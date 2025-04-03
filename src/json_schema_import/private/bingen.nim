import types, util, bin, std/[macros, tables]

let source {.compileTime.} = ident("source")
let target {.compileTime.} = ident("target")
let idx {.compileTime.} = ident("idx")

proc unionEncode(typ: TypeDef, typeName: NimNode): NimNode =
  assert(typ.kind == UnionType)
  var cases = nnkCaseStmt.newTree(newDotExpr(source, ident("kind")))

  for i, subtype in typ.subtypes:
    cases.add(
      nnkOfBranch.newTree(
        i.newLit, newCall(ident("toBinary"), target, newDotExpr(source, i.unionKey))
      )
    )

  return quote:
    toBinary(`target`, `source`.kind)
    `cases`

proc unionDecode(typ: TypeDef, typeName: NimNode): NimNode =
  assert(typ.kind == UnionType)
  let max = newLit(typ.subtypes.len - 1)

  result = nnkCaseStmt.newTree quote do:
    fromBinary(range[0 .. `max`], `source`, `idx`)

  for i, subtype in typ.subtypes:
    let key = i.unionKey
    let action = quote:
      return
        `typeName`(kind: `i`, `key`: fromBinary(typeof(result.`key`), `source`, `idx`))
    result.add(nnkOfBranch.newTree(i.newLit, action))

proc buildUnionBinSerde*(typ: TypeDef, typeName: NimNode): NimNode =
  doAssert(typ.kind == UnionType)
  let encode = typ.unionEncode(typeName)
  let decode = typ.unionDecode(typeName)
  return quote:
    proc toBinary*(`target`: var string, `source`: `typeName`) =
      `encode`

    proc fromBinary(
        _: typedesc[`typeName`], `source`: string, `idx`: var int
    ): `typeName` =
      `decode`
