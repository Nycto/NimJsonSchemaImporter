{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  Testcomplex_object* = object
    hobbies*: Option[seq[string]]
    address*: Option[TestTestcomplex_object_address]
    age*: BiggestInt
    name*: string
  TestTestcomplex_object_address* = object
    street*: string
    city*: string
    postalCode*: string
    state*: string
proc fromJsonHook*(target: var TestTestcomplex_object_address; source: JsonNode) =
  assert("street" in source, "street" & " is missing while decoding " &
      "TestTestcomplex_object_address")
  target.street = jsonTo(source{"street"}, typeof(target.street))
  assert("city" in source, "city" & " is missing while decoding " &
      "TestTestcomplex_object_address")
  target.city = jsonTo(source{"city"}, typeof(target.city))
  assert("postalCode" in source, "postalCode" & " is missing while decoding " &
      "TestTestcomplex_object_address")
  target.postalCode = jsonTo(source{"postalCode"}, typeof(target.postalCode))
  assert("state" in source, "state" & " is missing while decoding " &
      "TestTestcomplex_object_address")
  target.state = jsonTo(source{"state"}, typeof(target.state))

proc toJsonHook*(source: TestTestcomplex_object_address): JsonNode =
  result = newJObject()
  result{"street"} = toJson(source.street)
  result{"city"} = toJson(source.city)
  result{"postalCode"} = toJson(source.postalCode)
  result{"state"} = toJson(source.state)

proc fromJsonHook*(target: var Testcomplex_object; source: JsonNode) =
  if "hobbies" in source and source{"hobbies"}.kind != JNull:
    target.hobbies = some(jsonTo(source{"hobbies"},
                                 typeof(unsafeGet(target.hobbies))))
  if "address" in source and source{"address"}.kind != JNull:
    target.address = some(jsonTo(source{"address"},
                                 typeof(unsafeGet(target.address))))
  assert("age" in source,
         "age" & " is missing while decoding " & "Testcomplex_object")
  target.age = jsonTo(source{"age"}, typeof(target.age))
  assert("name" in source,
         "name" & " is missing while decoding " & "Testcomplex_object")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: Testcomplex_object): JsonNode =
  result = newJObject()
  if isSome(source.hobbies):
    result{"hobbies"} = toJson(source.hobbies)
  if isSome(source.address):
    result{"address"} = toJson(source.address)
  result{"age"} = toJson(source.age)
  result{"name"} = toJson(source.name)
