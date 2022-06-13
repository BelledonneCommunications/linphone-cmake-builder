############################################################################
# postinstall.cmake
# Copyright (C) 2014  Belledonne Communications, Grenoble France
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

if(WIN32)
	set(FFMPEG_ARCH ${CMAKE_CXX_COMPILER_ARCHITECTURE_ID})
	string(TOUPPER ${FFMPEG_ARCH} FFMPEG_ARCH)
	message(STATUS "Linking FFMPEG to ${FFMPEG_ARCH} arch")

	file(GLOB AVCODEC_DEF "${INSTALL_PREFIX}/lib/avcodec-*.def")
	if(AVCODEC_DEF)
		execute_process(COMMAND "lib" "/def:${AVCODEC_DEF}" "/out:${INSTALL_PREFIX}/lib/avcodec.lib" "/machine:${FFMPEG_ARCH}")
	endif()
	file(GLOB AVUTIL_DEF "${INSTALL_PREFIX}/lib/avutil-*.def")
	if(AVUTIL_DEF)
		execute_process(COMMAND "lib" "/def:${AVUTIL_DEF}" "/out:${INSTALL_PREFIX}/lib/avutil.lib" "/machine:${FFMPEG_ARCH}")
	endif()
	file(GLOB SWRESAMPLE_DEF "${INSTALL_PREFIX}/lib/swresample-*.def")
	if(SWRESAMPLE_DEF)
		execute_process(COMMAND "lib" "/def:${SWRESAMPLE_DEF}" "/out:${INSTALL_PREFIX}/lib/swresample.lib" "/machine:${FFMPEG_ARCH}")
	endif()
	file(GLOB SWSCALE_DEF "${INSTALL_PREFIX}/lib/swscale-*.def")
	if(SWSCALE_DEF)
		execute_process(COMMAND "lib" "/def:${SWSCALE_DEF}" "/out:${INSTALL_PREFIX}/lib/swscale.lib" "/machine:${FFMPEG_ARCH}")
	endif()
endif()

file(GLOB AVUTIL_DYLIB RELATIVE "${INSTALL_PREFIX}/lib" "${INSTALL_PREFIX}/lib/libavutil.*.*.*.dylib")
file(GLOB AVCODEC_DYLIB RELATIVE "${INSTALL_PREFIX}/lib" "${INSTALL_PREFIX}/lib/libavcodec.*.*.*.dylib")
file(GLOB SWRESAMPLE_DYLIB RELATIVE "${INSTALL_PREFIX}/lib" "${INSTALL_PREFIX}/lib/libswresample.*.*.*.dylib")
file(GLOB SWSCALE_DYLIB RELATIVE "${INSTALL_PREFIX}/lib" "${INSTALL_PREFIX}/lib/libswscale.*.*.*.dylib")

if(APPLE AND NOT IOS)
	execute_process(COMMAND install_name_tool -id @rpath/${AVUTIL_DYLIB} ${INSTALL_PREFIX}/lib/${AVUTIL_DYLIB})
	execute_process(COMMAND install_name_tool
		-id @rpath/${AVCODEC_DYLIB}
		-change ${INSTALL_PREFIX}/lib/${AVUTIL_DYLIB} @rpath/${AVUTIL_DYLIB}
		${INSTALL_PREFIX}/lib/${AVCODEC_DYLIB}
	)
	execute_process(COMMAND install_name_tool
		-id @rpath/${SWRESAMPLE_DYLIB}
		-change ${INSTALL_PREFIX}/lib/${AVUTIL_DYLIB} @rpath/${AVUTIL_DYLIB}
		${INSTALL_PREFIX}/lib/${SWRESAMPLE_DYLIB}
	)
	execute_process(COMMAND install_name_tool
		-id @rpath/${SWSCALE_DYLIB}
		-change ${INSTALL_PREFIX}/lib/${AVUTIL_DYLIB} @rpath/${AVUTIL_DYLIB}
		${INSTALL_PREFIX}/lib/${SWSCALE_DYLIB}
	)
endif()
