import std/[json, tables, options]
type
  ComplexObjectAddress* = object
    `street`*: string
    `city`*: string
    `postalCode`*: string
    `state`*: string
  ComplexObjectComplexObject* = object
    `hobbies`*: Option[seq[string]]
    `address`*: Option[ComplexObjectAddress]
    `age`*: BiggestInt
    `name`*: string