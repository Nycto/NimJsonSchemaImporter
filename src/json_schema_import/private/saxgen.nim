import types, util, std/[macros, tables, json, options, streams]

let source {.compileTime.} = ident("source")
let target {.compileTime.} = ident("target")
let toStream {.compileTime.} = ident("toStream")
let hasEmitted {.compileTime.} = ident("hasEmitted")
let key {.compileTime.} = ident("key")
let seen {.compileTime.} = ident("seen")

proc writeKeyValue(key: string, readProp: NimNode): NimNode =
  return quote:
    `hasEmitted`.writeComma(`target`)
    write(`target`, escapeJson(`key`))
    write(`target`, ':')
    `toStream`(`readProp`, `target`)

proc writeConstKeyValue(key: string, value: JsonNode): NimNode =
  ## Writes a `const` property's fixed value, computed once at macro
  ## expansion time since it never varies at runtime.
  let jsonText = $value
  return quote:
    `hasEmitted`.writeComma(`target`)
    write(`target`, escapeJson(`key`))
    write(`target`, ':')
    write(`target`, `jsonText`)

proc buildSaxObjEncoder*(typ: TypeDef, typeName: NimNode): NimNode =
  var encodeKeys = newStmtList()

  for key, (propName, propType, required) in typ.properties:
    let readProp = newDotExpr(source, safePropName(propName))

    if propType.kind == ConstValueType:
      encodeKeys.add(writeConstKeyValue(key, propType.value))
    elif propType.kind in SELF_OPTIONAL:
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
  var requiredCount = 0

  for jsonKey, (propName, subtype, required) in typ.properties:
    if not subtype.hasRealField:
      continue

    let safeKey = safePropName(propName)

    if subtype.kind in SELF_OPTIONAL or required:
      let decode = quote:
        result.`safeKey` = fromStream(typeof(result.`safeKey`), `source`)

      if subtype.kind in SELF_OPTIONAL:
        cases.add(nnkOfBranch.newTree(newLit(jsonKey), decode))
      else:
        let index = requiredCount.newLit
        inc requiredCount
        cases.add(
          nnkOfBranch.newTree(
            newLit(jsonKey),
            quote do:
              `decode`
              `seen`.incl(`index`)
          )
        )
    else:
      assert(subtype.kind == OptionalType)
      let decode = quote:
        result.`safeKey` =
          some(fromStream(typeof(unsafeGet(result.`safeKey`)), `source`))

      cases.add(nnkOfBranch.newTree(newLit(jsonKey), decode))

  cases.add(
    nnkElse.newTree(
      quote do:
        skipValue(`source`)
    )
  )

  var seenDecl = newStmtList()
  var seenAssert = newStmtList()

  if requiredCount > 0:
    let maxIndex = (requiredCount - 1).newLit
    seenDecl.add quote do:
      var `seen`: set[0 .. `maxIndex`]
    seenAssert.add quote do:
      assert(`seen` == {0 .. `maxIndex`})

  return quote:
    proc fromStream*(typ: typedesc[`typeName`], `source`: var JsonParser): `typeName` =
      `seenDecl`
      eat(`source`, tkCurlyLe)
      while `source`.tok != tkCurlyRi:
        expectString(`source`)
        let `key` = `source`.a
        discard getTok(`source`)
        eat(`source`, tkColon)
        `cases`
        if `source`.tok == tkComma:
          discard getTok(`source`)
        else:
          break
      eat(`source`, tkCurlyRi)
      `seenAssert`

proc buildSaxUnionEncoder*(typ: TypeDef, typeName: NimNode): NimNode =
  ## Builds the `toStream` proc for encoding a union
  assert(typ.kind == UnionType)

  var cases = nnkCaseStmt.newTree(newDotExpr(source, ident("kind")))

  for i, subtype in typ.subtypes:
    let key = i.unionKey
    cases.add(
      nnkOfBranch.newTree(i.newLit, newCall(toStream, newDotExpr(source, key), target))
    )

  return quote:
    proc toStream*(`source`: `typeName`, `target`: Stream) =
      `cases`

proc buildSaxUnionDecoder*(typ: TypeDef, typeName: NimNode): NimNode =
  ## Builds the `fromStream` proc for decoding a union type. Rather than
  ## re-implementing the union's type-disambiguation logic (which can
  ## require arbitrary lookahead, e.g. checking which required properties
  ## an object has) against the raw token stream, it buffers the value as a
  ## `JsonNode` and delegates to the existing `fromJsonHook`-based union
  ## decoder via `jsonTo`.
  assert(typ.kind == UnionType)

  return quote:
    proc fromStream*(typ: typedesc[`typeName`], `source`: var JsonParser): `typeName` =
      jsonTo(fromStream(JsonNode, `source`), `typeName`)
