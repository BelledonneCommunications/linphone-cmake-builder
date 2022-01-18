############################################################################
# liboqs.cmake
############################################################################

lcb_git_repository("https://github.com/open-quantum-safe/liboqs.git")
lcb_git_tag_latest("master")
lcb_git_tag("master")
lcb_external_source_paths("external/liboqs")
lcb_groupable(YES)
lcb_sanitizable(YES)
lcb_package_source(YES)
lcb_spec_file("liboqs.spec")
lcb_cmake_options("-DOQS_MINIMAL_BUILD="OQS_KEM_alg_sike_p434;OQS_KEM_alg_sike_p434_compressed;OQS_KEM_alg_sike_p503;OQS_KEM_alg_sike_p503_compressed;OQS_KEM_alg_sike_p610;OQS_KEM_alg_sike_p610_compressed;OQS_KEM_alg_sike_p751;OQS_KEM_alg_sike_p751_compressed""
    "-DOQS_DIST_BUILD=OFF")
