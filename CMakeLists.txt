cmake_minimum_required(VERSION 3.26)
project(pygui)


set(CIMGUI_DIRECTORY          src/external/dear_bindings/generated)
set(CIMGUI_IMPL_DIRECTORY     ${CIMGUI_DIRECTORY}/backends)

set(IMGUI_DIRECTORY           src/external/imgui)
set(IMGUI_IMPL_DIRECTORY      ${IMGUI_DIRECTORY}/backends)

set(GLFW_DIRECTORY            src/external/glfw)
set(GLFW_INCLUDE_DIRECTORY    ${GLFW_DIRECTORY}/include)

set(PYGUI_CONFIG_DIRECTORY    ${CMAKE_CURRENT_SOURCE_DIR}/src/cpp_config)
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
# my_program_cpp.exe
# - A typical ImGui static compilation

# Layout:
#  - define: IMGUI_USER_CONFIG
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
target_compile_definitions(my_program_cpp PRIVATE
    IMGUI_USER_CONFIG="${PYGUI_CONFIG_H}"
)
target_link_libraries(my_program_cpp opengl32 glfw)


# ------------------------------------------------------------------------------
# cimgui_glfw_opengl3.dll
# - Contains: imgui, cimgui, and cimgui glfw & opengl3 backend.
# - Exports only the cimgui functions

# Layout:
#  - define: PYGUI_COMPILING_DLL
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
#       {python assert src}

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
add_library(cimgui_glfw_opengl3 SHARED ${CIMGUI_AND_IMPL_FILES})
target_include_directories(cimgui_glfw_opengl3 PRIVATE
    ${IMGUI_DIRECTORY}
    ${IMGUI_IMPL_DIRECTORY}
    ${CIMGUI_DIRECTORY}
    ${CIMGUI_IMPL_DIRECTORY}
    ${GLFW_INCLUDE_DIRECTORY}
    ${Python3_INCLUDE_DIRS}
    ${PYGUI_CONFIG_DIRECTORY}
)
target_compile_definitions(cimgui_glfw_opengl3 PRIVATE
    USE_CUSTOM_PYTHON_ERROR                     # Comment this to disable custom assert
    PYGUI_COMPILING_DLL
    IMGUI_USER_CONFIG="${PYGUI_CONFIG_H}"
)
target_link_libraries(cimgui_glfw_opengl3 glfw ${Python3_LIBRARIES})


# ------------------------------------------------------------------------------
# my_program.exe
# - Tests the cimgui DLL using 
# - Does not compile with the custom IM_ASSERT() function. You can verify this
#   by clicking on the button "Click to crash cimgui" in the example provided.
# - The main.c file is based on the minimal c++ example in the ImGui repo.

# Layout:
#  - define: PYGUI_COMPILING_DLL_APP
# 		CIMGUI_API         __declspec(dllimport)
#       CIMGUI_IMPL_API    __declspec(dllimport)
#  - include
#       {imgui headers}
#       {cimgui headers}
#       {cimgui backend headers}
#  - src:
#       main.c
#  - links:
#       cimgui_glfw_opengl3  (CIMGUI_API import. Includes cimgui and backend).
#       opengl32             (So that opengl function calls are found).

add_executable(my_program_c
    src/main.c
)
target_include_directories(my_program_c PRIVATE
    ${IMGUI_DIRECTORY}
    ${CIMGUI_DIRECTORY}
    ${CIMGUI_IMPL_DIRECTORY}
    ${PYGUI_CONFIG_DIRECTORY}
)
target_compile_definitions(my_program_c PRIVATE
    PYGUI_COMPILING_DLL_APP
    IMGUI_USER_CONFIG="${PYGUI_CONFIG_H}"
)
target_link_libraries(my_program_c cimgui_glfw_opengl3 opengl32)


# Since we are compiling SHARED dll's, then we are mostly interesting in
# the runtime (dll) and the archive (associated .lib). The .lib file is
# for compiling with the dll. This is what setuptools is looking for. The
# dlls must be present to run my_program and pygui.
install(TARGETS cimgui_glfw_opengl3 my_program_c my_program_cpp glfw
        RUNTIME DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui
        LIBRARY DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui/libs
        ARCHIVE DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui/libs)

# For debugging my_program
message("Installing glfw and ${Python3_RUNTIME_LIBRARY} to build dir")
install(TARGETS glfw
        RUNTIME DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ${Python3_RUNTIME_LIBRARY}
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
