import std/[unittest, json, os, paths, strutils], json_schema_import, regex, util

{.push warning[UnusedImport]:off.}

template buildTest(name: static string, rootType: untyped) =
    import examples/name/expect

include defs

suite "Importing all snapshots":
    test "Importing snapshots should compile":
        discard

