{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify

type
  EcommerceProductSchema* = object
    name*: Option[string]
    price*: Option[BiggestFloat]
  EcommerceOrderSchema* = object
    orderId*: Option[string]
    items*: Option[seq[EcommerceProductSchema]]
proc toJsonHook*(source: EcommerceProductSchema): JsonNode
proc toJsonHook*(source: EcommerceOrderSchema): JsonNode
proc `==`*(a, b: EcommerceProductSchema): bool =
  true and a.name == b.name and a.price == b.price

proc stringify(_: typedesc[EcommerceProductSchema];
               value: EcommerceProductSchema): string =
  stringifyObj("EcommerceProductSchema",
               ("name", stringify(typeof(value.name), value.name)),
               ("price", stringify(typeof(value.price), value.price)))

proc `$`*(value: EcommerceProductSchema): string =
  stringify(EcommerceProductSchema, value)

proc fromJsonHook*(target: var EcommerceProductSchema; source: JsonNode) =
  if hasKey(source, "name") and source{"name"}.kind != JNull:
    target.name = some(jsonTo(source{"name"}, typeof(unsafeGet(target.name))))
  if hasKey(source, "price") and source{"price"}.kind != JNull:
    target.price = some(jsonTo(source{"price"}, typeof(unsafeGet(target.price))))

proc toJsonHook*(source: EcommerceProductSchema): JsonNode =
  result = newJObject()
  if isSome(source.name):
    result{"name"} = newJString(unsafeGet(source.name))
  if isSome(source.price):
    result{"price"} = newJFloat(unsafeGet(source.price))

proc `==`*(a, b: EcommerceOrderSchema): bool =
  true and a.orderId == b.orderId and a.items == b.items

proc stringify(_: typedesc[EcommerceOrderSchema]; value: EcommerceOrderSchema): string =
  stringifyObj("EcommerceOrderSchema",
               ("orderId", stringify(typeof(value.orderId), value.orderId)),
               ("items", stringify(typeof(value.items), value.items)))

proc `$`*(value: EcommerceOrderSchema): string =
  stringify(EcommerceOrderSchema, value)

proc fromJsonHook*(target: var EcommerceOrderSchema; source: JsonNode) =
  if hasKey(source, "orderId") and source{"orderId"}.kind != JNull:
    target.orderId = some(jsonTo(source{"orderId"},
                                 typeof(unsafeGet(target.orderId))))
  if hasKey(source, "items") and source{"items"}.kind != JNull:
    target.items = some(jsonTo(source{"items"}, typeof(unsafeGet(target.items))))

proc toJsonHook*(source: EcommerceOrderSchema): JsonNode =
  result = newJObject()
  if isSome(source.orderId):
    result{"orderId"} = newJString(unsafeGet(source.orderId))
  if isSome(source.items):
    result{"items"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.items):
        output.add(toJsonHook(entry))
      output
{.pop.}
