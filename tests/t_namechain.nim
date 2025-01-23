import std/unittest, json_schema_import/private/namechain

proc take(name: NameChain, count: int): seq[string] =
    for next in name.nameOptions("Pre"):
        result.add(next)
        if result.len >= count:
            break

suite "Name chaining and generation":

    test "Empty name chain":
        check(take(nil, 4).len == 0)

    test "Single name chain":
        check(take(rootName("Foo"), 4) == @["PreFoo", "PreFoo2", "PreFoo3", "PreFoo4"])

    test "Empty name strings":
        check(take(rootName(""), 4).len == 0)
        check(take(rootName("").add(""), 4).len == 0)

    test "Single added name":
        check(take(rootName("Foo").add("bar"), 4) == @["PreBar", "PreFooBar", "PreFooBar2", "PreFooBar3"])

    test "Triple added names":
        check(take(rootName("Foo").add("bar").add("baz"), 4) == @["PreBaz", "PreBarBaz", "PreFooBarBaz", "PreFooBarBaz2"])

    test "Categorized name":
        check(take(rootName("Foo").categorize("Union"), 4) == @["PreFoo", "PreFooUnion", "PreFooUnion2", "PreFooUnion3"])

    test "Multiple Categorized names":
        check(take(rootName("Foo").categorize("Union").add("bar").categorize("Obj"), 5) ==
            @["PreBar", "PreBarObj", "PreFooBarObj", "PreFooBarObjUnion", "PreFooBarObjUnion2"])
