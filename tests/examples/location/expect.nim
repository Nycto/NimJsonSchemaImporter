{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  Location* = object
    latitude*: BiggestFloat
    longitude*: BiggestFloat
proc `=copy`(a: var Location; b: Location) {.error.}
proc toJsonHook*(source: Location): JsonNode
proc equals(_: typedesc[Location]; a, b: Location): bool =
  equals(typeof(a.latitude), a.latitude, b.latitude) and
      equals(typeof(a.longitude), a.longitude, b.longitude)

proc `==`*(a, b: Location): bool =
  return equals(Location, a, b)

proc stringify(_: typedesc[Location]; value: Location): string =
  stringifyObj("Location", ("latitude",
                            stringify(typeof(value.latitude), value.latitude)), (
      "longitude", stringify(typeof(value.longitude), value.longitude)))

proc `$`*(value: Location): string =
  stringify(Location, value)

proc fromJsonHook*(target: var Location; source: JsonNode) =
  assert(hasKey(source, "latitude"),
         "latitude" & " is missing while decoding " & "Location")
  target.latitude = jsonTo(source{"latitude"}, typeof(target.latitude))
  assert(hasKey(source, "longitude"),
         "longitude" & " is missing while decoding " & "Location")
  target.longitude = jsonTo(source{"longitude"}, typeof(target.longitude))

proc toJsonHook*(source: Location): JsonNode =
  result = newJObject()
  result{"latitude"} = newJFloat(source.latitude)
  result{"longitude"} = newJFloat(source.longitude)
{.pop.}
