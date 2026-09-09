import
  std/[json, sets, tables, strformat, uri], types, schemaRef, history, util, ../config

type ParseContext = ref object
  doc: JsonNode
  resolver: UrlResolver
  refs: Table[SchemaRef, TypeDef]

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

  # `properties` may be missing entirely, which is how `additionalProperties: false`
  # describes an object that accepts nothing
  let properties = node{"properties"}
  if properties == nil:
    return

  var seen = initHashSet[string]()

  for key, typeDef in properties:
    # A `false` subschema forbids the property outright, so there is nothing to declare
    if typeDef.kind == JBool and not typeDef.getBool:
      continue

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

proc parseArray(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)
  let items = node{"items"}
  let subtype =
    if items == nil:
      TypeDef(kind: JsonType)
    else:
      parseType(items, ctx, history.add("items"))
  return TypeDef(kind: ArrayType, items: subtype, id: id(node))

proc parseRef(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)
  let sref = parseRef(node{"$ref"}.getStr)

  # Resolving a reference and parsing whatever it lands on is a pure function of the
  # reference, and schemas lean on that heavily -- every reference inside a definition
  # is re-walked once per site that reaches the definition, so the work grows with the
  # number of paths through the schema rather than its size. Memoizing collapses it
  # back down. `history` only ever feeds error messages, so it is safe to ignore here.
  if sref in ctx.refs:
    return ctx.refs[sref]

  result = sref.resolve(ctx).parseType(ctx, history).withRef(sref)
  ctx.refs[sref] = result

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

type ParseMode = enum
  ## A single keyword-driven interpretation of a schema node
  ##
  ## A node is a conjunction of every keyword on it, so more than one of these can apply
  ## at once. The declaration order is the order they get folded together in, and it
  ## matches the priority the old first-keyword-wins chain used.
  ParseRef ## `$ref`
  ParseMap ## `additionalProperties` holding a schema
  ParseObj ## `properties`, or `additionalProperties: false`
  ParseArray ## `items`, or `type: "array"`
  ParseEnum ## `enum`
  ParseOneOf ## `oneOf`
  ParseAnyOf ## `anyOf`
  ParseTypeName ## `type` holding a string other than `"array"`
  ParseTypeList ## `type` holding an array
  ParseFormat ## `format`
  ParseConst ## `const`

proc determineParseModes(node: JsonNode, history: History): set[ParseMode] =
  ## Determines every interpretation that applies to a schema node
  ##
  ## This is pure keyword inspection: nothing here parses a subschema, so it stays cheap
  ## and stays the single place that decides what a node means.

  # A reference with siblings is a merge of the target and those siblings, which isn't
  # supported yet, so a reference still swallows the rest of the node.
  if "$ref" in node:
    return {ParseRef}

  if "additionalProperties" in node:
    # `additionalProperties: false` doesn't describe entries, it closes the object off,
    # which is how a schema says "an object accepting nothing but what is listed".
    if node{"additionalProperties"}.kind == JBool and
        not node{"additionalProperties"}.getBool:
      result.incl(ParseObj)
    else:
      result.incl(ParseMap)

  if "properties" in node:
    result.incl(ParseObj)
  if "items" in node:
    result.incl(ParseArray)
  if "enum" in node:
    result.incl(ParseEnum)
  if "oneOf" in node:
    result.incl(ParseOneOf)
  if "anyOf" in node:
    result.incl(ParseAnyOf)
  if "format" in node:
    result.incl(ParseFormat)
  if "const" in node:
    result.incl(ParseConst)

  if "type" in node:
    let typ = node{"type"}
    case typ.kind
    of JString:
      # An array is described by its `items`, which `parseArray` fills in with an
      # unconstrained value when the keyword is missing entirely.
      if typ.getStr == "array":
        result.incl(ParseArray)
      else:
        result.incl(ParseTypeName)
    of JArray:
      result.incl(ParseTypeList)
    else:
      raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

proc parseType(
    node: JsonNode, mode: ParseMode, ctx: ParseContext, history: History
): TypeDef =
  ## Parses a single interpretation of a schema node, ignoring every other keyword on it
  case mode
  of ParseRef:
    return parseRef(node, ctx, history)
  of ParseMap:
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
  of ParseObj:
    return parseObj(node, ctx, history)
  of ParseArray:
    return parseArray(node, ctx, history)
  of ParseEnum:
    return parseEnum(node, ctx, history)
  of ParseOneOf:
    return parseUnion(node{"oneOf"}, ctx, history.add("oneOf"))
  of ParseAnyOf:
    return parseUnion(node{"anyOf"}, ctx, history.add("anyOf"))
  of ParseTypeName:
    # `parseTypeStr` only sees the type name, but the node it came from may carry an
    # `$id` that the type needs to be named after when it sits at the root.
    result = parseTypeStr(node{"type"}.getStr, history)
    result.id = id(node)
  of ParseTypeList:
    return parseUnion(node{"type"}, ctx, history.add("type"))
  of ParseFormat:
    result = parseTypeStr("string", history)
    result.id = id(node)
  of ParseConst:
    return TypeDef(kind: ConstValueType, value: node{"const"})

proc parseType(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  if node.kind == JBool and node.getBool:
    return TypeDef(kind: JsonType)
  if node.kind != JObject:
    raise newException(ValueError, fmt"Unable to parse type {node} at {history}")

  let modes = determineParseModes(node, history)
  if modes.card == 0:
    return TypeDef(kind: JsonType, id: id(node))

  for mode in modes:
    return node.parseType(mode, ctx, history)

proc parseSchema*(node: JsonNode, resolver: UrlResolver): JsonSchema =
  result = JsonSchema()
  let ctx =
    ParseContext(doc: node, resolver: resolver, refs: initTable[SchemaRef, TypeDef]())
  result.rootType = parseType(node, ctx, nil)

proc parseSchema*(node: string, resolver: UrlResolver): JsonSchema =
  node.parseJson.parseSchema(resolver)
