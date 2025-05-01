{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  UnionUnion* {.byref.} = object
    case kind*: range[0 .. 3]
    of 0:
      key0*: string
    of 1:
      key1*: BiggestInt
    of 2:
      key2*: bool
    of 3:
      key3*: BiggestFloat
  UnionKey3* {.byref.} = object
    foo*: Option[string]
  UnionKey32* = enum
    A = "a", B = "b", C = "c"
  UnionKey3Union* {.byref.} = object
    case kind*: range[0 .. 4]
    of 0:
      key0*: UnionKey3
    of 1:
      key1*: seq[string]
    of 2:
      key2*: OrderedTable[string, string]
    of 3:
      key3*: UnionKey32
    of 4:
      key4*: string
  Union* {.byref.} = object
    key1*: Option[UnionUnion]
    key2*: string
    key3*: Option[UnionKey3Union]
proc `=copy`(a: var UnionKey3; b: UnionKey3) {.error.}
proc toJsonHook*(source: UnionKey3): JsonNode
proc `=copy`(a: var Union; b: Union) {.error.}
proc toJsonHook*(source: Union): JsonNode
converter forUnionUnion*(value: string): UnionUnion =
  return UnionUnion(kind: 0, key0: value)

converter forUnionUnion*(value: BiggestInt): UnionUnion =
  return UnionUnion(kind: 1, key1: value)

converter forUnionUnion*(value: bool): UnionUnion =
  return UnionUnion(kind: 2, key2: value)

converter forUnionUnion*(value: BiggestFloat): UnionUnion =
  return UnionUnion(kind: 3, key3: value)

proc equals(_: typedesc[UnionUnion]; a, b: UnionUnion): bool =
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
  
proc `==`*(a, b: UnionUnion): bool =
  return equals(UnionUnion, a, b)

proc stringify(_: typedesc[UnionUnion]; value: UnionUnion): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  of 2:
    return stringify(typeof(value.key2), value.key2)
  of 3:
    return stringify(typeof(value.key3), value.key3)
  
proc `$`*(value: UnionUnion): string =
  stringify(UnionUnion, value)

proc fromJsonHook*(target: var UnionUnion; source: JsonNode) =
  if source.kind == JString:
    target = UnionUnion(kind: 0, key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JInt:
    target = UnionUnion(kind: 1, key1: jsonTo(source, typeof(target.key1)))
  elif source.kind == JBool:
    target = UnionUnion(kind: 2, key2: jsonTo(source, typeof(target.key2)))
  elif source.kind == JFloat or source.kind == JInt:
    target = UnionUnion(kind: 3, key3: jsonTo(source, typeof(target.key3)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to UnionUnion")
  
proc toJsonHook*(source: UnionUnion): JsonNode =
  case source.kind
  of 0:
    newJString(source.key0)
  of 1:
    newJInt(source.key1)
  of 2:
    newJBool(source.key2)
  of 3:
    newJFloat(source.key3)
  
proc isStr*(value: UnionUnion): bool =
  value.kind == 0

proc asStr*(value: UnionUnion): auto =
  assert(value.kind == 0)
  return value.key0

proc isInt*(value: UnionUnion): bool =
  value.kind == 1

proc asInt*(value: UnionUnion): auto =
  assert(value.kind == 1)
  return value.key1

proc isBool*(value: UnionUnion): bool =
  value.kind == 2

proc asBool*(value: UnionUnion): auto =
  assert(value.kind == 2)
  return value.key2

proc isFloat*(value: UnionUnion): bool =
  value.kind == 3

proc asFloat*(value: UnionUnion): auto =
  assert(value.kind == 3)
  return value.key3

proc toBinary*(target: var string; source: UnionUnion) =
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
  
proc fromBinary(_: typedesc[UnionUnion]; source: string; idx: var int): UnionUnion =
  case fromBinary(range[0 .. 3], source, idx)
  of 0:
    return UnionUnion(kind: 0,
                      key0: fromBinary(typeof(result.key0), source, idx))
  of 1:
    return UnionUnion(kind: 1,
                      key1: fromBinary(typeof(result.key1), source, idx))
  of 2:
    return UnionUnion(kind: 2,
                      key2: fromBinary(typeof(result.key2), source, idx))
  of 3:
    return UnionUnion(kind: 3,
                      key3: fromBinary(typeof(result.key3), source, idx))
  
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

converter forUnionKey3Union*(value: UnionKey3): UnionKey3Union =
  return UnionKey3Union(kind: 0, key0: value)

converter forUnionKey3Union*(value: seq[string]): UnionKey3Union =
  return UnionKey3Union(kind: 1, key1: value)

converter forUnionKey3Union*(value: OrderedTable[string, string]): UnionKey3Union =
  return UnionKey3Union(kind: 2, key2: value)

converter forUnionKey3Union*(value: UnionKey32): UnionKey3Union =
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
      let cursor {.cursor.} = source.key1
      var output = newJArray()
      for entry in cursor:
        output.add(newJString(entry))
      output
  of 2:
    block:
      let cursor {.cursor.} = source.key2
      var output = newJObject()
      for key in keys(cursor):
        output[key] = newJString(
            cursor[key])
      output
  of 3:
    `%`(source.key3)
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
  
proc equals(_: typedesc[Union]; a, b: Union): bool =
  equals(typeof(a.key1), a.key1, b.key1) and
      equals(typeof(a.key2), a.key2, b.key2) and
      equals(typeof(a.key3), a.key3, b.key3)

proc `==`*(a, b: Union): bool =
  return equals(Union, a, b)

proc stringify(_: typedesc[Union]; value: Union): string =
  stringifyObj("Union", ("key1", stringify(typeof(value.key1), value.key1)),
               ("key2", stringify(typeof(value.key2), value.key2)),
               ("key3", stringify(typeof(value.key3), value.key3)))

proc `$`*(value: Union): string =
  stringify(Union, value)

proc fromJsonHook*(target: var Union; source: JsonNode) =
  assert(hasKey(source, "key1"),
         "key1" & " is missing while decoding " & "Union")
  target.key1 = jsonTo(source{"key1"}, typeof(target.key1))
  assert(hasKey(source, "key2"),
         "key2" & " is missing while decoding " & "Union")
  target.key2 = jsonTo(source{"key2"}, typeof(target.key2))
  assert(hasKey(source, "key3"),
         "key3" & " is missing while decoding " & "Union")
  target.key3 = jsonTo(source{"key3"}, typeof(target.key3))

proc toJsonHook*(source: Union): JsonNode =
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
{.pop.}
