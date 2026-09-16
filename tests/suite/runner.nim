##
## Runs the JSON-Schema-Test-Suite against the library. Each suite file becomes a Nim
## module that imports every schema in it and checks that valid instances decode and
## invalid ones raise. Every case is gated on a probe of the generator, so a schema the
## library cannot import fails only its own tests.
##

import
  std/[json, os, osproc, strutils, strformat, sequtils, appdirs, paths],
  ./[loader, blocklist, report]

const
  suiteRoot = currentSourcePath.parentDir
  srcDir = suiteRoot & "/../../src"

let buildDir = getCacheDir("json_schema_import_suite".Path).string

proc dir(file: SuiteFile): string =
  buildDir & "/" & file.name

proc moduleSource(file: SuiteFile): string =
  result &= "import json_schema_import, std/json\n"
  result &= &"import {escape(suiteRoot & \"/remotes\")}\n"

  for i, suiteCase in file.cases:
    let typ = &"Case{i}"
    let schemaPath = escape(file.dir & &"/case{i}.json")
    let notice =
      escape("UNSUPPORTED " & file.name & " :: " & suiteCase.description & ": ")
    result.add &"const probe{i} = probe({schemaPath}, \"{typ}\")\n"

    result.add &"when probe{i}.kind == Never:\n"
    for test in suiteCase.tests:
      result.add &"  rejected({escape(label(file.name, suiteCase, test))}, {test.valid})\n"

    result.add &"elif probe{i}.kind == Unsupported:\n"
    result.add "  static:\n"
    result.add &"    echo {notice}, probe{i}.reason\n"
    for test in suiteCase.tests:
      result.add &"  unsupported({escape(label(file.name, suiteCase, test))})\n"

    result.add "else:\n"
    result.add &"  importJsonSchema(\"case{i}.json\", conf(\"{typ}\"))\n"
    for test in suiteCase.tests:
      result.add &"  check[{typ}]({escape(label(file.name, suiteCase, test))}, {escape($test.data)}, {test.valid})\n"

proc write(file: SuiteFile) =
  removeDir(file.dir)
  createDir(file.dir)
  for i, suiteCase in file.cases:
    writeFile(file.dir & &"/case{i}.json", $suiteCase.schema)
  writeFile(file.dir & "/main.nim", moduleSource(file))

proc command(file: SuiteFile): string =
  let d = file.dir.quoteShell
  &"nim c --hints:off --warnings:off -p:{srcDir.quoteShell} --nimcache:{d}/nimcache " &
    &"-o:{d}/main {d}/main.nim > {d}/build.log 2>&1 && {d}/main > {d}/run.log 2>&1"

proc run(files: seq[SuiteFile], stream: bool): Results =
  ## Compiles and runs a module per file. A file that will not compile fails all its
  ## tests.
  var commands: seq[string]
  for file in files:
    file.write()
    commands.add(file.command)

  proc echoLog(idx: int, p: Process) =
    let dir = files[idx].dir
    for line in lines(dir & "/build.log"):
      echo "[", files[idx].name, "] ", line
    if dir.compiled:
      for line in lines(dir & "/run.log"):
        echo line

  discard execProcesses(
    commands,
    options = {poEvalCommand},
    n = countProcessors(),
    afterRunEvent = if stream: echoLog else: nil,
  )
  for file in files:
    if file.dir.compiled:
      file.dir.collect(result)
    else:
      echo "COMPILE FAILED: ", file.dir, "/build.log"

proc runTests(update, stream: bool, filters: seq[string]) =
  let suite = loadSuite()
  let selected = suite.filterIt(filters.len == 0 or it.name in filters)

  let results = run(selected, stream)

  if update:
    writeBlocklist(suite, results)
    echo "Rewrote ", blocklistPath
    return

  let errors = report(suite, selected, results, loadBlocklist())
  if errors > 0:
    echo &"{errors} problem(s)"
    quit(1)

proc main() =
  var update = false
  var stream = false
  var filters: seq[string]
  for arg in commandLineParams():
    if arg == "--update":
      update = true
    elif arg == "--stream":
      stream = true
    else:
      filters.add(arg)

  if update and filters.len > 0:
    quit("--update rewrites the whole blocklist, so it runs the whole suite", 1)

  runTests(update, stream, filters)

main()
