{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Union_discriminatorShape* {.byref.} = object
    radius*: BiggestFloat
    name*: string
  Union_discriminatorShape2* {.byref.} = object
    side*: BiggestFloat
    name*: string
  Union_discriminatorUnion* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: Union_discriminatorShape
    of 1:
      key1*: Union_discriminatorShape2
  Union_discriminator* {.byref.} = object
    shape*: Union_discriminatorUnion
proc `=copy`(a: var Union_discriminatorShape;
             b: Union_discriminatorShape) {.error.}
proc toJsonHook*(source: Union_discriminatorShape): JsonNode
proc `=copy`(a: var Union_discriminatorShape2;
             b: Union_discriminatorShape2) {.error.}
proc toJsonHook*(source: Union_discriminatorShape2): JsonNode
proc `=copy`(a: var Union_discriminator;
             b: Union_discriminator) {.error.}
proc toJsonHook*(source: Union_discriminator): JsonNode
proc equals(_: typedesc[Union_discriminatorShape];
            a, b: Union_discriminatorShape): bool =
  equals(typeof(a.radius), a.radius, b.radius) and
      equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: Union_discriminatorShape): bool =
  return equals(Union_discriminatorShape, a, b)

proc stringify(_: typedesc[Union_discriminatorShape];
               value: Union_discriminatorShape): string =
  stringifyObj("Union_discriminatorShape",
               ("radius", stringify(typeof(value.radius), value.radius)),
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: Union_discriminatorShape): string =
  stringify(Union_discriminatorShape, value)

proc fromJsonHook*(target: var Union_discriminatorShape; source: JsonNode) =
  assert(hasKey(source, "radius"),
         "radius" & " is missing while decoding " & "Union_discriminatorShape")
  target.radius = jsonTo(source{"radius"}, typeof(target.radius))
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Union_discriminatorShape")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: Union_discriminatorShape): JsonNode =
  result = newJObject()
  result{"radius"} = newJFloat(source.radius)
  result{"name"} = newJString(source.name)

proc toStream*(source: Union_discriminatorShape; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("radius"))
  write(target, ':')
  toStream(source.radius, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  target.write('}')

proc fromStream*(typ: typedesc[Union_discriminatorShape];
                 source: var JsonParser): Union_discriminatorShape =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "radius":
      result.radius = fromStream(typeof(result.radius), source)
      seen.incl(0)
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

converter forUnion_discriminatorUnion*(value: Union_discriminatorShape): Union_discriminatorUnion =
  return Union_discriminatorUnion(kind: 0, key0: value)

proc equals(_: typedesc[Union_discriminatorShape2];
            a, b: Union_discriminatorShape2): bool =
  equals(typeof(a.side), a.side, b.side) and
      equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: Union_discriminatorShape2): bool =
  return equals(Union_discriminatorShape2, a, b)

proc stringify(_: typedesc[Union_discriminatorShape2];
               value: Union_discriminatorShape2): string =
  stringifyObj("Union_discriminatorShape2",
               ("side", stringify(typeof(value.side), value.side)),
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: Union_discriminatorShape2): string =
  stringify(Union_discriminatorShape2, value)

proc fromJsonHook*(target: var Union_discriminatorShape2; source: JsonNode) =
  assert(hasKey(source, "side"),
         "side" & " is missing while decoding " & "Union_discriminatorShape2")
  target.side = jsonTo(source{"side"}, typeof(target.side))
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Union_discriminatorShape2")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: Union_discriminatorShape2): JsonNode =
  result = newJObject()
  result{"side"} = newJFloat(source.side)
  result{"name"} = newJString(source.name)

proc toStream*(source: Union_discriminatorShape2; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("side"))
  write(target, ':')
  toStream(source.side, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  target.write('}')

proc fromStream*(typ: typedesc[Union_discriminatorShape2];
                 source: var JsonParser): Union_discriminatorShape2 =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "side":
      result.side = fromStream(typeof(result.side), source)
      seen.incl(0)
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

converter forUnion_discriminatorUnion*(value: Union_discriminatorShape2): Union_discriminatorUnion =
  return Union_discriminatorUnion(kind: 1, key1: value)

proc equals(_: typedesc[Union_discriminatorUnion];
            a, b: Union_discriminatorUnion): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Union_discriminatorUnion): bool =
  return equals(Union_discriminatorUnion, a, b)

proc stringify(_: typedesc[Union_discriminatorUnion];
               value: Union_discriminatorUnion): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Union_discriminatorUnion): string =
  stringify(Union_discriminatorUnion, value)

proc fromJsonHook*(target: var Union_discriminatorUnion; source: JsonNode) =
  if source.kind == JObject and hasKey(source, "radius") and
      hasKey(source, "name"):
    target = Union_discriminatorUnion(kind: 0,
                                      key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject and hasKey(source, "side") and
      hasKey(source, "name"):
    target = Union_discriminatorUnion(kind: 1,
                                      key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to Union_discriminatorUnion")
  
proc toJsonHook*(source: Union_discriminatorUnion): JsonNode =
  case source.kind
  of 0:
    toJsonHook(source.key0)
  of 1:
    toJsonHook(source.key1)
  
proc isObject*(value: Union_discriminatorUnion): bool =
  value.kind == 0

proc asObject*(value: Union_discriminatorUnion): auto =
  assert(value.kind == 0)
  return value.key0

proc toBinary*(target: var string; source: Union_discriminatorUnion) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Union_discriminatorUnion]; source: string;
                idx: var int): Union_discriminatorUnion =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Union_discriminatorUnion(kind: 0, key0: fromBinary(
        typeof(result.key0), source, idx))
  of 1:
    return Union_discriminatorUnion(kind: 1, key1: fromBinary(
        typeof(result.key1), source, idx))
  
proc toStream*(source: Union_discriminatorUnion; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Union_discriminatorUnion];
                 source: var JsonParser): Union_discriminatorUnion =
  jsonTo(fromStream(JsonNode, source), Union_discriminatorUnion)

proc equals(_: typedesc[Union_discriminator]; a, b: Union_discriminator): bool =
  equals(typeof(a.shape), a.shape, b.shape)

proc `==`*(a, b: Union_discriminator): bool =
  return equals(Union_discriminator, a, b)

proc stringify(_: typedesc[Union_discriminator]; value: Union_discriminator): string =
  stringifyObj("Union_discriminator",
               ("shape", stringify(typeof(value.shape), value.shape)))

proc `$`*(value: Union_discriminator): string =
  stringify(Union_discriminator, value)

proc fromJsonHook*(target: var Union_discriminator; source: JsonNode) =
  assert(hasKey(source, "shape"),
         "shape" & " is missing while decoding " & "Union_discriminator")
  target.shape = jsonTo(source{"shape"}, typeof(target.shape))

proc toJsonHook*(source: Union_discriminator): JsonNode =
  result = newJObject()
  result{"shape"} = toJsonHook(source.shape)

proc toStream*(source: Union_discriminator; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("shape"))
  write(target, ':')
  toStream(source.shape, target)
  target.write('}')

proc fromStream*(typ: typedesc[Union_discriminator];
                 source: var JsonParser): Union_discriminator =
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
