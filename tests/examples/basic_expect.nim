import std/[json, tables, options]
type
  `BasicBasic`* = object
    `firstName`*: Option[string]
    `age`*: Option[BiggestInt]
    `lastName`*: Option[string]