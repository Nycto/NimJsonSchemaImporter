type
  ArrayOfThingsVegetables* = object
    `veggieName`*: string
    `veggieLike`*: bool
  ArrayOfThingsArrayOfThings* = object
    `vegetables`*: seq[ArrayOfThingsVegetables]
    `fruits`*: seq[string]