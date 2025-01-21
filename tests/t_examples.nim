import std/[unittest, json, os, paths, strutils, strformat, jsonutils], json_schema_types, regex
import examples/address/expect
import examples/blog/expect
import examples/location/expect
import examples/health/expect
import examples/movie/expect
import examples/user_profile/expect
import examples/basic/expect
import examples/array_of_things/expect
import examples/enumerated_values/expect
import examples/complex_object/expect
import examples/union/expect
import examples/file_system/expect
import examples/ecommerce/expect
import examples/ldtk/expect
import examples/aseprite/expect

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

proc addHeader(content: string): string =
    "{.push warning[UnusedImport]:off.}\n" &
    "import std/[json, jsonutils, tables, options]\n" &
    content

suite "Parsing example json schema":

    template buildTest(name: static string) =
        test name:
            const parsed = slurp("examples" / name / "schema.json")
                .parseJsonSchema(name, "Test", testResolver)
                .repr
                .replace(re2"\`gensym\d+", "")
                .addHeader

            const expectPath = "examples" / name / "expect.nim"

            when defined(rebuild):
                writeFile(currentSourcePath.parentDir() / expectPath, parsed)
            else:
                const expect = slurp(expectPath)
                # check(parsed == expect)

    template buildTest(name: static string, rootType: typedesc) =
        buildTest(name)
        when not defined(disableJsonTest):
            test name & " parsing":
                let samplePath = currentSourcePath.parentDir() / "examples" / name / "sample.json"
                let parsed = jsonTo(parseFile(samplePath), rootType)
                let json = toJson(parsed).pretty
                when defined(rebuild):
                    writeFile(samplePath, json)
                else:
                    check(json == readFile(samplePath))

    # https://json-schema.org/learn/json-schema-examples
    buildTest("address", TestAddress)
    buildTest("blog", TestBlog)
    buildTest("ecommerce", TestOrderSchema)
    buildTest("location", TestLocation)
    buildTest("health", TestHealth)
    buildTest("movie", TestMovie)
    buildTest("user_profile", TestUser_profile)

    # https://json-schema.org/learn/miscellaneous-examples
    buildTest("basic", TestBasic)
    buildTest("array_of_things", TestArray_of_things)
    buildTest("enumerated_values", TestEnumerated_values)
    buildTest("complex_object", TestComplex_object)

    # https://json-schema.org/learn/file-system#full-entry
    buildTest("file_system", TestFile_system)

    # Specific use cases
    buildTest("union", TestUnion)

    # Specific applications
    buildTest("ldtk", TestLdtkJsonRoot)
    buildTest("aseprite", TestSpriteSheet)