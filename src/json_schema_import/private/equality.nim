import std/[options, json, tables], util

proc equals*[T: SomeNumber | SomeOrdinal | string](_: typedesc[T], a, b: T): bool =
  return a == b

proc equals*(_: typedesc[JsonNode], a, b: JsonNode): bool =
  ## Concrete so that `JsonNode`, itself a `ref object`, outranks the `ref T` overload
  return a == b

proc equals*[T](_: typedesc[ref T], a, b: ref T): bool =
  ## A recursive schema generates a `ref`, and nil is how it bottoms out
  if a.isNil or b.isNil:
    return a.isNil == b.isNil
  return equals(T, a[], b[])

proc equals*[T](_: typedesc[seq[T]], a, b: seq[T]): bool =
  if a.len == b.len:
    for i in 0 ..< a.len:
      if not equals(T, a[i], b[i]):
        return false
    return true
  else:
    return false

proc equals*[K, V](_: typedesc[SomeTable[K, V]], a, b: SomeTable[K, V]): bool =
  if a.len == b.len:
    for key in keys(a):
      if not b.hasKey(key) or not equals(V, a[key], b[key]):
        return false
    return true
  else:
    return false

proc equals*[T: tuple](_: typedesc[T], a, b: T): bool =
  for x, y in fields(a, b):
    if not equals(typeof(x), x, y):
      return false
  return true

proc equals*[T](_: typedesc[Option[T]], a, b: Option[T]): bool =
  let aSome = a.isSome
  let bSome = b.isSome
  if aSome and bSome:
    return equals(T, a.unsafeGet, b.unsafeGet)
  else:
    return aSome == bSome
