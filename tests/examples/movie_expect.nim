import std/[json, tables, options]
type
  `MovieMovie`* = object
    `duration`*: Option[string]
    `releaseDate`*: string
    `genre`*: Option[`MovieMovieMovie_Genre`]
    `title`*: string
    `cast`*: Option[seq[string]]
    `director`*: string
  `MovieMovieMovie_Genre`* = enum
    Comedy, Science Fiction, Action, Drama