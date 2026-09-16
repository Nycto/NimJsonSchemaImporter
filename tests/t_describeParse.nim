import
  std/[unittest, json, sets, options, sequtils, tables, strutils],
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

suite "Describing objects":
  test "Properties and required keys":
    let variant = """{
      "properties": {"a": {"type": "string"}, "b": false},
      "required": ["a", "c"]
    }""".parse.variants[
      0
    ]
    check(variant.kind == vkObject)
    check(variant.shaped)
    check(variant.properties.keys.toSeq == @["a", "b", "c"])
    check(variant.properties["b"].isNever)
    check(variant.properties["c"].kinds == @[vkAny])
    check(variant.required.toSeq == @["a", "c"])

  test "A draft 3 required or an empty list implies nothing":
    check("""{"required": true}""".parse.kinds == @[vkAny])
    check("""{"required": []}""".parse.kinds == @[vkAny])

  test "Additional properties":
    let variant = """{"additionalProperties": {"type": "integer"}}""".parse.variants[0]
    check(not variant.shaped)
    check(variant.additional.kinds == @[vkInteger])
    check("""{"additionalProperties": false}""".parse.variants[0].additional.isNever)

  test "Object keywords only narrow an object":
    let desc = """{"type": ["string", "object"], "properties": {}}""".parse
    check(desc.kinds == @[vkString, vkObject])
    check(desc.variants[1].shaped)
    check("""{"type": "string", "properties": {}}""".parse.kinds == @[vkString])

  test "An object requiring a key nothing satisfies is dropped":
    check("""{"required": ["a"], "properties": {"a": false}}""".parse.isNever)

suite "Describing arrays":
  test "Items":
    let variant = """{"items": {"type": "string"}}""".parse.variants[0]
    check(variant.kind == vkArray)
    check(variant.items.kinds == @[vkString])

  test "A tuple, spelled either way":
    for schema in ["""{"prefixItems": [{"type": "string"}]}""", """{"items": [true]}"""]:
      let variant = schema.parse.variants[0]
      check(variant.prefix.get.len == 1)
      check(variant.items.isNil)

  test "Items cover the slots of a tuple, unless they are false":
    let covered =
      """{"prefixItems": [{"type": "number"}], "items": {"type": "integer"}}""".parse
    check(covered.variants[0].prefix.get[0].kinds == @[vkInteger])
    let closed = """{"prefixItems": [{"type": "string"}], "items": false}""".parse
    check(closed.variants[0].prefix.get[0].kinds == @[vkString])
    check(closed.variants[0].items.isNever)

  test "A tuple with a slot nothing fills is dropped":
    check("""{"prefixItems": [false]}""".parse.isNever)
    check(
      """{"type": ["array", "null"], "prefixItems": [false]}""".parse.kinds == @[vkNull]
    )

proc root(schema: string): Description =
  describeSchema(schema.parseJson, nil)

suite "Describing references":
  test "A reference is labelled with where it points":
    let desc = """{"$ref": "#/$defs/a", "$defs": {"a": {"type": "string"}}}""".root
    check($desc.sref == "#/$defs/a")
    check(desc.kinds == @[vkString])

  test "A reference closing a cycle is cut into an edge":
    let desc = """{"properties": {"next": {"$ref": "#"}}}""".root
    let next = desc.variants[0].properties["next"]
    check(next.kinds == @[vkEdge])
    check($next.variants[0].target == "#")

  test "A reference reached twice is described once":
    let desc = """{
      "properties": {"a": {"$ref": "#/$defs/x"}, "b": {"$ref": "#/$defs/x"}},
      "$defs": {"x": {"properties": {}}}
    }""".root
    check(desc.variants[0].properties["a"] == desc.variants[0].properties["b"])

  test "A reference resolving only to itself is rejected, naming the descent":
    try:
      discard """{
        "properties": {"held": {"$ref": "#/$defs/a"}},
        "$defs": {"a": {"$ref": "#/$defs/a"}}
      }""".root
      fail()
    except ValueError as e:
      check("resolves only to itself" in e.msg)
      check("#/properties/held -> #/$defs/a" in e.msg)

  test "Keywords beside a reference narrow it":
    let desc = """{
      "$ref": "#/$defs/a", "required": ["name"],
      "$defs": {"a": {"properties": {"name": {"type": "string"}}}}
    }""".root
    check(desc.variants[0].required.toSeq == @["name"])
    check(desc.variants[0].sref.isNil)

  test "A format beside a reference does not name a string":
    let desc =
      """{"$ref": "#/$defs/n", "format": "int32", "$defs": {"n": {"type": "integer"}}}""".root
    check(desc.kinds == @[vkInteger])

suite "Describing combinators":
  test "allOf intersects every branch":
    let desc = """{"allOf": [{"type": "string"}, {"enum": ["a", "b"]}]}""".root
    check(desc.kinds == @[vkString])
    check(desc.variants[0].values.isSome)

  test "oneOf and anyOf keep every branch in order":
    let desc = """{"oneOf": [{"type": "integer"}, {"type": ["string", "null"]}]}""".root
    check(desc.kinds == @[vkInteger, vkString, vkNull])

  test "Keywords beside a union are distributed over it, dropping what they rule out":
    let desc =
      """{"type": "string", "anyOf": [{"type": "integer"}, {"enum": ["a"]}]}""".root
    check(desc.kinds == @[vkString])
    check(desc.variants[0].values.isSome)

  test "An empty allOf or union is rejected":
    expect ValueError:
      discard """{"allOf": []}""".root
    expect ValueError:
      discard """{"oneOf": []}""".root
