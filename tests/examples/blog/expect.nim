{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  BlogAuthor* = object
    username*: Option[string]
    email*: Option[string]
  Blog* = object
    title*: string
    content*: string
    publishedDate*: Option[string]
    author*: BlogAuthor
    tags*: Option[seq[string]]
proc toJsonHook*(source: BlogAuthor): JsonNode
proc toJsonHook*(source: Blog): JsonNode
proc equals(_: typedesc[BlogAuthor]; a, b: BlogAuthor): bool =
  equals(typeof(a.username), a.username, b.username) and
      equals(typeof(a.email), a.email, b.email)

proc `==`*(a, b: BlogAuthor): bool =
  return equals(BlogAuthor, a, b)

proc stringify(_: typedesc[BlogAuthor]; value: BlogAuthor): string =
  stringifyObj("BlogAuthor", ("username",
                              stringify(typeof(value.username), value.username)),
               ("email", stringify(typeof(value.email), value.email)))

proc `$`*(value: BlogAuthor): string =
  stringify(BlogAuthor, value)

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

proc equals(_: typedesc[Blog]; a, b: Blog): bool =
  equals(typeof(a.title), a.title, b.title) and
      equals(typeof(a.content), a.content, b.content) and
      equals(typeof(a.publishedDate), a.publishedDate, b.publishedDate) and
      equals(typeof(a.author), a.author, b.author) and
      equals(typeof(a.tags), a.tags, b.tags)

proc `==`*(a, b: Blog): bool =
  return equals(Blog, a, b)

proc stringify(_: typedesc[Blog]; value: Blog): string =
  stringifyObj("Blog", ("title", stringify(typeof(value.title), value.title)),
               ("content", stringify(typeof(value.content), value.content)), (
      "publishedDate",
      stringify(typeof(value.publishedDate), value.publishedDate)),
               ("author", stringify(typeof(value.author), value.author)),
               ("tags", stringify(typeof(value.tags), value.tags)))

proc `$`*(value: Blog): string =
  stringify(Blog, value)

proc fromJsonHook*(target: var Blog; source: JsonNode) =
  assert(hasKey(source, "title"),
         "title" & " is missing while decoding " & "Blog")
  target.title = jsonTo(source{"title"}, typeof(target.title))
  assert(hasKey(source, "content"),
         "content" & " is missing while decoding " & "Blog")
  target.content = jsonTo(source{"content"}, typeof(target.content))
  if hasKey(source, "publishedDate") and
      source{"publishedDate"}.kind != JNull:
    target.publishedDate = some(jsonTo(source{"publishedDate"},
                                       typeof(unsafeGet(target.publishedDate))))
  assert(hasKey(source, "author"),
         "author" & " is missing while decoding " & "Blog")
  target.author = jsonTo(source{"author"}, typeof(target.author))
  if hasKey(source, "tags") and source{"tags"}.kind != JNull:
    target.tags = some(jsonTo(source{"tags"}, typeof(unsafeGet(target.tags))))

proc toJsonHook*(source: Blog): JsonNode =
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
