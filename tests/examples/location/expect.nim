import std/[json, tables, options]
type
  `TestLocation`* = object
    `latitude`*: BiggestFloat
    `longitude`*: BiggestFloat