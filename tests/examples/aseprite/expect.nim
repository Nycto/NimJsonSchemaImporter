{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  TestFrameTag* = object
    direction*: TestDirection
    `from`*: BiggestFloat
    to*: BiggestFloat
    name*: string
  TestSpriteSheet* = object
    frames*: TestTestSpriteSheet_framesUnion
    meta*: TestMeta
  TestTestSpriteSheet_framesUnion* = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: Table[string, TestFrame]
    of 1:
      key1*: seq[TestArrayFrame]
  TestFrame* = object
    sourceSize*: TestSize
    duration*: BiggestFloat
    rotated*: bool
    trimmed*: bool
    spriteSourceSize*: TestRectangle
    frame*: TestRectangle
  TestFormat* = enum
    I8, RGBA8888
  TestSlice* = object
    data*: Option[string]
    color*: Option[string]
    name*: string
    keys*: seq[TestSliceKey]
  TestBlendMode* = enum
    Multiply, Overlay, Color_burn, Exclusion, Color_dodge, Hsl_saturation,
    Hsl_color, Subtract, Divide, Hsl_luminosity, Darken, Normal, Hard_light,
    Screen, Lighten, Soft_light, Addition, Hsl_hue, Difference
  TestRectangle* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  TestSliceKey* = object
    pivot*: Option[TestPoint]
    center*: Option[TestRectangle]
    bounds*: TestRectangle
    frame*: BiggestFloat
  TestMeta* = object
    scale*: string
    frameTags*: Option[seq[TestFrameTag]]
    format*: TestFormat
    size*: TestSize
    slices*: Option[seq[TestSlice]]
    version*: string
    layers*: Option[seq[TestLayer]]
    app*: string
    image*: string
  TestDirection* = enum
    Pingpong, Forward, Reverse
  TestArrayFrame* = object
    sourceSize*: TestSize
    duration*: BiggestFloat
    rotated*: bool
    trimmed*: bool
    spriteSourceSize*: TestRectangle
    filename*: string
    frame*: TestRectangle
  TestLayer* = object
    blendMode*: Option[TestBlendMode]
    data*: Option[string]
    color*: Option[string]
    group*: Option[string]
    name*: string
    opacity*: Option[BiggestFloat]
  TestSize* = object
    w*: BiggestFloat
    h*: BiggestFloat
  TestPoint* = object
    x*: BiggestFloat
    y*: BiggestFloat
proc fromJsonHook*(target: var TestSize; source: JsonNode) =
  assert("w" in source, "w" & " is missing while decoding " & "TestSize")
  target.w = jsonTo(source{"w"}, typeof(target.w))
  assert("h" in source, "h" & " is missing while decoding " & "TestSize")
  target.h = jsonTo(source{"h"}, typeof(target.h))

proc toJsonHook*(source: TestSize): JsonNode =
  result = newJObject()
  result{"w"} = toJson(source.w)
  result{"h"} = toJson(source.h)

proc fromJsonHook*(target: var TestRectangle; source: JsonNode) =
  assert("x" in source, "x" & " is missing while decoding " & "TestRectangle")
  target.x = jsonTo(source{"x"}, typeof(target.x))
  assert("w" in source, "w" & " is missing while decoding " & "TestRectangle")
  target.w = jsonTo(source{"w"}, typeof(target.w))
  assert("y" in source, "y" & " is missing while decoding " & "TestRectangle")
  target.y = jsonTo(source{"y"}, typeof(target.y))
  assert("h" in source, "h" & " is missing while decoding " & "TestRectangle")
  target.h = jsonTo(source{"h"}, typeof(target.h))

proc toJsonHook*(source: TestRectangle): JsonNode =
  result = newJObject()
  result{"x"} = toJson(source.x)
  result{"w"} = toJson(source.w)
  result{"y"} = toJson(source.y)
  result{"h"} = toJson(source.h)

proc fromJsonHook*(target: var TestFrame; source: JsonNode) =
  assert("sourceSize" in source,
         "sourceSize" & " is missing while decoding " & "TestFrame")
  target.sourceSize = jsonTo(source{"sourceSize"}, typeof(target.sourceSize))
  assert("duration" in source,
         "duration" & " is missing while decoding " & "TestFrame")
  target.duration = jsonTo(source{"duration"}, typeof(target.duration))
  assert("rotated" in source,
         "rotated" & " is missing while decoding " & "TestFrame")
  target.rotated = jsonTo(source{"rotated"}, typeof(target.rotated))
  assert("trimmed" in source,
         "trimmed" & " is missing while decoding " & "TestFrame")
  target.trimmed = jsonTo(source{"trimmed"}, typeof(target.trimmed))
  assert("spriteSourceSize" in source,
         "spriteSourceSize" & " is missing while decoding " & "TestFrame")
  target.spriteSourceSize = jsonTo(source{"spriteSourceSize"},
                                   typeof(target.spriteSourceSize))
  assert("frame" in source,
         "frame" & " is missing while decoding " & "TestFrame")
  target.frame = jsonTo(source{"frame"}, typeof(target.frame))

proc toJsonHook*(source: TestFrame): JsonNode =
  result = newJObject()
  result{"sourceSize"} = toJson(source.sourceSize)
  result{"duration"} = toJson(source.duration)
  result{"rotated"} = toJson(source.rotated)
  result{"trimmed"} = toJson(source.trimmed)
  result{"spriteSourceSize"} = toJson(source.spriteSourceSize)
  result{"frame"} = toJson(source.frame)

proc fromJsonHook*(target: var TestArrayFrame; source: JsonNode) =
  assert("sourceSize" in source,
         "sourceSize" & " is missing while decoding " & "TestArrayFrame")
  target.sourceSize = jsonTo(source{"sourceSize"}, typeof(target.sourceSize))
  assert("duration" in source,
         "duration" & " is missing while decoding " & "TestArrayFrame")
  target.duration = jsonTo(source{"duration"}, typeof(target.duration))
  assert("rotated" in source,
         "rotated" & " is missing while decoding " & "TestArrayFrame")
  target.rotated = jsonTo(source{"rotated"}, typeof(target.rotated))
  assert("trimmed" in source,
         "trimmed" & " is missing while decoding " & "TestArrayFrame")
  target.trimmed = jsonTo(source{"trimmed"}, typeof(target.trimmed))
  assert("spriteSourceSize" in source,
         "spriteSourceSize" & " is missing while decoding " & "TestArrayFrame")
  target.spriteSourceSize = jsonTo(source{"spriteSourceSize"},
                                   typeof(target.spriteSourceSize))
  assert("filename" in source,
         "filename" & " is missing while decoding " & "TestArrayFrame")
  target.filename = jsonTo(source{"filename"}, typeof(target.filename))
  assert("frame" in source,
         "frame" & " is missing while decoding " & "TestArrayFrame")
  target.frame = jsonTo(source{"frame"}, typeof(target.frame))

proc toJsonHook*(source: TestArrayFrame): JsonNode =
  result = newJObject()
  result{"sourceSize"} = toJson(source.sourceSize)
  result{"duration"} = toJson(source.duration)
  result{"rotated"} = toJson(source.rotated)
  result{"trimmed"} = toJson(source.trimmed)
  result{"spriteSourceSize"} = toJson(source.spriteSourceSize)
  result{"filename"} = toJson(source.filename)
  result{"frame"} = toJson(source.frame)

proc fromJsonHook*(target: var TestTestSpriteSheet_framesUnion; source: JsonNode) =
  if source.kind == JObject:
    target = TestTestSpriteSheet_framesUnion(kind: 0,
        key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JArray:
    target = TestTestSpriteSheet_framesUnion(kind: 1,
        key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to TestTestSpriteSheet_framesUnion")
  
proc toJsonHook*(source: TestTestSpriteSheet_framesUnion): JsonNode =
  case source.kind
  of 0:
    return toJson(source.key0)
  of 1:
    return toJson(source.key1)
  
proc toJsonHook*(source: TestDirection): JsonNode =
  case source
  of TestDirection.Pingpong:
    return newJString("pingpong")
  of TestDirection.Forward:
    return newJString("forward")
  of TestDirection.Reverse:
    return newJString("reverse")
  
proc fromJsonHook*(target: var TestDirection; source: JsonNode) =
  target = case getStr(source)
  of "pingpong":
    TestDirection.Pingpong
  of "forward":
    TestDirection.Forward
  of "reverse":
    TestDirection.Reverse
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestFrameTag; source: JsonNode) =
  assert("direction" in source,
         "direction" & " is missing while decoding " & "TestFrameTag")
  target.direction = jsonTo(source{"direction"}, typeof(target.direction))
  assert("from" in source,
         "from" & " is missing while decoding " & "TestFrameTag")
  target.`from` = jsonTo(source{"from"}, typeof(target.`from`))
  assert("to" in source, "to" & " is missing while decoding " & "TestFrameTag")
  target.to = jsonTo(source{"to"}, typeof(target.to))
  assert("name" in source,
         "name" & " is missing while decoding " & "TestFrameTag")
  target.name = jsonTo(source{"name"}, typeof(target.name))

proc toJsonHook*(source: TestFrameTag): JsonNode =
  result = newJObject()
  result{"direction"} = toJson(source.direction)
  result{"from"} = toJson(source.`from`)
  result{"to"} = toJson(source.to)
  result{"name"} = toJson(source.name)

proc toJsonHook*(source: TestFormat): JsonNode =
  case source
  of TestFormat.I8:
    return newJString("I8")
  of TestFormat.RGBA8888:
    return newJString("RGBA8888")
  
proc fromJsonHook*(target: var TestFormat; source: JsonNode) =
  target = case getStr(source)
  of "I8":
    TestFormat.I8
  of "RGBA8888":
    TestFormat.RGBA8888
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestPoint; source: JsonNode) =
  assert("x" in source, "x" & " is missing while decoding " & "TestPoint")
  target.x = jsonTo(source{"x"}, typeof(target.x))
  assert("y" in source, "y" & " is missing while decoding " & "TestPoint")
  target.y = jsonTo(source{"y"}, typeof(target.y))

proc toJsonHook*(source: TestPoint): JsonNode =
  result = newJObject()
  result{"x"} = toJson(source.x)
  result{"y"} = toJson(source.y)

proc fromJsonHook*(target: var TestSliceKey; source: JsonNode) =
  if "pivot" in source and source{"pivot"}.kind != JNull:
    target.pivot = some(jsonTo(source{"pivot"}, typeof(unsafeGet(target.pivot))))
  if "center" in source and source{"center"}.kind != JNull:
    target.center = some(jsonTo(source{"center"},
                                typeof(unsafeGet(target.center))))
  assert("bounds" in source,
         "bounds" & " is missing while decoding " & "TestSliceKey")
  target.bounds = jsonTo(source{"bounds"}, typeof(target.bounds))
  assert("frame" in source,
         "frame" & " is missing while decoding " & "TestSliceKey")
  target.frame = jsonTo(source{"frame"}, typeof(target.frame))

proc toJsonHook*(source: TestSliceKey): JsonNode =
  result = newJObject()
  if isSome(source.pivot):
    result{"pivot"} = toJson(source.pivot)
  if isSome(source.center):
    result{"center"} = toJson(source.center)
  result{"bounds"} = toJson(source.bounds)
  result{"frame"} = toJson(source.frame)

proc fromJsonHook*(target: var TestSlice; source: JsonNode) =
  if "data" in source and source{"data"}.kind != JNull:
    target.data = some(jsonTo(source{"data"}, typeof(unsafeGet(target.data))))
  if "color" in source and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  assert("name" in source, "name" & " is missing while decoding " & "TestSlice")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  assert("keys" in source, "keys" & " is missing while decoding " & "TestSlice")
  target.keys = jsonTo(source{"keys"}, typeof(target.keys))

proc toJsonHook*(source: TestSlice): JsonNode =
  result = newJObject()
  if isSome(source.data):
    result{"data"} = toJson(source.data)
  if isSome(source.color):
    result{"color"} = toJson(source.color)
  result{"name"} = toJson(source.name)
  result{"keys"} = toJson(source.keys)

proc toJsonHook*(source: TestBlendMode): JsonNode =
  case source
  of TestBlendMode.Multiply:
    return newJString("multiply")
  of TestBlendMode.Overlay:
    return newJString("overlay")
  of TestBlendMode.Color_burn:
    return newJString("color_burn")
  of TestBlendMode.Exclusion:
    return newJString("exclusion")
  of TestBlendMode.Color_dodge:
    return newJString("color_dodge")
  of TestBlendMode.Hsl_saturation:
    return newJString("hsl_saturation")
  of TestBlendMode.Hsl_color:
    return newJString("hsl_color")
  of TestBlendMode.Subtract:
    return newJString("subtract")
  of TestBlendMode.Divide:
    return newJString("divide")
  of TestBlendMode.Hsl_luminosity:
    return newJString("hsl_luminosity")
  of TestBlendMode.Darken:
    return newJString("darken")
  of TestBlendMode.Normal:
    return newJString("normal")
  of TestBlendMode.Hard_light:
    return newJString("hard_light")
  of TestBlendMode.Screen:
    return newJString("screen")
  of TestBlendMode.Lighten:
    return newJString("lighten")
  of TestBlendMode.Soft_light:
    return newJString("soft_light")
  of TestBlendMode.Addition:
    return newJString("addition")
  of TestBlendMode.Hsl_hue:
    return newJString("hsl_hue")
  of TestBlendMode.Difference:
    return newJString("difference")
  
proc fromJsonHook*(target: var TestBlendMode; source: JsonNode) =
  target = case getStr(source)
  of "multiply":
    TestBlendMode.Multiply
  of "overlay":
    TestBlendMode.Overlay
  of "color_burn":
    TestBlendMode.Color_burn
  of "exclusion":
    TestBlendMode.Exclusion
  of "color_dodge":
    TestBlendMode.Color_dodge
  of "hsl_saturation":
    TestBlendMode.Hsl_saturation
  of "hsl_color":
    TestBlendMode.Hsl_color
  of "subtract":
    TestBlendMode.Subtract
  of "divide":
    TestBlendMode.Divide
  of "hsl_luminosity":
    TestBlendMode.Hsl_luminosity
  of "darken":
    TestBlendMode.Darken
  of "normal":
    TestBlendMode.Normal
  of "hard_light":
    TestBlendMode.Hard_light
  of "screen":
    TestBlendMode.Screen
  of "lighten":
    TestBlendMode.Lighten
  of "soft_light":
    TestBlendMode.Soft_light
  of "addition":
    TestBlendMode.Addition
  of "hsl_hue":
    TestBlendMode.Hsl_hue
  of "difference":
    TestBlendMode.Difference
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestLayer; source: JsonNode) =
  if "blendMode" in source and source{"blendMode"}.kind != JNull:
    target.blendMode = some(jsonTo(source{"blendMode"},
                                   typeof(unsafeGet(target.blendMode))))
  if "data" in source and source{"data"}.kind != JNull:
    target.data = some(jsonTo(source{"data"}, typeof(unsafeGet(target.data))))
  if "color" in source and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  if "group" in source and source{"group"}.kind != JNull:
    target.group = some(jsonTo(source{"group"}, typeof(unsafeGet(target.group))))
  assert("name" in source, "name" & " is missing while decoding " & "TestLayer")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  if "opacity" in source and source{"opacity"}.kind != JNull:
    target.opacity = some(jsonTo(source{"opacity"},
                                 typeof(unsafeGet(target.opacity))))

proc toJsonHook*(source: TestLayer): JsonNode =
  result = newJObject()
  if isSome(source.blendMode):
    result{"blendMode"} = toJson(source.blendMode)
  if isSome(source.data):
    result{"data"} = toJson(source.data)
  if isSome(source.color):
    result{"color"} = toJson(source.color)
  if isSome(source.group):
    result{"group"} = toJson(source.group)
  result{"name"} = toJson(source.name)
  if isSome(source.opacity):
    result{"opacity"} = toJson(source.opacity)

proc fromJsonHook*(target: var TestMeta; source: JsonNode) =
  assert("scale" in source, "scale" & " is missing while decoding " & "TestMeta")
  target.scale = jsonTo(source{"scale"}, typeof(target.scale))
  if "frameTags" in source and source{"frameTags"}.kind != JNull:
    target.frameTags = some(jsonTo(source{"frameTags"},
                                   typeof(unsafeGet(target.frameTags))))
  assert("format" in source,
         "format" & " is missing while decoding " & "TestMeta")
  target.format = jsonTo(source{"format"}, typeof(target.format))
  assert("size" in source, "size" & " is missing while decoding " & "TestMeta")
  target.size = jsonTo(source{"size"}, typeof(target.size))
  if "slices" in source and source{"slices"}.kind != JNull:
    target.slices = some(jsonTo(source{"slices"},
                                typeof(unsafeGet(target.slices))))
  assert("version" in source,
         "version" & " is missing while decoding " & "TestMeta")
  target.version = jsonTo(source{"version"}, typeof(target.version))
  if "layers" in source and source{"layers"}.kind != JNull:
    target.layers = some(jsonTo(source{"layers"},
                                typeof(unsafeGet(target.layers))))
  assert("app" in source, "app" & " is missing while decoding " & "TestMeta")
  target.app = jsonTo(source{"app"}, typeof(target.app))
  assert("image" in source, "image" & " is missing while decoding " & "TestMeta")
  target.image = jsonTo(source{"image"}, typeof(target.image))

proc toJsonHook*(source: TestMeta): JsonNode =
  result = newJObject()
  result{"scale"} = toJson(source.scale)
  if isSome(source.frameTags):
    result{"frameTags"} = toJson(source.frameTags)
  result{"format"} = toJson(source.format)
  result{"size"} = toJson(source.size)
  if isSome(source.slices):
    result{"slices"} = toJson(source.slices)
  result{"version"} = toJson(source.version)
  if isSome(source.layers):
    result{"layers"} = toJson(source.layers)
  result{"app"} = toJson(source.app)
  result{"image"} = toJson(source.image)

proc fromJsonHook*(target: var TestSpriteSheet; source: JsonNode) =
  assert("frames" in source,
         "frames" & " is missing while decoding " & "TestSpriteSheet")
  target.frames = jsonTo(source{"frames"}, typeof(target.frames))
  assert("meta" in source,
         "meta" & " is missing while decoding " & "TestSpriteSheet")
  target.meta = jsonTo(source{"meta"}, typeof(target.meta))

proc toJsonHook*(source: TestSpriteSheet): JsonNode =
  result = newJObject()
  result{"frames"} = toJson(source.frames)
  result{"meta"} = toJson(source.meta)
