{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options, typetraits]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/validate as jsonSchemaValidate
import json_schema_import/private/[equality, bin, sax, empty]

type
  String_root* = distinct string
proc equals(_: typedesc[String_root]; a, b: String_root): bool =
  equals(distinctBase(String_root), distinctBase(String_root)(a),
         distinctBase(String_root)(b))

proc `==`*(a, b: String_root): bool =
  return equals(String_root, a, b)

proc stringify(_: typedesc[String_root]; value: String_root): string =
  stringify(distinctBase(String_root), distinctBase(String_root)(value))

proc `$`*(value: String_root): string =
  stringify(String_root, value)

proc validate*(_: typedesc[String_root]; value: String_root;
               path: string = "String_root") =
  if not (satisfiesMaxLength(distinctBase(String_root)(value), 25)):
    invalid(path, "maxLength: 25")

proc toJsonHook*(source: String_root): JsonNode =
  return toJson(distinctBase(String_root)(source))

proc fromJsonHook*(target: var String_root; source: JsonNode) =
  target = String_root(jsonTo(source, distinctBase(String_root)))
  when not defined(jsonSchemaNoValidate):
    validate(String_root, target)

proc toBinary*(target: var string; source: String_root) =
  toBinary(target, distinctBase(String_root)(source))

proc fromBinary*(_: typedesc[String_root]; source: string; idx: var int): String_root =
  return String_root(fromBinary(distinctBase(String_root), source, idx))

proc toStream*(source: String_root; target: Stream) =
  toStream(distinctBase(String_root)(source), target)

proc fromStream*(typ: typedesc[String_root]; source: var JsonParser): String_root =
  result = String_root(fromStream(distinctBase(String_root), source))
  when not defined(jsonSchemaNoValidate):
    validate(String_root, result)

{.pop.}
