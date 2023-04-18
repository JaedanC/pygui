#ifndef _PYGUI_CONFIG_H
#define _PYGUI_CONFIG_H


#ifdef PYGUI_COMPILING_CIMGUI
#pragma message ( "Preprocessor: PYGUI_COMPILING_CIMGUI" )
#define CIMGUI_API extern "C" __declspec(dllexport)
#define IMGUI_API             __declspec(dllexport)
#endif

#ifdef PYGUI_COMPILING_GLFW
// The glfw implementation is in this dll
#define _GLFW_BUILD_DLL
#endif

#ifdef PYGUI_COMPILING_GLFW_IMPL
#pragma message ( "Preprocessor: PYGUI_COMPILING_GLFW_IMPL" )
// The glfw implementation is in another dll
#define GLFW_DLL
#define IMGUI_IMPL_API  extern "C" __declspec(dllexport)
#define IMGUI_API                  __declspec(dllimport)
#endif

#ifdef PYGUI_COMPILING_APP
#pragma message ( "Preprocessor: PYGUI_COMPILING_APP" )
// No need to include extern "C" because this is a C project. Extern is not
// supported in C. This means we also need to make sure the header file is C
// compatable.
#define CIMGUI_API      __declspec(dllimport)
#define IMGUI_IMPL_API  __declspec(dllimport)

// TODO: Additional settings. The cimgui.json file won't see this change, so see
// if we find a way to change this value.
// #define ImDrawIdx      unsigned int
#define IMGUI_DISABLE_OBSOLETE_KEYIO
#define IMGUI_DISABLE_OBSOLETE_FUNCTIONS
// This shouldn't be required if you look at cimgui.h
// #define IMGUI_HAS_IMSTR false
#endif


#endif //_PYGUI_CONFIG_H
