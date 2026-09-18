import std/[hashes, strformat, strutils]

type
  ValidateKind* = enum ## An assertion a value has to satisfy, or a combination of them
    AndValid
    OrValid
    MinLenValid
    MaxLenValid
    PatternValid
    MinimumValid
    MaximumValid
    ExclusiveMinValid
    ExclusiveMaxValid
    MultipleOfValid

  ValidateNode* = ref object
    ## Constraints riding alongside a type, which narrow the values it accepts without
    ## changing the Nim type itself. Nil means nothing is asserted.
    case kind*: ValidateKind
    of AndValid, OrValid:
      l*, r*: ValidateNode
    of MinLenValid, MaxLenValid:
      len*: int
    of PatternValid:
      pattern*: string
    of MinimumValid, MaximumValid, ExclusiveMinValid, ExclusiveMaxValid, MultipleOfValid:
      bound*: BiggestFloat

type
  LengthKind* = range[MinLenValid .. MaxLenValid]
  BoundKind* = range[MinimumValid .. MultipleOfValid]

proc lengthAssertion*(kind: LengthKind, len: int): ValidateNode =
  ## Builds a length node from a kind only known at runtime
  return ValidateNode(kind: kind, len: len)

proc boundAssertion*(kind: BoundKind, bound: BiggestFloat): ValidateNode =
  ## Builds a numeric node from a kind only known at runtime
  return ValidateNode(kind: kind, bound: bound)

proc allOf*(a, b: ValidateNode): ValidateNode =
  ## Both sides, where a side asserting nothing leaves the other alone
  if a.isNil:
    return b
  if b.isNil:
    return a
  return ValidateNode(kind: AndValid, l: a, r: b)

proc anyOf*(a, b: ValidateNode): ValidateNode =
  ## Either side. A side asserting nothing accepts every value, and so does the whole,
  ## which is why this is not the mirror of `allOf`
  if a.isNil or b.isNil:
    return nil
  return ValidateNode(kind: OrValid, l: a, r: b)

proc `$`*(node: ValidateNode): string =
  ## Renders back to schema-ish text, for the message a failed check raises
  if node.isNil:
    return "anything"

  proc num(value: BiggestFloat): string =
    return
      if value == value.int.BiggestFloat:
        $value.int
      else:
        $value

  return
    case node.kind
    of AndValid:
      &"({node.l} and {node.r})"
    of OrValid:
      &"({node.l} or {node.r})"
    of MinLenValid:
      &"minLength: {node.len}"
    of MaxLenValid:
      &"maxLength: {node.len}"
    of PatternValid:
      &"pattern: {node.pattern.escape}"
    of MinimumValid:
      &"minimum: {num(node.bound)}"
    of MaximumValid:
      &"maximum: {num(node.bound)}"
    of ExclusiveMinValid:
      &"exclusiveMinimum: {num(node.bound)}"
    of ExclusiveMaxValid:
      &"exclusiveMaximum: {num(node.bound)}"
    of MultipleOfValid:
      &"multipleOf: {num(node.bound)}"

proc `==`*(a, b: ValidateNode): bool =
  if a.isNil or b.isNil:
    return a.isNil and b.isNil
  if a.kind != b.kind:
    return false

  return
    case a.kind
    of AndValid, OrValid:
      a.l == b.l and a.r == b.r
    of MinLenValid, MaxLenValid:
      a.len == b.len
    of PatternValid:
      a.pattern == b.pattern
    of MinimumValid, MaximumValid, ExclusiveMinValid, ExclusiveMaxValid, MultipleOfValid:
      a.bound == b.bound

proc hash*(node: ValidateNode): Hash {.noSideEffect.} =
  if node.isNil:
    return 0

  result = hash(node.kind)
  case node.kind
  of AndValid, OrValid:
    result = result !& hash(node.l) !& hash(node.r)
  of MinLenValid, MaxLenValid:
    result = result !& hash(node.len)
  of PatternValid:
    result = result !& hash(node.pattern)
  of MinimumValid, MaximumValid, ExclusiveMinValid, ExclusiveMaxValid, MultipleOfValid:
    result = result !& hash(node.bound)

iterator conjuncts*(node: ValidateNode): ValidateNode =
  ## Walks a top level `and` chain, so each side can be checked and reported on its own
  var pending =
    if node.isNil:
      @[]
    else:
      @[node]
  while pending.len > 0:
    let next = pending.pop
    if next.kind == AndValid:
      pending.add(next.r)
      pending.add(next.l)
    else:
      yield next
