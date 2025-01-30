{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

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
