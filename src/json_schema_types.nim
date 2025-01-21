##
## Library for generating native nim types from a JSON schema
##

import std/[json], json_schema_types/[parse, gen, util]

export JsonSchemaConfig, UrlResolver

proc defaultUrlResolver*(uri: string): JsonNode = nil

proc parseJsonSchema*(schema: JsonNode, conf: JsonSchemaConfig): NimNode {.compileTime.} =
    let resolver = if conf.urlResolver == nil: defaultUrlResolver else: conf.urlResolver
    parseSchema(schema, resolver).genDeclarations(conf.rootTypeName, conf.typeNamePrefix)

proc parseJsonSchema*(schema: string, conf: JsonSchemaConfig): NimNode {.compileTime.} =
    parseJsonSchema(schema.parseJson, conf)
