import
  std/[unittest, json, sets, options, tables],
  json_schema_import/private/[describe, lower, types, schemaRef]

proc v(kind: VariantKind): Variant =
  Variant(kind: kind)

proc d(kinds: varargs[VariantKind]): Description =
  result = never()
  for kind in kinds:
    result.variants.add(v(kind))

proc obj(props: openArray[(string, Description)], required: varargs[string]): Variant =
  result = Variant(kind: vkObject, shaped: true, required: toOrderedSet(required))
  for (key, prop) in props:
    result.properties[key] = prop

suite "Lowering scalars":
  test "Each kind has a type of its own":
    check(d(vkBool).lower.kind == BoolType)
    check(d(vkInteger).lower.kind == IntegerType)
    check(d(vkNumber).lower.kind == NumberType)
    check(d(vkString).lower.kind == StringType)
    check(d(vkAny).lower.kind == JsonType)

  test "An enum and a const":
    let enumed = Variant(kind: vkString, values: some(toOrderedSet(["a"])))
    check(describe(enumed).lower.kind == EnumType)
    check(describe(Variant(kind: vkConst, value: %1)).lower.kind == ConstValueType)

  test "An edge":
    check(d(vkEdge).lower.kind == RefType)

suite "Lowering alternatives":
  test "Nothing at all":
    check(never().lower.kind == NeverType)

  test "Only null":
    check(d(vkNull).lower.kind == NullType)

  test "Null alongside a single type makes it optional":
    let typ = d(vkNull, vkString).lower
    check(typ.kind == OptionalType)
    check(typ.subtype.kind == StringType)

  test "Several types become a union in the order they were listed":
    let typ = d(vkInteger, vkNull, vkString).lower
    check(typ.kind == OptionalType)
    check(typ.subtype.kind == UnionType)
    check(typ.subtype.subtypes[0].kind == IntegerType)
    check(typ.subtype.subtypes[1].kind == StringType)

  test "Alternatives that lower to the same type are folded together":
    check(d(vkString, vkString).lower.kind == StringType)

  test "Null makes a map no more optional than it already is":
    check(describe(Variant(kind: vkObject), v(vkNull)).lower.kind == MapType)

suite "Lowering objects":
  test "Properties that are not required are optional":
    let typ = describe(obj({"a": d(vkString), "b": d(vkString)}, "b")).lower
    check(typ.kind == ObjType)
    check(typ.properties["a"].typ.kind == OptionalType)
    check(typ.properties["b"].typ.kind == StringType)
    check(typ.properties["b"].required)

  test "A property nothing satisfies is left out":
    check(describe(obj({"a": never()})).lower.properties.len == 0)

  test "A required property that may be null stays optional":
    let typ = describe(obj({"a": d(vkString, vkNull)}, "a")).lower
    check(typ.properties["a"].typ.kind == OptionalType)

  test "Property names are made safe and unique":
    let typ = describe(obj({"_a": d(vkString), "a": d(vkString)})).lower
    check(typ.properties["_a"].propName == "a")
    check(typ.properties["a"].propName == "a1")

  test "A bare object is a map of anything":
    let typ = describe(Variant(kind: vkObject)).lower
    check(typ.kind == MapType)
    check(typ.entries.kind == JsonType)

  test "Additional properties describe the entries of a map":
    let typ = describe(Variant(kind: vkObject, additional: d(vkInteger))).lower
    check(typ.kind == MapType)
    check(typ.entries.kind == IntegerType)

  test "Listed properties win over additional properties":
    let variant = obj({"a": d(vkString)})
    variant.additional = d(vkInteger)
    check(describe(variant).lower.kind == ObjType)

  test "Additional properties nothing satisfies close the object":
    let typ = describe(Variant(kind: vkObject, additional: never())).lower
    check(typ.kind == ObjType)
    check(typ.properties.len == 0)

suite "Lowering arrays":
  test "Items describe a seq, anything when unspecified":
    check(
      describe(Variant(kind: vkArray, items: d(vkBool))).lower.items.kind == BoolType
    )
    check(describe(Variant(kind: vkArray)).lower.items.kind == JsonType)

  test "A prefix is a tuple":
    let typ =
      describe(Variant(kind: vkArray, prefix: some(@[d(vkString), d(vkBool)]))).lower
    check(typ.kind == TupleType)
    check(typ.elements.len == 2)
    check(typ.elements[1].kind == BoolType)

  test "Items nothing satisfies leave only the empty tuple":
    let typ = describe(Variant(kind: vkArray, items: never())).lower
    check(typ.kind == TupleType)
    check(typ.elements.len == 0)

proc named(desc: Description, name: string): Description =
  desc.relabel(parseRef("#/$defs/" & name))

proc edge(name: string): Description =
  describe(Variant(kind: vkEdge, target: parseRef("#/$defs/" & name)))

suite "Lowering labels":
  test "A labelled description names its type":
    check($d(vkString).named("a").lower.sref == "#/$defs/a")

  test "A labelled variant names its arm of a union":
    let arm = v(vkString)
    arm.sref = parseRef("#/$defs/a")
    let typ = describe(arm, v(vkInteger)).named("u").lower
    check($typ.sref == "#/$defs/u")
    check($typ.subtypes[0].sref == "#/$defs/a")
    check(typ.subtypes[1].sref.isNil)

  test "A reference reached twice lowers to the same type":
    let shared = describe(obj({"x": d(vkString)})).named("a")
    let typ = describe(obj({"first": shared, "second": shared})).lower
    check(typ.properties["first"].typ.subtype == typ.properties["second"].typ.subtype)
    check(
      cast[pointer](typ.properties["first"].typ.subtype) ==
        cast[pointer](typ.properties["second"].typ.subtype)
    )

  test "A folded type an edge closes onto is kept as a note":
    let node = describe(obj({"next": edge("node")})).named("node")
    let merged = intersect(node, describe(obj({"name": d(vkString)})))
    let typ = merged.lower
    check(typ.kind == NoteType)
    check($typ.note.sref == "#/$defs/node")
    check(typ.inner.kind == ObjType)
    check("name" in typ.inner.properties)

  test "A folded type nothing closes onto is dropped":
    let leaf = describe(obj({"id": d(vkString)})).named("leaf")
    let typ = intersect(leaf, describe(obj({"name": d(vkString)}))).lower
    check(typ.kind == ObjType)
    check(typ.properties.len == 2)

  test "Renaming a type an edge closes onto keeps the original alive":
    let node = describe(obj({"next": edge("node")})).named("node")
    let typ = node.named("alias").lower
    check(typ.stripNotes.kind == ObjType)
    check(typ.closesOnto(parseRef("#/$defs/node")))
