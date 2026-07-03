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

proc consumeText*(source: var JsonParser): string =
  ## Returns the current token's text, then advances past it.
  result = source.a
  discard getTok(source)

iterator delimited*(source: var JsonParser, openTok, closeTok: TokKind): int =
  ## Iterates a comma-delimited list bracketed by `openTok`/`closeTok` (e.g.
  ## `[...]` or `{...}`), yielding the (0-based) index of each element.
  ## Eats `openTok` before the loop and `closeTok` once it ends, so the
  ## body only needs to consume one element per iteration.
  eat(source, openTok)
  var i = 0
  while source.tok != closeTok:
    yield i
    inc i
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, closeTok)

iterator objectKeys*(source: var JsonParser): string =
  ## Iterates the string keys of a JSON object, leaving `source` positioned
  ## right after the `:` so the caller can parse the value.
  for _ in delimited(source, tkCurlyLe, tkCurlyRi):
    expectString(source)
    let key = consumeText(source)
    eat(source, tkColon)
    yield key

proc skipValue*(source: var JsonParser) =
  ## Consumes and discards one JSON value, recursing into objects/arrays, so
  ## that unrecognized keys don't desync the token stream.
  case source.tok
  of tkString, tkInt, tkFloat, tkTrue, tkFalse, tkNull:
    discard getTok(source)
  of tkCurlyLe:
    for _ in delimited(source, tkCurlyLe, tkCurlyRi):
      discard getTok(source) # skip key
      eat(source, tkColon)
      skipValue(source)
  of tkBracketLe:
    for _ in delimited(source, tkBracketLe, tkBracketRi):
      skipValue(source)
  else:
    raiseParseErr(source, "value")

proc fromStream*(typ: typedesc[string], source: var JsonParser): string =
  expectString(source)
  return consumeText(source)

proc fromStream*[T: SomeNumber](typ: typedesc[T], source: var JsonParser): T =
  case source.tok
  of tkInt:
    return T(parseBiggestInt(consumeText(source)))
  of tkFloat:
    return T(parseFloat(consumeText(source)))
  else:
    raiseParseErr(source, "number")

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
  for _ in delimited(source, tkBracketLe, tkBracketRi):
    result.add(fromStream(T, source))

proc fromStream*[V](
    typ: typedesc[OrderedTable[string, V]], source: var JsonParser
): OrderedTable[string, V] =
  for key in objectKeys(source):
    result[key] = fromStream(V, source)

proc fromStream*(typ: typedesc[JsonNode], source: var JsonParser): JsonNode =
  ## Parses an arbitrary JSON value into a JsonNode tree, for schemas that
  ## don't pin down a concrete type (e.g. mixed-type `enum`s).
  case source.tok
  of tkString:
    return newJString(consumeText(source))
  of tkInt:
    return newJInt(parseBiggestInt(consumeText(source)))
  of tkFloat:
    return newJFloat(parseFloat(consumeText(source)))
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
    for key in objectKeys(source):
      result[key] = fromStream(JsonNode, source)
  of tkBracketLe:
    result = newJArray()
    for _ in delimited(source, tkBracketLe, tkBracketRi):
      result.add(fromStream(JsonNode, source))
  else:
    raiseParseErr(source, "value")

proc fromStream*[T: enum](typ: typedesc[T], source: var JsonParser): T =
  expectString(source)
  return parseEnum[T](consumeText(source))

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
