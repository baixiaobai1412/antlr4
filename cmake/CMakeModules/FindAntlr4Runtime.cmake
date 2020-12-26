#.rst:
# FindAntlr4Runtime
# ---------
#
#
# Defines the following variables:
#
# ::
#
#    ANTLR4RUNTIME_FOUND - Found the Antlr C++ runtime
#    ANTLR4RUNTIME_INCLUDE_DIRS - Include directories
#
#
#
# Also defines the library variables below as normal variables.
#
# ::
#
#    ANTLR4RUNTIME_BOTH_LIBRARIES - Both libantlr4-runtime
#    ANTLR4RUNTIME_LIBRARIES - libantlr4-runtime
#
#
#
# Accepts the following variables as input:
#
# ::
#
#    ANTLR4RUNTIME_ROOT - (as a CMake or environment variable)
#                 The root directory of the Antlr C++ runtime install prefix
#
#
#
# Example Usage:
#
# ::
#
#     enable_testing()
#     find_package(ANTLR4RUNTIME REQUIRED)
#     include_directories(${ANTLR4RUNTIME_INCLUDE_DIRS})
#
#
#
# ::
#
#     add_executable(foo foo.cc)
#     target_link_libraries(foo ${ANTLR4RUNTIME_BOTH_LIBRARIES})
#
#
#
# ::
#
#     add_test(AllTestsInFoo foo)
#
#
#

function(_antlr4_runtime_append _endvar _library)
    set(_output ${${_library}})
    set(${_endvar} ${_output} PARENT_SCOPE)
endfunction()

function(_antlr4_runtime_find_library _name)
    find_library(${_name}
            NAMES ${ARGN}
            HINTS
            ENV ANTLR4RUNTIME_ROOT
            ${ANTLR4RUNTIME_ROOT}
            PATH_SUFFIXES ${_antlr4_runtime_libpath_suffixes}
            )
    mark_as_advanced(${_name})
endfunction()


set(_antlr4_runtime_libpath_suffixes lib)

find_path(ANTLR4RUNTIME_INCLUDE_DIR
        NAMES antlr4-runtime.h
        HINTS $ENV{ANTLR4RUNTIME_ROOT} ${ANTLR4RUNTIME_ROOT}
        PATH_SUFFIXES include
        )
mark_as_advanced(ANTLR4RUNTIME_INCLUDE_DIR)

_antlr4_runtime_find_library(ANTLR4RUNTIME_LIBRARY antlr4-runtime)

include(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Antlr4Runtime DEFAULT_MSG ANTLR4RUNTIME_LIBRARY ANTLR4RUNTIME_INCLUDE_DIR)

if (ANTLR4RUNTIME_FOUND)
    set(ANTLR4RUNTIME_INCLUDE_DIRS ${ANTLR4RUNTIME_INCLUDE_DIR})
    _antlr4_runtime_append(ANTLR4RUNTIME_LIBRARIES ANTLR4RUNTIME_LIBRARY)
    set(ANTLR4RUNTIME_BOTH_LIBRARIES ${ANTLR4RUNTIME_LIBRARIES})
endif ()
