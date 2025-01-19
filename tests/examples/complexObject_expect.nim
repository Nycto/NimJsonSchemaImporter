import std/[json, tables, options]
type
  `ComplexObjectComplexObject`* = object
    `hobbies`*: Option[seq[string]]
    `address`*: Option[`ComplexObjectComplexObjectComplexObject_Address`]
    `age`*: BiggestInt
    `name`*: string
  `ComplexObjectComplexObjectComplexObject_Address`* = object
    `street`*: string
    `city`*: string
    `postalCode`*: string
    `state`*: string