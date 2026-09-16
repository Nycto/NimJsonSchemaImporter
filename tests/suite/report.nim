##
## Reads the outcomes a generated suite module logs, and reports them against the
## blocklist
##

import std/[os, strutils, strformat, tables, sets], ./loader

type Results* = Table[string, bool] ## Whether each test that ran passed, by label

proc compiled*(dir: string): bool =
  ## A module that compiled was run, which leaves a log behind
  fileExists(dir & "/run.log")

proc collect*(dir: string, results: var Results) =
  for line in lines(dir & "/run.log"):
    let parts = line.split('\t', 1)
    if parts.len == 2:
      results[parts[1]] = parts[0] == "PASS"

proc report*(
    suite, selected: seq[SuiteFile], results: Results, blocklist: HashSet[string]
): int =
  ## Prints counts, unblocked failures and stale entries for the `selected` files, and
  ## entries matching no test in the whole `suite`, returning how many problems there
  ## were. A test that did not report, because its module did not compile, failed.
  for file in selected:
    var passed, failed, blocked: int
    for suiteCase in file.cases:
      for test in suiteCase.tests:
        let testLabel = label(file.name, suiteCase, test)
        let pass = results.getOrDefault(testLabel)
        if testLabel in blocklist:
          inc blocked
          if pass:
            inc result
            echo "STALE BLOCKLIST ENTRY: ", testLabel
        elif pass:
          inc passed
        else:
          inc failed
          inc result
          echo "FAIL: ", testLabel
    echo &"{file.name}: {passed} passed, {failed} failed, {blocked} blocked"

  var labels: HashSet[string]
  for file in suite:
    for suiteCase in file.cases:
      for test in suiteCase.tests:
        labels.incl(label(file.name, suiteCase, test))
  for entry in blocklist - labels:
    inc result
    echo "UNMATCHED BLOCKLIST ENTRY: ", entry
