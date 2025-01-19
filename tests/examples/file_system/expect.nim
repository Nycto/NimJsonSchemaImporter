import std/[json, tables, options]
type
  `File_systemFile_systemNfs_Type`* = enum
    nfs
  `File_systemDiskDevice`* = object
    `type`*: `File_systemFile_systemDiskDevice_Type`
    `device`*: string
  `File_systemFile_system`* = object
    `options`*: Option[seq[string]]
    `readonly`*: Option[bool]
    `storage`*: `File_systemFile_systemFile_system_StorageUnion`
    `fstype`*: Option[`File_systemFile_systemFile_system_Fstype`]
  `File_systemTmpfs`* = object
    `type`*: `File_systemFile_systemTmpfs_Type`
    `sizeInMB`*: BiggestInt
  `File_systemNfs`* = object
    `type`*: `File_systemFile_systemNfs_Type`
    `server`*: `File_systemFile_systemNfs_ServerUnion`
    `remotePath`*: string
  `File_systemFile_systemNfs_ServerUnion`* = object
    case kind: range[0 .. 2]
    of 0:
      key0: JsonNode
    of 1:
      key1: JsonNode
    of 2:
      key2: JsonNode
  `File_systemFile_systemTmpfs_Type`* = enum
    tmpfs
  `File_systemDiskUUID`* = object
    `type`*: `File_systemFile_systemDiskUUID_Type`
    `label`*: string
  `File_systemFile_systemDiskUUID_Type`* = enum
    disk
  `File_systemFile_systemFile_system_StorageUnion`* = object
    case kind: range[0 .. 3]
    of 0:
      key0: `File_systemDiskDevice`
    of 1:
      key1: `File_systemDiskUUID`
    of 2:
      key2: `File_systemNfs`
    of 3:
      key3: `File_systemTmpfs`
  `File_systemFile_systemDiskDevice_Type`* = enum
    disk
  `File_systemFile_systemFile_system_Fstype`* = enum
    ext4, btrfs, ext3