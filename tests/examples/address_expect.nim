import std/[json, tables]
type
  AddressAddress* = object
    `streetAddress`*: string
    `region`*: string
    `locality`*: string
    `countryName`*: string
    `postOfficeBox`*: string
    `extendedAddress`*: string
    `postalCode`*: string