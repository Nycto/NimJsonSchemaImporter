{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/stringify as jsonSchemaStringify
import json_schema_import/private/[equality, bin, sax, empty]

type
  Enum_value_collisionKind* {.pure.} = enum
    BasicAuth = "basicAuth", Feature = "Feature"
  Enum_value_collisionBasicAuth* {.byref.} = object
    user*: Option[string]
  Enum_value_collisionFeature* {.byref.} = object
    name*: Option[string]
  Enum_value_collisionScheme* {.pure.} = enum
    BasicAuth = "basicAuth", Bearer = "bearer"
  Enum_value_collisionMode* {.pure.} = enum
    Mode = "Mode", Other = "other"
  Enum_value_collision* {.byref.} = object
    kind*: Option[Enum_value_collisionKind]
    basicAuth*: Option[Enum_value_collisionBasicAuth]
    feature*: Option[Enum_value_collisionFeature]
    scheme*: Option[Enum_value_collisionScheme]
    mode*: Option[Enum_value_collisionMode]
proc `=copy`(a: var Enum_value_collisionBasicAuth;
             b: Enum_value_collisionBasicAuth) {.error.}
proc `=copy`(a: var Enum_value_collisionFeature;
             b: Enum_value_collisionFeature) {.error.}
proc `=copy`(a: var Enum_value_collision;
             b: Enum_value_collision) {.error.}
proc equals(_: typedesc[Enum_value_collisionBasicAuth];
            a, b: Enum_value_collisionBasicAuth): bool =
  equals(typeof(a.user), a.user, b.user)

proc `==`*(a, b: Enum_value_collisionBasicAuth): bool =
  return equals(Enum_value_collisionBasicAuth, a, b)

proc stringify(_: typedesc[Enum_value_collisionBasicAuth];
               value: Enum_value_collisionBasicAuth): string =
  stringifyObj("Enum_value_collisionBasicAuth",
               ("user", stringify(typeof(value.user), value.user)))

proc `$`*(value: Enum_value_collisionBasicAuth): string =
  stringify(Enum_value_collisionBasicAuth, value)

proc fromJsonHook*(target: var Enum_value_collisionBasicAuth; source: JsonNode) =
  if hasKey(source, "user") and source{"user"}.kind != JNull:
    target.user = some(jsonTo(source{"user"}, typeof(unsafeGet(target.user))))

proc toJsonHook*(source: Enum_value_collisionBasicAuth): JsonNode =
  result = newJObject()
  if isSome(source.user):
    result{"user"} = newJString(unsafeGet(source.user))

proc toStream*(source: Enum_value_collisionBasicAuth; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.user):
    hasEmitted.writeComma(target)
    write(target, escapeJson("user"))
    write(target, ':')
    toStream(unsafeGet(source.user), target)
  target.write('}')

proc fromStream*(typ: typedesc[Enum_value_collisionBasicAuth];
                 source: var JsonParser): Enum_value_collisionBasicAuth =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "user":
      result.user = some(fromStream(typeof(unsafeGet(result.user)), source))
    else:
      skipValue(source)
  assert(card(seen) == 0)

proc equals(_: typedesc[Enum_value_collisionFeature];
            a, b: Enum_value_collisionFeature): bool =
  equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: Enum_value_collisionFeature): bool =
  return equals(Enum_value_collisionFeature, a, b)

proc stringify(_: typedesc[Enum_value_collisionFeature];
               value: Enum_value_collisionFeature): string =
  stringifyObj("Enum_value_collisionFeature",
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: Enum_value_collisionFeature): string =
  stringify(Enum_value_collisionFeature, value)

proc fromJsonHook*(target: var Enum_value_collisionFeature; source: JsonNode) =
  if hasKey(source, "name") and source{"name"}.kind != JNull:
    target.name = some(jsonTo(source{"name"}, typeof(unsafeGet(target.name))))

proc toJsonHook*(source: Enum_value_collisionFeature): JsonNode =
  result = newJObject()
  if isSome(source.name):
    result{"name"} = newJString(unsafeGet(source.name))

proc toStream*(source: Enum_value_collisionFeature; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.name):
    hasEmitted.writeComma(target)
    write(target, escapeJson("name"))
    write(target, ':')
    toStream(unsafeGet(source.name), target)
  target.write('}')

proc fromStream*(typ: typedesc[Enum_value_collisionFeature];
                 source: var JsonParser): Enum_value_collisionFeature =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "name":
      result.name = some(fromStream(typeof(unsafeGet(result.name)), source))
    else:
      skipValue(source)
  assert(card(seen) == 0)

proc equals(_: typedesc[Enum_value_collision]; a, b: Enum_value_collision): bool =
  equals(typeof(a.kind), a.kind, b.kind) and
      equals(typeof(a.basicAuth), a.basicAuth, b.basicAuth) and
      equals(typeof(a.feature), a.feature, b.feature) and
      equals(typeof(a.scheme), a.scheme, b.scheme) and
      equals(typeof(a.mode), a.mode, b.mode)

proc `==`*(a, b: Enum_value_collision): bool =
  return equals(Enum_value_collision, a, b)

proc stringify(_: typedesc[Enum_value_collision]; value: Enum_value_collision): string =
  stringifyObj("Enum_value_collision",
               ("kind", stringify(typeof(value.kind), value.kind)), (
      "basicAuth", stringify(typeof(value.basicAuth), value.basicAuth)),
               ("feature", stringify(typeof(value.feature), value.feature)),
               ("scheme", stringify(typeof(value.scheme), value.scheme)),
               ("mode", stringify(typeof(value.mode), value.mode)))

proc `$`*(value: Enum_value_collision): string =
  stringify(Enum_value_collision, value)

proc fromJsonHook*(target: var Enum_value_collision; source: JsonNode) =
  if hasKey(source, "kind") and source{"kind"}.kind != JNull:
    target.kind = some(jsonTo(source{"kind"}, typeof(unsafeGet(target.kind))))
  if hasKey(source, "basicAuth") and source{"basicAuth"}.kind != JNull:
    target.basicAuth = some(jsonTo(source{"basicAuth"},
                                   typeof(unsafeGet(target.basicAuth))))
  if hasKey(source, "feature") and source{"feature"}.kind != JNull:
    target.feature = some(jsonTo(source{"feature"},
                                 typeof(unsafeGet(target.feature))))
  if hasKey(source, "scheme") and source{"scheme"}.kind != JNull:
    target.scheme = some(jsonTo(source{"scheme"},
                                typeof(unsafeGet(target.scheme))))
  if hasKey(source, "mode") and source{"mode"}.kind != JNull:
    target.mode = some(jsonTo(source{"mode"}, typeof(unsafeGet(target.mode))))

proc toJsonHook*(source: Enum_value_collision): JsonNode =
  result = newJObject()
  if isSome(source.kind):
    result{"kind"} = `%`(unsafeGet(source.kind))
  if isSome(source.basicAuth):
    result{"basicAuth"} = toJsonHook(unsafeGet(source.basicAuth))
  if isSome(source.feature):
    result{"feature"} = toJsonHook(unsafeGet(source.feature))
  if isSome(source.scheme):
    result{"scheme"} = `%`(unsafeGet(source.scheme))
  if isSome(source.mode):
    result{"mode"} = `%`(unsafeGet(source.mode))

proc toStream*(source: Enum_value_collision; target: Stream) =
  var hasEmitted: bool
  target.write('{')
  if isSome(source.kind):
    hasEmitted.writeComma(target)
    write(target, escapeJson("kind"))
    write(target, ':')
    toStream(unsafeGet(source.kind), target)
  if isSome(source.basicAuth):
    hasEmitted.writeComma(target)
    write(target, escapeJson("basicAuth"))
    write(target, ':')
    toStream(unsafeGet(source.basicAuth), target)
  if isSome(source.feature):
    hasEmitted.writeComma(target)
    write(target, escapeJson("feature"))
    write(target, ':')
    toStream(unsafeGet(source.feature), target)
  if isSome(source.scheme):
    hasEmitted.writeComma(target)
    write(target, escapeJson("scheme"))
    write(target, ':')
    toStream(unsafeGet(source.scheme), target)
  if isSome(source.mode):
    hasEmitted.writeComma(target)
    write(target, escapeJson("mode"))
    write(target, ':')
    toStream(unsafeGet(source.mode), target)
  target.write('}')

proc fromStream*(typ: typedesc[Enum_value_collision];
                 source: var JsonParser): Enum_value_collision =
  var seen: set[0 .. 1]
  for key in objectKeys(source):
    case key
    of "kind":
      result.kind = some(fromStream(typeof(unsafeGet(result.kind)), source))
    of "basicAuth":
      result.basicAuth = some(fromStream(typeof(unsafeGet(result.basicAuth)),
          source))
    of "feature":
      result.feature = some(fromStream(typeof(unsafeGet(result.feature)), source))
    of "scheme":
      result.scheme = some(fromStream(typeof(unsafeGet(result.scheme)), source))
    of "mode":
      result.mode = some(fromStream(typeof(unsafeGet(result.mode)), source))
    else:
      skipValue(source)
  assert(card(seen) == 0)

{.pop.}
