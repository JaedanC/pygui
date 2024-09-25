#pragma once

#define IMGUI_DISABLE_OBSOLETE_KEYIO
#define IMGUI_DISABLE_OBSOLETE_FUNCTIONS

// -----------------------------------------------------------------------------

#ifdef PYGUI_COMPILING_DLL
#pragma message ( "Preprocessor: PYGUI_COMPILING_DLL" )
// The glfw implementation is in another dll
#ifndef GLFW_DLL
#define GLFW_DLL
#endif

#define CIMGUI_API      __declspec(dllexport)
#define CIMGUI_IMPL_API __declspec(dllexport)

// If you are compiling any additional modules then make sure you export the
// functions in the DLL like below
// #define MY_EXTENSION_API __declspec(dllexport)


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

#endif // PYGUI_COMPILING_DLL

// -----------------------------------------------------------------------------

#ifdef PYGUI_COMPILING_DLL_APP
#pragma message ( "Preprocessor: PYGUI_COMPILING_DLL_APP" )

#define CIMGUI_API       __declspec(dllimport)
#define CIMGUI_IMPL_API  __declspec(dllimport)
// And likewise, to test the module make sure you import the functions from the
// DLL like below
// #define MY_EXTENSION_API __declspec(dllimport)

#endif // PYGUI_COMPILING_DLL_APP
