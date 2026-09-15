import std/[json, sets, options], schemaRef

type
  VariantKind* = enum
    vkNull
    vkBool
    vkInteger
    vkNumber
    vkString
    vkAny ## Nothing named a type, so every value is allowed
    vkConst ## A single fixed value
    vkEdge
      ## A `$ref` that closes a cycle, which says nothing about the shape it points at

  Variant* = ref object
    ## One type a schema node allows, and what it says about that type
    case kind*: VariantKind
    of vkString:
      values*: Option[OrderedSet[string]] ## Set by an `enum`
    of vkConst:
      value*: JsonNode
    of vkEdge:
      target*: SchemaRef
    of vkNull, vkBool, vkInteger, vkNumber, vkAny:
      discard

  Description* = ref object ## Every type a schema node allows
    variants*: seq[Variant]
      ## Kept in the order the schema lists them; empty accepts nothing

proc describe*(variants: varargs[Variant]): Description =
  Description(variants: @variants)

proc never*(): Description =
  Description()

proc isNever*(desc: Description): bool =
  desc.variants.len == 0

proc anyValue*(): Description =
  describe(Variant(kind: vkAny))

proc kindOf(value: JsonNode): VariantKind =
  ## The variant a fixed value would otherwise be described by
  case value.kind
  of JNull: vkNull
  of JBool: vkBool
  of JInt: vkInteger
  of JFloat: vkNumber
  of JString: vkString
  of JObject, JArray: vkAny

proc admits(kind, other: VariantKind): bool =
  ## Whether every value of `other` is also a value of `kind`
  kind == other or kind == vkAny or (kind == vkNumber and other == vkInteger)

proc intersectVariant*(a, b: Variant): Variant =
  ## The variant satisfying both, or nil when no value can
  if a.kind == vkEdge or b.kind == vkAny:
    return a
  if b.kind == vkEdge or a.kind == vkAny:
    return b

  if a.kind == vkConst or b.kind == vkConst:
    let (fixed, other) =
      if a.kind == vkConst:
        (a, b)
      else:
        (b, a)
    if other.kind == vkConst:
      return if fixed.value == other.value: fixed else: nil
    return if other.kind.admits(fixed.value.kindOf): fixed else: nil

  if a.kind.admits(b.kind):
    result = b
  elif b.kind.admits(a.kind):
    result = a
  else:
    return nil

  if result.kind == vkString and a.values.isSome and b.values.isSome:
    var values = initOrderedSet[string]()
    for value in a.values.get:
      if value in b.values.get:
        values.incl(value)
    if values.len == 0:
      return nil
    result = Variant(kind: vkString, values: some(values))
  elif result.kind == vkString and a.values.isSome:
    result = a

proc union*(a, b: Description): Description =
  ## Values satisfying either side, keeping each alternative as its own variant
  Description(variants: a.variants & b.variants)

proc intersect*(a, b: Description): Description =
  ## Values satisfying both sides, distributed over every pair of alternatives
  result = never()
  for left in a.variants:
    for right in b.variants:
      let merged = intersectVariant(left, right)
      if not merged.isNil:
        result.variants.add(merged)
