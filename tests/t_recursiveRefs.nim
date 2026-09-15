import
  std/[unittest, os, strutils, tables],
  json_schema_import/private/[parse, schemaRef, types]

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
  # An edge onto anything but an object or a union has no named type to point at. Codegen
  # turns those away, since the parser no longer records that a reference was cut; these pin
  # down what it will be handed.
  test "Parses to a map whose entries are the edge":
    let typ = """{
      "$ref": "#/$defs/tree",
      "$defs": {
        "tree": { "type": "object", "additionalProperties": { "$ref": "#/$defs/tree" } }
      }
    }""".root
    check(typ.kind == MapType)
    check(typ.entries.kind == RefType)

  test "Parses to an array whose items are the edge":
    let typ = """{
      "$ref": "#/$defs/list",
      "$defs": { "list": { "type": "array", "items": { "$ref": "#/$defs/list" } } }
    }""".root
    check(typ.kind == ArrayType)
    check(typ.items.kind == RefType)

suite "The committed recursive examples":
  test "All parse to a finite tree":
    for name in ["recursive_tree", "linked_list", "mutual_refs", "recursive_union"]:
      let path = currentSourcePath.parentDir() & "/examples/" & name & "/schema.json"
      check(parse(readFile(path)).rootType.kind == ObjType)
