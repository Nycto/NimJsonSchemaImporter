##
## Library for generating native nim types from a JSON schema
##

import std/[json], json_schema_reader/[parse, gen, schemaRef]

proc parseJsonSchema*(
    schema: JsonNode,
    name: string,
    resolver: UrlResolver = defaultResolver
): NimNode {.compileTime.} =
    return parseSchema(schema, resolver).genDeclarations(name)

proc parseJsonSchema*(
    schema, name: string,
    resolver: UrlResolver = defaultResolver
): NimNode {.compileTime.} =
    parseJsonSchema(schema.parseJson, name, resolver)
