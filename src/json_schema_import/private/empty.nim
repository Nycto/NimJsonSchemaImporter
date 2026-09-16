import std/json

type Empty* = distinct pointer ## The in-memory form of a JSON `null`

proc fromJsonHook*(target: var Empty, source: JsonNode) =
  if source.kind != JNull:
    raise newException(ValueError, "Expected null, got " & $source.kind)

proc toJsonHook*(source: Empty): JsonNode =
  newJNull()
