# Nim Json Schema Type Importer

[![Build](https://github.com/Nycto/NimJsonSchemaTypes/actions/workflows/build.yml/badge.svg)](https://github.com/Nycto/NimJsonSchemaTypes/actions/workflows/build.yml)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/Nycto/NimJsonSchemaTypes/blob/main/LICENSE)

This is a Nim package that allows [json schema](https://json-schema.org) documents to be directly
imported into a project. The types will be available, as well as helper functions for serializing
and deserializing JSON.

Everything happens at compile time: the schema is read, parsed and turned into a type section by a
macro, so nothing about the schema itself survives into the built binary.

It is intended for situations where you don't need to dynamically load the JSON schema itself. For example, if you
are building a game that uses [LDtk](https://ldtk.io) as a level editor, you could download the
[json schema](https://ldtk.io/docs/game-dev/json-overview/json-schema/) that describes the file format and directly
import it into your project. This would allow you to immediately start opening and interacting with the save
files using native Nim objects.

## Installation

```sh
nimble install json_schema_import
```

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

The root type is named after the schema's `$id` unless you give it a name yourself; nested types are
named after the keys that lead to them.

## Generated types

| Schema | Nim |
| --- | --- |
| `"string"` | `string` |
| `"integer"` | `BiggestInt` |
| `"number"` | `BiggestFloat` |
| `"boolean"` | `bool` |
| `"null"` | `Empty` |
| `"object"` with `properties` | `object` |
| `"object"` with only `additionalProperties` | `OrderedTable[string, V]` |
| `"array"` with `items` | `seq[T]` |
| `"array"` with `prefixItems` | a tuple |
| `enum` of only strings | `enum` |
| `oneOf` / `anyOf` | an object variant |
| anything unconstrained | `JsonNode` |

A property outside of `required` becomes an `Option[T]`, except for a seq or a table, which is simply
empty when the key is absent. A `$ref` that points back at an enclosing type becomes a
`ref` to that type, so recursive schemas work.

## Generated procs

Every generated type comes with:

```nim procs.nim
import json_schema_import, std/streams

importJsonSchema "address.schema.json"

let address = Address(street_address: "132 My Street", city: "Kingston", state: "NY")

# Structural equality and stringification
assert(address == address)
echo $address

# std/jsonutils
let node = address.toJson
assert(node.jsonTo(Address) == address)

# Streaming JSON, which never builds an intermediate JsonNode
let stream = newStringStream()
address.toStream(stream)
assert(Address.fromStream(stream, "address.json") == address)

# A compact binary encoding, for caching parsed documents
assert(Address.fromBinary(address.toBinary) == address)
```

The binary format is an implementation detail with no stability guarantee between versions of this
library; it is meant for a local cache, not for storage you intend to read back later.

## Validation

Assertion keywords — `minimum`, `maxLength`, `pattern`, `uniqueItems`, `enum` and friends — don't change
the generated type, so they are compiled into a `validate` proc that every decoder calls. A document
that decodes is one that satisfies them:

```nim validation.nim
import json_schema_import

jsonSchema %*{
  "$id": "/schemas/person",
  "required": [ "name" ],
  "properties": {
    "name": { "type": "string", "minLength": 3 }
  }
}

try:
  discard parseJson("""{"name": "ab"}""").jsonTo(Person)
except ValueError as e:
  echo e.msg    # Person/name does not satisfy minLength: 3

# Values built by hand are not checked until you ask
validate(Person, Person(name: "abc"))
```

Compile with `-d:jsonSchemaNoValidate` to strip the checks out entirely.

## Packing and unpacking unions

Getters and builders are automatically generated to allow interaction with union types:

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

## Configuration

Both macros take a `JsonSchemaConfig` with the following fields:

| Field | Purpose |
| --- | --- |
| `rootTypeName` | Names the root type, instead of deriving it from the schema's `$id` |
| `typePrefix` | Prefixes every generated type, to avoid collisions between two imports |
| `urlResolver` | A `proc(url: string): JsonNode` that fetches the documents a `$ref` points at |
| `noCopies` | Marks every generated object `{.error.}` to copy, forcing `move` or a `ref` |

```nim config.nim
import json_schema_import

importJsonSchema("address.schema.json", JsonSchemaConfig(
  rootTypeName: "MailingAddress",
  typePrefix: "Acme"
))

let address = AcmeMailingAddress(
    street_address: "132 My Street",
    city: "Kingston",
    state: "NY"
)
```

The prefix applies to the root type too, so this one generates `AcmeMailingAddress`. A prefix on its own is common enough to have a shorthand, `importJsonSchema "address.schema.json", "My"`.

A `urlResolver` is called at compile time, so it can only use what the Nim VM allows — `slurp` and
`staticRead` of a vendored copy, rather than an actual HTTP request.

## Compile flags

| Flag | Effect |
| --- | --- |
| `-d:dump` | Echoes the generated Nim source during the compile |
| `-d:jsonSchemaNoValidate` | Compiles out the assertion checks |
| `-d:jsonSchemaNoCache` | Turns the on-disk code cache off |
| `-d:jsonSchemaCacheDir=<path>` | Writes the code cache somewhere other than `nimcache` |

## Build caching

Generated schema code is cached to disk after the first compile and re-used for subsequent compile passes.
By default the cache lives inside `nimcache`, so it is cleaned up alongside the rest of nimcache and never
touches your source tree. `-d:jsonSchemaCacheDir` is useful when a project builds several targets, since
each target otherwise keeps its own nimcache and therefore its own copy of the cache.

The cache is keyed by the schema document, every config field that affects the output, the nim version, and the
version of this library, so any change to those produces a fresh entry rather than a stale hit. Schemas that use
a `urlResolver` are never cached, because the documents it pulls in are not visible to that key.

Caching is best effort: if the cache directory cannot be written to, the build simply generates the code as it
otherwise would.
