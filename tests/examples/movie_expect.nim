type
  MovieGenre* = enum
    Comedy, Science Fiction, Action, Drama
  MovieMovie* = object
    `duration`*: string
    `releaseDate`*: string
    `genre`*: MovieGenre
    `title`*: string
    `cast`*: seq[string]
    `director`*: string