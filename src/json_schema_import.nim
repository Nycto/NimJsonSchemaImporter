##
## Library for generating native nim types from a JSON schema
##

import std/[json, macros, jsonutils, strutils], json_schema_import/config
import json_schema_import/private/[parse, gen, util, equality, bin]
from std/os import fileExists, `/`, relativePath

export JsonSchemaConfig, UrlResolver, json, jsonutils, equality, bin

proc defaultUrlResolver(uri: string): JsonNode = nil

proc parseJsonSchema(schema: JsonNode, conf: JsonSchemaConfig): GeneratedOutput {.compileTime.} =
    ## Parses a json schema
    let resolver = if conf.urlResolver == nil: defaultUrlResolver else: conf.urlResolver
    result = parseSchema(schema, resolver).genDeclarations(conf.rootTypeName, conf.typePrefix)
    when defined(dump):
        echo result.code.formatCodeDump

proc parseJsonSchema(schema: string, conf: JsonSchemaConfig): GeneratedOutput {.compileTime.} =
    ## Parses a json schema from a string
    parseJsonSchema(schema.parseJson, conf)

macro realImportJsonSchema(rootDir, path: static string, conf: static JsonSchemaConfig) =
    ## Underlying macro for parsing the actual file. This is separated into a different
    ## macro to allow collection of a path relative to the importing file
    let resolvedPath = if path.startsWith("/"): path else: rootDir & "/" & path
    parseJsonSchema(slurp($resolvedPath), conf).code

proc getRootDir(node: NimNode): NimNode =
    newLit($(lineInfoObj(node).filename.parentDir))

macro importJsonSchema*(path: string, conf: JsonSchemaConfig) =
    ## Imports a json schema file as if it were a nim file
    let rootDir = path.getRootDir
    quote:
        realImportJsonSchema(`rootDir`, `path`, `conf`)

macro importJsonSchema*(path: string) =
    ## Imports a json schema file as if it were a nim file
    let rootDir = path.getRootDir
    return quote:
        realImportJsonSchema(`rootDir`, `path`, JsonSchemaConfig())

macro importJsonSchema*(path, prefix: string) =
    ## Imports a json schema file as if it were a nim file
    let rootDir = path.getRootDir
    quote:
        realImportJsonSchema(`rootDir`, `path`, JsonSchemaConfig(typePrefix: `prefix`))

macro jsonSchema*(schema: static JsonNode) =
    ## Converts a direct json reference to nim as if it were a json schema
    parseJsonSchema(schema, JsonSchemaConfig()).code

proc realEmbedFromJson(typ: typedesc; rootDir, path: static string; alwaysEmbed: static bool): typ =
    ## Embeds a parsed JSON file when in release mode. Otherwise, loads from disk
    when alwaysEmbed:
        const bin = toBinary(slurp(rootDir / path).parseJson.jsonTo(typ))
        return typ.fromBinary(bin)
    else:
        let loadPath = (rootDir / path).relativePath(getProjectPath())
        assert(loadPath.fileExists, "File not found: " & loadPath)
        return jsonTo(parseFile(loadPath), typ)

macro embedFromJson*(typ: typedesc, path: string, alwaysEmbed: static bool = defined(release)): auto =
    let rootDir = path.getRootDir()
    return quote:
        realEmbedFromJson(`typ`, `rootDir`, `path`, `alwaysEmbed`)