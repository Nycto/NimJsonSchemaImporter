{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testenumerated_values`* = object
    `data`*: Option[JsonNode]
proc fromJsonHook*(target: var `Testenumerated_values`; source: JsonNode) =
  if "data" in source and source{"data"}.kind != JNull:
    target.`data` = some(jsonTo(source{"data"}, typeof(unsafeGet(target.`data`))))

proc toJsonHook*(source: `Testenumerated_values`): JsonNode =
  result = newJObject()
  if isSome(source.`data`):
    result{"data"} = toJson(source.`data`)
