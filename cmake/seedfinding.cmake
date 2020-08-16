include(ExternalProject)
# On systems without Git installed, there were errors since execute_process seemed to not throw an error without it?
# Also to not check out the version.h its needed
find_package(Git QUIET)
if (Git_FOUND)
    # Gets the latest tag as a string like "v0.6.6"
    # Can silently fail if git isn't on the system
    execute_process(COMMAND ${GIT_EXECUTABLE} ls-remote https://github.com/Earthcomputer/libseedfinding tags/*
            OUTPUT_VARIABLE _raw_version_string
            ERROR_VARIABLE _git_tag_error
            )
    string(REGEX MATCHALL "refs/tags/[ab]([0-9]+\\.?)+" _libseedfinding_tag_list "${_raw_version_string}")
    list(LENGTH _libseedfinding_tag_list list_tag_len)
    math(EXPR last_tag_index "${list_tag_len} - 1")
    list(GET _libseedfinding_tag_list ${last_tag_index} last_tag)
    string(REGEX REPLACE "refs/tags/" "" _libseedfinding_version ${last_tag})
endif ()

# execute_process can fail silenty, so check for an error
# if there was an error, just use the user agent as a version
if (_git_tag_error OR NOT Git_FOUND)
    message(WARNING "cpp-libseedfinding failed to find the latest Git tag, falling back to using the version in the header file.")
    # This is so the we can only bother to update the header
    set(_raw_version_string a0.0.6)
endif ()

message("USING version ${_libseedfinding_version}")
set(libseedfinding_URL "https://github.com/Earthcomputer/libseedfinding/archive/${_libseedfinding_version}.zip")
set(libseedfinding_INSTALL "${CMAKE_CURRENT_BINARY_DIR}/third_party/libseedfinding")
set(libseedfinding_INCLUDE_DIR ${libseedfinding_INSTALL}/include)
set(libseedfinding_LIB_DIR ${libseedfinding_INSTALL}/lib)
set(libseedfinding_CMAKE_DIR ${libseedfinding_INSTALL}/cmake)

ExternalProject_Add(seedfinding
        PREFIX libseedfinding
        URL ${libseedfinding_URL}
        BUILD_IN_SOURCE 1
        CONFIGURE_COMMAND
        ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Release
              -DCMAKE_INSTALL_INCLUDEDIR=${libseedfinding_INCLUDE_DIR}
              -DCMAKE_INSTALL_LIBDIR=${libseedfinding_LIB_DIR}
              -DCMAKE_INSTALL_PREFIX=${libseedfinding_INSTALL}
              -DLIBSEEDFINDING_USE_CUDA=${LIBSEEDFINDING_USE_CUDA}
              -DLIBSEEDFINDING_COMPILE=${LIBSEEDFINDING_COMPILE}
              -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
              .
        BUILD_COMMAND
        ${CMAKE_COMMAND} --build . --target install
        INSTALL_COMMAND
        cmake -E echo "Skipping install step as it was done previously."
        INSTALL_DIR ${libseedfinding_INSTALL}
        LOG_DOWNLOAD 1
        LOG_UPDATE 1
        LOG_CONFIGURE 1
        LOG_BUILD 1
        )
