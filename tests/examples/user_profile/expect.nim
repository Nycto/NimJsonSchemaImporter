{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  User_profileuser_profile* = object
    username*: string
    email*: string
    fullName*: Option[string]
    age*: Option[BiggestInt]
    location*: Option[string]
    interests*: Option[seq[string]]
proc toJsonHook*(source: User_profileuser_profile): JsonNode
proc equals(_: typedesc[User_profileuser_profile];
            a, b: User_profileuser_profile): bool =
  equals(typeof(a.username), a.username, b.username) and
      equals(typeof(a.email), a.email, b.email) and
      equals(typeof(a.fullName), a.fullName, b.fullName) and
      equals(typeof(a.age), a.age, b.age) and
      equals(typeof(a.location), a.location, b.location) and
      equals(typeof(a.interests), a.interests, b.interests)

proc `==`*(a, b: User_profileuser_profile): bool =
  return equals(User_profileuser_profile, a, b)

proc stringify(_: typedesc[User_profileuser_profile];
               value: User_profileuser_profile): string =
  stringifyObj("User_profileuser_profile", ("username",
      stringify(typeof(value.username), value.username)),
               ("email", stringify(typeof(value.email), value.email)), (
      "fullName", stringify(typeof(value.fullName), value.fullName)),
               ("age", stringify(typeof(value.age), value.age)), ("location",
      stringify(typeof(value.location), value.location)), ("interests",
      stringify(typeof(value.interests), value.interests)))

proc `$`*(value: User_profileuser_profile): string =
  stringify(User_profileuser_profile, value)

proc fromJsonHook*(target: var User_profileuser_profile; source: JsonNode) =
  assert(hasKey(source, "username"), "username" & " is missing while decoding " &
      "User_profileuser_profile")
  target.username = jsonTo(source{"username"}, typeof(target.username))
  assert(hasKey(source, "email"),
         "email" & " is missing while decoding " & "User_profileuser_profile")
  target.email = jsonTo(source{"email"}, typeof(target.email))
  if hasKey(source, "fullName") and source{"fullName"}.kind != JNull:
    target.fullName = some(jsonTo(source{"fullName"},
                                  typeof(unsafeGet(target.fullName))))
  if hasKey(source, "age") and source{"age"}.kind != JNull:
    target.age = some(jsonTo(source{"age"}, typeof(unsafeGet(target.age))))
  if hasKey(source, "location") and source{"location"}.kind != JNull:
    target.location = some(jsonTo(source{"location"},
                                  typeof(unsafeGet(target.location))))
  if hasKey(source, "interests") and source{"interests"}.kind != JNull:
    target.interests = some(jsonTo(source{"interests"},
                                   typeof(unsafeGet(target.interests))))

proc toJsonHook*(source: User_profileuser_profile): JsonNode =
  result = newJObject()
  result{"username"} = newJString(source.username)
  result{"email"} = newJString(source.email)
  if isSome(source.fullName):
    result{"fullName"} = newJString(unsafeGet(source.fullName))
  if isSome(source.age):
    result{"age"} = newJInt(unsafeGet(source.age))
  if isSome(source.location):
    result{"location"} = newJString(unsafeGet(source.location))
  if isSome(source.interests):
    result{"interests"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.interests):
        output.add(newJString(entry))
      output
{.pop.}
