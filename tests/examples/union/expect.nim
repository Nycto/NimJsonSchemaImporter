{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `TestTestunion_key33`* = enum
    `B`, `C`, `A`
  `TestTestunion_key3Union`* = object
    case kind*: range[0 .. 4]
    of 0:
      key0*: `TestTestunion_key30`
    of 1:
      key1*: seq[string]
    of 2:
      key2*: Table[string, string]
    of 3:
      key3*: `TestTestunion_key33`
    of 4:
      key4*: Option[string]
  `TestTestunion_key1Union`* = object
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
  `TestTestunion_key30`* = object
    `foo`*: Option[string]
  `Testunion`* = object
    `key1`*: Option[`TestTestunion_key1Union`]
    `key2`*: Option[string]
    `key3`*: Option[`TestTestunion_key3Union`]
proc fromJsonHook*(target: var `TestTestunion_key1Union`; source: JsonNode) =
  if source.kind == JString:
    target = `TestTestunion_key1Union`(kind: 0, key0: jsonTo(source,
        typeof(target.key0)))
  elif source.kind == JInt:
    target = `TestTestunion_key1Union`(kind: 1, key1: jsonTo(source,
        typeof(target.key1)))
  elif source.kind == JBool:
    target = `TestTestunion_key1Union`(kind: 2, key2: jsonTo(source,
        typeof(target.key2)))
  elif source.kind == JNull:
    target = `TestTestunion_key1Union`(kind: 3, key3: jsonTo(source,
        typeof(target.key3)))
  elif source.kind == JFloat or source.kind == JInt:
    target = `TestTestunion_key1Union`(kind: 4, key4: jsonTo(source,
        typeof(target.key4)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to TestTestunion_key1Union")
  
proc toJsonHook*(source: `TestTestunion_key1Union`): JsonNode =
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
  
proc toJsonHook*(source: `TestTestunion_key33`): JsonNode =
  case source
  of `TestTestunion_key33`.`B`:
    return newJString("b")
  of `TestTestunion_key33`.`C`:
    return newJString("c")
  of `TestTestunion_key33`.`A`:
    return newJString("a")
  
proc fromJsonHook*(target: var `TestTestunion_key3Union`; source: JsonNode) =
  if source.kind == JObject:
    target = `TestTestunion_key3Union`(kind: 0, key0: jsonTo(source,
        typeof(target.key0)))
  elif source.kind == JArray:
    target = `TestTestunion_key3Union`(kind: 1, key1: jsonTo(source,
        typeof(target.key1)))
  elif source.kind == JObject:
    target = `TestTestunion_key3Union`(kind: 2, key2: jsonTo(source,
        typeof(target.key2)))
  elif source.kind == JString:
    target = `TestTestunion_key3Union`(kind: 3, key3: jsonTo(source,
        typeof(target.key3)))
  elif source.kind == JString:
    target = `TestTestunion_key3Union`(kind: 4, key4: jsonTo(source,
        typeof(target.key4)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to TestTestunion_key3Union")
  
proc toJsonHook*(source: `TestTestunion_key3Union`): JsonNode =
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
  