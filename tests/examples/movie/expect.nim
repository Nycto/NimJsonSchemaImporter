{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify

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
  
proc `==`*(a, b: Moviemovie): bool =
  true and a.title == b.title and a.director == b.director and
      a.releaseDate == b.releaseDate and
      a.genre == b.genre and
      a.duration == b.duration and
      a.`cast` == b.`cast`

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
{.pop.}
