{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testlocation`* = object
    `latitude`*: BiggestFloat
    `longitude`*: BiggestFloat
proc fromJsonHook*(target: var `Testlocation`; source: JsonNode) =
  assert("latitude" in source,
         "latitude" & " is missing while decoding " & "Testlocation")
  target.`latitude` = jsonTo(source{"latitude"}, typeof(target.`latitude`))
  assert("longitude" in source,
         "longitude" & " is missing while decoding " & "Testlocation")
  target.`longitude` = jsonTo(source{"longitude"}, typeof(target.`longitude`))

proc toJsonHook*(source: `Testlocation`): JsonNode =
  result = newJObject()
  result{"latitude"} = toJson(source.`latitude`)
  result{"longitude"} = toJson(source.`longitude`)
