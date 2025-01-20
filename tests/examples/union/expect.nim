import std/[json, tables, options]
type
  `TestUnion`* = object
    `key1`*: Option[`TestTestUnion_Key1Union`]
    `key2`*: Option[string]
  `TestTestUnion_Key1Union`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: BiggestInt