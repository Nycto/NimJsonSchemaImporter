import
  std/[json, os, strutils],
  json_schema_import,
  json_schema_import/private/[describe, describeparse, parse, gen]

const
  remoteHost = "http://localhost:1234/"
  draft7Meta = "http://json-schema.org/draft-07/schema"

proc suiteResolver(url: string): JsonNode =
  ## Serves the suite's `remotes` directory, which its tests expect at `remoteHost`,
  ## plus the metaschemas a real validator would already have
  if url.split('#')[0] == draft7Meta:
    return
      staticRead(currentSourcePath.parentDir & "/metaschemas/draft-07.json").parseJson
  if not url.startsWith(remoteHost):
    return nil
  let path =
    currentSourcePath.parentDir & "/../JSON-Schema-Test-Suite/remotes/" &
    url[remoteHost.len .. ^1].split('#')[0]
  if not fileExists(path):
    return nil
  return staticRead(path).parseJson

proc conf*(typ: string): JsonSchemaConfig =
  JsonSchemaConfig(rootTypeName: typ, typePrefix: typ, urlResolver: suiteResolver)

type
  Support* = enum
    ## What a case's schema can be turned into
    Never ## No value satisfies it, so there is no type to generate
    Unsupported ## The generator gives up on it
    Supported

  Probe* = object
    kind*: Support
    reason*: string

proc probe*(schemaPath, typ: string): Probe {.compileTime.} =
  ## Runs the generator over a schema without emitting anything, so that a case it
  ## cannot handle fails on its own instead of taking its whole file down with it.
  ## `importJsonSchema` fails by raising inside the VM, which is a compile error there
  ## is no other way to catch: `compiles` only judges expressions, and a schema import
  ## is a declaration.
  let schema = staticRead(schemaPath).parseJson
  try:
    if describeSchema(schema, suiteResolver).isNever:
      return Probe(kind: Never)
    discard schema.parseSchema(suiteResolver).genDeclarations(conf(typ))
    Probe(kind: Supported)
  except CatchableError, Defect:
    Probe(kind: Unsupported, reason: getCurrentExceptionMsg())

proc rejected*(label: string, valid: bool) =
  ## Reports a test against a schema that rejects every value
  echo(if valid: "FAIL\t" else: "PASS\t", label)

proc unsupported*(label: string) =
  ## Reports a test whose schema the generator would not import. The reason is echoed
  ## once per case at compile time, so it shows up in the build log.
  echo "FAIL\t", label

proc check*[T](label, instance: string, valid: bool) =
  var raised = false
  try:
    discard jsonTo(parseJson(instance), T)
  except CatchableError, Defect:
    raised = true
  echo(if raised != valid: "PASS\t" else: "FAIL\t", label)
