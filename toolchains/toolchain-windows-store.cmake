################################################################################
#
#  Copyright (c) 2010-2020 Belledonne Communications SARL.
#
#  This file is part of linphone-sdk
#  (see https://www.linphone.org).
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see <http://www.gnu.org/licenses/>.
#
################################################################################


# Building for Windows Store is only available under Windows systems
if(NOT WIN32)
	message(FATAL_ERROR "You need to build using a Windows system")
endif()
if(POLICY CMP0081)
	cmake_policy(SET CMP0081 OLD)#Needed to set LINK_DIRECTORIES with Visual Studio variables
endif ()
set(ENABLE_MICROSOFT_STORE_APP YES)
add_definitions(-DENABLE_MICROSOFT_STORE_APP)
set(MICROSOFT_STORE_LINK_PATHS "\$(WindowsSDK_LibraryPath_x86);\$(NETFXKitsDir)Lib\\um\\x86;\$(VC_LibraryPath_VC_x86_store);\$(VC_ReferencesPath_ATL_x86);\$(VC_LibraryPath_VC_x86);\$(VC_LibraryPath_x86);\$(VC_VS_LibraryPath_VC_VS_x86);\$(LibraryPath);\$(VC_LibraryPath_VC_x86_store)\\references")

set(_WIN32_WINNT 0x0A00)
add_definitions("-D_WIN32_WINNT=0x0A00")

if(NOT LINPHONE_ADDLIBRARY_DEFINED)
	set(LINPHONE_ADDLIBRARY_DEFINED 1)#Used to avoid infinite recursion when add_library is already overloaded
	function(add_library name mode)
		_add_library(${name} ${mode} ${ARGN})
		if( NOT( ${mode} STREQUAL "INTERFACE"))# It's forbidden to set LINK_DIRECTORIES property for Interfaces
			message(STATUS "AddLibrary overload : ${name}, ${mode}")
			set_target_properties(${name} PROPERTIES LINK_DIRECTORIES "${MICROSOFT_STORE_LINK_PATHS}")
		endif()
	endfunction()
endif()
