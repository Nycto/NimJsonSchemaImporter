import json_schema_import, std/[unittest, json, jsonutils, options, streams, tables]

jsonSchema %*{"$id": "arrContainer", "type": "array", "items": {"type": "integer"}}

jsonSchema %*{"$id": "strContainer", "type": "string", "maxLength": 25}

jsonSchema %*{"$id": "numContainer", "type": "number"}

jsonSchema %*{"$id": "mapContainer", "additionalProperties": {"type": "string"}}

jsonSchema(JsonSchemaConfig(rootTypeName: "Flag"), %*{"type": "boolean"})

jsonSchema(JsonSchemaConfig(rootTypeName: "MaybeName"), %*{"type": ["string", "null"]})

suite "Schemas rooted at something other than an object":
  test "An array at the root":
    let value: ArrContainer = @[1.BiggestInt, 2, 3]
    check(value.toJson == %*[1, 2, 3])
    check("[1,2,3]".parseJson.jsonTo(ArrContainer) == value)

  test "A string at the root":
    let value: StrContainer = "hello"
    check(value.toJson == %"hello")
    check("\"hello\"".parseJson.jsonTo(StrContainer) == value)

  test "A number at the root":
    let value: NumContainer = 1.5
    check(value.toJson == %1.5)

  test "A boolean at the root":
    let value: Flag = true
    check(value.toJson == %true)

  test "A map at the root":
    let value = """{"a": "b"}""".parseJson.jsonTo(MapContainer)
    check(value["a"] == "b")

  test "An optional at the root":
    check("null".parseJson.jsonTo(MaybeName).isNone)
    check("\"bob\"".parseJson.jsonTo(MaybeName) == some("bob"))

  test "Round tripping a root array through the sax parser":
    let value: ArrContainer = @[1.BiggestInt, 2, 3]
    var stream = newStringStream()
    value.toStream(stream)
    check(ArrContainer.fromStream(stream, "test.json") == value)
