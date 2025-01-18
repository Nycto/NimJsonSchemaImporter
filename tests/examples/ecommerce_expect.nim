import std/[json, tables, options]
type
  `EcommerceProductSchema`* = object
    `name`*: Option[string]
    `price`*: Option[BiggestFloat]
  `EcommerceOrderSchema`* = object
    `items`*: Option[seq[`EcommerceProductSchema`]]
    `orderId`*: Option[string]