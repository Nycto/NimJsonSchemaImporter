## The runtime half of the generated `validate` procs: one predicate per assertion
## keyword, and the single place a failed assertion is reported from

import std/[math, unicode], regex

proc invalid*(path, constraint: string) {.noreturn.} =
  ## Reports the first assertion a value failed, named by the path that reached it
  raise newException(ValueError, path & " does not satisfy " & constraint)

proc satisfiesMinLength*(value: string, len: int): bool =
  ## Lengths count characters rather than bytes, which is what the schema means
  return value.runeLen >= len

proc satisfiesMaxLength*(value: string, len: int): bool =
  return value.runeLen <= len

proc satisfiesPattern*(value: string, pattern: static string): bool =
  ## A pattern is a search, not a whole string match, unless it anchors itself
  const compiled = re2(pattern)
  return value.contains(compiled)

proc satisfiesMinimum*(value: SomeNumber, bound: BiggestFloat): bool =
  return value.BiggestFloat >= bound

proc satisfiesMaximum*(value: SomeNumber, bound: BiggestFloat): bool =
  return value.BiggestFloat <= bound

proc satisfiesExclusiveMinimum*(value: SomeNumber, bound: BiggestFloat): bool =
  return value.BiggestFloat > bound

proc satisfiesExclusiveMaximum*(value: SomeNumber, bound: BiggestFloat): bool =
  return value.BiggestFloat < bound

proc satisfiesMultipleOf*(value: SomeNumber, bound: BiggestFloat): bool =
  ## Exact for the integer case, and as close as binary floats get for the rest
  if bound == 0:
    return false
  let scaled = value.BiggestFloat / bound
  return scaled == scaled.round
