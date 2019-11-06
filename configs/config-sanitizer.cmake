
#####################################################################################################################################
# !Warning: this file is included before the android (or any specific) toolchain, so android-specific variables are not accessible
#####################################################################################################################################

if (LINPHONESDK_PLATFORM STREQUAL "Android")
	set(sanitize_flags "-fsanitize=address,undefined -fuse-ld=gold -fno-omit-frame-pointer -fno-optimize-sibling-calls")
	set(sanitize_linker_flags "-llog")
else()
  set(sanitize_flags "-fsanitize=address,undefined -fno-omit-frame-pointer -fno-optimize-sibling-calls")
  set(sanitize_linker_flags "-lasan -lubsan")		
endif()
	
# these link options are prepended by a semicolon if the following quotes are missing.
# we must set this quotes to prevent cmake from considering the given set as a list append
# see	https://cmake.org/cmake/help/v3.16/manual/cmake-language.7.html#cmake-language-variables

string(TOUPPER "${CMAKE_BUILD_TYPE}" BUILD_TYPE)

set(CMAKE_C_FLAGS_${BUILD_TYPE} "${CMAKE_C_FLAGS_${BUILD_TYPE}} ${sanitize_flags}")
set(CMAKE_CXX_FLAGS_${BUILD_TYPE} "${CMAKE_CXX_FLAGS_${BUILD_TYPE}} ${sanitize_flags}")

set(CMAKE_EXE_LINKER_FLAGS_${BUILD_TYPE} "${CMAKE_EXE_LINKER_FLAGS_${BUILD_TYPE}} ${sanitize_flags} ${sanitize_linker_flags}")
set(CMAKE_MODULE_LINKER_FLAGS_${BUILD_TYPE} "${CMAKE_MODULE_LINKER_FLAGS_${BUILD_TYPE}} ${sanitize_flags} ${sanitize_linker_flags}")
set(CMAKE_SHARED_LINKER_FLAGS_${BUILD_TYPE} "${CMAKE_SHARED_LINKER_FLAGS_${BUILD_TYPE}} ${sanitize_flags} ${sanitize_linker_flags}")

set(CMAKE_REQUIRED_FLAGS "${CMAKE_C_FLAGS_${BUILD_TYPE}}")
set(CMAKE_REQUIRED_LINK_OPTIONS "${CMAKE_EXE_LINKER_FLAGS_${BUILD_TYPE}}")


unset(sanitize_flags)
unset(sanitize_linker_flags)
