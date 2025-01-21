{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testuser_profile`* = object
    `interests`*: Option[seq[string]]
    `fullName`*: Option[string]
    `age`*: Option[BiggestInt]
    `username`*: string
    `location`*: Option[string]
    `email`*: string