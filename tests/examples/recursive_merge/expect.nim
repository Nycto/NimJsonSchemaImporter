{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Recursive_mergeColumnItems* {.byref.} = object
    `ref`*: string
  Recursive_mergeAnon* {.byref.} = object
    `type`*: string
    `ref`*: Option[string]
    items*: Option[Recursive_mergeItems]
  Recursive_mergeAnon2* {.byref.} = object
    `ref`*: string
    `type`*: Option[string]
    items*: Option[Recursive_mergeItems]
  Recursive_mergeDataType* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: Recursive_mergeAnon
    of 1:
      key1*: Recursive_mergeAnon2
  Recursive_mergeItems* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: Recursive_mergeColumnItems
    of 1:
      key1*: ref Recursive_mergeDataType
  Recursive_mergeColumn* {.byref.} = object
    `type`*: string
    `ref`*: Option[string]
    items*: Option[Recursive_mergeItems]
    name*: string
  Recursive_mergeColumn2* {.byref.} = object
    `ref`*: string
    `type`*: Option[string]
    items*: Option[Recursive_mergeItems]
    name*: string
  Recursive_mergeUnion* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: Recursive_mergeColumn
    of 1:
      key1*: Recursive_mergeColumn2
  Recursive_merge* {.byref.} = object
    column*: Option[Recursive_mergeUnion]
proc `=copy`(a: var Recursive_mergeColumnItems;
             b: Recursive_mergeColumnItems) {.error.}
proc `=copy`(a: var Recursive_mergeAnon;
             b: Recursive_mergeAnon) {.error.}
proc `=copy`(a: var Recursive_mergeAnon2;
             b: Recursive_mergeAnon2) {.error.}
proc equals(_: typedesc[Recursive_mergeDataType]; a, b: Recursive_mergeDataType): bool
proc `==`*(a, b: Recursive_mergeDataType): bool
proc stringify(_: typedesc[Recursive_mergeDataType];
               value: Recursive_mergeDataType): string
proc `$`*(value: Recursive_mergeDataType): string
proc fromJsonHook*(target: var Recursive_mergeDataType; source: JsonNode)
proc toJsonHook*(source: Recursive_mergeDataType): JsonNode
proc isObject*(value: Recursive_mergeDataType): bool
proc asObject*(value: Recursive_mergeDataType): typeof(
    value.key0)
proc toBinary*(target: var string; source: Recursive_mergeDataType)
proc fromBinary(_: typedesc[Recursive_mergeDataType]; source: string;
                idx: var int): Recursive_mergeDataType
proc toStream*(source: Recursive_mergeDataType; target: Stream)
proc fromStream*(typ: typedesc[Recursive_mergeDataType];
                 source: var JsonParser): Recursive_mergeDataType
proc equals(_: typedesc[Recursive_mergeItems]; a, b: Recursive_mergeItems): bool
proc `==`*(a, b: Recursive_mergeItems): bool
proc stringify(_: typedesc[Recursive_mergeItems]; value: Recursive_mergeItems): string
proc `$`*(value: Recursive_mergeItems): string
proc fromJsonHook*(target: var Recursive_mergeItems; source: JsonNode)
proc toJsonHook*(source: Recursive_mergeItems): JsonNode
proc isObject*(value: Recursive_mergeItems): bool
proc asObject*(value: Recursive_mergeItems): typeof(
    value.key0)
proc isdataType*(value: Recursive_mergeItems): bool
proc asdataType*(value: Recursive_mergeItems): typeof(
    value.key1)
proc toBinary*(target: var string; source: Recursive_mergeItems)
proc fromBinary(_: typedesc[Recursive_mergeItems]; source: string; idx: var int): Recursive_mergeItems
proc toStream*(source: Recursive_mergeItems; target: Stream)
proc fromStream*(typ: typedesc[Recursive_mergeItems];
                 source: var JsonParser): Recursive_mergeItems
proc `=copy`(a: var Recursive_mergeColumn;
             b: Recursive_mergeColumn) {.error.}
proc `=copy`(a: var Recursive_mergeColumn2;
             b: Recursive_mergeColumn2) {.error.}
proc `=copy`(a: var Recursive_merge; b: Recursive_merge) {.
    error.}
proc equals(_: typedesc[Recursive_merge]; a, b: Recursive_merge): bool
proc `==`*(a, b: Recursive_merge): bool
proc stringify(_: typedesc[Recursive_merge]; value: Recursive_merge): string
proc `$`*(value: Recursive_merge): string
proc fromJsonHook*(target: var Recursive_merge; source: JsonNode)
proc toJsonHook*(source: Recursive_merge): JsonNode
proc toStream*(source: Recursive_merge; target: Stream)
proc fromStream*(typ: typedesc[Recursive_merge];
                 source: var JsonParser): Recursive_merge
proc equals(_: typedesc[Recursive_mergeColumnItems];
            a, b: Recursive_mergeColumnItems): bool =
  equals(typeof(a.`ref`), a.`ref`, b.`ref`)

proc `==`*(a, b: Recursive_mergeColumnItems): bool =
  return equals(Recursive_mergeColumnItems, a, b)

proc stringify(_: typedesc[Recursive_mergeColumnItems];
               value: Recursive_mergeColumnItems): string =
  stringifyObj("Recursive_mergeColumnItems",
               ("ref", stringify(typeof(value.`ref`), value.`ref`)))

proc `$`*(value: Recursive_mergeColumnItems): string =
  stringify(Recursive_mergeColumnItems, value)

proc fromJsonHook*(target: var Recursive_mergeColumnItems; source: JsonNode) =
  assert(hasKey(source, "ref"),
         "ref" & " is missing while decoding " & "Recursive_mergeColumnItems")
  target.`ref` = jsonTo(source{"ref"}, typeof(target.`ref`))

proc toJsonHook*(source: Recursive_mergeColumnItems): JsonNode =
  result = newJObject()
  result{"ref"} = newJString(source.`ref`)

proc toStream*(source: Recursive_mergeColumnItems; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("ref"))
  write(target, ':')
  toStream(source.`ref`, target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_mergeColumnItems];
                 source: var JsonParser): Recursive_mergeColumnItems =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "ref":
      result.`ref` = fromStream(typeof(result.`ref`), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

converter forRecursive_mergeItems*(value: Recursive_mergeColumnItems): Recursive_mergeItems =
  return Recursive_mergeItems(kind: 0, key0: value)

proc equals(_: typedesc[Recursive_mergeAnon]; a, b: Recursive_mergeAnon): bool =
  equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.`ref`), a.`ref`, b.`ref`) and
      equals(typeof(a.items), a.items, b.items)

proc `==`*(a, b: Recursive_mergeAnon): bool =
  return equals(Recursive_mergeAnon, a, b)

proc stringify(_: typedesc[Recursive_mergeAnon]; value: Recursive_mergeAnon): string =
  stringifyObj("Recursive_mergeAnon",
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("ref", stringify(typeof(value.`ref`), value.`ref`)),
               ("items", stringify(typeof(value.items), value.items)))

proc `$`*(value: Recursive_mergeAnon): string =
  stringify(Recursive_mergeAnon, value)

proc fromJsonHook*(target: var Recursive_mergeAnon; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "Recursive_mergeAnon")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  if hasKey(source, "ref") and source{"ref"}.kind != JNull:
    target.`ref` = some(jsonTo(source{"ref"}, typeof(unsafeGet(target.`ref`))))
  if hasKey(source, "items") and source{"items"}.kind != JNull:
    target.items = some(jsonTo(source{"items"}, typeof(unsafeGet(target.items))))

proc toJsonHook*(source: Recursive_mergeAnon): JsonNode =
  result = newJObject()
  result{"type"} = newJString(source.`type`)
  if isSome(source.`ref`):
    result{"ref"} = newJString(unsafeGet(source.`ref`))
  if isSome(source.items):
    result{"items"} = toJsonHook(unsafeGet(source.items))

proc toStream*(source: Recursive_mergeAnon; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("type"))
  write(target, ':')
  toStream(source.`type`, target)
  if isSome(source.`ref`):
    hasEmitted.writeComma(target)
    write(target, escapeJson("ref"))
    write(target, ':')
    toStream(unsafeGet(source.`ref`), target)
  if isSome(source.items):
    hasEmitted.writeComma(target)
    write(target, escapeJson("items"))
    write(target, ':')
    toStream(unsafeGet(source.items), target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_mergeAnon];
                 source: var JsonParser): Recursive_mergeAnon =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "type":
      result.`type` = fromStream(typeof(result.`type`), source)
      seen.incl(0)
    of "ref":
      result.`ref` = some(fromStream(typeof(unsafeGet(result.`ref`)), source))
    of "items":
      result.items = some(fromStream(typeof(unsafeGet(result.items)), source))
    else:
      skipValue(source)
  assert(card(seen) == 1)

converter forRecursive_mergeDataType*(value: Recursive_mergeAnon): Recursive_mergeDataType =
  return Recursive_mergeDataType(kind: 0, key0: value)

proc equals(_: typedesc[Recursive_mergeAnon2]; a, b: Recursive_mergeAnon2): bool =
  equals(typeof(a.`ref`), a.`ref`, b.`ref`) and
      equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.items), a.items, b.items)

proc `==`*(a, b: Recursive_mergeAnon2): bool =
  return equals(Recursive_mergeAnon2, a, b)

proc stringify(_: typedesc[Recursive_mergeAnon2]; value: Recursive_mergeAnon2): string =
  stringifyObj("Recursive_mergeAnon2",
               ("ref", stringify(typeof(value.`ref`), value.`ref`)),
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("items", stringify(typeof(value.items), value.items)))

proc `$`*(value: Recursive_mergeAnon2): string =
  stringify(Recursive_mergeAnon2, value)

proc fromJsonHook*(target: var Recursive_mergeAnon2; source: JsonNode) =
  assert(hasKey(source, "ref"),
         "ref" & " is missing while decoding " & "Recursive_mergeAnon2")
  target.`ref` = jsonTo(source{"ref"}, typeof(target.`ref`))
  if hasKey(source, "type") and source{"type"}.kind != JNull:
    target.`type` = some(jsonTo(source{"type"}, typeof(unsafeGet(target.`type`))))
  if hasKey(source, "items") and source{"items"}.kind != JNull:
    target.items = some(jsonTo(source{"items"}, typeof(unsafeGet(target.items))))

proc toJsonHook*(source: Recursive_mergeAnon2): JsonNode =
  result = newJObject()
  result{"ref"} = newJString(source.`ref`)
  if isSome(source.`type`):
    result{"type"} = newJString(unsafeGet(source.`type`))
  if isSome(source.items):
    result{"items"} = toJsonHook(unsafeGet(source.items))

proc toStream*(source: Recursive_mergeAnon2; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("ref"))
  write(target, ':')
  toStream(source.`ref`, target)
  if isSome(source.`type`):
    hasEmitted.writeComma(target)
    write(target, escapeJson("type"))
    write(target, ':')
    toStream(unsafeGet(source.`type`), target)
  if isSome(source.items):
    hasEmitted.writeComma(target)
    write(target, escapeJson("items"))
    write(target, ':')
    toStream(unsafeGet(source.items), target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_mergeAnon2];
                 source: var JsonParser): Recursive_mergeAnon2 =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "ref":
      result.`ref` = fromStream(typeof(result.`ref`), source)
      seen.incl(0)
    of "type":
      result.`type` = some(fromStream(typeof(unsafeGet(result.`type`)), source))
    of "items":
      result.items = some(fromStream(typeof(unsafeGet(result.items)), source))
    else:
      skipValue(source)
  assert(card(seen) == 1)

converter forRecursive_mergeDataType*(value: Recursive_mergeAnon2): Recursive_mergeDataType =
  return Recursive_mergeDataType(kind: 1, key1: value)

proc equals(_: typedesc[Recursive_mergeDataType]; a, b: Recursive_mergeDataType): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Recursive_mergeDataType): bool =
  return equals(Recursive_mergeDataType, a, b)

proc stringify(_: typedesc[Recursive_mergeDataType];
               value: Recursive_mergeDataType): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Recursive_mergeDataType): string =
  stringify(Recursive_mergeDataType, value)

proc fromJsonHook*(target: var Recursive_mergeDataType; source: JsonNode) =
  if source.kind == JObject and hasKey(source, "type"):
    target = Recursive_mergeDataType(kind: 0,
                                     key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject and hasKey(source, "ref"):
    target = Recursive_mergeDataType(kind: 1,
                                     key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to Recursive_mergeDataType")
  
proc toJsonHook*(source: Recursive_mergeDataType): JsonNode =
  case source.kind
  of 0:
    toJsonHook(source.key0)
  of 1:
    toJsonHook(source.key1)
  
proc isObject*(value: Recursive_mergeDataType): bool =
  value.kind == 0

proc asObject*(value: Recursive_mergeDataType): typeof(
    value.key0) =
  assert(value.kind == 0)
  return value.key0

proc toBinary*(target: var string; source: Recursive_mergeDataType) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Recursive_mergeDataType]; source: string;
                idx: var int): Recursive_mergeDataType =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Recursive_mergeDataType(kind: 0, key0: fromBinary(
        typeof(result.key0), source, idx))
  of 1:
    return Recursive_mergeDataType(kind: 1, key1: fromBinary(
        typeof(result.key1), source, idx))
  
proc toStream*(source: Recursive_mergeDataType; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Recursive_mergeDataType];
                 source: var JsonParser): Recursive_mergeDataType =
  jsonTo(fromStream(JsonNode, source), Recursive_mergeDataType)

proc forRecursive_mergeItems*(value: ref Recursive_mergeDataType): Recursive_mergeItems =
  return Recursive_mergeItems(kind: 1, key1: value)

proc equals(_: typedesc[Recursive_mergeItems]; a, b: Recursive_mergeItems): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Recursive_mergeItems): bool =
  return equals(Recursive_mergeItems, a, b)

proc stringify(_: typedesc[Recursive_mergeItems]; value: Recursive_mergeItems): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Recursive_mergeItems): string =
  stringify(Recursive_mergeItems, value)

proc fromJsonHook*(target: var Recursive_mergeItems; source: JsonNode) =
  if source.kind == JObject and hasKey(source, "ref"):
    target = Recursive_mergeItems(kind: 0,
                                  key0: jsonTo(source, typeof(target.key0)))
  elif false or source.kind == JObject and hasKey(source, "type") or
      source.kind == JObject and hasKey(source, "ref"):
    target = Recursive_mergeItems(kind: 1,
                                  key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to Recursive_mergeItems")
  
proc toJsonHook*(source: Recursive_mergeItems): JsonNode =
  case source.kind
  of 0:
    toJsonHook(source.key0)
  of 1:
    toJson(source.key1)
  
proc isObject*(value: Recursive_mergeItems): bool =
  value.kind == 0

proc asObject*(value: Recursive_mergeItems): typeof(
    value.key0) =
  assert(value.kind == 0)
  return value.key0

proc isdataType*(value: Recursive_mergeItems): bool =
  value.kind == 1

proc asdataType*(value: Recursive_mergeItems): typeof(
    value.key1) =
  assert(value.kind == 1)
  return value.key1

proc toBinary*(target: var string; source: Recursive_mergeItems) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Recursive_mergeItems]; source: string; idx: var int): Recursive_mergeItems =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Recursive_mergeItems(kind: 0, key0: fromBinary(typeof(result.key0),
        source, idx))
  of 1:
    return Recursive_mergeItems(kind: 1, key1: fromBinary(typeof(result.key1),
        source, idx))
  
proc toStream*(source: Recursive_mergeItems; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Recursive_mergeItems];
                 source: var JsonParser): Recursive_mergeItems =
  jsonTo(fromStream(JsonNode, source), Recursive_mergeItems)

proc equals(_: typedesc[Recursive_mergeColumn]; a, b: Recursive_mergeColumn): bool =
  equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.`ref`), a.`ref`, b.`ref`) and
      equals(typeof(a.items), a.items, b.items) and
      equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: Recursive_mergeColumn): bool =
  return equals(Recursive_mergeColumn, a, b)

proc stringify(_: typedesc[Recursive_mergeColumn]; value: Recursive_mergeColumn): string =
  stringifyObj("Recursive_mergeColumn",
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("ref", stringify(typeof(value.`ref`), value.`ref`)),
               ("items", stringify(typeof(value.items), value.items)),
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: Recursive_mergeColumn): string =
  stringify(Recursive_mergeColumn, value)

proc fromJsonHook*(target: var Recursive_mergeColumn; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "Recursive_mergeColumn")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  if hasKey(source, "ref") and source{"ref"}.kind != JNull:
    target.`ref` = some(jsonTo(source{"ref"}, typeof(unsafeGet(target.`ref`))))
  if hasKey(source, "items") and source{"items"}.kind != JNull:
    target.items = some(jsonTo(source{"items"}, typeof(unsafeGet(target.items))))
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Recursive_mergeColumn")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: Recursive_mergeColumn): JsonNode =
  result = newJObject()
  result{"type"} = newJString(source.`type`)
  if isSome(source.`ref`):
    result{"ref"} = newJString(unsafeGet(source.`ref`))
  if isSome(source.items):
    result{"items"} = toJsonHook(unsafeGet(source.items))
  result{"name"} = newJString(source.name)

proc toStream*(source: Recursive_mergeColumn; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("type"))
  write(target, ':')
  toStream(source.`type`, target)
  if isSome(source.`ref`):
    hasEmitted.writeComma(target)
    write(target, escapeJson("ref"))
    write(target, ':')
    toStream(unsafeGet(source.`ref`), target)
  if isSome(source.items):
    hasEmitted.writeComma(target)
    write(target, escapeJson("items"))
    write(target, ':')
    toStream(unsafeGet(source.items), target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_mergeColumn];
                 source: var JsonParser): Recursive_mergeColumn =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "type":
      result.`type` = fromStream(typeof(result.`type`), source)
      seen.incl(0)
    of "ref":
      result.`ref` = some(fromStream(typeof(unsafeGet(result.`ref`)), source))
    of "items":
      result.items = some(fromStream(typeof(unsafeGet(result.items)), source))
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

converter forRecursive_mergeUnion*(value: Recursive_mergeColumn): Recursive_mergeUnion =
  return Recursive_mergeUnion(kind: 0, key0: value)

proc equals(_: typedesc[Recursive_mergeColumn2]; a, b: Recursive_mergeColumn2): bool =
  equals(typeof(a.`ref`), a.`ref`, b.`ref`) and
      equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.items), a.items, b.items) and
      equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: Recursive_mergeColumn2): bool =
  return equals(Recursive_mergeColumn2, a, b)

proc stringify(_: typedesc[Recursive_mergeColumn2];
               value: Recursive_mergeColumn2): string =
  stringifyObj("Recursive_mergeColumn2",
               ("ref", stringify(typeof(value.`ref`), value.`ref`)),
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("items", stringify(typeof(value.items), value.items)),
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: Recursive_mergeColumn2): string =
  stringify(Recursive_mergeColumn2, value)

proc fromJsonHook*(target: var Recursive_mergeColumn2; source: JsonNode) =
  assert(hasKey(source, "ref"),
         "ref" & " is missing while decoding " & "Recursive_mergeColumn2")
  target.`ref` = jsonTo(source{"ref"}, typeof(target.`ref`))
  if hasKey(source, "type") and source{"type"}.kind != JNull:
    target.`type` = some(jsonTo(source{"type"}, typeof(unsafeGet(target.`type`))))
  if hasKey(source, "items") and source{"items"}.kind != JNull:
    target.items = some(jsonTo(source{"items"}, typeof(unsafeGet(target.items))))
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Recursive_mergeColumn2")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: Recursive_mergeColumn2): JsonNode =
  result = newJObject()
  result{"ref"} = newJString(source.`ref`)
  if isSome(source.`type`):
    result{"type"} = newJString(unsafeGet(source.`type`))
  if isSome(source.items):
    result{"items"} = toJsonHook(unsafeGet(source.items))
  result{"name"} = newJString(source.name)

proc toStream*(source: Recursive_mergeColumn2; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("ref"))
  write(target, ':')
  toStream(source.`ref`, target)
  if isSome(source.`type`):
    hasEmitted.writeComma(target)
    write(target, escapeJson("type"))
    write(target, ':')
    toStream(unsafeGet(source.`type`), target)
  if isSome(source.items):
    hasEmitted.writeComma(target)
    write(target, escapeJson("items"))
    write(target, ':')
    toStream(unsafeGet(source.items), target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_mergeColumn2];
                 source: var JsonParser): Recursive_mergeColumn2 =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "ref":
      result.`ref` = fromStream(typeof(result.`ref`), source)
      seen.incl(0)
    of "type":
      result.`type` = some(fromStream(typeof(unsafeGet(result.`type`)), source))
    of "items":
      result.items = some(fromStream(typeof(unsafeGet(result.items)), source))
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

converter forRecursive_mergeUnion*(value: Recursive_mergeColumn2): Recursive_mergeUnion =
  return Recursive_mergeUnion(kind: 1, key1: value)

proc equals(_: typedesc[Recursive_mergeUnion]; a, b: Recursive_mergeUnion): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: Recursive_mergeUnion): bool =
  return equals(Recursive_mergeUnion, a, b)

proc stringify(_: typedesc[Recursive_mergeUnion]; value: Recursive_mergeUnion): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: Recursive_mergeUnion): string =
  stringify(Recursive_mergeUnion, value)

proc fromJsonHook*(target: var Recursive_mergeUnion; source: JsonNode) =
  if source.kind == JObject and hasKey(source, "type") and
      hasKey(source, "name"):
    target = Recursive_mergeUnion(kind: 0,
                                  key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject and hasKey(source, "ref") and
      hasKey(source, "name"):
    target = Recursive_mergeUnion(kind: 1,
                                  key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to Recursive_mergeUnion")
  
proc toJsonHook*(source: Recursive_mergeUnion): JsonNode =
  case source.kind
  of 0:
    toJsonHook(source.key0)
  of 1:
    toJsonHook(source.key1)
  
proc isObject*(value: Recursive_mergeUnion): bool =
  value.kind == 0

proc asObject*(value: Recursive_mergeUnion): typeof(
    value.key0) =
  assert(value.kind == 0)
  return value.key0

proc toBinary*(target: var string; source: Recursive_mergeUnion) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[Recursive_mergeUnion]; source: string; idx: var int): Recursive_mergeUnion =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return Recursive_mergeUnion(kind: 0, key0: fromBinary(typeof(result.key0),
        source, idx))
  of 1:
    return Recursive_mergeUnion(kind: 1, key1: fromBinary(typeof(result.key1),
        source, idx))
  
proc toStream*(source: Recursive_mergeUnion; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[Recursive_mergeUnion];
                 source: var JsonParser): Recursive_mergeUnion =
  jsonTo(fromStream(JsonNode, source), Recursive_mergeUnion)

proc equals(_: typedesc[Recursive_merge]; a, b: Recursive_merge): bool =
  equals(typeof(a.column), a.column, b.column)

proc `==`*(a, b: Recursive_merge): bool =
  return equals(Recursive_merge, a, b)

proc stringify(_: typedesc[Recursive_merge]; value: Recursive_merge): string =
  stringifyObj("Recursive_merge",
               ("column", stringify(typeof(value.column), value.column)))

proc `$`*(value: Recursive_merge): string =
  stringify(Recursive_merge, value)

proc fromJsonHook*(target: var Recursive_merge; source: JsonNode) =
  if hasKey(source, "column") and source{"column"}.kind != JNull:
    target.column = some(jsonTo(source{"column"},
                                typeof(unsafeGet(target.column))))

proc toJsonHook*(source: Recursive_merge): JsonNode =
  result = newJObject()
  if isSome(source.column):
    result{"column"} = toJsonHook(unsafeGet(source.column))

proc toStream*(source: Recursive_merge; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.column):
    hasEmitted.writeComma(target)
    write(target, escapeJson("column"))
    write(target, ':')
    toStream(unsafeGet(source.column), target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_merge];
                 source: var JsonParser): Recursive_merge =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "column":
      result.column = some(fromStream(typeof(unsafeGet(result.column)), source))
    else:
      skipValue(source)
  assert(card(seen) == 0)

{.pop.}
