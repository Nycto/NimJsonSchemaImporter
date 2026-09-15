import std/json, types, describe, describeparse, lower, ../config

proc parseSchema*(node: JsonNode, resolver: UrlResolver): JsonSchema =
  let desc = describeSchema(node, resolver)
  if desc.isNever:
    raise newException(
      ValueError,
      "This schema accepts no values at all, so there is no type to generate",
    )

  result = JsonSchema(rootType: desc.lower)

  # An edge onto the root looks the root up by its reference, which only a root that was
  # itself a `$ref` already carries
  if result.rootType.sref.isNil:
    result.rootType.sref = node.rootRef

proc parseSchema*(node: string, resolver: UrlResolver): JsonSchema =
  node.parseJson.parseSchema(resolver)
