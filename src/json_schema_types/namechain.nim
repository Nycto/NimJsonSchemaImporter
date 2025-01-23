import std/strutils

type
    NameChain* = ref object
        name, category: string
        parent: NameChain

proc rootName*(name: string): auto =
    return if name != "": NameChain(name: name) else: nil

proc add*(parent: NameChain, child: string): auto =
    if child != "":
        return NameChain(parent: parent, name: child.capitalizeAscii)
    else:
        return parent

proc categorize*(parent: NameChain, category: string): auto =
    if category == "":
        return parent
    assert(parent != nil)
    result.new
    result[] = parent[]
    result.category = category.capitalizeAscii

iterator nameOptions*(name: NameChain, prefix: string): string =
    var accum: string
    var next = name
    while next != nil:
        accum = next.name & accum
        yield prefix & accum

        if next.category != "":
            accum &= next.category
            yield prefix & accum

        next = next.parent

    if accum != "":
        var i = 2
        while true:
            yield prefix & accum & $i
            inc i
