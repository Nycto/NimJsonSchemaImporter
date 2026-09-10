{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  TuplesRecord* {.byref.} = object
    tag*: string
  TuplesTagged* {.byref.} = object
  TuplesUnion* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: (BiggestInt, BiggestInt)
    of 1:
      key1*: string
  Tuples* {.byref.} = object
    point*: (BiggestFloat, BiggestFloat)
    record*: (string, BiggestInt, TuplesRecord)
    path*: seq[(BiggestInt, BiggestInt)]
    tagged*: (TuplesTagged, string)
    either*: TuplesUnion
    span*: Option[(BiggestInt, BiggestInt)]
proc `=copy`(a: var TuplesRecord; b: TuplesRecord) {.error.}
proc toJsonHook*(source: TuplesRecord): JsonNode
proc `=copy`(a: var TuplesTagged; b: TuplesTagged) {.error.}
proc `=copy`(a: var Tuples; b: Tuples) {.error.}
proc toJsonHook*(source: Tuples): JsonNode
proc equals(_: typedesc[TuplesRecord]; a, b: TuplesRecord): bool =
  equals(typeof(a.tag), a.tag, b.tag)

proc `==`*(a, b: TuplesRecord): bool =
  return equals(TuplesRecord, a, b)

proc stringify(_: typedesc[TuplesRecord]; value: TuplesRecord): string =
  stringifyObj("TuplesRecord", ("tag", stringify(typeof(value.tag), value.tag)))

proc `$`*(value: TuplesRecord): string =
  stringify(TuplesRecord, value)

proc fromJsonHook*(target: var TuplesRecord; source: JsonNode) =
  assert(hasKey(source, "tag"),
         "tag" & " is missing while decoding " & "TuplesRecord")
  target.tag = jsonTo(source{"tag"}, typeof(target.tag))

proc toJsonHook*(source: TuplesRecord): JsonNode =
  result = newJObject()
  result{"tag"} = newJString(source.tag)

proc toStream*(source: TuplesRecord; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("tag"))
  write(target, ':')
  toStream(source.tag, target)
  target.write('}')

proc fromStream*(typ: typedesc[TuplesRecord]; source: var JsonParser): TuplesRecord =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "tag":
      result.tag = fromStream(typeof(result.tag), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

proc equals(_: typedesc[TuplesTagged]; a, b: TuplesTagged): bool =
  true

proc `==`*(a, b: TuplesTagged): bool =
  return equals(TuplesTagged, a, b)

proc stringify(_: typedesc[TuplesTagged]; value: TuplesTagged): string =
  "\"kind\""

proc `$`*(value: TuplesTagged): string =
  stringify(TuplesTagged, value)

proc fromJsonHook*(target: var TuplesTagged; source: JsonNode) =
  discard

proc toJsonHook*(source: TuplesTagged): JsonNode =
  newJString("kind")

proc toStream*(source: TuplesTagged; target: Stream) =
  write(target, "\"kind\"")

proc fromStream*(typ: typedesc[TuplesTagged]; source: var JsonParser): TuplesTagged =
  skipValue(source)

converter forTuplesUnion*(value: (BiggestInt, BiggestInt)): TuplesUnion =
  return TuplesUnion(kind: 0, key0: value)

converter forTuplesUnion*(value: string): TuplesUnion =
  return TuplesUnion(kind: 1, key1: value)

proc equals(_: typedesc[TuplesUnion]; a, b: TuplesUnion): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: TuplesUnion): bool =
  return equals(TuplesUnion, a, b)

proc stringify(_: typedesc[TuplesUnion]; value: TuplesUnion): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: TuplesUnion): string =
  stringify(TuplesUnion, value)

proc fromJsonHook*(target: var TuplesUnion; source: JsonNode) =
  if source.kind == JArray and len(source) == 2:
    target = TuplesUnion(kind: 0, key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JString:
    target = TuplesUnion(kind: 1, key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to TuplesUnion")
  
proc toJsonHook*(source: TuplesUnion): JsonNode =
  case source.kind
  of 0:
    JsonNode(kind: JArray,
             elems: @[newJInt(source.key0[0]), newJInt(source.key0[1])])
  of 1:
    newJString(source.key1)
  
proc isTuple*(value: TuplesUnion): bool =
  value.kind == 0

proc asTuple*(value: TuplesUnion): auto =
  assert(value.kind == 0)
  return value.key0

proc isTupleOfIntAndInt*(value: TuplesUnion): bool =
  value.kind == 0

proc asTupleOfIntAndInt*(value: TuplesUnion): auto =
  assert(value.kind == 0)
  return value.key0

proc isStr*(value: TuplesUnion): bool =
  value.kind == 1

proc asStr*(value: TuplesUnion): auto =
  assert(value.kind == 1)
  return value.key1

proc toBinary*(target: var string; source: TuplesUnion) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[TuplesUnion]; source: string; idx: var int): TuplesUnion =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return TuplesUnion(kind: 0,
                       key0: fromBinary(typeof(result.key0), source, idx))
  of 1:
    return TuplesUnion(kind: 1,
                       key1: fromBinary(typeof(result.key1), source, idx))
  
proc toStream*(source: TuplesUnion; target: Stream) =
  case source.kind
  of 0:
    toStream(source.key0, target)
  of 1:
    toStream(source.key1, target)
  
proc fromStream*(typ: typedesc[TuplesUnion]; source: var JsonParser): TuplesUnion =
  jsonTo(fromStream(JsonNode, source), TuplesUnion)

proc equals(_: typedesc[Tuples]; a, b: Tuples): bool =
  equals(typeof(a.point), a.point, b.point) and
      equals(typeof(a.record), a.record, b.record) and
      equals(typeof(a.path), a.path, b.path) and
      equals(typeof(a.tagged), a.tagged, b.tagged) and
      equals(typeof(a.either), a.either, b.either) and
      equals(typeof(a.span), a.span, b.span)

proc `==`*(a, b: Tuples): bool =
  return equals(Tuples, a, b)

proc stringify(_: typedesc[Tuples]; value: Tuples): string =
  stringifyObj("Tuples",
               ("point", stringify(typeof(value.point), value.point)),
               ("record", stringify(typeof(value.record), value.record)),
               ("path", stringify(typeof(value.path), value.path)),
               ("tagged", stringify(typeof(value.tagged), value.tagged)),
               ("either", stringify(typeof(value.either), value.either)),
               ("span", stringify(typeof(value.span), value.span)))

proc `$`*(value: Tuples): string =
  stringify(Tuples, value)

proc fromJsonHook*(target: var Tuples; source: JsonNode) =
  assert(hasKey(source, "point"),
         "point" & " is missing while decoding " & "Tuples")
  target.point = jsonTo(source{"point"}, typeof(target.point))
  assert(hasKey(source, "record"),
         "record" & " is missing while decoding " & "Tuples")
  target.record = jsonTo(source{"record"}, typeof(target.record))
  if hasKey(source, "path") and source{"path"}.kind != JNull:
    target.path = jsonTo(source{"path"}, typeof(target.path))
  assert(hasKey(source, "tagged"),
         "tagged" & " is missing while decoding " & "Tuples")
  target.tagged = jsonTo(source{"tagged"}, typeof(target.tagged))
  assert(hasKey(source, "either"),
         "either" & " is missing while decoding " & "Tuples")
  target.either = jsonTo(source{"either"}, typeof(target.either))
  if hasKey(source, "span") and source{"span"}.kind != JNull:
    target.span = some(jsonTo(source{"span"}, typeof(unsafeGet(target.span))))

proc toJsonHook*(source: Tuples): JsonNode =
  result = newJObject()
  result{"point"} = JsonNode(kind: JArray, elems: @[newJFloat(source.point[0]),
      newJFloat(source.point[1])])
  result{"record"} = JsonNode(kind: JArray, elems: @[
      newJString(source.record[0]), newJInt(source.record[1]),
      toJsonHook(source.record[2])])
  if len(source.path) > 0:
    result{"path"} = block:
      let cursor {.cursor.} = source.path
      var output = newJArray()
      for entry in cursor:
        output.add(JsonNode(kind: JArray, elems: @[
            newJInt(entry[0]), newJInt(entry[1])]))
      output
  result{"tagged"} = JsonNode(kind: JArray, elems: @[newJString("kind"),
      newJString(source.tagged[1])])
  result{"either"} = toJsonHook(source.either)
  if isSome(source.span):
    result{"span"} = JsonNode(kind: JArray, elems: @[
        newJInt(unsafeGet(source.span)[0]), newJInt(unsafeGet(source.span)[1])])

proc toStream*(source: Tuples; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("point"))
  write(target, ':')
  toStream(source.point, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("record"))
  write(target, ':')
  toStream(source.record, target)
  if len(source.path) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("path"))
    write(target, ':')
    toStream(source.path, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("tagged"))
  write(target, ':')
  toStream(source.tagged, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("either"))
  write(target, ':')
  toStream(source.either, target)
  if isSome(source.span):
    hasEmitted.writeComma(target)
    write(target, escapeJson("span"))
    write(target, ':')
    toStream(unsafeGet(source.span), target)
  target.write('}')

proc fromStream*(typ: typedesc[Tuples]; source: var JsonParser): Tuples =
  var seen: set[0 .. 3]
  for key in objectKeys(source):
    case key
    of "point":
      result.point = fromStream(typeof(result.point), source)
      seen.incl(0)
    of "record":
      result.record = fromStream(typeof(result.record), source)
      seen.incl(1)
    of "path":
      result.path = fromStream(typeof(result.path), source)
    of "tagged":
      result.tagged = fromStream(typeof(result.tagged), source)
      seen.incl(2)
    of "either":
      result.either = fromStream(typeof(result.either), source)
      seen.incl(3)
    of "span":
      result.span = some(fromStream(typeof(unsafeGet(result.span)), source))
    else:
      skipValue(source)
  assert(card(seen) == 4)

{.pop.}
