import json_schema_import, std/[json, jsonutils, options, unittest]

# No type prefix, so enum values land in the same scope as the object types
jsonSchema(
  JsonSchemaConfig(rootTypeName: "Settings"),
  %*{
    "type": "object",
    "properties": {
      "kind": {"enum": ["basicAuth", "Feature"]},
      "basicAuth": {"type": "object", "properties": {"user": {"type": "string"}}},
      "feature": {"type": "object", "properties": {"name": {"type": "string"}}},
    },
  },
)

suite "Enum values":
  test "Enum values can share a name with a type":
    let parsed = """{ "kind": "basicAuth", "basicAuth": { "user": "someone" } }""".parseJson.jsonTo(
      Settings
    )
    check parsed.kind == some(Kind.BasicAuth)
    check parsed.basicAuth.get.user == some("someone")
    check $Kind.Feature == "Feature"
    check BasicAuth(user: some("x")).user == some("x")
