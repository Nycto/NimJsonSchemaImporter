import std/[strformat], types, history

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

proc mergeOrdered(a, b: TypeDef, history: History): TypeDef =
  ## Applies the merge rules that care which of the two types they are handed
  ## Returns `nil` when none of them apply, which is the caller's cue to try again with the
  ## operands swapped rather than every rule having to be written out twice.

  # Every other type is narrower than "any json value at all"
  if a.kind == JsonType:
    return b

  if a.isWildcardObject and b.kind in OBJECT_SHAPED:
    return b

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

  if a.kind == b.kind:
    return a

  raise newException(
    ValueError, fmt"Unable to reconcile {a.kind} with {b.kind} at {history}"
  )
