## Compiled with `-d:jsonSchemaNoValidate`, set by the `.nims` beside this file

import std/[unittest, json, jsonutils, options]
import json_schema_import

importJsonSchema("examples/basic/schema.json", JsonSchemaConfig(rootTypeName: "Basic"))
importJsonSchema(
  "examples/string_root/schema.json", JsonSchemaConfig(rootTypeName: "StringRoot")
)

suite "Compiling validation out":
  test "A root that asserts something stays an alias":
    check(StringRoot is string)

  test "Decoders accept what the schema would reject":
    check(jsonTo(%*{"age": -1}, Basic).age.get == -1)
    let long = "a string that is altogether too long to be allowed"
    check(jsonTo(%long, StringRoot) == long)
