import std/[json, tables, options]
type
  `ArrayOfThingsVeggie`* = object
    `veggieName`*: string
    `veggieLike`*: bool
  `ArrayOfThingsArrayOfThings`* = object
    `vegetables`*: Option[seq[`ArrayOfThingsVeggie`]]
    `fruits`*: Option[seq[string]]