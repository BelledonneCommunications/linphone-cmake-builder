############################################################################
# Copyright (c) 2021 Belledonne Communications SARL.
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
lcb_git_repository("https://gitlab.linphone.org/BC/public/external/openldap.git")
lcb_external_source_paths("externals/openldap" "external/openldap")
lcb_may_be_found_on_system(YES)


if(NOT WIN32)
	lcb_dependencies("mbedtls")
else()
	lcb_dependencies("openssl")
	# Use Autotools on windows
	lcb_ignore_warnings(YES)
	lcb_build_method("autotools")
	lcb_do_not_use_cmake_flags(YES)
	lcb_config_h_file("stamp-h")#stamp-h is generated at the end of configure

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

	lcb_configure_options("--without-cyrus-sasl" "--with-gnu-ld" "--with-tls" "--without-yielding-select")# No need to build SASL as it is not yet supported by Linphone
	#Enable
	lcb_configure_options("--enable-shared")
	#Disable
	lcb_configure_options("--disable-backends" "--disable-slapd" "--disable-static" "--disable-slurpd")

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
endif()
