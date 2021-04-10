############################################################################
# Copyright (c) 2010-2021 Belledonne Communications SARL.
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

set(OPENLDAP_VERSION "2_4")
#lcb_git_repository("https://git.openldap.org/openldap/openldap")
#lcb_git_tag("OPENLDAP_REL_ENG_${OPENLDAP_VERSION}")
lcb_external_source_paths("externals/openldap" "external/openldap")

lcb_may_be_found_on_system(YES)
lcb_ignore_warnings(YES)

lcb_build_method("autotools")
lcb_do_not_use_cmake_flags(YES)
#lcb_config_h_file("vpx_config.h")
lcb_dependencies("cyrussasl")
lcb_configure_options("--enable-shared" "--disable-backends" "--disable-slapd")

#by default, Target=HOST
if(WIN32)
#target=pc-windows	
elseif(APPLE)
# target=pc-macos
else()
# target=pc-linux
endif()
#lcb_configure_options("--CPPFLAGS=-I${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}")
if(WIN32)
else()
lcb_configure_env("CPPFLAGS=-I${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR} LDFLAGS=-L${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
lcb_configure_options(
	"--prefix=${CMAKE_INSTALL_PREFIX}"
	"--libdir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
	"--includedir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/openldap"
)
endif()
