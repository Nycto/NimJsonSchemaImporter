{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Merged_scalarsTypedEnum* = enum
    Alpha = "alpha", Beta = "beta"
  Merged_scalars* {.byref.} = object
    typedEnum*: Merged_scalarsTypedEnum
    intEnum*: BiggestInt
    formatted*: string
    openMap*: OrderedTable[string, string]
proc `=copy`(a: var Merged_scalars; b: Merged_scalars) {.
    error.}
proc toJsonHook*(source: Merged_scalars): JsonNode
proc equals(_: typedesc[Merged_scalars]; a, b: Merged_scalars): bool =
  equals(typeof(a.typedEnum), a.typedEnum, b.typedEnum) and
      equals(typeof(a.intEnum), a.intEnum, b.intEnum) and
      equals(typeof(a.formatted), a.formatted, b.formatted) and
      equals(typeof(a.openMap), a.openMap, b.openMap)

proc `==`*(a, b: Merged_scalars): bool =
  return equals(Merged_scalars, a, b)

proc stringify(_: typedesc[Merged_scalars]; value: Merged_scalars): string =
  stringifyObj("Merged_scalars", ("typedEnum", stringify(
      typeof(value.typedEnum), value.typedEnum)),
               ("intEnum", stringify(typeof(value.intEnum), value.intEnum)), (
      "formatted", stringify(typeof(value.formatted), value.formatted)),
               ("openMap", stringify(typeof(value.openMap), value.openMap)))

proc `$`*(value: Merged_scalars): string =
  stringify(Merged_scalars, value)

proc fromJsonHook*(target: var Merged_scalars; source: JsonNode) =
  assert(hasKey(source, "typedEnum"),
         "typedEnum" & " is missing while decoding " & "Merged_scalars")
  target.typedEnum = jsonTo(source{"typedEnum"}, typeof(target.typedEnum))
  assert(hasKey(source, "intEnum"),
         "intEnum" & " is missing while decoding " & "Merged_scalars")
  target.intEnum = jsonTo(source{"intEnum"}, typeof(target.intEnum))
  assert(hasKey(source, "formatted"),
         "formatted" & " is missing while decoding " & "Merged_scalars")
  target.formatted = jsonTo(source{"formatted"}, typeof(target.formatted))
  if hasKey(source, "openMap") and source{"openMap"}.kind != JNull:
    target.openMap = jsonTo(source{"openMap"}, typeof(target.openMap))

proc toJsonHook*(source: Merged_scalars): JsonNode =
  result = newJObject()
  result{"typedEnum"} = `%`(source.typedEnum)
  result{"intEnum"} = newJInt(source.intEnum)
  result{"formatted"} = newJString(source.formatted)
  if len(source.openMap) > 0:
    result{"openMap"} = block:
      let cursor {.cursor.} = source.openMap
      var output = newJObject()
      for key in keys(cursor):
        output[key] = newJString(
            cursor[key])
      output

proc toStream*(source: Merged_scalars; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("typedEnum"))
  write(target, ':')
  toStream(source.typedEnum, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("intEnum"))
  write(target, ':')
  toStream(source.intEnum, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("formatted"))
  write(target, ':')
  toStream(source.formatted, target)
  if len(source.openMap) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("openMap"))
    write(target, ':')
    toStream(source.openMap, target)
  target.write('}')

proc fromStream*(typ: typedesc[Merged_scalars];
                 source: var JsonParser): Merged_scalars =
  var seen: set[0 .. 2]
  for key in objectKeys(source):
    case key
    of "typedEnum":
      result.typedEnum = fromStream(typeof(result.typedEnum), source)
      seen.incl(0)
    of "intEnum":
      result.intEnum = fromStream(typeof(result.intEnum), source)
      seen.incl(1)
    of "formatted":
      result.formatted = fromStream(typeof(result.formatted), source)
      seen.incl(2)
    of "openMap":
      result.openMap = fromStream(typeof(result.openMap), source)
    else:
      skipValue(source)
  assert(card(seen) == 3)

{.pop.}
