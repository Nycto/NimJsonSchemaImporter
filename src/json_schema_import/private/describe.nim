import std/[json, sets, options, tables], schemaRef

type
  VariantKind* = enum
    vkNull
    vkBool
    vkInteger
    vkNumber
    vkString
    vkArray
    vkObject
    vkAny ## Nothing named a type, so every value is allowed
    vkConst ## A single fixed value
    vkEdge
      ## A `$ref` that closes a cycle, which says nothing about the shape it points at

  Variant* = ref object
    ## One type a schema node allows, and what it says about that type
    case kind*: VariantKind
    of vkString:
      values*: Option[OrderedSet[string]] ## Set by an `enum`
    of vkArray:
      items*: Description ## Nil when nothing constrains them
      prefix*: Option[seq[Description]] ## A tuple, with `items` folded into every slot
    of vkObject:
      properties*: OrderedTable[string, Description]
      required*: OrderedSet[string]
      additional*: Description ## Nil when nothing constrains them
      shaped*: bool ## Whether the properties were listed, even as none at all
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
  of JArray: vkArray
  of JObject: vkObject

proc admits(kind, other: VariantKind): bool =
  ## Whether every value of `other` is also a value of `kind`
  kind == other or kind == vkAny or (kind == vkNumber and other == vkInteger)

proc intersect*(a, b: Description): Description

proc narrow(a, b: Description): Description =
  ## Intersects two optional constraints, where nil is no constraint at all
  if a.isNil:
    b
  elif b.isNil:
    a
  else:
    intersect(a, b)

proc narrowString(a, b: Variant): Variant =
  if a.values.isNone:
    return b
  if b.values.isNone:
    return a

  var values = initOrderedSet[string]()
  for value in a.values.get:
    if value in b.values.get:
      values.incl(value)
  if values.len > 0:
    return Variant(kind: vkString, values: some(values))

proc narrowArray(a, b: Variant): Variant =
  result = Variant(kind: vkArray, items: narrow(a.items, b.items))

  if a.prefix.isSome and b.prefix.isSome and a.prefix.get.len != b.prefix.get.len:
    raise newException(ValueError, "Mismatched tuple lengths")

  let slots = if a.prefix.isSome: a.prefix else: b.prefix
  if slots.isNone:
    return

  # `items` covers the slots too, except when it is `false`, which only closes the tail
  var elements: seq[Description]
  for i, slot in slots.get:
    var element = slot
    if a.prefix.isSome and b.prefix.isSome:
      element = intersect(element, b.prefix.get[i])
    if not result.items.isNil and not result.items.isNever:
      element = intersect(element, result.items)
    if element.isNever:
      return nil
    elements.add(element)
  result.prefix = some(elements)

proc narrowObject(a, b: Variant): Variant =
  result = Variant(
    kind: vkObject,
    additional: narrow(a.additional, b.additional),
    shaped: a.shaped or b.shaped,
  )
  for key in a.required:
    result.required.incl(key)
  for key in b.required:
    result.required.incl(key)

  for key, prop in a.properties:
    result.properties[key] = prop
  for key, prop in b.properties:
    result.properties[key] = narrow(result.properties.getOrDefault(key), prop)

  # An object missing a key it has to hold is no object at all
  for key in result.required:
    if key in result.properties and result.properties[key].isNever:
      return nil

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

  case result.kind
  of vkString:
    return narrowString(a, b)
  of vkArray:
    return narrowArray(a, b)
  of vkObject:
    return narrowObject(a, b)
  else:
    discard

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
