import std/[sets, tables], schemaRef

type
    TypeDefKind* = enum
        ObjType, RefType, ArrayType, SetType, IntegerType, StringType, NumberType, BoolType, NullType

    TypeDef* = ref object
        id*, title*, description*, comment*: string
        case kind*: TypeDefKind
        of ObjType:
            required*: HashSet[string]
            properties*: Table[string, TypeDef]
        of RefType:
            schemaRef*: SchemaRef
        of ArrayType, SetType:
            items*: TypeDef
        of IntegerType, StringType, NumberType, BoolType, NullType:
            discard

    JsonSchema* = ref object
        rootType*: TypeDef
        defs*: Table[string, TypeDef]
