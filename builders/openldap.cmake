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

set(OPENLDAP_VERSION "2_4")
lcb_git_repository("https://gitlab.linphone.org/BC/public/external/openldap.git")
lcb_external_source_paths("externals/openldap" "external/openldap")
lcb_may_be_found_on_system(YES)
lcb_dependencies("mbedtls")

if(WIN32)
	lcb_extra_cflags("/sdl-")
endif()
