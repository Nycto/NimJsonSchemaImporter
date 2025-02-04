{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify

type
  Enumerated_valuesenumerated_values* = object
    data*: Option[JsonNode]
proc toJsonHook*(source: Enumerated_valuesenumerated_values): JsonNode
proc `==`*(a, b: Enumerated_valuesenumerated_values): bool =
  true and a.data == b.data

proc stringify(_: typedesc[Enumerated_valuesenumerated_values];
               value: Enumerated_valuesenumerated_values): string =
  stringifyObj("Enumerated_valuesenumerated_values",
               ("data", stringify(typeof(value.data), value.data)))

proc `$`*(value: Enumerated_valuesenumerated_values): string =
  stringify(Enumerated_valuesenumerated_values, value)

proc fromJsonHook*(target: var Enumerated_valuesenumerated_values;
                   source: JsonNode) =
  if hasKey(source, "data") and source{"data"}.kind != JNull:
    target.data = some(jsonTo(source{"data"}, typeof(unsafeGet(target.data))))

proc toJsonHook*(source: Enumerated_valuesenumerated_values): JsonNode =
  result = newJObject()
  if isSome(source.data):
    result{"data"} = unsafeGet(source.data)
{.pop.}
