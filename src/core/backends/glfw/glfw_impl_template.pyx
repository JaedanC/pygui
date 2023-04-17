# distutils: language = c++
# cython: language_level = 3
# cython: embedsignature=True

import ctypes
import cython
import array
from cython.operator import dereference
from typing import Callable, Any, Sequence

cimport ccimgui_db
cimport ccimgui_glfw
from cython.view cimport array as cvarray
from libcpp cimport bool
from libc.float cimport FLT_MIN as LIBC_FLT_MIN
from libc.float cimport FLT_MAX as LIBC_FLT_MAX
from libc.stdint cimport uintptr_t
from libc.string cimport strncpy

cdef bytes _bytes(str text):
    return text.encode()

cdef str _from_bytes(bytes text):
    return <str>(text.decode('utf-8', errors='ignore'))

cdef _cast_ImVec2_tuple(ccimgui_db.ImVec2 vec):
    return (vec.x, vec.y)

cdef ccimgui_db.ImVec2 _cast_tuple_ImVec2(pair) except +:
    cdef ccimgui_db.ImVec2 vec
    if len(pair) != 2:
        raise ValueError('pair param must be length of 2')
    vec.x, vec.y = pair
    return vec

cdef _cast_ImVec4_tuple(ccimgui_db.ImVec4 vec):
    return (vec.x, vec.y, vec.z, vec.w)

cdef ccimgui_db.ImVec4 _cast_tuple_ImVec4(quadruple):
    cdef ccimgui_db.ImVec4 vec
    if len(quadruple) != 4:
        raise ValueError('quadruple param must be length of 4')

    vec.x, vec.y, vec.z, vec.w = quadruple
    return vec


def _py_vertex_buffer_vertex_pos_offset():
    return <uintptr_t><size_t>&(<ccimgui_db.ImDrawVert*>NULL).pos

def _py_vertex_buffer_vertex_uv_offset():
    return <uintptr_t><size_t>&(<ccimgui_db.ImDrawVert*>NULL).uv

def _py_vertex_buffer_vertex_col_offset():
    return <uintptr_t><size_t>&(<ccimgui_db.ImDrawVert*>NULL).col

def _py_vertex_buffer_vertex_size():
    return sizeof(ccimgui_db.ImDrawVert)

def _py_index_buffer_index_size():
    return sizeof(ccimgui_db.ImDrawIdx)


cdef class BoolPtr:
    cdef public bool value

    def __init__(self, initial_value: bool):
        self.ptr: bool = initial_value

    def __bool__(self):
        return self.ptr

cdef class IntPtr:
    cdef public int value

    def __init__(self, initial_value: int):
        self.value: int = initial_value


cdef class FloatPtr:
    cdef public float value

    def __init__(self, initial_value: float):
        self.value = initial_value


cdef class DoublePtr:
    cdef public double value

    def __init__(self, initial_value: float):
        self.value = initial_value


cdef class StrPtr:
    cdef char* buffer
    cdef public int buffer_size

    def __init__(self, initial_value: str, buffer_size=256):
        self.buffer = <char*>ccimgui_db.ImGui_MemAlloc(buffer_size)
        self.buffer_size: int = buffer_size
        self.value = initial_value

    def __dealloc__(self):
        ccimgui_db.ImGui_MemFree(self.buffer)

    @property
    def value(self):
        return _from_bytes(self.buffer)
    @value.setter
    def value(self, value: str):
        strncpy(self.buffer, _bytes(value), self.buffer_size - 1)
        self.buffer[min((self.buffer_size - 1), len(value))] = 0


cdef class Vec2Ptr:
    cdef public FloatPtr _x
    cdef public FloatPtr _y

    def __init__(self, x: float, y: float):
        self._x = FloatPtr(x)
        self._y = FloatPtr(y)

    @property
    def x(self):
        return self._x.value
    @x.setter
    def x(self, x):
        self._x.value = x
    @property
    def y(self):
        return self._y.value
    @y.setter
    def y(self, y):
        self._y.value = y

    def from_floatptrs(self, float_ptrs: Sequence[FloatPtr]):
        assert len(float_ptrs) >= 2
        self._x = float_ptrs[0]
        self._y = float_ptrs[1]

    def as_floatptrs(self) -> Sequence[FloatPtr]:
        return [
            self._x,
            self._y,
        ]

    def vec(self) -> Sequence[float]:
        return (
            self.x,
            self.y,
        )

    def copy(self) -> Vec2Ptr:
        return Vec2Ptr(*self.vec())

    cdef void from_array(self, float* array):
        self._x.value = array[0]
        self._y.value = array[1]

    cdef void to_array(self, float* array):
        array[0] = self.x
        array[1] = self.y


cdef class Vec4Ptr:
    cdef public FloatPtr _x
    cdef public FloatPtr _y
    cdef public FloatPtr _z
    cdef public FloatPtr _w

    def __init__(self, x: float, y: float, z: float, w: float):
        self._x = FloatPtr(x)
        self._y = FloatPtr(y)
        self._z = FloatPtr(z)
        self._w = FloatPtr(w)

    @property
    def x(self):
        return self._x.value
    @x.setter
    def x(self, x):
        self._x.value = x
    @property
    def y(self):
        return self._y.value
    @y.setter
    def y(self, y):
        self._y.value = y
    @property
    def z(self):
        return self._z.value
    @z.setter
    def z(self, z):
        self._z.value = z
    @property
    def w(self):
        return self._w.value
    @w.setter
    def w(self, w):
        self._w.value = w

    def from_floatptrs(self, float_ptrs: Sequence[FloatPtr]):
        assert len(float_ptrs) >= 4
        self._x = float_ptrs[0]
        self._y = float_ptrs[1]
        self._z = float_ptrs[2]
        self._w = float_ptrs[3]

    def as_floatptrs(self) -> Sequence[FloatPtr]:
        return [
            self._x,
            self._y,
            self._z,
            self._w,
        ]

    def vec(self) -> Sequence[float]:
        return (
            self.x,
            self.y,
            self.z,
            self.w,
        )

    def copy(self) -> Vec4Ptr:
        return Vec4Ptr(*self.vec())

    cdef void from_array(self, float* array):
        self._x.value = array[0]
        self._y.value = array[1]
        self._z.value = array[2]
        self._w.value = array[3]

    cdef void to_array(self, float* array):
        array[0] = self.x
        array[1] = self.y
        array[2] = self.z
        array[3] = self.w


def IM_COL32(int r, int g, int b, int a) -> int:
    cdef unsigned int output = 0
    output |= a << 24
    output |= b << 16
    output |= g << 8
    output |= r << 0
    return output

FLT_MIN = LIBC_FLT_MIN
FLT_MAX = LIBC_FLT_MAX
IMGUI_PAYLOAD_TYPE_COLOR_3F = "_COL3F"
IMGUI_PAYLOAD_TYPE_COLOR_4F = "_COL4F"
IM_COL32_WHITE        = IM_COL32(255, 255, 255, 255)   # Opaque white = 0xFFFFFFFF
IM_COL32_BLACK        = IM_COL32(0, 0, 0, 255)         # Opaque black
IM_COL32_BLACK_TRANS  = IM_COL32(0, 0, 0, 0)




# ---- Start Generated Content ----

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_char_callback(window: GLFWwindow=None, c: int=None):
    ccimgui_glfw.ImGui_ImplGlfw_CharCallback(
        window._ptr,
        c
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_cursor_enter_callback(window: GLFWwindow=None, entered: int=None):
    ccimgui_glfw.ImGui_ImplGlfw_CursorEnterCallback(
        window._ptr,
        entered
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_cursor_pos_callback(window: GLFWwindow=None, x: float=None, y: float=None):
    ccimgui_glfw.ImGui_ImplGlfw_CursorPosCallback(
        window._ptr,
        x,
        y
    )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?returns(bool)
def impl_glfw_init_for_open_gl(window, install_callbacks: bool):
    cdef uintptr_t adr = <uintptr_t>ctypes.addressof(window.contents)
    cdef bool res = ccimgui_glfw.ImGui_ImplGlfw_InitForOpenGL(<ccimgui_glfw.GLFWwindow*>adr, install_callbacks)
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_glfw_init_for_other(window: GLFWwindow=None, install_callbacks: bool=None):
    cdef bool res = ccimgui_glfw.ImGui_ImplGlfw_InitForOther(
        window._ptr,
        install_callbacks
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_glfw_init_for_vulkan(window: GLFWwindow=None, install_callbacks: bool=None):
    cdef bool res = ccimgui_glfw.ImGui_ImplGlfw_InitForVulkan(
        window._ptr,
        install_callbacks
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_install_callbacks(window: GLFWwindow=None):
    ccimgui_glfw.ImGui_ImplGlfw_InstallCallbacks(
        window._ptr
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_key_callback(window: GLFWwindow=None, key: int=None, scancode: int=None, action: int=None, mods: int=None):
    ccimgui_glfw.ImGui_ImplGlfw_KeyCallback(
        window._ptr,
        key,
        scancode,
        action,
        mods
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_monitor_callback(monitor: GLFWmonitor=None, event: int=None):
    ccimgui_glfw.ImGui_ImplGlfw_MonitorCallback(
        monitor._ptr,
        event
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_mouse_button_callback(window: GLFWwindow=None, button: int=None, action: int=None, mods: int=None):
    ccimgui_glfw.ImGui_ImplGlfw_MouseButtonCallback(
        window._ptr,
        button,
        action,
        mods
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?returns(None)
def impl_glfw_new_frame():
    ccimgui_glfw.ImGui_ImplGlfw_NewFrame()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_restore_callbacks(window: GLFWwindow=None):
    ccimgui_glfw.ImGui_ImplGlfw_RestoreCallbacks(
        window._ptr
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_scroll_callback(window: GLFWwindow=None, xoffset: float=None, yoffset: float=None):
    ccimgui_glfw.ImGui_ImplGlfw_ScrollCallback(
        window._ptr,
        xoffset,
        yoffset
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_set_callbacks_chain_for_all_windows(chain_for_all_windows: bool=None):
    ccimgui_glfw.ImGui_ImplGlfw_SetCallbacksChainForAllWindows(
        chain_for_all_windows
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?returns(None)
def impl_glfw_shutdown():
    ccimgui_glfw.ImGui_ImplGlfw_Shutdown()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_window_focus_callback(window: GLFWwindow=None, focused: int=None):
    ccimgui_glfw.ImGui_ImplGlfw_WindowFocusCallback(
        window._ptr,
        focused
    )
# [End Function]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(False)
cdef class GLFWmonitor:
    cdef ccimgui_glfw.GLFWmonitor* _ptr
    
    @staticmethod
    cdef GLFWmonitor from_ptr(ccimgui_glfw.GLFWmonitor* _ptr):
        cdef GLFWmonitor wrapper = GLFWmonitor.__new__(GLFWmonitor)
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
    # [End Class Constants]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(False)
cdef class GLFWwindow:
    cdef ccimgui_glfw.GLFWwindow* _ptr
    
    @staticmethod
    cdef GLFWwindow from_ptr(ccimgui_glfw.GLFWwindow* _ptr):
        cdef GLFWwindow wrapper = GLFWwindow.__new__(GLFWwindow)
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
    # [End Class Constants]
# [End Class]

