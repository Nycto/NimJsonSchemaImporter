import std/[strutils, parseutils, json, strformat]

type
    RefKind* = enum
        RootRef,
        SubRef

    SchemaRef* = ref object
        case kind*: RefKind
        of RootRef:
            discard
        of SubRef:
            name*: string
        next*: SchemaRef

proc `$`*(sref: SchemaRef): string =
    case sref.kind
    of RootRef:
        result = "#"
    of SubRef:
        result = sref.name

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

proc parseRef*(input: string): SchemaRef =
    if not input.startsWith("#"):
        raise newException(ValueError, "Unsupported reference value: " & input)

    return SchemaRef(kind: RootRef, next: parseSubref(input, 1))

proc resolve*(sref: SchemaRef, node: JsonNode): JsonNode =
    if sref == nil:
        return node

    case sref.kind
    of RootRef:
        return sref.next.resolve(node)
    of SubRef:
        if sref.name notin node:
            raise newException(ValueError, fmt"Unable to resolve reference: {sref} against {node}")
        return sref.next.resolve(node{sref.name})