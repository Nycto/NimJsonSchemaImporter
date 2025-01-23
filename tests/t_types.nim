import std/[unittest, uri], json_schema_types/private/[namechain, types]

proc take(typ: TypeDef, name: NameChain, count: int): seq[string] =
    for next in typ.proposeNames("Pre", name):
        result.add(next)
        if result.len >= count:
            break

suite "Types":

    test "Generating names for a type with an id":
        let typ = TypeDef(kind: StringType, id: parseUri("http://example.com/foo/bar/baz.schema.json"))
        check(typ.take(nil, 3) == @["PreBaz", "PreBaz2", "PreBaz3"])

    test "Generating anonomous names":
        let typ = TypeDef(kind: StringType)
        check(typ.take(nil, 3) == @["PreAnon", "PreAnon2", "PreAnon3"])
