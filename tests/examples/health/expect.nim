{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  HealthEmergencyContact* = object
    username*: Option[string]
    email*: Option[string]
  Healthhealth* = object
    dateOfBirth*: string
    emergencyContact*: Option[HealthEmergencyContact]
    patientName*: string
    bloodType*: string
    medications*: Option[seq[string]]
    conditions*: Option[seq[string]]
    allergies*: Option[seq[string]]
proc fromJsonHook*(target: var HealthEmergencyContact; source: JsonNode) =
  if "username" in source and source{"username"}.kind != JNull:
    target.username = some(jsonTo(source{"username"},
                                  typeof(unsafeGet(target.username))))
  if "email" in source and source{"email"}.kind != JNull:
    target.email = some(jsonTo(source{"email"}, typeof(unsafeGet(target.email))))

proc toJsonHook*(source: HealthEmergencyContact): JsonNode =
  result = newJObject()
  if isSome(source.username):
    result{"username"} = toJson(source.username)
  if isSome(source.email):
    result{"email"} = toJson(source.email)

proc fromJsonHook*(target: var Healthhealth; source: JsonNode) =
  assert("dateOfBirth" in source,
         "dateOfBirth" & " is missing while decoding " & "Healthhealth")
  target.dateOfBirth = jsonTo(source{"dateOfBirth"}, typeof(target.dateOfBirth))
  if "emergencyContact" in source and
      source{"emergencyContact"}.kind != JNull:
    target.emergencyContact = some(jsonTo(source{"emergencyContact"},
        typeof(unsafeGet(target.emergencyContact))))
  assert("patientName" in source,
         "patientName" & " is missing while decoding " & "Healthhealth")
  target.patientName = jsonTo(source{"patientName"}, typeof(target.patientName))
  assert("bloodType" in source,
         "bloodType" & " is missing while decoding " & "Healthhealth")
  target.bloodType = jsonTo(source{"bloodType"}, typeof(target.bloodType))
  if "medications" in source and source{"medications"}.kind != JNull:
    target.medications = some(jsonTo(source{"medications"},
                                     typeof(unsafeGet(target.medications))))
  if "conditions" in source and source{"conditions"}.kind != JNull:
    target.conditions = some(jsonTo(source{"conditions"},
                                    typeof(unsafeGet(target.conditions))))
  if "allergies" in source and source{"allergies"}.kind != JNull:
    target.allergies = some(jsonTo(source{"allergies"},
                                   typeof(unsafeGet(target.allergies))))

proc toJsonHook*(source: Healthhealth): JsonNode =
  result = newJObject()
  result{"dateOfBirth"} = toJson(source.dateOfBirth)
  if isSome(source.emergencyContact):
    result{"emergencyContact"} = toJson(source.emergencyContact)
  result{"patientName"} = toJson(source.patientName)
  result{"bloodType"} = toJson(source.bloodType)
  if isSome(source.medications):
    result{"medications"} = toJson(source.medications)
  if isSome(source.conditions):
    result{"conditions"} = toJson(source.conditions)
  if isSome(source.allergies):
    result{"allergies"} = toJson(source.allergies)
