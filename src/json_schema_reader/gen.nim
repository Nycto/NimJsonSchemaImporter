import types, std/[macros, tables, sets]

type GenContext = ref object
    accum: NimNode
    nextId: uint

proc add(ctx: GenContext, name, typ: NimNode) =
    ctx.accum.add(nnkTypeDef.newTree(postfix(name, "*"), newEmptyNode(), typ))

proc genType(typ: TypeDef, name: NimNode, ctx: GenContext): NimNode
    ## Forward declaration for a proc that generates code for an arbitrary type

proc genObj(typ: TypeDef, name: NimNode, ctx: GenContext): NimNode =
    ## Generates code for an object type
    assert(typ.kind == ObjType)

    result = name

    var records = nnkRecList.newTree()
    for key, keyType in typ.properties:
        records.add(
            nnkIdentDefs.newTree(
                postfix(key.ident, "*"),
                keyType.genType(key.ident, ctx),
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

proc genArray(typ: TypeDef, name: NimNode, ctx: GenContext): NimNode =
    assert(typ.kind == ArrayType)
    result = nnkBracketExpr.newTree(bindSym("seq"), genType(typ.items, name, ctx))

proc genEnum(typ: TypeDef, name: NimNode, ctx: GenContext): NimNode =
    assert(typ.kind == EnumType)
    result = name

    var enumTyp = nnkEnumTy.newTree(newEmptyNode())

    for value in typ.values:
        enumTyp.add(value.ident)

    ctx.add(result, enumTyp)

proc genType(typ: TypeDef, name: NimNode, ctx: GenContext): NimNode =
    ## Generates code for an arbitrary type
    case typ.kind
    of ObjType: return genObj(typ, name, ctx)
    of StringType: return bindSym("string")
    of ArrayType: return genArray(typ, name, ctx)
    of NumberType: return bindSym("float64")
    of EnumType: return genEnum(typ, name, ctx)
    else: raise newException(AssertionDefect, "Could not generate code for " & $typ.kind)

proc genDeclarations*(schema: JsonSchema, name: string): NimNode =
    result = nnkTypeSection.newTree()
    discard schema.rootType.genType(name.ident, GenContext(accum: result))
