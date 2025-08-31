import
  std/[unittest, strutils, options, tables, json, macros],
  json_schema_import/private/bin

proc encode[T](value: T): string =
  toBinary(result, value)

proc decode(encoded: string, kind: typedesc): kind =
  var i = 0
  fromBinary(kind, encoded, i)

type EnumValue = enum
  a
  b
  c

suite "toBinary and fromBinary conversions":
  macro checkValues(kind: untyped, values: varargs[typed]) =
    var tests = newStmtList()
    for value in values:
      tests.add quote do:
        require(encode[`kind`](`kind`(`value`)).decode(`kind`) == `kind`(`value`))
        const encoded = encode[`kind`](`kind`(`value`))
        require(encoded.decode(`kind`) == `kind`(`value`))
    return quote:
      {.push hint[ConvFromXtoItselfNotNeeded]: off.}
      test "Convert " & $`kind` & " to binary":
        `tests`
      {.pop.}

  checkValues(bool, true, false)

  template uintTest(kind: typedesc[SomeInteger]) =
    checkValues(kind, 0.kind, 1, 100, high(kind), low(kind))

  uintTest(uint64)
  uintTest(uint32)
  uintTest(uint16)
  uintTest(uint8)

  template intTest(kind: typedesc[SomeInteger]) =
    checkValues(kind, 0.kind, 1, -1, 100, -100, high(kind), low(kind))

  intTest(int64)
  intTest(int32)
  intTest(int16)
  intTest(int8)

  checkValues(EnumValue, a, b, c)
  checkValues(string, "", "a", "abc", "a".repeat(1000))

  checkValues(Option[int], none(int), some(0), some(1))
  checkValues(Option[string], none(string), some(""), some("a"))

  template floatTest(kind: typedesc[SomeFloat]) =
    checkValues(kind, 0.kind, 3.14, 100.0, -100, high(kind), low(kind))

  floatTest(float64)
  floatTest(float32)

  checkValues(seq[string], @[], @["a"], @["a", "b", "c"])
  checkValues(seq[int], @[], @[0], @[0, 1, 2])

  checkValues(
    Table[string, int],
    initTable[string, int](),
    {"a": 1}.toTable,
    {"a": 1, "b": 2}.toTable,
  )

  checkValues(
    Table[string, string],
    initTable[string, string](),
    {"a": "_".repeat(100)}.toTable,
    {"a": "abc", "b": "xyz"}.toTable,
  )

  checkValues(
    JsonNode,
    newJNull(),
    %true,
    %false,
    %1,
    %3.14,
    %"a",
    %["a", "b", "c"],
    %({"a": 1, "b": 2}.toTable),
  )
