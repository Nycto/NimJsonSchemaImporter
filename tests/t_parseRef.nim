import std/unittest, json_schema_types/private/schemaRef

suite "Parsing schema references":

    test "Can parse root references":
        check(parseRef("#").dump == "(Root)")
        check(parseRef("#/foo").dump == "(Root)/(Sub:foo)")
        check(parseRef("#/foo/bar/baz").dump == "(Root)/(Sub:foo)/(Sub:bar)/(Sub:baz)")

    test "Can parse anchor references":
        check(parseRef("#foo").dump == "(Anchor:foo)")
        check(parseRef("#foo/bar/baz").dump == "(Anchor:foo)/(Sub:bar)/(Sub:baz)")

    test "Can parse uri references":
        check(parseRef("https://example.com/foo/bar").dump == "(Url:https://example.com/foo/bar)")
        check(parseRef("https://example.com/foo/bar#").dump == "(Url:https://example.com/foo/bar)/(Root)")
        check(parseRef("https://example.com/foo/bar#/bar/baz").dump == "(Url:https://example.com/foo/bar)/(Root)/(Sub:bar)/(Sub:baz)")
        check(parseRef("https://example.com/foo/bar#bar/baz").dump == "(Url:https://example.com/foo/bar)/(Anchor:bar)/(Sub:baz)")
