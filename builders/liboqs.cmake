############################################################################
# liboqs.cmake
# Copyright (C) 2021-2022  Belledonne Communications, Grenoble France
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

lcb_git_repository("https://github.com/open-quantum-safe/liboqs.git")
lcb_git_tag_latest("master")
lcb_git_tag("master")
lcb_external_source_paths("liboqs" "externals/liboqs" "external/liboqs")
lcb_groupable(YES)
lcb_sanitizable(YES)
lcb_package_source(YES)
lcb_spec_file("liboqs.spec")
lcb_cmake_options("-DOQS_DIST_BUILD=ON" "-DOQS_USE_OPENSSL=OFF" "-DOQS_BUILD_ONLY_LIB=ON")
lcb_cmake_options("-DBUILD_SHARED_LIBS=Off") # TODO: this force the generation of static lib while we should translate the ENABLE_SHARED/ENABLE_STATIC
# Note: -DOQS_MINIMAL_BUILD is what we want to use but a ; separated list cannot go through cmake-builder
# so use the -DOQS_ENABLE_<family> and turn them all Off except the one we want. Sike and Kyber are explicitely turned on but it is useless
lcb_cmake_options("-DOQS_ENABLE_SIG_SPHINCS=Off"
	"-DOQS_ENABLE_SIG_RAINBOW=Off"
	"-DOQS_ENABLE_SIG_FALCON=Off"
	"-DOQS_ENABLE_SIG_DILITHIUM=Off"
	"-DOQS_ENABLE_KEM_SABER=Off"
	"-DOQS_ENABLE_KEM_NTRUPRIME=Off"
	"-DOQS_ENABLE_KEM_NTRU=Off"
	"-DOQS_ENABLE_KEM_HQC=On"
	"-DOQS_ENABLE_KEM_CLASSIC_MCELIECE=Off"
	"-DOQS_ENABLE_SIG_PICNIC=Off"
	"-DOQS_ENABLE_KEM_FRODOKEM=Off"
	"-DOQS_ENABLE_KEM_BIKE=Off"
	"-DOQS_ENABLE_KEM_KYBER=On"
        )
