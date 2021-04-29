############################################################################
# options-ios.cmake
# Copyright (C) 2010-2018 Belledonne Communications, Grenoble France
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

# Define default values for the linphone builder options
set(DEFAULT_VALUE_ENABLE_ADVANCED_IM ON)
set(DEFAULT_VALUE_ENABLE_DB_STORAGE ON)
set(DEFAULT_VALUE_ENABLE_FFMPEG OFF)
set(DEFAULT_VALUE_ENABLE_FLEXIAPI ON)
set(DEFAULT_VALUE_ENABLE_G729B_CNG OFF)
set(DEFAULT_VALUE_ENABLE_GPL_THIRD_PARTIES OFF)
set(DEFAULT_VALUE_ENABLE_GSM ON)
set(DEFAULT_VALUE_ENABLE_ILBC ON)
set(DEFAULT_VALUE_ENABLE_ISAC ON)
set(DEFAULT_VALUE_ENABLE_JPEG ON)
set(DEFAULT_VALUE_ENABLE_MBEDTLS ON)
set(DEFAULT_VALUE_ENABLE_MKV ON)
set(DEFAULT_VALUE_ENABLE_OPUS ON)
set(DEFAULT_VALUE_ENABLE_QRCODE ON)
set(DEFAULT_VALUE_ENABLE_SILK OFF)
set(DEFAULT_VALUE_ENABLE_SPEEX ON)
set(DEFAULT_VALUE_ENABLE_LIME_X3DH ON)
set(DEFAULT_VALUE_ENABLE_SRTP ON)
set(DEFAULT_VALUE_ENABLE_UNIT_TESTS OFF)
set(DEFAULT_VALUE_ENABLE_VCARD ON)
set(DEFAULT_VALUE_ENABLE_VIDEO ON)
set(DEFAULT_VALUE_ENABLE_VPX ON)
set(DEFAULT_VALUE_ENABLE_ZRTP ON)
set(DEFAULT_VALUE_ENABLE_TOOLS OFF)
set(DEFAULT_VALUE_ENABLE_UPDATE_CHECK ON)
set(DEFAULT_VALUE_ENABLE_ASSETS ON)
set(DEFAULT_VALUE_ENABLE_SWIFT_WRAPPER ON)
set(DEFAULT_VALUE_ENABLE_SWIFT_WRAPPER_COMPILATION OFF)

# Define default values for the belle-sip builder options
set(DEFAULT_VALUE_ENABLE_DNS_SERVICE ON)

# dependent options
set(DEFAULT_VALUE_ENABLE_G729 ${DEFAULT_VALUE_ENABLE_GPL_THIRD_PARTIES})

if ((NOT DEFINED CMAKE_INSTALL_PREFIX) OR CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
	set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/linphone-sdk" CACHE PATH "Default linphone-sdk installation prefix" FORCE)
endif()
