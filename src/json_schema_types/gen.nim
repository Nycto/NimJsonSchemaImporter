import types, schemaRef, marshalling, util, unpack
import std/[macros, tables, sets, strformat, json, options, hashes]

type GenContext = ref object
    types: HashSet[NimNode]
    procs: NimNode
    nextId: uint
    prefix: string
    cache: Table[SchemaRef, NimNode]

proc hash(node: NimNode): Hash =
    result = hash(node.kind)
    if node.kind in { nnkSym, nnkIdent }:
        result = result !& node.strVal.hash
    for child in node:
        result = result !& hash(child)

proc add(ctx: GenContext, name, typ: NimNode) =
    ctx.types.incl(nnkTypeDef.newTree(postfix(name, "*"), newEmptyNode(), typ))

proc genName(ctx: GenContext, name: string, typ: TypeDef): NimNode =
    var basename: string = typ.sref.getName()
    if basename == "":
        basename = name
    return safeTypeName(ctx.prefix & basename)

proc genType(typ: TypeDef, name: string, ctx: GenContext): NimNode
    ## Forward declaration for a proc that generates code for an arbitrary type

proc genObj(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    ## Generates code for an object type
    assert(typ.kind == ObjType)

    result = ctx.genName(name, typ)

    var records = nnkRecList.newTree()
    for jsonKey, (propName, keyType) in typ.properties:
        records.add(
            nnkIdentDefs.newTree(
                postfix(safePropName(propName), "*"),
                keyType.genType(fmt"{result.getName}_{jsonKey}", ctx),
                newEmptyNode()
            )
        )

    ctx.add(result, nnkObjectTy.newTree(newEmptyNode(), newEmptyNode(), records))

    ctx.procs.add(typ.buildObjectDecoder(result), typ.buildObjectEncoder(result))

proc genArray(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    assert(typ.kind == ArrayType)
    result = nnkBracketExpr.newTree(bindSym("seq"), genType(typ.items, name, ctx))

proc genEnum(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    assert(typ.kind == EnumType)
    result = ctx.genName(name, typ)

    var enumTyp = nnkEnumTy.newTree(newEmptyNode())
    for value in typ.values:
        enumTyp.add(safeTypeName(value))

    ctx.add(result, enumTyp)

    ctx.procs.add(typ.buildEnumEncoder(result), typ.buildEnumDecoder(result))

proc genUnion(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    ## Generates the type required to represent a union type
    assert(typ.kind == UnionType)
    assert(typ.subtypes.len > 0)

    result = ctx.genName(name & "Union", typ)

    var cases = nnkRecCase.newTree(
        nnkIdentDefs.newTree(
            postfix(newIdentNode("kind"), "*"),
            nnkBracketExpr.newTree(bindSym("range"), infix(0.newLit, "..", newLit(typ.subtypes.len - 1))),
            newEmptyNode()
        )
    )

    for i, subtype in typ.subtypes:
        cases.add(
            nnkOfBranch.newTree(
                i.newLit,
                nnkIdentDefs.newTree(
                    postfix(i.unionKey, "*"),
                    subtype.genType(fmt"{name}{i}", ctx),
                    newEmptyNode()
                )
            )
        )

    ctx.add(result, nnkObjectTy.newTree(newEmptyNode(), newEmptyNode(), nnkRecList.newTree(cases)))

    ctx.procs.add(
        typ.buildUnionDecoder(result),
        typ.buildUnionEncoder(result),
        typ.buildUnionUnpacker(result),
    )

proc genMap(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    assert(typ.kind == MapType)
    return nnkBracketExpr.newTree(bindSym("Table"), bindSym("string"), genType(typ.entries, name, ctx))

proc genOptional(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    assert(typ.kind == OptionalType)
    return nnkBracketExpr.newTree(bindSym("Option"), genType(typ.subtype, name, ctx))

proc genType(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    ## Generates code for an arbitrary type
    if not typ.sref.isNil and typ.sref in ctx.cache:
        return ctx.cache[typ.sref]

    case typ.kind
    of ObjType: result = genObj(typ, name, ctx)
    of StringType: result = bindSym("string")
    of ArrayType: result = genArray(typ, name, ctx)
    of NumberType: result = bindSym("BiggestFloat")
    of IntegerType: result = bindSym("BiggestInt")
    of EnumType: result = genEnum(typ, name, ctx)
    of UnionType: result = genUnion(typ, name, ctx)
    of BoolType: result = bindSym("bool")
    of NullType: result = bindSym("pointer")
    of JsonType: result = bindSym("JsonNode")
    of MapType: result = genMap(typ, name, ctx)
    of OptionalType: result = genOptional(typ, name, ctx)
    else: raise newException(AssertionDefect, "Could not generate code for " & $typ.kind)

    if not typ.sref.isNil:
        ctx.cache[typ.sref] = result

proc genDeclarations*(schema: JsonSchema, name, namePrefix: string): NimNode =
    let ctx = GenContext(
        types: initHashSet[NimNode](),
        prefix: namePrefix,
        cache: initTable[SchemaRef, NimNode](),
        procs: newStmtList()
    )

    discard schema.rootType.genType(name, ctx)

    var types = nnkTypeSection.newTree()
    for typ in ctx.types:
        types.add(typ)

    return newStmtList(types, ctx.procs)

