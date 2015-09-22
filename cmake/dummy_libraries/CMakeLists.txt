############################################################################
# CMakeLists.txt
# Copyright (C) 2015  Belledonne Communications, Grenoble France
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

cmake_minimum_required(VERSION 3.0)
project(DUMMY_LIBRARIES)

string(REPLACE " " ";" LINPHONE_BUILDER_DUMMY_LIBRARIES ${LINPHONE_BUILDER_DUMMY_LIBRARIES})
foreach(LIB ${LINPHONE_BUILDER_DUMMY_LIBRARIES})
	string(REPLACE "-" "_" UNDERSCORE_LIB ${LIB})
	string(REGEX REPLACE "^lib" "" NOPREFIX_LIB ${LIB})
	configure_file("${CMAKE_CURRENT_SOURCE_DIR}/dummy.c.in" "${CMAKE_CURRENT_BINARY_DIR}/${LIB}.c" @ONLY)
	add_library(${NOPREFIX_LIB} STATIC "${CMAKE_CURRENT_BINARY_DIR}/${LIB}.c")
	set(_dest "lib")
	if(${LIB} MATCHES "^libms")
		set(_dest "lib/mediastreamer/plugins")
	endif()
	install(TARGETS ${NOPREFIX_LIB}
		LIBRARY DESTINATION ${_dest}
		ARCHIVE DESTINATION ${_dest}
		PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
	)
	unset(_dest)
endforeach()