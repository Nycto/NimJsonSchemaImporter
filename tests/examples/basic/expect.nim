import std/[json, tables, options]
type
  `TestBasic`* = object
    `firstName`*: Option[string]
    `age`*: Option[BiggestInt]
    `lastName`*: Option[string]