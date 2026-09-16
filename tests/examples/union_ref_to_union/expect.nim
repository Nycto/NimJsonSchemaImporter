{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Union_ref_to_unionItems* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: BiggestInt
    of 1:
      key1*: ref Union_ref_to_union
  Union_ref_to_unionUnion* {.byref.} = object
    `type`*: string
    `$ref`*: Option[string]
    items*: Option[Union_ref_to_unionItems]
  Union_ref_to_unionUnion2* {.byref.} = object
    `type`*: Option[string]
    `$ref`*: string
    items*: Option[Union_ref_to_unionItems]
  Union_ref_to_union* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: Union_ref_to_unionUnion
    of 1:
      key1*: Union_ref_to_unionUnion2
proc `=copy`(a: var Union_ref_to_unionUnion;
             b: Union_ref_to_unionUnion) {.error.}
proc `=copy`(a: var Union_ref_to_unionUnion2;
             b: Union_ref_to_unionUnion2) {.error.}
proc equals(_: typedesc[Union_ref_to_union]; a, b: Union_ref_to_union): bool
proc `==`*(a, b: Union_ref_to_union): bool
proc stringify(_: typedesc[Union_ref_to_union]; value: Union_ref_to_union): string
proc `$`*(value: Union_ref_to_union): string
proc fromJsonHook*(target: var Union_ref_to_union; source: JsonNode)
proc toJsonHook*(source: Union_ref_to_union): JsonNode
proc isObject*(value: Union_ref_to_union): bool
proc asObject*(value: Union_ref_to_union): typeof(
    value.key0)
proc toBinary*(target: var string; source: Union_ref_to_union)
proc fromBinary(_: typedesc[Union_ref_to_union]; source: string; idx: var int): Union_ref_to_union
proc toStream*(source: Union_ref_to_union; target: Stream)
proc fromStream*(typ: typedesc[Union_ref_to_union];
                 source: var JsonParser): Union_ref_to_union
converter forUnion_ref_to_unionItems*(value: BiggestInt): Union_ref_to_unionItems =
  return Union_ref_to_unionItems(kind: 0, key0: value)

proc forUnion_ref_to_unionItems*(value: ref Union_ref_to_union): Union_ref_to_unionItems =
  return Union_ref_to_unionItems(kind: 1, key1: value)

proc equals(_: typedesc[Union_ref_to_unionItems]; a, b: Union_ref_to_unionItems): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Union_ref_to_unionItems): bool =
  return equals(Union_ref_to_unionItems, a, b)

proc stringify(_: typedesc[Union_ref_to_unionItems];
               value: Union_ref_to_unionItems): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Union_ref_to_unionItems): string =
  stringify(Union_ref_to_unionItems, value)

proc fromJsonHook*(target: var Union_ref_to_unionItems; source: JsonNode) =
  if source.kind == JInt:
    target = Union_ref_to_unionItems(kind: 0,
                                     key0: jsonTo(source, typeof(target.key0)))
  elif false or source.kind == JObject and hasKey(source, "type") or
      source.kind == JObject and hasKey(source, "$ref"):
    target = Union_ref_to_unionItems(kind: 1,
                                     key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to Union_ref_to_unionItems")
  
proc toJsonHook*(source: Union_ref_to_unionItems): JsonNode =
  case source.kind
  of 0:
    newJInt(source.key0)
  of 1:
    toJson(source.key1)
  
proc isInt*(value: Union_ref_to_unionItems): bool =
  value.kind == 0

proc asInt*(value: Union_ref_to_unionItems): typeof(
    value.key0) =
  assert(value.kind == 0)
  return value.key0

proc isRoot*(value: Union_ref_to_unionItems): bool =
  value.kind == 1

proc asRoot*(value: Union_ref_to_unionItems): typeof(
    value.key1) =
  assert(value.kind == 1)
  return value.key1

proc toBinary*(target: var string; source: Union_ref_to_unionItems) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Union_ref_to_unionItems]; source: string;
                idx: var int): Union_ref_to_unionItems =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Union_ref_to_unionItems(kind: 0, key0: fromBinary(
        typeof(result.key0), source, idx))
  of 1:
    return Union_ref_to_unionItems(kind: 1, key1: fromBinary(
        typeof(result.key1), source, idx))
  
proc toStream*(source: Union_ref_to_unionItems; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Union_ref_to_unionItems];
                 source: var JsonParser): Union_ref_to_unionItems =
  jsonTo(fromStream(JsonNode, source), Union_ref_to_unionItems)

proc equals(_: typedesc[Union_ref_to_unionUnion]; a, b: Union_ref_to_unionUnion): bool =
  equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.`$ref`), a.`$ref`, b.`$ref`) and
      equals(typeof(a.items), a.items, b.items)

proc `==`*(a, b: Union_ref_to_unionUnion): bool =
  return equals(Union_ref_to_unionUnion, a, b)

proc stringify(_: typedesc[Union_ref_to_unionUnion];
               value: Union_ref_to_unionUnion): string =
  stringifyObj("Union_ref_to_unionUnion",
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("$ref", stringify(typeof(value.`$ref`), value.`$ref`)),
               ("items", stringify(typeof(value.items), value.items)))

proc `$`*(value: Union_ref_to_unionUnion): string =
  stringify(Union_ref_to_unionUnion, value)

proc fromJsonHook*(target: var Union_ref_to_unionUnion; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "Union_ref_to_unionUnion")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  if hasKey(source, "$ref") and source{"$ref"}.kind != JNull:
    target.`$ref` = some(jsonTo(source{"$ref"}, typeof(unsafeGet(target.`$ref`))))
  if hasKey(source, "items") and source{"items"}.kind != JNull:
    target.items = some(jsonTo(source{"items"}, typeof(unsafeGet(target.items))))

proc toJsonHook*(source: Union_ref_to_unionUnion): JsonNode =
  result = newJObject()
  result{"type"} = newJString(source.`type`)
  if isSome(source.`$ref`):
    result{"$ref"} = newJString(unsafeGet(source.`$ref`))
  if isSome(source.items):
    result{"items"} = toJsonHook(unsafeGet(source.items))

proc toStream*(source: Union_ref_to_unionUnion; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("type"))
  write(target, ':')
  toStream(source.`type`, target)
  if isSome(source.`$ref`):
    hasEmitted.writeComma(target)
    write(target, escapeJson("$ref"))
    write(target, ':')
    toStream(unsafeGet(source.`$ref`), target)
  if isSome(source.items):
    hasEmitted.writeComma(target)
    write(target, escapeJson("items"))
    write(target, ':')
    toStream(unsafeGet(source.items), target)
  target.write('}')

proc fromStream*(typ: typedesc[Union_ref_to_unionUnion];
                 source: var JsonParser): Union_ref_to_unionUnion =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "type":
      result.`type` = fromStream(typeof(result.`type`), source)
      seen.incl(0)
    of "$ref":
      result.`$ref` = some(fromStream(typeof(unsafeGet(result.`$ref`)), source))
    of "items":
      result.items = some(fromStream(typeof(unsafeGet(result.items)), source))
    else:
      skipValue(source)
  assert(card(seen) == 1)

converter forUnion_ref_to_union*(value: Union_ref_to_unionUnion): Union_ref_to_union =
  return Union_ref_to_union(kind: 0, key0: value)

proc equals(_: typedesc[Union_ref_to_unionUnion2];
            a, b: Union_ref_to_unionUnion2): bool =
  equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.`$ref`), a.`$ref`, b.`$ref`) and
      equals(typeof(a.items), a.items, b.items)

proc `==`*(a, b: Union_ref_to_unionUnion2): bool =
  return equals(Union_ref_to_unionUnion2, a, b)

proc stringify(_: typedesc[Union_ref_to_unionUnion2];
               value: Union_ref_to_unionUnion2): string =
  stringifyObj("Union_ref_to_unionUnion2",
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("$ref", stringify(typeof(value.`$ref`), value.`$ref`)),
               ("items", stringify(typeof(value.items), value.items)))

proc `$`*(value: Union_ref_to_unionUnion2): string =
  stringify(Union_ref_to_unionUnion2, value)

proc fromJsonHook*(target: var Union_ref_to_unionUnion2; source: JsonNode) =
  if hasKey(source, "type") and source{"type"}.kind != JNull:
    target.`type` = some(jsonTo(source{"type"}, typeof(unsafeGet(target.`type`))))
  assert(hasKey(source, "$ref"),
         "$ref" & " is missing while decoding " & "Union_ref_to_unionUnion2")
  target.`$ref` = jsonTo(source{"$ref"}, typeof(target.`$ref`))
  if hasKey(source, "items") and source{"items"}.kind != JNull:
    target.items = some(jsonTo(source{"items"}, typeof(unsafeGet(target.items))))

proc toJsonHook*(source: Union_ref_to_unionUnion2): JsonNode =
  result = newJObject()
  if isSome(source.`type`):
    result{"type"} = newJString(unsafeGet(source.`type`))
  result{"$ref"} = newJString(source.`$ref`)
  if isSome(source.items):
    result{"items"} = toJsonHook(unsafeGet(source.items))

proc toStream*(source: Union_ref_to_unionUnion2; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.`type`):
    hasEmitted.writeComma(target)
    write(target, escapeJson("type"))
    write(target, ':')
    toStream(unsafeGet(source.`type`), target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("$ref"))
  write(target, ':')
  toStream(source.`$ref`, target)
  if isSome(source.items):
    hasEmitted.writeComma(target)
    write(target, escapeJson("items"))
    write(target, ':')
    toStream(unsafeGet(source.items), target)
  target.write('}')

proc fromStream*(typ: typedesc[Union_ref_to_unionUnion2];
                 source: var JsonParser): Union_ref_to_unionUnion2 =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "type":
      result.`type` = some(fromStream(typeof(unsafeGet(result.`type`)), source))
    of "$ref":
      result.`$ref` = fromStream(typeof(result.`$ref`), source)
      seen.incl(0)
    of "items":
      result.items = some(fromStream(typeof(unsafeGet(result.items)), source))
    else:
      skipValue(source)
  assert(card(seen) == 1)

converter forUnion_ref_to_union*(value: Union_ref_to_unionUnion2): Union_ref_to_union =
  return Union_ref_to_union(kind: 1, key1: value)

proc equals(_: typedesc[Union_ref_to_union]; a, b: Union_ref_to_union): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Union_ref_to_union): bool =
  return equals(Union_ref_to_union, a, b)

proc stringify(_: typedesc[Union_ref_to_union]; value: Union_ref_to_union): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Union_ref_to_union): string =
  stringify(Union_ref_to_union, value)

proc fromJsonHook*(target: var Union_ref_to_union; source: JsonNode) =
  if source.kind == JObject and hasKey(source, "type"):
    target = Union_ref_to_union(kind: 0,
                                key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject and hasKey(source, "$ref"):
    target = Union_ref_to_union(kind: 1,
                                key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to Union_ref_to_union")
  
proc toJsonHook*(source: Union_ref_to_union): JsonNode =
  case source.kind
  of 0:
    toJsonHook(source.key0)
  of 1:
    toJsonHook(source.key1)
  
proc isObject*(value: Union_ref_to_union): bool =
  value.kind == 0

proc asObject*(value: Union_ref_to_union): typeof(
    value.key0) =
  assert(value.kind == 0)
  return value.key0

proc toBinary*(target: var string; source: Union_ref_to_union) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Union_ref_to_union]; source: string; idx: var int): Union_ref_to_union =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Union_ref_to_union(kind: 0, key0: fromBinary(typeof(result.key0),
        source, idx))
  of 1:
    return Union_ref_to_union(kind: 1, key1: fromBinary(typeof(result.key1),
        source, idx))
  
proc toStream*(source: Union_ref_to_union; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Union_ref_to_union];
                 source: var JsonParser): Union_ref_to_union =
  jsonTo(fromStream(JsonNode, source), Union_ref_to_union)

{.pop.}
