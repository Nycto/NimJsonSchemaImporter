import std/[sets, tables, strformat, hashes, strutils, uri, paths], schemaRef, namechain

type
    TypeDefKind* = enum
        ObjType,
        RefType,
        ArrayType,
        IntegerType,
        StringType,
        NumberType,
        BoolType,
        NullType,
        EnumType,
        UnionType,
        JsonType,
        MapType,
        OptionalType,

    PropDef* = tuple[propName: string, typ: TypeDef]
        ## The details of an object property

    TypeDef* = ref object
        sref*: SchemaRef
        id*: Uri
        case kind*: TypeDefKind
        of ObjType:
            properties*: Table[string, tuple[propName: string, typ: TypeDef]]
        of EnumType:
            values*: HashSet[string]
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

    JsonSchema* = ref object
        rootType*: TypeDef
        defs*: Table[string, TypeDef]

proc hash*(typ: TypeDef): Hash {.noSideEffect.} =
    result = hash(typ.kind) !& hash(typ.sref)

    case typ.kind:
    of ObjType: result = result !& hash(typ.properties)
    of EnumType: result = result !& hash(typ.values)
    of RefType: result = result !& hash(typ.schemaRef)
    of ArrayType: result = result !& hash(typ.items)
    of UnionType: result = result !& hash(typ.subtypes)
    of MapType: result = result !& hash(typ.entries)
    of OptionalType: result = result !& hash(typ.subtype)
    of IntegerType, StringType, NumberType, BoolType, NullType, JsonType:
        discard

proc `==`*(a, b: TypeDef): bool {.noSideEffect.} =
    if a.kind != b.kind:
        return false

    case a.kind:
    of ObjType: return a.properties == b.properties
    of EnumType: return a.values == b.values
    of RefType: return a.schemaRef == b.schemaRef
    of ArrayType: return a.items == b.items
    of UnionType: return a.subtypes == b.subtypes
    of MapType: return a.entries == b.entries
    of OptionalType: return a.subtype == b.subtype
    of IntegerType, StringType, NumberType, BoolType, NullType, JsonType:
        return true

proc `$`*(typ: TypeDef): string =
    case typ.kind:
    of ObjType: result = fmt"(Obj {typ.properties})"
    of EnumType: result = fmt"(Enum {typ.values})"
    of RefType: result = fmt"(Ref {typ.schemaRef})"
    of ArrayType: result = fmt"(Array {typ.items})"
    of UnionType: result = fmt"(Union {typ.subtypes})"
    of MapType: result = fmt"(Map {typ.entries})"
    of OptionalType: result = fmt"(Optional {typ.subtype})"
    of IntegerType: result = "(Integer)"
    of StringType: result = "(String)"
    of NumberType: result = "(Number)"
    of BoolType: result = "(Bool)"
    of NullType: result = "(Null)"
    of JsonType: result = "(Json)"

    if not typ.sref.isNil:
        result = fmt"({typ.sref} {result})"

proc optional*(typ: TypeDef): TypeDef =
    if typ.kind == OptionalType:
        typ
    else:
        TypeDef(kind: OptionalType, subtype: typ)

proc abbrev*(typ: TypeDef): string =
    ## Returns an abbreviated name of a type
    if typ.sref != nil:
        return typ.sref.getName().capitalizeAscii

    return case typ.kind:
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

iterator nameFragments*(typ: TypeDef): string =
    ## Produces fragments of a descriptive name for a type
    if typ.sref != nil:
        yield typ.sref.getName().capitalizeAscii
    else:
        yield typ.abbrev()

        case typ.kind:
        of ObjType: discard
        of ArrayType: yield fmt"Of{typ.items.abbrev}"
        of UnionType:
            var accum: seq[string]
            for subtype in typ.subtypes:
                accum.add(subtype.abbrev)
            yield "Of" & accum.join("And")
        of MapType: yield fmt"Of{typ.entries.abbrev}"
        of OptionalType: yield fmt"Of{typ.subtype.abbrev}"
        of EnumType, RefType, IntegerType, StringType, NumberType, BoolType, NullType, JsonType:
            discard

proc chooseName*(typ: TypeDef): string =
    for fragment in typ.nameFragments:
        result &= fragment

iterator proposeNames*(typ: TypeDef, prefix: string, name: NameChain): string =
    ## Proposes all possible names for a type
    for name in name.add(typ.sref.getName).nameOptions(prefix):
        yield name

    var base = typ.id.path.Path.extractFilename.string.capitalizeAscii
    if base == "":
        base = "Anon"

    yield prefix & base

    var i = 1
    while true:
        inc i
        yield prefix & base & $i
