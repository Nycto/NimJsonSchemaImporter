import std/[json, tables, options]
type
  User_profileUser_profile* = object
    `interests`*: Option[seq[string]]
    `fullName`*: Option[string]
    `age`*: Option[BiggestInt]
    `username`*: string
    `location`*: Option[string]
    `email`*: string