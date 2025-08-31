import std/[options, json, tables]

iterator eachByte(source: string, idx: var int, kind: typedesc): (int, byte) =
  ## Iterates over each byte of a value in the source string.
  for i in 0 ..< sizeof(kind):
    yield (i, source[idx + i].byte)
  idx += sizeof(kind)

proc toBinary*(target: var string, source: bool) =
  ## Serializes a boolean value into binary format and appends it to the target string.
  target.add(source.char)

proc fromBinary*(_: typedesc[bool], source: string, idx: var int): bool =
  ## Deserializes a boolean value from binary format in the source string.
  for _, byt in eachByte(source, idx, bool):
    result = bool(byt)

proc toBinary*[T: SomeInteger](target: var string, source: T) =
  ## Serializes an integer value into binary format and appends it to the target string.
  for i in countdown(sizeof(T) - 1, 0):
    let byt = (source shr (i * 8)) and 0xFF
    target.add(byt.char)

proc fromBinary*[T: SomeInteger](_: typedesc[T], source: string, idx: var int): T =
  ## Deserializes an integer value from binary format in the source string.
  result = 0
  for i, byt in eachByte(source, idx, T):
    let position = sizeof(T) - 1 - i
    result = result or (cast[T](byt) shl (position * 8))

proc toBinary*[T: enum](target: var string, source: T) =
  ## Serializes an enum value into binary format and appends it to the target string.
  toBinary(target, source.int16)

proc fromBinary*[T: enum](_: typedesc[T], source: string, idx: var int): T =
  ## Deserializes an enum value from binary format in the source string.
  T(fromBinary(int16, source, idx))

proc toBinary*(target: var string, source: string) =
  ## Serializes a string into binary format and appends it to the target string.
  toBinary(target, source.len.int32)
  target.add(source)

proc fromBinary*(_: typedesc[string], source: string, idx: var int): string =
  ## Deserializes a string from binary format in the source string.
  let len = fromBinary(int32, source, idx)
  result = source[idx .. (idx + len - 1)]
  idx += len

proc toBinary*[T](target: var string, source: Option[T]) =
  ## Serializes an optional value into binary format and appends it to the target string.
  if source.isSome:
    toBinary(target, true)
    toBinary(target, unsafeGet(source))
  else:
    toBinary(target, false)

proc fromBinary*[T](_: typedesc[Option[T]], source: string, idx: var int): Option[T] =
  ## Deserializes an optional value from binary format in the source string.
  let isSome = fromBinary(bool, source, idx)
  if isSome:
    return some(fromBinary(T, source, idx))

proc toBinary*[T](target: var string, source: seq[T]) =
  ## Serializes a sequence into binary format and appends it to the target string.
  toBinary(target, source.len.int32)
  for item in source:
    toBinary(target, item)

proc fromBinary*[T](_: typedesc[seq[T]], source: string, idx: var int): seq[T] =
  ## Deserializes a sequence from binary format in the source string.
  let len = fromBinary(int32, source, idx)
  result = newSeqOfCap[T](len)
  for i in 0 ..< len:
    result.add(fromBinary(T, source, idx))

proc toBinary*(target: var string, source: float32) =
  ## Serializes a 32-bit floating-point value into binary format and appends it to the target string.
  toBinary(target, cast[uint32](source))

proc fromBinary*(_: typedesc[float32], source: string, idx: var int): float32 =
  ## Deserializes a 32-bit floating-point value from binary format in the source string.
  cast[float32](fromBinary(uint32, source, idx))

proc toBinary*(target: var string, source: float64) =
  ## Serializes a 64-bit floating-point value into binary format and appends it to the target string.
  toBinary(target, cast[uint64](source))

proc fromBinary*(_: typedesc[float64], source: string, idx: var int): float64 =
  ## Deserializes a 64-bit floating-point value from binary format in the source string.
  cast[float64](fromBinary(uint64, source, idx))

type SomeTable[K, V] = Table[K, V] | OrderedTable[K, V]
  ## A type alias for tables, supporting both `Table` and `OrderedTable`.

proc tableToBinary[K, V](target: var string, source: SomeTable[K, V]) =
  ## Serializes a table into binary format and appends it to the target string.
  toBinary(target, source.len.int32)
  for key in tables.keys(source):
    toBinary(target, key)
    toBinary(target, source[key])

proc tableFromBinary[K; V; T: SomeTable[K, V]](
    _: typedesc[T], source: string, idx: var int
): T =
  ## Deserializes a table from binary format in the source string.
  let size = fromBinary(int32, source, idx)

  when T is OrderedTable:
    result = initOrderedTable[K, V](size)
  else:
    result = initTable[K, V](size)

  for _ in 0 ..< size:
    let key = fromBinary(K, source, idx)
    result[key] = fromBinary(V, source, idx)

proc toBinary*[T: object | tuple](target: var string, source: T) =
  ## Serializes an object or tuple into binary format and appends it to the target string.
  when T is SomeTable:
    tableToBinary(target, source)
  else:
    for _, value in source.fieldPairs:
      toBinary(target, value)

proc fromBinary*[T: object | tuple](_: typedesc[T], source: string, idx: var int): T =
  ## Deserializes an object or tuple from binary format in the source string.
  when T is SomeTable:
    return tableFromBinary(T, source, idx)
  else:
    for _, value in result.fieldPairs:
      value = fromBinary(typeof(value), source, idx)

proc toBinary*[T: ref object | ref tuple](target: var string, source: T) =
  ## Serializes a reference object or tuple into binary format and appends it to the target string.
  toBinary(target, source[])

proc fromBinary*[T: ref object | ref tuple](
    _: typedesc[T], source: string, idx: var int
): T =
  ## Deserializes a reference object or tuple from binary format in the source string.
  result = new(T)
  for _, value in result[].fieldPairs:
    value = fromBinary(typeof(value), source, idx)

proc toBinary*(target: var string, source: JsonNode) =
  ## Serializes a JSON node into binary format and appends it to the target string.
  toBinary(target, source.kind)
  case source.kind
  of JArray:
    toBinary(target, source.elems)
  of JInt:
    toBinary(target, source.getInt.int64)
  of JFloat:
    toBinary(target, source.getFloat.float64)
  of JString:
    toBinary(target, source.getStr)
  of JObject:
    toBinary(target, source.fields)
  of JNull:
    discard
  of JBool:
    toBinary(target, source.getBool)

proc fromBinary*(_: typedesc[JsonNode], source: string, idx: var int): JsonNode =
  ## Deserializes a JSON node from binary format in the source string.
  let kind = fromBinary(JsonNodeKind, source, idx)
  case kind
  of JArray:
    return JsonNode(kind: kind, elems: fromBinary(seq[JsonNode], source, idx))
  of JInt:
    return newJInt(fromBinary(int64, source, idx))
  of JFloat:
    return newJFloat(fromBinary(float64, source, idx))
  of JString:
    return newJString(fromBinary(string, source, idx))
  of JObject:
    return JsonNode(
      kind: kind, fields: fromBinary(OrderedTable[string, JsonNode], source, idx)
    )
  of JNull:
    return newJNull()
  of JBool:
    return newJBool(fromBinary(bool, source, idx))

proc toBinary*[T](source: T): string =
  ## Serializes a value into binary format and returns it as a string.
  toBinary(result, source)

proc fromBinary*(typ: typedesc, source: string): typ =
  ## Deserializes a value from binary format in the source string.
  var idx = 0
  return fromBinary(typ, source, idx)
