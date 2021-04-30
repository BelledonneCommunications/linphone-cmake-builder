############################################################################
# config-flexisip.cmake
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

# Define default values for the flexisip builder options
set(DEFAULT_VALUE_ENABLE_ADVANCED_IM ON)
set(DEFAULT_VALUE_ENABLE_DB_STORAGE ON)
set(DEFAULT_VALUE_ENABLE_REDIS ON)
set(DEFAULT_VALUE_ENABLE_UNIT_TESTS OFF)
set(DEFAULT_VALUE_ENABLE_PRESENCE ON)
set(DEFAULT_VALUE_ENABLE_CONFERENCE ON)
set(DEFAULT_VALUE_ENABLE_SNMP OFF)
set(DEFAULT_VALUE_ENABLE_POLARSSL OFF)
set(DEFAULT_VALUE_ENABLE_MBEDTLS ON)
set(DEFAULT_VALUE_ENABLE_PROTOBUF OFF)
set(DEFAULT_VALUE_ENABLE_JWE_AUTH_PLUGIN ON)
set(DEFAULT_VAULE_ENABLE_EXTERNAL_AUTH_PLUGIN ON)
set(DEFAULT_VALUE_ENABLE_TRANSCODER ON)
set(DEFAULT_VALUE_ENABLE_SOCI ON)

set(DEFAULT_VALUE_ENABLE_VCARD OFF)
set(DEFAULT_VALUE_ENABLE_VIDEO OFF)

set(DEFAULT_VALUE_CMAKE_LINKING_TYPE "-DENABLE_STATIC=NO")

# ms2 default values
set(DEFAULT_VALUE_ENABLE_SPEEX ON)
set(DEFAULT_VALUE_ENABLE_OPUS ON)

set(USE_SYSTEM_XERCES YES)

# Global configuration
set(LINPHONE_BUILDER_HOST "")

# Set sanitizer flags
if (ENABLE_SANITIZER)
	include(configs/config-sanitizer.cmake)
endif()

# Adjust PKG_CONFIG_PATH to include install directory
if(UNIX)
	set(LINPHONE_BUILDER_PKG_CONFIG_PATH "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/:$ENV{PKG_CONFIG_PATH}:/usr/lib/pkgconfig/:/usr/lib/x86_64-linux-gnu/pkgconfig/:/usr/share/pkgconfig/:/usr/local/lib/pkgconfig/:/opt/local/lib/pkgconfig/")
else() # Windows
	set(LINPHONE_BUILDER_PKG_CONFIG_PATH "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/")
endif()
if(APPLE)
	if (NOT CMAKE_OSX_DEPLOYMENT_TARGET) #is it still useful?
		#without instruction chose to target lower version between current machine and current used SDK
		execute_process(COMMAND sw_vers -productVersion  COMMAND awk -F \\. "{printf \"%i.%i\",$1,$2}"  RESULT_VARIABLE sw_vers_version OUTPUT_VARIABLE CURRENT_OSX_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)
		execute_process(COMMAND xcrun --sdk macosx --show-sdk-version RESULT_VARIABLE xcrun_sdk_version OUTPUT_VARIABLE CURRENT_SDK_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)
		if (${CURRENT_OSX_VERSION} VERSION_LESS ${CURRENT_SDK_VERSION})
			set(CMAKE_OSX_DEPLOYMENT_TARGET ${CURRENT_OSX_VERSION})
		else()
			set(CMAKE_OSX_DEPLOYMENT_TARGET ${CURRENT_SDK_VERSION})
		endif()
	endif()
	set(CMAKE_MACOSX_RPATH 1)
endif()

include(GNUInstallDirs)
if(NOT CMAKE_INSTALL_RPATH)
	list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}" _IS_SYSTEM_DIR)
	if(_IS_SYSTEM_DIR STREQUAL "-1")
		set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_FULL_LIBDIR}")
		if(NOT CMAKE_INSTALL_LIBDIR STREQUAL "lib")
			list(APPEND CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
		endif()
	endif()
endif()
message("cmake install rpath: ${CMAKE_INSTALL_RPATH}")

# Include builders
include(builders/CMakeLists.txt)

# bctoolbox
lcb_builder_cmake_options(bctoolbox "-DENABLE_TESTS_COMPONENT=${ENABLE_UNIT_TESTS}")

# linphone
lcb_builder_cmake_options(linphone
	"-DENABLE_CONSOLE_UI=NO"
	"-DENABLE_DAEMON=NO"
)
if(ENABLE_CONFERENCE)
	lcb_builder_cmake_options(linphone
		"-DENABLE_CXX_WRAPPER=YES"
		"-DENABLE_SOCI=YES"
		"-DENABLE_UNIT_TESTS=${ENABLE_UNIT_TESTS}"
	)
endif()

# soci
lcb_builder_cmake_options(soci "-DWITH_MYSQL=ON" "-DSOCI_FRAMEWORK=OFF")
