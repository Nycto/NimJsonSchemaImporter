import std/[json, tables, options]
type
  AddressAddress* = object
    `streetAddress`*: Option[string]
    `region`*: string
    `locality`*: string
    `countryName`*: string
    `postOfficeBox`*: Option[string]
    `extendedAddress`*: Option[string]
    `postalCode`*: Option[string]