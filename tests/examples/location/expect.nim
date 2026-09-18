{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/validate as jsonSchemaValidate
import json_schema_import/private/[equality, bin, sax, empty]

type
  Location* {.byref.} = object
    latitude*: BiggestFloat
    longitude*: BiggestFloat
proc `=copy`(a: var Location; b: Location) {.error.}
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

proc validate*(_: typedesc[Location]; value: Location; path: string = "Location") =
  if not (satisfiesMinimum(value.latitude, -90.0'f64)):
    invalid(path & "/" & "latitude", "minimum: -90")
  if not (satisfiesMaximum(value.latitude, 90.0'f64)):
    invalid(path & "/" & "latitude", "maximum: 90")
  if not (satisfiesMinimum(value.longitude, -180.0'f64)):
    invalid(path & "/" & "longitude", "minimum: -180")
  if not (satisfiesMaximum(value.longitude, 180.0'f64)):
    invalid(path & "/" & "longitude", "maximum: 180")

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

proc toStream*(source: Location; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("latitude"))
  write(target, ':')
  toStream(source.latitude, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("longitude"))
  write(target, ':')
  toStream(source.longitude, target)
  target.write('}')

proc fromStream*(typ: typedesc[Location]; source: var JsonParser): Location =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "latitude":
      result.latitude = fromStream(typeof(result.latitude), source)
      seen.incl(0)
    of "longitude":
      result.longitude = fromStream(typeof(result.longitude), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

{.pop.}
