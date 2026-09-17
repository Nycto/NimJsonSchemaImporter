import ../config, std/[strutils, parseutils, json, strformat, hashes, uri]

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

  # Fragments are percent-encoded, then JSON pointer escaped
  token = token.decodeUrl(decodePlus = false).multiReplace(("~1", "/"), ("~0", "~"))
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
    # Before 2019-09, an anchor was written as an `$id` holding only a fragment
    let id = node{"$id"}.getStr
    if not isResource and id != "" and not id.startsWith("#"):
      return nil
    if node{"$anchor"}.getStr == name or id == "#" & name:
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

proc child(sref: SchemaRef, node: JsonNode): JsonNode =
  ## Steps into the object key or array index a `SubRef` names
  result =
    case node.kind
    of JObject:
      node{sref.name}
    of JArray:
      try:
        node{parseInt(sref.name)}
      except ValueError:
        nil
    else:
      nil
  if result == nil:
    raise
      newException(ValueError, fmt"Unable to resolve reference: {sref} against {node}")

proc anchor(sref: SchemaRef, node: JsonNode): JsonNode =
  ## Finds the node an `AnchorRef` names within the resource holding it
  result = findAnchor(node, sref.name, true)
  if result == nil:
    raise newException(ValueError, fmt"Unable to find anchor reference: {sref}")

proc fetch(sref: SchemaRef, resolveUrl: UrlResolver): JsonNode =
  ## Retrieves the document a `UrlRef` points at
  result = resolveUrl(sref.url)
  if result == nil:
    raise newException(ValueError, fmt"Unable to resolve url: {sref.url}")

iterator walk*(sref: SchemaRef, node: JsonNode, resolveUrl: UrlResolver): JsonNode =
  ## The document a reference starts in, then every node it steps into up to its target
  var cursor = sref
  var current = node
  if cursor.kind == UrlRef:
    current = cursor.fetch(resolveUrl)
    cursor = cursor.next
  yield current

  while cursor != nil:
    case cursor.kind
    of UrlRef, RootRef:
      discard
    of SubRef:
      current = cursor.child(current)
      yield current
    of AnchorRef:
      current = cursor.anchor(current)
      yield current
    cursor = cursor.next

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
