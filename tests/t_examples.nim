import std/[unittest, json, os, paths, strutils, strformat], json_schema_types
import examples/address/expect
import examples/blog/expect
# import examples/array_of_things/expect, examples/aseprite/expect
# import examples/basic/expect, examples/blog/expect, examples/complex_object/expect
# import examples/ecommerce/expect, examples/enumerated_values/expect, examples/file_system/expect
# import examples/health/expect, examples/ldtk/expect, examples/location/expect
# import examples/movie/expect, examples/union/expect, examples/user_profile/expect

proc testResolver(uri: string): JsonNode =
    if uri == "https://example.com/user-profile.schema.json":
        return %*{
            "type": "object",
            "properties": {
                "username": { "type": "string" },
                "email": { "type": "string" },
            }
        }
    else:
        raiseAssert(fmt"Unsupported test uri: {uri}")

proc addHeader(content: string): string = "import std/[json, tables, options]\n" & content

suite "Parsing example json schema":

    template buildTest(name: static string) =
        test name:
            const parsed = slurp("examples" / name / "schema.json")
                .parseJsonSchema(name, "Test", testResolver)
                .repr
                .addHeader

            const expectPath = "examples" / name / "expect.nim"

            when defined(rebuild):
                writeFile(currentSourcePath.parentDir() / expectPath, parsed)
            else:
                const expect = slurp(expectPath)
                check(parsed == expect)

    template buildTest(name: static string, rootType: typedesc) =
        buildTest(name)
        test name & " parsing":
            let samplePath = currentSourcePath.parentDir() / "examples" / name / "sample.json"
            let parsed: rootType = parseFile(samplePath).to(rootType)
            let json = pretty(%*(parsed))
            when defined(rebuild):
                writeFile(samplePath, json)
            else:
                check(json == readFile(samplePath))

    # https://json-schema.org/learn/json-schema-examples
    buildTest("address", TestAddress)
    buildTest("blog", TestBlog)
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