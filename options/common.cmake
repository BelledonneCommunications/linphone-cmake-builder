############################################################################
# common.cmake
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

# Common build options

lcb_add_option("Unit tests" "Enable unit tests support with BCUnit library." "${DEFAULT_VALUE_ENABLE_UNIT_TESTS}")
lcb_add_option("Debug logs" "Enable debug level logs in libinphone and mediastreamer2." NO)
lcb_add_option("Doc" "Enable documentation generation with Doxygen" NO)
lcb_add_option("Tools" "Enable tools binary compilation." "${DEFAULT_VALUE_ENABLE_TOOLS}")
lcb_add_option("unmaintained" "Allow inclusion of unmaintained code in the build." OFF)
lcb_add_option("Xml2" "Enable bc version of libxml2" ON)
lcb_add_option("Sqlite" "Enable bc version of sqlite3" ON)
lcb_add_option("Zlib" "Enable bc version of zlib" ON)
lcb_add_option("Soci mysql" "Enable mysql support of SOCI" OFF)

#if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" AND NOT IOS)
	lcb_add_option("Sanitizer" "Enable Clang sanitizer" NO)
#endif()
lcb_add_option("HW Sanitizer" "Enable Android HW sanitizer" NO)
lcb_add_option("OpenSSL Export" "Enable OpenSSL deployment" "${DEFAULT_VALUE_ENABLE_OPENSSL_EXPORT}")

#security options
lcb_add_option("SRTP" "SRTP media encryption support." "${DEFAULT_VALUE_ENABLE_SRTP}")
lcb_add_dependent_option("ZRTP" "ZRTP media encryption support." "${DEFAULT_VALUE_ENABLE_ZRTP}" "ENABLE_SRTP" OFF)
lcb_add_dependent_option("GOCLEAR" "ZRTP GoClear message support." "${DEFAULT_VALUE_ENABLE_GOCLEAR}" "ENABLE_ZRTP" ON)
