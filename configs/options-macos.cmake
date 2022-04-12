############################################################################
# Copyright (c) 2021 Belledonne Communications SARL.
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
include (${CMAKE_CURRENT_LIST_DIR}/options-desktop.cmake)

set(DEFAULT_VALUE_ENABLE_FAT_BINARY OFF)
set(DEFAULT_VALUE_ENABLE_SWIFT_WRAPPER ON)
set(DEFAULT_VALUE_ENABLE_SWIFT_WRAPPER_COMPILATION OFF)

lcb_add_dependent_option("Fat binary" "Enable fat binary generation using lipo." "${DEFAULT_VALUE_ENABLE_FAT_BINARY}" "ENABLE_FAT_BINARY" OFF)