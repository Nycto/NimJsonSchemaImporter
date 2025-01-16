import types, std/[macros, tables]

type GenContext = ref object
    accum: NimNode
    nextId: uint

proc add(ctx: GenContext, node: NimNode) =
    ctx.accum.add(node)

# dumpAstGen:
#     type Foo* = object
#         baz*: string

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
        nnkTypeDef.newTree(
            postfix(result, "*"),
            newEmptyNode(),
            nnkObjectTy.newTree(
                newEmptyNode(),
                newEmptyNode(),
                records
            )
        )
    )

proc genType(typ: TypeDef, name: NimNode, ctx: GenContext): NimNode =
    ## Generates code for an arbitrary type
    case typ.kind
    of ObjType: return genObj(typ, name, ctx)
    of StringType: return bindSym("string")
    else: raise newException(AssertionDefect, "Could not generate code for " & $typ.kind)

proc genDeclarations*(schema: JsonSchema, name: string): NimNode =
    result = nnkTypeSection.newTree()
    discard schema.rootType.genType(name.ident, GenContext(accum: result))
