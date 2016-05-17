############################################################################
# freerdp.cmake
# Copyright (C) 2014  Belledonne Communications, Grenoble France
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
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
############################################################################

set(EP_freerdp_GIT_REPOSITORY "git://github.com/FreeRDP/FreeRDP.git" CACHE STRING "freerdp repository URL")
set(EP_freerdp_GIT_TAG_LATEST "master" CACHE STRING "freerdp tag to use when compiling latest version")
set(EP_freerdp_GIT_TAG "bd7ed27f92747adbd13f5f89e7abcf4cffa07386" CACHE STRING "freerdp tag to use")
set(EP_freerdp_EXTERNAL_SOURCE_PATHS "externals/freerdp")
set(EP_freerdp_MAY_BE_FOUND_ON_SYSTEM TRUE)
set(EP_freerdp_IGNORE_WARNINGS TRUE)

set(EP_freerdp_LINKING_TYPE ${DEFAULT_VALUE_CMAKE_LINKING_TYPE})

set(EP_freerdp_CMAKE_OPTIONS
	"-DWLOG_LEVEL=DEBUG"
	"-DWITH_DEBUG_ALL=ON"
	"-DWITH_SERVER=ON"
	"-DWITH_CLIENT_INTERFACE=ON"
	"-DCLIENT_INTERFACE_SHARED=ON"
)
