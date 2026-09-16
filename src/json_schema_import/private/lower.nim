import std/[sets, tables, options], types, describe, util

proc lower*(desc: Description): TypeDef

proc lowerObject(variant: Variant): TypeDef =
  # A property list, a required key, or an `additionalProperties` nothing satisfies all
  # fix the keys; otherwise the object is open and a map describes it
  let closed = not variant.additional.isNil and variant.additional.isNever
  if not variant.shaped and variant.required.len == 0 and not closed:
    let entries =
      if variant.additional.isNil:
        TypeDef(kind: JsonType)
      else:
        variant.additional.lower
    return TypeDef(kind: MapType, entries: entries)

  result = TypeDef(kind: ObjType, properties: initOrderedTable[string, PropDef]())
  var seen = initHashSet[string]()
  for key, prop in variant.properties:
    if prop.isNever:
      continue

    let required = key in variant.required
    let typ = prop.lower
    result.properties[key] = (
      propName: key.cleanupIdent.choosePropName(seen),
      typ:
        if required:
          typ
        else:
          typ.optional(),
      required: required,
      nullable: typ.stripNotes.kind == OptionalType,
    )

proc lowerArray(variant: Variant): TypeDef =
  if variant.prefix.isSome:
    result = TypeDef(kind: TupleType)
    for slot in variant.prefix.get:
      result.elements.add(slot.lower)
  elif not variant.items.isNil and variant.items.isNever:
    # Only the empty array satisfies an `items` nothing can, which is a tuple of no slots
    result = TypeDef(kind: TupleType)
  elif variant.items.isNil:
    result = TypeDef(kind: ArrayType, items: TypeDef(kind: JsonType))
  else:
    result = TypeDef(kind: ArrayType, items: variant.items.lower)

proc lower*(variant: Variant): TypeDef =
  ## The Nim type describing a single variant
  result =
    case variant.kind
    of vkNull:
      TypeDef(kind: NullType)
    of vkBool:
      TypeDef(kind: BoolType)
    of vkInteger:
      TypeDef(kind: IntegerType)
    of vkNumber:
      TypeDef(kind: NumberType)
    of vkString:
      if variant.values.isSome:
        TypeDef(kind: EnumType, values: variant.values.get)
      else:
        TypeDef(kind: StringType)
    of vkAny:
      TypeDef(kind: JsonType)
    of vkConst:
      TypeDef(kind: ConstValueType, value: variant.value)
    of vkEdge:
      TypeDef(kind: RefType, schemaRef: variant.target)
    of vkArray:
      lowerArray(variant)
    of vkObject:
      lowerObject(variant)
  result.id = variant.id

proc lower*(desc: Description): TypeDef =
  ## The Nim type describing every variant of a description: nothing, one of them, or a
  ## union choosing between them, made optional when `null` is one of the choices
  var nullable = false
  var seen = initHashSet[TypeDef]()
  var arms: seq[TypeDef]
  for variant in desc.variants:
    if variant.kind == vkNull:
      nullable = true
      continue

    let arm = variant.lower
    if arm notin seen:
      seen.incl(arm)
      arms.add(arm)

  if arms.len == 0:
    return TypeDef(kind: if nullable: NullType else: NeverType, id: desc.id)

  result =
    if arms.len == 1:
      arms[0]
    else:
      TypeDef(kind: UnionType, subtypes: arms, id: desc.id)

  if nullable:
    result = result.optional()
