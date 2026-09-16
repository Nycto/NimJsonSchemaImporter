{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax, empty]

type
  Linked_list* {.byref.} = object
    value*: string
    next*: Option[ref Linked_list]
proc `=copy`(a: var Linked_list; b: Linked_list) {.error.}
proc equals(_: typedesc[Linked_list]; a, b: Linked_list): bool
proc `==`*(a, b: Linked_list): bool
proc stringify(_: typedesc[Linked_list]; value: Linked_list): string
proc `$`*(value: Linked_list): string
proc fromJsonHook*(target: var Linked_list; source: JsonNode)
proc toJsonHook*(source: Linked_list): JsonNode
proc toStream*(source: Linked_list; target: Stream)
proc fromStream*(typ: typedesc[Linked_list]; source: var JsonParser): Linked_list
proc equals(_: typedesc[Linked_list]; a, b: Linked_list): bool =
  equals(typeof(a.value), a.value, b.value) and
      equals(typeof(a.next), a.next, b.next)

proc `==`*(a, b: Linked_list): bool =
  return equals(Linked_list, a, b)

proc stringify(_: typedesc[Linked_list]; value: Linked_list): string =
  stringifyObj("Linked_list",
               ("value", stringify(typeof(value.value), value.value)),
               ("next", stringify(typeof(value.next), value.next)))

proc `$`*(value: Linked_list): string =
  stringify(Linked_list, value)

proc fromJsonHook*(target: var Linked_list; source: JsonNode) =
  assert(hasKey(source, "value"),
         "value" & " is missing while decoding " & "Linked_list")
  target.value = jsonTo(source{"value"}, typeof(target.value))
  if hasKey(source, "next") and source{"next"}.kind != JNull:
    target.next = some(jsonTo(source{"next"}, typeof(unsafeGet(target.next))))

proc toJsonHook*(source: Linked_list): JsonNode =
  result = newJObject()
  result{"value"} = newJString(source.value)
  if isSome(source.next):
    result{"next"} = toJson(unsafeGet(source.next))

proc toStream*(source: Linked_list; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("value"))
  write(target, ':')
  toStream(source.value, target)
  if isSome(source.next):
    hasEmitted.writeComma(target)
    write(target, escapeJson("next"))
    write(target, ':')
    toStream(unsafeGet(source.next), target)
  target.write('}')

proc fromStream*(typ: typedesc[Linked_list]; source: var JsonParser): Linked_list =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "value":
      result.value = fromStream(typeof(result.value), source)
      seen.incl(0)
    of "next":
      result.next = some(fromStream(typeof(unsafeGet(result.next)), source))
    else:
      skipValue(source)
  assert(card(seen) == 1)

{.pop.}
