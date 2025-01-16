import std/[json, sets, tables, strformat], types, schemaRef

type ParseContext = ref object
    doc: JsonNode

proc resolve(sref: SchemaRef, ctx: ParseContext): JsonNode = resolve(sref, ctx.doc)

proc parseType(node: JsonNode, ctx: ParseContext): TypeDef

proc parseObj(node: JsonNode, ctx: ParseContext): TypeDef =
    result = TypeDef(
        kind: ObjType,
        required: initHashSet[string](),
        properties: initTable[string, TypeDef]()
    )

    for key, typeDef in node{"properties"}:
        result.properties[key] = typeDef.parseType(ctx)

proc parseRef(node: JsonNode, ctx: ParseContext): TypeDef =
    parseRef(node{"$ref"}.getStr).resolve(ctx).parseType(ctx)

proc parseTypedStr(node: JsonNode, ctx: ParseContext): TypeDef =
    let typ = node{"type"}.getStr
    case typ
    of "string": return TypeDef(kind: StringType)
    else: raise newException(ValueError, fmt"Unsupported type {typ} in {node}")

proc parseTyped(node: JsonNode, ctx: ParseContext): TypeDef =
    let typ = node{"type"}
    case typ.kind
    of JString: return parseTypedStr(node, ctx)
    else: raise newException(ValueError, fmt"Unsupported type {typ} in {node}")

proc parseType(node: JsonNode, ctx: ParseContext): TypeDef =
    if "$ref" in node:
        return parseRef(node, ctx)
    elif "properties" in node:
        return parseObj(node, ctx)
    elif "type" in node:
        return parseTyped(node, ctx)
    else:
        raise newException(ValueError, fmt"Unable to parse type: {node}")

proc parseSchema*(node: JsonNode): JsonSchema =
    result = JsonSchema()
    result.rootType = parseType(node, ParseContext(doc: node))

proc parseSchema*(node: string): JsonSchema =
    node.parseJson.parseSchema
