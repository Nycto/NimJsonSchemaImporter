import std/[unittest, json, strutils]
import json_schema_import/config, json_schema_import/private/cache

const schema = """{"type": "object", "properties": {"a": {"type": "string"}}}"""
const other = """{"type": "object", "properties": {"b": {"type": "string"}}}"""

proc resolver(uri: string): JsonNode =
  raiseAssert("Should never be called")

suite "Caching generated code":
  test "The same inputs produce the same key":
    const a = cacheKey(schema, JsonSchemaConfig())
    const b = cacheKey(schema, JsonSchemaConfig())
    check(a == b)

  test "A different schema produces a different key":
    const a = cacheKey(schema, JsonSchemaConfig())
    const b = cacheKey(other, JsonSchemaConfig())
    check(a != b)

  test "Every config field that changes the output changes the key":
    const base = cacheKey(schema, JsonSchemaConfig())
    const rootTypeName = cacheKey(schema, JsonSchemaConfig(rootTypeName: "Renamed"))
    const typePrefix = cacheKey(schema, JsonSchemaConfig(typePrefix: "My"))
    const noCopies = cacheKey(schema, JsonSchemaConfig(noCopies: true))

    check(base != rootTypeName)
    check(base != typePrefix)
    check(base != noCopies)
    check(rootTypeName != typePrefix)

  test "Schemas resolving remote urls are not cacheable":
    # Those documents are invisible to the key, so caching them could serve stale code
    const withResolver = cacheable(JsonSchemaConfig(urlResolver: resolver))
    const without = cacheable(JsonSchemaConfig())
    check(not withResolver)
    check(without)

  test "Cached files are named after the schema and keyed by the hash":
    const path = cachePath("/some/where/ldtk/schema.json", "ABC123")
    check(path.endsWith("/ldtk_schema_json_ABC123.nim"))

  test "Names are reduced to characters that are safe in a file name":
    const path = cachePath("/some/where/./my-schema.json", "ABC123")
    check(path.endsWith("/my_schema_json_ABC123.nim"))

  test "Inline schemas are named after their root type":
    const named = inlineSchemaName(JsonSchemaConfig(rootTypeName: "Root"))
    const anonymous = inlineSchemaName(JsonSchemaConfig())
    check(named == "Root")
    check(anonymous == "inline")
