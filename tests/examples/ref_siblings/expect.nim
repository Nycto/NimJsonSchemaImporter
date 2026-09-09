{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Ref_siblingsEntry* {.byref.} = object
    name*: string
  Ref_siblingsNarrowed* {.byref.} = object
    name*: string
    count*: BiggestInt
  Ref_siblingsTagged* = enum
    Red = "red", Green = "green"
  Ref_siblings* {.byref.} = object
    plain*: Ref_siblingsEntry
    described*: Ref_siblingsEntry
    narrowed*: Ref_siblingsNarrowed
    tagged*: Ref_siblingsTagged
proc `=copy`(a: var Ref_siblingsEntry;
             b: Ref_siblingsEntry) {.error.}
proc toJsonHook*(source: Ref_siblingsEntry): JsonNode
proc `=copy`(a: var Ref_siblingsNarrowed;
             b: Ref_siblingsNarrowed) {.error.}
proc toJsonHook*(source: Ref_siblingsNarrowed): JsonNode
proc `=copy`(a: var Ref_siblings; b: Ref_siblings) {.error.}
proc toJsonHook*(source: Ref_siblings): JsonNode
proc equals(_: typedesc[Ref_siblingsEntry]; a, b: Ref_siblingsEntry): bool =
  equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: Ref_siblingsEntry): bool =
  return equals(Ref_siblingsEntry, a, b)

proc stringify(_: typedesc[Ref_siblingsEntry]; value: Ref_siblingsEntry): string =
  stringifyObj("Ref_siblingsEntry",
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: Ref_siblingsEntry): string =
  stringify(Ref_siblingsEntry, value)

proc fromJsonHook*(target: var Ref_siblingsEntry; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Ref_siblingsEntry")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: Ref_siblingsEntry): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)

proc toStream*(source: Ref_siblingsEntry; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  target.write('}')

proc fromStream*(typ: typedesc[Ref_siblingsEntry];
                 source: var JsonParser): Ref_siblingsEntry =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

proc equals(_: typedesc[Ref_siblingsNarrowed]; a, b: Ref_siblingsNarrowed): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.count), a.count, b.count)

proc `==`*(a, b: Ref_siblingsNarrowed): bool =
  return equals(Ref_siblingsNarrowed, a, b)

proc stringify(_: typedesc[Ref_siblingsNarrowed]; value: Ref_siblingsNarrowed): string =
  stringifyObj("Ref_siblingsNarrowed",
               ("name", stringify(typeof(value.name), value.name)),
               ("count", stringify(typeof(value.count), value.count)))

proc `$`*(value: Ref_siblingsNarrowed): string =
  stringify(Ref_siblingsNarrowed, value)

proc fromJsonHook*(target: var Ref_siblingsNarrowed; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Ref_siblingsNarrowed")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  assert(hasKey(source, "count"),
         "count" & " is missing while decoding " & "Ref_siblingsNarrowed")
  target.count = jsonTo(source{"count"}, typeof(target.count))

proc toJsonHook*(source: Ref_siblingsNarrowed): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  result{"count"} = newJInt(source.count)

proc toStream*(source: Ref_siblingsNarrowed; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("count"))
  write(target, ':')
  toStream(source.count, target)
  target.write('}')

proc fromStream*(typ: typedesc[Ref_siblingsNarrowed];
                 source: var JsonParser): Ref_siblingsNarrowed =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    of "count":
      result.count = fromStream(typeof(result.count), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

proc equals(_: typedesc[Ref_siblings]; a, b: Ref_siblings): bool =
  equals(typeof(a.plain), a.plain, b.plain) and
      equals(typeof(a.described), a.described, b.described) and
      equals(typeof(a.narrowed), a.narrowed, b.narrowed) and
      equals(typeof(a.tagged), a.tagged, b.tagged)

proc `==`*(a, b: Ref_siblings): bool =
  return equals(Ref_siblings, a, b)

proc stringify(_: typedesc[Ref_siblings]; value: Ref_siblings): string =
  stringifyObj("Ref_siblings",
               ("plain", stringify(typeof(value.plain), value.plain)), (
      "described", stringify(typeof(value.described), value.described)), (
      "narrowed", stringify(typeof(value.narrowed), value.narrowed)),
               ("tagged", stringify(typeof(value.tagged), value.tagged)))

proc `$`*(value: Ref_siblings): string =
  stringify(Ref_siblings, value)

proc fromJsonHook*(target: var Ref_siblings; source: JsonNode) =
  assert(hasKey(source, "plain"),
         "plain" & " is missing while decoding " & "Ref_siblings")
  target.plain = jsonTo(source{"plain"}, typeof(target.plain))
  assert(hasKey(source, "described"),
         "described" & " is missing while decoding " & "Ref_siblings")
  target.described = jsonTo(source{"described"}, typeof(target.described))
  assert(hasKey(source, "narrowed"),
         "narrowed" & " is missing while decoding " & "Ref_siblings")
  target.narrowed = jsonTo(source{"narrowed"}, typeof(target.narrowed))
  assert(hasKey(source, "tagged"),
         "tagged" & " is missing while decoding " & "Ref_siblings")
  target.tagged = jsonTo(source{"tagged"}, typeof(target.tagged))

proc toJsonHook*(source: Ref_siblings): JsonNode =
  result = newJObject()
  result{"plain"} = toJsonHook(source.plain)
  result{"described"} = toJsonHook(source.described)
  result{"narrowed"} = toJsonHook(source.narrowed)
  result{"tagged"} = `%`(source.tagged)

proc toStream*(source: Ref_siblings; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("plain"))
  write(target, ':')
  toStream(source.plain, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("described"))
  write(target, ':')
  toStream(source.described, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("narrowed"))
  write(target, ':')
  toStream(source.narrowed, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("tagged"))
  write(target, ':')
  toStream(source.tagged, target)
  target.write('}')

proc fromStream*(typ: typedesc[Ref_siblings]; source: var JsonParser): Ref_siblings =
  var seen: set[0 .. 3]
  for key in objectKeys(source):
    case key
    of "plain":
      result.plain = fromStream(typeof(result.plain), source)
      seen.incl(0)
    of "described":
      result.described = fromStream(typeof(result.described), source)
      seen.incl(1)
    of "narrowed":
      result.narrowed = fromStream(typeof(result.narrowed), source)
      seen.incl(2)
    of "tagged":
      result.tagged = fromStream(typeof(result.tagged), source)
      seen.incl(3)
    else:
      skipValue(source)
  assert(card(seen) == 4)

{.pop.}
