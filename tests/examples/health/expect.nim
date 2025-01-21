{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `Testhealth`* = object
    `dateOfBirth`*: string
    `emergencyContact`*: Option[`TestTesthealth_emergencyContact`]
    `patientName`*: string
    `bloodType`*: string
    `medications`*: Option[seq[string]]
    `conditions`*: Option[seq[string]]
    `allergies`*: Option[seq[string]]
  `TestTesthealth_emergencyContact`* = object
    `username`*: Option[string]
    `email`*: Option[string]