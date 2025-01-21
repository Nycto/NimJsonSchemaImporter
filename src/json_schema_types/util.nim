import std/[macros, json, strutils]

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

proc safeTypeName*(name: string): NimNode =
    return nnkAccQuoted.newTree(name.cleanupIdent.capitalizeAscii.ident)

proc safePropName*(name: string): NimNode =
    return nnkAccQuoted.newTree(name.cleanupIdent.ident)