{.push warning[UnusedImport]:off.}
import std/[json, tables, options]
type
  `TestHealth`* = object
    `dateOfBirth`*: string
    `emergencyContact`*: Option[`TestTestHealth_EmergencyContact`]
    `patientName`*: string
    `bloodType`*: string
    `medications`*: Option[seq[string]]
    `conditions`*: Option[seq[string]]
    `allergies`*: Option[seq[string]]
  `TestTestHealth_EmergencyContact`* = object
    `username`*: Option[string]
    `email`*: Option[string]