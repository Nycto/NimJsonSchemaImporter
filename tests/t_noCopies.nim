import json_schema_import, std/[json, unittest]

jsonSchema(
  JsonSchemaConfig(noCopies: true),
  %*{
    "$ref": "#/definitions/People",
    "definitions": {
      "Person": {
        "required": ["name", "age"],
        "properties": {"name": {"type": "string"}, "age": {"type": "integer"}},
      },
      "People": {
        "required": ["entries"],
        "properties":
          {"entries": {"items": {"$ref": "#/definitions/Person"}, "type": "array"}},
      },
    },
  },
)

suite "Copying values":
  test "Reading a union as a seq":
    let obj = """{
            "entries": [
                { "name": "Jack", "age": 41 },
                { "name": "Jill", "age": 42 }
            ]
        }
        """.parseJson.jsonTo(
      People
    )

    var target: People
    check not compiles(`=copy`(target, obj))
