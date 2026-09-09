{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Const_root* {.byref.} = object
proc `=copy`(a: var Const_root; b: Const_root) {.error.}
proc equals(_: typedesc[Const_root]; a, b: Const_root): bool =
  true

proc `==`*(a, b: Const_root): bool =
  return equals(Const_root, a, b)

proc stringify(_: typedesc[Const_root]; value: Const_root): string =
  "42"

proc `$`*(value: Const_root): string =
  stringify(Const_root, value)

proc fromJsonHook*(target: var Const_root; source: JsonNode) =
  discard

proc toJsonHook*(source: Const_root): JsonNode =
  newJInt(42)

proc toStream*(source: Const_root; target: Stream) =
  write(target, "42")

proc fromStream*(typ: typedesc[Const_root]; source: var JsonParser): Const_root =
  skipValue(source)

{.pop.}
