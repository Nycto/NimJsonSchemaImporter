{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax]

type
  Nullable_mergeNullableEnum* = enum
    Alpha = "alpha", Beta = "beta"
  Nullable_mergeNullableObject* {.byref.} = object
    inner*: string
  Nullable_merge* {.byref.} = object
    nullableEnum*: Option[Nullable_mergeNullableEnum]
    nullableScalar*: Option[string]
    nullableObject*: Nullable_mergeNullableObject
proc `=copy`(a: var Nullable_mergeNullableObject;
             b: Nullable_mergeNullableObject) {.error.}
proc toJsonHook*(source: Nullable_mergeNullableObject): JsonNode
proc `=copy`(a: var Nullable_merge; b: Nullable_merge) {.
    error.}
proc toJsonHook*(source: Nullable_merge): JsonNode
proc equals(_: typedesc[Nullable_mergeNullableObject];
            a, b: Nullable_mergeNullableObject): bool =
  equals(typeof(a.inner), a.inner, b.inner)

proc `==`*(a, b: Nullable_mergeNullableObject): bool =
  return equals(Nullable_mergeNullableObject, a, b)

proc stringify(_: typedesc[Nullable_mergeNullableObject];
               value: Nullable_mergeNullableObject): string =
  stringifyObj("Nullable_mergeNullableObject",
               ("inner", stringify(typeof(value.inner), value.inner)))

proc `$`*(value: Nullable_mergeNullableObject): string =
  stringify(Nullable_mergeNullableObject, value)

proc fromJsonHook*(target: var Nullable_mergeNullableObject; source: JsonNode) =
  assert(hasKey(source, "inner"), "inner" & " is missing while decoding " &
      "Nullable_mergeNullableObject")
  target.inner = jsonTo(source{"inner"}, typeof(target.inner))

proc toJsonHook*(source: Nullable_mergeNullableObject): JsonNode =
  result = newJObject()
  result{"inner"} = newJString(source.inner)

proc toStream*(source: Nullable_mergeNullableObject; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("inner"))
  write(target, ':')
  toStream(source.inner, target)
  target.write('}')

proc fromStream*(typ: typedesc[Nullable_mergeNullableObject];
                 source: var JsonParser): Nullable_mergeNullableObject =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "inner":
      result.inner = fromStream(typeof(result.inner), source)
      seen.incl(0)
    else:
      skipValue(source)
  assert(card(seen) == 1)

proc equals(_: typedesc[Nullable_merge]; a, b: Nullable_merge): bool =
  equals(typeof(a.nullableEnum), a.nullableEnum, b.nullableEnum) and
      equals(typeof(a.nullableScalar), a.nullableScalar, b.nullableScalar) and
      equals(typeof(a.nullableObject), a.nullableObject, b.nullableObject)

proc `==`*(a, b: Nullable_merge): bool =
  return equals(Nullable_merge, a, b)

proc stringify(_: typedesc[Nullable_merge]; value: Nullable_merge): string =
  stringifyObj("Nullable_merge", ("nullableEnum", stringify(
      typeof(value.nullableEnum), value.nullableEnum)), ("nullableScalar",
      stringify(typeof(value.nullableScalar), value.nullableScalar)), (
      "nullableObject",
      stringify(typeof(value.nullableObject), value.nullableObject)))

proc `$`*(value: Nullable_merge): string =
  stringify(Nullable_merge, value)

proc fromJsonHook*(target: var Nullable_merge; source: JsonNode) =
  assert(hasKey(source, "nullableEnum"),
         "nullableEnum" & " is missing while decoding " & "Nullable_merge")
  target.nullableEnum = jsonTo(source{"nullableEnum"},
                               typeof(target.nullableEnum))
  assert(hasKey(source, "nullableScalar"),
         "nullableScalar" & " is missing while decoding " & "Nullable_merge")
  target.nullableScalar = jsonTo(source{"nullableScalar"},
                                 typeof(target.nullableScalar))
  assert(hasKey(source, "nullableObject"),
         "nullableObject" & " is missing while decoding " & "Nullable_merge")
  target.nullableObject = jsonTo(source{"nullableObject"},
                                 typeof(target.nullableObject))

proc toJsonHook*(source: Nullable_merge): JsonNode =
  result = newJObject()
  result{"nullableEnum"} = if isSome(source.nullableEnum):
    `%`(unsafeGet(source.nullableEnum))
  else:
    newJNull()
  result{"nullableScalar"} = if isSome(source.nullableScalar):
    newJString(unsafeGet(source.nullableScalar))
  else:
    newJNull()
  result{"nullableObject"} = toJsonHook(source.nullableObject)

proc toStream*(source: Nullable_merge; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("nullableEnum"))
  write(target, ':')
  toStream(source.nullableEnum, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("nullableScalar"))
  write(target, ':')
  toStream(source.nullableScalar, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("nullableObject"))
  write(target, ':')
  toStream(source.nullableObject, target)
  target.write('}')

proc fromStream*(typ: typedesc[Nullable_merge];
                 source: var JsonParser): Nullable_merge =
  var seen: set[0 .. 2]
  for key in objectKeys(source):
    case key
    of "nullableEnum":
      result.nullableEnum = fromStream(typeof(result.nullableEnum), source)
      seen.incl(0)
    of "nullableScalar":
      result.nullableScalar = fromStream(typeof(result.nullableScalar), source)
      seen.incl(1)
    of "nullableObject":
      result.nullableObject = fromStream(typeof(result.nullableObject), source)
      seen.incl(2)
    else:
      skipValue(source)
  assert(card(seen) == 3)

{.pop.}
