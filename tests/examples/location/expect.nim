{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify

type
  Locationlocation* = object
    latitude*: BiggestFloat
    longitude*: BiggestFloat
proc toJsonHook*(source: Locationlocation): JsonNode
proc `==`*(a, b: Locationlocation): bool =
  true and a.latitude == b.latitude and a.longitude == b.longitude

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
{.pop.}
