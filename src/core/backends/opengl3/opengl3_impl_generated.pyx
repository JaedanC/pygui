# distutils: language = c++
# cython: language_level = 3
# cython: embedsignature=True

import ctypes
import cython
import array
from cython.operator import dereference
from typing import Callable, Any, Sequence

cimport ccimgui_db
cimport ccimgui_opengl3
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
# ?returns(bool)
def impl_open_gl_3_create_device_objects():
    cdef bool res = ccimgui_opengl3.ImGui_ImplOpenGL3_CreateDeviceObjects()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_open_gl_3_create_fonts_texture():
    cdef bool res = ccimgui_opengl3.ImGui_ImplOpenGL3_CreateFontsTexture()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_destroy_device_objects():
    ccimgui_opengl3.ImGui_ImplOpenGL3_DestroyDeviceObjects()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_destroy_fonts_texture():
    ccimgui_opengl3.ImGui_ImplOpenGL3_DestroyFontsTexture()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_open_gl_3_init(glsl_version: str=None):
    cdef bool res = ccimgui_opengl3.ImGui_ImplOpenGL3_Init(
        _bytes(glsl_version)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_new_frame():
    ccimgui_opengl3.ImGui_ImplOpenGL3_NewFrame()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_render_draw_data(draw_data: ImDrawData=None):
    ccimgui_opengl3.ImGui_ImplOpenGL3_RenderDrawData(
        draw_data._ptr
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_shutdown():
    ccimgui_opengl3.ImGui_ImplOpenGL3_Shutdown()
# [End Function]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
cdef class ImDrawData:
    cdef ccimgui_opengl3.ImDrawData* _ptr
    
    @staticmethod
    cdef ImDrawData from_ptr(ccimgui_opengl3.ImDrawData* _ptr):
        cdef ImDrawData wrapper = ImDrawData.__new__(ImDrawData)
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
    # [End Class Constants]

# [End Class]

