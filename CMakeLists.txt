Project(cimgui_glfw)
cmake_minimum_required(VERSION 3.11)
set(CMAKE_SHARED_LIBRARY_PREFIX "")

add_definitions("-DIMGUI_DISABLE_OBSOLETE_FUNCTIONS=1")
add_definitions("-DCIMGUI_USE_GLFW")
add_definitions("-DCIMGUI_USE_OPENGL3")

# general settings
set(CIMGUI_FOLDER   "src/cimgui/")
set(IMGUI_FOLDER    "src/cimgui/imgui/")
set(BACKENDS_FOLDER "src/cimgui/imgui/backends/")

include_directories(${CIMGUI_FOLDER})
include_directories(${IMGUI_FOLDER})
include_directories(src/cimgui/generator/output/)

set(
    IMGUI_SOURCES 
    ${CIMGUI_FOLDER}cimgui.cpp 
    ${IMGUI_FOLDER}imgui.cpp 
    ${IMGUI_FOLDER}imgui_draw.cpp 
    ${IMGUI_FOLDER}imgui_demo.cpp 
    ${IMGUI_FOLDER}imgui_tables.cpp
    ${IMGUI_FOLDER}imgui_widgets.cpp
    ${BACKENDS_FOLDER}imgui_impl_opengl3.cpp
    ${BACKENDS_FOLDER}imgui_impl_glfw.cpp
)

set(IMGUI_LIBRARIES )
list(APPEND IMGUI_LIBRARIES opengl32)

# GLFW
set(GLFW_VERSION 3.3.8)
include(FetchContent)
	FetchContent_Declare(
    glfw
    URL https://github.com/glfw/glfw/archive/refs/tags/${GLFW_VERSION}.tar.gz)

FetchContent_GetProperties(glfw)
if (NOT glfw_POPULATED)
	set(FETCHCONTENT_QUIET NO)
    FetchContent_Populate(glfw)
	set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
	set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
	add_subdirectory(${glfw_SOURCE_DIR} ${glfw_BINARY_DIR})
endif()

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)

add_library(cimgui STATIC ${IMGUI_SOURCES})

target_link_libraries(cimgui ${IMGUI_LIBRARIES} glfw)

execute_process(
    COMMAND python model_creator.py --all
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/src
)


if (EXISTS ${CMAKE_CURRENT_BINARY_DIR}/src)
    file(REMOVE_RECURSE ${CMAKE_CURRENT_BINARY_DIR}/src/)
endif()
    
file(
    COPY        ${CMAKE_CURRENT_SOURCE_DIR}/src/cimgui/cimgui.h
    DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/src/pygui
)
file(
    COPY        ${CMAKE_CURRENT_SOURCE_DIR}/src 
    DESTINATION ${PROJECT_BINARY_DIR}
)

# execute_process(
#     COMMAND python setup.py clean build_ext --build-lib .
#     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/src
# )

add_custom_target(
    generate_bindings ALL
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/__header.h
    # file(COPY        ${PROJECT_BINARY_DIR}/lib/
    #      DESTINATION ${PROJECT_BINARY_DIR}/src/pygui)
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:cimgui> ${PROJECT_BINARY_DIR}/src/pygui/cimgui.lib
    
    COMMAND python setup.py clean build_ext --build-lib .
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/src
)

# rm -r out; cmake -S . -B out/build
# cmake --build out/build --config RELEASE

# add_custom_target(generate_bindings ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/src)
# add_custom_command(
#     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/src
#     COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/src
#                                                ${CMAKE_CURRENT_BINARY_DIR}/src
#     DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/src/
# )

# Run Python to generate the source
# execute_process(COMMAND python model_creator.py --trial
#     WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})

# add_custom_target(
#     generate_bindings ALL
#     DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/__header.h
# )

# add_custom_command(
#     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/__header.h  # fake! ensure we run!
#     COMMAND python model_creator.py --trial
#     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/src/
# )

# add_custom_target(
#     generate_bindings ALL
#     DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/__header.h
#     COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/src ${CMAKE_CURRENT_BINARY_DIR}/src
#     COMMENT "Hello"
#     # DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/src
#     # COMMAND python model_creator.py --trial
#     #         WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/src/
# )