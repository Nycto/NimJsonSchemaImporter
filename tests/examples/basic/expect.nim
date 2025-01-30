{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  Basicbasic* = object
    firstName*: Option[string]
    lastName*: Option[string]
    age*: Option[BiggestInt]
proc toJsonHook*(source: Basicbasic): JsonNode
proc fromJsonHook*(target: var Basicbasic; source: JsonNode) =
  if hasKey(source, "firstName") and source{"firstName"}.kind != JNull:
    target.firstName = some(jsonTo(source{"firstName"},
                                   typeof(unsafeGet(target.firstName))))
  if hasKey(source, "lastName") and source{"lastName"}.kind != JNull:
    target.lastName = some(jsonTo(source{"lastName"},
                                  typeof(unsafeGet(target.lastName))))
  if hasKey(source, "age") and source{"age"}.kind != JNull:
    target.age = some(jsonTo(source{"age"}, typeof(unsafeGet(target.age))))

proc toJsonHook*(source: Basicbasic): JsonNode =
  result = newJObject()
  if isSome(source.firstName):
    result{"firstName"} = newJString(unsafeGet(source.firstName))
  if isSome(source.lastName):
    result{"lastName"} = newJString(unsafeGet(source.lastName))
  if isSome(source.age):
    result{"age"} = newJInt(unsafeGet(source.age))
{.pop.}
