{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `TestTestmovie_genre`* = enum
    `Comedy`, `Science Fiction`, `Action`, `Drama`
  `Testmovie`* = object
    `duration`*: Option[string]
    `releaseDate`*: string
    `genre`*: Option[`TestTestmovie_genre`]
    `title`*: string
    `cast`*: Option[seq[string]]
    `director`*: string
proc toJsonHook*(source: `TestTestmovie_genre`): JsonNode =
  case source
  of `TestTestmovie_genre`.`Comedy`:
    return newJString("Comedy")
  of `TestTestmovie_genre`.`Science Fiction`:
    return newJString("Science Fiction")
  of `TestTestmovie_genre`.`Action`:
    return newJString("Action")
  of `TestTestmovie_genre`.`Drama`:
    return newJString("Drama")
  