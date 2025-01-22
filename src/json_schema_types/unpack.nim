import std/macros, types, util

proc buildUnionUnpacker*(typ: TypeDef, typeName: NimNode): NimNode =
    ## Builds methods for unpacking the value in a union
    assert(typ.kind == UnionType)

    result = newStmtList()

    for i, subtype in typ.subtypes:
        let suffix = subtype.chooseName
        let checker = ident("is" & suffix)
        let getter = ident("as" & suffix)
        let keyName = i.unionKey
        result.add quote do:
            proc `checker`(value: `typeName`): bool = value.kind == `i`

            proc `getter`(value: `typeName`): auto =
                assert(value.kind == `i`)
                return value.`keyName`