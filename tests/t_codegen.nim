import std/[unittest, json, os, paths], util
import json_schema_import {.all.}, json_schema_import/private/util

suite "Code generation snapshots":

    template buildTest(name: static string, rootType: untyped) =
        test name:
            const parsed = slurp("examples" / name / "schema.json")
                .parseJsonSchema(conf(name))
                .formatCodeDump

            const expectPath = "examples" / name / "expect.nim"

            when defined(rebuild):
                writeFile(currentSourcePath.parentDir() / expectPath, parsed)
            else:
                const expect = slurp(expectPath)
                check(parsed == expect)

    include defs
