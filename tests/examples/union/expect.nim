{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  TestTestunion_key1Union* = object
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
  TestTestunion_key30* = object
    foo*: Option[string]
  TestTestunion_key33* = enum
    B, C, A
  TestTestunion_key3Union* = object
    case kind*: range[0 .. 4]
    of 0:
      key0*: TestTestunion_key30
    of 1:
      key1*: seq[string]
    of 2:
      key2*: Table[string, string]
    of 3:
      key3*: TestTestunion_key33
    of 4:
      key4*: Option[string]
  Testunion* = object
    key1*: Option[TestTestunion_key1Union]
    key2*: Option[string]
    key3*: Option[TestTestunion_key3Union]
proc fromJsonHook*(target: var TestTestunion_key1Union; source: JsonNode) =
  if source.kind == JString:
    target = TestTestunion_key1Union(kind: 0,
                                     key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JInt:
    target = TestTestunion_key1Union(kind: 1,
                                     key1: jsonTo(source, typeof(target.key1)))
  elif source.kind == JBool:
    target = TestTestunion_key1Union(kind: 2,
                                     key2: jsonTo(source, typeof(target.key2)))
  elif source.kind == JNull:
    target = TestTestunion_key1Union(kind: 3,
                                     key3: jsonTo(source, typeof(target.key3)))
  elif source.kind == JFloat or source.kind == JInt:
    target = TestTestunion_key1Union(kind: 4,
                                     key4: jsonTo(source, typeof(target.key4)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to TestTestunion_key1Union")
  
proc toJsonHook*(source: TestTestunion_key1Union): JsonNode =
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
  
proc isStr(value: TestTestunion_key1Union): bool =
  value.kind == 0

proc asStr(value: TestTestunion_key1Union): auto =
  assert(value.kind == 0)
  return value.key0

proc isInt(value: TestTestunion_key1Union): bool =
  value.kind == 1

proc asInt(value: TestTestunion_key1Union): auto =
  assert(value.kind == 1)
  return value.key1

proc isBool(value: TestTestunion_key1Union): bool =
  value.kind == 2

proc asBool(value: TestTestunion_key1Union): auto =
  assert(value.kind == 2)
  return value.key2

proc isNull(value: TestTestunion_key1Union): bool =
  value.kind == 3

proc asNull(value: TestTestunion_key1Union): auto =
  assert(value.kind == 3)
  return value.key3

proc isFloat(value: TestTestunion_key1Union): bool =
  value.kind == 4

proc asFloat(value: TestTestunion_key1Union): auto =
  assert(value.kind == 4)
  return value.key4

proc fromJsonHook*(target: var TestTestunion_key30; source: JsonNode) =
  if "foo" in source and source{"foo"}.kind != JNull:
    target.foo = some(jsonTo(source{"foo"}, typeof(unsafeGet(target.foo))))

proc toJsonHook*(source: TestTestunion_key30): JsonNode =
  result = newJObject()
  if isSome(source.foo):
    result{"foo"} = toJson(source.foo)

proc toJsonHook*(source: TestTestunion_key33): JsonNode =
  case source
  of TestTestunion_key33.B:
    return newJString("b")
  of TestTestunion_key33.C:
    return newJString("c")
  of TestTestunion_key33.A:
    return newJString("a")
  
proc fromJsonHook*(target: var TestTestunion_key33; source: JsonNode) =
  target = case getStr(source)
  of "b":
    TestTestunion_key33.B
  of "c":
    TestTestunion_key33.C
  of "a":
    TestTestunion_key33.A
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestTestunion_key3Union; source: JsonNode) =
  if source.kind == JObject:
    target = TestTestunion_key3Union(kind: 0,
                                     key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JArray:
    target = TestTestunion_key3Union(kind: 1,
                                     key1: jsonTo(source, typeof(target.key1)))
  elif source.kind == JObject:
    target = TestTestunion_key3Union(kind: 2,
                                     key2: jsonTo(source, typeof(target.key2)))
  elif source.kind == JString:
    target = TestTestunion_key3Union(kind: 3,
                                     key3: jsonTo(source, typeof(target.key3)))
  elif source.kind == JString:
    target = TestTestunion_key3Union(kind: 4,
                                     key4: jsonTo(source, typeof(target.key4)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to TestTestunion_key3Union")
  
proc toJsonHook*(source: TestTestunion_key3Union): JsonNode =
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
  
proc isObject(value: TestTestunion_key3Union): bool =
  value.kind == 0

proc asObject(value: TestTestunion_key3Union): auto =
  assert(value.kind == 0)
  return value.key0

proc isSeqOfStr(value: TestTestunion_key3Union): bool =
  value.kind == 1

proc asSeqOfStr(value: TestTestunion_key3Union): auto =
  assert(value.kind == 1)
  return value.key1

proc isMapOfStr(value: TestTestunion_key3Union): bool =
  value.kind == 2

proc asMapOfStr(value: TestTestunion_key3Union): auto =
  assert(value.kind == 2)
  return value.key2

proc isEnum(value: TestTestunion_key3Union): bool =
  value.kind == 3

proc asEnum(value: TestTestunion_key3Union): auto =
  assert(value.kind == 3)
  return value.key3

proc isOptOfStr(value: TestTestunion_key3Union): bool =
  value.kind == 4

proc asOptOfStr(value: TestTestunion_key3Union): auto =
  assert(value.kind == 4)
  return value.key4

proc fromJsonHook*(target: var Testunion; source: JsonNode) =
  if "key1" in source and source{"key1"}.kind != JNull:
    target.key1 = some(jsonTo(source{"key1"}, typeof(unsafeGet(target.key1))))
  if "key2" in source and source{"key2"}.kind != JNull:
    target.key2 = some(jsonTo(source{"key2"}, typeof(unsafeGet(target.key2))))
  if "key3" in source and source{"key3"}.kind != JNull:
    target.key3 = some(jsonTo(source{"key3"}, typeof(unsafeGet(target.key3))))

proc toJsonHook*(source: Testunion): JsonNode =
  result = newJObject()
  if isSome(source.key1):
    result{"key1"} = toJson(source.key1)
  if isSome(source.key2):
    result{"key2"} = toJson(source.key2)
  if isSome(source.key3):
    result{"key3"} = toJson(source.key3)
