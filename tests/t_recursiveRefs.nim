import
  std/[unittest, os, strutils, tables],
  json_schema_import {.all.},
  json_schema_import/private/[parse, schemaRef, types]

proc generate(schema: string): string {.compileTime.} =
  ## What codegen reports for a schema, or "" when it generates one
  try:
    discard parseJsonSchema(schema, JsonSchemaConfig(rootTypeName: "Root"))
    return ""
  except ValueError as e:
    return e.msg

template genError(schema: static string): string =
  const captured = generate(schema)
  captured

proc parse(schema: string): JsonSchema =
  ## Parses a schema without any url resolution, since none of these reach outwards
  parseSchema(schema, nil)

proc root(schema: string): TypeDef =
  parse(schema).rootType

proc prop(typ: TypeDef, key: string): TypeDef =
  check(key in typ.properties)
  return typ.properties[key].typ

const LINKED_LIST = """{
    "$ref": "#/$defs/node",
    "$defs": {
      "node": {
        "type": "object",
        "required": [ "value" ],
        "properties": {
          "value": { "type": "string" },
          "next": { "$ref": "#/$defs/node" }
        }
      }
    }
  }"""

const RECURSIVE_TREE = """{
    "type": "object",
    "required": [ "name" ],
    "properties": {
      "name": { "type": "string" },
      "children": { "type": "array", "items": { "$ref": "#" } }
    }
  }"""

const MUTUAL_REFS = """{
    "type": "object",
    "required": [ "top" ],
    "properties": { "top": { "$ref": "#/$defs/question" } },
    "$defs": {
      "question": {
        "type": "object",
        "required": [ "prompt" ],
        "properties": {
          "prompt": { "type": "string" },
          "answer": { "$ref": "#/$defs/answer" }
        }
      },
      "answer": {
        "type": "object",
        "required": [ "text" ],
        "properties": {
          "text": { "type": "string" },
          "followUp": { "$ref": "#/$defs/question" }
        }
      }
    }
  }"""

const RECURSIVE_UNION = """{
    "type": "object",
    "required": [ "name" ],
    "properties": {
      "name": { "type": "string" },
      "child": { "oneOf": [ { "type": "string" }, { "$ref": "#" } ] },
      "index": { "type": "object", "additionalProperties": { "$ref": "#" } }
    }
  }"""

suite "A reference that closes a cycle":
  test "Is cut where a definition points at itself":
    let typ = LINKED_LIST.root
    check(typ.kind == ObjType)

    let next = typ.prop("next")
    check(next.kind == OptionalType)
    check(next.subtype.kind == RefType)
    check(next.subtype.schemaRef == parseRef("#/$defs/node"))

  test "Is cut where the document root is referenced from inside an array":
    let typ = RECURSIVE_TREE.root
    check(typ.kind == ObjType)

    let children = typ.prop("children")
    check(children.kind == ArrayType)
    check(children.items.kind == RefType)
    check(children.items.schemaRef == parseRef("#"))

  test "Is cut on the second of two definitions that refer to each other":
    let typ = MUTUAL_REFS.root

    # `question` is reached first, so it is `answer` that holds the edge back
    let question = typ.prop("top")
    check(question.kind == ObjType)

    let answer = question.prop("answer")
    check(answer.kind == OptionalType)
    check(answer.subtype.kind == ObjType)

    let followUp = answer.subtype.prop("followUp")
    check(followUp.kind == OptionalType)
    check(followUp.subtype.kind == RefType)
    check(followUp.subtype.schemaRef == parseRef("#/$defs/question"))

  test "Is cut in a union arm and in map entries alike":
    let typ = RECURSIVE_UNION.root

    let child = typ.prop("child")
    check(child.kind == OptionalType)
    check(child.subtype.kind == UnionType)
    check(child.subtype.subtypes.len == 2)
    check(child.subtype.subtypes[0].kind == StringType)
    check(child.subtype.subtypes[1].kind == RefType)

    let index = typ.prop("index")
    check(index.kind == MapType)
    check(index.entries.kind == RefType)

  test "Leaves the tree finite enough to print":
    # `$` walks the whole tree, so it only returns at all because `RefType` is a leaf
    let printed = $RECURSIVE_TREE.root
    check("(Ref #)" in printed)
    check("children" in printed)

suite "The root schema":
  test "Is labelled with its own reference":
    # An edge onto the root looks the root up by this, and the root is reached without ever
    # going through `parseRef`, so nothing else would label it.
    check(RECURSIVE_TREE.root.sref == parseRef("#"))
    check(MUTUAL_REFS.root.sref == parseRef("#"))

  test "Keeps the reference it resolved through when it is itself a ref":
    check(LINKED_LIST.root.sref == parseRef("#/$defs/node"))

suite "A reference that does not close a cycle":
  test "Still resolves to a real type once it has been mentioned before":
    # The first mention resolves and memoizes `node`; the second must get that type back
    # rather than an edge, since by then nothing is left open for it to close onto.
    let typ = (
      """{
        "type": "object",
        "required": [ "first", "second" ],
        "properties": {
          "first": { "$ref": "#/$defs/node" },
          "second": { "$ref": "#/$defs/node" }
        },
        "$defs": {
          "node": {
            "type": "object",
            "required": [ "value" ],
            "properties": {
              "value": { "type": "string" },
              "next": { "$ref": "#/$defs/node" }
            }
          }
        }
      }"""
    ).root

    for key in ["first", "second"]:
      let entry = typ.prop(key)
      check(entry.kind == ObjType)
      check(entry.prop("next").subtype.kind == RefType)

suite "A reference that cannot be represented":
  test "Is rejected when it resolves only to itself":
    expect ValueError:
      discard """{
        "$ref": "#/$defs/a",
        "$defs": { "a": { "$ref": "#/$defs/a" } }
      }""".root

  test "Names the reference and the descent when it rejects one":
    try:
      discard """{
        "type": "object",
        "properties": { "held": { "$ref": "#/$defs/a" } },
        "$defs": { "a": { "$ref": "#/$defs/a" } }
      }""".root
      checkpoint("expected a ValueError")
      fail()
    except ValueError as e:
      check("resolves only to itself" in e.msg)
      check("#/properties/held -> #/$defs/a" in e.msg)

suite "A cycle with no type to close onto":
  # Only an object or a union reserves a name for an edge to point at, so codegen is where
  # these are turned away -- the parse hands over a container holding the edge.
  const MAP_CYCLE = """{
      "$ref": "#/$defs/tree",
      "$defs": {
        "tree": { "type": "object", "additionalProperties": { "$ref": "#/$defs/tree" } }
      }
    }"""

  const ARRAY_CYCLE = """{
      "$ref": "#/$defs/list",
      "$defs": { "list": { "type": "array", "items": { "$ref": "#/$defs/list" } } }
    }"""

  test "Parses to the container holding the edge":
    check(MAP_CYCLE.root.kind == MapType)
    check(MAP_CYCLE.root.entries.kind == RefType)
    check(ARRAY_CYCLE.root.kind == ArrayType)
    check(ARRAY_CYCLE.root.items.kind == RefType)

  test "Is rejected by codegen, naming the reference":
    check("object or a union" in genError(MAP_CYCLE))
    check("#/$defs/tree" in genError(MAP_CYCLE))
    check("object or a union" in genError(ARRAY_CYCLE))
    check("#/$defs/list" in genError(ARRAY_CYCLE))

  test "A cycle through an object or a union is not rejected":
    check(genError(LINKED_LIST) == "")
    check(genError(MUTUAL_REFS) == "")
    check(genError(RECURSIVE_TREE) == "")
    check(genError(RECURSIVE_UNION) == "")

suite "The committed recursive examples":
  test "All parse to a finite tree":
    for name in ["recursive_tree", "linked_list", "mutual_refs", "recursive_union"]:
      let path = currentSourcePath.parentDir() & "/examples/" & name & "/schema.json"
      check(parse(readFile(path)).rootType.kind == ObjType)
