import std/[unittest, sequtils], json_schema_import/private/constraints

let minLen = ValidateNode(kind: MinLenValid, len: 3)
let maxLen = ValidateNode(kind: MaxLenValid, len: 5)
let pattern = ValidateNode(kind: PatternValid, pattern: "^a")

suite "Combining constraints":
  test "Nothing asserted leaves the other side alone":
    check(allOf(nil, minLen) == minLen)
    check(allOf(minLen, nil) == minLen)
    check(allOf(nil, nil) == nil)

  test "Nothing asserted accepts everything, so a disjunction with it does too":
    check(anyOf(nil, minLen) == nil)
    check(anyOf(minLen, nil) == nil)
    check(anyOf(nil, nil) == nil)

  test "Both sides are kept":
    check(allOf(minLen, maxLen) == ValidateNode(kind: AndValid, l: minLen, r: maxLen))
    check(anyOf(minLen, maxLen) == ValidateNode(kind: OrValid, l: minLen, r: maxLen))

suite "Walking a conjunction":
  test "A nil node asserts nothing":
    check(conjuncts(nil).toSeq.len == 0)

  test "A leaf is its own only conjunct":
    check(conjuncts(minLen).toSeq == @[minLen])

  test "A chain flattens, in order":
    let chain = allOf(allOf(minLen, maxLen), pattern)
    check(conjuncts(chain).toSeq == @[minLen, maxLen, pattern])

  test "A disjunction is one conjunct, kept whole":
    let mixed = allOf(minLen, anyOf(maxLen, pattern))
    check(conjuncts(mixed).toSeq == @[minLen, anyOf(maxLen, pattern)])

suite "Rendering constraints":
  test "Leaves read back as the keyword that made them":
    check($minLen == "minLength: 3")
    check($ValidateNode(kind: MinimumValid, bound: 2.0) == "minimum: 2")
    check($ValidateNode(kind: MultipleOfValid, bound: 0.5) == "multipleOf: 0.5")
    check($pattern == "pattern: \"^a\"")

  test "Combinations are parenthesised":
    check($allOf(minLen, maxLen) == "(minLength: 3 and maxLength: 5)")
    check($anyOf(minLen, maxLen) == "(minLength: 3 or maxLength: 5)")

  test "Asserting nothing has a name too":
    check($ValidateNode(nil) == "anything")
