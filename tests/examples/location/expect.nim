{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  Locationlocation* = object
    latitude*: BiggestFloat
    longitude*: BiggestFloat
proc toJsonHook*(source: Locationlocation): JsonNode
proc equals(_: typedesc[Locationlocation]; a, b: Locationlocation): bool =
  equals(typeof(a.latitude), a.latitude, b.latitude) and
      equals(typeof(a.longitude), a.longitude, b.longitude)

proc `==`*(a, b: Locationlocation): bool =
  return equals(Locationlocation, a, b)

proc stringify(_: typedesc[Locationlocation]; value: Locationlocation): string =
  stringifyObj("Locationlocation", ("latitude", stringify(
      typeof(value.latitude), value.latitude)), ("longitude",
      stringify(typeof(value.longitude), value.longitude)))

proc `$`*(value: Locationlocation): string =
  stringify(Locationlocation, value)

proc fromJsonHook*(target: var Locationlocation; source: JsonNode) =
  assert(hasKey(source, "latitude"),
         "latitude" & " is missing while decoding " & "Locationlocation")
  target.latitude = jsonTo(source{"latitude"}, typeof(target.latitude))
  assert(hasKey(source, "longitude"),
         "longitude" & " is missing while decoding " & "Locationlocation")
  target.longitude = jsonTo(source{"longitude"}, typeof(target.longitude))

proc toJsonHook*(source: Locationlocation): JsonNode =
  result = newJObject()
  result{"latitude"} = newJFloat(source.latitude)
  result{"longitude"} = newJFloat(source.longitude)

proc toBinary*(target: var string; source: Locationlocation) =
  toBinary(target, source.latitude)
  toBinary(target, source.longitude)

proc toBinary*(source: Locationlocation): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[Locationlocation]; source: string; idx: var int): Locationlocation =
  result.latitude = fromBinary(typeof(result.latitude), source, idx)
  result.longitude = fromBinary(typeof(result.longitude), source, idx)

proc fromBinary*(_: typedesc[Locationlocation]; source: string): Locationlocation =
  var idx = 0
  return fromBinary(Locationlocation, source, idx)
{.pop.}
