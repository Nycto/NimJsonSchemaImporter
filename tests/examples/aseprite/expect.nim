{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `TestSpriteSheet`* = object
    `frames`*: `TestTestSpriteSheet_framesUnion`
    `meta`*: `TestMeta`
  `TestTestSpriteSheet_framesUnion`* = object
    case kind*: range[0 .. 1]
    of 0:
      key0*: Table[string, `TestFrame`]
    of 1:
      key1*: seq[`TestArrayFrame`]
  `TestLayer`* = object
    `blendMode`*: Option[`TestBlendMode`]
    `data`*: Option[string]
    `color`*: Option[string]
    `group`*: Option[string]
    `name`*: string
    `opacity`*: Option[BiggestFloat]
  `TestFormat`* = enum
    `I8`, `RGBA8888`
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
  `TestSize`* = object
    `w`*: BiggestFloat
    `h`*: BiggestFloat
  `TestPoint`* = object
    `x`*: BiggestFloat
    `y`*: BiggestFloat
  `TestBlendMode`* = enum
    `Multiply`, `Overlay`, `Color_burn`, `Exclusion`, `Color_dodge`,
    `Hsl_saturation`, `Hsl_color`, `Subtract`, `Divide`, `Hsl_luminosity`,
    `Darken`, `Normal`, `Hard_light`, `Screen`, `Lighten`, `Soft_light`,
    `Addition`, `Hsl_hue`, `Difference`
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
  `TestDirection`* = enum
    `Pingpong`, `Forward`, `Reverse`
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
proc fromJsonHook*(target: var `TestTestSpriteSheet_framesUnion`;
                   source: JsonNode) =
  if source.kind == JObject:
    target = `TestTestSpriteSheet_framesUnion`(kind: 0,
        key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JArray:
    target = `TestTestSpriteSheet_framesUnion`(kind: 1,
        key1: jsonTo(source, typeof(target.key1)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to TestTestSpriteSheet_framesUnion")
  
proc toJsonHook*(source: `TestTestSpriteSheet_framesUnion`): JsonNode =
  case source.kind
  of 0:
    return toJson(source.key0)
  of 1:
    return toJson(source.key1)
  
proc toJsonHook*(source: `TestDirection`): JsonNode =
  case source
  of `TestDirection`.`Pingpong`:
    return newJString("pingpong")
  of `TestDirection`.`Forward`:
    return newJString("forward")
  of `TestDirection`.`Reverse`:
    return newJString("reverse")
  
proc toJsonHook*(source: `TestFormat`): JsonNode =
  case source
  of `TestFormat`.`I8`:
    return newJString("I8")
  of `TestFormat`.`RGBA8888`:
    return newJString("RGBA8888")
  
proc toJsonHook*(source: `TestBlendMode`): JsonNode =
  case source
  of `TestBlendMode`.`Multiply`:
    return newJString("multiply")
  of `TestBlendMode`.`Overlay`:
    return newJString("overlay")
  of `TestBlendMode`.`Color_burn`:
    return newJString("color_burn")
  of `TestBlendMode`.`Exclusion`:
    return newJString("exclusion")
  of `TestBlendMode`.`Color_dodge`:
    return newJString("color_dodge")
  of `TestBlendMode`.`Hsl_saturation`:
    return newJString("hsl_saturation")
  of `TestBlendMode`.`Hsl_color`:
    return newJString("hsl_color")
  of `TestBlendMode`.`Subtract`:
    return newJString("subtract")
  of `TestBlendMode`.`Divide`:
    return newJString("divide")
  of `TestBlendMode`.`Hsl_luminosity`:
    return newJString("hsl_luminosity")
  of `TestBlendMode`.`Darken`:
    return newJString("darken")
  of `TestBlendMode`.`Normal`:
    return newJString("normal")
  of `TestBlendMode`.`Hard_light`:
    return newJString("hard_light")
  of `TestBlendMode`.`Screen`:
    return newJString("screen")
  of `TestBlendMode`.`Lighten`:
    return newJString("lighten")
  of `TestBlendMode`.`Soft_light`:
    return newJString("soft_light")
  of `TestBlendMode`.`Addition`:
    return newJString("addition")
  of `TestBlendMode`.`Hsl_hue`:
    return newJString("hsl_hue")
  of `TestBlendMode`.`Difference`:
    return newJString("difference")
  