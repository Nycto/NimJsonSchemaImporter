import std/[json, tables, options]
type
  `TestTestComplex_object_Address`* = object
    `street`*: string
    `city`*: string
    `postalCode`*: string
    `state`*: string
  `TestComplex_object`* = object
    `hobbies`*: Option[seq[string]]
    `address`*: Option[`TestTestComplex_object_Address`]
    `age`*: BiggestInt
    `name`*: string