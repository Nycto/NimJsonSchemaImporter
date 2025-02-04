{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  UnionKey1Union* = object
    case kind*: range[0 .. 3]
    of 0:
      key0*: string
    of 1:
      key1*: BiggestInt
    of 2:
      key2*: bool
    of 3:
      key3*: BiggestFloat
  UnionKey3* = object
    foo*: Option[string]
  UnionunionKey3* = enum
    A, B, C
  UnionKey3Union* = object
    case kind*: range[0 .. 4]
    of 0:
      key0*: UnionKey3
    of 1:
      key1*: seq[string]
    of 2:
      key2*: OrderedTable[string, string]
    of 3:
      key3*: UnionunionKey3
    of 4:
      key4*: string
  Unionunion* = object
    key1*: Option[UnionKey1Union]
    key2*: string
    key3*: Option[UnionKey3Union]
proc toJsonHook*(source: UnionKey1Union): JsonNode
proc toJsonHook*(source: UnionKey3): JsonNode
proc toJsonHook*(source: UnionunionKey3): JsonNode
proc toJsonHook*(source: UnionKey3Union): JsonNode
proc toJsonHook*(source: Unionunion): JsonNode
converter forUnionKey1Union*(value: string): UnionKey1Union =
  return UnionKey1Union(kind: 0, key0: value)

converter forUnionKey1Union*(value: BiggestInt): UnionKey1Union =
  return UnionKey1Union(kind: 1, key1: value)

converter forUnionKey1Union*(value: bool): UnionKey1Union =
  return UnionKey1Union(kind: 2, key2: value)

converter forUnionKey1Union*(value: BiggestFloat): UnionKey1Union =
  return UnionKey1Union(kind: 3, key3: value)

proc equals(_: typedesc[UnionKey1Union]; a, b: UnionKey1Union): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  of 2:
    return equals(typeof(a.key2), a.key2, b.key2)
  of 3:
    return equals(typeof(a.key3), a.key3, b.key3)
  
proc `==`*(a, b: UnionKey1Union): bool =
  return equals(UnionKey1Union, a, b)

proc stringify(_: typedesc[UnionKey1Union]; value: UnionKey1Union): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  of 2:
    return stringify(typeof(value.key2), value.key2)
  of 3:
    return stringify(typeof(value.key3), value.key3)
  
proc `$`*(value: UnionKey1Union): string =
  stringify(UnionKey1Union, value)

proc fromJsonHook*(target: var UnionKey1Union; source: JsonNode) =
  if source.kind == JString:
    target = UnionKey1Union(kind: 0, key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JInt:
    target = UnionKey1Union(kind: 1, key1: jsonTo(source, typeof(target.key1)))
  elif source.kind == JBool:
    target = UnionKey1Union(kind: 2, key2: jsonTo(source, typeof(target.key2)))
  elif source.kind == JFloat or source.kind == JInt:
    target = UnionKey1Union(kind: 3, key3: jsonTo(source, typeof(target.key3)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to UnionKey1Union")
  
proc toJsonHook*(source: UnionKey1Union): JsonNode =
  case source.kind
  of 0:
    newJString(source.key0)
  of 1:
    newJInt(source.key1)
  of 2:
    newJBool(source.key2)
  of 3:
    newJFloat(source.key3)
  
proc isStr*(value: UnionKey1Union): bool =
  value.kind == 0

proc asStr*(value: UnionKey1Union): auto =
  assert(value.kind == 0)
  return value.key0

proc isInt*(value: UnionKey1Union): bool =
  value.kind == 1

proc asInt*(value: UnionKey1Union): auto =
  assert(value.kind == 1)
  return value.key1

proc isBool*(value: UnionKey1Union): bool =
  value.kind == 2

proc asBool*(value: UnionKey1Union): auto =
  assert(value.kind == 2)
  return value.key2

proc isFloat*(value: UnionKey1Union): bool =
  value.kind == 3

proc asFloat*(value: UnionKey1Union): auto =
  assert(value.kind == 3)
  return value.key3

proc toBinary*(target: var string; source: UnionKey1Union) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  of 2:
    toBinary(target, source.key2)
  of 3:
    toBinary(target, source.key3)
  
proc toBinary*(source: UnionKey1Union): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[UnionKey1Union]; source: string; idx: var int): UnionKey1Union =
  case fromBinary(range[0 .. 3], source, idx)
  of 0:
    return UnionKey1Union(kind: 0,
                          key0: fromBinary(typeof(result.key0), source, idx))
  of 1:
    return UnionKey1Union(kind: 1,
                          key1: fromBinary(typeof(result.key1), source, idx))
  of 2:
    return UnionKey1Union(kind: 2,
                          key2: fromBinary(typeof(result.key2), source, idx))
  of 3:
    return UnionKey1Union(kind: 3,
                          key3: fromBinary(typeof(result.key3), source, idx))
  
proc fromBinary*(_: typedesc[UnionKey1Union]; source: string): UnionKey1Union =
  var idx = 0
  return fromBinary(UnionKey1Union, source, idx)

proc equals(_: typedesc[UnionKey3]; a, b: UnionKey3): bool =
  equals(typeof(a.foo), a.foo, b.foo)

proc `==`*(a, b: UnionKey3): bool =
  return equals(UnionKey3, a, b)

proc stringify(_: typedesc[UnionKey3]; value: UnionKey3): string =
  stringifyObj("UnionKey3", ("foo", stringify(typeof(value.foo), value.foo)))

proc `$`*(value: UnionKey3): string =
  stringify(UnionKey3, value)

proc fromJsonHook*(target: var UnionKey3; source: JsonNode) =
  if hasKey(source, "foo") and source{"foo"}.kind != JNull:
    target.foo = some(jsonTo(source{"foo"}, typeof(unsafeGet(target.foo))))

proc toJsonHook*(source: UnionKey3): JsonNode =
  result = newJObject()
  if isSome(source.foo):
    result{"foo"} = newJString(unsafeGet(source.foo))

proc toBinary*(target: var string; source: UnionKey3) =
  toBinary(target, source.foo)

proc toBinary*(source: UnionKey3): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[UnionKey3]; source: string; idx: var int): UnionKey3 =
  result.foo = fromBinary(typeof(result.foo), source, idx)

proc fromBinary*(_: typedesc[UnionKey3]; source: string): UnionKey3 =
  var idx = 0
  return fromBinary(UnionKey3, source, idx)

converter forUnionKey3Union*(value: UnionKey3): UnionKey3Union =
  return UnionKey3Union(kind: 0, key0: value)

converter forUnionKey3Union*(value: seq[string]): UnionKey3Union =
  return UnionKey3Union(kind: 1, key1: value)

converter forUnionKey3Union*(value: OrderedTable[string, string]): UnionKey3Union =
  return UnionKey3Union(kind: 2, key2: value)

proc toJsonHook*(source: UnionunionKey3): JsonNode =
  case source
  of UnionunionKey3.A:
    return newJString("a")
  of UnionunionKey3.B:
    return newJString("b")
  of UnionunionKey3.C:
    return newJString("c")
  
proc fromJsonHook*(target: var UnionunionKey3; source: JsonNode) =
  target = case getStr(source)
  of "a":
    UnionunionKey3.A
  of "b":
    UnionunionKey3.B
  of "c":
    UnionunionKey3.C
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
converter forUnionKey3Union*(value: UnionunionKey3): UnionKey3Union =
  return UnionKey3Union(kind: 3, key3: value)

converter forUnionKey3Union*(value: string): UnionKey3Union =
  return UnionKey3Union(kind: 4, key4: value)

proc equals(_: typedesc[UnionKey3Union]; a, b: UnionKey3Union): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  of 2:
    return equals(typeof(a.key2), a.key2, b.key2)
  of 3:
    return equals(typeof(a.key3), a.key3, b.key3)
  of 4:
    return equals(typeof(a.key4), a.key4, b.key4)
  
proc `==`*(a, b: UnionKey3Union): bool =
  return equals(UnionKey3Union, a, b)

proc stringify(_: typedesc[UnionKey3Union]; value: UnionKey3Union): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  of 2:
    return stringify(typeof(value.key2), value.key2)
  of 3:
    return stringify(typeof(value.key3), value.key3)
  of 4:
    return stringify(typeof(value.key4), value.key4)
  
proc `$`*(value: UnionKey3Union): string =
  stringify(UnionKey3Union, value)

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
    toJsonHook(source.key0)
  of 1:
    block:
      var output = newJArray()
      for entry in source.key1:
        output.add(newJString(entry))
      output
  of 2:
    block:
      var output = newJObject()
      for key, entry in pairs(source.key2):
        output[key] = newJString(entry)
      output
  of 3:
    toJsonHook(source.key3)
  of 4:
    newJString(source.key4)
  
proc isObject*(value: UnionKey3Union): bool =
  value.kind == 0

proc asObject*(value: UnionKey3Union): auto =
  assert(value.kind == 0)
  return value.key0

proc isSeq*(value: UnionKey3Union): bool =
  value.kind == 1

proc asSeq*(value: UnionKey3Union): auto =
  assert(value.kind == 1)
  return value.key1

proc isSeqOfStr*(value: UnionKey3Union): bool =
  value.kind == 1

proc asSeqOfStr*(value: UnionKey3Union): auto =
  assert(value.kind == 1)
  return value.key1

proc isMap*(value: UnionKey3Union): bool =
  value.kind == 2

proc asMap*(value: UnionKey3Union): auto =
  assert(value.kind == 2)
  return value.key2

proc isMapOfStr*(value: UnionKey3Union): bool =
  value.kind == 2

proc asMapOfStr*(value: UnionKey3Union): auto =
  assert(value.kind == 2)
  return value.key2

proc isEnum*(value: UnionKey3Union): bool =
  value.kind == 3

proc asEnum*(value: UnionKey3Union): auto =
  assert(value.kind == 3)
  return value.key3

proc isStr*(value: UnionKey3Union): bool =
  value.kind == 4

proc asStr*(value: UnionKey3Union): auto =
  assert(value.kind == 4)
  return value.key4

proc toBinary*(target: var string; source: UnionKey3Union) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  of 2:
    toBinary(target, source.key2)
  of 3:
    toBinary(target, source.key3)
  of 4:
    toBinary(target, source.key4)
  
proc toBinary*(source: UnionKey3Union): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[UnionKey3Union]; source: string; idx: var int): UnionKey3Union =
  case fromBinary(range[0 .. 4], source, idx)
  of 0:
    return UnionKey3Union(kind: 0,
                          key0: fromBinary(typeof(result.key0), source, idx))
  of 1:
    return UnionKey3Union(kind: 1,
                          key1: fromBinary(typeof(result.key1), source, idx))
  of 2:
    return UnionKey3Union(kind: 2,
                          key2: fromBinary(typeof(result.key2), source, idx))
  of 3:
    return UnionKey3Union(kind: 3,
                          key3: fromBinary(typeof(result.key3), source, idx))
  of 4:
    return UnionKey3Union(kind: 4,
                          key4: fromBinary(typeof(result.key4), source, idx))
  
proc fromBinary*(_: typedesc[UnionKey3Union]; source: string): UnionKey3Union =
  var idx = 0
  return fromBinary(UnionKey3Union, source, idx)

proc equals(_: typedesc[Unionunion]; a, b: Unionunion): bool =
  equals(typeof(a.key1), a.key1, b.key1) and
      equals(typeof(a.key2), a.key2, b.key2) and
      equals(typeof(a.key3), a.key3, b.key3)

proc `==`*(a, b: Unionunion): bool =
  return equals(Unionunion, a, b)

proc stringify(_: typedesc[Unionunion]; value: Unionunion): string =
  stringifyObj("Unionunion",
               ("key1", stringify(typeof(value.key1), value.key1)),
               ("key2", stringify(typeof(value.key2), value.key2)),
               ("key3", stringify(typeof(value.key3), value.key3)))

proc `$`*(value: Unionunion): string =
  stringify(Unionunion, value)

proc fromJsonHook*(target: var Unionunion; source: JsonNode) =
  assert(hasKey(source, "key1"),
         "key1" & " is missing while decoding " & "Unionunion")
  target.key1 = jsonTo(source{"key1"}, typeof(target.key1))
  assert(hasKey(source, "key2"),
         "key2" & " is missing while decoding " & "Unionunion")
  target.key2 = jsonTo(source{"key2"}, typeof(target.key2))
  assert(hasKey(source, "key3"),
         "key3" & " is missing while decoding " & "Unionunion")
  target.key3 = jsonTo(source{"key3"}, typeof(target.key3))

proc toJsonHook*(source: Unionunion): JsonNode =
  result = newJObject()
  result{"key1"} = if isSome(source.key1):
    toJsonHook(unsafeGet(source.key1))
  else:
    newJNull()
  result{"key2"} = newJString(source.key2)
  result{"key3"} = if isSome(source.key3):
    toJsonHook(unsafeGet(source.key3))
  else:
    newJNull()

proc toBinary*(target: var string; source: Unionunion) =
  toBinary(target, source.key1)
  toBinary(target, source.key2)
  toBinary(target, source.key3)

proc toBinary*(source: Unionunion): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[Unionunion]; source: string; idx: var int): Unionunion =
  result.key1 = fromBinary(typeof(result.key1), source, idx)
  result.key2 = fromBinary(typeof(result.key2), source, idx)
  result.key3 = fromBinary(typeof(result.key3), source, idx)

proc fromBinary*(_: typedesc[Unionunion]; source: string): Unionunion =
  var idx = 0
  return fromBinary(Unionunion, source, idx)
{.pop.}
