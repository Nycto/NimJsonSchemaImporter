{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  BlogAuthor* = object
    username*: Option[string]
    email*: Option[string]
  Blogblog* = object
    author*: BlogAuthor
    title*: string
    tags*: Option[seq[string]]
    content*: string
    publishedDate*: Option[string]
proc fromJsonHook*(target: var BlogAuthor; source: JsonNode) =
  if hasKey(source, "username") and source{"username"}.kind != JNull:
    target.username = some(jsonTo(source{"username"},
                                  typeof(unsafeGet(target.username))))
  if hasKey(source, "email") and source{"email"}.kind != JNull:
    target.email = some(jsonTo(source{"email"}, typeof(unsafeGet(target.email))))

proc toJsonHook*(source: BlogAuthor): JsonNode =
  result = newJObject()
  if isSome(source.username):
    result{"username"} = toJson(unsafeGet(source.username))
  if isSome(source.email):
    result{"email"} = toJson(unsafeGet(source.email))

proc fromJsonHook*(target: var Blogblog; source: JsonNode) =
  assert(hasKey(source, "author"),
         "author" & " is missing while decoding " & "Blogblog")
  target.author = jsonTo(source{"author"}, typeof(target.author))
  assert(hasKey(source, "title"),
         "title" & " is missing while decoding " & "Blogblog")
  target.title = jsonTo(source{"title"}, typeof(target.title))
  if hasKey(source, "tags") and source{"tags"}.kind != JNull:
    target.tags = some(jsonTo(source{"tags"}, typeof(unsafeGet(target.tags))))
  assert(hasKey(source, "content"),
         "content" & " is missing while decoding " & "Blogblog")
  target.content = jsonTo(source{"content"}, typeof(target.content))
  if hasKey(source, "publishedDate") and
      source{"publishedDate"}.kind != JNull:
    target.publishedDate = some(jsonTo(source{"publishedDate"},
                                       typeof(unsafeGet(target.publishedDate))))

proc toJsonHook*(source: Blogblog): JsonNode =
  result = newJObject()
  result{"author"} = toJson(source.author)
  result{"title"} = toJson(source.title)
  if isSome(source.tags):
    result{"tags"} = toJson(unsafeGet(source.tags))
  result{"content"} = toJson(source.content)
  if isSome(source.publishedDate):
    result{"publishedDate"} = toJson(unsafeGet(source.publishedDate))
