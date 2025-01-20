{.push warning[UnusedImport]:off.}
import std/[json, tables, options]
type
  `TestLocation`* = object
    `latitude`*: BiggestFloat
    `longitude`*: BiggestFloat