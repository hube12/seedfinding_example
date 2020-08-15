cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(seedfinding_example LANGUAGES CXX)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_CXX_STANDARD 14)
if (!MSVC)
    set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-Ofast -ggdb3 -pedantic -Wall -Wextra -Wnon-virtual-dtor -Wno-unused-parameter")
endif()
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(libseedfinding)

add_executable(main main.cpp)
add_dependencies(main libseedfinding)
# improve compilation speed only in cmake 3.16+

target_include_directories(main PUBLIC ${libseedfinding_INCLUDE_DIR})

