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
	if(EXISTS ${BINARY_DIR}/libraries/libldap/.libs/libldap.la.def)
		execute_process(COMMAND "lib" "/def:${BINARY_DIR}/libraries/libldap/.libs/libldap.la.def" "/name:ldap.dll" "/out:${INSTALL_PREFIX}/lib/ldap.lib" "/machine:X86")
	endif()
	if(EXISTS ${INSTALL_PREFIX}/bin/libldap.dll)
		execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "remove" "-f" "${INSTALL_PREFIX}/bin/ldap.dll")
		execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "rename" "${INSTALL_PREFIX}/bin/libldap.dll" "${INSTALL_PREFIX}/bin/ldap.dll")
	endif()
	if(EXISTS ${BINARY_DIR}/libraries/liblber/.libs/liblber.la.def)
		execute_process(COMMAND "lib" "/def:${BINARY_DIR}/libraries/liblber/.libs/liblber.la.def" "/name:lber.dll" "/out:${INSTALL_PREFIX}/lib/lber.lib" "/machine:X86")
	endif()
	if(EXISTS ${INSTALL_PREFIX}/bin/liblber.dll)
		execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "remove" "-f" "${INSTALL_PREFIX}/bin/lber.dll")
		execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "rename" "${INSTALL_PREFIX}/bin/liblber.dll" "${INSTALL_PREFIX}/bin/lber.dll")
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
