# Package

version = "0.5.0"
author = "Nycto"
description = "Converts JSON schema definitions to nim types"
license = "MIT"
srcDir = "src"

# Dependencies

requires "nim >= 2.0.0"
requires "regex >= 0.26.1"

# Tasks

import std/[os, strutils]

task readme, "Compiles code in the readme":
  let readme = readFile("README.md")

  let tmpDir = nimcacheDir() & "/readme_json_schema_import"
  mkDir(tmpDir)

  var inCode = false
  var accum = ""
  var path = ""
  for line in readme.split("\n"):
    if line.startsWith "```":
      if not inCode:
        let filename = line.split(' ')[^1]
        assert(filename != "")
        path = tmpDir & "/" & filename
      else:
        assert(path != "")
        echo "Creating file ", path
        writeFile(path, accum)

        if path.endsWith(".nim"):
          exec("nim c -r -p:" & getCurrentDir() & "/src " & path)

        path = ""
        accum = ""

      inCode = not inCode
    elif inCode:
      accum &= line & "\n"

task cachetest, "Verifies generated code is cached, reused and invalidated":
  ## Exercises the cache across separate compiler invocations, which is the only place
  ## its actual behaviour shows up -- within a single compile there is nothing to reuse.
  let tmpDir = nimcacheDir() & "/cachetest_json_schema_import"
  let cacheDir = tmpDir & "/nimcache/json_schema_import"

  rmDir(tmpDir)
  mkDir(tmpDir)

  writeFile(
    tmpDir & "/schema.json",
    """{"$id": "/schemas/cached", "properties": {"a": {"type": "string"}}}""",
  )
  writeFile(
    tmpDir & "/main.nim",
    "import json_schema_import\n" & "importJsonSchema \"schema.json\"\n" &
      "doAssert(declared(Cached))\n",
  )

  proc build() =
    exec(
      "nim c -r --hints:off -p:" & getCurrentDir() & "/src --nimcache:" & tmpDir &
        "/nimcache -o:" & tmpDir & "/main " & tmpDir & "/main.nim"
    )

  proc cached(): seq[string] =
    for path in listFiles(cacheDir):
      result.add(path)

  build()
  let afterFirst = cached()
  assert(afterFirst.len == 1, "Expected a cache file, found: " & $afterFirst)

  build()
  assert(cached() == afterFirst, "A second build should reuse the cached file")

  writeFile(
    tmpDir & "/schema.json",
    """{"$id": "/schemas/cached", "properties": {"b": {"type": "string"}}}""",
  )
  build()
  assert(
    cached().len == 2, "An edited schema should be cached under a new key, not reused"
  )

  echo "Cache written, reused and invalidated as expected"
