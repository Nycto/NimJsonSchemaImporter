import std/[unittest, uri]
import json_schema_import/private/[constraints, namechain, schemaRef, types]

proc take(typ: TypeDef, name: NameChain, count: int): seq[string] =
  for next in typ.proposeNames("Pre", name):
    result.add(next)
    if result.len >= count:
      break

suite "Types":
  test "Generating names for a type with an id":
    let typ = TypeDef(
      kind: StringType, id: parseUri("http://example.com/foo/bar/baz.schema.json")
    )
    check(typ.take(nil, 3) == @["PreBaz", "PreBaz2", "PreBaz3"])

  test "Generating anonomous names":
    let typ = TypeDef(kind: StringType)
    check(typ.take(nil, 3) == @["PreAnon", "PreAnon2", "PreAnon3"])

suite "Comparing types":
  let minLen = ValidateNode(kind: MinLenValid, len: 3)

  proc str(validation: ValidateNode = nil): TypeDef =
    TypeDef(kind: StringType, validation: validation)

  test "A constraint tells two types apart":
    check(str() != str(minLen))
    check(str(minLen) == str(minLen))

  test "But not two shapes, which is what picks the Nim type":
    check(str().asShape == str(minLen).asShape)
    check(hash(str().asShape) == hash(str(minLen).asShape))

  test "A shape still tells apart the things that change the Nim type":
    check(str().asShape != TypeDef(kind: IntegerType).asShape)

  test "A constraint nested inside is invisible to a shape, and visible to `==`":
    proc wrap(inner: TypeDef): TypeDef =
      TypeDef(kind: ArrayType, items: inner)

    check(wrap(str()) != wrap(str(minLen)))
    check(wrap(str()).asShape == wrap(str(minLen)).asShape)

  test "Copying a type for a new label carries its constraints":
    let original = str(minLen).withRef(parseRef("#/$defs/a"))
    let copied = original.withRef(parseRef("#/$defs/b"))
    check(copied.validation == minLen)
