import
  std/[json, sets, tables, strformat, uri, options],
  describe,
  schemaRef,
  history,
  ../config

type DescribeContext* = ref object
  doc: JsonNode
  resolver: UrlResolver
  refs: Table[SchemaRef, Description]
    ## Every reference resolved so far, by the reference

proc id(node: JsonNode): Uri =
  if node.kind == JObject and node.hasKey("$id"):
    try:
      return parseUri(node{"$id"}.getStr)
    except:
      discard

iterator requiredKeys(node: JsonNode): string =
  ## The keys named by a `required` list; draft 3's boolean `required` names none
  if "required" in node and node{"required"}.kind == JArray:
    for key in node{"required"}:
      yield key.getStr

proc describeNode*(node: JsonNode, ctx: DescribeContext, history: History): Description

proc typeVariant(name: string, history: History): Variant =
  case name
  of "string":
    Variant(kind: vkString)
  of "number":
    Variant(kind: vkNumber)
  of "integer":
    Variant(kind: vkInteger)
  of "boolean":
    Variant(kind: vkBool)
  of "null":
    Variant(kind: vkNull)
  of "object":
    Variant(kind: vkObject)
  of "array":
    Variant(kind: vkArray)
  else:
    raise newException(ValueError, fmt"Unsupported type {name} at {history}")

proc allowedTypes(node: JsonNode, ctx: DescribeContext, history: History): Description =
  ## The types a `type` keyword narrows a node to, or nil when it has none
  let typ = node{"type"}
  if typ.isNil:
    return nil

  case typ.kind
  of JString:
    return describe(typeVariant(typ.getStr, history))
  of JArray:
    result = never()
    for entry in typ:
      result =
        if entry.kind == JString:
          result.union(describe(typeVariant(entry.getStr, history)))
        else:
          result.union(entry.describeNode(ctx, history.add("type")))
  else:
    raise newException(ValueError, fmt"Unsupported type {typ} at {history}")

proc objectConstraint(node: JsonNode, ctx: DescribeContext, history: History): Variant =
  ## What `properties`, `required` and `additionalProperties` say about an object
  var required = false
  for _ in node.requiredKeys:
    required = true
  if "properties" notin node and "additionalProperties" notin node and not required:
    return nil

  result = Variant(kind: vkObject, shaped: "properties" in node)
  if "properties" in node:
    for key, sub in node{"properties"}:
      result.properties[key] = sub.describeNode(ctx, history.add("properties").add(key))

  # A required key nothing else describes can hold anything at all
  for key in node.requiredKeys:
    result.required.incl(key)
    if key notin result.properties:
      result.properties[key] = anyValue()

  if "additionalProperties" in node:
    result.additional = node{"additionalProperties"}.describeNode(
      ctx, history.add("additionalProperties")
    )

proc arrayConstraint(node: JsonNode, ctx: DescribeContext, history: History): Variant =
  ## What `items` and `prefixItems` say about an array
  if "items" notin node and "prefixItems" notin node:
    return nil

  # Before 2020-12, a tuple was written as an `items` holding a list
  let items = node{"items"}
  let slotsKey = if "prefixItems" in node: "prefixItems" else: "items"
  let slots = node{slotsKey}

  result = Variant(kind: vkArray)
  if not items.isNil and items.kind != JArray:
    result.items = items.describeNode(ctx, history.add("items"))

  if not slots.isNil and slots.kind == JArray:
    # `items` covers every slot too, unless it is `false`, which only closes the tail
    let covers = not result.items.isNil and not result.items.isNever
    var elements: seq[Description]
    for i in 0 ..< slots.len:
      let element = slots[i].describeNode(ctx, history.add(slotsKey).add($i))
      elements.add(
        if covers:
          intersect(element, result.items)
        else:
          element
      )
    result.prefix = some(elements)

proc scalarConstraints(node: JsonNode): seq[Variant] =
  ## What `enum` and `const` say about a node
  if "enum" in node:
    var values = initOrderedSet[string]()
    var nullable = false
    var onlyStrings = true
    for value in node{"enum"}:
      case value.kind
      of JString:
        values.incl(value.getStr)
      of JNull:
        nullable = true
      else:
        onlyStrings = false

    # An enum of anything but strings says nothing a Nim enum could carry
    if onlyStrings:
      if values.len > 0:
        result.add(Variant(kind: vkString, values: some(values)))
      if nullable:
        result.add(Variant(kind: vkNull))

  if "const" in node:
    result.add(Variant(kind: vkConst, value: node{"const"}))

proc constrains(constraint, variant: Variant): bool =
  ## Whether a keyword's constraint applies to a type `type` allowed
  constraint.kind == variant.kind or
    (constraint.kind == vkConst and not intersectVariant(variant, constraint).isNil)

proc ownDescription(
    node: JsonNode, ctx: DescribeContext, history: History
): Description =
  ## What the keywords written on the node itself say, ignoring references and combinators,
  ## or nil when they say nothing at all
  var constraints = node.scalarConstraints
  for constraint in [
    node.objectConstraint(ctx, history), node.arrayConstraint(ctx, history)
  ]:
    if not constraint.isNil:
      constraints.add(constraint)
  for constraint in constraints:
    constraint.id = id(node)

  let allowed = node.allowedTypes(ctx, history)
  if allowed.isNil:
    # Every format describes a string, but only says so when nothing else names a type
    let combined =
      "$ref" in node or "allOf" in node or "oneOf" in node or "anyOf" in node
    if constraints.len == 0 and "format" in node and not combined:
      constraints.add(Variant(kind: vkString, id: id(node)))
    if constraints.len == 0:
      return nil

    result = never()
    for constraint in constraints:
      if not constraint.isEmpty:
        result.variants.add(constraint)
    return

  # Each keyword narrows only the types it is about, leaving the rest of `type` alone
  result = never()
  for allowedVariant in allowed.variants:
    var variant = allowedVariant
    if variant.id == default(Uri) and variant.sref.isNil:
      variant = variant.clone
      variant.id = id(node)
    for constraint in constraints:
      if not variant.isNil and constraint.constrains(variant):
        variant = intersectVariant(variant, constraint)
    if not variant.isNil:
      result.variants.add(variant)
  result.folded = allowed.folded

proc describeRef(node: JsonNode, ctx: DescribeContext, history: History): Description =
  let sref = parseRef(node{"$ref"}.getStr).within(history.document)

  # A reference still open closes a cycle, so it is cut into an edge naming it
  if sref in history:
    return describe(Variant(kind: vkEdge, target: sref))

  # Every site reaching a definition would otherwise walk it again
  if sref in ctx.refs:
    return ctx.refs[sref]

  let inner = history.addRef(sref)
  result = sref.resolve(ctx.doc, ctx.resolver).describeNode(ctx, inner).relabel(sref)

  if result.variants.len == 1 and result.variants[0].kind == vkEdge:
    raise
      newException(ValueError, fmt"Reference {sref} resolves only to itself: {inner}")

  ctx.refs[sref] = result

proc describeAlternatives(
    node: JsonNode, key: string, ctx: DescribeContext, history: History
): Description =
  ## The union of every branch of a `oneOf` or `anyOf`
  let branches = node{key}
  if branches.kind != JArray or branches.len == 0:
    raise newException(ValueError, fmt"Empty union at {history.add(key)}")

  result = branches[0].describeNode(ctx, history.add(key))
  for i in 1 ..< branches.len:
    result = result.union(branches[i].describeNode(ctx, history.add(key)))

proc describeNode*(
    node: JsonNode, ctx: DescribeContext, history: History
): Description =
  # `true` accepts every value and `false` none
  if node.kind == JBool:
    return
      if node.getBool:
        anyValue()
      else:
        never()
  if node.kind != JObject:
    raise newException(ValueError, fmt"Unable to parse type {node} at {history}")

  # Folded in a fixed order, which is the order object properties come out in
  var parts: seq[Description]
  if "$ref" in node:
    parts.add(node.describeRef(ctx, history))

  let own = node.ownDescription(ctx, history)
  if not own.isNil:
    own.id = id(node)
    parts.add(own)

  if "allOf" in node:
    let branches = node{"allOf"}
    let within = history.add("allOf")
    if branches.kind != JArray or branches.len == 0:
      raise newException(ValueError, fmt"Empty allOf at {within}")
    for i in 0 ..< branches.len:
      parts.add(branches[i].describeNode(ctx, within.add($i)))

  for key in ["oneOf", "anyOf"]:
    if key in node:
      parts.add(node.describeAlternatives(key, ctx, history))

  if parts.len == 0:
    return anyValue()

  result = parts[0]
  for i in 1 ..< parts.len:
    result = intersect(result, parts[i])
  if parts.len > 1 and result.id == default(Uri):
    result.id = id(node)

proc describeSchema*(node: JsonNode, resolver: UrlResolver): Description =
  ## Describes a whole document, starting at its root
  let ctx = DescribeContext(doc: node, resolver: resolver)
  node.describeNode(ctx, addRef(nil, SchemaRef(kind: RootRef)))
