import std/[json, tables]
type
  ArrayOfThingsVeggie* = object
    `veggieName`*: string
    `veggieLike`*: bool
  ArrayOfThingsArrayOfThings* = object
    `vegetables`*: seq[ArrayOfThingsVeggie]
    `fruits`*: seq[string]