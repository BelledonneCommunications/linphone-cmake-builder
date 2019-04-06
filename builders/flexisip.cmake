############################################################################
# flexisip.cmake
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

lcb_git_repository("https://gitlab.linphone.org/BC/public/flexisip")
lcb_git_tag_latest("master")
lcb_git_tag("cc4e47496600e9b1d3d412ce6e887275c204334b")
lcb_external_source_paths("<LINPHONE_BUILDER_TOP_DIR>")
lcb_groupable(YES)
lcb_sanitizable(YES)

lcb_spec_file("flexisip.spec")
lcb_dependencies("belr" "sofiasip")
if(ENABLE_CONFERENCE)
	lcb_dependencies("linphone")
endif()
if(ENABLE_PRESENCE OR ENABLE_MDNS)
	lcb_dependencies("bellesip")
endif()
if(ENABLE_SOCI)
	lcb_dependencies("soci")
endif()
if(ENABLE_TRANSCODER)
	lcb_dependencies("ms2")
else()
	lcb_dependencies("ortp")
endif()
if(ENABLE_REDIS)
	lcb_dependencies("hiredis")
endif()
if(ENABLE_JWE_AUTH_PLUGIN)
	lcb_dependencies("jose")
endif()

lcb_cmake_options(
	"-DENABLE_TRANSCODER=${ENABLE_TRANSCODER}"
	"-DENABLE_UNIT_TESTS=${ENABLE_UNIT_TESTS}"
	"-DENABLE_ODBC=NO"
	"-DENABLE_REDIS=${ENABLE_REDIS}"
	"-DENABLE_SOCI=${ENABLE_SOCI}"
	"-DENABLE_PRESENCE=${ENABLE_PRESENCE}"
	"-DENABLE_CONFERENCE=${ENABLE_CONFERENCE}"
	"-DENABLE_SNMP=${ENABLE_SNMP}"
	"-DENABLE_DOC=${ENABLE_DOC}"
	"-DENABLE_PROTOBUF=${ENABLE_PROTOBUF}"
	"-DENABLE_MDNS=${ENABLE_MDNS}"
	"-DENABLE_JWE_AUTH_PLUGIN=${ENABLE_JWE_AUTH_PLUGIN}"
	"-DENABLE_EXTERNAL_AUTH_PLUGIN=${ENABLE_EXTERNAL_AUTH_PLUGIN}"
)
if (DEFINED SYSCONF_INSTALL_DIR)
	lcb_cmake_options(
		"-DSYSCONF_INSTALL_DIR=${SYSCONF_INSTALL_DIR}"
	)
endif()
