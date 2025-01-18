type
  sourceSize* = object
    w*: BiggestFloat
    h*: BiggestFloat
  spriteSourceSize* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  frame* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  frames0* = object
    sourceSize*: sourceSize
    duration*: BiggestFloat
    rotated*: bool
    trimmed*: bool
    spriteSourceSize*: spriteSourceSize
    frame*: frame
  sourceSize* = object
    w*: BiggestFloat
    h*: BiggestFloat
  spriteSourceSize* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  frame* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  frames1* = object
    sourceSize*: sourceSize
    duration*: BiggestFloat
    rotated*: bool
    trimmed*: bool
    spriteSourceSize*: spriteSourceSize
    filename*: string
    frame*: frame
  frames* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, frames0]
    of 1:
      key1: seq[frames1]
  direction* = enum
    pingpong, forward, reverse
  frameTags* = object
    direction*: direction
    from*: BiggestFloat
    to*: BiggestFloat
    name*: string
  format* = enum
    I8, RGBA8888
  size* = object
    w*: BiggestFloat
    h*: BiggestFloat
  pivot* = object
    x*: BiggestFloat
    y*: BiggestFloat
  center* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  bounds* = object
    x*: BiggestFloat
    w*: BiggestFloat
    y*: BiggestFloat
    h*: BiggestFloat
  keys* = object
    pivot*: pivot
    center*: center
    bounds*: bounds
    frame*: BiggestFloat
  slices* = object
    data*: string
    color*: string
    name*: string
    keys*: seq[keys]
  blendMode* = enum
    multiply, overlay, color_burn, exclusion, color_dodge, hsl_saturation,
    hsl_color, subtract, divide, hsl_luminosity, darken, normal, hard_light,
    screen, lighten, soft_light, addition, hsl_hue, difference
  layers* = object
    blendMode*: blendMode
    data*: string
    color*: string
    group*: string
    name*: string
    opacity*: BiggestFloat
  meta* = object
    scale*: string
    frameTags*: seq[frameTags]
    format*: format
    size*: size
    slices*: seq[slices]
    version*: string
    layers*: seq[layers]
    app*: string
    image*: string
  aseprite* = object
    frames*: frames
    meta*: meta