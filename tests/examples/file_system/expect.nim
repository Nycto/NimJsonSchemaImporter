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
  
proc toJsonHook*(source: `TestTestdiskUUID_type`): JsonNode =
  case source
  of `TestTestdiskUUID_type`.`Disk`:
    return newJString("disk")
  
proc toJsonHook*(source: `TestTestnfs_type`): JsonNode =
  case source
  of `TestTestnfs_type`.`Nfs`:
    return newJString("nfs")
  
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
  
proc toJsonHook*(source: `TestTesttmpfs_type`): JsonNode =
  case source
  of `TestTesttmpfs_type`.`Tmpfs`:
    return newJString("tmpfs")
  
proc fromJsonHook*(target: var `TestTestfile_system_storageUnion`;
                   source: JsonNode) =
  if source.kind == JObject:
    target = `TestTestfile_system_storageUnion`(kind: 0,
        key0: jsonTo(source, typeof(target.key0)))
  elif source.kind == JObject:
    target = `TestTestfile_system_storageUnion`(kind: 1,
        key1: jsonTo(source, typeof(target.key1)))
  elif source.kind == JObject:
    target = `TestTestfile_system_storageUnion`(kind: 2,
        key2: jsonTo(source, typeof(target.key2)))
  elif source.kind == JObject:
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
  