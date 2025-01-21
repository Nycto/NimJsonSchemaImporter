{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `TestdiskDevice`* = object
    `type`*: `TestTestdiskDevice_type`
    `device`*: string
  `TestTestnfs_serverUnion`* = object
    case kind*: range[0 .. 2]
    of 0:
      key0*: JsonNode
    of 1:
      key1*: JsonNode
    of 2:
      key2*: JsonNode
  `Testnfs`* = object
    `type`*: `TestTestnfs_type`
    `server`*: `TestTestnfs_serverUnion`
    `remotePath`*: string
  `Testtmpfs`* = object
    `type`*: `TestTesttmpfs_type`
    `sizeInMB`*: BiggestInt
  `TestTestdiskDevice_type`* = enum
    `Disk`
  `TestTestfile_system_fstype`* = enum
    `Ext4`, `Btrfs`, `Ext3`
  `TestdiskUUID`* = object
    `type`*: `TestTestdiskUUID_type`
    `label`*: string
  `TestTestdiskUUID_type`* = enum
    `Disk`
  `TestTesttmpfs_type`* = enum
    `Tmpfs`
  `TestTestnfs_type`* = enum
    `Nfs`
  `Testfile_system`* = object
    `options`*: Option[seq[string]]
    `readonly`*: Option[bool]
    `storage`*: `TestTestfile_system_storageUnion`
    `fstype`*: Option[`TestTestfile_system_fstype`]
  `TestTestfile_system_storageUnion`* = object
    case kind*: range[0 .. 3]
    of 0:
      key0*: `TestdiskDevice`
    of 1:
      key1*: `TestdiskUUID`
    of 2:
      key2*: `Testnfs`
    of 3:
      key3*: `Testtmpfs`
proc toJsonHook*(source: `TestTestdiskDevice_type`): JsonNode =
  case source
  of `TestTestdiskDevice_type`.`Disk`:
    return newJString("disk")
  
proc fromJsonHook*(target: var `TestTestdiskDevice_type`; source: JsonNode) =
  target = case getStr(source)
  of "disk":
    `TestTestdiskDevice_type`.`Disk`
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var `TestdiskDevice`; source: JsonNode) =
  assert("type" in source,
         "type" & " is missing while decoding " & "TestdiskDevice")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert("device" in source,
         "device" & " is missing while decoding " & "TestdiskDevice")
  target.`device` = jsonTo(source{"device"}, typeof(target.`device`))

proc toJsonHook*(source: `TestdiskDevice`): JsonNode =
  result = newJObject()
  result{"type"} = toJson(source.`type`)
  result{"device"} = toJson(source.`device`)

proc toJsonHook*(source: `TestTestdiskUUID_type`): JsonNode =
  case source
  of `TestTestdiskUUID_type`.`Disk`:
    return newJString("disk")
  
proc fromJsonHook*(target: var `TestTestdiskUUID_type`; source: JsonNode) =
  target = case getStr(source)
  of "disk":
    `TestTestdiskUUID_type`.`Disk`
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var `TestdiskUUID`; source: JsonNode) =
  assert("type" in source,
         "type" & " is missing while decoding " & "TestdiskUUID")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert("label" in source,
         "label" & " is missing while decoding " & "TestdiskUUID")
  target.`label` = jsonTo(source{"label"}, typeof(target.`label`))

proc toJsonHook*(source: `TestdiskUUID`): JsonNode =
  result = newJObject()
  result{"type"} = toJson(source.`type`)
  result{"label"} = toJson(source.`label`)

proc toJsonHook*(source: `TestTestnfs_type`): JsonNode =
  case source
  of `TestTestnfs_type`.`Nfs`:
    return newJString("nfs")
  
proc fromJsonHook*(target: var `TestTestnfs_type`; source: JsonNode) =
  target = case getStr(source)
  of "nfs":
    `TestTestnfs_type`.`Nfs`
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var `TestTestnfs_serverUnion`; source: JsonNode) =
  if true:
    target = `TestTestnfs_serverUnion`(kind: 0, key0: jsonTo(source,
        typeof(target.key0)))
  elif true:
    target = `TestTestnfs_serverUnion`(kind: 1, key1: jsonTo(source,
        typeof(target.key1)))
  elif true:
    target = `TestTestnfs_serverUnion`(kind: 2, key2: jsonTo(source,
        typeof(target.key2)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to TestTestnfs_serverUnion")
  
proc toJsonHook*(source: `TestTestnfs_serverUnion`): JsonNode =
  case source.kind
  of 0:
    return toJson(source.key0)
  of 1:
    return toJson(source.key1)
  of 2:
    return toJson(source.key2)
  
proc fromJsonHook*(target: var `Testnfs`; source: JsonNode) =
  assert("type" in source, "type" & " is missing while decoding " & "Testnfs")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert("server" in source,
         "server" & " is missing while decoding " & "Testnfs")
  target.`server` = jsonTo(source{"server"}, typeof(target.`server`))
  assert("remotePath" in source,
         "remotePath" & " is missing while decoding " & "Testnfs")
  target.`remotePath` = jsonTo(source{"remotePath"}, typeof(target.`remotePath`))

proc toJsonHook*(source: `Testnfs`): JsonNode =
  result = newJObject()
  result{"type"} = toJson(source.`type`)
  result{"server"} = toJson(source.`server`)
  result{"remotePath"} = toJson(source.`remotePath`)

proc toJsonHook*(source: `TestTesttmpfs_type`): JsonNode =
  case source
  of `TestTesttmpfs_type`.`Tmpfs`:
    return newJString("tmpfs")
  
proc fromJsonHook*(target: var `TestTesttmpfs_type`; source: JsonNode) =
  target = case getStr(source)
  of "tmpfs":
    `TestTesttmpfs_type`.`Tmpfs`
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var `Testtmpfs`; source: JsonNode) =
  assert("type" in source, "type" & " is missing while decoding " & "Testtmpfs")
  target.`type` = jsonTo(source{"type"}, typeof(target.`type`))
  assert("sizeInMB" in source,
         "sizeInMB" & " is missing while decoding " & "Testtmpfs")
  target.`sizeInMB` = jsonTo(source{"sizeInMB"}, typeof(target.`sizeInMB`))

proc toJsonHook*(source: `Testtmpfs`): JsonNode =
  result = newJObject()
  result{"type"} = toJson(source.`type`)
  result{"sizeInMB"} = toJson(source.`sizeInMB`)

proc fromJsonHook*(target: var `TestTestfile_system_storageUnion`;
                   source: JsonNode) =
  if source.kind == JObject and "device" in source:
    target = `TestTestfile_system_storageUnion`(kind: 0,
        key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject and "label" in source:
    target = `TestTestfile_system_storageUnion`(kind: 1,
        key1: jsonTo(source, typeof(target.key1)))
  elif source.kind == JObject and "remotePath" in source:
    target = `TestTestfile_system_storageUnion`(kind: 2,
        key2: jsonTo(source, typeof(target.key2)))
  elif source.kind == JObject and "sizeInMB" in source:
    target = `TestTestfile_system_storageUnion`(kind: 3,
        key3: jsonTo(source, typeof(target.key3)))
  else:
    raise newException(ValueError, "Unable to deserialize json node to TestTestfile_system_storageUnion")
  
proc toJsonHook*(source: `TestTestfile_system_storageUnion`): JsonNode =
  case source.kind
  of 0:
    return toJson(source.key0)
  of 1:
    return toJson(source.key1)
  of 2:
    return toJson(source.key2)
  of 3:
    return toJson(source.key3)
  
proc toJsonHook*(source: `TestTestfile_system_fstype`): JsonNode =
  case source
  of `TestTestfile_system_fstype`.`Ext4`:
    return newJString("ext4")
  of `TestTestfile_system_fstype`.`Btrfs`:
    return newJString("btrfs")
  of `TestTestfile_system_fstype`.`Ext3`:
    return newJString("ext3")
  
proc fromJsonHook*(target: var `TestTestfile_system_fstype`; source: JsonNode) =
  target = case getStr(source)
  of "ext4":
    `TestTestfile_system_fstype`.`Ext4`
  of "btrfs":
    `TestTestfile_system_fstype`.`Btrfs`
  of "ext3":
    `TestTestfile_system_fstype`.`Ext3`
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var `Testfile_system`; source: JsonNode) =
  if "options" in source:
    target.`options` = some(jsonTo(source{"options"},
                                   typeof(unsafeGet(target.`options`))))
  if "readonly" in source:
    target.`readonly` = some(jsonTo(source{"readonly"},
                                    typeof(unsafeGet(target.`readonly`))))
  assert("storage" in source,
         "storage" & " is missing while decoding " & "Testfile_system")
  target.`storage` = jsonTo(source{"storage"}, typeof(target.`storage`))
  if "fstype" in source:
    target.`fstype` = some(jsonTo(source{"fstype"},
                                  typeof(unsafeGet(target.`fstype`))))

proc toJsonHook*(source: `Testfile_system`): JsonNode =
  result = newJObject()
  if isSome(source.`options`):
    result{"options"} = toJson(source.`options`)
  if isSome(source.`readonly`):
    result{"readonly"} = toJson(source.`readonly`)
  result{"storage"} = toJson(source.`storage`)
  if isSome(source.`fstype`):
    result{"fstype"} = toJson(source.`fstype`)
