############################################################################
# x264.cmake
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

lcb_git_repository("https://code.videolan.org/videolan/x264.git")
lcb_external_source_paths("externals/x264")
lcb_ignore_warnings(YES)

lcb_build_method("autotools")
lcb_cross_compilation_options(
	"--prefix=${CMAKE_INSTALL_PREFIX}"
	"--host=${LINPHONE_BUILDER_HOST}"
)

if(IOS)
	lcb_configure_options(
	"--extra-cflags=$CFLAGS"
	"--extra-ldflags=$LDFLAGS"
	"--sysroot=${CMAKE_OSX_SYSROOT}"
	)
	string(REGEX MATCH "^(arm*|aarch64)" ARM_ARCH "${CMAKE_SYSTEM_PROCESSOR}")
	if(ARM_ARCH AND NOT ${XCODE_VERSION} VERSION_LESS 7)
		lcb_configure_options("--extra-asflags=-fembed-bitcode")
	endif()
elseif(ANDROID)
	lcb_configure_options(
		"--disable-asm"
		"--sysroot=${CMAKE_SYSROOT}"
	)

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

	if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a")
		set(X264_HOST "arm-linux")
	elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
		set(X264_HOST "aarch64-linux")
	elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
		set(X264_HOST "x86_64-linux")
	else()
		set(X264_HOST "i686-linux")
	endif()

	message(STATUS "---------------------PREFIX '${CMAKE_ANDROID_NDK}'  '${ANDROID_HOST_TAG}' $CC")
	lcb_cross_compilation_options(
		"--prefix=${CMAKE_INSTALL_PREFIX}"
		"--host=${X264_HOST}"
	)
	lcb_use_c_compiler_for_assembler(YES)
endif()

lcb_linking_type("--enable-shared")
if(IOS)
	lcb_configure_env("CC=\"$CC -arch ${LINPHONE_BUILDER_OSX_ARCHITECTURES}\"")
else()
	if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a")
		lcb_configure_env("CC=${CMAKE_ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/armv7a-linux-androideabi${CMAKE_ANDROID_API}-clang")
	else()
		lcb_configure_env("CC=${CMAKE_ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/${CMAKE_SYSTEM_PROCESSOR}-linux-android${CMAKE_ANDROID_API}-clang")
	endif()
endif()
lcb_install_target("install-lib-shared")
