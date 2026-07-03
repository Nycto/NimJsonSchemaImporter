{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin, sax]

type
  Array_of_thingsVeggie* {.byref.} = object
    veggieName*: string
    veggieLike*: bool
  Array_of_things* {.byref.} = object
    fruits*: seq[string]
    vegetables*: seq[Array_of_thingsVeggie]
proc `=copy`(a: var Array_of_thingsVeggie;
             b: Array_of_thingsVeggie) {.error.}
proc toJsonHook*(source: Array_of_thingsVeggie): JsonNode
proc `=copy`(a: var Array_of_things; b: Array_of_things) {.
    error.}
proc toJsonHook*(source: Array_of_things): JsonNode
proc equals(_: typedesc[Array_of_thingsVeggie]; a, b: Array_of_thingsVeggie): bool =
  equals(typeof(a.veggieName), a.veggieName, b.veggieName) and
      equals(typeof(a.veggieLike), a.veggieLike, b.veggieLike)

proc `==`*(a, b: Array_of_thingsVeggie): bool =
  return equals(Array_of_thingsVeggie, a, b)

proc stringify(_: typedesc[Array_of_thingsVeggie]; value: Array_of_thingsVeggie): string =
  stringifyObj("Array_of_thingsVeggie", ("veggieName",
      stringify(typeof(value.veggieName), value.veggieName)), ("veggieLike",
      stringify(typeof(value.veggieLike), value.veggieLike)))

proc `$`*(value: Array_of_thingsVeggie): string =
  stringify(Array_of_thingsVeggie, value)

proc fromJsonHook*(target: var Array_of_thingsVeggie; source: JsonNode) =
  assert(hasKey(source, "veggieName"),
         "veggieName" & " is missing while decoding " & "Array_of_thingsVeggie")
  target.veggieName = jsonTo(source{"veggieName"}, typeof(target.veggieName))
  assert(hasKey(source, "veggieLike"),
         "veggieLike" & " is missing while decoding " & "Array_of_thingsVeggie")
  target.veggieLike = jsonTo(source{"veggieLike"}, typeof(target.veggieLike))

proc toJsonHook*(source: Array_of_thingsVeggie): JsonNode =
  result = newJObject()
  result{"veggieName"} = newJString(source.veggieName)
  result{"veggieLike"} = newJBool(source.veggieLike)

proc toStream*(source: Array_of_thingsVeggie; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("veggieName"))
  write(target, ':')
  toStream(source.veggieName, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("veggieLike"))
  write(target, ':')
  toStream(source.veggieLike, target)
  target.write('}')

proc fromStream*(typ: typedesc[Array_of_thingsVeggie];
                 source: var JsonParser): Array_of_thingsVeggie =
  var seen: set[0 .. 1]
  eat(source, tkCurlyLe)
  while source.tok != tkCurlyRi:
    expectString(source)
    let key = source.a
    discard getTok(source)
    eat(source, tkColon)
    case key
    of "veggieName":
      result.veggieName = fromStream(typeof(result.veggieName), source)
      seen.incl(0)
    of "veggieLike":
      result.veggieLike = fromStream(typeof(result.veggieLike), source)
      seen.incl(1)
    else:
      skipValue(source)
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkCurlyRi)
  assert(seen == {0 .. 1})

proc equals(_: typedesc[Array_of_things]; a, b: Array_of_things): bool =
  equals(typeof(a.fruits), a.fruits, b.fruits) and
      equals(typeof(a.vegetables), a.vegetables, b.vegetables)

proc `==`*(a, b: Array_of_things): bool =
  return equals(Array_of_things, a, b)

proc stringify(_: typedesc[Array_of_things]; value: Array_of_things): string =
  stringifyObj("Array_of_things",
               ("fruits", stringify(typeof(value.fruits), value.fruits)), (
      "vegetables", stringify(typeof(value.vegetables), value.vegetables)))

proc `$`*(value: Array_of_things): string =
  stringify(Array_of_things, value)

proc fromJsonHook*(target: var Array_of_things; source: JsonNode) =
  if hasKey(source, "fruits") and source{"fruits"}.kind != JNull:
    target.fruits = jsonTo(source{"fruits"}, typeof(target.fruits))
  if hasKey(source, "vegetables") and source{"vegetables"}.kind != JNull:
    target.vegetables = jsonTo(source{"vegetables"}, typeof(target.vegetables))

proc toJsonHook*(source: Array_of_things): JsonNode =
  result = newJObject()
  if len(source.fruits) > 0:
    result{"fruits"} = block:
      let cursor {.cursor.} = source.fruits
      var output = newJArray()
      for entry in cursor:
        output.add(newJString(entry))
      output
  if len(source.vegetables) > 0:
    result{"vegetables"} = block:
      let cursor {.cursor.} = source.vegetables
      var output = newJArray()
      for entry in cursor:
        output.add(toJsonHook(entry))
      output

proc toStream*(source: Array_of_things; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if len(source.fruits) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("fruits"))
    write(target, ':')
    toStream(source.fruits, target)
  if len(source.vegetables) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("vegetables"))
    write(target, ':')
    toStream(source.vegetables, target)
  target.write('}')

proc fromStream*(typ: typedesc[Array_of_things];
                 source: var JsonParser): Array_of_things =
  eat(source, tkCurlyLe)
  while source.tok != tkCurlyRi:
    expectString(source)
    let key = source.a
    discard getTok(source)
    eat(source, tkColon)
    case key
    of "fruits":
      result.fruits = fromStream(typeof(result.fruits), source)
    of "vegetables":
      result.vegetables = fromStream(typeof(result.vegetables), source)
    else:
      skipValue(source)
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkCurlyRi)
  {.pop.}
