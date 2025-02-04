import json_schema_import, util, std/[macros, os, paths]

include import_all

import std/[unittest, json, strformat, jsonutils]

suite "Creating a stringified version of a generated object":

    template buildTest(name: static string, rootType: typedesc) =

        let testDir = currentSourcePath.parentDir() & "/examples/" & name
        let sampleDir = testDir & "/samples"
        let dollarDir = testDir & "/dollars"

        for (_, path) in walkDir(sampleDir):
            test name & " parsing: " & path:
                let stringified = $jsonTo(parseFile(path), rootType)

                let expect = Path(dollarDir) / Path(path).lastPathPart.changeFileExt("txt")

                when defined(rebuild):
                    writeFile(expect.string, stringified)
                else:
                    check(stringified == readFile(expect.string))

    include defs