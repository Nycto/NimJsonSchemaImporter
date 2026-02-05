import std/[sets, tables, strformat, hashes, strutils, uri, json], schemaRef, namechain

type
  TypeDefKind* = enum
    ObjType
    RefType
    ArrayType
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
      schemaRef*: SchemaRef
    of ArrayType:
      items*: TypeDef
    of UnionType:
      subtypes*: seq[TypeDef]
    of MapType:
      entries*: TypeDef
    of OptionalType:
      subtype*: TypeDef
    of IntegerType, StringType, NumberType, BoolType, NullType, JsonType:
      discard
    of ConstValueType:
      value*: JsonNode

  JsonSchema* = ref object
    rootType*: TypeDef
    defs*: OrderedTable[string, TypeDef]

proc hasRealField*(typ: TypeDef): bool =
  ## Returns whether the given type actually requires a field on internal object
  return
    case typ.kind
    of ConstValueType:
      false
    of OptionalType:
      hasRealField(typ.subtype)
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
  of UnionType:
    result = result !& hash(typ.subtypes)
  of MapType:
    result = result !& hash(typ.entries)
  of OptionalType:
    result = result !& hash(typ.subtype)
  of IntegerType, StringType, NumberType, BoolType, NullType, JsonType:
    discard
  of ConstValueType:
    result = result !& hash(typ.value)

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
  of UnionType:
    return a.subtypes == b.subtypes
  of MapType:
    return a.entries == b.entries
  of OptionalType:
    return a.subtype == b.subtype
  of IntegerType, StringType, NumberType, BoolType, NullType, JsonType, ConstValueType:
    return true

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
  of ConstValueType:
    result = fmt"(Const {typ.value})"

  if not typ.sref.isNil:
    result = fmt"({typ.sref} {result})"

proc optional*(typ: TypeDef): TypeDef =
  return
    case typ.kind
    of OptionalType:
      typ
    of ConstValueType:
      typ
    else:
      TypeDef(kind: OptionalType, subtype: typ)

proc abbrev*(typ: TypeDef): string =
  ## Returns an abbreviated name of a type
  if typ.sref != nil:
    return typ.sref.getName().capitalizeAscii

  return
    case typ.kind
    of ObjType: "Object"
    of EnumType: "Enum"
    of RefType: typ.schemaRef.getName
    of ArrayType: "Seq"
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
    of UnionType:
      var accum: seq[string]
      for subtype in typ.subtypes:
        accum.add(subtype.abbrev)
      yield "Of" & accum.join("And")
    of MapType:
      yield fmt"Of{typ.entries.abbrev}"
    of OptionalType:
      yield fmt"Of{typ.subtype.abbrev}"
    of EnumType, RefType, IntegerType, StringType, NumberType, BoolType, NullType,
        JsonType, ConstValueType:
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
