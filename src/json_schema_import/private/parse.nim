import
  std/[json, sets, tables, strformat, uri],
  types,
  schemaRef,
  history,
  util,
  merge,
  ../config

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

iterator requiredKeys(node: JsonNode): string =
  ## The keys named by a node's `required` list. Draft 3 spelled `required` as a boolean
  ## beside the property it applied to, which names no key of the node carrying it, so
  ## anything but a list is passed over.
  if "required" in node and node{"required"}.kind == JArray:
    for key in node{"required"}:
      yield key.getStr

proc hasRequiredKeys(node: JsonNode): bool =
  for _ in node.requiredKeys:
    return true

proc parseObj(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)

  var required = initHashSet[string]()
  for key in node.requiredKeys:
    required.incl(key)

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
    let subtype = typeDef.parseType(ctx, history.add("properties").add(key))

    if subtype.kind == NeverType:
      continue

    result.properties[key] = (
      propName: key.cleanupIdent.choosePropName(seen),
      typ:
        if key in required:
          subtype
        else:
          subtype.optional(),
      required: key in required,
      nullable: subtype.kind == OptionalType,
    )

proc parseRequired(node: JsonNode, history: History): TypeDef =
  ## Builds an object out of a `required` list on its own. The keys it names have to be
  ## present, but nothing here says what they hold, so they come out untyped and are
  ## narrowed by whatever `properties` the merge folds in alongside them.
  node.expectKind(JObject)

  result = TypeDef(
    kind: ObjType, properties: initOrderedTable[string, PropDef](), id: id(node)
  )

  var seen = initHashSet[string]()

  for name in node.requiredKeys:
    if name in result.properties:
      continue

    result.properties[name] = (
      propName: name.cleanupIdent.choosePropName(seen),
      typ: TypeDef(kind: JsonType),
      required: true,
      nullable: false,
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

proc parseTuple(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  ## Parses a fixed length array, where every position has a schema of its own
  ##
  ## `prefixItems` is how 2020-12 spells this; earlier drafts overloaded `items` with a
  ## list, and plenty of schemas in the wild still do.
  node.expectKind(JObject)
  let key = if "prefixItems" in node: "prefixItems" else: "items"
  let elements = node{key}
  elements.expectKind(JArray)

  result = TypeDef(kind: TupleType, id: id(node))
  for i in 0 ..< elements.len:
    let element = elements[i].parseType(ctx, history.add(key).add($i))

    # Nothing can fill a slot nothing satisfies, so no array of this length validates and
    # the tuple as a whole is uninhabited
    if element.kind == NeverType:
      return TypeDef(kind: NeverType, id: id(node))

    result.elements.add(element)

proc parseRef(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  node.expectKind(JObject)
  let sref = parseRef(node{"$ref"}.getStr).within(history.document)

  # A reference still open closes a cycle, so it is cut into a leaf naming it. Asked before
  # the memo, which holds nothing for an open reference and so cannot tell one from a
  # reference never visited at all.
  if sref in history:
    return TypeDef(kind: RefType, schemaRef: sref)

  # Resolving a reference and parsing whatever it lands on is a pure function of the
  # reference, and schemas lean on that heavily -- every reference inside a definition
  # is re-walked once per site that reaches the definition, so the work grows with the
  # number of paths through the schema rather than its size. Memoizing collapses it
  # back down.
  if sref in ctx.refs:
    return ctx.refs[sref]

  let inner = history.addRef(sref)
  result = sref.resolve(ctx).parseType(ctx, inner).withRef(sref)

  # A reference resolving to nothing but itself describes no value and names no type
  if result.kind == RefType:
    raise
      newException(ValueError, fmt"Reference {sref} resolves only to itself: {inner}")

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
  of "array":
    # Only reachable through a `type` holding a list: a `type` naming an array on its own is
    # routed to `ParseArray`, which reads the `items` this has no access to. Merging against
    # whatever `items` describes is what narrows this back down.
    return TypeDef(kind: ArrayType, items: TypeDef(kind: JsonType))
  else:
    raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

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

proc parseAllOf(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  ## Folds every branch of an `allOf` into the one type that satisfies all of them
  node.expectKind(JArray)
  for i in 0 ..< node.len:
    result = result.mergeTypes(node[i].parseType(ctx, history.add($i)), history)
  if result.isNil:
    raise newException(ValueError, fmt"Empty allOf at {history}")

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
  ## at once. The declaration order is the order the results get folded together in, which
  ## is what makes the merge produce the same type every time.
  ParseRef ## `$ref`
  ParseMap ## `additionalProperties` holding a schema
  ParseObj ## `properties`, or `additionalProperties: false`
  ParseRequired ## `required` holding a list of keys
  ParseArray ## `items`, or `type: "array"`
  ParseTuple ## `prefixItems`, or `items` holding a list of schemas
  ParseEnum ## `enum`
  ParseAllOf ## `allOf`
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

  if "$ref" in node:
    result.incl(ParseRef)

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

  # `required` stands on its own: splitting the properties from the keys that must be
  # present across `allOf` branches, or tightening a `$ref` with a sibling `required`,
  # are both mainstream idioms, and neither says anything the other keywords do. Draft 3
  # spelled `required` as a boolean beside the property it applied to, which names no key
  # of this node, and an empty list narrows nothing.
  if node.hasRequiredKeys:
    result.incl(ParseRequired)

  if "items" in node:
    # Before 2020-12, an `items` holding a list was how a tuple was written.
    if node{"items"}.kind == JArray:
      result.incl(ParseTuple)
    else:
      result.incl(ParseArray)
  if "prefixItems" in node:
    result.incl(ParseTuple)
  if "enum" in node:
    result.incl(ParseEnum)
  if "allOf" in node:
    result.incl(ParseAllOf)
  if "oneOf" in node:
    result.incl(ParseOneOf)
  if "anyOf" in node:
    result.incl(ParseAnyOf)
  if "const" in node:
    result.incl(ParseConst)

  if "type" in node:
    let typ = node{"type"}
    case typ.kind
    of JString:
      # An array is described by its `items`, which `parseArray` fills in with an
      # unconstrained value when the keyword is missing entirely. A tuple is also
      # written as `type: array`, so the list-form `items`/`prefixItems` wins.
      if typ.getStr == "array":
        if ParseTuple notin result:
          result.incl(ParseArray)
      else:
        result.incl(ParseTypeName)
    of JArray:
      result.incl(ParseTypeList)
    else:
      raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

  # Every format the spec defines describes a string, so a node whose only keyword is a
  # `format` is one. It says nothing at all about an instance of any other type, though --
  # `{"type": "integer", "format": "int64"}` is an integer, not a contradiction -- so it
  # only names a type when nothing else on the node has.
  if result.card == 0 and "format" in node:
    result.incl(ParseFormat)

proc parseType(
    node: JsonNode, mode: ParseMode, ctx: ParseContext, history: History
): TypeDef =
  ## Parses a single interpretation of a schema node, ignoring every other keyword on it
  case mode
  of ParseRef:
    return parseRef(node, ctx, history)
  of ParseMap:
    let entries = node.parseSubnodeType("additionalProperties", ctx, history)

    # Entries nothing can satisfy is an object that accepts no key it does not name, which
    # is what `additionalProperties: false` says the short way
    if entries.kind == NeverType:
      return parseObj(node, ctx, history)

    return TypeDef(kind: MapType, entries: entries, id: id(node))
  of ParseObj:
    return parseObj(node, ctx, history)
  of ParseRequired:
    return parseRequired(node, history)
  of ParseArray:
    return parseArray(node, ctx, history)
  of ParseTuple:
    return parseTuple(node, ctx, history)
  of ParseEnum:
    return parseEnum(node, ctx, history)
  of ParseAllOf:
    return parseAllOf(node{"allOf"}, ctx, history.add("allOf"))
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
    return TypeDef(kind: ConstValueType, value: node{"const"}, id: id(node))

proc parseType(node: JsonNode, ctx: ParseContext, history: History): TypeDef =
  # A boolean is a schema in its own right: `true` accepts every value, `false` accepts
  # none. There is no Nim type for the latter, so it is carried as `NeverType` and absorbed
  # by whichever keyword encloses it; one that reaches the root is reported there.
  if node.kind == JBool:
    return
      if node.getBool:
        TypeDef(kind: JsonType)
      else:
        TypeDef(kind: NeverType)
  if node.kind != JObject:
    raise newException(ValueError, fmt"Unable to parse type {node} at {history}")

  let modes = determineParseModes(node, history)
  if modes.card == 0:
    return TypeDef(kind: JsonType, id: id(node))

  for mode in modes:
    let parsed = node.parseType(mode, ctx, history)
    result =
      if result.isNil:
        parsed
      else:
        mergeTypes(result, parsed, history)

  # Once every keyword on the node has been folded in, an array whose element nothing
  # satisfies is an array whose only value is the empty one -- a fixed length array of
  # length zero, which the tuple machinery already describes end to end. This has to wait
  # until after the merge, because a `prefixItems` written beside the `items` is what
  # decides whether the array had any slots to begin with.
  if result.kind == ArrayType and result.items.kind == NeverType:
    result = TypeDef(kind: TupleType, id: result.id)

proc parseSchema*(node: JsonNode, resolver: UrlResolver): JsonSchema =
  result = JsonSchema()
  let ctx =
    ParseContext(doc: node, resolver: resolver, refs: initTable[SchemaRef, TypeDef]())

  # The root never goes through `parseRef`, so the chain is opened with its reference by
  # hand. The type it produces takes that reference too, since an edge onto the root looks
  # the root up by it, but only when nothing else named it: a root that is itself a `$ref`
  # already carries the reference it resolved through, and that one has to win.
  let rootRef = SchemaRef(kind: RootRef)
  result.rootType = parseType(node, ctx, addRef(nil, rootRef))
  if result.rootType.sref.isNil:
    result.rootType.sref = rootRef
  result.refs = ctx.refs

  if result.rootType.kind == NeverType:
    raise newException(
      ValueError,
      "This schema accepts no values at all, so there is no type to generate",
    )

proc parseSchema*(node: string, resolver: UrlResolver): JsonSchema =
  node.parseJson.parseSchema(resolver)
