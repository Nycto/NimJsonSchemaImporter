import json_schema_import, std/[unittest, json, jsonutils, options, streams, strutils]

importJsonSchema "./examples/bool_schema/schema.json"

## `emptyList` is written as an `items: false`, so the only array that satisfies it is the
## empty one -- a fixed length array of length zero, which is Nim's empty tuple

template sample(emptyList: string): string =
  """{
    "anything": 1,
    "list": [],
    "bag": {},
    "closedTuple": ["a", 1],
    "legacyClosed": [true, "b"],
    """ &
    emptyList & """
    "eitherOr": "x",
    "closedBag": { "named": "n" }
  }"""

suite "A list that can only ever be empty":
  test "Decodes the empty list it is allowed to hold":
    let parsed = sample(""""emptyList": [],""").parseJson.jsonTo(Bool_schema)
    check(parsed.emptyList == some(default(tuple[])))

  test "Stays absent when the document leaves it out":
    check(sample("").parseJson.jsonTo(Bool_schema).emptyList.isNone)

  test "Streams the empty list it is allowed to hold":
    let parsed =
      fromStream(Bool_schema, newStringStream(sample(""""emptyList": [],""")), "sample")
    check(parsed.emptyList.isSome)

  test "Rejects a streamed list with anything in it":
    expect JsonParsingError:
      discard fromStream(
        Bool_schema, newStringStream(sample(""""emptyList": [1, 2],""")), "sample"
      )

  test "Encodes back to an empty list":
    let parsed = sample(""""emptyList": [],""").parseJson.jsonTo(Bool_schema)
    check(parsed.toJson{"emptyList"} == newJArray())

  test "Survives a binary round trip":
    let parsed = sample(""""emptyList": [],""").parseJson.jsonTo(Bool_schema)
    check(fromBinary(Bool_schema, toBinary(parsed)).emptyList.isSome)

  test "Prints as a tuple of no slots":
    check(
      "emptyList: ()" in $sample(""""emptyList": [],""").parseJson.jsonTo(Bool_schema)
    )
