import std/strformat, schemaRef

type
  HistoryKind = enum ## The kind of step a link in the chain records
    PathStep ## A key stepped into within a schema node
    RefStep ## A `$ref` followed out of one

  History* = ref object ## The descent that reached the schema node being parsed
    parent: History
    case kind: HistoryKind
    of PathStep:
      name: string
    of RefStep:
      sref: SchemaRef

proc add*(parent: History, name: auto): History =
  ## Records stepping into a key of the current schema node
  History(kind: PathStep, parent: parent, name: $name)

proc addRef*(parent: History, sref: SchemaRef): History =
  ## Records following a `$ref` out of the current schema node
  History(kind: RefStep, parent: parent, sref: sref)

iterator items(history: History): History =
  var cursor = history
  while cursor != nil:
    yield cursor
    cursor = cursor.parent

proc contains*(history: History, sref: SchemaRef): bool =
  ## Whether a reference is still being resolved somewhere further up the descent
  for node in history:
    if node.kind == RefStep and node.sref == sref:
      return true

proc document*(history: History): SchemaRef =
  ## The reference that led into the document currently being parsed
  for node in history:
    if node.kind == RefStep:
      return node.sref

proc `$`*(history: History): string =
  if history == nil:
    return ""

  let step =
    case history.kind
    of PathStep:
      history.name
    of RefStep:
      $history.sref

  return
    if history.parent == nil:
      step
    elif history.kind == RefStep:
      fmt"{history.parent} -> {step}"
    else:
      fmt"{history.parent}/{step}"
