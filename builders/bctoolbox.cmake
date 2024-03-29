############################################################################
# bctoolbox.cmake
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

lcb_git_repository("https://gitlab.linphone.org/BC/public/bctoolbox.git")
lcb_git_tag_latest("master")
lcb_git_tag("master")
lcb_external_source_paths("bctoolbox")
lcb_groupable(YES)
lcb_sanitizable(YES)
lcb_package_source(YES)
lcb_spec_file("bctoolbox.spec")

if(ENABLE_MBEDTLS)
	lcb_dependencies("mbedtls")
endif()
if(ENABLE_UNIT_TESTS)
	lcb_dependencies("bcunit")
endif()
if(ENABLE_LIME_X3DH)
	lcb_dependencies("decaf")
endif()

lcb_cmake_options(
	"-DENABLE_DEBUG_LOGS=${ENABLE_DEBUG_LOGS}"
	"-DENABLE_MBEDTLS=${ENABLE_MBEDTLS}"
	"-DENABLE_DECAF=${ENABLE_LIME_X3DH}"
	"-DENABLE_TESTS=${ENABLE_UNIT_TESTS}"
	"-DENABLE_TESTS_COMPONENT=${ENABLE_UNIT_TESTS}"
)

