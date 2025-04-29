{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  Enumerated_values* = object
    data*: Option[JsonNode]
proc `=copy`(a: var Enumerated_values; b: Enumerated_values) {.
    error.}
proc toJsonHook*(source: Enumerated_values): JsonNode
proc equals(_: typedesc[Enumerated_values]; a, b: Enumerated_values): bool =
  equals(typeof(a.data), a.data, b.data)

proc `==`*(a, b: Enumerated_values): bool =
  return equals(Enumerated_values, a, b)

proc stringify(_: typedesc[Enumerated_values]; value: Enumerated_values): string =
  stringifyObj("Enumerated_values",
               ("data", stringify(typeof(value.data), value.data)))

proc `$`*(value: Enumerated_values): string =
  stringify(Enumerated_values, value)

proc fromJsonHook*(target: var Enumerated_values; source: JsonNode) =
  if hasKey(source, "data") and source{"data"}.kind != JNull:
    target.data = some(jsonTo(source{"data"}, typeof(unsafeGet(target.data))))

proc toJsonHook*(source: Enumerated_values): JsonNode =
  result = newJObject()
  if isSome(source.data):
    result{"data"} = unsafeGet(source.data)
{.pop.}
