import types, schemaRef, std/[macros, tables, sets, strformat, json, strutils, options]

type GenContext = ref object
    accum: NimNode
    nextId: uint
    prefix: string
    cache: Table[SchemaRef, NimNode]

proc add(ctx: GenContext, name, typ: NimNode) =
    ctx.accum.add(nnkTypeDef.newTree(postfix(name, "*"), newEmptyNode(), typ))

proc genName(ctx: GenContext, name: string, typ: TypeDef): NimNode =
    var basename: string = typ.sref.getName()
    if basename == "":
        basename = name
    return (ctx.prefix & basename.capitalizeAscii).ident

proc genType(typ: TypeDef, name: string, ctx: GenContext): NimNode
    ## Forward declaration for a proc that generates code for an arbitrary type

proc genObj(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    ## Generates code for an object type
    assert(typ.kind == ObjType)

    result = ctx.genName(name, typ)

    var records = nnkRecList.newTree()
    for key, keyType in typ.properties:
        records.add(
            nnkIdentDefs.newTree(
                postfix(nnkAccQuoted.newTree(key.ident), "*"),
                keyType.genType(key, ctx),
                newEmptyNode()
            )
        )

    ctx.add(
        result,
        nnkObjectTy.newTree(
            newEmptyNode(),
            newEmptyNode(),
            records
        )
    )

proc genArray(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    assert(typ.kind == ArrayType)
    result = nnkBracketExpr.newTree(bindSym("seq"), genType(typ.items, name, ctx))

proc genEnum(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    assert(typ.kind == EnumType)
    result = ctx.genName(name, typ)

    var enumTyp = nnkEnumTy.newTree(newEmptyNode())
    for value in typ.values:
        enumTyp.add(value.ident)

    ctx.add(result, enumTyp)

# dumpAstGen:
#     type Foo = object
#         case kind: range[0..2]
#         of 0: key0: string
#         of 1: key1: int
#         of 2: key2: float

proc genUnion(typ: TypeDef, name: string, ctx: GenContext): NimNode =
    assert(typ.kind == UnionType)

    if typ.subtypes.len == 0:
        raise newException(AssertionDefect, "Empty union type")
    elif typ.subtypes.len == 1:
        return typ.subtypes[0].genType(name, ctx)

    result = ctx.genName(name, typ)

    var cases = nnkRecCase.newTree(
        nnkIdentDefs.newTree(
            newIdentNode("kind"),
            nnkBracketExpr.newTree(bindSym("range"), infix(0.newLit, "..", newLit(typ.subtypes.len - 1))),
            newEmptyNode()
        )
    )

    for i, subtype in typ.subtypes:
        cases.add(
            nnkOfBranch.newTree(
                i.newLit,
                nnkIdentDefs.newTree(
                    ident(fmt"key{i}"),
                    subtype.genType(fmt"{name}{i}", ctx),
                    newEmptyNode()
                )
            )
        )

    ctx.add(result, nnkObjectTy.newTree(newEmptyNode(), newEmptyNode(), nnkRecList.newTree(cases)))

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
    result = nnkTypeSection.newTree()
    let ctx = GenContext(accum: result, prefix: namePRefix, cache: initTable[SchemaRef, NimNode]())
    discard schema.rootType.genType(name, ctx)
