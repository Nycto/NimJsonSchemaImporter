import json_schema_import, std/unittest

importJsonSchema "examples/address/schema.json"
importJsonSchema "examples/movie/schema.json", "Prefix"

suite "Simple import syntax":
  test "File should compile":
    check(declared(Address))
    check(declared(PrefixMovie))
