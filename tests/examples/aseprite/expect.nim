{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  AsepriteRectangle* {.byref.} = object
    h*: BiggestFloat
    w*: BiggestFloat
    x*: BiggestFloat
    y*: BiggestFloat
  AsepriteSize* {.byref.} = object
    h*: BiggestFloat
    w*: BiggestFloat
  AsepriteFrame* {.byref.} = object
    duration*: BiggestFloat
    frame*: AsepriteRectangle
    rotated*: bool
    sourceSize*: AsepriteSize
    spriteSourceSize*: AsepriteRectangle
    trimmed*: bool
  AsepriteArrayFrame* {.byref.} = object
    duration*: BiggestFloat
    filename*: string
    frame*: AsepriteRectangle
    rotated*: bool
    sourceSize*: AsepriteSize
    spriteSourceSize*: AsepriteRectangle
    trimmed*: bool
  AsepriteUnion* {.byref.} = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: OrderedTable[string, AsepriteFrame]
    of 1:
      key1*: seq[AsepriteArrayFrame]
  AsepriteFormat* = enum
    RGBA8888 = "RGBA8888", I8 = "I8"
  AsepriteDirection* = enum
    Forward = "forward", Reverse = "reverse", Pingpong = "pingpong"
  AsepriteFrameTag* {.byref.} = object
    direction*: AsepriteDirection
    `from`*: BiggestFloat
    name*: string
    to*: BiggestFloat
  AsepriteBlendMode* = enum
    Normal = "normal", Darken = "darken", Multiply = "multiply",
    Color_burn = "color_burn", Lighten = "lighten", Screen = "screen",
    Color_dodge = "color_dodge", Addition = "addition", Overlay = "overlay",
    Soft_light = "soft_light", Hard_light = "hard_light",
    Difference = "difference", Exclusion = "exclusion", Subtract = "subtract",
    Divide = "divide", Hsl_hue = "hsl_hue", Hsl_saturation = "hsl_saturation",
    Hsl_color = "hsl_color", Hsl_luminosity = "hsl_luminosity"
  AsepriteLayer* {.byref.} = object
    blendMode*: Option[AsepriteBlendMode]
    color*: Option[string]
    data*: Option[string]
    group*: Option[string]
    name*: string
    opacity*: Option[BiggestFloat]
  AsepritePoint* {.byref.} = object
    x*: BiggestFloat
    y*: BiggestFloat
  AsepriteSliceKey* {.byref.} = object
    bounds*: AsepriteRectangle
    center*: Option[AsepriteRectangle]
    frame*: BiggestFloat
    pivot*: Option[AsepritePoint]
  AsepriteSlice* {.byref.} = object
    color*: Option[string]
    data*: Option[string]
    keys*: seq[AsepriteSliceKey]
    name*: string
  AsepriteMeta* {.byref.} = object
    app*: string
    format*: AsepriteFormat
    frameTags*: Option[seq[AsepriteFrameTag]]
    image*: string
    layers*: Option[seq[AsepriteLayer]]
    scale*: string
    size*: AsepriteSize
    slices*: Option[seq[AsepriteSlice]]
    version*: string
  AsepriteSpriteSheet* {.byref.} = object
    frames*: AsepriteUnion
    meta*: AsepriteMeta
proc `=copy`(a: var AsepriteRectangle;
             b: AsepriteRectangle) {.error.}
proc toJsonHook*(source: AsepriteRectangle): JsonNode
proc `=copy`(a: var AsepriteSize; b: AsepriteSize) {.error.}
proc toJsonHook*(source: AsepriteSize): JsonNode
proc `=copy`(a: var AsepriteFrame; b: AsepriteFrame) {.
    error.}
proc toJsonHook*(source: AsepriteFrame): JsonNode
proc `=copy`(a: var AsepriteArrayFrame;
             b: AsepriteArrayFrame) {.error.}
proc toJsonHook*(source: AsepriteArrayFrame): JsonNode
proc `=copy`(a: var AsepriteFrameTag; b: AsepriteFrameTag) {.
    error.}
proc toJsonHook*(source: AsepriteFrameTag): JsonNode
proc `=copy`(a: var AsepriteLayer; b: AsepriteLayer) {.
    error.}
proc toJsonHook*(source: AsepriteLayer): JsonNode
proc `=copy`(a: var AsepritePoint; b: AsepritePoint) {.
    error.}
proc toJsonHook*(source: AsepritePoint): JsonNode
proc `=copy`(a: var AsepriteSliceKey; b: AsepriteSliceKey) {.
    error.}
proc toJsonHook*(source: AsepriteSliceKey): JsonNode
proc `=copy`(a: var AsepriteSlice; b: AsepriteSlice) {.
    error.}
proc toJsonHook*(source: AsepriteSlice): JsonNode
proc `=copy`(a: var AsepriteMeta; b: AsepriteMeta) {.error.}
proc toJsonHook*(source: AsepriteMeta): JsonNode
proc `=copy`(a: var AsepriteSpriteSheet;
             b: AsepriteSpriteSheet) {.error.}
proc toJsonHook*(source: AsepriteSpriteSheet): JsonNode
proc equals(_: typedesc[AsepriteRectangle]; a, b: AsepriteRectangle): bool =
  equals(typeof(a.h), a.h, b.h) and equals(typeof(a.w), a.w, b.w) and
      equals(typeof(a.x), a.x, b.x) and
      equals(typeof(a.y), a.y, b.y)

proc `==`*(a, b: AsepriteRectangle): bool =
  return equals(AsepriteRectangle, a, b)

proc stringify(_: typedesc[AsepriteRectangle]; value: AsepriteRectangle): string =
  stringifyObj("AsepriteRectangle", ("h", stringify(typeof(value.h), value.h)),
               ("w", stringify(typeof(value.w), value.w)),
               ("x", stringify(typeof(value.x), value.x)),
               ("y", stringify(typeof(value.y), value.y)))

proc `$`*(value: AsepriteRectangle): string =
  stringify(AsepriteRectangle, value)

proc fromJsonHook*(target: var AsepriteRectangle; source: JsonNode) =
  assert(hasKey(source, "h"),
         "h" & " is missing while decoding " & "AsepriteRectangle")
  target.h = jsonTo(source{"h"}, typeof(target.h))
  assert(hasKey(source, "w"),
         "w" & " is missing while decoding " & "AsepriteRectangle")
  target.w = jsonTo(source{"w"}, typeof(target.w))
  assert(hasKey(source, "x"),
         "x" & " is missing while decoding " & "AsepriteRectangle")
  target.x = jsonTo(source{"x"}, typeof(target.x))
  assert(hasKey(source, "y"),
         "y" & " is missing while decoding " & "AsepriteRectangle")
  target.y = jsonTo(source{"y"}, typeof(target.y))

proc toJsonHook*(source: AsepriteRectangle): JsonNode =
  result = newJObject()
  result{"h"} = newJFloat(source.h)
  result{"w"} = newJFloat(source.w)
  result{"x"} = newJFloat(source.x)
  result{"y"} = newJFloat(source.y)

proc equals(_: typedesc[AsepriteSize]; a, b: AsepriteSize): bool =
  equals(typeof(a.h), a.h, b.h) and equals(typeof(a.w), a.w, b.w)

proc `==`*(a, b: AsepriteSize): bool =
  return equals(AsepriteSize, a, b)

proc stringify(_: typedesc[AsepriteSize]; value: AsepriteSize): string =
  stringifyObj("AsepriteSize", ("h", stringify(typeof(value.h), value.h)),
               ("w", stringify(typeof(value.w), value.w)))

proc `$`*(value: AsepriteSize): string =
  stringify(AsepriteSize, value)

proc fromJsonHook*(target: var AsepriteSize; source: JsonNode) =
  assert(hasKey(source, "h"),
         "h" & " is missing while decoding " & "AsepriteSize")
  target.h = jsonTo(source{"h"}, typeof(target.h))
  assert(hasKey(source, "w"),
         "w" & " is missing while decoding " & "AsepriteSize")
  target.w = jsonTo(source{"w"}, typeof(target.w))

proc toJsonHook*(source: AsepriteSize): JsonNode =
  result = newJObject()
  result{"h"} = newJFloat(source.h)
  result{"w"} = newJFloat(source.w)

proc equals(_: typedesc[AsepriteFrame]; a, b: AsepriteFrame): bool =
  equals(typeof(a.duration), a.duration, b.duration) and
      equals(typeof(a.frame), a.frame, b.frame) and
      equals(typeof(a.rotated), a.rotated, b.rotated) and
      equals(typeof(a.sourceSize), a.sourceSize, b.sourceSize) and
      equals(typeof(a.spriteSourceSize), a.spriteSourceSize, b.spriteSourceSize) and
      equals(typeof(a.trimmed), a.trimmed, b.trimmed)

proc `==`*(a, b: AsepriteFrame): bool =
  return equals(AsepriteFrame, a, b)

proc stringify(_: typedesc[AsepriteFrame]; value: AsepriteFrame): string =
  stringifyObj("AsepriteFrame", ("duration", stringify(typeof(value.duration),
      value.duration)), ("frame", stringify(typeof(value.frame), value.frame)),
               ("rotated", stringify(typeof(value.rotated), value.rotated)), (
      "sourceSize", stringify(typeof(value.sourceSize), value.sourceSize)), (
      "spriteSourceSize",
      stringify(typeof(value.spriteSourceSize), value.spriteSourceSize)),
               ("trimmed", stringify(typeof(value.trimmed), value.trimmed)))

proc `$`*(value: AsepriteFrame): string =
  stringify(AsepriteFrame, value)

proc fromJsonHook*(target: var AsepriteFrame; source: JsonNode) =
  assert(hasKey(source, "duration"),
         "duration" & " is missing while decoding " & "AsepriteFrame")
  target.duration = jsonTo(source{"duration"}, typeof(target.duration))
  assert(hasKey(source, "frame"),
         "frame" & " is missing while decoding " & "AsepriteFrame")
  target.frame = jsonTo(source{"frame"}, typeof(target.frame))
  assert(hasKey(source, "rotated"),
         "rotated" & " is missing while decoding " & "AsepriteFrame")
  target.rotated = jsonTo(source{"rotated"}, typeof(target.rotated))
  assert(hasKey(source, "sourceSize"),
         "sourceSize" & " is missing while decoding " & "AsepriteFrame")
  target.sourceSize = jsonTo(source{"sourceSize"}, typeof(target.sourceSize))
  assert(hasKey(source, "spriteSourceSize"),
         "spriteSourceSize" & " is missing while decoding " & "AsepriteFrame")
  target.spriteSourceSize = jsonTo(source{"spriteSourceSize"},
                                   typeof(target.spriteSourceSize))
  assert(hasKey(source, "trimmed"),
         "trimmed" & " is missing while decoding " & "AsepriteFrame")
  target.trimmed = jsonTo(source{"trimmed"}, typeof(target.trimmed))

proc toJsonHook*(source: AsepriteFrame): JsonNode =
  result = newJObject()
  result{"duration"} = newJFloat(source.duration)
  result{"frame"} = toJsonHook(source.frame)
  result{"rotated"} = newJBool(source.rotated)
  result{"sourceSize"} = toJsonHook(source.sourceSize)
  result{"spriteSourceSize"} = toJsonHook(source.spriteSourceSize)
  result{"trimmed"} = newJBool(source.trimmed)

converter forAsepriteUnion*(value: OrderedTable[string, AsepriteFrame]): AsepriteUnion =
  return AsepriteUnion(kind: 0, key0: value)

proc equals(_: typedesc[AsepriteArrayFrame]; a, b: AsepriteArrayFrame): bool =
  equals(typeof(a.duration), a.duration, b.duration) and
      equals(typeof(a.filename), a.filename, b.filename) and
      equals(typeof(a.frame), a.frame, b.frame) and
      equals(typeof(a.rotated), a.rotated, b.rotated) and
      equals(typeof(a.sourceSize), a.sourceSize, b.sourceSize) and
      equals(typeof(a.spriteSourceSize), a.spriteSourceSize, b.spriteSourceSize) and
      equals(typeof(a.trimmed), a.trimmed, b.trimmed)

proc `==`*(a, b: AsepriteArrayFrame): bool =
  return equals(AsepriteArrayFrame, a, b)

proc stringify(_: typedesc[AsepriteArrayFrame]; value: AsepriteArrayFrame): string =
  stringifyObj("AsepriteArrayFrame", ("duration", stringify(
      typeof(value.duration), value.duration)), ("filename",
      stringify(typeof(value.filename), value.filename)),
               ("frame", stringify(typeof(value.frame), value.frame)),
               ("rotated", stringify(typeof(value.rotated), value.rotated)), (
      "sourceSize", stringify(typeof(value.sourceSize), value.sourceSize)), (
      "spriteSourceSize",
      stringify(typeof(value.spriteSourceSize), value.spriteSourceSize)),
               ("trimmed", stringify(typeof(value.trimmed), value.trimmed)))

proc `$`*(value: AsepriteArrayFrame): string =
  stringify(AsepriteArrayFrame, value)

proc fromJsonHook*(target: var AsepriteArrayFrame; source: JsonNode) =
  assert(hasKey(source, "duration"),
         "duration" & " is missing while decoding " & "AsepriteArrayFrame")
  target.duration = jsonTo(source{"duration"}, typeof(target.duration))
  assert(hasKey(source, "filename"),
         "filename" & " is missing while decoding " & "AsepriteArrayFrame")
  target.filename = jsonTo(source{"filename"}, typeof(target.filename))
  assert(hasKey(source, "frame"),
         "frame" & " is missing while decoding " & "AsepriteArrayFrame")
  target.frame = jsonTo(source{"frame"}, typeof(target.frame))
  assert(hasKey(source, "rotated"),
         "rotated" & " is missing while decoding " & "AsepriteArrayFrame")
  target.rotated = jsonTo(source{"rotated"}, typeof(target.rotated))
  assert(hasKey(source, "sourceSize"),
         "sourceSize" & " is missing while decoding " & "AsepriteArrayFrame")
  target.sourceSize = jsonTo(source{"sourceSize"}, typeof(target.sourceSize))
  assert(hasKey(source, "spriteSourceSize"), "spriteSourceSize" &
      " is missing while decoding " &
      "AsepriteArrayFrame")
  target.spriteSourceSize = jsonTo(source{"spriteSourceSize"},
                                   typeof(target.spriteSourceSize))
  assert(hasKey(source, "trimmed"),
         "trimmed" & " is missing while decoding " & "AsepriteArrayFrame")
  target.trimmed = jsonTo(source{"trimmed"}, typeof(target.trimmed))

proc toJsonHook*(source: AsepriteArrayFrame): JsonNode =
  result = newJObject()
  result{"duration"} = newJFloat(source.duration)
  result{"filename"} = newJString(source.filename)
  result{"frame"} = toJsonHook(source.frame)
  result{"rotated"} = newJBool(source.rotated)
  result{"sourceSize"} = toJsonHook(source.sourceSize)
  result{"spriteSourceSize"} = toJsonHook(source.spriteSourceSize)
  result{"trimmed"} = newJBool(source.trimmed)

converter forAsepriteUnion*(value: seq[AsepriteArrayFrame]): AsepriteUnion =
  return AsepriteUnion(kind: 1, key1: value)

proc equals(_: typedesc[AsepriteUnion]; a, b: AsepriteUnion): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  
proc `==`*(a, b: AsepriteUnion): bool =
  return equals(AsepriteUnion, a, b)

proc stringify(_: typedesc[AsepriteUnion]; value: AsepriteUnion): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  
proc `$`*(value: AsepriteUnion): string =
  stringify(AsepriteUnion, value)

proc fromJsonHook*(target: var AsepriteUnion; source: JsonNode) =
  if source.kind == JObject:
    target = AsepriteUnion(kind: 0, key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JArray:
    target = AsepriteUnion(kind: 1, key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to AsepriteUnion")
  
proc toJsonHook*(source: AsepriteUnion): JsonNode =
  case source.kind
  of 0:
    block:
      let cursor {.cursor.} = source.key0
      var output = newJObject()
      for key in keys(cursor):
        output[key] = toJsonHook(
            cursor[key])
      output
  of 1:
    block:
      let cursor {.cursor.} = source.key1
      var output = newJArray()
      for entry in cursor:
        output.add(toJsonHook(entry))
      output
  
proc isMap*(value: AsepriteUnion): bool =
  value.kind == 0

proc asMap*(value: AsepriteUnion): auto =
  assert(value.kind == 0)
  return value.key0

proc isMapOfFrame*(value: AsepriteUnion): bool =
  value.kind == 0

proc asMapOfFrame*(value: AsepriteUnion): auto =
  assert(value.kind == 0)
  return value.key0

proc isSeq*(value: AsepriteUnion): bool =
  value.kind == 1

proc asSeq*(value: AsepriteUnion): auto =
  assert(value.kind == 1)
  return value.key1

proc isSeqOfArrayFrame*(value: AsepriteUnion): bool =
  value.kind == 1

proc asSeqOfArrayFrame*(value: AsepriteUnion): auto =
  assert(value.kind == 1)
  return value.key1

proc toBinary*(target: var string; source: AsepriteUnion) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  
proc fromBinary(_: typedesc[AsepriteUnion]; source: string; idx: var int): AsepriteUnion =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return AsepriteUnion(kind: 0,
                         key0: fromBinary(typeof(result.key0), source, idx))
  of 1:
    return AsepriteUnion(kind: 1,
                         key1: fromBinary(typeof(result.key1), source, idx))
  
proc equals(_: typedesc[AsepriteFrameTag]; a, b: AsepriteFrameTag): bool =
  equals(typeof(a.direction), a.direction, b.direction) and
      equals(typeof(a.`from`), a.`from`, b.`from`) and
      equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.to), a.to, b.to)

proc `==`*(a, b: AsepriteFrameTag): bool =
  return equals(AsepriteFrameTag, a, b)

proc stringify(_: typedesc[AsepriteFrameTag]; value: AsepriteFrameTag): string =
  stringifyObj("AsepriteFrameTag", ("direction", stringify(
      typeof(value.direction), value.direction)),
               ("from", stringify(typeof(value.`from`), value.`from`)),
               ("name", stringify(typeof(value.name), value.name)),
               ("to", stringify(typeof(value.to), value.to)))

proc `$`*(value: AsepriteFrameTag): string =
  stringify(AsepriteFrameTag, value)

proc fromJsonHook*(target: var AsepriteFrameTag; source: JsonNode) =
  assert(hasKey(source, "direction"),
         "direction" & " is missing while decoding " & "AsepriteFrameTag")
  target.direction = jsonTo(source{"direction"}, typeof(target.direction))
  assert(hasKey(source, "from"),
         "from" & " is missing while decoding " & "AsepriteFrameTag")
  target.`from` = jsonTo(source{"from"}, typeof(target.`from`))
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "AsepriteFrameTag")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  assert(hasKey(source, "to"),
         "to" & " is missing while decoding " & "AsepriteFrameTag")
  target.to = jsonTo(source{"to"}, typeof(target.to))

proc toJsonHook*(source: AsepriteFrameTag): JsonNode =
  result = newJObject()
  result{"direction"} = `%`(source.direction)
  result{"from"} = newJFloat(source.`from`)
  result{"name"} = newJString(source.name)
  result{"to"} = newJFloat(source.to)

proc equals(_: typedesc[AsepriteLayer]; a, b: AsepriteLayer): bool =
  equals(typeof(a.blendMode), a.blendMode, b.blendMode) and
      equals(typeof(a.color), a.color, b.color) and
      equals(typeof(a.data), a.data, b.data) and
      equals(typeof(a.group), a.group, b.group) and
      equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.opacity), a.opacity, b.opacity)

proc `==`*(a, b: AsepriteLayer): bool =
  return equals(AsepriteLayer, a, b)

proc stringify(_: typedesc[AsepriteLayer]; value: AsepriteLayer): string =
  stringifyObj("AsepriteLayer", ("blendMode", stringify(typeof(value.blendMode),
      value.blendMode)),
               ("color", stringify(typeof(value.color), value.color)),
               ("data", stringify(typeof(value.data), value.data)),
               ("group", stringify(typeof(value.group), value.group)),
               ("name", stringify(typeof(value.name), value.name)),
               ("opacity", stringify(typeof(value.opacity), value.opacity)))

proc `$`*(value: AsepriteLayer): string =
  stringify(AsepriteLayer, value)

proc fromJsonHook*(target: var AsepriteLayer; source: JsonNode) =
  if hasKey(source, "blendMode") and source{"blendMode"}.kind != JNull:
    target.blendMode = some(jsonTo(source{"blendMode"},
                                   typeof(unsafeGet(target.blendMode))))
  if hasKey(source, "color") and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  if hasKey(source, "data") and source{"data"}.kind != JNull:
    target.data = some(jsonTo(source{"data"}, typeof(unsafeGet(target.data))))
  if hasKey(source, "group") and source{"group"}.kind != JNull:
    target.group = some(jsonTo(source{"group"}, typeof(unsafeGet(target.group))))
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "AsepriteLayer")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  if hasKey(source, "opacity") and source{"opacity"}.kind != JNull:
    target.opacity = some(jsonTo(source{"opacity"},
                                 typeof(unsafeGet(target.opacity))))

proc toJsonHook*(source: AsepriteLayer): JsonNode =
  result = newJObject()
  if isSome(source.blendMode):
    result{"blendMode"} = `%`(unsafeGet(source.blendMode))
  if isSome(source.color):
    result{"color"} = newJString(unsafeGet(source.color))
  if isSome(source.data):
    result{"data"} = newJString(unsafeGet(source.data))
  if isSome(source.group):
    result{"group"} = newJString(unsafeGet(source.group))
  result{"name"} = newJString(source.name)
  if isSome(source.opacity):
    result{"opacity"} = newJFloat(unsafeGet(source.opacity))

proc equals(_: typedesc[AsepritePoint]; a, b: AsepritePoint): bool =
  equals(typeof(a.x), a.x, b.x) and equals(typeof(a.y), a.y, b.y)

proc `==`*(a, b: AsepritePoint): bool =
  return equals(AsepritePoint, a, b)

proc stringify(_: typedesc[AsepritePoint]; value: AsepritePoint): string =
  stringifyObj("AsepritePoint", ("x", stringify(typeof(value.x), value.x)),
               ("y", stringify(typeof(value.y), value.y)))

proc `$`*(value: AsepritePoint): string =
  stringify(AsepritePoint, value)

proc fromJsonHook*(target: var AsepritePoint; source: JsonNode) =
  assert(hasKey(source, "x"),
         "x" & " is missing while decoding " & "AsepritePoint")
  target.x = jsonTo(source{"x"}, typeof(target.x))
  assert(hasKey(source, "y"),
         "y" & " is missing while decoding " & "AsepritePoint")
  target.y = jsonTo(source{"y"}, typeof(target.y))

proc toJsonHook*(source: AsepritePoint): JsonNode =
  result = newJObject()
  result{"x"} = newJFloat(source.x)
  result{"y"} = newJFloat(source.y)

proc equals(_: typedesc[AsepriteSliceKey]; a, b: AsepriteSliceKey): bool =
  equals(typeof(a.bounds), a.bounds, b.bounds) and
      equals(typeof(a.center), a.center, b.center) and
      equals(typeof(a.frame), a.frame, b.frame) and
      equals(typeof(a.pivot), a.pivot, b.pivot)

proc `==`*(a, b: AsepriteSliceKey): bool =
  return equals(AsepriteSliceKey, a, b)

proc stringify(_: typedesc[AsepriteSliceKey]; value: AsepriteSliceKey): string =
  stringifyObj("AsepriteSliceKey",
               ("bounds", stringify(typeof(value.bounds), value.bounds)),
               ("center", stringify(typeof(value.center), value.center)),
               ("frame", stringify(typeof(value.frame), value.frame)),
               ("pivot", stringify(typeof(value.pivot), value.pivot)))

proc `$`*(value: AsepriteSliceKey): string =
  stringify(AsepriteSliceKey, value)

proc fromJsonHook*(target: var AsepriteSliceKey; source: JsonNode) =
  assert(hasKey(source, "bounds"),
         "bounds" & " is missing while decoding " & "AsepriteSliceKey")
  target.bounds = jsonTo(source{"bounds"}, typeof(target.bounds))
  if hasKey(source, "center") and source{"center"}.kind != JNull:
    target.center = some(jsonTo(source{"center"},
                                typeof(unsafeGet(target.center))))
  assert(hasKey(source, "frame"),
         "frame" & " is missing while decoding " & "AsepriteSliceKey")
  target.frame = jsonTo(source{"frame"}, typeof(target.frame))
  if hasKey(source, "pivot") and source{"pivot"}.kind != JNull:
    target.pivot = some(jsonTo(source{"pivot"}, typeof(unsafeGet(target.pivot))))

proc toJsonHook*(source: AsepriteSliceKey): JsonNode =
  result = newJObject()
  result{"bounds"} = toJsonHook(source.bounds)
  if isSome(source.center):
    result{"center"} = toJsonHook(unsafeGet(source.center))
  result{"frame"} = newJFloat(source.frame)
  if isSome(source.pivot):
    result{"pivot"} = toJsonHook(unsafeGet(source.pivot))

proc equals(_: typedesc[AsepriteSlice]; a, b: AsepriteSlice): bool =
  equals(typeof(a.color), a.color, b.color) and
      equals(typeof(a.data), a.data, b.data) and
      equals(typeof(a.keys), a.keys, b.keys) and
      equals(typeof(a.name), a.name, b.name)

proc `==`*(a, b: AsepriteSlice): bool =
  return equals(AsepriteSlice, a, b)

proc stringify(_: typedesc[AsepriteSlice]; value: AsepriteSlice): string =
  stringifyObj("AsepriteSlice",
               ("color", stringify(typeof(value.color), value.color)),
               ("data", stringify(typeof(value.data), value.data)),
               ("keys", stringify(typeof(value.keys), value.keys)),
               ("name", stringify(typeof(value.name), value.name)))

proc `$`*(value: AsepriteSlice): string =
  stringify(AsepriteSlice, value)

proc fromJsonHook*(target: var AsepriteSlice; source: JsonNode) =
  if hasKey(source, "color") and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  if hasKey(source, "data") and source{"data"}.kind != JNull:
    target.data = some(jsonTo(source{"data"}, typeof(unsafeGet(target.data))))
  assert(hasKey(source, "keys"),
         "keys" & " is missing while decoding " & "AsepriteSlice")
  target.keys = jsonTo(source{"keys"}, typeof(target.keys))
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "AsepriteSlice")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: AsepriteSlice): JsonNode =
  result = newJObject()
  if isSome(source.color):
    result{"color"} = newJString(unsafeGet(source.color))
  if isSome(source.data):
    result{"data"} = newJString(unsafeGet(source.data))
  result{"keys"} = block:
    let cursor {.cursor.} = source.keys
    var output = newJArray()
    for entry in cursor:
      output.add(toJsonHook(entry))
    output
  result{"name"} = newJString(source.name)

proc equals(_: typedesc[AsepriteMeta]; a, b: AsepriteMeta): bool =
  equals(typeof(a.app), a.app, b.app) and
      equals(typeof(a.format), a.format, b.format) and
      equals(typeof(a.frameTags), a.frameTags, b.frameTags) and
      equals(typeof(a.image), a.image, b.image) and
      equals(typeof(a.layers), a.layers, b.layers) and
      equals(typeof(a.scale), a.scale, b.scale) and
      equals(typeof(a.size), a.size, b.size) and
      equals(typeof(a.slices), a.slices, b.slices) and
      equals(typeof(a.version), a.version, b.version)

proc `==`*(a, b: AsepriteMeta): bool =
  return equals(AsepriteMeta, a, b)

proc stringify(_: typedesc[AsepriteMeta]; value: AsepriteMeta): string =
  stringifyObj("AsepriteMeta",
               ("app", stringify(typeof(value.app), value.app)),
               ("format", stringify(typeof(value.format), value.format)), (
      "frameTags", stringify(typeof(value.frameTags), value.frameTags)),
               ("image", stringify(typeof(value.image), value.image)),
               ("layers", stringify(typeof(value.layers), value.layers)),
               ("scale", stringify(typeof(value.scale), value.scale)),
               ("size", stringify(typeof(value.size), value.size)),
               ("slices", stringify(typeof(value.slices), value.slices)),
               ("version", stringify(typeof(value.version), value.version)))

proc `$`*(value: AsepriteMeta): string =
  stringify(AsepriteMeta, value)

proc fromJsonHook*(target: var AsepriteMeta; source: JsonNode) =
  assert(hasKey(source, "app"),
         "app" & " is missing while decoding " & "AsepriteMeta")
  target.app = jsonTo(source{"app"}, typeof(target.app))
  assert(hasKey(source, "format"),
         "format" & " is missing while decoding " & "AsepriteMeta")
  target.format = jsonTo(source{"format"}, typeof(target.format))
  if hasKey(source, "frameTags") and source{"frameTags"}.kind != JNull:
    target.frameTags = some(jsonTo(source{"frameTags"},
                                   typeof(unsafeGet(target.frameTags))))
  assert(hasKey(source, "image"),
         "image" & " is missing while decoding " & "AsepriteMeta")
  target.image = jsonTo(source{"image"}, typeof(target.image))
  if hasKey(source, "layers") and source{"layers"}.kind != JNull:
    target.layers = some(jsonTo(source{"layers"},
                                typeof(unsafeGet(target.layers))))
  assert(hasKey(source, "scale"),
         "scale" & " is missing while decoding " & "AsepriteMeta")
  target.scale = jsonTo(source{"scale"}, typeof(target.scale))
  assert(hasKey(source, "size"),
         "size" & " is missing while decoding " & "AsepriteMeta")
  target.size = jsonTo(source{"size"}, typeof(target.size))
  if hasKey(source, "slices") and source{"slices"}.kind != JNull:
    target.slices = some(jsonTo(source{"slices"},
                                typeof(unsafeGet(target.slices))))
  assert(hasKey(source, "version"),
         "version" & " is missing while decoding " & "AsepriteMeta")
  target.version = jsonTo(source{"version"}, typeof(target.version))

proc toJsonHook*(source: AsepriteMeta): JsonNode =
  result = newJObject()
  result{"app"} = newJString(source.app)
  result{"format"} = `%`(source.format)
  if isSome(source.frameTags):
    result{"frameTags"} = block:
      let cursor {.cursor.} = unsafeGet(source.frameTags)
      var output = newJArray()
      for entry in cursor:
        output.add(toJsonHook(entry))
      output
  result{"image"} = newJString(source.image)
  if isSome(source.layers):
    result{"layers"} = block:
      let cursor {.cursor.} = unsafeGet(source.layers)
      var output = newJArray()
      for entry in cursor:
        output.add(toJsonHook(entry))
      output
  result{"scale"} = newJString(source.scale)
  result{"size"} = toJsonHook(source.size)
  if isSome(source.slices):
    result{"slices"} = block:
      let cursor {.cursor.} = unsafeGet(source.slices)
      var output = newJArray()
      for entry in cursor:
        output.add(toJsonHook(entry))
      output
  result{"version"} = newJString(source.version)

proc equals(_: typedesc[AsepriteSpriteSheet]; a, b: AsepriteSpriteSheet): bool =
  equals(typeof(a.frames), a.frames, b.frames) and
      equals(typeof(a.meta), a.meta, b.meta)

proc `==`*(a, b: AsepriteSpriteSheet): bool =
  return equals(AsepriteSpriteSheet, a, b)

proc stringify(_: typedesc[AsepriteSpriteSheet]; value: AsepriteSpriteSheet): string =
  stringifyObj("AsepriteSpriteSheet",
               ("frames", stringify(typeof(value.frames), value.frames)),
               ("meta", stringify(typeof(value.meta), value.meta)))

proc `$`*(value: AsepriteSpriteSheet): string =
  stringify(AsepriteSpriteSheet, value)

proc fromJsonHook*(target: var AsepriteSpriteSheet; source: JsonNode) =
  assert(hasKey(source, "frames"),
         "frames" & " is missing while decoding " & "AsepriteSpriteSheet")
  target.frames = jsonTo(source{"frames"}, typeof(target.frames))
  assert(hasKey(source, "meta"),
         "meta" & " is missing while decoding " & "AsepriteSpriteSheet")
  target.meta = jsonTo(source{"meta"}, typeof(target.meta))

proc toJsonHook*(source: AsepriteSpriteSheet): JsonNode =
  result = newJObject()
  result{"frames"} = toJsonHook(source.frames)
  result{"meta"} = toJsonHook(source.meta)
{.pop.}
