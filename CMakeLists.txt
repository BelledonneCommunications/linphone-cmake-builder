################################################################################
#
#  Copyright (c) 2010-2021 Belledonne Communications SARL.
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

cmake_minimum_required(VERSION 3.1)

include(FeatureSummary)


set(LINPHONE_BUILDER_CONFIG_FILE "configs/config-desktop.cmake" CACHE STRING "Path to the linphone builder configuration file.")
set(LINPHONE_BUILDER_TOP_DIR "${PROJECT_SOURCE_DIR}" CACHE PATH "Top directory of the source tree.")
set(LINPHONE_BUILDER_WORK_DIR "${CMAKE_CURRENT_SOURCE_DIR}/WORK" CACHE PATH "Working directory for the build.")
set(LINPHONE_BUILDER_TARGET "linphone" CACHE STRING "Target to build.")
set(LINPHONE_BUILDER_PREBUILT_URL "" CACHE STRING "URL to download some prebuilt dependencies.")
option(LINPHONE_BUILDER_LATEST "Build latest versions (from git)." NO)
option(LINPHONE_BUILDER_CHECK_LASTEST "Check that the git revisions are the latest ones." NO)
set(LINPHONE_BUILDER_EXTERNAL_SOURCE_PATH "" CACHE PATH "External path to source code that is available.")
set(LINPHONE_BUILDER_ALTERNATE_EXTERNAL_SOURCE_PATH "" CACHE PATH "Alternate external path to source code that is available.")
set(LINPHONE_BUILDER_DUMMY_LIBRARIES "" CACHE STRING "Dummy libraries to be generated.")
option(LINPHONE_BUILDER_USE_SYSTEM_DEPENDENCIES "Use system dependencies." NO)
option(LINPHONE_BUILDER_GROUP_EXTERNAL_SOURCE_PATH_BUILDERS "Group external source path builders in a single external project." NO)
set(LINPHONE_BUILDER_EXTERNAL_BUILDERS_PATH "" CACHE PATH "Path to external builders.")
set(LINPHONE_BUILDER_SIGNING_IDENTITY "" CACHE STRING "Signing identity used for code signing on Mac OS X")
option(LINPHONE_BUILDER_ENABLE_RPM_PACKAGING "Enable RPM packaging." NO)
option(LINPHONE_BUILDER_WINDOWS_TOOLS_CHECK "Enable windows tools checking" NO)


# Include macros definition to be used by builders
include(cmake/CMakeLists.txt)


if(LINPHONE_BUILDER_CHECK_LATEST)

	include(builders/CMakeLists.txt)

else()

	# Include toolchain definition
	if(CMAKE_TOOLCHAIN_FILE)
		get_filename_component(CMAKE_TOOLCHAIN_FILE ${CMAKE_TOOLCHAIN_FILE} ABSOLUTE)
		message(STATUS "Using toolchain file '${CMAKE_TOOLCHAIN_FILE}'")
	endif()


	# Include project configuration according to the toolchain
	get_filename_component(LINPHONE_BUILDER_CONFIG_FILE ${LINPHONE_BUILDER_CONFIG_FILE} ABSOLUTE)
	message(STATUS "Using configuration file '${LINPHONE_BUILDER_CONFIG_FILE}'")
	include(${LINPHONE_BUILDER_CONFIG_FILE})


	# Apply build flags
	linphone_builder_apply_flags()

	# Get build tools and flags for autotools projects
	linphone_builder_get_autotools_configuration()

	# Add external projects
	linphone_builder_add_projects()
	linphone_builder_add_dummy_libraries_generation()
	linphone_builder_add_package_source_check_project()


	if(LINPHONE_BUILDER_ADDITIONAL_CONFIG_STEPS)
		include(${LINPHONE_BUILDER_ADDITIONAL_CONFIG_STEPS})
	endif()

	# Give a feature summary
	feature_summary(WHAT ENABLED_FEATURES DESCRIPTION "Enabled features:")
	feature_summary(WHAT DISABLED_FEATURES DESCRIPTION "Disabled features:")

endif()
