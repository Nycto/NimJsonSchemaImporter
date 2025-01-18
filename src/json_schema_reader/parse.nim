import std/[json, sets, tables, strformat], types, schemaRef, history

type
    ParseContext = ref object
        doc: JsonNode
        resolver: UrlResolver

proc resolve(sref: SchemaRef, ctx: ParseContext): JsonNode = resolve(sref, ctx.doc, ctx.resolver)

proc parseType(node: JsonNode, ctx: ParseContext, history: History): TypeDef

proc parseObj(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    result = TypeDef(kind: ObjType, properties: initTable[string, TypeDef]())
    for key, typeDef in node{"properties"}:
        result.properties[key] = typeDef.parseType(ctx, history.add("properties").add(key))

proc parseArray(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    return TypeDef(kind: ArrayType, items: parseType(node{"items"}, ctx, history.add("items")))

proc parseRef(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    parseRef(node{"$ref"}.getStr).resolve(ctx).parseType(ctx, history)

proc parseTypeStr(typ: string, history: History): TypeDef =
    case typ
    of "string": return TypeDef(kind: StringType)
    of "number": return TypeDef(kind: NumberType)
    of "integer": return TypeDef(kind: IntegerType)
    of "boolean": return TypeDef(kind: BoolType)
    of "null": return TypeDef(kind: NullType)
    of "object": return TypeDef(kind: MapType, entries: TypeDef(kind: JsonType))
    else: raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

proc parseUnion(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    result = TypeDef(kind: UnionType, subtypes: newSeq[TypeDef]())
    for subtype in node:
        result.subtypes.add(
            if subtype.kind == JString:
                subtype.getStr.parseTypeStr(history)
            else:
                subtype.parseType(ctx, history)
        )

proc parseEnum(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    result = TypeDef(kind: EnumType, values: initHashSet[string]())
    for value in node{"enum"}:
        result.values.incl(value.getStr)

proc parseStr(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    return if "enum" in node: parseEnum(node, ctx, history) else: parseTypeStr("string", history)

proc parseTypedStr(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    let typ = node{"type"}.getStr
    case typ
    of "string": return parseStr(node, ctx, history)
    of "number", "integer", "boolean", "null": return parseTypeStr(typ, history)
    of "object": return parseObj(node, ctx, history)
    of "array": return parseArray(node, ctx, history)
    else: raise newException(ValueError, fmt"Unsupported type '{typ}' at {history}")

proc parseTyped(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    let typ = node{"type"}
    case typ.kind
    of JString: return parseTypedStr(node, ctx, history)
    of JArray: return parseUnion(typ, ctx, history.add("type"))
    else: raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

proc parseType(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    if "$ref" in node:
        return parseRef(node, ctx, history)
    elif "properties" in node:
        return parseObj(node, ctx, history)
    elif "items" in node:
        return parseArray(node, ctx, history)
    elif "enum" in node:
        return parseEnum(node, ctx, history)
    elif "oneOf" in node:
        return parseUnion(node{"oneOf"}, ctx, history.add("oneOf"))
    elif "type" in node:
        return parseTyped(node, ctx, history)
    elif node.kind == JObject:
        return TypeDef(kind: JsonType)
    else:
        raise newException(ValueError, fmt"Unable to parse type {node} at {history}")

proc parseSchema*(node: JsonNode, resolver: UrlResolver = defaultResolver): JsonSchema =
    result = JsonSchema()
    result.rootType = parseType(node, ParseContext(doc: node, resolver: resolver), nil)

proc parseSchema*(node: string, resolver: UrlResolver = defaultResolver): JsonSchema =
    node.parseJson.parseSchema
