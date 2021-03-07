############################################################################
# config-desktop.cmake
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
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
############################################################################

include(${CMAKE_CURRENT_LIST_DIR}/options-desktop.cmake)

if(APPLE)
	set(CMAKE_INSTALL_RPATH "@executable_path/../Frameworks;@executable_path/../lib")
endif()

include(configs/config-desktop-common.cmake)


lcb_builder_cmake_options(belr "-DENABLE_TOOLS=YES")
lcb_builder_cmake_options(linphone "-DENABLE_TOOLS=YES")


# Install GTK and intltool for build with Visual Studio
if(MSVC AND ENABLE_GTK_UI)
	if(NOT EXISTS "${CMAKE_CURRENT_BINARY_DIR}/intltool_win32.zip")
		message(STATUS "Installing intltool")
		file(DOWNLOAD http://ftp.acc.umu.se/pub/GNOME/binaries/win32/intltool/0.40/intltool_0.40.4-1_win32.zip "${CMAKE_CURRENT_BINARY_DIR}/intltool_win32.zip" SHOW_PROGRESS)
		execute_process(
			COMMAND "${CMAKE_COMMAND}" "-E" "tar" "x" "${CMAKE_CURRENT_BINARY_DIR}/intltool_win32.zip"
			WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}"
		)
	endif()
	if(NOT EXISTS "${CMAKE_CURRENT_BINARY_DIR}/gtk+-bundle_win32.zip")
		message(STATUS "Installing GTK")
		file(DOWNLOAD http://ftp.gnome.org/pub/gnome/binaries/win32/gtk+/2.24/gtk+-bundle_2.24.10-20120208_win32.zip "${CMAKE_CURRENT_BINARY_DIR}/gtk+-bundle_win32.zip" SHOW_PROGRESS)
		execute_process(
			COMMAND "${CMAKE_COMMAND}" "-E" "tar" "x" "${CMAKE_CURRENT_BINARY_DIR}/gtk+-bundle_win32.zip"
			WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}"
		)
	endif()
endif()


# Add config step for packaging
if(NOT LINPHONE_BUILDER_ADDITIONAL_CONFIG_STEPS)
	set(LINPHONE_BUILDER_ADDITIONAL_CONFIG_STEPS "${CMAKE_CURRENT_LIST_DIR}/desktop/additional_steps.cmake")
endif()

#decaf
lcb_builder_cmake_options(decaf "-DENABLE_STRICT=NO")

if (MSVC)
	lcb_builder_linking_type(mbedtls "-DUSE_STATIC_MBEDTLS_LIBRARY=YES" "-DUSE_SHARED_MBEDTLS_LIBRARY=NO")
endif()

if(APPLE)
	set(DEFAULT_VALUE_CMAKE_LINKING_TYPE "-DENABLE_SHARED=NO" "-DENABLE_STATIC=YES")

	# bctoolbox
	lcb_builder_linking_type(bctoolbox "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")

	# belcard
	lcb_builder_linking_type(belcard "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")

	# belr
	lcb_builder_linking_type(belr "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")

	# bzrtp
	lcb_builder_cmake_options(bzrtp "-DENABLE_DOC=NO")

	# lime
	lcb_builder_cmake_options(lime "-DENABLE_DOC=NO")
	lcb_builder_linking_type(lime "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")
	
	# linphone
	lcb_builder_cmake_options(linphone "-DENABLE_RELATIVE_PREFIX=YES")
	lcb_builder_cmake_options(linphone "-DENABLE_CONSOLE_UI=NO")
	lcb_builder_cmake_options(linphone "-DENABLE_DAEMON=NO")
	lcb_builder_cmake_options(linphone "-DENABLE_NOTIFY=NO")
	lcb_builder_cmake_options(linphone "-DENABLE_TUTORIALS=NO")
	lcb_builder_cmake_options(linphone "-DENABLE_UPNP=NO")
	lcb_builder_cmake_options(linphone "-DENABLE_MSG_STORAGE=YES")
	lcb_builder_cmake_options(linphone "-DENABLE_DOC=NO")
	lcb_builder_cmake_options(linphone "-DENABLE_NLS=NO")
	lcb_builder_linking_type(linphone "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")

	# mbedtls
	lcb_builder_linking_type(mbedtls "-DUSE_STATIC_MBEDTLS_LIBRARY=YES" "-DUSE_SHARED_MBEDTLS_LIBRARY=NO")

	# mediastreamer2
	lcb_builder_cmake_options(ms2 "-DENABLE_RELATIVE_PREFIX=YES")
	lcb_builder_cmake_options(ms2 "-DENABLE_ALSA=NO")
	lcb_builder_cmake_options(ms2 "-DENABLE_PULSEAUDIO=NO")
	lcb_builder_cmake_options(ms2 "-DENABLE_OSS=NO")
	lcb_builder_cmake_options(ms2 "-DENABLE_GLX=NO")
	lcb_builder_cmake_options(ms2 "-DENABLE_X11=NO")
	lcb_builder_cmake_options(ms2 "-DENABLE_XV=NO")
	lcb_builder_cmake_options(ms2 "-DENABLE_DOC=NO")
	lcb_builder_linking_type(ms2 "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")

	# ms2 plugins
	lcb_builder_linking_type(msamr "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")
	lcb_builder_linking_type(mscodec2 "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")
	lcb_builder_linking_type(msopenh264 "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")
	lcb_builder_linking_type(mssilk "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")
	lcb_builder_linking_type(mswebrtc "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")
	lcb_builder_linking_type(msx264 "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")

	# ortp
	lcb_builder_cmake_options(ortp "-DENABLE_DOC=NO")
	lcb_builder_linking_type(ortp "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")

	# bellesip
	lcb_builder_linking_type(bellesip "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")


elseif(WIN32 AND ENABLE_MICROSOFT_STORE_APP)
	set(CMAKE_C_STANDARD_LIBRARIES "WindowsApp.lib ${CMAKE_C_STANDARD_LIBRARIES}")
	set(CMAKE_CXX_STANDARD_LIBRARIES "WindowsApp.lib ${CMAKE_CXX_STANDARD_LIBRARIES}")
	set(CMAKE_EXE_LINKER_FLAGS "/APPCONTAINER ${CMAKE_EXE_LINKER_FLAGS}")
	set(CMAKE_MODULE_LINKER_FLAGS "/APPCONTAINER ${CMAKE_MODULE_LINKER_FLAGS}")
	set(CMAKE_SHARED_LINKER_FLAGS "/APPCONTAINER ${CMAKE_SHARED_LINKER_FLAGS}")
endif()
