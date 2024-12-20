cmake_minimum_required(VERSION 3.26)
project(pygui)


set(DCIMGUI_DIRECTORY          src/external/dear_bindings/generated)
set(DCIMGUI_IMPL_DIRECTORY     ${DCIMGUI_DIRECTORY}/backends)

set(IMGUI_DIRECTORY           src/external/imgui)
set(IMGUI_IMPL_DIRECTORY      ${IMGUI_DIRECTORY}/backends)

set(GLFW_DIRECTORY            src/external/glfw)
set(GLFW_INCLUDE_DIRECTORY    ${GLFW_DIRECTORY}/include)

set(PYGUI_CONFIG_DIRECTORY    ${CMAKE_CURRENT_SOURCE_DIR}/src/c/cpp_config)
set(PYGUI_CONFIG_H            ${CMAKE_CURRENT_SOURCE_DIR}/src/c/cpp_config/pygui_config.h)
set(PYGUI_CONFIG_CPP          ${CMAKE_CURRENT_SOURCE_DIR}/src/c/cpp_config/pygui_config.cpp)
set(CMAKE_VERBOSE_MAKEFILE ON)

set(Python_FIND_ABI "ANY" "ANY" "ANY")
find_package(Python3 COMPONENTS Development)
message("Python_FOUND:${Python3_FOUND}")
message("Python_VERSION:${Python3_VERSION}")
message("Python_Development_FOUND:${Python3_Development_FOUND}")
message("Python_LIBRARIES:${Python3_LIBRARIES}")

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
# No Console window on startup
# set_target_properties(my_program_cpp PROPERTIES
#    LINK_FLAGS "/ENTRY:mainCRTStartup /SUBSYSTEM:WINDOWS")
target_link_libraries(my_program_cpp opengl32 glfw)


# ------------------------------------------------------------------------------
# dcimgui_glfw_opengl3.dll
# - Contains: imgui, dcimgui, and dcimgui glfw & opengl3 backend.
# - Exports only the dcimgui functions

# Layout:
#  - define: PYGUI_COMPILING_DLL
#       CIMGUI_IMPL_API   __declspec(dllexport)
#       CIMGUI_API        __declspec(dllexport)
#  - include:
#       {imgui headers}
#       {dcimgui headers}
#       {dcimgui backend headers}
#       {glfw headers}
#       {python headers} -> For custom assertion
#  - src:
#       {imgui  src}
#       {dcimgui src}
#       {dcimgui backend src}
#       {python assert src}

file(
    GLOB
    DCIMGUI_AND_IMPL_FILES
    ${IMGUI_DIRECTORY}/*.cpp
    ${DCIMGUI_DIRECTORY}/*.cpp
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_glfw.cpp
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_opengl3.cpp
    ${DCIMGUI_IMPL_DIRECTORY}/dcimgui_impl_glfw.cpp
    ${DCIMGUI_IMPL_DIRECTORY}/dcimgui_impl_opengl3.cpp
    ${PYGUI_CONFIG_CPP}                             # Custom Python assertion
)
add_library(dcimgui_glfw_opengl3 SHARED ${DCIMGUI_AND_IMPL_FILES})
target_include_directories(dcimgui_glfw_opengl3 PRIVATE
    ${IMGUI_DIRECTORY}
    ${IMGUI_IMPL_DIRECTORY}
    ${DCIMGUI_DIRECTORY}
    ${DCIMGUI_IMPL_DIRECTORY}
    ${GLFW_INCLUDE_DIRECTORY}
    ${Python3_INCLUDE_DIRS}
    ${PYGUI_CONFIG_DIRECTORY}
)
target_compile_definitions(dcimgui_glfw_opengl3 PRIVATE
    USE_CUSTOM_PYTHON_ERROR                     # Comment this to disable custom assert
    PYGUI_COMPILING_DLL
    IMGUI_USER_CONFIG="${PYGUI_CONFIG_H}"
)
target_link_libraries(dcimgui_glfw_opengl3 glfw ${Python3_LIBRARIES})


# ------------------------------------------------------------------------------
# my_program.exe
# - Tests the dcimgui DLL using
# - Does not compile with the custom IM_ASSERT() function. You can verify this
#   by clicking on the button "Click to crash dcimgui" in the example provided.
# - The main.c file is based on the minimal c++ example in the ImGui repo.

# Layout:
#  - define: PYGUI_COMPILING_DLL_APP
# 		CIMGUI_API         __declspec(dllimport)
#       CIMGUI_IMPL_API    __declspec(dllimport)
#  - include
#       {imgui headers}
#       {dcimgui headers}
#       {dcimgui backend headers}
#  - src:
#       main.c
#  - links:
#       dcimgui_glfw_opengl3  (CIMGUI_API import. Includes dcimgui and backend).
#       opengl32              (So that opengl function calls are found).

add_executable(my_program_c
    src/c/main.c
)
target_include_directories(my_program_c PRIVATE
    ${IMGUI_DIRECTORY}
    ${DCIMGUI_DIRECTORY}
    ${DCIMGUI_IMPL_DIRECTORY}
    ${PYGUI_CONFIG_DIRECTORY}
)
target_compile_definitions(my_program_c PRIVATE
    PYGUI_COMPILING_DLL_APP
    IMGUI_USER_CONFIG="${PYGUI_CONFIG_H}"
)
# No Console window on startup
# set_target_properties(my_program_c PROPERTIES
#    LINK_FLAGS "/ENTRY:mainCRTStartup /SUBSYSTEM:WINDOWS")
target_link_libraries(my_program_c dcimgui_glfw_opengl3 opengl32)


# Since we are compiling SHARED dll's, then we are mostly interesting in
# the runtime (dll) and the archive (associated .lib). The .lib file is
# for compiling with the dll. This is what setuptools is looking for. The
# dlls must be present to run my_program and pygui.
install(TARGETS dcimgui_glfw_opengl3 my_program_c my_program_cpp glfw
        RUNTIME DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/deploy/pygui
        LIBRARY DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/deploy/pygui/libs
        ARCHIVE DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/deploy/pygui/libs)

# For debugging my_program
message("Installing glfw and ${Python3_RUNTIME_LIBRARY} to build dir")
install(TARGETS glfw
        RUNTIME DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ${Python3_RUNTIME_LIBRARY}
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
