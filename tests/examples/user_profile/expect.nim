{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin, sax]

type
  User_profile* {.byref.} = object
    username*: string
    email*: string
    fullName*: Option[string]
    age*: Option[BiggestInt]
    location*: Option[string]
    interests*: seq[string]
proc `=copy`(a: var User_profile; b: User_profile) {.error.}
proc toJsonHook*(source: User_profile): JsonNode
proc equals(_: typedesc[User_profile]; a, b: User_profile): bool =
  equals(typeof(a.username), a.username, b.username) and
      equals(typeof(a.email), a.email, b.email) and
      equals(typeof(a.fullName), a.fullName, b.fullName) and
      equals(typeof(a.age), a.age, b.age) and
      equals(typeof(a.location), a.location, b.location) and
      equals(typeof(a.interests), a.interests, b.interests)

proc `==`*(a, b: User_profile): bool =
  return equals(User_profile, a, b)

proc stringify(_: typedesc[User_profile]; value: User_profile): string =
  stringifyObj("User_profile", ("username", stringify(typeof(value.username),
      value.username)), ("email", stringify(typeof(value.email), value.email)), (
      "fullName", stringify(typeof(value.fullName), value.fullName)),
               ("age", stringify(typeof(value.age), value.age)), ("location",
      stringify(typeof(value.location), value.location)), ("interests",
      stringify(typeof(value.interests), value.interests)))

proc `$`*(value: User_profile): string =
  stringify(User_profile, value)

proc fromJsonHook*(target: var User_profile; source: JsonNode) =
  assert(hasKey(source, "username"),
         "username" & " is missing while decoding " & "User_profile")
  target.username = jsonTo(source{"username"}, typeof(target.username))
  assert(hasKey(source, "email"),
         "email" & " is missing while decoding " & "User_profile")
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
    target.interests = jsonTo(source{"interests"}, typeof(target.interests))

proc toJsonHook*(source: User_profile): JsonNode =
  result = newJObject()
  result{"username"} = newJString(source.username)
  result{"email"} = newJString(source.email)
  if isSome(source.fullName):
    result{"fullName"} = newJString(unsafeGet(source.fullName))
  if isSome(source.age):
    result{"age"} = newJInt(unsafeGet(source.age))
  if isSome(source.location):
    result{"location"} = newJString(unsafeGet(source.location))
  if len(source.interests) > 0:
    result{"interests"} = block:
      let cursor {.cursor.} = source.interests
      var output = newJArray()
      for entry in cursor:
        output.add(newJString(entry))
      output

proc toStream*(source: User_profile; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("username"))
  write(target, ':')
  toStream(source.username, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("email"))
  write(target, ':')
  toStream(source.email, target)
  if isSome(source.fullName):
    hasEmitted.writeComma(target)
    write(target, escapeJson("fullName"))
    write(target, ':')
    toStream(unsafeGet(source.fullName), target)
  if isSome(source.age):
    hasEmitted.writeComma(target)
    write(target, escapeJson("age"))
    write(target, ':')
    toStream(unsafeGet(source.age), target)
  if isSome(source.location):
    hasEmitted.writeComma(target)
    write(target, escapeJson("location"))
    write(target, ':')
    toStream(unsafeGet(source.location), target)
  if len(source.interests) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("interests"))
    write(target, ':')
    toStream(source.interests, target)
  target.write('}')

proc fromStream*(typ: typedesc[User_profile]; source: var JsonParser): User_profile =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "username":
      result.username = fromStream(typeof(result.username), source)
      seen.incl(0)
    of "email":
      result.email = fromStream(typeof(result.email), source)
      seen.incl(1)
    of "fullName":
      result.fullName = some(fromStream(typeof(unsafeGet(result.fullName)),
                                        source))
    of "age":
      result.age = some(fromStream(typeof(unsafeGet(result.age)), source))
    of "location":
      result.location = some(fromStream(typeof(unsafeGet(result.location)),
                                        source))
    of "interests":
      result.interests = fromStream(typeof(result.interests), source)
    else:
      skipValue(source)
  assert(card(seen) == 2)
{.pop.}
