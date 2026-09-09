{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Narrowed_unionNarrowed* {.byref.} = object
    a*: BiggestInt
    shared*: string
  Narrowed_unionNarrowed2* {.byref.} = object
    b*: BiggestInt
    shared*: string
  Narrowed_unionUnion* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: Narrowed_unionNarrowed
    of 1:
      key1*: Narrowed_unionNarrowed2
  Narrowed_union* {.byref.} = object
    narrowed*: Narrowed_unionUnion
proc `=copy`(a: var Narrowed_unionNarrowed;
             b: Narrowed_unionNarrowed) {.error.}
proc toJsonHook*(source: Narrowed_unionNarrowed): JsonNode
proc `=copy`(a: var Narrowed_unionNarrowed2;
             b: Narrowed_unionNarrowed2) {.error.}
proc toJsonHook*(source: Narrowed_unionNarrowed2): JsonNode
proc `=copy`(a: var Narrowed_union; b: Narrowed_union) {.
    error.}
proc toJsonHook*(source: Narrowed_union): JsonNode
proc equals(_: typedesc[Narrowed_unionNarrowed]; a, b: Narrowed_unionNarrowed): bool =
  equals(typeof(a.a), a.a, b.a) and equals(typeof(a.shared), a.shared, b.shared)

proc `==`*(a, b: Narrowed_unionNarrowed): bool =
  return equals(Narrowed_unionNarrowed, a, b)

proc stringify(_: typedesc[Narrowed_unionNarrowed];
               value: Narrowed_unionNarrowed): string =
  stringifyObj("Narrowed_unionNarrowed",
               ("a", stringify(typeof(value.a), value.a)),
               ("shared", stringify(typeof(value.shared), value.shared)))

proc `$`*(value: Narrowed_unionNarrowed): string =
  stringify(Narrowed_unionNarrowed, value)

proc fromJsonHook*(target: var Narrowed_unionNarrowed; source: JsonNode) =
  assert(hasKey(source, "a"),
         "a" & " is missing while decoding " & "Narrowed_unionNarrowed")
  target.a = jsonTo(source{"a"}, typeof(target.a))
  assert(hasKey(source, "shared"),
         "shared" & " is missing while decoding " & "Narrowed_unionNarrowed")
  target.shared = jsonTo(source{"shared"}, typeof(target.shared))

proc toJsonHook*(source: Narrowed_unionNarrowed): JsonNode =
  result = newJObject()
  result{"a"} = newJInt(source.a)
  result{"shared"} = newJString(source.shared)

proc toStream*(source: Narrowed_unionNarrowed; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("a"))
  write(target, ':')
  toStream(source.a, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("shared"))
  write(target, ':')
  toStream(source.shared, target)
  target.write('}')

proc fromStream*(typ: typedesc[Narrowed_unionNarrowed];
                 source: var JsonParser): Narrowed_unionNarrowed =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "a":
      result.a = fromStream(typeof(result.a), source)
      seen.incl(0)
    of "shared":
      result.shared = fromStream(typeof(result.shared), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

converter forNarrowed_unionUnion*(value: Narrowed_unionNarrowed): Narrowed_unionUnion =
  return Narrowed_unionUnion(kind: 0, key0: value)

proc equals(_: typedesc[Narrowed_unionNarrowed2]; a, b: Narrowed_unionNarrowed2): bool =
  equals(typeof(a.b), a.b, b.b) and equals(typeof(a.shared), a.shared, b.shared)

proc `==`*(a, b: Narrowed_unionNarrowed2): bool =
  return equals(Narrowed_unionNarrowed2, a, b)

proc stringify(_: typedesc[Narrowed_unionNarrowed2];
               value: Narrowed_unionNarrowed2): string =
  stringifyObj("Narrowed_unionNarrowed2",
               ("b", stringify(typeof(value.b), value.b)),
               ("shared", stringify(typeof(value.shared), value.shared)))

proc `$`*(value: Narrowed_unionNarrowed2): string =
  stringify(Narrowed_unionNarrowed2, value)

proc fromJsonHook*(target: var Narrowed_unionNarrowed2; source: JsonNode) =
  assert(hasKey(source, "b"),
         "b" & " is missing while decoding " & "Narrowed_unionNarrowed2")
  target.b = jsonTo(source{"b"}, typeof(target.b))
  assert(hasKey(source, "shared"),
         "shared" & " is missing while decoding " & "Narrowed_unionNarrowed2")
  target.shared = jsonTo(source{"shared"}, typeof(target.shared))

proc toJsonHook*(source: Narrowed_unionNarrowed2): JsonNode =
  result = newJObject()
  result{"b"} = newJInt(source.b)
  result{"shared"} = newJString(source.shared)

proc toStream*(source: Narrowed_unionNarrowed2; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("b"))
  write(target, ':')
  toStream(source.b, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("shared"))
  write(target, ':')
  toStream(source.shared, target)
  target.write('}')

proc fromStream*(typ: typedesc[Narrowed_unionNarrowed2];
                 source: var JsonParser): Narrowed_unionNarrowed2 =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "b":
      result.b = fromStream(typeof(result.b), source)
      seen.incl(0)
    of "shared":
      result.shared = fromStream(typeof(result.shared), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

converter forNarrowed_unionUnion*(value: Narrowed_unionNarrowed2): Narrowed_unionUnion =
  return Narrowed_unionUnion(kind: 1, key1: value)

proc equals(_: typedesc[Narrowed_unionUnion]; a, b: Narrowed_unionUnion): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Narrowed_unionUnion): bool =
  return equals(Narrowed_unionUnion, a, b)

proc stringify(_: typedesc[Narrowed_unionUnion]; value: Narrowed_unionUnion): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Narrowed_unionUnion): string =
  stringify(Narrowed_unionUnion, value)

proc fromJsonHook*(target: var Narrowed_unionUnion; source: JsonNode) =
  if source.kind == JObject and hasKey(source, "a") and hasKey(source, "shared"):
    target = Narrowed_unionUnion(kind: 0,
                                 key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject and hasKey(source, "b") and
      hasKey(source, "shared"):
    target = Narrowed_unionUnion(kind: 1,
                                 key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to Narrowed_unionUnion")
  
proc toJsonHook*(source: Narrowed_unionUnion): JsonNode =
  case source.kind
  of 0:
    toJsonHook(source.key0)
  of 1:
    toJsonHook(source.key1)
  
proc isObject*(value: Narrowed_unionUnion): bool =
  value.kind == 0

proc asObject*(value: Narrowed_unionUnion): auto =
  assert(value.kind == 0)
  return value.key0

proc toBinary*(target: var string; source: Narrowed_unionUnion) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Narrowed_unionUnion]; source: string; idx: var int): Narrowed_unionUnion =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Narrowed_unionUnion(kind: 0, key0: fromBinary(typeof(result.key0),
        source, idx))
  of 1:
    return Narrowed_unionUnion(kind: 1, key1: fromBinary(typeof(result.key1),
        source, idx))
  
proc toStream*(source: Narrowed_unionUnion; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Narrowed_unionUnion];
                 source: var JsonParser): Narrowed_unionUnion =
  jsonTo(fromStream(JsonNode, source), Narrowed_unionUnion)

proc equals(_: typedesc[Narrowed_union]; a, b: Narrowed_union): bool =
  equals(typeof(a.narrowed), a.narrowed, b.narrowed)

proc `==`*(a, b: Narrowed_union): bool =
  return equals(Narrowed_union, a, b)

proc stringify(_: typedesc[Narrowed_union]; value: Narrowed_union): string =
  stringifyObj("Narrowed_union",
               ("narrowed", stringify(typeof(value.narrowed), value.narrowed)))

proc `$`*(value: Narrowed_union): string =
  stringify(Narrowed_union, value)

proc fromJsonHook*(target: var Narrowed_union; source: JsonNode) =
  assert(hasKey(source, "narrowed"),
         "narrowed" & " is missing while decoding " & "Narrowed_union")
  target.narrowed = jsonTo(source{"narrowed"}, typeof(target.narrowed))

proc toJsonHook*(source: Narrowed_union): JsonNode =
  result = newJObject()
  result{"narrowed"} = toJsonHook(source.narrowed)

proc toStream*(source: Narrowed_union; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("narrowed"))
  write(target, ':')
  toStream(source.narrowed, target)
  target.write('}')

proc fromStream*(typ: typedesc[Narrowed_union];
                 source: var JsonParser): Narrowed_union =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "narrowed":
      result.narrowed = fromStream(typeof(result.narrowed), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

{.pop.}
