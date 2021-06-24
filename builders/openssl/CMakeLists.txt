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

cmake_minimum_required(VERSION 3.15)#FOLLOW_SYMLINK_CHAIN of file(COPY)
project(openssl)

include(GNUInstallDirs)

set(CMAKE_FIND_ROOT_PATH "/") #find_* of cmake prepend this path to all searchs. Let cmake to find in OPENSSL_ROOT_PATH and not in CMAKE_FIND_ROOT_PATH/OPENSSL_ROOT_PATH
find_package(OpenSSL REQUIRED)

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
