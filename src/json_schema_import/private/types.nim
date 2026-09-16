import std/[sets, tables, strformat, hashes, strutils, uri, json], schemaRef, namechain

type
  TypeDefKind* = enum
    ObjType
    RefType
    ArrayType
    TupleType
    IntegerType
    StringType
    NumberType
    BoolType
    NullType
    EnumType
    UnionType
    JsonType
    MapType
    OptionalType
    ConstValueType
    NeverType ## A schema nothing can satisfy, written as a `false` subschema
    NoteType
      ## A type carrying a note: another type that has to be generated alongside it

  PropDef* = tuple[propName: string, typ: TypeDef, required: bool]
    ## The details of an object property

  TypeDef* = ref object
    sref*: SchemaRef
    id*: Uri
    case kind*: TypeDefKind
    of ObjType:
      properties*: OrderedTable[string, PropDef]
    of EnumType:
      values*: OrderedSet[string]
    of RefType:
      schemaRef*: SchemaRef ## Left unresolved: `hash`, `==` and `$` all walk the tree
    of ArrayType:
      items*: TypeDef
    of TupleType:
      elements*: seq[TypeDef]
    of UnionType:
      subtypes*: seq[TypeDef]
    of MapType:
      entries*: TypeDef
    of OptionalType:
      subtype*: TypeDef
    of IntegerType, StringType, NumberType, BoolType, NullType, JsonType, NeverType:
      discard
    of ConstValueType:
      value*: JsonNode
    of NoteType:
      note*: TypeDef ## Replaced by `inner`, but an edge inside still points at its name
      inner*: TypeDef ## The type this node actually describes

  JsonSchema* = ref object
    rootType*: TypeDef

proc hasRealField*(typ: TypeDef): bool =
  ## Returns whether the given type actually requires a field on internal object
  return
    case typ.kind
    of ConstValueType:
      false
    of OptionalType:
      hasRealField(typ.subtype)
    of NoteType:
      hasRealField(typ.inner)
    else:
      true

proc hash*(typ: TypeDef): Hash {.noSideEffect.} =
  result = hash(typ.kind) !& hash(typ.sref)

  case typ.kind
  of ObjType:
    result = result !& hash(typ.properties)
  of EnumType:
    result = result !& hash(typ.values)
  of RefType:
    result = result !& hash(typ.schemaRef)
  of ArrayType:
    result = result !& hash(typ.items)
  of TupleType:
    result = result !& hash(typ.elements)
  of UnionType:
    result = result !& hash(typ.subtypes)
  of MapType:
    result = result !& hash(typ.entries)
  of OptionalType:
    result = result !& hash(typ.subtype)
  of IntegerType, StringType, NumberType, BoolType, NullType, JsonType, NeverType:
    discard
  of ConstValueType:
    result = result !& hash(typ.value)
  of NoteType:
    result = result !& hash(typ.note.sref) !& hash(typ.inner)

proc `==`*(a, b: TypeDef): bool {.noSideEffect.} =
  if a.kind != b.kind:
    return false

  case a.kind
  of ObjType:
    return a.properties == b.properties
  of EnumType:
    return a.values == b.values
  of RefType:
    return a.schemaRef == b.schemaRef
  of ArrayType:
    return a.items == b.items
  of TupleType:
    return a.elements == b.elements
  of UnionType:
    return a.subtypes == b.subtypes
  of MapType:
    return a.entries == b.entries
  of OptionalType:
    return a.subtype == b.subtype
  of NoteType:
    return a.note.sref == b.note.sref and a.inner == b.inner
  of IntegerType, StringType, NumberType, BoolType, NullType, JsonType, ConstValueType,
      NeverType:
    return true

proc closesOnto*(typ: TypeDef, sref: SchemaRef): bool =
  ## Whether an edge anywhere inside a type points back at the given reference

  template recurse(sub: TypeDef): bool =
    not sub.isNil and sub.closesOnto(sref)

  case typ.kind
  of RefType:
    return typ.schemaRef == sref
  of ObjType:
    for _, prop in typ.properties:
      if recurse(prop.typ):
        return true
  of ArrayType:
    return recurse(typ.items)
  of MapType:
    return recurse(typ.entries)
  of OptionalType:
    return recurse(typ.subtype)
  of NoteType:
    return recurse(typ.inner)
  of TupleType:
    for element in typ.elements:
      if recurse(element):
        return true
  of UnionType:
    for subtype in typ.subtypes:
      if recurse(subtype):
        return true
  of EnumType, IntegerType, StringType, NumberType, BoolType, NullType, JsonType,
      ConstValueType, NeverType:
    discard

proc isEdgeTarget*(typ: TypeDef): bool =
  ## Whether an edge inside a type needs the type's own name to point at
  not typ.sref.isNil and typ.closesOnto(typ.sref)

proc withNote*(inner, note: TypeDef): TypeDef =
  ## Keeps a type an edge closes onto alive next to whatever replaced it
  if inner.sref == note.sref:
    return inner
  return TypeDef(kind: NoteType, note: note, inner: inner)

proc `$`*(typ: TypeDef): string =
  case typ.kind
  of ObjType:
    result = fmt"(Obj {typ.properties})"
  of EnumType:
    result = fmt"(Enum {typ.values})"
  of RefType:
    result = fmt"(Ref {typ.schemaRef})"
  of ArrayType:
    result = fmt"(Array {typ.items})"
  of TupleType:
    result = fmt"(Tuple {typ.elements})"
  of UnionType:
    result = fmt"(Union {typ.subtypes})"
  of MapType:
    result = fmt"(Map {typ.entries})"
  of OptionalType:
    result = fmt"(Optional {typ.subtype})"
  of IntegerType:
    result = "(Integer)"
  of StringType:
    result = "(String)"
  of NumberType:
    result = "(Number)"
  of BoolType:
    result = "(Bool)"
  of NullType:
    result = "(Null)"
  of JsonType:
    result = "(Json)"
  of NeverType:
    result = "(Never)"
  of ConstValueType:
    result = fmt"(Const {typ.value})"
  of NoteType:
    result = fmt"(Note {typ.note.sref} {typ.inner})"

  if not typ.sref.isNil:
    result = fmt"({typ.sref} {result})"

proc withRef*(typ: TypeDef, sref: SchemaRef): TypeDef =
  ## Labels a type with the reference it was reached through
  ##
  ## When `typ` is already labelled it gets copied, because a labelled type is one that
  ## is memoized under its own reference and relabelling it in place would corrupt that
  ## entry. Note that the copy has to be built field by field: `result[] = typ[]` looks
  ## like it would do the job, but the VM aliases the two bodies instead of copying.
  if typ.sref.isNil:
    typ.sref = sref
    return typ

  # Relabelling would take away the name an edge inside points at. The old name serves just
  # as well, unless an edge needs the new one too.
  if typ.isEdgeTarget and not typ.closesOnto(sref):
    return typ

  result =
    case typ.kind
    of ObjType:
      TypeDef(kind: ObjType, properties: typ.properties)
    of EnumType:
      TypeDef(kind: EnumType, values: typ.values)
    of RefType:
      TypeDef(kind: RefType, schemaRef: typ.schemaRef)
    of ArrayType:
      TypeDef(kind: ArrayType, items: typ.items)
    of TupleType:
      TypeDef(kind: TupleType, elements: typ.elements)
    of UnionType:
      TypeDef(kind: UnionType, subtypes: typ.subtypes)
    of MapType:
      TypeDef(kind: MapType, entries: typ.entries)
    of OptionalType:
      TypeDef(kind: OptionalType, subtype: typ.subtype)
    of ConstValueType:
      TypeDef(kind: ConstValueType, value: typ.value)
    of NoteType:
      TypeDef(kind: NoteType, note: typ.note, inner: typ.inner)
    of IntegerType, StringType, NumberType, BoolType, NullType, JsonType, NeverType:
      TypeDef(kind: typ.kind)

  result.id = typ.id
  result.sref = sref
  if typ.isEdgeTarget:
    result = result.withNote(typ)

const SELF_OPTIONAL* = {MapType, ArrayType}
  ## These are field types that don't need to be wrapped in optional values

proc stripNotes*(typ: TypeDef): TypeDef =
  ## Looks past any notes, to the type a value actually has
  result = typ
  while result.kind == NoteType:
    result = result.inner

proc optional*(typ: TypeDef): TypeDef =
  return
    if typ.stripNotes.kind in SELF_OPTIONAL or
        typ.stripNotes.kind in {ConstValueType, OptionalType}:
      typ
    else:
      TypeDef(kind: OptionalType, subtype: typ)

proc refName(sref: SchemaRef): string =
  ## The fragment a type reached through a reference is named after
  return if sref.getName == "": "Root" else: sref.getName

proc abbrev*(typ: TypeDef): string =
  ## Returns an abbreviated name of a type
  if typ.sref != nil:
    return typ.sref.getName().capitalizeAscii

  return
    case typ.kind
    of ObjType: "Object"
    of EnumType: "Enum"
    of RefType: typ.schemaRef.refName
    of ArrayType: "Seq"
    of TupleType: "Tuple"
    of UnionType: "Union"
    of MapType: "Map"
    of OptionalType: "Opt"
    of IntegerType: "Int"
    of StringType: "Str"
    of NumberType: "Float"
    of BoolType: "Bool"
    of NullType: "Null"
    of JsonType: "Json"
    of ConstValueType: "Const"
    of NeverType: "Never"
    of NoteType: typ.inner.abbrev

proc abbrevAll(typs: seq[TypeDef]): string =
  ## Names a type built out of a list of others by what each of them is
  var accum: seq[string]
  for typ in typs:
    accum.add(typ.abbrev)
  return "Of" & accum.join("And")

iterator nameFragments*(typ: TypeDef): string =
  ## Produces fragments of a descriptive name for a type
  if typ.sref != nil:
    yield typ.sref.getName().capitalizeAscii
  else:
    yield typ.abbrev()

    case typ.kind
    of ObjType:
      discard
    of ArrayType:
      yield fmt"Of{typ.items.abbrev}"
    of TupleType:
      yield typ.elements.abbrevAll
    of UnionType:
      yield typ.subtypes.abbrevAll
    of MapType:
      yield fmt"Of{typ.entries.abbrev}"
    of OptionalType:
      yield fmt"Of{typ.subtype.abbrev}"
    of EnumType, RefType, IntegerType, StringType, NumberType, BoolType, NullType,
        JsonType, ConstValueType, NeverType, NoteType:
      discard

proc chooseName*(typ: TypeDef): string =
  for fragment in typ.nameFragments:
    result &= fragment

proc removeExt(value: string): string =
  let pos = value.find('.')
  return
    if pos == -1:
      value
    else:
      value[0 ..< pos]

proc extractFilename(value: string): string =
  for part in value.rsplit('/'):
    return part
  return value

iterator proposeNames*(typ: TypeDef, prefix: string, name: NameChain): string =
  ## Proposes all possible names for a type
  # A type reached through a `$ref` borrows the name of the ref target, but at the root
  # the name the user configured outranks it; the ref name is only a fallback there.
  if name.isRoot:
    for name in name.chainOptions(prefix):
      yield name

  for name in name.add(typ.sref.getName).nameOptions(prefix):
    yield name

  var base = typ.id.path.extractFilename.capitalizeAscii.removeExt
  if base == "":
    base = "Anon"

  yield prefix & base

  var i = 1
  while true:
    inc i
    yield prefix & base & $i
