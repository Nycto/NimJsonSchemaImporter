import json_schema_import, std/unittest

importJsonSchema "./examples/complex_object/schema.json"

suite "Compile time parsing":
  test "Parsing data at compile time":
    const data = slurp("./examples/complex_object/samples/data0.json").parseJson.jsonTo(
        Complex_object
      )
    const expect = slurp("./examples/complex_object/samples/data0.json")
    check(data.toJson.pretty == expect)
