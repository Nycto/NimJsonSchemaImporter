import std/[json, tables]
type
  ComplexObjectAddress* = object
    `street`*: string
    `city`*: string
    `postalCode`*: string
    `state`*: string
  ComplexObjectComplexObject* = object
    `hobbies`*: seq[string]
    `address`*: ComplexObjectAddress
    `age`*: BiggestInt
    `name`*: string