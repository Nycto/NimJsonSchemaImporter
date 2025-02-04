import json_schema_import, util, std/[macros, os]

include import_all

import std/[unittest, json, strformat, jsonutils]

suite "Equality of types":

    template buildTest(name: static string, rootType: typedesc) =

        let sampleDir = currentSourcePath.parentDir() & "/examples/" & name & "/samples"

        var previous: rootType
        for (_, path) in walkDir(sampleDir):
            test name & " parsing: " & path:
                let a = jsonTo(parseFile(path), rootType)
                let b = jsonTo(parseFile(path), rootType)
                check(a == b)
                check(a != previous)
                previous = a

    include defs

