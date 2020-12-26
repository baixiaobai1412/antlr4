cmake_minimum_required(VERSION 3.17)
project(nginx_demo)

set(CMAKE_CXX_STANDARD 11)

set(ANTLR_JAR_FILE $ENV{ANTLR_JAR_FILE})

INCLUDE(cmake/FindPackage.cmake)

# https://github.com/antlr/antlr4/tree/master/runtime/Cpp/cmake
# Call macro to add lexer and grammar to your build dependencies.
antlr_target(NginxLexer ${CMAKE_CURRENT_SOURCE_DIR}/grammar/NginxLexer.g4 LEXER
        PACKAGE parsers)
antlr_target(NginxParser ${CMAKE_CURRENT_SOURCE_DIR}/grammar/NginxParser.g4 PARSER
        PACKAGE parsers
        DEPENDS_ANTLR NginxLexer
        COMPILE_FLAGS -lib ${ANTLR_NginxLexer_OUTPUT_DIR})

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-attributes")

include_directories(include/ ${ANTLR4RUNTIME_INCLUDE_DIRS})
message(${ANTLR_NginxLexer_OUTPUT_DIR})
include_directories(${ANTLR_NginxLexer_OUTPUT_DIR})
include_directories(${ANTLR_NginxParser_OUTPUT_DIR})

include_directories(cmake-build-debug/antlr4_cpp /usr/include/antlr4-runtime)
add_executable(nginx_demo
        main.cpp
        ${ANTLR_NginxLexer_CXX_OUTPUTS}
        ${ANTLR_NginxParser_CXX_OUTPUTS}
        )
target_link_libraries(nginx_demo ${ANTLR4RUNTIME_LIBRARIES})