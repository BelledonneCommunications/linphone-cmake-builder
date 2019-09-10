############################################################################
# soci.cmake
# Copyright (C) 2015-2018  Belledonne Communications, Grenoble France
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

lcb_git_repository("https://gitlab.linphone.org/BC/public/external/soci.git")
lcb_external_source_paths("externals/soci" "external/soci")
if(NOT APPLE)
  # Do not build sqlite3 on Apple systems (Mac OS X and iOS), it is provided by the system
	if (ENABLE_SQLITE)
		lcb_dependencies("sqlite3")
	endif()
endif()

lcb_cmake_options(
	"-DSOCI_TESTS=NO"
	"-DWITH_SQLITE3=YES"
)

if (ENABLE_SOCI_MYSQL)
	lcb_cmake_options("-DWITH_MYSQL=YES")
endif()
lcb_package_source(YES)
lcb_spec_file("soci.spec")
lcb_linking_type("-DSOCI_SHARED=YES" "-DSOCI_STATIC=NO")

