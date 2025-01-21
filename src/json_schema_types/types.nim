import std/[sets, tables, strformat], schemaRef

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
        id*, title*, description*, comment*: string
        sref*: SchemaRef
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