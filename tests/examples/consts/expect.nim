{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin, sax]

type
  Consts* {.byref.} = object
    nonConstField*: Option[string]
proc `=copy`(a: var Consts; b: Consts) {.error.}
proc toJsonHook*(source: Consts): JsonNode
proc equals(_: typedesc[Consts]; a, b: Consts): bool =
  equals(typeof(a.nonConstField), a.nonConstField, b.nonConstField)

proc `==`*(a, b: Consts): bool =
  return equals(Consts, a, b)

proc stringify(_: typedesc[Consts]; value: Consts): string =
  stringifyObj("Consts", ("nonConstField", stringify(
      typeof(value.nonConstField), value.nonConstField)), ("nil", "null"),
               ("integer", "42"), ("str", "\"example\""), ("float", "3.14"),
               ("bool", "true"), ("list", "[1,2,3]"),
               ("obj", "{\"key\":\"value\",\"key2\":\"value2\"}"),
               ("emptyObj", "{}"), ("emptyArray", "[]"))

proc `$`*(value: Consts): string =
  stringify(Consts, value)

proc fromJsonHook*(target: var Consts; source: JsonNode) =
  if hasKey(source, "nonConstField") and
      source{"nonConstField"}.kind != JNull:
    target.nonConstField = some(jsonTo(source{"nonConstField"},
                                       typeof(unsafeGet(target.nonConstField))))

proc toJsonHook*(source: Consts): JsonNode =
  result = newJObject()
  if isSome(source.nonConstField):
    result{"nonConstField"} = newJString(unsafeGet(source.nonConstField))
  result{"nil"} = newJNull()
  result{"integer"} = newJInt(42)
  result{"str"} = newJString("example")
  result{"float"} = newJFloat(3.14'f64)
  result{"bool"} = newJBool(true)
  result{"list"} = `%*`([newJInt(1), newJInt(2), newJInt(3)])
  result{"obj"} = `%*`({"key": newJString("value"), "key2": newJString("value2")})
  result{"emptyObj"} = `%*`({:})
  result{"emptyArray"} = `%*`([])

proc toStream*(source: Consts; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.nonConstField):
    hasEmitted.writeComma(target)
    write(target, escapeJson("nonConstField"))
    write(target, ':')
    toStream(unsafeGet(source.nonConstField), target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("nil"))
  write(target, ':')
  write(target, "null")
  hasEmitted.writeComma(target)
  write(target, escapeJson("integer"))
  write(target, ':')
  write(target, "42")
  hasEmitted.writeComma(target)
  write(target, escapeJson("str"))
  write(target, ':')
  write(target, "\"example\"")
  hasEmitted.writeComma(target)
  write(target, escapeJson("float"))
  write(target, ':')
  write(target, "3.14")
  hasEmitted.writeComma(target)
  write(target, escapeJson("bool"))
  write(target, ':')
  write(target, "true")
  hasEmitted.writeComma(target)
  write(target, escapeJson("list"))
  write(target, ':')
  write(target, "[1,2,3]")
  hasEmitted.writeComma(target)
  write(target, escapeJson("obj"))
  write(target, ':')
  write(target, "{\"key\":\"value\",\"key2\":\"value2\"}")
  hasEmitted.writeComma(target)
  write(target, escapeJson("emptyObj"))
  write(target, ':')
  write(target, "{}")
  hasEmitted.writeComma(target)
  write(target, escapeJson("emptyArray"))
  write(target, ':')
  write(target, "[]")
  target.write('}')

proc fromStream*(typ: typedesc[Consts]; source: var JsonParser): Consts =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "nonConstField":
      result.nonConstField = some(fromStream(
          typeof(unsafeGet(result.nonConstField)), source))
    else:
      skipValue(source)
  assert(card(seen) == 0)
{.pop.}
