############################################################################
# linphone.cmake
# Copyright (C) 2014-2018  Belledonne Communications, Grenoble France
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

lcb_git_repository("https://gitlab.linphone.org/BC/public/linphone.git")
lcb_git_tag_latest("master")
lcb_git_tag("3.10.0")
lcb_external_source_paths("liblinphone")
lcb_groupable(YES)
lcb_sanitizable(YES)
lcb_package_source(YES)
lcb_spec_file("liblinphone.spec")
lcb_rpmbuild_name("liblinphone")

lcb_dependencies("bctoolbox" "bellesip" "ortp" "ms2" "ms2plugins" "belr" "jsoncpp")

if(ENABLE_DB_STORAGE)
	lcb_dependencies("soci")
else()
	# Do not add group chat if we don't have soci
	set(ENABLE_ADVANCED_IM OFF CACHE BOOL "Enable advanced instant messaging such as group chat." FORCE)
endif()

if(ENABLE_ADVANCED_IM AND NOT USE_SYSTEM_XERCES)
	lcb_dependencies("xerces")
endif()

if(NOT ENABLE_ADVANCED_IM OR NOT ENABLE_DB_STORAGE)
	# Having lime is pointless without one of those
	set(ENABLE_LIME_X3DH OFF CACHE BOOL "Enable lime X3DH support." FORCE)
endif()

if(NOT APPLE)
	# Do not build sqlite3, xml2 and zlib on Apple systems (Mac OS X and iOS), they are provided by the system
	if (ENABLE_SQLITE)
		lcb_dependencies("sqlite3")
	endif()
	if (ENABLE_XML2)
		lcb_dependencies("xml2")
	endif()
	if(NOT ANDROID AND NOT QNX AND ENABLE_ZLIB)
		lcb_dependencies("zlib")
	endif()
endif()

if(ENABLE_TUNNEL)
	lcb_dependencies("tunnel")
endif()

if(ENABLE_VCARD)
	lcb_dependencies("belcard")
endif()

if(ENABLE_LIME_X3DH)
	lcb_dependencies("lime")
endif()

if(ENABLE_LDAP)
	lcb_dependencies("openldap")
endif()

lcb_cmake_options(
	"-DENABLE_GTK_UI=${ENABLE_GTK_UI}"
	"-DENABLE_VIDEO=${ENABLE_VIDEO}"
	"-DENABLE_DEBUG_LOGS=${ENABLE_DEBUG_LOGS}"
	"-DENABLE_DOC=${ENABLE_DOC}"
	"-DENABLE_TOOLS=${ENABLE_TOOLS}"
	"-DENABLE_NLS=${ENABLE_NLS}"
	"-DENABLE_FLEXIAPI=${ENABLE_FLEXIAPI}"
	"-DENABLE_LIME=${ENABLE_LIME}"
	"-DENABLE_LIME_X3DH=${ENABLE_LIME_X3DH}"
	"-DENABLE_UNIT_TESTS=${ENABLE_UNIT_TESTS}"
	"-DENABLE_POLARSSL=${ENABLE_POLARSSL}"
	"-DENABLE_MBEDTLS=${ENABLE_MBEDTLS}"
	"-DENABLE_SOCI=ON"
	"-DENABLE_TUNNEL=${ENABLE_TUNNEL}"
	"-DENABLE_UPDATE_CHECK=${ENABLE_UPDATE_CHECK}"
	"-DENABLE_VCARD=${ENABLE_VCARD}"
	"-DENABLE_CXX_WRAPPER=${ENABLE_CXX_WRAPPER}"
	"-DENABLE_CSHARP_WRAPPER=${ENABLE_CSHARP_WRAPPER}"
	"-DENABLE_SWIFT_WRAPPER=${ENABLE_SWIFT_WRAPPER}"
	"-DENABLE_SWIFT_WRAPPER_COMPILATION=${ENABLE_SWIFT_WRAPPER_COMPILATION}"
	"-DENABLE_JAZZY_DOC=${ENABLE_JAZZY_DOC}"
	"-DENABLE_JAVA_WRAPPER=${ENABLE_JAVA_WRAPPER}"
	"-DENABLE_QRCODE=${ENABLE_QRCODE}"
	"-DENABLE_ASSETS=${ENABLE_ASSETS}"
	"-DENABLE_DB_STORAGE=${ENABLE_DB_STORAGE}"
	"-DENABLE_ADVANCED_IM=${ENABLE_ADVANCED_IM}"
	"-DENABLE_CONSOLE_UI=${ENABLE_CONSOLE_UI}"
	"-DENABLE_DAEMON=${ENABLE_DAEMON}"
	"-DENABLE_QT_GL=${ENABLE_QT_GL}"
	"-DENABLE_LDAP=${ENABLE_LDAP}"
)
