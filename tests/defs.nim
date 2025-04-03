
# https://json-schema.org/learn/json-schema-examples
buildTest("address", Address)
buildTest("blog", Blog)
buildTest("ecommerce", EcommerceOrderSchema)
buildTest("location", Location)
buildTest("health", Health)
buildTest("movie", Movie)
buildTest("user_profile", User_profile)

# https://json-schema.org/learn/miscellaneous-examples
buildTest("basic", Basic)
buildTest("array_of_things", Array_of_things)
buildTest("enumerated_values", Enumerated_values)
buildTest("complex_object", Complex_object)

# https://json-schema.org/learn/file-system#full-entry
buildTest("file_system", File_system)

# Specific use cases
buildTest("union", Union)

# Specific applications
buildTest("ldtk", LdtkJsonRoot)
buildTest("aseprite", AsepriteSpriteSheet)