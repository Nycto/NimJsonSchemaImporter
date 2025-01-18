import std/[json, tables, options]
type
  LocationLocation* = object
    `latitude`*: BiggestFloat
    `longitude`*: BiggestFloat