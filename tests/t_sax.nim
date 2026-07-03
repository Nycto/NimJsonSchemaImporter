import json_schema_import, util, std/[macros, os, streams]

include import_all

import std/[unittest, json, strformat, jsonutils, options]

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

suite "Sax decoding errors":
  test "Truncated JSON raises":
    expect JsonParsingError:
      discard Basic.fromStream(newStringStream("""{"firstName": """), "test.json")

  test "Malformed JSON syntax raises":
    expect JsonParsingError:
      discard Basic.fromStream(newStringStream("""{"firstName" "Bob"}"""), "test.json")

  test "Wrong-typed field raises":
    expect JsonParsingError:
      discard Basic.fromStream(newStringStream("""{"age": "not a number"}"""), "test.json")

  test "Invalid enum value raises":
    expect ValueError:
      discard
        AsepriteSpriteSheet.fromStream(
          newStringStream(
            """{"frames": {}, "meta": {"app": "a", "format": "bogus",
            "image": "i", "scale": "1", "size": {"h": 0, "w": 0}, "version": "v"}}"""
          ),
          "test.json",
        )

  test "Missing required field raises":
    expect AssertionDefect:
      discard Address.fromStream(newStringStream("""{"locality": "X"}"""), "test.json")

suite "Non-object root types":
  test "seq root type round-trips":
    let initial = @[Basic(firstName: some("A")), Basic(lastName: some("B"))]

    var stream = newStringStream()
    initial.toStream(stream)
    let decoded = fromStream(seq[Basic], stream, "test.json")
    check(initial == decoded)

  test "primitive root type round-trips":
    var stream = newStringStream()
    toStream(42, stream)
    check(fromStream(int, stream, "test.json") == 42)

  test "union root type round-trips":
    let initial = """[{
      "duration": 1.0, "filename": "f",
      "frame": {"h": 0, "w": 0, "x": 0, "y": 0}, "rotated": false,
      "sourceSize": {"h": 0, "w": 0},
      "spriteSourceSize": {"h": 0, "w": 0, "x": 0, "y": 0}, "trimmed": false
    }]""".parseJson.jsonTo(AsepriteUnion)

    var stream = newStringStream()
    initial.toStream(stream)
    let decoded = fromStream(AsepriteUnion, stream, "test.json")
    check(initial == decoded)
