############################################################################
# linphone.cmake
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

# Linphone build options

lcb_add_option("GTK UI" "Enable the GTK user interface of Linphone." "${DEFAULT_VALUE_ENABLE_GTK_UI}")
lcb_add_option("CXX wrapper" "Build the C++ wrapper for Liblinphone." "${DEFAULT_VALUE_ENABLE_CXX_WRAPPER}")
lcb_add_option("CSharp wrapper" "Build the C# wrapper from Liblinphone." "${DEFAULT_VALUE_ENABLE_CSHARP_WRAPPER}")
lcb_add_option("FlexiAPI" "Enable the FlexiAPI support in Liblinphone." "${DEFAULT_VALUE_ENABLE_FLEXIAPI}")
lcb_add_option("Swift wrapper" "Build the Swift wrapper sources from Liblinphone." "${DEFAULT_VALUE_ENABLE_SWIFT_WRAPPER}")
lcb_add_option("Swift wrapper compilation" "Compile and package the swift wrapper framework. Require at least cmake 3.16.3." "${DEFAULT_VALUE_ENABLE_SWIFT_WRAPPER_COMPILATION}")
lcb_add_option("Jazzy doc" "Build the Swift doc from Liblinphone." "${DEFAULT_VALUE_ENABLE_JAZZY_DOC}")
lcb_add_option("Java wrapper" "Build the Java wrapper from Liblinphone." "${DEFAULT_VALUE_ENABLE_JAVA_WRAPPER}")
lcb_add_option("LIME" "Enable Linphone IM Encryption support in  Liblinphone." "${DEFAULT_VALUE_ENABLE_LIME}")
lcb_add_option("LIME X3DH" "Enable Linphone IM Encryption version 2 support in  Liblinphone." "${DEFAULT_VALUE_ENABLE_LIME_X3DH}")
lcb_add_option("LDAP" "Enable LDAP Liblinphone." "${DEFAULT_VALUE_ENABLE_LDAP}")
lcb_add_option("NLS" "Enable internationalization of Linphone and Liblinphone." "${DEFAULT_VALUE_ENABLE_NLS}")
lcb_add_option("Update Check" "Enable update check." "${DEFAULT_VALUE_ENABLE_UPDATE_CHECK}")
lcb_add_option("VCARD" "Enable vCard 4 support in Linphone and Liblinphone." "${DEFAULT_VALUE_ENABLE_VCARD}")
lcb_add_option("Assets" "Enable packaging of assets (ringtones) when building the SDK." "${DEFAULT_VALUE_ENABLE_ASSETS}")
lcb_add_option("Advanced IM" "Enable advanced instant messaging such as group chat." "${DEFAULT_VALUE_ENABLE_ADVANCED_IM}")
lcb_add_option("DB Storage" "Enable the database storage." "${DEFAULT_VALUE_ENABLE_DB_STORAGE}")

if(UNIX AND NOT IOS)
	lcb_add_option("Relative prefix" "liblinphone and mediastreamer will look for their respective ressources relatively to their location." OFF)
endif()
