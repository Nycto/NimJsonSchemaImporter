import
  std/[unittest, json, sets, options, sequtils], json_schema_import/private/describe

proc v(kind: VariantKind): Variant =
  Variant(kind: kind)

proc enumOf(values: varargs[string]): Variant =
  Variant(kind: vkString, values: some(toOrderedSet(values)))

proc fixed(value: JsonNode): Variant =
  Variant(kind: vkConst, value: value)

proc kinds(desc: Description): seq[VariantKind] =
  for variant in desc.variants:
    result.add(variant.kind)

suite "Intersecting scalar variants":
  test "Any value narrows to whatever the other side says":
    check(intersect(anyValue(), describe(v(vkString))).kinds == @[vkString])
    check(intersect(describe(v(vkBool)), anyValue()).kinds == @[vkBool])

  test "Matching kinds survive":
    check(intersect(describe(v(vkNull)), describe(v(vkNull))).kinds == @[vkNull])

  test "Mismatched kinds leave nothing":
    check(intersect(describe(v(vkString)), describe(v(vkInteger))).isNever)

  test "An integer is a number":
    check(
      intersect(describe(v(vkNumber)), describe(v(vkInteger))).kinds == @[vkInteger]
    )
    check(
      intersect(describe(v(vkInteger)), describe(v(vkNumber))).kinds == @[vkInteger]
    )

  test "An enum narrows a string":
    let merged = intersect(describe(v(vkString)), describe(enumOf("a", "b")))
    check(merged.variants[0].values.get == toOrderedSet(["a", "b"]))

  test "Two enums keep only the values they share":
    let merged = intersect(describe(enumOf("a", "b", "c")), describe(enumOf("c", "b")))
    check(merged.variants[0].values.get.toSeq == @["b", "c"])

  test "Two enums sharing nothing leave nothing":
    check(intersect(describe(enumOf("a")), describe(enumOf("b"))).isNever)

  test "A const narrows the kind its value belongs to":
    check(intersect(describe(v(vkString)), describe(fixed(%"x"))).kinds == @[vkConst])
    check(intersect(describe(fixed(%3)), describe(v(vkNumber))).kinds == @[vkConst])
    check(intersect(describe(fixed(%3)), describe(v(vkString))).isNever)

  test "Two consts only agree on the same value":
    check(intersect(describe(fixed(%"x")), describe(fixed(%"x"))).kinds == @[vkConst])
    check(intersect(describe(fixed(%"x")), describe(fixed(%"y"))).isNever)

  test "An edge absorbs whatever is written beside it":
    check(intersect(describe(v(vkEdge)), describe(v(vkString))).kinds == @[vkEdge])
    check(intersect(describe(v(vkString)), describe(v(vkEdge))).kinds == @[vkEdge])

suite "Combining alternatives":
  test "A union keeps every alternative in order":
    let joined = union(describe(v(vkString), v(vkNull)), describe(enumOf("a")))
    check(joined.kinds == @[vkString, vkNull, vkString])

  test "An intersection distributes over every alternative and drops the empty ones":
    let merged =
      intersect(describe(v(vkString), v(vkInteger), v(vkNull)), describe(v(vkNumber)))
    check(merged.kinds == @[vkInteger])

  test "Nothing intersected with anything is nothing":
    check(intersect(never(), anyValue()).isNever)
