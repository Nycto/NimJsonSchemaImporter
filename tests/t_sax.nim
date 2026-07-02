import json_schema_import, util, std/[macros, os, streams]

include import_all

import std/[unittest, json, strformat, jsonutils]

suite "Based encoding of types":
  template buildTest(name: static string, rootType: typedesc) =
    let sampleDir = currentSourcePath.parentDir() & "/examples/" & name & "/samples"
    for (_, path) in walkDir(sampleDir):
      test name & " parsing: " & path:
        let initial = jsonTo(parseFile(path), rootType)

        var stream = newStringStream()
        initial.toStream(stream)
        echo stream.data
        let decoded = rootType.fromStream(stream, "test.json")
        check(initial == decoded)

  include defs
