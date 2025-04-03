{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  Array_of_thingsVeggie* = object
    veggieName*: string
    veggieLike*: bool
  Array_of_things* = object
    fruits*: Option[seq[string]]
    vegetables*: Option[seq[Array_of_thingsVeggie]]
proc toJsonHook*(source: Array_of_thingsVeggie): JsonNode
proc toJsonHook*(source: Array_of_things): JsonNode
proc equals(_: typedesc[Array_of_thingsVeggie]; a, b: Array_of_thingsVeggie): bool =
  equals(typeof(a.veggieName), a.veggieName, b.veggieName) and
      equals(typeof(a.veggieLike), a.veggieLike, b.veggieLike)

proc `==`*(a, b: Array_of_thingsVeggie): bool =
  return equals(Array_of_thingsVeggie, a, b)

proc stringify(_: typedesc[Array_of_thingsVeggie]; value: Array_of_thingsVeggie): string =
  stringifyObj("Array_of_thingsVeggie", ("veggieName",
      stringify(typeof(value.veggieName), value.veggieName)), ("veggieLike",
      stringify(typeof(value.veggieLike), value.veggieLike)))

proc `$`*(value: Array_of_thingsVeggie): string =
  stringify(Array_of_thingsVeggie, value)

proc fromJsonHook*(target: var Array_of_thingsVeggie; source: JsonNode) =
  assert(hasKey(source, "veggieName"),
         "veggieName" & " is missing while decoding " & "Array_of_thingsVeggie")
  target.veggieName = jsonTo(source{"veggieName"}, typeof(target.veggieName))
  assert(hasKey(source, "veggieLike"),
         "veggieLike" & " is missing while decoding " & "Array_of_thingsVeggie")
  target.veggieLike = jsonTo(source{"veggieLike"}, typeof(target.veggieLike))

proc toJsonHook*(source: Array_of_thingsVeggie): JsonNode =
  result = newJObject()
  result{"veggieName"} = newJString(source.veggieName)
  result{"veggieLike"} = newJBool(source.veggieLike)

proc equals(_: typedesc[Array_of_things]; a, b: Array_of_things): bool =
  equals(typeof(a.fruits), a.fruits, b.fruits) and
      equals(typeof(a.vegetables), a.vegetables, b.vegetables)

proc `==`*(a, b: Array_of_things): bool =
  return equals(Array_of_things, a, b)

proc stringify(_: typedesc[Array_of_things]; value: Array_of_things): string =
  stringifyObj("Array_of_things",
               ("fruits", stringify(typeof(value.fruits), value.fruits)), (
      "vegetables", stringify(typeof(value.vegetables), value.vegetables)))

proc `$`*(value: Array_of_things): string =
  stringify(Array_of_things, value)

proc fromJsonHook*(target: var Array_of_things; source: JsonNode) =
  if hasKey(source, "fruits") and source{"fruits"}.kind != JNull:
    target.fruits = some(jsonTo(source{"fruits"},
                                typeof(unsafeGet(target.fruits))))
  if hasKey(source, "vegetables") and source{"vegetables"}.kind != JNull:
    target.vegetables = some(jsonTo(source{"vegetables"},
                                    typeof(unsafeGet(target.vegetables))))

proc toJsonHook*(source: Array_of_things): JsonNode =
  result = newJObject()
  if isSome(source.fruits):
    result{"fruits"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.fruits):
        output.add(newJString(entry))
      output
  if isSome(source.vegetables):
    result{"vegetables"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.vegetables):
        output.add(toJsonHook(entry))
      output
{.pop.}
