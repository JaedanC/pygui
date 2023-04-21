project(pygui)

cmake_minimum_required(VERSION 3.11)

set(CIMGUI_DIRECTORY          src/external/dear_bindings)
set(IMGUI_DIRECTORY           src/external/imgui)
set(IMGUI_IMPL_DIRECTORY      ${IMGUI_DIRECTORY}/backends)
set(IMGUILESS_IMPL_DIRECTORY  src/core/backends)
set(GLFW_DIRECTORY            src/external/glfw)
set(GLFW_INCLUDE_DIRECTORY    ${GLFW_DIRECTORY}/include)

#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

set(PYGUI_CONFIG_H      ${CMAKE_CURRENT_SOURCE_DIR}/src/cpp_config/pygui_config.h)
set(PYGUI_CONFIG_CPP    ${CMAKE_CURRENT_SOURCE_DIR}/src/cpp_config/pygui_config.cpp)
set(CMAKE_VERBOSE_MAKEFILE ON)

find_package(PythonLibs REQUIRED)

# ------------------------------------------------------------------------------
# glfw.dll
# - Contains glfw implementation

# Layout:
#  - define: PYGUI_COMPILING_GLFW
#       _GLFW_BUILD_DLL
#  - src:
#       Use built-in CMake

set(BUILD_SHARED_LIBS ON CACHE BOOL "" FORCE)
add_subdirectory(${GLFW_DIRECTORY})
target_compile_definitions(glfw PRIVATE
    _GLFW_BUILD_DLL
)


# ------------------------------------------------------------------------------
# cimgui.dll
# - Contains cimgui and imgui.
# - Exports the cimgui functions non-mangled (for pygui)
# - Exports the imgui functions mangled so that the internals for implementations
#   know how to link with imgui directly.

# Layout:
#  - define: PYGUI_COMPILING_CIMGUI
#       IMGUI_API       __declspec(dllexport)
#       CIMGUI_API      extern "C" __declspec(dllexport)
#  - include:
#       cimgui.h
#       {imgui_includes}
#  - src:
#       cimgui.cpp
#       {imgui_src}

file(
    GLOB
    CIMGUI_FILES
    ${CIMGUI_DIRECTORY}/*.cpp
    ${IMGUI_DIRECTORY}/*.cpp
)
add_library(cimgui SHARED ${CIMGUI_FILES} ${PYGUI_CONFIG_CPP})
target_compile_definitions(cimgui PRIVATE
    PYGUI_COMPILING_CIMGUI
    USE_CUSTOM_PYTHON_ERROR
)
target_include_directories(cimgui PRIVATE
    ${CIMGUI_DIRECTORY}
    ${IMGUI_DIRECTORY}
    ${PYTHON_INCLUDE_DIRS}
)
target_link_libraries(cimgui
    ${PYTHON_LIBRARIES}
)

# cl specific. Force include of the config file
target_compile_options(cimgui PRIVATE "/FI${PYGUI_CONFIG_H}")


# ------------------------------------------------------------------------------
# imgui_glfw_opengl3.dll
# - Contains glfw and opengl specific imgui code

# Layout:
#  - define: PYGUI_COMPILING_GLFW_IMPL
#       GLFW_DLL
#  		IMGUI_IMPL_API  extern "C" __declspec(dllexport)
# 		IMGUI_API                  __declspec(dllimport)
#  - include
#       imgui_impl_glfw.h
#       imgui_impl_opengl3.h
#       {imgui_includes}
#  - src:
#       imgui_impl_glfw.cpp
#       imgui_impl_opengl3.cpp
#  - links:
#       cimgui  (IMGUI_API import)
#       glfw    (So that glfw functions calls are found)

add_library(imgui_glfw_opengl3 SHARED
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_glfw.cpp
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_opengl3.cpp
)
target_compile_definitions(imgui_glfw_opengl3 PRIVATE
    PYGUI_COMPILING_GLFW_IMPL
)
target_include_directories(imgui_glfw_opengl3 PRIVATE
    ${IMGUI_DIRECTORY}
    ${IMGUI_IMPL_DIRECTORY} # Technically this isn't required because the sources come
                            # this directory but this is more obvious and I prefer that.
    ${GLFW_INCLUDE_DIRECTORY}
)
target_compile_options(imgui_glfw_opengl3 PRIVATE "/FI${PYGUI_CONFIG_H}")
target_link_libraries(imgui_glfw_opengl3 cimgui glfw)


# ------------------------------------------------------------------------------
# my_program.exe
# - Since this is a C file, we can only link to functions that at non-mangled.
#   This is why this app uses the CIMGUI_API and the much simpler header file
#   of cimgui_impl.h.
# - VERY IMPORTANT. Since this links with cimgui (which may be compiled with
#   a redefined IM_ASSERT macro), you need to be careful. If IM_ASSERT() fails
#   then the program will crash WITHOUT an error message at all. If you are
#   testing and want ImGui to crash with appropriate error messages OR want to
#   use cimgui for your own application, then it is crucial you recompile cimgui
#   WITHOUT the USE_CUSTOM_PYTHON_ERROR macro defined.
# - To test that cimgui is not using Python, then there is a button in this
#   example program called "Click to crash cimgui". If you see an error message
#   then you are good. Otherwise, it is using the custom python exception.

# Layout:
#  - define: PYGUI_COMPILING_APP
# 		CIMGUI_API           __declspec(dllimport)
#  - include
#       {basically everything}
#  - src:
#       main_db.c
#  - links:
#       cimgui              (CIMGUI_API import)
#       imgui_glfw_opengl3  (So that glfw function calls are found)
#       opengl32            (So that opengl function calls are found)

add_executable(my_program src/main.c)
target_compile_definitions(my_program PRIVATE
    PYGUI_COMPILING_APP
)
target_include_directories(my_program PRIVATE
    ${IMGUI_DIRECTORY}
    ${CIMGUI_DIRECTORY}
    ${IMGUILESS_IMPL_DIRECTORY}
)
# ${GLFW_INCLUDE_DIRECTORY}
target_compile_options(my_program PRIVATE "/FI${PYGUI_CONFIG_H}")
target_link_libraries(my_program cimgui imgui_glfw_opengl3 opengl32)

# Since we are compiling SHARED dll's, then we are mostly interesting in
# the runtime (dll) and the archive (associated .lib). The .lib file is
# for compiling with the dll. This is what setuptools is looking for. The
# dlls must be present to run my_program and pygui.
install(TARGETS cimgui imgui_glfw_opengl3 glfw my_program cimgui imgui_glfw_opengl3 my_program
        RUNTIME DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui
        LIBRARY DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui/libs
        ARCHIVE DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui/libs)
