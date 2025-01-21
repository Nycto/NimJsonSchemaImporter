import util, std/[strutils, parseutils, json, strformat, hashes]

type
    RefKind* = enum
        RootRef,
        SubRef,
        UrlRef,
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
        result = sref.url
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

    return SchemaRef(kind: SubRef, name: token, next: parseSubref(input, offset + parsedChars + 1))

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
            return SchemaRef(kind: AnchorRef, name: token, next: parseSubRef(input, offset + parsedChars + 1))

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
        of UrlRef, RootRef: return ""
        of SubRef, AnchorRef: return sref.name

proc resolve*(sref: SchemaRef, node: JsonNode, resolveUrl: UrlResolver): JsonNode =
    if sref == nil:
        return node

    case sref.kind
    of UrlRef:
        result = resolveUrl(sref.url)
        if result == nil:
            raise newException(ValueError, fmt"Unable to resolve url: {sref.url}")

    of RootRef:
        return sref.next.resolve(node, resolveUrl)

    of SubRef:
        if sref.name notin node:
            raise newException(ValueError, fmt"Unable to resolve reference: {sref} against {node}")
        return sref.next.resolve(node{sref.name}, resolveUrl)

    of AnchorRef:
        for key, entry in node{"$defs"}:
            if "$anchor" in entry and entry{"$anchor"}.getStr == sref.name:
                return entry
        raise newException(ValueError, fmt"Unable to find anchor reference: {sref}")

proc `==`*(a, b: SchemaRef): bool =
    if a.isNil and b.isNil:
        return true
    elif not a.isNil and not b.isNil and a.kind == b.kind:
        return case a.kind
        of RootRef: true
        of SubRef, AnchorRef: a.name == b.name
        of UrlRef: a.url == b.url

proc hash*(sref: SchemaRef): Hash =
    if not sref.isNil:
        result = hash(sref.kind)

        case sref.kind
        of RootRef: discard
        of SubRef, AnchorRef:
            result = result !& hash(sref.name)
        of UrlRef:
            result = result !& hash(sref.url)

        result = result !& hash(sref.next)