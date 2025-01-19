import std/[json, tables, options]
type
  `AsepriteRectangle`* = object
    `x`*: BiggestFloat
    `w`*: BiggestFloat
    `y`*: BiggestFloat
    `h`*: BiggestFloat
  `AsepriteSliceKey`* = object
    `pivot`*: Option[`AsepritePoint`]
    `center`*: Option[`AsepriteRectangle`]
    `bounds`*: `AsepriteRectangle`
    `frame`*: BiggestFloat
  `AsepriteFrame`* = object
    `sourceSize`*: `AsepriteSize`
    `duration`*: BiggestFloat
    `rotated`*: bool
    `trimmed`*: bool
    `spriteSourceSize`*: `AsepriteRectangle`
    `frame`*: `AsepriteRectangle`
  `AsepriteLayer`* = object
    `blendMode`*: Option[`AsepriteBlendMode`]
    `data`*: Option[string]
    `color`*: Option[string]
    `group`*: Option[string]
    `name`*: string
    `opacity`*: Option[BiggestFloat]
  `AsepriteDirection`* = enum
    pingpong, forward, reverse
  `AsepritePoint`* = object
    `x`*: BiggestFloat
    `y`*: BiggestFloat
  `AsepriteFramesUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, `AsepriteFrame`]
    of 1:
      key1: seq[`AsepriteArrayFrame`]
  `AsepriteArrayFrame`* = object
    `sourceSize`*: `AsepriteSize`
    `duration`*: BiggestFloat
    `rotated`*: bool
    `trimmed`*: bool
    `spriteSourceSize`*: `AsepriteRectangle`
    `filename`*: string
    `frame`*: `AsepriteRectangle`
  `AsepriteMeta`* = object
    `scale`*: string
    `frameTags`*: Option[seq[`AsepriteFrameTag`]]
    `format`*: `AsepriteFormat`
    `size`*: `AsepriteSize`
    `slices`*: Option[seq[`AsepriteSlice`]]
    `version`*: string
    `layers`*: Option[seq[`AsepriteLayer`]]
    `app`*: string
    `image`*: string
  `AsepriteSize`* = object
    `w`*: BiggestFloat
    `h`*: BiggestFloat
  `AsepriteBlendMode`* = enum
    multiply, overlay, color_burn, exclusion, color_dodge, hsl_saturation,
    hsl_color, subtract, divide, hsl_luminosity, darken, normal, hard_light,
    screen, lighten, soft_light, addition, hsl_hue, difference
  `AsepriteSpriteSheet`* = object
    `frames`*: `AsepriteFramesUnion`
    `meta`*: `AsepriteMeta`
  `AsepriteFrameTag`* = object
    `direction`*: `AsepriteDirection`
    `from`*: BiggestFloat
    `to`*: BiggestFloat
    `name`*: string
  `AsepriteSlice`* = object
    `data`*: Option[string]
    `color`*: Option[string]
    `name`*: string
    `keys`*: seq[`AsepriteSliceKey`]
  `AsepriteFormat`* = enum
    I8, RGBA8888