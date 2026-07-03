{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin, sax]

type
  EcommerceProductSchema* {.byref.} = object
    name*: Option[string]
    price*: Option[BiggestFloat]
  EcommerceOrderSchema* {.byref.} = object
    orderId*: Option[string]
    items*: seq[EcommerceProductSchema]
proc `=copy`(a: var EcommerceProductSchema;
             b: EcommerceProductSchema) {.error.}
proc toJsonHook*(source: EcommerceProductSchema): JsonNode
proc `=copy`(a: var EcommerceOrderSchema;
             b: EcommerceOrderSchema) {.error.}
proc toJsonHook*(source: EcommerceOrderSchema): JsonNode
proc equals(_: typedesc[EcommerceProductSchema]; a, b: EcommerceProductSchema): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.price), a.price, b.price)

proc `==`*(a, b: EcommerceProductSchema): bool =
  return equals(EcommerceProductSchema, a, b)

proc stringify(_: typedesc[EcommerceProductSchema];
               value: EcommerceProductSchema): string =
  stringifyObj("EcommerceProductSchema",
               ("name", stringify(typeof(value.name), value.name)),
               ("price", stringify(typeof(value.price), value.price)))

proc `$`*(value: EcommerceProductSchema): string =
  stringify(EcommerceProductSchema, value)

proc fromJsonHook*(target: var EcommerceProductSchema; source: JsonNode) =
  if hasKey(source, "name") and source{"name"}.kind != JNull:
    target.name = some(jsonTo(source{"name"}, typeof(unsafeGet(target.name))))
  if hasKey(source, "price") and source{"price"}.kind != JNull:
    target.price = some(jsonTo(source{"price"}, typeof(unsafeGet(target.price))))

proc toJsonHook*(source: EcommerceProductSchema): JsonNode =
  result = newJObject()
  if isSome(source.name):
    result{"name"} = newJString(unsafeGet(source.name))
  if isSome(source.price):
    result{"price"} = newJFloat(unsafeGet(source.price))

proc toStream*(source: EcommerceProductSchema; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.name):
    hasEmitted.writeComma(target)
    write(target, escapeJson("name"))
    write(target, ':')
    toStream(unsafeGet(source.name), target)
  if isSome(source.price):
    hasEmitted.writeComma(target)
    write(target, escapeJson("price"))
    write(target, ':')
    toStream(unsafeGet(source.price), target)
  target.write('}')

proc fromStream*(typ: typedesc[EcommerceProductSchema];
                 source: var JsonParser): EcommerceProductSchema =
  eat(source, tkCurlyLe)
  while source.tok != tkCurlyRi:
    expectString(source)
    let key = source.a
    discard getTok(source)
    eat(source, tkColon)
    case key
    of "name":
      result.name = some(fromStream(typeof(unsafeGet(result.name)), source))
    of "price":
      result.price = some(fromStream(typeof(unsafeGet(result.price)), source))
    else:
      skipValue(source)
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkCurlyRi)
  
proc equals(_: typedesc[EcommerceOrderSchema]; a, b: EcommerceOrderSchema): bool =
  equals(typeof(a.orderId), a.orderId, b.orderId) and
      equals(typeof(a.items), a.items, b.items)

proc `==`*(a, b: EcommerceOrderSchema): bool =
  return equals(EcommerceOrderSchema, a, b)

proc stringify(_: typedesc[EcommerceOrderSchema]; value: EcommerceOrderSchema): string =
  stringifyObj("EcommerceOrderSchema",
               ("orderId", stringify(typeof(value.orderId), value.orderId)),
               ("items", stringify(typeof(value.items), value.items)))

proc `$`*(value: EcommerceOrderSchema): string =
  stringify(EcommerceOrderSchema, value)

proc fromJsonHook*(target: var EcommerceOrderSchema; source: JsonNode) =
  if hasKey(source, "orderId") and source{"orderId"}.kind != JNull:
    target.orderId = some(jsonTo(source{"orderId"},
                                 typeof(unsafeGet(target.orderId))))
  if hasKey(source, "items") and source{"items"}.kind != JNull:
    target.items = jsonTo(source{"items"}, typeof(target.items))

proc toJsonHook*(source: EcommerceOrderSchema): JsonNode =
  result = newJObject()
  if isSome(source.orderId):
    result{"orderId"} = newJString(unsafeGet(source.orderId))
  if len(source.items) > 0:
    result{"items"} = block:
      let cursor {.cursor.} = source.items
      var output = newJArray()
      for entry in cursor:
        output.add(toJsonHook(entry))
      output

proc toStream*(source: EcommerceOrderSchema; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.orderId):
    hasEmitted.writeComma(target)
    write(target, escapeJson("orderId"))
    write(target, ':')
    toStream(unsafeGet(source.orderId), target)
  if len(source.items) > 0:
    hasEmitted.writeComma(target)
    write(target, escapeJson("items"))
    write(target, ':')
    toStream(source.items, target)
  target.write('}')

proc fromStream*(typ: typedesc[EcommerceOrderSchema];
                 source: var JsonParser): EcommerceOrderSchema =
  eat(source, tkCurlyLe)
  while source.tok != tkCurlyRi:
    expectString(source)
    let key = source.a
    discard getTok(source)
    eat(source, tkColon)
    case key
    of "orderId":
      result.orderId = some(fromStream(typeof(unsafeGet(result.orderId)), source))
    of "items":
      result.items = fromStream(typeof(result.items), source)
    else:
      skipValue(source)
    if source.tok == tkComma:
      discard getTok(source)
    else:
      break
  eat(source, tkCurlyRi)
  {.pop.}
