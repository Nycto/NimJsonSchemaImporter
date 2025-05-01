{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  Basic* {.byref.} = object
    firstName*: Option[string]
    lastName*: Option[string]
    age*: Option[BiggestInt]
proc `=copy`(a: var Basic; b: Basic) {.error.}
proc toJsonHook*(source: Basic): JsonNode
proc equals(_: typedesc[Basic]; a, b: Basic): bool =
  equals(typeof(a.firstName), a.firstName, b.firstName) and
      equals(typeof(a.lastName), a.lastName, b.lastName) and
      equals(typeof(a.age), a.age, b.age)

proc `==`*(a, b: Basic): bool =
  return equals(Basic, a, b)

proc stringify(_: typedesc[Basic]; value: Basic): string =
  stringifyObj("Basic", ("firstName",
                         stringify(typeof(value.firstName), value.firstName)), (
      "lastName", stringify(typeof(value.lastName), value.lastName)),
               ("age", stringify(typeof(value.age), value.age)))

proc `$`*(value: Basic): string =
  stringify(Basic, value)

proc fromJsonHook*(target: var Basic; source: JsonNode) =
  if hasKey(source, "firstName") and source{"firstName"}.kind != JNull:
    target.firstName = some(jsonTo(source{"firstName"},
                                   typeof(unsafeGet(target.firstName))))
  if hasKey(source, "lastName") and source{"lastName"}.kind != JNull:
    target.lastName = some(jsonTo(source{"lastName"},
                                  typeof(unsafeGet(target.lastName))))
  if hasKey(source, "age") and source{"age"}.kind != JNull:
    target.age = some(jsonTo(source{"age"}, typeof(unsafeGet(target.age))))

proc toJsonHook*(source: Basic): JsonNode =
  result = newJObject()
  if isSome(source.firstName):
    result{"firstName"} = newJString(unsafeGet(source.firstName))
  if isSome(source.lastName):
    result{"lastName"} = newJString(unsafeGet(source.lastName))
  if isSome(source.age):
    result{"age"} = newJInt(unsafeGet(source.age))
{.pop.}
