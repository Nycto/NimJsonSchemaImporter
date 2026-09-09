{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Const_typedShape* {.byref.} = object
    radius*: BiggestInt
  Const_typedShape2* {.byref.} = object
    side*: BiggestInt
  Const_typedUnion* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: Const_typedShape
    of 1:
      key1*: Const_typedShape2
  Const_typed* {.byref.} = object
    shape*: Const_typedUnion
proc `=copy`(a: var Const_typedShape; b: Const_typedShape) {.
    error.}
proc toJsonHook*(source: Const_typedShape): JsonNode
proc `=copy`(a: var Const_typedShape2;
             b: Const_typedShape2) {.error.}
proc toJsonHook*(source: Const_typedShape2): JsonNode
proc `=copy`(a: var Const_typed; b: Const_typed) {.error.}
proc toJsonHook*(source: Const_typed): JsonNode
proc equals(_: typedesc[Const_typedShape]; a, b: Const_typedShape): bool =
  equals(typeof(a.radius), a.radius, b.radius)

proc `==`*(a, b: Const_typedShape): bool =
  return equals(Const_typedShape, a, b)

proc stringify(_: typedesc[Const_typedShape]; value: Const_typedShape): string =
  stringifyObj("Const_typedShape", ("kind", "\"circle\""),
               ("radius", stringify(typeof(value.radius), value.radius)))

proc `$`*(value: Const_typedShape): string =
  stringify(Const_typedShape, value)

proc fromJsonHook*(target: var Const_typedShape; source: JsonNode) =
  assert(hasKey(source, "radius"),
         "radius" & " is missing while decoding " & "Const_typedShape")
  target.radius = jsonTo(source{"radius"}, typeof(target.radius))

proc toJsonHook*(source: Const_typedShape): JsonNode =
  result = newJObject()
  result{"kind"} = newJString("circle")
  result{"radius"} = newJInt(source.radius)

proc toStream*(source: Const_typedShape; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("kind"))
  write(target, ':')
  write(target, "\"circle\"")
  hasEmitted.writeComma(target)
  write(target, escapeJson("radius"))
  write(target, ':')
  toStream(source.radius, target)
  target.write('}')

proc fromStream*(typ: typedesc[Const_typedShape];
                 source: var JsonParser): Const_typedShape =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "radius":
      result.radius = fromStream(typeof(result.radius), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

converter forConst_typedUnion*(value: Const_typedShape): Const_typedUnion =
  return Const_typedUnion(kind: 0, key0: value)

proc equals(_: typedesc[Const_typedShape2]; a, b: Const_typedShape2): bool =
  equals(typeof(a.side), a.side, b.side)

proc `==`*(a, b: Const_typedShape2): bool =
  return equals(Const_typedShape2, a, b)

proc stringify(_: typedesc[Const_typedShape2]; value: Const_typedShape2): string =
  stringifyObj("Const_typedShape2", ("kind", "\"square\""),
               ("side", stringify(typeof(value.side), value.side)))

proc `$`*(value: Const_typedShape2): string =
  stringify(Const_typedShape2, value)

proc fromJsonHook*(target: var Const_typedShape2; source: JsonNode) =
  assert(hasKey(source, "side"),
         "side" & " is missing while decoding " & "Const_typedShape2")
  target.side = jsonTo(source{"side"}, typeof(target.side))

proc toJsonHook*(source: Const_typedShape2): JsonNode =
  result = newJObject()
  result{"kind"} = newJString("square")
  result{"side"} = newJInt(source.side)

proc toStream*(source: Const_typedShape2; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("kind"))
  write(target, ':')
  write(target, "\"square\"")
  hasEmitted.writeComma(target)
  write(target, escapeJson("side"))
  write(target, ':')
  toStream(source.side, target)
  target.write('}')

proc fromStream*(typ: typedesc[Const_typedShape2];
                 source: var JsonParser): Const_typedShape2 =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "side":
      result.side = fromStream(typeof(result.side), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

converter forConst_typedUnion*(value: Const_typedShape2): Const_typedUnion =
  return Const_typedUnion(kind: 1, key1: value)

proc equals(_: typedesc[Const_typedUnion]; a, b: Const_typedUnion): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Const_typedUnion): bool =
  return equals(Const_typedUnion, a, b)

proc stringify(_: typedesc[Const_typedUnion]; value: Const_typedUnion): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Const_typedUnion): string =
  stringify(Const_typedUnion, value)

proc fromJsonHook*(target: var Const_typedUnion; source: JsonNode) =
  if source.kind == JObject and hasKey(source, "kind") and
      hasKey(source, "radius"):
    target = Const_typedUnion(kind: 0, key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject and hasKey(source, "kind") and
      hasKey(source, "side"):
    target = Const_typedUnion(kind: 1, key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to Const_typedUnion")
  
proc toJsonHook*(source: Const_typedUnion): JsonNode =
  case source.kind
  of 0:
    toJsonHook(source.key0)
  of 1:
    toJsonHook(source.key1)
  
proc isObject*(value: Const_typedUnion): bool =
  value.kind == 0

proc asObject*(value: Const_typedUnion): auto =
  assert(value.kind == 0)
  return value.key0

proc toBinary*(target: var string; source: Const_typedUnion) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Const_typedUnion]; source: string; idx: var int): Const_typedUnion =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Const_typedUnion(kind: 0,
                            key0: fromBinary(typeof(result.key0), source, idx))
  of 1:
    return Const_typedUnion(kind: 1,
                            key1: fromBinary(typeof(result.key1), source, idx))
  
proc toStream*(source: Const_typedUnion; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Const_typedUnion];
                 source: var JsonParser): Const_typedUnion =
  jsonTo(fromStream(JsonNode, source), Const_typedUnion)

proc equals(_: typedesc[Const_typed]; a, b: Const_typed): bool =
  equals(typeof(a.shape), a.shape, b.shape)

proc `==`*(a, b: Const_typed): bool =
  return equals(Const_typed, a, b)

proc stringify(_: typedesc[Const_typed]; value: Const_typed): string =
  stringifyObj("Const_typed", ("taggedKind", "\"widget\""),
               ("shape", stringify(typeof(value.shape), value.shape)))

proc `$`*(value: Const_typed): string =
  stringify(Const_typed, value)

proc fromJsonHook*(target: var Const_typed; source: JsonNode) =
  assert(hasKey(source, "shape"),
         "shape" & " is missing while decoding " & "Const_typed")
  target.shape = jsonTo(source{"shape"}, typeof(target.shape))

proc toJsonHook*(source: Const_typed): JsonNode =
  result = newJObject()
  result{"taggedKind"} = newJString("widget")
  result{"shape"} = toJsonHook(source.shape)

proc toStream*(source: Const_typed; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("taggedKind"))
  write(target, ':')
  write(target, "\"widget\"")
  hasEmitted.writeComma(target)
  write(target, escapeJson("shape"))
  write(target, ':')
  toStream(source.shape, target)
  target.write('}')

proc fromStream*(typ: typedesc[Const_typed]; source: var JsonParser): Const_typed =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "shape":
      result.shape = fromStream(typeof(result.shape), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

{.pop.}
