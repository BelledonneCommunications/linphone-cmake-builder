############################################################################
# Copyright (c) 2010-2021 Belledonne Communications SARL.
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

set(OPENLDAP_VERSION "2_4")
lcb_external_source_paths("externals/openldap" "external/openldap")

lcb_may_be_found_on_system(YES)
lcb_ignore_warnings(YES)

lcb_build_method("autotools")
lcb_do_not_use_cmake_flags(YES)
lcb_config_h_file("openldap_config.h")

#by default, Target=HOST
if(WIN32)
	if(MSVC)
		set(MSVC_ARCH ${CMAKE_CXX_COMPILER_ARCHITECTURE_ID})# ${MSVC_ARCH} MATCHES "X64"
		string(TOUPPER ${MSVC_ARCH} MSVC_ARCH)
		if(${MSVC_ARCH} MATCHES "X64")
			set(OPENLDAP_TARGET "--target=x86_64-pc-mingw64")
		else()
			set(OPENLDAP_TARGET "--target=i686-pc-mingw32")
		endif()
	else()
		if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" OR CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64")
			set(OPENLDAP_TARGET "--target=x86_64-pc-mingw64")
		else()
			set(OPENLDAP_TARGET "--target=i686-pc-mingw32")
		endif()
	endif()
#target=pc-windows	
elseif(APPLE)
# target=pc-macos
else()
# target=pc-linux
endif()

lcb_configure_options("--without-cyrus-sasl" "--with-gnu-ld")# No need to build SASL as it is not yet supported by Linphone
#Enable
lcb_configure_options("--enable-shared")
#Disable
lcb_configure_options("--disable-backends" "--disable-slapd" "--disable-static" "--disable-slurpd")

if(WIN32)
	if(CMAKE_BUILD_PARALLEL_LEVEL)
		lcb_make_options("-j${CMAKE_BUILD_PARALLEL_LEVEL}")
	else()
		lcb_make_options("-j4")
	endif()
	if(CMAKE_BUILD_TYPE STREQUAL "Debug" OR CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
		set(BUILD_FLAG "-I${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR} -g3 -w")
	else()
		set(BUILD_FLAG "-I${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR} -w")
	endif()
	
# Need 8 '\' to get one '\' in final configure_file (that comes from double escaping and regex)
	lcb_configure_env("LIBS=\"-lssl -lcrypto -lws2_32\" CFLAGS=\"-D__USE_MINGW_ANSI_STDIO ${BUILD_FLAGS}\" CPPFLAGS=\"${BUILD_FLAGS}\" LDFLAGS=\"-static-libgcc -L${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR} -Wl,--output-def,.libs/\\\\\\\\$@.def\" ")
	lcb_configure_options(
		"--srcdir=${CMAKE_CURRENT_SOURCE_DIR}/../external/openldap"
		"--prefix=${CMAKE_INSTALL_PREFIX}"
		"--libdir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
		"--includedir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/openldap"
		"${OPENLDAP_TARGET}"
	)
elseif(APPLE)
	if(CMAKE_GENERATOR STREQUAL "Xcode")
		# It appears that the build occurs in the cmake directory instead of the Build/vpx one with Xcode, so these flags are needed for include files to be found...
		lcb_extra_cflags("-I${LINPHONE_BUILDER_WORK_DIR}/Build/openldap")
		lcb_extra_asflags("-I${LINPHONE_BUILDER_WORK_DIR}/Build/openldap")
	endif()
	lcb_extra_cflags("-isysroot ${CMAKE_OSX_SYSROOT} -mmacosx-version-min=${CMAKE_OSX_DEPLOYMENT_TARGET}")
#Letting cmake to select compiler can lead to not use the right framework. Let it decide on the build of OpenLDAP by not using full path
	lcb_configure_env("CC=cc LD=ld AR=ar RANLIB=ranlib STRIP=strip ASFLAGS=$ASFLAGS CFLAGS=$CFLAGS LDFLAGS=$LDFLAGS")
	lcb_configure_options(
		"--srcdir=${CMAKE_CURRENT_SOURCE_DIR}/../external/openldap"
		"--prefix=${CMAKE_INSTALL_PREFIX}"
		"--libdir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
		"--includedir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/openldap"
	)
else()
	lcb_configure_env("CPPFLAGS=-I${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR} LDFLAGS=-L${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
	lcb_configure_options(
		"--srcdir=${CMAKE_CURRENT_SOURCE_DIR}/../external/openldap"
		"--prefix=${CMAKE_INSTALL_PREFIX}"
		"--libdir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
		"--includedir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/openldap"
	)
endif()
