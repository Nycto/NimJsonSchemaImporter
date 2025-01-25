{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  Locationlocation* = object
    latitude*: BiggestFloat
    longitude*: BiggestFloat
proc toJsonHook*(source: Locationlocation): JsonNode
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
