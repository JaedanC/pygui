#ifndef _PYGUI_CONFIG_H
#define _PYGUI_CONFIG_H


#ifdef PYGUI_COMPILING_CIMGUI
#pragma message ( "Preprocessor: PYGUI_COMPILING_CIMGUI" )
#define IMGUI_API __declspec(dllexport)
// cimgui.h will automatically define CIMGUI_API to be the below
#define CIMGUI_API extern "C" __declspec(dllexport)
#endif

#ifdef PYGUI_COMPILING_GLFW
// The glfw implementation is in this dll
#define _GLFW_BUILD_DLL
#endif

#ifdef PYGUI_COMPILING_GLFW_IMPL
#pragma message ( "Preprocessor: PYGUI_COMPILING_GLFW_IMPL" )
// The glfw implementation is in another dll
#define GLFW_DLL
#define IMGUI_IMPL_API extern "C" __declspec(dllexport)
#define IMGUI_API __declspec(dllimport)
#endif

#ifdef PYGUI_COMPILING_APP
#pragma message ( "Preprocessor: PYGUI_COMPILING_APP" )
#define CIMGUI_USE_GLFW
#define CIMGUI_USE_OPENGL3
// So that we can interface with cimgui. This should not be moved since when
#define CIMGUI_DEFINE_ENUMS_AND_STRUCTS
#define CIMGUI_API __declspec(dllimport)
#endif


#endif //_PYGUI_CONFIG_H
