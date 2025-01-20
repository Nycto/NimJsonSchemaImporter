{.push warning[UnusedImport]:off.}
import std/[json, tables, options]
type
  `TestTestMovie_Genre`* = enum
    Comedy, Science Fiction, Action, Drama
  `TestMovie`* = object
    `duration`*: Option[string]
    `releaseDate`*: string
    `genre`*: Option[`TestTestMovie_Genre`]
    `title`*: string
    `cast`*: Option[seq[string]]
    `director`*: string