##
## Library for generating native nim types from a JSON schema
##

import std/[json], json_schema_types/[parse, gen, schemaRef]

proc parseJsonSchema*(
    schema: JsonNode,
    name: string,
    namePrefix: string = "",
    resolver: UrlResolver = defaultResolver
): NimNode {.compileTime.} =
    return parseSchema(schema, resolver).genDeclarations(name, namePrefix)

proc parseJsonSchema*(
    schema, name: string,
    namePrefix: string = "",
    resolver: UrlResolver = defaultResolver
): NimNode {.compileTime.} =
    parseJsonSchema(schema.parseJson, name, namePrefix, resolver)
