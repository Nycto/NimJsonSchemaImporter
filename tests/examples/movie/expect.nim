{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  MovieGenre* = enum
    Action, Comedy, Drama, `Science Fiction`
  Moviemovie* = object
    title*: string
    director*: string
    releaseDate*: string
    genre*: Option[MovieGenre]
    duration*: Option[string]
    `cast`*: Option[seq[string]]
proc toJsonHook*(source: MovieGenre): JsonNode
proc toJsonHook*(source: Moviemovie): JsonNode
proc toJsonHook*(source: MovieGenre): JsonNode =
  case source
  of MovieGenre.Action:
    return newJString("Action")
  of MovieGenre.Comedy:
    return newJString("Comedy")
  of MovieGenre.Drama:
    return newJString("Drama")
  of MovieGenre.`Science Fiction`:
    return newJString("Science Fiction")
  
proc fromJsonHook*(target: var MovieGenre; source: JsonNode) =
  target = case getStr(source)
  of "Action":
    MovieGenre.Action
  of "Comedy":
    MovieGenre.Comedy
  of "Drama":
    MovieGenre.Drama
  of "Science Fiction":
    MovieGenre.`Science Fiction`
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc equals(_: typedesc[Moviemovie]; a, b: Moviemovie): bool =
  equals(typeof(a.title), a.title, b.title) and
      equals(typeof(a.director), a.director, b.director) and
      equals(typeof(a.releaseDate), a.releaseDate, b.releaseDate) and
      equals(typeof(a.genre), a.genre, b.genre) and
      equals(typeof(a.duration), a.duration, b.duration) and
      equals(typeof(a.`cast`), a.`cast`, b.`cast`)

proc `==`*(a, b: Moviemovie): bool =
  return equals(Moviemovie, a, b)

proc stringify(_: typedesc[Moviemovie]; value: Moviemovie): string =
  stringifyObj("Moviemovie",
               ("title", stringify(typeof(value.title), value.title)), (
      "director", stringify(typeof(value.director), value.director)), (
      "releaseDate", stringify(typeof(value.releaseDate), value.releaseDate)),
               ("genre", stringify(typeof(value.genre), value.genre)), (
      "duration", stringify(typeof(value.duration), value.duration)),
               ("cast", stringify(typeof(value.`cast`), value.`cast`)))

proc `$`*(value: Moviemovie): string =
  stringify(Moviemovie, value)

proc fromJsonHook*(target: var Moviemovie; source: JsonNode) =
  assert(hasKey(source, "title"),
         "title" & " is missing while decoding " & "Moviemovie")
  target.title = jsonTo(source{"title"}, typeof(target.title))
  assert(hasKey(source, "director"),
         "director" & " is missing while decoding " & "Moviemovie")
  target.director = jsonTo(source{"director"}, typeof(target.director))
  assert(hasKey(source, "releaseDate"),
         "releaseDate" & " is missing while decoding " & "Moviemovie")
  target.releaseDate = jsonTo(source{"releaseDate"}, typeof(target.releaseDate))
  if hasKey(source, "genre") and source{"genre"}.kind != JNull:
    target.genre = some(jsonTo(source{"genre"}, typeof(unsafeGet(target.genre))))
  if hasKey(source, "duration") and source{"duration"}.kind != JNull:
    target.duration = some(jsonTo(source{"duration"},
                                  typeof(unsafeGet(target.duration))))
  if hasKey(source, "cast") and source{"cast"}.kind != JNull:
    target.`cast` = some(jsonTo(source{"cast"}, typeof(unsafeGet(target.`cast`))))

proc toJsonHook*(source: Moviemovie): JsonNode =
  result = newJObject()
  result{"title"} = newJString(source.title)
  result{"director"} = newJString(source.director)
  result{"releaseDate"} = newJString(source.releaseDate)
  if isSome(source.genre):
    result{"genre"} = toJsonHook(unsafeGet(source.genre))
  if isSome(source.duration):
    result{"duration"} = newJString(unsafeGet(source.duration))
  if isSome(source.`cast`):
    result{"cast"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.`cast`):
        output.add(newJString(entry))
      output

proc toBinary*(target: var string; source: Moviemovie) =
  toBinary(target, source.title)
  toBinary(target, source.director)
  toBinary(target, source.releaseDate)
  toBinary(target, source.genre)
  toBinary(target, source.duration)
  toBinary(target, source.`cast`)

proc toBinary*(source: Moviemovie): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[Moviemovie]; source: string; idx: var int): Moviemovie =
  result.title = fromBinary(typeof(result.title), source, idx)
  result.director = fromBinary(typeof(result.director), source, idx)
  result.releaseDate = fromBinary(typeof(result.releaseDate), source, idx)
  result.genre = fromBinary(typeof(result.genre), source, idx)
  result.duration = fromBinary(typeof(result.duration), source, idx)
  result.`cast` = fromBinary(typeof(result.`cast`), source, idx)

proc fromBinary*(_: typedesc[Moviemovie]; source: string): Moviemovie =
  var idx = 0
  return fromBinary(Moviemovie, source, idx)
{.pop.}
