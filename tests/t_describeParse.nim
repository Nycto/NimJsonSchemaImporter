import
  std/[unittest, json, sets, options, sequtils, tables],
  json_schema_import/private/[describe, describeparse, history, schemaRef]

proc parse(schema: string): Description =
  let node = schema.parseJson
  node.describeNode(
    newDescribeContext(node, nil), addRef(nil, SchemaRef(kind: RootRef))
  )

proc kinds(desc: Description): seq[VariantKind] =
  for variant in desc.variants:
    result.add(variant.kind)

suite "Describing types":
  test "A boolean schema":
    check("true".parse.kinds == @[vkAny])
    check("false".parse.isNever)

  test "A node saying nothing accepts anything":
    check("""{"description": "hi"}""".parse.kinds == @[vkAny])

  test "A type name, or a list of them":
    check("""{"type": "integer"}""".parse.kinds == @[vkInteger])
    check("""{"type": ["string", "null"]}""".parse.kinds == @[vkString, vkNull])

  test "An unsupported type name is rejected":
    expect ValueError:
      discard """{"type": "date"}""".parse

  test "A format names a string only when nothing else names a type":
    check("""{"format": "uuid"}""".parse.kinds == @[vkString])
    check("""{"type": "integer", "format": "int64"}""".parse.kinds == @[vkInteger])

  test "An enum names a string, and null when it lists one":
    let desc = """{"enum": ["a", null]}""".parse
    check(desc.kinds == @[vkString, vkNull])
    check(desc.variants[0].values.get.toSeq == @["a"])

  test "An enum only narrows the types it is about":
    let desc = """{"type": ["string", "null"], "enum": ["a"]}""".parse
    check(desc.kinds == @[vkString, vkNull])
    check(desc.variants[0].values.isSome)

  test "An enum of anything but strings says nothing":
    check("""{"type": "integer", "enum": [1, 2]}""".parse.kinds == @[vkInteger])
    check("""{"enum": [1, 2]}""".parse.kinds == @[vkAny])

  test "A const narrows the type its value belongs to":
    check("""{"const": "x"}""".parse.kinds == @[vkConst])
    check(
      """{"type": ["string", "null"], "const": "x"}""".parse.kinds == @[vkConst, vkNull]
    )
