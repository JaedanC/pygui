#pragma once

#ifndef CIMGUI_API
#define CIMGUI_API
#endif

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
    // #pragma message ( "Preprocessor: Redefining IM_ASSERT to use Python" )
    #define IM_ASSERT(EX) (void)((EX) || (__py_assert ("ImGui assertion error (" #EX ") at " AT),0))

    static PyObject* ImGuiError = NULL;
    void __py_assert(const char* msg);

#endif // USE_CUSTOM_PYTHON_ERROR
