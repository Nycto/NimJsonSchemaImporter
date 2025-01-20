import std/[json, tables, options]
type
  `TestDiskDevice`* = object
    `type`*: `TestTestDiskDevice_Type`
    `device`*: string
  `TestTmpfs`* = object
    `type`*: `TestTestTmpfs_Type`
    `sizeInMB`*: BiggestInt
  `TestTestTmpfs_Type`* = enum
    tmpfs
  `TestTestNfs_ServerUnion`* = object
    case kind: range[0 .. 2]
    of 0:
      key0: JsonNode
    of 1:
      key1: JsonNode
    of 2:
      key2: JsonNode
  `TestTestFile_system_StorageUnion`* = object
    case kind: range[0 .. 3]
    of 0:
      key0: `TestDiskDevice`
    of 1:
      key1: `TestDiskUUID`
    of 2:
      key2: `TestNfs`
    of 3:
      key3: `TestTmpfs`
  `TestTestDiskUUID_Type`* = enum
    disk
  `TestTestDiskDevice_Type`* = enum
    disk
  `TestTestFile_system_Fstype`* = enum
    ext4, btrfs, ext3
  `TestTestNfs_Type`* = enum
    nfs
  `TestDiskUUID`* = object
    `type`*: `TestTestDiskUUID_Type`
    `label`*: string
  `TestFile_system`* = object
    `options`*: Option[seq[string]]
    `readonly`*: Option[bool]
    `storage`*: `TestTestFile_system_StorageUnion`
    `fstype`*: Option[`TestTestFile_system_Fstype`]
  `TestNfs`* = object
    `type`*: `TestTestNfs_Type`
    `server`*: `TestTestNfs_ServerUnion`
    `remotePath`*: string