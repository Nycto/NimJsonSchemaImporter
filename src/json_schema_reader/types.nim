import std/[sets, tables], schemaRef

type
    TypeDefKind* = enum
        ObjType,
        RefType,
        ArrayType,
        SetType,
        IntegerType,
        StringType,
        NumberType,
        BoolType,
        NullType,
        EnumType,
        UnionType,
        JsonType,
        MapType,

    TypeDef* = ref object
        id*, title*, description*, comment*: string
        case kind*: TypeDefKind
        of ObjType:
            properties*: Table[string, TypeDef]
        of EnumType:
            values*: HashSet[string]
        of RefType:
            schemaRef*: SchemaRef
        of ArrayType, SetType:
            items*: TypeDef
        of UnionType:
            subtypes*: seq[TypeDef]
        of MapType:
            entries*: TypeDef
        of IntegerType, StringType, NumberType, BoolType, NullType, JsonType:
            discard

    JsonSchema* = ref object
        rootType*: TypeDef
        defs*: Table[string, TypeDef]
