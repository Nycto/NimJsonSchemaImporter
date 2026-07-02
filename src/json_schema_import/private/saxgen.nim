import types, util, std/[macros, tables, json, options, streams]

let source {.compileTime.} = ident("source")
let target {.compileTime.} = ident("target")
let toStream {.compileTime.} = ident("toStream")
let hasEmitted {.compileTime.} = ident("hasEmitted")
let key {.compileTime.} = ident("key")

proc writeKeyValue(key: string, readProp: NimNode): NimNode =
  return quote:
    `hasEmitted`.writeComma(`target`)
    write(`target`, escapeJson(`key`))
    write(`target`, ':')
    `toStream`(`readProp`, `target`)

proc buildSaxObjEncoder*(typ: TypeDef, typeName: NimNode): NimNode =
  var encodeKeys = newStmtList()

  for key, (propName, propType, required) in typ.properties:
    let readProp = newDotExpr(source, safePropName(propName))

    if propType.kind in SELF_OPTIONAL:
      let encode = writeKeyValue(key, readProp)
      encodeKeys.add quote do:
        if len(`readProp`) > 0:
          `encode`
    elif required or not propType.hasRealField:
      encodeKeys.add(writeKeyValue(key, readProp))
    else:
      assert(propType.kind == OptionalType)

      let encode = writeKeyValue(key, newCall(bindSym("unsafeGet"), readProp))
      encodeKeys.add quote do:
        if isSome(`readProp`):
          `encode`

  return quote:
    proc toStream*(`source`: `typeName`, `target`: Stream) =
      var `hasEmitted`: bool
      `target`.write('{')
      `encodeKeys`
      `target`.write('}')

proc buildSaxObjDecoder*(typ: TypeDef, typeName: NimNode): NimNode =
  assert(typ.kind == ObjType)

  var cases = nnkCaseStmt.newTree(key)

  for jsonKey, (propName, subtype, required) in typ.properties:
    if not subtype.hasRealField:
      continue

    let safeKey = safePropName(propName)
    let decode =
      if subtype.kind in SELF_OPTIONAL or required:
        quote do:
          result.`safeKey` = fromStream(typeof(result.`safeKey`), `source`)
      else:
        assert(subtype.kind == OptionalType)
        quote do:
          result.`safeKey` = some(fromStream(typeof(unsafeGet(result.`safeKey`)), `source`))

    cases.add(nnkOfBranch.newTree(newLit(jsonKey), decode))

  cases.add(nnkElse.newTree(quote do: skipValue(`source`)))

  return quote:
    proc fromStream*(typ: typedesc[`typeName`], `source`: var JsonParser): `typeName` =
      eat(`source`, tkCurlyLe)
      while `source`.tok != tkCurlyRi:
        if `source`.tok != tkString:
          raiseParseErr(`source`, "string")
        let `key` = `source`.a
        discard getTok(`source`)
        eat(`source`, tkColon)
        `cases`
        if `source`.tok == tkComma:
          discard getTok(`source`)
        else:
          break
      eat(`source`, tkCurlyRi)

proc buildSaxUnionEncoder*(typ: TypeDef, typeName: NimNode): NimNode =
  ## Builds the `toJsonHook` function for encoding a union
  assert(typ.kind == UnionType)

  return quote:
    proc toStream*(`source`: `typeName`, `target`: Stream) =
      discard
