import
  types, schemaRef, marshalling, util, unpack, namechain, equalsgen, dollargen, bingen
import std/[macros, tables, sets, json, options, hashes, strutils]

type
  GenContext = ref object
    types: OrderedSet[NimNode]
    declarations: NimNode
    procs: NimNode
    nextId: uint
    prefix: string
    cache: Table[SchemaRef, NimNode]
    usedNames: HashSet[string]

  GeneratedOutput* = tuple[rootType, code: NimNode]

proc hash(node: NimNode): Hash =
  result = hash(node.kind)
  if node.kind in {nnkSym, nnkIdent}:
    result = result !& node.strVal.hash
  for child in node:
    result = result !& hash(child)

let source {.compileTime.} = ident("source")

proc add(ctx: GenContext, name, typ: NimNode) =
  name.expectKind({nnkIdent, nnkAccQuoted})
  ctx.usedNames.incl(name.getName.toUpperAscii)
  ctx.types.incl(nnkTypeDef.newTree(postfix(name, "*"), newEmptyNode(), typ))

proc genName(ctx: GenContext, name: NameChain, typ: TypeDef): NimNode =
  for name in typ.proposeNames(ctx.prefix, name):
    let upperName = name.toUpperAscii
    if upperName notin ctx.usedNames:
      ctx.usedNames.incl(upperName)
      return safeTypeName(name)
  raiseAssert("Should not be reachable!")

proc genType(typ: TypeDef, name: NameChain, ctx: GenContext): NimNode
  ## Forward declaration for a proc that generates code for an arbitrary type

proc genObj(typ: TypeDef, name: NameChain, ctx: GenContext): NimNode =
  ## Generates code for an object type
  assert(typ.kind == ObjType)

  result = ctx.genName(name, typ)

  var records = nnkRecList.newTree()
  for jsonKey, (propName, keyType, _) in typ.properties:
    records.add(
      nnkIdentDefs.newTree(
        postfix(safePropName(propName), "*"),
        keyType.genType(name.add(jsonKey), ctx),
        newEmptyNode(),
      )
    )

  ctx.add(result, nnkObjectTy.newTree(newEmptyNode(), newEmptyNode(), records))

  ctx.declarations.add quote do:
    proc toJsonHook*(`source`: `result`): JsonNode

  ctx.procs.add(
    typ.buildEquals(result),
    typ.buildDollars(result),
    typ.buildObjectDecoder(result),
    typ.buildObjectEncoder(result),
  )

proc genArray(typ: TypeDef, name: NameChain, ctx: GenContext): NimNode =
  assert(typ.kind == ArrayType)
  result = nnkBracketExpr.newTree(bindSym("seq"), genType(typ.items, name, ctx))

proc genEnum(typ: TypeDef, name: NameChain, ctx: GenContext): NimNode =
  assert(typ.kind == EnumType)
  result = ctx.genName(name, typ)

  var enumTyp = nnkEnumTy.newTree(newEmptyNode())
  for value in typ.values:
    enumTyp.add(nnkEnumFieldDef.newTree(safeTypeName(value), value.newLit))

  ctx.add(result, enumTyp)

proc genUnion(typ: TypeDef, name: NameChain, ctx: GenContext): NimNode =
  ## Generates the type required to represent a union type
  assert(typ.kind == UnionType)
  assert(typ.subtypes.len > 0)

  result = ctx.genName(name.add("Union"), typ)

  var cases = nnkRecCase.newTree(
    nnkIdentDefs.newTree(
      postfix(newIdentNode("kind"), "*"),
      nnkBracketExpr.newTree(
        bindSym("range"), infix(0.newLit, "..", newLit(typ.subtypes.len - 1))
      ),
      newEmptyNode(),
    )
  )

  for i, subtype in typ.subtypes:
    let subtypeNode = subtype.genType(name, ctx)
    cases.add(
      nnkOfBranch.newTree(
        i.newLit,
        nnkIdentDefs.newTree(postfix(i.unionKey, "*"), subtypeNode, newEmptyNode()),
      )
    )

    ctx.procs.add(buildUnionPacker(i, subtypeNode, result))

  ctx.add(
    result,
    nnkObjectTy.newTree(newEmptyNode(), newEmptyNode(), nnkRecList.newTree(cases)),
  )

  ctx.procs.add(
    typ.buildEquals(result),
    typ.buildDollars(result),
    typ.buildUnionDecoder(result),
    typ.buildUnionEncoder(result),
    typ.buildUnionUnpacker(result),
    typ.buildUnionBinSerde(result),
  )

proc genMap(typ: TypeDef, name: NameChain, ctx: GenContext): NimNode =
  assert(typ.kind == MapType)
  return nnkBracketExpr.newTree(
    bindSym("OrderedTable"), bindSym("string"), genType(typ.entries, name, ctx)
  )

proc genOptional(typ: TypeDef, name: NameChain, ctx: GenContext): NimNode =
  assert(typ.kind == OptionalType)
  return nnkBracketExpr.newTree(bindSym("Option"), genType(typ.subtype, name, ctx))

proc genType(typ: TypeDef, name: NameChain, ctx: GenContext): NimNode =
  ## Generates code for an arbitrary type
  if not typ.sref.isNil and typ.sref in ctx.cache:
    return ctx.cache[typ.sref]

  case typ.kind
  of ObjType:
    result = genObj(typ, name, ctx)
  of StringType:
    result = bindSym("string")
  of ArrayType:
    result = genArray(typ, name, ctx)
  of NumberType:
    result = bindSym("BiggestFloat")
  of IntegerType:
    result = bindSym("BiggestInt")
  of EnumType:
    result = genEnum(typ, name, ctx)
  of UnionType:
    result = genUnion(typ, name, ctx)
  of BoolType:
    result = bindSym("bool")
  of NullType:
    result = bindSym("pointer")
  of JsonType:
    result = bindSym("JsonNode")
  of MapType:
    result = genMap(typ, name, ctx)
  of OptionalType:
    result = genOptional(typ, name, ctx)
  else:
    raise newException(AssertionDefect, "Could not generate code for " & $typ.kind)

  if not typ.sref.isNil:
    ctx.cache[typ.sref] = result

proc genDeclarations*(schema: JsonSchema, name, namePrefix: string): GeneratedOutput =
  let ctx = GenContext(
    types: initOrderedSet[NimNode](),
    prefix: namePrefix,
    cache: initTable[SchemaRef, NimNode](),
    declarations: newStmtList(),
    procs: newStmtList(),
  )

  result.rootType = schema.rootType.genType(rootName(name), ctx)

  var types = nnkTypeSection.newTree()
  for typ in ctx.types:
    types.add(typ)

  result.code = newStmtList(types, ctx.declarations, ctx.procs)
