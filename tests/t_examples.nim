import std/[unittest, json, os, paths, strutils], json_schema_types

proc testResolver(uri: string): JsonNode = parseJson("""{"type":"string"}""")

proc addHeader(content: string): string = "import std/[json, tables, options]\n" & content

suite "Parsing example json schema":

    template buildTest(name: static string) =
        test name:
            const parsed = slurp("examples" / name / "schema.json")
                .parseJsonSchema(name, name.capitalizeAscii, testResolver)
                .repr
                .addHeader

            const expectPath = "examples" / name / "expect.nim"

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
    buildTest("array_of_things")
    buildTest("enumerated_values")
    buildTest("complex_object")

    # https://json-schema.org/learn/file-system#full-entry
    buildTest("file_system")

    # Specific use cases
    buildTest("union")

    # Specific applications
    buildTest("ldtk")
    buildTest("aseprite")