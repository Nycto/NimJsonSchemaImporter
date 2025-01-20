import std/[json, tables, options]
type
  `TestDirection`* = enum
    pingpong, forward, reverse
  `TestLayer`* = object
    `blendMode`*: Option[`TestBlendMode`]
    `data`*: Option[string]
    `color`*: Option[string]
    `group`*: Option[string]
    `name`*: string
    `opacity`*: Option[BiggestFloat]
  `TestFrameTag`* = object
    `direction`*: `TestDirection`
    `from`*: BiggestFloat
    `to`*: BiggestFloat
    `name`*: string
  `TestRectangle`* = object
    `x`*: BiggestFloat
    `w`*: BiggestFloat
    `y`*: BiggestFloat
    `h`*: BiggestFloat
  `TestSliceKey`* = object
    `pivot`*: Option[`TestPoint`]
    `center`*: Option[`TestRectangle`]
    `bounds`*: `TestRectangle`
    `frame`*: BiggestFloat
  `TestSlice`* = object
    `data`*: Option[string]
    `color`*: Option[string]
    `name`*: string
    `keys`*: seq[`TestSliceKey`]
  `TestTestSpriteSheet_FramesUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, `TestFrame`]
    of 1:
      key1: seq[`TestArrayFrame`]
  `TestFormat`* = enum
    I8, RGBA8888
  `TestSize`* = object
    `w`*: BiggestFloat
    `h`*: BiggestFloat
  `TestPoint`* = object
    `x`*: BiggestFloat
    `y`*: BiggestFloat
  `TestArrayFrame`* = object
    `sourceSize`*: `TestSize`
    `duration`*: BiggestFloat
    `rotated`*: bool
    `trimmed`*: bool
    `spriteSourceSize`*: `TestRectangle`
    `filename`*: string
    `frame`*: `TestRectangle`
  `TestFrame`* = object
    `sourceSize`*: `TestSize`
    `duration`*: BiggestFloat
    `rotated`*: bool
    `trimmed`*: bool
    `spriteSourceSize`*: `TestRectangle`
    `frame`*: `TestRectangle`
  `TestSpriteSheet`* = object
    `frames`*: `TestTestSpriteSheet_FramesUnion`
    `meta`*: `TestMeta`
  `TestMeta`* = object
    `scale`*: string
    `frameTags`*: Option[seq[`TestFrameTag`]]
    `format`*: `TestFormat`
    `size`*: `TestSize`
    `slices`*: Option[seq[`TestSlice`]]
    `version`*: string
    `layers`*: Option[seq[`TestLayer`]]
    `app`*: string
    `image`*: string
  `TestBlendMode`* = enum
    multiply, overlay, color_burn, exclusion, color_dodge, hsl_saturation,
    hsl_color, subtract, divide, hsl_luminosity, darken, normal, hard_light,
    screen, lighten, soft_light, addition, hsl_hue, difference