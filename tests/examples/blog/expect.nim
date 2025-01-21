{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testblog`* = object
    `author`*: `TestTestblog_author`
    `title`*: string
    `tags`*: Option[seq[string]]
    `content`*: string
    `publishedDate`*: Option[string]
  `TestTestblog_author`* = object
    `username`*: Option[string]
    `email`*: Option[string]