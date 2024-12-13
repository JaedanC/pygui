import textwrap
from typing import List, Callable, Optional, Tuple
from io import StringIO
from ..template import Template
from . import pythonise_string
from .interfaces import *
from .db_type import _Type, Kinds, Kind
from .enum import _Enum
from .function import Function
from .struct import Struct
from .typedef import Typedef


PYX_TEMPLATE_MARKER = "# ---- Start Generated Content ----\n\n"


def passes_conditional(json_with_conditional, definitions, verbose=False):
    def is_defined(expression, definitions):
        for define, _ in definitions:
            if expression == define:
                return True
        return False

    def is_true(expression, definitions):
        for define, value in definitions:
            if expression == define:
                return value
        return False

    if "conditionals" not in json_with_conditional:
        return True

    conditional_list = json_with_conditional["conditionals"]

    if verbose:
        print(conditional_list, end=" ")

    for conditional_obj in conditional_list:
        condition, expression = conditional_obj.values()
        if condition == "ifndef" and not is_defined(expression, definitions):
            continue

        if condition == "ifdef" and is_defined(expression, definitions):
            continue

        if condition == "if":
            if "defined" in expression or is_true(expression, definitions):
                continue

        if verbose:
            print("Failed")
        return False
    if verbose:
        print("Failed")
    return True


def ignore_anonymous(json_: dict | str):
    if not isinstance(json_, dict):
        return True

    if json_.get("is_anonymous"):
        return False
    return True


def deep_json_filter(_json: dict | list, func: Callable, *args, **kwargs):
    def __recurse_dict(_dict: dict, func: Callable, *args, **kwargs):
        # Go through each key and run deep_json_filter on it
        for key in _dict.keys():
            _dict[key] = deep_json_filter(_dict[key], func, *args, **kwargs)
        return _dict

    def __recurse_list(_list: list, func: Callable, *args, **kwargs):
        # Modify the list in-place
        _list[:] = [i for i in _list if func(i, *args, **kwargs)]
        for item in _list:
            deep_json_filter(item, func, *args, **kwargs)
        return _list

    if isinstance(_json, dict):
        return __recurse_dict(_json, func, *args, **kwargs)
    if isinstance(_json, list):
        return __recurse_list(_json, func, *args, **kwargs)
    return _json


class Binding(IBinding):
    @staticmethod
    def from_json(dcimgui_json, pxd_header: str, definitions: List[Tuple[str, bool]]):
        dcimgui_json = deep_json_filter(dcimgui_json, passes_conditional, definitions)
        dcimgui_json = deep_json_filter(dcimgui_json, ignore_anonymous)

        enums = [_Enum.from_json(e) for e in dcimgui_json["enums"]]
        typedefs = [Typedef.from_json(e) for e in dcimgui_json["typedefs"]]
        structs = [Struct.from_json(e) for e in dcimgui_json["structs"]]
        functions = []

        methods: List[IFunction] = []
        for function in dcimgui_json["functions"]:
            function = Function.from_json(function)
            if len(function.get_arguments()) > 0 and function.get_arguments()[0].get_name() == "self":
                methods.append(function)
                continue
            functions.append(function)

        struct_lookup = {s.get_name(): s for s in structs}
        for method in methods:
            method: IFunction
            class_name = method.get_arguments()[0].get_type().with_no_const_or_asterisk()
            # Modify the name of the function so that it looks more like a
            # method.
            method.set_python_name(method.get_python_name().replace(class_name + "_", "", 1))
            struct_lookup[class_name].add_method(method)

        return Binding(enums, typedefs, structs, functions, pxd_header)

    def __init__(
            self,
            enums: List[IEnum],
            typedefs: List[ITypedef],
            structs: List[IStruct],
            functions: List[IFunction],
            pxd_header: str
        ):
        self.enums: List[IEnum] = enums
        self.typedefs: List[ITypedef] = typedefs
        self.structs: List[IStruct] = structs
        self.functions: List[IFunction] = functions
        self.pxd_header: str = pxd_header

    def to_pxd(self, include_base: bool) -> str:
        base = """
        # -*- coding: utf-8 -*-
        # distutils: language = c++

        from libcpp cimport bool

        cdef extern from "Python.h":
            ctypedef struct PyObject

        cdef extern from "pygui_config.h":
            PyObject* get_imgui_error()

        """
        dynamic_content = StringIO("")
        if include_base:
            dynamic_content.write(textwrap.dedent(base.lstrip("\n")))

        dynamic_content.write('cdef extern from "{}":\n'.format(self.pxd_header))

        # Struct forward declaration
        # You might think you could use this value but some typedefs require all
        # the structs to be forward declared. So we can just be safe and do them
        # all.
        for struct in self.structs:
            dynamic_content.write(textwrap.indent(struct.to_pxd_foward_declaration(), "    "))
            dynamic_content.write("\n")
        dynamic_content.write("\n")

        # Typedefs. TODO: This should probably be in a separate class. (List of typedefs)
        longest_typedef = 0
        longest_fn_typedef = 0
        for typedef in self.typedefs:
            if typedef.is_function_pointer():
                longest_fn_typedef = max(longest_typedef, len(typedef.to_pxd()))
            else:
                longest_typedef = max(longest_typedef, len(typedef.to_pxd()))

        for typedef in self.typedefs:
            comment_text = typedef.get_comment().hash_proceeding_only()
            if comment_text is not None:
                dynamic_content.write("\n")
                dynamic_content.write(textwrap.indent(comment_text, "    "))
                dynamic_content.write("\n")

            dynamic_content.write(textwrap.indent(typedef.to_pxd(), "    "))

            comment_text = typedef.get_comment().hash_attached_only()
            if comment_text is not None:
                if typedef.is_function_pointer():
                    dynamic_content.write(" " * (longest_fn_typedef - len(typedef.to_pxd()) + 5))
                else:
                    dynamic_content.write(" " * (longest_typedef - len(typedef.to_pxd()) + 5))
                dynamic_content.write(comment_text)

            dynamic_content.write("\n")
        dynamic_content.write("\n")

        for enum in self.enums:
            dynamic_content.write(textwrap.indent(enum.to_pxd(), "    "))
            dynamic_content.write("\n")
        dynamic_content.write("\n")

        for struct in self.structs:
            dynamic_content.write(textwrap.indent(struct.to_pxd(), "    "))
            dynamic_content.write("\n")
        dynamic_content.write("\n")

        for function in self.functions:
            dynamic_content.write(textwrap.indent(function.to_pxd(), "    "))
            dynamic_content.write("\n")
        dynamic_content.write("\n")

        return dynamic_content.getvalue()

    def to_pyx(
            self,
            pxd_library_name: str,
            include_base: bool,
            class_base: str,
            function_base: str,
            field_base: str
        ) -> str:
        # TODO: Sort?
        base = '''
        # distutils: language = c++
        # cython: language_level = 3
        # cython: embedsignature=True

        import ctypes
        import cython
        import array
        from collections import namedtuple
        from cython.operator import dereference
        from typing import Callable, Any, Sequence, Tuple, NamedTuple, Optional

        cimport dcimgui
        from libcpp cimport bool
        from libc.stdint cimport uintptr_t
        from libc.stdlib cimport malloc, free
        from libc.string cimport strncpy, memset
        from libc.float cimport FLT_MIN as LIBC_FLT_MIN
        from libc.float cimport FLT_MAX as LIBC_FLT_MAX
        from libc.limits cimport INT_MIN as LIBC_INT_MIN
        from libc.limits cimport INT_MAX as LIBC_INT_MAX
        from libc.limits cimport UINT_MAX as LIBC_UINT_MAX
        from libc.limits cimport LLONG_MIN as LIBC_LLONG_MIN
        from libc.limits cimport LLONG_MAX as LIBC_LLONG_MAX
        from libc.limits cimport ULLONG_MAX as LIBC_ULLONG_MAX

        FLT_MIN = LIBC_FLT_MIN
        FLT_MAX = LIBC_FLT_MAX
        INT_MIN = LIBC_INT_MIN
        INT_MAX = LIBC_INT_MAX
        UINT_MAX = LIBC_UINT_MAX
        LLONG_MIN = LIBC_LLONG_MIN
        LLONG_MAX = LIBC_LLONG_MAX
        ULLONG_MAX = LIBC_ULLONG_MAX

        # Used purely to allow for .x and .y notation on any of the tuples returned
        # by the _cast_ImVec2_tuple style functions. The included pygui examples does
        # not use this behaviour. It instead assumes that it is just a tuple. This
        # features mainly exists to prevent any accidents when translating ImGui code
        # to pygui.
        # Vec2Tuple = namedtuple("Vec2", "x y")
        # Vec4Tuple = namedtuple("Vec4", "x y z w")

        cdef void* _pygui_malloc(size_t sz, void* user_data) noexcept:
            return malloc(sz)

        cdef void _pygui_free(void* ptr, void* user_data) noexcept:
            free(ptr)

        cdef bytes _bytes(str text):
            return text.encode()

        cdef str _from_bytes(bytes text):
            return <str>(text.decode('utf-8', errors='ignore'))

        cdef _cast_ImVec2_tuple({pxd_library_name}.ImVec2 vec):
            return (vec.x, vec.y)

        cdef {pxd_library_name}.ImVec2 _cast_tuple_ImVec2(pair):
            cdef {pxd_library_name}.ImVec2 vec
            if len(pair) != 2:
                raise ValueError('pair param must be length of 2')
            vec.x, vec.y = pair
            return vec

        cdef _cast_ImVec4_tuple({pxd_library_name}.ImVec4 vec):
            return (vec.x, vec.y, vec.z, vec.w)

        cdef {pxd_library_name}.ImVec4 _cast_tuple_ImVec4(quadruple):
            cdef {pxd_library_name}.ImVec4 vec
            if len(quadruple) != 4:
                raise ValueError('quadruple param must be length of 4')

            vec.x, vec.y, vec.z, vec.w = quadruple
            return vec


        cdef class Bool:
            @staticmethod
            cdef bool* ptr(ptr: Bool):
                return <bool*>(NULL if ptr is None else <void*>(&ptr.value))

            cdef public bool value

            def __init__(self, initial_value: bool):
                self.value: bool = initial_value

            def __bool__(self):
                return self.value


        cdef class Int:
            @staticmethod
            cdef int* ptr(ptr: Int):
                return <int*>(NULL if ptr is None else <void*>(&ptr.value))

            cdef public int value

            def __init__(self, initial_value: int=0):
                self.value: int = initial_value

        cdef class Long:
            @staticmethod
            cdef long long* ptr(ptr: Long):
                return <long long*>(NULL if ptr is None else <void*>(&ptr.value))

            cdef public long long value

            def __init__(self, initial_value: int=0):
                self.value: int = initial_value


        cdef class Float:
            @staticmethod
            cdef float* ptr(ptr: Float):
                return <float*>(NULL if ptr is None else <void*>(&ptr.value))

            cdef public float value

            def __init__(self, initial_value: float=0.0):
                self.value = initial_value


        cdef class Double:
            @staticmethod
            cdef double* ptr(ptr: Double):
                return <double*>(NULL if ptr is None else <void*>(&ptr.value))

            cdef public double value

            def __init__(self, initial_value: float=0.0):
                self.value = initial_value


        cdef class String:
            cdef char* buffer
            cdef unsigned int _buffer_size

            def __cinit__(self, initial_value: str="", buffer_size=256):
                IM_ASSERT(buffer_size > 0)
                self.buffer = <char*>{pxd_library_name}.ImGui_MemAlloc(buffer_size)
                if self.buffer == NULL:
                    raise MemoryError()
                self._buffer_size: int = buffer_size
                self.value = initial_value

            def __dealloc__(self):
                {pxd_library_name}.ImGui_MemFree(self.buffer)

            @property
            def buffer_size(self) -> int:
                return self._buffer_size
            @buffer_size.setter
            def buffer_size(self, value: int):
                raise NotImplementedError

            @property
            def value(self):
                return _from_bytes(self.buffer)
            @value.setter
            def value(self, value: str):
                # Remember: len(bytes(str)) != len(str)
                # So to mark the end of the string, you should use the len(bytes).
                c_bytes = _bytes(value)
                n_bytes = len(c_bytes)
                strncpy(self.buffer, c_bytes, self._buffer_size)
                self.buffer[min(n_bytes, self._buffer_size - 1)] = 0


        cdef class Vec2:
            cdef public Float x_ptr
            cdef public Float y_ptr
            cdef int _n

            def __init__(self, x: float, y: float):
                self.x_ptr = Float(x)
                self.y_ptr = Float(y)

            def __add__(self, other: Vec2):
                return Vec2(
                    self.x + other.x,
                    self.y + other.y,
                )

            def __sub__(self, other: Vec2):
                return Vec2(
                    self.x - other.x,
                    self.y - other.y,
                )

            def __eq__(self, other: Vec2):
                return self.x == other.x \\
                    and self.y == other.y

            def __len__(self):
                return 2

            def __getitem__(self, index: int):
                return self.tuple()[index]

            def __iter__(self):
                self._n = -1
                return self

            def __next__(self):
                self._n += 1
                if self._n == 0:
                    return self.x
                elif self._n == 1:
                    return self.y
                raise StopIteration

            def __repr__(self):
                return f"Vec2({{self.x}}, {{self.y}})"

            @staticmethod
            def zero():
                return Vec2(0, 0)

            @property
            def x(self):
                return self.x_ptr.value
            @x.setter
            def x(self, x):
                self.x_ptr.value = x
            @property
            def y(self):
                return self.y_ptr.value
            @y.setter
            def y(self, y):
                self.y_ptr.value = y

            def from_floatptrs(self, float_ptrs: Sequence[Float, Float]) -> Vec2:
                IM_ASSERT(len(float_ptrs) >= 2, "Must be a sequence of length 2")
                self.x_ptr = float_ptrs[0]
                self.y_ptr = float_ptrs[1]
                return self

            def as_floatptrs(self) -> Sequence[Float, Float]:
                return (
                    self.x_ptr,
                    self.y_ptr,
                )

            def tuple(self) -> Sequence[float, float]:
                return (
                    self.x,
                    self.y,
                )

            def from_tuple(self, vec: Sequence[float, float]) -> Vec2:
                if len(vec) < 2:
                    raise IndexError

                self.x = vec[0]
                self.y = vec[1]
                return self

            def copy(self) -> Vec2:
                return Vec2(*self.tuple())


            cdef void from_array(self, float* array):
                self.x_ptr.value = array[0]
                self.y_ptr.value = array[1]

            cdef void to_array(self, float* array):
                array[0] = self.x_ptr.value
                array[1] = self.y_ptr.value


        cdef class Vec4:
            cdef public Float x_ptr
            cdef public Float y_ptr
            cdef public Float z_ptr
            cdef public Float w_ptr

            def __init__(self, x: float, y: float, z: float, w: float):
                self.x_ptr = Float(x)
                self.y_ptr = Float(y)
                self.z_ptr = Float(z)
                self.w_ptr = Float(w)

            def __add__(self, other: Vec4):
                return Vec4(
                    self.x + other.x,
                    self.y + other.y,
                    self.z + other.z,
                    self.w + other.w,
                )

            def __sub__(self, other: Vec4):
                return Vec2(
                    self.x - other.x,
                    self.y - other.y,
                    self.z - other.z,
                    self.w - other.w,
                )

            def __eq__(self, other: Vec2):
                return self.x == other.x \\
                    and self.y == other.y \\
                    and self.z == other.z \\
                    and self.w == other.w \\

            def __len__(self):
                return 4

            def __getitem__(self, index: int):
                return self.tuple()[index]

            def __iter__(self):
                self._n = -1
                return self

            def __next__(self):
                self._n += 1
                if self._n == 0:
                    return self.x
                elif self._n == 1:
                    return self.y
                elif self._n == 2:
                    return self.z
                elif self._n == 3:
                    return self.w
                raise StopIteration

            def __repr__(self):
                return f"Vec4({{self.x}}, {{self.y}}, {{self.z}}, {{self.w}})"

            @staticmethod
            def zero():
                return Vec4(0, 0, 0, 0)

            @property
            def x(self):
                return self.x_ptr.value
            @x.setter
            def x(self, x):
                self.x_ptr.value = x
            @property
            def y(self):
                return self.y_ptr.value
            @y.setter
            def y(self, y):
                self.y_ptr.value = y
            @property
            def z(self):
                return self.z_ptr.value
            @z.setter
            def z(self, z):
                self.z_ptr.value = z
            @property
            def w(self):
                return self.w_ptr.value
            @w.setter
            def w(self, w):
                self.w_ptr.value = w

            def from_floatptrs(self, float_ptrs: Sequence[Float, Float, Float, Float]) -> Vec4:
                IM_ASSERT(len(float_ptrs) >= 4, "Must be a sequence of length 4")
                self.x_ptr = float_ptrs[0]
                self.y_ptr = float_ptrs[1]
                self.z_ptr = float_ptrs[2]
                self.w_ptr = float_ptrs[3]
                return self

            def as_floatptrs(self) -> Sequence[Float, Float, Float, Float]:
                return (
                    self.x_ptr,
                    self.y_ptr,
                    self.z_ptr,
                    self.w_ptr,
                )

            def tuple(self) -> Sequence[float, float, float, float]:
                return (
                    self.x,
                    self.y,
                    self.z,
                    self.w,
                )

            def from_tuple(self, vec: Sequence[float, float, float, float]) -> Vec4:
                if len(vec) < 4:
                    raise IndexError

                self.x = vec[0]
                self.y = vec[1]
                self.z = vec[2]
                self.w = vec[3]
                return self

            def to_u32(self) -> int:
                return IM_COL32(
                    int(self.x * 255),
                    int(self.y * 255),
                    int(self.z * 255),
                    int(self.w * 255),
                )

            def copy(self) -> Vec4:
                return Vec4(*self.tuple())

            cdef void from_array(self, float* array):
                self.x_ptr.value = array[0]
                self.y_ptr.value = array[1]
                self.z_ptr.value = array[2]
                self.w_ptr.value = array[3]

            cdef void to_array(self, float* array):
                array[0] = self.x_ptr.value
                array[1] = self.y_ptr.value
                array[2] = self.z_ptr.value
                array[3] = self.w_ptr.value


        cdef class ImGlyphRange:
            cdef unsigned short* c_ranges
            cdef object p_ranges

            def __cinit__(self, glyph_ranges: Sequence[tuple]):
                # All elements passed need to be of length 2, and add 1 to any
                # tuples that contain zero, because these are considered terminators
                # of the array in imgui. Assert that only positive numbers were
                # passed in.
                safe_ranges = []
                for glyph in glyph_ranges:
                    IM_ASSERT(len(glyph) == 2)
                    start, end = glyph
                    IM_ASSERT(start >= 0 and end >= 0)
                    start = start + 1 if start == 0 else start
                    IM_ASSERT(start <= end)
                    safe_ranges.append((start, end))

                self.p_ranges = safe_ranges
                self.c_ranges = <unsigned short*>{pxd_library_name}.ImGui_MemAlloc((len(safe_ranges) * 2 + 1) * sizeof(short))
                if self.c_ranges == NULL:
                    raise MemoryError()
                for i, g_range in enumerate(safe_ranges):
                    self.c_ranges[i * 2] = g_range[0]
                    self.c_ranges[i * 2 + 1] = g_range[1]
                self.c_ranges[len(safe_ranges) * 2] = 0

            @property
            def ranges(self):
                return self.p_ranges
            @ranges.setter
            def ranges(self, value):
                raise NotImplementedError

            def destroy(self: ImGuiTextFilter):
                """
                Explicitly frees this instance.
                """
                if self.c_ranges != NULL:
                    {pxd_library_name}.ImGui_MemFree(self.c_ranges)
                    self.c_ranges = NULL
            def __dealloc__(self):
                """
                Just in case the user forgets to free the memory.
                """
                self.destroy()

            @staticmethod
            cdef from_short_array(const {pxd_library_name}.ImWchar* c_glyph_ranges):
                cdef {pxd_library_name}.ImWchar x
                cdef {pxd_library_name}.ImWchar y
                cdef int i = 0
                ranges = []
                while True:
                    x = c_glyph_ranges[i * 2]
                    if x == 0:
                        break
                    y = c_glyph_ranges[i * 2 + 1]
                    ranges.append((x, y))
                    i += 1
                # Owns the ranges and keeps a copy.
                return ImGlyphRange(ranges)


        PAYLOAD_TYPE_COLOR_3F = "_COL3F"
        PAYLOAD_TYPE_COLOR_4F = "_COL4F"

        # IM_COL32_R_SHIFT = 0
        # IM_COL32_G_SHIFT = 8
        # IM_COL32_B_SHIFT = 16
        # IM_COL32_A_SHIFT = 24
        def IM_COL32(int r, int g, int b, int a) -> int:
            cdef unsigned long output = 0
            output |= a << 24
            output |= b << 16
            output |= g << 8
            output |= r << 0
            return output

        IM_COL32_WHITE        = IM_COL32(255, 255, 255, 255)   # Opaque white = 0xFFFFFFFF
        IM_COL32_BLACK        = IM_COL32(0, 0, 0, 255)         # Opaque black
        IM_COL32_BLACK_TRANS  = IM_COL32(0, 0, 0, 0)

        def get_imgui_error():
            cdef {pxd_library_name}.PyObject* imgui_exception
            imgui_exception = {pxd_library_name}.get_imgui_error()
            if imgui_exception == NULL:
                return None

            cdef object python_exception = <object>imgui_exception
            return python_exception

        def IM_ASSERT(condition: bool, error_message: str=""):
            """
            If dcimgui exposes us a custom exception, we will use that. Otherwise,
            we will use Python's AssertionError.
            """
            if condition:
                return

            # The variable name of ImGuiError means nothing. It just makes python's
            # traceback look nicer. The actual name of the exception is defined
            # in the config.cpp
            ImGuiError = get_imgui_error()
            if ImGuiError is None:
                raise AssertionError(error_message)
            else:
                raise ImGuiError(error_message)

        def IM_CLAMP(n, smallest, largest):
            return max(smallest, min(n, largest))

        '''

        pyx = StringIO()

        if include_base:
            pyx.write(textwrap.dedent(base.lstrip("\n")).format(
                pxd_library_name=pxd_library_name
            ))

        # Add enums
        for enum in self.enums:
            pyx.write(enum.to_pyx(pxd_library_name))

        # Add Functions
        pyx.write("\n\n")
        pyx.write(PYX_TEMPLATE_MARKER)
        for function in self.functions:
            function_template = Template(function_base)
            pyx.write("# [Function]\n")
            function_pyx = self.function_to_pyx(pxd_library_name, function_template, function)
            pyx.write(function_pyx)
            pyx.write("# [End Function]\n\n")

        # Add Classes/Methods
        for struct in self.structs:
            class_template = Template(class_base)

            # Depending on if custom_comment_only is set, we'll generate the comment
            # twice. This will make the pyx parser only edit the first comment
            # keeping the old comment in the implementation. This is mainly to let
            # diff_match_patch find the old comment to apply changes to if the
            # comment changes in dcimgui.
            # struct_comments = None
            # if struct.comments.three_quote_all_comments() is not None:
            #     struct_comments = struct.comments.three_quote_all_comments() + "\n" + \
            #         comment_text(struct.comments.three_quote_all_comments())

            struct_comments = struct.get_comment().three_quote_all_comments()
            class_template.set_condition("has_comment", struct_comments is not None)
            if struct_comments is not None:
                class_template.format(comment=textwrap.indent(struct_comments, "    "))

            class_template.format(
                class_name=struct.get_name(),
                pxd_library_name=pxd_library_name,
            )
            pyx.write("# [Class]\n")
            pyx.write("# [Class Constants]\n")
            pyx.write(class_template.compile())
            pyx.write("    # [End Class Constants]\n\n")

            for field in struct.get_fields():
                field_template = Template(field_base)

                # Comments
                field_comments = field.get_comment().three_quote_all_comments()
                field_template.set_condition("has_comment", field_comments is not None)
                if field_comments is not None:
                    field_template.format(comment=textwrap.indent(field_comments, "    "))

                # Python type
                python_type = self.as_python_type(field.get_type())

                # Field type
                if field.get_type().is_function_pointer():
                    field_type = "Callable"
                elif self.is_dcimgui_type(field.get_type()):
                    field_type = "{}.{}".format(pxd_library_name, field.get_type().with_no_const())
                else:
                    field_type = field.get_type().to_pxd()

                # Res
                res = self.marshall_c_to_python(field.get_type()).format("res")

                # Field name
                field_name = pythonise_string(field.get_name())

                # dcimgui field name
                dcimgui_field_name = field.get_name()

                # Value
                value, _ = self.marshall_python_to_c(field.get_type(), "value", pxd_library_name)

                pyx.write("    # [Field]\n")
                pyx.write(textwrap.indent(field_template.format(
                    python_type=python_type,
                    field_name=field_name,
                    field_type=field_type,
                    dcimgui_field_name=dcimgui_field_name,
                    res=res,
                    value=value,
                ).compile(), "    "))
                pyx.write("    # [End Field]\n\n")


            for method in struct.get_methods():
                method_template = Template(function_base)
                method_pyx = self.function_to_pyx(pxd_library_name, method_template, method)
                pyx.write("    # [Method]\n")
                pyx.write(textwrap.indent(method_pyx, "    "))
                pyx.write("    # [End Method]\n\n")
            pyx.write("# [End Class]\n\n")

        return pyx.getvalue()

    def get_enums(self) -> List[IEnum]:
        return self.enums

    def function_to_pyx(self, pxd_library_name: str, function_template: Template, function: IFunction) -> str:
        # Python return type
        python_return_type = self.as_python_type(function.get_return_type())

        # Python function name
        python_function_name = pythonise_string(function.get_function_name_no_imgui_prefix())

        # Python function arguments
        python_function_arguments = ", ".join([self.as_name_type_default_parameter(a) for a in function.get_arguments()])

        # Comments
        function_comments = function.get_comment().three_quote_all_comments()
        function_template.set_condition("has_comment", function_comments is not None)
        if function_comments is not None:
            function_template.format(comment=textwrap.indent(function_comments, "    "))

        # Return type
        function_template.set_condition("has_return_type", not function.get_return_type().is_void_type())
        if function.get_return_type().is_function_pointer():
            return_type = "Callable"
        elif self.is_dcimgui_type(function.get_return_type()):
            return_type = "{}.{}".format(pxd_library_name, function.get_return_type().with_no_const())
        else:
            return_type = function.get_return_type().to_pxd()

        # Function arguments
        lines_required_for_marshalling = []
        if len(function.get_arguments()) > 0:
            function_argument_list = []
            for argument in function.get_arguments():
                marshalled_type, additional_lines = self.marshall_python_to_c(
                    argument.get_type(),
                    argument.get_name(),
                    pxd_library_name,
                    argument.get_default_value()
                )
                lines_required_for_marshalling += additional_lines
                if argument.get_name() == "self":
                    marshalled_type = "self._ptr"
                function_argument_list.append(marshalled_type)

            function_arguments = "\n" + ",\n".join(function_argument_list) + "\n    "
            function_arguments = textwrap.indent(function_arguments, "        ")
        else:
            function_arguments = ""

        # Checking for lines required to marshalling between python and c
        function_template.set_condition("has_additional_lines", len(lines_required_for_marshalling) > 0)
        function_template.format(
            additional_lines=textwrap.indent("\n".join(lines_required_for_marshalling), "    ")
        )

        # res
        followed_return_type = self.follow_type(function.get_return_type())
        res = self.marshall_c_to_python(followed_return_type).format("res")

        return function_template.format(
            python_return_type=python_return_type,
            python_function_name=python_function_name,
            python_function_arguments=python_function_arguments,
            return_type=return_type,
            pxd_library_name=pxd_library_name,
            function_name=function.get_name(),
            function_arguments=function_arguments,
            res=res,
        ).compile()

    def as_python_type(self, _type: IType) -> str:
        python_type_lookup = {
            "bool": "bool",
            "bool*": "Bool",
            "char": "int",
            "size_t": "int",
            "int": "int",
            "int*": "Int",
            "short": "int",
            "short*": "Int",
            "long": "int",
            "long*": "Int",
            "float": "float",
            "float*": "Float",
            "double": "float",
            "double*": "Double",
            "ImVec2": "Tuple[float, float]",
            "ImVec4": "Tuple[float, float, float, float]",
            "void": "None",
            "char*": "str",
        }
        _type = self.follow_type(_type)

        if _type.is_array() and _type.ptr_version() is not None:
            return "Sequence[" + _type.ptr_version() + "]"

        if _type.with_no_const_or_sign() in python_type_lookup:
            return python_type_lookup[_type.with_no_const_or_sign()]

        for struct in self.structs:
            if struct.get_name() == _type.with_no_const_or_asterisk():
                return struct.get_name()

        if _type.is_function_pointer():
            return "Callable"


        return "Any"

    def marshall_c_to_python(self, _type: IType) -> str:
        _type = self.follow_type(_type)

        if _type.is_string():
            return "_from_bytes({})"

        if _type.is_vec2():
            return "_cast_ImVec2_tuple({})"

        if _type.is_vec4():
            return "_cast_ImVec4_tuple({})"

        if _type.ptr_version() is not None:
            return _type.ptr_version() + "(dereference({}))"

        if self.is_dcimgui_type(_type):
            return _type.with_no_const_or_asterisk() + ".from_ptr({})"

        return "{}"

    def marshall_python_to_c(
            self,
            _type: IType,
            argument_name: str,
            pxd_library_name: str,
            default_value: Optional[str] = None
        ) -> str:
        _type = self.follow_type(_type)

        additional_lines = []

        output = "{name}"
        if _type.is_vec2():
            output = "_cast_tuple_ImVec2({name})"

        elif _type.is_vec4():
            output = "_cast_tuple_ImVec4({name})"

        elif _type.is_string() and default_value == "None":
            additional_lines.append(
                "bytes_{name} = _bytes({name}) if {name} is not None else None".format(name=argument_name)
            )
            output = "((<char*>bytes_{name} if {name} is not None else NULL))"

        elif _type.is_string():
            output = "_bytes({name})"

        elif _type.ptr_version() and default_value == "None":
            output = _type.ptr_version() + ".ptr({name})"

        elif self.is_dcimgui_type(_type) and default_value == "None":
            output = "<{pxd_library_name}.{type_name}>(NULL if {{name}} is None else {{name}}._ptr)".format(
                pxd_library_name=pxd_library_name,
                type_name=_type.with_no_const()
            )

        elif _type.ptr_version() is not None:
            output = "&{name}.value"

        elif self.is_dcimgui_type(_type):
            output = "{name}._ptr"

        return output.format(name=argument_name), additional_lines

    def follow_type(self, _type: IType) -> IType:
        if not self.is_dcimgui_type(_type):
            return _type

        for enum in self.enums:
            if enum.get_name() == _type.with_no_const_or_asterisk():
                return _Type(
                    "int",
                    Kind(Kinds.Builtin, "int")
                )

        for typedef in self.typedefs:
            if _type.with_no_const_or_asterisk() == typedef.get_definition():
                return self.follow_type(typedef.get_base())

        return _type

    def as_name_type_default_parameter(self, argument: IArgument) -> str:
        parameter_format = "{}: {}{}".format(
            argument.get_name(),
            self.as_python_type(self.follow_type(argument.get_type())),
            "={}".format(argument.get_default_value()) if argument.get_default_value() is not None else ""
        )
        return parameter_format

    def is_dcimgui_type(self, _type: IType) -> bool:
        for enum in self.enums:
            if _type.with_no_const_or_asterisk() == enum:
                return True
            if enum.has_element(_type.with_no_const_or_asterisk()):
                return True

        for typedef in self.typedefs:
            if typedef.get_definition() == _type.with_no_const_or_asterisk():
                return True

        for struct in self.structs:
            if _type.with_no_const_or_asterisk() == struct.get_name():
                return True

        return False

    def __repr__(self):
        return \
            "Enums:\n{}\n\n".format("\n".join([e.to_pxd() for e in self.enums])) + \
            "Functions:\n{}\n".format("\n".join([e.to_pxd() for e in self.functions])) + \
            "Typedefs:\n{}\n\n".format("\n".join([e.to_pxd() for e in self.typedefs])) + \
            "Structs:\n{}\n\n".format("\n".join([e.to_pxd() for e in self.structs]))
