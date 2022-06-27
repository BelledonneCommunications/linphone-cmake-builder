############################################################################
# srtp.cmake
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

lcb_git_repository("https://gitlab.linphone.org/BC/public/external/srtp.git")
lcb_git_tag_latest("master")
lcb_git_tag("befc23777e07efba36ffd7bda73f22c92d4e2475")
lcb_external_source_paths("srtp" "externals/srtp" "external/srtp")
lcb_may_be_found_on_system(YES)
lcb_ignore_warnings(YES)

lcb_linking_type("-DBUILD_SHARED_LIBS=YES")
lcb_cmake_options("-DTEST_APPS=NO")
# We must use mbedtls as crypto backend to enable AEAD crypto suites
lcb_dependencies("mbedtls")
lcb_cmake_options("-DENABLE_MBEDTLS=YES")
