{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  All_ofCombined* {.byref.} = object
    a*: string
    b*: BiggestInt
  All_ofExtended* {.byref.} = object
    extra*: bool
    name*: string
  All_ofNarrowed* = enum
    One = "one", Two = "two"
  All_of* {.byref.} = object
    combined*: All_ofCombined
    extended*: All_ofExtended
    narrowed*: All_ofNarrowed
proc `=copy`(a: var All_ofCombined; b: All_ofCombined) {.
    error.}
proc toJsonHook*(source: All_ofCombined): JsonNode
proc `=copy`(a: var All_ofExtended; b: All_ofExtended) {.
    error.}
proc toJsonHook*(source: All_ofExtended): JsonNode
proc `=copy`(a: var All_of; b: All_of) {.error.}
proc toJsonHook*(source: All_of): JsonNode
proc equals(_: typedesc[All_ofCombined]; a, b: All_ofCombined): bool =
  equals(typeof(a.a), a.a, b.a) and equals(typeof(a.b), a.b, b.b)

proc `==`*(a, b: All_ofCombined): bool =
  return equals(All_ofCombined, a, b)

proc stringify(_: typedesc[All_ofCombined]; value: All_ofCombined): string =
  stringifyObj("All_ofCombined", ("a", stringify(typeof(value.a), value.a)),
               ("b", stringify(typeof(value.b), value.b)))

proc `$`*(value: All_ofCombined): string =
  stringify(All_ofCombined, value)

proc fromJsonHook*(target: var All_ofCombined; source: JsonNode) =
  assert(hasKey(source, "a"),
         "a" & " is missing while decoding " & "All_ofCombined")
  target.a = jsonTo(source{"a"}, typeof(target.a))
  assert(hasKey(source, "b"),
         "b" & " is missing while decoding " & "All_ofCombined")
  target.b = jsonTo(source{"b"}, typeof(target.b))

proc toJsonHook*(source: All_ofCombined): JsonNode =
  result = newJObject()
  result{"a"} = newJString(source.a)
  result{"b"} = newJInt(source.b)

proc toStream*(source: All_ofCombined; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("a"))
  write(target, ':')
  toStream(source.a, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("b"))
  write(target, ':')
  toStream(source.b, target)
  target.write('}')

proc fromStream*(typ: typedesc[All_ofCombined];
                 source: var JsonParser): All_ofCombined =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "a":
      result.a = fromStream(typeof(result.a), source)
      seen.incl(0)
    of "b":
      result.b = fromStream(typeof(result.b), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

proc equals(_: typedesc[All_ofExtended]; a, b: All_ofExtended): bool =
  equals(typeof(a.extra), a.extra, b.extra) and
      equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: All_ofExtended): bool =
  return equals(All_ofExtended, a, b)

proc stringify(_: typedesc[All_ofExtended]; value: All_ofExtended): string =
  stringifyObj("All_ofExtended",
               ("extra", stringify(typeof(value.extra), value.extra)),
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: All_ofExtended): string =
  stringify(All_ofExtended, value)

proc fromJsonHook*(target: var All_ofExtended; source: JsonNode) =
  assert(hasKey(source, "extra"),
         "extra" & " is missing while decoding " & "All_ofExtended")
  target.extra = jsonTo(source{"extra"}, typeof(target.extra))
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "All_ofExtended")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: All_ofExtended): JsonNode =
  result = newJObject()
  result{"extra"} = newJBool(source.extra)
  result{"name"} = newJString(source.name)

proc toStream*(source: All_ofExtended; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("extra"))
  write(target, ':')
  toStream(source.extra, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  target.write('}')

proc fromStream*(typ: typedesc[All_ofExtended];
                 source: var JsonParser): All_ofExtended =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "extra":
      result.extra = fromStream(typeof(result.extra), source)
      seen.incl(0)
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

proc equals(_: typedesc[All_of]; a, b: All_of): bool =
  equals(typeof(a.combined), a.combined, b.combined) and
      equals(typeof(a.extended), a.extended, b.extended) and
      equals(typeof(a.narrowed), a.narrowed, b.narrowed)

proc `==`*(a, b: All_of): bool =
  return equals(All_of, a, b)

proc stringify(_: typedesc[All_of]; value: All_of): string =
  stringifyObj("All_of", ("combined",
                          stringify(typeof(value.combined), value.combined)), (
      "extended", stringify(typeof(value.extended), value.extended)),
               ("narrowed", stringify(typeof(value.narrowed), value.narrowed)))

proc `$`*(value: All_of): string =
  stringify(All_of, value)

proc fromJsonHook*(target: var All_of; source: JsonNode) =
  assert(hasKey(source, "combined"),
         "combined" & " is missing while decoding " & "All_of")
  target.combined = jsonTo(source{"combined"}, typeof(target.combined))
  assert(hasKey(source, "extended"),
         "extended" & " is missing while decoding " & "All_of")
  target.extended = jsonTo(source{"extended"}, typeof(target.extended))
  assert(hasKey(source, "narrowed"),
         "narrowed" & " is missing while decoding " & "All_of")
  target.narrowed = jsonTo(source{"narrowed"}, typeof(target.narrowed))

proc toJsonHook*(source: All_of): JsonNode =
  result = newJObject()
  result{"combined"} = toJsonHook(source.combined)
  result{"extended"} = toJsonHook(source.extended)
  result{"narrowed"} = `%`(source.narrowed)

proc toStream*(source: All_of; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("combined"))
  write(target, ':')
  toStream(source.combined, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("extended"))
  write(target, ':')
  toStream(source.extended, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("narrowed"))
  write(target, ':')
  toStream(source.narrowed, target)
  target.write('}')

proc fromStream*(typ: typedesc[All_of]; source: var JsonParser): All_of =
  var seen: set[0 .. 2]
  for key in objectKeys(source):
    case key
    of "combined":
      result.combined = fromStream(typeof(result.combined), source)
      seen.incl(0)
    of "extended":
      result.extended = fromStream(typeof(result.extended), source)
      seen.incl(1)
    of "narrowed":
      result.narrowed = fromStream(typeof(result.narrowed), source)
      seen.incl(2)
    else:
      skipValue(source)
  assert(card(seen) == 3)

{.pop.}
