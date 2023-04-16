
# distutils: language = c++
# cython: language_level = 3
# cython: embedsignature=True

# [Imports]
import ctypes
from typing import Callable, Any, Sequence

cimport ccimgui_dear_bindings_impl
from libcpp cimport bool
from libc.float cimport FLT_MIN as LIBC_FLT_MIN
from libc.float cimport FLT_MAX as LIBC_FLT_MAX
from libc.stdint cimport uintptr_t
from libc.string cimport strncpy
# [End Imports]


# [Constant Functions]
cdef bytes _bytes(str text):
    return text.encode()

cdef str _from_bytes(bytes text):
    return <str>(text.decode('utf-8', errors='ignore'))

cdef _cast_ImVec2_tuple(ccimgui_dear_bindings_impl.ImVec2 vec):
    return (vec.x, vec.y)

cdef ccimgui_dear_bindings_impl.ImVec2 _cast_tuple_ImVec2(pair) except +:
    cdef ccimgui_dear_bindings_impl.ImVec2 vec
    if len(pair) != 2:
        raise ValueError('pair param must be length of 2')
    vec.x, vec.y = pair
    return vec

cdef _cast_ImVec4_tuple(ccimgui_dear_bindings_impl.ImVec4 vec):
    return (vec.x, vec.y, vec.z, vec.w)

cdef ccimgui_dear_bindings_impl.ImVec4 _cast_tuple_ImVec4(quadruple):
    cdef ccimgui_dear_bindings_impl.ImVec4 vec
    if len(quadruple) != 4:
        raise ValueError('quadruple param must be length of 4')

    vec.x, vec.y, vec.z, vec.w = quadruple
    return vec


def _py_vertex_buffer_vertex_pos_offset():
    return <uintptr_t><size_t>&(<ccimgui_dear_bindings_impl.ImDrawVert*>NULL).pos

def _py_vertex_buffer_vertex_uv_offset():
    return <uintptr_t><size_t>&(<ccimgui_dear_bindings_impl.ImDrawVert*>NULL).uv

def _py_vertex_buffer_vertex_col_offset():
    return <uintptr_t><size_t>&(<ccimgui_dear_bindings_impl.ImDrawVert*>NULL).col

def _py_vertex_buffer_vertex_size():
    return sizeof(ccimgui_dear_bindings_impl.ImDrawVert)

def _py_index_buffer_index_size():
    return sizeof(ccimgui_dear_bindings_impl.ImDrawIdx)


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
        self.buffer = <char*>ccimgui_dear_bindings_impl.igMemAlloc(buffer_size)
        self.buffer_size: int = buffer_size
        self.value = initial_value

    def __dealloc__(self):
        ccimgui_dear_bindings_impl.igMemFree(self.buffer)

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

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_glfw_init_for_other(window: GLFWwindow, install_callbacks: bool):
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplGlfw_InitForOther(
        window,
        install_callbacks
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_shutdown():
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_Shutdown()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_new_frame():
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_NewFrame()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_install_callbacks(window: GLFWwindow):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_InstallCallbacks(
        window
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_restore_callbacks(window: GLFWwindow):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_RestoreCallbacks(
        window
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_set_callbacks_chain_for_all_windows(chain_for_all_windows: bool):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_SetCallbacksChainForAllWindows(
        chain_for_all_windows
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_window_focus_callback(window: GLFWwindow, focused: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_WindowFocusCallback(
        window,
        focused
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_cursor_enter_callback(window: GLFWwindow, entered: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_CursorEnterCallback(
        window,
        entered
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_cursor_pos_callback(window: GLFWwindow, x: float, y: float):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_CursorPosCallback(
        window,
        x,
        y
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_mouse_button_callback(window: GLFWwindow, button: int, action: int, mods: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_MouseButtonCallback(
        window,
        button,
        action,
        mods
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_scroll_callback(window: GLFWwindow, xoffset: float, yoffset: float):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_ScrollCallback(
        window,
        xoffset,
        yoffset
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_key_callback(window: GLFWwindow, key: int, scancode: int, action: int, mods: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_KeyCallback(
        window,
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
def impl_glfw_char_callback(window: GLFWwindow, c: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_CharCallback(
        window,
        c
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_monitor_callback(monitor: GLFWmonitor, event: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_MonitorCallback(
        monitor,
        event
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_open_gl_3_init(glsl_version: str):
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_Init(
        _bytes(glsl_version)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_shutdown():
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_Shutdown()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_new_frame():
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_NewFrame()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_render_draw_data(draw_data: ImDrawData):
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_RenderDrawData(
        draw_data
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_open_gl_3_create_fonts_texture():
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_CreateFontsTexture()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_destroy_fonts_texture():
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_DestroyFontsTexture()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_open_gl_3_create_device_objects():
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_CreateDeviceObjects()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_destroy_device_objects():
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_DestroyDeviceObjects()
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


# [Class]
# [Class Constants]
# ?use_template(False)
cdef class GLFWmonitor:
    cdef ccimgui_dear_bindings_impl.GLFWmonitor* _ptr
    
    @staticmethod
    cdef GLFWmonitor from_ptr(ccimgui_dear_bindings_impl.GLFWmonitor* _ptr):
        cdef GLFWmonitor wrapper = GLFWmonitor.__new__(GLFWmonitor)
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
    # [End Class Constants]

# [End Class]


# [Class]
# [Class Constants]
# ?use_template(False)
cdef class ImDrawData:
    cdef ccimgui_dear_bindings_impl.ImDrawData* _ptr
    
    @staticmethod
    cdef ImDrawData from_ptr(ccimgui_dear_bindings_impl.ImDrawData* _ptr):
        cdef ImDrawData wrapper = ImDrawData.__new__(ImDrawData)
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
    # [End Class Constants]

# [End Class]


