{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testbasic`* = object
    `firstName`*: Option[string]
    `age`*: Option[BiggestInt]
    `lastName`*: Option[string]
proc fromJsonHook*(target: var `Testbasic`; source: JsonNode) =
  if "firstName" in source:
    target.`firstName` = some(jsonTo(source{"firstName"},
                                     typeof(unsafeGet(target.`firstName`))))
  if "age" in source:
    target.`age` = some(jsonTo(source{"age"}, typeof(unsafeGet(target.`age`))))
  if "lastName" in source:
    target.`lastName` = some(jsonTo(source{"lastName"},
                                    typeof(unsafeGet(target.`lastName`))))

proc toJsonHook*(source: `Testbasic`): JsonNode =
  result = newJObject()
  if isSome(source.`firstName`):
    result{"firstName"} = toJson(source.`firstName`)
  if isSome(source.`age`):
    result{"age"} = toJson(source.`age`)
  if isSome(source.`lastName`):
    result{"lastName"} = toJson(source.`lastName`)
