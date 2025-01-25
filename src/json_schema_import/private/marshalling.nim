import std/[macros, tables, sets, json, jsonutils, options]
import types, util

proc isJsonKind(value: NimNode, kind: JsonNodeKind): NimNode =
    return quote:
        `value`.kind == `kind`

proc hasAllProps(base, value: NimNode, typ: TypeDef): NimNode =
    result = base
    for key, (_, _, required) in typ.properties:
        if required:
            result = infix(base, "and", newCall(bindSym("hasKey"), value, key.newLit))

proc createEncodeExpr(input: NimNode, typ: TypeDef): NimNode =
    ## Creates an expression that knows how to json encode a type
    case typ.kind
    of ArrayType:
        let entry = genSym(nskForVar, "entry`gensym")
        let encodeItem = entry.createEncodeExpr(typ.items)
        return quote:
            block:
                var output = newJArray()
                for `entry` in `input`:
                    output.add(`encodeItem`)
                output
    of MapType:
        let entry = genSym(nskForVar, "entry`gensym")
        let encodeEntry = entry.createEncodeExpr(typ.entries)
        return quote:
            block:
                var output = newJObject()
                for key, `entry` in pairs(`input`):
                    output[key] = `encodeEntry`
                output
    of OptionalType:
        let encodeValue = newCall(bindSym("unsafeGet"), `input`).createEncodeExpr(typ.subtype)
        return quote:
            if isSome(`input`): `encodeValue` else: newJNull()
    of StringType:
        return newCall(bindSym("newJString"), input)
    of IntegerType:
        return newCall(bindSym("newJInt"), input)
    of NumberType:
        return newCall(bindSym("newJFloat"), input)
    of BoolType:
        return newCall(bindSym("newJBool"), input)
    of ObjType, EnumType, UnionType:
        return newCall(ident("toJsonHook"), input)
    of NullType, RefType:
        return newCall(bindSym("newJNull"))
    of JsonType:
        return input

proc buildIsType(typ: TypeDef, value: NimNode): NimNode =
    case typ.kind
    of StringType, EnumType: return value.isJsonKind(JString)
    of IntegerType: return value.isJsonKind(JInt)
    of ObjType: return value.isJsonKind(JObject).hasAllProps(value, typ)
    of MapType: return value.isJsonKind(JObject)
    of ArrayType: return value.isJsonKind(JArray)
    of BoolType: return value.isJsonKind(JBool)
    of NullType: return value.isJsonKind(JNull)
    of NumberType: return infix(value.isJsonKind(JFloat), "or", value.isJsonKind(JInt))
    of JsonType: return true.newLit
    of OptionalType: return typ.subtype.buildIsType(value)
    of UnionType: raiseAssert("Unions should not contain other unions")
    of RefType: raiseAssert("Unions are not supported in ref types")

let source {.compileTime.} = ident("source")
let target {.compileTime.} = ident("target")

proc buildUnionDecoder*(typ: TypeDef, typeName: NimNode): NimNode =
    ## Builds the `fromJsonHook` function for decoding a union type down to the union object
    assert(typ.kind == UnionType)

    var branches = nnkIfStmt.newTree()

    for i, subtype in typ.subtypes:
        let key = i.unionKey
        let builder = quote:
            `target` = `typeName`(kind: `i`, `key`: jsonTo(`source`, typeof(`target`.`key`)))
        branches.add(nnkElifBranch.newTree(buildIsType(subtype, source), builder))

    let errorMessage = newLit("Unable to deserialize json node to " & typeName.getName)
    let throw = quote:
        raise newException(ValueError, `errorMessage`)

    branches.add(nnkElse.newTree(throw))

    return quote:
        proc fromJsonHook*(`target`: var `typeName`; `source`: JsonNode) =
            `branches`

proc buildUnionEncoder*(typ: TypeDef, typeName: NimNode): NimNode =
    ## Builds the `toJsonHook` function for encoding a union
    assert(typ.kind == UnionType)

    var cases = nnkCaseStmt.newTree(newDotExpr(source, ident("kind")))

    for i, subtype in typ.subtypes:
        let key = i.unionKey
        cases.add(nnkOfBranch.newTree(i.newLit, newDotExpr(source, key).createEncodeExpr(subtype)))

    return quote:
        proc toJsonHook*(`source`: `typeName`): JsonNode =
            `cases`

proc buildEnumEncoder*(typ: TypeDef, typeName: NimNode): NimNode =
    assert(typ.kind == EnumType)

    var cases = nnkCaseStmt.newTree(source)
    for value in typ.values:
        cases.add(
            nnkOfBranch.newTree(
                newDotExpr(typeName, safeTypeName(value)),
                nnkReturnStmt.newTree(newCall(bindSym("newJString"), value.newLit))
            )
        )

    return quote:
        proc toJsonHook*(`source`: `typeName`): JsonNode =
            `cases`

proc buildEnumDecoder*(typ: TypeDef, typeName: NimNode): NimNode =
    assert(typ.kind == EnumType)

    var cases = nnkCaseStmt.newTree(newCall(bindSym("getStr"), source))
    for value in typ.values:
        cases.add(nnkOfBranch.newTree(value.newLit, newDotExpr(typeName, safeTypeName(value))))

    cases.add nnkElse.newTree quote do:
        raise newException(ValueError, "Unable to decode enum: " & $`source`)

    return quote:
        proc fromJsonHook*(`target`: var `typeName`; `source`: JsonNode) =
            `target` = `cases`

proc buildObjectDecoder*(typ: TypeDef, typeName: NimNode): NimNode =
    var decodeKeys = newStmtList()

    let typeNameStr = typeName.getName.newLit

    for key, (propName, subtype, required) in typ.properties:
        let safeKey = safePropName(propName)
        if required:
            decodeKeys.add quote do:
                assert(hasKey(`source`, `key`), `key` & " is missing while decoding " & `typeNameStr`)
                `target`.`safeKey` = jsonTo(`source`{`key`}, typeof(`target`.`safeKey`))
        else:
            decodeKeys.add quote do:
                if hasKey(`source`, `key`) and `source`{`key`}.kind != JNull:
                    `target`.`safeKey` = some(jsonTo(`source`{`key`}, typeof(unsafeGet(`target`.`safeKey`))))

    return quote:
        proc fromJsonHook*(`target`: var `typeName`; `source`: JsonNode) =
            `decodeKeys`

proc buildObjectEncoder*(typ: TypeDef, typeName: NimNode): NimNode =
    var encodeKeys = newStmtList()

    for key, (propName, propType, required) in typ.properties:
        let readProp = newDotExpr(source, safePropName(propName))
        if required:
            let encode = readProp.createEncodeExpr(propType)
            encodeKeys.add quote do:
                result{`key`} = `encode`
        else:
            assert(propType.kind == OptionalType)

            let encode = newCall(bindSym("unsafeGet"), readProp).createEncodeExpr(propType.subtype)
            encodeKeys.add quote do:
                if isSome(`readProp`):
                    result{`key`} = `encode`

    return quote:
        proc toJsonHook*(`source`: `typeName`): JsonNode =
            result = newJObject()
            `encodeKeys`
