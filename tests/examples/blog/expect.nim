import std/[json, tables, options]
type
  `TestTestBlog_Author`* = object
    `username`*: Option[string]
    `email`*: Option[string]
  `TestBlog`* = object
    `author`*: `TestTestBlog_Author`
    `title`*: string
    `tags`*: Option[seq[string]]
    `content`*: string
    `publishedDate`*: Option[string]