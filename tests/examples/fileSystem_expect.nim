type
  FileSystemType* = enum
    disk
  FileSystemDiskDevice* = object
    `type`*: FileSystemType
    `device`*: string
  FileSystemType* = enum
    disk
  FileSystemDiskUUID* = object
    `type`*: FileSystemType
    `label`*: string
  FileSystemType* = enum
    nfs
  FileSystemServer* = object
    case kind: range[0 .. 2]
    of 0:
      key0: JsonNode
    of 1:
      key1: JsonNode
    of 2:
      key2: JsonNode
  FileSystemNfs* = object
    `type`*: FileSystemType
    `server`*: FileSystemServer
    `remotePath`*: string
  FileSystemType* = enum
    tmpfs
  FileSystemTmpfs* = object
    `type`*: FileSystemType
    `sizeInMB`*: BiggestInt
  FileSystemStorage* = object
    case kind: range[0 .. 3]
    of 0:
      key0: FileSystemDiskDevice
    of 1:
      key1: FileSystemDiskUUID
    of 2:
      key2: FileSystemNfs
    of 3:
      key3: FileSystemTmpfs
  FileSystemFstype* = enum
    ext4, btrfs, ext3
  FileSystemFileSystem* = object
    `options`*: seq[string]
    `readonly`*: bool
    `storage`*: FileSystemStorage
    `fstype`*: FileSystemFstype