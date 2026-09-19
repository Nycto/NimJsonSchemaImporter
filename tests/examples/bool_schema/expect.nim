{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options, typetraits]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/validate as jsonSchemaValidate
import json_schema_import/private/[equality, bin, sax, empty]
from json_schema_import/private/util import baseOf

type
  Bool_schemaClosedBag* {.byref.} = object
    named*: string
  Bool_schema* {.byref.} = object
    anything*: JsonNode
    list*: seq[JsonNode]
    bag*: OrderedTable[string, JsonNode]
    closedTuple*: (string, BiggestInt)
    legacyClosed*: (bool, string)
    emptyList*: Option[tuple[]]
    eitherOr*: string
    closedBag*: Bool_schemaClosedBag
proc `=copy`(a: var Bool_schemaClosedBag;
             b: Bool_schemaClosedBag) {.error.}
proc `=copy`(a: var Bool_schema; b: Bool_schema) {.error.}
proc equals(_: typedesc[Bool_schemaClosedBag]; a, b: Bool_schemaClosedBag): bool =
  equals(typeof(a.named), a.named, b.named)

proc `==`*(a, b: Bool_schemaClosedBag): bool =
  return equals(Bool_schemaClosedBag, a, b)

proc stringify(_: typedesc[Bool_schemaClosedBag]; value: Bool_schemaClosedBag): string =
  stringifyObj("Bool_schemaClosedBag",
               ("named", stringify(typeof(value.named), value.named)))

proc `$`*(value: Bool_schemaClosedBag): string =
  stringify(Bool_schemaClosedBag, value)

proc fromJsonHook*(target: var Bool_schemaClosedBag; source: JsonNode) =
  assert(hasKey(source, "named"),
         "named" & " is missing while decoding " & "Bool_schemaClosedBag")
  target.named = jsonTo(source{"named"}, typeof(target.named))
  when not defined(jsonSchemaNoValidate):
    validate(Bool_schemaClosedBag, target)

proc toJsonHook*(source: Bool_schemaClosedBag): JsonNode =
  result = newJObject()
  result{"named"} = newJString(source.named)

proc toStream*(source: Bool_schemaClosedBag; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("named"))
  write(target, ':')
  toStream(source.named, target)
  target.write('}')

proc fromStream*(typ: typedesc[Bool_schemaClosedBag];
                 source: var JsonParser): Bool_schemaClosedBag =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "named":
      result.named = fromStream(typeof(result.named), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)
  when not defined(jsonSchemaNoValidate):
    validate(Bool_schemaClosedBag, result)

proc equals(_: typedesc[Bool_schema]; a, b: Bool_schema): bool =
  equals(typeof(a.anything), a.anything, b.anything) and
      equals(typeof(a.list), a.list, b.list) and
      equals(typeof(a.bag), a.bag, b.bag) and
      equals(typeof(a.closedTuple), a.closedTuple, b.closedTuple) and
      equals(typeof(a.legacyClosed), a.legacyClosed, b.legacyClosed) and
      equals(typeof(a.emptyList), a.emptyList, b.emptyList) and
      equals(typeof(a.eitherOr), a.eitherOr, b.eitherOr) and
      equals(typeof(a.closedBag), a.closedBag, b.closedBag)

proc `==`*(a, b: Bool_schema): bool =
  return equals(Bool_schema, a, b)

proc stringify(_: typedesc[Bool_schema]; value: Bool_schema): string =
  stringifyObj("Bool_schema", ("anything", stringify(typeof(value.anything),
      value.anything)), ("list", stringify(typeof(value.list), value.list)),
               ("bag", stringify(typeof(value.bag), value.bag)), ("closedTuple",
      stringify(typeof(value.closedTuple), value.closedTuple)), ("legacyClosed",
      stringify(typeof(value.legacyClosed), value.legacyClosed)), ("emptyList",
      stringify(typeof(value.emptyList), value.emptyList)), ("eitherOr",
      stringify(typeof(value.eitherOr), value.eitherOr)), ("closedBag",
      stringify(typeof(value.closedBag), value.closedBag)))

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
  assert(hasKey(source, "closedTuple"),
         "closedTuple" & " is missing while decoding " & "Bool_schema")
  target.closedTuple = jsonTo(source{"closedTuple"}, typeof(target.closedTuple))
  assert(hasKey(source, "legacyClosed"),
         "legacyClosed" & " is missing while decoding " & "Bool_schema")
  target.legacyClosed = jsonTo(source{"legacyClosed"},
                               typeof(target.legacyClosed))
  if hasKey(source, "emptyList") and source{"emptyList"}.kind != JNull:
    target.emptyList = some(jsonTo(source{"emptyList"},
                                   typeof(unsafeGet(target.emptyList))))
  assert(hasKey(source, "eitherOr"),
         "eitherOr" & " is missing while decoding " & "Bool_schema")
  target.eitherOr = jsonTo(source{"eitherOr"}, typeof(target.eitherOr))
  assert(hasKey(source, "closedBag"),
         "closedBag" & " is missing while decoding " & "Bool_schema")
  target.closedBag = jsonTo(source{"closedBag"}, typeof(target.closedBag))
  when not defined(jsonSchemaNoValidate):
    validate(Bool_schema, target)

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
  result{"closedTuple"} = JsonNode(kind: JArray, elems: @[
      newJString(source.closedTuple[0]), newJInt(source.closedTuple[1])])
  result{"legacyClosed"} = JsonNode(kind: JArray, elems: @[
      newJBool(source.legacyClosed[0]), newJString(source.legacyClosed[1])])
  if isSome(source.emptyList):
    result{"emptyList"} = JsonNode(kind: JArray, elems: @[])
  result{"eitherOr"} = newJString(source.eitherOr)
  result{"closedBag"} = toJsonHook(source.closedBag)

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
  hasEmitted.writeComma(target)
  write(target, escapeJson("closedTuple"))
  write(target, ':')
  toStream(source.closedTuple, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("legacyClosed"))
  write(target, ':')
  toStream(source.legacyClosed, target)
  if isSome(source.emptyList):
    hasEmitted.writeComma(target)
    write(target, escapeJson("emptyList"))
    write(target, ':')
    toStream(unsafeGet(source.emptyList), target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("eitherOr"))
  write(target, ':')
  toStream(source.eitherOr, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("closedBag"))
  write(target, ':')
  toStream(source.closedBag, target)
  target.write('}')

proc fromStream*(typ: typedesc[Bool_schema]; source: var JsonParser): Bool_schema =
  var seen: set[0 .. 4]
  for key in objectKeys(source):
    case key
    of "anything":
      result.anything = fromStream(typeof(result.anything), source)
      seen.incl(0)
    of "list":
      result.list = fromStream(typeof(result.list), source)
    of "bag":
      result.bag = fromStream(typeof(result.bag), source)
    of "closedTuple":
      result.closedTuple = fromStream(typeof(result.closedTuple), source)
      seen.incl(1)
    of "legacyClosed":
      result.legacyClosed = fromStream(typeof(result.legacyClosed), source)
      seen.incl(2)
    of "emptyList":
      result.emptyList = some(fromStream(typeof(unsafeGet(result.emptyList)),
          source))
    of "eitherOr":
      result.eitherOr = fromStream(typeof(result.eitherOr), source)
      seen.incl(3)
    of "closedBag":
      result.closedBag = fromStream(typeof(result.closedBag), source)
      seen.incl(4)
    else:
      skipValue(source)
  assert(card(seen) == 5)
  when not defined(jsonSchemaNoValidate):
    validate(Bool_schema, result)

{.pop.}
