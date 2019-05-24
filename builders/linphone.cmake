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
lcb_external_source_paths("linphone")
lcb_groupable(YES)
lcb_sanitizable(YES)
lcb_package_source(YES)
lcb_spec_file("liblinphone.spec")
lcb_rpmbuild_name("liblinphone")

lcb_dependencies("bctoolbox" "bellesip" "ortp" "ms2" "ms2plugins" "belr" "libxsd" "soci")
if(NOT APPLE)
	# Do not build sqlite3, xml2 and zlib on Apple systems (Mac OS X and iOS), they are provided by the system
	lcb_dependencies("sqlite3" "xml2")
	if(NOT ANDROID AND NOT QNX)
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
lcb_cmake_options(
	"-DENABLE_GTK_UI=${ENABLE_GTK_UI}"
	"-DENABLE_VIDEO=${ENABLE_VIDEO}"
	"-DENABLE_DEBUG_LOGS=${ENABLE_DEBUG_LOGS}"
	"-DENABLE_DOC=${ENABLE_DOC}"
	"-DENABLE_TOOLS=${ENABLE_TOOLS}"
	"-DENABLE_NLS=${ENABLE_NLS}"
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
	"-DENABLE_JAVA_WRAPPER=${ENABLE_JAVA_WRAPPER}"
	"-DENABLE_QRCODE=${ENABLE_QRCODE}"
)
