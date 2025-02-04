import json_schema_import, util, std/[macros, os]

include import_all

import std/[unittest, json, strformat, jsonutils]

suite "Binary encoding of types":

    template buildTest(name: static string, rootType: typedesc) =

        let sampleDir = currentSourcePath.parentDir() & "/examples/" & name & "/samples"
        for (_, path) in walkDir(sampleDir):
            test name & " parsing: " & path:
                let initial = jsonTo(parseFile(path), rootType)
                let encoded = initial.toBinary()
                let decoded = rootType.fromBinary(encoded)
                check(initial == decoded)

    include defs
