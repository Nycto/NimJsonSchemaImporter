import types, util, std/[macros, genasts, tables]

let a {.compileTime.} = ident("a")
let b {.compileTime.} = ident("b")

proc keysEqual(key: NimNode): NimNode =
    return quote:
        equals(typeof(`a`.`key`), `a`.`key`, `b`.`key`)

proc buildObjEquals(typ: TypeDef, typeName: NimNode): NimNode =
    assert(typ.kind == ObjType)
    var output = newEmptyNode()
    for _, (propName, _, _) in typ.properties:
        let compare = keysEqual(safePropName(propName))
        output = if output.kind == nnkEmpty: compare else: infix(output, "and", compare)
    return output or newLit(false)

proc buildUnionEquals(typ: TypeDef, typeName: NimNode): NimNode =
    assert(typ.kind == UnionType)

    var cases = nnkCaseStmt.newTree(newDotExpr(a, ident("kind")))
    for i, subtype in typ.subtypes:
        cases.add(nnkOfBranch.newTree(i.newLit, nnkReturnStmt.newTree(keysEqual(i.unionKey))))

    return genAst(a, b, cases):
        if a.kind != b.kind:
            return false
        cases

proc buildEquals*(typ: TypeDef, typeName: NimNode): NimNode =
    let body = case typ.kind
    of ObjType: buildObjEquals(typ, typeName)
    of UnionType: buildUnionEquals(typ, typeName)
    else: return newStmtList()

    return genAst(typeName, body, a, b):
        proc equals(_: typedesc[typeName], a, b: typeName): bool =
            body

        proc `==`*(a, b: typeName): bool =
            return equals(typeName, a, b)
