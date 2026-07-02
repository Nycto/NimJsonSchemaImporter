{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin, sax]

type
  MovieGenre* = enum
    Action = "Action", Comedy = "Comedy", Drama = "Drama",
    `Science Fiction` = "Science Fiction"
  Movie* {.byref.} = object
    title*: string
    director*: string
    releaseDate*: string
    genre*: Option[MovieGenre]
    duration*: Option[string]
    `cast`*: seq[string]
proc `=copy`(a: var Movie; b: Movie) {.error.}
proc toJsonHook*(source: Movie): JsonNode
proc equals(_: typedesc[Movie]; a, b: Movie): bool =
  equals(typeof(a.title), a.title, b.title) and
      equals(typeof(a.director), a.director, b.director) and
      equals(typeof(a.releaseDate), a.releaseDate, b.releaseDate) and
      equals(typeof(a.genre), a.genre, b.genre) and
      equals(typeof(a.duration), a.duration, b.duration) and
      equals(typeof(a.`cast`), a.`cast`, b.`cast`)

proc `==`*(a, b: Movie): bool =
  return equals(Movie, a, b)

proc stringify(_: typedesc[Movie]; value: Movie): string =
  stringifyObj("Movie", ("title", stringify(typeof(value.title), value.title)), (
      "director", stringify(typeof(value.director), value.director)), (
      "releaseDate", stringify(typeof(value.releaseDate), value.releaseDate)),
               ("genre", stringify(typeof(value.genre), value.genre)), (
      "duration", stringify(typeof(value.duration), value.duration)),
               ("cast", stringify(typeof(value.`cast`), value.`cast`)))

proc `$`*(value: Movie): string =
  stringify(Movie, value)

proc fromJsonHook*(target: var Movie; source: JsonNode) =
  assert(hasKey(source, "title"),
         "title" & " is missing while decoding " & "Movie")
  target.title = jsonTo(source{"title"}, typeof(target.title))
  assert(hasKey(source, "director"),
         "director" & " is missing while decoding " & "Movie")
  target.director = jsonTo(source{"director"}, typeof(target.director))
  assert(hasKey(source, "releaseDate"),
         "releaseDate" & " is missing while decoding " & "Movie")
  target.releaseDate = jsonTo(source{"releaseDate"}, typeof(target.releaseDate))
  if hasKey(source, "genre") and source{"genre"}.kind != JNull:
    target.genre = some(jsonTo(source{"genre"}, typeof(unsafeGet(target.genre))))
  if hasKey(source, "duration") and source{"duration"}.kind != JNull:
    target.duration = some(jsonTo(source{"duration"},
                                  typeof(unsafeGet(target.duration))))
  if hasKey(source, "cast") and source{"cast"}.kind != JNull:
    target.`cast` = jsonTo(source{"cast"}, typeof(target.`cast`))

proc toJsonHook*(source: Movie): JsonNode =
  result = newJObject()
  result{"title"} = newJString(source.title)
  result{"director"} = newJString(source.director)
  result{"releaseDate"} = newJString(source.releaseDate)
  if isSome(source.genre):
    result{"genre"} = `%`(unsafeGet(source.genre))
  if isSome(source.duration):
    result{"duration"} = newJString(unsafeGet(source.duration))
  if len(source.`cast`) > 0:
    result{"cast"} = block:
      let cursor {.cursor.} = source.`cast`
      var output = newJArray()
      for entry in cursor:
        output.add(newJString(entry))
      output

proc toStream*(source: Movie; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("title"))
  write(target, ':')
  toStream(source.title, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("director"))
  write(target, ':')
  toStream(source.director, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("releaseDate"))
  write(target, ':')
  toStream(source.releaseDate, target)
  if isSome(source.genre):
    hasEmitted.writeComma(target)
    write(target, escapeJson("genre"))
    write(target, ':')
    toStream(unsafeGet(source.genre), target)
  if isSome(source.duration):
    hasEmitted.writeComma(target)
    write(target, escapeJson("duration"))
    write(target, ':')
    toStream(unsafeGet(source.duration), target)
  if len(source.`cast`) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("cast"))
    write(target, ':')
    toStream(source.`cast`, target)
  target.write('}')

proc fromStream*(typ: typedesc[Movie]; source: var JsonParser): Movie =
  eat(source, tkCurlyLe)
  while source.tok != tkCurlyRi:
    if source.tok != tkString:
      raiseParseErr(source, "string")
    let key = source.a
    discard getTok(source)
    eat(source, tkColon)
    case key
    of "title":
      result.title = fromStream(typeof(result.title), source)
    of "director":
      result.director = fromStream(typeof(result.director), source)
    of "releaseDate":
      result.releaseDate = fromStream(typeof(result.releaseDate), source)
    of "genre":
      result.genre = some(fromStream(typeof(unsafeGet(result.genre)), source))
    of "duration":
      result.duration = some(fromStream(typeof(unsafeGet(result.duration)),
                                        source))
    of "cast":
      result.`cast` = fromStream(typeof(result.`cast`), source)
    else:
      skipValue(source)
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkCurlyRi)
{.pop.}
