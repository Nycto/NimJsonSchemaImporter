{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  TestTestblog_author* = object
    username*: Option[string]
    email*: Option[string]
  Testblog* = object
    author*: TestTestblog_author
    title*: string
    tags*: Option[seq[string]]
    content*: string
    publishedDate*: Option[string]
proc fromJsonHook*(target: var TestTestblog_author; source: JsonNode) =
  if "username" in source and source{"username"}.kind != JNull:
    target.username = some(jsonTo(source{"username"},
                                  typeof(unsafeGet(target.username))))
  if "email" in source and source{"email"}.kind != JNull:
    target.email = some(jsonTo(source{"email"}, typeof(unsafeGet(target.email))))

proc toJsonHook*(source: TestTestblog_author): JsonNode =
  result = newJObject()
  if isSome(source.username):
    result{"username"} = toJson(source.username)
  if isSome(source.email):
    result{"email"} = toJson(source.email)

proc fromJsonHook*(target: var Testblog; source: JsonNode) =
  assert("author" in source,
         "author" & " is missing while decoding " & "Testblog")
  target.author = jsonTo(source{"author"}, typeof(target.author))
  assert("title" in source, "title" & " is missing while decoding " & "Testblog")
  target.title = jsonTo(source{"title"}, typeof(target.title))
  if "tags" in source and source{"tags"}.kind != JNull:
    target.tags = some(jsonTo(source{"tags"}, typeof(unsafeGet(target.tags))))
  assert("content" in source,
         "content" & " is missing while decoding " & "Testblog")
  target.content = jsonTo(source{"content"}, typeof(target.content))
  if "publishedDate" in source and source{"publishedDate"}.kind != JNull:
    target.publishedDate = some(jsonTo(source{"publishedDate"},
                                       typeof(unsafeGet(target.publishedDate))))

proc toJsonHook*(source: Testblog): JsonNode =
  result = newJObject()
  result{"author"} = toJson(source.author)
  result{"title"} = toJson(source.title)
  if isSome(source.tags):
    result{"tags"} = toJson(source.tags)
  result{"content"} = toJson(source.content)
  if isSome(source.publishedDate):
    result{"publishedDate"} = toJson(source.publishedDate)
