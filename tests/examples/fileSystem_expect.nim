import std/[json, tables, options]
type
  `FileSystemDiskDevice`* = object
    `type`*: `FileSystemFileSystemDiskDevice_Type`
    `device`*: string
  `FileSystemTmpfs`* = object
    `type`*: `FileSystemFileSystemTmpfs_Type`
    `sizeInMB`*: BiggestInt
  `FileSystemFileSystemFileSystem_Fstype`* = enum
    ext4, btrfs, ext3
  `FileSystemNfs`* = object
    `type`*: `FileSystemFileSystemNfs_Type`
    `server`*: `FileSystemFileSystemNfs_ServerUnion`
    `remotePath`*: string
  `FileSystemFileSystemDiskDevice_Type`* = enum
    disk
  `FileSystemFileSystemNfs_Type`* = enum
    nfs
  `FileSystemFileSystem`* = object
    `options`*: Option[seq[string]]
    `readonly`*: Option[bool]
    `storage`*: `FileSystemFileSystemFileSystem_StorageUnion`
    `fstype`*: Option[`FileSystemFileSystemFileSystem_Fstype`]
  `FileSystemDiskUUID`* = object
    `type`*: `FileSystemFileSystemDiskUUID_Type`
    `label`*: string
  `FileSystemFileSystemFileSystem_StorageUnion`* = object
    case kind: range[0 .. 3]
    of 0:
      key0: `FileSystemDiskDevice`
    of 1:
      key1: `FileSystemDiskUUID`
    of 2:
      key2: `FileSystemNfs`
    of 3:
      key3: `FileSystemTmpfs`
  `FileSystemFileSystemTmpfs_Type`* = enum
    tmpfs
  `FileSystemFileSystemNfs_ServerUnion`* = object
    case kind: range[0 .. 2]
    of 0:
      key0: JsonNode
    of 1:
      key1: JsonNode
    of 2:
      key2: JsonNode
  `FileSystemFileSystemDiskUUID_Type`* = enum
    disk