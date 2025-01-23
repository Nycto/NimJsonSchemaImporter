{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  UnionKey1Union* = object
    case kind*: range[0 .. 4]
    of 0:
      key0*: string
    of 1:
      key1*: BiggestInt
    of 2:
      key2*: bool
    of 3:
      key3*: pointer
    of 4:
      key4*: BiggestFloat
  UnionKey3* = object
    foo*: Option[string]
  UnionunionKey3* = enum
    B, C, A
  UnionKey3Union* = object
    case kind*: range[0 .. 4]
    of 0:
      key0*: UnionKey3
    of 1:
      key1*: seq[string]
    of 2:
      key2*: Table[string, string]
    of 3:
      key3*: UnionunionKey3
    of 4:
      key4*: Option[string]
  Unionunion* = object
    key1*: Option[UnionKey1Union]
    key2*: Option[string]
    key3*: Option[UnionKey3Union]
proc fromJsonHook*(target: var UnionKey1Union; source: JsonNode) =
  if source.kind == JString:
    target = UnionKey1Union(kind: 0, key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JInt:
    target = UnionKey1Union(kind: 1, key1: jsonTo(source, typeof(target.key1)))
  elif source.kind == JBool:
    target = UnionKey1Union(kind: 2, key2: jsonTo(source, typeof(target.key2)))
  elif source.kind == JNull:
    target = UnionKey1Union(kind: 3, key3: jsonTo(source, typeof(target.key3)))
  elif source.kind == JFloat or source.kind == JInt:
    target = UnionKey1Union(kind: 4, key4: jsonTo(source, typeof(target.key4)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to UnionKey1Union")
  
proc toJsonHook*(source: UnionKey1Union): JsonNode =
  case source.kind
  of 0:
    return toJson(source.key0)
  of 1:
    return toJson(source.key1)
  of 2:
    return toJson(source.key2)
  of 3:
    return toJson(source.key3)
  of 4:
    return toJson(source.key4)
  
proc isStr(value: UnionKey1Union): bool =
  value.kind == 0

proc asStr(value: UnionKey1Union): auto =
  assert(value.kind == 0)
  return value.key0

proc isInt(value: UnionKey1Union): bool =
  value.kind == 1

proc asInt(value: UnionKey1Union): auto =
  assert(value.kind == 1)
  return value.key1

proc isBool(value: UnionKey1Union): bool =
  value.kind == 2

proc asBool(value: UnionKey1Union): auto =
  assert(value.kind == 2)
  return value.key2

proc isNull(value: UnionKey1Union): bool =
  value.kind == 3

proc asNull(value: UnionKey1Union): auto =
  assert(value.kind == 3)
  return value.key3

proc isFloat(value: UnionKey1Union): bool =
  value.kind == 4

proc asFloat(value: UnionKey1Union): auto =
  assert(value.kind == 4)
  return value.key4

proc fromJsonHook*(target: var UnionKey3; source: JsonNode) =
  if hasKey(source, "foo") and source{"foo"}.kind != JNull:
    target.foo = some(jsonTo(source{"foo"}, typeof(unsafeGet(target.foo))))

proc toJsonHook*(source: UnionKey3): JsonNode =
  result = newJObject()
  if isSome(source.foo):
    result{"foo"} = toJson(unsafeGet(source.foo))

proc toJsonHook*(source: UnionunionKey3): JsonNode =
  case source
  of UnionunionKey3.B:
    return newJString("b")
  of UnionunionKey3.C:
    return newJString("c")
  of UnionunionKey3.A:
    return newJString("a")
  
proc fromJsonHook*(target: var UnionunionKey3; source: JsonNode) =
  target = case getStr(source)
  of "b":
    UnionunionKey3.B
  of "c":
    UnionunionKey3.C
  of "a":
    UnionunionKey3.A
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var UnionKey3Union; source: JsonNode) =
  if source.kind == JObject:
    target = UnionKey3Union(kind: 0, key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JArray:
    target = UnionKey3Union(kind: 1, key1: jsonTo(source, typeof(target.key1)))
  elif source.kind == JObject:
    target = UnionKey3Union(kind: 2, key2: jsonTo(source, typeof(target.key2)))
  elif source.kind == JString:
    target = UnionKey3Union(kind: 3, key3: jsonTo(source, typeof(target.key3)))
  elif source.kind == JString:
    target = UnionKey3Union(kind: 4, key4: jsonTo(source, typeof(target.key4)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to UnionKey3Union")
  
proc toJsonHook*(source: UnionKey3Union): JsonNode =
  case source.kind
  of 0:
    return toJson(source.key0)
  of 1:
    return toJson(source.key1)
  of 2:
    return toJson(source.key2)
  of 3:
    return toJson(source.key3)
  of 4:
    return toJson(source.key4)
  
proc isObject(value: UnionKey3Union): bool =
  value.kind == 0

proc asObject(value: UnionKey3Union): auto =
  assert(value.kind == 0)
  return value.key0

proc isSeqOfStr(value: UnionKey3Union): bool =
  value.kind == 1

proc asSeqOfStr(value: UnionKey3Union): auto =
  assert(value.kind == 1)
  return value.key1

proc isMapOfStr(value: UnionKey3Union): bool =
  value.kind == 2

proc asMapOfStr(value: UnionKey3Union): auto =
  assert(value.kind == 2)
  return value.key2

proc isEnum(value: UnionKey3Union): bool =
  value.kind == 3

proc asEnum(value: UnionKey3Union): auto =
  assert(value.kind == 3)
  return value.key3

proc isOptOfStr(value: UnionKey3Union): bool =
  value.kind == 4

proc asOptOfStr(value: UnionKey3Union): auto =
  assert(value.kind == 4)
  return value.key4

proc fromJsonHook*(target: var Unionunion; source: JsonNode) =
  if hasKey(source, "key1") and source{"key1"}.kind != JNull:
    target.key1 = some(jsonTo(source{"key1"}, typeof(unsafeGet(target.key1))))
  if hasKey(source, "key2") and source{"key2"}.kind != JNull:
    target.key2 = some(jsonTo(source{"key2"}, typeof(unsafeGet(target.key2))))
  if hasKey(source, "key3") and source{"key3"}.kind != JNull:
    target.key3 = some(jsonTo(source{"key3"}, typeof(unsafeGet(target.key3))))

proc toJsonHook*(source: Unionunion): JsonNode =
  result = newJObject()
  if isSome(source.key1):
    result{"key1"} = toJson(unsafeGet(source.key1))
  if isSome(source.key2):
    result{"key2"} = toJson(unsafeGet(source.key2))
  if isSome(source.key3):
    result{"key3"} = toJson(unsafeGet(source.key3))
