############################################################################
# options-desktop.cmake
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
lcb_add_dependent_option("Embedded OpenH264" "Embed the openh264 library instead of downloading it from Cisco." "${DEFAULT_VALUE_ENABLE_EMBEDDED_OPENH264}" "ENABLE_OPENH264" OFF)

# Define default values for the linphone builder options
set(DEFAULT_VALUE_ENABLE_ADVANCED_IM ON)
set(DEFAULT_VALUE_ENABLE_BV16 ON)
set(DEFAULT_VALUE_ENABLE_CXX_WRAPPER ON)
set(DEFAULT_VALUE_ENABLE_DB_STORAGE ON)
set(DEFAULT_VALUE_ENABLE_FFMPEG OFF)
set(DEFAULT_VALUE_ENABLE_G729B_CNG OFF)
set(DEFAULT_VALUE_ENABLE_GPL_THIRD_PARTIES OFF)
set(DEFAULT_VALUE_ENABLE_GSM ON)
set(DEFAULT_VALUE_ENABLE_GTK_UI OFF)
set(DEFAULT_VALUE_ENABLE_ILBC ON)
set(DEFAULT_VALUE_ENABLE_JPEG ON)
set(DEFAULT_VALUE_ENABLE_LIME_X3DH ON)
set(DEFAULT_VALUE_ENABLE_MBEDTLS ON)
set(DEFAULT_VALUE_ENABLE_MKV ON)
set(DEFAULT_VALUE_ENABLE_NLS OFF)
set(DEFAULT_VALUE_ENABLE_LDAP ON)
set(DEFAULT_VALUE_ENABLE_OPUS ON)
set(DEFAULT_VALUE_ENABLE_QT_GL OFF)
set(DEFAULT_VALUE_ENABLE_SPEEX ON)
set(DEFAULT_VALUE_ENABLE_SRTP ON)
set(DEFAULT_VALUE_ENABLE_TOOLS ON)
if(NOT LINPHONE_BUILDER_ENABLE_RPM_PACKAGING)
	set(DEFAULT_VALUE_ENABLE_UNIT_TESTS ON)
endif()
set(DEFAULT_VALUE_ENABLE_VCARD ON)
set(DEFAULT_VALUE_ENABLE_VIDEO ON)
set(DEFAULT_VALUE_ENABLE_VPX ON)
set(DEFAULT_VALUE_ENABLE_WASAPI ON)
set(DEFAULT_VALUE_ENABLE_WEBRTC_AEC ON)
set(DEFAULT_VALUE_ENABLE_ZRTP ON)
set(DEFAULT_VALUE_ENABLE_ASSETS ON)
set(DEFAULT_VALUE_ENABLE_MICROSOFT_STORE_APP OFF)

# dependent options
set(DEFAULT_VALUE_ENABLE_G729 ${DEFAULT_VALUE_ENABLE_GPL_THIRD_PARTIES})

# disable FlexiAPI for old CMAKE versions
set(CMAKE_MIN_VERSION "3.12")
if(${CMAKE_VERSION} VERSION_LESS ${CMAKE_MIN_VERSION})
	set(DEFAULT_VALUE_ENABLE_FLEXIAPI OFF)
else()
	set(DEFAULT_VALUE_ENABLE_FLEXIAPI ON)
endif()

if ((NOT DEFINED CMAKE_INSTALL_PREFIX) OR CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
	set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/linphone-sdk/desktop" CACHE PATH "Default linphone-sdk installation prefix" FORCE)
endif()
