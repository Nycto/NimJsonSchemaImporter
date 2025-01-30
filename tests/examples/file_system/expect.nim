{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  File_systemType* = enum
    Disk
  File_systemDiskDevice* = object
    `type`*: File_systemType
    device*: string
  File_systemStorageType* = enum
    Disk
  File_systemDiskUUID* = object
    `type`*: File_systemStorageType
    label*: string
  File_systemfile_systemStorageType* = enum
    Nfs
  File_systemNfs* = object
    `type`*: File_systemfile_systemStorageType
    remotePath*: string
    server*: string
  File_systemfile_systemStorageType2* = enum
    Tmpfs
  File_systemTmpfs* = object
    `type`*: File_systemfile_systemStorageType2
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
    Ext3, Ext4, Btrfs
  File_systemfile_system* = object
    storage*: File_systemUnion
    fstype*: Option[File_systemFstype]
    options*: Option[seq[string]]
    readonly*: Option[bool]
proc toJsonHook*(source: File_systemType): JsonNode
proc toJsonHook*(source: File_systemDiskDevice): JsonNode
proc toJsonHook*(source: File_systemStorageType): JsonNode
proc toJsonHook*(source: File_systemDiskUUID): JsonNode
proc toJsonHook*(source: File_systemfile_systemStorageType): JsonNode
proc toJsonHook*(source: File_systemNfs): JsonNode
proc toJsonHook*(source: File_systemfile_systemStorageType2): JsonNode
proc toJsonHook*(source: File_systemTmpfs): JsonNode
proc toJsonHook*(source: File_systemUnion): JsonNode
proc toJsonHook*(source: File_systemFstype): JsonNode
proc toJsonHook*(source: File_systemfile_system): JsonNode
proc toJsonHook*(source: File_systemType): JsonNode =
  case source
  of File_systemType.Disk:
    return newJString("disk")
  
proc fromJsonHook*(target: var File_systemType; source: JsonNode) =
  target = case getStr(source)
  of "disk":
    File_systemType.Disk
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc `==`*(a, b: File_systemDiskDevice): bool =
  true and a.`type` == b.`type` and a.device == b.device

proc fromJsonHook*(target: var File_systemDiskDevice; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "File_systemDiskDevice")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert(hasKey(source, "device"),
         "device" & " is missing while decoding " & "File_systemDiskDevice")
  target.device = jsonTo(source{"device"}, typeof(target.device))

proc toJsonHook*(source: File_systemDiskDevice): JsonNode =
  result = newJObject()
  result{"type"} = toJsonHook(source.`type`)
  result{"device"} = newJString(source.device)

converter forFile_systemUnion*(value: File_systemDiskDevice): File_systemUnion =
  return File_systemUnion(kind: 0, key0: value)

proc toJsonHook*(source: File_systemStorageType): JsonNode =
  case source
  of File_systemStorageType.Disk:
    return newJString("disk")
  
proc fromJsonHook*(target: var File_systemStorageType; source: JsonNode) =
  target = case getStr(source)
  of "disk":
    File_systemStorageType.Disk
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc `==`*(a, b: File_systemDiskUUID): bool =
  true and a.`type` == b.`type` and a.label == b.label

proc fromJsonHook*(target: var File_systemDiskUUID; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "File_systemDiskUUID")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert(hasKey(source, "label"),
         "label" & " is missing while decoding " & "File_systemDiskUUID")
  target.label = jsonTo(source{"label"}, typeof(target.label))

proc toJsonHook*(source: File_systemDiskUUID): JsonNode =
  result = newJObject()
  result{"type"} = toJsonHook(source.`type`)
  result{"label"} = newJString(source.label)

converter forFile_systemUnion*(value: File_systemDiskUUID): File_systemUnion =
  return File_systemUnion(kind: 1, key1: value)

proc toJsonHook*(source: File_systemfile_systemStorageType): JsonNode =
  case source
  of File_systemfile_systemStorageType.Nfs:
    return newJString("nfs")
  
proc fromJsonHook*(target: var File_systemfile_systemStorageType;
                   source: JsonNode) =
  target = case getStr(source)
  of "nfs":
    File_systemfile_systemStorageType.Nfs
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc `==`*(a, b: File_systemNfs): bool =
  true and a.`type` == b.`type` and a.remotePath == b.remotePath and
      a.server == b.server

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
  result{"type"} = toJsonHook(source.`type`)
  result{"remotePath"} = newJString(source.remotePath)
  result{"server"} = newJString(source.server)

converter forFile_systemUnion*(value: File_systemNfs): File_systemUnion =
  return File_systemUnion(kind: 2, key2: value)

proc toJsonHook*(source: File_systemfile_systemStorageType2): JsonNode =
  case source
  of File_systemfile_systemStorageType2.Tmpfs:
    return newJString("tmpfs")
  
proc fromJsonHook*(target: var File_systemfile_systemStorageType2;
                   source: JsonNode) =
  target = case getStr(source)
  of "tmpfs":
    File_systemfile_systemStorageType2.Tmpfs
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc `==`*(a, b: File_systemTmpfs): bool =
  true and a.`type` == b.`type` and a.sizeInMB == b.sizeInMB

proc fromJsonHook*(target: var File_systemTmpfs; source: JsonNode) =
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "File_systemTmpfs")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert(hasKey(source, "sizeInMB"),
         "sizeInMB" & " is missing while decoding " & "File_systemTmpfs")
  target.sizeInMB = jsonTo(source{"sizeInMB"}, typeof(target.sizeInMB))

proc toJsonHook*(source: File_systemTmpfs): JsonNode =
  result = newJObject()
  result{"type"} = toJsonHook(source.`type`)
  result{"sizeInMB"} = newJInt(source.sizeInMB)

converter forFile_systemUnion*(value: File_systemTmpfs): File_systemUnion =
  return File_systemUnion(kind: 3, key3: value)

proc `==`*(a, b: File_systemUnion): bool =
  if a.kind != b.kind:
    return false
  case a.kind
  of 0:
    return a.key0 == b.key0
  of 1:
    return a.key1 == b.key1
  of 2:
    return a.key2 == b.key2
  of 3:
    return a.key3 == b.key3
  
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

proc toJsonHook*(source: File_systemFstype): JsonNode =
  case source
  of File_systemFstype.Ext3:
    return newJString("ext3")
  of File_systemFstype.Ext4:
    return newJString("ext4")
  of File_systemFstype.Btrfs:
    return newJString("btrfs")
  
proc fromJsonHook*(target: var File_systemFstype; source: JsonNode) =
  target = case getStr(source)
  of "ext3":
    File_systemFstype.Ext3
  of "ext4":
    File_systemFstype.Ext4
  of "btrfs":
    File_systemFstype.Btrfs
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc `==`*(a, b: File_systemfile_system): bool =
  true and a.storage == b.storage and a.fstype == b.fstype and
      a.options == b.options and
      a.readonly == b.readonly

proc fromJsonHook*(target: var File_systemfile_system; source: JsonNode) =
  assert(hasKey(source, "storage"),
         "storage" & " is missing while decoding " & "File_systemfile_system")
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

proc toJsonHook*(source: File_systemfile_system): JsonNode =
  result = newJObject()
  result{"storage"} = toJsonHook(source.storage)
  if isSome(source.fstype):
    result{"fstype"} = toJsonHook(unsafeGet(source.fstype))
  if isSome(source.options):
    result{"options"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.options):
        output.add(newJString(entry))
      output
  if isSome(source.readonly):
    result{"readonly"} = newJBool(unsafeGet(source.readonly))
{.pop.}
