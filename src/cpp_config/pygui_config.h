#pragma once

// -----------------------------------------------------------------------------

#ifdef PYGUI_COMPILING_CIMGUI
#pragma message ( "Preprocessor: PYGUI_COMPILING_CIMGUI" )
#define CIMGUI_API extern "C" __declspec(dllexport)
#define IMGUI_API             __declspec(dllexport)

// TODO: Additional settings. The cimgui.json file won't see this change, so see
// if we find a way to change this value.
// #define ImDrawIdx      unsigned int
#define IMGUI_DISABLE_OBSOLETE_KEYIO
#define IMGUI_DISABLE_OBSOLETE_FUNCTIONS
// This shouldn't be required if you look at cimgui.h
// #define IMGUI_HAS_IMSTR false

extern "C" {
    #ifdef _DEBUG
    #undef _DEBUG
    #include <Python.h>
    #define _DEBUG
    #else
    #include <Python.h>
    #endif
}

CIMGUI_API PyObject* get_imgui_error();

    #ifdef USE_CUSTOM_PYTHON_ERROR

    // few macros to make IM_ASSERT cleaner
    #define STRINGIFY(x) #x
    #define TOSTRING(x) STRINGIFY(x)
    #define TOWRAP(x) "(" STRINGIFY(x) ")"
    #define AT __FILE__ ":" TOSTRING(__LINE__)

    // Redefine IM_ASSERT to raise Python specific exceptions
    // note: enabling asserts as Python exceptions guards us from
    //       possible segmentation faults when using functions that
    //       does not return error values. Especially when pushing/poping
    //       style stack variables.
    #pragma message ( "Preprocessor: Redefining IM_ASSERT to use Python" )
    #define IM_ASSERT(EX) (void)((EX) || (__py_assert ("ImGui assertion error (" #EX ") at " AT),0))

    static PyObject* ImGuiError = NULL;
    void __py_assert(const char* msg);

    #endif // USE_CUSTOM_PYTHON_ERROR
#endif // PYGUI_COMPILING_CIMGUI

// -----------------------------------------------------------------------------

#ifdef PYGUI_COMPILING_GLFW
// The glfw implementation is in this dll
#define _GLFW_BUILD_DLL
#endif // PYGUI_COMPILING_GLFW

// -----------------------------------------------------------------------------

#ifdef PYGUI_COMPILING_GLFW_IMPL
#pragma message ( "Preprocessor: PYGUI_COMPILING_GLFW_IMPL" )
// The glfw implementation is in another dll
#ifndef GLFW_DLL
#define GLFW_DLL
#endif
#define IMGUI_IMPL_API  extern "C" __declspec(dllexport)
#define IMGUI_API                  __declspec(dllimport)
#endif // PYGUI_COMPILING_GLFW_IMPL

// -----------------------------------------------------------------------------

#ifdef PYGUI_COMPILING_APP
#pragma message ( "Preprocessor: PYGUI_COMPILING_APP" )
// No need to include extern "C" because this is a C project. Extern is not
// supported in C. This means we also need to make sure the header file is C
// compatable.
#define CIMGUI_API      __declspec(dllimport)
#define IMGUI_IMPL_API  __declspec(dllimport)
#endif // PYGUI_COMPILING_APP

// -----------------------------------------------------------------------------

#ifdef PYGUI_COMPILING_CPP_APP
#pragma message ( "Preprocessor: PYGUI_COMPILING_CPP_APP" )

#ifndef GLFW_DLL
#define GLFW_DLL
#endif

#endif // PYGUI_COMPILING_CPP_APP
