import std/[json, tables]
type
  EcommerceProductSchema* = object
    `name`*: string
    `price`*: BiggestFloat
  EcommerceOrderSchema* = object
    `items`*: seq[EcommerceProductSchema]
    `orderId`*: string