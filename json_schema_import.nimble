# Package

version = "0.2.0"
author = "Nycto"
description = "Converts JSON schema definitions to nim types"
license = "MIT"
srcDir = "src"

# Dependencies

requires "nim >= 2.0.0"
requires "regex >= 0.26.1"

# Tasks

import std/[os, strutils]

task readme, "Compiles code in the readme":
  let readme = readFile("README.md")

  let tmpDir = nimcacheDir() & "/readme_json_schema_import"
  mkDir(tmpDir)

  var inCode = false
  var accum = ""
  var path = ""
  for line in readme.split("\n"):
    if line.startsWith "```":
      if not inCode:
        let filename = line.split(' ')[^1]
        assert(filename != "")
        path = tmpDir & "/" & filename
      else:
        assert(path != "")
        echo "Creating file ", path
        writeFile(path, accum)

        if path.endsWith(".nim"):
          exec("nim c -r -p:" & getCurrentDir() & "/src " & path)

        path = ""
        accum = ""

      inCode = not inCode
    elif inCode:
      accum &= line & "\n"
