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
set(ENABLE_MICROSOFT_STORE_APP YES)
set(MICROSOFT_STORE_LINK_PATHS "\$(WindowsSDK_LibraryPath_x86);\$(NETFXKitsDir)Lib\\um\\x86;\$(VC_LibraryPath_VC_x86_store);\$(VC_ReferencesPath_ATL_x86);\$(VC_LibraryPath_VC_x86);\$(VC_LibraryPath_x86);\$(VC_VS_LibraryPath_VC_VS_x86);\$(LibraryPath)")

#link_directories(BEFORE ${MICROSOFT_STORE_LINK_PATHS})# Didn't work. $(VC_LibraryPath_x86) is guessed as a relative path by cmake. CMAKE_** cannot be used
#add_definitions() interprets -L and remove quotes
