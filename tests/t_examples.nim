import std/[unittest, json, os, paths, strutils], json_schema_types

proc testResolver(uri: string): JsonNode = parseJson("""{"type":"string"}""")

suite "Parsing example json schema":

    template buildTest(name: static string) =
        test name:
            const parsed = slurp("examples" / (name & ".json"))
                .parseJsonSchema(name, name.capitalizeAscii, testResolver)
                .repr
            const expectPath = "examples" / (name & "_expect.nim")
            when defined(rebuild):
                writeFile(currentSourcePath.parentDir() / expectPath, parsed)
            else:
                const expect = slurp(expectPath)
                check(parsed == expect)

    # https://json-schema.org/learn/json-schema-examples
    buildTest("address")
    buildTest("blog")
    buildTest("ecommerce")
    buildTest("location")
    buildTest("health")
    buildTest("movie")
    buildTest("user_profile")

    # https://json-schema.org/learn/miscellaneous-examples
    buildTest("basic")
    buildTest("arrayOfThings")
    buildTest("enumeratedValues")
    buildTest("complexObject")

    # Specific use cases
    buildTest("union")

    # Specific applications
    buildTest("ldtk")
    buildTest("aseprite")