import std/strutils

type NameChain* = ref object ## A chain of names
  name, category: string
  parent: NameChain
  root: bool

proc rootName*(name: string): auto =
  ## Creates a root name chain
  return
    if name != "":
      NameChain(name: name, root: true)
    else:
      nil

proc isRoot*(name: NameChain): bool =
  ## Whether this is the name the user configured for the root type, as opposed to one
  ## derived from a key within the schema
  return name != nil and name.root

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

iterator chainOptions*(name: NameChain, prefix: string): string =
  ## Proposes the names that can be spelled out of the chain itself. Unlike
  ## `nameOptions`, this ends instead of falling back to numeric suffixes
  var accum: string
  var next = name
  while next != nil:
    accum = next.name & accum
    yield accum.prefixed(prefix)

    if next.category != "":
      accum &= next.category
      yield accum.prefixed(prefix)

    next = next.parent

iterator nameOptions*(name: NameChain, prefix: string): string =
  ## Proposes all possible names for a type
  var last: string
  for option in name.chainOptions(prefix):
    last = option
    yield option

  if last != "":
    var i = 2
    while true:
      yield last & $i
      inc i
