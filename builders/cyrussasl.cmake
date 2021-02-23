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

set(CYRUSSASL_VERSION "2.1")
lcb_git_repository("https://github.com/cyrusimap/cyrus-sasl")
lcb_git_tag("cyrus-sasl-${CYRUSSASL_VERSION}")
lcb_external_source_paths("externals/cyrus-sasl" "external/cyrus-sasl")

lcb_may_be_found_on_system(YES)
lcb_ignore_warnings(YES)

lcb_build_method("autotools")
lcb_use_autogen(YES)
lcb_do_not_use_cmake_flags(YES)
#lcb_config_h_file("vpx_config.h")
#lcb_configure_options("--enable-shared" "--disable-backends" "--disable-slapd")
lcb_configure_options("--disable-sample")
#lcb_configure_command_source(${CMAKE_CURRENT_SOURCE_DIR}/builders/cyrussasl/sasl_configure.sh.cmake)
lcb_configure_options(
	"--prefix=${CMAKE_INSTALL_PREFIX}"
	"--libdir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
	"--includedir=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}"
)

