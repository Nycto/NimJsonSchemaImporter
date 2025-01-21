{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testlocation`* = object
    `latitude`*: BiggestFloat
    `longitude`*: BiggestFloat