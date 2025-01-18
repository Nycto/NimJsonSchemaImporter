import std/[json, tables, options]
type
  `MovieGenre`* = enum
    Comedy, Science Fiction, Action, Drama
  `MovieMovie`* = object
    `duration`*: Option[string]
    `releaseDate`*: string
    `genre`*: Option[`MovieGenre`]
    `title`*: string
    `cast`*: Option[seq[string]]
    `director`*: string