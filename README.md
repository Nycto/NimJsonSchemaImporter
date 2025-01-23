# Nim Json Schema Type Importer

[![Build](https://github.com/Nycto/NimJsonSchemaTypes/actions/workflows/build.yml/badge.svg)](https://github.com/Nycto/NimJsonSchemaTypes/actions/workflows/build.yml)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/Nycto/NimJsonSchemaTypes/blob/main/LICENSE)

This is a Nim package that allows [json schema](https://json-schema.org) documents to be directly
imported into a project. The types will available, as well as helper functions for serializing
and deserializing JSON.

## Example

Given a simple json schema file:

```json
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

```nim
import json_schema_import

importJsonSchema "address.schema.json"

let address = Address(
    street_address: "132 My Street",
    city: "Kingston",
    state: "NY"
)

echo "Json representation: ", address.toJson
```
