import json_schema_import, util, std/[macros, os]

include import_all

import std/[unittest, json, strformat, jsonutils]

suite "Parsing example json schema":
  template buildTest(name: static string, rootType: typedesc) =
    let sampleDir = currentSourcePath.parentDir() & "/examples/" & name & "/samples"
    for (_, path) in walkDir(sampleDir):
      test name & " parsing: " & path:
        let parsed = jsonTo(parseFile(path), rootType)
        let json = toJson(parsed).pretty
        when defined(rebuild):
          writeFile(path, json)
        else:
          check(json == readFile(path))

  include defs
