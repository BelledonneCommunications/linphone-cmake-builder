############################################################################
# ms2.cmake
# Copyright (C) 2014-2018  Belledonne Communications, Grenoble France
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

lcb_git_repository("https://gitlab.linphone.org/BC/public/mediastreamer2.git")
lcb_git_tag_latest("master")
lcb_git_tag("2.14.0")
lcb_external_source_paths("mediastreamer2")
lcb_groupable(YES)
lcb_sanitizable(YES)
lcb_package_source(YES)
lcb_spec_file("mediastreamer2.spec")
lcb_rpmbuild_name("mediastreamer")

lcb_dependencies("ortp" "bctoolbox")
if(ANDROID)
	if(CMAKE_ANDROID_NDK_VERSION VERSION_LESS 19)
		lcb_dependencies("androidcpufeatures" "androidsupport")
	else()
		lcb_dependencies("androidcpufeatures")
	endif()
endif()

lcb_cmake_options(
	"-DENABLE_NON_FREE_CODECS=${ENABLE_NON_FREE_CODECS}"
	"-DENABLE_UNIT_TESTS=${ENABLE_UNIT_TESTS}"
	"-DENABLE_DEBUG_LOGS=${ENABLE_DEBUG_LOGS}"
	"-DENABLE_PCAP=${ENABLE_PCAP}"
	"-DENABLE_DOC=${ENABLE_DOC}"
	"-DENABLE_TOOLS=${ENABLE_TOOLS}"
)

lcb_cmake_options(
	"-DENABLE_G726=${ENABLE_G726}"
	"-DENABLE_GSM=${ENABLE_GSM}"
	"-DENABLE_OPUS=${ENABLE_OPUS}"
	"-DENABLE_SPEEX_CODEC=${ENABLE_SPEEX}"
	"-DENABLE_BV16=${ENABLE_BV16}"
	"-DENABLE_G729=${ENABLE_G729}"
	"-DENABLE_G729B_CNG=${ENABLE_G729B_CNG}"
	"-DENABLE_JPEG=${ENABLE_JPEG}"
	"-DENABLE_QRCODE=${ENABLE_QRCODE}"
)
if(ENABLE_GSM)
	lcb_dependencies("gsm")
endif()
if(ENABLE_OPUS)
	lcb_dependencies("opus")
endif()
if(ENABLE_SPEEX)
	lcb_dependencies("speex")
endif()
if(ENABLE_BV16)
	lcb_dependencies("bv16")
endif()
if(ENABLE_G729 OR ENABLE_G729B_CNG)
	lcb_dependencies("bcg729")
endif()
if(ENABLE_JPEG)
	lcb_dependencies("turbojpeg")
endif()
if(ENABLE_QRCODE)
	lcb_dependencies("zxing")
endif()

lcb_cmake_options("-DENABLE_VIDEO=${ENABLE_VIDEO}")
if(ENABLE_VIDEO)
	lcb_cmake_options(
		"-DENABLE_FFMPEG=${ENABLE_FFMPEG}"
		"-DENABLE_VPX=${ENABLE_VPX}"
	)
	if(ENABLE_FFMPEG)
		if(ANDROID)
			lcb_dependencies("ffmpegandroid")
		else()
			lcb_dependencies("ffmpeg")
		endif()
	endif()
	if(ENABLE_VPX)
		lcb_dependencies("vpx")
	endif()
	lcb_cmake_options("-DENABLE_V4L=${ENABLE_V4L}")
endif()
if(ENABLE_GTK_UI)
	lcb_cmake_options("-DENABLE_GL=NO")
endif()

lcb_cmake_options("-DENABLE_MKV=${ENABLE_MKV}")
if(ENABLE_MKV)
	lcb_dependencies("matroska2")
endif()

lcb_cmake_options(
	"-DENABLE_SRTP=${ENABLE_SRTP}"
	"-DENABLE_ZRTP=${ENABLE_ZRTP}"
)
if(ENABLE_SRTP)
	lcb_dependencies("srtp")
endif()
if(ENABLE_ZRTP)
	lcb_dependencies("bzrtp")
endif()

