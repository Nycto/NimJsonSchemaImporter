import std/[json, tables]
type
  BlogBlog* = object
    `title`*: string
    `tags`*: seq[string]
    `content`*: string
    `publishedDate`*: string