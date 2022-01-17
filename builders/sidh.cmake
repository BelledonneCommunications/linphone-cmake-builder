############################################################################
# sidh.cmake
############################################################################

lcb_git_repository("https://github.com/open-quantum-safe/liboqs.git")
lcb_git_tag_latest("master")
lcb_git_tag("master")
lcb_external_source_paths("external/liboqs")
lcb_groupable(YES)
lcb_sanitizable(YES)
lcb_package_source(YES)
lcb_spec_file("sidh.spec")
