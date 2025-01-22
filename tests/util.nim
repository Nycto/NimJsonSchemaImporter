import std/[json, strformat], json_schema_types

proc testResolver*(uri: string): JsonNode =
    if uri == "https://example.com/user-profile.schema.json":
        return %*{
            "type": "object",
            "properties": {
                "username": { "type": "string" },
                "email": { "type": "string" },
            }
        }
    else:
        raiseAssert(fmt"Unsupported test uri: {uri}")

proc conf*(rootTypeName: string): auto =
    return JsonSchemaConfig(rootTypeName: rootTypeName, typePrefix: rootTypeName, urlResolver: testResolver)
