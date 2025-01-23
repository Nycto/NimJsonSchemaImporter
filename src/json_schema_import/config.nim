import std/json

type
    JsonSchemaConfig* = object
        ## The configuration required for parsing a json schema
        rootTypeName*: string
        typePrefix*: string
        urlResolver*: UrlResolver

    UrlResolver* = proc (url: string): JsonNode
        ## Callback that resolves remote URL references to a schema