import types, util, bin, std/[macros, tables]

let source {.compileTime.} = ident("source")
let target {.compileTime.} = ident("target")
let idx {.compileTime.} = ident("idx")

proc objBin(typ: TypeDef, typeName: NimNode): (NimNode, NimNode) =
    assert(typ.kind == ObjType)

    let encode = newStmtList()
    let decode = newStmtList()

    for _, (propName, subtype, _) in typ.properties:
        let safeKey = safePropName(propName)

        encode.add(newCall(ident("toBinary"), target, newDotExpr(source, safeKey)))

        decode.add quote do:
            result.`safeKey` = fromBinary(typeof(result.`safeKey`), `source`, `idx`)

    return (encode, decode)

proc unionEncode(typ: TypeDef, typeName: NimNode): NimNode =
    assert(typ.kind == UnionType)
    var cases = nnkCaseStmt.newTree(newDotExpr(source, ident("kind")))

    for i, subtype in typ.subtypes:
        cases.add(nnkOfBranch.newTree(i.newLit, newCall(ident("toBinary"), target, newDotExpr(source, i.unionKey))))

    return quote:
        toBinary(`target`, `source`.kind)
        `cases`

proc unionDecode(typ: TypeDef, typeName: NimNode): NimNode =
    assert(typ.kind == UnionType)
    let max = newLit(typ.subtypes.len - 1)

    result = nnkCaseStmt.newTree quote do:
        fromBinary(range[0..`max`], `source`, `idx`)

    for i, subtype in typ.subtypes:
        let key = i.unionKey
        let action = quote:
            return `typeName`(kind: `i`, `key`: fromBinary(typeof(result.`key`), `source`, `idx`))
        result.add(nnkOfBranch.newTree(i.newLit, action))

proc buildBinarySerde*(typ: TypeDef, typeName: NimNode): NimNode =
    let (encode, decode) = case typ.kind
        of ObjType: typ.objBin(typeName)
        of UnionType: (typ.unionEncode(typeName), typ.unionDecode(typeName))
        else: raiseAssert("Unsupported value type")

    return quote:
        proc toBinary*(`target`: var string, `source`: `typeName`) =
            `encode`

        proc toBinary*(`source`: `typeName`): string =
            toBinary(result, `source`)

        proc fromBinary(_: typedesc[`typeName`], `source`: string, `idx`: var int): `typeName` =
            `decode`

        proc fromBinary*(_: typedesc[`typeName`], `source`: string): `typeName` =
            var `idx` = 0
            return fromBinary(`typeName`, `source`, `idx`)
