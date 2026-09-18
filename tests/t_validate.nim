import std/[unittest], json_schema_import/private/validate

suite "Length assertions":
  test "Lengths count characters, not bytes":
    check(satisfiesMinLength("héllo", 5))
    check(satisfiesMaxLength("héllo", 5))
    check(not satisfiesMinLength("héllo", 6))
    check(not satisfiesMaxLength("héllo", 4))

  test "An empty string has no length to speak of":
    check(satisfiesMinLength("", 0))
    check(not satisfiesMinLength("", 1))

suite "Pattern assertions":
  test "A pattern searches, rather than matching the whole string":
    check(satisfiesPattern("xxabcyy", "a.c"))
    check(not satisfiesPattern("xxabd", "a.c"))

  test "A pattern that anchors itself is obeyed":
    check(satisfiesPattern("abc", "^a.c$"))
    check(not satisfiesPattern("xxabc", "^a.c$"))

suite "Numeric assertions":
  test "Bounds include their endpoint, and the exclusive ones do not":
    check(satisfiesMinimum(2, 2.0))
    check(satisfiesMaximum(2, 2.0))
    check(not satisfiesExclusiveMinimum(2, 2.0))
    check(not satisfiesExclusiveMaximum(2, 2.0))

  test "Bounds hold integers and floats alike":
    check(satisfiesMinimum(2.5, 2.0))
    check(not satisfiesMinimum(1.5, 2.0))

  test "A multiple divides exactly":
    check(satisfiesMultipleOf(10, 2.0))
    check(not satisfiesMultipleOf(7, 2.0))

  test "A multiple smaller than one still divides":
    check(satisfiesMultipleOf(0.0075, 0.0001))
    check(not satisfiesMultipleOf(0.00751, 0.0001))

  test "Nothing is a multiple of nothing":
    check(not satisfiesMultipleOf(0, 0.0))

suite "Reporting a failure":
  test "The message names the path and what it did not satisfy":
    expect ValueError:
      invalid("/name", "minLength: 3")

    try:
      invalid("/name", "minLength: 3")
    except ValueError as e:
      check(e.msg == "/name does not satisfy minLength: 3")
