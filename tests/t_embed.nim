import std/unittest, json_schema_import, util

include import_all

suite "Embedding values":

    template buildTest(name: static string, rootType: typedesc) =

        const basePath = "examples/" & name
        const strVal = slurp(basePath & "/dollars/data0.txt")

        test "Loading an embedded value as a const for " & name:
            let value = rootType.embedFromJson(basePath & "/samples/data0.json", alwaysEmbed = true)
            check($value == strVal)

        test "Loading an embedded value dynamically for " & name:
            let value = rootType.embedFromJson(basePath & "/samples/data0.json", alwaysEmbed = false)
            check($value == strVal)

    include defs
