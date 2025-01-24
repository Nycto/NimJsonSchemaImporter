import json_schema_import, std/[json, unittest, tables]

jsonSchema %*{
    "$ref": "#/definitions/People",
    "definitions": {
        "Person": {
            "required": [ "name", "age" ],
            "properties": {
                "name": { "type": "string" },
                "age": { "type": "integer" },
            }
        },
        "People": {
            "required": [ "entries" ],
            "properties": {
                "entries": {
                    "anyOf": [
                        {
                            "additionalProperties": {
                                "$ref": "#/definitions/Person"
                            }
                        },
                        {
                            "items": {
                                "$ref": "#/definitions/Person"
                            },
                            "type": "array"
                        }
                    ]
                }
            }
        }
    }
}

suite "Interacting with unions":

    test "Reading a union as a seq":
        let obj = """{
            "entries": [
                { "name": "Jack", "age": 41 },
                { "name": "Jill", "age": 42 }
            ]
        }
        """.parseJson.jsonTo(People)

        var names: seq[string]
        var ages: seq[int]

        check(obj.entries.isSeq)
        for entry in obj.entries.asSeq:
            names.add(entry.name)
            ages.add(entry.age)

        check(names == @[ "Jack", "Jill" ])
        check(ages == @[ 41, 42 ])

    test "Reading a union as a map":
        let obj = """{
            "entries": {
                "a": { "name": "Jack", "age": 41 },
                "b": { "name": "Jill", "age": 42 }
            }
        }
        """.parseJson.jsonTo(People)

        check(obj.entries.isMap)
        check(obj.entries.asMap.len == 2)
        check(obj.entries.asMap["a"].name == "Jack")
        check(obj.entries.asMap["a"].age == 41)
        check(obj.entries.asMap["b"].name == "Jill")
        check(obj.entries.asMap["b"].age == 42)
