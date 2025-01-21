{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testaddress`* = object
    `streetAddress`*: Option[string]
    `region`*: string
    `locality`*: string
    `countryName`*: string
    `postOfficeBox`*: Option[string]
    `extendedAddress`*: Option[string]
    `postalCode`*: Option[string]