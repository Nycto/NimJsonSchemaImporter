import json_schema_import, std/[unittest, json, jsonutils, options]

jsonSchema(JsonSchemaConfig(rootTypeName: "Bare"), %*{"format": "date-time"})

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Described"),
  %*{"format": "uuid", "description": "a keyword that names no type of its own"},
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Str"), %*{"type": "string", "format": "email"}
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Int"), %*{"type": "integer", "format": "int64"}
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Num"), %*{"type": "number", "format": "double"}
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Nullable"),
  %*{"type": ["string", "null"], "format": "date"},
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Enumed"), %*{"enum": ["a", "b"], "format": "unknown"}
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Tightened"),
  %*{
    "$ref": "#/$defs/count", "format": "int32", "$defs": {"count": {"type": "integer"}}
  },
)

suite "A `format` alongside the type it annotates":
  test "On its own it describes a string":
    check("\"2026-09-08T12:00:00Z\"".parseJson.jsonTo(Bare) is string)
    check("\"f81d4fae\"".parseJson.jsonTo(Described) is string)

  test "Beside a string it changes nothing":
    check("\"bob@example.com\"".parseJson.jsonTo(Str) == "bob@example.com")

  test "A numeric format leaves the number alone":
    check("42".parseJson.jsonTo(Int) == 42.BiggestInt)
    check("1.5".parseJson.jsonTo(Num) == 1.5.BiggestFloat)

  test "A nullable string stays optional":
    check("null".parseJson.jsonTo(Nullable).isNone)
    check("\"2026-09-08\"".parseJson.jsonTo(Nullable) == some("2026-09-08"))

  test "An enum outranks it":
    check($"\"b\"".parseJson.jsonTo(Enumed) == "b")

  test "A ref supplies the type it annotates":
    check("7".parseJson.jsonTo(Tightened) == 7.BiggestInt)
