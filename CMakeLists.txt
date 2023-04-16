project(pygui)

cmake_minimum_required(VERSION 3.11)

set(CIMGUI_DIRECTORY          src/external/cimgui)
set(CIMGUI_IMPL_DIRECTORY     ${CIMGUI_DIRECTORY}/generator/output)
set(DB_CIMGUI_DIRECTORY       src/external/dear_bindings)
set(IMGUI_DIRECTORY           ${CIMGUI_DIRECTORY}/imgui)
set(IMGUI_IMPL_DIRECTORY      ${IMGUI_DIRECTORY}/backends)
set(GLFW_DIRECTORY            src/external/glfw)
set(GLFW_INCLUDE_DIRECTORY    ${GLFW_DIRECTORY}/include)

#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

set(PYGUI_CONFIG_FILE      ${CMAKE_CURRENT_SOURCE_DIR}/src/external/pygui_config.h)
set(CMAKE_VERBOSE_MAKEFILE ON)

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
add_library(cimgui SHARED ${CIMGUI_FILES})
target_compile_definitions(cimgui PRIVATE
    PYGUI_COMPILING_CIMGUI
)
target_include_directories(cimgui PRIVATE
    ${CIMGUI_DIRECTORY}
    ${IMGUI_DIRECTORY}
)

# cl specific. Force include of the config file
target_compile_options(cimgui PRIVATE "/FI${PYGUI_CONFIG_FILE}")

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
# imgui_glfw_opengl3.dll
# - Contains glfw and opengl specific imgui code

# Layout:
#  - define: PYGUI_COMPILING_GLFW_IMPL
#       GLFW_DLL
#  		IMGUI_IMPL_API  extern "C" __declspec(dllexport)
# 		IMGUI_API       extern "C" __declspec(dllimport)
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
    ${IMGUI_IMPL_DIRECTORY} # TODO Check if this is required
    ${GLFW_INCLUDE_DIRECTORY}
)
target_compile_options(imgui_glfw_opengl3 PRIVATE "/FI${PYGUI_CONFIG_FILE}")
target_link_libraries(imgui_glfw_opengl3 cimgui glfw)

# ------------------------------------------------------------------------------
# my_program.exe
# - Since this is a C file, we can only link to functions that at non-mangled.
#   This is why this app uses the CIMGUI_API and the much simpler header file
#   of cimgui_impl.h.

# Layout:
#  - define: PYGUI_COMPILING_APP
#       CIMGUI_USE_GLFW
#  		CIMGUI_USE_OPENGL3
# 		CIMGUI_API          __declspec(dllimport)
#  - include
#       {basically everything}
#  - src:
#       main.c
#  - links:
#       cimgui              (CIMGUI_API import)
#       imgui_glfw_opengl3  (So that glfw function calls are found)
#       opengl32            (So that opengl function calls are found)

add_executable(my_program src/main.c)
target_compile_definitions(my_program PRIVATE
    PYGUI_COMPILING_APP
)
target_include_directories(my_program PRIVATE
    ${CIMGUI_DIRECTORY}
    ${CIMGUI_IMPL_DIRECTORY}
    ${IMGUI_DIRECTORY}
    ${IMGUI_IMPL_DIRECTORY}
    ${GLFW_INCLUDE_DIRECTORY}
)
target_compile_options(my_program PRIVATE "/FI${PYGUI_CONFIG_FILE}")
target_link_libraries(my_program cimgui imgui_glfw_opengl3 opengl32)


# ------------------------------------------------------------------------------
# ------------------------------- Dear Bindings --------------------------------
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# db_cimgui.dll
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
    DB_CIMGUI_FILES
    ${DB_CIMGUI_DIRECTORY}/*.cpp
    ${IMGUI_DIRECTORY}/*.cpp
)
add_library(db_cimgui SHARED ${DB_CIMGUI_FILES})
target_compile_definitions(db_cimgui PRIVATE
    PYGUI_COMPILING_CIMGUI
)
target_include_directories(db_cimgui PRIVATE
    ${DB_CIMGUI_DIRECTORY}
    ${IMGUI_DIRECTORY}
)

# cl specific. Force include of the config file
target_compile_options(db_cimgui PRIVATE "/FI${PYGUI_CONFIG_FILE}")


# ------------------------------------------------------------------------------
# imgui_glfw_opengl3.dll
# - Contains glfw and opengl specific imgui code

# Layout:
#  - define: PYGUI_COMPILING_GLFW_IMPL
#       GLFW_DLL
#  		IMGUI_IMPL_API  extern "C" __declspec(dllexport)
# 		IMGUI_API       extern "C" __declspec(dllimport)
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

add_library(db_imgui_glfw_opengl3 SHARED
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_glfw.cpp
    ${IMGUI_IMPL_DIRECTORY}/imgui_impl_opengl3.cpp
)
target_compile_definitions(db_imgui_glfw_opengl3 PRIVATE
    PYGUI_COMPILING_GLFW_IMPL
)
target_include_directories(db_imgui_glfw_opengl3 PRIVATE
    ${IMGUI_DIRECTORY}
    ${IMGUI_IMPL_DIRECTORY} # TODO Check if this is required
    ${GLFW_INCLUDE_DIRECTORY}
)
target_compile_options(db_imgui_glfw_opengl3 PRIVATE "/FI${PYGUI_CONFIG_FILE}")
target_link_libraries(db_imgui_glfw_opengl3 db_cimgui glfw)


# ------------------------------------------------------------------------------
# db_my_program.exe
# - Since this is a C file, we can only link to functions that at non-mangled.
#   This is why this app uses the CIMGUI_API and the much simpler header file
#   of cimgui_impl.h.

# Layout:
#  - define: PYGUI_COMPILING_APP
#       CIMGUI_USE_GLFW
#  		CIMGUI_USE_OPENGL3
# 		CIMGUI_API          __declspec(dllimport)
#  - include
#       {basically everything}
#  - src:
#       main_db.c
#  - links:
#       db_cimgui           (CIMGUI_API import)
#       db_imgui_glfw_opengl3  (So that glfw function calls are found)
#       opengl32               (So that opengl function calls are found)

add_executable(db_my_program src/db_main.c)
target_compile_definitions(db_my_program PRIVATE
    PYGUI_COMPILING_APP
)
target_include_directories(db_my_program PRIVATE
    ${DB_CIMGUI_DIRECTORY}
    ${CIMGUI_IMPL_DIRECTORY}
    ${IMGUI_DIRECTORY}
    ${IMGUI_IMPL_DIRECTORY}
    ${GLFW_INCLUDE_DIRECTORY}
)
target_compile_options(db_my_program PRIVATE "/FI${PYGUI_CONFIG_FILE}")
target_link_libraries(db_my_program db_cimgui db_imgui_glfw_opengl3 opengl32)



# Since we are compiling SHARED dll's, then we are mostly interesting in
# the runtime (dll) and the archive (associated .lib). The .lib file is
# for compiling with the dll. This is what setuptools is looking for. The
# dlls must be present to run my_program and pygui.
install(TARGETS cimgui imgui_glfw_opengl3 glfw my_program db_cimgui db_imgui_glfw_opengl3 db_my_program
        RUNTIME DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui
        LIBRARY DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui/libs
        ARCHIVE DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui/libs)
