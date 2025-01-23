##
## Library for generating native nim types from a JSON schema
##

import std/[json, macros, paths, jsonutils], json_schema_types/[parse, gen, util]

export JsonSchemaConfig, UrlResolver, json, jsonutils

proc defaultUrlResolver*(uri: string): JsonNode = nil

proc parseJsonSchema*(schema: JsonNode, conf: JsonSchemaConfig): NimNode {.compileTime.} =
    let resolver = if conf.urlResolver == nil: defaultUrlResolver else: conf.urlResolver
    parseSchema(schema, resolver).genDeclarations(conf.rootTypeName, conf.typePrefix)

proc parseJsonSchema*(schema: string, conf: JsonSchemaConfig): NimNode {.compileTime.} =
    parseJsonSchema(schema.parseJson, conf)

macro realImportJsonSchema(rootDir, path: static Path, conf: static JsonSchemaConfig) =
    let resolvedPath = if path.isAbsolute: path else: rootDir / path
    parseJsonSchema(slurp($resolvedPath), conf)

macro importJsonSchema*(path: string, conf: JsonSchemaConfig) =
    ## Imports a json schema file as if it were a nim file
    let rootDir = newLit($(lineInfoObj(path).filename.Path.parentDir))
    quote:
        realImportJsonSchema(Path(`rootDir`), Path(`path`), `conf`)
