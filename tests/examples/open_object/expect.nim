{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Open_objectPartlyOpen* {.byref.} = object
    known*: Option[string]
  Open_objectClosed* {.byref.} = object
    alsoKnown*: Option[string]
  Open_object* {.byref.} = object
    partlyOpen*: Open_objectPartlyOpen
    closed*: Open_objectClosed
    anyValue*: OrderedTable[string, BiggestInt]
proc `=copy`(a: var Open_objectPartlyOpen;
             b: Open_objectPartlyOpen) {.error.}
proc toJsonHook*(source: Open_objectPartlyOpen): JsonNode
proc `=copy`(a: var Open_objectClosed;
             b: Open_objectClosed) {.error.}
proc toJsonHook*(source: Open_objectClosed): JsonNode
proc `=copy`(a: var Open_object; b: Open_object) {.error.}
proc toJsonHook*(source: Open_object): JsonNode
proc equals(_: typedesc[Open_objectPartlyOpen]; a, b: Open_objectPartlyOpen): bool =
  equals(typeof(a.known), a.known, b.known)

proc `==`*(a, b: Open_objectPartlyOpen): bool =
  return equals(Open_objectPartlyOpen, a, b)

proc stringify(_: typedesc[Open_objectPartlyOpen]; value: Open_objectPartlyOpen): string =
  stringifyObj("Open_objectPartlyOpen",
               ("known", stringify(typeof(value.known), value.known)))

proc `$`*(value: Open_objectPartlyOpen): string =
  stringify(Open_objectPartlyOpen, value)

proc fromJsonHook*(target: var Open_objectPartlyOpen; source: JsonNode) =
  if hasKey(source, "known") and source{"known"}.kind != JNull:
    target.known = some(jsonTo(source{"known"}, typeof(unsafeGet(target.known))))

proc toJsonHook*(source: Open_objectPartlyOpen): JsonNode =
  result = newJObject()
  if isSome(source.known):
    result{"known"} = newJString(unsafeGet(source.known))

proc toStream*(source: Open_objectPartlyOpen; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.known):
    hasEmitted.writeComma(target)
    write(target, escapeJson("known"))
    write(target, ':')
    toStream(unsafeGet(source.known), target)
  target.write('}')

proc fromStream*(typ: typedesc[Open_objectPartlyOpen];
                 source: var JsonParser): Open_objectPartlyOpen =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "known":
      result.known = some(fromStream(typeof(unsafeGet(result.known)), source))
    else:
      skipValue(source)
  assert(card(seen) == 0)

proc equals(_: typedesc[Open_objectClosed]; a, b: Open_objectClosed): bool =
  equals(typeof(a.alsoKnown), a.alsoKnown, b.alsoKnown)

proc `==`*(a, b: Open_objectClosed): bool =
  return equals(Open_objectClosed, a, b)

proc stringify(_: typedesc[Open_objectClosed]; value: Open_objectClosed): string =
  stringifyObj("Open_objectClosed", ("alsoKnown", stringify(
      typeof(value.alsoKnown), value.alsoKnown)))

proc `$`*(value: Open_objectClosed): string =
  stringify(Open_objectClosed, value)

proc fromJsonHook*(target: var Open_objectClosed; source: JsonNode) =
  if hasKey(source, "alsoKnown") and source{"alsoKnown"}.kind != JNull:
    target.alsoKnown = some(jsonTo(source{"alsoKnown"},
                                   typeof(unsafeGet(target.alsoKnown))))

proc toJsonHook*(source: Open_objectClosed): JsonNode =
  result = newJObject()
  if isSome(source.alsoKnown):
    result{"alsoKnown"} = newJString(unsafeGet(source.alsoKnown))

proc toStream*(source: Open_objectClosed; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.alsoKnown):
    hasEmitted.writeComma(target)
    write(target, escapeJson("alsoKnown"))
    write(target, ':')
    toStream(unsafeGet(source.alsoKnown), target)
  target.write('}')

proc fromStream*(typ: typedesc[Open_objectClosed];
                 source: var JsonParser): Open_objectClosed =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "alsoKnown":
      result.alsoKnown = some(fromStream(typeof(unsafeGet(result.alsoKnown)),
          source))
    else:
      skipValue(source)
  assert(card(seen) == 0)

proc equals(_: typedesc[Open_object]; a, b: Open_object): bool =
  equals(typeof(a.partlyOpen), a.partlyOpen, b.partlyOpen) and
      equals(typeof(a.closed), a.closed, b.closed) and
      equals(typeof(a.anyValue), a.anyValue, b.anyValue)

proc `==`*(a, b: Open_object): bool =
  return equals(Open_object, a, b)

proc stringify(_: typedesc[Open_object]; value: Open_object): string =
  stringifyObj("Open_object", ("partlyOpen", stringify(typeof(value.partlyOpen),
      value.partlyOpen)),
               ("closed", stringify(typeof(value.closed), value.closed)),
               ("anyValue", stringify(typeof(value.anyValue), value.anyValue)))

proc `$`*(value: Open_object): string =
  stringify(Open_object, value)

proc fromJsonHook*(target: var Open_object; source: JsonNode) =
  assert(hasKey(source, "partlyOpen"),
         "partlyOpen" & " is missing while decoding " & "Open_object")
  target.partlyOpen = jsonTo(source{"partlyOpen"}, typeof(target.partlyOpen))
  assert(hasKey(source, "closed"),
         "closed" & " is missing while decoding " & "Open_object")
  target.closed = jsonTo(source{"closed"}, typeof(target.closed))
  if hasKey(source, "anyValue") and source{"anyValue"}.kind != JNull:
    target.anyValue = jsonTo(source{"anyValue"}, typeof(target.anyValue))

proc toJsonHook*(source: Open_object): JsonNode =
  result = newJObject()
  result{"partlyOpen"} = toJsonHook(source.partlyOpen)
  result{"closed"} = toJsonHook(source.closed)
  if len(source.anyValue) > 0:
    result{"anyValue"} = block:
      let cursor {.cursor.} = source.anyValue
      var output = newJObject()
      for key in keys(cursor):
        output[key] = newJInt(
            cursor[key])
      output

proc toStream*(source: Open_object; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("partlyOpen"))
  write(target, ':')
  toStream(source.partlyOpen, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("closed"))
  write(target, ':')
  toStream(source.closed, target)
  if len(source.anyValue) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("anyValue"))
    write(target, ':')
    toStream(source.anyValue, target)
  target.write('}')

proc fromStream*(typ: typedesc[Open_object]; source: var JsonParser): Open_object =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "partlyOpen":
      result.partlyOpen = fromStream(typeof(result.partlyOpen), source)
      seen.incl(0)
    of "closed":
      result.closed = fromStream(typeof(result.closed), source)
      seen.incl(1)
    of "anyValue":
      result.anyValue = fromStream(typeof(result.anyValue), source)
    else:
      skipValue(source)
  assert(card(seen) == 2)

{.pop.}
