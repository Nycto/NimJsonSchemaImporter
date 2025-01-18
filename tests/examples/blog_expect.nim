import std/[json, tables, options]
type
  BlogBlog* = object
    `title`*: string
    `tags`*: Option[seq[string]]
    `content`*: string
    `publishedDate`*: Option[string]