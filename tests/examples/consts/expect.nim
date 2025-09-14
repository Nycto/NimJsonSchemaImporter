{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

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
{.pop.}
