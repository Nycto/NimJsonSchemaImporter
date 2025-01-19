import std/[json, tables, options]
type
  `UnionUnion`* = object
    `key1`*: Option[`UnionKey1`]
    `key2`*: Option[string]
  `UnionKey1`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: BiggestInt