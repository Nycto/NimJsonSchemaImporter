import std/[sets, tables, strformat, uri], types, history, util

proc collapseUnion*(typ: TypeDef, history: History): TypeDef =
  ## Flattens a union, hoisting nullability out of it
  assert(typ.kind == UnionType)

  if typ.subtypes.len == 0:
    raise newException(ValueError, fmt"Empty union at {history}")
  elif typ.subtypes.len == 1:
    return typ.subtypes[0]

  var nestedUnion = false
  var markOptional = false
  var subtypes: seq[TypeDef]
  for subtype in typ.subtypes:
    case subtype.kind
    of NullType:
      markOptional = true
    of OptionalType:
      markOptional = true
      subtypes.add(subtype.subtype)
    of UnionType:
      nestedUnion = true
      subtypes.add(subtype.subtypes)
    else:
      subtypes.add(subtype)

  return
    if markOptional:
      TypeDef(kind: UnionType, subtypes: subtypes, id: typ.id)
        .collapseUnion(history)
        .optional()
    elif nestedUnion:
      TypeDef(kind: UnionType, subtypes: subtypes, id: typ.id).collapseUnion(history)
    else:
      typ

proc isWildcardObject(typ: TypeDef): bool =
  ## Whether a type is a bare `type: "object"`: a value that has to be an object, with
  ## nothing said about what it holds
  return typ.kind == MapType and typ.entries.kind == JsonType and typ.sref.isNil

const OBJECT_SHAPED = {ObjType, MapType, UnionType}
  ## Kinds that a bare `type: "object"` adds nothing to, because they already describe an
  ## object more precisely than it does

proc mergeTypes*(a, b: TypeDef, history: History): TypeDef

proc mergeIds(a, b: TypeDef): Uri =
  ## Picks the `$id` a merged type is named after
  if a.id == default(Uri): b.id else: a.id

proc mergeUnion(a, b: TypeDef, history: History): TypeDef =
  ## Narrows every arm of a union by whatever the rest of the node says

  # A union of arms is a choice between them, and a constraint written alongside it applies
  # whichever arm is taken, so it distributes over them. Arms that become the same type
  # afterwards are folded together, the way `parseUnion` does with the arms it is given.
  var seen = initHashSet[TypeDef]()
  var subtypes: seq[TypeDef]
  for subtype in a.subtypes:
    let merged = mergeTypes(subtype, b, history)
    if merged notin seen:
      seen.incl(merged)
      subtypes.add(merged)

  return TypeDef(kind: UnionType, subtypes: subtypes, id: mergeIds(a, b)).collapseUnion(
    history
  )

proc mergeProps(a, b: PropDef, history: History, seen: var HashSet[string]): PropDef =
  let required = a.required or b.required
  let typ = mergeTypes(a.typ, b.typ, history.add(a.propName))

  let finalTyp =
    if not required:
      typ.optional()
    elif typ.kind == OptionalType:
      typ.subtype
    else:
      typ
  return (
    propName: a.propName.cleanupIdent.choosePropName(seen),
    typ: finalTyp,
    required: required,
  )

proc mergeObjects(a, b: TypeDef, history: History): TypeDef =
  ## Intersects two object descriptions of the same node
  var properties = initOrderedTable[string, PropDef]()
  var seen = initHashSet[string]()

  proc addProperty(key: auto) =
    if key notin properties:
      properties[key] =
        if key notin a.properties:
          b.properties[key]
        elif key notin b.properties:
          a.properties[key]
        else:
          mergeProps(a.properties[key], b.properties[key], history, seen)

  for key in a.properties.keys:
    addProperty(key)

  for key in b.properties.keys:
    addProperty(key)

  return TypeDef(kind: ObjType, properties: properties, id: mergeIds(a, b))

proc mergeOrdered(a, b: TypeDef, history: History): TypeDef =
  ## Applies the merge rules that care which of the two types they are handed
  ## Returns `nil` when none of them apply, which is the caller's cue to try again with the
  ## operands swapped rather than every rule having to be written out twice.

  # Every other type is narrower than "any json value at all"
  if a.kind == JsonType:
    return b

  # Nullability describes the value as a whole rather than any one keyword, so it comes back
  # out to the front once the types underneath it have been reconciled. This has to be tried
  # ahead of the object rules below, which would otherwise discard the `null`.
  if a.kind == OptionalType:
    return mergeTypes(a.subtype, b, history).optional()

  if a.isWildcardObject and b.kind in OBJECT_SHAPED:
    return b

  if a.kind == UnionType:
    return mergeUnion(a, b, history)

  # A single fixed value is as narrow as a type can get
  if a.kind == ConstValueType:
    return a

  # An enum is a set of strings, so it already satisfies being a string
  if a.kind == EnumType and b.kind == StringType:
    return a

  return nil

proc mergeTypes*(a, b: TypeDef, history: History): TypeDef =
  ## Intersects two interpretations of the same schema node

  result = mergeOrdered(a, b, history)
  if not result.isNil:
    return

  result = mergeOrdered(b, a, history)
  if not result.isNil:
    return

  if a.kind == ObjType and b.kind == ObjType:
    return mergeObjects(a, b, history)

  # A pair of containers is narrowed by narrowing what they hold
  if a.kind == ArrayType and b.kind == ArrayType:
    return TypeDef(
      kind: ArrayType,
      items: mergeTypes(a.items, b.items, history.add("items")),
      id: mergeIds(a, b),
    )
  if a.kind == MapType and b.kind == MapType:
    return TypeDef(
      kind: MapType,
      entries: mergeTypes(a.entries, b.entries, history.add("additionalProperties")),
      id: mergeIds(a, b),
    )

  if a.kind == b.kind:
    return a

  raise newException(
    ValueError, fmt"Unable to reconcile {a.kind} with {b.kind} at {history}"
  )
