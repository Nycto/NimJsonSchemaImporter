import std/[unittest, tables, sets], json_schema_import/private/[parse, types]

proc parse(schema: string): TypeDef =
  ## Parses a schema without any url resolution, since none of these reach outwards
  parseSchema(schema, nil).rootType

suite "A false subschema":
  test "Forbids a property outright":
    let typ = parse(
      """{"type": "object", "properties": {"kept": {"type": "string"}, "gone": false}}"""
    )
    check(typ.kind == ObjType)
    check("gone" notin typ.properties)
    check("kept" in typ.properties)

  test "Forbids a property it only works out to":
    let typ = parse(
      """{
        "type": "object",
        "properties": {
          "viaUnion": {"oneOf": [false]},
          "viaAllOf": {"allOf": [false]},
          "besideAType": {"type": "string", "allOf": [false]},
          "inATupleSlot": {"prefixItems": [{"type": "string"}, false]}
        }
      }"""
    )
    check(typ.kind == ObjType)
    check(typ.properties.len == 0)

  test "Leaves the arms of a union it does not describe":
    let typ = parse("""{"oneOf": [false, {"type": "string"}]}""")
    check(typ.kind == StringType)

  test "Collapses a union of nothing but itself":
    # Reached through a property, since a root that accepts nothing is an error
    let typ =
      parse("""{"type": "object", "properties": {"gone": {"anyOf": [false, false]}}}""")
    check(typ.properties.len == 0)

  test "Keeps a null arm alive on its own":
    let typ = parse("""{"oneOf": [false, {"type": "null"}]}""")
    check(typ.kind == NullType)

  test "Absorbs whatever is written beside it":
    let typ = parse(
      """{"type": "object", "properties": {"gone": {"allOf": [{"type": "string"}, false]}}}"""
    )
    check(typ.properties.len == 0)

suite "A false items":
  test "Adds no constraint to a tuple it closes":
    let typ = parse(
      """{"type": "array", "prefixItems": [{"type": "string"}], "items": false}"""
    )
    check(typ.kind == TupleType)
    check(typ.elements.len == 1)
    check(typ.elements[0].kind == StringType)

  test "Describes an array that can only ever be empty as a tuple of no slots":
    let typ = parse("""{"type": "array", "items": false}""")
    check(typ.kind == TupleType)
    check(typ.elements.len == 0)

  test "Closes a draft-07 tuple through additionalItems":
    let typ = parse(
      """{
        "type": "array",
        "items": [{"type": "boolean"}, {"type": "string"}],
        "additionalItems": false
      }"""
    )
    check(typ.kind == TupleType)
    check(typ.elements.len == 2)
    check(typ.elements[0].kind == BoolType)
    check(typ.elements[1].kind == StringType)

suite "A false additionalProperties":
  test "Closes the object off when it is only worked out":
    let typ = parse(
      """{
        "type": "object",
        "properties": {"named": {"type": "string"}},
        "additionalProperties": {"allOf": [false]}
      }"""
    )
    check(typ.kind == ObjType)
    check(typ.properties.len == 1)
    check("named" in typ.properties)

suite "A schema that accepts nothing":
  test "Is rejected at the root":
    expect ValueError:
      discard parse("false")

  test "Is rejected when the root works out to one":
    expect ValueError:
      discard parse("""{"type": "string", "oneOf": [false]}""")

suite "Types a combine rules out":
  test "A type beside a union drops the arms it rules out":
    let typ = parse(
      """{"type": "string", "oneOf": [{"type": "integer"}, {"type": "string"}]}"""
    )
    check(typ.kind == StringType)

  test "An integer is the number both sides allow":
    check(
      parse("""{"allOf": [{"type": "number"}, {"type": "integer"}]}""").kind ==
        IntegerType
    )

  test "Two enums keep only the values they share":
    let typ = parse("""{"allOf": [{"enum": ["a", "b"]}, {"enum": ["b", "c"]}]}""")
    check(typ.kind == EnumType)
    check(typ.values.len == 1)
    check("b" in typ.values)

  test "An object requiring a key nothing satisfies is dropped, sparing null":
    let typ = parse(
      """{"type": ["object", "null"], "required": ["a"], "properties": {"a": false}}"""
    )
    check(typ.kind == NullType)

  test "A tuple slot nothing fills only drops the array":
    check(
      parse("""{"oneOf": [{"prefixItems": [false]}, {"type": "string"}]}""").kind ==
        StringType
    )

  test "A null an enum lists is dropped when the type rules it out":
    check(parse("""{"type": ["string"], "enum": ["a", null]}""").kind == EnumType)
