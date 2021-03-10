############################################################################
# config-uwp.cmake
# Copyright (C) 2015  Belledonne Communications, Grenoble France
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

include(${CMAKE_CURRENT_LIST_DIR}/options-uwp.cmake)


set(DEFAULT_VALUE_CMAKE_LINKING_TYPE "-DENABLE_SHARED=YES" "-DENABLE_STATIC=NO")


# Global configuration
set(LINPHONE_BUILDER_CPPFLAGS "-D_ALLOW_KEYWORD_MACROS -D_CRT_SECURE_NO_WARNINGS -D_WINSOCK_DEPRECATED_NO_WARNINGS -D_WIN32_WINNT=0x0A00")


# Include builders
include(builders/CMakeLists.txt)

#decaf
lcb_builder_cmake_options(decaf "-DENABLE_STRICT=NO")

# linphone
lcb_builder_cmake_options(linphone "-DENABLE_CSHARP_WRAPPER=YES")
lcb_builder_cmake_options(linphone "-DENABLE_SWIFT_WRAPPER=NO")
lcb_builder_cmake_options(linphone "-DENABLE_JAZZY_DOC=NO")
lcb_builder_cmake_options(linphone "-DENABLE_RELATIVE_PREFIX=YES")
lcb_builder_cmake_options(linphone "-DENABLE_CONSOLE_UI=NO")
lcb_builder_cmake_options(linphone "-DENABLE_DAEMON=NO")
lcb_builder_cmake_options(linphone "-DENABLE_NOTIFY=NO")
lcb_builder_cmake_options(linphone "-DENABLE_TUTORIALS=NO")
lcb_builder_cmake_options(linphone "-DENABLE_UPNP=NO")

#libjpeg-turbo
lcb_builder_cmake_options(turbojpeg "-DWITH_SIMD=FALSE")
lcb_builder_cmake_options(turbojpeg "-DENABLE_STATIC=NO")
lcb_builder_cmake_options(turbojpeg "-DENABLE_SHARED=YES")
lcb_builder_cmake_options(turbojpeg "-DWITH_CRT_DLL=TRUE")

# ms2
lcb_builder_cmake_options(ms2 "-DENABLE_RELATIVE_PREFIX=YES")

# opus
lcb_builder_cmake_options(opus "-DOPUS_FIXED_POINT=YES")

lcb_builder_linking_type(mbedtls "-DUSE_STATIC_MBEDTLS_LIBRARY=NO" "-DUSE_SHARED_MBEDTLS_LIBRARY=YES")
add_definitions("-DWINDOWS_UNIVERSAL=1 -D_WIN32_WINNT=0x0A00")

# soci
lcb_builder_linking_type(soci "-DSOCI_STATIC=NO" "-DSOCI_SHARED=YES")
