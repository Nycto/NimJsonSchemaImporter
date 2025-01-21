import std/[macros, json, strutils]

type
    JsonSchemaConfig* = object
        ## The configuration required for parsing a json schema
        rootTypeName*: string
        typeNamePrefix*: string
        urlResolver*: UrlResolver

    UrlResolver* = proc (url: string): JsonNode
        ## Callback that resolves remote URL references to a schema

proc unionKey*(i: int): NimNode = ident("key" & $i)

proc cleanupIdent*(name: string): string =
    result = name.strip(leading = true, trailing = true, chars = {'_'})
    while true:
        var newOutput = result
        newOutput = newOutput.replace("__", "_")
        if newOutput == result:
            break
        else:
            result = newOutput

proc getName*(node: NimNode): string =
    case node.kind
    of nnkAccQuoted: return node[0].getName
    of nnkIdent, nnkSym: return node.strVal
    else: node.expectKind({ nnkAccQuoted, nnkIdent, nnkSym })

proc safeTypeName*(name: string): NimNode = nnkAccQuoted.newTree(name.cleanupIdent.capitalizeAscii.ident)

proc safePropName*(name: string): NimNode = nnkAccQuoted.newTree(name.cleanupIdent.ident)