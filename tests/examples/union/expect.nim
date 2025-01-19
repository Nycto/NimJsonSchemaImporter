import std/[json, tables, options]
type
  `UnionUnionUnion_Key1Union`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: BiggestInt
  `UnionUnion`* = object
    `key1`*: Option[`UnionUnionUnion_Key1Union`]
    `key2`*: Option[string]