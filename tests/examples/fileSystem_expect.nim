type
  FileSystemType* = enum
    disk
  FileSystemStorage0* = object
    type*: FileSystemType
    device*: string
  FileSystemType* = enum
    disk
  FileSystemStorage1* = object
    type*: FileSystemType
    label*: string
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
  FileSystemStorage2* = object
    type*: FileSystemType
    server*: FileSystemServer
    remotePath*: string
  FileSystemType* = enum
    tmpfs
  FileSystemStorage3* = object
    type*: FileSystemType
    sizeInMB*: BiggestInt
  FileSystemStorage* = object
    case kind: range[0 .. 3]
    of 0:
      key0: FileSystemStorage0
    of 1:
      key1: FileSystemStorage1
    of 2:
      key2: FileSystemStorage2
    of 3:
      key3: FileSystemStorage3
  FileSystemFstype* = enum
    ext4, btrfs, ext3
  FileSystemFileSystem* = object
    options*: seq[string]
    readonly*: bool
    storage*: FileSystemStorage
    fstype*: FileSystemFstype