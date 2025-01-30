{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  Addressaddress* = object
    postOfficeBox*: Option[string]
    extendedAddress*: Option[string]
    streetAddress*: Option[string]
    locality*: string
    region*: string
    postalCode*: Option[string]
    countryName*: string
proc toJsonHook*(source: Addressaddress): JsonNode
proc fromJsonHook*(target: var Addressaddress; source: JsonNode) =
  if hasKey(source, "postOfficeBox") and
      source{"postOfficeBox"}.kind != JNull:
    target.postOfficeBox = some(jsonTo(source{"postOfficeBox"},
                                       typeof(unsafeGet(target.postOfficeBox))))
  if hasKey(source, "extendedAddress") and
      source{"extendedAddress"}.kind != JNull:
    target.extendedAddress = some(jsonTo(source{"extendedAddress"},
        typeof(unsafeGet(target.extendedAddress))))
  if hasKey(source, "streetAddress") and
      source{"streetAddress"}.kind != JNull:
    target.streetAddress = some(jsonTo(source{"streetAddress"},
                                       typeof(unsafeGet(target.streetAddress))))
  assert(hasKey(source, "locality"),
         "locality" & " is missing while decoding " & "Addressaddress")
  target.locality = jsonTo(source{"locality"}, typeof(target.locality))
  assert(hasKey(source, "region"),
         "region" & " is missing while decoding " & "Addressaddress")
  target.region = jsonTo(source{"region"}, typeof(target.region))
  if hasKey(source, "postalCode") and source{"postalCode"}.kind != JNull:
    target.postalCode = some(jsonTo(source{"postalCode"},
                                    typeof(unsafeGet(target.postalCode))))
  assert(hasKey(source, "countryName"),
         "countryName" & " is missing while decoding " & "Addressaddress")
  target.countryName = jsonTo(source{"countryName"}, typeof(target.countryName))

proc toJsonHook*(source: Addressaddress): JsonNode =
  result = newJObject()
  if isSome(source.postOfficeBox):
    result{"postOfficeBox"} = newJString(unsafeGet(source.postOfficeBox))
  if isSome(source.extendedAddress):
    result{"extendedAddress"} = newJString(unsafeGet(source.extendedAddress))
  if isSome(source.streetAddress):
    result{"streetAddress"} = newJString(unsafeGet(source.streetAddress))
  result{"locality"} = newJString(source.locality)
  result{"region"} = newJString(source.region)
  if isSome(source.postalCode):
    result{"postalCode"} = newJString(unsafeGet(source.postalCode))
  result{"countryName"} = newJString(source.countryName)
{.pop.}
