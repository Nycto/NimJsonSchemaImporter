import std/[json, tables, options]
type
  `FileSystemDiskUUID`* = object
    `type`*: `FileSystemType`
    `label`*: string
  `FileSystemType`* = enum
    disk
  `FileSystemType`* = enum
    tmpfs
  `FileSystemDiskDevice`* = object
    `type`*: `FileSystemType`
    `device`*: string
  `FileSystemFileSystem`* = object
    `options`*: Option[seq[string]]
    `readonly`*: Option[bool]
    `storage`*: `FileSystemStorageUnion`
    `fstype`*: Option[`FileSystemFstype`]
  `FileSystemServerUnion`* = object
    case kind: range[0 .. 2]
    of 0:
      key0: JsonNode
    of 1:
      key1: JsonNode
    of 2:
      key2: JsonNode
  `FileSystemStorageUnion`* = object
    case kind: range[0 .. 3]
    of 0:
      key0: `FileSystemDiskDevice`
    of 1:
      key1: `FileSystemDiskUUID`
    of 2:
      key2: `FileSystemNfs`
    of 3:
      key3: `FileSystemTmpfs`
  `FileSystemNfs`* = object
    `type`*: `FileSystemType`
    `server`*: `FileSystemServerUnion`
    `remotePath`*: string
  `FileSystemType`* = enum
    nfs
  `FileSystemFstype`* = enum
    ext4, btrfs, ext3
  `FileSystemTmpfs`* = object
    `type`*: `FileSystemType`
    `sizeInMB`*: BiggestInt