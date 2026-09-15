{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Recursive_tree* {.byref.} = object
    name*: string
    weight*: Option[BiggestInt]
    children*: seq[ref Recursive_tree]
proc `=copy`(a: var Recursive_tree; b: Recursive_tree) {.
    error.}
proc equals(_: typedesc[Recursive_tree]; a, b: Recursive_tree): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.weight), a.weight, b.weight) and
      equals(typeof(a.children), a.children, b.children)

proc `==`*(a, b: Recursive_tree): bool =
  return equals(Recursive_tree, a, b)

proc stringify(_: typedesc[Recursive_tree]; value: Recursive_tree): string =
  stringifyObj("Recursive_tree",
               ("name", stringify(typeof(value.name), value.name)),
               ("weight", stringify(typeof(value.weight), value.weight)),
               ("children", stringify(typeof(value.children), value.children)))

proc `$`*(value: Recursive_tree): string =
  stringify(Recursive_tree, value)

proc fromJsonHook*(target: var Recursive_tree; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Recursive_tree")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  if hasKey(source, "weight") and source{"weight"}.kind != JNull:
    target.weight = some(jsonTo(source{"weight"},
                                typeof(unsafeGet(target.weight))))
  if hasKey(source, "children") and source{"children"}.kind != JNull:
    target.children = jsonTo(source{"children"}, typeof(target.children))

proc toJsonHook*(source: Recursive_tree): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  if isSome(source.weight):
    result{"weight"} = newJInt(unsafeGet(source.weight))
  if len(source.children) > 0:
    result{"children"} = block:
      let cursor {.cursor.} = source.children
      var output = newJArray()
      for entry in cursor:
        output.add(toJson(entry))
      output

proc toStream*(source: Recursive_tree; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  if isSome(source.weight):
    hasEmitted.writeComma(target)
    write(target, escapeJson("weight"))
    write(target, ':')
    toStream(unsafeGet(source.weight), target)
  if len(source.children) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("children"))
    write(target, ':')
    toStream(source.children, target)
  target.write('}')

proc fromStream*(typ: typedesc[Recursive_tree];
                 source: var JsonParser): Recursive_tree =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    of "weight":
      result.weight = some(fromStream(typeof(unsafeGet(result.weight)), source))
    of "children":
      result.children = fromStream(typeof(result.children), source)
    else:
      skipValue(source)
  assert(card(seen) == 1)

{.pop.}
