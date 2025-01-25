{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  Array_of_thingsVeggie* = object
    veggieName*: string
    veggieLike*: bool
  Array_of_thingsarray_of_things* = object
    vegetables*: Option[seq[Array_of_thingsVeggie]]
    fruits*: Option[seq[string]]
proc toJsonHook*(source: Array_of_thingsVeggie): JsonNode
proc toJsonHook*(source: Array_of_thingsarray_of_things): JsonNode
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

proc fromJsonHook*(target: var Array_of_thingsarray_of_things; source: JsonNode) =
  if hasKey(source, "vegetables") and source{"vegetables"}.kind != JNull:
    target.vegetables = some(jsonTo(source{"vegetables"},
                                    typeof(unsafeGet(target.vegetables))))
  if hasKey(source, "fruits") and source{"fruits"}.kind != JNull:
    target.fruits = some(jsonTo(source{"fruits"},
                                typeof(unsafeGet(target.fruits))))

proc toJsonHook*(source: Array_of_thingsarray_of_things): JsonNode =
  result = newJObject()
  if isSome(source.vegetables):
    result{"vegetables"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.vegetables):
        output.add(toJsonHook(entry))
      output
  if isSome(source.fruits):
    result{"fruits"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.fruits):
        output.add(newJString(entry))
      output
{.pop.}
