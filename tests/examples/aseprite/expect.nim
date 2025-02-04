{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  AsepriteRectangle* = object
    h*: BiggestFloat
    w*: BiggestFloat
    x*: BiggestFloat
    y*: BiggestFloat
  AsepriteSize* = object
    h*: BiggestFloat
    w*: BiggestFloat
  AsepriteFrame* = object
    duration*: BiggestFloat
    frame*: AsepriteRectangle
    rotated*: bool
    sourceSize*: AsepriteSize
    spriteSourceSize*: AsepriteRectangle
    trimmed*: bool
  AsepriteArrayFrame* = object
    duration*: BiggestFloat
    filename*: string
    frame*: AsepriteRectangle
    rotated*: bool
    sourceSize*: AsepriteSize
    spriteSourceSize*: AsepriteRectangle
    trimmed*: bool
  AsepriteUnion* = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: OrderedTable[string, AsepriteFrame]
    of 1:
      key1*: seq[AsepriteArrayFrame]
  AsepriteFormat* = enum
    RGBA8888, I8
  AsepriteDirection* = enum
    Forward, Reverse, Pingpong
  AsepriteFrameTag* = object
    direction*: AsepriteDirection
    `from`*: BiggestFloat
    name*: string
    to*: BiggestFloat
  AsepriteBlendMode* = enum
    Normal, Darken, Multiply, Color_burn, Lighten, Screen, Color_dodge,
    Addition, Overlay, Soft_light, Hard_light, Difference, Exclusion, Subtract,
    Divide, Hsl_hue, Hsl_saturation, Hsl_color, Hsl_luminosity
  AsepriteLayer* = object
    blendMode*: Option[AsepriteBlendMode]
    color*: Option[string]
    data*: Option[string]
    group*: Option[string]
    name*: string
    opacity*: Option[BiggestFloat]
  AsepritePoint* = object
    x*: BiggestFloat
    y*: BiggestFloat
  AsepriteSliceKey* = object
    bounds*: AsepriteRectangle
    center*: Option[AsepriteRectangle]
    frame*: BiggestFloat
    pivot*: Option[AsepritePoint]
  AsepriteSlice* = object
    color*: Option[string]
    data*: Option[string]
    keys*: seq[AsepriteSliceKey]
    name*: string
  AsepriteMeta* = object
    app*: string
    format*: AsepriteFormat
    frameTags*: Option[seq[AsepriteFrameTag]]
    image*: string
    layers*: Option[seq[AsepriteLayer]]
    scale*: string
    size*: AsepriteSize
    slices*: Option[seq[AsepriteSlice]]
    version*: string
  AsepriteSpriteSheet* = object
    frames*: AsepriteUnion
    meta*: AsepriteMeta
proc toJsonHook*(source: AsepriteRectangle): JsonNode
proc toJsonHook*(source: AsepriteSize): JsonNode
proc toJsonHook*(source: AsepriteFrame): JsonNode
proc toJsonHook*(source: AsepriteArrayFrame): JsonNode
proc toJsonHook*(source: AsepriteUnion): JsonNode
proc toJsonHook*(source: AsepriteFormat): JsonNode
proc toJsonHook*(source: AsepriteDirection): JsonNode
proc toJsonHook*(source: AsepriteFrameTag): JsonNode
proc toJsonHook*(source: AsepriteBlendMode): JsonNode
proc toJsonHook*(source: AsepriteLayer): JsonNode
proc toJsonHook*(source: AsepritePoint): JsonNode
proc toJsonHook*(source: AsepriteSliceKey): JsonNode
proc toJsonHook*(source: AsepriteSlice): JsonNode
proc toJsonHook*(source: AsepriteMeta): JsonNode
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

proc toBinary*(target: var string; source: AsepriteRectangle) =
  toBinary(target, source.h)
  toBinary(target, source.w)
  toBinary(target, source.x)
  toBinary(target, source.y)

proc toBinary*(source: AsepriteRectangle): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteRectangle]; source: string; idx: var int): AsepriteRectangle =
  result.h = fromBinary(typeof(result.h), source, idx)
  result.w = fromBinary(typeof(result.w), source, idx)
  result.x = fromBinary(typeof(result.x), source, idx)
  result.y = fromBinary(typeof(result.y), source, idx)

proc fromBinary*(_: typedesc[AsepriteRectangle]; source: string): AsepriteRectangle =
  var idx = 0
  return fromBinary(AsepriteRectangle, source, idx)

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

proc toBinary*(target: var string; source: AsepriteSize) =
  toBinary(target, source.h)
  toBinary(target, source.w)

proc toBinary*(source: AsepriteSize): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteSize]; source: string; idx: var int): AsepriteSize =
  result.h = fromBinary(typeof(result.h), source, idx)
  result.w = fromBinary(typeof(result.w), source, idx)

proc fromBinary*(_: typedesc[AsepriteSize]; source: string): AsepriteSize =
  var idx = 0
  return fromBinary(AsepriteSize, source, idx)

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

proc toBinary*(target: var string; source: AsepriteFrame) =
  toBinary(target, source.duration)
  toBinary(target, source.frame)
  toBinary(target, source.rotated)
  toBinary(target, source.sourceSize)
  toBinary(target, source.spriteSourceSize)
  toBinary(target, source.trimmed)

proc toBinary*(source: AsepriteFrame): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteFrame]; source: string; idx: var int): AsepriteFrame =
  result.duration = fromBinary(typeof(result.duration), source, idx)
  result.frame = fromBinary(typeof(result.frame), source, idx)
  result.rotated = fromBinary(typeof(result.rotated), source, idx)
  result.sourceSize = fromBinary(typeof(result.sourceSize), source, idx)
  result.spriteSourceSize = fromBinary(typeof(result.spriteSourceSize), source,
                                       idx)
  result.trimmed = fromBinary(typeof(result.trimmed), source, idx)

proc fromBinary*(_: typedesc[AsepriteFrame]; source: string): AsepriteFrame =
  var idx = 0
  return fromBinary(AsepriteFrame, source, idx)

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

proc toBinary*(target: var string; source: AsepriteArrayFrame) =
  toBinary(target, source.duration)
  toBinary(target, source.filename)
  toBinary(target, source.frame)
  toBinary(target, source.rotated)
  toBinary(target, source.sourceSize)
  toBinary(target, source.spriteSourceSize)
  toBinary(target, source.trimmed)

proc toBinary*(source: AsepriteArrayFrame): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteArrayFrame]; source: string; idx: var int): AsepriteArrayFrame =
  result.duration = fromBinary(typeof(result.duration), source, idx)
  result.filename = fromBinary(typeof(result.filename), source, idx)
  result.frame = fromBinary(typeof(result.frame), source, idx)
  result.rotated = fromBinary(typeof(result.rotated), source, idx)
  result.sourceSize = fromBinary(typeof(result.sourceSize), source, idx)
  result.spriteSourceSize = fromBinary(typeof(result.spriteSourceSize), source,
                                       idx)
  result.trimmed = fromBinary(typeof(result.trimmed), source, idx)

proc fromBinary*(_: typedesc[AsepriteArrayFrame]; source: string): AsepriteArrayFrame =
  var idx = 0
  return fromBinary(AsepriteArrayFrame, source, idx)

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
      var output = newJObject()
      for key, entry in pairs(source.key0):
        output[key] = toJsonHook(entry)
      output
  of 1:
    block:
      var output = newJArray()
      for entry in source.key1:
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
  
proc toBinary*(source: AsepriteUnion): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteUnion]; source: string; idx: var int): AsepriteUnion =
  case fromBinary(range[0 .. 1], source, idx)
  of 0:
    return AsepriteUnion(kind: 0,
                         key0: fromBinary(typeof(result.key0), source, idx))
  of 1:
    return AsepriteUnion(kind: 1,
                         key1: fromBinary(typeof(result.key1), source, idx))
  
proc fromBinary*(_: typedesc[AsepriteUnion]; source: string): AsepriteUnion =
  var idx = 0
  return fromBinary(AsepriteUnion, source, idx)

proc toJsonHook*(source: AsepriteFormat): JsonNode =
  case source
  of AsepriteFormat.RGBA8888:
    return newJString("RGBA8888")
  of AsepriteFormat.I8:
    return newJString("I8")
  
proc fromJsonHook*(target: var AsepriteFormat; source: JsonNode) =
  target = case getStr(source)
  of "RGBA8888":
    AsepriteFormat.RGBA8888
  of "I8":
    AsepriteFormat.I8
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: AsepriteDirection): JsonNode =
  case source
  of AsepriteDirection.Forward:
    return newJString("forward")
  of AsepriteDirection.Reverse:
    return newJString("reverse")
  of AsepriteDirection.Pingpong:
    return newJString("pingpong")
  
proc fromJsonHook*(target: var AsepriteDirection; source: JsonNode) =
  target = case getStr(source)
  of "forward":
    AsepriteDirection.Forward
  of "reverse":
    AsepriteDirection.Reverse
  of "pingpong":
    AsepriteDirection.Pingpong
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
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
  result{"direction"} = toJsonHook(source.direction)
  result{"from"} = newJFloat(source.`from`)
  result{"name"} = newJString(source.name)
  result{"to"} = newJFloat(source.to)

proc toBinary*(target: var string; source: AsepriteFrameTag) =
  toBinary(target, source.direction)
  toBinary(target, source.`from`)
  toBinary(target, source.name)
  toBinary(target, source.to)

proc toBinary*(source: AsepriteFrameTag): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteFrameTag]; source: string; idx: var int): AsepriteFrameTag =
  result.direction = fromBinary(typeof(result.direction), source, idx)
  result.`from` = fromBinary(typeof(result.`from`), source, idx)
  result.name = fromBinary(typeof(result.name), source, idx)
  result.to = fromBinary(typeof(result.to), source, idx)

proc fromBinary*(_: typedesc[AsepriteFrameTag]; source: string): AsepriteFrameTag =
  var idx = 0
  return fromBinary(AsepriteFrameTag, source, idx)

proc toJsonHook*(source: AsepriteBlendMode): JsonNode =
  case source
  of AsepriteBlendMode.Normal:
    return newJString("normal")
  of AsepriteBlendMode.Darken:
    return newJString("darken")
  of AsepriteBlendMode.Multiply:
    return newJString("multiply")
  of AsepriteBlendMode.Color_burn:
    return newJString("color_burn")
  of AsepriteBlendMode.Lighten:
    return newJString("lighten")
  of AsepriteBlendMode.Screen:
    return newJString("screen")
  of AsepriteBlendMode.Color_dodge:
    return newJString("color_dodge")
  of AsepriteBlendMode.Addition:
    return newJString("addition")
  of AsepriteBlendMode.Overlay:
    return newJString("overlay")
  of AsepriteBlendMode.Soft_light:
    return newJString("soft_light")
  of AsepriteBlendMode.Hard_light:
    return newJString("hard_light")
  of AsepriteBlendMode.Difference:
    return newJString("difference")
  of AsepriteBlendMode.Exclusion:
    return newJString("exclusion")
  of AsepriteBlendMode.Subtract:
    return newJString("subtract")
  of AsepriteBlendMode.Divide:
    return newJString("divide")
  of AsepriteBlendMode.Hsl_hue:
    return newJString("hsl_hue")
  of AsepriteBlendMode.Hsl_saturation:
    return newJString("hsl_saturation")
  of AsepriteBlendMode.Hsl_color:
    return newJString("hsl_color")
  of AsepriteBlendMode.Hsl_luminosity:
    return newJString("hsl_luminosity")
  
proc fromJsonHook*(target: var AsepriteBlendMode; source: JsonNode) =
  target = case getStr(source)
  of "normal":
    AsepriteBlendMode.Normal
  of "darken":
    AsepriteBlendMode.Darken
  of "multiply":
    AsepriteBlendMode.Multiply
  of "color_burn":
    AsepriteBlendMode.Color_burn
  of "lighten":
    AsepriteBlendMode.Lighten
  of "screen":
    AsepriteBlendMode.Screen
  of "color_dodge":
    AsepriteBlendMode.Color_dodge
  of "addition":
    AsepriteBlendMode.Addition
  of "overlay":
    AsepriteBlendMode.Overlay
  of "soft_light":
    AsepriteBlendMode.Soft_light
  of "hard_light":
    AsepriteBlendMode.Hard_light
  of "difference":
    AsepriteBlendMode.Difference
  of "exclusion":
    AsepriteBlendMode.Exclusion
  of "subtract":
    AsepriteBlendMode.Subtract
  of "divide":
    AsepriteBlendMode.Divide
  of "hsl_hue":
    AsepriteBlendMode.Hsl_hue
  of "hsl_saturation":
    AsepriteBlendMode.Hsl_saturation
  of "hsl_color":
    AsepriteBlendMode.Hsl_color
  of "hsl_luminosity":
    AsepriteBlendMode.Hsl_luminosity
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
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
    result{"blendMode"} = toJsonHook(unsafeGet(source.blendMode))
  if isSome(source.color):
    result{"color"} = newJString(unsafeGet(source.color))
  if isSome(source.data):
    result{"data"} = newJString(unsafeGet(source.data))
  if isSome(source.group):
    result{"group"} = newJString(unsafeGet(source.group))
  result{"name"} = newJString(source.name)
  if isSome(source.opacity):
    result{"opacity"} = newJFloat(unsafeGet(source.opacity))

proc toBinary*(target: var string; source: AsepriteLayer) =
  toBinary(target, source.blendMode)
  toBinary(target, source.color)
  toBinary(target, source.data)
  toBinary(target, source.group)
  toBinary(target, source.name)
  toBinary(target, source.opacity)

proc toBinary*(source: AsepriteLayer): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteLayer]; source: string; idx: var int): AsepriteLayer =
  result.blendMode = fromBinary(typeof(result.blendMode), source, idx)
  result.color = fromBinary(typeof(result.color), source, idx)
  result.data = fromBinary(typeof(result.data), source, idx)
  result.group = fromBinary(typeof(result.group), source, idx)
  result.name = fromBinary(typeof(result.name), source, idx)
  result.opacity = fromBinary(typeof(result.opacity), source, idx)

proc fromBinary*(_: typedesc[AsepriteLayer]; source: string): AsepriteLayer =
  var idx = 0
  return fromBinary(AsepriteLayer, source, idx)

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

proc toBinary*(target: var string; source: AsepritePoint) =
  toBinary(target, source.x)
  toBinary(target, source.y)

proc toBinary*(source: AsepritePoint): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepritePoint]; source: string; idx: var int): AsepritePoint =
  result.x = fromBinary(typeof(result.x), source, idx)
  result.y = fromBinary(typeof(result.y), source, idx)

proc fromBinary*(_: typedesc[AsepritePoint]; source: string): AsepritePoint =
  var idx = 0
  return fromBinary(AsepritePoint, source, idx)

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

proc toBinary*(target: var string; source: AsepriteSliceKey) =
  toBinary(target, source.bounds)
  toBinary(target, source.center)
  toBinary(target, source.frame)
  toBinary(target, source.pivot)

proc toBinary*(source: AsepriteSliceKey): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteSliceKey]; source: string; idx: var int): AsepriteSliceKey =
  result.bounds = fromBinary(typeof(result.bounds), source, idx)
  result.center = fromBinary(typeof(result.center), source, idx)
  result.frame = fromBinary(typeof(result.frame), source, idx)
  result.pivot = fromBinary(typeof(result.pivot), source, idx)

proc fromBinary*(_: typedesc[AsepriteSliceKey]; source: string): AsepriteSliceKey =
  var idx = 0
  return fromBinary(AsepriteSliceKey, source, idx)

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
    var output = newJArray()
    for entry in source.keys:
      output.add(toJsonHook(entry))
    output
  result{"name"} = newJString(source.name)

proc toBinary*(target: var string; source: AsepriteSlice) =
  toBinary(target, source.color)
  toBinary(target, source.data)
  toBinary(target, source.keys)
  toBinary(target, source.name)

proc toBinary*(source: AsepriteSlice): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteSlice]; source: string; idx: var int): AsepriteSlice =
  result.color = fromBinary(typeof(result.color), source, idx)
  result.data = fromBinary(typeof(result.data), source, idx)
  result.keys = fromBinary(typeof(result.keys), source, idx)
  result.name = fromBinary(typeof(result.name), source, idx)

proc fromBinary*(_: typedesc[AsepriteSlice]; source: string): AsepriteSlice =
  var idx = 0
  return fromBinary(AsepriteSlice, source, idx)

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
  result{"format"} = toJsonHook(source.format)
  if isSome(source.frameTags):
    result{"frameTags"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.frameTags):
        output.add(toJsonHook(entry))
      output
  result{"image"} = newJString(source.image)
  if isSome(source.layers):
    result{"layers"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.layers):
        output.add(toJsonHook(entry))
      output
  result{"scale"} = newJString(source.scale)
  result{"size"} = toJsonHook(source.size)
  if isSome(source.slices):
    result{"slices"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.slices):
        output.add(toJsonHook(entry))
      output
  result{"version"} = newJString(source.version)

proc toBinary*(target: var string; source: AsepriteMeta) =
  toBinary(target, source.app)
  toBinary(target, source.format)
  toBinary(target, source.frameTags)
  toBinary(target, source.image)
  toBinary(target, source.layers)
  toBinary(target, source.scale)
  toBinary(target, source.size)
  toBinary(target, source.slices)
  toBinary(target, source.version)

proc toBinary*(source: AsepriteMeta): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteMeta]; source: string; idx: var int): AsepriteMeta =
  result.app = fromBinary(typeof(result.app), source, idx)
  result.format = fromBinary(typeof(result.format), source, idx)
  result.frameTags = fromBinary(typeof(result.frameTags), source, idx)
  result.image = fromBinary(typeof(result.image), source, idx)
  result.layers = fromBinary(typeof(result.layers), source, idx)
  result.scale = fromBinary(typeof(result.scale), source, idx)
  result.size = fromBinary(typeof(result.size), source, idx)
  result.slices = fromBinary(typeof(result.slices), source, idx)
  result.version = fromBinary(typeof(result.version), source, idx)

proc fromBinary*(_: typedesc[AsepriteMeta]; source: string): AsepriteMeta =
  var idx = 0
  return fromBinary(AsepriteMeta, source, idx)

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

proc toBinary*(target: var string; source: AsepriteSpriteSheet) =
  toBinary(target, source.frames)
  toBinary(target, source.meta)

proc toBinary*(source: AsepriteSpriteSheet): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[AsepriteSpriteSheet]; source: string; idx: var int): AsepriteSpriteSheet =
  result.frames = fromBinary(typeof(result.frames), source, idx)
  result.meta = fromBinary(typeof(result.meta), source, idx)

proc fromBinary*(_: typedesc[AsepriteSpriteSheet]; source: string): AsepriteSpriteSheet =
  var idx = 0
  return fromBinary(AsepriteSpriteSheet, source, idx)
{.pop.}
