{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  EcommerceProductSchema* = object
    name*: Option[string]
    price*: Option[BiggestFloat]
  EcommerceOrderSchema* = object
    items*: Option[seq[EcommerceProductSchema]]
    orderId*: Option[string]
proc fromJsonHook*(target: var EcommerceProductSchema; source: JsonNode) =
  if "name" in source and source{"name"}.kind != JNull:
    target.name = some(jsonTo(source{"name"}, typeof(unsafeGet(target.name))))
  if "price" in source and source{"price"}.kind != JNull:
    target.price = some(jsonTo(source{"price"}, typeof(unsafeGet(target.price))))

proc toJsonHook*(source: EcommerceProductSchema): JsonNode =
  result = newJObject()
  if isSome(source.name):
    result{"name"} = toJson(source.name)
  if isSome(source.price):
    result{"price"} = toJson(source.price)

proc fromJsonHook*(target: var EcommerceOrderSchema; source: JsonNode) =
  if "items" in source and source{"items"}.kind != JNull:
    target.items = some(jsonTo(source{"items"}, typeof(unsafeGet(target.items))))
  if "orderId" in source and source{"orderId"}.kind != JNull:
    target.orderId = some(jsonTo(source{"orderId"},
                                 typeof(unsafeGet(target.orderId))))

proc toJsonHook*(source: EcommerceOrderSchema): JsonNode =
  result = newJObject()
  if isSome(source.items):
    result{"items"} = toJson(source.items)
  if isSome(source.orderId):
    result{"orderId"} = toJson(source.orderId)
