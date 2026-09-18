{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/validate as jsonSchemaValidate
import json_schema_import/private/[equality, bin, sax, empty]

type
  Mutual_refsAnswer* {.byref.} = object
    text*: string
    followUp*: Option[ref Mutual_refsQuestion]
  Mutual_refsQuestion* {.byref.} = object
    prompt*: string
    answer*: Option[Mutual_refsAnswer]
  Mutual_refs* {.byref.} = object
    top*: Mutual_refsQuestion
proc `=copy`(a: var Mutual_refsAnswer;
             b: Mutual_refsAnswer) {.error.}
proc `=copy`(a: var Mutual_refsQuestion;
             b: Mutual_refsQuestion) {.error.}
proc equals(_: typedesc[Mutual_refsQuestion]; a, b: Mutual_refsQuestion): bool
proc `==`*(a, b: Mutual_refsQuestion): bool
proc stringify(_: typedesc[Mutual_refsQuestion]; value: Mutual_refsQuestion): string
proc `$`*(value: Mutual_refsQuestion): string
proc fromJsonHook*(target: var Mutual_refsQuestion; source: JsonNode)
proc toJsonHook*(source: Mutual_refsQuestion): JsonNode
proc toStream*(source: Mutual_refsQuestion; target: Stream)
proc fromStream*(typ: typedesc[Mutual_refsQuestion];
                 source: var JsonParser): Mutual_refsQuestion
proc `=copy`(a: var Mutual_refs; b: Mutual_refs) {.error.}
proc equals(_: typedesc[Mutual_refsAnswer]; a, b: Mutual_refsAnswer): bool =
  equals(typeof(a.text), a.text, b.text) and
      equals(typeof(a.followUp), a.followUp, b.followUp)

proc `==`*(a, b: Mutual_refsAnswer): bool =
  return equals(Mutual_refsAnswer, a, b)

proc stringify(_: typedesc[Mutual_refsAnswer]; value: Mutual_refsAnswer): string =
  stringifyObj("Mutual_refsAnswer",
               ("text", stringify(typeof(value.text), value.text)),
               ("followUp", stringify(typeof(value.followUp), value.followUp)))

proc `$`*(value: Mutual_refsAnswer): string =
  stringify(Mutual_refsAnswer, value)

proc fromJsonHook*(target: var Mutual_refsAnswer; source: JsonNode) =
  assert(hasKey(source, "text"),
         "text" & " is missing while decoding " & "Mutual_refsAnswer")
  target.text = jsonTo(source{"text"}, typeof(target.text))
  if hasKey(source, "followUp") and source{"followUp"}.kind != JNull:
    target.followUp = some(jsonTo(source{"followUp"},
                                  typeof(unsafeGet(target.followUp))))
  when not defined(jsonSchemaNoValidate):
    validate(Mutual_refsAnswer, target)

proc toJsonHook*(source: Mutual_refsAnswer): JsonNode =
  result = newJObject()
  result{"text"} = newJString(source.text)
  if isSome(source.followUp):
    result{"followUp"} = toJson(unsafeGet(source.followUp))

proc toStream*(source: Mutual_refsAnswer; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("text"))
  write(target, ':')
  toStream(source.text, target)
  if isSome(source.followUp):
    hasEmitted.writeComma(target)
    write(target, escapeJson("followUp"))
    write(target, ':')
    toStream(unsafeGet(source.followUp), target)
  target.write('}')

proc fromStream*(typ: typedesc[Mutual_refsAnswer];
                 source: var JsonParser): Mutual_refsAnswer =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "text":
      result.text = fromStream(typeof(result.text), source)
      seen.incl(0)
    of "followUp":
      result.followUp = some(fromStream(typeof(unsafeGet(result.followUp)),
                                        source))
    else:
      skipValue(source)
  assert(card(seen) == 1)
  when not defined(jsonSchemaNoValidate):
    validate(Mutual_refsAnswer, result)

proc equals(_: typedesc[Mutual_refsQuestion]; a, b: Mutual_refsQuestion): bool =
  equals(typeof(a.prompt), a.prompt, b.prompt) and
      equals(typeof(a.answer), a.answer, b.answer)

proc `==`*(a, b: Mutual_refsQuestion): bool =
  return equals(Mutual_refsQuestion, a, b)

proc stringify(_: typedesc[Mutual_refsQuestion]; value: Mutual_refsQuestion): string =
  stringifyObj("Mutual_refsQuestion",
               ("prompt", stringify(typeof(value.prompt), value.prompt)),
               ("answer", stringify(typeof(value.answer), value.answer)))

proc `$`*(value: Mutual_refsQuestion): string =
  stringify(Mutual_refsQuestion, value)

proc fromJsonHook*(target: var Mutual_refsQuestion; source: JsonNode) =
  assert(hasKey(source, "prompt"),
         "prompt" & " is missing while decoding " & "Mutual_refsQuestion")
  target.prompt = jsonTo(source{"prompt"}, typeof(target.prompt))
  if hasKey(source, "answer") and source{"answer"}.kind != JNull:
    target.answer = some(jsonTo(source{"answer"},
                                typeof(unsafeGet(target.answer))))
  when not defined(jsonSchemaNoValidate):
    validate(Mutual_refsQuestion, target)

proc toJsonHook*(source: Mutual_refsQuestion): JsonNode =
  result = newJObject()
  result{"prompt"} = newJString(source.prompt)
  if isSome(source.answer):
    result{"answer"} = toJsonHook(unsafeGet(source.answer))

proc toStream*(source: Mutual_refsQuestion; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("prompt"))
  write(target, ':')
  toStream(source.prompt, target)
  if isSome(source.answer):
    hasEmitted.writeComma(target)
    write(target, escapeJson("answer"))
    write(target, ':')
    toStream(unsafeGet(source.answer), target)
  target.write('}')

proc fromStream*(typ: typedesc[Mutual_refsQuestion];
                 source: var JsonParser): Mutual_refsQuestion =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "prompt":
      result.prompt = fromStream(typeof(result.prompt), source)
      seen.incl(0)
    of "answer":
      result.answer = some(fromStream(typeof(unsafeGet(result.answer)), source))
    else:
      skipValue(source)
  assert(card(seen) == 1)
  when not defined(jsonSchemaNoValidate):
    validate(Mutual_refsQuestion, result)

proc equals(_: typedesc[Mutual_refs]; a, b: Mutual_refs): bool =
  equals(typeof(a.top), a.top, b.top)

proc `==`*(a, b: Mutual_refs): bool =
  return equals(Mutual_refs, a, b)

proc stringify(_: typedesc[Mutual_refs]; value: Mutual_refs): string =
  stringifyObj("Mutual_refs", ("top", stringify(typeof(value.top), value.top)))

proc `$`*(value: Mutual_refs): string =
  stringify(Mutual_refs, value)

proc fromJsonHook*(target: var Mutual_refs; source: JsonNode) =
  assert(hasKey(source, "top"),
         "top" & " is missing while decoding " & "Mutual_refs")
  target.top = jsonTo(source{"top"}, typeof(target.top))
  when not defined(jsonSchemaNoValidate):
    validate(Mutual_refs, target)

proc toJsonHook*(source: Mutual_refs): JsonNode =
  result = newJObject()
  result{"top"} = toJsonHook(source.top)

proc toStream*(source: Mutual_refs; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("top"))
  write(target, ':')
  toStream(source.top, target)
  target.write('}')

proc fromStream*(typ: typedesc[Mutual_refs]; source: var JsonParser): Mutual_refs =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "top":
      result.top = fromStream(typeof(result.top), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)
  when not defined(jsonSchemaNoValidate):
    validate(Mutual_refs, result)

{.pop.}
