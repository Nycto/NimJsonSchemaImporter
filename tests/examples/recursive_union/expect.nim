{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options, typetraits]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/validate as jsonSchemaValidate
import json_schema_import/private/[equality, bin, sax, empty]
from json_schema_import/private/util import baseOf

type
  Recursive_unionUnion* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: string
    of 1:
      key1*: ref Recursive_union
  Recursive_union* {.byref.} = object
    name*: string
    child*: Option[Recursive_unionUnion]
    index*: OrderedTable[string, ref Recursive_union]
proc `=copy`(a: var Recursive_union; b: Recursive_union) {.
    error.}
proc equals(_: typedesc[Recursive_union]; a, b: Recursive_union): bool
proc `==`*(a, b: Recursive_union): bool
proc stringify(_: typedesc[Recursive_union]; value: Recursive_union): string
proc `$`*(value: Recursive_union): string
proc fromJsonHook*(target: var Recursive_union; source: JsonNode)
proc toJsonHook*(source: Recursive_union): JsonNode
proc toStream*(source: Recursive_union; target: Stream)
proc fromStream*(typ: typedesc[Recursive_union];
                 source: var JsonParser): Recursive_union
converter forRecursive_unionUnion*(value: string): Recursive_unionUnion =
  return Recursive_unionUnion(kind: 0, key0: value)

proc forRecursive_unionUnion*(value: ref Recursive_union): Recursive_unionUnion =
  return Recursive_unionUnion(kind: 1, key1: value)

proc equals(_: typedesc[Recursive_unionUnion]; a, b: Recursive_unionUnion): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Recursive_unionUnion): bool =
  return equals(Recursive_unionUnion, a, b)

proc stringify(_: typedesc[Recursive_unionUnion]; value: Recursive_unionUnion): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Recursive_unionUnion): string =
  stringify(Recursive_unionUnion, value)

proc fromJsonHook*(target: var Recursive_unionUnion; source: JsonNode) =
  if source.kind == JString:
    target = Recursive_unionUnion(kind: 0,
                                  key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject and hasKey(source, "name"):
    target = Recursive_unionUnion(kind: 1,
                                  key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to Recursive_unionUnion")
  when not defined(jsonSchemaNoValidate):
    validate(Recursive_unionUnion, target)

proc toJsonHook*(source: Recursive_unionUnion): JsonNode =
  case source.kind
  of 0:
    newJString(source.key0)
  of 1:
    toJson(source.key1)
  
proc isStr*(value: Recursive_unionUnion): bool =
  value.kind == 0

proc asStr*(value: Recursive_unionUnion): typeof(
    value.key0) =
  assert(value.kind == 0)
  return value.key0

proc isRoot*(value: Recursive_unionUnion): bool =
  value.kind == 1

proc asRoot*(value: Recursive_unionUnion): typeof(
    value.key1) =
  assert(value.kind == 1)
  return value.key1

proc toBinary*(target: var string; source: Recursive_unionUnion) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Recursive_unionUnion]; source: string; idx: var int): Recursive_unionUnion =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Recursive_unionUnion(kind: 0, key0: fromBinary(typeof(result.key0),
        source, idx))
  of 1:
    return Recursive_unionUnion(kind: 1, key1: fromBinary(typeof(result.key1),
        source, idx))
  
proc toStream*(source: Recursive_unionUnion; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Recursive_unionUnion];
                 source: var JsonParser): Recursive_unionUnion =
  jsonTo(fromStream(JsonNode, source), Recursive_unionUnion)

proc equals(_: typedesc[Recursive_union]; a, b: Recursive_union): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.child), a.child, b.child) and
      equals(typeof(a.index), a.index, b.index)

proc `==`*(a, b: Recursive_union): bool =
  return equals(Recursive_union, a, b)

proc stringify(_: typedesc[Recursive_union]; value: Recursive_union): string =
  stringifyObj("Recursive_union",
               ("name", stringify(typeof(value.name), value.name)),
               ("child", stringify(typeof(value.child), value.child)),
               ("index", stringify(typeof(value.index), value.index)))

proc `$`*(value: Recursive_union): string =
  stringify(Recursive_union, value)

proc fromJsonHook*(target: var Recursive_union; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Recursive_union")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  if hasKey(source, "child") and source{"child"}.kind != JNull:
    target.child = some(jsonTo(source{"child"}, typeof(unsafeGet(target.child))))
  if hasKey(source, "index") and source{"index"}.kind != JNull:
    target.index = jsonTo(source{"index"}, typeof(target.index))
  when not defined(jsonSchemaNoValidate):
    validate(Recursive_union, target)

proc toJsonHook*(source: Recursive_union): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  if isSome(source.child):
    result{"child"} = toJsonHook(unsafeGet(source.child))
  if len(source.index) > 0:
    result{"index"} = block:
      let cursor {.cursor.} = source.index
      var output = newJObject()
      for key in keys(cursor):
        output[key] = toJson(
            cursor[key])
      output

proc toStream*(source: Recursive_union; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  if isSome(source.child):
    hasEmitted.writeComma(target)
    write(target, escapeJson("child"))
    write(target, ':')
    toStream(unsafeGet(source.child), target)
  if len(source.index) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("index"))
    write(target, ':')
    toStream(source.index, target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_union];
                 source: var JsonParser): Recursive_union =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    of "child":
      result.child = some(fromStream(typeof(unsafeGet(result.child)), source))
    of "index":
      result.index = fromStream(typeof(result.index), source)
    else:
      skipValue(source)
  assert(card(seen) == 1)
  when not defined(jsonSchemaNoValidate):
    validate(Recursive_union, result)

{.pop.}
