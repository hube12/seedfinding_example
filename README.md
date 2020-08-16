# Seedfinding Example

This repository show how to use the libseedfinding and how to configure it as a library.

The main two parts are the cmake/seedfinding.cmake build script and the following lines in the root Cmake file:

```cmake
##################### Configure the library ##############################
# find the external project and include it
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(seedfinding)
# create the library and bind the cmake script to it, the library is available everywhere now
add_library(libseedfinding INTERFACE)
add_dependencies(libseedfinding seedfinding)
target_include_directories(libseedfinding INTERFACE ${libseedfinding_INCLUDE_DIR})
##########################################################################
```

You can also configure a few options notably those ones by default you don't need to define them as they are all configured 
as disabled

```cmake
# options for the library
# Let you use cuda capabilities
set(LIBSEEDFINDING_USE_CUDA OFF) # use ON to turn it on
# Let you compile the program as a regular library instead of header-only (If ON, uses a Python script to split the header into a compilable header & source file (requires Python v3).
set(LIBSEEDFINDING_COMPILE OFF)
# Defaults to static library (Build the library as a shared library instead of static. Has no effect if using header-only)
option(BUILD_SHARED_LIBS OFF)
```

# Dependencies

You need a git client, as well as python 2.6+ or python 3.3+.

# Versions

This has been tested on wsl, ubuntu 16,18 and 20, debian 9 and 10, MSVC with c++14+, mingw, cygwin