{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin, sax]

type
  Complex_objectAddress* {.byref.} = object
    street*: string
    city*: string
    state*: string
    postalCode*: string
  Complex_object* {.byref.} = object
    name*: string
    age*: BiggestInt
    address*: Option[Complex_objectAddress]
    hobbies*: seq[string]
proc `=copy`(a: var Complex_objectAddress;
             b: Complex_objectAddress) {.error.}
proc toJsonHook*(source: Complex_objectAddress): JsonNode
proc `=copy`(a: var Complex_object; b: Complex_object) {.
    error.}
proc toJsonHook*(source: Complex_object): JsonNode
proc equals(_: typedesc[Complex_objectAddress]; a, b: Complex_objectAddress): bool =
  equals(typeof(a.street), a.street, b.street) and
      equals(typeof(a.city), a.city, b.city) and
      equals(typeof(a.state), a.state, b.state) and
      equals(typeof(a.postalCode), a.postalCode, b.postalCode)

proc `==`*(a, b: Complex_objectAddress): bool =
  return equals(Complex_objectAddress, a, b)

proc stringify(_: typedesc[Complex_objectAddress]; value: Complex_objectAddress): string =
  stringifyObj("Complex_objectAddress",
               ("street", stringify(typeof(value.street), value.street)),
               ("city", stringify(typeof(value.city), value.city)),
               ("state", stringify(typeof(value.state), value.state)), (
      "postalCode", stringify(typeof(value.postalCode), value.postalCode)))

proc `$`*(value: Complex_objectAddress): string =
  stringify(Complex_objectAddress, value)

proc fromJsonHook*(target: var Complex_objectAddress; source: JsonNode) =
  assert(hasKey(source, "street"),
         "street" & " is missing while decoding " & "Complex_objectAddress")
  target.street = jsonTo(source{"street"}, typeof(target.street))
  assert(hasKey(source, "city"),
         "city" & " is missing while decoding " & "Complex_objectAddress")
  target.city = jsonTo(source{"city"}, typeof(target.city))
  assert(hasKey(source, "state"),
         "state" & " is missing while decoding " & "Complex_objectAddress")
  target.state = jsonTo(source{"state"}, typeof(target.state))
  assert(hasKey(source, "postalCode"),
         "postalCode" & " is missing while decoding " & "Complex_objectAddress")
  target.postalCode = jsonTo(source{"postalCode"}, typeof(target.postalCode))

proc toJsonHook*(source: Complex_objectAddress): JsonNode =
  result = newJObject()
  result{"street"} = newJString(source.street)
  result{"city"} = newJString(source.city)
  result{"state"} = newJString(source.state)
  result{"postalCode"} = newJString(source.postalCode)

proc toStream*(source: Complex_objectAddress; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("street"))
  write(target, ':')
  toStream(source.street, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("city"))
  write(target, ':')
  toStream(source.city, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("state"))
  write(target, ':')
  toStream(source.state, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("postalCode"))
  write(target, ':')
  toStream(source.postalCode, target)
  target.write('}')

proc fromStream*(typ: typedesc[Complex_objectAddress];
                 source: var JsonParser): Complex_objectAddress =
  var seen: set[0 .. 3]
  for key in objectKeys(source):
    case key
    of "street":
      result.street = fromStream(typeof(result.street), source)
      seen.incl(0)
    of "city":
      result.city = fromStream(typeof(result.city), source)
      seen.incl(1)
    of "state":
      result.state = fromStream(typeof(result.state), source)
      seen.incl(2)
    of "postalCode":
      result.postalCode = fromStream(typeof(result.postalCode), source)
      seen.incl(3)
    else:
      skipValue(source)
  assert(card(seen) == 4)

proc equals(_: typedesc[Complex_object]; a, b: Complex_object): bool =
  equals(typeof(a.name), a.name, b.name) and equals(typeof(a.age), a.age, b.age) and
      equals(typeof(a.address), a.address, b.address) and
      equals(typeof(a.hobbies), a.hobbies, b.hobbies)

proc `==`*(a, b: Complex_object): bool =
  return equals(Complex_object, a, b)

proc stringify(_: typedesc[Complex_object]; value: Complex_object): string =
  stringifyObj("Complex_object",
               ("name", stringify(typeof(value.name), value.name)),
               ("age", stringify(typeof(value.age), value.age)),
               ("address", stringify(typeof(value.address), value.address)),
               ("hobbies", stringify(typeof(value.hobbies), value.hobbies)))

proc `$`*(value: Complex_object): string =
  stringify(Complex_object, value)

proc fromJsonHook*(target: var Complex_object; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "Complex_object")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  assert(hasKey(source, "age"),
         "age" & " is missing while decoding " & "Complex_object")
  target.age = jsonTo(source{"age"}, typeof(target.age))
  if hasKey(source, "address") and source{"address"}.kind != JNull:
    target.address = some(jsonTo(source{"address"},
                                 typeof(unsafeGet(target.address))))
  if hasKey(source, "hobbies") and source{"hobbies"}.kind != JNull:
    target.hobbies = jsonTo(source{"hobbies"}, typeof(target.hobbies))

proc toJsonHook*(source: Complex_object): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  result{"age"} = newJInt(source.age)
  if isSome(source.address):
    result{"address"} = toJsonHook(unsafeGet(source.address))
  if len(source.hobbies) > 0:
    result{"hobbies"} = block:
      let cursor {.cursor.} = source.hobbies
      var output = newJArray()
      for entry in cursor:
        output.add(newJString(entry))
      output

proc toStream*(source: Complex_object; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  hasEmitted.writeComma(target)
  write(target, escapeJson("name"))
  write(target, ':')
  toStream(source.name, target)
  hasEmitted.writeComma(target)
  write(target, escapeJson("age"))
  write(target, ':')
  toStream(source.age, target)
  if isSome(source.address):
    hasEmitted.writeComma(target)
    write(target, escapeJson("address"))
    write(target, ':')
    toStream(unsafeGet(source.address), target)
  if len(source.hobbies) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("hobbies"))
    write(target, ':')
    toStream(source.hobbies, target)
  target.write('}')

proc fromStream*(typ: typedesc[Complex_object]; source: var JsonParser): Complex_object =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = fromStream(typeof(result.name), source)
      seen.incl(0)
    of "age":
      result.age = fromStream(typeof(result.age), source)
      seen.incl(1)
    of "address":
      result.address = some(fromStream(typeof(unsafeGet(result.address)), source))
    of "hobbies":
      result.hobbies = fromStream(typeof(result.hobbies), source)
    else:
      skipValue(source)
  assert(card(seen) == 2)
{.pop.}
