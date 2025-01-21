{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `TestOrderSchema`* = object
    `items`*: Option[seq[`TestProductSchema`]]
    `orderId`*: Option[string]
  `TestProductSchema`* = object
    `name`*: Option[string]
    `price`*: Option[BiggestFloat]