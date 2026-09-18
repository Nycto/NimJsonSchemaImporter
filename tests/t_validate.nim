import std/[unittest, json, jsonutils, options, tables]
import json_schema_import, json_schema_import/private/validate

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

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Person"),
  %*{
    "type": "object",
    "required": ["name"],
    "properties": {
      "name": {"type": "string", "minLength": 3, "maxLength": 6},
      "age": {"type": "integer", "minimum": 0},
      "tags": {"type": "array", "items": {"type": "string", "pattern": "^[a-z]+$"}},
      "scores":
        {"type": "object", "additionalProperties": {"type": "number", "multipleOf": 5}},
      "nested":
        {"type": "object", "properties": {"code": {"type": "string", "minLength": 2}}},
    },
  },
)

proc decode(instance: string): Person =
  jsonTo(instance.parseJson, Person)

proc rejects(instance, because: string) =
  try:
    discard instance.decode
    check(false)
  except ValueError as e:
    check(e.msg == because)

jsonSchema(
  JsonSchemaConfig(rootTypeName: "Unholdable"),
  %*{"type": "string", "pattern": "^\\p{Letter}+$"},
)

suite "A pattern the regex engine cannot hold":
  test "Asserts nothing, rather than failing the build":
    check(jsonTo(%*"abc", Unholdable) == "abc")
    check(jsonTo(%*"123", Unholdable) == "123")

  test "So the type keeps its alias, having nothing to assert":
    check(Unholdable is string)

suite "Validating while decoding":
  test "A value satisfying everything decodes":
    check(""" {"name": "abcd"} """.decode.name == "abcd")

  test "A string is held to its length":
    rejects(""" {"name": "ab"} """, "Person/name does not satisfy minLength: 3")
    rejects(""" {"name": "abcdefg"} """, "Person/name does not satisfy maxLength: 6")

  test "An absent optional asserts nothing, a present one does":
    check(""" {"name": "abcd"} """.decode.age.isNone)
    rejects(
      """ {"name": "abcd", "age": -1} """, "Person/age does not satisfy minimum: 0"
    )

  test "Every element of a seq is held to what its items say":
    rejects(
      """ {"name": "abcd", "tags": ["ok", "N0"]} """,
      "Person/tags/1 does not satisfy pattern: \"^[a-z]+$\"",
    )

  test "Every entry of a map is held to what its values say":
    rejects(
      """ {"name": "abcd", "scores": {"a": 10, "b": 7}} """,
      "Person/scores/b does not satisfy multipleOf: 5",
    )

  test "A nested object reports against its own type, having validated itself":
    rejects(
      """ {"name": "abcd", "nested": {"code": "x"}} """,
      "Nested/code does not satisfy minLength: 2",
    )

  test "Validating a value directly says the same thing":
    var person = """ {"name": "abcd"} """.decode
    person.name = "ab"
    expect ValueError:
      validate(Person, person)
