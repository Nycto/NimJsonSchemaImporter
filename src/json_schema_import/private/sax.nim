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

proc toStream*(source: string, target: Stream) =
  target.write(source.escapeJson)

proc toStream*[T](source: seq[T], target: Stream) =
  var hasEmitted: bool
  target.write('[')
  for item in source:
    hasEmitted.writeComma(target)
    toStream(item, target)
  target.write(']')

proc writeComma*(hasEmitted: var bool, target: Stream) =
  if hasEmitted:
    target.write(',')
  else:
    hasEmitted = true

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
  if source.tok != tkString:
    raiseParseErr(source, "string")
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
