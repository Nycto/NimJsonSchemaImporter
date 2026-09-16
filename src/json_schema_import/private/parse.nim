import std/json, types, schemaRef, describeparse, lower, ../config

proc parseSchema*(node: JsonNode, resolver: UrlResolver): JsonSchema =
  result = JsonSchema(rootType: describeSchema(node, resolver).lower)

  # An edge onto the root looks the root up by its reference, which only a root that was
  # itself a `$ref` already carries
  if result.rootType.sref.isNil:
    result.rootType.sref = SchemaRef(kind: RootRef)

  if result.rootType.kind == NeverType:
    raise newException(
      ValueError,
      "This schema accepts no values at all, so there is no type to generate",
    )

proc parseSchema*(node: string, resolver: UrlResolver): JsonSchema =
  node.parseJson.parseSchema(resolver)
