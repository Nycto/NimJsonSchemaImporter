import std/[hashes, strutils, compilesettings, staticos, macros], ../config, util

const
  json_schema_version* = 1
    ## Version of the generated code produced by this library.
    ## Bump this whenever a change to the generator alters the code it emits, otherwise
    ## builds with a warm cache will keep using output from the previous version.

  jsonSchemaCacheDir {.strdefine.} = ""
    ## Overrides where generated code is cached, set with `-d:jsonSchemaCacheDir=<path>`

  jsonSchemaNoCache {.booldefine.} = false
    ## Disables caching entirely, set with `-d:jsonSchemaNoCache`

proc cacheDir(): string {.compileTime.} =
  ## The directory in which generated code is cached
  if jsonSchemaCacheDir != "":
    jsonSchemaCacheDir
  else:
    querySetting(SingleValueSetting.nimcacheDir) & "/json_schema_import"

proc cacheKey*(schema: string, conf: JsonSchemaConfig): string {.compileTime.} =
  ## Builds a key covering everything the generated code depends on
  let accum = schema.hash !& conf.cacheKeyHash !& NimVersion.hash !& json_schema_version.hash
  return cast[uint](!$accum).toHex

proc inlineSchemaName*(conf: JsonSchemaConfig): string {.compileTime.} =
  ## A name for a schema declared inline, which has no file to be named after
  if conf.rootTypeName == "": "inline" else: conf.rootTypeName

proc fileStem(path: string): string =
  ## Reduces a schema path to the readable part of its cache file name
  ##
  ## The last two components are kept because schemas are routinely named
  ## `<something>/schema.json`, and the final component alone would leave every cached
  ## file in a project looking identical.
  var pos = path.rfind('/')
  if pos != -1:
    pos = path.rfind('/', last = pos - 1)

  for c in (if pos == -1: path else: path[pos + 1 .. ^1]):
    result.add(if c in IdentChars: c else: '_')

  result = result.cleanupIdent

proc cachePath*(name, key: string): string {.compileTime.} =
  ## The file in which the code generated for `key` is cached. `name` only exists to
  ## keep the cache browsable; `key` is what makes the path correct.
  cacheDir() & "/" & name.fileStem & "_" & key & ".nim"

proc writeCache(path, contents: string) {.compileTime.} =
  ## Records generated code for a later compile to pick up
  try:
    let dir = cacheDir()
    if not staticDirExists(dir):
      discard staticExec("mkdir -p \"" & dir & "\"")
      if not staticDirExists(dir):
        # cmd.exe has no -p, but its mkdir creates intermediate directories regardless
        discard staticExec("mkdir \"" & dir & "\"")

    writeFile(path, contents)
  except CatchableError:
    # Best effort by design: an unwritable cache directory should cost a build some time,
    # not break it. Callers have to confirm the write landed rather than assume it did,
    # which is also what makes this safe under `nimsuggest` and `nim check` -- there
    # `writeFile` is silently a no-op unless `--experimental:vmopsDanger` is set.
    discard

template emitSchema*(
    schemaText: string, conf: JsonSchemaConfig, name: string, generate: untyped
): NimNode =
  ## Produces the code for a schema, reading it from the cache when it is already there
  block:
    var output: NimNode
    if jsonSchemaNoCache or not conf.cacheable:
      output = generate
    else:
      let path = cachePath(name, cacheKey(schemaText, conf))

      var generated: NimNode = nil
      if not staticFileExists(path):
        generated = generate
        writeCache(path, generated.formatCodeDump)
        hint("Writing generated code to cache: " & path)
      else:
        hint("Reading generated code from cache: " & path)

      output =
        if staticFileExists(path):
          nnkIncludeStmt.newTree(newLit(path))
        else:
          generated
    output
