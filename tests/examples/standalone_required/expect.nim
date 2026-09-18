{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/validate as jsonSchemaValidate
import json_schema_import/private/[equality, bin, sax, empty]

type
  Standalone_requiredSplit* {.byref.} = object
    a*: string
  Standalone_requiredTightened* {.byref.} = object
    name*: string
  Standalone_requiredUntyped* {.byref.} = object
    known*: string
    anything*: JsonNode
  Standalone_required* {.byref.} = object
    split*: Standalone_requiredSplit
    tightened*: Standalone_requiredTightened
    untyped*: Standalone_requiredUntyped
proc `=copy`(a: var Standalone_requiredSplit;
             b: Standalone_requiredSplit) {.error.}
proc `=copy`(a: var Standalone_requiredTightened;
             b: Standalone_requiredTightened) {.error.}
proc `=copy`(a: var Standalone_requiredUntyped;
             b: Standalone_requiredUntyped) {.error.}
proc `=copy`(a: var Standalone_required;
             b: Standalone_required) {.error.}
proc equals(_: typedesc[Standalone_requiredSplit];
            a, b: Standalone_requiredSplit): bool =
  equals(typeof(a.a), a.a, b.a)

proc `==`*(a, b: Standalone_requiredSplit): bool =
  return equals(Standalone_requiredSplit, a, b)

proc stringify(_: typedesc[Standalone_requiredSplit];
               value: Standalone_requiredSplit): string =
  stringifyObj("Standalone_requiredSplit",
               ("a", stringify(typeof(value.a), value.a)))

proc `$`*(value: Standalone_requiredSplit): string =
  stringify(Standalone_requiredSplit, value)

proc fromJsonHook*(target: var Standalone_requiredSplit; source: JsonNode) =
  assert(hasKey(source, "a"),
         "a" & " is missing while decoding " & "Standalone_requiredSplit")
  target.a = jsonTo(source{"a"}, typeof(target.a))

proc toJsonHook*(source: Standalone_requiredSplit): JsonNode =
  result = newJObject()
  result{"a"} = newJString(source.a)

proc toStream*(source: Standalone_requiredSplit; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("a"))
  write(target, ':')
  toStream(source.a, target)
  target.write('}')

proc fromStream*(typ: typedesc[Standalone_requiredSplit];
                 source: var JsonParser): Standalone_requiredSplit =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "a":
      result.a = fromStream(typeof(result.a), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

proc equals(_: typedesc[Standalone_requiredTightened];
            a, b: Standalone_requiredTightened): bool =
  equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: Standalone_requiredTightened): bool =
  return equals(Standalone_requiredTightened, a, b)

proc stringify(_: typedesc[Standalone_requiredTightened];
               value: Standalone_requiredTightened): string =
  stringifyObj("Standalone_requiredTightened",
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: Standalone_requiredTightened): string =
  stringify(Standalone_requiredTightened, value)

proc fromJsonHook*(target: var Standalone_requiredTightened; source: JsonNode) =
  assert(hasKey(source, "name"), "name" & " is missing while decoding " &
      "Standalone_requiredTightened")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: Standalone_requiredTightened): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)

proc toStream*(source: Standalone_requiredTightened; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  target.write('}')

proc fromStream*(typ: typedesc[Standalone_requiredTightened];
                 source: var JsonParser): Standalone_requiredTightened =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

proc equals(_: typedesc[Standalone_requiredUntyped];
            a, b: Standalone_requiredUntyped): bool =
  equals(typeof(a.known), a.known, b.known) and
      equals(typeof(a.anything), a.anything, b.anything)

proc `==`*(a, b: Standalone_requiredUntyped): bool =
  return equals(Standalone_requiredUntyped, a, b)

proc stringify(_: typedesc[Standalone_requiredUntyped];
               value: Standalone_requiredUntyped): string =
  stringifyObj("Standalone_requiredUntyped",
               ("known", stringify(typeof(value.known), value.known)),
               ("anything", stringify(typeof(value.anything), value.anything)))

proc `$`*(value: Standalone_requiredUntyped): string =
  stringify(Standalone_requiredUntyped, value)

proc fromJsonHook*(target: var Standalone_requiredUntyped; source: JsonNode) =
  assert(hasKey(source, "known"),
         "known" & " is missing while decoding " & "Standalone_requiredUntyped")
  target.known = jsonTo(source{"known"}, typeof(target.known))
  assert(hasKey(source, "anything"), "anything" & " is missing while decoding " &
      "Standalone_requiredUntyped")
  target.anything = jsonTo(source{"anything"}, typeof(target.anything))

proc toJsonHook*(source: Standalone_requiredUntyped): JsonNode =
  result = newJObject()
  result{"known"} = newJString(source.known)
  result{"anything"} = source.anything

proc toStream*(source: Standalone_requiredUntyped; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("known"))
  write(target, ':')
  toStream(source.known, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("anything"))
  write(target, ':')
  toStream(source.anything, target)
  target.write('}')

proc fromStream*(typ: typedesc[Standalone_requiredUntyped];
                 source: var JsonParser): Standalone_requiredUntyped =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "known":
      result.known = fromStream(typeof(result.known), source)
      seen.incl(0)
    of "anything":
      result.anything = fromStream(typeof(result.anything), source)
      seen.incl(1)
    else:
      skipValue(source)
  assert(card(seen) == 2)

proc equals(_: typedesc[Standalone_required]; a, b: Standalone_required): bool =
  equals(typeof(a.split), a.split, b.split) and
      equals(typeof(a.tightened), a.tightened, b.tightened) and
      equals(typeof(a.untyped), a.untyped, b.untyped)

proc `==`*(a, b: Standalone_required): bool =
  return equals(Standalone_required, a, b)

proc stringify(_: typedesc[Standalone_required]; value: Standalone_required): string =
  stringifyObj("Standalone_required",
               ("split", stringify(typeof(value.split), value.split)), (
      "tightened", stringify(typeof(value.tightened), value.tightened)),
               ("untyped", stringify(typeof(value.untyped), value.untyped)))

proc `$`*(value: Standalone_required): string =
  stringify(Standalone_required, value)

proc fromJsonHook*(target: var Standalone_required; source: JsonNode) =
  assert(hasKey(source, "split"),
         "split" & " is missing while decoding " & "Standalone_required")
  target.split = jsonTo(source{"split"}, typeof(target.split))
  assert(hasKey(source, "tightened"),
         "tightened" & " is missing while decoding " & "Standalone_required")
  target.tightened = jsonTo(source{"tightened"}, typeof(target.tightened))
  assert(hasKey(source, "untyped"),
         "untyped" & " is missing while decoding " & "Standalone_required")
  target.untyped = jsonTo(source{"untyped"}, typeof(target.untyped))

proc toJsonHook*(source: Standalone_required): JsonNode =
  result = newJObject()
  result{"split"} = toJsonHook(source.split)
  result{"tightened"} = toJsonHook(source.tightened)
  result{"untyped"} = toJsonHook(source.untyped)

proc toStream*(source: Standalone_required; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("split"))
  write(target, ':')
  toStream(source.split, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("tightened"))
  write(target, ':')
  toStream(source.tightened, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("untyped"))
  write(target, ':')
  toStream(source.untyped, target)
  target.write('}')

proc fromStream*(typ: typedesc[Standalone_required];
                 source: var JsonParser): Standalone_required =
  var seen: set[0 .. 2]
  for key in objectKeys(source):
    case key
    of "split":
      result.split = fromStream(typeof(result.split), source)
      seen.incl(0)
    of "tightened":
      result.tightened = fromStream(typeof(result.tightened), source)
      seen.incl(1)
    of "untyped":
      result.untyped = fromStream(typeof(result.untyped), source)
      seen.incl(2)
    else:
      skipValue(source)
  assert(card(seen) == 3)

{.pop.}
