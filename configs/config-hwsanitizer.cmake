
#####################################################################################################################################
# !Warning: be SURE YOU REALLY KNOW what you are doing before modifying this file!
#####################################################################################################################################

# See https://developer.android.com/ndk/guides/hwasan

set(sanitize_flags "-fsanitize=hwaddress -fno-omit-frame-pointer")
set(sanitize_linker_flags "-fsanitize=hwaddress")

# these link options are prepended by a semicolon if the following quotes are missing.
# we must set this quotes to prevent cmake from considering the given set as a list append
# see	https://cmake.org/cmake/help/v3.16/manual/cmake-language.7.html#cmake-language-variables

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${sanitize_flags}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${sanitize_flags}")

set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS} ${sanitize_linker_flags})
set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} ${sanitize_linker_flags}")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${sanitize_linker_flags}")

#We need to put all these variables in cache so that cmake-builder external
# project variables passing includes correct values initially (from cache)
# (used very early in the build by toolchains)
#if this is not done the variables are reset
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS}" CACHE STRING "" FORCE)

unset(sanitize_flags)
unset(sanitize_linker_flags)
