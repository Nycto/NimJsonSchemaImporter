##
## Loads the JSON-Schema-Test-Suite files, and names every case and test by the
## `file :: case :: test` label the blocklist matches against
##

import std/[json, os, algorithm]

const
  suiteDir = currentSourcePath.parentDir & "/../JSON-Schema-Test-Suite/tests"
  drafts = ["draft2020-12", "draft2019-09", "draft7"]
  sep = " :: "

type
  SuiteTest* = object
    description*: string
    data*: JsonNode
    valid*: bool

  SuiteCase* = object
    description*: string
    schema*: JsonNode
    tests*: seq[SuiteTest]

  SuiteFile* = object
    name*: string
    cases*: seq[SuiteCase]

proc label*(file: string, suiteCase: SuiteCase, test: SuiteTest): string =
  file & sep & suiteCase.description & sep & test.description

proc loadSuite*(): seq[SuiteFile] =
  for draft in drafts:
    var paths: seq[string]
    for path in walkFiles(suiteDir & "/" & draft & "/*.json"):
      paths.add(path)
    for path in paths.sorted:
      result.add SuiteFile(
        name: draft & "/" & path.extractFilename,
        cases: parseFile(path).to(seq[SuiteCase]),
      )
