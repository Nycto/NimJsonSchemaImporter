import std/[macros, json, sets, strutils, tables], regex

type SomeTable*[K, V] = Table[K, V] | OrderedTable[K, V]

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

# https://nim-lang.org/docs/manual.html#lexical-analysis-identifiers-amp-keywords
let nimKeywords {.compileTime.} = toHashSet[string]([
    "addr", "and", "as", "asm",
    "bind", "block", "break",
    "case", "cast", "concept", "const", "continue", "converter",
    "defer", "discard", "distinct", "div", "do",
    "elif", "else", "end", "enum", "except", "export",
    "finally", "for", "from", "func",
    "if", "import", "in", "include", "interface", "is", "isnot", "iterator",
    "let",
    "macro", "method", "mixin", "mod",
    "nil", "not", "notin",
    "object", "of", "or", "out",
    "proc", "ptr",
    "raise", "ref", "return",
    "shl", "shr", "static",
    "template", "try", "tuple", "type",
    "using",
    "var",
    "when", "while",
    "xor",
    "yield",
])

proc wrapIdent(name: string): NimNode =
    return if validIdentifier(name) and name notin nimKeywords:
        name.ident
    else:
        return nnkAccQuoted.newTree(name.ident)

proc safeTypeName*(name: string): NimNode = name.cleanupIdent.capitalizeAscii.wrapIdent

proc safePropName*(name: string): NimNode = name.cleanupIdent.wrapIdent

proc formatCodeDump*(code: NimNode): string =
    result = "{.push warning[UnusedImport]:off.}\n"
    result &= "import std/[json, jsonutils, tables, options]\n"
    result &= "import json_schema_import/private/stringify\n"
    result &= code.repr.replace(re2"\`gensym_?\d+", "")
    result &= "{.pop.}\n"

proc parentDir*(path: string): string =
    let pos = path.rfind('/')
    return if pos == -1: path else: path[0..pos]
