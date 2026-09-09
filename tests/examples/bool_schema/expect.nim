{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Bool_schema* {.byref.} = object
    anything*: JsonNode
    list*: seq[JsonNode]
    bag*: OrderedTable[string, JsonNode]
proc `=copy`(a: var Bool_schema; b: Bool_schema) {.error.}
proc toJsonHook*(source: Bool_schema): JsonNode
proc equals(_: typedesc[Bool_schema]; a, b: Bool_schema): bool =
  equals(typeof(a.anything), a.anything, b.anything) and
      equals(typeof(a.list), a.list, b.list) and
      equals(typeof(a.bag), a.bag, b.bag)

proc `==`*(a, b: Bool_schema): bool =
  return equals(Bool_schema, a, b)

proc stringify(_: typedesc[Bool_schema]; value: Bool_schema): string =
  stringifyObj("Bool_schema", ("anything", stringify(typeof(value.anything),
      value.anything)), ("list", stringify(typeof(value.list), value.list)),
               ("bag", stringify(typeof(value.bag), value.bag)))

proc `$`*(value: Bool_schema): string =
  stringify(Bool_schema, value)

proc fromJsonHook*(target: var Bool_schema; source: JsonNode) =
  assert(hasKey(source, "anything"),
         "anything" & " is missing while decoding " & "Bool_schema")
  target.anything = jsonTo(source{"anything"}, typeof(target.anything))
  if hasKey(source, "list") and source{"list"}.kind != JNull:
    target.list = jsonTo(source{"list"}, typeof(target.list))
  if hasKey(source, "bag") and source{"bag"}.kind != JNull:
    target.bag = jsonTo(source{"bag"}, typeof(target.bag))

proc toJsonHook*(source: Bool_schema): JsonNode =
  result = newJObject()
  result{"anything"} = source.anything
  if len(source.list) > 0:
    result{"list"} = block:
      let cursor {.cursor.} = source.list
      var output = newJArray()
      for entry in cursor:
        output.add(entry)
      output
  if len(source.bag) > 0:
    result{"bag"} = block:
      let cursor {.cursor.} = source.bag
      var output = newJObject()
      for key in keys(cursor):
        output[key] = cursor[
            key]
      output

proc toStream*(source: Bool_schema; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("anything"))
  write(target, ':')
  toStream(source.anything, target)
  if len(source.list) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("list"))
    write(target, ':')
    toStream(source.list, target)
  if len(source.bag) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("bag"))
    write(target, ':')
    toStream(source.bag, target)
  target.write('}')

proc fromStream*(typ: typedesc[Bool_schema]; source: var JsonParser): Bool_schema =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "anything":
      result.anything = fromStream(typeof(result.anything), source)
      seen.incl(0)
    of "list":
      result.list = fromStream(typeof(result.list), source)
    of "bag":
      result.bag = fromStream(typeof(result.bag), source)
    else:
      skipValue(source)
  assert(card(seen) == 1)

{.pop.}
