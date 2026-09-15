import std/[tables, options, json], util

proc stringify*(_: typedesc[string], value: string): string
proc stringify*[T: SomeNumber | SomeOrdinal](_: typedesc[T], value: T): string
proc stringify*(_: typedesc[JsonNode], value: JsonNode): string
proc stringify*[T](_: typedesc[ref T], value: ref T): string

proc stringify*[T](_: typedesc[Option[T]], value: Option[T]): string
proc stringify*[T](_: typedesc[seq[T]], values: seq[T]): string
proc stringify*[K, V](_: typedesc[SomeTable[K, V]], values: SomeTable[K, V]): string
proc stringify*[T: tuple](_: typedesc[T], value: T): string

proc stringify*(_: typedesc[string], value: string): string =
  "\"" & value & "\""

proc stringify*[T: SomeNumber | SomeOrdinal](_: typedesc[T], value: T): string =
  $value

proc stringify*(_: typedesc[JsonNode], value: JsonNode): string =
  ## Concrete so that `JsonNode`, itself a `ref object`, outranks the `ref T` overload
  $value

proc stringify*[T](_: typedesc[ref T], value: ref T): string =
  ## A recursive schema generates a `ref`, and nil is how it bottoms out
  if value.isNil:
    "nil"
  else:
    stringify(T, value[])

proc stringify*[T](_: typedesc[Option[T]], value: Option[T]): string =
  if value.isSome:
    stringify(T, value.unsafeGet)
  else:
    "∅"

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
  for key in keys(values):
    if isFirst:
      isFirst = false
    else:
      result &= ", "
    result &= stringify(K, key) & ": " & stringify(V, values[key])
  result &= "}"

proc stringify*[T: tuple](_: typedesc[T], value: T): string =
  ## Prints a tuple the way the schema describes it: a fixed length list of values, each
  ## with a type of its own
  result = "("
  var isFirst = true
  for field in value.fields:
    if isFirst:
      isFirst = false
    else:
      result &= ", "
    result &= stringify(typeof(field), field)
  result &= ")"

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
