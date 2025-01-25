import std/[unittest, json, os, paths, strutils], regex, util
import json_schema_import {.all.}

proc addHeader(content: string): string =
    "{.push warning[UnusedImport]:off.}\n" &
    "import std/[json, jsonutils, tables, options]\n" &
    content

suite "Code generation snapshots":

    template buildTest(name: static string, rootType: untyped) =
        test name:
            const parsed = slurp("examples" / name / "schema.json")
                .parseJsonSchema(conf(name))
                .repr
                .replace(re2"\`gensym_?\d+", "")
                .addHeader

            const expectPath = "examples" / name / "expect.nim"

            when defined(rebuild):
                writeFile(currentSourcePath.parentDir() / expectPath, parsed)
            else:
                const expect = slurp(expectPath)
                check(parsed == expect)

    include defs
