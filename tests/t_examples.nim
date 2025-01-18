import std/[unittest, json], json_schema_reader

proc testResolver(uri: string): JsonNode = parseJson("""{"type":"string"}""")

suite "Parsing example json schema":

    template buildTest(name: static string) =
        test name:
            const parsed = slurp("examples/" & name & ".json").parseJsonSchema(name, testResolver).repr
            const expect = slurp("examples/" & name & "_expect.nim")
            check(parsed == expect)

    # buildTest("examples/ldtk")
    buildTest("address")
    buildTest("blog")
    # buildTest("ecommerce")
    buildTest("location")
    buildTest("health")
    buildTest("movie")
    buildTest("user_profile")
