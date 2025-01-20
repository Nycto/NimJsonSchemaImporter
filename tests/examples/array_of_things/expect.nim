import std/[json, tables, options]
type
  `TestVeggie`* = object
    `veggieName`*: string
    `veggieLike`*: bool
  `TestArray_of_things`* = object
    `vegetables`*: Option[seq[`TestVeggie`]]
    `fruits`*: Option[seq[string]]