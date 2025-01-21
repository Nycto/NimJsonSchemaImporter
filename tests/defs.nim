
# https://json-schema.org/learn/json-schema-examples
buildTest("address", TestAddress)
buildTest("blog", TestBlog)
buildTest("ecommerce", TestOrderSchema)
buildTest("location", TestLocation)
buildTest("health", TestHealth)
buildTest("movie", TestMovie)
buildTest("user_profile", TestUser_profile)

# https://json-schema.org/learn/miscellaneous-examples
buildTest("basic", TestBasic)
buildTest("array_of_things", TestArray_of_things)
buildTest("enumerated_values", TestEnumeratedValues)
buildTest("complex_object", TestComplex_object)

# https://json-schema.org/learn/file-system#full-entry
buildTest("file_system", TestFile_system)

# Specific use cases
buildTest("union", TestUnion)

# Specific applications
buildTest("ldtk", TestLdtkJsonRoot)
buildTest("aseprite", TestSpriteSheet)