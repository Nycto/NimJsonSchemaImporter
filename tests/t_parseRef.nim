import std/unittest, json_schema_reader/schemaRef

suite "Parsing schema references":

    test "Can parse root references":
        check($parseRef("#") == "#")
        check($parseRef("#/foo") == "#/foo")
        check($parseRef("#/foo/bar/baz") == "#/foo/bar/baz")
