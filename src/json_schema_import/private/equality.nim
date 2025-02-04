import std/[options, json, tables], util

proc equals*[T : SomeNumber | SomeOrdinal | string | JsonNode](_: typedesc[T]; a, b: T): bool =
    return a == b

proc equals*[T](_: typedesc[seq[T]]; a, b: seq[T]): bool =
    if a.len == b.len:
        for i in 0..<a.len:
            if not equals(T, a[i], b[i]):
                return false
        return true
    else:
        return false

proc equals*[K, V](_: typedesc[SomeTable[K, V]]; a, b: SomeTable[K, V]): bool =
    if a.len == b.len:
        for key, value in pairs(a):
            if not b.hasKey(key) or not equals(V, value, b[key]):
                return false
        return true
    else:
        return false

proc equals*[T](_: typedesc[Option[T]], a, b: Option[T]): bool =
    let aSome = a.isSome
    let bSome = b.isSome
    if aSome and bSome:
        return equals(T, a.unsafeGet, b.unsafeGet)
    else:
        return aSome == bSome