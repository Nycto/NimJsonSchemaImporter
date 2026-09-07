{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Optional_empty_objectCustom* {.byref.} = object
  Optional_empty_object* {.byref.} = object
    name*: string
    custom*: Option[Optional_empty_objectCustom]
proc `=copy`(a: var Optional_empty_objectCustom;
             b: Optional_empty_objectCustom) {.error.}
proc toJsonHook*(source: Optional_empty_objectCustom): JsonNode
proc `=copy`(a: var Optional_empty_object;
             b: Optional_empty_object) {.error.}
proc toJsonHook*(source: Optional_empty_object): JsonNode
proc equals(_: typedesc[Optional_empty_objectCustom];
            a, b: Optional_empty_objectCustom): bool =
  true

proc `==`*(a, b: Optional_empty_objectCustom): bool =
  return equals(Optional_empty_objectCustom, a, b)

proc stringify(_: typedesc[Optional_empty_objectCustom];
               value: Optional_empty_objectCustom): string =
  stringifyObj("Optional_empty_objectCustom")

proc `$`*(value: Optional_empty_objectCustom): string =
  stringify(Optional_empty_objectCustom, value)

proc fromJsonHook*(target: var Optional_empty_objectCustom; source: JsonNode) =
  discard

proc toJsonHook*(source: Optional_empty_objectCustom): JsonNode =
  result = newJObject()
  
proc toStream*(source: Optional_empty_objectCustom; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  target.write('}')

proc fromStream*(typ: typedesc[Optional_empty_objectCustom];
                 source: var JsonParser): Optional_empty_objectCustom =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    else:
      skipValue(source)
  assert(card(seen) == 0)

proc equals(_: typedesc[Optional_empty_object]; a, b: Optional_empty_object): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.custom), a.custom, b.custom)

proc `==`*(a, b: Optional_empty_object): bool =
  return equals(Optional_empty_object, a, b)

proc stringify(_: typedesc[Optional_empty_object]; value: Optional_empty_object): string =
  stringifyObj("Optional_empty_object",
               ("name", stringify(typeof(value.name), value.name)),
               ("custom", stringify(typeof(value.custom), value.custom)))

proc `$`*(value: Optional_empty_object): string =
  stringify(Optional_empty_object, value)

proc fromJsonHook*(target: var Optional_empty_object; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Optional_empty_object")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  if hasKey(source, "custom") and source{"custom"}.kind != JNull:
    target.custom = some(jsonTo(source{"custom"},
                                typeof(unsafeGet(target.custom))))

proc toJsonHook*(source: Optional_empty_object): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  if isSome(source.custom):
    result{"custom"} = toJsonHook(unsafeGet(source.custom))

proc toStream*(source: Optional_empty_object; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  if isSome(source.custom):
    hasEmitted.writeComma(target)
    write(target, escapeJson("custom"))
    write(target, ':')
    toStream(unsafeGet(source.custom), target)
  target.write('}')

proc fromStream*(typ: typedesc[Optional_empty_object];
                 source: var JsonParser): Optional_empty_object =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    of "custom":
      result.custom = some(fromStream(typeof(unsafeGet(result.custom)), source))
    else:
      skipValue(source)
  assert(card(seen) == 1)
{.pop.}
