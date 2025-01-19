import std/[json, tables, options]
type
  `Array_of_thingsVeggie`* = object
    `veggieName`*: string
    `veggieLike`*: bool
  `Array_of_thingsArray_of_things`* = object
    `vegetables`*: Option[seq[`Array_of_thingsVeggie`]]
    `fruits`*: Option[seq[string]]