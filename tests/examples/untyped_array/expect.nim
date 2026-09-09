{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Untyped_array* {.byref.} = object
    name*: string
    values*: seq[JsonNode]
proc `=copy`(a: var Untyped_array; b: Untyped_array) {.error.}
proc toJsonHook*(source: Untyped_array): JsonNode
proc equals(_: typedesc[Untyped_array]; a, b: Untyped_array): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.values), a.values, b.values)

proc `==`*(a, b: Untyped_array): bool =
  return equals(Untyped_array, a, b)

proc stringify(_: typedesc[Untyped_array]; value: Untyped_array): string =
  stringifyObj("Untyped_array",
               ("name", stringify(typeof(value.name), value.name)),
               ("values", stringify(typeof(value.values), value.values)))

proc `$`*(value: Untyped_array): string =
  stringify(Untyped_array, value)

proc fromJsonHook*(target: var Untyped_array; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Untyped_array")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  if hasKey(source, "values") and source{"values"}.kind != JNull:
    target.values = jsonTo(source{"values"}, typeof(target.values))

proc toJsonHook*(source: Untyped_array): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  if len(source.values) > 0:
    result{"values"} = block:
      let cursor {.cursor.} = source.values
      var output = newJArray()
      for entry in cursor:
        output.add(entry)
      output

proc toStream*(source: Untyped_array; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  if len(source.values) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("values"))
    write(target, ':')
    toStream(source.values, target)
  target.write('}')

proc fromStream*(typ: typedesc[Untyped_array]; source: var JsonParser): Untyped_array =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    of "values":
      result.values = fromStream(typeof(result.values), source)
    else:
      skipValue(source)
  assert(card(seen) == 1)

{.pop.}
