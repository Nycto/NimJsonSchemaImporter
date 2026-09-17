import std/[json, jsonutils, math]

proc expectKind(source: JsonNode, kind: JsonNodeKind) =
  if source.kind != kind:
    raise newException(ValueError, "Expected " & $kind & ", got " & $source.kind)

proc fromJsonHook*(target: var BiggestInt, source: JsonNode) =
  ## Also takes a float with no fractional part, which JSON schema counts as an integer
  if source.kind == JFloat:
    let value = source.getFloat
    if value != value.trunc or value.abs >= 9.2233720368547758e18:
      raise newException(ValueError, "Expected an integer, got " & $value)
    target = BiggestInt(value)
  else:
    source.expectKind(JInt)
    target = source.getBiggestInt

proc fromJsonHook*[T](target: var seq[T], source: JsonNode, opt = Joptions()) =
  source.expectKind(JArray)
  target.setLen(source.len)
  for i, value in source.elems:
    fromJson(target[i], value, opt)
