import
  std/[unittest, json, sets, options, sequtils, tables, strutils],
  json_schema_import/private/[constraints, describe, describeparse, schemaRef]

proc parse(schema: string): Description =
  describeSchema(schema.parseJson, nil)

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

  test "Pattern properties name a map without typing it":
    let variant =
      """{"patternProperties": {"^x-": {"type": "string"}}}""".parse.variants[0]
    check(variant.kind == vkObject)
    check(not variant.shaped)
    check(variant.additional.kinds == @[vkAny])

  test "A pattern reopens an object additionalProperties closed":
    let variant = """{"patternProperties": {"^x-": true}, "additionalProperties": false}""".parse.variants[
      0
    ]
    check(not variant.additional.isNever)

  test "An empty pattern list leaves additionalProperties alone":
    let variant = """{"patternProperties": {}, "additionalProperties": {"type": "string"}}""".parse.variants[
      0
    ]
    check(variant.additional.kinds == @[vkString])

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

suite "Describing references":
  test "A reference is labelled with where it points":
    let desc = """{"$ref": "#/$defs/a", "$defs": {"a": {"type": "string"}}}""".parse
    check($desc.sref == "#/$defs/a")
    check(desc.kinds == @[vkString])

  test "A reference closing a cycle is cut into an edge":
    let desc = """{"properties": {"next": {"$ref": "#"}}}""".parse
    let next = desc.variants[0].properties["next"]
    check(next.kinds == @[vkEdge])
    check($next.variants[0].target == "#")

  test "A reference reached twice is described once":
    let desc = """{
      "properties": {"a": {"$ref": "#/$defs/x"}, "b": {"$ref": "#/$defs/x"}},
      "$defs": {"x": {"properties": {}}}
    }""".parse
    check(desc.variants[0].properties["a"] == desc.variants[0].properties["b"])

  test "A reference resolving only to itself is rejected, naming the descent":
    try:
      discard """{
        "properties": {"held": {"$ref": "#/$defs/a"}},
        "$defs": {"a": {"$ref": "#/$defs/a"}}
      }""".parse
      fail()
    except ValueError as e:
      check("resolves only to itself" in e.msg)
      check("#/properties/held -> #/$defs/a" in e.msg)

  test "Keywords beside a reference narrow it":
    let desc = """{
      "$ref": "#/$defs/a", "required": ["name"],
      "$defs": {"a": {"properties": {"name": {"type": "string"}}}}
    }""".parse
    check(desc.variants[0].required.toSeq == @["name"])
    check(desc.variants[0].sref.isNil)

  test "A format beside a reference does not name a string":
    let desc =
      """{"$ref": "#/$defs/n", "format": "int32", "$defs": {"n": {"type": "integer"}}}""".parse
    check(desc.kinds == @[vkInteger])

suite "Describing combinators":
  test "allOf intersects every branch":
    let desc = """{"allOf": [{"type": "string"}, {"enum": ["a", "b"]}]}""".parse
    check(desc.kinds == @[vkString])
    check(desc.variants[0].values.isSome)

  test "oneOf and anyOf keep every branch in order":
    let desc =
      """{"oneOf": [{"type": "integer"}, {"type": ["string", "null"]}]}""".parse
    check(desc.kinds == @[vkInteger, vkString, vkNull])

  test "Keywords beside a union are distributed over it, dropping what they rule out":
    let desc =
      """{"type": "string", "anyOf": [{"type": "integer"}, {"enum": ["a"]}]}""".parse
    check(desc.kinds == @[vkString])
    check(desc.variants[0].values.isSome)

  test "An empty allOf or union is rejected":
    expect ValueError:
      discard """{"allOf": []}""".parse
    expect ValueError:
      discard """{"oneOf": []}""".parse

suite "Describing assertions":
  proc asserts(schema: string): seq[string] =
    for variant in schema.parse.variants:
      result.add($variant.validation)

  test "Length keywords describe a string":
    check("""{"minLength": 3}""".parse.kinds == @[vkString])
    check("""{"minLength": 3}""".asserts == @["minLength: 3"])
    check(
      """{"minLength": 3, "maxLength": 5}""".asserts ==
        @["(minLength: 3 and maxLength: 5)"]
    )

  test "A pattern describes a string":
    check("""{"pattern": "^a"}""".parse.kinds == @[vkString])
    check("""{"pattern": "^a"}""".asserts == @["pattern: \"^a\""])

  test "Numeric keywords describe a number":
    check("""{"minimum": 2}""".parse.kinds == @[vkNumber])
    check("""{"minimum": 2}""".asserts == @["minimum: 2"])
    check("""{"multipleOf": 0.5}""".asserts == @["multipleOf: 0.5"])

  test "A written type keeps its own shape and takes the assertion":
    check("""{"type": "string", "minLength": 3}""".parse.kinds == @[vkString])
    check("""{"type": "string", "minLength": 3}""".asserts == @["minLength: 3"])

  test "An integer is a number, so a bound written for one holds it":
    let schema = """{"type": "integer", "minimum": 2}"""
    check(schema.parse.kinds == @[vkInteger])
    check(schema.asserts == @["minimum: 2"])

  test "An assertion narrows only the type it is about":
    let schema = """{"type": ["string", "integer"], "minLength": 3}"""
    check(schema.parse.kinds == @[vkString, vkInteger])
    check(schema.asserts == @["minLength: 3", "anything"])

  test "allOf conjoins what each branch asserts":
    let schema = """
      {"type": "string", "allOf": [{"minLength": 3}, {"maxLength": 5}]}
    """
    check(schema.asserts == @["(minLength: 3 and maxLength: 5)"])

  test "Alternatives each keep their own":
    let schema = """{"anyOf": [{"minLength": 3}, {"maxLength": 5}]}"""
    check(schema.asserts == @["minLength: 3", "maxLength: 5"])

  test "A keyword written with a value of the wrong type says nothing":
    check("""{"minLength": "three"}""".parse.kinds == @[vkAny])
    check("""{"pattern": 3}""".parse.kinds == @[vkAny])

  test "A whole number spelled as a decimal still counts":
    check("""{"maxLength": 2.0}""".asserts == @["maxLength: 2"])
    check("""{"minLength": 1.0, "maxLength": 2.0}""".parse.kinds == @[vkString])

  test "A count that is not whole says nothing, since no length could equal it":
    check("""{"maxLength": 2.5}""".parse.kinds == @[vkAny])
