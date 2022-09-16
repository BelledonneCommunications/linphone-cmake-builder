############################################################################
# Copyright (c) 2010-2019 Belledonne Communications SARL.
#
# This file is part of mediastreamer2.
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



lcb_git_repository("https://gitlab.linphone.org/BC/public/external/libyuv.git")
lcb_external_source_paths("externals/libyuv" "external/libyuv")
lcb_may_be_found_on_system(YES)

lcb_linking_type("-DENABLE_STATIC=YES" "-DENABLE_SHARED=NO")
if(NOT WIN32)
	lcb_extra_cflags("-fPIC")
	lcb_extra_cxxflags("-fPIC")
endif()

if(ENABLE_JPEG)
	#yuv use the cmake FindJPEG without allowing to switch it off. Make sure to point to the internal library.
	lcb_dependencies("turbojpeg")
	lcb_cmake_options("-DJPEG_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/turbojpeg")
endif()
