################################################################################
#
#  Copyright (c) 2021 Belledonne Communications SARL.
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

set(CMAKE_SYSTEM_PROCESSOR "arm64")
set(CMAKE_OSX_ARCHITECTURES "arm64")
set(LINPHONE_BUILDER_OSX_ARCHITECTURES "arm64")
set(COMPILER_PREFIX "arm64-apple-macos")
set(CLANG_TARGET "arm64-apple-macos")
if(LINPHONESDK_OPENSSL_ROOT_DIR_ARM64)
	set(OPENSSL_ROOT_DIR ${LINPHONESDK_OPENSSL_ROOT_DIR_ARM64})
elseif(DEFINED ENV{LINPHONESDK_OPENSSL_ROOT_DIR_ARM64})
	set(OPENSSL_ROOT_DIR $ENV{LINPHONESDK_OPENSSL_ROOT_DIR_ARM64})
endif()
include("${CMAKE_CURRENT_LIST_DIR}/macos/toolchain-macos.cmake")

#For armv7
#list(APPEND CMAKE_CXX_COMPILE_FEATURES
#	cxx_std_11 # Compiler mode is aware of C++ 11.
#	#MSVC 1900 cxx_alignas # Alignment control alignas, as defined in N2341.
#	#MSVC 1900 cxx_alignof # Alignment control alignof, as defined in N2341.
#	#MSVC 1900 cxx_attributes # Generic attributes, as defined in N2761.
#	cxx_auto_type # Automatic type deduction, as defined in N1984.
#	#MSVC 1900 cxx_constexpr # Constant expressions, as defined in N2235.
#	cxx_decltype # Decltype, as defined in N2343.
#	cxx_default_function_template_args # Default template arguments for function templates, as defined in DR226
#	cxx_defaulted_functions # Defaulted functions, as defined in N2346.
#	#MSVC 1900 cxx_defaulted_move_initializers # Defaulted move initializers, as defined in N3053.
#	cxx_delegating_constructors # Delegating constructors, as defined in N1986.
#	#MSVC 1900 cxx_deleted_functions # Deleted functions, as defined in N2346.
#	cxx_enum_forward_declarations # Enum forward declarations, as defined in N2764.
#	cxx_explicit_conversions # Explicit conversion operators, as defined in N2437.
#	cxx_extended_friend_declarations # Extended friend declarations, as defined in N1791.
#	cxx_extern_templates # Extern templates, as defined in N1987.
#	cxx_final # Override control final keyword, as defined in N2928, N3206 and N3272.
#	#MSVC 1900 cxx_func_identifier # Predefined __func__ identifier, as defined in N2340.
#	#MSVC 1900 cxx_generalized_initializers # Initializer lists, as defined in N2672.
#	#MSVC 1900 cxx_inheriting_constructors # Inheriting constructors, as defined in N2540.
#	#MSVC 1900 cxx_inline_namespaces # Inline namespaces, as defined in N2535.
#	cxx_lambdas # Lambda functions, as defined in N2927.
#	#MSVC 1900 cxx_local_type_template_args # Local and unnamed types as template arguments, as defined in N2657.
#	cxx_long_long_type # long long type, as defined in N1811.
#	#MSVC 1900 cxx_noexcept # Exception specifications, as defined in N3050.
#	#MSVC 1900 cxx_nonstatic_member_init # Non-static data member initialization, as defined in N2756.
#	cxx_nullptr # Null pointer, as defined in N2431.
#	cxx_override # Override control override keyword, as defined in N2928, N3206 and N3272.
#	cxx_range_for # Range-based for, as defined in N2930.
#	cxx_raw_string_literals # Raw string literals, as defined in N2442.
#	#MSVC 1900 cxx_reference_qualified_functions # Reference qualified functions, as defined in N2439.
#	cxx_right_angle_brackets # Right angle bracket parsing, as defined in N1757.
#	cxx_rvalue_references # R-value references, as defined in N2118.
#	#MSVC 1900 cxx_sizeof_member # Size of non-static data members, as defined in N2253.
#	cxx_static_assert # Static assert, as defined in N1720.
#	cxx_strong_enums # Strongly typed enums, as defined in N2347.
#	#MSVC 1900 cxx_thread_local # Thread-local variables, as defined in N2659.
#	cxx_trailing_return_types # Automatic function return type, as defined in N2541.
#	#MSVC 1900 cxx_unicode_literals # Unicode string literals, as defined in N2442.
#	cxx_uniform_initialization # Uniform initialization, as defined in N2640.
#	#MSVC 1900 cxx_unrestricted_unions # Unrestricted unions, as defined in N2544.
#	#MSVC 1900 cxx_user_literals # User-defined literals, as defined in N2765.
#	cxx_variadic_macros # Variadic macros, as defined in N1653.
#	cxx_variadic_templates # Variadic templates, as defined in N2242.
#)



