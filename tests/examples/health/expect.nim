{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  HealthEmergencyContact* = object
    username*: Option[string]
    email*: Option[string]
  Healthhealth* = object
    patientName*: string
    dateOfBirth*: string
    bloodType*: string
    allergies*: Option[seq[string]]
    conditions*: Option[seq[string]]
    medications*: Option[seq[string]]
    emergencyContact*: Option[HealthEmergencyContact]
proc toJsonHook*(source: HealthEmergencyContact): JsonNode
proc toJsonHook*(source: Healthhealth): JsonNode
proc equals(_: typedesc[HealthEmergencyContact]; a, b: HealthEmergencyContact): bool =
  equals(typeof(a.username), a.username, b.username) and
      equals(typeof(a.email), a.email, b.email)

proc `==`*(a, b: HealthEmergencyContact): bool =
  return equals(HealthEmergencyContact, a, b)

proc stringify(_: typedesc[HealthEmergencyContact];
               value: HealthEmergencyContact): string =
  stringifyObj("HealthEmergencyContact", ("username",
      stringify(typeof(value.username), value.username)),
               ("email", stringify(typeof(value.email), value.email)))

proc `$`*(value: HealthEmergencyContact): string =
  stringify(HealthEmergencyContact, value)

proc fromJsonHook*(target: var HealthEmergencyContact; source: JsonNode) =
  if hasKey(source, "username") and source{"username"}.kind != JNull:
    target.username = some(jsonTo(source{"username"},
                                  typeof(unsafeGet(target.username))))
  if hasKey(source, "email") and source{"email"}.kind != JNull:
    target.email = some(jsonTo(source{"email"}, typeof(unsafeGet(target.email))))

proc toJsonHook*(source: HealthEmergencyContact): JsonNode =
  result = newJObject()
  if isSome(source.username):
    result{"username"} = newJString(unsafeGet(source.username))
  if isSome(source.email):
    result{"email"} = newJString(unsafeGet(source.email))

proc toBinary*(target: var string; source: HealthEmergencyContact) =
  toBinary(target, source.username)
  toBinary(target, source.email)

proc fromBinary(_: typedesc[HealthEmergencyContact]; source: string;
                idx: var int): HealthEmergencyContact =
  result.username = fromBinary(typeof(result.username), source, idx)
  result.email = fromBinary(typeof(result.email), source, idx)

proc equals(_: typedesc[Healthhealth]; a, b: Healthhealth): bool =
  equals(typeof(a.patientName), a.patientName, b.patientName) and
      equals(typeof(a.dateOfBirth), a.dateOfBirth, b.dateOfBirth) and
      equals(typeof(a.bloodType), a.bloodType, b.bloodType) and
      equals(typeof(a.allergies), a.allergies, b.allergies) and
      equals(typeof(a.conditions), a.conditions, b.conditions) and
      equals(typeof(a.medications), a.medications, b.medications) and
      equals(typeof(a.emergencyContact), a.emergencyContact, b.emergencyContact)

proc `==`*(a, b: Healthhealth): bool =
  return equals(Healthhealth, a, b)

proc stringify(_: typedesc[Healthhealth]; value: Healthhealth): string =
  stringifyObj("Healthhealth", ("patientName", stringify(
      typeof(value.patientName), value.patientName)), ("dateOfBirth",
      stringify(typeof(value.dateOfBirth), value.dateOfBirth)), ("bloodType",
      stringify(typeof(value.bloodType), value.bloodType)), ("allergies",
      stringify(typeof(value.allergies), value.allergies)), ("conditions",
      stringify(typeof(value.conditions), value.conditions)), ("medications",
      stringify(typeof(value.medications), value.medications)), (
      "emergencyContact",
      stringify(typeof(value.emergencyContact), value.emergencyContact)))

proc `$`*(value: Healthhealth): string =
  stringify(Healthhealth, value)

proc fromJsonHook*(target: var Healthhealth; source: JsonNode) =
  assert(hasKey(source, "patientName"),
         "patientName" & " is missing while decoding " & "Healthhealth")
  target.patientName = jsonTo(source{"patientName"}, typeof(target.patientName))
  assert(hasKey(source, "dateOfBirth"),
         "dateOfBirth" & " is missing while decoding " & "Healthhealth")
  target.dateOfBirth = jsonTo(source{"dateOfBirth"}, typeof(target.dateOfBirth))
  assert(hasKey(source, "bloodType"),
         "bloodType" & " is missing while decoding " & "Healthhealth")
  target.bloodType = jsonTo(source{"bloodType"}, typeof(target.bloodType))
  if hasKey(source, "allergies") and source{"allergies"}.kind != JNull:
    target.allergies = some(jsonTo(source{"allergies"},
                                   typeof(unsafeGet(target.allergies))))
  if hasKey(source, "conditions") and source{"conditions"}.kind != JNull:
    target.conditions = some(jsonTo(source{"conditions"},
                                    typeof(unsafeGet(target.conditions))))
  if hasKey(source, "medications") and source{"medications"}.kind != JNull:
    target.medications = some(jsonTo(source{"medications"},
                                     typeof(unsafeGet(target.medications))))
  if hasKey(source, "emergencyContact") and
      source{"emergencyContact"}.kind != JNull:
    target.emergencyContact = some(jsonTo(source{"emergencyContact"},
        typeof(unsafeGet(target.emergencyContact))))

proc toJsonHook*(source: Healthhealth): JsonNode =
  result = newJObject()
  result{"patientName"} = newJString(source.patientName)
  result{"dateOfBirth"} = newJString(source.dateOfBirth)
  result{"bloodType"} = newJString(source.bloodType)
  if isSome(source.allergies):
    result{"allergies"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.allergies):
        output.add(newJString(entry))
      output
  if isSome(source.conditions):
    result{"conditions"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.conditions):
        output.add(newJString(entry))
      output
  if isSome(source.medications):
    result{"medications"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.medications):
        output.add(newJString(entry))
      output
  if isSome(source.emergencyContact):
    result{"emergencyContact"} = toJsonHook(unsafeGet(source.emergencyContact))

proc toBinary*(target: var string; source: Healthhealth) =
  toBinary(target, source.patientName)
  toBinary(target, source.dateOfBirth)
  toBinary(target, source.bloodType)
  toBinary(target, source.allergies)
  toBinary(target, source.conditions)
  toBinary(target, source.medications)
  toBinary(target, source.emergencyContact)

proc fromBinary(_: typedesc[Healthhealth]; source: string; idx: var int): Healthhealth =
  result.patientName = fromBinary(typeof(result.patientName), source, idx)
  result.dateOfBirth = fromBinary(typeof(result.dateOfBirth), source, idx)
  result.bloodType = fromBinary(typeof(result.bloodType), source, idx)
  result.allergies = fromBinary(typeof(result.allergies), source, idx)
  result.conditions = fromBinary(typeof(result.conditions), source, idx)
  result.medications = fromBinary(typeof(result.medications), source, idx)
  result.emergencyContact = fromBinary(typeof(result.emergencyContact), source,
                                       idx)
{.pop.}
