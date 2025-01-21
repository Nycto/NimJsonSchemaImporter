import std/[json, sets, tables, strformat], types, schemaRef, history, util

type
    ParseContext = ref object
        doc: JsonNode
        resolver: UrlResolver

proc resolve(sref: SchemaRef, ctx: ParseContext): JsonNode = resolve(sref, ctx.doc, ctx.resolver)

proc parseType(node: JsonNode, ctx: ParseContext, history: History): TypeDef

proc parseSubnodeType(parent: JsonNode, prop: string, ctx: ParseContext, history: History): TypeDef =
    parseType(parent{prop}, ctx, history.add(prop))

proc expectKind(node: JsonNode, kind: JsonNodeKind) =
    assert(node.kind == kind, fmt"Expecting a(n) {kind}: {node}")

proc choosePropName(initialName: string, seen: var HashSet[string], increment: int = 0): string =
    ## Chooses a unique name for an object property
    let name = if increment == 0: initialName else: fmt"{initialName}{increment}"

    if name notin seen:
        seen.incl name
        return name
    else:
        return choosePropName(initialName, seen, increment + 1)


proc parseObj(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    node.expectKind(JObject)

    var required = initHashSet[string]()
    if "required" in node:
        for key in node{"required"}:
            required.incl(key.getStr)

    result = TypeDef(kind: ObjType, properties: initTable[string, PropDef]())

    var seen = initHashSet[string]()

    for key, typeDef in node{"properties"}:
        let subtype = typeDef.parseType(ctx, history.add("properties").add(key))
        result.properties[key] = (
            propName: key.cleanupIdent.choosePropName(seen),
            typ: if key in required: subtype else: subtype.optional()
        )

proc parseMap(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    node.expectKind(JObject)
    if node{"additionalProperties"}.kind == JBool and node{"additionalProperties"}.getBool == false:
        return parseObj(node, ctx, history)
    if "properties" in node:
        raise newException(ValueError, fmt"Mixing properties and additionalProperties is unsupported at {history}")
    return TypeDef(kind: MapType, entries: node.parseSubnodeType("additionalProperties", ctx, history))

proc parseArray(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    node.expectKind(JObject)
    return TypeDef(kind: ArrayType, items: parseType(node{"items"}, ctx, history.add("items")))

proc parseRef(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    node.expectKind(JObject)
    let sref = parseRef(node{"$ref"}.getStr)
    result = sref.resolve(ctx).parseType(ctx, history)
    result.sref = sref

proc parseTypeStr(typ: string, history: History): TypeDef =
    case typ
    of "string": return TypeDef(kind: StringType)
    of "number": return TypeDef(kind: NumberType)
    of "integer": return TypeDef(kind: IntegerType)
    of "boolean": return TypeDef(kind: BoolType)
    of "null": return TypeDef(kind: NullType)
    of "object": return TypeDef(kind: MapType, entries: TypeDef(kind: JsonType))
    else: raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

proc isNullableUnion(subtypes: seq[TypeDef]): bool =
    if subtypes.len == 2:
        for subtype in subtypes:
            if subtype.kind == NullType:
                return true

proc buildNullableUnion(subtypes: seq[TypeDef]): TypeDef =
    assert(subtypes.len == 2)
    for subtype in subtypes:
        if subtype.kind != NullType:
            return subtype.optional()
    raise newException(AssertionDefect, "Failed to generate nullable union")

proc parseUnion(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    node.expectKind(JArray)
    var subtypes = newSeq[TypeDef]()
    for subtype in node:
        subtypes.add(
            if subtype.kind == JString:
                subtype.getStr.parseTypeStr(history)
            else:
                subtype.parseType(ctx, history)
        )

    if subtypes.len == 0:
        raise newException(ValueError, fmt"Empty union at {history}")
    elif subtypes.len == 1:
        return subtypes[0]
    elif subtypes.isNullableUnion():
        return subtypes.buildNullableUnion()
    else:
        return TypeDef(kind: UnionType, subtypes: subtypes)

proc parseEnum(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    node.expectKind(JObject)
    var values = initHashSet[string]()
    var isOptional = false
    for value in node{"enum"}:
        case value.kind:
        of JString: values.incl(value.getStr)
        of JNull: isOptional = true
        else: return TypeDef(kind: JsonType)

    result = TypeDef(kind: EnumType, values: values)
    if isOptional:
        result = result.optional()

proc parseStr(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    return if "enum" in node: parseEnum(node, ctx, history) else: parseTypeStr("string", history)

proc parseTypedStr(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    node.expectKind(JObject)
    let typ = node{"type"}.getStr
    case typ
    of "string": return parseStr(node, ctx, history)
    of "number", "integer", "boolean", "null": return parseTypeStr(typ, history)
    of "object": return parseObj(node, ctx, history)
    of "array": return parseArray(node, ctx, history)
    else: raise newException(ValueError, fmt"Unsupported type '{typ}' at {history}")

proc parseTyped(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    node.expectKind(JObject)
    let typ = node{"type"}
    case typ.kind
    of JString: return parseTypedStr(node, ctx, history)
    of JArray: return parseUnion(typ, ctx, history.add("type"))
    else: raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

proc parseType(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
    if node.kind != JObject:
        raise newException(ValueError, fmt"Unable to parse type {node} at {history}")
    if "$ref" in node:
        return parseRef(node, ctx, history)
    elif "additionalProperties" in node:
        return parseMap(node, ctx, history)
    elif "properties" in node:
        return parseObj(node, ctx, history)
    elif "items" in node:
        return parseArray(node, ctx, history)
    elif "enum" in node:
        return parseEnum(node, ctx, history)
    elif "oneOf" in node:
        return parseUnion(node{"oneOf"}, ctx, history.add("oneOf"))
    elif "anyOf" in node:
        return parseUnion(node{"anyOf"}, ctx, history.add("anyOf"))
    elif "type" in node:
        return parseTyped(node, ctx, history)
    else:
        return TypeDef(kind: JsonType)

proc parseSchema*(node: JsonNode, resolver: UrlResolver): JsonSchema =
    result = JsonSchema()
    result.rootType = parseType(node, ParseContext(doc: node, resolver: resolver), nil)

proc parseSchema*(node: string, resolver: UrlResolver): JsonSchema =
    node.parseJson.parseSchema(resolver)
