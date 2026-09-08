{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Array_root2* {.byref.} = object
    name*: string
    count*: Option[BiggestInt]
  Array_root* = seq[Array_root2]
proc `=copy`(a: var Array_root2; b: Array_root2) {.error.}
proc toJsonHook*(source: Array_root2): JsonNode
proc equals(_: typedesc[Array_root2]; a, b: Array_root2): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.count), a.count, b.count)

proc `==`*(a, b: Array_root2): bool =
  return equals(Array_root2, a, b)

proc stringify(_: typedesc[Array_root2]; value: Array_root2): string =
  stringifyObj("Array_root2",
               ("name", stringify(typeof(value.name), value.name)),
               ("count", stringify(typeof(value.count), value.count)))

proc `$`*(value: Array_root2): string =
  stringify(Array_root2, value)

proc fromJsonHook*(target: var Array_root2; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Array_root2")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  if hasKey(source, "count") and source{"count"}.kind != JNull:
    target.count = some(jsonTo(source{"count"}, typeof(unsafeGet(target.count))))

proc toJsonHook*(source: Array_root2): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  if isSome(source.count):
    result{"count"} = newJInt(unsafeGet(source.count))

proc toStream*(source: Array_root2; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  if isSome(source.count):
    hasEmitted.writeComma(target)
    write(target, escapeJson("count"))
    write(target, ':')
    toStream(unsafeGet(source.count), target)
  target.write('}')

proc fromStream*(typ: typedesc[Array_root2]; source: var JsonParser): Array_root2 =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    of "count":
      result.count = some(fromStream(typeof(unsafeGet(result.count)), source))
    else:
      skipValue(source)
  assert(card(seen) == 1)

{.pop.}
