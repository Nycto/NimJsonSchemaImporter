
# https://json-schema.org/learn/json-schema-examples
buildTest("address", AddressAddress)
buildTest("blog", BlogBlog)
buildTest("ecommerce", EcommerceOrderSchema)
buildTest("location", LocationLocation)
buildTest("health", HealthHealth)
buildTest("movie", MovieMovie)
buildTest("user_profile", User_profileUser_profile)

# https://json-schema.org/learn/miscellaneous-examples
buildTest("basic", BasicBasic)
buildTest("array_of_things", Array_of_thingsArray_of_things)
buildTest("enumerated_values", Enumerated_values_EnumeratedValues)
buildTest("complex_object", Complex_objectComplex_object)

# https://json-schema.org/learn/file-system#full-entry
buildTest("file_system", File_systemFile_system)

# Specific use cases
buildTest("union", UnionUnion)

# Specific applications
buildTest("ldtk", LdtkLdtkJsonRoot)
buildTest("aseprite", AsepriteSpriteSheet)