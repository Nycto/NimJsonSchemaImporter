{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  MovieGenre* = enum
    Comedy, `Science Fiction`, Action, Drama
  Moviemovie* = object
    duration*: Option[string]
    releaseDate*: string
    genre*: Option[MovieGenre]
    title*: string
    `cast`*: Option[seq[string]]
    director*: string
proc toJsonHook*(source: MovieGenre): JsonNode
proc toJsonHook*(source: Moviemovie): JsonNode
proc toJsonHook*(source: MovieGenre): JsonNode =
  case source
  of MovieGenre.Comedy:
    return newJString("Comedy")
  of MovieGenre.`Science Fiction`:
    return newJString("Science Fiction")
  of MovieGenre.Action:
    return newJString("Action")
  of MovieGenre.Drama:
    return newJString("Drama")
  
proc fromJsonHook*(target: var MovieGenre; source: JsonNode) =
  target = case getStr(source)
  of "Comedy":
    MovieGenre.Comedy
  of "Science Fiction":
    MovieGenre.`Science Fiction`
  of "Action":
    MovieGenre.Action
  of "Drama":
    MovieGenre.Drama
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var Moviemovie; source: JsonNode) =
  if hasKey(source, "duration") and source{"duration"}.kind != JNull:
    target.duration = some(jsonTo(source{"duration"},
                                  typeof(unsafeGet(target.duration))))
  assert(hasKey(source, "releaseDate"),
         "releaseDate" & " is missing while decoding " & "Moviemovie")
  target.releaseDate = jsonTo(source{"releaseDate"}, typeof(target.releaseDate))
  if hasKey(source, "genre") and source{"genre"}.kind != JNull:
    target.genre = some(jsonTo(source{"genre"}, typeof(unsafeGet(target.genre))))
  assert(hasKey(source, "title"),
         "title" & " is missing while decoding " & "Moviemovie")
  target.title = jsonTo(source{"title"}, typeof(target.title))
  if hasKey(source, "cast") and source{"cast"}.kind != JNull:
    target.`cast` = some(jsonTo(source{"cast"}, typeof(unsafeGet(target.`cast`))))
  assert(hasKey(source, "director"),
         "director" & " is missing while decoding " & "Moviemovie")
  target.director = jsonTo(source{"director"}, typeof(target.director))

proc toJsonHook*(source: Moviemovie): JsonNode =
  result = newJObject()
  if isSome(source.duration):
    result{"duration"} = newJString(unsafeGet(source.duration))
  result{"releaseDate"} = newJString(source.releaseDate)
  if isSome(source.genre):
    result{"genre"} = toJsonHook(unsafeGet(source.genre))
  result{"title"} = newJString(source.title)
  if isSome(source.`cast`):
    result{"cast"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.`cast`):
        output.add(newJString(entry))
      output
  result{"director"} = newJString(source.director)
{.pop.}
