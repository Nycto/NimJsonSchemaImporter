##
## Library for generating native nim types from a JSON schema
##

import std/[json, macros, paths, jsonutils], json_schema_import/config, json_schema_import/private/[parse, gen]

export JsonSchemaConfig, UrlResolver, json, jsonutils

proc defaultUrlResolver(uri: string): JsonNode = nil

proc parseJsonSchema(schema: JsonNode, conf: JsonSchemaConfig): NimNode {.compileTime.} =
    ## Parses a json schema
    let resolver = if conf.urlResolver == nil: defaultUrlResolver else: conf.urlResolver
    parseSchema(schema, resolver).genDeclarations(conf.rootTypeName, conf.typePrefix)

proc parseJsonSchema(schema: string, conf: JsonSchemaConfig): NimNode {.compileTime.} =
    ## Parses a json schema from a string
    parseJsonSchema(schema.parseJson, conf)

macro realImportJsonSchema(rootDir, path: static Path, conf: static JsonSchemaConfig) =
    ## Underlying macro for parsing the actual file. This is separated into a different
    ## macro to allow collection of a path relative to the importing file
    let resolvedPath = if path.isAbsolute: path else: rootDir / path
    parseJsonSchema(slurp($resolvedPath), conf)

proc getRootDir(node: NimNode): NimNode =
    newCall(bindSym("Path"), newLit($(lineInfoObj(node).filename.Path.parentDir)))

macro importJsonSchema*(path: string, conf: JsonSchemaConfig) =
    ## Imports a json schema file as if it were a nim file
    let rootDir = path.getRootDir
    quote:
        realImportJsonSchema(`rootDir`, Path(`path`), `conf`)

macro importJsonSchema*(path: string) =
    ## Imports a json schema file as if it were a nim file
    let rootDir = path.getRootDir
    return quote:
        realImportJsonSchema(`rootDir`, Path(`path`), JsonSchemaConfig())

macro importJsonSchema*(path, prefix: string) =
    ## Imports a json schema file as if it were a nim file
    let rootDir = path.getRootDir
    quote:
        realImportJsonSchema(`rootDir`, Path(`path`), JsonSchemaConfig(typePrefix: `prefix`))
