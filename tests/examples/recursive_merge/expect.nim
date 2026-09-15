{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Recursive_mergeNode* {.byref.} = object
    next*: Option[ref Recursive_mergeNode]
  Recursive_merge* {.byref.} = object
    next*: Option[ref Recursive_mergeNode]
    name*: string
proc `=copy`(a: var Recursive_mergeNode;
             b: Recursive_mergeNode) {.error.}
proc equals(_: typedesc[Recursive_mergeNode]; a, b: Recursive_mergeNode): bool
proc `==`*(a, b: Recursive_mergeNode): bool
proc stringify(_: typedesc[Recursive_mergeNode]; value: Recursive_mergeNode): string
proc `$`*(value: Recursive_mergeNode): string
proc fromJsonHook*(target: var Recursive_mergeNode; source: JsonNode)
proc toJsonHook*(source: Recursive_mergeNode): JsonNode
proc toStream*(source: Recursive_mergeNode; target: Stream)
proc fromStream*(typ: typedesc[Recursive_mergeNode];
                 source: var JsonParser): Recursive_mergeNode
proc `=copy`(a: var Recursive_merge; b: Recursive_merge) {.
    error.}
proc equals(_: typedesc[Recursive_mergeNode]; a, b: Recursive_mergeNode): bool =
  equals(typeof(a.next), a.next, b.next)

proc `==`*(a, b: Recursive_mergeNode): bool =
  return equals(Recursive_mergeNode, a, b)

proc stringify(_: typedesc[Recursive_mergeNode]; value: Recursive_mergeNode): string =
  stringifyObj("Recursive_mergeNode",
               ("next", stringify(typeof(value.next), value.next)))

proc `$`*(value: Recursive_mergeNode): string =
  stringify(Recursive_mergeNode, value)

proc fromJsonHook*(target: var Recursive_mergeNode; source: JsonNode) =
  if hasKey(source, "next") and source{"next"}.kind != JNull:
    target.next = some(jsonTo(source{"next"}, typeof(unsafeGet(target.next))))

proc toJsonHook*(source: Recursive_mergeNode): JsonNode =
  result = newJObject()
  if isSome(source.next):
    result{"next"} = toJson(unsafeGet(source.next))

proc toStream*(source: Recursive_mergeNode; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.next):
    hasEmitted.writeComma(target)
    write(target, escapeJson("next"))
    write(target, ':')
    toStream(unsafeGet(source.next), target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_mergeNode];
                 source: var JsonParser): Recursive_mergeNode =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "next":
      result.next = some(fromStream(typeof(unsafeGet(result.next)), source))
    else:
      skipValue(source)
  assert(card(seen) == 0)

proc equals(_: typedesc[Recursive_merge]; a, b: Recursive_merge): bool =
  equals(typeof(a.next), a.next, b.next) and
      equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: Recursive_merge): bool =
  return equals(Recursive_merge, a, b)

proc stringify(_: typedesc[Recursive_merge]; value: Recursive_merge): string =
  stringifyObj("Recursive_merge",
               ("next", stringify(typeof(value.next), value.next)),
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: Recursive_merge): string =
  stringify(Recursive_merge, value)

proc fromJsonHook*(target: var Recursive_merge; source: JsonNode) =
  if hasKey(source, "next") and source{"next"}.kind != JNull:
    target.next = some(jsonTo(source{"next"}, typeof(unsafeGet(target.next))))
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Recursive_merge")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: Recursive_merge): JsonNode =
  result = newJObject()
  if isSome(source.next):
    result{"next"} = toJson(unsafeGet(source.next))
  result{"name"} = newJString(source.name)

proc toStream*(source: Recursive_merge; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.next):
    hasEmitted.writeComma(target)
    write(target, escapeJson("next"))
    write(target, ':')
    toStream(unsafeGet(source.next), target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_merge];
                 source: var JsonParser): Recursive_merge =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "next":
      result.next = some(fromStream(typeof(unsafeGet(result.next)), source))
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

{.pop.}
