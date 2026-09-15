import
  std/[unittest, json, sets, options, sequtils, tables],
  json_schema_import/private/describe

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

proc obj(props: openArray[(string, Description)], required: varargs[string]): Variant =
  result = Variant(kind: vkObject, shaped: true, required: toOrderedSet(required))
  for (key, prop) in props:
    result.properties[key] = prop

proc arr(items: Description): Variant =
  Variant(kind: vkArray, items: items)

proc tup(slots: varargs[Description]): Variant =
  Variant(kind: vkArray, prefix: some(@slots))

suite "Intersecting objects":
  test "Properties from both sides are kept, the left side's first":
    let merged = intersect(
      describe(obj({"a": describe(v(vkString))}, "a")),
      describe(obj({"b": describe(v(vkInteger)), "a": anyValue()}, "b")),
    )
    let variant = merged.variants[0]
    check(variant.properties.keys.toSeq == @["a", "b"])
    check(variant.properties["a"].kinds == @[vkString])
    check(variant.required.toSeq == @["a", "b"])

  test "A property both sides describe is narrowed by both":
    let merged = intersect(
      describe(obj({"a": describe(v(vkNumber), v(vkNull))})),
      describe(obj({"a": describe(v(vkInteger))})),
    )
    check(merged.variants[0].properties["a"].kinds == @[vkInteger])

  test "A required property nothing satisfies leaves no object":
    let merged = intersect(
      describe(obj({"a": describe(v(vkString))}, "a")),
      describe(obj({"a": describe(v(vkInteger))})),
    )
    check(merged.isNever)

  test "An optional property nothing satisfies leaves the object":
    let merged = intersect(
      describe(obj({"a": describe(v(vkString))})),
      describe(obj({"a": describe(v(vkInteger))})),
    )
    check(merged.variants[0].properties["a"].isNever)

  test "Additional properties are narrowed, and a listing on either side shapes it":
    let open = Variant(kind: vkObject, additional: describe(v(vkNumber)))
    let other = Variant(kind: vkObject, additional: describe(v(vkInteger)))
    let merged = intersect(describe(open), describe(other)).variants[0]
    check(merged.additional.kinds == @[vkInteger])
    check(not merged.shaped)
    check(intersect(describe(open), describe(obj({:}))).variants[0].shaped)

suite "Intersecting arrays":
  test "Items are narrowed":
    let merged = intersect(
      describe(arr(describe(v(vkString), v(vkInteger)))),
      describe(arr(describe(v(vkString)))),
    )
    check(merged.variants[0].items.kinds == @[vkString])

  test "Items are folded into the slots of a tuple":
    let merged = intersect(
      describe(tup(describe(v(vkNumber)), anyValue())),
      describe(arr(describe(v(vkInteger)))),
    )
    check(merged.variants[0].prefix.get[0].kinds == @[vkInteger])
    check(merged.variants[0].prefix.get[1].kinds == @[vkInteger])

  test "Items that accept nothing only close the tuple off":
    let merged = intersect(describe(tup(describe(v(vkString)))), describe(arr(never())))
    check(merged.variants[0].prefix.get[0].kinds == @[vkString])

  test "Two tuples are narrowed slot by slot":
    let merged = intersect(
      describe(tup(describe(v(vkNumber)))), describe(tup(describe(v(vkInteger))))
    )
    check(merged.variants[0].prefix.get[0].kinds == @[vkInteger])

  test "A slot nothing satisfies leaves no array, but spares the other alternatives":
    let merged = intersect(
      describe(tup(describe(v(vkString))), v(vkString)),
      describe(tup(describe(v(vkInteger))), v(vkString)),
    )
    check(merged.kinds == @[vkString])

  test "Tuples of different lengths are rejected":
    expect ValueError:
      discard
        intersect(describe(tup(anyValue())), describe(tup(anyValue(), anyValue())))

  test "An array const narrows an array":
    check(intersect(describe(fixed(%*[1])), describe(arr(nil))).kinds == @[vkConst])
