# https://json-schema.org/learn/json-schema-examples
buildTest("address", Address)
buildTest("blog", Blog)
buildTest("ecommerce", Ecommerce)
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
buildTest("consts", Consts)
buildTest("empty_object", EmptyObject)
buildTest("optional_empty_object", OptionalEmptyObject)
buildTest("untyped_array", UntypedArray)
buildTest("unconstrained_object", UnconstrainedObject)
buildTest("bool_schema", BoolSchema)
buildTest("array_root", ArrayRoot)
buildTest("string_root", StringRoot)
buildTest("const_root", ConstRoot)
buildTest("union_root", UnionRoot)
buildTest("merged_scalars", MergedScalars)
buildTest("nullable_merge", NullableMerge)
buildTest("union_discriminator", UnionDiscriminator)
buildTest("narrowed_union", NarrowedUnion)
buildTest("const_typed", ConstTyped)
buildTest("open_object", OpenObject)
buildTest("ref_siblings", RefSiblings)
buildTest("all_of", AllOf)
buildTest("tuples", Tuples)
buildTest("standalone_required", StandaloneRequired)
buildTest("recursive_tree", RecursiveTree)
buildTest("linked_list", LinkedList)
buildTest("mutual_refs", MutualRefs)
buildTest("recursive_union", RecursiveUnion)
buildTest("enum_value_collision", EnumValueCollision)

# Specific applications
buildTest("ldtk", Ldtk)
buildTest("aseprite", Aseprite)
