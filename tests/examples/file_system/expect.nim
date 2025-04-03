{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

type
  File_systemType* = enum
    Disk = "disk"
  File_systemDiskDevice* = object
    `type`*: File_systemType
    device*: string
  File_systemStorageType* = enum
    Disk = "disk"
  File_systemDiskUUID* = object
    `type`*: File_systemStorageType
    label*: string
  File_systemStorageType2* = enum
    Nfs = "nfs"
  File_systemNfs* = object
    `type`*: File_systemStorageType2
    remotePath*: string
    server*: string
  File_systemStorageType3* = enum
    Tmpfs = "tmpfs"
  File_systemTmpfs* = object
    `type`*: File_systemStorageType3
    sizeInMB*: BiggestInt
  File_systemUnion* = object
    case kind*: range[0 .. 3]
    of 0:
      key0*: File_systemDiskDevice
    of 1:
      key1*: File_systemDiskUUID
    of 2:
      key2*: File_systemNfs
    of 3:
      key3*: File_systemTmpfs
  File_systemFstype* = enum
    Ext3 = "ext3", Ext4 = "ext4", Btrfs = "btrfs"
  File_system* = object
    storage*: File_systemUnion
    fstype*: Option[File_systemFstype]
    options*: Option[seq[string]]
    readonly*: Option[bool]
proc toJsonHook*(source: File_systemDiskDevice): JsonNode
proc toJsonHook*(source: File_systemDiskUUID): JsonNode
proc toJsonHook*(source: File_systemNfs): JsonNode
proc toJsonHook*(source: File_systemTmpfs): JsonNode
proc toJsonHook*(source: File_system): JsonNode
proc equals(_: typedesc[File_systemDiskDevice]; a, b: File_systemDiskDevice): bool =
  equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.device), a.device, b.device)

proc `==`*(a, b: File_systemDiskDevice): bool =
  return equals(File_systemDiskDevice, a, b)

proc stringify(_: typedesc[File_systemDiskDevice]; value: File_systemDiskDevice): string =
  stringifyObj("File_systemDiskDevice",
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("device", stringify(typeof(value.device), value.device)))

proc `$`*(value: File_systemDiskDevice): string =
  stringify(File_systemDiskDevice, value)

proc fromJsonHook*(target: var File_systemDiskDevice; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "File_systemDiskDevice")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert(hasKey(source, "device"),
         "device" & " is missing while decoding " & "File_systemDiskDevice")
  target.device = jsonTo(source{"device"}, typeof(target.device))

proc toJsonHook*(source: File_systemDiskDevice): JsonNode =
  result = newJObject()
  result{"type"} = `%`(source.`type`)
  result{"device"} = newJString(source.device)

converter forFile_systemUnion*(value: File_systemDiskDevice): File_systemUnion =
  return File_systemUnion(kind: 0, key0: value)

proc equals(_: typedesc[File_systemDiskUUID]; a, b: File_systemDiskUUID): bool =
  equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.label), a.label, b.label)

proc `==`*(a, b: File_systemDiskUUID): bool =
  return equals(File_systemDiskUUID, a, b)

proc stringify(_: typedesc[File_systemDiskUUID]; value: File_systemDiskUUID): string =
  stringifyObj("File_systemDiskUUID",
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("label", stringify(typeof(value.label), value.label)))

proc `$`*(value: File_systemDiskUUID): string =
  stringify(File_systemDiskUUID, value)

proc fromJsonHook*(target: var File_systemDiskUUID; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "File_systemDiskUUID")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert(hasKey(source, "label"),
         "label" & " is missing while decoding " & "File_systemDiskUUID")
  target.label = jsonTo(source{"label"}, typeof(target.label))

proc toJsonHook*(source: File_systemDiskUUID): JsonNode =
  result = newJObject()
  result{"type"} = `%`(source.`type`)
  result{"label"} = newJString(source.label)

converter forFile_systemUnion*(value: File_systemDiskUUID): File_systemUnion =
  return File_systemUnion(kind: 1, key1: value)

proc equals(_: typedesc[File_systemNfs]; a, b: File_systemNfs): bool =
  equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.remotePath), a.remotePath, b.remotePath) and
      equals(typeof(a.server), a.server, b.server)

proc `==`*(a, b: File_systemNfs): bool =
  return equals(File_systemNfs, a, b)

proc stringify(_: typedesc[File_systemNfs]; value: File_systemNfs): string =
  stringifyObj("File_systemNfs",
               ("type", stringify(typeof(value.`type`), value.`type`)), (
      "remotePath", stringify(typeof(value.remotePath), value.remotePath)),
               ("server", stringify(typeof(value.server), value.server)))

proc `$`*(value: File_systemNfs): string =
  stringify(File_systemNfs, value)

proc fromJsonHook*(target: var File_systemNfs; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "File_systemNfs")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert(hasKey(source, "remotePath"),
         "remotePath" & " is missing while decoding " & "File_systemNfs")
  target.remotePath = jsonTo(source{"remotePath"}, typeof(target.remotePath))
  assert(hasKey(source, "server"),
         "server" & " is missing while decoding " & "File_systemNfs")
  target.server = jsonTo(source{"server"}, typeof(target.server))

proc toJsonHook*(source: File_systemNfs): JsonNode =
  result = newJObject()
  result{"type"} = `%`(source.`type`)
  result{"remotePath"} = newJString(source.remotePath)
  result{"server"} = newJString(source.server)

converter forFile_systemUnion*(value: File_systemNfs): File_systemUnion =
  return File_systemUnion(kind: 2, key2: value)

proc equals(_: typedesc[File_systemTmpfs]; a, b: File_systemTmpfs): bool =
  equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.sizeInMB), a.sizeInMB, b.sizeInMB)

proc `==`*(a, b: File_systemTmpfs): bool =
  return equals(File_systemTmpfs, a, b)

proc stringify(_: typedesc[File_systemTmpfs]; value: File_systemTmpfs): string =
  stringifyObj("File_systemTmpfs",
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("sizeInMB", stringify(typeof(value.sizeInMB), value.sizeInMB)))

proc `$`*(value: File_systemTmpfs): string =
  stringify(File_systemTmpfs, value)

proc fromJsonHook*(target: var File_systemTmpfs; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "File_systemTmpfs")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert(hasKey(source, "sizeInMB"),
         "sizeInMB" & " is missing while decoding " & "File_systemTmpfs")
  target.sizeInMB = jsonTo(source{"sizeInMB"}, typeof(target.sizeInMB))

proc toJsonHook*(source: File_systemTmpfs): JsonNode =
  result = newJObject()
  result{"type"} = `%`(source.`type`)
  result{"sizeInMB"} = newJInt(source.sizeInMB)

converter forFile_systemUnion*(value: File_systemTmpfs): File_systemUnion =
  return File_systemUnion(kind: 3, key3: value)

proc equals(_: typedesc[File_systemUnion]; a, b: File_systemUnion): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return equals(typeof(a.key0), a.key0, b.key0)
  of 1:
    return equals(typeof(a.key1), a.key1, b.key1)
  of 2:
    return equals(typeof(a.key2), a.key2, b.key2)
  of 3:
    return equals(typeof(a.key3), a.key3, b.key3)
  
proc `==`*(a, b: File_systemUnion): bool =
  return equals(File_systemUnion, a, b)

proc stringify(_: typedesc[File_systemUnion]; value: File_systemUnion): string =
  case value.kind
  of 0:
    return stringify(typeof(value.key0), value.key0)
  of 1:
    return stringify(typeof(value.key1), value.key1)
  of 2:
    return stringify(typeof(value.key2), value.key2)
  of 3:
    return stringify(typeof(value.key3), value.key3)
  
proc `$`*(value: File_systemUnion): string =
  stringify(File_systemUnion, value)

proc fromJsonHook*(target: var File_systemUnion; source: JsonNode) =
  if source.kind == JObject and hasKey(source, "device"):
    target = File_systemUnion(kind: 0, key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject and hasKey(source, "label"):
    target = File_systemUnion(kind: 1, key1: jsonTo(source, typeof(target.key1)))
  elif source.kind == JObject and hasKey(source, "server"):
    target = File_systemUnion(kind: 2, key2: jsonTo(source, typeof(target.key2)))
  elif source.kind == JObject and hasKey(source, "sizeInMB"):
    target = File_systemUnion(kind: 3, key3: jsonTo(source, typeof(target.key3)))
  else:
    raise newException(ValueError,
                       "Unable to deserialize json node to File_systemUnion")
  
proc toJsonHook*(source: File_systemUnion): JsonNode =
  case source.kind
  of 0:
    toJsonHook(source.key0)
  of 1:
    toJsonHook(source.key1)
  of 2:
    toJsonHook(source.key2)
  of 3:
    toJsonHook(source.key3)
  
proc isDiskDevice*(value: File_systemUnion): bool =
  value.kind == 0

proc asDiskDevice*(value: File_systemUnion): auto =
  assert(value.kind == 0)
  return value.key0

proc isDiskUUID*(value: File_systemUnion): bool =
  value.kind == 1

proc asDiskUUID*(value: File_systemUnion): auto =
  assert(value.kind == 1)
  return value.key1

proc isNfs*(value: File_systemUnion): bool =
  value.kind == 2

proc asNfs*(value: File_systemUnion): auto =
  assert(value.kind == 2)
  return value.key2

proc isTmpfs*(value: File_systemUnion): bool =
  value.kind == 3

proc asTmpfs*(value: File_systemUnion): auto =
  assert(value.kind == 3)
  return value.key3

proc toBinary*(target: var string; source: File_systemUnion) =
  toBinary(target, source.kind)
  case source.kind
  of 0:
    toBinary(target, source.key0)
  of 1:
    toBinary(target, source.key1)
  of 2:
    toBinary(target, source.key2)
  of 3:
    toBinary(target, source.key3)
  
proc fromBinary(_: typedesc[File_systemUnion]; source: string; idx: var int): File_systemUnion =
  case fromBinary(range[0 .. 3], source, idx)
  of 0:
    return File_systemUnion(kind: 0,
                            key0: fromBinary(typeof(result.key0), source, idx))
  of 1:
    return File_systemUnion(kind: 1,
                            key1: fromBinary(typeof(result.key1), source, idx))
  of 2:
    return File_systemUnion(kind: 2,
                            key2: fromBinary(typeof(result.key2), source, idx))
  of 3:
    return File_systemUnion(kind: 3,
                            key3: fromBinary(typeof(result.key3), source, idx))
  
proc equals(_: typedesc[File_system]; a, b: File_system): bool =
  equals(typeof(a.storage), a.storage, b.storage) and
      equals(typeof(a.fstype), a.fstype, b.fstype) and
      equals(typeof(a.options), a.options, b.options) and
      equals(typeof(a.readonly), a.readonly, b.readonly)

proc `==`*(a, b: File_system): bool =
  return equals(File_system, a, b)

proc stringify(_: typedesc[File_system]; value: File_system): string =
  stringifyObj("File_system",
               ("storage", stringify(typeof(value.storage), value.storage)),
               ("fstype", stringify(typeof(value.fstype), value.fstype)),
               ("options", stringify(typeof(value.options), value.options)),
               ("readonly", stringify(typeof(value.readonly), value.readonly)))

proc `$`*(value: File_system): string =
  stringify(File_system, value)

proc fromJsonHook*(target: var File_system; source: JsonNode) =
  assert(hasKey(source, "storage"),
         "storage" & " is missing while decoding " & "File_system")
  target.storage = jsonTo(source{"storage"}, typeof(target.storage))
  if hasKey(source, "fstype") and source{"fstype"}.kind != JNull:
    target.fstype = some(jsonTo(source{"fstype"},
                                typeof(unsafeGet(target.fstype))))
  if hasKey(source, "options") and source{"options"}.kind != JNull:
    target.options = some(jsonTo(source{"options"},
                                 typeof(unsafeGet(target.options))))
  if hasKey(source, "readonly") and source{"readonly"}.kind != JNull:
    target.readonly = some(jsonTo(source{"readonly"},
                                  typeof(unsafeGet(target.readonly))))

proc toJsonHook*(source: File_system): JsonNode =
  result = newJObject()
  result{"storage"} = toJsonHook(source.storage)
  if isSome(source.fstype):
    result{"fstype"} = `%`(unsafeGet(source.fstype))
  if isSome(source.options):
    result{"options"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.options):
        output.add(newJString(entry))
      output
  if isSome(source.readonly):
    result{"readonly"} = newJBool(unsafeGet(source.readonly))
{.pop.}
