############################################################################
# turbo-jpeg.cmake
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

lcb_git_repository("https://gitlab.linphone.org/BC/public/external/libjpeg-turbo.git")
#lcb_git_tag("f6b57f3521404f587f23d79ecd1b6db0dab6a221")
lcb_external_source_paths("externals/libjpeg-turbo" "external/libjpeg-turbo")
lcb_may_be_found_on_system(YES)

lcb_linking_type("-DENABLE_STATIC=YES" "-DENABLE_SHARED=NO")
if(NOT WIN32)
	lcb_extra_cflags("-fPIC")
	lcb_extra_cxxflags("-fPIC")
endif()
