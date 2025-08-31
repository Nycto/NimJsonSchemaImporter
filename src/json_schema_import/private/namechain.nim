import std/strutils

type NameChain* = ref object ## A chain of names
  name, category: string
  parent: NameChain

proc rootName*(name: string): auto =
  ## Creates a root name chain
  return
    if name != "":
      NameChain(name: name)
    else:
      nil

proc add*(parent: NameChain, child: string): auto =
  ## Adds a child to the name chain
  if child != "":
    return NameChain(parent: parent, name: child.capitalizeAscii)
  else:
    return parent

proc categorize*(parent: NameChain, category: string): auto =
  ## Adds a category to the name chain
  if category == "":
    return parent
  assert(parent != nil)
  result.new
  result[] = parent[]
  result.category = category.capitalizeAscii

proc prefixed(name, prefix: string): string =
  ## Adds prefix to name if the name doesn't already start with that prefix
  return
    if name.startsWith(prefix):
      name
    else:
      prefix & name

iterator nameOptions*(name: NameChain, prefix: string): string =
  ## Proposes all possible names for a type
  var accum: string
  var next = name
  while next != nil:
    accum = next.name & accum
    yield accum.prefixed(prefix)

    if next.category != "":
      accum &= next.category
      yield accum.prefixed(prefix)

    next = next.parent

  if accum != "":
    var i = 2
    while true:
      yield accum.prefixed(prefix) & $i
      inc i
