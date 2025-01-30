{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  BlogAuthor* = object
    username*: Option[string]
    email*: Option[string]
  Blogblog* = object
    title*: string
    content*: string
    publishedDate*: Option[string]
    author*: BlogAuthor
    tags*: Option[seq[string]]
proc toJsonHook*(source: BlogAuthor): JsonNode
proc toJsonHook*(source: Blogblog): JsonNode
proc fromJsonHook*(target: var BlogAuthor; source: JsonNode) =
  if hasKey(source, "username") and source{"username"}.kind != JNull:
    target.username = some(jsonTo(source{"username"},
                                  typeof(unsafeGet(target.username))))
  if hasKey(source, "email") and source{"email"}.kind != JNull:
    target.email = some(jsonTo(source{"email"}, typeof(unsafeGet(target.email))))

proc toJsonHook*(source: BlogAuthor): JsonNode =
  result = newJObject()
  if isSome(source.username):
    result{"username"} = newJString(unsafeGet(source.username))
  if isSome(source.email):
    result{"email"} = newJString(unsafeGet(source.email))

proc fromJsonHook*(target: var Blogblog; source: JsonNode) =
  assert(hasKey(source, "title"),
         "title" & " is missing while decoding " & "Blogblog")
  target.title = jsonTo(source{"title"}, typeof(target.title))
  assert(hasKey(source, "content"),
         "content" & " is missing while decoding " & "Blogblog")
  target.content = jsonTo(source{"content"}, typeof(target.content))
  if hasKey(source, "publishedDate") and
      source{"publishedDate"}.kind != JNull:
    target.publishedDate = some(jsonTo(source{"publishedDate"},
                                       typeof(unsafeGet(target.publishedDate))))
  assert(hasKey(source, "author"),
         "author" & " is missing while decoding " & "Blogblog")
  target.author = jsonTo(source{"author"}, typeof(target.author))
  if hasKey(source, "tags") and source{"tags"}.kind != JNull:
    target.tags = some(jsonTo(source{"tags"}, typeof(unsafeGet(target.tags))))

proc toJsonHook*(source: Blogblog): JsonNode =
  result = newJObject()
  result{"title"} = newJString(source.title)
  result{"content"} = newJString(source.content)
  if isSome(source.publishedDate):
    result{"publishedDate"} = newJString(unsafeGet(source.publishedDate))
  result{"author"} = toJsonHook(source.author)
  if isSome(source.tags):
    result{"tags"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.tags):
        output.add(newJString(entry))
      output
{.pop.}
