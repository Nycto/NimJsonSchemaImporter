import std/[json, tables, options]
type
  UnionKey1* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: BiggestInt
  UnionUnion* = object
    `key1`*: Option[UnionKey1]
    `key2`*: Option[string]