############################################################################
# CheckBuildTools.txt
# Copyright (C) 2015-2021  Belledonne Communications, Grenoble France
#
############################################################################
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

find_package(PythonInterp 3 REQUIRED)

if(CMAKE_SYSTEM_NAME STREQUAL "WindowsPhone" OR CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	set(WINDOWS_UNIVERSAL TRUE)
else()
	set(WINDOWS_UNIVERSAL FALSE)
endif()
if(WIN32)
	#Internal variable where to search MSYS2 programs
	set(_DEFAULT_MSYS2_BIN_PATH "C:/msys64/usr/bin")
endif()
	

if(WIN32)
	find_program(MSYS2_PROGRAM
		NAMES msys2_shell.cmd
		HINTS "C:/msys64/"
	)
	if(NOT MSYS2_PROGRAM)
		message(FATAL_ERROR "Could not find MSYS2 for MinGW! Make sure to have msys2_shell.cmd in your PATH. The default folder is 'C:/msys64/'")
	endif()
endif()

if(MSVC AND NOT WINDOWS_UNIVERSAL)
	find_program(SH_PROGRAM
		NAMES sh.exe
		HINTS ${_DEFAULT_MSYS2_BIN_PATH}
	)
	if(NOT SH_PROGRAM)
		message(FATAL_ERROR "Could not find sh for MinGW! Make sure to have sh.exe in your PATH. The default folder is : '${_DEFAULT_MSYS2_BIN_PATH}'")
	endif()
endif()

set(CMAKE_PROGRAM_PATH "${CMAKE_BINARY_DIR}/programs")
string(REGEX REPLACE "^([a-zA-Z]):(.*)$" "/\\1\\2" AUTOTOOLS_PROGRAM_PATH "${CMAKE_PROGRAM_PATH}")
string(REPLACE "\\" "/" AUTOTOOLS_PROGRAM_PATH ${AUTOTOOLS_PROGRAM_PATH})
file(MAKE_DIRECTORY ${CMAKE_PROGRAM_PATH})
file(COPY "${CMAKE_CURRENT_LIST_DIR}/../scripts/gas-preprocessor.pl" DESTINATION "${CMAKE_PROGRAM_PATH}")
if(WIN32)
	message(STATUS "Installing windows tools : perl, yasm, gawk, bzip2, nasm, sed, patch")
	execute_process(
		COMMAND "${MSYS2_PROGRAM}" "-msys2" "-here" "-full-path" "-no-start" "-defterm" "-shell" "sh" "-l" "-c"
		"pacman -Sy perl yasm gawk bzip2 nasm sed patch --noconfirm  --needed"
	)
endif()

if(WIN32)
	#Should be already installed from MSYS2
	find_program(PATCH_PROGRAM
		NAMES patch patch.exe
		HINTS ${_DEFAULT_MSYS2_BIN_PATH}
		CMAKE_FIND_ROOT_PATH_BOTH
	)
else()
	find_program(PATCH_PROGRAM
		NAMES patch patch.exe
		CMAKE_FIND_ROOT_PATH_BOTH
	)
endif()

if(NOT PATCH_PROGRAM)
		message(FATAL_ERROR "Could not find the patch program.")
endif()


if(WIN32)
	#Should be already installed from MSYS2
	find_program(SED_PROGRAM
		NAMES  sed sed.exe
		HINTS ${_DEFAULT_MSYS2_BIN_PATH}
		CMAKE_FIND_ROOT_PATH_BOTH
	)
else()
	find_program(SED_PROGRAM
		NAMES  sed sed.exe
		CMAKE_FIND_ROOT_PATH_BOTH
	)
endif()

if(NOT SED_PROGRAM)
		message(FATAL_ERROR "Could not find the sed program.")
endif()


if(WIN32)
	find_program(PKG_CONFIG_PROGRAM
		NAMES pkg-config pkg-config.exe
		HINTS ${_DEFAULT_MSYS2_BIN_PATH}
		CMAKE_FIND_ROOT_PATH_BOTH
	)
else()
	find_program(PKG_CONFIG_PROGRAM
		NAMES pkg-config pkg-config.exe
		CMAKE_FIND_ROOT_PATH_BOTH
	)
endif()

if(NOT WINDOWS_UNIVERSAL)
	if(NOT PKG_CONFIG_PROGRAM)
		if(WIN32)
			message(STATUS "Installing pkg-config, gettext, glib2 to MSYS2")
			execute_process(
				COMMAND "${MSYS2_PROGRAM}" "-msys2" "-here" "-full-path" "-no-start" "-defterm" "-shell" "sh" "-l" "-c"
				"pacman -Sy pkg-config gettext glib2 --noconfirm  --needed"
			)
			find_program(PKG_CONFIG_PROGRAM
				NAMES pkg-config pkg-config.exe
				HINTS ${_DEFAULT_MSYS2_BIN_PATH}
			)
		endif()
	endif()
	if(NOT PKG_CONFIG_PROGRAM AND NOT MSVC)
		message(FATAL_ERROR "Could not find the pkg-config program.")
	endif()
	if(ENABLE_NLS)
		find_program(INTLTOOLIZE_PROGRAM
			NAMES intltoolize
			HINTS ${_DEFAULT_MSYS2_BIN_PATH}
		)
		if(NOT INTLTOOLIZE_PROGRAM)
			if(WIN32)
				message(STATUS "Installing intltoolize to MSYS2")
				execute_process(
					COMMAND "${MSYS2_PROGRAM}" "-msys2" "-here" "-full-path" "-no-start" "-defterm" "-shell" "sh" "-l" "-c"
					"pacman -Sy intltool --noconfirm --needed"
				)
			endif()
			find_program(INTLTOOLIZE_PROGRAM
				NAMES intltoolize
				HINTS ${_DEFAULT_MSYS2_BIN_PATH}
			)
		endif()

		if(NOT INTLTOOLIZE_PROGRAM AND NOT MSVC)
			message(FATAL_ERROR "Could not find the intltoolize program.")
		endif()
	endif()
endif()

if(MSVC AND NOT WINDOWS_UNIVERSAL)
	# Install headers needed by MSVC
	file(GLOB MSVC_HEADER_FILES "${CMAKE_CURRENT_SOURCE_DIR}/cmake/MSVC/*.h")
	file(MAKE_DIRECTORY "${CMAKE_INSTALL_PREFIX}/include/MSVC")
	file(INSTALL ${MSVC_HEADER_FILES} DESTINATION "${CMAKE_INSTALL_PREFIX}/include/MSVC")
endif()
