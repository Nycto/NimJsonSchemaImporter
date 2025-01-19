import std/[json, tables, options]
type
  `Complex_objectComplex_object`* = object
    `hobbies`*: Option[seq[string]]
    `address`*: Option[`Complex_objectComplex_objectComplex_object_Address`]
    `age`*: BiggestInt
    `name`*: string
  `Complex_objectComplex_objectComplex_object_Address`* = object
    `street`*: string
    `city`*: string
    `postalCode`*: string
    `state`*: string