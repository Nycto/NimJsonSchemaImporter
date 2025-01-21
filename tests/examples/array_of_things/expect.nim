{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testarray_of_things`* = object
    `vegetables`*: Option[seq[`Testveggie`]]
    `fruits`*: Option[seq[string]]
  `Testveggie`* = object
    `veggieName`*: string
    `veggieLike`*: bool