{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin, sax]

type
  Basic* {.byref.} = object
    firstName*: Option[string]
    lastName*: Option[string]
    age*: Option[BiggestInt]
proc `=copy`(a: var Basic; b: Basic) {.error.}
proc toJsonHook*(source: Basic): JsonNode
proc equals(_: typedesc[Basic]; a, b: Basic): bool =
  equals(typeof(a.firstName), a.firstName, b.firstName) and
      equals(typeof(a.lastName), a.lastName, b.lastName) and
      equals(typeof(a.age), a.age, b.age)

proc `==`*(a, b: Basic): bool =
  return equals(Basic, a, b)

proc stringify(_: typedesc[Basic]; value: Basic): string =
  stringifyObj("Basic", ("firstName",
                         stringify(typeof(value.firstName), value.firstName)), (
      "lastName", stringify(typeof(value.lastName), value.lastName)),
               ("age", stringify(typeof(value.age), value.age)))

proc `$`*(value: Basic): string =
  stringify(Basic, value)

proc fromJsonHook*(target: var Basic; source: JsonNode) =
  if hasKey(source, "firstName") and source{"firstName"}.kind != JNull:
    target.firstName = some(jsonTo(source{"firstName"},
                                   typeof(unsafeGet(target.firstName))))
  if hasKey(source, "lastName") and source{"lastName"}.kind != JNull:
    target.lastName = some(jsonTo(source{"lastName"},
                                  typeof(unsafeGet(target.lastName))))
  if hasKey(source, "age") and source{"age"}.kind != JNull:
    target.age = some(jsonTo(source{"age"}, typeof(unsafeGet(target.age))))

proc toJsonHook*(source: Basic): JsonNode =
  result = newJObject()
  if isSome(source.firstName):
    result{"firstName"} = newJString(unsafeGet(source.firstName))
  if isSome(source.lastName):
    result{"lastName"} = newJString(unsafeGet(source.lastName))
  if isSome(source.age):
    result{"age"} = newJInt(unsafeGet(source.age))

proc toStream*(source: Basic; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.firstName):
    hasEmitted.writeComma(target)
    write(target, escapeJson("firstName"))
    write(target, ':')
    toStream(unsafeGet(source.firstName), target)
  if isSome(source.lastName):
    hasEmitted.writeComma(target)
    write(target, escapeJson("lastName"))
    write(target, ':')
    toStream(unsafeGet(source.lastName), target)
  if isSome(source.age):
    hasEmitted.writeComma(target)
    write(target, escapeJson("age"))
    write(target, ':')
    toStream(unsafeGet(source.age), target)
  target.write('}')

proc fromStream*(typ: typedesc[Basic]; source: var JsonParser): Basic =
  eat(source, tkCurlyLe)
  while source.tok != tkCurlyRi:
    if source.tok != tkString:
      raiseParseErr(source, "string")
    let key = source.a
    discard getTok(source)
    eat(source, tkColon)
    case key
    of "firstName":
      result.firstName = some(fromStream(typeof(unsafeGet(result.firstName)),
          source))
    of "lastName":
      result.lastName = some(fromStream(typeof(unsafeGet(result.lastName)),
                                        source))
    of "age":
      result.age = some(fromStream(typeof(unsafeGet(result.age)), source))
    else:
      skipValue(source)
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkCurlyRi)
{.pop.}
