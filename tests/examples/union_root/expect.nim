{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Union_root* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: string
    of 1:
      key1*: BiggestInt
converter forUnion_root*(value: string): Union_root =
  return Union_root(kind: 0, key0: value)

converter forUnion_root*(value: BiggestInt): Union_root =
  return Union_root(kind: 1, key1: value)

proc equals(_: typedesc[Union_root]; a, b: Union_root): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Union_root): bool =
  return equals(Union_root, a, b)

proc stringify(_: typedesc[Union_root]; value: Union_root): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Union_root): string =
  stringify(Union_root, value)

proc fromJsonHook*(target: var Union_root; source: JsonNode) =
  if source.kind == JString:
    target = Union_root(kind: 0, key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JInt:
    target = Union_root(kind: 1, key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to Union_root")
  
proc toJsonHook*(source: Union_root): JsonNode =
  case source.kind
  of 0:
    newJString(source.key0)
  of 1:
    newJInt(source.key1)
  
proc isStr*(value: Union_root): bool =
  value.kind == 0

proc asStr*(value: Union_root): auto =
  assert(value.kind == 0)
  return value.key0

proc isInt*(value: Union_root): bool =
  value.kind == 1

proc asInt*(value: Union_root): auto =
  assert(value.kind == 1)
  return value.key1

proc toBinary*(target: var string; source: Union_root) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Union_root]; source: string; idx: var int): Union_root =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Union_root(kind: 0,
                      key0: fromBinary(typeof(result.key0), source, idx))
  of 1:
    return Union_root(kind: 1,
                      key1: fromBinary(typeof(result.key1), source, idx))
  
proc toStream*(source: Union_root; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Union_root]; source: var JsonParser): Union_root =
  jsonTo(fromStream(JsonNode, source), Union_root)

{.pop.}
