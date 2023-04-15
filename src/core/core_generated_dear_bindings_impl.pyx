
# distutils: language = c++
# cython: language_level = 3
# cython: embedsignature=True

# [Imports]
import cython
import ctypes
import array
from cython.operator import dereference
from typing import Callable, Any, Sequence

cimport ccimgui_dear_bindings_impl
from cython.view cimport array as cvarray
from libcpp cimport bool
from libc.float cimport FLT_MIN as LIBC_FLT_MIN
from libc.float cimport FLT_MAX as LIBC_FLT_MAX
from libc.stdint cimport uintptr_t
from libc.string cimport strncpy
# [End Imports]
# [Enums]
# [End Enums]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_glfw_init_for_vulkan(window: GLFWwindow, install_callbacks: bool):
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplGlfw_InitForVulkan(
        window,
        install_callbacks
    )
    return res
# [End Function]

# [Class]
# [Class Constants]
# ?use_template(False)
cdef class GLFWwindow:
    cdef ccimgui_dear_bindings_impl.GLFWwindow* _ptr
    
    @staticmethod
    cdef GLFWwindow from_ptr(ccimgui_dear_bindings_impl.GLFWwindow* _ptr):
        cdef GLFWwindow wrapper = GLFWwindow.__new__(GLFWwindow)
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
    # [End Class Constants]

# [End Class]


