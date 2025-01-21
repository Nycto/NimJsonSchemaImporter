import std/[unittest, json, os, paths, strutils, strformat, jsonutils], json_schema_types, util

importJsonSchema("examples/address/schema.json", conf("Address"))
importJsonSchema("examples/blog/schema.json", conf("Blog"))
importJsonSchema("examples/location/schema.json", conf("Location"))
importJsonSchema("examples/health/schema.json", conf("Health"))
importJsonSchema("examples/movie/schema.json", conf("Movie"))
importJsonSchema("examples/user_profile/schema.json", conf("UserProfile"))
importJsonSchema("examples/basic/schema.json", conf("Basic"))
importJsonSchema("examples/array_of_things/schema.json", conf("ArrayOfThings"))
importJsonSchema("examples/enumerated_values/schema.json", conf("EnumeratedValues"))
importJsonSchema("examples/complex_object/schema.json", conf("ComplexObject"))
importJsonSchema("examples/union/schema.json", conf("Union"))
importJsonSchema("examples/file_system/schema.json", conf("FileSystem"))
importJsonSchema("examples/ecommerce/schema.json", conf("Ecommerce"))
importJsonSchema("examples/ldtk/schema.json", conf("Ldtk"))
importJsonSchema("examples/aseprite/schema.json", conf("Aseprite"))

suite "Parsing example json schema":

    template buildTest(name: static string, rootType: typedesc) =
        test name & " parsing":
            let samplePath = currentSourcePath.parentDir() / "examples" / name / "sample.json"
            let parsed = jsonTo(parseFile(samplePath), rootType)
            let json = toJson(parsed).pretty
            when defined(rebuild):
                writeFile(samplePath, json)
            else:
                check(json == readFile(samplePath))

    include defs