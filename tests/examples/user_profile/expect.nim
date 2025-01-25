{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  User_profileuser_profile* = object
    interests*: Option[seq[string]]
    fullName*: Option[string]
    age*: Option[BiggestInt]
    username*: string
    location*: Option[string]
    email*: string
proc toJsonHook*(source: User_profileuser_profile): JsonNode
proc fromJsonHook*(target: var User_profileuser_profile; source: JsonNode) =
  if hasKey(source, "interests") and source{"interests"}.kind != JNull:
    target.interests = some(jsonTo(source{"interests"},
                                   typeof(unsafeGet(target.interests))))
  if hasKey(source, "fullName") and source{"fullName"}.kind != JNull:
    target.fullName = some(jsonTo(source{"fullName"},
                                  typeof(unsafeGet(target.fullName))))
  if hasKey(source, "age") and source{"age"}.kind != JNull:
    target.age = some(jsonTo(source{"age"}, typeof(unsafeGet(target.age))))
  assert(hasKey(source, "username"), "username" & " is missing while decoding " &
      "User_profileuser_profile")
  target.username = jsonTo(source{"username"}, typeof(target.username))
  if hasKey(source, "location") and source{"location"}.kind != JNull:
    target.location = some(jsonTo(source{"location"},
                                  typeof(unsafeGet(target.location))))
  assert(hasKey(source, "email"),
         "email" & " is missing while decoding " & "User_profileuser_profile")
  target.email = jsonTo(source{"email"}, typeof(target.email))

proc toJsonHook*(source: User_profileuser_profile): JsonNode =
  result = newJObject()
  if isSome(source.interests):
    result{"interests"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.interests):
        output.add(newJString(entry))
      output
  if isSome(source.fullName):
    result{"fullName"} = newJString(unsafeGet(source.fullName))
  if isSome(source.age):
    result{"age"} = newJInt(unsafeGet(source.age))
  result{"username"} = newJString(source.username)
  if isSome(source.location):
    result{"location"} = newJString(unsafeGet(source.location))
  result{"email"} = newJString(source.email)
{.pop.}
