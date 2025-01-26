# Nim Json Schema Type Importer

[![Build](https://github.com/Nycto/NimJsonSchemaTypes/actions/workflows/build.yml/badge.svg)](https://github.com/Nycto/NimJsonSchemaTypes/actions/workflows/build.yml)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/Nycto/NimJsonSchemaTypes/blob/main/LICENSE)

This is a Nim package that allows [json schema](https://json-schema.org) documents to be directly
imported into a project. The types will available, as well as helper functions for serializing
and deserializing JSON.

It is intended for situations where you don't need to dynamically load the JSON schema itself. For example, if you
are building a game that uses [LDtk](https://ldtk.io) as a level editor, you could download the
[json schema](https://ldtk.io/docs/game-dev/json-overview/json-schema/) that describes the file format and directly
import it into your project. This would allow you to immediately start opening and interacting with the save
files using native Nim objects.

## Example

Given a simple json schema file:

```json address.schema.json
{
  "$id": "/schemas/address",
  "type": "object",
  "properties": {
    "street_address": { "type": "string" },
    "city": { "type": "string" },
    "state": { "type": "string" }
  },
  "required": ["street_address", "city", "state"]
}
```

This can be directly imported into a nim file as follows:

```nim basic.nim
import json_schema_import

importJsonSchema "address.schema.json"

let address = parseJson("""
  {
    "city":"Kingston",
    "street_address":"132 My Street",
    "state":"NY"
  }
""").jsonTo(Address)

echo "Nim object: ", address.repr

echo "Converted back to JSON: ", address.toJson
```

## Prefixing types

If your import creates naming collisions, you can add a prefix to every generated type:

```nim typePrefix.nim
import json_schema_import

importJsonSchema "address.schema.json", "My"

let address = MyAddress(
    street_address: "132 My Street",
    city: "Kingston",
    state: "NY"
)
```

## Packing and unpacking unions

Getters and builders are automatically generated to allow interactiction with union types:

```nim unions.nim
import json_schema_import

# Schemas can be loaded from inline json blocks
jsonSchema %*{
  "$id": "/schemas/unionContainer",
  "required": [ "value" ],
  "properties": {
    "value": {
      "anyOf": [
        { "type": "string" },
        { "type": "integer" },
      ]
    }
  }
}

# Creating a union from an integer
block:
  let unioned = UnionContainer(value: forUnion(123))
  assert(unioned.value.isInt)
  echo unioned.value.asInt

# Creating a union from a string. Notice the `forUnion` call above isn't required,
# as converters are created to automatically wrap types in union objects when possible.
block:
  let unioned = UnionContainer(value: "foo")
  assert(unioned.value.isStr)
  echo unioned.value.asStr
```

## Showing the generated types

To see the exact nim code being generated, you can add the `-d:dump` compile flag. It will cause the generated
code to be printed during compile.
