############################################################################
# linphoneqt.cmake
# Copyright (C) 2017-2018  Belledonne Communications, Grenoble France
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

lcb_git_repository("https://gitlab.linphone.org/BC/public/linphone-desktop.git")
lcb_git_tag_latest("master")
lcb_external_source_paths("${CMAKE_SOURCE_DIR}/cmake")
lcb_git_tag("release/4.2")
lcb_groupable(NO)
lcb_sanitizable(YES)
lcb_spec_file("linphoneqt.spec")

lcb_dependencies("linphone" "ms2plugins" "minizip")

lcb_cmake_options("-DENABLE_UPDATE_CHECK=${ENABLE_UPDATE_CHECK}")

#Add config step for packaging.
set(LINPHONE_BUILDER_ADDITIONAL_CONFIG_STEPS "${CMAKE_CURRENT_LIST_DIR}/linphoneqt/additional_steps.cmake")

#NMN pointer, check this regarding jpeg2yuv issue
if(NOT WIN32 AND NOT APPLE)
#	lcb_blacklist_dependencies("turbo-jpeg") # turbo-jpeg is already provided by Qt5 so do not build it.
endif()
