import std/[json, tables, options]
type
  `TestBlog`* = object
    `title`*: string
    `tags`*: Option[seq[string]]
    `content`*: string
    `publishedDate`*: Option[string]