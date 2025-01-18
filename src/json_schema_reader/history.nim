import std/strformat

type
    History* = ref object
        parent: History
        name: string

proc add*(parent: History, name: auto): History = History(parent: parent, name: $name)

proc `$`*(history: History): string =
    if history == nil:
        return ""
    elif history.parent == nil:
        return history.name
    else:
        return fmt"{history.parent}/{history.name}"