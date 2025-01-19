import std/[json, tables, options]
type
  `HealthHealth`* = object
    `dateOfBirth`*: string
    `emergencyContact`*: Option[string]
    `patientName`*: string
    `bloodType`*: string
    `medications`*: Option[seq[string]]
    `conditions`*: Option[seq[string]]
    `allergies`*: Option[seq[string]]