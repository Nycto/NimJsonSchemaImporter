{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `TestTestcomplex_object_address`* = object
    `street`*: string
    `city`*: string
    `postalCode`*: string
    `state`*: string
  `Testcomplex_object`* = object
    `hobbies`*: Option[seq[string]]
    `address`*: Option[`TestTestcomplex_object_address`]
    `age`*: BiggestInt
    `name`*: string