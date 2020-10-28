############################################################################
# bellesip.cmake
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

lcb_git_repository("https://gitlab.linphone.org/BC/public/belle-sip.git")
lcb_git_tag_latest("master")
lcb_git_tag("1.5.3")
lcb_external_source_paths("belle-sip")
lcb_groupable(YES)
lcb_sanitizable(YES)
lcb_package_source(YES)
lcb_spec_file("belle-sip.spec")
lcb_rpmbuild_name("belle-sip")

lcb_dependencies("bctoolbox")
if(ENABLE_TUNNEL)
	lcb_dependencies("tunnel")
endif()

if(NOT APPLE AND NOT ANDROID AND NOT QNX AND ENABLE_ZLIB)
	lcb_dependencies("zlib")
endif()

lcb_cmake_options(
	"-DENABLE_RTP_MAP_ALWAYS_IN_SDP=${ENABLE_RTP_MAP_ALWAYS_IN_SDP}"
	"-DENABLE_TUNNEL=${ENABLE_TUNNEL}"
	"-DENABLE_TESTS=${ENABLE_UNIT_TESTS}"
	"-DENABLE_MDNS=${ENABLE_MDNS}"
	"-DENABLE_DNS_SERVICE=${ENABLE_DNS_SERVICE}"
)
