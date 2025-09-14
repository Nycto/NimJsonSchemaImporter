import types, util, stringify, std/[macros, genasts, tables, json]

let value {.compileTime.} = ident("value")

proc buildObjDollar(typ: TypeDef, typeName: NimNode): NimNode =
  assert(typ.kind == ObjType)
  result = newCall(bindSym("stringifyObj"), typeName.getName.newLit)
  for _, (propName, subtype, _) in typ.properties:
    let propRef = safePropName(propName)

    let propStr = if subtype.kind == ConstValueType:
      newLit($subtype.value)
    else:
      quote:
        stringify(typeof(`value`.`propRef`), `value`.`propRef`)

    result.add(nnkTupleConstr.newTree(propName.newLit, propStr))

proc buildUnionDollar(typ: TypeDef, typeName: NimNode): NimNode =
  assert(typ.kind == UnionType)
  result = nnkCaseStmt.newTree(newDotExpr(value, ident("kind")))
  for i, subtype in typ.subtypes:
    let key = i.unionKey
    let toStr = quote:
      stringify(typeof(`value`.`key`), `value`.`key`)
    result.add(nnkOfBranch.newTree(i.newLit, nnkReturnStmt.newTree(toStr)))

proc buildDollars*(typ: TypeDef, typeName: NimNode): NimNode =
  let body =
    case typ.kind
    of ObjType:
      buildObjDollar(typ, typeName)
    of UnionType:
      buildUnionDollar(typ, typeName)
    else:
      return newStmtList()

  return genAst(typeName, body, value):
    proc stringify(_: typedesc[typeName], value: typeName): string =
      body

    proc `$`*(value: typeName): string =
      stringify(typeName, value)
