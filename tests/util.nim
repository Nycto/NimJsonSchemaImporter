import std/[json, strformat, strutils, unittest], json_schema_import

proc testResolver*(uri: string): JsonNode =
  if uri == "https://example.com/user-profile.schema.json":
    return %*{
      "type": "object",
      "properties": {"username": {"type": "string"}, "email": {"type": "string"}},
    }
  else:
    raiseAssert(fmt"Unsupported test uri: {uri}")

proc conf*(rootTypeName: string): auto =
  return JsonSchemaConfig(
    rootTypeName: rootTypeName,
    typePrefix: rootTypeName,
    urlResolver: testResolver,
    noCopies: true,
  )

proc isSingleton*(T: typedesc): bool =
  ## Whether a type has exactly one possible value, as a schema pinned to a `const` does.
  ## There is no second value for such a type to be different from.
  when T is object:
    var value: T
    for _ in value.fields:
      return false
    return true
  else:
    return false

proc compareLines*(expect, found, path: string) =
  let expectLines = expect.splitLines
  let foundLines = found.splitLines
  for i in 0 ..< max(expectLines.len, foundLines.len):
    if expectLines[i] != foundLines[i]:
      checkpoint(fmt"Compare failed at {path}:{i + 1}")
      let expected = expectLines[i]
      let received = foundLines[i]
      check(expected == received)
