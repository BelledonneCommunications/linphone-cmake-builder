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
set(LINPHONE_BUILDER_CPPFLAGS "-D_ALLOW_KEYWORD_MACROS -D_CRT_SECURE_NO_WARNINGS -D_WINSOCK_DEPRECATED_NO_WARNINGS")


# Include builders
include(builders/CMakeLists.txt)
	
lcb_builder_cmake_options(bctoolbox "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(bcunit "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(belcard "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(bellesip "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(belr "-DENABLE_MICROSOFT_STORE_APP=YES")	
lcb_builder_cmake_options(bv16 "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(bzrtp "-DENABLE_MICROSOFT_STORE_APP=YES")	
lcb_builder_cmake_options(decaf "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(gsm "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(lime "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(linphone "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(mbedtls "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(ms2 "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(ms2plugins "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(msaaudio "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(msdia "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(msamr "-DENABLE_MICROSOFT_STORE_APP=YES")	
lcb_builder_cmake_options(mscodec2 "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(msopenh264 "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(mssilk "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(mswasapi "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(mswebrtc "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(mswinrtvid "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(msx264 "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(openh264 "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(opus "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(ortp "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(soci "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(speex "-DENABLE_MICROSOFT_STORE_APP=YES")	
lcb_builder_cmake_options(sqlite3 "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(srtp "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(turbojpeg "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(vpx "-DENABLE_MICROSOFT_STORE_APP=YES")	
lcb_builder_cmake_options(xerces "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(xml2 "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(zlib "-DENABLE_MICROSOFT_STORE_APP=YES")
lcb_builder_cmake_options(zxing "-DENABLE_MICROSOFT_STORE_APP=YES")

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
lcb_builder_cmake_options(linphone "-DENABLE_SOCI=NO")

# ms2
lcb_builder_cmake_options(ms2 "-DENABLE_RELATIVE_PREFIX=YES")

# opus
lcb_builder_cmake_options(opus "-DENABLE_ASM=NO")
lcb_builder_cmake_options(opus "-DENABLE_FIXED_POINT=YES")
lcb_builder_linking_type(opus "-DENABLE_SHARED=NO" "-DENABLE_STATIC=YES")
