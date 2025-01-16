##
## Library for generating native nim types from a JSON schema
##

import std/[json], json_schema_reader/[parse, gen]

proc parseJsonSchema*(schema: JsonNode, name: string): NimNode {.compileTime.} =
    return parseSchema(schema).genDeclarations(name)

proc parseJsonSchema*(schema, name: string): NimNode {.compileTime.} =
    parseJsonSchema(schema.parseJson, name)
