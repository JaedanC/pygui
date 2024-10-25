#ifdef PYGUI_COMPILING_DLL
#include "pygui_config.h"

#ifdef USE_CUSTOM_PYTHON_ERROR

    void init_exception()
    {
        if (!ImGuiError)
        {
            ImGuiError = PyErr_NewException("pygui.ImGuiError", NULL, NULL);
            Py_INCREF(ImGuiError);
        }
    }

    /**
     * ImGui does not throw exceptions when errors occur. By redefining the
     * IM_ASSERT macro we can at least get ImGui to throw a Python exception.
    */
    void __py_assert(const char* msg) {
        init_exception();
        
        // At first, set the Python exception state so we don't need to provide
        // custom exception translation function everywhere in Cython code
        // PyErr_SetString(PyExc_RuntimeError, msg);
        PyErr_SetString(ImGuiError, msg);

        // Throw anything so on the Cython side we can can catch it with
        // something like:
        //
        //     cdef extern from "cimgui.h":
        //         void PopStyleVar(int) except +
        throw msg;
    }

    /**
     * To then allow cython to see the newly created exception, we expose it in
     * a function accessable in the API.
    */
    CIMGUI_API PyObject* get_imgui_error()
    {
        init_exception();
        return ImGuiError;
    }
#else
    CIMGUI_API PyObject* get_imgui_error() { return nullptr; }
#endif //USE_CUSTOM_PYTHON_ERROR

#endif //PYGUI_COMPILING_CIMGUI