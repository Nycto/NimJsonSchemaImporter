import std/[options, json, tables]

func addBytes[T](target: var string, source: T) =
    let bytes = cast[array[sizeof(source), char]](source)
    for byt in bytes:
        target.add(byt)

func readBytes[T](source: string, idx: var int, kind: typedesc[T]): T =
    var buffer: array[sizeof(T), byte]
    for i in 0..<sizeof(T):
        buffer[i] = cast[seq[byte]](source)[idx + i]
    idx += sizeof(T)
    result = cast[T](buffer)

proc toBinary*(target: var string, source: string) =
    target.addBytes(source.len.int32)
    target.add(source)

proc fromBinary*(_: typedesc[string], source: string, idx: var int): string =
    let len = source.readBytes(idx, int32)
    result = source[idx .. (idx + len - 1)]
    idx += len

proc toBinary*[T](target: var string, source: Option[T]) =
    if source.isSome:
        target.addBytes(true)
        toBinary(target, unsafeGet(source))
    else:
        target.addBytes(false)

proc fromBinary*[T](_: typedesc[Option[T]], source: string, idx: var int): Option[T] =
    if source.readBytes(idx, bool):
        return some(fromBinary(T, source, idx))

proc toBinary*[T](target: var string, source: seq[T]) =
    target.addBytes(source.len.int32)
    for item in source:
        toBinary(target, item)

proc fromBinary*[T](_: typedesc[seq[T]], source: string, idx: var int): seq[T] =
    let len = source.readBytes(idx, int32)
    result = newSeqOfCap[T](len)
    for i in 0..<len:
        result.add(fromBinary(T, source, idx))

proc toBinary*(target: var string, source: SomeNumber | SomeOrdinal) =
    target.addBytes(source)

proc fromBinary*[T : SomeNumber | SomeOrdinal](_: typedesc[T], source: string, idx: var int): T =
    return source.readBytes(idx, T)

type SomeTable[K, V] = Table[K, V] | OrderedTable[K, V]

proc toBinary*[K, V](target: var string, source: SomeTable[K, V]) =
    target.addBytes(source.len.int32)
    for key, value in tables.pairs(source):
        toBinary(target, key)
        toBinary(target, value)

proc fromBinary*[K; V; T : SomeTable[K, V]](_: typedesc[T], source: string, idx: var int): T =
    let size = source.readBytes(idx, int32)

    when T is OrderedTable:
        result = initOrderedTable[K, V](size)
    else:
        result = initTable[K, V](size)

    for _ in 0..<size:
        let key = fromBinary(K, source, idx)
        result[key] = fromBinary(V, source, idx)

proc toBinary*(target: var string, source: JsonNode) =
    target.addBytes(source.kind)
    case source.kind
    of JArray: toBinary(target, source.elems)
    of JInt: toBinary(target, source.getInt.int64)
    of JString: toBinary(target, source.getStr)
    of JObject: toBinary(target, source.fields)
    else: raiseAssert("Can't yet encode json of kind: " & $source.kind)

proc fromBinary*(_: typedesc[JsonNode], source: string, idx: var int): JsonNode =
    let kind = source.readBytes(idx, JsonNodeKind)
    case kind
    of JArray: return JsonNode(kind: kind, elems: fromBinary(seq[JsonNode], source, idx))
    of JInt: return newJInt(fromBinary(int64, source, idx))
    of JString: return newJString(fromBinary(string, source, idx))
    of JObject: return JsonNode(kind: kind, fields: fromBinary(OrderedTable[string, JsonNode], source, idx))
    else: raiseAssert("Can't yet decode json of kind: " & $kind)
