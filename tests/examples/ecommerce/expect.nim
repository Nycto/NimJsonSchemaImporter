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
  if hasKey(source, "name") and source{"name"}.kind != JNull:
    target.name = some(jsonTo(source{"name"}, typeof(unsafeGet(target.name))))
  if hasKey(source, "price") and source{"price"}.kind != JNull:
    target.price = some(jsonTo(source{"price"}, typeof(unsafeGet(target.price))))

proc toJsonHook*(source: EcommerceProductSchema): JsonNode =
  result = newJObject()
  if isSome(source.name):
    result{"name"} = toJson(unsafeGet(source.name))
  if isSome(source.price):
    result{"price"} = toJson(unsafeGet(source.price))

proc fromJsonHook*(target: var EcommerceOrderSchema; source: JsonNode) =
  if hasKey(source, "items") and source{"items"}.kind != JNull:
    target.items = some(jsonTo(source{"items"}, typeof(unsafeGet(target.items))))
  if hasKey(source, "orderId") and source{"orderId"}.kind != JNull:
    target.orderId = some(jsonTo(source{"orderId"},
                                 typeof(unsafeGet(target.orderId))))

proc toJsonHook*(source: EcommerceOrderSchema): JsonNode =
  result = newJObject()
  if isSome(source.items):
    result{"items"} = toJson(unsafeGet(source.items))
  if isSome(source.orderId):
    result{"orderId"} = toJson(unsafeGet(source.orderId))
