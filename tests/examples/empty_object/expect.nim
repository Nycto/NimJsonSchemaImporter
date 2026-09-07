{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Empty_objectCustom* {.byref.} = object
  Empty_object* {.byref.} = object
    name*: string
    custom*: Empty_objectCustom
proc `=copy`(a: var Empty_objectCustom;
             b: Empty_objectCustom) {.error.}
proc toJsonHook*(source: Empty_objectCustom): JsonNode
proc `=copy`(a: var Empty_object; b: Empty_object) {.error.}
proc toJsonHook*(source: Empty_object): JsonNode
proc equals(_: typedesc[Empty_objectCustom]; a, b: Empty_objectCustom): bool =
  true

proc `==`*(a, b: Empty_objectCustom): bool =
  return equals(Empty_objectCustom, a, b)

proc stringify(_: typedesc[Empty_objectCustom]; value: Empty_objectCustom): string =
  stringifyObj("Empty_objectCustom")

proc `$`*(value: Empty_objectCustom): string =
  stringify(Empty_objectCustom, value)

proc fromJsonHook*(target: var Empty_objectCustom; source: JsonNode) =
  discard

proc toJsonHook*(source: Empty_objectCustom): JsonNode =
  result = newJObject()
  
proc toStream*(source: Empty_objectCustom; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  target.write('}')

proc fromStream*(typ: typedesc[Empty_objectCustom];
                 source: var JsonParser): Empty_objectCustom =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    else:
      skipValue(source)
  assert(card(seen) == 0)

proc equals(_: typedesc[Empty_object]; a, b: Empty_object): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.custom), a.custom, b.custom)

proc `==`*(a, b: Empty_object): bool =
  return equals(Empty_object, a, b)

proc stringify(_: typedesc[Empty_object]; value: Empty_object): string =
  stringifyObj("Empty_object",
               ("name", stringify(typeof(value.name), value.name)),
               ("custom", stringify(typeof(value.custom), value.custom)))

proc `$`*(value: Empty_object): string =
  stringify(Empty_object, value)

proc fromJsonHook*(target: var Empty_object; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Empty_object")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  assert(hasKey(source, "custom"),
         "custom" & " is missing while decoding " & "Empty_object")
  target.custom = jsonTo(source{"custom"}, typeof(target.custom))

proc toJsonHook*(source: Empty_object): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  result{"custom"} = toJsonHook(source.custom)

proc toStream*(source: Empty_object; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("custom"))
  write(target, ':')
  toStream(source.custom, target)
  target.write('}')

proc fromStream*(typ: typedesc[Empty_object]; source: var JsonParser): Empty_object =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    of "custom":
      result.custom = fromStream(typeof(result.custom), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)
{.pop.}
