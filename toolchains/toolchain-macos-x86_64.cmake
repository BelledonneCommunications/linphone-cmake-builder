################################################################################
#
#  Copyright (c) 2021 Belledonne Communications SARL.
# 
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
# 
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
# 
#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see <http://www.gnu.org/licenses/>.
#
################################################################################

set(CMAKE_SYSTEM_PROCESSOR "x86_64")
set(LINPHONE_BUILDER_OSX_ARCHITECTURES "x86_64")
set(COMPILER_PREFIX "x86_64-apple-darwin")
set(CLANG_TARGET "x86_64-apple-darwin")
if(LINPHONESDK_OPENSSL_ROOT_DIR_X86_64)
	set(OPENSSL_ROOT_DIR ${LINPHONESDK_OPENSSL_ROOT_DIR_X86_64})
elseif(DEFINED ENV{LINPHONESDK_OPENSSL_ROOT_DIR_X86_64})
	set(OPENSSL_ROOT_DIR $ENV{LINPHONESDK_OPENSSL_ROOT_DIR_X86_64})
endif()
include("${CMAKE_CURRENT_LIST_DIR}/macos/toolchain-macos.cmake")


