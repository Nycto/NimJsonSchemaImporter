import std/[macros, json, sets, strutils, tables, options], regex, types

type SomeTable*[K, V] = Table[K, V] | OrderedTable[K, V]

proc unionKey*(i: int): NimNode =
  ident("key" & $i)

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
  of nnkAccQuoted, nnkPragmaExpr:
    return node[0].getName
  of nnkIdent, nnkSym:
    return node.strVal
  else:
    node.expectKind({nnkAccQuoted, nnkIdent, nnkSym, nnkPragmaExpr})

# https://nim-lang.org/docs/manual.html#lexical-analysis-identifiers-amp-keywords
let nimKeywords {.compileTime.} = toHashSet[string](
  [
    "addr", "and", "as", "asm", "bind", "block", "break", "case", "cast", "concept",
    "const", "continue", "converter", "defer", "discard", "distinct", "div", "do",
    "elif", "else", "end", "enum", "except", "export", "finally", "for", "from", "func",
    "if", "import", "in", "include", "interface", "is", "isnot", "iterator", "let",
    "macro", "method", "mixin", "mod", "nil", "not", "notin", "object", "of", "or",
    "out", "proc", "ptr", "raise", "ref", "return", "shl", "shr", "static", "template",
    "try", "tuple", "type", "using", "var", "when", "while", "xor", "yield",
  ]
)

proc wrapIdent(name: string): NimNode =
  return
    if validIdentifier(name) and name notin nimKeywords:
      name.ident
    else:
      return nnkAccQuoted.newTree(name.ident)

proc safeTypeName*(name: string): NimNode =
  name.cleanupIdent.capitalizeAscii.wrapIdent

proc safePropName*(name: string): NimNode =
  name.cleanupIdent.wrapIdent

type PropCategory* = enum
  pcSelfOptional
    ## The type's own zero value (e.g. an empty map/array) already conveys
    ## "absent", so presence is inferred from that rather than tracked
    ## separately.
  pcRequired
    ## Must always be encoded/decoded: either the schema requires it, or it
    ## has no real field to be optional about (e.g. a const value).
  pcOptional
    ## Wrapped in `Option[T]`; may be entirely absent.

proc classify*(propType: TypeDef, required: bool): PropCategory =
  ## Classifies an object property for encoder/decoder codegen, matching the
  ## three cases every `buildObject*`/`buildSaxObj*` builder branches on.
  if propType.kind in SELF_OPTIONAL:
    pcSelfOptional
  elif required or not propType.hasRealField:
    pcRequired
  else:
    assert(propType.kind == OptionalType)
    pcOptional

proc formatCodeDump*(code: NimNode): string =
  result = "{.push warning[UnusedImport]:off.}\n"
  result &= "import std/[json, jsonutils, tables, options]\n"
  result &= "import json_schema_import/private/[stringify, equality, bin, sax]\n"
  result &= code.repr.replace(re2"\`gensym_?\d+", "")
  result &= "{.pop.}\n"

proc parentDir*(path: string): string =
  let pos = path.rfind('/')
  return
    if pos == -1:
      path
    else:
      path[0 .. pos]

proc withByRef*(ident: NimNode): NimNode =
  nnkPragmaExpr.newTree(ident, nnkPragma.newTree(ident("byref")))

proc markPublic*(ident: NimNode): NimNode =
  if ident.kind == nnkPragmaExpr:
    result = ident.copyNimTree
    result[0] = ident[0].markPublic
  else:
    return postfix(ident, "*")
