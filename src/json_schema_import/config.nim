import std/[json, hashes]

type
  JsonSchemaConfig* = object ## The configuration required for parsing a json schema
    rootTypeName*: string
    typePrefix*: string
    urlResolver*: UrlResolver
    noCopies*: bool

  UrlResolver* = proc(url: string): JsonNode
    ## Callback that resolves remote URL references to a schema

proc cacheKeyHash*(conf: JsonSchemaConfig): Hash =
  ## Hashes the settings that change the generated code
  ##
  ## This is what keys the on-disk code cache, so any field added above that affects the
  ## output has to be folded in here as well. Missing one means a build reusing code
  ## generated under the previous value of that field.
  return !$(conf.rootTypeName.hash !& conf.typePrefix.hash !& conf.noCopies.hash)

proc cacheable*(conf: JsonSchemaConfig): bool =
  ## Whether code generated with this config is safe to cache
  ##
  ## A `urlResolver` pulls in documents from outside the schema being compiled, and
  ## those are invisible to `cacheKeyHash`. Caching them would mean serving stale code once a
  ## remote document changes, so schemas using a resolver are always regenerated.
  conf.urlResolver == nil
