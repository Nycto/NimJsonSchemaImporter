{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  TestTestmovie_genre* = enum
    Comedy, `Science Fiction`, Action, Drama
  Testmovie* = object
    duration*: Option[string]
    releaseDate*: string
    genre*: Option[TestTestmovie_genre]
    title*: string
    `cast`*: Option[seq[string]]
    director*: string
proc toJsonHook*(source: TestTestmovie_genre): JsonNode =
  case source
  of TestTestmovie_genre.Comedy:
    return newJString("Comedy")
  of TestTestmovie_genre.`Science Fiction`:
    return newJString("Science Fiction")
  of TestTestmovie_genre.Action:
    return newJString("Action")
  of TestTestmovie_genre.Drama:
    return newJString("Drama")
  
proc fromJsonHook*(target: var TestTestmovie_genre; source: JsonNode) =
  target = case getStr(source)
  of "Comedy":
    TestTestmovie_genre.Comedy
  of "Science Fiction":
    TestTestmovie_genre.`Science Fiction`
  of "Action":
    TestTestmovie_genre.Action
  of "Drama":
    TestTestmovie_genre.Drama
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var Testmovie; source: JsonNode) =
  if "duration" in source and source{"duration"}.kind != JNull:
    target.duration = some(jsonTo(source{"duration"},
                                  typeof(unsafeGet(target.duration))))
  assert("releaseDate" in source,
         "releaseDate" & " is missing while decoding " & "Testmovie")
  target.releaseDate = jsonTo(source{"releaseDate"}, typeof(target.releaseDate))
  if "genre" in source and source{"genre"}.kind != JNull:
    target.genre = some(jsonTo(source{"genre"}, typeof(unsafeGet(target.genre))))
  assert("title" in source,
         "title" & " is missing while decoding " & "Testmovie")
  target.title = jsonTo(source{"title"}, typeof(target.title))
  if "cast" in source and source{"cast"}.kind != JNull:
    target.`cast` = some(jsonTo(source{"cast"}, typeof(unsafeGet(target.`cast`))))
  assert("director" in source,
         "director" & " is missing while decoding " & "Testmovie")
  target.director = jsonTo(source{"director"}, typeof(target.director))

proc toJsonHook*(source: Testmovie): JsonNode =
  result = newJObject()
  if isSome(source.duration):
    result{"duration"} = toJson(source.duration)
  result{"releaseDate"} = toJson(source.releaseDate)
  if isSome(source.genre):
    result{"genre"} = toJson(source.genre)
  result{"title"} = toJson(source.title)
  if isSome(source.`cast`):
    result{"cast"} = toJson(source.`cast`)
  result{"director"} = toJson(source.director)
