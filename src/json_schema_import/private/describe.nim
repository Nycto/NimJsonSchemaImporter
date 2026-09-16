import std/[json, sets, options, tables, uri, sequtils], schemaRef

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
    sref*: SchemaRef ## The reference this variant was reached through, if any
    id*: Uri
    folded*: seq[Description]
      ## Labelled types a combine absorbed; an edge may still name one
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
    sref*: SchemaRef
      ## Names the description as a whole, which is a union when it has many
    id*: Uri
    folded*: seq[Description]
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
proc intersectKinds(a, b: Variant): Variant

proc narrow(a, b: Description): Description =
  ## Intersects two optional constraints, where nil is no constraint at all
  if a.isNil:
    b
  elif b.isNil:
    a
  else:
    intersect(a, b)

proc isBare(variant: Variant): bool =
  ## Whether a container variant says nothing beyond its kind
  case variant.kind
  of vkArray:
    variant.items.isNil and variant.prefix.isNone
  of vkObject:
    not variant.shaped and variant.properties.len == 0 and variant.required.len == 0 and
      variant.additional.isNil
  else:
    false

proc clone*(variant: Variant): Variant =
  ## Copies a variant. Built field by field, since the VM aliases `result[] = variant[]`.
  result =
    case variant.kind
    of vkString:
      Variant(kind: vkString, values: variant.values)
    of vkArray:
      Variant(kind: vkArray, items: variant.items, prefix: variant.prefix)
    of vkObject:
      Variant(
        kind: vkObject,
        properties: variant.properties,
        required: variant.required,
        additional: variant.additional,
        shaped: variant.shaped,
      )
    of vkConst:
      Variant(kind: vkConst, value: variant.value)
    of vkEdge:
      Variant(kind: vkEdge, target: variant.target)
    of vkNull, vkBool, vkInteger, vkNumber, vkAny:
      Variant(kind: variant.kind)
  result.sref = variant.sref
  result.id = variant.id
  for desc in variant.folded:
    result.folded.add(desc)

proc firstId(a, b: Variant): Uri =
  if a.id == default(Uri): b.id else: a.id

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
    return Variant(kind: vkString, values: some(values), id: firstId(a, b))

proc narrowArray(a, b: Variant): Variant =
  if a.isBare:
    return b
  if b.isBare:
    return a

  result = Variant(kind: vkArray, items: narrow(a.items, b.items), id: firstId(a, b))

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
    elements.add(element)
  result.prefix = some(elements)

proc narrowObject(a, b: Variant): Variant =
  if a.isBare:
    return b
  if b.isBare:
    return a

  result = Variant(
    kind: vkObject,
    id: firstId(a, b),
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

proc isEmpty*(variant: Variant): bool =
  ## Whether nothing satisfies a variant: an object missing a key it has to hold, or a
  ## tuple with a slot nothing fills
  case variant.kind
  of vkObject:
    for key in variant.required:
      if key in variant.properties and variant.properties[key].isNever:
        return true
  of vkArray:
    if variant.prefix.isSome:
      for slot in variant.prefix.get:
        if slot.isNever:
          return true
  else:
    discard

proc intersectVariant*(a, b: Variant): Variant =
  ## The variant satisfying both, or nil when no value can
  result = intersectKinds(a, b)
  if not result.isNil and result.isEmpty:
    return nil

proc intersectKinds(a, b: Variant): Variant =
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

iterator spread(desc: Description): Variant =
  ## The variants of a description, with its label moved onto the variant it names
  if desc.sref.isNil or desc.variants.len != 1:
    for variant in desc.variants:
      yield variant
  else:
    let inner = desc.variants[0]
    let variant = inner.clone
    variant.sref = desc.sref
    if variant.id == default(Uri):
      variant.id = desc.id
    variant.folded.add(desc.folded)
    if not inner.sref.isNil and inner.sref != desc.sref:
      variant.folded.add(describe(inner))
    yield variant

proc leftovers(desc: Description): seq[Description] =
  ## Whatever `spread` could not carry over onto a variant
  if desc.sref.isNil:
    desc.folded
  elif desc.variants.len != 1:
    @[desc]
  else:
    @[]

proc absorb(merged, loser: Variant): Variant =
  ## Keeps a labelled variant a combine discarded where an edge can still find it
  if merged == loser or (loser.sref.isNil and loser.folded.len == 0):
    return merged

  result = merged.clone
  if loser.sref.isNil:
    result.folded.add(loser.folded)
  else:
    result.folded.add(describe(loser))

proc union*(a, b: Description): Description =
  ## Values satisfying either side, keeping each alternative as its own variant
  Description(
    variants: a.spread.toSeq & b.spread.toSeq, folded: a.leftovers & b.leftovers
  )

proc intersect*(a, b: Description): Description =
  ## Values satisfying both sides, distributed over every pair of alternatives
  result = Description(folded: a.leftovers & b.leftovers)
  for left in a.spread:
    for right in b.spread:
      let merged = intersectVariant(left, right)
      if not merged.isNil:
        result.variants.add(merged.absorb(left).absorb(right))

proc relabel*(desc: Description, sref: SchemaRef): Description =
  ## Names a description after the reference it was reached through
  if desc.sref.isNil:
    desc.sref = sref
    return desc

  # Already named, and memoized under that name, so it is copied rather than renamed
  return Description(sref: sref, id: desc.id, variants: desc.variants, folded: @[desc])
