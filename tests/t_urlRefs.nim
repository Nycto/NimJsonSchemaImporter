import
  std/[unittest, json, tables], json_schema_import/private/[parse, types, schemaRef]

proc resolver(url: string): JsonNode =
  case url
  of "https://example.com/address.json":
    %*{
      "type": "object",
      "required": ["street"],
      "properties": {"street": {"$ref": "#/definitions/street"}},
      "definitions": {"street": {"type": "string"}},
    }
  of "https://example.com/list.json":
    %*{"type": "object", "properties": {"next": {"$ref": "#"}}}
  of "https://example.com/fragment.json":
    %*{"definitions": {"zip": {"type": "integer"}}}
  else:
    raiseAssert("Unsupported test url: " & url)

proc prop(typ: TypeDef, key: string): TypeDef =
  check(key in typ.properties)
  return typ.properties[key].typ

suite "References into fetched documents":
  test "A document relative reference resolves within the fetched document":
    let root = parseSchema(
      %*{
        "type": "object",
        "required": ["home"],
        "properties": {"home": {"$ref": "https://example.com/address.json"}},
        "definitions": {"street": {"type": "integer"}},
      },
      resolver,
    ).rootType

    check(root.prop("home").prop("street").kind == StringType)

  test "A url reference follows its fragment":
    let root = parseSchema(
      %*{
        "type": "object",
        "required": ["zip"],
        "properties":
          {"zip": {"$ref": "https://example.com/fragment.json#/definitions/zip"}},
      },
      resolver,
    ).rootType

    check(root.prop("zip").kind == IntegerType)

  test "The same relative reference in two documents is not shared":
    let root = parseSchema(
      %*{
        "type": "object",
        "required": ["home", "street"],
        "properties": {
          "home": {"$ref": "https://example.com/address.json"},
          "street": {"$ref": "#/definitions/street"},
        },
        "definitions": {"street": {"type": "integer"}},
      },
      resolver,
    ).rootType

    check(root.prop("street").kind == IntegerType)
    check(root.prop("home").prop("street").kind == StringType)

  test "A cycle inside a fetched document closes onto that document":
    let root = parseSchema(
      %*{
        "type": "object",
        "required": ["list"],
        "properties": {"list": {"$ref": "https://example.com/list.json"}},
      },
      resolver,
    ).rootType

    let next = root.prop("list").prop("next").subtype
    check(next.kind == RefType)
    check($next.schemaRef == "https://example.com/list.json#")

suite "Embedded resources":
  test "A relative reference resolves against the $id around it":
    let root = parseSchema(
      %*{
        "$id": "https://example.com/schemas/root",
        "type": "object",
        "required": ["zip"],
        "properties": {"zip": {"$ref": "./zip"}},
        "$defs": {"zip": {"$id": "https://example.com/schemas/zip", "type": "integer"}},
      },
      resolver,
    ).rootType

    check(root.prop("zip").kind == IntegerType)

  test "An embedded $id is itself relative to the one above it":
    let root = parseSchema(
      %*{
        "$id": "https://example.com/schemas/root",
        "type": "object",
        "required": ["zip"],
        "properties": {"zip": {"$ref": "zip"}},
        "$defs": {"zip": {"$id": "./zip", "type": "integer"}},
      },
      resolver,
    ).rootType

    check(root.prop("zip").kind == IntegerType)
