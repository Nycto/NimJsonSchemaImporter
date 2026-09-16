import json_schema_import, std/[unittest, json, jsonutils, options, tables]

jsonSchema(
  JsonSchemaConfig(rootTypeName: "SplitAllOf"),
  %*{
    "allOf":
      [{"type": "object", "properties": {"a": {"type": "string"}}}, {"required": ["a"]}]
  },
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "TightenedRef"),
  %*{
    "$ref": "#/$defs/entry",
    "required": ["name"],
    "$defs": {"entry": {"type": "object", "properties": {"name": {"type": "string"}}}},
  },
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Untyped"),
  %*{"properties": {"known": {"type": "string"}}, "required": ["known", "anything"]},
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "NullableRequired"),
  %*{
    "type": "object",
    "properties": {"a": {"type": ["string", "null"]}},
    "required": ["a"],
  },
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "SplitNullable"),
  %*{
    "allOf": [
      {"type": "object", "properties": {"a": {"type": ["string", "null"]}}},
      {"required": ["a"]},
    ]
  },
)

# Draft 3 wrote `required` as a boolean beside the property it applied to, which names no
# key of the node carrying it
jsonSchema(
  JsonSchemaConfig(rootTypeName: "Draft3"),
  %*{
    "type": "object",
    "properties": {"a": {"type": "string", "required": true}},
    "required": true,
  },
)

# An empty list requires nothing, so it must not close an open object off
jsonSchema(
  JsonSchemaConfig(rootTypeName: "EmptyRequired"),
  %*{"additionalProperties": {"type": "string"}, "required": []},
)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "NullableObject"),
  %*{
    "type": "object",
    "properties": {
      "x": {
        "type": ["object", "null"],
        "properties": {"inner": {"type": "string"}},
        "required": ["inner"],
      }
    },
    "required": ["x"],
  },
)

suite "A `required` that stands on its own":
  test "Split from the properties across allOf branches":
    let value = """{"a": "hello"}""".parseJson.jsonTo(SplitAllOf)
    check(value.a == "hello")
    check(value.a is string)

  test "Written beside a $ref it tightens":
    let value = """{"name": "widget"}""".parseJson.jsonTo(TightenedRef)
    check(value.name == "widget")
    check(value.name is string)

  test "Naming a key the properties never type":
    let value = """{"known": "v", "anything": [1, 2]}""".parseJson.jsonTo(Untyped)
    check(value.known == "v")
    check(value.anything == %*[1, 2])

  test "A required property that is also nullable stays optional":
    check("""{"a": null}""".parseJson.jsonTo(NullableRequired).a.isNone)
    check("""{"a": "x"}""".parseJson.jsonTo(NullableRequired).a == some("x"))

  test "A nullable property required from another branch stays optional":
    check("""{"a": null}""".parseJson.jsonTo(SplitNullable).a.isNone)
    check("""{"a": "x"}""".parseJson.jsonTo(SplitNullable).a == some("x"))

  test "A draft 3 boolean required is passed over":
    let value = """{"a": "hello"}""".parseJson.jsonTo(Draft3)
    check(value.a == some("hello"))

  test "An empty required list leaves an open object open":
    let value = """{"k": "v"}""".parseJson.jsonTo(EmptyRequired)
    check(value["k"] == "v")

  test "A required object that may be null keeps the null":
    check("""{"x": null}""".parseJson.jsonTo(NullableObject).x.isNone)
    check(
      """{"x": {"inner": "i"}}""".parseJson.jsonTo(NullableObject).x.get.inner == "i"
    )
