import json_schema_import, std/[unittest, json, jsonutils, options]

importJsonSchema "./examples/open_object/schema.json"

## A schema node that names its properties and also describes what any other key would
## hold generates just the object. That the other keys are dropped rather than kept cannot
## be shown in the snapshot corpus, because `-d:rebuild` writes the re-encoded document
## back over the sample, so it is asserted here instead.

suite "Objects with both properties and additionalProperties":
  test "Keys the object does not name are dropped":
    let parsed = """{
      "partlyOpen": {"known": "hello", "extra": "gone"},
      "closed": {"alsoKnown": "world"},
      "anyValue": {"a": 1}
    }""".parseJson.jsonTo(
      Open_object
    )

    check(parsed.partlyOpen.known == some("hello"))
    check(parsed.toJson{"partlyOpen"} == %*{"known": "hello"})
