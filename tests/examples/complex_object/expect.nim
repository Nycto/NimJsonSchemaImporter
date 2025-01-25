{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  Complex_objectAddress* = object
    street*: string
    city*: string
    postalCode*: string
    state*: string
  Complex_objectcomplex_object* = object
    hobbies*: Option[seq[string]]
    address*: Option[Complex_objectAddress]
    age*: BiggestInt
    name*: string
proc toJsonHook*(source: Complex_objectAddress): JsonNode
proc toJsonHook*(source: Complex_objectcomplex_object): JsonNode
proc fromJsonHook*(target: var Complex_objectAddress; source: JsonNode) =
  assert(hasKey(source, "street"),
         "street" & " is missing while decoding " & "Complex_objectAddress")
  target.street = jsonTo(source{"street"}, typeof(target.street))
  assert(hasKey(source, "city"),
         "city" & " is missing while decoding " & "Complex_objectAddress")
  target.city = jsonTo(source{"city"}, typeof(target.city))
  assert(hasKey(source, "postalCode"),
         "postalCode" & " is missing while decoding " & "Complex_objectAddress")
  target.postalCode = jsonTo(source{"postalCode"}, typeof(target.postalCode))
  assert(hasKey(source, "state"),
         "state" & " is missing while decoding " & "Complex_objectAddress")
  target.state = jsonTo(source{"state"}, typeof(target.state))

proc toJsonHook*(source: Complex_objectAddress): JsonNode =
  result = newJObject()
  result{"street"} = newJString(source.street)
  result{"city"} = newJString(source.city)
  result{"postalCode"} = newJString(source.postalCode)
  result{"state"} = newJString(source.state)

proc fromJsonHook*(target: var Complex_objectcomplex_object; source: JsonNode) =
  if hasKey(source, "hobbies") and source{"hobbies"}.kind != JNull:
    target.hobbies = some(jsonTo(source{"hobbies"},
                                 typeof(unsafeGet(target.hobbies))))
  if hasKey(source, "address") and source{"address"}.kind != JNull:
    target.address = some(jsonTo(source{"address"},
                                 typeof(unsafeGet(target.address))))
  assert(hasKey(source, "age"),
         "age" & " is missing while decoding " & "Complex_objectcomplex_object")
  target.age = jsonTo(source{"age"}, typeof(target.age))
  assert(hasKey(source, "name"), "name" & " is missing while decoding " &
      "Complex_objectcomplex_object")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: Complex_objectcomplex_object): JsonNode =
  result = newJObject()
  if isSome(source.hobbies):
    result{"hobbies"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.hobbies):
        output.add(newJString(entry))
      output
  if isSome(source.address):
    result{"address"} = toJsonHook(unsafeGet(source.address))
  result{"age"} = newJInt(source.age)
  result{"name"} = newJString(source.name)
{.pop.}
