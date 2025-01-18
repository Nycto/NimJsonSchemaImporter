type
  genre* = enum
    Comedy, Science Fiction, Action, Drama
  movie* = object
    duration*: string
    releaseDate*: string
    genre*: genre
    title*: string
    cast*: seq[string]
    director*: string