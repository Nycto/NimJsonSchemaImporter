import std/unittest, util
import json_schema_import {.all.}, json_schema_import/private/util

suite "Code generation snapshots":

    template buildTest(name: static string, rootType: untyped) =
        test name:
            const parsed = slurp("examples/" & name & "/schema.json")
                .parseJsonSchema(conf(name))
                .code
                .formatCodeDump

            const expectPath = "examples/" & name & "/expect.nim"

            when defined(rebuild):
                writeFile(currentSourcePath.parentDir() & "/" & expectPath, parsed)
            else:
                const expect = slurp(expectPath)
                compareLines(expect, parsed, expectPath)

    include defs
