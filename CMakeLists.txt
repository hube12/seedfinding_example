cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(seedfinding_example LANGUAGES CXX)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_CXX_STANDARD 14)
if (!MSVC)
    set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-Ofast -ggdb3 -pedantic -Wall -Wextra -Wnon-virtual-dtor -Wno-unused-parameter")
endif()

# options for the library
set(LIBSEEDFINDING_USE_CUDA OFF)

##################### Configure the library ##############################
# find the external project and include it
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(seedfinding)
# create the library and bind the cmake script to it, the library is available everywhere now
add_library(libseedfinding INTERFACE)
add_dependencies(libseedfinding seedfinding)
target_include_directories(libseedfinding INTERFACE ${libseedfinding_INCLUDE_DIR})
##########################################################################


# add our code directory
add_subdirectory(src)



######################## This is the more advanced section#######################
# You don't actually need to make a library since its a header only one
# You can just use target_include_directories(YOUR_TARGET PUBLIC ${libseedfinding_INCLUDE_DIR})
# What it looks like:
#
# set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
# include(libseedfinding)
# add_executable(YOUR_TARGET ${SOURCES})
# add_dependencies(YOUR_TARGET libseedfinding)
# target_include_directories(YOUR_TARGET PUBLIC ${libseedfinding_INCLUDE_DIR})

##################################################################################