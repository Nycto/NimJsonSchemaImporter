import
  std/[json, sets, tables, strformat, uri], types, schemaRef, history, util, ../config

type ParseContext = ref object
  doc: JsonNode
  resolver: UrlResolver

proc resolve(sref: SchemaRef, ctx: ParseContext): JsonNode =
  resolve(sref, ctx.doc, ctx.resolver)

proc parseType(node: JsonNode, ctx: ParseContext, history: History): TypeDef

proc parseSubnodeType(
    parent: JsonNode, prop: string, ctx: ParseContext, history: History
): TypeDef =
  parseType(parent{prop}, ctx, history.add(prop))

proc expectKind(node: JsonNode, kind: JsonNodeKind) =
  assert(node.kind == kind, fmt"Expecting a(n) {kind}: {node}")

proc id(node: JsonNode): Uri =
  if node.kind == JObject and node.hasKey("$id"):
    try:
      return parseUri(node{"$id"}.getStr)
    except:
      discard

proc choosePropName(
    initialName: string, seen: var HashSet[string], increment: int = 0
): string =
  ## Chooses a unique name for an object property
  let name =
    if increment == 0:
      initialName
    else:
      fmt"{initialName}{increment}"

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

  result = TypeDef(
    kind: ObjType, properties: initOrderedTable[string, PropDef](), id: id(node)
  )

  var seen = initHashSet[string]()

  for key, typeDef in node{"properties"}:
    let subtype = typeDef.parseType(ctx, history.add("properties").add(key))
    result.properties[key] = (
      propName: key.cleanupIdent.choosePropName(seen),
      typ:
        if key in required:
          subtype
        else:
          subtype.optional(),
      required: key in required,
    )

proc parseMap(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)
  if node{"additionalProperties"}.kind == JBool and
      node{"additionalProperties"}.getBool == false:
    return parseObj(node, ctx, history)
  if "properties" in node:
    raise newException(
      ValueError,
      fmt"Mixing properties and additionalProperties is unsupported at {history}",
    )
  return TypeDef(
    kind: MapType,
    entries: node.parseSubnodeType("additionalProperties", ctx, history),
    id: id(node),
  )

proc parseArray(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)
  return TypeDef(
    kind: ArrayType,
    items: parseType(node{"items"}, ctx, history.add("items")),
    id: id(node),
  )

proc parseRef(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)
  let sref = parseRef(node{"$ref"}.getStr)
  result = sref.resolve(ctx).parseType(ctx, history)
  result.sref = sref

proc parseTypeStr(typ: string, history: History): TypeDef =
  case typ
  of "string":
    return TypeDef(kind: StringType)
  of "number":
    return TypeDef(kind: NumberType)
  of "integer":
    return TypeDef(kind: IntegerType)
  of "boolean":
    return TypeDef(kind: BoolType)
  of "null":
    return TypeDef(kind: NullType)
  of "object":
    return TypeDef(kind: MapType, entries: TypeDef(kind: JsonType))
  else:
    raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

proc collapseUnion(typ: TypeDef, history: History): TypeDef =
  assert(typ.kind == UnionType)

  if typ.subtypes.len == 0:
    raise newException(ValueError, fmt"Empty union at {history}")
  elif typ.subtypes.len == 1:
    return typ.subtypes[0]

  var nestedUnion = false
  var markOptional = false
  var subtypes: seq[TypeDef]
  for subtype in typ.subtypes:
    case subtype.kind
    of NullType:
      markOptional = true
    of OptionalType:
      markOptional = true
      subtypes.add(subtype.subtype)
    of UnionType:
      nestedUnion = true
      subtypes.add(subtype.subtypes)
    else:
      subtypes.add(subtype)

  return
    if markOptional:
      TypeDef(kind: UnionType, subtypes: subtypes, id: typ.id)
      .collapseUnion(history)
      .optional()
    elif nestedUnion:
      TypeDef(kind: UnionType, subtypes: subtypes, id: typ.id).collapseUnion(history)
    else:
      typ

proc parseUnion(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JArray)

  var seenTypes = initHashSet[TypeDef]()
  var subtypes = newSeq[TypeDef]()
  for subtype in node:
    let parsed =
      if subtype.kind == JString:
        subtype.getStr.parseTypeStr(history)
      else:
        subtype.parseType(ctx, history)
    if parsed notin seenTypes:
      seenTypes.incl(parsed)
      subtypes.add(parsed)

  return
    TypeDef(kind: UnionType, subtypes: subtypes, id: id(node)).collapseUnion(history)

proc parseEnum(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)
  var values = initOrderedSet[string]()
  var isOptional = false
  for value in node{"enum"}:
    case value.kind
    of JString:
      values.incl(value.getStr)
    of JNull:
      isOptional = true
    else:
      return TypeDef(kind: JsonType, id: id(node))

  result = TypeDef(kind: EnumType, values: values, id: id(node))
  if isOptional:
    result = result.optional()

proc parseStr(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  return
    if "enum" in node:
      parseEnum(node, ctx, history)
    else:
      parseTypeStr("string", history)

proc parseTypedStr(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)
  let typ = node{"type"}.getStr
  case typ
  of "string":
    return parseStr(node, ctx, history)
  of "number", "integer", "boolean", "null":
    return parseTypeStr(typ, history)
  of "object":
    return parseObj(node, ctx, history)
  of "array":
    return parseArray(node, ctx, history)
  else:
    raise newException(ValueError, fmt"Unsupported type '{typ}' at {history}")

proc parseTyped(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)
  let typ = node{"type"}
  case typ.kind
  of JString:
    return parseTypedStr(node, ctx, history)
  of JArray:
    return parseUnion(typ, ctx, history.add("type"))
  else:
    raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

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
  elif "format" in node:
    return parseTypeStr("string", history)
  elif "const" in node:
    return TypeDef(kind: ConstValueType, value: node{"const"})
  else:
    return TypeDef(kind: JsonType, id: id(node))

proc parseSchema*(node: JsonNode, resolver: UrlResolver): JsonSchema =
  result = JsonSchema()
  result.rootType = parseType(node, ParseContext(doc: node, resolver: resolver), nil)

proc parseSchema*(node: string, resolver: UrlResolver): JsonSchema =
  node.parseJson.parseSchema(resolver)
