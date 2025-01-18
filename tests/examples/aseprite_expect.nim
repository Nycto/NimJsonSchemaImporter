type
  AsepriteSourceSize* = object
    w*: BiggestFloat
    h*: BiggestFloat
  AsepriteSpriteSourceSize* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  AsepriteFrame* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  AsepriteFrames0* = object
    sourceSize*: AsepriteSourceSize
    duration*: BiggestFloat
    rotated*: bool
    trimmed*: bool
    spriteSourceSize*: AsepriteSpriteSourceSize
    frame*: AsepriteFrame
  AsepriteSourceSize* = object
    w*: BiggestFloat
    h*: BiggestFloat
  AsepriteSpriteSourceSize* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  AsepriteFrame* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  AsepriteFrames1* = object
    sourceSize*: AsepriteSourceSize
    duration*: BiggestFloat
    rotated*: bool
    trimmed*: bool
    spriteSourceSize*: AsepriteSpriteSourceSize
    filename*: string
    frame*: AsepriteFrame
  AsepriteFrames* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, AsepriteFrames0]
    of 1:
      key1: seq[AsepriteFrames1]
  AsepriteDirection* = enum
    pingpong, forward, reverse
  AsepriteFrameTags* = object
    direction*: AsepriteDirection
    from*: BiggestFloat
    to*: BiggestFloat
    name*: string
  AsepriteFormat* = enum
    I8, RGBA8888
  AsepriteSize* = object
    w*: BiggestFloat
    h*: BiggestFloat
  AsepritePivot* = object
    x*: BiggestFloat
    y*: BiggestFloat
  AsepriteCenter* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  AsepriteBounds* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  AsepriteKeys* = object
    pivot*: AsepritePivot
    center*: AsepriteCenter
    bounds*: AsepriteBounds
    frame*: BiggestFloat
  AsepriteSlices* = object
    data*: string
    color*: string
    name*: string
    keys*: seq[AsepriteKeys]
  AsepriteBlendMode* = enum
    multiply, overlay, color_burn, exclusion, color_dodge, hsl_saturation,
    hsl_color, subtract, divide, hsl_luminosity, darken, normal, hard_light,
    screen, lighten, soft_light, addition, hsl_hue, difference
  AsepriteLayers* = object
    blendMode*: AsepriteBlendMode
    data*: string
    color*: string
    group*: string
    name*: string
    opacity*: BiggestFloat
  AsepriteMeta* = object
    scale*: string
    frameTags*: seq[AsepriteFrameTags]
    format*: AsepriteFormat
    size*: AsepriteSize
    slices*: seq[AsepriteSlices]
    version*: string
    layers*: seq[AsepriteLayers]
    app*: string
    image*: string
  AsepriteAseprite* = object
    frames*: AsepriteFrames
    meta*: AsepriteMeta