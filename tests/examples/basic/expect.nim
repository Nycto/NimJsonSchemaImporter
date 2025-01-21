{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testbasic`* = object
    `firstName`*: Option[string]
    `age`*: Option[BiggestInt]
    `lastName`*: Option[string]