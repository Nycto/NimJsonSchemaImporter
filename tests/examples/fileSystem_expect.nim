import std/[json, tables, options]
type
  `FileSystemDiskUUID`* = object
    `type`*: `FileSystemType`
    `label`*: string
  `FileSystemStorage`* = object
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
    `server`*: `FileSystemServer`
    `remotePath`*: string
  `FileSystemType`* = enum
    disk
  `FileSystemType`* = enum
    tmpfs
  `FileSystemFileSystem`* = object
    `options`*: Option[seq[string]]
    `readonly`*: Option[bool]
    `storage`*: `FileSystemStorage`
    `fstype`*: Option[`FileSystemFstype`]
  `FileSystemDiskDevice`* = object
    `type`*: `FileSystemType`
    `device`*: string
  `FileSystemType`* = enum
    nfs
  `FileSystemServer`* = object
    case kind: range[0 .. 2]
    of 0:
      key0: JsonNode
    of 1:
      key1: JsonNode
    of 2:
      key2: JsonNode
  `FileSystemFstype`* = enum
    ext4, btrfs, ext3
  `FileSystemTmpfs`* = object
    `type`*: `FileSystemType`
    `sizeInMB`*: BiggestInt