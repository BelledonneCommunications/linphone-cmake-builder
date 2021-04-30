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

if(WIN32)
	set(LDAP_ARCH ${CMAKE_CXX_COMPILER_ARCHITECTURE_ID})
	string(TOUPPER ${LDAP_ARCH} LDAP_ARCH)
	message(STATUS "Linking OpenLDAP to ${LDAP_ARCH} arch")
	if(EXISTS ${BINARY_DIR}/libraries/libldap/.libs/libldap.la.def)
		execute_process(COMMAND "lib" "/def:${BINARY_DIR}/libraries/libldap/.libs/libldap.la.def" "/name:libldap.dll" "/out:${INSTALL_PREFIX}/lib/libldap.lib" "/machine:${LDAP_ARCH}")
	endif()
	if(EXISTS ${BINARY_DIR}/libraries/liblber/.libs/liblber.la.def)
		execute_process(COMMAND "lib" "/def:${BINARY_DIR}/libraries/liblber/.libs/liblber.la.def" "/name:liblber.dll" "/out:${INSTALL_PREFIX}/lib/liblber.lib" "/machine:${LDAP_ARCH}")
	endif()
endif()


file(GLOB OPENLDAP_LDAP_LIBS "${INSTALL_PREFIX}/lib/libldap*.dylib")
file(GLOB OPENLDAP_LBER_LIBS "${INSTALL_PREFIX}/lib/liblber*.dylib")

foreach(OPENLDAP_LIB IN LISTS OPENLDAP_LDAP_LIBS)
	get_filename_component(OPENLDAP_LIB_ID ${OPENLDAP_LIB} NAME )
	execute_process(COMMAND install_name_tool -id "@rpath/${OPENLDAP_LIB_ID}" ${OPENLDAP_LIB})
	foreach(OPENLDAP_LIB_A IN LISTS OPENLDAP_LBER_LIBS)
	get_filename_component(OPENLDAP_LIB_ID_A ${OPENLDAP_LIB_A} NAME )
		execute_process(COMMAND install_name_tool -change ${OPENLDAP_LIB_A} "@rpath/${OPENLDAP_LIB_ID_A}" ${OPENLDAP_LIB})
	endforeach()
endforeach()

foreach(OPENLDAP_LIB IN LISTS OPENLDAP_LBER_LIBS)
	get_filename_component(OPENLDAP_LIB_ID ${OPENLDAP_LIB} NAME )
	execute_process(COMMAND install_name_tool -id "@rpath/${OPENLDAP_LIB_ID}" ${OPENLDAP_LIB})
	foreach(OPENLDAP_LIB_A IN LISTS OPENLDAP_LDAP_LIBS)
	get_filename_component(OPENLDAP_LIB_ID_A ${OPENLDAP_LIB_A} NAME )
		execute_process(COMMAND install_name_tool -change ${OPENLDAP_LIB_A} "@rpath/${OPENLDAP_LIB_ID_A}" ${OPENLDAP_LIB})
	endforeach()
endforeach()
