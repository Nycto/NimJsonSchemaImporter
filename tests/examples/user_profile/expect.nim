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
proc fromJsonHook*(target: var User_profileuser_profile; source: JsonNode) =
  if "interests" in source and source{"interests"}.kind != JNull:
    target.interests = some(jsonTo(source{"interests"},
                                   typeof(unsafeGet(target.interests))))
  if "fullName" in source and source{"fullName"}.kind != JNull:
    target.fullName = some(jsonTo(source{"fullName"},
                                  typeof(unsafeGet(target.fullName))))
  if "age" in source and source{"age"}.kind != JNull:
    target.age = some(jsonTo(source{"age"}, typeof(unsafeGet(target.age))))
  assert("username" in source, "username" & " is missing while decoding " &
      "User_profileuser_profile")
  target.username = jsonTo(source{"username"}, typeof(target.username))
  if "location" in source and source{"location"}.kind != JNull:
    target.location = some(jsonTo(source{"location"},
                                  typeof(unsafeGet(target.location))))
  assert("email" in source,
         "email" & " is missing while decoding " & "User_profileuser_profile")
  target.email = jsonTo(source{"email"}, typeof(target.email))

proc toJsonHook*(source: User_profileuser_profile): JsonNode =
  result = newJObject()
  if isSome(source.interests):
    result{"interests"} = toJson(source.interests)
  if isSome(source.fullName):
    result{"fullName"} = toJson(source.fullName)
  if isSome(source.age):
    result{"age"} = toJson(source.age)
  result{"username"} = toJson(source.username)
  if isSome(source.location):
    result{"location"} = toJson(source.location)
  result{"email"} = toJson(source.email)
