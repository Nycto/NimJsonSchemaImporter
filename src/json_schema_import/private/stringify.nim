import std/[tables, options, json], util

proc stringify*(_: typedesc[string], value: string): string
proc stringify*[T : SomeNumber | SomeOrdinal | JsonNode](_: typedesc[T], value: T): string
proc stringify*[T](_: typedesc[Option[T]], value: Option[T]): string
proc stringify*[T](_: typedesc[seq[T]], values: seq[T]): string
proc stringify*[K, V](_: typedesc[SomeTable[K, V]], values: SomeTable[K, V]): string

proc stringify*(_: typedesc[string], value: string): string =
    "\"" & value & "\""

proc stringify*[T : SomeNumber | SomeOrdinal | JsonNode](_: typedesc[T], value: T): string =
    $value

proc stringify*[T](_: typedesc[Option[T]], value: Option[T]): string =
    if value.isSome: stringify(T, value.unsafeGet) else: "∅"

proc stringify*[T](_: typedesc[seq[T]], values: seq[T]): string =
    result = "["
    var isFirst = true
    for entry in values:
        if isFirst:
            isFirst = false
        else:
            result &= ", "
        result &= stringify(T, entry)
    result &= "]"

proc stringify*[K, V](_: typedesc[SomeTable[K, V]], values: SomeTable[K, V]): string =
    result = "{"
    var isFirst = true
    for key, value in pairs(values):
        if isFirst:
            isFirst = false
        else:
            result &= ", "
        result &= stringify(K, key) & ": " & stringify(V, value)
    result &= "}"

proc stringifyObj*(name: string, entries: varargs[(string, string)]): string =
    result = name & "("
    var isFirst = true
    for (key, value) in entries:
        if isFirst:
            isFirst = false
        else:
            result &= ", "
        result &= key & ": " & value
    result &= ")"
