{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

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
    `cast`*: Option[seq[string]]
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
    target.`cast` = some(jsonTo(source{"cast"}, typeof(unsafeGet(target.`cast`))))

proc toJsonHook*(source: Movie): JsonNode =
  result = newJObject()
  result{"title"} = newJString(source.title)
  result{"director"} = newJString(source.director)
  result{"releaseDate"} = newJString(source.releaseDate)
  if isSome(source.genre):
    result{"genre"} = `%`(unsafeGet(source.genre))
  if isSome(source.duration):
    result{"duration"} = newJString(unsafeGet(source.duration))
  if isSome(source.`cast`):
    result{"cast"} = block:
      let cursor {.cursor.} = unsafeGet(source.`cast`)
      var output = newJArray()
      for entry in cursor:
        output.add(newJString(entry))
      output
{.pop.}
