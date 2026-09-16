import std/[json, os, strutils], json_schema_import

const remoteHost = "http://localhost:1234/"

proc suiteResolver(url: string): JsonNode =
  ## Serves the suite's `remotes` directory, which its tests expect at `remoteHost`
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

proc check*[T](label, instance: string, valid: bool) =
  var raised = false
  try:
    discard jsonTo(parseJson(instance), T)
  except CatchableError, Defect:
    raised = true
  echo(if raised != valid: "PASS\t" else: "FAIL\t", label)
