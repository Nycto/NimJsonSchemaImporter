{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  Testaddress* = object
    streetAddress*: Option[string]
    region*: string
    locality*: string
    countryName*: string
    postOfficeBox*: Option[string]
    extendedAddress*: Option[string]
    postalCode*: Option[string]
proc fromJsonHook*(target: var Testaddress; source: JsonNode) =
  if "streetAddress" in source and source{"streetAddress"}.kind != JNull:
    target.streetAddress = some(jsonTo(source{"streetAddress"},
                                       typeof(unsafeGet(target.streetAddress))))
  assert("region" in source,
         "region" & " is missing while decoding " & "Testaddress")
  target.region = jsonTo(source{"region"}, typeof(target.region))
  assert("locality" in source,
         "locality" & " is missing while decoding " & "Testaddress")
  target.locality = jsonTo(source{"locality"}, typeof(target.locality))
  assert("countryName" in source,
         "countryName" & " is missing while decoding " & "Testaddress")
  target.countryName = jsonTo(source{"countryName"}, typeof(target.countryName))
  if "postOfficeBox" in source and source{"postOfficeBox"}.kind != JNull:
    target.postOfficeBox = some(jsonTo(source{"postOfficeBox"},
                                       typeof(unsafeGet(target.postOfficeBox))))
  if "extendedAddress" in source and source{"extendedAddress"}.kind != JNull:
    target.extendedAddress = some(jsonTo(source{"extendedAddress"},
        typeof(unsafeGet(target.extendedAddress))))
  if "postalCode" in source and source{"postalCode"}.kind != JNull:
    target.postalCode = some(jsonTo(source{"postalCode"},
                                    typeof(unsafeGet(target.postalCode))))

proc toJsonHook*(source: Testaddress): JsonNode =
  result = newJObject()
  if isSome(source.streetAddress):
    result{"streetAddress"} = toJson(source.streetAddress)
  result{"region"} = toJson(source.region)
  result{"locality"} = toJson(source.locality)
  result{"countryName"} = toJson(source.countryName)
  if isSome(source.postOfficeBox):
    result{"postOfficeBox"} = toJson(source.postOfficeBox)
  if isSome(source.extendedAddress):
    result{"extendedAddress"} = toJson(source.extendedAddress)
  if isSome(source.postalCode):
    result{"postalCode"} = toJson(source.postalCode)
