############################################################################
# matroska2.cmake
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

lcb_git_repository("git://git.linphone.org/libmatroska-c.git")
lcb_git_tag_latest("bc")
lcb_git_tag("c3fc2746f18bafefe3010669d8d2855240565c86")
lcb_external_source_paths("bcmatroska2")
lcb_package_source(YES)
lcb_spec_file("matroska2.spec")

lcb_dependencies("bctoolbox")

lcb_linking_type("-DENABLE_STATIC=YES" "-DENABLE_SHARED=NO")
