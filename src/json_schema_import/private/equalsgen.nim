import types, util, std/[macros, genasts, tables, typetraits]

let a {.compileTime.} = ident("a")
let b {.compileTime.} = ident("b")

proc keysEqual(key: NimNode): NimNode =
  return quote:
    equals(typeof(`a`.`key`), `a`.`key`, `b`.`key`)

proc buildObjEquals(typ: TypeDef, typeName: NimNode): NimNode =
  assert(typ.kind == ObjType)
  var output = newEmptyNode()
  for _, (propName, typ, _) in typ.properties:
    if typ.hasRealField:
      let compare = keysEqual(safePropName(propName))
      output =
        if output.kind == nnkEmpty:
          compare
        else:
          infix(output, "and", compare)
  return output or newLit(true)

proc buildUnionEquals(typ: TypeDef, typeName: NimNode): NimNode =
  assert(typ.kind == UnionType)

  var cases = nnkCaseStmt.newTree(newDotExpr(a, ident("kind")))
  for i, subtype in typ.subtypes:
    cases.add(
      nnkOfBranch.newTree(i.newLit, nnkReturnStmt.newTree(keysEqual(i.unionKey)))
    )

  return genAst(a, b, cases):
    if a.kind != b.kind:
      return false
    cases

proc buildDistinctEquals(typeName: NimNode): NimNode =
  ## A distinct is equal by what it wraps, reached through `distinctBase`
  return genAst(typeName, a, b):
    equals(distinctBase(typeName), distinctBase(typeName)(a), distinctBase(typeName)(b))

proc buildEquals*(typ: TypeDef, typeName: NimNode): NimNode =
  let body =
    case typ.kind
    of ObjType:
      buildObjEquals(typ, typeName)
    of UnionType:
      buildUnionEquals(typ, typeName)
    of ConstValueType:
      # Two values of a const type are the same value, by construction
      newLit(true)
    of DistinctType:
      buildDistinctEquals(typeName)
    else:
      return newStmtList()

  return genAst(typeName, body, a, b):
    proc equals(_: typedesc[typeName], a, b: typeName): bool =
      body

    proc `==`*(a, b: typeName): bool =
      return equals(typeName, a, b)
