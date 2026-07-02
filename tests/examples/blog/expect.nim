{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin, sax]

type
  BlogAuthor* {.byref.} = object
    username*: Option[string]
    email*: Option[string]
  Blog* {.byref.} = object
    title*: string
    content*: string
    publishedDate*: Option[string]
    author*: BlogAuthor
    tags*: seq[string]
proc `=copy`(a: var BlogAuthor; b: BlogAuthor) {.error.}
proc toJsonHook*(source: BlogAuthor): JsonNode
proc `=copy`(a: var Blog; b: Blog) {.error.}
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

proc toStream*(source: BlogAuthor; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.username):
    hasEmitted.writeComma(target)
    write(target, escapeJson("username"))
    write(target, ':')
    toStream(unsafeGet(source.username), target)
  if isSome(source.email):
    hasEmitted.writeComma(target)
    write(target, escapeJson("email"))
    write(target, ':')
    toStream(unsafeGet(source.email), target)
  target.write('}')

proc fromStream*(typ: typedesc[BlogAuthor]; source: var JsonParser): BlogAuthor =
  eat(source, tkCurlyLe)
  while source.tok != tkCurlyRi:
    if source.tok != tkString:
      raiseParseErr(source, "string")
    let key = source.a
    discard getTok(source)
    eat(source, tkColon)
    case key
    of "username":
      result.username = some(fromStream(typeof(unsafeGet(result.username)),
                                        source))
    of "email":
      result.email = some(fromStream(typeof(unsafeGet(result.email)), source))
    else:
      skipValue(source)
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkCurlyRi)

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
    target.tags = jsonTo(source{"tags"}, typeof(target.tags))

proc toJsonHook*(source: Blog): JsonNode =
  result = newJObject()
  result{"title"} = newJString(source.title)
  result{"content"} = newJString(source.content)
  if isSome(source.publishedDate):
    result{"publishedDate"} = newJString(unsafeGet(source.publishedDate))
  result{"author"} = toJsonHook(source.author)
  if len(source.tags) > 0:
    result{"tags"} = block:
      let cursor {.cursor.} = source.tags
      var output = newJArray()
      for entry in cursor:
        output.add(newJString(entry))
      output

proc toStream*(source: Blog; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("title"))
  write(target, ':')
  toStream(source.title, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("content"))
  write(target, ':')
  toStream(source.content, target)
  if isSome(source.publishedDate):
    hasEmitted.writeComma(target)
    write(target, escapeJson("publishedDate"))
    write(target, ':')
    toStream(unsafeGet(source.publishedDate), target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("author"))
  write(target, ':')
  toStream(source.author, target)
  if len(source.tags) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("tags"))
    write(target, ':')
    toStream(source.tags, target)
  target.write('}')

proc fromStream*(typ: typedesc[Blog]; source: var JsonParser): Blog =
  eat(source, tkCurlyLe)
  while source.tok != tkCurlyRi:
    if source.tok != tkString:
      raiseParseErr(source, "string")
    let key = source.a
    discard getTok(source)
    eat(source, tkColon)
    case key
    of "title":
      result.title = fromStream(typeof(result.title), source)
    of "content":
      result.content = fromStream(typeof(result.content), source)
    of "publishedDate":
      result.publishedDate = some(fromStream(
          typeof(unsafeGet(result.publishedDate)), source))
    of "author":
      result.author = fromStream(typeof(result.author), source)
    of "tags":
      result.tags = fromStream(typeof(result.tags), source)
    else:
      skipValue(source)
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkCurlyRi)
{.pop.}
