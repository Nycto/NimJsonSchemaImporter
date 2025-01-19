import std/[json, tables, options]
type
  `EcommerceOrderSchema`* = object
    `items`*: Option[seq[`EcommerceProductSchema`]]
    `orderId`*: Option[string]
  `EcommerceProductSchema`* = object
    `name`*: Option[string]
    `price`*: Option[BiggestFloat]