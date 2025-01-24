import std/[macros, sets], types, util

proc buildUnionUnpacker*(typ: TypeDef, typeName: NimNode): NimNode =
    ## Builds methods for unpacking the value in a union
    assert(typ.kind == UnionType)

    result = newStmtList()

    var namesSeen = initHashSet[string]()

    for i, subtype in typ.subtypes:
        var name: string
        for suffix in subtype.nameFragments:
            name &= suffix
            if name notin namesSeen:
                namesSeen.incl(name)

                let checker = ident("is" & name)
                let getter = ident("as" & name)
                let keyName = i.unionKey
                result.add quote do:
                    proc `checker`*(value: `typeName`): bool = value.kind == `i`

                    proc `getter`*(value: `typeName`): auto =
                        assert(value.kind == `i`)
                        return value.`keyName`