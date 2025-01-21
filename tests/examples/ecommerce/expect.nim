{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `TestOrderSchema`* = object
    `items`*: Option[seq[`TestProductSchema`]]
    `orderId`*: Option[string]
  `TestProductSchema`* = object
    `name`*: Option[string]
    `price`*: Option[BiggestFloat]
proc fromJsonHook*(target: var `TestProductSchema`; source: JsonNode) =
  if "name" in source:
    target.`name` = some(jsonTo(source{"name"}, typeof(unsafeGet(target.`name`))))
  if "price" in source:
    target.`price` = some(jsonTo(source{"price"},
                                 typeof(unsafeGet(target.`price`))))

proc toJsonHook*(source: `TestProductSchema`): JsonNode =
  result = newJObject()
  if isSome(source.`name`):
    result{"name"} = toJson(source.`name`)
  if isSome(source.`price`):
    result{"price"} = toJson(source.`price`)

proc fromJsonHook*(target: var `TestOrderSchema`; source: JsonNode) =
  if "items" in source:
    target.`items` = some(jsonTo(source{"items"},
                                 typeof(unsafeGet(target.`items`))))
  if "orderId" in source:
    target.`orderId` = some(jsonTo(source{"orderId"},
                                   typeof(unsafeGet(target.`orderId`))))

proc toJsonHook*(source: `TestOrderSchema`): JsonNode =
  result = newJObject()
  if isSome(source.`items`):
    result{"items"} = toJson(source.`items`)
  if isSome(source.`orderId`):
    result{"orderId"} = toJson(source.`orderId`)
