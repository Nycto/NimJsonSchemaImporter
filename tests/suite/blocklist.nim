##
## The labels of suite tests known to fail: loading them, and regenerating them from a
## run
##

import std/[os, strutils, sets, tables], ./loader

const
  blocklistPath* = currentSourcePath.parentDir & "/blocklist.txt"
  blocklistHeader =
    """# Suite tests this library is known to fail, one `file :: case :: test` label per line.
# Regenerate with `nimble suite --update`.
"""

proc loadBlocklist*(): HashSet[string] =
  for line in lines(blocklistPath):
    let entry = line.strip
    if entry.len > 0 and not entry.startsWith("#"):
      result.incl(entry)

proc writeBlocklist*(suite: seq[SuiteFile], results: Table[string, bool]) =
  ## Replaces every entry with the failures from a run of the whole suite
  var output = blocklistHeader
  for file in suite:
    for suiteCase in file.cases:
      for test in suiteCase.tests:
        let testLabel = label(file.name, suiteCase, test)
        if not results.getOrDefault(testLabel):
          output.add(testLabel & "\n")
  writeFile(blocklistPath, output)
