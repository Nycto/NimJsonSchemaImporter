import json_schema_import, util

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

import std/[unittest, json, os, paths, strformat, jsonutils]

suite "Parsing example json schema":

    template buildTest(name: static string, rootType: typedesc) =

        let sampleDir = currentSourcePath.parentDir() / "examples" / name / "samples"
        for (_, path) in walkDir(sampleDir):
            test name & " parsing: " & path:
                let parsed = jsonTo(parseFile(path), rootType)
                let json = toJson(parsed).pretty
                when defined(rebuild):
                    writeFile(path, json)
                else:
                    check(json == readFile(path))

    include defs