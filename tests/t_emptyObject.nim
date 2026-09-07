import json_schema_import, std/[unittest, json, jsonutils]

importJsonSchema "./examples/empty_object/schema.json"

const sample = """{"name": "example", "custom": {}}"""

suite "Objects without any properties":
  test "Decoding an object without properties":
    let parsed = sample.parseJson.jsonTo(Empty_object)
    check(parsed.name == "example")
    check(parsed.custom == Custom())

  test "Encoding an object without properties":
    check(sample.parseJson.jsonTo(Empty_object).toJson == sample.parseJson)

  test "Stringifying an object without properties":
    check(
      $sample.parseJson.jsonTo(Empty_object) ==
        """Empty_object(name: "example", custom: Custom())"""
    )
