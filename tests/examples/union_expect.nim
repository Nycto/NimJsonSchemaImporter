type
  key1* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: BiggestInt
  union* = object
    key1*: key1
    key2*: string