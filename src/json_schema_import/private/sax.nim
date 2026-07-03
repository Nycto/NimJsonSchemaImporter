##
## Writes JSON using a callback
##
##

import std/[streams, parsejson, tables, macros, sets, json, options, hashes, strutils]

export parsejson, streams

type SomeTable[K, V] = Table[K, V] | OrderedTable[K, V]
  ## A type alias for tables, supporting both `Table` and `OrderedTable`.

proc toStream*(source: SomeNumber, target: Stream) =
  target.write($source)

proc toStream*(source: bool, target: Stream) =
  target.write(if source: "true" else: "false")

proc toStream*[T](source: Option[T], target: Stream) =
  if source.isSome:
    toStream(source.unsafeGet, target)
  else:
    target.write("null")

proc toStream*(source: string, target: Stream) =
  target.write(source.escapeJson)

proc toStream*[T](source: seq[T], target: Stream) =
  var hasEmitted: bool
  target.write('[')
  for item in source:
    hasEmitted.writeComma(target)
    toStream(item, target)
  target.write(']')

proc toStream*[V](source: OrderedTable[string, V], target: Stream) =
  var hasEmitted: bool
  target.write('{')
  for key in source.keys:
    hasEmitted.writeComma(target)
    toStream(key, target)
    target.write(':')
    toStream(source[key], target)
  target.write('}')

proc toStream*(source: JsonNode, target: Stream) =
  target.write($source)

proc toStream*[T: enum](source: T, target: Stream) =
  ## Generated enum fields carry the schema's original string as their enum
  ## field value (see `genEnum`), so `$source` is already the JSON string.
  toStream($source, target)

proc writeComma*(hasEmitted: var bool, target: Stream) =
  if hasEmitted:
    target.write(',')
  else:
    hasEmitted = true

proc expectString*(source: var JsonParser) =
  if source.tok != tkString:
    raiseParseErr(source, "string")

proc skipValue*(source: var JsonParser) =
  ## Consumes and discards one JSON value, recursing into objects/arrays, so
  ## that unrecognized keys don't desync the token stream.
  case source.tok
  of tkString, tkInt, tkFloat, tkTrue, tkFalse, tkNull:
    discard getTok(source)
  of tkCurlyLe:
    discard getTok(source)
    while source.tok != tkCurlyRi:
      discard getTok(source) # skip key
      eat(source, tkColon)
      skipValue(source)
      if source.tok == tkComma:
        discard getTok(source)
      else:
        break
    eat(source, tkCurlyRi)
  of tkBracketLe:
    discard getTok(source)
    while source.tok != tkBracketRi:
      skipValue(source)
      if source.tok == tkComma:
        discard getTok(source)
      else:
        break
    eat(source, tkBracketRi)
  else:
    raiseParseErr(source, "value")

proc fromStream*(typ: typedesc[string], source: var JsonParser): string =
  expectString(source)
  result = source.a
  discard getTok(source)

proc fromStream*[T: SomeNumber](typ: typedesc[T], source: var JsonParser): T =
  case source.tok
  of tkInt:
    result = T(parseBiggestInt(source.a))
  of tkFloat:
    result = T(parseFloat(source.a))
  else:
    raiseParseErr(source, "number")
  discard getTok(source)

proc fromStream*(typ: typedesc[bool], source: var JsonParser): bool =
  case source.tok
  of tkTrue:
    result = true
  of tkFalse:
    result = false
  else:
    raiseParseErr(source, "bool")
  discard getTok(source)

proc fromStream*[T](typ: typedesc[Option[T]], source: var JsonParser): Option[T] =
  if source.tok == tkNull:
    discard getTok(source)
  else:
    result = some(fromStream(T, source))

proc fromStream*[T](typ: typedesc[seq[T]], source: var JsonParser): seq[T] =
  eat(source, tkBracketLe)
  while source.tok != tkBracketRi:
    result.add(fromStream(T, source))
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkBracketRi)

proc fromStream*[V](
    typ: typedesc[OrderedTable[string, V]], source: var JsonParser
): OrderedTable[string, V] =
  eat(source, tkCurlyLe)
  while source.tok != tkCurlyRi:
    expectString(source)
    let key = source.a
    discard getTok(source)
    eat(source, tkColon)
    result[key] = fromStream(V, source)
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkCurlyRi)

proc fromStream*(typ: typedesc[JsonNode], source: var JsonParser): JsonNode =
  ## Parses an arbitrary JSON value into a JsonNode tree, for schemas that
  ## don't pin down a concrete type (e.g. mixed-type `enum`s).
  case source.tok
  of tkString:
    result = newJString(source.a)
    discard getTok(source)
  of tkInt:
    result = newJInt(parseBiggestInt(source.a))
    discard getTok(source)
  of tkFloat:
    result = newJFloat(parseFloat(source.a))
    discard getTok(source)
  of tkTrue:
    result = newJBool(true)
    discard getTok(source)
  of tkFalse:
    result = newJBool(false)
    discard getTok(source)
  of tkNull:
    result = newJNull()
    discard getTok(source)
  of tkCurlyLe:
    result = newJObject()
    discard getTok(source)
    while source.tok != tkCurlyRi:
      expectString(source)
      let key = source.a
      discard getTok(source)
      eat(source, tkColon)
      result[key] = fromStream(JsonNode, source)
      if source.tok == tkComma:
        discard getTok(source)
      else:
        break
    eat(source, tkCurlyRi)
  of tkBracketLe:
    result = newJArray()
    discard getTok(source)
    while source.tok != tkBracketRi:
      result.add(fromStream(JsonNode, source))
      if source.tok == tkComma:
        discard getTok(source)
      else:
        break
    eat(source, tkBracketRi)
  else:
    raiseParseErr(source, "value")

proc fromStream*[T: enum](typ: typedesc[T], source: var JsonParser): T =
  expectString(source)
  result = parseEnum[T](source.a)
  discard getTok(source)

proc fromStream*(typ: typedesc, source: Stream, filename: string): typ =
  ## Reads a JSON file to the given type
  mixin fromStream
  source.setPosition(0)
  var parser: JsonParser
  parser.open(source, filename)
  try:
    discard getTok(parser) # prime the first token
    result = fromStream(typ, parser)
  finally:
    parser.close()
