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

proc newDescribeContext*(doc: JsonNode, resolver: UrlResolver): DescribeContext =
  DescribeContext(doc: doc, resolver: resolver)

proc id(node: JsonNode): Uri =
  if node.kind == JObject and node.hasKey("$id"):
    try:
      return parseUri(node{"$id"}.getStr)
    except:
      discard

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

  result = node.ownDescription(ctx, history)
  if result.isNil:
    result = anyValue()
