############################################################################
# config-android.cmake
# Copyright (C) 2016  Belledonne Communications, Grenoble France
#
############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
############################################################################

include(${CMAKE_CURRENT_LIST_DIR}/options-android.cmake)



set(DEFAULT_VALUE_CMAKE_LINKING_TYPE "-DENABLE_STATIC=YES" "-DENABLE_SHARED=NO")
set(DEFAULT_VALUE_CMAKE_PLUGIN_LINKING_TYPE "-DENABLE_STATIC=NO" "-DENABLE_SHARED=YES")


# Global configuration
set(LINPHONE_BUILDER_HOST "${CMAKE_SYSTEM_PROCESSOR}-linux-android")
set(CMAKE_INSTALL_RPATH "$ORIGIN")
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv5te")
	if(ENABLE_VIDEO)
		message(STATUS "Disabling video for armv6")
		set(ENABLE_VIDEO NO CACHE BOOL "" FORCE)
		set(ENABLE_FFMPEG NO CACHE BOOL "" FORCE)
		set(ENABLE_OPENH264 NO CACHE BOOL "" FORCE)
		set(ENABLE_VPX NO CACHE BOOL "" FORCE)
		set(ENABLE_X264 NO CACHE BOOL "" FORCE)
	endif()
	set(ENABLE_WEBRTC_AEC NO CACHE BOOL "" FORCE)
endif()


# Include builders
include(builders/CMakeLists.txt)


# bctoolbox
lcb_builder_linking_type(bctoolbox "-DENABLE_STATIC=NO" "-DENABLE_SHARED=YES")
lcb_builder_cmake_options(bctoolbox "-DENABLE_TESTS=NO")

# belcard
lcb_builder_cmake_options(belcard "-DENABLE_TOOLS=NO")
lcb_builder_cmake_options(belcard "-DENABLE_UNIT_TESTS=NO")

# belle-sip
lcb_builder_cmake_options(bellesip "-DENABLE_TESTS=NO")

# belr
lcb_builder_cmake_options(belr "-DENABLE_TESTS=NO")

# bzrtp
lcb_builder_cmake_options(bzrtp "-DENABLE_DOC=NO")
lcb_builder_cmake_options(bzrtp "-DENABLE_TESTS=NO")

# codec2
lcb_builder_extra_cflags(codec2 "-ffast-math")

# ffmpeg
lcb_builder_linking_type(ffmpeg "--enable-static" "--disable-shared" "--enable-pic")

# lime
lcb_builder_cmake_options(lime "-DENABLE_DOC=NO")
lcb_builder_cmake_options(lime "-DENABLE_UNIT_TESTS=NO" "-DENABLE_JNI=YES")

# linphone
lcb_builder_cmake_options(linphone "-DENABLE_RELATIVE_PREFIX=YES")
lcb_builder_cmake_options(linphone "-DENABLE_CONSOLE_UI=NO")
lcb_builder_cmake_options(linphone "-DENABLE_DAEMON=NO")
lcb_builder_cmake_options(linphone "-DENABLE_NOTIFY=NO")
lcb_builder_cmake_options(linphone "-DENABLE_TUTORIALS=NO")
lcb_builder_cmake_options(linphone "-DENABLE_UPNP=NO")
lcb_builder_cmake_options(linphone "-DENABLE_MSG_STORAGE=YES")
lcb_builder_cmake_options(linphone "-DENABLE_DOC=NO")
lcb_builder_linking_type(linphone "-DENABLE_STATIC=NO" "-DENABLE_SHARED=YES")

# mbedtls
lcb_builder_linking_type(mbedtls "-DUSE_STATIC_MBEDTLS_LIBRARY=YES" "-DUSE_SHARED_MBEDTLS_LIBRARY=NO")

# mediastreamer2
lcb_builder_cmake_options(ms2 "-DENABLE_RELATIVE_PREFIX=YES")
lcb_builder_cmake_options(ms2 "-DENABLE_ALSA=NO")
lcb_builder_cmake_options(ms2 "-DENABLE_ANDROIDSND=YES")
lcb_builder_cmake_options(ms2 "-DENABLE_PULSEAUDIO=NO")
lcb_builder_cmake_options(ms2 "-DENABLE_OSS=NO")
lcb_builder_cmake_options(ms2 "-DENABLE_GLX=NO")
lcb_builder_cmake_options(ms2 "-DENABLE_X11=NO")
lcb_builder_cmake_options(ms2 "-DENABLE_XV=NO")
lcb_builder_cmake_options(ms2 "-DENABLE_DOC=NO")
lcb_builder_cmake_options(ms2 "-DENABLE_UNIT_TESTS=NO")
lcb_builder_linking_type(ms2 "-DENABLE_STATIC=NO" "-DENABLE_SHARED=YES")

# openh264 shared library build disabled for Android as it no longuer work on armv7 with ndk > 19 (see openh274 submodule for details)
if(NOT ENABLE_EMBEDDED_OPENH264)
	#lcb_builder_linking_type(openh264 "-shared")
	message(WARNING "Only static build is available for Android") 
endif()

# opus
lcb_builder_cmake_options(opus "-DOPUS_FIXED_POINT=YES")

# ortp
lcb_builder_cmake_options(ortp "-DENABLE_DOC=NO")
lcb_builder_linking_type(ortp "-DENABLE_STATIC=NO" "-DENABLE_SHARED=YES")

# polarssl
lcb_builder_linking_type(polarssl "-DUSE_SHARED_POLARSSL_LIBRARY=NO")

# soci
lcb_builder_linking_type(soci "-DSOCI_STATIC=YES" "-DSOCI_SHARED=NO")

# speex
lcb_builder_cmake_options(speex "-DENABLE_FLOAT_API=NO")
lcb_builder_cmake_options(speex "-DENABLE_FIXED_POINT=YES")
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a")
	lcb_builder_cmake_options(speex "-DENABLE_ARM_NEON_INTRINSICS=YES")
endif()

# vpx
lcb_builder_linking_type(vpx "--enable-static" "--disable-shared")

# x264
lcb_builder_linking_type(x264 "--enable-static" "--enable-pic")
lcb_builder_install_target(x264 "install-lib-static")

#Copy c++ library to install prefix
#The library has to be present for cmake dependencies and before the install target
file(COPY "${CMAKE_ANDROID_NDK}/sources/cxx-stl/llvm-libc++/libs/${CMAKE_ANDROID_ARCH_ABI}/libc++_shared.so" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/")

if(ENABLE_SANITIZER)
	set(SANITIZER_ARCH ${CMAKE_SYSTEM_PROCESSOR})
	if(SANITIZER_ARCH MATCHES "^arm")
		set(SANITIZER_ARCH "arm")
	endif()
		
	file(GLOB_RECURSE _clang_rt_library "${CMAKE_ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/*/clang/*/lib/linux/libclang_rt.asan-${SANITIZER_ARCH}-android.so")
	if(_clang_rt_library)
		list(GET _clang_rt_library 0 _clang_rt_library)
		file(COPY ${_clang_rt_library} DESTINATION "${CMAKE_INSTALL_PREFIX}/lib")
		
    #DO NOT REMOVE NOW  !!!
    # It SEEMS to be useless as the sanitizer builds without these lines on ndk 20 and sdk 28.
    # Need to check with others versions.

  	#we search for liblog.so in the folder of the ndk, then if it is found we add it to the linker flags
		#find_library(log_library log PATHS "${CMAKE_ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/sysroot/")
		#if(NOT DEFINED log_library-NOTFOUND)
		  #set(CMAKE_EXE_LINKER_FLAGS "${_clang_rt_library} ${log_library} ${CMAKE_EXE_LINKER_FLAGS}")
		 # message("if find library config android")
 		 # message("if find library config android CMAKE_EXE_LINKER_FLAGS = ${CMAKE_EXE_LINKER_FLAGS}")
		 # message("if find library config android _clang_rt_library = ${_clang_rt_library}")
 		 # message("if find library config android log_library = ${log_library}")
		#else()
		#  message(fatal_error "LOG LIBRARY NOT FOUND. It is mandatory for the Android Sanitizer")
		#endif()
		  
		configure_file("${CMAKE_CURRENT_SOURCE_DIR}/configs/android/wrap.sh.cmake" "${CMAKE_INSTALL_PREFIX}/lib/wrap.sh" @ONLY)
	endif()
endif()


if(CMAKE_BUILD_TYPE STREQUAL "Debug")
	# GDB server setup
	linphone_builder_apply_flags()
	linphone_builder_set_ep_directories(gdbserver)
	linphone_builder_expand_external_project_vars()
	ExternalProject_Add(TARGET_gdbserver
		DEPENDS TARGET_linphone_builder
		TMP_DIR ${ep_tmp}
		BINARY_DIR ${ep_build}
		SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/android/gdbserver"
		DOWNLOAD_COMMAND ""
		CMAKE_GENERATOR ${CMAKE_GENERATOR}
		CMAKE_ARGS ${LINPHONE_BUILDER_EP_ARGS} -DANDROID_NDK_PATH=${ANDROID_NDK_PATH} -DARCHITECTURE=${ARCHITECTURE}
	)

	# Dummy stript to not strip compiled libs from the general Makefile
	file(WRITE "${LINPHONE_BUILDER_WORK_DIR}/strip.sh" "")
else()
	# Script to be able to strip compiled libs from the general Makefile
	configure_file("${CMAKE_CURRENT_LIST_DIR}/android/strip.sh.cmake" "${LINPHONE_BUILDER_WORK_DIR}/strip.sh" @ONLY)
endif()
