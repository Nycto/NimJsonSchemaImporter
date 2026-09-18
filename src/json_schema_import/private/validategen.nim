import types, util, constraints, validate
import std/[macros, genasts, sequtils, tables, options]

let value {.compileTime.} = ident("value")
let path {.compileTime.} = ident("path")

const STRING_ASSERTIONS = {MinLenValid, MaxLenValid, PatternValid}

proc predicate(node: ValidateNode, access: NimNode): NimNode =
  ## The boolean expression asserting a node of the tree, whole
  template call(name: untyped, arg: NimNode): NimNode =
    newCall(bindSym(astToStr(name)), access, arg)

  return
    case node.kind
    of AndValid:
      infix(node.l.predicate(access), "and", node.r.predicate(access))
    of OrValid:
      infix(node.l.predicate(access), "or", node.r.predicate(access))
    of MinLenValid:
      call(satisfiesMinLength, node.len.newLit)
    of MaxLenValid:
      call(satisfiesMaxLength, node.len.newLit)
    of PatternValid:
      call(satisfiesPattern, node.pattern.newLit)
    of MinimumValid:
      call(satisfiesMinimum, node.bound.newLit)
    of MaximumValid:
      call(satisfiesMaximum, node.bound.newLit)
    of ExclusiveMinValid:
      call(satisfiesExclusiveMinimum, node.bound.newLit)
    of ExclusiveMaxValid:
      call(satisfiesExclusiveMaximum, node.bound.newLit)
    of MultipleOfValid:
      call(satisfiesMultipleOf, node.bound.newLit)

proc walk(typ: TypeDef, access, location: NimNode): NimNode

proc assertions(typ: TypeDef, access, location: NimNode): NimNode =
  ## What the type itself says about the value held at `access`
  ##
  ## A conjunction is split so each side reports on its own; a disjunction cannot be,
  ## since no one branch failing says anything until they all have.
  result = newStmtList()
  for assertion in typ.validation.conjuncts:
    if assertion.checkable(typ):
      let test = assertion.predicate(access)
      let named = ($assertion).newLit
      result.add quote do:
        if not (`test`):
          invalid(`location`, `named`)

proc walkOptional(typ: TypeDef, access, location: NimNode): NimNode =
  ## An absent value asserts nothing, so the whole check goes under the `isSome`
  if not typ.subtype.asserts:
    return newStmtList()
  let body = typ.subtype.walk(newCall(bindSym"unsafeGet", access), location)
  return quote:
    if isSome(`access`):
      `body`

proc walkArray(typ: TypeDef, access, location: NimNode): NimNode =
  ## Every element is held to whatever `items` said, named by its index
  if not typ.items.asserts:
    return newStmtList()
  let index = genSym(nskForVar, "index")
  let entry = genSym(nskForVar, "entry")
  let body = typ.items.walk(
    entry,
    quote do:
      `location` & "/" & $`index`,
  )
  return quote:
    for `index`, `entry` in `access`:
      `body`

proc walkMap(typ: TypeDef, access, location: NimNode): NimNode =
  ## Every entry is held to whatever the values said, named by its key
  if not typ.entries.asserts:
    return newStmtList()
  let key = genSym(nskForVar, "key")
  let entry = genSym(nskForVar, "entry")
  let body = typ.entries.walk(
    entry,
    quote do:
      `location` & "/" & `key`,
  )
  return quote:
    for `key`, `entry` in `access`:
      `body`

proc walkTuple(typ: TypeDef, access, location: NimNode): NimNode =
  ## Each slot is its own type, so each is walked against its own position
  result = newStmtList()
  for i, element in typ.elements:
    if not element.asserts:
      continue
    let slot = nnkBracketExpr.newTree(access, i.newLit)
    let index = ($i).newLit
    result.add(
      element.walk(
        slot,
        quote do:
          `location` & "/" & `index`,
      )
    )

proc walk(typ: TypeDef, access, location: NimNode): NimNode =
  ## Every assertion reachable from a value without passing through a type that has a
  ## `validate` of its own, which has already run by the time this one does
  let typ = typ.stripNotes
  result = newStmtList()
  if not typ.asserts:
    return

  result.add(typ.assertions(access, location))

  # Anything not listed here either holds no values worth asserting on, or names a
  # type whose own `validate` has already run over it
  case typ.kind
  of OptionalType:
    result.add(typ.walkOptional(access, location))
  of ArrayType:
    result.add(typ.walkArray(access, location))
  of MapType:
    result.add(typ.walkMap(access, location))
  of TupleType:
    result.add(typ.walkTuple(access, location))
  else:
    discard

proc buildObjValidate(typ: TypeDef): NimNode =
  result = newStmtList()
  result.add(typ.assertions(value, path))
  for _, (propName, subtype, _) in typ.properties:
    if not subtype.asserts:
      continue
    let prop = safePropName(propName)
    result.add(
      subtype.walk(
        newDotExpr(value, prop),
        quote do:
          `path` & "/" & `propName`,
      )
    )

proc buildUnionValidate(typ: TypeDef): NimNode =
  result = nnkCaseStmt.newTree(newDotExpr(value, ident("kind")))
  for i, subtype in typ.subtypes:
    let key = i.unionKey
    let body = subtype.walk(
      quote do:
        `value`.`key`,
      path,
    )
    result.add(nnkOfBranch.newTree(i.newLit, body.orDiscard))

proc buildValidate*(typ: TypeDef, typeName: NimNode): NimNode =
  ## A proc asserting what a value's own schema says about it, where the schema says
  ## anything at all. Where it says nothing, the generic no-op in `validate` stands in.
  let body =
    case typ.kind
    of ObjType:
      if not typ.assertsOwn and not typ.properties.values.toSeq.anyIt(it.typ.asserts):
        return newStmtList()
      buildObjValidate(typ)
    of UnionType:
      if not typ.subtypes.anyIt(it.asserts):
        return newStmtList()
      buildUnionValidate(typ)
    else:
      return newStmtList()

  # The path defaults to the type's own name, since a decoder has no outer path to pass
  # and a bare "/age" says much less than "Basic/age"
  let root = typeName.getName.newLit
  return genAst(typeName, body, value, path, root):
    proc validate*(_: typedesc[typeName], value: typeName, path: string = root) =
      body
