## The same assertions as `t_validate`, against schemas the cache will not hold
##
## `conf` carries a `urlResolver`, and a schema resolving urls is never cached, because
## the documents it fetches are invisible to the cache key. That is worth a module of
## its own: the cache writes the generated code out and `include`s the text back, while
## an uncacheable schema splices the AST straight into the caller. A name bound while
## building that AST resolves in the generator's scope rather than here, which is how
## every decoder once ended up calling the no-op `validate` instead of its own.

import std/[unittest, json, jsonutils, options]
import json_schema_import, util

importJsonSchema("examples/basic/schema.json", conf("Uncached"))
importJsonSchema("examples/string_root/schema.json", conf("UncachedRoot"))

suite "Validating a schema the cache will not hold":
  test "An object is held to what its properties assert":
    check(jsonTo(%*{"age": 4}, Uncached).age.get == 4)
    expect ValueError:
      discard jsonTo(%*{"age": -1}, Uncached)

  test "A distinct root is held to what it asserts":
    check(jsonTo(%*"short enough", UncachedRoot) == UncachedRoot("short enough"))
    expect ValueError:
      discard
        jsonTo(%*"a string that is altogether too long to be allowed", UncachedRoot)
