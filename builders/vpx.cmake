############################################################################
# vpx.cmake
# Copyright (C) 2014-2021  Belledonne Communications, Grenoble France
#
############################################################################
#
# This file is part of cmake-builder.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
############################################################################

if(LINPHONE_BUILDER_PREBUILT_URL)
	set(VPX_FILENAME "vpx-v1.3.0-${LINPHONE_BUILDER_ARCHITECTURE}.zip")
	file(DOWNLOAD "${LINPHONE_BUILDER_PREBUILT_URL}/${VPX_FILENAME}" "${CMAKE_CURRENT_BINARY_DIR}/${VPX_FILENAME}" STATUS VPX_FILENAME_STATUS)
	list(GET VPX_FILENAME_STATUS 0 VPX_DOWNLOAD_STATUS)
	if(NOT VPX_DOWNLOAD_STATUS)
		set(VPX_PREBUILT 1)
	endif()
endif()
set(CROSS_COMPILATION_OPTIONS "")
# BUILD_ROOT is set by Xcode, but we still need the current build root.
# See https://gitlab.linphone.org/BC/public/external/libvpx/blob/v1.7.0-linphone/build/make/Makefile
set(VPX_MAKE_OPTIONS "BUILD_ROOT=.")

if(VPX_PREBUILT)
	lcb_url("${CMAKE_CURRENT_BINARY_DIR}/${VPX_FILENAME}")
	lcb_build_method("prebuilt")
else()
	lcb_url("http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2")
	lcb_url_hash("MD5=49e59dd184caa255886683facea56fca")
	lcb_external_source_paths("externals/libvpx" "external/libvpx")
	lcb_may_be_found_on_system(YES)
	lcb_ignore_warnings(YES)

	lcb_build_method("autotools")
	lcb_do_not_use_cmake_flags(YES)
	lcb_config_h_file("vpx_config.h")
	lcb_configure_options(
		"--enable-error-concealment"
		"--enable-multithread"
		"--enable-realtime-only"
		"--enable-spatial-resampling"
		"--enable-vp8"
		"--disable-vp9"
		"--enable-libs"
		"--disable-install-docs"
		"--disable-debug-libs"
		"--disable-examples"
		"--disable-unit-tests"
		"--disable-tools"
		"--as=yasm"
	)
	string(FIND "${CMAKE_C_COMPILER_LAUNCHER}" "ccache" CCACHE_ENABLED)
	if (NOT "${CCACHE_ENABLED}" STREQUAL "-1")
		lcb_configure_options("--enable-ccache")
	endif()

	set(USE_TARGET YES)
	if(WIN32)
		if(MSVC)
			lcb_build_method("custom")
			if(CMAKE_BUILD_PARALLEL_LEVEL)
				set(VPX_MAKE_OPTIONS "${VPX_MAKE_OPTIONS} -j${CMAKE_BUILD_PARALLEL_LEVEL}")
			endif()
			if(CMAKE_GENERATOR MATCHES "^Visual Studio")
				string(REPLACE " " ";" GENERATOR_LIST "${CMAKE_GENERATOR}")
				list(GET GENERATOR_LIST 2 VS_VERSION)
			else()
				if( "${MSVC_TOOLSET_VERSION}" STREQUAL "142")
					set(VS_VERSION "16")
				elseif( "${MSVC_TOOLSET_VERSION}" STREQUAL "141")
					set(VS_VERSION "15")
				elseif("${MSVC_TOOLSET_VERSION}" STREQUAL "140")
					set(VS_VERSION "14")
				elseif("${MSVC_TOOLSET_VERSION}" STREQUAL "120")
					set(VS_VERSION "12")
				elseif("${MSVC_TOOLSET_VERSION}" STREQUAL "110")
					set(VS_VERSION "11")
				elseif("${MSVC_TOOLSET_VERSION}" STREQUAL "100")
					set(VS_VERSION "10")
				elseif("${MSVC_TOOLSET_VERSION}" STREQUAL "90")
					set(VS_VERSION "9")
				else()
					set(VS_VERSION "15")
				endif()
			endif()
			set(MSVC_ARCH ${CMAKE_CXX_COMPILER_ARCHITECTURE_ID})# ${MSVC_ARCH} MATCHES "X64"
			string(TOUPPER ${MSVC_ARCH} MSVC_ARCH)
			if(${MSVC_ARCH} MATCHES "X64")
			    set(VPX_TARGET "x86_64-win64-vs${VS_VERSION}")
			else()
			    set(VPX_TARGET "x86-win32-vs${VS_VERSION}")
			endif()
			message(STATUS "Build VPX with : ${VPX_TARGET}")
			execute_process(COMMAND "cmd.exe" "/c" "${CMAKE_CURRENT_SOURCE_DIR}/builders/vpx/windows_env.bat" "${VS_VERSION}"
				WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
			)
			if(NOT SH_PROGRAM)#Just in case if this builder is execute before CheckBuildTools
				find_program(SH_PROGRAM sh.exe HINTS "C:/msys64/user/bin")
			endif()
			get_filename_component(SH_DIR ${SH_PROGRAM} DIRECTORY )# No need to test if sh is found as it is a pre-required module in SDK CheckBuildTools
			set(VPX_ENV_PATH_LIST "")
			list(APPEND VPX_ENV_PATH_LIST ${SH_DIR} ${AUTOTOOLS_PROGRAM_PATH})
			string(REPLACE "\n" "" VPX_ENV_PATH_LIST "${VPX_ENV_PATH_LIST}")
			set(VPX_ENV_PATH "${VPX_ENV_PATH_LIST}")
			string(STRIP "${VPX_ENV_PATH}" VPX_ENV_PATH)
			file(READ "${CMAKE_CURRENT_BINARY_DIR}/windowsenv_include.txt" VPX_ENV_INCLUDE)
			string(REPLACE "\n" "" VPX_ENV_INCLUDE "${VPX_ENV_INCLUDE}")
			file(READ "${CMAKE_CURRENT_BINARY_DIR}/windowsenv_lib.txt" VPX_ENV_LIB)
			string(REPLACE "\n" "" VPX_ENV_LIB "${VPX_ENV_LIB}")
			file(READ "${CMAKE_CURRENT_BINARY_DIR}/windowsenv_libpath.txt" VPX_ENV_LIBPATH)
			string(REPLACE "\n" "" VPX_ENV_LIBPATH "${VPX_ENV_LIBPATH}")
		else()
		    if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" OR CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64")
				set(VPX_TARGET "x86_64-win64-gcc")
		    else()
				set(VPX_TARGET "x86-win32-gcc")
		    endif()
		endif()
		set(EP_vpx_CONFIGURE_OPTIONS_STR "")
		foreach(OPTION ${EP_vpx_CONFIGURE_OPTIONS})
			set(EP_vpx_CONFIGURE_OPTIONS_STR "${EP_vpx_CONFIGURE_OPTIONS_STR} \"${OPTION}\"")
		endforeach()
		lcb_configure_command_source("${CMAKE_CURRENT_SOURCE_DIR}/builders/vpx/windows_configure.sh.cmake")
		lcb_build_command_source("${CMAKE_CURRENT_SOURCE_DIR}/builders/vpx/windows_build.sh.cmake")
		lcb_install_command_source("${CMAKE_CURRENT_SOURCE_DIR}/builders/vpx/windows_install.sh.cmake")
	elseif(APPLE)
		if(IOS)
			if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
				set(VPX_TARGET "arm64-darwin-gcc")
			elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7")
				set(VPX_TARGET "armv7-darwin-gcc")
			elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
				set(VPX_TARGET "x86_64-iphonesimulator-gcc")
			else()
				set(VPX_TARGET "x86-iphonesimulator-gcc")
			endif()
		else()
			if(CMAKE_OSX_ARCHITECTURES STREQUAL "x86_64")
				set(VPX_TARGET "x86_64-darwin10-gcc")
			else()
				set(VPX_TARGET "x86-darwin10-gcc")
			endif()
		endif()
		if(CMAKE_GENERATOR STREQUAL "Xcode")
			# It appears that the build occurs in the cmake directory instead of the Build/vpx one with Xcode, so these flags are needed for include files to be found...
			lcb_extra_cflags("-I${LINPHONE_BUILDER_WORK_DIR}/Build/vpx")
			lcb_extra_asflags("-I${LINPHONE_BUILDER_WORK_DIR}/Build/vpx")
		endif()
		lcb_linking_type("--enable-static" "--disable-shared" "--enable-pic")
	elseif(ANDROID)
		if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv5te")
			message(FATAL_ERROR "VPX cannot be built on arm.")
		elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a")
			set(VPX_TARGET "armv7-android-gcc")
		elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
			set(VPX_TARGET "arm64-android-gcc")
		elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" )
			set(VPX_TARGET "x86_64-android-gcc")
		else()
			set(VPX_TARGET "x86-android-gcc")
		endif()
		lcb_configure_options(
			"--sdk-path=${CMAKE_ANDROID_NDK}/"
			"--android_ndk_api=${ANDROID_NATIVE_API_LEVEL}"
		)
		lcb_linking_type("--enable-static" "--disable-shared" "--enable-pic")
		list(APPEND CROSS_COMPILATION_OPTIONS "--extra-cflags=-fPIC" "--extra-cxxflags=-fPIC")
	elseif(QNX)
		set(VPX_TARGET "armv7-qnx-gcc")
		lcb_configure_options(
			"--libc=${QNX_TARGET}/${ROOT_PATH_SUFFIX}"
			"--force-target=armv7-qnx-gcc"
			"--disable-runtime-cpu-detect"
		)
		list(REMOVE_ITEM EP_vpx_CONFIGURE_OPTIONS "--enable-multithread")
	else()
		lcb_use_c_compiler_for_assembler(NO)
		if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7l")
			set(VPX_TARGET "armv7-linux-gcc")
	        elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "arm")
			#A bit hacky, but CMAKE_SYSTEM_PROCESSOR sometimes doesn't include abi version so assume `armv7` by default
			set(VPX_TARGET "armv7-linux-gcc")
		else()
			if(CMAKE_SIZEOF_VOID_P EQUAL 8)
				set(VPX_TARGET "x86_64-linux-gcc")
			else()
				set(VPX_TARGET "x86-linux-gcc")
			endif()
		endif()
		lcb_linking_type("--disable-static" "--enable-shared")
	endif()
	list(APPEND CROSS_COMPILATION_OPTIONS "--prefix=${CMAKE_INSTALL_PREFIX}")
	if(USE_TARGET)
		list(APPEND CROSS_COMPILATION_OPTIONS "--libdir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
			"--target=${VPX_TARGET}"
		)
	endif()
	lcb_cross_compilation_options(${CROSS_COMPILATION_OPTIONS})
	if(CMAKE_C_COMPILER_ID MATCHES "Clang" AND CMAKE_C_COMPILER_VERSION VERSION_LESS "4.0")
		lcb_configure_options("--disable-avx512")
	endif()
	lcb_configure_env("CC=$CC_NO_LAUNCHER LD=$CC_NO_LAUNCHER ASFLAGS=$ASFLAGS CFLAGS=$CFLAGS LDFLAGS=$LDFLAGS")
	lcb_make_options("${VPX_MAKE_OPTIONS}")
endif()
