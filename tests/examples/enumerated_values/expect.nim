{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  Enumerated_valuesenumerated_values* = object
    data*: Option[JsonNode]
proc fromJsonHook*(target: var Enumerated_valuesenumerated_values;
                   source: JsonNode) =
  if "data" in source and source{"data"}.kind != JNull:
    target.data = some(jsonTo(source{"data"}, typeof(unsafeGet(target.data))))

proc toJsonHook*(source: Enumerated_valuesenumerated_values): JsonNode =
  result = newJObject()
  if isSome(source.data):
    result{"data"} = toJson(source.data)
