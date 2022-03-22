############################################################################
# Copyright (c) 2021 Belledonne Communications SARL.
#
# This file is part of cmake-builder.
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

cmake_minimum_required(VERSION 3.0)
project(openssl)
include(GNUInstallDirs)
if(APPLE)
	set(CMAKE_FIND_ROOT_PATH "/") #find_* of cmake prepend this path to all searchs. Let cmake to find in OPENSSL_ROOT_PATH and not in CMAKE_FIND_ROOT_PATH/OPENSSL_ROOT_PATH
	find_package(OpenSSL REQUIRED)
elseif(WIN32)
#find_package retrieve from MSVC. Do not use it. The goal is to deploy MINGW dll.
#find_library and find_file cannot work because of versionning.
	find_program(MSYS2_PROGRAM
		NAMES msys2_shell.cmd
		HINTS "C:/msys64/"
	)
	get_filename_component(MSYS2_PATH ${MSYS2_PROGRAM} PATH )
	if( CMAKE_SIZEOF_VOID_P EQUAL 8)
		set(MSYS2_MINGW "mingw64")
		set(SEARCH_PATH "${MSYS2_PATH}/${MSYS2_MINGW}/bin")
	else()
		set(MSYS2_MINGW "mingw32")
		set(SEARCH_PATH "${MSYS2_PATH}/${MSYS2_MINGW}/bin")
	endif()
	message(STATUS "Search libs in ${SEARCH_PATH}")
	file(GLOB SSL_FILES LIST_DIRECTORIES false "${SEARCH_PATH}/libssl*.dll")
	file(GLOB CRYPTO_FILES LIST_DIRECTORIES false "${SEARCH_PATH}/libcrypto*.dll")
	list(LENGTH SSL_FILES SSL_FILES_LENGTH)
	list(LENGTH CRYPTO_FILES CRYPTO_FILES_LENGTH)
	if( ${SSL_FILES_LENGTH} EQUAL 0 OR ${CRYPTO_FILES_LENGTH} EQUAL 0)
		message(FATAL_ERROR "OpenSSL for MinGW : libssl and libcrypto cannot be found.")
	else()
		set(OPENSSL_LIBRARIES ${SSL_FILES} ${CRYPTO_FILES})
	endif()
else()
	find_package(OpenSSL REQUIRED)
endif()

if(ENABLE_OPENSSL_EXPORT)
	set(INSTALL_FOLDER ${CMAKE_INSTALL_LIBDIR})

	if(WIN32)
		set(INSTALL_FOLDER ${CMAKE_INSTALL_BINDIR})
	endif()
	foreach(OPENSSL_LIB IN LISTS OPENSSL_LIBRARIES)	# copy the library on install step : this will replace a symlink with the real file
		install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${OPENSSL_LIB} \"${CMAKE_INSTALL_PREFIX}/${INSTALL_FOLDER}/\")")
	endforeach()
	install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -E echo \"OpenSSL libraries have been deployed.\")")
else()
	install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -E echo \"OpenSSL libraries have not been deployed as requested.\")")
endif()
