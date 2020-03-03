############################################################################
# openh264.cmake
# Copyright (C) 2014  Belledonne Communications, Grenoble France
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

if(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	# Use prebuilt library in the source tree for Windows 10
	lcb_external_source_paths("build/openh264")
else()
	find_program(NASM_PROGRAM
		NAMES nasm nasm.exe
		HINTS "${LINPHONE_BUILDER_WORK_DIR}/windows_tools"
	)
	if(NOT NASM_PROGRAM)
		if(WIN32)
			message(FATAL_ERROR "Could not find the nasm.exe program. Please install it from http://www.nasm.us/")
		else()
			message(FATAL_ERROR "Could not find the nasm program.")
		endif()
	endif()

	set(OPENH264_VERSION "1.8.0")	# Keep this variable, it is used for packaging to know the version to download from Cisco
	lcb_git_repository("https://github.com/cisco/openh264")
	lcb_git_tag("openh264v${OPENH264_VERSION}")
	lcb_external_source_paths("externals/openh264" "external/openh264")
	lcb_ignore_warnings(YES)

	lcb_build_method("custom")
	lcb_linking_type("-static")
	set(OPENH264_BUILD_TYPE "Release")	# Always use Release build type, otherwise the codec is too slow...
	lcb_configure_command_source(${CMAKE_CURRENT_SOURCE_DIR}/builders/openh264/configure.sh.cmake)
	lcb_build_command_source(${CMAKE_CURRENT_SOURCE_DIR}/builders/openh264/build.sh.cmake)
	lcb_install_command_source(${CMAKE_CURRENT_SOURCE_DIR}/builders/openh264/install.sh.cmake)
	if(MSVC)
		lcb_additional_options("OS=\"msvc\"")
	elseif(ANDROID)
		#Temporary fix for 4.3 release. The ANDROID_PLATFORM_LEVEL (and derivatives...) aren't well passed here, so we hardcode it
		#(Waiting for proper fix in our android toolchain wrapper to be merged)
		if(CMAKE_ANDROID_NDK_VERSION VERSION_LESS 19 AND CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a")
			set(ANDROID_PLATFORM_LEVEL "17")
			set(ANDROID_PLATFORM "android-17")
			set(CMAKE_ANDROID_API "17")
			set(NDK_TOOLCHAIN_VERSION "gcc")
		else()
			set(ANDROID_PLATFORM_LEVEL "21")
			set(ANDROID_PLATFORM "android-21")
			set(CMAKE_ANDROID_API "21")
			set(NDK_TOOLCHAIN_VERSION "clang")
		endif()
		set(ADDITIONAL_OPTIONS "TOOLCHAINPREFIX=\"${ANDROID_TOOLCHAIN_PREFIX}\" OS=\"android\" NDKROOT=\"${CMAKE_ANDROID_NDK}\" NDKLEVEL=${ANDROID_PLATFORM_LEVEL} TARGET=\"android-${CMAKE_ANDROID_API}\" NDK_TOOLCHAIN_VERSION=${NDK_TOOLCHAIN_VERSION}")
		if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a")
			set(ADDITIONAL_OPTIONS "${ADDITIONAL_OPTIONS} ARCH=\"arm\" INCLUDE_PREFIX=\"arm-linux-androideabi\"")
		elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
			set(ADDITIONAL_OPTIONS "${ADDITIONAL_OPTIONS} ARCH=\"arm64\" INCLUDE_PREFIX=\"aarch64-linux-android\"")
		elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
			set(ADDITIONAL_OPTIONS "${ADDITIONAL_OPTIONS} ARCH=\"x86_64\" ENABLEPIC=\"Yes\" INCLUDE_PREFIX=\"i686-linux-android\"")
		else()
			set(ADDITIONAL_OPTIONS "${ADDITIONAL_OPTIONS} ARCH=\"x86\" ENABLEPIC=\"Yes\" INCLUDE_PREFIX=\"i686-linux-android\"")
		endif()
		lcb_additional_options("${ADDITIONAL_OPTIONS}")
	elseif(APPLE)
		if(IOS)
			if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
				lcb_additional_options("OS=\"ios\" ARCH=\"arm64\"")
				#XCode7  allows bitcode
				if (NOT ${XCODE_VERSION} VERSION_LESS 7)
					lcb_extra_cflags("-fembed-bitcode")
				endif()
			elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7")
				lcb_additional_options("OS=\"ios\" ARCH=\"armv7\"")
				#XCode7  allows bitcode
				if (NOT ${XCODE_VERSION} VERSION_LESS 7)
					lcb_extra_cflags("-fembed-bitcode")
				endif()
			elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
				lcb_additional_options("OS=\"ios\" ARCH=\"x86_64\"")
			else()
				lcb_additional_options("OS=\"ios\" ARCH=\"i386\"")
			endif()
		else()
			lcb_extra_cflags("-isysroot ${CMAKE_OSX_SYSROOT} -mmacosx-version-min=${CMAKE_OSX_DEPLOYMENT_TARGET}")
			if(CMAKE_OSX_ARCHITECTURES STREQUAL "x86_64")
				lcb_additional_options("ARCH=\"x86_64\"")
			else()
				lcb_additional_options("ARCH=\"x86\"")
			endif()
		endif()
	endif()
endif()
