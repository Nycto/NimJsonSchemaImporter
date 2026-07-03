{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin, sax]

type
  Address* {.byref.} = object
    postOfficeBox*: Option[string]
    extendedAddress*: Option[string]
    streetAddress*: Option[string]
    locality*: string
    region*: string
    postalCode*: Option[string]
    countryName*: string
proc `=copy`(a: var Address; b: Address) {.error.}
proc toJsonHook*(source: Address): JsonNode
proc equals(_: typedesc[Address]; a, b: Address): bool =
  equals(typeof(a.postOfficeBox), a.postOfficeBox, b.postOfficeBox) and
      equals(typeof(a.extendedAddress), a.extendedAddress, b.extendedAddress) and
      equals(typeof(a.streetAddress), a.streetAddress, b.streetAddress) and
      equals(typeof(a.locality), a.locality, b.locality) and
      equals(typeof(a.region), a.region, b.region) and
      equals(typeof(a.postalCode), a.postalCode, b.postalCode) and
      equals(typeof(a.countryName), a.countryName, b.countryName)

proc `==`*(a, b: Address): bool =
  return equals(Address, a, b)

proc stringify(_: typedesc[Address]; value: Address): string =
  stringifyObj("Address", ("postOfficeBox", stringify(
      typeof(value.postOfficeBox), value.postOfficeBox)), ("extendedAddress",
      stringify(typeof(value.extendedAddress), value.extendedAddress)), (
      "streetAddress",
      stringify(typeof(value.streetAddress), value.streetAddress)), ("locality",
      stringify(typeof(value.locality), value.locality)),
               ("region", stringify(typeof(value.region), value.region)), (
      "postalCode", stringify(typeof(value.postalCode), value.postalCode)), (
      "countryName", stringify(typeof(value.countryName), value.countryName)))

proc `$`*(value: Address): string =
  stringify(Address, value)

proc fromJsonHook*(target: var Address; source: JsonNode) =
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
         "locality" & " is missing while decoding " & "Address")
  target.locality = jsonTo(source{"locality"}, typeof(target.locality))
  assert(hasKey(source, "region"),
         "region" & " is missing while decoding " & "Address")
  target.region = jsonTo(source{"region"}, typeof(target.region))
  if hasKey(source, "postalCode") and source{"postalCode"}.kind != JNull:
    target.postalCode = some(jsonTo(source{"postalCode"},
                                    typeof(unsafeGet(target.postalCode))))
  assert(hasKey(source, "countryName"),
         "countryName" & " is missing while decoding " & "Address")
  target.countryName = jsonTo(source{"countryName"}, typeof(target.countryName))

proc toJsonHook*(source: Address): JsonNode =
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

proc toStream*(source: Address; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.postOfficeBox):
    hasEmitted.writeComma(target)
    write(target, escapeJson("postOfficeBox"))
    write(target, ':')
    toStream(unsafeGet(source.postOfficeBox), target)
  if isSome(source.extendedAddress):
    hasEmitted.writeComma(target)
    write(target, escapeJson("extendedAddress"))
    write(target, ':')
    toStream(unsafeGet(source.extendedAddress), target)
  if isSome(source.streetAddress):
    hasEmitted.writeComma(target)
    write(target, escapeJson("streetAddress"))
    write(target, ':')
    toStream(unsafeGet(source.streetAddress), target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("locality"))
  write(target, ':')
  toStream(source.locality, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("region"))
  write(target, ':')
  toStream(source.region, target)
  if isSome(source.postalCode):
    hasEmitted.writeComma(target)
    write(target, escapeJson("postalCode"))
    write(target, ':')
    toStream(unsafeGet(source.postalCode), target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("countryName"))
  write(target, ':')
  toStream(source.countryName, target)
  target.write('}')

proc fromStream*(typ: typedesc[Address]; source: var JsonParser): Address =
  var seen: set[0 .. 2]
  for key in objectKeys(source):
    case key
    of "postOfficeBox":
      result.postOfficeBox = some(fromStream(
          typeof(unsafeGet(result.postOfficeBox)), source))
    of "extendedAddress":
      result.extendedAddress = some(fromStream(
          typeof(unsafeGet(result.extendedAddress)), source))
    of "streetAddress":
      result.streetAddress = some(fromStream(
          typeof(unsafeGet(result.streetAddress)), source))
    of "locality":
      result.locality = fromStream(typeof(result.locality), source)
      seen.incl(0)
    of "region":
      result.region = fromStream(typeof(result.region), source)
      seen.incl(1)
    of "postalCode":
      result.postalCode = some(fromStream(typeof(unsafeGet(result.postalCode)),
          source))
    of "countryName":
      result.countryName = fromStream(typeof(result.countryName), source)
      seen.incl(2)
    else:
      skipValue(source)
  assert(card(seen) == 3)
{.pop.}
