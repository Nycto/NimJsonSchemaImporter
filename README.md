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

```nim example.nim
import json_schema_import

importJsonSchema "address.schema.json"

let address = Address(
    street_address: "132 My Street",
    city: "Kingston",
    state: "NY"
)

echo "Json representation: ", address.toJson
```
