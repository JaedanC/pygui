cmake_minimum_required(VERSION 3.26)
project(pygui)


set(CIMGUI_DIRECTORY          src/external/dear_bindings/generated)
set(CIMGUI_IMPL_DIRECTORY     ${CIMGUI_DIRECTORY}/backends)

set(IMGUI_DIRECTORY           src/external/imgui)
set(IMGUI_IMPL_DIRECTORY      ${IMGUI_DIRECTORY}/backends)

set(GLFW_DIRECTORY            src/external/glfw)
set(GLFW_INCLUDE_DIRECTORY    ${GLFW_DIRECTORY}/include)

set(PYGUI_CONFIG_H            ${CMAKE_CURRENT_SOURCE_DIR}/src/cpp_config/pygui_config.h)
set(PYGUI_CONFIG_CPP          ${CMAKE_CURRENT_SOURCE_DIR}/src/cpp_config/pygui_config.cpp)
set(CMAKE_VERBOSE_MAKEFILE ON)

set(Python_FIND_ABI "ANY" "ANY" "ANY")
find_package(Python3 COMPONENTS Development)

# ------------------------------------------------------------------------------
# glfw.dll
# - Contains glfw implementation

set(BUILD_SHARED_LIBS ON CACHE BOOL "" FORCE)
add_subdirectory(${GLFW_DIRECTORY})
target_compile_definitions(glfw PRIVATE
    _GLFW_BUILD_DLL
)


# ------------------------------------------------------------------------------
# cimgui.dll
# - Contains imgui, cimgui, and cimgui backend.
# - Exports only the cimgui functions

# Layout:
#  - define: PYGUI_COMPILING_CIMGUI
#       CIMGUI_IMPL_API   __declspec(dllexport)
#       CIMGUI_API        __declspec(dllexport)
#  - include:
#       {imgui headers}
#       {cimgui headers}
#       {cimgui backend headers}
#       {glfw headers}
#       {python headers} -> For custom assertion
#  - src:
#       {imgui  src}
#       {cimgui src}
#       {cimgui backend src}
#       {custom python assert src}


file(
    GLOB
    CIMGUI_AND_IMPL_FILES
    ${IMGUI_DIRECTORY}/*.cpp
    ${CIMGUI_DIRECTORY}/*.cpp
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_glfw.cpp
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_opengl3.cpp
    ${CIMGUI_IMPL_DIRECTORY}/cimgui_impl_glfw.cpp
    ${CIMGUI_IMPL_DIRECTORY}/cimgui_impl_opengl3.cpp
    ${PYGUI_CONFIG_CPP}                             # Custom Python assertion
)
add_library(cimgui SHARED ${CIMGUI_AND_IMPL_FILES})
target_compile_definitions(cimgui PRIVATE
    PYGUI_COMPILING_DLL
    USE_CUSTOM_PYTHON_ERROR                         # Comment this to disable custom assert
)
target_include_directories(cimgui PRIVATE
    ${IMGUI_DIRECTORY}
    ${IMGUI_IMPL_DIRECTORY}
    ${CIMGUI_DIRECTORY}
    ${CIMGUI_IMPL_DIRECTORY}
    ${GLFW_INCLUDE_DIRECTORY}
    ${Python3_INCLUDE_DIRS}
)
target_compile_options(cimgui PRIVATE "/FI${PYGUI_CONFIG_H}")
target_link_libraries(cimgui glfw ${Python3_LIBRARIES})


# ------------------------------------------------------------------------------
# my_program_cpp.exe
# - This is compiled to test the stability of ImGui itself.

# Layout:
#  - define: PYGUI_COMPILING_CPP_APP
# 		GLFW_DLL
#  - include
#       {imgui}
#       {imgui_impl}
#  - src:
#       main.cpp
#       {imgui}
#       {imgui_impl}
#  - links:
#       glfw                (So that glfw function calls are found)
#       opengl32            (So that opengl function calls are found)

file(
    GLOB
    IMGUI_FILES
    ${IMGUI_DIRECTORY}/*.cpp
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_glfw.cpp
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_opengl3.cpp
)
add_executable(my_program_cpp
    ${IMGUI_DIRECTORY}/examples/example_glfw_opengl3/main.cpp
    ${IMGUI_FILES}
)
target_include_directories(my_program_cpp PRIVATE
    ${IMGUI_DIRECTORY}
    ${IMGUI_IMPL_DIRECTORY}
)
target_link_libraries(my_program_cpp opengl32 glfw)

# ------------------------------------------------------------------------------
# my_program.exe
# - Since this is a C file, we can only link to functions that are non-mangled.
# - Thankfully, dear_bindings now supports C backends, so everything can be
#   wrapped into a single DLL and linked in one go :)
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
#  - define: PYGUI_COMPILING_C_APP
# 		CIMGUI_API       __declspec(dllimport)
#       CIMGUI_IMPL_API  __declspec(dllimport)
#  - include
#       {basically everything}
#  - src:
#       main.c
#  - links:
#       cimgui              (CIMGUI_API import. Includes glfw nad backend).
#       opengl32            (So that opengl function calls are found).

add_executable(my_program_c
    src/main.c
)
target_compile_definitions(my_program_c PRIVATE
    PYGUI_COMPILING_C_APP
)
target_include_directories(my_program_c PRIVATE
    ${IMGUI_DIRECTORY}
    ${CIMGUI_DIRECTORY}
    ${CIMGUI_IMPL_DIRECTORY}
)
target_compile_options(my_program_c PRIVATE "/FI${PYGUI_CONFIG_H}")
target_link_libraries(my_program_c cimgui opengl32)


# Since we are compiling SHARED dll's, then we are mostly interesting in
# the runtime (dll) and the archive (associated .lib). The .lib file is
# for compiling with the dll. This is what setuptools is looking for. The
# dlls must be present to run my_program and pygui.
install(TARGETS cimgui my_program_c glfw my_program_cpp
        RUNTIME DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui
        LIBRARY DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui/libs
        ARCHIVE DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui/libs)

# For debugging my_program
message("Installing glfw and ${Python3_RUNTIME_LIBRARY} to build dir")
install(TARGETS glfw
        RUNTIME DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ${Python3_RUNTIME_LIBRARY}
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})