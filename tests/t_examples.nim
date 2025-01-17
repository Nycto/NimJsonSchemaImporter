import std/unittest, json_schema_reader

suite "Parsing example json schema":

    template buildTest(name: static string) =
        test name:
            const parsed = slurp("examples/" & name & ".json").parseJsonSchema(name).repr
            const expect = slurp("examples/" & name & "_expect.nim")
            check(parsed == expect)

    # buildTest("examples/ldtk")
    buildTest("address")
    buildTest("blog")


