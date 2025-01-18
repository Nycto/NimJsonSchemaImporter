import types, std/[macros, tables, sets, strformat, json]

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

# dumpAstGen:
#     type Foo = object
#         case kind: range[0..2]
#         of 0: key0: string
#         of 1: key1: int
#         of 2: key2: float

proc genUnion(typ: TypeDef, name: NimNode, ctx: GenContext): NimNode =
    assert(typ.kind == UnionType)

    if typ.subtypes.len == 0:
        raise newException(AssertionDefect, "Empty union type")
    elif typ.subtypes.len == 1:
        return typ.subtypes[0].genType(name, ctx)

    result = name

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
                    subtype.genType(ident(fmt"{name.strVal}{i}"), ctx),
                    newEmptyNode()
                )
            )
        )

    ctx.add(result, nnkObjectTy.newTree(newEmptyNode(), newEmptyNode(), nnkRecList.newTree(cases)))

proc genMap(typ: TypeDef, name: NimNode, ctx: GenContext): NimNode =
    assert(typ.kind == MapType)
    return nnkBracketExpr.newTree(bindSym("Table"), bindSym("string"), genType(typ.entries, name, ctx))

proc genType(typ: TypeDef, name: NimNode, ctx: GenContext): NimNode =
    ## Generates code for an arbitrary type
    case typ.kind
    of ObjType: return genObj(typ, name, ctx)
    of StringType: return bindSym("string")
    of ArrayType: return genArray(typ, name, ctx)
    of NumberType: return bindSym("BiggestFloat")
    of IntegerType: return bindSym("BiggestInt")
    of EnumType: return genEnum(typ, name, ctx)
    of UnionType: return genUnion(typ, name, ctx)
    of BoolType: return bindSym("bool")
    of NullType: return bindSym("pointer")
    of JsonType: return bindSym("JsonNode")
    of MapType: return genMap(typ, name, ctx)
    else: raise newException(AssertionDefect, "Could not generate code for " & $typ.kind)

proc genDeclarations*(schema: JsonSchema, name: string): NimNode =
    result = nnkTypeSection.newTree()
    discard schema.rootType.genType(name.ident, GenContext(accum: result))
