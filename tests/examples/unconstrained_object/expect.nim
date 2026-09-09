{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Unconstrained_objectClosed* {.byref.} = object
  Unconstrained_object* {.byref.} = object
    name*: string
    free*: OrderedTable[string, JsonNode]
    closed*: Unconstrained_objectClosed
    patterned*: OrderedTable[string, JsonNode]
proc `=copy`(a: var Unconstrained_objectClosed;
             b: Unconstrained_objectClosed) {.error.}
proc toJsonHook*(source: Unconstrained_objectClosed): JsonNode
proc `=copy`(a: var Unconstrained_object;
             b: Unconstrained_object) {.error.}
proc toJsonHook*(source: Unconstrained_object): JsonNode
proc equals(_: typedesc[Unconstrained_objectClosed];
            a, b: Unconstrained_objectClosed): bool =
  true

proc `==`*(a, b: Unconstrained_objectClosed): bool =
  return equals(Unconstrained_objectClosed, a, b)

proc stringify(_: typedesc[Unconstrained_objectClosed];
               value: Unconstrained_objectClosed): string =
  stringifyObj("Unconstrained_objectClosed")

proc `$`*(value: Unconstrained_objectClosed): string =
  stringify(Unconstrained_objectClosed, value)

proc fromJsonHook*(target: var Unconstrained_objectClosed; source: JsonNode) =
  discard

proc toJsonHook*(source: Unconstrained_objectClosed): JsonNode =
  result = newJObject()
  
proc toStream*(source: Unconstrained_objectClosed; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  target.write('}')

proc fromStream*(typ: typedesc[Unconstrained_objectClosed];
                 source: var JsonParser): Unconstrained_objectClosed =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    else:
      skipValue(source)
  assert(card(seen) == 0)

proc equals(_: typedesc[Unconstrained_object]; a, b: Unconstrained_object): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.free), a.free, b.free) and
      equals(typeof(a.closed), a.closed, b.closed) and
      equals(typeof(a.patterned), a.patterned, b.patterned)

proc `==`*(a, b: Unconstrained_object): bool =
  return equals(Unconstrained_object, a, b)

proc stringify(_: typedesc[Unconstrained_object]; value: Unconstrained_object): string =
  stringifyObj("Unconstrained_object",
               ("name", stringify(typeof(value.name), value.name)),
               ("free", stringify(typeof(value.free), value.free)),
               ("closed", stringify(typeof(value.closed), value.closed)), (
      "patterned", stringify(typeof(value.patterned), value.patterned)))

proc `$`*(value: Unconstrained_object): string =
  stringify(Unconstrained_object, value)

proc fromJsonHook*(target: var Unconstrained_object; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Unconstrained_object")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  if hasKey(source, "free") and source{"free"}.kind != JNull:
    target.free = jsonTo(source{"free"}, typeof(target.free))
  assert(hasKey(source, "closed"),
         "closed" & " is missing while decoding " & "Unconstrained_object")
  target.closed = jsonTo(source{"closed"}, typeof(target.closed))
  if hasKey(source, "patterned") and source{"patterned"}.kind != JNull:
    target.patterned = jsonTo(source{"patterned"}, typeof(target.patterned))

proc toJsonHook*(source: Unconstrained_object): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  if len(source.free) > 0:
    result{"free"} = block:
      let cursor {.cursor.} = source.free
      var output = newJObject()
      for key in keys(cursor):
        output[key] = cursor[
            key]
      output
  result{"closed"} = toJsonHook(source.closed)
  if len(source.patterned) > 0:
    result{"patterned"} = block:
      let cursor {.cursor.} = source.patterned
      var output = newJObject()
      for key in keys(cursor):
        output[key] = cursor[
            key]
      output

proc toStream*(source: Unconstrained_object; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  if len(source.free) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("free"))
    write(target, ':')
    toStream(source.free, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("closed"))
  write(target, ':')
  toStream(source.closed, target)
  if len(source.patterned) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("patterned"))
    write(target, ':')
    toStream(source.patterned, target)
  target.write('}')

proc fromStream*(typ: typedesc[Unconstrained_object];
                 source: var JsonParser): Unconstrained_object =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    of "free":
      result.free = fromStream(typeof(result.free), source)
    of "closed":
      result.closed = fromStream(typeof(result.closed), source)
      seen.incl(1)
    of "patterned":
      result.patterned = fromStream(typeof(result.patterned), source)
    else:
      skipValue(source)
  assert(card(seen) == 2)

{.pop.}
