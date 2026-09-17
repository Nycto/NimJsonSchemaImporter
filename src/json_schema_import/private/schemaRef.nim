import ../config, std/[strutils, parseutils, json, strformat, hashes]

type
  RefKind* = enum
    RootRef
    SubRef
    UrlRef
    AnchorRef

  SchemaRef* = ref object
    case kind*: RefKind
    of RootRef:
      discard
    of SubRef, AnchorRef:
      name*: string
    of UrlRef:
      url*: string
    next*: SchemaRef

proc dump*(sref: SchemaRef): string =
  case sref.kind
  of RootRef:
    result = "(Root)"
  of SubRef:
    result = fmt"(Sub:{sref.name})"
  of UrlRef:
    result = fmt"(Url:{sref.url})"
  of AnchorRef:
    result = fmt"(Anchor:{sref.name})"

  if sref.next != nil:
    result &= "/" & sref.next.dump

proc `$`*(sref: SchemaRef): string =
  if sref == nil:
    return ""

  case sref.kind
  of RootRef:
    result = "#"
  of SubRef:
    result = sref.name
  of UrlRef:
    return sref.url & $sref.next
  of AnchorRef:
    result = "#" & sref.name

  if sref.next != nil:
    result &= "/" & $sref.next

template required(input: string, predicate: bool) =
  if not predicate:
    raise newException(ValueError, "Malformed reference: " & input)

proc parseSubref(input: string, offset: int): SchemaRef =
  if input.len == offset:
    return nil

  input.required(input[offset] == '/')

  var token: string
  let parsedChars = parseUntil(input, token, '/', offset + 1)
  input.required(parsedChars > 0)

  return SchemaRef(
    kind: SubRef, name: token, next: parseSubref(input, offset + parsedChars + 1)
  )

proc parseHash(input: string, offset: int): SchemaRef =
  case input.len - offset
  of 0:
    return nil
  of 1:
    input.required(input[offset] == '#')
    return SchemaRef(kind: RootRef)
  else:
    input.required(input[offset] == '#')
    if input[offset + 1] == '/':
      return SchemaRef(kind: RootRef, next: parseSubRef(input, offset + 1))
    else:
      var token: string
      let parsedChars = parseUntil(input, token, '/', offset + 1)
      input.required(parsedChars > 0)
      return SchemaRef(
        kind: AnchorRef, name: token, next: parseSubRef(input, offset + parsedChars + 1)
      )

proc parseRef*(input: string): SchemaRef =
  input.required(input != "")

  if input.startsWith("#"):
    return parseHash(input, 0)
  else:
    var url: string
    let parsedChars = parseUntil(input, url, '#', 0)
    input.required(parsedChars > 0)
    return SchemaRef(kind: UrlRef, url: url, next: parseHash(input, parsedChars))

proc getName*(sref: SchemaRef): string =
  if sref == nil:
    return ""
  elif sref.next != nil:
    return sref.next.getName()
  else:
    case sref.kind
    of UrlRef, RootRef:
      return ""
    of SubRef, AnchorRef:
      return sref.name

proc within*(sref, document: SchemaRef): SchemaRef =
  ## Pins a reference to the document it was written in, so `#/...` in a fetched one stays there
  if sref.kind == UrlRef:
    let next =
      if sref.next.isNil:
        SchemaRef(kind: RootRef)
      else:
        sref.next
    return SchemaRef(kind: UrlRef, url: sref.url, next: next)
  elif not document.isNil and document.kind == UrlRef:
    return SchemaRef(kind: UrlRef, url: document.url, next: sref)
  else:
    return sref

proc findAnchor(node: JsonNode, name: string, isResource: bool): JsonNode =
  ## Searches one schema resource for an `$anchor`, stopping at embedded `$id`s
  case node.kind
  of JObject:
    if not isResource and "$id" in node:
      return nil
    if node{"$anchor"}.getStr == name:
      return node
    for key, child in node:
      if key notin ["enum", "const", "examples", "default"]:
        result = findAnchor(child, name, false)
        if result != nil:
          return
  of JArray:
    for child in node:
      result = findAnchor(child, name, false)
      if result != nil:
        return
  else:
    discard

proc resolve*(sref: SchemaRef, node: JsonNode, resolveUrl: UrlResolver): JsonNode =
  if sref == nil:
    return node

  case sref.kind
  of UrlRef:
    let doc = resolveUrl(sref.url)
    if doc == nil:
      raise newException(ValueError, fmt"Unable to resolve url: {sref.url}")
    return sref.next.resolve(doc, resolveUrl)
  of RootRef:
    return sref.next.resolve(node, resolveUrl)
  of SubRef:
    if sref.name notin node:
      raise newException(
        ValueError, fmt"Unable to resolve reference: {sref} against {node}"
      )
    return sref.next.resolve(node{sref.name}, resolveUrl)
  of AnchorRef:
    let found = findAnchor(node, sref.name, true)
    if found != nil:
      return sref.next.resolve(found, resolveUrl)
    raise newException(ValueError, fmt"Unable to find anchor reference: {sref}")

proc `==`*(a, b: SchemaRef): bool =
  ## Whether two references point at the same place
  # The tail has to be part of this: every document relative reference starts with the
  # same `RootRef`, so comparing only the head makes `#/foo` and `#/bar` equal. `hash`
  # already covers `next`, which is what has been keeping the reference keyed tables
  # working -- they only fall back to `==` once two references collide.
  if a.isNil or b.isNil:
    return a.isNil and b.isNil
  elif a.kind != b.kind or a.next != b.next:
    return false
  else:
    return
      case a.kind
      of RootRef:
        true
      of SubRef, AnchorRef:
        a.name == b.name
      of UrlRef:
        a.url == b.url

proc hash*(sref: SchemaRef): Hash =
  if not sref.isNil:
    result = hash(sref.kind)

    case sref.kind
    of RootRef:
      discard
    of SubRef, AnchorRef:
      result = result !& hash(sref.name)
    of UrlRef:
      result = result !& hash(sref.url)

    result = result !& hash(sref.next)
