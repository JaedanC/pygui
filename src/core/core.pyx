# distutils: language = c++
# cython: language_level = 3
# cython: embedsignature=True

import ctypes
import cython
import array
from collections import namedtuple
from cython.operator import dereference
from typing import Callable, Any, Sequence, Tuple, NamedTuple, Optional

cimport ccimgui
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

cdef _cast_ImVec2_tuple(ccimgui.ImVec2 vec):
    return (vec.x, vec.y)

cdef ccimgui.ImVec2 _cast_tuple_ImVec2(pair):
    cdef ccimgui.ImVec2 vec
    if len(pair) != 2:
        raise ValueError('pair param must be length of 2')
    vec.x, vec.y = pair
    return vec

cdef _cast_ImVec4_tuple(ccimgui.ImVec4 vec):
    return (vec.x, vec.y, vec.z, vec.w)

cdef ccimgui.ImVec4 _cast_tuple_ImVec4(quadruple):
    cdef ccimgui.ImVec4 vec
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
        self.buffer = <char*>ccimgui.ImGui_MemAlloc(buffer_size)
        if self.buffer == NULL:
            raise MemoryError()
        self._buffer_size: int = buffer_size
        self.value = initial_value

    def __dealloc__(self):
        ccimgui.ImGui_MemFree(self.buffer)

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
        return self.x == other.x \
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
        return f"Vec2({self.x}, {self.y})"

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
        return self.x == other.x \
            and self.y == other.y \
            and self.z == other.z \
            and self.w == other.w \

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
        return f"Vec4({self.x}, {self.y}, {self.z}, {self.w})"

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
        self.c_ranges = <unsigned short*>ccimgui.ImGui_MemAlloc((len(safe_ranges) * 2 + 1) * sizeof(short))
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
            ccimgui.ImGui_MemFree(self.c_ranges)
            self.c_ranges = NULL
    def __dealloc__(self):
        """
        Just in case the user forgets to free the memory.
        """
        self.destroy()

    @staticmethod
    cdef from_short_array(const ccimgui.ImWchar* c_glyph_ranges):
        cdef ccimgui.ImWchar x
        cdef ccimgui.ImWchar y
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
    cdef ccimgui.PyObject* imgui_exception
    imgui_exception = ccimgui.get_imgui_error()
    if imgui_exception == NULL:
        return None

    cdef object python_exception = <object>imgui_exception
    return python_exception

def IM_ASSERT(condition: bool, error_message: str=""):
    """
    If cimgui exposes us a custom exception, we will use that. Otherwise,
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

WINDOW_FLAGS_NONE = ccimgui.ImGuiWindowFlags_None
WINDOW_FLAGS_NO_TITLE_BAR = ccimgui.ImGuiWindowFlags_NoTitleBar
WINDOW_FLAGS_NO_RESIZE = ccimgui.ImGuiWindowFlags_NoResize
WINDOW_FLAGS_NO_MOVE = ccimgui.ImGuiWindowFlags_NoMove
WINDOW_FLAGS_NO_SCROLLBAR = ccimgui.ImGuiWindowFlags_NoScrollbar
WINDOW_FLAGS_NO_SCROLL_WITH_MOUSE = ccimgui.ImGuiWindowFlags_NoScrollWithMouse
WINDOW_FLAGS_NO_COLLAPSE = ccimgui.ImGuiWindowFlags_NoCollapse
WINDOW_FLAGS_ALWAYS_AUTO_RESIZE = ccimgui.ImGuiWindowFlags_AlwaysAutoResize
WINDOW_FLAGS_NO_BACKGROUND = ccimgui.ImGuiWindowFlags_NoBackground
WINDOW_FLAGS_NO_SAVED_SETTINGS = ccimgui.ImGuiWindowFlags_NoSavedSettings
WINDOW_FLAGS_NO_MOUSE_INPUTS = ccimgui.ImGuiWindowFlags_NoMouseInputs
WINDOW_FLAGS_MENU_BAR = ccimgui.ImGuiWindowFlags_MenuBar
WINDOW_FLAGS_HORIZONTAL_SCROLLBAR = ccimgui.ImGuiWindowFlags_HorizontalScrollbar
WINDOW_FLAGS_NO_FOCUS_ON_APPEARING = ccimgui.ImGuiWindowFlags_NoFocusOnAppearing
WINDOW_FLAGS_NO_BRING_TO_FRONT_ON_FOCUS = ccimgui.ImGuiWindowFlags_NoBringToFrontOnFocus
WINDOW_FLAGS_ALWAYS_VERTICAL_SCROLLBAR = ccimgui.ImGuiWindowFlags_AlwaysVerticalScrollbar
WINDOW_FLAGS_ALWAYS_HORIZONTAL_SCROLLBAR = ccimgui.ImGuiWindowFlags_AlwaysHorizontalScrollbar
WINDOW_FLAGS_NO_NAV_INPUTS = ccimgui.ImGuiWindowFlags_NoNavInputs
WINDOW_FLAGS_NO_NAV_FOCUS = ccimgui.ImGuiWindowFlags_NoNavFocus
WINDOW_FLAGS_UNSAVED_DOCUMENT = ccimgui.ImGuiWindowFlags_UnsavedDocument
WINDOW_FLAGS_NO_DOCKING = ccimgui.ImGuiWindowFlags_NoDocking
WINDOW_FLAGS_NO_NAV = ccimgui.ImGuiWindowFlags_NoNav
WINDOW_FLAGS_NO_DECORATION = ccimgui.ImGuiWindowFlags_NoDecoration
WINDOW_FLAGS_NO_INPUTS = ccimgui.ImGuiWindowFlags_NoInputs
WINDOW_FLAGS_NAV_FLATTENED = ccimgui.ImGuiWindowFlags_NavFlattened
WINDOW_FLAGS_CHILD_WINDOW = ccimgui.ImGuiWindowFlags_ChildWindow
WINDOW_FLAGS_TOOLTIP = ccimgui.ImGuiWindowFlags_Tooltip
WINDOW_FLAGS_POPUP = ccimgui.ImGuiWindowFlags_Popup
WINDOW_FLAGS_MODAL = ccimgui.ImGuiWindowFlags_Modal
WINDOW_FLAGS_CHILD_MENU = ccimgui.ImGuiWindowFlags_ChildMenu
WINDOW_FLAGS_DOCK_NODE_HOST = ccimgui.ImGuiWindowFlags_DockNodeHost
CHILD_FLAGS_NONE = ccimgui.ImGuiChildFlags_None
CHILD_FLAGS_BORDER = ccimgui.ImGuiChildFlags_Border
CHILD_FLAGS_ALWAYS_USE_WINDOW_PADDING = ccimgui.ImGuiChildFlags_AlwaysUseWindowPadding
CHILD_FLAGS_RESIZE_X = ccimgui.ImGuiChildFlags_ResizeX
CHILD_FLAGS_RESIZE_Y = ccimgui.ImGuiChildFlags_ResizeY
CHILD_FLAGS_AUTO_RESIZE_X = ccimgui.ImGuiChildFlags_AutoResizeX
CHILD_FLAGS_AUTO_RESIZE_Y = ccimgui.ImGuiChildFlags_AutoResizeY
CHILD_FLAGS_ALWAYS_AUTO_RESIZE = ccimgui.ImGuiChildFlags_AlwaysAutoResize
CHILD_FLAGS_FRAME_STYLE = ccimgui.ImGuiChildFlags_FrameStyle
INPUT_TEXT_FLAGS_NONE = ccimgui.ImGuiInputTextFlags_None
INPUT_TEXT_FLAGS_CHARS_DECIMAL = ccimgui.ImGuiInputTextFlags_CharsDecimal
INPUT_TEXT_FLAGS_CHARS_HEXADECIMAL = ccimgui.ImGuiInputTextFlags_CharsHexadecimal
INPUT_TEXT_FLAGS_CHARS_UPPERCASE = ccimgui.ImGuiInputTextFlags_CharsUppercase
INPUT_TEXT_FLAGS_CHARS_NO_BLANK = ccimgui.ImGuiInputTextFlags_CharsNoBlank
INPUT_TEXT_FLAGS_AUTO_SELECT_ALL = ccimgui.ImGuiInputTextFlags_AutoSelectAll
INPUT_TEXT_FLAGS_ENTER_RETURNS_TRUE = ccimgui.ImGuiInputTextFlags_EnterReturnsTrue
INPUT_TEXT_FLAGS_CALLBACK_COMPLETION = ccimgui.ImGuiInputTextFlags_CallbackCompletion
INPUT_TEXT_FLAGS_CALLBACK_HISTORY = ccimgui.ImGuiInputTextFlags_CallbackHistory
INPUT_TEXT_FLAGS_CALLBACK_ALWAYS = ccimgui.ImGuiInputTextFlags_CallbackAlways
INPUT_TEXT_FLAGS_CALLBACK_CHAR_FILTER = ccimgui.ImGuiInputTextFlags_CallbackCharFilter
INPUT_TEXT_FLAGS_ALLOW_TAB_INPUT = ccimgui.ImGuiInputTextFlags_AllowTabInput
INPUT_TEXT_FLAGS_CTRL_ENTER_FOR_NEW_LINE = ccimgui.ImGuiInputTextFlags_CtrlEnterForNewLine
INPUT_TEXT_FLAGS_NO_HORIZONTAL_SCROLL = ccimgui.ImGuiInputTextFlags_NoHorizontalScroll
INPUT_TEXT_FLAGS_ALWAYS_OVERWRITE = ccimgui.ImGuiInputTextFlags_AlwaysOverwrite
INPUT_TEXT_FLAGS_READ_ONLY = ccimgui.ImGuiInputTextFlags_ReadOnly
INPUT_TEXT_FLAGS_PASSWORD = ccimgui.ImGuiInputTextFlags_Password
INPUT_TEXT_FLAGS_NO_UNDO_REDO = ccimgui.ImGuiInputTextFlags_NoUndoRedo
INPUT_TEXT_FLAGS_CHARS_SCIENTIFIC = ccimgui.ImGuiInputTextFlags_CharsScientific
INPUT_TEXT_FLAGS_CALLBACK_RESIZE = ccimgui.ImGuiInputTextFlags_CallbackResize
INPUT_TEXT_FLAGS_CALLBACK_EDIT = ccimgui.ImGuiInputTextFlags_CallbackEdit
INPUT_TEXT_FLAGS_ESCAPE_CLEARS_ALL = ccimgui.ImGuiInputTextFlags_EscapeClearsAll
TREE_NODE_FLAGS_NONE = ccimgui.ImGuiTreeNodeFlags_None
TREE_NODE_FLAGS_SELECTED = ccimgui.ImGuiTreeNodeFlags_Selected
TREE_NODE_FLAGS_FRAMED = ccimgui.ImGuiTreeNodeFlags_Framed
TREE_NODE_FLAGS_ALLOW_OVERLAP = ccimgui.ImGuiTreeNodeFlags_AllowOverlap
TREE_NODE_FLAGS_NO_TREE_PUSH_ON_OPEN = ccimgui.ImGuiTreeNodeFlags_NoTreePushOnOpen
TREE_NODE_FLAGS_NO_AUTO_OPEN_ON_LOG = ccimgui.ImGuiTreeNodeFlags_NoAutoOpenOnLog
TREE_NODE_FLAGS_DEFAULT_OPEN = ccimgui.ImGuiTreeNodeFlags_DefaultOpen
TREE_NODE_FLAGS_OPEN_ON_DOUBLE_CLICK = ccimgui.ImGuiTreeNodeFlags_OpenOnDoubleClick
TREE_NODE_FLAGS_OPEN_ON_ARROW = ccimgui.ImGuiTreeNodeFlags_OpenOnArrow
TREE_NODE_FLAGS_LEAF = ccimgui.ImGuiTreeNodeFlags_Leaf
TREE_NODE_FLAGS_BULLET = ccimgui.ImGuiTreeNodeFlags_Bullet
TREE_NODE_FLAGS_FRAME_PADDING = ccimgui.ImGuiTreeNodeFlags_FramePadding
TREE_NODE_FLAGS_SPAN_AVAIL_WIDTH = ccimgui.ImGuiTreeNodeFlags_SpanAvailWidth
TREE_NODE_FLAGS_SPAN_FULL_WIDTH = ccimgui.ImGuiTreeNodeFlags_SpanFullWidth
TREE_NODE_FLAGS_SPAN_ALL_COLUMNS = ccimgui.ImGuiTreeNodeFlags_SpanAllColumns
TREE_NODE_FLAGS_NAV_LEFT_JUMPS_BACK_HERE = ccimgui.ImGuiTreeNodeFlags_NavLeftJumpsBackHere
TREE_NODE_FLAGS_COLLAPSING_HEADER = ccimgui.ImGuiTreeNodeFlags_CollapsingHeader
POPUP_FLAGS_NONE = ccimgui.ImGuiPopupFlags_None
POPUP_FLAGS_MOUSE_BUTTON_LEFT = ccimgui.ImGuiPopupFlags_MouseButtonLeft
POPUP_FLAGS_MOUSE_BUTTON_RIGHT = ccimgui.ImGuiPopupFlags_MouseButtonRight
POPUP_FLAGS_MOUSE_BUTTON_MIDDLE = ccimgui.ImGuiPopupFlags_MouseButtonMiddle
POPUP_FLAGS_MOUSE_BUTTON_MASK = ccimgui.ImGuiPopupFlags_MouseButtonMask_
POPUP_FLAGS_MOUSE_BUTTON_DEFAULT = ccimgui.ImGuiPopupFlags_MouseButtonDefault_
POPUP_FLAGS_NO_REOPEN = ccimgui.ImGuiPopupFlags_NoReopen
POPUP_FLAGS_NO_OPEN_OVER_EXISTING_POPUP = ccimgui.ImGuiPopupFlags_NoOpenOverExistingPopup
POPUP_FLAGS_NO_OPEN_OVER_ITEMS = ccimgui.ImGuiPopupFlags_NoOpenOverItems
POPUP_FLAGS_ANY_POPUP_ID = ccimgui.ImGuiPopupFlags_AnyPopupId
POPUP_FLAGS_ANY_POPUP_LEVEL = ccimgui.ImGuiPopupFlags_AnyPopupLevel
POPUP_FLAGS_ANY_POPUP = ccimgui.ImGuiPopupFlags_AnyPopup
SELECTABLE_FLAGS_NONE = ccimgui.ImGuiSelectableFlags_None
SELECTABLE_FLAGS_DONT_CLOSE_POPUPS = ccimgui.ImGuiSelectableFlags_DontClosePopups
SELECTABLE_FLAGS_SPAN_ALL_COLUMNS = ccimgui.ImGuiSelectableFlags_SpanAllColumns
SELECTABLE_FLAGS_ALLOW_DOUBLE_CLICK = ccimgui.ImGuiSelectableFlags_AllowDoubleClick
SELECTABLE_FLAGS_DISABLED = ccimgui.ImGuiSelectableFlags_Disabled
SELECTABLE_FLAGS_ALLOW_OVERLAP = ccimgui.ImGuiSelectableFlags_AllowOverlap
COMBO_FLAGS_NONE = ccimgui.ImGuiComboFlags_None
COMBO_FLAGS_POPUP_ALIGN_LEFT = ccimgui.ImGuiComboFlags_PopupAlignLeft
COMBO_FLAGS_HEIGHT_SMALL = ccimgui.ImGuiComboFlags_HeightSmall
COMBO_FLAGS_HEIGHT_REGULAR = ccimgui.ImGuiComboFlags_HeightRegular
COMBO_FLAGS_HEIGHT_LARGE = ccimgui.ImGuiComboFlags_HeightLarge
COMBO_FLAGS_HEIGHT_LARGEST = ccimgui.ImGuiComboFlags_HeightLargest
COMBO_FLAGS_NO_ARROW_BUTTON = ccimgui.ImGuiComboFlags_NoArrowButton
COMBO_FLAGS_NO_PREVIEW = ccimgui.ImGuiComboFlags_NoPreview
COMBO_FLAGS_WIDTH_FIT_PREVIEW = ccimgui.ImGuiComboFlags_WidthFitPreview
COMBO_FLAGS_HEIGHT_MASK = ccimgui.ImGuiComboFlags_HeightMask_
TAB_BAR_FLAGS_NONE = ccimgui.ImGuiTabBarFlags_None
TAB_BAR_FLAGS_REORDERABLE = ccimgui.ImGuiTabBarFlags_Reorderable
TAB_BAR_FLAGS_AUTO_SELECT_NEW_TABS = ccimgui.ImGuiTabBarFlags_AutoSelectNewTabs
TAB_BAR_FLAGS_TAB_LIST_POPUP_BUTTON = ccimgui.ImGuiTabBarFlags_TabListPopupButton
TAB_BAR_FLAGS_NO_CLOSE_WITH_MIDDLE_MOUSE_BUTTON = ccimgui.ImGuiTabBarFlags_NoCloseWithMiddleMouseButton
TAB_BAR_FLAGS_NO_TAB_LIST_SCROLLING_BUTTONS = ccimgui.ImGuiTabBarFlags_NoTabListScrollingButtons
TAB_BAR_FLAGS_NO_TOOLTIP = ccimgui.ImGuiTabBarFlags_NoTooltip
TAB_BAR_FLAGS_FITTING_POLICY_RESIZE_DOWN = ccimgui.ImGuiTabBarFlags_FittingPolicyResizeDown
TAB_BAR_FLAGS_FITTING_POLICY_SCROLL = ccimgui.ImGuiTabBarFlags_FittingPolicyScroll
TAB_BAR_FLAGS_FITTING_POLICY_MASK = ccimgui.ImGuiTabBarFlags_FittingPolicyMask_
TAB_BAR_FLAGS_FITTING_POLICY_DEFAULT = ccimgui.ImGuiTabBarFlags_FittingPolicyDefault_
TAB_ITEM_FLAGS_NONE = ccimgui.ImGuiTabItemFlags_None
TAB_ITEM_FLAGS_UNSAVED_DOCUMENT = ccimgui.ImGuiTabItemFlags_UnsavedDocument
TAB_ITEM_FLAGS_SET_SELECTED = ccimgui.ImGuiTabItemFlags_SetSelected
TAB_ITEM_FLAGS_NO_CLOSE_WITH_MIDDLE_MOUSE_BUTTON = ccimgui.ImGuiTabItemFlags_NoCloseWithMiddleMouseButton
TAB_ITEM_FLAGS_NO_PUSH_ID = ccimgui.ImGuiTabItemFlags_NoPushId
TAB_ITEM_FLAGS_NO_TOOLTIP = ccimgui.ImGuiTabItemFlags_NoTooltip
TAB_ITEM_FLAGS_NO_REORDER = ccimgui.ImGuiTabItemFlags_NoReorder
TAB_ITEM_FLAGS_LEADING = ccimgui.ImGuiTabItemFlags_Leading
TAB_ITEM_FLAGS_TRAILING = ccimgui.ImGuiTabItemFlags_Trailing
TAB_ITEM_FLAGS_NO_ASSUMED_CLOSURE = ccimgui.ImGuiTabItemFlags_NoAssumedClosure
FOCUSED_FLAGS_NONE = ccimgui.ImGuiFocusedFlags_None
FOCUSED_FLAGS_CHILD_WINDOWS = ccimgui.ImGuiFocusedFlags_ChildWindows
FOCUSED_FLAGS_ROOT_WINDOW = ccimgui.ImGuiFocusedFlags_RootWindow
FOCUSED_FLAGS_ANY_WINDOW = ccimgui.ImGuiFocusedFlags_AnyWindow
FOCUSED_FLAGS_NO_POPUP_HIERARCHY = ccimgui.ImGuiFocusedFlags_NoPopupHierarchy
FOCUSED_FLAGS_DOCK_HIERARCHY = ccimgui.ImGuiFocusedFlags_DockHierarchy
FOCUSED_FLAGS_ROOT_AND_CHILD_WINDOWS = ccimgui.ImGuiFocusedFlags_RootAndChildWindows
HOVERED_FLAGS_NONE = ccimgui.ImGuiHoveredFlags_None
HOVERED_FLAGS_CHILD_WINDOWS = ccimgui.ImGuiHoveredFlags_ChildWindows
HOVERED_FLAGS_ROOT_WINDOW = ccimgui.ImGuiHoveredFlags_RootWindow
HOVERED_FLAGS_ANY_WINDOW = ccimgui.ImGuiHoveredFlags_AnyWindow
HOVERED_FLAGS_NO_POPUP_HIERARCHY = ccimgui.ImGuiHoveredFlags_NoPopupHierarchy
HOVERED_FLAGS_DOCK_HIERARCHY = ccimgui.ImGuiHoveredFlags_DockHierarchy
HOVERED_FLAGS_ALLOW_WHEN_BLOCKED_BY_POPUP = ccimgui.ImGuiHoveredFlags_AllowWhenBlockedByPopup
HOVERED_FLAGS_ALLOW_WHEN_BLOCKED_BY_ACTIVE_ITEM = ccimgui.ImGuiHoveredFlags_AllowWhenBlockedByActiveItem
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED_BY_ITEM = ccimgui.ImGuiHoveredFlags_AllowWhenOverlappedByItem
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED_BY_WINDOW = ccimgui.ImGuiHoveredFlags_AllowWhenOverlappedByWindow
HOVERED_FLAGS_ALLOW_WHEN_DISABLED = ccimgui.ImGuiHoveredFlags_AllowWhenDisabled
HOVERED_FLAGS_NO_NAV_OVERRIDE = ccimgui.ImGuiHoveredFlags_NoNavOverride
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED = ccimgui.ImGuiHoveredFlags_AllowWhenOverlapped
HOVERED_FLAGS_RECT_ONLY = ccimgui.ImGuiHoveredFlags_RectOnly
HOVERED_FLAGS_ROOT_AND_CHILD_WINDOWS = ccimgui.ImGuiHoveredFlags_RootAndChildWindows
HOVERED_FLAGS_FOR_TOOLTIP = ccimgui.ImGuiHoveredFlags_ForTooltip
HOVERED_FLAGS_STATIONARY = ccimgui.ImGuiHoveredFlags_Stationary
HOVERED_FLAGS_DELAY_NONE = ccimgui.ImGuiHoveredFlags_DelayNone
HOVERED_FLAGS_DELAY_SHORT = ccimgui.ImGuiHoveredFlags_DelayShort
HOVERED_FLAGS_DELAY_NORMAL = ccimgui.ImGuiHoveredFlags_DelayNormal
HOVERED_FLAGS_NO_SHARED_DELAY = ccimgui.ImGuiHoveredFlags_NoSharedDelay
DOCK_NODE_FLAGS_NONE = ccimgui.ImGuiDockNodeFlags_None
DOCK_NODE_FLAGS_KEEP_ALIVE_ONLY = ccimgui.ImGuiDockNodeFlags_KeepAliveOnly
DOCK_NODE_FLAGS_NO_DOCKING_OVER_CENTRAL_NODE = ccimgui.ImGuiDockNodeFlags_NoDockingOverCentralNode
DOCK_NODE_FLAGS_PASSTHRU_CENTRAL_NODE = ccimgui.ImGuiDockNodeFlags_PassthruCentralNode
DOCK_NODE_FLAGS_NO_DOCKING_SPLIT = ccimgui.ImGuiDockNodeFlags_NoDockingSplit
DOCK_NODE_FLAGS_NO_RESIZE = ccimgui.ImGuiDockNodeFlags_NoResize
DOCK_NODE_FLAGS_AUTO_HIDE_TAB_BAR = ccimgui.ImGuiDockNodeFlags_AutoHideTabBar
DOCK_NODE_FLAGS_NO_UNDOCKING = ccimgui.ImGuiDockNodeFlags_NoUndocking
DRAG_DROP_FLAGS_NONE = ccimgui.ImGuiDragDropFlags_None
DRAG_DROP_FLAGS_SOURCE_NO_PREVIEW_TOOLTIP = ccimgui.ImGuiDragDropFlags_SourceNoPreviewTooltip
DRAG_DROP_FLAGS_SOURCE_NO_DISABLE_HOVER = ccimgui.ImGuiDragDropFlags_SourceNoDisableHover
DRAG_DROP_FLAGS_SOURCE_NO_HOLD_TO_OPEN_OTHERS = ccimgui.ImGuiDragDropFlags_SourceNoHoldToOpenOthers
DRAG_DROP_FLAGS_SOURCE_ALLOW_NULL_ID = ccimgui.ImGuiDragDropFlags_SourceAllowNullID
DRAG_DROP_FLAGS_SOURCE_EXTERN = ccimgui.ImGuiDragDropFlags_SourceExtern
DRAG_DROP_FLAGS_SOURCE_AUTO_EXPIRE_PAYLOAD = ccimgui.ImGuiDragDropFlags_SourceAutoExpirePayload
DRAG_DROP_FLAGS_ACCEPT_BEFORE_DELIVERY = ccimgui.ImGuiDragDropFlags_AcceptBeforeDelivery
DRAG_DROP_FLAGS_ACCEPT_NO_DRAW_DEFAULT_RECT = ccimgui.ImGuiDragDropFlags_AcceptNoDrawDefaultRect
DRAG_DROP_FLAGS_ACCEPT_NO_PREVIEW_TOOLTIP = ccimgui.ImGuiDragDropFlags_AcceptNoPreviewTooltip
DRAG_DROP_FLAGS_ACCEPT_PEEK_ONLY = ccimgui.ImGuiDragDropFlags_AcceptPeekOnly
DATA_TYPE_S8 = ccimgui.ImGuiDataType_S8
DATA_TYPE_U8 = ccimgui.ImGuiDataType_U8
DATA_TYPE_S16 = ccimgui.ImGuiDataType_S16
DATA_TYPE_U16 = ccimgui.ImGuiDataType_U16
DATA_TYPE_S32 = ccimgui.ImGuiDataType_S32
DATA_TYPE_U32 = ccimgui.ImGuiDataType_U32
DATA_TYPE_S64 = ccimgui.ImGuiDataType_S64
DATA_TYPE_U64 = ccimgui.ImGuiDataType_U64
DATA_TYPE_FLOAT = ccimgui.ImGuiDataType_Float
DATA_TYPE_DOUBLE = ccimgui.ImGuiDataType_Double
DATA_TYPE_COUNT = ccimgui.ImGuiDataType_COUNT
DIR_NONE = ccimgui.ImGuiDir_None
DIR_LEFT = ccimgui.ImGuiDir_Left
DIR_RIGHT = ccimgui.ImGuiDir_Right
DIR_UP = ccimgui.ImGuiDir_Up
DIR_DOWN = ccimgui.ImGuiDir_Down
DIR_COUNT = ccimgui.ImGuiDir_COUNT
SORT_DIRECTION_NONE = ccimgui.ImGuiSortDirection_None
SORT_DIRECTION_ASCENDING = ccimgui.ImGuiSortDirection_Ascending
SORT_DIRECTION_DESCENDING = ccimgui.ImGuiSortDirection_Descending
KEY_NONE = ccimgui.ImGuiKey_None
KEY_TAB = ccimgui.ImGuiKey_Tab
KEY_LEFT_ARROW = ccimgui.ImGuiKey_LeftArrow
KEY_RIGHT_ARROW = ccimgui.ImGuiKey_RightArrow
KEY_UP_ARROW = ccimgui.ImGuiKey_UpArrow
KEY_DOWN_ARROW = ccimgui.ImGuiKey_DownArrow
KEY_PAGE_UP = ccimgui.ImGuiKey_PageUp
KEY_PAGE_DOWN = ccimgui.ImGuiKey_PageDown
KEY_HOME = ccimgui.ImGuiKey_Home
KEY_END = ccimgui.ImGuiKey_End
KEY_INSERT = ccimgui.ImGuiKey_Insert
KEY_DELETE = ccimgui.ImGuiKey_Delete
KEY_BACKSPACE = ccimgui.ImGuiKey_Backspace
KEY_SPACE = ccimgui.ImGuiKey_Space
KEY_ENTER = ccimgui.ImGuiKey_Enter
KEY_ESCAPE = ccimgui.ImGuiKey_Escape
KEY_LEFT_CTRL = ccimgui.ImGuiKey_LeftCtrl
KEY_LEFT_SHIFT = ccimgui.ImGuiKey_LeftShift
KEY_LEFT_ALT = ccimgui.ImGuiKey_LeftAlt
KEY_LEFT_SUPER = ccimgui.ImGuiKey_LeftSuper
KEY_RIGHT_CTRL = ccimgui.ImGuiKey_RightCtrl
KEY_RIGHT_SHIFT = ccimgui.ImGuiKey_RightShift
KEY_RIGHT_ALT = ccimgui.ImGuiKey_RightAlt
KEY_RIGHT_SUPER = ccimgui.ImGuiKey_RightSuper
KEY_MENU = ccimgui.ImGuiKey_Menu
KEY_0 = ccimgui.ImGuiKey_0
KEY_1 = ccimgui.ImGuiKey_1
KEY_2 = ccimgui.ImGuiKey_2
KEY_3 = ccimgui.ImGuiKey_3
KEY_4 = ccimgui.ImGuiKey_4
KEY_5 = ccimgui.ImGuiKey_5
KEY_6 = ccimgui.ImGuiKey_6
KEY_7 = ccimgui.ImGuiKey_7
KEY_8 = ccimgui.ImGuiKey_8
KEY_9 = ccimgui.ImGuiKey_9
KEY_A = ccimgui.ImGuiKey_A
KEY_B = ccimgui.ImGuiKey_B
KEY_C = ccimgui.ImGuiKey_C
KEY_D = ccimgui.ImGuiKey_D
KEY_E = ccimgui.ImGuiKey_E
KEY_F = ccimgui.ImGuiKey_F
KEY_G = ccimgui.ImGuiKey_G
KEY_H = ccimgui.ImGuiKey_H
KEY_I = ccimgui.ImGuiKey_I
KEY_J = ccimgui.ImGuiKey_J
KEY_K = ccimgui.ImGuiKey_K
KEY_L = ccimgui.ImGuiKey_L
KEY_M = ccimgui.ImGuiKey_M
KEY_N = ccimgui.ImGuiKey_N
KEY_O = ccimgui.ImGuiKey_O
KEY_P = ccimgui.ImGuiKey_P
KEY_Q = ccimgui.ImGuiKey_Q
KEY_R = ccimgui.ImGuiKey_R
KEY_S = ccimgui.ImGuiKey_S
KEY_T = ccimgui.ImGuiKey_T
KEY_U = ccimgui.ImGuiKey_U
KEY_V = ccimgui.ImGuiKey_V
KEY_W = ccimgui.ImGuiKey_W
KEY_X = ccimgui.ImGuiKey_X
KEY_Y = ccimgui.ImGuiKey_Y
KEY_Z = ccimgui.ImGuiKey_Z
KEY_F1 = ccimgui.ImGuiKey_F1
KEY_F2 = ccimgui.ImGuiKey_F2
KEY_F3 = ccimgui.ImGuiKey_F3
KEY_F4 = ccimgui.ImGuiKey_F4
KEY_F5 = ccimgui.ImGuiKey_F5
KEY_F6 = ccimgui.ImGuiKey_F6
KEY_F7 = ccimgui.ImGuiKey_F7
KEY_F8 = ccimgui.ImGuiKey_F8
KEY_F9 = ccimgui.ImGuiKey_F9
KEY_F10 = ccimgui.ImGuiKey_F10
KEY_F11 = ccimgui.ImGuiKey_F11
KEY_F12 = ccimgui.ImGuiKey_F12
KEY_F13 = ccimgui.ImGuiKey_F13
KEY_F14 = ccimgui.ImGuiKey_F14
KEY_F15 = ccimgui.ImGuiKey_F15
KEY_F16 = ccimgui.ImGuiKey_F16
KEY_F17 = ccimgui.ImGuiKey_F17
KEY_F18 = ccimgui.ImGuiKey_F18
KEY_F19 = ccimgui.ImGuiKey_F19
KEY_F20 = ccimgui.ImGuiKey_F20
KEY_F21 = ccimgui.ImGuiKey_F21
KEY_F22 = ccimgui.ImGuiKey_F22
KEY_F23 = ccimgui.ImGuiKey_F23
KEY_F24 = ccimgui.ImGuiKey_F24
KEY_APOSTROPHE = ccimgui.ImGuiKey_Apostrophe
KEY_COMMA = ccimgui.ImGuiKey_Comma
KEY_MINUS = ccimgui.ImGuiKey_Minus
KEY_PERIOD = ccimgui.ImGuiKey_Period
KEY_SLASH = ccimgui.ImGuiKey_Slash
KEY_SEMICOLON = ccimgui.ImGuiKey_Semicolon
KEY_EQUAL = ccimgui.ImGuiKey_Equal
KEY_LEFT_BRACKET = ccimgui.ImGuiKey_LeftBracket
KEY_BACKSLASH = ccimgui.ImGuiKey_Backslash
KEY_RIGHT_BRACKET = ccimgui.ImGuiKey_RightBracket
KEY_GRAVE_ACCENT = ccimgui.ImGuiKey_GraveAccent
KEY_CAPS_LOCK = ccimgui.ImGuiKey_CapsLock
KEY_SCROLL_LOCK = ccimgui.ImGuiKey_ScrollLock
KEY_NUM_LOCK = ccimgui.ImGuiKey_NumLock
KEY_PRINT_SCREEN = ccimgui.ImGuiKey_PrintScreen
KEY_PAUSE = ccimgui.ImGuiKey_Pause
KEY_KEYPAD0 = ccimgui.ImGuiKey_Keypad0
KEY_KEYPAD1 = ccimgui.ImGuiKey_Keypad1
KEY_KEYPAD2 = ccimgui.ImGuiKey_Keypad2
KEY_KEYPAD3 = ccimgui.ImGuiKey_Keypad3
KEY_KEYPAD4 = ccimgui.ImGuiKey_Keypad4
KEY_KEYPAD5 = ccimgui.ImGuiKey_Keypad5
KEY_KEYPAD6 = ccimgui.ImGuiKey_Keypad6
KEY_KEYPAD7 = ccimgui.ImGuiKey_Keypad7
KEY_KEYPAD8 = ccimgui.ImGuiKey_Keypad8
KEY_KEYPAD9 = ccimgui.ImGuiKey_Keypad9
KEY_KEYPAD_DECIMAL = ccimgui.ImGuiKey_KeypadDecimal
KEY_KEYPAD_DIVIDE = ccimgui.ImGuiKey_KeypadDivide
KEY_KEYPAD_MULTIPLY = ccimgui.ImGuiKey_KeypadMultiply
KEY_KEYPAD_SUBTRACT = ccimgui.ImGuiKey_KeypadSubtract
KEY_KEYPAD_ADD = ccimgui.ImGuiKey_KeypadAdd
KEY_KEYPAD_ENTER = ccimgui.ImGuiKey_KeypadEnter
KEY_KEYPAD_EQUAL = ccimgui.ImGuiKey_KeypadEqual
KEY_APP_BACK = ccimgui.ImGuiKey_AppBack
KEY_APP_FORWARD = ccimgui.ImGuiKey_AppForward
KEY_GAMEPAD_START = ccimgui.ImGuiKey_GamepadStart
KEY_GAMEPAD_BACK = ccimgui.ImGuiKey_GamepadBack
KEY_GAMEPAD_FACE_LEFT = ccimgui.ImGuiKey_GamepadFaceLeft
KEY_GAMEPAD_FACE_RIGHT = ccimgui.ImGuiKey_GamepadFaceRight
KEY_GAMEPAD_FACE_UP = ccimgui.ImGuiKey_GamepadFaceUp
KEY_GAMEPAD_FACE_DOWN = ccimgui.ImGuiKey_GamepadFaceDown
KEY_GAMEPAD_DPAD_LEFT = ccimgui.ImGuiKey_GamepadDpadLeft
KEY_GAMEPAD_DPAD_RIGHT = ccimgui.ImGuiKey_GamepadDpadRight
KEY_GAMEPAD_DPAD_UP = ccimgui.ImGuiKey_GamepadDpadUp
KEY_GAMEPAD_DPAD_DOWN = ccimgui.ImGuiKey_GamepadDpadDown
KEY_GAMEPAD_L1 = ccimgui.ImGuiKey_GamepadL1
KEY_GAMEPAD_R1 = ccimgui.ImGuiKey_GamepadR1
KEY_GAMEPAD_L2 = ccimgui.ImGuiKey_GamepadL2
KEY_GAMEPAD_R2 = ccimgui.ImGuiKey_GamepadR2
KEY_GAMEPAD_L3 = ccimgui.ImGuiKey_GamepadL3
KEY_GAMEPAD_R3 = ccimgui.ImGuiKey_GamepadR3
KEY_GAMEPAD_LSTICK_LEFT = ccimgui.ImGuiKey_GamepadLStickLeft
KEY_GAMEPAD_LSTICK_RIGHT = ccimgui.ImGuiKey_GamepadLStickRight
KEY_GAMEPAD_LSTICK_UP = ccimgui.ImGuiKey_GamepadLStickUp
KEY_GAMEPAD_LSTICK_DOWN = ccimgui.ImGuiKey_GamepadLStickDown
KEY_GAMEPAD_RSTICK_LEFT = ccimgui.ImGuiKey_GamepadRStickLeft
KEY_GAMEPAD_RSTICK_RIGHT = ccimgui.ImGuiKey_GamepadRStickRight
KEY_GAMEPAD_RSTICK_UP = ccimgui.ImGuiKey_GamepadRStickUp
KEY_GAMEPAD_RSTICK_DOWN = ccimgui.ImGuiKey_GamepadRStickDown
KEY_MOUSE_LEFT = ccimgui.ImGuiKey_MouseLeft
KEY_MOUSE_RIGHT = ccimgui.ImGuiKey_MouseRight
KEY_MOUSE_MIDDLE = ccimgui.ImGuiKey_MouseMiddle
KEY_MOUSE_X1 = ccimgui.ImGuiKey_MouseX1
KEY_MOUSE_X2 = ccimgui.ImGuiKey_MouseX2
KEY_MOUSE_WHEEL_X = ccimgui.ImGuiKey_MouseWheelX
KEY_MOUSE_WHEEL_Y = ccimgui.ImGuiKey_MouseWheelY
KEY_RESERVED_FOR_MOD_CTRL = ccimgui.ImGuiKey_ReservedForModCtrl
KEY_RESERVED_FOR_MOD_SHIFT = ccimgui.ImGuiKey_ReservedForModShift
KEY_RESERVED_FOR_MOD_ALT = ccimgui.ImGuiKey_ReservedForModAlt
KEY_RESERVED_FOR_MOD_SUPER = ccimgui.ImGuiKey_ReservedForModSuper
KEY_COUNT = ccimgui.ImGuiKey_COUNT
MOD_NONE = ccimgui.ImGuiMod_None
MOD_CTRL = ccimgui.ImGuiMod_Ctrl
MOD_SHIFT = ccimgui.ImGuiMod_Shift
MOD_ALT = ccimgui.ImGuiMod_Alt
MOD_SUPER = ccimgui.ImGuiMod_Super
MOD_SHORTCUT = ccimgui.ImGuiMod_Shortcut
MOD_MASK = ccimgui.ImGuiMod_Mask_
KEY_NAMED_KEY_BEGIN = ccimgui.ImGuiKey_NamedKey_BEGIN
KEY_NAMED_KEY_END = ccimgui.ImGuiKey_NamedKey_END
KEY_NAMED_KEY_COUNT = ccimgui.ImGuiKey_NamedKey_COUNT
KEY_KEYS_DATA_SIZE = ccimgui.ImGuiKey_KeysData_SIZE
KEY_KEYS_DATA_OFFSET = ccimgui.ImGuiKey_KeysData_OFFSET
CONFIG_FLAGS_NONE = ccimgui.ImGuiConfigFlags_None
CONFIG_FLAGS_NAV_ENABLE_KEYBOARD = ccimgui.ImGuiConfigFlags_NavEnableKeyboard
CONFIG_FLAGS_NAV_ENABLE_GAMEPAD = ccimgui.ImGuiConfigFlags_NavEnableGamepad
CONFIG_FLAGS_NAV_ENABLE_SET_MOUSE_POS = ccimgui.ImGuiConfigFlags_NavEnableSetMousePos
CONFIG_FLAGS_NAV_NO_CAPTURE_KEYBOARD = ccimgui.ImGuiConfigFlags_NavNoCaptureKeyboard
CONFIG_FLAGS_NO_MOUSE = ccimgui.ImGuiConfigFlags_NoMouse
CONFIG_FLAGS_NO_MOUSE_CURSOR_CHANGE = ccimgui.ImGuiConfigFlags_NoMouseCursorChange
CONFIG_FLAGS_DOCKING_ENABLE = ccimgui.ImGuiConfigFlags_DockingEnable
CONFIG_FLAGS_VIEWPORTS_ENABLE = ccimgui.ImGuiConfigFlags_ViewportsEnable
CONFIG_FLAGS_DPI_ENABLE_SCALE_VIEWPORTS = ccimgui.ImGuiConfigFlags_DpiEnableScaleViewports
CONFIG_FLAGS_DPI_ENABLE_SCALE_FONTS = ccimgui.ImGuiConfigFlags_DpiEnableScaleFonts
CONFIG_FLAGS_IS_S_RGB = ccimgui.ImGuiConfigFlags_IsSRGB
CONFIG_FLAGS_IS_TOUCH_SCREEN = ccimgui.ImGuiConfigFlags_IsTouchScreen
BACKEND_FLAGS_NONE = ccimgui.ImGuiBackendFlags_None
BACKEND_FLAGS_HAS_GAMEPAD = ccimgui.ImGuiBackendFlags_HasGamepad
BACKEND_FLAGS_HAS_MOUSE_CURSORS = ccimgui.ImGuiBackendFlags_HasMouseCursors
BACKEND_FLAGS_HAS_SET_MOUSE_POS = ccimgui.ImGuiBackendFlags_HasSetMousePos
BACKEND_FLAGS_RENDERER_HAS_VTX_OFFSET = ccimgui.ImGuiBackendFlags_RendererHasVtxOffset
BACKEND_FLAGS_PLATFORM_HAS_VIEWPORTS = ccimgui.ImGuiBackendFlags_PlatformHasViewports
BACKEND_FLAGS_HAS_MOUSE_HOVERED_VIEWPORT = ccimgui.ImGuiBackendFlags_HasMouseHoveredViewport
BACKEND_FLAGS_RENDERER_HAS_VIEWPORTS = ccimgui.ImGuiBackendFlags_RendererHasViewports
COL_TEXT = ccimgui.ImGuiCol_Text
COL_TEXT_DISABLED = ccimgui.ImGuiCol_TextDisabled
COL_WINDOW_BG = ccimgui.ImGuiCol_WindowBg
COL_CHILD_BG = ccimgui.ImGuiCol_ChildBg
COL_POPUP_BG = ccimgui.ImGuiCol_PopupBg
COL_BORDER = ccimgui.ImGuiCol_Border
COL_BORDER_SHADOW = ccimgui.ImGuiCol_BorderShadow
COL_FRAME_BG = ccimgui.ImGuiCol_FrameBg
COL_FRAME_BG_HOVERED = ccimgui.ImGuiCol_FrameBgHovered
COL_FRAME_BG_ACTIVE = ccimgui.ImGuiCol_FrameBgActive
COL_TITLE_BG = ccimgui.ImGuiCol_TitleBg
COL_TITLE_BG_ACTIVE = ccimgui.ImGuiCol_TitleBgActive
COL_TITLE_BG_COLLAPSED = ccimgui.ImGuiCol_TitleBgCollapsed
COL_MENU_BAR_BG = ccimgui.ImGuiCol_MenuBarBg
COL_SCROLLBAR_BG = ccimgui.ImGuiCol_ScrollbarBg
COL_SCROLLBAR_GRAB = ccimgui.ImGuiCol_ScrollbarGrab
COL_SCROLLBAR_GRAB_HOVERED = ccimgui.ImGuiCol_ScrollbarGrabHovered
COL_SCROLLBAR_GRAB_ACTIVE = ccimgui.ImGuiCol_ScrollbarGrabActive
COL_CHECK_MARK = ccimgui.ImGuiCol_CheckMark
COL_SLIDER_GRAB = ccimgui.ImGuiCol_SliderGrab
COL_SLIDER_GRAB_ACTIVE = ccimgui.ImGuiCol_SliderGrabActive
COL_BUTTON = ccimgui.ImGuiCol_Button
COL_BUTTON_HOVERED = ccimgui.ImGuiCol_ButtonHovered
COL_BUTTON_ACTIVE = ccimgui.ImGuiCol_ButtonActive
COL_HEADER = ccimgui.ImGuiCol_Header
COL_HEADER_HOVERED = ccimgui.ImGuiCol_HeaderHovered
COL_HEADER_ACTIVE = ccimgui.ImGuiCol_HeaderActive
COL_SEPARATOR = ccimgui.ImGuiCol_Separator
COL_SEPARATOR_HOVERED = ccimgui.ImGuiCol_SeparatorHovered
COL_SEPARATOR_ACTIVE = ccimgui.ImGuiCol_SeparatorActive
COL_RESIZE_GRIP = ccimgui.ImGuiCol_ResizeGrip
COL_RESIZE_GRIP_HOVERED = ccimgui.ImGuiCol_ResizeGripHovered
COL_RESIZE_GRIP_ACTIVE = ccimgui.ImGuiCol_ResizeGripActive
COL_TAB = ccimgui.ImGuiCol_Tab
COL_TAB_HOVERED = ccimgui.ImGuiCol_TabHovered
COL_TAB_ACTIVE = ccimgui.ImGuiCol_TabActive
COL_TAB_UNFOCUSED = ccimgui.ImGuiCol_TabUnfocused
COL_TAB_UNFOCUSED_ACTIVE = ccimgui.ImGuiCol_TabUnfocusedActive
COL_DOCKING_PREVIEW = ccimgui.ImGuiCol_DockingPreview
COL_DOCKING_EMPTY_BG = ccimgui.ImGuiCol_DockingEmptyBg
COL_PLOT_LINES = ccimgui.ImGuiCol_PlotLines
COL_PLOT_LINES_HOVERED = ccimgui.ImGuiCol_PlotLinesHovered
COL_PLOT_HISTOGRAM = ccimgui.ImGuiCol_PlotHistogram
COL_PLOT_HISTOGRAM_HOVERED = ccimgui.ImGuiCol_PlotHistogramHovered
COL_TABLE_HEADER_BG = ccimgui.ImGuiCol_TableHeaderBg
COL_TABLE_BORDER_STRONG = ccimgui.ImGuiCol_TableBorderStrong
COL_TABLE_BORDER_LIGHT = ccimgui.ImGuiCol_TableBorderLight
COL_TABLE_ROW_BG = ccimgui.ImGuiCol_TableRowBg
COL_TABLE_ROW_BG_ALT = ccimgui.ImGuiCol_TableRowBgAlt
COL_TEXT_SELECTED_BG = ccimgui.ImGuiCol_TextSelectedBg
COL_DRAG_DROP_TARGET = ccimgui.ImGuiCol_DragDropTarget
COL_NAV_HIGHLIGHT = ccimgui.ImGuiCol_NavHighlight
COL_NAV_WINDOWING_HIGHLIGHT = ccimgui.ImGuiCol_NavWindowingHighlight
COL_NAV_WINDOWING_DIM_BG = ccimgui.ImGuiCol_NavWindowingDimBg
COL_MODAL_WINDOW_DIM_BG = ccimgui.ImGuiCol_ModalWindowDimBg
COL_COUNT = ccimgui.ImGuiCol_COUNT
STYLE_VAR_ALPHA = ccimgui.ImGuiStyleVar_Alpha
STYLE_VAR_DISABLED_ALPHA = ccimgui.ImGuiStyleVar_DisabledAlpha
STYLE_VAR_WINDOW_PADDING = ccimgui.ImGuiStyleVar_WindowPadding
STYLE_VAR_WINDOW_ROUNDING = ccimgui.ImGuiStyleVar_WindowRounding
STYLE_VAR_WINDOW_BORDER_SIZE = ccimgui.ImGuiStyleVar_WindowBorderSize
STYLE_VAR_WINDOW_MIN_SIZE = ccimgui.ImGuiStyleVar_WindowMinSize
STYLE_VAR_WINDOW_TITLE_ALIGN = ccimgui.ImGuiStyleVar_WindowTitleAlign
STYLE_VAR_CHILD_ROUNDING = ccimgui.ImGuiStyleVar_ChildRounding
STYLE_VAR_CHILD_BORDER_SIZE = ccimgui.ImGuiStyleVar_ChildBorderSize
STYLE_VAR_POPUP_ROUNDING = ccimgui.ImGuiStyleVar_PopupRounding
STYLE_VAR_POPUP_BORDER_SIZE = ccimgui.ImGuiStyleVar_PopupBorderSize
STYLE_VAR_FRAME_PADDING = ccimgui.ImGuiStyleVar_FramePadding
STYLE_VAR_FRAME_ROUNDING = ccimgui.ImGuiStyleVar_FrameRounding
STYLE_VAR_FRAME_BORDER_SIZE = ccimgui.ImGuiStyleVar_FrameBorderSize
STYLE_VAR_ITEM_SPACING = ccimgui.ImGuiStyleVar_ItemSpacing
STYLE_VAR_ITEM_INNER_SPACING = ccimgui.ImGuiStyleVar_ItemInnerSpacing
STYLE_VAR_INDENT_SPACING = ccimgui.ImGuiStyleVar_IndentSpacing
STYLE_VAR_CELL_PADDING = ccimgui.ImGuiStyleVar_CellPadding
STYLE_VAR_SCROLLBAR_SIZE = ccimgui.ImGuiStyleVar_ScrollbarSize
STYLE_VAR_SCROLLBAR_ROUNDING = ccimgui.ImGuiStyleVar_ScrollbarRounding
STYLE_VAR_GRAB_MIN_SIZE = ccimgui.ImGuiStyleVar_GrabMinSize
STYLE_VAR_GRAB_ROUNDING = ccimgui.ImGuiStyleVar_GrabRounding
STYLE_VAR_TAB_ROUNDING = ccimgui.ImGuiStyleVar_TabRounding
STYLE_VAR_TAB_BAR_BORDER_SIZE = ccimgui.ImGuiStyleVar_TabBarBorderSize
STYLE_VAR_BUTTON_TEXT_ALIGN = ccimgui.ImGuiStyleVar_ButtonTextAlign
STYLE_VAR_SELECTABLE_TEXT_ALIGN = ccimgui.ImGuiStyleVar_SelectableTextAlign
STYLE_VAR_SEPARATOR_TEXT_BORDER_SIZE = ccimgui.ImGuiStyleVar_SeparatorTextBorderSize
STYLE_VAR_SEPARATOR_TEXT_ALIGN = ccimgui.ImGuiStyleVar_SeparatorTextAlign
STYLE_VAR_SEPARATOR_TEXT_PADDING = ccimgui.ImGuiStyleVar_SeparatorTextPadding
STYLE_VAR_DOCKING_SEPARATOR_SIZE = ccimgui.ImGuiStyleVar_DockingSeparatorSize
STYLE_VAR_COUNT = ccimgui.ImGuiStyleVar_COUNT
BUTTON_FLAGS_NONE = ccimgui.ImGuiButtonFlags_None
BUTTON_FLAGS_MOUSE_BUTTON_LEFT = ccimgui.ImGuiButtonFlags_MouseButtonLeft
BUTTON_FLAGS_MOUSE_BUTTON_RIGHT = ccimgui.ImGuiButtonFlags_MouseButtonRight
BUTTON_FLAGS_MOUSE_BUTTON_MIDDLE = ccimgui.ImGuiButtonFlags_MouseButtonMiddle
BUTTON_FLAGS_MOUSE_BUTTON_MASK = ccimgui.ImGuiButtonFlags_MouseButtonMask_
BUTTON_FLAGS_MOUSE_BUTTON_DEFAULT = ccimgui.ImGuiButtonFlags_MouseButtonDefault_
COLOR_EDIT_FLAGS_NONE = ccimgui.ImGuiColorEditFlags_None
COLOR_EDIT_FLAGS_NO_ALPHA = ccimgui.ImGuiColorEditFlags_NoAlpha
COLOR_EDIT_FLAGS_NO_PICKER = ccimgui.ImGuiColorEditFlags_NoPicker
COLOR_EDIT_FLAGS_NO_OPTIONS = ccimgui.ImGuiColorEditFlags_NoOptions
COLOR_EDIT_FLAGS_NO_SMALL_PREVIEW = ccimgui.ImGuiColorEditFlags_NoSmallPreview
COLOR_EDIT_FLAGS_NO_INPUTS = ccimgui.ImGuiColorEditFlags_NoInputs
COLOR_EDIT_FLAGS_NO_TOOLTIP = ccimgui.ImGuiColorEditFlags_NoTooltip
COLOR_EDIT_FLAGS_NO_LABEL = ccimgui.ImGuiColorEditFlags_NoLabel
COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW = ccimgui.ImGuiColorEditFlags_NoSidePreview
COLOR_EDIT_FLAGS_NO_DRAG_DROP = ccimgui.ImGuiColorEditFlags_NoDragDrop
COLOR_EDIT_FLAGS_NO_BORDER = ccimgui.ImGuiColorEditFlags_NoBorder
COLOR_EDIT_FLAGS_ALPHA_BAR = ccimgui.ImGuiColorEditFlags_AlphaBar
COLOR_EDIT_FLAGS_ALPHA_PREVIEW = ccimgui.ImGuiColorEditFlags_AlphaPreview
COLOR_EDIT_FLAGS_ALPHA_PREVIEW_HALF = ccimgui.ImGuiColorEditFlags_AlphaPreviewHalf
COLOR_EDIT_FLAGS_HDR = ccimgui.ImGuiColorEditFlags_HDR
COLOR_EDIT_FLAGS_DISPLAY_RGB = ccimgui.ImGuiColorEditFlags_DisplayRGB
COLOR_EDIT_FLAGS_DISPLAY_HSV = ccimgui.ImGuiColorEditFlags_DisplayHSV
COLOR_EDIT_FLAGS_DISPLAY_HEX = ccimgui.ImGuiColorEditFlags_DisplayHex
COLOR_EDIT_FLAGS_UINT8 = ccimgui.ImGuiColorEditFlags_Uint8
COLOR_EDIT_FLAGS_FLOAT = ccimgui.ImGuiColorEditFlags_Float
COLOR_EDIT_FLAGS_PICKER_HUE_BAR = ccimgui.ImGuiColorEditFlags_PickerHueBar
COLOR_EDIT_FLAGS_PICKER_HUE_WHEEL = ccimgui.ImGuiColorEditFlags_PickerHueWheel
COLOR_EDIT_FLAGS_INPUT_RGB = ccimgui.ImGuiColorEditFlags_InputRGB
COLOR_EDIT_FLAGS_INPUT_HSV = ccimgui.ImGuiColorEditFlags_InputHSV
COLOR_EDIT_FLAGS_DEFAULT_OPTIONS = ccimgui.ImGuiColorEditFlags_DefaultOptions_
COLOR_EDIT_FLAGS_DISPLAY_MASK = ccimgui.ImGuiColorEditFlags_DisplayMask_
COLOR_EDIT_FLAGS_DATA_TYPE_MASK = ccimgui.ImGuiColorEditFlags_DataTypeMask_
COLOR_EDIT_FLAGS_PICKER_MASK = ccimgui.ImGuiColorEditFlags_PickerMask_
COLOR_EDIT_FLAGS_INPUT_MASK = ccimgui.ImGuiColorEditFlags_InputMask_
SLIDER_FLAGS_NONE = ccimgui.ImGuiSliderFlags_None
SLIDER_FLAGS_ALWAYS_CLAMP = ccimgui.ImGuiSliderFlags_AlwaysClamp
SLIDER_FLAGS_LOGARITHMIC = ccimgui.ImGuiSliderFlags_Logarithmic
SLIDER_FLAGS_NO_ROUND_TO_FORMAT = ccimgui.ImGuiSliderFlags_NoRoundToFormat
SLIDER_FLAGS_NO_INPUT = ccimgui.ImGuiSliderFlags_NoInput
SLIDER_FLAGS_INVALID_MASK = ccimgui.ImGuiSliderFlags_InvalidMask_
MOUSE_BUTTON_LEFT = ccimgui.ImGuiMouseButton_Left
MOUSE_BUTTON_RIGHT = ccimgui.ImGuiMouseButton_Right
MOUSE_BUTTON_MIDDLE = ccimgui.ImGuiMouseButton_Middle
MOUSE_BUTTON_COUNT = ccimgui.ImGuiMouseButton_COUNT
MOUSE_CURSOR_NONE = ccimgui.ImGuiMouseCursor_None
MOUSE_CURSOR_ARROW = ccimgui.ImGuiMouseCursor_Arrow
MOUSE_CURSOR_TEXT_INPUT = ccimgui.ImGuiMouseCursor_TextInput
MOUSE_CURSOR_RESIZE_ALL = ccimgui.ImGuiMouseCursor_ResizeAll
MOUSE_CURSOR_RESIZE_NS = ccimgui.ImGuiMouseCursor_ResizeNS
MOUSE_CURSOR_RESIZE_EW = ccimgui.ImGuiMouseCursor_ResizeEW
MOUSE_CURSOR_RESIZE_NESW = ccimgui.ImGuiMouseCursor_ResizeNESW
MOUSE_CURSOR_RESIZE_NWSE = ccimgui.ImGuiMouseCursor_ResizeNWSE
MOUSE_CURSOR_HAND = ccimgui.ImGuiMouseCursor_Hand
MOUSE_CURSOR_NOT_ALLOWED = ccimgui.ImGuiMouseCursor_NotAllowed
MOUSE_CURSOR_COUNT = ccimgui.ImGuiMouseCursor_COUNT
MOUSE_SOURCE_MOUSE = ccimgui.ImGuiMouseSource_Mouse
MOUSE_SOURCE_TOUCH_SCREEN = ccimgui.ImGuiMouseSource_TouchScreen
MOUSE_SOURCE_PEN = ccimgui.ImGuiMouseSource_Pen
MOUSE_SOURCE_COUNT = ccimgui.ImGuiMouseSource_COUNT
COND_NONE = ccimgui.ImGuiCond_None
COND_ALWAYS = ccimgui.ImGuiCond_Always
COND_ONCE = ccimgui.ImGuiCond_Once
COND_FIRST_USE_EVER = ccimgui.ImGuiCond_FirstUseEver
COND_APPEARING = ccimgui.ImGuiCond_Appearing
TABLE_FLAGS_NONE = ccimgui.ImGuiTableFlags_None
TABLE_FLAGS_RESIZABLE = ccimgui.ImGuiTableFlags_Resizable
TABLE_FLAGS_REORDERABLE = ccimgui.ImGuiTableFlags_Reorderable
TABLE_FLAGS_HIDEABLE = ccimgui.ImGuiTableFlags_Hideable
TABLE_FLAGS_SORTABLE = ccimgui.ImGuiTableFlags_Sortable
TABLE_FLAGS_NO_SAVED_SETTINGS = ccimgui.ImGuiTableFlags_NoSavedSettings
TABLE_FLAGS_CONTEXT_MENU_IN_BODY = ccimgui.ImGuiTableFlags_ContextMenuInBody
TABLE_FLAGS_ROW_BG = ccimgui.ImGuiTableFlags_RowBg
TABLE_FLAGS_BORDERS_INNER_H = ccimgui.ImGuiTableFlags_BordersInnerH
TABLE_FLAGS_BORDERS_OUTER_H = ccimgui.ImGuiTableFlags_BordersOuterH
TABLE_FLAGS_BORDERS_INNER_V = ccimgui.ImGuiTableFlags_BordersInnerV
TABLE_FLAGS_BORDERS_OUTER_V = ccimgui.ImGuiTableFlags_BordersOuterV
TABLE_FLAGS_BORDERS_H = ccimgui.ImGuiTableFlags_BordersH
TABLE_FLAGS_BORDERS_V = ccimgui.ImGuiTableFlags_BordersV
TABLE_FLAGS_BORDERS_INNER = ccimgui.ImGuiTableFlags_BordersInner
TABLE_FLAGS_BORDERS_OUTER = ccimgui.ImGuiTableFlags_BordersOuter
TABLE_FLAGS_BORDERS = ccimgui.ImGuiTableFlags_Borders
TABLE_FLAGS_NO_BORDERS_IN_BODY = ccimgui.ImGuiTableFlags_NoBordersInBody
TABLE_FLAGS_NO_BORDERS_IN_BODY_UNTIL_RESIZE = ccimgui.ImGuiTableFlags_NoBordersInBodyUntilResize
TABLE_FLAGS_SIZING_FIXED_FIT = ccimgui.ImGuiTableFlags_SizingFixedFit
TABLE_FLAGS_SIZING_FIXED_SAME = ccimgui.ImGuiTableFlags_SizingFixedSame
TABLE_FLAGS_SIZING_STRETCH_PROP = ccimgui.ImGuiTableFlags_SizingStretchProp
TABLE_FLAGS_SIZING_STRETCH_SAME = ccimgui.ImGuiTableFlags_SizingStretchSame
TABLE_FLAGS_NO_HOST_EXTEND_X = ccimgui.ImGuiTableFlags_NoHostExtendX
TABLE_FLAGS_NO_HOST_EXTEND_Y = ccimgui.ImGuiTableFlags_NoHostExtendY
TABLE_FLAGS_NO_KEEP_COLUMNS_VISIBLE = ccimgui.ImGuiTableFlags_NoKeepColumnsVisible
TABLE_FLAGS_PRECISE_WIDTHS = ccimgui.ImGuiTableFlags_PreciseWidths
TABLE_FLAGS_NO_CLIP = ccimgui.ImGuiTableFlags_NoClip
TABLE_FLAGS_PAD_OUTER_X = ccimgui.ImGuiTableFlags_PadOuterX
TABLE_FLAGS_NO_PAD_OUTER_X = ccimgui.ImGuiTableFlags_NoPadOuterX
TABLE_FLAGS_NO_PAD_INNER_X = ccimgui.ImGuiTableFlags_NoPadInnerX
TABLE_FLAGS_SCROLL_X = ccimgui.ImGuiTableFlags_ScrollX
TABLE_FLAGS_SCROLL_Y = ccimgui.ImGuiTableFlags_ScrollY
TABLE_FLAGS_SORT_MULTI = ccimgui.ImGuiTableFlags_SortMulti
TABLE_FLAGS_SORT_TRISTATE = ccimgui.ImGuiTableFlags_SortTristate
TABLE_FLAGS_HIGHLIGHT_HOVERED_COLUMN = ccimgui.ImGuiTableFlags_HighlightHoveredColumn
TABLE_FLAGS_SIZING_MASK = ccimgui.ImGuiTableFlags_SizingMask_
TABLE_COLUMN_FLAGS_NONE = ccimgui.ImGuiTableColumnFlags_None
TABLE_COLUMN_FLAGS_DISABLED = ccimgui.ImGuiTableColumnFlags_Disabled
TABLE_COLUMN_FLAGS_DEFAULT_HIDE = ccimgui.ImGuiTableColumnFlags_DefaultHide
TABLE_COLUMN_FLAGS_DEFAULT_SORT = ccimgui.ImGuiTableColumnFlags_DefaultSort
TABLE_COLUMN_FLAGS_WIDTH_STRETCH = ccimgui.ImGuiTableColumnFlags_WidthStretch
TABLE_COLUMN_FLAGS_WIDTH_FIXED = ccimgui.ImGuiTableColumnFlags_WidthFixed
TABLE_COLUMN_FLAGS_NO_RESIZE = ccimgui.ImGuiTableColumnFlags_NoResize
TABLE_COLUMN_FLAGS_NO_REORDER = ccimgui.ImGuiTableColumnFlags_NoReorder
TABLE_COLUMN_FLAGS_NO_HIDE = ccimgui.ImGuiTableColumnFlags_NoHide
TABLE_COLUMN_FLAGS_NO_CLIP = ccimgui.ImGuiTableColumnFlags_NoClip
TABLE_COLUMN_FLAGS_NO_SORT = ccimgui.ImGuiTableColumnFlags_NoSort
TABLE_COLUMN_FLAGS_NO_SORT_ASCENDING = ccimgui.ImGuiTableColumnFlags_NoSortAscending
TABLE_COLUMN_FLAGS_NO_SORT_DESCENDING = ccimgui.ImGuiTableColumnFlags_NoSortDescending
TABLE_COLUMN_FLAGS_NO_HEADER_LABEL = ccimgui.ImGuiTableColumnFlags_NoHeaderLabel
TABLE_COLUMN_FLAGS_NO_HEADER_WIDTH = ccimgui.ImGuiTableColumnFlags_NoHeaderWidth
TABLE_COLUMN_FLAGS_PREFER_SORT_ASCENDING = ccimgui.ImGuiTableColumnFlags_PreferSortAscending
TABLE_COLUMN_FLAGS_PREFER_SORT_DESCENDING = ccimgui.ImGuiTableColumnFlags_PreferSortDescending
TABLE_COLUMN_FLAGS_INDENT_ENABLE = ccimgui.ImGuiTableColumnFlags_IndentEnable
TABLE_COLUMN_FLAGS_INDENT_DISABLE = ccimgui.ImGuiTableColumnFlags_IndentDisable
TABLE_COLUMN_FLAGS_ANGLED_HEADER = ccimgui.ImGuiTableColumnFlags_AngledHeader
TABLE_COLUMN_FLAGS_IS_ENABLED = ccimgui.ImGuiTableColumnFlags_IsEnabled
TABLE_COLUMN_FLAGS_IS_VISIBLE = ccimgui.ImGuiTableColumnFlags_IsVisible
TABLE_COLUMN_FLAGS_IS_SORTED = ccimgui.ImGuiTableColumnFlags_IsSorted
TABLE_COLUMN_FLAGS_IS_HOVERED = ccimgui.ImGuiTableColumnFlags_IsHovered
TABLE_COLUMN_FLAGS_WIDTH_MASK = ccimgui.ImGuiTableColumnFlags_WidthMask_
TABLE_COLUMN_FLAGS_INDENT_MASK = ccimgui.ImGuiTableColumnFlags_IndentMask_
TABLE_COLUMN_FLAGS_STATUS_MASK = ccimgui.ImGuiTableColumnFlags_StatusMask_
TABLE_COLUMN_FLAGS_NO_DIRECT_RESIZE = ccimgui.ImGuiTableColumnFlags_NoDirectResize_
TABLE_ROW_FLAGS_NONE = ccimgui.ImGuiTableRowFlags_None
TABLE_ROW_FLAGS_HEADERS = ccimgui.ImGuiTableRowFlags_Headers
TABLE_BG_TARGET_NONE = ccimgui.ImGuiTableBgTarget_None
TABLE_BG_TARGET_ROW_BG0 = ccimgui.ImGuiTableBgTarget_RowBg0
TABLE_BG_TARGET_ROW_BG1 = ccimgui.ImGuiTableBgTarget_RowBg1
TABLE_BG_TARGET_CELL_BG = ccimgui.ImGuiTableBgTarget_CellBg
IM_DRAW_FLAGS_NONE = ccimgui.ImDrawFlags_None
IM_DRAW_FLAGS_CLOSED = ccimgui.ImDrawFlags_Closed
IM_DRAW_FLAGS_ROUND_CORNERS_TOP_LEFT = ccimgui.ImDrawFlags_RoundCornersTopLeft
IM_DRAW_FLAGS_ROUND_CORNERS_TOP_RIGHT = ccimgui.ImDrawFlags_RoundCornersTopRight
IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM_LEFT = ccimgui.ImDrawFlags_RoundCornersBottomLeft
IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM_RIGHT = ccimgui.ImDrawFlags_RoundCornersBottomRight
IM_DRAW_FLAGS_ROUND_CORNERS_NONE = ccimgui.ImDrawFlags_RoundCornersNone
IM_DRAW_FLAGS_ROUND_CORNERS_TOP = ccimgui.ImDrawFlags_RoundCornersTop
IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM = ccimgui.ImDrawFlags_RoundCornersBottom
IM_DRAW_FLAGS_ROUND_CORNERS_LEFT = ccimgui.ImDrawFlags_RoundCornersLeft
IM_DRAW_FLAGS_ROUND_CORNERS_RIGHT = ccimgui.ImDrawFlags_RoundCornersRight
IM_DRAW_FLAGS_ROUND_CORNERS_ALL = ccimgui.ImDrawFlags_RoundCornersAll
IM_DRAW_FLAGS_ROUND_CORNERS_DEFAULT = ccimgui.ImDrawFlags_RoundCornersDefault_
IM_DRAW_FLAGS_ROUND_CORNERS_MASK = ccimgui.ImDrawFlags_RoundCornersMask_
IM_DRAW_LIST_FLAGS_NONE = ccimgui.ImDrawListFlags_None
IM_DRAW_LIST_FLAGS_ANTI_ALIASED_LINES = ccimgui.ImDrawListFlags_AntiAliasedLines
IM_DRAW_LIST_FLAGS_ANTI_ALIASED_LINES_USE_TEX = ccimgui.ImDrawListFlags_AntiAliasedLinesUseTex
IM_DRAW_LIST_FLAGS_ANTI_ALIASED_FILL = ccimgui.ImDrawListFlags_AntiAliasedFill
IM_DRAW_LIST_FLAGS_ALLOW_VTX_OFFSET = ccimgui.ImDrawListFlags_AllowVtxOffset
IM_FONT_ATLAS_FLAGS_NONE = ccimgui.ImFontAtlasFlags_None
IM_FONT_ATLAS_FLAGS_NO_POWER_OF_TWO_HEIGHT = ccimgui.ImFontAtlasFlags_NoPowerOfTwoHeight
IM_FONT_ATLAS_FLAGS_NO_MOUSE_CURSORS = ccimgui.ImFontAtlasFlags_NoMouseCursors
IM_FONT_ATLAS_FLAGS_NO_BAKED_LINES = ccimgui.ImFontAtlasFlags_NoBakedLines
VIEWPORT_FLAGS_NONE = ccimgui.ImGuiViewportFlags_None
VIEWPORT_FLAGS_IS_PLATFORM_WINDOW = ccimgui.ImGuiViewportFlags_IsPlatformWindow
VIEWPORT_FLAGS_IS_PLATFORM_MONITOR = ccimgui.ImGuiViewportFlags_IsPlatformMonitor
VIEWPORT_FLAGS_OWNED_BY_APP = ccimgui.ImGuiViewportFlags_OwnedByApp
VIEWPORT_FLAGS_NO_DECORATION = ccimgui.ImGuiViewportFlags_NoDecoration
VIEWPORT_FLAGS_NO_TASK_BAR_ICON = ccimgui.ImGuiViewportFlags_NoTaskBarIcon
VIEWPORT_FLAGS_NO_FOCUS_ON_APPEARING = ccimgui.ImGuiViewportFlags_NoFocusOnAppearing
VIEWPORT_FLAGS_NO_FOCUS_ON_CLICK = ccimgui.ImGuiViewportFlags_NoFocusOnClick
VIEWPORT_FLAGS_NO_INPUTS = ccimgui.ImGuiViewportFlags_NoInputs
VIEWPORT_FLAGS_NO_RENDERER_CLEAR = ccimgui.ImGuiViewportFlags_NoRendererClear
VIEWPORT_FLAGS_NO_AUTO_MERGE = ccimgui.ImGuiViewportFlags_NoAutoMerge
VIEWPORT_FLAGS_TOP_MOST = ccimgui.ImGuiViewportFlags_TopMost
VIEWPORT_FLAGS_CAN_HOST_OTHER_WINDOWS = ccimgui.ImGuiViewportFlags_CanHostOtherWindows
VIEWPORT_FLAGS_IS_MINIMIZED = ccimgui.ImGuiViewportFlags_IsMinimized
VIEWPORT_FLAGS_IS_FOCUSED = ccimgui.ImGuiViewportFlags_IsFocused


# ---- Start Generated Content ----

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiPayload)
def accept_drag_drop_payload(type_: str, flags: int=0):
    """
    Accept contents of a given type. if imguidragdropflags_acceptbeforedelivery is set you can peek into the payload before the mouse button is released.
    """
    cdef const ccimgui.ImGuiPayload* res = ccimgui.ImGui_AcceptDragDropPayload(
        _bytes(type_),
        flags
    )
    return ImGuiPayload.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def align_text_to_frame_padding():
    """
    Vertically align upcoming text baseline to framepadding.y so that it will align properly to regularly framed items (call if you have text on a line before a framed item)
    """
    ccimgui.ImGui_AlignTextToFramePadding()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def arrow_button(str_id: str, dir_: int):
    """
    Square button with an arrow shape
    """
    cdef bool res = ccimgui.ImGui_ArrowButton(
        _bytes(str_id),
        dir_
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin(name: str, p_open: Bool=None, flags: int=0):
    """
    Windows
    - Begin() = push window to the stack and start appending to it. End() = pop window from the stack.
    - Passing 'bool* p_open != NULL' shows a window-closing widget in the upper-right corner of the window,
    which clicking will set the boolean to false when clicked.
    - You may append multiple times to the same window during the same frame by calling Begin()/End() pairs multiple times.
    Some information such as 'flags' or 'p_open' will only be considered by the first call to Begin().
    - Begin() return false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
    anything to the window. Always call a matching End() for each Begin() call, regardless of its return value!
    [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
    such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
    BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
    - Note that the bottom of window stack always contains a window called "Debug".
    """
    cdef bool res = ccimgui.ImGui_Begin(
        _bytes(name),
        Bool.ptr(p_open),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_child(str_id: str, size: Tuple[float, float]=(0, 0), child_flags: int=0, window_flags: int=0):
    """
    Child Windows
    - Use child windows to begin into a self-contained independent scrolling/clipping regions within a host window. Child windows can embed their own child.
    - Before 1.90 (November 2023), the "ImGuiChildFlags child_flags = 0" parameter was "bool border = false".
    This API is backward compatible with old code, as we guarantee that ImGuiChildFlags_Border == true.
    Consider updating your old code:
    BeginChild("Name", size, false)   -> Begin("Name", size, 0); or Begin("Name", size, ImGuiChildFlags_None);
    BeginChild("Name", size, true)-> Begin("Name", size, ImGuiChildFlags_Border);
    - Manual sizing (each axis can use a different setting e.g. ImVec2(0.0f, 400.0f)):
    == 0.0f: use remaining parent window size for this axis.
    > 0.0f: use specified size for this axis.
    < 0.0f: right/bottom-align to specified distance from available content boundaries.
    - Specifying ImGuiChildFlags_AutoResizeX or ImGuiChildFlags_AutoResizeY makes the sizing automatic based on child contents.
    Combining both ImGuiChildFlags_AutoResizeX _and_ ImGuiChildFlags_AutoResizeY defeats purpose of a scrolling region and is NOT recommended.
    - BeginChild() returns false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
    anything to the window. Always call a matching EndChild() for each BeginChild() call, regardless of its return value.
    [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
    such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
    BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
    """
    cdef bool res = ccimgui.ImGui_BeginChild(
        _bytes(str_id),
        _cast_tuple_ImVec2(size),
        child_flags,
        window_flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_child_id(id_: int, size: Tuple[float, float]=(0, 0), child_flags: int=0, window_flags: int=0):
    cdef bool res = ccimgui.ImGui_BeginChildID(
        id_,
        _cast_tuple_ImVec2(size),
        child_flags,
        window_flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_combo(label: str, preview_value: str, flags: int=0):
    """
    Widgets: Combo Box (Dropdown)
    - The BeginCombo()/EndCombo() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() items.
    - The old Combo() api are helpers over BeginCombo()/EndCombo() which are kept available for convenience purpose. This is analogous to how ListBox are created.
    """
    cdef bool res = ccimgui.ImGui_BeginCombo(
        _bytes(label),
        _bytes(preview_value),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def begin_disabled(disabled: bool=True):
    """
    Disabling [BETA API]
    - Disable all user interactions and dim items visuals (applying style.DisabledAlpha over current colors)
    - Those can be nested but it cannot be used to enable an already disabled section (a single BeginDisabled(true) in the stack is enough to keep everything disabled)
    - BeginDisabled(false) essentially does nothing useful but is provided to facilitate use of boolean expressions. If you can avoid calling BeginDisabled(False)/EndDisabled() best to avoid it.
    """
    ccimgui.ImGui_BeginDisabled(
        disabled
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_drag_drop_source(flags: int=0):
    """
    Drag and Drop
    - On source items, call BeginDragDropSource(), if it returns true also call SetDragDropPayload() + EndDragDropSource().
    - On target candidates, call BeginDragDropTarget(), if it returns true also call AcceptDragDropPayload() + EndDragDropTarget().
    - If you stop calling BeginDragDropSource() the payload is preserved however it won't have a preview tooltip (we currently display a fallback "..." tooltip, see #1725)
    - An item can be both drag source and drop target.
    Call after submitting an item which may be dragged. when this return true, you can call setdragdroppayload() + enddragdropsource()
    """
    cdef bool res = ccimgui.ImGui_BeginDragDropSource(
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_drag_drop_target():
    """
    Call after submitting an item that may receive a payload. if this returns true, you can call acceptdragdroppayload() + enddragdroptarget()
    """
    cdef bool res = ccimgui.ImGui_BeginDragDropTarget()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def begin_group():
    """
    Lock horizontal starting position
    """
    ccimgui.ImGui_BeginGroup()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_item_tooltip():
    """
    Tooltips: helpers for showing a tooltip when hovering an item
    - BeginItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip) && BeginTooltip())' idiom.
    - SetItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip)) ( SetTooltip(...); )' idiom.
    - Where 'ImGuiHoveredFlags_ForTooltip' itself is a shortcut to use 'style.HoverFlagsForTooltipMouse' or 'style.HoverFlagsForTooltipNav' depending on active input type. For mouse it defaults to 'ImGuiHoveredFlags_Stationary | ImGuiHoveredFlags_DelayShort'.
    Begin/append a tooltip window if preceding item was hovered.
    """
    cdef bool res = ccimgui.ImGui_BeginItemTooltip()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_list_box(label: str, size: Tuple[float, float]=(0, 0)):
    """
    Widgets: List Boxes
    - This is essentially a thin wrapper to using BeginChild/EndChild with the ImGuiChildFlags_FrameStyle flag for stylistic changes + displaying a label.
    - You can submit contents and manage your selection state however you want it, by creating e.g. Selectable() or any other items.
    - The simplified/old ListBox() api are helpers over BeginListBox()/EndListBox() which are kept available for convenience purpose. This is analoguous to how Combos are created.
    - Choose frame width:   size.x > 0.0f: custom  /  size.x < 0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
    - Choose frame height:  size.y > 0.0f: custom  /  size.y < 0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
    Open a framed scrolling region
    """
    cdef bool res = ccimgui.ImGui_BeginListBox(
        _bytes(label),
        _cast_tuple_ImVec2(size)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_main_menu_bar():
    """
    Create and append to a full screen menu-bar.
    """
    cdef bool res = ccimgui.ImGui_BeginMainMenuBar()
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_menu(label: str, enabled: bool=True):
    """
    Create a sub-menu entry. only call endmenu() if this returns true!
    """
    cdef bool res = ccimgui.ImGui_BeginMenuEx(
        _bytes(label),
        enabled
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_menu_bar():
    """
    Widgets: Menus
    - Use BeginMenuBar() on a window ImGuiWindowFlags_MenuBar to append to its menu bar.
    - Use BeginMainMenuBar() to create a menu bar at the top of the screen and append to it.
    - Use BeginMenu() to create a menu. You can call BeginMenu() multiple time with the same identifier to append more items to it.
    - Not that MenuItem() keyboardshortcuts are displayed as a convenience but _not processed_ by Dear ImGui at the moment.
    Append to menu-bar of current window (requires imguiwindowflags_menubar flag set on parent window).
    """
    cdef bool res = ccimgui.ImGui_BeginMenuBar()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def begin_menu_ex(label: str, enabled: bool=True):
#     """
#     Create a sub-menu entry. only call endmenu() if this returns true!
#     """
#     cdef bool res = ccimgui.ImGui_BeginMenuEx(
#         _bytes(label),
#         enabled
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_popup(str_id: str, flags: int=0):
    """
    Popups, Modals
    - They block normal mouse hovering detection (and therefore most mouse interactions) behind them.
    - If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
    - Their visibility state (~bool) is held internally instead of being held by the programmer as we are used to with regular Begin*() calls.
    - The 3 properties above are related: we need to retain popup visibility state in the library because popups may be closed as any time.
    - You can bypass the hovering restriction by using ImGuiHoveredFlags_AllowWhenBlockedByPopup when calling IsItemHovered() or IsWindowHovered().
    - IMPORTANT: Popup identifiers are relative to the current ID stack, so OpenPopup and BeginPopup generally needs to be at the same level of the stack.
    This is sometimes leading to confusing mistakes. May rework this in the future.
    - BeginPopup(): query popup state, if open start appending into the window. Call EndPopup() afterwards if returned true. ImGuiWindowFlags are forwarded to the window.
    - BeginPopupModal(): block every interaction behind the window, cannot be closed by user, add a dimming background, has a title bar.
    Return true if the popup is open, and you can start outputting to it.
    """
    cdef bool res = ccimgui.ImGui_BeginPopup(
        _bytes(str_id),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_popup_context_item(str_id: str=None, popup_flags: int=1):
    """
    Popups: open+begin combined functions helpers
    - Helpers to do OpenPopup+BeginPopup where the Open action is triggered by e.g. hovering an item and right-clicking.
    - They are convenient to easily create context menus, hence the name.
    - IMPORTANT: Notice that BeginPopupContextXXX takes ImGuiPopupFlags just like OpenPopup() and unlike BeginPopup(). For full consistency, we may add ImGuiWindowFlags to the BeginPopupContextXXX functions in the future.
    - IMPORTANT: Notice that we exceptionally default their flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter, so if you add other flags remember to re-add the ImGuiPopupFlags_MouseButtonRight.
    Implied str_id = null, popup_flags = 1
    Open+begin popup when clicked on last item. use str_id==null to associate the popup to previous item. if you want to use that on a non-interactive item such as text() you need to pass in an explicit id here. read comments in .cpp!
    """
    bytes_str_id = _bytes(str_id) if str_id is not None else None

    cdef bool res = ccimgui.ImGui_BeginPopupContextItemEx(
        ((<char*>bytes_str_id if str_id is not None else NULL)),
        popup_flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def begin_popup_context_item_ex(str_id: str=None, popup_flags: int=1):
#     """
#     Open+begin popup when clicked on last item. use str_id==null to associate the popup to previous item. if you want to use that on a non-interactive item such as text() you need to pass in an explicit id here. read comments in .cpp!
#     """
#     bytes_str_id = _bytes(str_id) if str_id is not None else None

#     cdef bool res = ccimgui.ImGui_BeginPopupContextItemEx(
#         ((<char*>bytes_str_id if str_id is not None else NULL)),
#         popup_flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_popup_context_void(str_id: str=None, popup_flags: int=1):
    """
    Open+begin popup when clicked in void (where there are no windows).
    """
    bytes_str_id = _bytes(str_id) if str_id is not None else None

    cdef bool res = ccimgui.ImGui_BeginPopupContextVoidEx(
        ((<char*>bytes_str_id if str_id is not None else NULL)),
        popup_flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def begin_popup_context_void_ex(str_id: str=None, popup_flags: int=1):
#     """
#     Open+begin popup when clicked in void (where there are no windows).
#     """
#     bytes_str_id = _bytes(str_id) if str_id is not None else None

#     cdef bool res = ccimgui.ImGui_BeginPopupContextVoidEx(
#         ((<char*>bytes_str_id if str_id is not None else NULL)),
#         popup_flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_popup_context_window(str_id: str=None, popup_flags: int=1):
    """
    Open+begin popup when clicked on current window.
    """
    bytes_str_id = _bytes(str_id) if str_id is not None else None

    cdef bool res = ccimgui.ImGui_BeginPopupContextWindowEx(
        ((<char*>bytes_str_id if str_id is not None else NULL)),
        popup_flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def begin_popup_context_window_ex(str_id: str=None, popup_flags: int=1):
#     """
#     Open+begin popup when clicked on current window.
#     """
#     bytes_str_id = _bytes(str_id) if str_id is not None else None

#     cdef bool res = ccimgui.ImGui_BeginPopupContextWindowEx(
#         ((<char*>bytes_str_id if str_id is not None else NULL)),
#         popup_flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_popup_modal(name: str, p_open: Bool=None, flags: int=0):
    """
    Return true if the modal is open, and you can start outputting to it.
    """
    cdef bool res = ccimgui.ImGui_BeginPopupModal(
        _bytes(name),
        Bool.ptr(p_open),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_tab_bar(str_id: str, flags: int=0):
    """
    Tab Bars, Tabs
    - Note: Tabs are automatically created by the docking system (when in 'docking' branch). Use this to create tab bars/tabs yourself.
    Create and append into a tabbar
    """
    cdef bool res = ccimgui.ImGui_BeginTabBar(
        _bytes(str_id),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_tab_item(label: str, p_open: Bool=None, flags: int=0):
    """
    Create a tab. returns true if the tab is selected.
    """
    cdef bool res = ccimgui.ImGui_BeginTabItem(
        _bytes(label),
        Bool.ptr(p_open),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_table(str_id: str, column: int, flags: int=0, outer_size: tuple=(0.0, 0.0), inner_width: float=0.0):
    """
    Tables
    - Full-featured replacement for old Columns API.
    - See Demo->Tables for demo code. See top of imgui_tables.cpp for general commentary.
    - See ImGuiTableFlags_ and ImGuiTableColumnFlags_ enums for a description of available flags.
    The typical call flow is:
    - 1. Call BeginTable(), early out if returning false.
    - 2. Optionally call TableSetupColumn() to submit column name/flags/defaults.
    - 3. Optionally call TableSetupScrollFreeze() to request scroll freezing of columns/rows.
    - 4. Optionally call TableHeadersRow() to submit a header row. Names are pulled from TableSetupColumn() data.
    - 5. Populate contents:
    - In most situations you can use TableNextRow() + TableSetColumnIndex(N) to start appending into a column.
    - If you are using tables as a sort of grid, where every column is holding the same type of contents,
    you may prefer using TableNextColumn() instead of TableNextRow() + TableSetColumnIndex().
    TableNextColumn() will automatically wrap-around into the next row if needed.
    - IMPORTANT: Comparatively to the old Columns() API, we need to call TableNextColumn() for the first column!
    - Summary of possible call flow:
    - TableNextRow() -> TableSetColumnIndex(0) -> Text("Hello 0") -> TableSetColumnIndex(1) -> Text("Hello 1")  // OK
    - TableNextRow() -> TableNextColumn()  -> Text("Hello 0") -> TableNextColumn()  -> Text("Hello 1")  // OK
    -   TableNextColumn()  -> Text("Hello 0") -> TableNextColumn()  -> Text("Hello 1")  // OK: TableNextColumn() automatically gets to next row!
    - TableNextRow()   -> Text("Hello 0")   // Not OK! Missing TableSetColumnIndex() or TableNextColumn()! Text will not appear!
    - 5. Call EndTable()
    Implied outer_size = imvec2(0.0f, 0.0f), inner_width = 0.0f
    """
    cdef bool res = ccimgui.ImGui_BeginTableEx(
        _bytes(str_id),
        column,
        flags,
        _cast_tuple_ImVec2(outer_size),
        inner_width
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def begin_table_ex(str_id: str, column: int, flags: int=0, outer_size: Tuple[float, float]=(0.0, 0.0), inner_width: float=0.0):
#     cdef bool res = ccimgui.ImGui_BeginTableEx(
#         _bytes(str_id),
#         column,
#         flags,
#         _cast_tuple_ImVec2(outer_size),
#         inner_width
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def begin_tooltip():
    """
    Tooltips
    - Tooltips are windows following the mouse. They do not take focus away.
    - A tooltip window can contain items of any types. SetTooltip() is a shortcut for the 'if (BeginTooltip()) ( Text(...); EndTooltip(); )' idiom.
    Begin/append a tooltip window.
    """
    cdef bool res = ccimgui.ImGui_BeginTooltip()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def bullet():
    """
    Draw a small circle + keep the cursor on the same line. advance cursor x position by gettreenodetolabelspacing(), same distance that treenode() uses
    """
    ccimgui.ImGui_Bullet()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def bullet_text(fmt: str):
    """
    Shortcut for bullet()+text()
    """
    ccimgui.ImGui_BulletText(
        _bytes(fmt)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def bullet_text_v(fmt: str):
#     ccimgui.ImGui_BulletTextV(
#         _bytes(fmt)
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def button(label: str, size: tuple=(0, 0)):
    """
    Widgets: Main
    - Most widgets return true when the value has been changed or when pressed/selected
    - You may also use one of the many IsItemXXX functions (e.g. IsItemActive, IsItemHovered, etc.) to query widget state.
    Implied size = imvec2(0, 0)
    """
    cdef bool res = ccimgui.ImGui_ButtonEx(
        _bytes(label),
        _cast_tuple_ImVec2(size)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def button_ex(label: str, size: Tuple[float, float]=(0, 0)):
#     """
#     Button
#     """
#     cdef bool res = ccimgui.ImGui_ButtonEx(
#         _bytes(label),
#         _cast_tuple_ImVec2(size)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def calc_item_width():
    """
    Width of item given pushed settings and current cursor position. not necessarily the width of last item unlike most 'item' functions.
    """
    cdef float res = ccimgui.ImGui_CalcItemWidth()
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def calc_text_size(text: str, text_end: str=None, hide_text_after_double_hash: bool=False, wrap_width: float=-1.0):
    """
    Text Utilities
    Implied text_end = null, hide_text_after_double_hash = false, wrap_width = -1.0f
    """
    bytes_text_end = _bytes(text_end) if text_end is not None else None

    cdef ccimgui.ImVec2 res = ccimgui.ImGui_CalcTextSizeEx(
        _bytes(text),
        ((<char*>bytes_text_end if text_end is not None else NULL)),
        hide_text_after_double_hash,
        wrap_width
    )
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
# def calc_text_size_ex(text: str, text_end: str=None, hide_text_after_double_hash: bool=False, wrap_width: float=-1.0):
#     bytes_text_end = _bytes(text_end) if text_end is not None else None

#     cdef ccimgui.ImVec2 res = ccimgui.ImGui_CalcTextSizeEx(
#         _bytes(text),
#         ((<char*>bytes_text_end if text_end is not None else NULL)),
#         hide_text_after_double_hash,
#         wrap_width
#     )
#     return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def checkbox(label: str, v: Bool):
    cdef bool res = ccimgui.ImGui_Checkbox(
        _bytes(label),
        &v.value
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?returns(bool)
def checkbox_flags(label: str, flags: Int, flags_value: int):
    cdef bool res = ccimgui.ImGui_CheckboxFlagsIntPtr(
        _bytes(label),
        &flags.value,
        flags_value
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def checkbox_flags_int_ptr(label: str, flags: Int, flags_value: int):
#     cdef bool res = ccimgui.ImGui_CheckboxFlagsIntPtr(
#         _bytes(label),
#         &flags.value,
#         flags_value
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def checkbox_flags_uint_ptr(label: str, flags: Int, flags_value: int):
#     cdef bool res = ccimgui.ImGui_CheckboxFlagsUintPtr(
#         _bytes(label),
#         &flags.value,
#         flags_value
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def close_current_popup():
    """
    Manually close the popup we have begin-ed into.
    """
    ccimgui.ImGui_CloseCurrentPopup()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def collapsing_header(label: str, flags: int=0):
    """
    If returning 'true' the header is open. doesn't indent nor push on id stack. user doesn't have to call treepop().
    """
    cdef bool res = ccimgui.ImGui_CollapsingHeader(
        _bytes(label),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def collapsing_header_bool_ptr(label: str, p_visible: Bool, flags: int=0):
    """
    When 'p_visible != null': if '*p_visible==true' display an additional small close button on upper right of the header which will set the bool to false when clicked, if '*p_visible==false' don't display the header.
    """
    cdef bool res = ccimgui.ImGui_CollapsingHeaderBoolPtr(
        _bytes(label),
        &p_visible.value,
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def color_button(desc_id: str, col: Tuple[float, float, float, float], flags: int=0, size: tuple=(0, 0)):
    """
    Display a color square/button, hover for details, return true when pressed.
    """
    cdef bool res = ccimgui.ImGui_ColorButtonEx(
        _bytes(desc_id),
        _cast_tuple_ImVec4(col),
        flags,
        _cast_tuple_ImVec2(size)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def color_button_ex(desc_id: str, col: Tuple[float, float, float, float], flags: int=0, size: Tuple[float, float]=(0, 0)):
#     """
#     Display a color square/button, hover for details, return true when pressed.
#     """
#     cdef bool res = ccimgui.ImGui_ColorButtonEx(
#         _bytes(desc_id),
#         _cast_tuple_ImVec4(col),
#         flags,
#         _cast_tuple_ImVec2(size)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def color_convert_float4_to_u32(in_: Tuple[float, float, float, float]):
    cdef ccimgui.ImU32 res = ccimgui.ImGui_ColorConvertFloat4ToU32(
        _cast_tuple_ImVec4(in_)
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(tuple)
def color_convert_hsv_to_rgb(h: float, s: float, value: float, a: float=1):
    cdef float c_floats[4]
    cdef Vec4 colour = Vec4(0, 0, 0, a)
    colour.to_array(c_floats)
    ccimgui.ImGui_ColorConvertHSVtoRGB(
        h,
        s,
        value,
        &c_floats[0],
        &c_floats[1],
        &c_floats[2],
    )
    colour.from_array(c_floats)
    return colour.tuple()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(tuple)
def color_convert_rgb_to_hsv(r: float, g: float, b: float, a: float=1):
    cdef float c_floats[4]
    cdef Vec4 colour = Vec4(0, 0, 0, a)
    colour.to_array(c_floats)
    ccimgui.ImGui_ColorConvertRGBtoHSV(
        r,
        g,
        b,
        &c_floats[0],
        &c_floats[1],
        &c_floats[2],
    )
    colour.from_array(c_floats)
    return colour.tuple()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float, float, float])
def color_convert_u32_to_float4(in_: int):
    """
    Color Utilities
    """
    cdef ccimgui.ImVec4 res = ccimgui.ImGui_ColorConvertU32ToFloat4(
        in_
    )
    return _cast_ImVec4_tuple(res)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def color_edit3(label: str, colour: Vec4, flags: int=0):
    """
    Widgets: Color Editor/Picker (tip: the ColorEdit* functions have a little color square that can be left-clicked to open a picker, and right-clicked to open an option menu.)
    - Note that in C++ a 'float v[X]' function argument is the _same_ as 'float* v', the array syntax is just a way to document the number of elements that are expected to be accessible.
    - You can pass the address of a first float element out of a contiguous structure, e.g. &myvector.x
    """
    cdef float c_floats[4]
    colour.to_array(c_floats)
    cdef bool res = ccimgui.ImGui_ColorEdit3(
        _bytes(label),
        c_floats,
        flags
    )
    colour.from_array(c_floats)
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def color_edit4(label: str, colour: Vec4, flags: int=0):
    cdef float c_floats[4]
    colour.to_array(c_floats)
    cdef bool res = ccimgui.ImGui_ColorEdit4(
        _bytes(label),
        c_floats,
        flags
    )
    colour.from_array(c_floats)
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def color_picker3(label: str, colour: Vec4, flags: int=0):
    cdef float c_floats[4]
    colour.to_array(c_floats)
    cdef bool res = ccimgui.ImGui_ColorPicker3(
        _bytes(label),
        c_floats,
        flags
    )
    colour.from_array(c_floats)
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def color_picker4(label: str, colour: Vec4, flags: int=0, ref_col: Vec4=None):
    cdef float c_floats[4]
    cdef float c_ref_col[4]
    cdef bool res

    colour.to_array(c_floats)
    if ref_col is not None:
        ref_col.to_array(c_ref_col)
        res = ccimgui.ImGui_ColorPicker4(
            _bytes(label),
            c_floats,
            flags,
            c_ref_col
        )
        ref_col.from_array(c_ref_col)
    else:
        res = ccimgui.ImGui_ColorPicker4(
            _bytes(label),
            c_floats,
            flags,
            NULL
        )
    colour.from_array(c_floats)
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def columns(count: int=1, id_: str=None, border: bool=True):
    """
    Legacy Columns API (prefer using Tables!)
    - You can also use SameLine(pos_x) to mimic simplified columns.
    Implied count = 1, id = null, border = true
    """
    bytes_id_ = _bytes(id_) if id_ is not None else None

    ccimgui.ImGui_ColumnsEx(
        count,
        ((<char*>bytes_id_ if id_ is not None else NULL)),
        border
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def columns_ex(count: int=1, id_: str=None, border: bool=True):
#     bytes_id_ = _bytes(id_) if id_ is not None else None

#     ccimgui.ImGui_ColumnsEx(
#         count,
#         ((<char*>bytes_id_ if id_ is not None else NULL)),
#         border
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def combo(label: str, current_item: Int, items: Sequence[str], popup_max_height_in_items: int=-1):
    """
    Separate items with \\0 within a string, end item-list with \\0\\0. e.g. 'one\\0two\\0three\\0'
    """
    cdef unsigned int buffer_length = sum(len(_bytes(b)) + 1 for b in items) + 1
    cdef char* c_strings = <char*>ccimgui.ImGui_MemAlloc(buffer_length)
    
    # Store items in array
    cdef int counter = 0
    for p_str in items:
        n_bytes = len(_bytes(p_str))
        strncpy(&c_strings[counter], _bytes(p_str), n_bytes)
        # Null terminated string
        c_strings[counter + n_bytes] = 0
        counter += n_bytes + 1
    
    # Null terminated list
    c_strings[counter] = 0

    cdef bool res = ccimgui.ImGui_ComboEx(
        _bytes(label),
        &current_item.value,
        c_strings,
        popup_max_height_in_items
    )
    ccimgui.ImGui_MemFree(c_strings)
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
combo_callback_data = {}
def combo_callback(label: str, current_item: Int, items_getter: Callable[[Any, int], str], data: Any, items_count: int, popup_max_height_in_items: int=-1):
    cdef bytes label_bytes = _bytes(label)
    cdef ccimgui.ImGuiID lookup_id = ccimgui.ImGui_GetID(label_bytes)
    combo_callback_data[lookup_id] = (items_getter, data)
    cdef bool res = ccimgui.ImGui_ComboCallbackEx(
        _bytes(label),
        &current_item.value,
        _combo_callback_function,
        <void*><uintptr_t>lookup_id, # Retrieve later to get the callback data
        items_count,
        popup_max_height_in_items
    )
    del combo_callback_data[lookup_id]
    return res

cdef const char* _combo_callback_function(void* data, int index) noexcept:
    cdef ccimgui.ImGuiID lookup_id = <uintptr_t>data
    if lookup_id not in combo_callback_data:
        raise RuntimeError("Did not find lookup_id: {}".format(lookup_id))
    items_getter, user_data = combo_callback_data[lookup_id]
    return _bytes(items_getter(user_data, index))
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def combo_callback_ex(label: str, current_item: Int, getter: Callable, user_data: Any, items_count: int, popup_max_height_in_items: int=-1):
#     cdef bool res = ccimgui.ImGui_ComboCallbackEx(
#         _bytes(label),
#         &current_item.value,
#         getter,
#         user_data,
#         items_count,
#         popup_max_height_in_items
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def combo_char(label: str, current_item: Int, items: Any, items_count: int):
#     """
#     Implied popup_max_height_in_items = -1
#     """
#     cdef bool res = ccimgui.ImGui_ComboChar(
#         _bytes(label),
#         &current_item.value,
#         items,
#         items_count
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def combo_char_ex(label: str, current_item: Int, items: Any, items_count: int, popup_max_height_in_items: int=-1):
#     cdef bool res = ccimgui.ImGui_ComboCharEx(
#         _bytes(label),
#         &current_item.value,
#         items,
#         items_count,
#         popup_max_height_in_items
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def combo_ex(label: str, current_item: Int, items_separated_by_zeros: str, popup_max_height_in_items: int=-1):
#     """
#     Separate items with \0 within a string, end item-list with \0\0. e.g. 'one\0two\0three\0'
#     """
#     cdef bool res = ccimgui.ImGui_ComboEx(
#         _bytes(label),
#         &current_item.value,
#         _bytes(items_separated_by_zeros),
#         popup_max_height_in_items
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiContext)
def create_context(shared_font_atlas: ImFontAtlas=None):
    """
    Context creation and access
    - Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
    - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
    for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
    """
    # This allows us to make ImGui use the same malloc and free as us in case it
    # didn't already.
    ccimgui.ImGui_SetAllocatorFunctions(_pygui_malloc, _pygui_free, NULL)
    cdef ccimgui.ImGuiContext* res = ccimgui.ImGui_CreateContext(
        <ccimgui.ImFontAtlas*>(NULL if shared_font_atlas is None else shared_font_atlas._ptr)
    )
    return ImGuiContext.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def debug_check_version_and_data_layout():
    """
    This is called by imgui_checkversion() macro.
    """
    cdef bool res = ccimgui.ImGui_DebugCheckVersionAndDataLayout(
        ccimgui.ImGui_GetVersion(),
        sizeof(ccimgui.ImGuiIO),
        sizeof(ccimgui.ImGuiStyle),
        sizeof(ccimgui.ImVec2),
        sizeof(ccimgui.ImVec4),
        sizeof(ccimgui.ImDrawVert),
        sizeof(ccimgui.ImDrawIdx)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def debug_flash_style_color(idx: int):
#     ccimgui.ImGui_DebugFlashStyleColor(
#         idx
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def debug_start_item_picker():
#     ccimgui.ImGui_DebugStartItemPicker()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def debug_text_encoding(text: str):
    """
    Debug Utilities
    - Your main debugging friend is the ShowMetricsWindow() function, which is also accessible from Demo->Tools->Metrics Debugger
    """
    ccimgui.ImGui_DebugTextEncoding(
        _bytes(text)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def destroy_context(ctx: ImGuiContext=None):
    """
    Null = destroy current context
    """
    ccimgui.ImGui_DestroyContext(
        <ccimgui.ImGuiContext*>(NULL if ctx is None else ctx._ptr)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def destroy_platform_windows():
#     """
#     Call destroywindow platform functions for all viewports. call from backend shutdown() if you need to close platform windows before imgui shutdown. otherwise will be called by destroycontext().
#     """
#     ccimgui.ImGui_DestroyPlatformWindows()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def dock_space(id_: int, size: tuple=(0, 0), flags: int=0, window_class: ImGuiWindowClass=None):
    """
    Docking
    [BETA API] Enable with io.ConfigFlags |= ImGuiConfigFlags_DockingEnable.
    Note: You can use most Docking facilities without calling any API. You DO NOT need to call DockSpace() to use Docking!
    - Drag from window title bar or their tab to dock/undock. Hold SHIFT to disable docking.
    - Drag from window menu button (upper-left button) to undock an entire node (all windows).
    - When io.ConfigDockingWithShift == true, you instead need to hold SHIFT to enable docking.
    About dockspaces:
    - Use DockSpaceOverViewport() to create an explicit dock node covering the screen or a specific viewport.
    This is often used with ImGuiDockNodeFlags_PassthruCentralNode to make it transparent.
    - Use DockSpace() to create an explicit dock node _within_ an existing window. See Docking demo for details.
    - Important: Dockspaces need to be submitted _before_ any window they can host. Submit it early in your frame!
    - Important: Dockspaces need to be kept alive if hidden, otherwise windows docked into it will be undocked.
    e.g. if you have multiple tabs with a dockspace inside each tab: submit the non-visible dockspaces with ImGuiDockNodeFlags_KeepAliveOnly.
    Implied size = imvec2(0, 0), flags = 0, window_class = null
    """
    cdef ccimgui.ImGuiID res = ccimgui.ImGui_DockSpaceEx(
        id_,
        _cast_tuple_ImVec2(size),
        flags,
        <ccimgui.ImGuiWindowClass*>(NULL if window_class is None else window_class._ptr)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(int)
# def dock_space_ex(id_: int, size: Tuple[float, float]=(0, 0), flags: int=0, window_class: ImGuiWindowClass=None):
#     cdef ccimgui.ImGuiID res = ccimgui.ImGui_DockSpaceEx(
#         id_,
#         _cast_tuple_ImVec2(size),
#         flags,
#         <ccimgui.ImGuiWindowClass*>(NULL if window_class is None else window_class._ptr)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def dock_space_over_viewport(viewport: ImGuiViewport=None, flags: int=0, window_class: ImGuiWindowClass=None):
    cdef ccimgui.ImGuiID res = ccimgui.ImGui_DockSpaceOverViewportEx(
        <ccimgui.ImGuiViewport*>(NULL if viewport is None else viewport._ptr),
        flags,
        <ccimgui.ImGuiWindowClass*>(NULL if window_class is None else window_class._ptr)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(int)
# def dock_space_over_viewport_ex(viewport: ImGuiViewport=None, flags: int=0, window_class: ImGuiWindowClass=None):
#     cdef ccimgui.ImGuiID res = ccimgui.ImGui_DockSpaceOverViewportEx(
#         <ccimgui.ImGuiViewport*>(NULL if viewport is None else viewport._ptr),
#         flags,
#         <ccimgui.ImGuiWindowClass*>(NULL if window_class is None else window_class._ptr)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_float(label: str, v: Float, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0):
    """
    Widgets: Drag Sliders
    - CTRL+Click on any drag box to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
    - For all the Float2/Float3/Float4/Int2/Int3/Int4 versions of every function, note that a 'float v[X]' function argument is the same as 'float* v',
    the array syntax is just a way to document the number of elements that are expected to be accessible. You can pass address of your first element out of a contiguous set, e.g. &myvector.x
    - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
    - Format string may also be set to NULL or use the default format ("%f" or "%d").
    - Speed are per-pixel of mouse movement (v_speed=0.2f: mouse needs to move by 5 pixels to increase value by 1). For gamepad/keyboard navigation, minimum speed is Max(v_speed, minimum_step_at_given_precision).
    - Use v_min < v_max to clamp edits to given limits. Note that CTRL+Click manual input can override those limits if ImGuiSliderFlags_AlwaysClamp is not used.
    - Use v_max = FLT_MAX / INT_MAX etc to avoid clamping to a maximum, same with v_min = -FLT_MAX / INT_MIN to avoid clamping to a minimum.
    - We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
    - Legacy: Pre-1.78 there are DragXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
    If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    If v_min >= v_max we have no bound
    """
    cdef bool res = ccimgui.ImGui_DragFloatEx(
        _bytes(label),
        &v.value,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_float2(label: str, float_ptrs: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0):
    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    """
    cdef float c_floats[2]
    c_floats[0] = float_ptrs[0].value
    c_floats[1] = float_ptrs[1].value

    cdef bool res = ccimgui.ImGui_DragFloat2Ex(
        _bytes(label),
        c_floats,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    float_ptrs[0].value = c_floats[0]
    float_ptrs[1].value = c_floats[1]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_float2_ex(label: str, v: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_DragFloat2Ex(
#         _bytes(label),
#         &v.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_float3(label: str, float_ptrs: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0):
    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    """
    cdef float c_floats[3]
    c_floats[0] = float_ptrs[0].value
    c_floats[1] = float_ptrs[1].value
    c_floats[2] = float_ptrs[2].value

    cdef bool res = ccimgui.ImGui_DragFloat3Ex(
        _bytes(label),
        c_floats,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    float_ptrs[0].value = c_floats[0]
    float_ptrs[1].value = c_floats[1]
    float_ptrs[2].value = c_floats[2]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_float3_ex(label: str, v: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_DragFloat3Ex(
#         _bytes(label),
#         &v.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_float4(label: str, float_ptrs: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0):
    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    """
    cdef float c_floats[4]
    c_floats[0] = float_ptrs[0].value
    c_floats[1] = float_ptrs[1].value
    c_floats[2] = float_ptrs[2].value
    c_floats[3] = float_ptrs[3].value

    cdef bool res = ccimgui.ImGui_DragFloat4Ex(
        _bytes(label),
        c_floats,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    float_ptrs[0].value = c_floats[0]
    float_ptrs[1].value = c_floats[1]
    float_ptrs[2].value = c_floats[2]
    float_ptrs[3].value = c_floats[3]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_float4_ex(label: str, v: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_DragFloat4Ex(
#         _bytes(label),
#         &v.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_float_ex(label: str, v: Float, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0):
#     """
#     If v_min >= v_max we have no bound
#     """
#     cdef bool res = ccimgui.ImGui_DragFloatEx(
#         _bytes(label),
#         &v.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_float_range2(label: str, v_current_min: Float, v_current_max: Float, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", format_max: str=None, flags: int=0):
    bytes_format_max = _bytes(format_max) if format_max is not None else None

    cdef bool res = ccimgui.ImGui_DragFloatRange2Ex(
        _bytes(label),
        &v_current_min.value,
        &v_current_max.value,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        ((<char*>bytes_format_max if format_max is not None else NULL)),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_float_range2_ex(label: str, v_current_min: Float, v_current_max: Float, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", format_max: str=None, flags: int=0):
#     bytes_format_max = _bytes(format_max) if format_max is not None else None

#     cdef bool res = ccimgui.ImGui_DragFloatRange2Ex(
#         _bytes(label),
#         &v_current_min.value,
#         &v_current_max.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         ((<char*>bytes_format_max if format_max is not None else NULL)),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_int(label: str, value: Int, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0):
    """
    If v_min >= v_max we have no bound
    """
    cdef bool res = ccimgui.ImGui_DragIntEx(
        _bytes(label),
        &value.value,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_int2(label: str, int_ptrs: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0):
    cdef int c_ints[2]
    c_ints[0] = int_ptrs[0].value
    c_ints[1] = int_ptrs[1].value
    
    cdef bool res = ccimgui.ImGui_DragInt2Ex(
        _bytes(label),
        c_ints,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    int_ptrs[0].value = c_ints[0]
    int_ptrs[1].value = c_ints[1]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_int2_ex(label: str, v: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0):
#     cdef bool res = ccimgui.ImGui_DragInt2Ex(
#         _bytes(label),
#         &v.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_int3(label: str, int_ptrs: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0):
    cdef int c_ints[3]
    c_ints[0] = int_ptrs[0].value
    c_ints[1] = int_ptrs[1].value
    c_ints[2] = int_ptrs[2].value

    cdef bool res = ccimgui.ImGui_DragInt3Ex(
        _bytes(label),
        c_ints,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    int_ptrs[0].value = c_ints[0]
    int_ptrs[1].value = c_ints[1]
    int_ptrs[2].value = c_ints[2]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_int3_ex(label: str, v: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0):
#     cdef bool res = ccimgui.ImGui_DragInt3Ex(
#         _bytes(label),
#         &v.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_int4(label: str, int_ptrs: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0):
    cdef int c_ints[4]
    c_ints[0] = int_ptrs[0].value
    c_ints[1] = int_ptrs[1].value
    c_ints[2] = int_ptrs[2].value
    c_ints[3] = int_ptrs[3].value

    cdef bool res = ccimgui.ImGui_DragInt4Ex(
        _bytes(label),
        c_ints,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    int_ptrs[0].value = c_ints[0]
    int_ptrs[1].value = c_ints[1]
    int_ptrs[2].value = c_ints[2]
    int_ptrs[3].value = c_ints[3]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_int4_ex(label: str, v: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0):
#     cdef bool res = ccimgui.ImGui_DragInt4Ex(
#         _bytes(label),
#         &v.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_int_ex(label: str, v: Int, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0):
#     """
#     If v_min >= v_max we have no bound
#     """
#     cdef bool res = ccimgui.ImGui_DragIntEx(
#         _bytes(label),
#         &v.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_int_range2(label: str, v_current_min: Int, v_current_max: Int, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", format_max: str=None, flags: int=0):
    bytes_format_max = _bytes(format_max) if format_max is not None else None

    cdef bool res = ccimgui.ImGui_DragIntRange2Ex(
        _bytes(label),
        &v_current_min.value,
        &v_current_max.value,
        v_speed,
        v_min,
        v_max,
        _bytes(format_),
        ((<char*>bytes_format_max if format_max is not None else NULL)),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_int_range2_ex(label: str, v_current_min: Int, v_current_max: Int, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", format_max: str=None, flags: int=0):
#     bytes_format_max = _bytes(format_max) if format_max is not None else None

#     cdef bool res = ccimgui.ImGui_DragIntRange2Ex(
#         _bytes(label),
#         &v_current_min.value,
#         &v_current_max.value,
#         v_speed,
#         v_min,
#         v_max,
#         _bytes(format_),
#         ((<char*>bytes_format_max if format_max is not None else NULL)),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_scalar(label: str, data_type: int, p_data: "Int | Long | Float | Double", v_speed: float=1.0, _min: "int | float"=None, _max: "int | float"=None, format_: str=None, flags: int=0):
    bytes_format_ = _bytes(format_) if format_ is not None else None
    
    cdef bool res
    cdef long long min_int
    cdef long long max_int
    cdef long long value_int
    cdef float min_float
    cdef float max_float
    cdef float value_float
    cdef double min_double
    cdef double max_double
    cdef double value_double
    if isinstance(p_data, Int) or isinstance(p_data, Long):
        min_int = _min if _min is not None else 0
        max_int = _max if _max is not None else 0
        value_int = p_data.value
        res = ccimgui.ImGui_DragScalarEx(
            _bytes(label),
            data_type,
            &value_int,
            v_speed,
            &min_int if _min is not None else NULL,
            &max_int if _max is not None else NULL,
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = value_int
    elif isinstance(p_data, Float):
        min_float = <float>(_min if _min is not None else 0)
        max_float = <float>(_max if _max is not None else 0)
        value_float = p_data.value
        res = ccimgui.ImGui_DragScalarEx(
            _bytes(label),
            data_type,
            &value_float,
            v_speed,
            &min_float if _min is not None else NULL,
            &max_float if _max is not None else NULL,
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = value_float
    else:
        min_double = <double>(_min if _min is not None else 0)
        max_double = <double>(_max if _max is not None else 0)
        value_double = p_data.value
        res = ccimgui.ImGui_DragScalarEx(
            _bytes(label),
            data_type,
            &value_double,
            v_speed,
            &min_double if _min is not None else NULL,
            &max_double if _max is not None else NULL,
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = value_double

    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_scalar_ex(label: str, data_type: int, p_data: Any, v_speed: float=1.0, p_min: Any=None, p_max: Any=None, format_: str=None, flags: int=0):
#     bytes_format_ = _bytes(format_) if format_ is not None else None

#     cdef bool res = ccimgui.ImGui_DragScalarEx(
#         _bytes(label),
#         data_type,
#         p_data,
#         v_speed,
#         p_min,
#         p_max,
#         ((<char*>bytes_format_ if format_ is not None else NULL)),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def drag_scalar_n(label: str, data_type: int, p_data: "Sequence[Int | Long | Float | Double]", components: int, v_speed: float=1.0, p_min: "int | float"=None, p_max: "int | float"=None, format_: str=None, flags: int=0):
    """
    Implied v_speed = 1.0f, p_min = null, p_max = null, format = null, flags = 0
    """
    IM_ASSERT(len(p_data) > 0, "Should probably have at least one component")
    
    bytes_format_ = _bytes(format_) if format_ is not None else None
    cdef long long long_long_size

    cdef int* c_ints
    cdef long long* c_longs
    cdef float* c_floats
    cdef double* c_doubles

    cdef int int_p_min
    cdef int int_p_max
    cdef long long long_p_min
    cdef long long long_p_max
    cdef float float_p_min
    cdef float float_p_max
    cdef double double_p_min
    cdef double double_p_max

    cdef bool res

    first = p_data[0]
    if isinstance(first, Int):
        c_ints = <int*>ccimgui.ImGui_MemAlloc(sizeof(int) * len(p_data))
        int_p_min = p_min if p_min is not None else 0
        int_p_max = p_max if p_min is not None else 0

        for i in range(len(p_data)):
            c_ints[i] = p_data[i].value

        res = ccimgui.ImGui_DragScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_ints,
            components,
            v_speed,
            <void*>(&int_p_min if p_min is not None else NULL),
            <void*>(&int_p_max if p_max is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_ints[i]

        ccimgui.ImGui_MemFree(c_ints)
    elif isinstance(first, Long):
        c_longs = <long long*>ccimgui.ImGui_MemAlloc(sizeof(long_long_size) * len(p_data))
        long_p_min = p_min if p_min is not None else 0
        long_p_max = p_max if p_min is not None else 0

        for i in range(len(p_data)):
            c_longs[i] = p_data[i].value

        res = ccimgui.ImGui_DragScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_longs,
            components,
            v_speed,
            <void*>(&long_p_min if p_min is not None else NULL),
            <void*>(&long_p_max if p_max is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_longs[i]

        ccimgui.ImGui_MemFree(c_longs)
    elif isinstance(first, Float):
        c_floats = <float*>ccimgui.ImGui_MemAlloc(sizeof(float) * len(p_data))
        float_p_min = p_min if p_min is not None else 0
        float_p_max = p_max if p_min is not None else 0

        for i in range(len(p_data)):
            c_floats[i] = p_data[i].value

        res = ccimgui.ImGui_DragScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_floats,
            components,
            v_speed,
            <void*>(&float_p_min if p_min is not None else NULL),
            <void*>(&float_p_max if p_max is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_floats[i]

        ccimgui.ImGui_MemFree(c_floats)
    else:
        c_doubles = <double*>ccimgui.ImGui_MemAlloc(sizeof(double) * len(p_data))
        double_p_min = p_min if p_min is not None else 0
        double_p_max = p_max if p_min is not None else 0

        for i in range(len(p_data)):
            c_doubles[i] = p_data[i].value

        res = ccimgui.ImGui_DragScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_doubles,
            components,
            v_speed,
            <void*>(&double_p_min if p_min is not None else NULL),
            <void*>(&double_p_max if p_max is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_doubles[i]

        ccimgui.ImGui_MemFree(c_doubles)
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def drag_scalar_n_ex(label: str, data_type: int, p_data: Any, components: int, v_speed: float=1.0, p_min: Any=None, p_max: Any=None, format_: str=None, flags: int=0):
#     bytes_format_ = _bytes(format_) if format_ is not None else None

#     cdef bool res = ccimgui.ImGui_DragScalarNEx(
#         _bytes(label),
#         data_type,
#         p_data,
#         components,
#         v_speed,
#         p_min,
#         p_max,
#         ((<char*>bytes_format_ if format_ is not None else NULL)),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def dummy(size: Tuple[float, float]):
    """
    Add a dummy item of given size. unlike invisiblebutton(), dummy() won't take the mouse click or be navigable into.
    """
    ccimgui.ImGui_Dummy(
        _cast_tuple_ImVec2(size)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end():
    ccimgui.ImGui_End()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_child():
    ccimgui.ImGui_EndChild()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_combo():
    """
    Only call endcombo() if begincombo() returns true!
    """
    ccimgui.ImGui_EndCombo()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_disabled():
    ccimgui.ImGui_EndDisabled()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_drag_drop_source():
    """
    Only call enddragdropsource() if begindragdropsource() returns true!
    """
    ccimgui.ImGui_EndDragDropSource()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_drag_drop_target():
    """
    Only call enddragdroptarget() if begindragdroptarget() returns true!
    """
    ccimgui.ImGui_EndDragDropTarget()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_frame():
    """
    Ends the dear imgui frame. automatically called by render(). if you don't need to render data (skipping rendering) you may call endframe() without render()... but you'll have wasted cpu already! if you don't need to render, better to not create any windows and not call newframe() at all!
    """
    ccimgui.ImGui_EndFrame()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_group():
    """
    Unlock horizontal starting position + capture the whole group bounding box into one 'item' (so you can use isitemhovered() or layout primitives such as sameline() on whole group, etc.)
    """
    ccimgui.ImGui_EndGroup()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_list_box():
    """
    Only call endlistbox() if beginlistbox() returned true!
    """
    ccimgui.ImGui_EndListBox()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_main_menu_bar():
    """
    Only call endmainmenubar() if beginmainmenubar() returns true!
    """
    ccimgui.ImGui_EndMainMenuBar()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_menu():
    """
    Only call endmenu() if beginmenu() returns true!
    """
    ccimgui.ImGui_EndMenu()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_menu_bar():
    """
    Only call endmenubar() if beginmenubar() returns true!
    """
    ccimgui.ImGui_EndMenuBar()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_popup():
    """
    Only call endpopup() if beginpopupxxx() returns true!
    """
    ccimgui.ImGui_EndPopup()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_tab_bar():
    """
    Only call endtabbar() if begintabbar() returns true!
    """
    ccimgui.ImGui_EndTabBar()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_tab_item():
    """
    Only call endtabitem() if begintabitem() returns true!
    """
    ccimgui.ImGui_EndTabItem()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_table():
    """
    Only call endtable() if begintable() returns true!
    """
    ccimgui.ImGui_EndTable()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def end_tooltip():
    """
    Only call endtooltip() if begintooltip()/beginitemtooltip() returns true!
    """
    ccimgui.ImGui_EndTooltip()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiViewport)
# def find_viewport_by_id(id_: int):
#     """
#     This is a helper for backends.
#     """
#     cdef ccimgui.ImGuiViewport* res = ccimgui.ImGui_FindViewportByID(
#         id_
#     )
#     return ImGuiViewport.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiViewport)
# def find_viewport_by_platform_handle(platform_handle: Any):
#     """
#     This is a helper for backends. the type platform_handle is decided by the backend (e.g. hwnd, mywindow*, glfwwindow* etc.)
#     """
#     cdef ccimgui.ImGuiViewport* res = ccimgui.ImGui_FindViewportByPlatformHandle(
#         platform_handle
#     )
#     return ImGuiViewport.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def get_allocator_functions(p_alloc_func: Callable, p_free_func: Callable, p_user_data: Any):
#     ccimgui.ImGui_GetAllocatorFunctions(
#         p_alloc_func,
#         p_free_func,
#         p_user_data
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImDrawList)
def get_background_draw_list(viewport: ImGuiViewport=None):
    """
    Background/Foreground Draw Lists
    If viewport is None, get background draw list for the viewport associated to the current window. this draw list will be the first rendering one. useful to quickly draw shapes/text behind dear imgui contents.
    Otherwise, get background draw list for the given viewport.
    """
    cdef ccimgui.ImDrawList* res
    if viewport is None:
        res = ccimgui.ImGui_GetBackgroundDrawList()
    else:
        res = ccimgui.ImGui_GetBackgroundDrawListImGuiViewportPtr(
            viewport._ptr
        )
    return ImDrawList.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(ImDrawList)
# def get_background_draw_list_imgui_viewport_ptr(viewport: ImGuiViewport):
#     """
#     Get background draw list for the given viewport. this draw list will be the first rendering one. useful to quickly draw shapes/text behind dear imgui contents.
#     """
#     cdef ccimgui.ImDrawList* res = ccimgui.ImGui_GetBackgroundDrawListImGuiViewportPtr(
#         viewport._ptr
#     )
#     return ImDrawList.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(str)
def get_clipboard_text():
    """
    Clipboard Utilities
    - Also see the LogToClipboard() function to capture GUI into clipboard, or easily output text data to the clipboard.
    """
    cdef const char* res = ccimgui.ImGui_GetClipboardText()
    return _from_bytes(res)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_color_u32(idx: int, alpha_mul: float=1.0):
    """
    Retrieve given style color with style alpha applied and optional extra alpha multiplier, packed as a 32-bit value suitable for imdrawlist
    """
    if idx >= COL_COUNT:
        raise IndexError("Perhaps you wanted to call get_color_u32_im_u32() instead?")
    cdef ccimgui.ImU32 res = ccimgui.ImGui_GetColorU32Ex(
        idx,
        alpha_mul
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(int)
# def get_color_u32_ex(idx: int, alpha_mul: float=1.0):
#     """
#     Retrieve given style color with style alpha applied and optional extra alpha multiplier, packed as a 32-bit value suitable for imdrawlist
#     """
#     cdef ccimgui.ImU32 res = ccimgui.ImGui_GetColorU32Ex(
#         idx,
#         alpha_mul
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_color_u32_im_u32(col: int):
    """
    Implied alpha_mul = 1.0f
    """
    cdef ccimgui.ImU32 res = ccimgui.ImGui_GetColorU32ImU32(
        col
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
# def get_color_u32_im_u32_ex(col: int, alpha_mul: float=1.0):
#     """
#     Retrieve given color with style alpha applied, packed as a 32-bit value suitable for imdrawlist
#     """
#     cdef ccimgui.ImU32 res = ccimgui.ImGui_GetColorU32ImU32Ex(
#         col,
#         alpha_mul
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_color_u32_im_vec4(col: Tuple[float, float, float, float]):
    """
    Retrieve given color with style alpha applied, packed as a 32-bit value suitable for imdrawlist
    """
    cdef ccimgui.ImU32 res = ccimgui.ImGui_GetColorU32ImVec4(
        _cast_tuple_ImVec4(col)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
# def get_column_index():
#     """
#     Get current column index
#     """
#     cdef int res = ccimgui.ImGui_GetColumnIndex()
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
# def get_column_offset(column_index: int=-1):
#     """
#     Get position of column line (in pixels, from the left side of the contents region). pass -1 to use current column, otherwise 0..getcolumnscount() inclusive. column 0 is typically 0.0f
#     """
#     cdef float res = ccimgui.ImGui_GetColumnOffset(
#         column_index
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
# def get_column_width(column_index: int=-1):
#     """
#     Get column width (in pixels). pass -1 to use current column
#     """
#     cdef float res = ccimgui.ImGui_GetColumnWidth(
#         column_index
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
# def get_columns_count():
#     cdef int res = ccimgui.ImGui_GetColumnsCount()
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_content_region_avail():
    """
    Content region
    - Retrieve available space from a given point. GetContentRegionAvail() is frequently useful.
    - Those functions are bound to be redesigned (they are confusing, incomplete and the Min/Max return values are in local window coordinates which increases confusion)
    == getcontentregionmax() - getcursorpos()
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetContentRegionAvail()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_content_region_max():
    """
    Current content boundaries (typically window boundaries including scrolling, or current column boundaries), in windows coordinates
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetContentRegionMax()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiContext)
def get_current_context():
    cdef ccimgui.ImGuiContext* res = ccimgui.ImGui_GetCurrentContext()
    return ImGuiContext.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_cursor_pos():
    """
    [window-local] cursor position in window coordinates (relative to window position)
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetCursorPos()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_cursor_pos_x():
    """
    [window-local] '
    """
    cdef float res = ccimgui.ImGui_GetCursorPosX()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_cursor_pos_y():
    """
    [window-local] '
    """
    cdef float res = ccimgui.ImGui_GetCursorPosY()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_cursor_screen_pos():
    """
    Layout cursor positioning
    - By "cursor" we mean the current output position.
    - The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
    - You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
    - Attention! We currently have inconsistencies between window-local and absolute positions we will aim to fix with future API:
    - Absolute coordinate:GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions. -> this is the preferred way forward.
    - Window-local coordinates:   SameLine(), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), GetContentRegionMax(), GetWindowContentRegion*(), PushTextWrapPos()
    - GetCursorScreenPos() = GetCursorPos() + GetWindowPos(). GetWindowPos() is almost only ever useful to convert from window-local to absolute coordinates.
    Cursor position in absolute coordinates (prefer using this, also more useful to work with imdrawlist api).
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetCursorScreenPos()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_cursor_start_pos():
    """
    [window-local] initial cursor position, in window coordinates
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetCursorStartPos()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiPayload)
def get_drag_drop_payload():
    """
    Peek directly into the current payload from anywhere. returns null when drag and drop is finished or inactive. use imguipayload::isdatatype() to test for the payload type.
    """
    cdef const ccimgui.ImGuiPayload* res = ccimgui.ImGui_GetDragDropPayload()
    return ImGuiPayload.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImDrawData)
def get_draw_data():
    """
    Valid after render() and until the next call to newframe(). this is what you have to render.
    """
    cdef ccimgui.ImDrawData* res = ccimgui.ImGui_GetDrawData()
    return ImDrawData.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(ImDrawListSharedData)
# def get_draw_list_shared_data():
#     """
#     You may use this when creating your own imdrawlist instances.
#     """
#     cdef ccimgui.ImDrawListSharedData* res = ccimgui.ImGui_GetDrawListSharedData()
#     return ImDrawListSharedData.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImFont)
def get_font():
    """
    Style read access
    - Use the ShowStyleEditor() function to interactively see/edit the colors.
    Get current font
    pygui note: Returns a const ImFont. Fields should only be read, not modified.
    """
    cdef const ccimgui.ImFont* res = ccimgui.ImGui_GetFont()
    return ImFont.from_const_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_font_size():
    """
    Get current font size (= height in pixels) of current font with current scale applied
    """
    cdef float res = ccimgui.ImGui_GetFontSize()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_font_tex_uv_white_pixel():
    """
    Get uv coordinate for a while pixel, useful to draw custom shapes via the imdrawlist api
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetFontTexUvWhitePixel()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImDrawList)
def get_foreground_draw_list(viewport: ImGuiViewport=None):
    """
    If viewport is None, get foreground draw list for the viewport associated to the current window. this draw list will be the last rendered one. useful to quickly draw shapes/text over dear imgui contents.
    Otherwise, get foreground draw list for the given viewport.
    """
    cdef ccimgui.ImDrawList* res
    if viewport is None:
        res = ccimgui.ImGui_GetForegroundDrawList()
    else:
        res = ccimgui.ImGui_GetForegroundDrawListImGuiViewportPtr(
            viewport._ptr
        )
    return ImDrawList.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(ImDrawList)
# def get_foreground_draw_list_imgui_viewport_ptr(viewport: ImGuiViewport):
#     """
#     Get foreground draw list for the given viewport. this draw list will be the last rendered one. useful to quickly draw shapes/text over dear imgui contents.
#     """
#     cdef ccimgui.ImDrawList* res = ccimgui.ImGui_GetForegroundDrawListImGuiViewportPtr(
#         viewport._ptr
#     )
#     return ImDrawList.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_frame_count():
    """
    Get global imgui frame count. incremented by 1 every frame.
    """
    cdef int res = ccimgui.ImGui_GetFrameCount()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_frame_height():
    """
    ~ fontsize + style.framepadding.y * 2
    """
    cdef float res = ccimgui.ImGui_GetFrameHeight()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_frame_height_with_spacing():
    """
    ~ fontsize + style.framepadding.y * 2 + style.itemspacing.y (distance in pixels between 2 consecutive lines of framed widgets)
    """
    cdef float res = ccimgui.ImGui_GetFrameHeightWithSpacing()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_id(str_id: str):
    """
    Calculate unique id (hash of whole id stack + given parameter). e.g. if you want to query into imguistorage yourself
    """
    cdef ccimgui.ImGuiID res = ccimgui.ImGui_GetID(
        _bytes(str_id)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
# def get_id_ptr(ptr_id: Any):
#     cdef ccimgui.ImGuiID res = ccimgui.ImGui_GetIDPtr(
#         ptr_id
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
# def get_id_str(str_id_begin: str, str_id_end: str):
#     cdef ccimgui.ImGuiID res = ccimgui.ImGui_GetIDStr(
#         _bytes(str_id_begin),
#         _bytes(str_id_end)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiIO)
def get_io():
    """
    Main
    Access the io structure (mouse/keyboard/gamepad inputs, time, various configuration options/flags)
    """
    cdef ccimgui.ImGuiIO* res = ccimgui.ImGui_GetIO()
    return ImGuiIO.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_item_id():
    """
    Get id of last item (~~ often same imgui::getid(label) beforehand)
    """
    cdef ccimgui.ImGuiID res = ccimgui.ImGui_GetItemID()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_item_rect_max():
    """
    Get lower-right bounding rectangle of the last item (screen space)
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetItemRectMax()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_item_rect_min():
    """
    Get upper-left bounding rectangle of the last item (screen space)
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetItemRectMin()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_item_rect_size():
    """
    Get size of last item
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetItemRectSize()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(str)
# def get_key_name(key: int):
#     """
#     [debug] returns english name of the key. those names a provided for debugging purpose and are not meant to be saved persistently not compared.
#     """
#     cdef const char* res = ccimgui.ImGui_GetKeyName(
#         key
#     )
#     return _from_bytes(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_key_pressed_amount(key: int, repeat_delay: float, rate: float):
    """
    Uses provided repeat rate/delay. return a count, most often 0 or 1 but might be >1 if repeatrate is small enough that deltatime > repeatrate
    """
    cdef int res = ccimgui.ImGui_GetKeyPressedAmount(
        key,
        repeat_delay,
        rate
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiViewport)
def get_main_viewport():
    """
    Viewports
    - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
    - In 'docking' branch with multi-viewport enabled, we extend this concept to have multiple active viewports.
    - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
    Return primary/default viewport. this can never be null.
    """
    cdef ccimgui.ImGuiViewport* res = ccimgui.ImGui_GetMainViewport()
    return ImGuiViewport.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_mouse_clicked_count(button: int):
    """
    Return the number of successive mouse-clicks at the time where a click happen (otherwise 0).
    """
    cdef int res = ccimgui.ImGui_GetMouseClickedCount(
        button
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_mouse_cursor():
    """
    Get desired mouse cursor shape. important: reset in imgui::newframe(), this is updated during the frame. valid before render(). if you use software rendering by setting io.mousedrawcursor imgui will render those for you
    """
    cdef ccimgui.ImGuiMouseCursor res = ccimgui.ImGui_GetMouseCursor()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_mouse_drag_delta(button: int=0, lock_threshold: float=-1.0):
    """
    Return the delta from the initial clicking position while the mouse button is pressed or was just released. this is locked and return 0.0f until the mouse moves past a distance threshold at least once (if lock_threshold < -1.0f, uses io.mousedraggingthreshold)
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetMouseDragDelta(
        button,
        lock_threshold
    )
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_mouse_pos():
    """
    Shortcut to imgui::getio().mousepos provided by user, to be consistent with other calls
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetMousePos()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_mouse_pos_on_opening_current_popup():
    """
    Retrieve mouse position at the time of opening popup we have beginpopup() into (helper to avoid user backing that value themselves)
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetMousePosOnOpeningCurrentPopup()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiPlatformIO)
def get_platform_io():
    """
    (Optional) Platform/OS interface for multi-viewport support
    Read comments around the ImGuiPlatformIO structure for more details.
    Note: You may use GetWindowViewport() to get the current viewport of the current window.
    Platform/renderer functions, for backend to setup + viewports list.
    """
    cdef ccimgui.ImGuiPlatformIO* res = ccimgui.ImGui_GetPlatformIO()
    return ImGuiPlatformIO.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_scroll_max_x():
    """
    Get maximum scrolling amount ~~ contentsize.x - windowsize.x - decorationssize.x
    """
    cdef float res = ccimgui.ImGui_GetScrollMaxX()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_scroll_max_y():
    """
    Get maximum scrolling amount ~~ contentsize.y - windowsize.y - decorationssize.y
    """
    cdef float res = ccimgui.ImGui_GetScrollMaxY()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_scroll_x():
    """
    Windows Scrolling
    - Any change of Scroll will be applied at the beginning of next frame in the first call to Begin().
    - You may instead use SetNextWindowScroll() prior to calling Begin() to avoid this delay, as an alternative to using SetScrollX()/SetScrollY().
    Get scrolling amount [0 .. getscrollmaxx()]
    """
    cdef float res = ccimgui.ImGui_GetScrollX()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_scroll_y():
    """
    Get scrolling amount [0 .. getscrollmaxy()]
    """
    cdef float res = ccimgui.ImGui_GetScrollY()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiStorage)
# def get_state_storage():
#     cdef ccimgui.ImGuiStorage* res = ccimgui.ImGui_GetStateStorage()
#     return ImGuiStorage.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiStyle)
def get_style():
    """
    Access the style structure (colors, sizes). always use pushstylecolor(), pushstylevar() to modify style mid-frame!
    """
    cdef ccimgui.ImGuiStyle* res = ccimgui.ImGui_GetStyle()
    return ImGuiStyle.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(str)
def get_style_color_name(idx: int):
    """
    Get a string corresponding to the enum value (for display, saving, etc.).
    """
    cdef const char* res = ccimgui.ImGui_GetStyleColorName(
        idx
    )
    return _from_bytes(res)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(tuple)
def get_style_color_vec4(idx: int):
    """
    Retrieve style color as stored in imguistyle structure. use to feed back into pushstylecolor(), otherwise use getcoloru32() to get style color with style alpha baked in.
    """
    cdef const ccimgui.ImVec4* res = ccimgui.ImGui_GetStyleColorVec4(
        idx
    )
    return _cast_ImVec4_tuple(dereference(res))
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_text_line_height():
    """
    ~ fontsize
    """
    cdef float res = ccimgui.ImGui_GetTextLineHeight()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_text_line_height_with_spacing():
    """
    ~ fontsize + style.itemspacing.y (distance in pixels between 2 consecutive lines of text)
    """
    cdef float res = ccimgui.ImGui_GetTextLineHeightWithSpacing()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_time():
    """
    Get global imgui time. incremented by io.deltatime every frame.
    """
    cdef double res = ccimgui.ImGui_GetTime()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_tree_node_to_label_spacing():
    """
    Horizontal distance preceding label when using treenode*() or bullet() == (g.fontsize + style.framepadding.x*2) for a regular unframed treenode
    """
    cdef float res = ccimgui.ImGui_GetTreeNodeToLabelSpacing()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(str)
def get_version():
    """
    Get the compiled version string e.g. '1.80 wip' (essentially the value for imgui_version from the compiled version of imgui.cpp)
    """
    cdef const char* res = ccimgui.ImGui_GetVersion()
    return _from_bytes(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_window_content_region_max():
    """
    Content boundaries max for the full window (roughly (0,0)+size-scroll) where size can be overridden with setnextwindowcontentsize(), in window coordinates
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetWindowContentRegionMax()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_window_content_region_min():
    """
    Content boundaries min for the full window (roughly (0,0)-scroll), in window coordinates
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetWindowContentRegionMin()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
def get_window_dock_id():
    cdef ccimgui.ImGuiID res = ccimgui.ImGui_GetWindowDockID()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_window_dpi_scale():
    """
    Get dpi scale currently associated to the current window's viewport.
    """
    cdef float res = ccimgui.ImGui_GetWindowDpiScale()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImDrawList)
def get_window_draw_list():
    """
    Get draw list associated to the current window, to append your own drawing primitives
    """
    cdef ccimgui.ImDrawList* res = ccimgui.ImGui_GetWindowDrawList()
    return ImDrawList.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_window_height():
    """
    Get current window height (shortcut for getwindowsize().y)
    """
    cdef float res = ccimgui.ImGui_GetWindowHeight()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_window_pos():
    """
    Get current window position in screen space (note: it is unlikely you need to use this. consider using current layout pos instead, getcursorscreenpos())
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetWindowPos()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(Tuple[float, float])
def get_window_size():
    """
    Get current window size (note: it is unlikely you need to use this. consider using getcursorscreenpos() and e.g. getcontentregionavail() instead)
    """
    cdef ccimgui.ImVec2 res = ccimgui.ImGui_GetWindowSize()
    return _cast_ImVec2_tuple(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiViewport)
def get_window_viewport():
    """
    Get viewport currently associated to the current window.
    """
    cdef ccimgui.ImGuiViewport* res = ccimgui.ImGui_GetWindowViewport()
    return ImGuiViewport.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(float)
def get_window_width():
    """
    Get current window width (shortcut for getwindowsize().x)
    """
    cdef float res = ccimgui.ImGui_GetWindowWidth()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def im_vector_construct(vector: Any):
#     """
#     Construct a zero-size imvector<> (of any type). this is primarily useful when calling imfontglyphrangesbuilder_buildranges()
#     """
#     ccimgui.ImVector_Construct(
#         vector
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def im_vector_destruct(vector: Any):
#     """
#     Destruct an imvector<> (of any type). important: frees the vector memory but does not call destructors on contained objects (if they have them)
#     """
#     ccimgui.ImVector_Destruct(
#         vector
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def image(user_texture_id: int, image_size: Tuple[float, float], uv0: tuple=(0, 0), uv1: tuple=(1, 1), tint_col: tuple=(1, 1, 1, 1), border_col: tuple=(0, 0, 0, 0)):
    """
    Widgets: Images
    - Read about ImTextureID here: https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples
    - 'uv0' and 'uv1' are texture coordinates. Read about them from the same link above.
    - Note that Image() may add +2.0f to provided size if a border is visible, ImageButton() adds style.FramePadding*2.0f to provided size.
    Implied uv0 = imvec2(0, 0), uv1 = imvec2(1, 1), tint_col = imvec4(1, 1, 1, 1), border_col = imvec4(0, 0, 0, 0)
    """
    ccimgui.ImGui_ImageEx(
        <ccimgui.ImTextureID><uintptr_t>user_texture_id,
        _cast_tuple_ImVec2(image_size),
        _cast_tuple_ImVec2(uv0),
        _cast_tuple_ImVec2(uv1),
        _cast_tuple_ImVec4(tint_col),
        _cast_tuple_ImVec4(border_col)
    )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def image_button(str_id: str, user_texture_id: int, image_size: Tuple[float, float], uv0: tuple=(0, 0), uv1: tuple=(1, 1), bg_col: tuple=(0, 0, 0, 0), tint_col: tuple=(1, 1, 1, 1)):
    """
    Implied uv0 = imvec2(0, 0), uv1 = imvec2(1, 1), bg_col = imvec4(0, 0, 0, 0), tint_col = imvec4(1, 1, 1, 1)
    """
    cdef bool res = ccimgui.ImGui_ImageButtonEx(
        _bytes(str_id),
        <ccimgui.ImTextureID>user_texture_id,
        _cast_tuple_ImVec2(image_size),
        _cast_tuple_ImVec2(uv0),
        _cast_tuple_ImVec2(uv1),
        _cast_tuple_ImVec4(bg_col),
        _cast_tuple_ImVec4(tint_col)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def image_button_ex(str_id: str, user_texture_id: Any, image_size: Tuple[float, float], uv0: Tuple[float, float]=(0, 0), uv1: Tuple[float, float]=(1, 1), bg_col: Tuple[float, float, float, float]=(0, 0, 0, 0), tint_col: Tuple[float, float, float, float]=(1, 1, 1, 1)):
#     cdef bool res = ccimgui.ImGui_ImageButtonEx(
#         _bytes(str_id),
#         user_texture_id,
#         _cast_tuple_ImVec2(image_size),
#         _cast_tuple_ImVec2(uv0),
#         _cast_tuple_ImVec2(uv1),
#         _cast_tuple_ImVec4(bg_col),
#         _cast_tuple_ImVec4(tint_col)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def image_ex(user_texture_id: Any, image_size: Tuple[float, float], uv0: Tuple[float, float]=(0, 0), uv1: Tuple[float, float]=(1, 1), tint_col: Tuple[float, float, float, float]=(1, 1, 1, 1), border_col: Tuple[float, float, float, float]=(0, 0, 0, 0)):
#     ccimgui.ImGui_ImageEx(
#         user_texture_id,
#         _cast_tuple_ImVec2(image_size),
#         _cast_tuple_ImVec2(uv0),
#         _cast_tuple_ImVec2(uv1),
#         _cast_tuple_ImVec4(tint_col),
#         _cast_tuple_ImVec4(border_col)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_char_callback(window: GLFWwindow, c: int):
#     ccimgui.ImGui_ImplGlfw_CharCallback(
#         window._ptr,
#         c
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_cursor_enter_callback(window: GLFWwindow, entered: float):
#     ccimgui.ImGui_ImplGlfw_CursorEnterCallback(
#         window._ptr,
#         entered
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_cursor_pos_callback(window: GLFWwindow, x: float, y: float):
#     ccimgui.ImGui_ImplGlfw_CursorPosCallback(
#         window._ptr,
#         x,
#         y
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def impl_glfw_init_for_open_gl(window, install_callbacks: bool):
    cdef uintptr_t adr = <uintptr_t>ctypes.addressof(window.contents)
    cdef bool res = ccimgui.ImGui_ImplGlfw_InitForOpenGL(
        <ccimgui.GLFWwindow*>adr,
        install_callbacks
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
# def impl_glfw_init_for_other(window: GLFWwindow, install_callbacks: bool):
#     cdef bool res = ccimgui.ImGui_ImplGlfw_InitForOther(
#         window._ptr,
#         install_callbacks
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
# def impl_glfw_init_for_vulkan(window: GLFWwindow, install_callbacks: bool):
#     cdef bool res = ccimgui.ImGui_ImplGlfw_InitForVulkan(
#         window._ptr,
#         install_callbacks
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_install_callbacks(window: GLFWwindow):
#     ccimgui.ImGui_ImplGlfw_InstallCallbacks(
#         window._ptr
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_key_callback(window: GLFWwindow, key: int, scancode: int, action: int, mods: int):
#     ccimgui.ImGui_ImplGlfw_KeyCallback(
#         window._ptr,
#         key,
#         scancode,
#         action,
#         mods
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_monitor_callback(window: GLFWwindow, event: int):
#     ccimgui.ImGui_ImplGlfw_MonitorCallback(
#         window._ptr,
#         event
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_mouse_button_callback(window: GLFWwindow, button: int, action: int, mods: int):
#     ccimgui.ImGui_ImplGlfw_MouseButtonCallback(
#         window._ptr,
#         button,
#         action,
#         mods
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def impl_glfw_new_frame():
    ccimgui.ImGui_ImplGlfw_NewFrame()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_restore_callbacks(window: GLFWwindow):
#     ccimgui.ImGui_ImplGlfw_RestoreCallbacks(
#         window._ptr
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_scroll_callback(window: GLFWwindow, xoffset: float, yoffset: float):
#     ccimgui.ImGui_ImplGlfw_ScrollCallback(
#         window._ptr,
#         xoffset,
#         yoffset
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_set_callbacks_chain_for_all_windows(chain_for_all_windows: bool):
#     ccimgui.ImGui_ImplGlfw_SetCallbacksChainForAllWindows(
#         chain_for_all_windows
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def impl_glfw_shutdown():
    ccimgui.ImGui_ImplGlfw_Shutdown()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_glfw_window_focus_callback(window: GLFWwindow, focused: int):
#     ccimgui.ImGui_ImplGlfw_WindowFocusCallback(
#         window._ptr,
#         focused
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
# def impl_open_gl3_create_device_objects():
#     cdef bool res = ccimgui.ImGui_ImplOpenGL3_CreateDeviceObjects()
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
# def impl_open_gl3_create_fonts_texture():
#     cdef bool res = ccimgui.ImGui_ImplOpenGL3_CreateFontsTexture()
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_open_gl3_destroy_device_objects():
#     ccimgui.ImGui_ImplOpenGL3_DestroyDeviceObjects()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def impl_open_gl3_destroy_fonts_texture():
#     ccimgui.ImGui_ImplOpenGL3_DestroyFontsTexture()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def impl_open_gl3_init(glsl_version: str=None):
    bytes_glsl_version = _bytes(glsl_version) if glsl_version is not None else None

    cdef bool res = ccimgui.ImGui_ImplOpenGL3_Init(
        ((<char*>bytes_glsl_version if glsl_version is not None else NULL))
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def impl_open_gl3_new_frame():
    ccimgui.ImGui_ImplOpenGL3_NewFrame()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def impl_open_gl3_render_draw_data(draw_data: ImDrawData):
    ccimgui.ImGui_ImplOpenGL3_RenderDrawData(
        draw_data._ptr
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def impl_open_gl3_shutdown():
    ccimgui.ImGui_ImplOpenGL3_Shutdown()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def indent(indent_w: float=0.0):
    """
    Move content position toward the right, by indent_w, or style.indentspacing if indent_w <= 0
    """
    ccimgui.ImGui_IndentEx(
        indent_w
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def indent_ex(indent_w: float=0.0):
#     """
#     Move content position toward the right, by indent_w, or style.indentspacing if indent_w <= 0
#     """
#     ccimgui.ImGui_IndentEx(
#         indent_w
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_double(label: str, v: Double, step: float=0.0, step_fast: float=0.0, format_: str="%.6f", flags: int=0):
    cdef bool res = ccimgui.ImGui_InputDoubleEx(
        _bytes(label),
        &v.value,
        step,
        step_fast,
        _bytes(format_),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_double_ex(label: str, v: Double, step: float=0.0, step_fast: float=0.0, format_: str="%.6f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_InputDoubleEx(
#         _bytes(label),
#         &v.value,
#         step,
#         step_fast,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_float(label: str, v: Float, step: float=0.0, step_fast: float=0.0, format_: str="%.3f", flags: int=0):
    cdef bool res = ccimgui.ImGui_InputFloatEx(
        _bytes(label),
        &v.value,
        step,
        step_fast,
        _bytes(format_),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_float2(label: str, float_ptrs: Sequence[Float], format_: str="%.3f", flags: int=0):
    cdef float c_floats[2]
    c_floats[0] = float_ptrs[0].value
    c_floats[1] = float_ptrs[1].value

    cdef bool res = ccimgui.ImGui_InputFloat2Ex(
        _bytes(label),
        c_floats,
        _bytes(format_),
        flags
    )
    float_ptrs[0].value = c_floats[0]
    float_ptrs[1].value = c_floats[1]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_float2_ex(label: str, v: Sequence[Float], format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_InputFloat2Ex(
#         _bytes(label),
#         &v.value,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_float3(label: str, float_ptrs: Sequence[Float], format_: str="%.3f", flags: int=0):
    cdef float c_floats[3]
    c_floats[0] = float_ptrs[0].value
    c_floats[1] = float_ptrs[1].value
    c_floats[2] = float_ptrs[2].value

    cdef bool res = ccimgui.ImGui_InputFloat3Ex(
        _bytes(label),
        c_floats,
        _bytes(format_),
        flags
    )
    float_ptrs[0].value = c_floats[0]
    float_ptrs[1].value = c_floats[1]
    float_ptrs[2].value = c_floats[2]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_float3_ex(label: str, v: Sequence[Float], format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_InputFloat3Ex(
#         _bytes(label),
#         &v.value,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_float4(label: str, float_ptrs: Sequence[Float], format_: str="%.3f", flags: int=0):
    cdef float c_floats[4]
    c_floats[0] = float_ptrs[0].value
    c_floats[1] = float_ptrs[1].value
    c_floats[2] = float_ptrs[2].value
    c_floats[3] = float_ptrs[3].value

    cdef bool res = ccimgui.ImGui_InputFloat4Ex(
        _bytes(label),
        c_floats,
        _bytes(format_),
        flags
    )
    float_ptrs[0].value = c_floats[0]
    float_ptrs[1].value = c_floats[1]
    float_ptrs[2].value = c_floats[2]
    float_ptrs[3].value = c_floats[3]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_float4_ex(label: str, v: Sequence[Float], format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_InputFloat4Ex(
#         _bytes(label),
#         &v.value,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_float_ex(label: str, v: Float, step: float=0.0, step_fast: float=0.0, format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_InputFloatEx(
#         _bytes(label),
#         &v.value,
#         step,
#         step_fast,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_int(label: str, v: Int):
    """
    Implied step = 1, step_fast = 100, flags = 0
    """
    cdef bool res = ccimgui.ImGui_InputInt(
        _bytes(label),
        &v.value
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_int2(label: str, int_ptrs: Sequence[Int], flags: int=0):
    cdef int c_ints[2]
    c_ints[0] = int_ptrs[0].value
    c_ints[1] = int_ptrs[1].value

    cdef bool res = ccimgui.ImGui_InputInt2(
        _bytes(label),
        c_ints,
        flags
    )
    int_ptrs[0].value = c_ints[0]
    int_ptrs[1].value = c_ints[1]
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_int3(label: str, int_ptrs: Sequence[Int], flags: int=0):
    cdef int c_ints[3]
    c_ints[0] = int_ptrs[0].value
    c_ints[1] = int_ptrs[1].value
    c_ints[2] = int_ptrs[2].value

    cdef bool res = ccimgui.ImGui_InputInt3(
        _bytes(label),
        c_ints,
        flags
    )
    int_ptrs[0].value = c_ints[0]
    int_ptrs[1].value = c_ints[1]
    int_ptrs[2].value = c_ints[2]
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_int4(label: str, int_ptrs: Sequence[Int], flags: int=0):
    cdef int c_ints[4]
    c_ints[0] = int_ptrs[0].value
    c_ints[1] = int_ptrs[1].value
    c_ints[2] = int_ptrs[2].value
    c_ints[3] = int_ptrs[3].value

    cdef bool res = ccimgui.ImGui_InputInt4(
        _bytes(label),
        c_ints,
        flags
    )
    int_ptrs[0].value = c_ints[0]
    int_ptrs[1].value = c_ints[1]
    int_ptrs[2].value = c_ints[2]
    int_ptrs[3].value = c_ints[3]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
def input_int_ex(label: str, v: Int, step: int=1, step_fast: int=100, flags: int=0):
    cdef bool res = ccimgui.ImGui_InputIntEx(
        _bytes(label),
        &v.value,
        step,
        step_fast,
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_scalar(label: str, data_type: int, p_data: "Int | Long | Float | Double", step: "int | float"=None, step_fast: "int | float"=None, format_: str=None, flags: int=0):
    bytes_format_ = _bytes(format_) if format_ is not None else None

    cdef bool res
    cdef long long step_int
    cdef long long step_fast_int
    cdef long long data_int
    cdef float step_float
    cdef float step_fast_float
    cdef float data_float
    cdef double step_double
    cdef double step_fast_double
    cdef double data_double
    if isinstance(p_data, Int) or isinstance(p_data, Long):
        step_int = step if step is not None else 0
        step_fast_int = step_fast if step_fast is not None else 0
        data_int = p_data.value
        res = ccimgui.ImGui_InputScalarEx(
            _bytes(label),
            data_type,
            &data_int,
            <void*>(&step_int if step is not None else NULL),
            <void*>(&step_fast_int if step_fast is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = data_int
    elif isinstance(p_data, Float):
        step_float = step if step is not None else 0
        step_fast_float = step_fast if step_fast is not None else 0
        data_float = p_data.value
        res = ccimgui.ImGui_InputScalarEx(
            _bytes(label),
            data_type,
            &data_float,
            <void*>(&step_float if step is not None else NULL),
            <void*>(&step_fast_float if step_fast is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = data_float
    else:
        step_double = step if step is not None else 0
        step_fast_double = step_fast if step_fast is not None else 0
        data_double = p_data.value
        res = ccimgui.ImGui_InputScalarEx(
            _bytes(label),
            data_type,
            &data_double,
            <void*>(&step_double if step is not None else NULL),
            <void*>(&step_fast_double if step_fast is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = data_double

    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_scalar_ex(label: str, data_type: int, p_data: Any, p_step: Any=None, p_step_fast: Any=None, format_: str=None, flags: int=0):
#     bytes_format_ = _bytes(format_) if format_ is not None else None

#     cdef bool res = ccimgui.ImGui_InputScalarEx(
#         _bytes(label),
#         data_type,
#         p_data,
#         p_step,
#         p_step_fast,
#         ((<char*>bytes_format_ if format_ is not None else NULL)),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)

def input_scalar_n(label: str, data_type: int, p_data: "Sequence[Int | Long | Float | Double]", components: int, p_step: "int | float"=None, p_step_fast: "int | float"=None, format_: str=None, flags: int=0):
    IM_ASSERT(len(p_data) > 0, "Should probably have at least one component")
    
    bytes_format_ = _bytes(format_) if format_ is not None else None
    cdef long long long_long_size

    cdef int* c_ints
    cdef long long* c_longs
    cdef float* c_floats
    cdef double* c_doubles

    cdef int int_p_step
    cdef int int_p_step_fast
    cdef long long long_p_step
    cdef long long long_p_step_fast
    cdef float float_p_step
    cdef float float_p_step_fast
    cdef double double_p_step
    cdef double double_p_step_fast

    cdef bool res

    first = p_data[0]
    if isinstance(first, Int):
        c_ints = <int*>ccimgui.ImGui_MemAlloc(sizeof(int) * len(p_data))
        int_p_step = p_step if p_step is not None else 0
        int_p_step_fast = p_step_fast if p_step is not None else 0

        for i in range(len(p_data)):
            c_ints[i] = p_data[i].value

        res = ccimgui.ImGui_InputScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_ints,
            components,
            <void*>(&int_p_step if p_step is not None else NULL),
            <void*>(&int_p_step_fast if p_step_fast is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_ints[i]

        ccimgui.ImGui_MemFree(c_ints)
    elif isinstance(first, Long):
        c_longs = <long long*>ccimgui.ImGui_MemAlloc(sizeof(long_long_size) * len(p_data))
        long_p_step = p_step if p_step is not None else 0
        long_p_step_fast = p_step_fast if p_step is not None else 0

        for i in range(len(p_data)):
            c_longs[i] = p_data[i].value

        res = ccimgui.ImGui_InputScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_longs,
            components,
            <void*>(&long_p_step if p_step is not None else NULL),
            <void*>(&long_p_step_fast if p_step_fast is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_longs[i]

        ccimgui.ImGui_MemFree(c_longs)
    elif isinstance(first, Float):
        c_floats = <float*>ccimgui.ImGui_MemAlloc(sizeof(float) * len(p_data))
        float_p_step = p_step if p_step is not None else 0
        float_p_step_fast = p_step_fast if p_step is not None else 0

        for i in range(len(p_data)):
            c_floats[i] = p_data[i].value

        res = ccimgui.ImGui_InputScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_floats,
            components,
            <void*>(&float_p_step if p_step is not None else NULL),
            <void*>(&float_p_step_fast if p_step_fast is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_floats[i]

        ccimgui.ImGui_MemFree(c_floats)
    else:
        c_doubles = <double*>ccimgui.ImGui_MemAlloc(sizeof(double) * len(p_data))
        double_p_step = p_step if p_step is not None else 0
        double_p_step_fast = p_step_fast if p_step is not None else 0

        for i in range(len(p_data)):
            c_doubles[i] = p_data[i].value

        res = ccimgui.ImGui_InputScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_doubles,
            components,
            <void*>(&double_p_step if p_step is not None else NULL),
            <void*>(&double_p_step_fast if p_step_fast is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_doubles[i]

        ccimgui.ImGui_MemFree(c_doubles)
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_scalar_n_ex(label: str, data_type: int, p_data: Any, components: int, p_step: Any=None, p_step_fast: Any=None, format_: str=None, flags: int=0):
#     bytes_format_ = _bytes(format_) if format_ is not None else None

#     cdef bool res = ccimgui.ImGui_InputScalarNEx(
#         _bytes(label),
#         data_type,
#         p_data,
#         components,
#         p_step,
#         p_step_fast,
#         ((<char*>bytes_format_ if format_ is not None else NULL)),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
_input_text_user_data = {}
def input_text(label: str, buf: String, flags: int=0, callback: "Callable[[ImGuiInputTextCallbackData, Any], int]"=None, user_data: Any=None):
    """
    Widgets: Input with Keyboard
    - If you want to use InputText() with std::string or any custom dynamic string type, see misc/cpp/imgui_stdlib.h and comments in imgui_demo.cpp.
    - Most of the ImGuiInputTextFlags flags are only useful for InputText() and not for InputFloatX, InputIntX, InputDouble etc.
    Implied callback = null, user_data = null
    """
    # Pygui note. Since I want to the user to be able to send through python
    # objects for the callback, I instead store the user_data inside a dictionary
    # and pass through the label for this input_text as a lookup value.
    cdef ccimgui.ImGuiID widget_id = ccimgui.ImGui_GetID(_bytes(label))
    cdef bool res
    if callback is not None:
        _input_text_user_data[widget_id] = (callback, user_data)
        res = ccimgui.ImGui_InputTextEx(
            _bytes(label),
            buf.buffer,
            buf.buffer_size,
            flags,
            <ccimgui.ImGuiInputTextCallback>_input_text_callback,
            <void*>widget_id
        )
    else:
        res = ccimgui.ImGui_InputTextEx(
            _bytes(label),
            buf.buffer,
            buf.buffer_size,
            flags,
            NULL,
            NULL
        )

    return res

cdef int _input_text_callback(ccimgui.ImGuiInputTextCallbackData callback_data):
    cdef ccimgui.ImGuiID widget_id = <ccimgui.ImGuiID>callback_data.UserData
    if widget_id not in _input_text_user_data:
        raise RuntimeError("Did not find widget_id: {}".format(widget_id))
    
    python_callback, user_data = _input_text_user_data[widget_id]
    callback_return_value = python_callback(
        ImGuiInputTextCallbackData.from_ptr(&callback_data),
        user_data
    )
    if isinstance(callback_return_value, int):
        return callback_return_value
    return 0
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_text_ex(label: str, buf: str, buf_size: int, flags: int=0, callback: Callable=None, user_data: Any=None):
#     cdef bool res = ccimgui.ImGui_InputTextEx(
#         _bytes(label),
#         _bytes(buf),
#         buf_size,
#         flags,
#         callback,
#         user_data
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_text_multiline(label: str, buf: String, size: tuple=(0, 0), flags: int=0, callback: "Callable[[ImGuiInputTextCallbackData, Any], int]"=None, user_data: Any=None):
    cdef ccimgui.ImGuiID widget_id = ccimgui.ImGui_GetID(_bytes(label))
    cdef bool res
    if callback is not None:
        _input_text_user_data[widget_id] = (callback, user_data)
        res = ccimgui.ImGui_InputTextMultilineEx(
            _bytes(label),
            buf.buffer,
            buf.buffer_size,
            _cast_tuple_ImVec2(size),
            flags,
            <ccimgui.ImGuiInputTextCallback>_input_text_callback,
            <void*>widget_id
        )
    else:
        res = ccimgui.ImGui_InputTextMultilineEx(
            _bytes(label),
            buf.buffer,
            buf.buffer_size,
            _cast_tuple_ImVec2(size),
            flags,
            NULL,
            NULL
        )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_text_multiline_ex(label: str, buf: str, buf_size: int, size: Tuple[float, float]=(0, 0), flags: int=0, callback: Callable=None, user_data: Any=None):
#     cdef bool res = ccimgui.ImGui_InputTextMultilineEx(
#         _bytes(label),
#         _bytes(buf),
#         buf_size,
#         _cast_tuple_ImVec2(size),
#         flags,
#         callback,
#         user_data
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def input_text_with_hint(label: str, hint: str, buf: String, flags: int=0, callback: "Callable[[ImGuiInputTextCallbackData, Any], int]"=None, user_data: Any=None):
    cdef ccimgui.ImGuiID widget_id = ccimgui.ImGui_GetID(_bytes(label))
    cdef bool res
    if callback is not None:
        _input_text_user_data[widget_id] = (callback, user_data)
        res = ccimgui.ImGui_InputTextWithHintEx(
            _bytes(label),
            _bytes(hint),
            buf.buffer,
            buf.buffer_size,
            flags,
            <ccimgui.ImGuiInputTextCallback>_input_text_callback,
            <void*>widget_id
        )
    else:
        res = ccimgui.ImGui_InputTextWithHintEx(
            _bytes(label),
            _bytes(hint),
            buf.buffer,
            buf.buffer_size,
            flags,
            NULL,
            NULL
        )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def input_text_with_hint_ex(label: str, hint: str, buf: str, buf_size: int, flags: int=0, callback: Callable=None, user_data: Any=None):
#     cdef bool res = ccimgui.ImGui_InputTextWithHintEx(
#         _bytes(label),
#         _bytes(hint),
#         _bytes(buf),
#         buf_size,
#         flags,
#         callback,
#         user_data
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def invisible_button(str_id: str, size: Tuple[float, float], flags: int=0):
    """
    Flexible button behavior without the visuals, frequently useful to build custom behaviors using the public api (along with isitemactive, isitemhovered, etc.)
    """
    cdef bool res = ccimgui.ImGui_InvisibleButton(
        _bytes(str_id),
        _cast_tuple_ImVec2(size),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_any_item_active():
    """
    Is any item active?
    """
    cdef bool res = ccimgui.ImGui_IsAnyItemActive()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_any_item_focused():
    """
    Is any item focused?
    """
    cdef bool res = ccimgui.ImGui_IsAnyItemFocused()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_any_item_hovered():
    """
    Is any item hovered?
    """
    cdef bool res = ccimgui.ImGui_IsAnyItemHovered()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_any_mouse_down():
    """
    [will obsolete] is any mouse button held? this was designed for backends, but prefer having backend maintain a mask of held mouse buttons, because upcoming input queue system will make this invalid.
    """
    cdef bool res = ccimgui.ImGui_IsAnyMouseDown()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_activated():
    """
    Was the last item just made active (item was previously inactive).
    """
    cdef bool res = ccimgui.ImGui_IsItemActivated()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_active():
    """
    Is the last item active? (e.g. button being held, text field being edited. this will continuously return true while holding mouse button on an item. items that don't interact will always return false)
    """
    cdef bool res = ccimgui.ImGui_IsItemActive()
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_clicked(mouse_button: int=0):
    """
    Is the last item hovered and mouse clicked on? (**)  == ismouseclicked(mouse_button) && isitemhovered()important. (**) this is not equivalent to the behavior of e.g. button(). read comments in function definition.
    """
    cdef bool res = ccimgui.ImGui_IsItemClickedEx(
        mouse_button
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def is_item_clicked_ex(mouse_button: int=0):
#     """
#     Is the last item hovered and mouse clicked on? (**)  == ismouseclicked(mouse_button) && isitemhovered()important. (**) this is not equivalent to the behavior of e.g. button(). read comments in function definition.
#     """
#     cdef bool res = ccimgui.ImGui_IsItemClickedEx(
#         mouse_button
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_deactivated():
    """
    Was the last item just made inactive (item was previously active). useful for undo/redo patterns with widgets that require continuous editing.
    """
    cdef bool res = ccimgui.ImGui_IsItemDeactivated()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_deactivated_after_edit():
    """
    Was the last item just made inactive and made a value change when it was active? (e.g. slider/drag moved). useful for undo/redo patterns with widgets that require continuous editing. note that you may get false positives (some widgets such as combo()/listbox()/selectable() will return true even when clicking an already selected item).
    """
    cdef bool res = ccimgui.ImGui_IsItemDeactivatedAfterEdit()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_edited():
    """
    Did the last item modify its underlying value this frame? or was pressed? this is generally the same as the 'bool' return value of many widgets.
    """
    cdef bool res = ccimgui.ImGui_IsItemEdited()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_focused():
    """
    Is the last item focused for keyboard/gamepad navigation?
    """
    cdef bool res = ccimgui.ImGui_IsItemFocused()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_hovered(flags: int=0):
    """
    Item/Widgets Utilities and Query Functions
    - Most of the functions are referring to the previous Item that has been submitted.
    - See Demo Window under "Widgets->Querying Status" for an interactive visualization of most of those functions.
    Is the last item hovered? (and usable, aka not blocked by a popup, etc.). see imguihoveredflags for more options.
    """
    cdef bool res = ccimgui.ImGui_IsItemHovered(
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_toggled_open():
    """
    Was the last item open state toggled? set by treenode().
    """
    cdef bool res = ccimgui.ImGui_IsItemToggledOpen()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_item_visible():
    """
    Is the last item visible? (items may be out of sight because of clipping/scrolling)
    """
    cdef bool res = ccimgui.ImGui_IsItemVisible()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
# def is_key_chord_pressed(key_chord: int):
#     """
#     Was key chord (mods + key) pressed, e.g. you can pass 'imguimod_ctrl | imguikey_s' as a key-chord. this doesn't do any routing or focus check, please consider using shortcut() function instead.
#     """
#     cdef bool res = ccimgui.ImGui_IsKeyChordPressed(
#         key_chord
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_key_down(key: int):
    """
    Inputs Utilities: Keyboard/Mouse/Gamepad
    - the ImGuiKey enum contains all possible keyboard, mouse and gamepad inputs (e.g. ImGuiKey_A, ImGuiKey_MouseLeft, ImGuiKey_GamepadDpadUp...).
    - before v1.87, we used ImGuiKey to carry native/user indices as defined by each backends. About use of those legacy ImGuiKey values:
    - without IMGUI_DISABLE_OBSOLETE_KEYIO (legacy support): you can still use your legacy native/user indices (< 512) according to how your backend/engine stored them in io.KeysDown[], but need to cast them to ImGuiKey.
    - withIMGUI_DISABLE_OBSOLETE_KEYIO (this is the way forward): any use of ImGuiKey will assert with key < 512. GetKeyIndex() is pass-through and therefore deprecated (gone if IMGUI_DISABLE_OBSOLETE_KEYIO is defined).
    Is key being held.
    """
    cdef bool res = ccimgui.ImGui_IsKeyDown(
        key
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_key_pressed(key: int, repeat: bool=True):
    """
    Was key pressed (went from !down to down)? if repeat=true, uses io.keyrepeatdelay / keyrepeatrate
    """
    cdef bool res = ccimgui.ImGui_IsKeyPressedEx(
        key,
        repeat
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def is_key_pressed_ex(key: int, repeat: bool=True):
#     """
#     Was key pressed (went from !down to down)? if repeat=true, uses io.keyrepeatdelay / keyrepeatrate
#     """
#     cdef bool res = ccimgui.ImGui_IsKeyPressedEx(
#         key,
#         repeat
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_key_released(key: int):
    """
    Was key released (went from down to !down)?
    """
    cdef bool res = ccimgui.ImGui_IsKeyReleased(
        key
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_mouse_clicked(button: int, repeat: bool=False):
    """
    Did mouse button clicked? (went from !down to down). same as getmouseclickedcount() == 1.
    """
    cdef bool res = ccimgui.ImGui_IsMouseClickedEx(
        button,
        repeat
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def is_mouse_clicked_ex(button: int, repeat: bool=False):
#     """
#     Did mouse button clicked? (went from !down to down). same as getmouseclickedcount() == 1.
#     """
#     cdef bool res = ccimgui.ImGui_IsMouseClickedEx(
#         button,
#         repeat
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_mouse_double_clicked(button: int):
    """
    Did mouse button double-clicked? same as getmouseclickedcount() == 2. (note that a double-click will also report ismouseclicked() == true)
    """
    cdef bool res = ccimgui.ImGui_IsMouseDoubleClicked(
        button
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_mouse_down(button: int):
    """
    Inputs Utilities: Mouse specific
    - To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
    - You can also use regular integer: it is forever guaranteed that 0=Left, 1=Right, 2=Middle.
    - Dragging operations are only reported after mouse has moved a certain distance away from the initial clicking position (see 'lock_threshold' and 'io.MouseDraggingThreshold')
    Is mouse button held?
    """
    cdef bool res = ccimgui.ImGui_IsMouseDown(
        button
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_mouse_dragging(button: int, lock_threshold: float=-1.0):
    """
    Is mouse dragging? (if lock_threshold < -1.0f, uses io.mousedraggingthreshold)
    """
    cdef bool res = ccimgui.ImGui_IsMouseDragging(
        button,
        lock_threshold
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_mouse_hovering_rect(r_min: Tuple[float, float], r_max: Tuple[float, float], clip: bool=True):
    """
    Is mouse hovering given bounding rect (in screen space). clipped by current clipping settings, but disregarding of other consideration of focus/window ordering/popup-block.
    """
    cdef bool res = ccimgui.ImGui_IsMouseHoveringRectEx(
        _cast_tuple_ImVec2(r_min),
        _cast_tuple_ImVec2(r_max),
        clip
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def is_mouse_hovering_rect_ex(r_min: Tuple[float, float], r_max: Tuple[float, float], clip: bool=True):
#     """
#     Is mouse hovering given bounding rect (in screen space). clipped by current clipping settings, but disregarding of other consideration of focus/window ordering/popup-block.
#     """
#     cdef bool res = ccimgui.ImGui_IsMouseHoveringRectEx(
#         _cast_tuple_ImVec2(r_min),
#         _cast_tuple_ImVec2(r_max),
#         clip
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_mouse_pos_valid(mouse_pos: tuple=None):
    """
    By convention we use (-flt_max,-flt_max) to denote that there is no mouse available
    """
    cdef ccimgui.ImVec2 vec
    cdef bool res
    if mouse_pos is None:
        res = ccimgui.ImGui_IsMousePosValid(NULL)
    else:
        vec = _cast_tuple_ImVec2(mouse_pos)
        res = ccimgui.ImGui_IsMousePosValid(&vec)

    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_mouse_released(button: int):
    """
    Did mouse button released? (went from down to !down)
    """
    cdef bool res = ccimgui.ImGui_IsMouseReleased(
        button
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_popup_open(str_id: str, flags: int=0):
    """
    Popups: query functions
    - IsPopupOpen(): return true if the popup is open at the current BeginPopup() level of the popup stack.
    - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
    - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
    Return true if the popup is open.
    """
    cdef bool res = ccimgui.ImGui_IsPopupOpen(
        _bytes(str_id),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_rect_visible(rect_min: Tuple[float, float], rect_max: Tuple[float, float]):
    """
    Test if rectangle (in screen space) is visible / not clipped. to perform coarse clipping on user's side.
    """
    cdef bool res = ccimgui.ImGui_IsRectVisible(
        _cast_tuple_ImVec2(rect_min),
        _cast_tuple_ImVec2(rect_max)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_rect_visible_by_size(size: Tuple[float, float]):
    """
    Miscellaneous Utilities
    Test if rectangle (of given size, starting from cursor position) is visible / not clipped.
    """
    cdef bool res = ccimgui.ImGui_IsRectVisibleBySize(
        _cast_tuple_ImVec2(size)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_window_appearing():
    """
    Windows Utilities
    - 'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.
    """
    cdef bool res = ccimgui.ImGui_IsWindowAppearing()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_window_collapsed():
    cdef bool res = ccimgui.ImGui_IsWindowCollapsed()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_window_docked():
    """
    Is current window docked into another window?
    """
    cdef bool res = ccimgui.ImGui_IsWindowDocked()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_window_focused(flags: int=0):
    """
    Is current window focused? or its root/child, depending on flags. see flags for options.
    """
    cdef bool res = ccimgui.ImGui_IsWindowFocused(
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def is_window_hovered(flags: int=0):
    """
    Is current window hovered and hoverable (e.g. not blocked by a popup/modal)? see imguihoveredflags_ for options. important: if you are trying to check whether your mouse should be dispatched to dear imgui or to your underlying app, you should not use this function! use the 'io.wantcapturemouse' boolean for that! refer to faq entry 'how can i tell whether to dispatch mouse/keyboard to dear imgui or my application?' for details.
    """
    cdef bool res = ccimgui.ImGui_IsWindowHovered(
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def label_text(label: str, fmt: str):
    """
    Display text+label aligned the same way as value+label widgets
    """
    ccimgui.ImGui_LabelText(
        _bytes(label),
        _bytes(fmt)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def label_text_v(label: str, fmt: str):
#     ccimgui.ImGui_LabelTextV(
#         _bytes(label),
#         _bytes(fmt)
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def list_box(label: str, current_item: Int, items: Sequence[str], height_in_items: int=-1):
    cdef void* void_ptr
    cdef char** c_strings = <char**>ccimgui.ImGui_MemAlloc(sizeof(void_ptr) * len(items))

    # Creates a secondary array for each element
    cdef char* array
    cdef bytes temp_bytes
    for i, item in enumerate(items):
        temp_bytes = _bytes(item)
        n_bytes = len(temp_bytes)
        array = <char*>ccimgui.ImGui_MemAlloc(sizeof(char) * n_bytes + 1)
        strncpy(array, temp_bytes, n_bytes + 1)
        c_strings[i] = array
    
    cdef bool res = ccimgui.ImGui_ListBox(
        _bytes(label),
        &current_item.value,
        c_strings,
        len(items),
        height_in_items
    )
    for i in range(len(items)):
        ccimgui.ImGui_MemFree(c_strings[i])
    ccimgui.ImGui_MemFree(c_strings)
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
list_box_callback_data = {}
def list_box_callback(label: str, current_item: Int, items_getter: Callable[[Any, int], str], data: Any, items_count: int, height_in_items: int=-1):
    cdef bytes label_bytes = _bytes(label)
    cdef ccimgui.ImGuiID lookup_id = ccimgui.ImGui_GetID(label_bytes)
    list_box_callback_data[lookup_id] = (items_getter, data)
    cdef bool res = ccimgui.ImGui_ListBoxCallbackEx(
        _bytes(label),
        &current_item.value,
        _list_box_callback_function,
        <void*><uintptr_t>lookup_id,
        items_count,
        height_in_items
    )
    # Interesting that this still works. Clearly the callback is exhausted
    # after calling ListBoxCallback.
    del list_box_callback_data[lookup_id]
    return res

cdef const char* _list_box_callback_function(void* data, int index) noexcept:
    cdef ccimgui.ImGuiID lookup_id = <uintptr_t>data
    if lookup_id not in list_box_callback_data:
        raise RuntimeError("Did not find lookup_id: {}".format(lookup_id))
    items_getter, user_data = list_box_callback_data[lookup_id]

    return _bytes(items_getter(user_data, index))
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def list_box_callback_ex(label: str, current_item: Int, getter: Callable, user_data: Any, items_count: int, height_in_items: int=-1):
#     cdef bool res = ccimgui.ImGui_ListBoxCallbackEx(
#         _bytes(label),
#         &current_item.value,
#         getter,
#         user_data,
#         items_count,
#         height_in_items
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def load_ini_settings_from_disk(ini_filename: str):
#     """
#     Settings/.Ini Utilities
#     - The disk functions are automatically called if io.IniFilename != NULL (default is "imgui.ini").
#     - Set io.IniFilename to NULL to load/save manually. Read io.WantSaveIniSettings description about handling .ini saving manually.
#     - Important: default value "imgui.ini" is relative to current working dir! Most apps will want to lock this to an absolute path (e.g. same path as executables).
#     Call after createcontext() and before the first call to newframe(). newframe() automatically calls loadinisettingsfromdisk(io.inifilename).
#     """
#     ccimgui.ImGui_LoadIniSettingsFromDisk(
#         _bytes(ini_filename)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def load_ini_settings_from_memory(ini_data: str, ini_size: int=0):
#     """
#     Call after createcontext() and before the first call to newframe() to provide .ini data from your own data source.
#     """
#     ccimgui.ImGui_LoadIniSettingsFromMemory(
#         _bytes(ini_data),
#         ini_size
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def log_buttons():
    """
    Helper to display buttons for logging to tty/file/clipboard
    """
    ccimgui.ImGui_LogButtons()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def log_finish():
    """
    Stop logging (close file, etc.)
    """
    ccimgui.ImGui_LogFinish()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def log_text(fmt: str):
    """
    Pass text data straight to log (without being displayed)
    """
    ccimgui.ImGui_LogText(
        _bytes(fmt)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def log_text_v(fmt: str):
#     ccimgui.ImGui_LogTextV(
#         _bytes(fmt)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def log_to_clipboard(auto_open_depth: int=-1):
    """
    Start logging to os clipboard
    """
    ccimgui.ImGui_LogToClipboard(
        auto_open_depth
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def log_to_file(auto_open_depth: int=-1, filename: str=None):
#     """
#     Start logging to file
#     """
#     bytes_filename = _bytes(filename) if filename is not None else None

#     ccimgui.ImGui_LogToFile(
#         auto_open_depth,
#         ((<char*>bytes_filename if filename is not None else NULL))
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def log_to_tty(auto_open_depth: int=-1):
#     """
#     Logging/Capture
#     - All text output from the interface can be captured into tty/file/clipboard. By default, tree nodes are automatically opened during logging.
#     Start logging to tty (stdout)
#     """
#     ccimgui.ImGui_LogToTTY(
#         auto_open_depth
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(Any)
# def mem_alloc(size: int):
#     cdef void* res = ccimgui.ImGui_MemAlloc(
#         size
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def mem_free(ptr: Any):
#     ccimgui.ImGui_MemFree(
#         ptr
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def menu_item(label: str, shortcut: str=None, selected: bool=False, enabled: bool=True):
    """
    Return true when activated.
    """
    bytes_shortcut = _bytes(shortcut) if shortcut is not None else None

    cdef bool res = ccimgui.ImGui_MenuItemEx(
        _bytes(label),
        ((<char*>bytes_shortcut if shortcut is not None else NULL)),
        selected,
        enabled
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def menu_item_bool_ptr(label: str, shortcut: Optional[str], p_selected: Bool, enabled: bool=True):
    """
    Return true when activated + toggle (*p_selected) if p_selected != null
    """
    bytes_shortcut = _bytes(shortcut) if shortcut is not None else None

    cdef bool res = ccimgui.ImGui_MenuItemBoolPtr(
        _bytes(label),
        ((<char*>bytes_shortcut if shortcut is not None else NULL)),
        &p_selected.value,
        enabled
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def menu_item_ex(label: str, shortcut: str=None, selected: bool=False, enabled: bool=True):
#     """
#     Return true when activated.
#     """
#     bytes_shortcut = _bytes(shortcut) if shortcut is not None else None

#     cdef bool res = ccimgui.ImGui_MenuItemEx(
#         _bytes(label),
#         ((<char*>bytes_shortcut if shortcut is not None else NULL)),
#         selected,
#         enabled
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def new_frame():
    """
    Start a new dear imgui frame, you can submit any command from this point until render()/endframe().
    """
    ccimgui.ImGui_NewFrame()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def new_line():
    """
    Undo a sameline() or force a new line when in a horizontal-layout context.
    """
    ccimgui.ImGui_NewLine()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def next_column():
#     """
#     Next column, defaults to current row or next row if the current row is finished
#     """
#     ccimgui.ImGui_NextColumn()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def open_popup(str_id: str, popup_flags: int=0):
    """
    Popups: open/close functions
    - OpenPopup(): set popup state to open. ImGuiPopupFlags are available for opening options.
    - If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
    - CloseCurrentPopup(): use inside the BeginPopup()/EndPopup() scope to close manually.
    - CloseCurrentPopup() is called by default by Selectable()/MenuItem() when activated (FIXME: need some options).
    - Use ImGuiPopupFlags_NoOpenOverExistingPopup to avoid opening a popup if there's already one at the same level. This is equivalent to e.g. testing for !IsAnyPopupOpen() prior to OpenPopup().
    - Use IsWindowAppearing() after BeginPopup() to tell if a window just opened.
    - IMPORTANT: Notice that for OpenPopupOnItemClick() we exceptionally default flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter
    Call to mark popup as open (don't call every frame!).
    """
    ccimgui.ImGui_OpenPopup(
        _bytes(str_id),
        popup_flags
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(True)
# ?returns(None)
def open_popup_id(id_: int, popup_flags: int=0):
    """
    Id overload to facilitate calling from nested stacks
    pygui note: This function really only makes sense when you also have
    BeginPopupEx from imgui_internal.h. Otherwise you might as well use the
    normal open_popup().
    """
    ccimgui.ImGui_OpenPopupID(
        id_,
        popup_flags
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def open_popup_on_item_click(str_id: str=None, popup_flags: int=1):
    """
    Helper to open popup when clicked on last item. default to imguipopupflags_mousebuttonright == 1. (note: actually triggers on the mouse _released_ event to be consistent with popup behaviors)
    """
    bytes_str_id = _bytes(str_id) if str_id is not None else None

    ccimgui.ImGui_OpenPopupOnItemClick(
        ((<char*>bytes_str_id if str_id is not None else NULL)),
        popup_flags
    )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def plot_histogram(label: str, values: Sequence[float], values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0), stride: int=4):
    """
    Implied values_offset = 0, overlay_text = null, scale_min = flt_max, scale_max = flt_max, graph_size = imvec2(0, 0), stride = sizeof(float)
    """
    cdef float* c_floats = <float*>ccimgui.ImGui_MemAlloc(sizeof(float) * len(values))
    if c_floats is NULL:
        raise MemoryError()
    
    for i in range(len(values)):
        c_floats[i] = values[i]
    
    bytes_overlay_text = _bytes(overlay_text) if overlay_text is not None else None
    
    ccimgui.ImGui_PlotHistogramEx(
        _bytes(label),
        c_floats,
        len(values),
        values_offset,
        ((<char*>bytes_overlay_text if overlay_text is not None else NULL)),
        scale_min,
        scale_max,
        _cast_tuple_ImVec2(graph_size),
        stride
    )
    ccimgui.ImGui_MemFree(c_floats)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
plot_histogram_callback_data = {}
def plot_histogram_callback(label: str, values_getter: Callable[[Any, int], float], data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)):
    cdef bytes label_bytes = _bytes(label)
    cdef ccimgui.ImGuiID lookup_id = ccimgui.ImGui_GetID(label_bytes)
    plot_histogram_callback_data[lookup_id] = (values_getter, data)
    bytes_overlay_text = _bytes(overlay_text) if overlay_text is not None else None

    ccimgui.ImGui_PlotHistogramCallbackEx(
        _bytes(label),
        _plot_histogram_callback_function,
        <void*>lookup_id,
        values_count,
        values_offset,
        ((<char*>bytes_overlay_text if overlay_text is not None else NULL)),
        scale_min,
        scale_max,
        _cast_tuple_ImVec2(graph_size)
    )
    del plot_histogram_callback_data[lookup_id]

cdef float _plot_histogram_callback_function(void* data, int idx) noexcept:
    cdef ccimgui.ImGuiID lookup_id = <ccimgui.ImGuiID>data
    if lookup_id not in plot_histogram_callback_data:
        raise RuntimeError("Did not find lookup_id: {}".format(lookup_id))
    values_getter, user_data = plot_histogram_callback_data[lookup_id]

    cdef float res = values_getter(user_data, idx)
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def plot_histogram_callback_ex(label: str, values_getter: Callable, data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: Tuple[float, float]=(0, 0)):
#     bytes_overlay_text = _bytes(overlay_text) if overlay_text is not None else None

#     ccimgui.ImGui_PlotHistogramCallbackEx(
#         _bytes(label),
#         values_getter,
#         data,
#         values_count,
#         values_offset,
#         ((<char*>bytes_overlay_text if overlay_text is not None else NULL)),
#         scale_min,
#         scale_max,
#         _cast_tuple_ImVec2(graph_size)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def plot_histogram_ex(label: str, values: Float, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: Tuple[float, float]=(0, 0), stride: int=4):
#     bytes_overlay_text = _bytes(overlay_text) if overlay_text is not None else None

#     ccimgui.ImGui_PlotHistogramEx(
#         _bytes(label),
#         &values.value,
#         values_count,
#         values_offset,
#         ((<char*>bytes_overlay_text if overlay_text is not None else NULL)),
#         scale_min,
#         scale_max,
#         _cast_tuple_ImVec2(graph_size),
#         stride
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def plot_lines(label: str, values: Sequence[float], values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)):
    """
    Widgets: Data Plotting
    - Consider using ImPlot (https://github.com/epezent/implot) which is much better!
    Implied stride = sizeof(float)
    - Pygui note: stride has been omitted because we are instead passing in a list.
    the underlying c_float array is handled by Cython.
    """
    cdef float* c_floats = <float*>ccimgui.ImGui_MemAlloc(sizeof(float) * len(values))
    if c_floats is NULL:
        raise MemoryError()
    
    for i in range(len(values)):
        c_floats[i] = values[i]

    bytes_overlay_text = _bytes(overlay_text) if overlay_text is not None else None

    ccimgui.ImGui_PlotLinesEx(
        _bytes(label),
        c_floats,
        len(values),
        values_offset,
        ((<char*>bytes_overlay_text if overlay_text is not None else NULL)),
        scale_min,
        scale_max,
        _cast_tuple_ImVec2(graph_size),
        sizeof(float)
    )
    ccimgui.ImGui_MemFree(c_floats)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
plot_lines_callback_data = {}
def plot_lines_callback(label: str, values_getter: Callable[[Any, int], float], data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)):
    cdef bytes label_bytes = _bytes(label)
    cdef ccimgui.ImGuiID lookup_id = ccimgui.ImGui_GetID(label_bytes)
    plot_lines_callback_data[lookup_id] = (values_getter, data)
    bytes_overlay_text = _bytes(overlay_text) if overlay_text is not None else None

    ccimgui.ImGui_PlotLinesCallbackEx(
        _bytes(label),
        _plot_lines_callback_function,
        <void*>lookup_id,
        values_count,
        values_offset,
        ((<char*>bytes_overlay_text if overlay_text is not None else NULL)),
        scale_min,
        scale_max,
        _cast_tuple_ImVec2(graph_size)
    )
    del plot_lines_callback_data[lookup_id]

cdef float _plot_lines_callback_function(void* data, int idx) noexcept:
    cdef ccimgui.ImGuiID lookup_id = <ccimgui.ImGuiID>data
    if lookup_id not in plot_lines_callback_data:
        raise RuntimeError("Did not find lookup_id: {}".format(lookup_id))
    values_getter, user_data = plot_lines_callback_data[lookup_id]

    cdef float res = values_getter(user_data, idx)
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def plot_lines_callback_ex(label: str, values_getter: Callable, data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: Tuple[float, float]=(0, 0)):
#     bytes_overlay_text = _bytes(overlay_text) if overlay_text is not None else None

#     ccimgui.ImGui_PlotLinesCallbackEx(
#         _bytes(label),
#         values_getter,
#         data,
#         values_count,
#         values_offset,
#         ((<char*>bytes_overlay_text if overlay_text is not None else NULL)),
#         scale_min,
#         scale_max,
#         _cast_tuple_ImVec2(graph_size)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def plot_lines_ex(label: str, values: Float, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: Tuple[float, float]=(0, 0), stride: int=4):
#     bytes_overlay_text = _bytes(overlay_text) if overlay_text is not None else None

#     ccimgui.ImGui_PlotLinesEx(
#         _bytes(label),
#         &values.value,
#         values_count,
#         values_offset,
#         ((<char*>bytes_overlay_text if overlay_text is not None else NULL)),
#         scale_min,
#         scale_max,
#         _cast_tuple_ImVec2(graph_size),
#         stride
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def pop_button_repeat():
    ccimgui.ImGui_PopButtonRepeat()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def pop_clip_rect():
#     ccimgui.ImGui_PopClipRect()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def pop_font():
    ccimgui.ImGui_PopFont()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def pop_id():
    """
    Pop from the id stack.
    """
    ccimgui.ImGui_PopID()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def pop_item_width():
    ccimgui.ImGui_PopItemWidth()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def pop_style_color(count: int=1):
    ccimgui.ImGui_PopStyleColorEx(
        count
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def pop_style_color_ex(count: int=1):
#     ccimgui.ImGui_PopStyleColorEx(
#         count
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def pop_style_var(count: int=1):
    ccimgui.ImGui_PopStyleVarEx(
        count
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def pop_style_var_ex(count: int=1):
#     ccimgui.ImGui_PopStyleVarEx(
#         count
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def pop_tab_stop():
    ccimgui.ImGui_PopTabStop()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def pop_text_wrap_pos():
    ccimgui.ImGui_PopTextWrapPos()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def progress_bar(fraction: float, size_arg: Tuple[float, float]=(-FLT_MIN, 0), overlay: str=None):
    bytes_overlay = _bytes(overlay) if overlay is not None else None

    ccimgui.ImGui_ProgressBar(
        fraction,
        _cast_tuple_ImVec2(size_arg),
        ((<char*>bytes_overlay if overlay is not None else NULL))
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def push_button_repeat(repeat: bool):
    """
    In 'repeat' mode, button*() functions return repeated true in a typematic manner (using io.keyrepeatdelay/io.keyrepeatrate setting). note that you can call isitemactive() after any button() to tell if the button is held in the current frame.
    """
    ccimgui.ImGui_PushButtonRepeat(
        repeat
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def push_clip_rect(clip_rect_min: Tuple[float, float], clip_rect_max: Tuple[float, float], intersect_with_current_clip_rect: bool):
#     """
#     Clipping
#     - Mouse hovering is affected by ImGui::PushClipRect() calls, unlike direct calls to ImDrawList::PushClipRect() which are render only.
#     """
#     ccimgui.ImGui_PushClipRect(
#         _cast_tuple_ImVec2(clip_rect_min),
#         _cast_tuple_ImVec2(clip_rect_max),
#         intersect_with_current_clip_rect
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def push_font(font: ImFont):
    """
    Parameters stacks (shared)
    Use null as a shortcut to push default font
    """
    ccimgui.ImGui_PushFont(
        font._ptr
    )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def push_id(obj: object):
    """
    ID stack/scopes
    Read the FAQ (docs/FAQ.md or http://dearimgui.com/faq) for more details about how ID are handled in dear imgui.
    - Those questions are answered and impacted by understanding of the ID stack system:
    - "Q: Why is my widget not reacting when I click on it?"
    - "Q: How can I have widgets with an empty label?"
    - "Q: How can I have multiple widgets with the same label?"
    - Short version: ID are hashes of the entire ID stack. If you are creating widgets in a loop you most likely
    want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them.
    - You can also use the "Label##foobar" syntax within widget label to distinguish them from each others.
    - In this header file we use the "label"/"name" terminology to denote a string that will be displayed + used as an ID,
    whereas "str_id" denote a string that is only used as an ID and not normally displayed.
    Push string into the id stack (will hash string).

    pygui note: This will call python's hash() function on the parameter. If you pass
    a pygui object then the corresponding __hash__() magic method will be called. This
    method converts the underlying _ptr to an unsigned int and then hashes that. This
    allows for the object's hash to remain consistent as long as the underlying pointer
    is constant.
    """
    ccimgui.ImGui_PushIDInt(
        hash(obj)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def push_id_int(int_id: int):
#     """
#     Push integer into the id stack (will hash integer).
#     """
#     ccimgui.ImGui_PushIDInt(
#         int_id
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def push_id_ptr(ptr_id: Any):
#     """
#     Push pointer into the id stack (will hash pointer).
#     """
#     ccimgui.ImGui_PushIDPtr(
#         ptr_id
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def push_id_str(str_id_begin: str, str_id_end: str):
#     """
#     Push string into the id stack (will hash string).
#     """
#     ccimgui.ImGui_PushIDStr(
#         _bytes(str_id_begin),
#         _bytes(str_id_end)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def push_item_width(item_width: float):
    """
    Parameters stacks (current window)
    Push width of items for common large 'item+label' widgets. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -flt_min always align width to the right side).
    """
    ccimgui.ImGui_PushItemWidth(
        item_width
    )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def push_style_color(idx: int, col: "int | tuple"):
    """
    Modify a style color. always use this if you modify the style after newframe().
    pygui note: You can pass a u32 color or a 0-1, length 4 tuple for color.
    """
    if isinstance(col, int) or isinstance(col, float):
        ccimgui.ImGui_PushStyleColor(
            idx,
            int(col)
        )
    else:
        ccimgui.ImGui_PushStyleColorImVec4(
            idx,
            _cast_tuple_ImVec4(col)
        )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def push_style_color_im_vec4(idx: int, col: Tuple[float, float, float, float]):
#     ccimgui.ImGui_PushStyleColorImVec4(
#         idx,
#         _cast_tuple_ImVec4(col)
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def push_style_var(idx: int, val: "float | tuple"):
    """
    Modify a style float variable. always use this if you modify the style after newframe().
    pygui note: You can pass a float or length 2 tuple.
    """
    if isinstance(val, float) or isinstance(val, int):
        ccimgui.ImGui_PushStyleVar(
            idx,
            val
        )
    else:
        ccimgui.ImGui_PushStyleVarImVec2(
            idx,
            _cast_tuple_ImVec2(val)
        )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def push_style_var_im_vec2(idx: int, val: Tuple[float, float]):
#     """
#     Modify a style imvec2 variable. always use this if you modify the style after newframe().
#     """
#     ccimgui.ImGui_PushStyleVarImVec2(
#         idx,
#         _cast_tuple_ImVec2(val)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def push_tab_stop(tab_stop: bool):
    """
    == tab stop enable. allow focusing using tab/shift-tab, enabled by default but you can disable it for certain widgets
    """
    ccimgui.ImGui_PushTabStop(
        tab_stop
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def push_text_wrap_pos(wrap_local_pos_x: float=0.0):
    """
    Push word-wrapping position for text*() commands. < 0.0f: no wrapping; 0.0f: wrap to end of window (or column); > 0.0f: wrap at 'wrap_pos_x' position in window local space
    """
    ccimgui.ImGui_PushTextWrapPos(
        wrap_local_pos_x
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def radio_button(label: str, active: bool):
    """
    Use with e.g. if (radiobutton('one', my_value==1)) ( my_value = 1; )
    """
    cdef bool res = ccimgui.ImGui_RadioButton(
        _bytes(label),
        active
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def radio_button_int_ptr(label: str, v: Int, v_button: int):
    """
    Shortcut to handle the above pattern when value is an integer
    """
    cdef bool res = ccimgui.ImGui_RadioButtonIntPtr(
        _bytes(label),
        &v.value,
        v_button
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def render():
    """
    Ends the dear imgui frame, finalize the draw data. you can then get call getdrawdata().
    """
    ccimgui.ImGui_Render()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def render_platform_windows_default(platform_render_arg: Any=None, renderer_render_arg: Any=None):
    """
    Call in main loop. will call renderwindow/swapbuffers platform functions for each secondary viewport which doesn't have the imguiviewportflags_minimized flag set. may be reimplemented by user for custom rendering needs.
    TODO: Doesn't consider real inputs.
    """
    ccimgui.ImGui_RenderPlatformWindowsDefaultEx(
        NULL if platform_render_arg is None else <void*>platform_render_arg,
        NULL if renderer_render_arg is None else <void*>renderer_render_arg
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def render_platform_windows_default_ex(platform_render_arg: Any=None, renderer_render_arg: Any=None):
#     """
#     Call in main loop. will call renderwindow/swapbuffers platform functions for each secondary viewport which doesn't have the imguiviewportflags_minimized flag set. may be reimplemented by user for custom rendering needs.
#     """
#     ccimgui.ImGui_RenderPlatformWindowsDefaultEx(
#         platform_render_arg,
#         renderer_render_arg
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def reset_mouse_drag_delta():
#     """
#     Implied button = 0
#     """
#     ccimgui.ImGui_ResetMouseDragDelta()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def reset_mouse_drag_delta_ex(button: int=0):
#     """

#     """
#     ccimgui.ImGui_ResetMouseDragDeltaEx(
#         button
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def same_line(offset_from_start_x: float=0.0, spacing: float=-1.0):
    """
    Call between widgets or groups to layout them horizontally. x position given in window coordinates.
    """
    ccimgui.ImGui_SameLineEx(
        offset_from_start_x,
        spacing
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def same_line_ex(offset_from_start_x: float=0.0, spacing: float=-1.0):
#     """
#     Call between widgets or groups to layout them horizontally. x position given in window coordinates.
#     """
#     ccimgui.ImGui_SameLineEx(
#         offset_from_start_x,
#         spacing
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def save_ini_settings_to_disk(ini_filename: str):
#     """
#     This is automatically called (if io.inifilename is not empty) a few seconds after any modification that should be reflected in the .ini file (and also by destroycontext).
#     """
#     ccimgui.ImGui_SaveIniSettingsToDisk(
#         _bytes(ini_filename)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(str)
# def save_ini_settings_to_memory(out_ini_size: Any=None):
#     """
#     Return a zero-terminated string with the .ini data which you can save by your own mean. call when io.wantsaveinisettings is set, then save data by your own mean and clear io.wantsaveinisettings.
#     """
#     cdef const char* res = ccimgui.ImGui_SaveIniSettingsToMemory(
#         out_ini_size
#     )
#     return _from_bytes(res)
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def selectable(label: str, selected: bool=False, flags: int=0, size: tuple=(0, 0)):
    """
    Widgets: Selectables
    - A selectable highlights when hovered, and can display another color when selected.
    - Neighbors selectable extend their highlight bounds in order to leave no gap between them. This is so a series of selected Selectable appear contiguous.
    Implied selected = false, flags = 0, size = imvec2(0, 0)
    'bool selected' carry the selection state (read-only). selectable() is clicked is returns true so you can modify your selection state. size.x==0.0: use remaining width, size.x>0.0: specify width. size.y==0.0: use label height, size.y>0.0: specify height
    """
    cdef bool res = ccimgui.ImGui_SelectableEx(
        _bytes(label),
        selected,
        flags,
        _cast_tuple_ImVec2(size)
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def selectable_bool_ptr(label: str, p_selected: Bool, flags: int=0, size: tuple=(0, 0)):
    """
    'bool* p_selected' point to the selection state (read-write), as a convenient helper.
    """
    cdef bool res = ccimgui.ImGui_SelectableBoolPtrEx(
        _bytes(label),
        &p_selected.value,
        flags,
        _cast_tuple_ImVec2(size)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def selectable_bool_ptr_ex(label: str, p_selected: Bool, flags: int=0, size: Tuple[float, float]=(0, 0)):
#     """
#     'bool* p_selected' point to the selection state (read-write), as a convenient helper.
#     """
#     cdef bool res = ccimgui.ImGui_SelectableBoolPtrEx(
#         _bytes(label),
#         &p_selected.value,
#         flags,
#         _cast_tuple_ImVec2(size)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def selectable_ex(label: str, selected: bool=False, flags: int=0, size: Tuple[float, float]=(0, 0)):
#     """
#     'bool selected' carry the selection state (read-only). selectable() is clicked is returns true so you can modify your selection state. size.x==0.0: use remaining width, size.x>0.0: specify width. size.y==0.0: use label height, size.y>0.0: specify height
#     """
#     cdef bool res = ccimgui.ImGui_SelectableEx(
#         _bytes(label),
#         selected,
#         flags,
#         _cast_tuple_ImVec2(size)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def separator():
    """
    Other layout functions
    Separator, generally horizontal. inside a menu bar or in horizontal layout mode, this becomes a vertical separator.
    """
    ccimgui.ImGui_Separator()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def separator_text(label: str):
    """
    Currently: formatted text with an horizontal line
    """
    ccimgui.ImGui_SeparatorText(
        _bytes(label)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(True)
# ?returns(None)
# def set_allocator_functions(alloc_func: Callable, free_func: Callable, user_data: Any=None):
#     """
#     Memory Allocators
#     - Those functions are not reliant on the current context.
#     - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
#     for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for more details.

#     Pygui note: see create_context(). This is where the allocator functions are set for ImGui.
#     """
#     ccimgui.ImGui_SetAllocatorFunctions(
#         alloc_func,
#         free_func,
#         user_data
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_clipboard_text(text: str):
    ccimgui.ImGui_SetClipboardText(
        _bytes(text)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_color_edit_options(flags: int):
    """
    Initialize current options (generally on application startup) if you want to select a default format, picker type, etc. user will be able to change many settings, unless you pass the _nooptions flag to your calls.
    """
    ccimgui.ImGui_SetColorEditOptions(
        flags
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_column_offset(column_index: int, offset_x: float):
#     """
#     Set position of column line (in pixels, from the left side of the contents region). pass -1 to use current column
#     """
#     ccimgui.ImGui_SetColumnOffset(
#         column_index,
#         offset_x
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_column_width(column_index: int, width: float):
#     """
#     Set column width (in pixels). pass -1 to use current column
#     """
#     ccimgui.ImGui_SetColumnWidth(
#         column_index,
#         width
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_current_context(ctx: ImGuiContext):
#     ccimgui.ImGui_SetCurrentContext(
#         ctx._ptr
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_cursor_pos(local_pos: Tuple[float, float]):
    """
    [window-local] '
    """
    ccimgui.ImGui_SetCursorPos(
        _cast_tuple_ImVec2(local_pos)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_cursor_pos_x(local_x: float):
    """
    [window-local] '
    """
    ccimgui.ImGui_SetCursorPosX(
        local_x
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_cursor_pos_y(local_y: float):
    """
    [window-local] '
    """
    ccimgui.ImGui_SetCursorPosY(
        local_y
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_cursor_screen_pos(pos: Tuple[float, float]):
    """
    Cursor position in absolute coordinates
    """
    ccimgui.ImGui_SetCursorScreenPos(
        _cast_tuple_ImVec2(pos)
    )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
_drag_drop_payload = {}
# This purely exists so that we have *something* to give to the function that
# is copyable. This is required to know if the .data is NULL or not.
cdef int _drag_drop_constant = 0
def set_drag_drop_payload(type_: str, data: Any, cond: int=0):
    """
    Type is a user defined string of maximum 32 characters. strings starting with '_' are reserved for dear imgui internal types.
    Return true when payload has been accepted.
    pygui note: Data is stored by pygui so that an abitrary python object can
    can stored.
    """
    cdef bool res = ccimgui.ImGui_SetDragDropPayload(
        _bytes(type_),
        <void*>&_drag_drop_constant,
        sizeof(_drag_drop_constant),
        cond
    )
    if res:
        _drag_drop_payload[<uintptr_t>ccimgui.ImGui_GetCurrentContext()] = data
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_item_default_focus():
    """
    Focus, Activation
    - Prefer using "SetItemDefaultFocus()" over "if (IsWindowAppearing()) SetScrollHereY()" when applicable to signify "this is the default item"
    Make last item the default focused item of a window.
    """
    ccimgui.ImGui_SetItemDefaultFocus()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_item_tooltip(fmt: str):
    """
    Set a text-only tooltip if preceeding item was hovered. override any previous call to settooltip().
    """
    ccimgui.ImGui_SetItemTooltip(
        _bytes(fmt)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def set_item_tooltip_v(fmt: str):
#     ccimgui.ImGui_SetItemTooltipV(
#         _bytes(fmt)
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_keyboard_focus_here(offset: int=0):
    """
    Focus keyboard on the next widget. use positive 'offset' to access sub components of a multiple component widget. use -1 to access previous widget.
    """
    ccimgui.ImGui_SetKeyboardFocusHereEx(
        offset
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def set_keyboard_focus_here_ex(offset: int=0):
#     """
#     Focus keyboard on the next widget. use positive 'offset' to access sub components of a multiple component widget. use -1 to access previous widget.
#     """
#     ccimgui.ImGui_SetKeyboardFocusHereEx(
#         offset
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_mouse_cursor(cursor_type: int):
    """
    Set desired mouse cursor shape
    """
    ccimgui.ImGui_SetMouseCursor(
        cursor_type
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_next_frame_want_capture_keyboard(want_capture_keyboard: bool):
#     """
#     Override io.wantcapturekeyboard flag next frame (said flag is left for your application to handle, typically when true it instructs your app to ignore inputs). e.g. force capture keyboard when your widget is being hovered. this is equivalent to setting 'io.wantcapturekeyboard = want_capture_keyboard'; after the next newframe() call.
#     """
#     ccimgui.ImGui_SetNextFrameWantCaptureKeyboard(
#         want_capture_keyboard
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_next_frame_want_capture_mouse(want_capture_mouse: bool):
#     """
#     Override io.wantcapturemouse flag next frame (said flag is left for your application to handle, typical when true it instucts your app to ignore inputs). this is equivalent to setting 'io.wantcapturemouse = want_capture_mouse;' after the next newframe() call.
#     """
#     ccimgui.ImGui_SetNextFrameWantCaptureMouse(
#         want_capture_mouse
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_next_item_allow_overlap():
#     """
#     Overlapping mode
#     Allow next item to be overlapped by a subsequent item. useful with invisible buttons, selectable, treenode covering an area where subsequent items may need to be added. note that both selectable() and treenode() have dedicated flags doing this.
#     """
#     ccimgui.ImGui_SetNextItemAllowOverlap()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_item_open(is_open: bool, cond: int=0):
    """
    Set next treenode/collapsingheader open state.
    """
    ccimgui.ImGui_SetNextItemOpen(
        is_open,
        cond
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_item_width(item_width: float):
    """
    Set width of the _next_ common large 'item+label' widget. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -flt_min always align width to the right side)
    """
    ccimgui.ImGui_SetNextItemWidth(
        item_width
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_window_bg_alpha(alpha: float):
    """
    Set next window background color alpha. helper to easily override the alpha component of imguicol_windowbg/childbg/popupbg. you may also use imguiwindowflags_nobackground.
    """
    ccimgui.ImGui_SetNextWindowBgAlpha(
        alpha
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_next_window_class(window_class: ImGuiWindowClass):
#     """
#     Set next window class (control docking compatibility + provide hints to platform backend via custom viewport flags and platform parent/child relationship)
#     """
#     ccimgui.ImGui_SetNextWindowClass(
#         window_class._ptr
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_window_collapsed(collapsed: bool, cond: int=0):
    """
    Set next window collapsed state. call before begin()
    """
    ccimgui.ImGui_SetNextWindowCollapsed(
        collapsed,
        cond
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_window_content_size(size: Tuple[float, float]):
    """
    Set next window content size (~ scrollable client area, which enforce the range of scrollbars). not including window decorations (title bar, menu bar, etc.) nor windowpadding. set an axis to 0.0f to leave it automatic. call before begin()
    """
    ccimgui.ImGui_SetNextWindowContentSize(
        _cast_tuple_ImVec2(size)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_window_dock_id(dock_id: int, cond: int=0):
    """
    Set next window dock id
    """
    ccimgui.ImGui_SetNextWindowDockID(
        dock_id,
        cond
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_window_focus():
    """
    Set next window to be focused / top-most. call before begin()
    """
    ccimgui.ImGui_SetNextWindowFocus()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_window_pos(pos: Tuple[float, float], cond: int=0, pivot: tuple=(0, 0)):
    """
    Window manipulation
    - Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
    Set next window position. call before begin(). use pivot=(0.5f,0.5f) to center on given point, etc.
    """
    ccimgui.ImGui_SetNextWindowPosEx(
        _cast_tuple_ImVec2(pos),
        cond,
        _cast_tuple_ImVec2(pivot)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def set_next_window_pos_ex(pos: Tuple[float, float], cond: int=0, pivot: Tuple[float, float]=(0, 0)):
#     """
#     Set next window position. call before begin(). use pivot=(0.5f,0.5f) to center on given point, etc.
#     """
#     ccimgui.ImGui_SetNextWindowPosEx(
#         _cast_tuple_ImVec2(pos),
#         cond,
#         _cast_tuple_ImVec2(pivot)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_window_scroll(scroll: Tuple[float, float]):
    """
    Set next window scrolling value (use < 0.0f to not affect a given axis).
    """
    ccimgui.ImGui_SetNextWindowScroll(
        _cast_tuple_ImVec2(scroll)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_window_size(size: Tuple[float, float], cond: int=0):
    """
    Set next window size. set axis to 0.0f to force an auto-fit on this axis. call before begin()
    """
    ccimgui.ImGui_SetNextWindowSize(
        _cast_tuple_ImVec2(size),
        cond
    )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
_set_next_window_size_constraints_data = {}
def set_next_window_size_constraints(size_min: Tuple[float, float], size_max: Tuple[float, float], custom_callback: Callable=None, custom_callback_data: Any=None):
    """
    Set next window size limits. use 0.0f or flt_max if you don't want limits. use -1 for both min and max of same axis to preserve current size (which itself is a constraint). use callback to apply non-trivial programmatic constraints.
    """
    cdef int lookup = hash(custom_callback_data)
    if custom_callback is not None:
        _set_next_window_size_constraints_data[lookup] = (custom_callback, custom_callback_data)
        ccimgui.ImGui_SetNextWindowSizeConstraints(
            _cast_tuple_ImVec2(size_min),
            _cast_tuple_ImVec2(size_max),
            _set_next_window_size_constraints_callback,
            <void*><uintptr_t>lookup
        )
    else:
        ccimgui.ImGui_SetNextWindowSizeConstraints(
            _cast_tuple_ImVec2(size_min),
            _cast_tuple_ImVec2(size_max),
            NULL,
            NULL
        )

cdef void _set_next_window_size_constraints_callback(ccimgui.ImGuiSizeCallbackData* data) noexcept:
    cdef int lookup = <int><uintptr_t>data.UserData
    # We are going to retrieve the user_data in ImGuiSizeCallbackData.user_data
    callback, user_data = _set_next_window_size_constraints_data[lookup]
    callback(ImGuiSizeCallbackData.from_ptr(data))
    return
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_next_window_viewport(viewport_id: int):
    """
    Set next window viewport
    """
    ccimgui.ImGui_SetNextWindowViewport(
        viewport_id
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_scroll_from_pos_x(local_x: float, center_x_ratio: float=0.5):
    """
    Adjust scrolling amount to make given position visible. generally getcursorstartpos() + offset to compute a valid position.
    """
    ccimgui.ImGui_SetScrollFromPosX(
        local_x,
        center_x_ratio
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_scroll_from_pos_y(local_y: float, center_y_ratio: float=0.5):
    """
    Adjust scrolling amount to make given position visible. generally getcursorstartpos() + offset to compute a valid position.
    """
    ccimgui.ImGui_SetScrollFromPosY(
        local_y,
        center_y_ratio
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_scroll_here_x(center_x_ratio: float=0.5):
    """
    Adjust scrolling amount to make current cursor position visible. center_x_ratio=0.0: left, 0.5: center, 1.0: right. when using to make a 'default/current item' visible, consider using setitemdefaultfocus() instead.
    """
    ccimgui.ImGui_SetScrollHereX(
        center_x_ratio
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_scroll_here_y(center_y_ratio: float=0.5):
    """
    Adjust scrolling amount to make current cursor position visible. center_y_ratio=0.0: top, 0.5: center, 1.0: bottom. when using to make a 'default/current item' visible, consider using setitemdefaultfocus() instead.
    """
    ccimgui.ImGui_SetScrollHereY(
        center_y_ratio
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_scroll_x(scroll_x: float):
    """
    Set scrolling amount [0 .. getscrollmaxx()]
    """
    ccimgui.ImGui_SetScrollX(
        scroll_x
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_scroll_y(scroll_y: float):
    """
    Set scrolling amount [0 .. getscrollmaxy()]
    """
    ccimgui.ImGui_SetScrollY(
        scroll_y
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_state_storage(storage: ImGuiStorage):
#     """
#     Replace current window storage with our own (if you want to manipulate it yourself, typically clear subsection of it)
#     """
#     ccimgui.ImGui_SetStateStorage(
#         storage._ptr
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_tab_item_closed(tab_or_docked_window_label: str):
    """
    Notify tabbar or docking system of a closed tab/window ahead (useful to reduce visual flicker on reorderable tab bars). for tab-bar: call after begintabbar() and before tab submissions. otherwise call with a window name.
    """
    ccimgui.ImGui_SetTabItemClosed(
        _bytes(tab_or_docked_window_label)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def set_tooltip(fmt: str):
    """
    Set a text-only tooltip. often used after a imgui::isitemhovered() check. override any previous call to settooltip().
    """
    ccimgui.ImGui_SetTooltip(
        _bytes(fmt)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def set_tooltip_v(fmt: str):
#     ccimgui.ImGui_SetTooltipV(
#         _bytes(fmt)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_window_collapsed(collapsed: bool, cond: int=0):
#     """
#     (not recommended) set current window collapsed state. prefer using setnextwindowcollapsed().
#     """
#     ccimgui.ImGui_SetWindowCollapsed(
#         collapsed,
#         cond
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_window_collapsed_str(name: str, collapsed: bool, cond: int=0):
#     """
#     Set named window collapsed state
#     """
#     ccimgui.ImGui_SetWindowCollapsedStr(
#         _bytes(name),
#         collapsed,
#         cond
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_window_focus():
#     """
#     (not recommended) set current window to be focused / top-most. prefer using setnextwindowfocus().
#     """
#     ccimgui.ImGui_SetWindowFocus()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_window_focus_str(name: str):
#     """
#     Set named window to be focused / top-most. use null to remove focus.
#     """
#     ccimgui.ImGui_SetWindowFocusStr(
#         _bytes(name)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_window_font_scale(scale: float):
#     """
#     [obsolete] set font scale. adjust io.fontglobalscale if you want to scale all windows. this is an old api! for correct scaling, prefer to reload font + rebuild imfontatlas + call style.scaleallsizes().
#     """
#     ccimgui.ImGui_SetWindowFontScale(
#         scale
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_window_pos(pos: Tuple[float, float], cond: int=0):
#     """
#     (not recommended) set current window position - call within begin()/end(). prefer using setnextwindowpos(), as this may incur tearing and side-effects.
#     """
#     ccimgui.ImGui_SetWindowPos(
#         _cast_tuple_ImVec2(pos),
#         cond
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_window_pos_str(name: str, pos: Tuple[float, float], cond: int=0):
#     """
#     Set named window position.
#     """
#     ccimgui.ImGui_SetWindowPosStr(
#         _bytes(name),
#         _cast_tuple_ImVec2(pos),
#         cond
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_window_size(size: Tuple[float, float], cond: int=0):
#     """
#     (not recommended) set current window size - call within begin()/end(). set to imvec2(0, 0) to force an auto-fit. prefer using setnextwindowsize(), as this may incur tearing and minor side-effects.
#     """
#     ccimgui.ImGui_SetWindowSize(
#         _cast_tuple_ImVec2(size),
#         cond
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def set_window_size_str(name: str, size: Tuple[float, float], cond: int=0):
#     """
#     Set named window size. set axis to 0.0f to force an auto-fit on this axis.
#     """
#     ccimgui.ImGui_SetWindowSizeStr(
#         _bytes(name),
#         _cast_tuple_ImVec2(size),
#         cond
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def show_about_window(p_open: Bool=None):
    """
    Create about window. display dear imgui version, credits and build/system information.
    """
    ccimgui.ImGui_ShowAboutWindow(
        Bool.ptr(p_open)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def show_debug_log_window(p_open: Bool=None):
    """
    Create debug log window. display a simplified log of important dear imgui events.
    """
    ccimgui.ImGui_ShowDebugLogWindow(
        Bool.ptr(p_open)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def show_demo_window(p_open: Bool=None):
    """
    Demo, Debug, Information
    Create demo window. demonstrate most imgui features. call this to learn about the library! try to make it always available in your application!
    """
    ccimgui.ImGui_ShowDemoWindow(
        Bool.ptr(p_open)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def show_font_selector(label: str):
    """
    Add font selector block (not a window), essentially a combo listing the loaded fonts.
    """
    ccimgui.ImGui_ShowFontSelector(
        _bytes(label)
    )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def show_id_stack_tool_window(p_open: Bool=None):
    """
    Create stack tool window. hover items with mouse to query information about the source of their unique id.
    """
    ccimgui.ImGui_ShowIDStackToolWindowEx(
        Bool.ptr(p_open)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def show_id_stack_tool_window_ex(p_open: Bool=None):
#     """
#     Create stack tool window. hover items with mouse to query information about the source of their unique id.
#     """
#     ccimgui.ImGui_ShowIDStackToolWindowEx(
#         Bool.ptr(p_open)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def show_metrics_window(p_open: Bool=None):
    """
    Create metrics/debugger window. display dear imgui internals: windows, draw commands, various internal state, etc.
    """
    ccimgui.ImGui_ShowMetricsWindow(
        Bool.ptr(p_open)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def show_style_editor(ref: ImGuiStyle=None):
    """
    Add style editor block (not a window). you can pass in a reference imguistyle structure to compare to, revert to and save to (else it uses the default style)
    """
    ccimgui.ImGui_ShowStyleEditor(
        <ccimgui.ImGuiStyle*>(NULL if ref is None else ref._ptr)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def show_style_selector(label: str):
    """
    Add style selector block (not a window), essentially a combo listing the default styles.
    """
    cdef bool res = ccimgui.ImGui_ShowStyleSelector(
        _bytes(label)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def show_user_guide():
    """
    Add basic help/info block (not a window): how to manipulate imgui as an end-user (mouse/keyboard controls).
    """
    ccimgui.ImGui_ShowUserGuide()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_angle(label: str, v_rad: Float, v_degrees_min: float=-360.0, v_degrees_max: float=+360.0, format_: str="%.0f deg", flags: int=0):
    """
    Implied v_degrees_min = -360.0f, v_degrees_max = +360.0f, format = '%.0f deg', flags = 0
    """
    cdef bool res = ccimgui.ImGui_SliderAngleEx(
        _bytes(label),
        &v_rad.value,
        v_degrees_min,
        v_degrees_max,
        _bytes(format_),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_angle_ex(label: str, v_rad: Float, v_degrees_min: float=-360.0, v_degrees_max: float=+360.0, format_: str="%.0f deg", flags: int=0):
#     cdef bool res = ccimgui.ImGui_SliderAngleEx(
#         _bytes(label),
#         &v_rad.value,
#         v_degrees_min,
#         v_degrees_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_float(label: str, value: Float, v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
    """
    Widgets: Regular Sliders
    - CTRL+Click on any slider to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
    - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
    - Format string may also be set to NULL or use the default format ("%f" or "%d").
    - Legacy: Pre-1.78 there are SliderXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
    If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
    Implied format = '%.3f', flags = 0
    Adjust format to decorate the value with a prefix or a suffix for in-slider labels or unit display.
    """
    cdef bool res = ccimgui.ImGui_SliderFloatEx(
        _bytes(label),
        &value.value,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_float2(label: str, float_ptrs: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
    """
    Implied format = '%.3f', flags = 0
    """
    cdef float c_floats[2]
    c_floats[0] = float_ptrs[0].value
    c_floats[1] = float_ptrs[1].value
    
    cdef bool res = ccimgui.ImGui_SliderFloat2Ex(
        _bytes(label),
        c_floats,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    float_ptrs[0].value = c_floats[0]
    float_ptrs[1].value = c_floats[1]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_float2_ex(label: str, v: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_SliderFloat2Ex(
#         _bytes(label),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_float3(label: str, float_ptrs: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
    """
    Implied format = '%.3f', flags = 0
    """
    cdef float c_floats[3]
    c_floats[0] = float_ptrs[0].value
    c_floats[1] = float_ptrs[1].value
    c_floats[2] = float_ptrs[2].value

    cdef bool res = ccimgui.ImGui_SliderFloat3Ex(
        _bytes(label),
        c_floats,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    float_ptrs[0].value = c_floats[0]
    float_ptrs[1].value = c_floats[1]
    float_ptrs[2].value = c_floats[2]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_float3_ex(label: str, v: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_SliderFloat3Ex(
#         _bytes(label),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_float4(label: str, float_ptrs: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
    """
    Implied format = '%.3f', flags = 0
    """
    cdef float c_floats[4]
    c_floats[0] = float_ptrs[0].value
    c_floats[1] = float_ptrs[1].value
    c_floats[2] = float_ptrs[2].value
    c_floats[3] = float_ptrs[3].value

    cdef bool res = ccimgui.ImGui_SliderFloat4Ex(
        _bytes(label),
        c_floats,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    float_ptrs[0].value = c_floats[0]
    float_ptrs[1].value = c_floats[1]
    float_ptrs[2].value = c_floats[2]
    float_ptrs[3].value = c_floats[3]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_float4_ex(label: str, v: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_SliderFloat4Ex(
#         _bytes(label),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_float_ex(label: str, v: Float, v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
#     """
#     Adjust format to decorate the value with a prefix or a suffix for in-slider labels or unit display.
#     """
#     cdef bool res = ccimgui.ImGui_SliderFloatEx(
#         _bytes(label),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_int(label: str, value: Int, v_min: int, v_max: int, format_: str="%d", flags: int=0):
    """
    Implied format = '%d', flags = 0
    """
    cdef bool res = ccimgui.ImGui_SliderIntEx(
        _bytes(label),
        &value.value,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_int2(label: str, int_ptrs: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0):
    """
    Implied format = '%d', flags = 0
    """
    cdef int c_ints[2]
    c_ints[0] = int_ptrs[0].value
    c_ints[1] = int_ptrs[1].value

    cdef bool res = ccimgui.ImGui_SliderInt2Ex(
        _bytes(label),
        c_ints,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    int_ptrs[0].value = c_ints[0]
    int_ptrs[1].value = c_ints[1]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_int2_ex(label: str, v: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0):
#     cdef bool res = ccimgui.ImGui_SliderInt2Ex(
#         _bytes(label),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_int3(label: str, int_ptrs: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0):
    """
    Implied format = '%d', flags = 0
    """
    cdef int c_ints[3]
    c_ints[0] = int_ptrs[0].value
    c_ints[1] = int_ptrs[1].value
    c_ints[2] = int_ptrs[2].value    

    cdef bool res = ccimgui.ImGui_SliderInt3Ex(
        _bytes(label),
        c_ints,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    int_ptrs[0].value = c_ints[0]
    int_ptrs[1].value = c_ints[1]
    int_ptrs[2].value = c_ints[2]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_int3_ex(label: str, v: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0):
#     cdef bool res = ccimgui.ImGui_SliderInt3Ex(
#         _bytes(label),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_int4(label: str, int_ptrs: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0):
    """
    Implied format = '%d', flags = 0
    """
    cdef int c_ints[4]
    c_ints[0] = int_ptrs[0].value
    c_ints[1] = int_ptrs[1].value
    c_ints[2] = int_ptrs[2].value
    c_ints[3] = int_ptrs[3].value

    cdef bool res = ccimgui.ImGui_SliderInt4Ex(
        _bytes(label),
        c_ints,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    int_ptrs[0].value = c_ints[0]
    int_ptrs[1].value = c_ints[1]
    int_ptrs[2].value = c_ints[2]
    int_ptrs[3].value = c_ints[3]
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_int4_ex(label: str, v: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0):
#     cdef bool res = ccimgui.ImGui_SliderInt4Ex(
#         _bytes(label),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_int_ex(label: str, v: Int, v_min: int, v_max: int, format_: str="%d", flags: int=0):
#     cdef bool res = ccimgui.ImGui_SliderIntEx(
#         _bytes(label),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_scalar(label: str, data_type: int, p_data: "Int | Long | Float | Double", _min: "int | float", _max: "int | float", format_: str=None, flags: int=0):
    bytes_format_ = _bytes(format_) if format_ is not None else None

    cdef bool res
    cdef long long min_int
    cdef long long max_int
    cdef long long value_int
    cdef float min_float
    cdef float max_float
    cdef float value_float
    cdef double min_double
    cdef double max_double
    cdef double value_double
    if isinstance(p_data, Int) or isinstance(p_data, Long):
        min_int = _min if _min is not None else 0
        max_int = _max if _max is not None else 0
        value_int = p_data.value
        res = ccimgui.ImGui_SliderScalarEx(
            _bytes(label),
            data_type,
            &value_int,
            &min_int,
            &max_int,
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = value_int
    elif isinstance(p_data, Float):
        min_float = <float>(_min if _min is not None else 0)
        max_float = <float>(_max if _max is not None else 0)
        value_float = p_data.value
        res = ccimgui.ImGui_SliderScalarEx(
            _bytes(label),
            data_type,
            &value_float,
            &min_float,
            &max_float,
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = value_float
    else:
        min_double = <double>(_min if _min is not None else 0)
        max_double = <double>(_max if _max is not None else 0)
        value_double = p_data.value
        res = ccimgui.ImGui_SliderScalarEx(
            _bytes(label),
            data_type,
            &value_double,
            &min_double,
            &max_double,
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = value_double

    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_scalar_ex(label: str, data_type: int, p_data: Any, p_min: Any, p_max: Any, format_: str=None, flags: int=0):
#     bytes_format_ = _bytes(format_) if format_ is not None else None

#     cdef bool res = ccimgui.ImGui_SliderScalarEx(
#         _bytes(label),
#         data_type,
#         p_data,
#         p_min,
#         p_max,
#         ((<char*>bytes_format_ if format_ is not None else NULL)),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def slider_scalar_n(label: str, data_type: int, p_data: "Sequence[Int | Long | Float | Double]", components: int, p_min: "int | float", p_max: "int | float", format_: str=None, flags: int=0):
    IM_ASSERT(len(p_data) > 0, "Should probably have at least one component")
    
    bytes_format_ = _bytes(format_) if format_ is not None else None
    cdef long long long_long_size

    cdef int* c_ints
    cdef long long* c_longs
    cdef float* c_floats
    cdef double* c_doubles

    cdef int int_p_min
    cdef int int_p_max
    cdef long long long_p_min
    cdef long long long_p_max
    cdef float float_p_min
    cdef float float_p_max
    cdef double double_p_min
    cdef double double_p_max

    cdef bool res

    first = p_data[0]
    if isinstance(first, Int):
        c_ints = <int*>ccimgui.ImGui_MemAlloc(sizeof(int) * len(p_data))
        int_p_min = p_min if p_min is not None else 0
        int_p_max = p_max if p_min is not None else 0

        for i in range(len(p_data)):
            c_ints[i] = p_data[i].value

        res = ccimgui.ImGui_SliderScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_ints,
            components,
            <void*>(&int_p_min if p_min is not None else NULL),
            <void*>(&int_p_max if p_max is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_ints[i]

        ccimgui.ImGui_MemFree(c_ints)
    elif isinstance(first, Long):
        c_longs = <long long*>ccimgui.ImGui_MemAlloc(sizeof(long_long_size) * len(p_data))
        long_p_min = p_min if p_min is not None else 0
        long_p_max = p_max if p_min is not None else 0

        for i in range(len(p_data)):
            c_longs[i] = p_data[i].value

        res = ccimgui.ImGui_SliderScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_longs,
            components,
            <void*>(&long_p_min if p_min is not None else NULL),
            <void*>(&long_p_max if p_max is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_longs[i]

        ccimgui.ImGui_MemFree(c_longs)
    elif isinstance(first, Float):
        c_floats = <float*>ccimgui.ImGui_MemAlloc(sizeof(float) * len(p_data))
        float_p_min = p_min if p_min is not None else 0
        float_p_max = p_max if p_min is not None else 0

        for i in range(len(p_data)):
            c_floats[i] = p_data[i].value

        res = ccimgui.ImGui_SliderScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_floats,
            components,
            <void*>(&float_p_min if p_min is not None else NULL),
            <void*>(&float_p_max if p_max is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_floats[i]

        ccimgui.ImGui_MemFree(c_floats)
    else:
        c_doubles = <double*>ccimgui.ImGui_MemAlloc(sizeof(double) * len(p_data))
        double_p_min = p_min if p_min is not None else 0
        double_p_max = p_max if p_min is not None else 0

        for i in range(len(p_data)):
            c_doubles[i] = p_data[i].value

        res = ccimgui.ImGui_SliderScalarNEx(
            _bytes(label),
            data_type,
            <void*>c_doubles,
            components,
            <void*>(&double_p_min if p_min is not None else NULL),
            <void*>(&double_p_max if p_max is not None else NULL),
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )

        for i in range(len(p_data)):
            p_data[i].value = c_doubles[i]

        ccimgui.ImGui_MemFree(c_doubles)
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def slider_scalar_n_ex(label: str, data_type: int, p_data: Any, components: int, p_min: Any, p_max: Any, format_: str=None, flags: int=0):
#     bytes_format_ = _bytes(format_) if format_ is not None else None

#     cdef bool res = ccimgui.ImGui_SliderScalarNEx(
#         _bytes(label),
#         data_type,
#         p_data,
#         components,
#         p_min,
#         p_max,
#         ((<char*>bytes_format_ if format_ is not None else NULL)),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def small_button(label: str):
    """
    Button with (framepadding.y == 0) to easily embed within text
    """
    cdef bool res = ccimgui.ImGui_SmallButton(
        _bytes(label)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def spacing():
    """
    Add vertical spacing.
    """
    ccimgui.ImGui_Spacing()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def style_colors_classic(dst: ImGuiStyle=None):
    """
    Classic imgui style
    """
    ccimgui.ImGui_StyleColorsClassic(
        <ccimgui.ImGuiStyle*>(NULL if dst is None else dst._ptr)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def style_colors_dark(dst: ImGuiStyle=None):
    """
    Styles
    New, recommended style (default)
    """
    ccimgui.ImGui_StyleColorsDark(
        <ccimgui.ImGuiStyle*>(NULL if dst is None else dst._ptr)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def style_colors_light(dst: ImGuiStyle=None):
    """
    Best used with borders and a custom, thicker font
    """
    ccimgui.ImGui_StyleColorsLight(
        <ccimgui.ImGuiStyle*>(NULL if dst is None else dst._ptr)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def tab_item_button(label: str, flags: int=0):
    """
    Create a tab behaving like a button. return true when clicked. cannot be selected in the tab bar.
    """
    cdef bool res = ccimgui.ImGui_TabItemButton(
        _bytes(label),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
# def table_angled_headers_row():
#     """
#     Submit a row with angled headers for every column with the imguitablecolumnflags_angledheader flag. must be first row.
#     """
#     ccimgui.ImGui_TableAngledHeadersRow()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
# def table_get_column_count():
#     """
#     Return number of columns (value passed to begintable)
#     """
#     cdef int res = ccimgui.ImGui_TableGetColumnCount()
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
# def table_get_column_flags(column_n: int=-1):
#     """
#     Return column flags so you can query their enabled/visible/sorted/hovered status flags. pass -1 to use current column.
#     """
#     cdef ccimgui.ImGuiTableColumnFlags res = ccimgui.ImGui_TableGetColumnFlags(
#         column_n
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
# def table_get_column_index():
#     """
#     Return current column index.
#     """
#     cdef int res = ccimgui.ImGui_TableGetColumnIndex()
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(str)
# def table_get_column_name(column_n: int=-1):
#     """
#     Return '' if column didn't have a name declared by tablesetupcolumn(). pass -1 to use current column.
#     """
#     cdef const char* res = ccimgui.ImGui_TableGetColumnName(
#         column_n
#     )
#     return _from_bytes(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(int)
# def table_get_row_index():
#     """
#     Return current row index.
#     """
#     cdef int res = ccimgui.ImGui_TableGetRowIndex()
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(ImGuiTableSortSpecs)
def table_get_sort_specs():
    """
    Tables: Sorting & Miscellaneous functions
    - Sorting: call TableGetSortSpecs() to retrieve latest sort specs for the table. NULL when not sorting.
    When 'sort_specs->SpecsDirty == true' you should sort your data. It will be true when sorting specs have
    changed since last call, or the first time. Make sure to set 'SpecsDirty = false' after sorting,
    else you may wastefully sort your data every frame!
    - Functions args 'int column_n' treat the default value of -1 as the same as passing the current column index.
    Get latest sort specs for the table (null if not sorting).  lifetime: don't hold on this pointer over multiple frames or past any subsequent call to begintable().
    """
    cdef ccimgui.ImGuiTableSortSpecs* res = ccimgui.ImGui_TableGetSortSpecs()
    return ImGuiTableSortSpecs.from_ptr(res)
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def table_header(label: str):
    """
    Submit one header cell manually (rarely used)
    """
    ccimgui.ImGui_TableHeader(
        _bytes(label)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def table_headers_row():
    """
    Submit a row with headers cells based on data provided to tablesetupcolumn() + submit context menu
    """
    ccimgui.ImGui_TableHeadersRow()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def table_next_column():
    """
    Append into the next column (or first column of next row if currently in last column). return true when column is visible.
    """
    cdef bool res = ccimgui.ImGui_TableNextColumn()
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def table_next_row(row_flags: int=0, min_row_height: float=0.0):
    """
    Append into the first cell of a new row.
    """
    ccimgui.ImGui_TableNextRowEx(
        row_flags,
        min_row_height
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def table_next_row_ex(row_flags: int=0, min_row_height: float=0.0):
#     """
#     Append into the first cell of a new row.
#     """
#     ccimgui.ImGui_TableNextRowEx(
#         row_flags,
#         min_row_height
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def table_set_bg_color(target: int, color: int, column_n: int=-1):
    """
    Change the color of a cell, row, or column. see imguitablebgtarget_ flags for details.
    """
    ccimgui.ImGui_TableSetBgColor(
        target,
        color,
        column_n
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def table_set_column_enabled(column_n: int, v: bool):
    """
    Change user accessible enabled/disabled state of a column. set to false to hide the column. user can use the context menu to change this themselves (right-click in headers, or right-click in columns body with imguitableflags_contextmenuinbody)
    """
    ccimgui.ImGui_TableSetColumnEnabled(
        column_n,
        v
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def table_set_column_index(column_n: int):
    """
    Append into the specified column. return true when column is visible.
    """
    cdef bool res = ccimgui.ImGui_TableSetColumnIndex(
        column_n
    )
    return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def table_setup_column(label: str, flags: int=0, init_width_or_weight: float=0.0, user_id: int=0):
    """
    Tables: Headers & Columns declaration
    - Use TableSetupColumn() to specify label, resizing policy, default width/weight, id, various other flags etc.
    - Use TableHeadersRow() to create a header row and automatically submit a TableHeader() for each column.
    Headers are required to perform: reordering, sorting, and opening the context menu.
    The context menu can also be made available in columns body using ImGuiTableFlags_ContextMenuInBody.
    - You may manually submit headers using TableNextRow() + TableHeader() calls, but this is only useful in
    some advanced use cases (e.g. adding custom widgets in header row).
    - Use TableSetupScrollFreeze() to lock columns/rows so they stay visible when scrolled.
    Implied init_width_or_weight = 0.0f, user_id = 0
    """
    ccimgui.ImGui_TableSetupColumnEx(
        _bytes(label),
        flags,
        init_width_or_weight,
        user_id
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def table_setup_column_ex(label: str, flags: int=0, init_width_or_weight: float=0.0, user_id: int=0):
#     ccimgui.ImGui_TableSetupColumnEx(
#         _bytes(label),
#         flags,
#         init_width_or_weight,
#         user_id
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def table_setup_scroll_freeze(cols: int, rows: int):
    """
    Lock columns/rows so they stay visible when scrolled.
    """
    ccimgui.ImGui_TableSetupScrollFreeze(
        cols,
        rows
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def text(fmt: str):
    """
    Formatted text
    """
    ccimgui.ImGui_Text(
        _bytes(fmt)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def text_colored(col: Tuple[float, float, float, float], fmt: str):
    """
    Shortcut for pushstylecolor(imguicol_text, col); text(fmt, ...); popstylecolor();
    """
    ccimgui.ImGui_TextColored(
        _cast_tuple_ImVec4(col),
        _bytes(fmt)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def text_colored_v(col: Tuple[float, float, float, float], fmt: str):
#     ccimgui.ImGui_TextColoredV(
#         _cast_tuple_ImVec4(col),
#         _bytes(fmt)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def text_disabled(fmt: str):
    """
    Shortcut for pushstylecolor(imguicol_text, style.colors[imguicol_textdisabled]); text(fmt, ...); popstylecolor();
    """
    ccimgui.ImGui_TextDisabled(
        _bytes(fmt)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def text_disabled_v(fmt: str):
#     ccimgui.ImGui_TextDisabledV(
#         _bytes(fmt)
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def text_unformatted(text: str, text_end: str=None):
    """
    Raw text without formatting. roughly equivalent to text('%s', text) but: a) doesn't require null terminated string if 'text_end' is specified, b) it's faster, no memory copy is done, no buffer size limits, recommended for long chunks of text.
    """
    bytes_text_end = _bytes(text_end) if text_end is not None else None

    ccimgui.ImGui_TextUnformattedEx(
        _bytes(text),
        ((<char*>bytes_text_end if text_end is not None else NULL))
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def text_unformatted_ex(text: str, text_end: str=None):
#     """
#     Raw text without formatting. roughly equivalent to text('%s', text) but: a) doesn't require null terminated string if 'text_end' is specified, b) it's faster, no memory copy is done, no buffer size limits, recommended for long chunks of text.
#     """
#     bytes_text_end = _bytes(text_end) if text_end is not None else None

#     ccimgui.ImGui_TextUnformattedEx(
#         _bytes(text),
#         ((<char*>bytes_text_end if text_end is not None else NULL))
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def text_v(fmt: str):
#     ccimgui.ImGui_TextV(
#         _bytes(fmt)
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def text_wrapped(fmt: str):
    """
    Shortcut for pushtextwrappos(0.0f); text(fmt, ...); poptextwrappos();. note that this won't work on an auto-resizing window if there's no other widgets to extend the window width, yoy may need to set a size using setnextwindowsize().
    """
    ccimgui.ImGui_TextWrapped(
        _bytes(fmt)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def text_wrapped_v(fmt: str):
#     ccimgui.ImGui_TextWrappedV(
#         _bytes(fmt)
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def tree_node(label: str, flags: int=0):
    """
    Widgets: Trees
    - TreeNode functions return true when the node is open, in which case you need to also call TreePop() when you are finished displaying the tree node contents.
    """
    cdef bool res = ccimgui.ImGui_TreeNodeEx(
        _bytes(label),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def tree_node_ex(label: str, flags: int=0):
#     cdef bool res = ccimgui.ImGui_TreeNodeEx(
#         _bytes(label),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def tree_node_ex_ptr(ptr_id: Any, flags: int, fmt: str):
#     cdef bool res = ccimgui.ImGui_TreeNodeExPtr(
#         ptr_id,
#         flags,
#         _bytes(fmt)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def tree_node_ex_str(str_id: str, flags: int, fmt: str):
#     cdef bool res = ccimgui.ImGui_TreeNodeExStr(
#         _bytes(str_id),
#         flags,
#         _bytes(fmt)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def tree_node_ex_v(str_id: str, flags: int, fmt: str):
#     cdef bool res = ccimgui.ImGui_TreeNodeExV(
#         _bytes(str_id),
#         flags,
#         _bytes(fmt)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def tree_node_ex_vptr(ptr_id: Any, flags: int, fmt: str):
#     cdef bool res = ccimgui.ImGui_TreeNodeExVPtr(
#         ptr_id,
#         flags,
#         _bytes(fmt)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def tree_node_ptr(ptr_id: Any, fmt: str):
#     """
#     '
#     """
#     cdef bool res = ccimgui.ImGui_TreeNodePtr(
#         ptr_id,
#         _bytes(fmt)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def tree_node_str(str_id: str, fmt: str):
    """
    Helper variation to easily decorelate the id from the displayed string. read the faq about why and how to use id. to align arbitrary text at the same level as a treenode() you can use bullet().
    """
    cdef bool res = ccimgui.ImGui_TreeNodeStr(
        _bytes(str_id),
        _bytes(fmt)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def tree_node_v(str_id: str, fmt: str):
#     cdef bool res = ccimgui.ImGui_TreeNodeV(
#         _bytes(str_id),
#         _bytes(fmt)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def tree_node_vptr(ptr_id: Any, fmt: str):
#     cdef bool res = ccimgui.ImGui_TreeNodeVPtr(
#         ptr_id,
#         _bytes(fmt)
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def tree_pop():
    """
    ~ unindent()+popid()
    """
    ccimgui.ImGui_TreePop()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def tree_push(obj: object):
    """
    ~ indent()+pushid(). already called by treenode() when returning true, but you can call treepush/treepop yourself if desired.
    pygui note: Uses python's hash() function on the object passed in.
    """
    ccimgui.ImGui_TreePushPtr(
        <void*><uintptr_t>hash(obj)
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def tree_push_ptr(ptr_id: Any):
#     """
#     '
#     """
#     ccimgui.ImGui_TreePushPtr(
#         ptr_id
#     )
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def unindent(indent_w: float=0.0):
    """
    Move content position back to the left, by indent_w, or style.indentspacing if indent_w <= 0
    """
    ccimgui.ImGui_UnindentEx(
        indent_w
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(None)
# def unindent_ex(indent_w: float=0.0):
#     """
#     Move content position back to the left, by indent_w, or style.indentspacing if indent_w <= 0
#     """
#     ccimgui.ImGui_UnindentEx(
#         indent_w
#     )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(None)
def update_platform_windows():
    """
    Call in main loop. will call createwindow/resizewindow/etc. platform functions for each secondary viewport, and destroywindow for each inactive viewport.
    """
    ccimgui.ImGui_UpdatePlatformWindows()
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def vslider_float(label: str, size: Tuple[float, float], v: Float, v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
    cdef bool res = ccimgui.ImGui_VSliderFloatEx(
        _bytes(label),
        _cast_tuple_ImVec2(size),
        &v.value,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def vslider_float_ex(label: str, size: Tuple[float, float], v: Float, v_min: float, v_max: float, format_: str="%.3f", flags: int=0):
#     cdef bool res = ccimgui.ImGui_VSliderFloatEx(
#         _bytes(label),
#         _cast_tuple_ImVec2(size),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def vslider_int(label: str, size: Tuple[float, float], v: Int, v_min: int, v_max: int, format_: str="%d", flags: int=0):
    cdef bool res = ccimgui.ImGui_VSliderIntEx(
        _bytes(label),
        _cast_tuple_ImVec2(size),
        &v.value,
        v_min,
        v_max,
        _bytes(format_),
        flags
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def vslider_int_ex(label: str, size: Tuple[float, float], v: Int, v_min: int, v_max: int, format_: str="%d", flags: int=0):
#     cdef bool res = ccimgui.ImGui_VSliderIntEx(
#         _bytes(label),
#         _cast_tuple_ImVec2(size),
#         &v.value,
#         v_min,
#         v_max,
#         _bytes(format_),
#         flags
#     )
#     return res
# [End Function]

# [Function]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
# ?returns(bool)
def vslider_scalar(label: str, size: Tuple[float, float], data_type: int, p_data: "Int | Long | Float | Double", _min: "int | float", _max: "int | float", format_: str=None, flags: int=0):
    bytes_format_ = _bytes(format_) if format_ is not None else None
    
    cdef bool res
    cdef long long min_int
    cdef long long max_int
    cdef long long value_int
    cdef float min_float
    cdef float max_float
    cdef float value_float
    cdef double min_double
    cdef double max_double
    cdef double value_double
    if isinstance(p_data, Int) or isinstance(p_data, Long):
        min_int = _min if _min is not None else 0
        max_int = _max if _max is not None else 0
        value_int = p_data.value

        res = ccimgui.ImGui_VSliderScalarEx(
            _bytes(label),
            _cast_tuple_ImVec2(size),
            data_type,
            &value_int,
            &min_int if _min is not None else NULL,
            &max_int if _max is not None else NULL,
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = value_int
    elif isinstance(p_data, Float):
        min_float = <float>(_min if _min is not None else 0)
        max_float = <float>(_max if _max is not None else 0)
        value_float = p_data.value
        res = ccimgui.ImGui_VSliderScalarEx(
            _bytes(label),
            _cast_tuple_ImVec2(size),
            data_type,
            &value_float,
            &min_float if _min is not None else NULL,
            &max_float if _max is not None else NULL,
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = value_float
    else:
        min_double = <double>(_min if _min is not None else 0)
        max_double = <double>(_max if _max is not None else 0)
        value_double = p_data.value
        res = ccimgui.ImGui_VSliderScalarEx(
            _bytes(label),
            _cast_tuple_ImVec2(size),
            data_type,
            &value_double,
            &min_double if _min is not None else NULL,
            &max_double if _max is not None else NULL,
            ((<char*>bytes_format_ if format_ is not None else NULL)),
            flags
        )
        p_data.value = value_double

    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# ?returns(bool)
# def vslider_scalar_ex(label: str, size: Tuple[float, float], data_type: int, p_data: Any, p_min: Any, p_max: Any, format_: str=None, flags: int=0):
#     bytes_format_ = _bytes(format_) if format_ is not None else None

#     cdef bool res = ccimgui.ImGui_VSliderScalarEx(
#         _bytes(label),
#         _cast_tuple_ImVec2(size),
#         data_type,
#         p_data,
#         p_min,
#         p_max,
#         ((<char*>bytes_format_ if format_ is not None else NULL)),
#         flags
#     )
#     return res
# [End Function]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class GLFWmonitor:
    cdef ccimgui.GLFWmonitor* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef GLFWmonitor from_ptr(ccimgui.GLFWmonitor* _ptr):
        if _ptr == NULL:
            return None
        cdef GLFWmonitor wrapper = GLFWmonitor.__new__(GLFWmonitor)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef GLFWmonitor from_heap_ptr(ccimgui.GLFWmonitor* _ptr):
        wrapper = GLFWmonitor.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class GLFWwindow:
    cdef ccimgui.GLFWwindow* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef GLFWwindow from_ptr(ccimgui.GLFWwindow* _ptr):
        if _ptr == NULL:
            return None
        cdef GLFWwindow wrapper = GLFWwindow.__new__(GLFWwindow)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef GLFWwindow from_heap_ptr(ccimgui.GLFWwindow* _ptr):
        wrapper = GLFWwindow.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# cdef class ImColor:
#     """
#     Helper: ImColor() implicitly converts colors to either ImU32 (packed 4x1 byte) or ImVec4 (4x1 float)
#     Prefer using IM_COL32() macros if you want a guaranteed compile-time ImU32 for usage with ImDrawList API.
#     **Avoid storing ImColor! Store either u32 of ImVec4. This is not a full-featured color class. MAY OBSOLETE.
#     **None of the ImGui API are using ImColor directly but you can use it as a convenience to pass colors in either ImU32 or ImVec4 formats. Explicitly cast to ImU32 or ImVec4 if needed.
#     """
#     cdef ccimgui.ImColor* _ptr
#     cdef bool dynamically_allocated

#     @staticmethod
#     cdef ImColor from_ptr(ccimgui.ImColor* _ptr):
#         if _ptr == NULL:
#             return None
#         cdef ImColor wrapper = ImColor.__new__(ImColor)
#         wrapper._ptr = _ptr
#         wrapper.dynamically_allocated = False
#         return wrapper

#     @staticmethod
#     cdef ImColor from_heap_ptr(ccimgui.ImColor* _ptr):
#         wrapper = ImColor.from_ptr(_ptr)
#         if wrapper is None:
#             return None
#         wrapper.dynamically_allocated = True
#         return wrapper

#     def __init__(self):
#         raise TypeError("This class cannot be instantiated directly.")

#     def __hash__(self) -> int:
#         if self._ptr == NULL:
#             raise RuntimeError("Won't hash a NULL pointer")
#         cdef unsigned int ptr_int = <uintptr_t>self._ptr
#         return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float, float, float])
    # @property
    # def value(self):
    #     cdef ccimgui.ImVec4 res = dereference(self._ptr).Value
    #     return _cast_ImVec4_tuple(res)
    # @value.setter
    # def value(self, value: Tuple[float, float, float, float]):
    #     # dereference(self._ptr).Value = _cast_tuple_ImVec4(value)
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImColor)
    # def hsv(self: ImColor, h: float, s: float, v: float, a: float=1.0):
    #     cdef ccimgui.ImColor res = ccimgui.ImColor_HSV(
    #         self._ptr,
    #         h,
    #         s,
    #         v,
    #         a
    #     )
    #     return ImColor.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_hsv(self: ImColor, h: float, s: float, v: float, a: float=1.0):
    #     """
    #     FIXME-OBSOLETE: May need to obsolete/cleanup those helpers.
    #     """
    #     ccimgui.ImColor_SetHSV(
    #         self._ptr,
    #         h,
    #         s,
    #         v,
    #         a
    #     )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImDrawChannel:
    """
    [Internal] For use by ImDrawListSplitter
    """
    cdef ccimgui.ImDrawChannel* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImDrawChannel from_ptr(ccimgui.ImDrawChannel* _ptr):
        if _ptr == NULL:
            return None
        cdef ImDrawChannel wrapper = ImDrawChannel.__new__(ImDrawChannel)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImDrawChannel from_heap_ptr(ccimgui.ImDrawChannel* _ptr):
        wrapper = ImDrawChannel.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImVector_ImDrawCmd)
    # @property
    # def cmd_buffer(self):
    #     cdef ccimgui.ImVector_ImDrawCmd res = dereference(self._ptr)._CmdBuffer
    #     return ImVector_ImDrawCmd.from_ptr(res)
    # @cmd_buffer.setter
    # def cmd_buffer(self, value: ImVector_ImDrawCmd):
    #     # dereference(self._ptr)._CmdBuffer = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[int])
    # @property
    # def idx_buffer(self):
    #     cdef ccimgui.ImVector_ImDrawIdx res = dereference(self._ptr)._IdxBuffer
    #     return ImVector_ImDrawIdx.from_ptr(res)
    # @idx_buffer.setter
    # def idx_buffer(self, value: ImVector_ImDrawIdx):
    #     # dereference(self._ptr)._IdxBuffer = value._ptr
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImDrawCmd:
    """
    Typically, 1 command = 1 GPU draw call (unless command is a callback)
    - VtxOffset: When 'io.BackendFlags & ImGuiBackendFlags_RendererHasVtxOffset' is enabled,
    this fields allow us to render meshes larger than 64K vertices while keeping 16-bit indices.
    Backends made for <1.71. will typically ignore the VtxOffset fields.
    - The ClipRect/TextureId/VtxOffset fields must be contiguous as we memcmp() them together (this is asserted for).
    """
    cdef ccimgui.ImDrawCmd* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImDrawCmd from_ptr(ccimgui.ImDrawCmd* _ptr):
        if _ptr == NULL:
            return None
        cdef ImDrawCmd wrapper = ImDrawCmd.__new__(ImDrawCmd)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImDrawCmd from_heap_ptr(ccimgui.ImDrawCmd* _ptr):
        wrapper = ImDrawCmd.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float, float, float])
    @property
    def clip_rect(self):
        """
        4*4  // clipping rectangle (x1, y1, x2, y2). subtract imdrawdata->displaypos to get clipping rectangle in 'viewport' coordinates
        """
        cdef ccimgui.ImVec4 res = dereference(self._ptr).ClipRect
        return _cast_ImVec4_tuple(res)
    @clip_rect.setter
    def clip_rect(self, value: Tuple[float, float, float, float]):
        # dereference(self._ptr).ClipRect = _cast_tuple_ImVec4(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def elem_count(self):
        """
        4// number of indices (multiple of 3) to be rendered as triangles. vertices are stored in the callee imdrawlist's vtx_buffer[] array, indices in idx_buffer[].
        """
        cdef unsigned int res = dereference(self._ptr).ElemCount
        return res
    @elem_count.setter
    def elem_count(self, value: int):
        # dereference(self._ptr).ElemCount = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def idx_offset(self):
        """
        4// start offset in index buffer.
        """
        cdef unsigned int res = dereference(self._ptr).IdxOffset
        return res
    @idx_offset.setter
    def idx_offset(self, value: int):
        # dereference(self._ptr).IdxOffset = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(object)
    # @property
    # def texture_id(self):
    #     """
    #     4-8  // user-provided texture id. set by user in imfontatlas::settexid() for fonts or passed to image*() functions. ignore if never using images or multiple fonts atlas.
    #     """
    #     cdef ccimgui.ImTextureID res = dereference(self._ptr).TextureId
    #     return res
    # @texture_id.setter
    # def texture_id(self, value: Any):
    #     # dereference(self._ptr).TextureId = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def user_callback(self):
    #     """
    #     4-8  // if != null, call the function instead of rendering the vertices. clip_rect and texture_id will be set normally.
    #     """
    #     cdef ccimgui.ImDrawCallback res = dereference(self._ptr).UserCallback
    #     return res
    # @user_callback.setter
    # def user_callback(self, value: Callable):
    #     # dereference(self._ptr).UserCallback = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def user_callback_data(self):
    #     """
    #     4-8  // the draw callback code can access this.
    #     """
    #     cdef void* res = dereference(self._ptr).UserCallbackData
    #     return res
    # @user_callback_data.setter
    # def user_callback_data(self, value: Any):
    #     # dereference(self._ptr).UserCallbackData = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def vtx_offset(self):
        """
        4// start offset in vertex buffer. imguibackendflags_rendererhasvtxoffset: always 0, otherwise may be >0 to support meshes larger than 64k vertices with 16-bit indices.
        """
        cdef unsigned int res = dereference(self._ptr).VtxOffset
        return res
    @vtx_offset.setter
    def vtx_offset(self, value: int):
        # dereference(self._ptr).VtxOffset = value
        raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # def get_tex_id(self: ImDrawCmd):
    #     """
    #     Since 1.83: returns ImTextureID associated with this draw call. Warning: DO NOT assume this is always same as 'TextureId' (we will change this function for an upcoming feature)
    #     """
    #     cdef ccimgui.ImTextureID res = ccimgui.ImDrawCmd_GetTexID(
    #         self._ptr
    #     )
    #     return res
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# cdef class ImDrawCmdHeader:
#     """
#     [Internal] For use by ImDrawList
#     """
#     cdef ccimgui.ImDrawCmdHeader* _ptr
#     cdef bool dynamically_allocated

#     @staticmethod
#     cdef ImDrawCmdHeader from_ptr(ccimgui.ImDrawCmdHeader* _ptr):
#         if _ptr == NULL:
#             return None
#         cdef ImDrawCmdHeader wrapper = ImDrawCmdHeader.__new__(ImDrawCmdHeader)
#         wrapper._ptr = _ptr
#         wrapper.dynamically_allocated = False
#         return wrapper

#     @staticmethod
#     cdef ImDrawCmdHeader from_heap_ptr(ccimgui.ImDrawCmdHeader* _ptr):
#         wrapper = ImDrawCmdHeader.from_ptr(_ptr)
#         if wrapper is None:
#             return None
#         wrapper.dynamically_allocated = True
#         return wrapper

#     def __init__(self):
#         raise TypeError("This class cannot be instantiated directly.")

#     def __hash__(self) -> int:
#         if self._ptr == NULL:
#             raise RuntimeError("Won't hash a NULL pointer")
#         cdef unsigned int ptr_int = <uintptr_t>self._ptr
#         return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float, float, float])
    @property
    def clip_rect(self):
        cdef ccimgui.ImVec4 res = dereference(self._ptr).ClipRect
        return _cast_ImVec4_tuple(res)
    @clip_rect.setter
    def clip_rect(self, value: Tuple[float, float, float, float]):
        # dereference(self._ptr).ClipRect = _cast_tuple_ImVec4(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def texture_id(self):
    #     cdef ccimgui.ImTextureID res = dereference(self._ptr).TextureId
    #     return res
    # @texture_id.setter
    # def texture_id(self, value: Any):
    #     # dereference(self._ptr).TextureId = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def vtx_offset(self):
    #     cdef unsigned int res = dereference(self._ptr).VtxOffset
    #     return res
    # @vtx_offset.setter
    # def vtx_offset(self, value: int):
    #     # dereference(self._ptr).VtxOffset = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImDrawData:
    """
    All draw data to render a Dear ImGui frame
    (NB: the style and the naming convention here is a little inconsistent, we currently preserve them for backward compatibility purpose,
    as this is one of the oldest structure exposed by the library! Basically, ImDrawList == CmdList)
    """
    cdef ccimgui.ImDrawData* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImDrawData from_ptr(ccimgui.ImDrawData* _ptr):
        if _ptr == NULL:
            return None
        cdef ImDrawData wrapper = ImDrawData.__new__(ImDrawData)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImDrawData from_heap_ptr(ccimgui.ImDrawData* _ptr):
        wrapper = ImDrawData.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImVector_ImDrawListPtr])
    @property
    def cmd_lists(self):
        """
        Array of imdrawlist* to render. the imdrawlists are owned by imguicontext and only pointed to from here.
        """
        cdef ccimgui.ImDrawList** cmd_lists = dereference(self._ptr).CmdLists.Data
        return [
            ImDrawList.from_ptr(cmd_lists[idx]) for idx in range(self.cmd_lists_count)
        ]
    @cmd_lists.setter
    def cmd_lists(self, value: ImDrawList):
        # dereference(self._ptr).CmdLists = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def cmd_lists_count(self):
        """
        Number of imdrawlist* to render
        """
        cdef int res = dereference(self._ptr).CmdListsCount
        return res
    @cmd_lists_count.setter
    def cmd_lists_count(self, value: int):
        # dereference(self._ptr).CmdListsCount = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    # @property
    # def display_pos(self):
    #     """
    #     Top-left position of the viewport to render (== top-left of the orthogonal projection matrix to use) (== getmainviewport()->pos for the main viewport, == (0.0) in most single-viewport applications)
    #     """
    #     cdef ccimgui.ImVec2 res = dereference(self._ptr).DisplayPos
    #     return _cast_ImVec2_tuple(res)
    # @display_pos.setter
    # def display_pos(self, value: Tuple[float, float]):
    #     # dereference(self._ptr).DisplayPos = _cast_tuple_ImVec2(value)
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    # @property
    # def display_size(self):
    #     """
    #     Size of the viewport to render (== getmainviewport()->size for the main viewport, == io.displaysize in most single-viewport applications)
    #     """
    #     cdef ccimgui.ImVec2 res = dereference(self._ptr).DisplaySize
    #     return _cast_ImVec2_tuple(res)
    # @display_size.setter
    # def display_size(self, value: Tuple[float, float]):
    #     # dereference(self._ptr).DisplaySize = _cast_tuple_ImVec2(value)
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    # @property
    # def framebuffer_scale(self):
    #     """
    #     Amount of pixels for each unit of displaysize. based on io.displayframebufferscale. generally (1,1) on normal display, (2,2) on osx with retina display.
    #     """
    #     cdef ccimgui.ImVec2 res = dereference(self._ptr).FramebufferScale
    #     return _cast_ImVec2_tuple(res)
    # @framebuffer_scale.setter
    # def framebuffer_scale(self, value: Tuple[float, float]):
    #     # dereference(self._ptr).FramebufferScale = _cast_tuple_ImVec2(value)
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGuiViewport)
    # @property
    # def owner_viewport(self):
    #     """
    #     Viewport carrying the imdrawdata instance, might be of use to the renderer (generally not).
    #     """
    #     cdef ccimgui.ImGuiViewport* res = dereference(self._ptr).OwnerViewport
    #     return ImGuiViewport.from_ptr(res)
    # @owner_viewport.setter
    # def owner_viewport(self, value: ImGuiViewport):
    #     # dereference(self._ptr).OwnerViewport = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def total_idx_count(self):
    #     """
    #     For convenience, sum of all imdrawlist's idxbuffer.size
    #     """
    #     cdef int res = dereference(self._ptr).TotalIdxCount
    #     return res
    # @total_idx_count.setter
    # def total_idx_count(self, value: int):
    #     # dereference(self._ptr).TotalIdxCount = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def total_vtx_count(self):
    #     """
    #     For convenience, sum of all imdrawlist's vtxbuffer.size
    #     """
    #     cdef int res = dereference(self._ptr).TotalVtxCount
    #     return res
    # @total_vtx_count.setter
    # def total_vtx_count(self, value: int):
    #     # dereference(self._ptr).TotalVtxCount = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # @property
    # def valid(self):
    #     """
    #     Only valid after render() is called and before the next newframe() is called.
    #     """
    #     cdef bool res = dereference(self._ptr).Valid
    #     return res
    # @valid.setter
    # def valid(self, value: bool):
    #     # dereference(self._ptr).Valid = value
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_draw_list(self: ImDrawData, draw_list: ImDrawList):
    #     """
    #     Helper to add an external draw list into an existing imdrawdata.
    #     """
    #     ccimgui.ImDrawData_AddDrawList(
    #         self._ptr,
    #         draw_list._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear(self: ImDrawData):
    #     ccimgui.ImDrawData_Clear(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def de_index_all_buffers(self: ImDrawData):
    #     """
    #     Helper to convert all buffers from indexed to non-indexed, in case you cannot render indexed. note: this is slow and most likely a waste of resources. always prefer indexed rendering!
    #     """
    #     ccimgui.ImDrawData_DeIndexAllBuffers(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def scale_clip_rects(self: ImDrawData, fb_scale: Tuple[float, float]):
        """
        Helper to scale the cliprect field of each imdrawcmd. use if your final output buffer is at a different scale than dear imgui expects, or if there is a difference between your window resolution and framebuffer resolution.
        """
        ccimgui.ImDrawData_ScaleClipRects(
            self._ptr,
            _cast_tuple_ImVec2(fb_scale)
        )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImDrawList:
    """
    Draw command list
    This is the low-level list of polygons that ImGui:: functions are filling. At the end of the frame,
    all command lists are passed to your ImGuiIO::RenderDrawListFn function for rendering.
    Each dear imgui window contains its own ImDrawList. You can use ImGui::GetWindowDrawList() to
    access the current window draw list and draw custom primitives.
    You can interleave normal ImGui:: calls and adding primitives to the current draw list.
    In single viewport mode, top-left is == GetMainViewport()->Pos (generally 0,0), bottom-right is == GetMainViewport()->Pos+Size (generally io.DisplaySize).
    You are totally free to apply whatever transformation matrix to want to the data (depending on the use of the transformation you may want to apply it to ClipRect as well!)
    Important: Primitives are always added to the list and not culled (culling is done at higher-level by ImGui:: functions), if you use this API a lot consider coarse culling your drawn objects.
    """
    cdef ccimgui.ImDrawList* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImDrawList from_ptr(ccimgui.ImDrawList* _ptr):
        if _ptr == NULL:
            return None
        cdef ImDrawList wrapper = ImDrawList.__new__(ImDrawList)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImDrawList from_heap_ptr(ccimgui.ImDrawList* _ptr):
        wrapper = ImDrawList.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(ImVector_ImVec4)
    # @property
    # def clip_rect_stack(self):
    #     """
    #     [internal]
    #     """
    #     cdef ccimgui.ImVector_ImVec4 res = dereference(self._ptr)._ClipRectStack
    #     return ImVector_ImVec4.from_ptr(res)
    # @clip_rect_stack.setter
    # def clip_rect_stack(self, value: ImVector_ImVec4):
    #     # dereference(self._ptr)._ClipRectStack = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImDrawCmd])
    @property
    def cmd_buffer(self):
        """
        This is what you have to render
        Draw commands. typically 1 command = 1 gpu draw call, unless the command is a callback.
        """
        cdef ccimgui.ImVector_ImDrawCmd* res = &dereference(self._ptr).CmdBuffer
        return [ImDrawCmd.from_ptr(&res.Data[i]) for i in range(res.Size)]
    @cmd_buffer.setter
    def cmd_buffer(self, value: ImVector_ImDrawCmd):
        # dereference(self._ptr).CmdBuffer = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(ImDrawCmdHeader)
    # @property
    # def cmd_header(self):
    #     """
    #     [internal] template of active commands. fields should match those of cmdbuffer.back().
    #     """
    #     cdef ccimgui.ImDrawCmdHeader res = dereference(self._ptr)._CmdHeader
    #     return ImDrawCmdHeader.from_ptr(res)
    # @cmd_header.setter
    # def cmd_header(self, value: ImDrawCmdHeader):
    #     # dereference(self._ptr)._CmdHeader = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(ImDrawListSharedData)
    @property
    def data(self):
        """
        Pointer to shared draw data (you can use imgui::getdrawlistshareddata() to get the one from current imgui context)
        """
        cdef ccimgui.ImDrawListSharedData* res = dereference(self._ptr)._Data
        return ImDrawListSharedData.from_ptr(res)
    @data.setter
    def data(self, value: ImDrawListSharedData):
        # dereference(self._ptr)._Data = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def flags(self):
        """
        Flags, you may poke into these to adjust anti-aliasing settings per-primitive.
        """
        cdef ccimgui.ImDrawListFlags res = dereference(self._ptr).Flags
        return res
    @flags.setter
    def flags(self, value: int):
        # dereference(self._ptr).Flags = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def fringe_scale(self):
    #     """
    #     [internal] anti-alias fringe is scaled by this value, this helps to keep things sharp while zooming at vertex buffer content
    #     """
    #     cdef float res = dereference(self._ptr)._FringeScale
    #     return res
    # @fringe_scale.setter
    # def fringe_scale(self, value: float):
    #     # dereference(self._ptr)._FringeScale = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImVector_ImDrawIdx)
    @property
    def idx_buffer(self):
        """
        Index buffer. each command consume imdrawcmd::elemcount of those
        """
        cdef ccimgui.ImVector_ImDrawIdx* res = &dereference(self._ptr).IdxBuffer
        return ImVector_ImDrawIdx.from_ptr(res)
    @idx_buffer.setter
    def idx_buffer(self, value: ImVector_ImDrawIdx):
        # dereference(self._ptr).IdxBuffer = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def idx_write_ptr(self):
    #     """
    #     [internal] point within idxbuffer.data after each add command (to avoid using the imvector<> operators too much)
    #     """
    #     cdef ccimgui.ImDrawIdx* res = dereference(self._ptr)._IdxWritePtr
    #     return res
    # @idx_write_ptr.setter
    # def idx_write_ptr(self, value: int):
    #     # dereference(self._ptr)._IdxWritePtr = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    @property
    def owner_name(self):
        """
        Pointer to owner window's name for debugging
        """
        cdef const char* res = dereference(self._ptr)._OwnerName
        return _from_bytes(res)
    @owner_name.setter
    def owner_name(self, value: str):
        # dereference(self._ptr)._OwnerName = _bytes(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(ImVector_ImVec2)
    # @property
    # def path(self):
    #     """
    #     [internal] current path building
    #     """
    #     cdef ccimgui.ImVector_ImVec2 res = dereference(self._ptr)._Path
    #     return ImVector_ImVec2.from_ptr(res)
    # @path.setter
    # def path(self, value: ImVector_ImVec2):
    #     # dereference(self._ptr)._Path = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(ImDrawListSplitter)
    # @property
    # def splitter(self):
    #     """
    #     [internal] for channels api (note: prefer using your own persistent instance of imdrawlistsplitter!)
    #     """
    #     cdef ccimgui.ImDrawListSplitter res = dereference(self._ptr)._Splitter
    #     return ImDrawListSplitter.from_ptr(res)
    # @splitter.setter
    # def splitter(self, value: ImDrawListSplitter):
    #     # dereference(self._ptr)._Splitter = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(ImVector_ImTextureID)
    # @property
    # def texture_id_stack(self):
    #     """
    #     [internal]
    #     """
    #     cdef ccimgui.ImVector_ImTextureID res = dereference(self._ptr)._TextureIdStack
    #     return ImVector_ImTextureID.from_ptr(res)
    # @texture_id_stack.setter
    # def texture_id_stack(self, value: ImVector_ImTextureID):
    #     # dereference(self._ptr)._TextureIdStack = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImDrawVert])
    @property
    def vtx_buffer(self):
        """
        Vertex buffer.
        """
        cdef ccimgui.ImVector_ImDrawVert* res = &dereference(self._ptr).VtxBuffer
        return [ImDrawVert.from_ptr(&res.Data[i]) for i in range(res.Size)]
        # return ImVector_ImDrawVert.from_ptr(res)
    @vtx_buffer.setter
    def vtx_buffer(self, value: ImVector_ImDrawVert):
        # dereference(self._ptr).VtxBuffer = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def vtx_current_idx(self):
        """
        [Internal, used while building lists]
        [internal] generally == vtxbuffer.size unless we are past 64k vertices, in which case this gets reset to 0.
        """
        cdef unsigned int res = dereference(self._ptr)._VtxCurrentIdx
        return res
    @vtx_current_idx.setter
    def vtx_current_idx(self, value: int):
        # dereference(self._ptr)._VtxCurrentIdx = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(ImDrawVert)
    # @property
    # def vtx_write_ptr(self):
    #     """
    #     [internal] point within vtxbuffer.data after each add command (to avoid using the imvector<> operators too much)
    #     """
    #     cdef ccimgui.ImDrawVert* res = dereference(self._ptr)._VtxWritePtr
    #     return ImDrawVert.from_ptr(res)
    # @vtx_write_ptr.setter
    # def vtx_write_ptr(self, value: ImDrawVert):
    #     # dereference(self._ptr)._VtxWritePtr = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_bezier_cubic(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int, thickness: float, num_segments: int=0):
        """
        Cubic bezier (4 control points)
        """
        ccimgui.ImDrawList_AddBezierCubic(
            self._ptr,
            _cast_tuple_ImVec2(p1),
            _cast_tuple_ImVec2(p2),
            _cast_tuple_ImVec2(p3),
            _cast_tuple_ImVec2(p4),
            col,
            thickness,
            num_segments
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_bezier_quadratic(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int, thickness: float, num_segments: int=0):
        """
        Quadratic bezier (3 control points)
        """
        ccimgui.ImDrawList_AddBezierQuadratic(
            self._ptr,
            _cast_tuple_ImVec2(p1),
            _cast_tuple_ImVec2(p2),
            _cast_tuple_ImVec2(p3),
            col,
            thickness,
            num_segments
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_callback(self: ImDrawList, callback: Callable, callback_data: Any):
    #     """
    #     Advanced
    #     Your rendering function must check for 'usercallback' in imdrawcmd and call the function instead of rendering triangles.
    #     """
    #     ccimgui.ImDrawList_AddCallback(
    #         self._ptr,
    #         callback,
    #         callback_data
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_circle(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int=0, thickness: float=1.0):
        ccimgui.ImDrawList_AddCircleEx(
            self._ptr,
            _cast_tuple_ImVec2(center),
            radius,
            col,
            num_segments,
            thickness
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_circle_ex(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int=0, thickness: float=1.0):
    #     ccimgui.ImDrawList_AddCircleEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(center),
    #         radius,
    #         col,
    #         num_segments,
    #         thickness
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_circle_filled(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int=0):
        ccimgui.ImDrawList_AddCircleFilled(
            self._ptr,
            _cast_tuple_ImVec2(center),
            radius,
            col,
            num_segments
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_concave_poly_filled(self: ImDrawList, points: Sequence[tuple], col: int):
        cdef ccimgui.ImVec2* c_points = <ccimgui.ImVec2*>ccimgui.ImGui_MemAlloc(len(points) * sizeof(ccimgui.ImVec2))

        for i, point in enumerate(points):
            c_points[i].x = point[0]
            c_points[i].y = point[1]
        
        ccimgui.ImDrawList_AddConcavePolyFilled(
            self._ptr,
            c_points,
            len(points),
            col
        )

        ccimgui.ImGui_MemFree(c_points)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_convex_poly_filled(self: ImDrawList, points: Sequence[tuple], col: int):
        cdef ccimgui.ImVec2* c_points = <ccimgui.ImVec2*>ccimgui.ImGui_MemAlloc(len(points) * sizeof(ccimgui.ImVec2))

        for i, point in enumerate(points):
            c_points[i].x = point[0]
            c_points[i].y = point[1]

        ccimgui.ImDrawList_AddConvexPolyFilled(
            self._ptr,
            c_points,
            len(points),
            col
        )

        ccimgui.ImGui_MemFree(c_points)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_draw_cmd(self: ImDrawList):
    #     """
    #     This is useful if you need to forcefully create a new draw call (to allow for dependent rendering / blending). otherwise primitives are merged into the same draw-call as much as possible
    #     """
    #     ccimgui.ImDrawList_AddDrawCmd(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_ellipse(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], col: int, rot: float=0.0, num_segments: int=0, thickness: float=1.0):
        ccimgui.ImDrawList_AddEllipseEx(
            self._ptr,
            _cast_tuple_ImVec2(center),
            _cast_tuple_ImVec2(radius),
            col,
            rot,
            num_segments,
            thickness
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_ellipse_ex(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], col: int, rot: float=0.0, num_segments: int=0, thickness: float=1.0):
    #     ccimgui.ImDrawList_AddEllipseEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(center),
    #         _cast_tuple_ImVec2(radius),
    #         col,
    #         rot,
    #         num_segments,
    #         thickness
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_ellipse_filled(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], col: int, rot: float=0.0, num_segments: int=0):
        ccimgui.ImDrawList_AddEllipseFilledEx(
            self._ptr,
            _cast_tuple_ImVec2(center),
            _cast_tuple_ImVec2(radius),
            col,
            rot,
            num_segments
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_ellipse_filled_ex(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], col: int, rot: float=0.0, num_segments: int=0):
    #     ccimgui.ImDrawList_AddEllipseFilledEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(center),
    #         _cast_tuple_ImVec2(radius),
    #         col,
    #         rot,
    #         num_segments
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_image(self: ImDrawList, user_texture_id: int, p_min: Tuple[float, float], p_max: Tuple[float, float], uv_min: tuple=(0, 0), uv_max: tuple=(1, 1), col: int=IM_COL32_WHITE):
        """
        Image primitives
        - Read FAQ to understand what ImTextureID is.
        - "p_min" and "p_max" represent the upper-left and lower-right corners of the rectangle.
        - "uv_min" and "uv_max" represent the normalized texture coordinates to use for those corners. Using (0,0)->(1,1) texture coordinates will generally display the entire texture.
        Implied uv_min = imvec2(0, 0), uv_max = imvec2(1, 1), col = im_col32_white
        """
        ccimgui.ImDrawList_AddImageEx(
            self._ptr,
            <ccimgui.ImTextureID><uintptr_t>user_texture_id,
            _cast_tuple_ImVec2(p_min),
            _cast_tuple_ImVec2(p_max),
            _cast_tuple_ImVec2(uv_min),
            _cast_tuple_ImVec2(uv_max),
            col
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_image_ex(self: ImDrawList, user_texture_id: Any, p_min: Tuple[float, float], p_max: Tuple[float, float], uv_min: Tuple[float, float]=(0, 0), uv_max: Tuple[float, float]=(1, 1), col: int=IM_COL32_WHITE):
    #     ccimgui.ImDrawList_AddImageEx(
    #         self._ptr,
    #         user_texture_id,
    #         _cast_tuple_ImVec2(p_min),
    #         _cast_tuple_ImVec2(p_max),
    #         _cast_tuple_ImVec2(uv_min),
    #         _cast_tuple_ImVec2(uv_max),
    #         col
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_image_quad(self: ImDrawList, user_texture_id: int, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], uv1: tuple=(0, 0), uv2: tuple=(1, 0), uv3: tuple=(1, 1), uv4: tuple=(0, 1), col: int=IM_COL32_WHITE):
        ccimgui.ImDrawList_AddImageQuadEx(
            self._ptr,
            <ccimgui.ImTextureID><uintptr_t>user_texture_id,
            _cast_tuple_ImVec2(p1),
            _cast_tuple_ImVec2(p2),
            _cast_tuple_ImVec2(p3),
            _cast_tuple_ImVec2(p4),
            _cast_tuple_ImVec2(uv1),
            _cast_tuple_ImVec2(uv2),
            _cast_tuple_ImVec2(uv3),
            _cast_tuple_ImVec2(uv4),
            col
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_image_quad_ex(self: ImDrawList, user_texture_id: Any, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], uv1: Tuple[float, float]=(0, 0), uv2: Tuple[float, float]=(1, 0), uv3: Tuple[float, float]=(1, 1), uv4: Tuple[float, float]=(0, 1), col: int=IM_COL32_WHITE):
    #     ccimgui.ImDrawList_AddImageQuadEx(
    #         self._ptr,
    #         user_texture_id,
    #         _cast_tuple_ImVec2(p1),
    #         _cast_tuple_ImVec2(p2),
    #         _cast_tuple_ImVec2(p3),
    #         _cast_tuple_ImVec2(p4),
    #         _cast_tuple_ImVec2(uv1),
    #         _cast_tuple_ImVec2(uv2),
    #         _cast_tuple_ImVec2(uv3),
    #         _cast_tuple_ImVec2(uv4),
    #         col
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_image_rounded(self: ImDrawList, user_texture_id: int, p_min: Tuple[float, float], p_max: Tuple[float, float], uv_min: Tuple[float, float], uv_max: Tuple[float, float], col: int, rounding: float, flags: int=0):
        ccimgui.ImDrawList_AddImageRounded(
            self._ptr,
            <ccimgui.ImTextureID><uintptr_t>user_texture_id,
            _cast_tuple_ImVec2(p_min),
            _cast_tuple_ImVec2(p_max),
            _cast_tuple_ImVec2(uv_min),
            _cast_tuple_ImVec2(uv_max),
            col,
            rounding,
            flags
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_line(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], col: int, thickness: float=1.0):
        """
        Primitives
        - Filled shapes must always use clockwise winding order. The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
        - For rectangular primitives, "p_min" and "p_max" represent the upper-left and lower-right corners.
        - For circle primitives, use "num_segments == 0" to automatically calculate tessellation (preferred).
        In older versions (until Dear ImGui 1.77) the AddCircle functions defaulted to num_segments == 12.
        In future versions we will use textures to provide cheaper and higher-quality circles.
        Use AddNgon() and AddNgonFilled() functions if you need to guarantee a specific number of sides.
        """
        ccimgui.ImDrawList_AddLineEx(
            self._ptr,
            _cast_tuple_ImVec2(p1),
            _cast_tuple_ImVec2(p2),
            col,
            thickness
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_line_ex(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], col: int, thickness: float=1.0):
    #     ccimgui.ImDrawList_AddLineEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(p1),
    #         _cast_tuple_ImVec2(p2),
    #         col,
    #         thickness
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_ngon(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int, thickness: float=1.0):
        ccimgui.ImDrawList_AddNgonEx(
            self._ptr,
            _cast_tuple_ImVec2(center),
            radius,
            col,
            num_segments,
            thickness
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_ngon_ex(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int, thickness: float=1.0):
    #     ccimgui.ImDrawList_AddNgonEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(center),
    #         radius,
    #         col,
    #         num_segments,
    #         thickness
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_ngon_filled(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int):
        ccimgui.ImDrawList_AddNgonFilled(
            self._ptr,
            _cast_tuple_ImVec2(center),
            radius,
            col,
            num_segments
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_polyline(self: ImDrawList, points: Sequence[tuple], col: int, flags: int, thickness: float):
        """
        General polygon
        - Only simple polygons are supported by filling functions (no self-intersections, no holes).
        - Concave polygon fill is more expensive than convex one: it has O(N^2) complexity. Provided as a convenience fo user but not used by main library.
        """
        cdef ccimgui.ImVec2* c_points = <ccimgui.ImVec2*>ccimgui.ImGui_MemAlloc(len(points) * sizeof(ccimgui.ImVec2))

        for i, point in enumerate(points):
            c_points[i].x = point[0]
            c_points[i].y = point[1]

        ccimgui.ImDrawList_AddPolyline(
            self._ptr,
            c_points,
            len(points),
            col,
            flags,
            thickness
        )

        ccimgui.ImGui_MemFree(c_points)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_quad(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int, thickness: float=1.0):
        ccimgui.ImDrawList_AddQuadEx(
            self._ptr,
            _cast_tuple_ImVec2(p1),
            _cast_tuple_ImVec2(p2),
            _cast_tuple_ImVec2(p3),
            _cast_tuple_ImVec2(p4),
            col,
            thickness
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_quad_ex(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int, thickness: float=1.0):
    #     ccimgui.ImDrawList_AddQuadEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(p1),
    #         _cast_tuple_ImVec2(p2),
    #         _cast_tuple_ImVec2(p3),
    #         _cast_tuple_ImVec2(p4),
    #         col,
    #         thickness
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_quad_filled(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int):
        ccimgui.ImDrawList_AddQuadFilled(
            self._ptr,
            _cast_tuple_ImVec2(p1),
            _cast_tuple_ImVec2(p2),
            _cast_tuple_ImVec2(p3),
            _cast_tuple_ImVec2(p4),
            col
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_rect(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col: int, rounding: float=0.0, flags: int=0, thickness: float=1.0):
        """
        A: upper-left, b: lower-right (== upper-left + size)
        """
        ccimgui.ImDrawList_AddRectEx(
            self._ptr,
            _cast_tuple_ImVec2(p_min),
            _cast_tuple_ImVec2(p_max),
            col,
            rounding,
            flags,
            thickness
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_rect_ex(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col: int, rounding: float=0.0, flags: int=0, thickness: float=1.0):
    #     """
    #     A: upper-left, b: lower-right (== upper-left + size)
    #     """
    #     ccimgui.ImDrawList_AddRectEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(p_min),
    #         _cast_tuple_ImVec2(p_max),
    #         col,
    #         rounding,
    #         flags,
    #         thickness
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_rect_filled(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col: int, rounding: float=0.0, flags: int=0):
        """
        A: upper-left, b: lower-right (== upper-left + size)
        """
        ccimgui.ImDrawList_AddRectFilledEx(
            self._ptr,
            _cast_tuple_ImVec2(p_min),
            _cast_tuple_ImVec2(p_max),
            col,
            rounding,
            flags
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_rect_filled_ex(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col: int, rounding: float=0.0, flags: int=0):
    #     """
    #     A: upper-left, b: lower-right (== upper-left + size)
    #     """
    #     ccimgui.ImDrawList_AddRectFilledEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(p_min),
    #         _cast_tuple_ImVec2(p_max),
    #         col,
    #         rounding,
    #         flags
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_rect_filled_multi_color(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col_upr_left: int, col_upr_right: int, col_bot_right: int, col_bot_left: int):
        ccimgui.ImDrawList_AddRectFilledMultiColor(
            self._ptr,
            _cast_tuple_ImVec2(p_min),
            _cast_tuple_ImVec2(p_max),
            col_upr_left,
            col_upr_right,
            col_bot_right,
            col_bot_left
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_text(self: ImDrawList, pos: Tuple[float, float], col: int, text: str):
        ccimgui.ImDrawList_AddTextEx(
            self._ptr,
            _cast_tuple_ImVec2(pos),
            col,
            _bytes(text),
            NULL
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
#     def add_text_ex(self: ImDrawList, pos: Tuple[float, float], col: int, text_begin: str, text_end: str=None):
#         bytes_text_end = _bytes(text_end) if text_end is not None else None

#         ccimgui.ImDrawList_AddTextEx(
#             self._ptr,
#             _cast_tuple_ImVec2(pos),
#             col,
#             _bytes(text_begin),
#             ((<char*>bytes_text_end if text_end is not None else NULL))
#         )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_text_im_font_ptr(self: ImDrawList, font: ImFont, font_size: float, pos: Tuple[float, float], col: int, text_begin: str):
    #     """
    #     Implied text_end = null, wrap_width = 0.0f, cpu_fine_clip_rect = null
    #     """
    #     ccimgui.ImDrawList_AddTextImFontPtr(
    #         self._ptr,
    #         font._ptr,
    #         font_size,
    #         _cast_tuple_ImVec2(pos),
    #         col,
    #         _bytes(text_begin)
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
#     def add_text_im_font_ptr_ex(self: ImDrawList, font: ImFont, font_size: float, pos: Tuple[float, float], col: int, text_begin: str, text_end: str=None, wrap_width: float=0.0, cpu_fine_clip_rect: ImVec4=None):
#         bytes_text_end = _bytes(text_end) if text_end is not None else None

#         ccimgui.ImDrawList_AddTextImFontPtrEx(
#             self._ptr,
#             font._ptr,
#             font_size,
#             _cast_tuple_ImVec2(pos),
#             col,
#             _bytes(text_begin),
#             ((<char*>bytes_text_end if text_end is not None else NULL)),
#             wrap_width,
#             <ccimgui.ImVec4*>(NULL if cpu_fine_clip_rect is None else cpu_fine_clip_rect._ptr)
#         )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_text_imfont(self: ImDrawList, font: ImFont, font_size: float, pos: tuple, col: int, text: str, wrap_width: float=0.0, cpu_fine_clip_rect: Tuple[float, float, float, float]=None):
        cdef float c_float[4]
        if cpu_fine_clip_rect is not None:
            c_float[0] = cpu_fine_clip_rect[0]
            c_float[1] = cpu_fine_clip_rect[1]
            c_float[2] = cpu_fine_clip_rect[2]
            c_float[3] = cpu_fine_clip_rect[3]
        
        ccimgui.ImDrawList_AddTextImFontPtrEx(
            self._ptr,
            font._ptr,
            font_size,
            _cast_tuple_ImVec2(pos),
            col,
            _bytes(text),
            NULL,
            wrap_width,
            <ccimgui.ImVec4*>(NULL if cpu_fine_clip_rect is None else c_float)
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_triangle(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int, thickness: float=1.0):
        ccimgui.ImDrawList_AddTriangleEx(
            self._ptr,
            _cast_tuple_ImVec2(p1),
            _cast_tuple_ImVec2(p2),
            _cast_tuple_ImVec2(p3),
            col,
            thickness
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_triangle_ex(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int, thickness: float=1.0):
    #     ccimgui.ImDrawList_AddTriangleEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(p1),
    #         _cast_tuple_ImVec2(p2),
    #         _cast_tuple_ImVec2(p3),
    #         col,
    #         thickness
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_triangle_filled(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int):
        ccimgui.ImDrawList_AddTriangleFilled(
            self._ptr,
            _cast_tuple_ImVec2(p1),
            _cast_tuple_ImVec2(p2),
            _cast_tuple_ImVec2(p3),
            col
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(int)
    # def calc_circle_auto_segment_count(self: ImDrawList, radius: float):
    #     cdef int res = ccimgui.ImDrawList__CalcCircleAutoSegmentCount(
    #         self._ptr,
    #         radius
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def channels_merge(self: ImDrawList):
        ccimgui.ImDrawList_ChannelsMerge(
            self._ptr
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def channels_set_current(self: ImDrawList, n: int):
        ccimgui.ImDrawList_ChannelsSetCurrent(
            self._ptr,
            n
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def channels_split(self: ImDrawList, count: int):
        """
        Advanced: Channels
        - Use to split render into layers. By switching channels to can render out-of-order (e.g. submit FG primitives before BG primitives)
        - Use to minimize draw calls (e.g. if going back-and-forth between multiple clipping rectangles, prefer to append into separate channels then merge at the end)
        - This API shouldn't have been in ImDrawList in the first place!
        Prefer using your own persistent instance of ImDrawListSplitter as you can stack them.
        Using the ImDrawList::ChannelsXXXX you cannot stack a split over another.
        """
        ccimgui.ImDrawList_ChannelsSplit(
            self._ptr,
            count
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear_free_memory(self: ImDrawList):
    #     ccimgui.ImDrawList__ClearFreeMemory(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImDrawList)
    # def clone_output(self: ImDrawList):
    #     """
    #     Create a clone of the cmdbuffer/idxbuffer/vtxbuffer.
    #     """
    #     cdef ccimgui.ImDrawList* res = ccimgui.ImDrawList_CloneOutput(
    #         self._ptr
    #     )
    #     return ImDrawList.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    # def get_clip_rect_max(self: ImDrawList):
    #     cdef ccimgui.ImVec2 res = ccimgui.ImDrawList_GetClipRectMax(
    #         self._ptr
    #     )
    #     return _cast_ImVec2_tuple(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    # def get_clip_rect_min(self: ImDrawList):
    #     cdef ccimgui.ImVec2 res = ccimgui.ImDrawList_GetClipRectMin(
    #         self._ptr
    #     )
    #     return _cast_ImVec2_tuple(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def on_changed_clip_rect(self: ImDrawList):
    #     ccimgui.ImDrawList__OnChangedClipRect(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def on_changed_texture_id(self: ImDrawList):
    #     ccimgui.ImDrawList__OnChangedTextureID(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def on_changed_vtx_offset(self: ImDrawList):
    #     ccimgui.ImDrawList__OnChangedVtxOffset(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_arc_to(self: ImDrawList, center: Tuple[float, float], radius: float, a_min: float, a_max: float, num_segments: int=0):
        ccimgui.ImDrawList_PathArcTo(
            self._ptr,
            _cast_tuple_ImVec2(center),
            radius,
            a_min,
            a_max,
            num_segments
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_arc_to_fast(self: ImDrawList, center: Tuple[float, float], radius: float, a_min_of_12: int, a_max_of_12: int):
        """
        Use precomputed angles for a 12 steps circle
        pygui note: The _ex version of this function is a private function in imgui.h
        This function works like a clock. But 0 and 12 is East and 6 is West.
        """
        ccimgui.ImDrawList_PathArcToFast(
            self._ptr,
            _cast_tuple_ImVec2(center),
            radius,
            a_min_of_12,
            a_max_of_12
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def path_arc_to_fast_ex(self: ImDrawList, center: Tuple[float, float], radius: float, a_min_sample: int, a_max_sample: int, a_step: int):
    #     ccimgui.ImDrawList__PathArcToFastEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(center),
    #         radius,
    #         a_min_sample,
    #         a_max_sample,
    #         a_step
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def path_arc_to_n(self: ImDrawList, center: Tuple[float, float], radius: float, a_min: float, a_max: float, num_segments: int):
    #     ccimgui.ImDrawList__PathArcToN(
    #         self._ptr,
    #         _cast_tuple_ImVec2(center),
    #         radius,
    #         a_min,
    #         a_max,
    #         num_segments
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_bezier_cubic_curve_to(self: ImDrawList, p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], num_segments: int=0):
        """
        Cubic bezier (4 control points)
        """
        ccimgui.ImDrawList_PathBezierCubicCurveTo(
            self._ptr,
            _cast_tuple_ImVec2(p2),
            _cast_tuple_ImVec2(p3),
            _cast_tuple_ImVec2(p4),
            num_segments
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_bezier_quadratic_curve_to(self: ImDrawList, p2: Tuple[float, float], p3: Tuple[float, float], num_segments: int=0):
        """
        Quadratic bezier (3 control points)
        """
        ccimgui.ImDrawList_PathBezierQuadraticCurveTo(
            self._ptr,
            _cast_tuple_ImVec2(p2),
            _cast_tuple_ImVec2(p3),
            num_segments
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_clear(self: ImDrawList):
        """
        Stateful path API, add points then finish with PathFillConvex() or PathStroke()
        - Important: filled shapes must always use clockwise winding order! The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
        so e.g. 'PathArcTo(center, radius, PI * -0.5f, PI)' is ok, whereas 'PathArcTo(center, radius, PI, PI * -0.5f)' won't have correct anti-aliasing when followed by PathFillConvex().
        """
        ccimgui.ImDrawList_PathClear(
            self._ptr
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def path_elliptical_arc_to(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], rot: float, a_min: float, a_max: float):
    #     """
    #     Implied num_segments = 0
    #     """
    #     ccimgui.ImDrawList_PathEllipticalArcTo(
    #         self._ptr,
    #         _cast_tuple_ImVec2(center),
    #         _cast_tuple_ImVec2(radius),
    #         rot,
    #         a_min,
    #         a_max
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def path_elliptical_arc_to_ex(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], rot: float, a_min: float, a_max: float, num_segments: int=0):
    #     """
    #     Ellipse
    #     """
    #     ccimgui.ImDrawList_PathEllipticalArcToEx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(center),
    #         _cast_tuple_ImVec2(radius),
    #         rot,
    #         a_min,
    #         a_max,
    #         num_segments
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def path_fill_concave(self: ImDrawList, col: int):
    #     ccimgui.ImDrawList_PathFillConcave(
    #         self._ptr,
    #         col
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_fill_convex(self: ImDrawList, col: int):
        ccimgui.ImDrawList_PathFillConvex(
            self._ptr,
            col
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_line_to(self: ImDrawList, pos: Tuple[float, float]):
        ccimgui.ImDrawList_PathLineTo(
            self._ptr,
            _cast_tuple_ImVec2(pos)
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_line_to_merge_duplicate(self: ImDrawList, pos: Tuple[float, float]):
        ccimgui.ImDrawList_PathLineToMergeDuplicate(
            self._ptr,
            _cast_tuple_ImVec2(pos)
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_rect(self: ImDrawList, rect_min: Tuple[float, float], rect_max: Tuple[float, float], rounding: float=0.0, flags: int=0):
        ccimgui.ImDrawList_PathRect(
            self._ptr,
            _cast_tuple_ImVec2(rect_min),
            _cast_tuple_ImVec2(rect_max),
            rounding,
            flags
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def path_stroke(self: ImDrawList, col: int, flags: int=0, thickness: float=1.0):
        ccimgui.ImDrawList_PathStroke(
            self._ptr,
            col,
            flags,
            thickness
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def pop_clip_rect(self: ImDrawList):
        ccimgui.ImDrawList_PopClipRect(
            self._ptr
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def pop_texture_id(self: ImDrawList):
    #     ccimgui.ImDrawList_PopTextureID(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def pop_unused_draw_cmd(self: ImDrawList):
    #     ccimgui.ImDrawList__PopUnusedDrawCmd(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def prim_quad_uv(self: ImDrawList, a: Tuple[float, float], b: Tuple[float, float], c: Tuple[float, float], d: Tuple[float, float], uv_a: Tuple[float, float], uv_b: Tuple[float, float], uv_c: Tuple[float, float], uv_d: Tuple[float, float], col: int):
    #     ccimgui.ImDrawList_PrimQuadUV(
    #         self._ptr,
    #         _cast_tuple_ImVec2(a),
    #         _cast_tuple_ImVec2(b),
    #         _cast_tuple_ImVec2(c),
    #         _cast_tuple_ImVec2(d),
    #         _cast_tuple_ImVec2(uv_a),
    #         _cast_tuple_ImVec2(uv_b),
    #         _cast_tuple_ImVec2(uv_c),
    #         _cast_tuple_ImVec2(uv_d),
    #         col
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def prim_rect(self: ImDrawList, a: Tuple[float, float], b: Tuple[float, float], col: int):
    #     """
    #     Axis aligned rectangle (composed of two triangles)
    #     """
    #     ccimgui.ImDrawList_PrimRect(
    #         self._ptr,
    #         _cast_tuple_ImVec2(a),
    #         _cast_tuple_ImVec2(b),
    #         col
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def prim_rect_uv(self: ImDrawList, a: Tuple[float, float], b: Tuple[float, float], uv_a: Tuple[float, float], uv_b: Tuple[float, float], col: int):
    #     ccimgui.ImDrawList_PrimRectUV(
    #         self._ptr,
    #         _cast_tuple_ImVec2(a),
    #         _cast_tuple_ImVec2(b),
    #         _cast_tuple_ImVec2(uv_a),
    #         _cast_tuple_ImVec2(uv_b),
    #         col
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def prim_reserve(self: ImDrawList, idx_count: int, vtx_count: int):
    #     """
    #     Advanced: Primitives allocations
    #     - We render triangles (three vertices)
    #     - All primitives needs to be reserved via PrimReserve() beforehand.
    #     """
    #     ccimgui.ImDrawList_PrimReserve(
    #         self._ptr,
    #         idx_count,
    #         vtx_count
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def prim_unreserve(self: ImDrawList, idx_count: int, vtx_count: int):
    #     ccimgui.ImDrawList_PrimUnreserve(
    #         self._ptr,
    #         idx_count,
    #         vtx_count
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def prim_vtx(self: ImDrawList, pos: Tuple[float, float], uv: Tuple[float, float], col: int):
    #     """
    #     Write vertex with unique index
    #     """
    #     ccimgui.ImDrawList_PrimVtx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(pos),
    #         _cast_tuple_ImVec2(uv),
    #         col
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def prim_write_idx(self: ImDrawList, idx: int):
    #     ccimgui.ImDrawList_PrimWriteIdx(
    #         self._ptr,
    #         idx
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def prim_write_vtx(self: ImDrawList, pos: Tuple[float, float], uv: Tuple[float, float], col: int):
    #     ccimgui.ImDrawList_PrimWriteVtx(
    #         self._ptr,
    #         _cast_tuple_ImVec2(pos),
    #         _cast_tuple_ImVec2(uv),
    #         col
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def push_clip_rect(self: ImDrawList, clip_rect_min: Tuple[float, float], clip_rect_max: Tuple[float, float], intersect_with_current_clip_rect: bool=False):
        """
        Render-level scissoring. this is passed down to your render function but not used for cpu-side coarse clipping. prefer using higher-level imgui::pushcliprect() to affect logic (hit-testing and widget culling)
        """
        ccimgui.ImDrawList_PushClipRect(
            self._ptr,
            _cast_tuple_ImVec2(clip_rect_min),
            _cast_tuple_ImVec2(clip_rect_max),
            intersect_with_current_clip_rect
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def push_clip_rect_full_screen(self: ImDrawList):
    #     ccimgui.ImDrawList_PushClipRectFullScreen(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def push_texture_id(self: ImDrawList, texture_id: Any):
    #     ccimgui.ImDrawList_PushTextureID(
    #         self._ptr,
    #         texture_id
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def reset_for_new_frame(self: ImDrawList):
    #     """
    #     [Internal helpers]
    #     """
    #     ccimgui.ImDrawList__ResetForNewFrame(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def try_merge_draw_cmds(self: ImDrawList):
    #     ccimgui.ImDrawList__TryMergeDrawCmds(
    #         self._ptr
    #     )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImDrawListSharedData:
    """
    Data shared among multiple draw lists (typically owned by parent imgui context, but you may create one yourself)
    """
    cdef ccimgui.ImDrawListSharedData* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImDrawListSharedData from_ptr(ccimgui.ImDrawListSharedData* _ptr):
        if _ptr == NULL:
            return None
        cdef ImDrawListSharedData wrapper = ImDrawListSharedData.__new__(ImDrawListSharedData)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImDrawListSharedData from_heap_ptr(ccimgui.ImDrawListSharedData* _ptr):
        wrapper = ImDrawListSharedData.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(True)
cdef class ImDrawListSplitter:
    """
    Split/Merge functions are used to split the draw list into different layers which can be drawn into out of order.
    This is used by the Columns/Tables API, so items of each column can be batched together in a same draw call.
    pygui note: This class is instantiable with ImGuiListClipper.create()
    """
    cdef ccimgui.ImDrawListSplitter* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImDrawListSplitter from_ptr(ccimgui.ImDrawListSplitter* _ptr):
        if _ptr == NULL:
            return None
        cdef ImDrawListSplitter wrapper = ImDrawListSplitter.__new__(ImDrawListSplitter)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImDrawListSplitter from_heap_ptr(ccimgui.ImDrawListSplitter* _ptr):
        wrapper = ImDrawListSplitter.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(ImVector_ImDrawChannel)
    # @property
    # def channels(self):
    #     """
    #     Draw channels (not resized down so _count might be < channels.size)
    #     """
    #     cdef ccimgui.ImVector_ImDrawChannel res = dereference(self._ptr)._Channels
    #     return ImVector_ImDrawChannel.from_ptr(res)
    # @channels.setter
    # def channels(self, value: ImVector_ImDrawChannel):
    #     # dereference(self._ptr)._Channels = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def count(self):
    #     """
    #     Number of active channels (1+)
    #     """
    #     cdef int res = dereference(self._ptr)._Count
    #     return res
    # @count.setter
    # def count(self, value: int):
    #     # dereference(self._ptr)._Count = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def current(self):
    #     """
    #     Current channel number (0)
    #     """
    #     cdef int res = dereference(self._ptr)._Current
    #     return res
    # @current.setter
    # def current(self, value: int):
    #     # dereference(self._ptr)._Current = value
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear(self: ImDrawListSplitter):
    #     """
    #     Do not clear channels[] so our allocations are reused next frame
    #     """
    #     ccimgui.ImDrawListSplitter_Clear(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear_free_memory(self: ImDrawListSplitter):
    #     ccimgui.ImDrawListSplitter_ClearFreeMemory(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(ImDrawListSplitter)
    @staticmethod
    def create():
        """
        Create a dynamically allocated instance of ImDrawListSplitter. Must
        also be freed with destroy().
        """
        cdef ccimgui.ImDrawListSplitter* spliter = <ccimgui.ImDrawListSplitter*>ccimgui.ImGui_MemAlloc(sizeof(ccimgui.ImDrawListSplitter))
        memset(spliter, 0, sizeof(ccimgui.ImDrawListSplitter))
        return ImDrawListSplitter.from_heap_ptr(spliter)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(None)
    def destroy(self: ImDrawListSplitter):
        """
        Mimics the destructor of ccimgui.ImDrawListSplitter
        """
        if self._ptr != NULL:
            ccimgui.ImDrawListSplitter_ClearFreeMemory(self._ptr)
            ccimgui.ImGui_MemFree(self._ptr)
            self._ptr = NULL
    def __dealloc__(self):
        """
        Just in case the user forgets to free the memory.
        """
        if not self.dynamically_allocated:
            return
        
        self.destroy()
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def merge(self: ImDrawListSplitter, draw_list: ImDrawList):
        ccimgui.ImDrawListSplitter_Merge(
            self._ptr,
            draw_list._ptr
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def set_current_channel(self: ImDrawListSplitter, draw_list: ImDrawList, channel_idx: int):
        ccimgui.ImDrawListSplitter_SetCurrentChannel(
            self._ptr,
            draw_list._ptr,
            channel_idx
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def split(self: ImDrawListSplitter, draw_list: ImDrawList, count: int):
        ccimgui.ImDrawListSplitter_Split(
            self._ptr,
            draw_list._ptr,
            count
        )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImDrawVert:
    cdef ccimgui.ImDrawVert* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImDrawVert from_ptr(ccimgui.ImDrawVert* _ptr):
        if _ptr == NULL:
            return None
        cdef ImDrawVert wrapper = ImDrawVert.__new__(ImDrawVert)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImDrawVert from_heap_ptr(ccimgui.ImDrawVert* _ptr):
        wrapper = ImDrawVert.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def col(self):
        cdef ccimgui.ImU32 res = dereference(self._ptr).col
        return res
    @col.setter
    def col(self, value: int):
        # dereference(self._ptr).col = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def pos(self):
        cdef ccimgui.ImVec2 res = dereference(self._ptr).pos
        return _cast_ImVec2_tuple(res)
    @pos.setter
    def pos(self, value: Tuple[float, float]):
        # dereference(self._ptr).pos = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def uv(self):
        cdef ccimgui.ImVec2 res = dereference(self._ptr).uv
        return _cast_ImVec2_tuple(res)
    @uv.setter
    def uv(self, value: Tuple[float, float]):
        # dereference(self._ptr).uv = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImFont:
    """
    Font runtime data and rendering
    ImFontAtlas automatically loads a default embedded font for you when you call GetTexDataAsAlpha8() or GetTexDataAsRGBA32().
    """
    cdef ccimgui.ImFont* _ptr
    cdef bool dynamically_allocated
    cdef const ccimgui.ImFont* _const_ptr

    @staticmethod
    cdef ImFont from_ptr(ccimgui.ImFont* _ptr):
        if _ptr == NULL:
            return None
        cdef ImFont wrapper = ImFont.__new__(ImFont)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        wrapper._const_ptr = NULL
        return wrapper
    
    @staticmethod
    cdef ImFont from_const_ptr(const ccimgui.ImFont* _ptr):
        if _ptr == NULL:
            return None
        cdef ImFont wrapper = ImFont.__new__(ImFont)
        wrapper._ptr = NULL
        wrapper._const_ptr = _ptr
        return wrapper
    
    @staticmethod
    cdef ImFont from_heap_ptr(ccimgui.ImFont* _ptr):
        wrapper = ImFont.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr != NULL:
            return hash(<uintptr_t>self._ptr)
        if self._const_ptr != NULL:
            return hash(<uintptr_t>self._const_ptr)
        raise RuntimeError("Won't hash a NULL pointer")
    # [End Class Constants]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def ascent(self):
        """
        4+4   // out //// ascent: distance from top to bottom of e.g. 'a' [0..fontsize]
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).Ascent
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).Ascent
        return res
    @ascent.setter
    def ascent(self, value: float):
        # dereference(self._ptr).Ascent = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontConfig)
    @property
    def config_data(self):
        """
        4-8   // in  //// pointer within containeratlas->configdata
        pygui note: Returns a const ImFontConfig. Fields should only be read,
        not modified.
        """
        cdef const ccimgui.ImFontConfig* res
        if self._ptr != NULL:
            res = dereference(self._ptr).ConfigData
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).ConfigData
        
        return ImFontConfig.from_const_ptr(res)
    @config_data.setter
    def config_data(self, value: ImFontConfig):
        # dereference(self._ptr).ConfigData = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def config_data_count(self):
        """
        2 // in  // ~ 1// number of imfontconfig involved in creating this font. bigger than 1 when merging multiple font sources into one imfont.
        """
        cdef short res
        if self._ptr != NULL:
            res = dereference(self._ptr).ConfigDataCount
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).ConfigDataCount
        
        return res
    @config_data_count.setter
    def config_data_count(self, value: int):
        # dereference(self._ptr).ConfigDataCount = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontAtlas)
    @property
    def container_atlas(self):
        """
        Members: Cold ~32/40 bytes
        4-8   // out //// what we has been loaded into
        """
        cdef ccimgui.ImFontAtlas* res
        if self._ptr != NULL:
            res = dereference(self._ptr).ContainerAtlas
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).ContainerAtlas
        
        return ImFontAtlas.from_ptr(res)
    @container_atlas.setter
    def container_atlas(self, value: ImFontAtlas):
        # dereference(self._ptr).ContainerAtlas = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def descent(self):
        """
        4+4   // out //// ascent: distance from top to bottom of e.g. 'a' [0..fontsize]
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).Descent
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).Descent
        return res
    @descent.setter
    def descent(self, value: float):
        # dereference(self._ptr).Descent = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def dirty_lookup_tables(self):
        """
        1 // out //
        """
        cdef bool res
        if self._ptr != NULL:
            res = dereference(self._ptr).DirtyLookupTables
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).DirtyLookupTables
        return res
    @dirty_lookup_tables.setter
    def dirty_lookup_tables(self, value: bool):
        # dereference(self._ptr).DirtyLookupTables = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def ellipsis_char(self):
        """
        2 // out // = '...'/'.'// character used for ellipsis rendering.
        """
        cdef ccimgui.ImWchar res
        if self._ptr != NULL:
            res = dereference(self._ptr).EllipsisChar
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).EllipsisChar
        return res
    @ellipsis_char.setter
    def ellipsis_char(self, value: int):
        # dereference(self._ptr).EllipsisChar = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def ellipsis_char_count(self):
        """
        1 // out // 1 or 3
        """
        cdef short res
        if self._ptr != NULL:
            res = dereference(self._ptr).EllipsisCharCount
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).EllipsisCharCount
        return res
    @ellipsis_char_count.setter
    def ellipsis_char_count(self, value: int):
        # dereference(self._ptr).EllipsisCharCount = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def ellipsis_char_step(self):
        """
        4 // out   // step between characters when ellipsiscount > 0
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).EllipsisCharStep
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).EllipsisCharStep
        return res
    @ellipsis_char_step.setter
    def ellipsis_char_step(self, value: float):
        # dereference(self._ptr).EllipsisCharStep = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def ellipsis_width(self):
        """
        4 // out   // width
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).EllipsisWidth
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).EllipsisWidth
        return res
    @ellipsis_width.setter
    def ellipsis_width(self, value: float):
        # dereference(self._ptr).EllipsisWidth = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def fallback_advance_x(self):
        """
        4 // out // = fallbackglyph->advancex
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).FallbackAdvanceX
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).FallbackAdvanceX
        return res
    @fallback_advance_x.setter
    def fallback_advance_x(self, value: float):
        # dereference(self._ptr).FallbackAdvanceX = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def fallback_char(self):
        """
        2 // out // = fffd/'?' // character used if a glyph isn't found.
        """
        cdef ccimgui.ImWchar res
        if self._ptr != NULL:
            res = dereference(self._ptr).FallbackChar
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).FallbackChar
        return res
    @fallback_char.setter
    def fallback_char(self, value: int):
        # dereference(self._ptr).FallbackChar = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontGlyph)
    @property
    def fallback_glyph(self):
        """
        4-8   // out // = findglyph(fontfallbackchar)
        """
        cdef const ccimgui.ImFontGlyph* res
        if self._ptr != NULL:
            res = dereference(self._ptr).FallbackGlyph
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).FallbackGlyph
        return ImFontGlyph.from_ptr(res)
    @fallback_glyph.setter
    def fallback_glyph(self, value: ImFontGlyph):
        # dereference(self._ptr).FallbackGlyph = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def font_size(self):
        """
        4 // in  //// height of characters/line, set during loading (don't change after loading)
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).FontSize
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).FontSize
        return res
    @font_size.setter
    def font_size(self, value: float):
        # dereference(self._ptr).FontSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImFontGlyph])
    @property
    def glyphs(self):
        """
        12-16 // out //// all glyphs.
        """
        cdef const ccimgui.ImVector_ImFontGlyph* res = &dereference(self._ptr).Glyphs
        return [ImFontGlyph.from_ptr(&res.Data[i]) for i in range(res.Size)]
        # return ImVector_ImFontGlyph.from_ptr(res)
    @glyphs.setter
    def glyphs(self, value: ImVector_ImFontGlyph):
        # dereference(self._ptr).Glyphs = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[float])
    @property
    def index_advance_x(self):
        """
        Members: Hot ~20/24 bytes (for CalcTextSize)
        12-16 // out //// sparse. glyphs->advancex in a directly indexable way (cache-friendly for calctextsize functions which only this this info, and are often bottleneck in large ui).
        """
        cdef const ccimgui.ImVector_float* res = &dereference(self._ptr).IndexAdvanceX
        return [res.Data[i] for i in range(res.Size)]
        # return ImVector_float.from_ptr(res)
    @index_advance_x.setter
    def index_advance_x(self, value: ImVector_float):
        # dereference(self._ptr).IndexAdvanceX = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[int])
    @property
    def index_lookup(self):
        """
        Members: Hot ~28/40 bytes (for CalcTextSize + render loop)
        12-16 // out //// sparse. index glyphs by unicode code-point.
        """
        cdef const ccimgui.ImVector_ImWchar* res = &dereference(self._ptr).IndexLookup
        return [res.Data[i] for i in range(res.Size)]
        # return ImVector_ImWchar.from_ptr(res)
    @index_lookup.setter
    def index_lookup(self, value: ImVector_ImWchar):
        # dereference(self._ptr).IndexLookup = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def metrics_total_surface(self):
        """
        4 // out //// total surface in pixels to get an idea of the font rasterization/texture cost (not exact, we approximate the cost of padding between glyphs)
        """
        cdef int res
        if self._ptr != NULL:
            res = dereference(self._ptr).MetricsTotalSurface
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).MetricsTotalSurface
        return res
    @metrics_total_surface.setter
    def metrics_total_surface(self, value: int):
        # dereference(self._ptr).MetricsTotalSurface = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def scale(self):
        """
        4 // in  // = 1.f  // base font scale, multiplied by the per-window font scale which you can adjust with setwindowfontscale()
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).Scale
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).Scale
        return res
    @scale.setter
    def scale(self, value: float):
        # dereference(self._ptr).Scale = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bytes)
    @property
    def used4k_pages_map(self):
        """
        2 bytes if imwchar=imwchar16, 34 bytes if imwchar==imwchar32. store 1-bit for each block of 4k codepoints that has one active glyph. this is mainly used to facilitate iterations across all used codepoints.
        """
        cdef unsigned char* res
        if self._ptr != NULL:
            res = <ccimgui.ImU8*>dereference(self._ptr).Used4kPagesMap
        if self._const_ptr != NULL:
            res = <ccimgui.ImU8*>dereference(self._const_ptr).Used4kPagesMap
        return bytes(res)
    @used4k_pages_map.setter
    def used4k_pages_map(self, value: int):
        # dereference(self._ptr).Used4kPagesMap = value
        raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_glyph(self: ImFont, src_cfg: ImFontConfig, c: int, x0: float, y0: float, x1: float, y1: float, u0: float, v0: float, u1: float, v1: float, advance_x: float):
    #     ccimgui.ImFont_AddGlyph(
    #         self._ptr,
    #         src_cfg._ptr,
    #         c,
    #         x0,
    #         y0,
    #         x1,
    #         y1,
    #         u0,
    #         v0,
    #         u1,
    #         v1,
    #         advance_x
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_remap_char(self: ImFont, dst: int, src: int, overwrite_dst: bool=True):
    #     """
    #     Makes 'dst' character/glyph points to 'src' character/glyph. currently needs to be called after fonts have been built.
    #     """
    #     ccimgui.ImFont_AddRemapChar(
    #         self._ptr,
    #         dst,
    #         src,
    #         overwrite_dst
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def build_lookup_table(self: ImFont):
    #     """
    #     [Internal] Don't use!
    #     """
    #     ccimgui.ImFont_BuildLookupTable(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    # def calc_text_size_a(self: ImFont, size: float, max_width: float, wrap_width: float, text_begin: str):
    #     """
    #     'max_width' stops rendering after a certain width (could be turned into a 2d size). FLT_MAX to disable.
    #     'wrap_width' enable automatic word-wrapping across multiple lines to fit into given width. 0.0f to disable.
    #     Implied text_end = null, remaining = null
    #     """
    #     cdef ccimgui.ImVec2 res = ccimgui.ImFont_CalcTextSizeA(
    #         self._ptr,
    #         size,
    #         max_width,
    #         wrap_width,
    #         _bytes(text_begin)
    #     )
    #     return _cast_ImVec2_tuple(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
#     def calc_text_size_a_ex(self: ImFont, size: float, max_width: float, wrap_width: float, text_begin: str, text_end: str=None, remaining: Any=None):
#         """
#         Utf8
#         """
#         bytes_text_end = _bytes(text_end) if text_end is not None else None

#         cdef ccimgui.ImVec2 res = ccimgui.ImFont_CalcTextSizeAEx(
#             self._ptr,
#             size,
#             max_width,
#             wrap_width,
#             _bytes(text_begin),
#             ((<char*>bytes_text_end if text_end is not None else NULL)),
#             remaining
#         )
#         return _cast_ImVec2_tuple(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    # def calc_word_wrap_position_a(self: ImFont, scale: float, text: str, text_end: str, wrap_width: float):
    #     cdef const char* res = ccimgui.ImFont_CalcWordWrapPositionA(
    #         self._ptr,
    #         scale,
    #         _bytes(text),
    #         _bytes(text_end),
    #         wrap_width
    #     )
    #     return _from_bytes(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear_output_data(self: ImFont):
    #     ccimgui.ImFont_ClearOutputData(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontGlyph)
    # def find_glyph(self: ImFont, c: int):
    #     cdef ccimgui.ImFontGlyph* res = ccimgui.ImFont_FindGlyph(
    #         self._ptr,
    #         c
    #     )
    #     return ImFontGlyph.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontGlyph)
    # def find_glyph_no_fallback(self: ImFont, c: int):
    #     cdef ccimgui.ImFontGlyph* res = ccimgui.ImFont_FindGlyphNoFallback(
    #         self._ptr,
    #         c
    #     )
    #     return ImFontGlyph.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(float)
    # def get_char_advance(self: ImFont, c: int):
    #     cdef float res = ccimgui.ImFont_GetCharAdvance(
    #         self._ptr,
    #         c
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    def get_debug_name(self: ImFont):
        if self._const_ptr != NULL:
            raise NotImplementedError
        
        cdef const char* res = ccimgui.ImFont_GetDebugName(
            self._ptr,
        )
        return _from_bytes(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def grow_index(self: ImFont, new_size: int):
    #     ccimgui.ImFont_GrowIndex(
    #         self._ptr,
    #         new_size
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def is_glyph_range_unused(self: ImFont, c_begin: int, c_last: int):
    #     cdef bool res = ccimgui.ImFont_IsGlyphRangeUnused(
    #         self._ptr,
    #         c_begin,
    #         c_last
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def is_loaded(self: ImFont):
    #     cdef bool res = ccimgui.ImFont_IsLoaded(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def render_char(self: ImFont, draw_list: ImDrawList, size: float, pos: Tuple[float, float], col: int, c: int):
    #     ccimgui.ImFont_RenderChar(
    #         self._ptr,
    #         draw_list._ptr,
    #         size,
    #         _cast_tuple_ImVec2(pos),
    #         col,
    #         c
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def render_text(self: ImFont, draw_list: ImDrawList, size: float, pos: Tuple[float, float], col: int, clip_rect: Tuple[float, float, float, float], text_begin: str, text_end: str, wrap_width: float=0.0, cpu_fine_clip: bool=False):
    #     ccimgui.ImFont_RenderText(
    #         self._ptr,
    #         draw_list._ptr,
    #         size,
    #         _cast_tuple_ImVec2(pos),
    #         col,
    #         _cast_tuple_ImVec4(clip_rect),
    #         _bytes(text_begin),
    #         _bytes(text_end),
    #         wrap_width,
    #         cpu_fine_clip
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_glyph_visible(self: ImFont, c: int, visible: bool):
    #     ccimgui.ImFont_SetGlyphVisible(
    #         self._ptr,
    #         c,
    #         visible
    #     )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImFontAtlas:
    """
    Load and rasterize multiple TTF/OTF fonts into a same texture. The font atlas will build a single texture holding:
    - One or more fonts.
    - Custom graphics data needed to render the shapes needed by Dear ImGui.
    - Mouse cursor shapes for software cursor rendering (unless setting 'Flags |= ImFontAtlasFlags_NoMouseCursors' in the font atlas).
    It is the user-code responsibility to setup/build the atlas, then upload the pixel data into a texture accessible by your graphics api.
    - Optionally, call any of the AddFont*** functions. If you don't call any, the default font embedded in the code will be loaded for you.
    - Call GetTexDataAsAlpha8() or GetTexDataAsRGBA32() to build and retrieve pixels data.
    - Upload the pixels data into a texture within your graphics system (see imgui_impl_xxxx.cpp examples)
    - Call SetTexID(my_tex_id); and pass the pointer/identifier to your texture in a format natural to your graphics API.
    This value will be passed back to you during rendering to identify the texture. Read FAQ entry about ImTextureID for more details.
    Common pitfalls:
    - If you pass a 'glyph_ranges' array to AddFont*** functions, you need to make sure that your array persist up until the
    atlas is build (when calling GetTexData*** or Build()). We only copy the pointer, not the data.
    - Important: By default, AddFontFromMemoryTTF() takes ownership of the data. Even though we are not writing to it, we will free the pointer on destruction.
    You can set font_cfg->FontDataOwnedByAtlas=false to keep ownership of your data and it won't be freed,
    - Even though many functions are suffixed with "TTF", OTF data is supported just as well.
    - This is an old API and it is currently awkward for those and various other reasons! We will address them in the future!
    """
    cdef ccimgui.ImFontAtlas* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImFontAtlas from_ptr(ccimgui.ImFontAtlas* _ptr):
        if _ptr == NULL:
            return None
        cdef ImFontAtlas wrapper = ImFontAtlas.__new__(ImFontAtlas)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImFontAtlas from_heap_ptr(ccimgui.ImFontAtlas* _ptr):
        wrapper = ImFontAtlas.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImFontConfig])
    @property
    def config_data(self):
        """
        Configuration data
        """
        cdef ccimgui.ImVector_ImFontConfig* res = &dereference(self._ptr).ConfigData
        return [ImFontConfig.from_ptr(&res.Data[i]) for i in range(res.Size)]
        # return ImVector_ImFontConfig.from_ptr(res)
    @config_data.setter
    def config_data(self, value: ImVector_ImFontConfig):
        # dereference(self._ptr).ConfigData = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImFontAtlasCustomRect])
    @property
    def custom_rects(self):
        """
        Rectangles for packing custom texture data into the atlas.
        """
        cdef ccimgui.ImVector_ImFontAtlasCustomRect* res = &dereference(self._ptr).CustomRects
        return [ImFontAtlasCustomRect.from_ptr(&res.Data[i]) for i in range(res.Size)]
        # return ImVector_ImFontAtlasCustomRect.from_ptr(res)
    @custom_rects.setter
    def custom_rects(self, value: ImVector_ImFontAtlasCustomRect):
        # dereference(self._ptr).CustomRects = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def flags(self):
        """
        Build flags (see imfontatlasflags_)
        """
        cdef ccimgui.ImFontAtlasFlags res = dereference(self._ptr).Flags
        return res
    @flags.setter
    def flags(self, value: int):
        # dereference(self._ptr).Flags = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def font_builder_flags(self):
        """
        Shared flags (for all fonts) for custom font builder. this is build implementation dependent. per-font override is also available in imfontconfig.
        """
        cdef unsigned int res = dereference(self._ptr).FontBuilderFlags
        return res
    @font_builder_flags.setter
    def font_builder_flags(self, value: int):
        # dereference(self._ptr).FontBuilderFlags = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontBuilderIO)
    @property
    def font_builder_io(self):
        """
        [Internal] Font builder
        Opaque interface to a font builder (default to stb_truetype, can be changed to use freetype by defining imgui_enable_freetype).
        """
        cdef const ccimgui.ImFontBuilderIO* res = dereference(self._ptr).FontBuilderIO
        return ImFontBuilderIO.from_ptr(res)
    @font_builder_io.setter
    def font_builder_io(self, value: ImFontBuilderIO):
        # dereference(self._ptr).FontBuilderIO = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImFont])
    @property
    def fonts(self):
        """
        Hold all the fonts returned by addfont*. fonts[0] is the default font upon calling imgui::newframe(), use imgui::pushfont()/popfont() to change the current font.
        """
        cdef ccimgui.ImVector_ImFontPtr* res = &dereference(self._ptr).Fonts
        return [ImFont.from_ptr(res.Data[i]) for i in range(res.Size)]
        # return ImVector_ImFontPtr.from_ptr(res)
    @fonts.setter
    def fonts(self, value: ImVector_ImFontPtr):
        # dereference(self._ptr).Fonts = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def locked(self):
        """
        Marked as locked by imgui::newframe() so attempt to modify the atlas will assert.
        """
        cdef bool res = dereference(self._ptr).Locked
        return res
    @locked.setter
    def locked(self, value: bool):
        # dereference(self._ptr).Locked = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def pack_id_lines(self):
        """
        Custom texture rectangle id for baked anti-aliased lines
        """
        cdef int res = dereference(self._ptr).PackIdLines
        return res
    @pack_id_lines.setter
    def pack_id_lines(self, value: int):
        # dereference(self._ptr).PackIdLines = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def pack_id_mouse_cursors(self):
        """
        [Internal] Packing data
        Custom texture rectangle id for white pixel and mouse cursors
        """
        cdef int res = dereference(self._ptr).PackIdMouseCursors
        return res
    @pack_id_mouse_cursors.setter
    def pack_id_mouse_cursors(self, value: int):
        # dereference(self._ptr).PackIdMouseCursors = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def tex_desired_width(self):
        """
        Texture width desired by user before build(). must be a power-of-two. if have many glyphs your graphics api have texture size restrictions you may want to increase texture width to decrease height.
        """
        cdef int res = dereference(self._ptr).TexDesiredWidth
        return res
    @tex_desired_width.setter
    def tex_desired_width(self, value: int):
        # dereference(self._ptr).TexDesiredWidth = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def tex_glyph_padding(self):
        """
        Padding between glyphs within texture in pixels. defaults to 1. if your rendering method doesn't rely on bilinear filtering you may set this to 0 (will also need to set antialiasedlinesusetex = false).
        """
        cdef int res = dereference(self._ptr).TexGlyphPadding
        return res
    @tex_glyph_padding.setter
    def tex_glyph_padding(self, value: int):
        # dereference(self._ptr).TexGlyphPadding = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def tex_height(self):
        """
        Texture height calculated during build().
        """
        cdef int res = dereference(self._ptr).TexHeight
        return res
    @tex_height.setter
    def tex_height(self, value: int):
        # dereference(self._ptr).TexHeight = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def tex_id(self):
        """
        User data to refer to the texture once it has been uploaded to user's graphic systems. it is passed back to you during rendering via the imdrawcmd structure.
        """
        cdef unsigned int res = <uintptr_t>dereference(self._ptr).TexID
        return res
    @tex_id.setter
    def tex_id(self, value: int):
        dereference(self._ptr).TexID = <void*>value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bytes)
    @property
    def tex_pixels_alpha8(self):
        """
        1 component per pixel, each component is unsigned 8-bit. total size = texwidth * texheight
        """
        cdef unsigned char* res = dereference(self._ptr).TexPixelsAlpha8
        return bytes(res[:self.tex_width * self.tex_height])
    @tex_pixels_alpha8.setter
    def tex_pixels_alpha8(self, value: str):
        # dereference(self._ptr).TexPixelsAlpha8 = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bytes)
    @property
    def tex_pixels_rgba_32(self):
        """
        4 component per pixel, each component is unsigned 8-bit. total size = texwidth * texheight * 4
        """
        cdef unsigned char* res = <unsigned char*>dereference(self._ptr).TexPixelsRGBA32
        return bytes(res[:self.tex_width * self.tex_height * 4])
    @tex_pixels_rgba_32.setter
    def tex_pixels_rgba_32(self, value: Int):
        # dereference(self._ptr).TexPixelsRGBA32 = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def tex_pixels_use_colors(self):
        """
        Tell whether our texture data is known to use colors (rather than just alpha channel), in order to help backend select a format.
        """
        cdef bool res = dereference(self._ptr).TexPixelsUseColors
        return res
    @tex_pixels_use_colors.setter
    def tex_pixels_use_colors(self, value: bool):
        # dereference(self._ptr).TexPixelsUseColors = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def tex_ready(self):
        """
        [Internal]
        NB: Access texture data via GetTexData*() calls! Which will setup a default font for you.
        Set when texture was built matching current font input
        """
        cdef bool res = dereference(self._ptr).TexReady
        return res
    @tex_ready.setter
    def tex_ready(self, value: bool):
        # dereference(self._ptr).TexReady = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Vec4)
    @property
    def tex_uv_lines(self):
        """
        Uvs for baked anti-aliased lines
        """
        cdef ccimgui.ImVec4* res = dereference(self._ptr).TexUvLines
        cdef Vec4 vec = Vec4.zero()
        vec.from_array(&res.x)
        return vec
    @tex_uv_lines.setter
    def tex_uv_lines(self, value: ImVec4):
        # dereference(self._ptr).TexUvLines = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def tex_uv_scale(self):
        """
        = (1.0f/texwidth, 1.0f/texheight)
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).TexUvScale
        return _cast_ImVec2_tuple(res)
    @tex_uv_scale.setter
    def tex_uv_scale(self, value: Tuple[float, float]):
        # dereference(self._ptr).TexUvScale = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def tex_uv_white_pixel(self):
        """
        Texture coordinates to a white pixel
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).TexUvWhitePixel
        return _cast_ImVec2_tuple(res)
    @tex_uv_white_pixel.setter
    def tex_uv_white_pixel(self, value: Tuple[float, float]):
        # dereference(self._ptr).TexUvWhitePixel = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def tex_width(self):
        """
        Texture width calculated during build().
        """
        cdef int res = dereference(self._ptr).TexWidth
        return res
    @tex_width.setter
    def tex_width(self, value: int):
        # dereference(self._ptr).TexWidth = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def user_data(self):
    #     """
    #     Store your own atlas related user-data (if e.g. you have multiple font atlas).
    #     """
    #     cdef void* res = dereference(self._ptr).UserData
    #     return res
    # @user_data.setter
    # def user_data(self, value: Any):
    #     # dereference(self._ptr).UserData = value
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # def add_custom_rect_font_glyph(self: ImFontAtlas, font: ImFont, id_: int, width: int, height: int, advance_x: float, offset: Tuple[float, float]=(0, 0)):
    #     cdef int res = ccimgui.ImFontAtlas_AddCustomRectFontGlyph(
    #         self._ptr,
    #         font._ptr,
    #         id_,
    #         width,
    #         height,
    #         advance_x,
    #         _cast_tuple_ImVec2(offset)
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # def add_custom_rect_regular(self: ImFontAtlas, width: int, height: int):
    #     """
    #     You can request arbitrary rectangles to be packed into the atlas, for your own purposes.
    #     - After calling Build(), you can query the rectangle position and render your pixels.
    #     - If you render colored output, set 'atlas->TexPixelsUseColors = true' as this may help some backends decide of prefered texture format.
    #     - You can also request your rectangles to be mapped as font glyph (given a font + Unicode point),
    #     so you can render e.g. custom colorful icons and use them as regular glyphs.
    #     - Read docs/FONTS.md for more details about using colorful icons.
    #     - Note: this API may be redesigned later in order to support multi-monitor varying DPI settings.
    #     """
    #     cdef int res = ccimgui.ImFontAtlas_AddCustomRectRegular(
    #         self._ptr,
    #         width,
    #         height
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    # def add_font(self: ImFontAtlas, font_cfg: ImFontConfig):
    #     cdef ccimgui.ImFont* res = ccimgui.ImFontAtlas_AddFont(
    #         self._ptr,
    #         font_cfg._ptr
    #     )
    #     return ImFont.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    def add_font_default(self: ImFontAtlas, font_cfg: ImFontConfig=None):
        cdef ccimgui.ImFont* res = ccimgui.ImFontAtlas_AddFontDefault(
            self._ptr,
            <ccimgui.ImFontConfig*>(NULL if font_cfg is None else font_cfg._ptr)
        )
        return ImFont.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    def add_font_from_file_ttf(self: ImFontAtlas, filename: str, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: ImGlyphRange=None):
        """
        pygui note: The ImFontConfig is copied in ImGui so there is no need to
        keep the object alive after calling this function.
        """
        cdef ccimgui.ImFont* res = ccimgui.ImFontAtlas_AddFontFromFileTTF(
            self._ptr,
            _bytes(filename),
            size_pixels,
            <ccimgui.ImFontConfig*>(NULL if font_cfg is None else font_cfg._ptr),
            <ccimgui.ImWchar*>(glyph_ranges.c_ranges if glyph_ranges is not None else NULL)
        )
        return ImFont.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    # def add_font_from_memory_compressed_base85_ttf(self: ImFontAtlas, compressed_font_data_base85: str, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None):
    #     """
    #     'compressed_font_data_base85' still owned by caller. compress with binary_to_compressed_c.cpp with -base85 parameter.
    #     """
    #     cdef ccimgui.ImFont* res = ccimgui.ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(
    #         self._ptr,
    #         _bytes(compressed_font_data_base85),
    #         size_pixels,
    #         <ccimgui.ImFontConfig*>(NULL if font_cfg is None else font_cfg._ptr),
    #         glyph_ranges
    #     )
    #     return ImFont.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    # def add_font_from_memory_compressed_ttf(self: ImFontAtlas, compressed_font_data: Any, compressed_font_data_size: int, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None):
    #     """
    #     'compressed_font_data' still owned by caller. compress with binary_to_compressed_c.cpp.
    #     """
    #     cdef ccimgui.ImFont* res = ccimgui.ImFontAtlas_AddFontFromMemoryCompressedTTF(
    #         self._ptr,
    #         compressed_font_data,
    #         compressed_font_data_size,
    #         size_pixels,
    #         <ccimgui.ImFontConfig*>(NULL if font_cfg is None else font_cfg._ptr),
    #         glyph_ranges
    #     )
    #     return ImFont.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    # def add_font_from_memory_ttf(self: ImFontAtlas, font_data: Any, font_data_size: int, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None):
    #     """
    #     Note: transfer ownership of 'ttf_data' to imfontatlas! will be deleted after destruction of the atlas. set font_cfg->fontdataownedbyatlas=false to keep ownership of your data and it won't be freed.
    #     """
    #     cdef ccimgui.ImFont* res = ccimgui.ImFontAtlas_AddFontFromMemoryTTF(
    #         self._ptr,
    #         font_data,
    #         font_data_size,
    #         size_pixels,
    #         <ccimgui.ImFontConfig*>(NULL if font_cfg is None else font_cfg._ptr),
    #         glyph_ranges
    #     )
    #     return ImFont.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    def build(self: ImFontAtlas):
        """
        Build atlas, retrieve pixel data.
        User is in charge of copying the pixels into graphics memory (e.g. create a texture with your engine). Then store your texture handle with SetTexID().
        The pitch is always = Width * BytesPerPixels (1 or 4)
        Building in RGBA32 format is provided for convenience and compatibility, but note that unless you manually manipulate or copy color data into
        the texture (e.g. when using the AddCustomRect*** api), then the RGB pixels emitted will always be white (~75% of memory/bandwidth waste.
        Build pixels data. this is called automatically for you by the gettexdata*** functions.
        """
        cdef bool res = ccimgui.ImFontAtlas_Build(
            self._ptr
        )
        return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def calc_custom_rect_uv(self: ImFontAtlas, rect: ImFontAtlasCustomRect, out_uv_min: ImVec2, out_uv_max: ImVec2):
    #     """
    #     [Internal]
    #     """
    #     ccimgui.ImFontAtlas_CalcCustomRectUV(
    #         self._ptr,
    #         rect._ptr,
    #         out_uv_min._ptr,
    #         out_uv_max._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear(self: ImFontAtlas):
    #     """
    #     Clear all input and output.
    #     """
    #     ccimgui.ImFontAtlas_Clear(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear_fonts(self: ImFontAtlas):
    #     """
    #     Clear output font data (glyphs storage, uv coordinates).
    #     """
    #     ccimgui.ImFontAtlas_ClearFonts(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear_input_data(self: ImFontAtlas):
    #     """
    #     Clear input data (all imfontconfig structures including sizes, ttf data, glyph ranges, etc.) = all the data used to build the texture and fonts.
    #     """
    #     ccimgui.ImFontAtlas_ClearInputData(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def clear_tex_data(self: ImFontAtlas):
        """
        Clear output texture data (cpu side). saves ram once the texture has been copied to graphics memory.
        """
        ccimgui.ImFontAtlas_ClearTexData(
            self._ptr
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontAtlasCustomRect)
    # def get_custom_rect_by_index(self: ImFontAtlas, index: int):
    #     cdef ccimgui.ImFontAtlasCustomRect* res = ccimgui.ImFontAtlas_GetCustomRectByIndex(
    #         self._ptr,
    #         index
    #     )
    #     return ImFontAtlasCustomRect.from_ptr(res)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGlyphRange)
    def get_glyph_ranges_chinese_full(self: ImFontAtlas):
        """
        Default + half-width + japanese hiragana/katakana + full set of about 21000 cjk unified ideographs
        """
        cdef const ccimgui.ImWchar* res = ccimgui.ImFontAtlas_GetGlyphRangesChineseFull(
            self._ptr
        )
        return ImGlyphRange.from_short_array(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # def get_glyph_ranges_chinese_simplified_common(self: ImFontAtlas):
    #     """
    #     Default + half-width + japanese hiragana/katakana + set of 2500 cjk unified ideographs for common simplified chinese
    #     """
    #     cdef ccimgui.ImWchar* res = ccimgui.ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGlyphRange)
    def get_glyph_ranges_cyrillic(self: ImFontAtlas):
        """
        Default + about 400 cyrillic characters
        """
        cdef const ccimgui.ImWchar* res = ccimgui.ImFontAtlas_GetGlyphRangesCyrillic(
            self._ptr
        )
        return ImGlyphRange.from_short_array(res)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGlyphRange)
    def get_glyph_ranges_default(self: ImFontAtlas):
        """
        Helpers to retrieve list of common Unicode ranges (2 value per range, values are inclusive, zero-terminated list)
        NB: Make sure that your string are UTF-8 and NOT in your local code page.
        Read https://github.com/ocornut/imgui/blob/master/docs/FONTS.md/#about-utf-8-encoding for details.
        NB: Consider using ImFontGlyphRangesBuilder to build glyph ranges from textual data.
        Basic latin, extended latin
        """
        cdef const ccimgui.ImWchar* res = ccimgui.ImFontAtlas_GetGlyphRangesDefault(
            self._ptr
        )
        return ImGlyphRange.from_short_array(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # def get_glyph_ranges_greek(self: ImFontAtlas):
    #     """
    #     Default + greek and coptic
    #     """
    #     cdef ccimgui.ImWchar* res = ccimgui.ImFontAtlas_GetGlyphRangesGreek(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGlyphRange)
    def get_glyph_ranges_japanese(self: ImFontAtlas):
        """
        Default + hiragana, katakana, half-width, selection of 2999 ideographs
        """
        cdef const ccimgui.ImWchar* res = ccimgui.ImFontAtlas_GetGlyphRangesJapanese(
            self._ptr
        )
        return ImGlyphRange.from_short_array(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGlyphRange)
    # def get_glyph_ranges_korean(self: ImFontAtlas):
    #     """
    #     Default + korean characters
    #     """
    #     cdef ccimgui.ImWchar* res = ccimgui.ImFontAtlas_GetGlyphRangesKorean(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # def get_glyph_ranges_thai(self: ImFontAtlas):
    #     """
    #     Default + thai characters
    #     """
    #     cdef ccimgui.ImWchar* res = ccimgui.ImFontAtlas_GetGlyphRangesThai(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # def get_glyph_ranges_vietnamese(self: ImFontAtlas):
    #     """
    #     Default + vietnamese characters
    #     """
    #     cdef ccimgui.ImWchar* res = ccimgui.ImFontAtlas_GetGlyphRangesVietnamese(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def get_mouse_cursor_tex_data(self: ImFontAtlas, cursor: int, out_offset: ImVec2, out_size: ImVec2, out_uv_border: ImVec2, out_uv_fill: ImVec2):
    #     cdef bool res = ccimgui.ImFontAtlas_GetMouseCursorTexData(
    #         self._ptr,
    #         cursor,
    #         out_offset._ptr,
    #         out_size._ptr,
    #         out_uv_border._ptr,
    #         out_uv_fill._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bytes)
    def get_tex_data_as_alpha8(self: ImFontAtlas, out_width: Int, out_height: Int, out_bytes_per_pixel: Int=None):
        """
        1 byte per-pixel
        """
        cdef unsigned char* pixels

        ccimgui.ImFontAtlas_GetTexDataAsAlpha8(
            self._ptr,
            &pixels,
            &out_width.value,
            &out_height.value,
            Int.ptr(out_bytes_per_pixel)
        )
        return bytes(pixels[:out_width.value*out_height.value])
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bytes)
    def get_tex_data_as_rgba_32(self: ImFontAtlas, out_width: Int, out_height: Int, out_bytes_per_pixel: Int=None):
        """
        4 bytes-per-pixel
        """
        cdef unsigned char* pixels

        ccimgui.ImFontAtlas_GetTexDataAsRGBA32(
            self._ptr,
            &pixels,
            &out_width.value,
            &out_height.value,
            Int.ptr(out_bytes_per_pixel)
        )
        return bytes(pixels[:out_width.value*out_height.value*4])
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def is_built(self: ImFontAtlas):
    #     """
    #     Bit ambiguous: used to detect when user didn't build texture but effectively we should check texid != 0 except that would be backend dependent...
    #     """
    #     cdef bool res = ccimgui.ImFontAtlas_IsBuilt(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_tex_id(self: ImFontAtlas, id_: Any):
    #     ccimgui.ImFontAtlas_SetTexID(
    #         self._ptr,
    #         id_
    #     )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImFontAtlasCustomRect:
    """
    See ImFontAtlas::AddCustomRectXXX functions.
    """
    cdef ccimgui.ImFontAtlasCustomRect* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImFontAtlasCustomRect from_ptr(ccimgui.ImFontAtlasCustomRect* _ptr):
        if _ptr == NULL:
            return None
        cdef ImFontAtlasCustomRect wrapper = ImFontAtlasCustomRect.__new__(ImFontAtlasCustomRect)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImFontAtlasCustomRect from_heap_ptr(ccimgui.ImFontAtlasCustomRect* _ptr):
        wrapper = ImFontAtlasCustomRect.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    @property
    def font(self):
        """
        Input// for custom font glyphs only: target font
        """
        cdef ccimgui.ImFont* res = dereference(self._ptr).Font
        return ImFont.from_ptr(res)
    @font.setter
    def font(self, value: ImFont):
        # dereference(self._ptr).Font = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def glyph_advance_x(self):
        """
        Input// for custom font glyphs only: glyph xadvance
        """
        cdef float res = dereference(self._ptr).GlyphAdvanceX
        return res
    @glyph_advance_x.setter
    def glyph_advance_x(self, value: float):
        # dereference(self._ptr).GlyphAdvanceX = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def glyph_id(self):
        """
        Input// for custom font glyphs only (id < 0x110000)
        """
        cdef unsigned int res = dereference(self._ptr).GlyphID
        return res
    @glyph_id.setter
    def glyph_id(self, value: int):
        # dereference(self._ptr).GlyphID = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def glyph_offset(self):
        """
        Input// for custom font glyphs only: glyph display offset
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).GlyphOffset
        return _cast_ImVec2_tuple(res)
    @glyph_offset.setter
    def glyph_offset(self, value: Tuple[float, float]):
        # dereference(self._ptr).GlyphOffset = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def height(self):
        """
        Input// desired rectangle dimension
        """
        cdef unsigned short res = dereference(self._ptr).Height
        return res
    @height.setter
    def height(self, value: int):
        # dereference(self._ptr).Height = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def width(self):
        """
        Input// desired rectangle dimension
        """
        cdef unsigned short res = dereference(self._ptr).Width
        return res
    @width.setter
    def width(self, value: int):
        # dereference(self._ptr).Width = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def x(self):
        """
        Output   // packed position in atlas
        """
        cdef unsigned short res = dereference(self._ptr).X
        return res
    @x.setter
    def x(self, value: int):
        # dereference(self._ptr).X = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def y(self):
        """
        Output   // packed position in atlas
        """
        cdef unsigned short res = dereference(self._ptr).Y
        return res
    @y.setter
    def y(self, value: int):
        # dereference(self._ptr).Y = value
        raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    def is_packed(self: ImFontAtlasCustomRect):
        cdef bool res = ccimgui.ImFontAtlasCustomRect_IsPacked(
            self._ptr
        )
        return res
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImFontBuilderIO:
    """
    Opaque interface to a font builder (stb_truetype or freetype).
    """
    cdef const ccimgui.ImFontBuilderIO* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImFontBuilderIO from_ptr(const ccimgui.ImFontBuilderIO* _ptr):
        if _ptr == NULL:
            return None
        cdef ImFontBuilderIO wrapper = ImFontBuilderIO.__new__(ImFontBuilderIO)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImFontBuilderIO from_heap_ptr(ccimgui.ImFontBuilderIO* _ptr):
        wrapper = ImFontBuilderIO.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(True)
cdef class ImFontConfig:
    cdef ccimgui.ImFontConfig* _ptr
    cdef const ccimgui.ImFontConfig* _const_ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImFontConfig from_ptr(ccimgui.ImFontConfig* _ptr):
        if _ptr == NULL:
            return None
        cdef ImFontConfig wrapper = ImFontConfig.__new__(ImFontConfig)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        wrapper._const_ptr = NULL
        return wrapper
    
    @staticmethod
    cdef ImFontConfig from_heap_ptr(ccimgui.ImFontConfig* _ptr):
        wrapper = ImFontConfig.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    @staticmethod
    cdef ImFontConfig from_const_ptr(const ccimgui.ImFontConfig* _ptr):
        if _ptr == NULL:
            return None
        cdef ImFontConfig wrapper = ImFontConfig.__new__(ImFontConfig)
        wrapper._ptr = NULL
        wrapper._const_ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr != NULL:
            return hash(<uintptr_t>self._ptr)
        if self._const_ptr != NULL:
            return hash(<uintptr_t>self._const_ptr)
        raise RuntimeError("Won't hash a NULL pointer")
    # [End Class Constants]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    @property
    def dst_font(self):
        cdef ccimgui.ImFont* res
        if self._ptr != NULL:
            res = dereference(self._ptr).DstFont
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).DstFont
        return ImFont.from_ptr(res)
    @dst_font.setter
    def dst_font(self, value: ImFont):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).DstFont = value._ptr
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def ellipsis_char(self):
        """
        -1   // explicitly specify unicode codepoint of ellipsis character. when fonts are being merged first specified ellipsis will be used.
        """
        cdef ccimgui.ImWchar res
        if self._ptr != NULL:
            res = dereference(self._ptr).EllipsisChar
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).EllipsisChar
        return res
    @ellipsis_char.setter
    def ellipsis_char(self, value: int):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).EllipsisChar = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def font_builder_flags(self):
        """
        0// settings for custom font builder. this is builder implementation dependent. leave as zero if unsure.
        """
        cdef unsigned int res
        if self._ptr != NULL:
            res = dereference(self._ptr).FontBuilderFlags
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).FontBuilderFlags
        return res
    @font_builder_flags.setter
    def font_builder_flags(self, value: int):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).FontBuilderFlags = value
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def font_data(self):
    #     """
    #     Ttf/otf data
    #     """
    #     cdef void* res = dereference(self._ptr).FontData
    #     return res
    # @font_data.setter
    # def font_data(self, value: Any):
    #     # dereference(self._ptr).FontData = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def font_data_owned_by_atlas(self):
        """
        True // ttf/otf data ownership taken by the container imfontatlas (will delete memory itself).
        """
        cdef bool res
        if self._ptr != NULL:
            res = dereference(self._ptr).FontDataOwnedByAtlas
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).FontDataOwnedByAtlas
        return res
    @font_data_owned_by_atlas.setter
    def font_data_owned_by_atlas(self, value: bool):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).FontDataOwnedByAtlas = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def font_data_size(self):
        """
        Ttf/otf data size
        """
        cdef int res
        if self._ptr != NULL:
            res = dereference(self._ptr).FontDataSize
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).FontDataSize
        return res
    @font_data_size.setter
    def font_data_size(self, value: int):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).FontDataSize = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def font_no(self):
        """
        0// index of font within ttf/otf file
        """
        cdef int res
        if self._ptr != NULL:
            res = dereference(self._ptr).FontNo
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).FontNo
        return res
    @font_no.setter
    def font_no(self, value: int):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).FontNo = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def glyph_extra_spacing(self):
        """
        0, 0 // extra spacing (in pixels) between glyphs. only x axis is supported for now.
        """
        cdef ccimgui.ImVec2 res
        if self._ptr != NULL:
            res = dereference(self._ptr).GlyphExtraSpacing
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).GlyphExtraSpacing
        return _cast_ImVec2_tuple(res)
    @glyph_extra_spacing.setter
    def glyph_extra_spacing(self, value: Tuple[float, float]):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).GlyphExtraSpacing = _cast_tuple_ImVec2(value)
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def glyph_max_advance_x(self):
        """
        Flt_max  // maximum advancex for glyphs
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).GlyphMaxAdvanceX
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).GlyphMaxAdvanceX
        return res
    @glyph_max_advance_x.setter
    def glyph_max_advance_x(self, value: float):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).GlyphMaxAdvanceX = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def glyph_min_advance_x(self):
        """
        0// minimum advancex for glyphs, set min to align font icons, set both min/max to enforce mono-space font
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).GlyphMinAdvanceX
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).GlyphMinAdvanceX
        return res
    @glyph_min_advance_x.setter
    def glyph_min_advance_x(self, value: float):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).GlyphMinAdvanceX = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def glyph_offset(self):
        """
        0, 0 // offset all glyphs from this font input.
        """
        cdef ccimgui.ImVec2 res
        if self._ptr != NULL:
            res = dereference(self._ptr).GlyphOffset
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).GlyphOffset
        return _cast_ImVec2_tuple(res)
    @glyph_offset.setter
    def glyph_offset(self, value: Tuple[float, float]):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).GlyphOffset = _cast_tuple_ImVec2(value)
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[int])
    @property
    def glyph_ranges(self):
        """
        Null // the array data needs to persist as long as the font is alive. pointer to a user-provided list of unicode range (2 value per range, values are inclusive, zero-terminated list).
        """
        int_list = []
        cdef unsigned char* res = <unsigned char*>dereference(self._ptr).GlyphRanges
        i = 0
        while True:
            char = res[i]
            if char == 0:
                break
            int_list.append(char)
            i += 1
        return int_list
    @glyph_ranges.setter
    def glyph_ranges(self, value: int):
        # dereference(self._ptr).GlyphRanges = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def merge_mode(self):
        """
        False// merge into previous imfont, so you can combine multiple inputs font into one imfont (e.g. ascii font + icons + japanese glyphs). you may want to use glyphoffset.y when merge font of different heights.
        """
        cdef bool res
        if self._ptr != NULL:
            res = dereference(self._ptr).MergeMode
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).MergeMode
        return res
    @merge_mode.setter
    def merge_mode(self, value: bool):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).MergeMode = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def name(self):
        """
        [Internal]
        Name (strictly to ease debugging)
        """
        if self._ptr != NULL:
            return _from_bytes(dereference(self._ptr).Name)
        else:
            return _from_bytes(dereference(self._const_ptr).Name)
    @name.setter
    def name(self, value: str):
        if self._const_ptr != NULL:
            raise NotImplementedError
        cdef bytes c_string = _bytes(value)
        cdef unsigned int string_length = min(39, len(c_string))
        strncpy(dereference(self._ptr).Name, c_string, string_length)
        dereference(self._ptr).Name[string_length] = 0
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def oversample_h(self):
        """
        2// rasterize at higher quality for sub-pixel positioning. note the difference between 2 and 3 is minimal. you can reduce this to 1 for large glyphs save memory. read https://github.com/nothings/stb/blob/master/tests/oversample/readme.md for details.
        """
        cdef int res
        if self._ptr != NULL:
            res = dereference(self._ptr).OversampleH
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).OversampleH
        return res
    @oversample_h.setter
    def oversample_h(self, value: int):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).OversampleH = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def oversample_v(self):
        """
        1// rasterize at higher quality for sub-pixel positioning. this is not really useful as we don't use sub-pixel positions on the y axis.
        """
        cdef int res
        if self._ptr != NULL:
            res = dereference(self._ptr).OversampleV
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).OversampleV
        return res
    @oversample_v.setter
    def oversample_v(self, value: int):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).OversampleV = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def pixel_snap_h(self):
        """
        False// align every glyph to pixel boundary. useful e.g. if you are merging a non-pixel aligned font with the default font. if enabled, you can set oversampleh/v to 1.
        """
        cdef bool res
        if self._ptr != NULL:
            res = dereference(self._ptr).PixelSnapH
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).PixelSnapH
        return res
    @pixel_snap_h.setter
    def pixel_snap_h(self, value: bool):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).PixelSnapH = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def rasterizer_density(self):
    #     """
    #     1.0f // dpi scale for rasterization, not altering other font metrics: make it easy to swap between e.g. a 100% and a 400% fonts for a zooming display. important: if you increase this it is expected that you increase font scale accordingly, otherwise quality may look lowered.
    #     """
    #     cdef float res = dereference(self._ptr).RasterizerDensity
    #     return res
    # @rasterizer_density.setter
    # def rasterizer_density(self, value: float):
    #     # dereference(self._ptr).RasterizerDensity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def rasterizer_multiply(self):
        """
        1.0f // linearly brighten (>1.0f) or darken (<1.0f) font output. brightening small fonts may be a good workaround to make them more readable. this is a silly thing we may remove in the future.
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).RasterizerMultiply
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).RasterizerMultiply
        return res
    @rasterizer_multiply.setter
    def rasterizer_multiply(self, value: float):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).RasterizerMultiply = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def size_pixels(self):
        """
        Size in pixels for rasterizer (more or less maps to the resulting font height).
        """
        cdef float res
        if self._ptr != NULL:
            res = dereference(self._ptr).SizePixels
        if self._const_ptr != NULL:
            res = dereference(self._const_ptr).SizePixels
        return res
    @size_pixels.setter
    def size_pixels(self, value: float):
        if self._const_ptr != NULL:
            raise NotImplementedError
        dereference(self._ptr).SizePixels = value
        # raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(ImFontConfig)
    @staticmethod
    def create():
        """
        Create a dynamically allocated instance of ImFontConfig. Must
        also be freed with destroy().
        """
        cdef ccimgui.ImFontConfig* config = <ccimgui.ImFontConfig*>ccimgui.ImGui_MemAlloc(sizeof(ccimgui.ImFontConfig))

        # Since DearBindings doesn't expose constructors yet, we will mimic the behaviour of a constructor
        # ImFontConfig::ImFontConfig()
        # {
        #     memset(this, 0, sizeof(*this));
        #     FontDataOwnedByAtlas = true;
        #     OversampleH = 3;
        #     OversampleV = 1;
        #     GlyphMaxAdvanceX = FLT_MAX;
        #     RasterizerMultiply = 1.0f;
        #     EllipsisChar = (ImWchar)-1;
        # }

        memset(config, 0, sizeof(ccimgui.ImFontConfig))
        config.FontDataOwnedByAtlas = True
        config.OversampleH = 3
        config.OversampleV = 1
        config.GlyphMaxAdvanceX = FLT_MAX
        config.RasterizerMultiply = <float>1.0
        config.EllipsisChar = -1
        return ImFontConfig.from_heap_ptr(config)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(None)
    def destroy(self: ImFontConfig):
        """
        Explicitly frees this instance.
        """
        if self._ptr != NULL:
            ccimgui.ImGui_MemFree(self._ptr)
            self._ptr = NULL
    def __dealloc__(self):
        """
        Just in case the user forgets to free the memory.
        """
        if not self.dynamically_allocated:
            return
        
        self.destroy()
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImFontGlyph:
    """
    Hold rendering data for one glyph.
    (Note: some language parsers may fail to convert the 31+1 bitfield members, in this case maybe drop store a single u32 or we can rework this)
    """
    cdef const ccimgui.ImFontGlyph* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImFontGlyph from_ptr(const ccimgui.ImFontGlyph* _ptr):
        if _ptr == NULL:
            return None
        cdef ImFontGlyph wrapper = ImFontGlyph.__new__(ImFontGlyph)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImFontGlyph from_heap_ptr(ccimgui.ImFontGlyph* _ptr):
        wrapper = ImFontGlyph.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def advance_x(self):
        """
        Distance to next character (= data from font + imfontconfig::glyphextraspacing.x baked in)
        """
        cdef float res = dereference(self._ptr).AdvanceX
        return res
    @advance_x.setter
    def advance_x(self, value: float):
        # dereference(self._ptr).AdvanceX = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def codepoint(self):
        """
        0x0000..0x10ffff
        """
        cdef unsigned int res = dereference(self._ptr).Codepoint
        return res
    @codepoint.setter
    def codepoint(self, value: int):
        # dereference(self._ptr).Codepoint = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def colored(self):
        """
        Flag to indicate glyph is colored and should generally ignore tinting (make it usable with no shift on little-endian as this is used in loops)
        """
        cdef unsigned int res = dereference(self._ptr).Colored
        return res
    @colored.setter
    def colored(self, value: int):
        # dereference(self._ptr).Colored = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def u0(self):
        """
        Texture coordinates
        """
        cdef float res = dereference(self._ptr).U0
        return res
    @u0.setter
    def u0(self, value: float):
        # dereference(self._ptr).U0 = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def u1(self):
        """
        Texture coordinates
        """
        cdef float res = dereference(self._ptr).U1
        return res
    @u1.setter
    def u1(self, value: float):
        # dereference(self._ptr).U1 = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def v0(self):
        """
        Texture coordinates
        """
        cdef float res = dereference(self._ptr).V0
        return res
    @v0.setter
    def v0(self, value: float):
        # dereference(self._ptr).V0 = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def v1(self):
        """
        Texture coordinates
        """
        cdef float res = dereference(self._ptr).V1
        return res
    @v1.setter
    def v1(self, value: float):
        # dereference(self._ptr).V1 = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def visible(self):
        """
        Flag to indicate glyph has no visible pixels (e.g. space). allow early out when rendering.
        """
        cdef unsigned int res = dereference(self._ptr).Visible
        return res
    @visible.setter
    def visible(self, value: int):
        # dereference(self._ptr).Visible = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def x0(self):
        """
        Glyph corners
        """
        cdef float res = dereference(self._ptr).X0
        return res
    @x0.setter
    def x0(self, value: float):
        # dereference(self._ptr).X0 = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def x1(self):
        """
        Glyph corners
        """
        cdef float res = dereference(self._ptr).X1
        return res
    @x1.setter
    def x1(self, value: float):
        # dereference(self._ptr).X1 = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def y0(self):
        """
        Glyph corners
        """
        cdef float res = dereference(self._ptr).Y0
        return res
    @y0.setter
    def y0(self, value: float):
        # dereference(self._ptr).Y0 = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def y1(self):
        """
        Glyph corners
        """
        cdef float res = dereference(self._ptr).Y1
        return res
    @y1.setter
    def y1(self, value: float):
        # dereference(self._ptr).Y1 = value
        raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(True)
cdef class ImFontGlyphRangesBuilder:
    """
    Helper to build glyph ranges from text/string data. Feed your application strings/characters to it then call BuildRanges().
    This is essentially a tightly packed of vector of 64k booleans = 8KB storage.
    pygui note: This class is instantiable with ImFontGlyphRangesBuilder.create()
    """
    cdef ccimgui.ImFontGlyphRangesBuilder* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImFontGlyphRangesBuilder from_ptr(ccimgui.ImFontGlyphRangesBuilder* _ptr):
        if _ptr == NULL:
            return None
        cdef ImFontGlyphRangesBuilder wrapper = ImFontGlyphRangesBuilder.__new__(ImFontGlyphRangesBuilder)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImFontGlyphRangesBuilder from_heap_ptr(ccimgui.ImFontGlyphRangesBuilder* _ptr):
        wrapper = ImFontGlyphRangesBuilder.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[int])
    @property
    def used_chars(self):
        """
        Store 1-bit per unicode code point (0=unused, 1=used).
        pygui note: Each integer is an unsigned 4 byte integer. Each integer is
        32 booleans. Use get_bit and set_bit to change the booleans.
        """
        cdef ccimgui.ImVector_ImU32 res = dereference(self._ptr).UsedChars
        return [res.Data[i] for i in range(res.Size)]
    @used_chars.setter
    def used_chars(self, value: ImVector_ImU32):
        # dereference(self._ptr).UsedChars = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_char(self: ImFontGlyphRangesBuilder, c: int):
        """
        Add character
        """
        ccimgui.ImFontGlyphRangesBuilder_AddChar(
            self._ptr,
            c
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_ranges(self: ImFontGlyphRangesBuilder, ranges: ImGlyphRange):
        """
        Add ranges, e.g. builder.addranges(imfontatlas::getglyphrangesdefault()) to force add all of ascii/latin+ext
        """
        ccimgui.ImFontGlyphRangesBuilder_AddRanges(
            self._ptr,
            ranges.c_ranges
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_text(self: ImFontGlyphRangesBuilder, text: str):
        """
        Add string (each character of the utf-8 string are added)
        """

        ccimgui.ImFontGlyphRangesBuilder_AddText(
            self._ptr,
            _bytes(text),
            NULL
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGlyphRange)
    def build_ranges(self: ImFontGlyphRangesBuilder):
        """
        Output new ranges (imvector_construct()/imvector_destruct() can be used to safely construct out_ranges
        pygui note: Uses ImGlyphRange wrapper instead. This returns a copy of the
        internal buffer so this instance can be freed immediately after calling
        this function if you need.
        """
        cdef ccimgui.ImVector_ImWchar c_out_ranges
        ccimgui.ImVector_Construct(&c_out_ranges)
        ccimgui.ImFontGlyphRangesBuilder_BuildRanges(
            self._ptr,
            &c_out_ranges
        )
        cdef ImGlyphRange res = ImGlyphRange.from_short_array(c_out_ranges.Data)
        ccimgui.ImVector_Destruct(&c_out_ranges)
        return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def clear(self: ImFontGlyphRangesBuilder):
        ccimgui.ImFontGlyphRangesBuilder_Clear(
            self._ptr
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(ImFontGlyphRangesBuilder)
    @staticmethod
    def create():
        """
        Create a dynamically allocated instance of ImFontGlyphRangesBuilder. Must
        also be freed with destroy().
        """
        cdef ccimgui.ImFontGlyphRangesBuilder* builder = <ccimgui.ImFontGlyphRangesBuilder*>ccimgui.ImGui_MemAlloc(sizeof(ccimgui.ImFontGlyphRangesBuilder))
        # Since DearBindings doesn't expose constructors yet, we will mimic the behaviour of a constructor. Zero init should also work for the ImVector too.
        memset(builder, 0, sizeof(ccimgui.ImFontGlyphRangesBuilder))
        ccimgui.ImFontGlyphRangesBuilder_Clear(builder)
        return ImFontGlyphRangesBuilder.from_heap_ptr(builder)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(None)
    def destroy(self: ImFontGlyphRangesBuilder):
        """
        Explicitly frees this instance.
        """
        if self._ptr != NULL:
            ccimgui.ImGui_MemFree(self._ptr)
            self._ptr = NULL
    def __dealloc__(self):
        """
        Just in case the user forgets to free the memory.
        """
        if not self.dynamically_allocated:
            return
        
        self.destroy()
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    def get_bit(self: ImFontGlyphRangesBuilder, n: int):
        """
        Get bit n in the array
        """
        cdef bool res = ccimgui.ImFontGlyphRangesBuilder_GetBit(
            self._ptr,
            n
        )
        return res
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def set_bit(self: ImFontGlyphRangesBuilder, n: int):
        """
        Set bit n in the array
        """
        ccimgui.ImFontGlyphRangesBuilder_SetBit(
            self._ptr,
            n
        )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiContext:
    """
    Dear imgui context (opaque structure, unless including imgui_internal.h)
    """
    cdef ccimgui.ImGuiContext* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiContext from_ptr(ccimgui.ImGuiContext* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiContext wrapper = ImGuiContext.__new__(ImGuiContext)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiContext from_heap_ptr(ccimgui.ImGuiContext* _ptr):
        wrapper = ImGuiContext.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
_io_clipboard = {}
cdef class ImGuiIO:
    cdef ccimgui.ImGuiIO* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiIO from_ptr(ccimgui.ImGuiIO* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiIO wrapper = ImGuiIO.__new__(ImGuiIO)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        if <uintptr_t>ccimgui.ImGui_GetCurrentContext() not in _io_clipboard:
            _io_clipboard[<uintptr_t>ccimgui.ImGui_GetCurrentContext()] = {
               '_get_clipboard_text_fn': None,
               '_set_clipboard_text_fn': None
            }
        return wrapper
    
    @staticmethod
    cdef ImGuiIO from_heap_ptr(ccimgui.ImGuiIO* _ptr):
        wrapper = ImGuiIO.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def app_accepting_events(self):
        """
        Only modify via setappacceptingevents()
        """
        cdef bool res = dereference(self._ptr).AppAcceptingEvents
        return res
    @app_accepting_events.setter
    def app_accepting_events(self, value: bool):
        # dereference(self._ptr).AppAcceptingEvents = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def app_focus_lost(self):
        """
        Only modify via addfocusevent()
        """
        cdef bool res = dereference(self._ptr).AppFocusLost
        return res
    @app_focus_lost.setter
    def app_focus_lost(self, value: bool):
        # dereference(self._ptr).AppFocusLost = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def backend_flags(self):
        """
        = 0  // see imguibackendflags_ enum. set by backend (imgui_impl_xxx files or custom backend) to communicate features supported by the backend.
        """
        cdef ccimgui.ImGuiBackendFlags res = dereference(self._ptr).BackendFlags
        return res
    @backend_flags.setter
    def backend_flags(self, value: int):
        # dereference(self._ptr).BackendFlags = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def backend_language_user_data(self):
    #     """
    #     = null   // user data for non c++ programming language backend
    #     """
    #     cdef void* res = dereference(self._ptr).BackendLanguageUserData
    #     return res
    # @backend_language_user_data.setter
    # def backend_language_user_data(self, value: Any):
    #     # dereference(self._ptr).BackendLanguageUserData = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    @property
    def backend_platform_name(self):
        """
        Optional: Platform/Renderer backend name (informational only! will be displayed in About Window) + User data for backend/wrappers to store their own stuff.
        = null
        """
        cdef const char* res = dereference(self._ptr).BackendPlatformName
        return _from_bytes(res)
    @backend_platform_name.setter
    def backend_platform_name(self, value: str):
        # dereference(self._ptr).BackendPlatformName = _bytes(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def backend_platform_user_data(self):
    #     """
    #     = null   // user data for platform backend
    #     """
    #     cdef void* res = dereference(self._ptr).BackendPlatformUserData
    #     return res
    # @backend_platform_user_data.setter
    # def backend_platform_user_data(self, value: Any):
    #     # dereference(self._ptr).BackendPlatformUserData = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    @property
    def backend_renderer_name(self):
        """
        = null
        """
        cdef const char* res = dereference(self._ptr).BackendRendererName
        return _from_bytes(res)
    @backend_renderer_name.setter
    def backend_renderer_name(self, value: str):
        # dereference(self._ptr).BackendRendererName = _bytes(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def backend_renderer_user_data(self):
    #     """
    #     = null   // user data for renderer backend
    #     """
    #     cdef void* res = dereference(self._ptr).BackendRendererUserData
    #     return res
    # @backend_renderer_user_data.setter
    # def backend_renderer_user_data(self, value: Any):
    #     # dereference(self._ptr).BackendRendererUserData = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def backend_using_legacy_key_arrays(self):
        """
        -1: unknown, 0: using addkeyevent(), 1: using legacy io.keysdown[]
        """
        cdef ccimgui.ImS8 res = dereference(self._ptr).BackendUsingLegacyKeyArrays
        return res
    @backend_using_legacy_key_arrays.setter
    def backend_using_legacy_key_arrays(self, value: int):
        # dereference(self._ptr).BackendUsingLegacyKeyArrays = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def backend_using_legacy_nav_input_array(self):
        """
        0: using addkeyanalogevent(), 1: writing to legacy io.navinputs[] directly
        """
        cdef bool res = dereference(self._ptr).BackendUsingLegacyNavInputArray
        return res
    @backend_using_legacy_nav_input_array.setter
    def backend_using_legacy_nav_input_array(self, value: bool):
        # dereference(self._ptr).BackendUsingLegacyNavInputArray = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def clipboard_user_data(self):
    #     cdef void* res = dereference(self._ptr).ClipboardUserData
    #     return res
    # @clipboard_user_data.setter
    # def clipboard_user_data(self, value: Any):
    #     # dereference(self._ptr).ClipboardUserData = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_debug_begin_return_value_loop(self):
        """
        = false  // some calls to begin()/beginchild() will return false. will cycle through window depths then repeat. suggested use: add 'io.configdebugbeginreturnvalue = io.keyshift' in your main loop then occasionally press shift. windows should be flickering while running.
        """
        cdef bool res = dereference(self._ptr).ConfigDebugBeginReturnValueLoop
        return res
    @config_debug_begin_return_value_loop.setter
    def config_debug_begin_return_value_loop(self, value: bool):
        # dereference(self._ptr).ConfigDebugBeginReturnValueLoop = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_debug_begin_return_value_once(self):
        """
        Tools to test correct Begin/End and BeginChild/EndChild behaviors.
        - Presently Begin()/End() and BeginChild()/EndChild() needs to ALWAYS be called in tandem, regardless of return value of BeginXXX()
        - This is inconsistent with other BeginXXX functions and create confusion for many users.
        - We expect to update the API eventually. In the meanwhile we provide tools to facilitate checking user-code behavior.
        = false  // first-time calls to begin()/beginchild() will return false. needs to be set at application boot time if you don't want to miss windows.
        """
        cdef bool res = dereference(self._ptr).ConfigDebugBeginReturnValueOnce
        return res
    @config_debug_begin_return_value_once.setter
    def config_debug_begin_return_value_once(self, value: bool):
        # dereference(self._ptr).ConfigDebugBeginReturnValueOnce = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # @property
    # def config_debug_ignore_focus_loss(self):
    #     """
    #     Option to deactivate io.AddFocusEvent(false) handling.
    #     - May facilitate interactions with a debugger when focus loss leads to clearing inputs data.
    #     - Backends may have other side-effects on focus loss, so this will reduce side-effects but not necessary remove all of them.
    #     = false  // ignore io.addfocusevent(false), consequently not calling io.clearinputkeys() in input processing.
    #     """
    #     cdef bool res = dereference(self._ptr).ConfigDebugIgnoreFocusLoss
    #     return res
    # @config_debug_ignore_focus_loss.setter
    # def config_debug_ignore_focus_loss(self, value: bool):
    #     # dereference(self._ptr).ConfigDebugIgnoreFocusLoss = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_debug_ini_settings(self):
        """
        Option to audit .ini data
        = false  // save .ini data with extra comments (particularly helpful for docking, but makes saving slower)
        """
        cdef bool res = dereference(self._ptr).ConfigDebugIniSettings
        return res
    @config_debug_ini_settings.setter
    def config_debug_ini_settings(self, value: bool):
        dereference(self._ptr).ConfigDebugIniSettings = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # @property
    # def config_debug_is_debugger_present(self):
    #     """
    #     Option to enable various debug tools showing buttons that will call the IM_DEBUG_BREAK() macro.
    #     - The Item Picker tool will be available regardless of this being enabled, in order to maximize its discoverability.
    #     - Requires a debugger being attached, otherwise IM_DEBUG_BREAK() options will appear to crash your application.
    #     e.g. io.ConfigDebugIsDebuggerPresent = ::IsDebuggerPresent() on Win32, or refer to ImOsIsDebuggerPresent() imgui_test_engine/imgui_te_utils.cpp for a Unix compatible version).
    #     = false  // enable various tools calling im_debug_break().
    #     """
    #     cdef bool res = dereference(self._ptr).ConfigDebugIsDebuggerPresent
    #     return res
    # @config_debug_is_debugger_present.setter
    # def config_debug_is_debugger_present(self, value: bool):
    #     # dereference(self._ptr).ConfigDebugIsDebuggerPresent = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_docking_always_tab_bar(self):
        """
        = false  // [beta] [fixme: this currently creates regression with auto-sizing and general overhead] make every single floating window display within a docking node.
        """
        cdef bool res = dereference(self._ptr).ConfigDockingAlwaysTabBar
        return res
    @config_docking_always_tab_bar.setter
    def config_docking_always_tab_bar(self, value: bool):
        # dereference(self._ptr).ConfigDockingAlwaysTabBar = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_docking_no_split(self):
        """
        Docking options (when ImGuiConfigFlags_DockingEnable is set)
        = false  // simplified docking mode: disable window splitting, so docking is limited to merging multiple windows together into tab-bars.
        """
        cdef bool res = dereference(self._ptr).ConfigDockingNoSplit
        return res
    @config_docking_no_split.setter
    def config_docking_no_split(self, value: bool):
        # dereference(self._ptr).ConfigDockingNoSplit = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_docking_transparent_payload(self):
        """
        = false  // [beta] make window or viewport transparent when docking and only display docking boxes on the target viewport. useful if rendering of multiple viewport cannot be synced. best used with configviewportsnoautomerge.
        """
        cdef bool res = dereference(self._ptr).ConfigDockingTransparentPayload
        return res
    @config_docking_transparent_payload.setter
    def config_docking_transparent_payload(self, value: bool):
        # dereference(self._ptr).ConfigDockingTransparentPayload = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_docking_with_shift(self):
        """
        = false  // enable docking with holding shift key (reduce visual noise, allows dropping in wider space)
        """
        cdef bool res = dereference(self._ptr).ConfigDockingWithShift
        return res
    @config_docking_with_shift.setter
    def config_docking_with_shift(self, value: bool):
        # dereference(self._ptr).ConfigDockingWithShift = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_drag_click_to_input_text(self):
        """
        = false  // [beta] enable turning dragxxx widgets into text input with a simple mouse click-release (without moving). not desirable on devices without a keyboard.
        """
        cdef bool res = dereference(self._ptr).ConfigDragClickToInputText
        return res
    @config_drag_click_to_input_text.setter
    def config_drag_click_to_input_text(self, value: bool):
        # dereference(self._ptr).ConfigDragClickToInputText = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def config_flags(self):
        """
        = 0  // see imguiconfigflags_ enum. set by user/application. gamepad/keyboard navigation options, etc.
        """
        cdef ccimgui.ImGuiConfigFlags res = dereference(self._ptr).ConfigFlags
        return res
    @config_flags.setter
    def config_flags(self, value: int):
        dereference(self._ptr).ConfigFlags = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_input_text_cursor_blink(self):
        """
        = true   // enable blinking cursor (optional as some users consider it to be distracting).
        """
        cdef bool res = dereference(self._ptr).ConfigInputTextCursorBlink
        return res
    @config_input_text_cursor_blink.setter
    def config_input_text_cursor_blink(self, value: bool):
        # dereference(self._ptr).ConfigInputTextCursorBlink = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_input_text_enter_keep_active(self):
        """
        = false  // [beta] pressing enter will keep item active and select contents (single-line only).
        """
        cdef bool res = dereference(self._ptr).ConfigInputTextEnterKeepActive
        return res
    @config_input_text_enter_keep_active.setter
    def config_input_text_enter_keep_active(self, value: bool):
        # dereference(self._ptr).ConfigInputTextEnterKeepActive = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_input_trickle_event_queue(self):
        """
        = true   // enable input queue trickling: some types of events submitted during the same frame (e.g. button down + up) will be spread over multiple frames, improving interactions with low framerates.
        """
        cdef bool res = dereference(self._ptr).ConfigInputTrickleEventQueue
        return res
    @config_input_trickle_event_queue.setter
    def config_input_trickle_event_queue(self, value: bool):
        # dereference(self._ptr).ConfigInputTrickleEventQueue = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_mac_osx_behaviors(self):
        """
        = defined(__apple__) // os x style: text editing cursor movement using alt instead of ctrl, shortcuts using cmd/super instead of ctrl, line/text start and end using cmd+arrows instead of home/end, double click selects by word instead of selecting whole text, multi-selection in lists uses cmd/super instead of ctrl.
        """
        cdef bool res = dereference(self._ptr).ConfigMacOSXBehaviors
        return res
    @config_mac_osx_behaviors.setter
    def config_mac_osx_behaviors(self, value: bool):
        # dereference(self._ptr).ConfigMacOSXBehaviors = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def config_memory_compact_timer(self):
        """
        = 60.0f  // timer (in seconds) to free transient windows/tables memory buffers when unused. set to -1.0f to disable.
        """
        cdef float res = dereference(self._ptr).ConfigMemoryCompactTimer
        return res
    @config_memory_compact_timer.setter
    def config_memory_compact_timer(self, value: float):
        # dereference(self._ptr).ConfigMemoryCompactTimer = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_viewports_no_auto_merge(self):
        """
        Viewport options (when ImGuiConfigFlags_ViewportsEnable is set)
        = false; // set to make all floating imgui windows always create their own viewport. otherwise, they are merged into the main host viewports when overlapping it. may also set imguiviewportflags_noautomerge on individual viewport.
        """
        cdef bool res = dereference(self._ptr).ConfigViewportsNoAutoMerge
        return res
    @config_viewports_no_auto_merge.setter
    def config_viewports_no_auto_merge(self, value: bool):
        # dereference(self._ptr).ConfigViewportsNoAutoMerge = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_viewports_no_decoration(self):
        """
        = true   // disable default os window decoration flag for secondary viewports. when a viewport doesn't want window decorations, imguiviewportflags_nodecoration will be set on it. enabling decoration can create subsequent issues at os levels (e.g. minimum window size).
        """
        cdef bool res = dereference(self._ptr).ConfigViewportsNoDecoration
        return res
    @config_viewports_no_decoration.setter
    def config_viewports_no_decoration(self, value: bool):
        # dereference(self._ptr).ConfigViewportsNoDecoration = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_viewports_no_default_parent(self):
        """
        = false  // disable default os parenting to main viewport for secondary viewports. by default, viewports are marked with parentviewportid = <main_viewport>, expecting the platform backend to setup a parent/child relationship between the os windows (some backend may ignore this). set to true if you want the default to be 0, then all viewports will be top-level os windows.
        """
        cdef bool res = dereference(self._ptr).ConfigViewportsNoDefaultParent
        return res
    @config_viewports_no_default_parent.setter
    def config_viewports_no_default_parent(self, value: bool):
        # dereference(self._ptr).ConfigViewportsNoDefaultParent = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_viewports_no_task_bar_icon(self):
        """
        = false  // disable default os task bar icon flag for secondary viewports. when a viewport doesn't want a task bar icon, imguiviewportflags_notaskbaricon will be set on it.
        """
        cdef bool res = dereference(self._ptr).ConfigViewportsNoTaskBarIcon
        return res
    @config_viewports_no_task_bar_icon.setter
    def config_viewports_no_task_bar_icon(self, value: bool):
        # dereference(self._ptr).ConfigViewportsNoTaskBarIcon = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_windows_move_from_title_bar_only(self):
        """
        = false   // enable allowing to move windows only when clicking on their title bar. does not apply to windows without a title bar.
        """
        cdef bool res = dereference(self._ptr).ConfigWindowsMoveFromTitleBarOnly
        return res
    @config_windows_move_from_title_bar_only.setter
    def config_windows_move_from_title_bar_only(self, value: bool):
        # dereference(self._ptr).ConfigWindowsMoveFromTitleBarOnly = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def config_windows_resize_from_edges(self):
        """
        = true   // enable resizing of windows from their edges and from the lower-left corner. this requires (io.backendflags & imguibackendflags_hasmousecursors) because it needs mouse cursor feedback. (this used to be a per-window imguiwindowflags_resizefromanyside flag)
        """
        cdef bool res = dereference(self._ptr).ConfigWindowsResizeFromEdges
        return res
    @config_windows_resize_from_edges.setter
    def config_windows_resize_from_edges(self, value: bool):
        # dereference(self._ptr).ConfigWindowsResizeFromEdges = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGuiContext)
    @property
    def ctx(self):
        """
        Parent ui context (needs to be set explicitly by parent).
        """
        cdef ccimgui.ImGuiContext* res = dereference(self._ptr).Ctx
        return ImGuiContext.from_ptr(res)
    @ctx.setter
    def ctx(self, value: ImGuiContext):
        # dereference(self._ptr).Ctx = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def delta_time(self):
        """
        = 1.0f/60.0f // time elapsed since last frame, in seconds. may change every frame.
        """
        cdef float res = dereference(self._ptr).DeltaTime
        return res
    @delta_time.setter
    def delta_time(self, value: float):
        # dereference(self._ptr).DeltaTime = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def display_framebuffer_scale(self):
        """
        = (1, 1) // for retina display or other situations where window coordinates are different from framebuffer coordinates. this generally ends up in imdrawdata::framebufferscale.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).DisplayFramebufferScale
        return _cast_ImVec2_tuple(res)
    @display_framebuffer_scale.setter
    def display_framebuffer_scale(self, value: Tuple[float, float]):
        # dereference(self._ptr).DisplayFramebufferScale = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def display_size(self):
        """
        <unset>  // main display size, in pixels (generally == getmainviewport()->size). may change every frame.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).DisplaySize
        return _cast_ImVec2_tuple(res)
    @display_size.setter
    def display_size(self, value: Tuple[float, float]):
        # dereference(self._ptr).DisplaySize = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def font_allow_user_scaling(self):
        """
        = false  // allow user scaling text of individual window with ctrl+wheel.
        """
        cdef bool res = dereference(self._ptr).FontAllowUserScaling
        return res
    @font_allow_user_scaling.setter
    def font_allow_user_scaling(self, value: bool):
        # dereference(self._ptr).FontAllowUserScaling = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    @property
    def font_default(self):
        """
        = null   // font to use on newframe(). use null to uses fonts->fonts[0].
        """
        cdef ccimgui.ImFont* res = dereference(self._ptr).FontDefault
        return ImFont.from_ptr(res)
    @font_default.setter
    def font_default(self, value: ImFont):
        # dereference(self._ptr).FontDefault = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def font_global_scale(self):
        """
        = 1.0f   // global scale all fonts
        """
        cdef float res = dereference(self._ptr).FontGlobalScale
        return res
    @font_global_scale.setter
    def font_global_scale(self, value: float):
        # dereference(self._ptr).FontGlobalScale = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontAtlas)
    @property
    def fonts(self):
        """
        <auto>   // font atlas: load, rasterize and pack one or more fonts into a single texture.
        """
        cdef ccimgui.ImFontAtlas* res = dereference(self._ptr).Fonts
        return ImFontAtlas.from_ptr(res)
    @fonts.setter
    def fonts(self, value: ImFontAtlas):
        # dereference(self._ptr).Fonts = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def framerate(self):
        """
        Estimate of application framerate (rolling average over 60 frames, based on io.deltatime), in frame per second. solely for convenience. slow applications may not want to use a moving average or may want to reset underlying buffers occasionally.
        """
        cdef float res = dereference(self._ptr).Framerate
        return res
    @framerate.setter
    def framerate(self, value: float):
        # dereference(self._ptr).Framerate = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    @property
    def get_clipboard_text_fn(self):
        return _io_clipboard[<uintptr_t>ccimgui.ImGui_GetCurrentContext()]['_get_clipboard_text_fn']
    @get_clipboard_text_fn.setter
    def get_clipboard_text_fn(self, value: Callable):
        if callable(value):
            _io_clipboard[<uintptr_t>ccimgui.ImGui_GetCurrentContext()]['_get_clipboard_text_fn'] = value
            dereference(self._ptr).GetClipboardTextFn = self._get_clipboard_text
        else:
            raise ValueError("func is not a callable: %s" % str(value))
    
    @staticmethod
    cdef const char* _get_clipboard_text(void* user_data) noexcept:
        text = _io_clipboard[<uintptr_t>ccimgui.ImGui_GetCurrentContext()]['_get_clipboard_text_fn']()
        if type(text) is bytes:
            return text
        return _bytes(text)
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    @property
    def ini_filename(self):
        """
        = 'imgui.ini'// path to .ini file (important: default 'imgui.ini' is relative to current working dir!). set null to disable automatic .ini loading/saving or if you want to manually call loadinisettingsxxx() / saveinisettingsxxx() functions.
        """
        cdef const char* res = dereference(self._ptr).IniFilename
        return _from_bytes(res)
    @ini_filename.setter
    def ini_filename(self, value: str):
        # dereference(self._ptr).IniFilename = _bytes(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def ini_saving_rate(self):
        """
        = 5.0f   // minimum time between saving positions/sizes to .ini file, in seconds.
        """
        cdef float res = dereference(self._ptr).IniSavingRate
        return res
    @ini_saving_rate.setter
    def ini_saving_rate(self, value: float):
        # dereference(self._ptr).IniSavingRate = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[int])
    @property
    def input_queue_characters(self):
        """
        Queue of _characters_ input (obtained by platform backend). fill using addinputcharacter() helper.
        """
        cdef ccimgui.ImVector_ImWchar res = dereference(self._ptr).InputQueueCharacters
        return [res.Data[i] for i in range(res.Size)]
        # return ImVector_ImWchar.from_ptr(res)
    @input_queue_characters.setter
    def input_queue_characters(self, value: ImVector_ImWchar):
        # dereference(self._ptr).InputQueueCharacters = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def input_queue_surrogate(self):
        """
        For addinputcharacterutf16()
        """
        cdef ccimgui.ImWchar16 res = dereference(self._ptr).InputQueueSurrogate
        return res
    @input_queue_surrogate.setter
    def input_queue_surrogate(self, value: int):
        # dereference(self._ptr).InputQueueSurrogate = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def key_alt(self):
        """
        Keyboard modifier down: alt
        """
        cdef bool res = dereference(self._ptr).KeyAlt
        return res
    @key_alt.setter
    def key_alt(self, value: bool):
        # dereference(self._ptr).KeyAlt = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def key_ctrl(self):
        """
        Keyboard modifier down: control
        """
        cdef bool res = dereference(self._ptr).KeyCtrl
        return res
    @key_ctrl.setter
    def key_ctrl(self, value: bool):
        # dereference(self._ptr).KeyCtrl = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def key_mods(self):
        """
        Other state maintained from data above + IO function calls
        Key mods flags (any of imguimod_ctrl/imguimod_shift/imguimod_alt/imguimod_super flags, same as io.keyctrl/keyshift/keyalt/keysuper but merged into flags. does not contains imguimod_shortcut which is pretranslated). read-only, updated by newframe()
        """
        cdef ccimgui.ImGuiKeyChord res = dereference(self._ptr).KeyMods
        return res
    @key_mods.setter
    def key_mods(self, value: int):
        # dereference(self._ptr).KeyMods = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def key_repeat_delay(self):
        """
        = 0.275f // when holding a key/button, time before it starts repeating, in seconds (for buttons in repeat mode, etc.).
        """
        cdef float res = dereference(self._ptr).KeyRepeatDelay
        return res
    @key_repeat_delay.setter
    def key_repeat_delay(self, value: float):
        # dereference(self._ptr).KeyRepeatDelay = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def key_repeat_rate(self):
        """
        = 0.050f // when holding a key/button, rate at which it repeats, in seconds.
        """
        cdef float res = dereference(self._ptr).KeyRepeatRate
        return res
    @key_repeat_rate.setter
    def key_repeat_rate(self, value: float):
        # dereference(self._ptr).KeyRepeatRate = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def key_shift(self):
        """
        Keyboard modifier down: shift
        """
        cdef bool res = dereference(self._ptr).KeyShift
        return res
    @key_shift.setter
    def key_shift(self, value: bool):
        # dereference(self._ptr).KeyShift = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def key_super(self):
        """
        Keyboard modifier down: cmd/super/windows
        """
        cdef bool res = dereference(self._ptr).KeySuper
        return res
    @key_super.setter
    def key_super(self, value: bool):
        # dereference(self._ptr).KeySuper = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGuiKeyData)
    @property
    def keys_data(self):
        """
        Key state for all known keys. use iskeyxxx() functions to access this.
        """
        cdef ccimgui.ImGuiKeyData* res = dereference(self._ptr).KeysData
        return ImGuiKeyData.from_ptr(res)
    @keys_data.setter
    def keys_data(self, value: ImGuiKeyData):
        # dereference(self._ptr).KeysData = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    @property
    def log_filename(self):
        """
        = 'imgui_log.txt'// path to .log file (default parameter to imgui::logtofile when no file is specified).
        """
        cdef const char* res = dereference(self._ptr).LogFilename
        return _from_bytes(res)
    @log_filename.setter
    def log_filename(self, value: str):
        # dereference(self._ptr).LogFilename = _bytes(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def metrics_active_windows(self):
        """
        Number of active windows
        """
        cdef int res = dereference(self._ptr).MetricsActiveWindows
        return res
    @metrics_active_windows.setter
    def metrics_active_windows(self, value: int):
        # dereference(self._ptr).MetricsActiveWindows = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def metrics_render_indices(self):
        """
        Indices output during last call to render() = number of triangles * 3
        """
        cdef int res = dereference(self._ptr).MetricsRenderIndices
        return res
    @metrics_render_indices.setter
    def metrics_render_indices(self, value: int):
        # dereference(self._ptr).MetricsRenderIndices = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def metrics_render_vertices(self):
        """
        Vertices output during last call to render()
        """
        cdef int res = dereference(self._ptr).MetricsRenderVertices
        return res
    @metrics_render_vertices.setter
    def metrics_render_vertices(self, value: int):
        # dereference(self._ptr).MetricsRenderVertices = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def metrics_render_windows(self):
        """
        Number of visible windows
        """
        cdef int res = dereference(self._ptr).MetricsRenderWindows
        return res
    @metrics_render_windows.setter
    def metrics_render_windows(self, value: int):
        # dereference(self._ptr).MetricsRenderWindows = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[bool])
    @property
    def mouse_clicked(self):
        """
        Mouse button went from !down to down (same as mouseclickedcount[x] != 0)
        """
        cdef bool* res = dereference(self._ptr).MouseClicked
        return dereference(res)
    @mouse_clicked.setter
    def mouse_clicked(self, value: Sequence[Bool]):
        # dereference(self._ptr).MouseClicked = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def mouse_clicked_count(self):
        """
        == 0 (not clicked), == 1 (same as mouseclicked[]), == 2 (double-clicked), == 3 (triple-clicked) etc. when going from !down to down
        """
        cdef ccimgui.ImU16* res = dereference(self._ptr).MouseClickedCount
        return dereference(res)
    @mouse_clicked_count.setter
    def mouse_clicked_count(self, value: int):
        # dereference(self._ptr).MouseClickedCount = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def mouse_clicked_last_count(self):
        """
        Count successive number of clicks. stays valid after mouse release. reset after another click is done.
        """
        cdef ccimgui.ImU16* res = dereference(self._ptr).MouseClickedLastCount
        return dereference(res)
    @mouse_clicked_last_count.setter
    def mouse_clicked_last_count(self, value: int):
        # dereference(self._ptr).MouseClickedLastCount = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(tuple)
    @property
    def mouse_clicked_pos(self):
        """
        Position at time of clicking
        """
        cdef ccimgui.ImVec2* res = dereference(self._ptr).MouseClickedPos
        return _cast_ImVec2_tuple(dereference(res))
    @mouse_clicked_pos.setter
    def mouse_clicked_pos(self, value: ImVec2):
        # dereference(self._ptr).MouseClickedPos = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[Double])
    # @property
    # def mouse_clicked_time(self):
    #     """
    #     Time of last click (used to figure out double-click)
    #     """
    #     cdef double* res = dereference(self._ptr).MouseClickedTime
    #     return Double(dereference(res))
    # @mouse_clicked_time.setter
    # def mouse_clicked_time(self, value: Sequence[Double]):
    #     # dereference(self._ptr).MouseClickedTime = &value.value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def mouse_delta(self):
        """
        Mouse delta. note that this is zero if either current or previous position are invalid (-flt_max,-flt_max), so a disappearing/reappearing mouse won't have a huge delta.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).MouseDelta
        return _cast_ImVec2_tuple(res)
    @mouse_delta.setter
    def mouse_delta(self, value: Tuple[float, float]):
        # dereference(self._ptr).MouseDelta = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def mouse_double_click_max_dist(self):
        """
        = 6.0f   // distance threshold to stay in to validate a double-click, in pixels.
        """
        cdef float res = dereference(self._ptr).MouseDoubleClickMaxDist
        return res
    @mouse_double_click_max_dist.setter
    def mouse_double_click_max_dist(self, value: float):
        # dereference(self._ptr).MouseDoubleClickMaxDist = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def mouse_double_click_time(self):
        """
        Inputs Behaviors
        (other variables, ones which are expected to be tweaked within UI code, are exposed in ImGuiStyle)
        = 0.30f  // time for a double-click, in seconds.
        """
        cdef float res = dereference(self._ptr).MouseDoubleClickTime
        return res
    @mouse_double_click_time.setter
    def mouse_double_click_time(self, value: float):
        # dereference(self._ptr).MouseDoubleClickTime = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[bool])
    @property
    def mouse_double_clicked(self):
        """
        Has mouse button been double-clicked? (same as mouseclickedcount[x] == 2)
        """
        cdef bool* res = dereference(self._ptr).MouseDoubleClicked
        return dereference(res)
    @mouse_double_clicked.setter
    def mouse_double_clicked(self, value: Sequence[Bool]):
        # dereference(self._ptr).MouseDoubleClicked = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[bool])
    @property
    def mouse_down(self):
        """
        Mouse buttons: 0=left, 1=right, 2=middle + extras (imguimousebutton_count == 5). dear imgui mostly uses left and right buttons. other buttons allow us to track if the mouse is being used by your application + available to user as a convenience via ismouse** api.
        """
        cdef bool* res = dereference(self._ptr).MouseDown
        return dereference(res)
    @mouse_down.setter
    def mouse_down(self, value: Sequence[Bool]):
        # dereference(self._ptr).MouseDown = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[float])
    @property
    def mouse_down_duration(self):
        """
        Duration the mouse button has been down (0.0f == just clicked)
        """
        cdef float* res = dereference(self._ptr).MouseDownDuration
        return dereference(res)
    @mouse_down_duration.setter
    def mouse_down_duration(self, value: Sequence[Float]):
        # dereference(self._ptr).MouseDownDuration = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[float])
    @property
    def mouse_down_duration_prev(self):
        """
        Previous time the mouse button has been down
        """
        cdef float* res = dereference(self._ptr).MouseDownDurationPrev
        return dereference(res)
    @mouse_down_duration_prev.setter
    def mouse_down_duration_prev(self, value: Sequence[Float]):
        # dereference(self._ptr).MouseDownDurationPrev = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[bool])
    @property
    def mouse_down_owned(self):
        """
        Track if button was clicked inside a dear imgui window or over void blocked by a popup. we don't request mouse capture from the application if click started outside imgui bounds.
        """
        cdef bool* res = dereference(self._ptr).MouseDownOwned
        return dereference(res)
    @mouse_down_owned.setter
    def mouse_down_owned(self, value: Sequence[Bool]):
        # dereference(self._ptr).MouseDownOwned = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[bool])
    @property
    def mouse_down_owned_unless_popup_close(self):
        """
        Track if button was clicked inside a dear imgui window.
        """
        cdef bool* res = dereference(self._ptr).MouseDownOwnedUnlessPopupClose
        return dereference(res)
    @mouse_down_owned_unless_popup_close.setter
    def mouse_down_owned_unless_popup_close(self, value: Sequence[Bool]):
        # dereference(self._ptr).MouseDownOwnedUnlessPopupClose = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(tuple)
    @property
    def mouse_drag_max_distance_abs(self):
        """
        Maximum distance, absolute, on each axis, of how much mouse has traveled from the clicking point
        """
        cdef ccimgui.ImVec2* res = dereference(self._ptr).MouseDragMaxDistanceAbs
        return _cast_ImVec2_tuple(dereference(res))
    @mouse_drag_max_distance_abs.setter
    def mouse_drag_max_distance_abs(self, value: ImVec2):
        # dereference(self._ptr).MouseDragMaxDistanceAbs = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[float])
    @property
    def mouse_drag_max_distance_sqr(self):
        """
        Squared maximum distance of how much mouse has traveled from the clicking point (used for moving thresholds)
        """
        cdef float* res = dereference(self._ptr).MouseDragMaxDistanceSqr
        return dereference(res)
    @mouse_drag_max_distance_sqr.setter
    def mouse_drag_max_distance_sqr(self, value: Sequence[Float]):
        # dereference(self._ptr).MouseDragMaxDistanceSqr = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def mouse_drag_threshold(self):
        """
        = 6.0f   // distance threshold before considering we are dragging.
        """
        cdef float res = dereference(self._ptr).MouseDragThreshold
        return res
    @mouse_drag_threshold.setter
    def mouse_drag_threshold(self, value: float):
        # dereference(self._ptr).MouseDragThreshold = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def mouse_draw_cursor(self):
        """
        Miscellaneous options
        = false  // request imgui to draw a mouse cursor for you (if you are on a platform without a mouse cursor). cannot be easily renamed to 'io.configxxx' because this is frequently used by backend implementations.
        """
        cdef bool res = dereference(self._ptr).MouseDrawCursor
        return res
    @mouse_draw_cursor.setter
    def mouse_draw_cursor(self, value: bool):
        # dereference(self._ptr).MouseDrawCursor = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def mouse_hovered_viewport(self):
        """
        (optional) modify using io.addmouseviewportevent(). with multi-viewports: viewport the os mouse is hovering. if possible _ignoring_ viewports with the imguiviewportflags_noinputs flag is much better (few backends can handle that). set io.backendflags |= imguibackendflags_hasmousehoveredviewport if you can provide this info. if you don't imgui will infer the value using the rectangles and last focused time of the viewports it knows about (ignoring other os windows).
        """
        cdef ccimgui.ImGuiID res = dereference(self._ptr).MouseHoveredViewport
        return res
    @mouse_hovered_viewport.setter
    def mouse_hovered_viewport(self, value: int):
        # dereference(self._ptr).MouseHoveredViewport = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def mouse_pos(self):
        """
        Main Input State
        (this block used to be written by backend, since 1.87 it is best to NOT write to those directly, call the AddXXX functions above instead)
        (reading from those variables is fair game, as they are extremely unlikely to be moving anywhere)
        Mouse position, in pixels. set to imvec2(-flt_max, -flt_max) if mouse is unavailable (on another screen, etc.)
        """
        # cdef ccimgui.ImVec2 res = dereference(self._ptr).MousePos
        # return _cast_ImVec2_tuple(res)

        # Not sure why but the typical way to read this member
        # return nan unless this function is called instead. I'm going to
        # raise an error below to make sure a user knows this.
        return _cast_ImVec2_tuple(ccimgui.ImGui_GetMousePos())
    @mouse_pos.setter
    def mouse_pos(self, value: Tuple[float, float]):
        # dereference(self._ptr).MousePos = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def mouse_pos_prev(self):
        """
        Previous mouse position (note that mousedelta is not necessary == mousepos-mouseposprev, in case either position is invalid)
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).MousePosPrev
        return _cast_ImVec2_tuple(res)
    @mouse_pos_prev.setter
    def mouse_pos_prev(self, value: Tuple[float, float]):
        # dereference(self._ptr).MousePosPrev = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Sequence[bool])
    @property
    def mouse_released(self):
        """
        Mouse button went from down to !down
        """
        cdef bool* res = dereference(self._ptr).MouseReleased
        return dereference(res)
    @mouse_released.setter
    def mouse_released(self, value: Sequence[Bool]):
        # dereference(self._ptr).MouseReleased = &value.value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def mouse_source(self):
        """
        Mouse actual input peripheral (mouse/touchscreen/pen).
        """
        cdef ccimgui.ImGuiMouseSource res = dereference(self._ptr).MouseSource
        return res
    @mouse_source.setter
    def mouse_source(self, value: int):
        # dereference(self._ptr).MouseSource = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def mouse_wheel(self):
        """
        Mouse wheel vertical: 1 unit scrolls about 5 lines text. >0 scrolls up, <0 scrolls down. hold shift to turn vertical scroll into horizontal scroll.
        """
        cdef float res = dereference(self._ptr).MouseWheel
        return res
    @mouse_wheel.setter
    def mouse_wheel(self, value: float):
        # dereference(self._ptr).MouseWheel = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def mouse_wheel_h(self):
        """
        Mouse wheel horizontal. >0 scrolls left, <0 scrolls right. most users don't have a mouse with a horizontal wheel, may not be filled by all backends.
        """
        cdef float res = dereference(self._ptr).MouseWheelH
        return res
    @mouse_wheel_h.setter
    def mouse_wheel_h(self, value: float):
        # dereference(self._ptr).MouseWheelH = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def mouse_wheel_request_axis_swap(self):
        """
        On a non-mac system, holding shift requests wheely to perform the equivalent of a wheelx event. on a mac system this is already enforced by the system.
        """
        cdef bool res = dereference(self._ptr).MouseWheelRequestAxisSwap
        return res
    @mouse_wheel_request_axis_swap.setter
    def mouse_wheel_request_axis_swap(self, value: bool):
        # dereference(self._ptr).MouseWheelRequestAxisSwap = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def nav_active(self):
        """
        Keyboard/gamepad navigation is currently allowed (will handle imguikey_navxxx events) = a window is focused and it doesn't use the imguiwindowflags_nonavinputs flag.
        """
        cdef bool res = dereference(self._ptr).NavActive
        return res
    @nav_active.setter
    def nav_active(self, value: bool):
        # dereference(self._ptr).NavActive = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def nav_visible(self):
        """
        Keyboard/gamepad navigation is visible and allowed (will handle imguikey_navxxx events).
        """
        cdef bool res = dereference(self._ptr).NavVisible
        return res
    @nav_visible.setter
    def nav_visible(self, value: bool):
        # dereference(self._ptr).NavVisible = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def pen_pressure(self):
        """
        Touch/pen pressure (0.0f to 1.0f, should be >0.0f only when mousedown[0] == true). helper storage currently unused by dear imgui.
        """
        cdef float res = dereference(self._ptr).PenPressure
        return res
    @pen_pressure.setter
    def pen_pressure(self, value: float):
        # dereference(self._ptr).PenPressure = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def platform_locale_decimal_point(self):
    #     """
    #     Optional: Platform locale
    #     '.'  // [experimental] configure decimal point e.g. '.' or ',' useful for some languages (e.g. german), generally pulled from *localeconv()->decimal_point
    #     """
    #     cdef ccimgui.ImWchar res = dereference(self._ptr).PlatformLocaleDecimalPoint
    #     return res
    # @platform_locale_decimal_point.setter
    # def platform_locale_decimal_point(self, value: int):
    #     # dereference(self._ptr).PlatformLocaleDecimalPoint = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    @property
    def set_clipboard_text_fn(self):
        return _io_clipboard[<uintptr_t>ccimgui.ImGui_GetCurrentContext()]['_set_clipboard_text_fn']
    @set_clipboard_text_fn.setter
    def set_clipboard_text_fn(self, value: Callable):
        if callable(value):
            _io_clipboard[<uintptr_t>ccimgui.ImGui_GetCurrentContext()]['_set_clipboard_text_fn'] = value
            dereference(self._ptr).SetClipboardTextFn = self._set_clipboard_text
        else:
            raise ValueError("func is not a callable: %s" % str(value))
    
    @staticmethod
    cdef void _set_clipboard_text(void* user_data, const char* text) noexcept:
        _io_clipboard[<uintptr_t>ccimgui.ImGui_GetCurrentContext()]['_set_clipboard_text_fn'](_from_bytes(text))
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def set_platform_ime_data_fn(self):
    #     """
    #     Optional: Notify OS Input Method Editor of the screen position of your cursor for text input position (e.g. when using Japanese/Chinese IME on Windows)
    #     (default to use native imm32 api on Windows)
    #     """
    #     cdef Callable res = dereference(self._ptr).SetPlatformImeDataFn
    #     return res
    # @set_platform_ime_data_fn.setter
    # def set_platform_ime_data_fn(self, value: Callable):
    #     # dereference(self._ptr).SetPlatformImeDataFn = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    _imgui_io_user_data = {}
    @property
    def user_data(self):
        """
        = null   // store your own data.
        pygui note: Store anything in here if you need.
        """
        cdef uintptr_t lookup = <uintptr_t>ccimgui.ImGui_GetCurrentContext()
        if lookup in self._imgui_io_user_data:
            return self._imgui_io_user_data[lookup]
        return None
    @user_data.setter
    def user_data(self, value: Any):
        cdef uintptr_t lookup = <uintptr_t>ccimgui.ImGui_GetCurrentContext()
        self._imgui_io_user_data[lookup] = value
        # dereference(self._ptr).UserData = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def want_capture_keyboard(self):
        """
        Set when dear imgui will use keyboard inputs, in this case do not dispatch them to your main game/application (either way, always pass keyboard inputs to imgui). (e.g. inputtext active, or an imgui window is focused and navigation is enabled, etc.).
        """
        cdef bool res = dereference(self._ptr).WantCaptureKeyboard
        return res
    @want_capture_keyboard.setter
    def want_capture_keyboard(self, value: bool):
        # dereference(self._ptr).WantCaptureKeyboard = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def want_capture_mouse(self):
        """
        Set when dear imgui will use mouse inputs, in this case do not dispatch them to your main game/application (either way, always pass on mouse inputs to imgui). (e.g. unclicked mouse is hovering over an imgui window, widget is active, mouse was clicked over an imgui window, etc.).
        """
        cdef bool res = dereference(self._ptr).WantCaptureMouse
        return res
    @want_capture_mouse.setter
    def want_capture_mouse(self, value: bool):
        # dereference(self._ptr).WantCaptureMouse = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def want_capture_mouse_unless_popup_close(self):
        """
        Alternative to wantcapturemouse: (wantcapturemouse == true && wantcapturemouseunlesspopupclose == false) when a click over void is expected to close a popup.
        """
        cdef bool res = dereference(self._ptr).WantCaptureMouseUnlessPopupClose
        return res
    @want_capture_mouse_unless_popup_close.setter
    def want_capture_mouse_unless_popup_close(self, value: bool):
        # dereference(self._ptr).WantCaptureMouseUnlessPopupClose = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def want_save_ini_settings(self):
        """
        When manual .ini load/save is active (io.inifilename == null), this will be set to notify your application that you can call saveinisettingstomemory() and save yourself. important: clear io.wantsaveinisettings yourself after saving!
        """
        cdef bool res = dereference(self._ptr).WantSaveIniSettings
        return res
    @want_save_ini_settings.setter
    def want_save_ini_settings(self, value: bool):
        # dereference(self._ptr).WantSaveIniSettings = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def want_set_mouse_pos(self):
        """
        Mousepos has been altered, backend should reposition mouse on next frame. rarely used! set only when imguiconfigflags_navenablesetmousepos flag is enabled.
        """
        cdef bool res = dereference(self._ptr).WantSetMousePos
        return res
    @want_set_mouse_pos.setter
    def want_set_mouse_pos(self, value: bool):
        # dereference(self._ptr).WantSetMousePos = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def want_text_input(self):
        """
        Mobile/console: when set, you may display an on-screen keyboard. this is set by dear imgui when it wants textual keyboard input to happen (e.g. when a inputtext widget is active).
        """
        cdef bool res = dereference(self._ptr).WantTextInput
        return res
    @want_text_input.setter
    def want_text_input(self, value: bool):
        # dereference(self._ptr).WantTextInput = value
        raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_focus_event(self: ImGuiIO, focused: bool):
    #     """
    #     Queue a gain/loss of focus for the application (generally based on os/platform focus of your window)
    #     """
    #     ccimgui.ImGuiIO_AddFocusEvent(
    #         self._ptr,
    #         focused
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_input_character(self: ImGuiIO, c: int):
        """
        Queue a new character input
        """
        ccimgui.ImGuiIO_AddInputCharacter(
            self._ptr,
            c
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_input_character_utf_16(self: ImGuiIO, c: int):
    #     """
    #     Queue a new character input from a utf-16 character, it can be a surrogate
    #     """
    #     ccimgui.ImGuiIO_AddInputCharacterUTF16(
    #         self._ptr,
    #         c
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_input_characters_utf_8(self: ImGuiIO, str_: str):
    #     """
    #     Queue a new characters input from a utf-8 string
    #     """
    #     ccimgui.ImGuiIO_AddInputCharactersUTF8(
    #         self._ptr,
    #         _bytes(str_)
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_key_analog_event(self: ImGuiIO, key: int, down: bool, v: float):
    #     """
    #     Queue a new key down/up event for analog values (e.g. imguikey_gamepad_ values). dead-zones should be handled by the backend.
    #     """
    #     ccimgui.ImGuiIO_AddKeyAnalogEvent(
    #         self._ptr,
    #         key,
    #         down,
    #         v
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_key_event(self: ImGuiIO, key: int, down: bool):
        """
        Input Functions
        Queue a new key down/up event. key should be 'translated' (as in, generally imguikey_a matches the key end-user would use to emit an 'a' character)
        """
        ccimgui.ImGuiIO_AddKeyEvent(
            self._ptr,
            key,
            down
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_mouse_button_event(self: ImGuiIO, button: int, down: bool):
        """
        Queue a mouse button change
        """
        ccimgui.ImGuiIO_AddMouseButtonEvent(
            self._ptr,
            button,
            down
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_mouse_pos_event(self: ImGuiIO, x: float, y: float):
        """
        Queue a mouse position update. use -flt_max,-flt_max to signify no mouse (e.g. app not focused and not hovered)
        """
        ccimgui.ImGuiIO_AddMousePosEvent(
            self._ptr,
            x,
            y
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_mouse_source_event(self: ImGuiIO, source: int):
    #     """
    #     Queue a mouse source change (mouse/touchscreen/pen)
    #     """
    #     ccimgui.ImGuiIO_AddMouseSourceEvent(
    #         self._ptr,
    #         source
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def add_mouse_viewport_event(self: ImGuiIO, id_: int):
    #     """
    #     Queue a mouse hovered viewport. requires backend to set imguibackendflags_hasmousehoveredviewport to call this (for multi-viewport support).
    #     """
    #     ccimgui.ImGuiIO_AddMouseViewportEvent(
    #         self._ptr,
    #         id_
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def add_mouse_wheel_event(self: ImGuiIO, wheel_x: float, wheel_y: float):
        """
        Queue a mouse wheel update. wheel_y<0: scroll down, wheel_y>0: scroll up, wheel_x<0: scroll right, wheel_x>0: scroll left.
        """
        ccimgui.ImGuiIO_AddMouseWheelEvent(
            self._ptr,
            wheel_x,
            wheel_y
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear_events_queue(self: ImGuiIO):
    #     """
    #     Clear all incoming events.
    #     """
    #     ccimgui.ImGuiIO_ClearEventsQueue(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear_input_keys(self: ImGuiIO):
    #     """
    #     Clear current keyboard/mouse/gamepad state + current frame text input buffer. equivalent to releasing all keys/buttons.
    #     """
    #     ccimgui.ImGuiIO_ClearInputKeys(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_app_accepting_events(self: ImGuiIO, accepting_events: bool):
    #     """
    #     Set master flag for accepting key/mouse/text events (default to true). useful if you have native dialog boxes that are interrupting your application loop/refresh, and you want to disable events being queued while your app is frozen.
    #     """
    #     ccimgui.ImGuiIO_SetAppAcceptingEvents(
    #         self._ptr,
    #         accepting_events
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_key_event_native_data(self: ImGuiIO, key: int, native_keycode: int, native_scancode: int):
    #     """
    #     Implied native_legacy_index = -1
    #     """
    #     ccimgui.ImGuiIO_SetKeyEventNativeData(
    #         self._ptr,
    #         key,
    #         native_keycode,
    #         native_scancode
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_key_event_native_data_ex(self: ImGuiIO, key: int, native_keycode: int, native_scancode: int, native_legacy_index: int=-1):
    #     """
    #     [optional] specify index for legacy <1.87 iskeyxxx() functions with native indices + specify native keycode, scancode.
    #     """
    #     ccimgui.ImGuiIO_SetKeyEventNativeDataEx(
    #         self._ptr,
    #         key,
    #         native_keycode,
    #         native_scancode,
    #         native_legacy_index
    #     )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiInputTextCallbackData:
    """
    Shared state of InputText(), passed as an argument to your callback when a ImGuiInputTextFlags_Callback* flag is used.
    The callback function should return 0 by default.
    Callbacks (follow a flag name and see comments in ImGuiInputTextFlags_ declarations for more details)
    - ImGuiInputTextFlags_CallbackEdit:Callback on buffer edit (note that InputText() already returns true on edit, the callback is useful mainly to manipulate the underlying buffer while focus is active)
    - ImGuiInputTextFlags_CallbackAlways:  Callback on each iteration
    - ImGuiInputTextFlags_CallbackCompletion:  Callback on pressing TAB
    - ImGuiInputTextFlags_CallbackHistory: Callback on pressing Up/Down arrows
    - ImGuiInputTextFlags_CallbackCharFilter:  Callback on character inputs to replace or discard them. Modify 'EventChar' to replace or discard, or return 1 in callback to discard.
    - ImGuiInputTextFlags_CallbackResize:  Callback on buffer capacity changes request (beyond 'buf_size' parameter value), allowing the string to grow.
    """
    cdef ccimgui.ImGuiInputTextCallbackData* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiInputTextCallbackData from_ptr(ccimgui.ImGuiInputTextCallbackData* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiInputTextCallbackData wrapper = ImGuiInputTextCallbackData.__new__(ImGuiInputTextCallbackData)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiInputTextCallbackData from_heap_ptr(ccimgui.ImGuiInputTextCallbackData* _ptr):
        wrapper = ImGuiInputTextCallbackData.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    @property
    def buf(self):
        """
        Text buffer  // read-write   // [resize] can replace pointer / [completion,history,always] only write to pointed data, don't replace the actual pointer!
        """
        cdef char* res = dereference(self._ptr).Buf
        return _from_bytes(res)
    @buf.setter
    def buf(self, value: str):
        strncpy(dereference(self._ptr).Buf, _bytes(value), len(_bytes(value)))
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def buf_dirty(self):
        """
        Set if you modify buf/buftextlen!// write// [completion,history,always]
        """
        cdef bool res = dereference(self._ptr).BufDirty
        return res
    @buf_dirty.setter
    def buf_dirty(self, value: bool):
        dereference(self._ptr).BufDirty = value
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def buf_size(self):
        """
        Buffer size (in bytes) = capacity+1  // read-only// [resize,completion,history,always] include zero-terminator storage. in c land == arraysize(my_char_array), in c++ land: string.capacity()+1
        """
        cdef int res = dereference(self._ptr).BufSize
        return res
    @buf_size.setter
    def buf_size(self, value: int):
        # dereference(self._ptr).BufSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def buf_text_len(self):
        """
        Text length (in bytes)   // read-write   // [resize,completion,history,always] exclude zero-terminator storage. in c land: == strlen(some_text), in c++ land: string.length()
        """
        cdef int res = dereference(self._ptr).BufTextLen
        return res
    @buf_text_len.setter
    def buf_text_len(self, value: int):
        # dereference(self._ptr).BufTextLen = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGuiContext)
    @property
    def ctx(self):
        """
        Parent ui context
        """
        cdef ccimgui.ImGuiContext* res = dereference(self._ptr).Ctx
        return ImGuiContext.from_ptr(res)
    @ctx.setter
    def ctx(self, value: ImGuiContext):
        # dereference(self._ptr).Ctx = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def cursor_pos(self):
        """
        Read-write   // [completion,history,always]
        """
        cdef int res = dereference(self._ptr).CursorPos
        return res
    @cursor_pos.setter
    def cursor_pos(self, value: int):
        # dereference(self._ptr).CursorPos = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def event_char(self):
        """
        Arguments for the different callback events
        - During Resize callback, Buf will be same as your input buffer.
        - However, during Completion/History/Always callback, Buf always points to our own internal data (it is not the same as your buffer)! Changes to it will be reflected into your own buffer shortly after the callback.
        - To modify the text buffer in a callback, prefer using the InsertChars() / DeleteChars() function. InsertChars() will take care of calling the resize callback if necessary.
        - If you know your edits are not going to resize the underlying buffer allocation, you may modify the contents of 'Buf[]' directly. You need to update 'BufTextLen' accordingly (0 <= BufTextLen < BufSize) and set 'BufDirty'' to true so InputText can update its internal state.
        Character input  // read-write   // [charfilter] replace character with another one, or set to zero to drop. return 1 is equivalent to setting eventchar=0;
        """
        cdef ccimgui.ImWchar res = dereference(self._ptr).EventChar
        return res
    @event_char.setter
    def event_char(self, value: int):
        # dereference(self._ptr).EventChar = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def event_flag(self):
        """
        One imguiinputtextflags_callback*// read-only
        """
        cdef ccimgui.ImGuiInputTextFlags res = dereference(self._ptr).EventFlag
        return res
    @event_flag.setter
    def event_flag(self, value: int):
        # dereference(self._ptr).EventFlag = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def event_key(self):
        """
        Key pressed (up/down/tab)// read-only// [completion,history]
        """
        cdef ccimgui.ImGuiKey res = dereference(self._ptr).EventKey
        return res
    @event_key.setter
    def event_key(self, value: int):
        # dereference(self._ptr).EventKey = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def flags(self):
        """
        What user passed to inputtext()  // read-only
        """
        cdef ccimgui.ImGuiInputTextFlags res = dereference(self._ptr).Flags
        return res
    @flags.setter
    def flags(self, value: int):
        # dereference(self._ptr).Flags = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def selection_end(self):
        """
        Read-write   // [completion,history,always]
        """
        cdef int res = dereference(self._ptr).SelectionEnd
        return res
    @selection_end.setter
    def selection_end(self, value: int):
        # dereference(self._ptr).SelectionEnd = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def selection_start(self):
        """
        Read-write   // [completion,history,always] == to selectionend when no selection)
        """
        cdef int res = dereference(self._ptr).SelectionStart
        return res
    @selection_start.setter
    def selection_start(self, value: int):
        # dereference(self._ptr).SelectionStart = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    @property
    def user_data(self):
        """
        What user passed to inputtext()  // read-only
        """
        cdef ccimgui.ImGuiID widget_id = <ccimgui.ImGuiID>dereference(self._ptr).UserData
        if widget_id not in _input_text_user_data:
            raise RuntimeError("Did not find widget_id: {}".format(widget_id))
        
        callback, user_data = _input_text_user_data[widget_id]
        return user_data
    @user_data.setter
    def user_data(self, value: Any):
        # dereference(self._ptr).UserData = value
        raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def clear_selection(self: ImGuiInputTextCallbackData):
        ccimgui.ImGuiInputTextCallbackData_ClearSelection(
            self._ptr
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def delete_chars(self: ImGuiInputTextCallbackData, pos: int, bytes_count: int):
        ccimgui.ImGuiInputTextCallbackData_DeleteChars(
            self._ptr,
            pos,
            bytes_count
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    def has_selection(self: ImGuiInputTextCallbackData):
        cdef bool res = ccimgui.ImGuiInputTextCallbackData_HasSelection(
            self._ptr
        )
        return res
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def insert_chars(self: ImGuiInputTextCallbackData, pos: int, text: str):
        ccimgui.ImGuiInputTextCallbackData_InsertChars(
            self._ptr,
            pos,
            _bytes(text),
            NULL
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def select_all(self: ImGuiInputTextCallbackData):
        ccimgui.ImGuiInputTextCallbackData_SelectAll(
            self._ptr
        )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiKeyData:
    """
    [Internal] Storage used by IsKeyDown(), IsKeyPressed() etc functions.
    If prior to 1.87 you used io.KeysDownDuration[] (which was marked as internal), you should use GetKeyData(key)->DownDuration and *NOT* io.KeysData[key]->DownDuration.
    """
    cdef ccimgui.ImGuiKeyData* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiKeyData from_ptr(ccimgui.ImGuiKeyData* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiKeyData wrapper = ImGuiKeyData.__new__(ImGuiKeyData)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiKeyData from_heap_ptr(ccimgui.ImGuiKeyData* _ptr):
        wrapper = ImGuiKeyData.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def analog_value(self):
        """
        0.0f..1.0f for gamepad values
        """
        cdef float res = dereference(self._ptr).AnalogValue
        return res
    @analog_value.setter
    def analog_value(self, value: float):
        # dereference(self._ptr).AnalogValue = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def down(self):
        """
        True for if key is down
        """
        cdef bool res = dereference(self._ptr).Down
        return res
    @down.setter
    def down(self, value: bool):
        # dereference(self._ptr).Down = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def down_duration(self):
        """
        Duration the key has been down (<0.0f: not pressed, 0.0f: just pressed, >0.0f: time held)
        """
        cdef float res = dereference(self._ptr).DownDuration
        return res
    @down_duration.setter
    def down_duration(self, value: float):
        # dereference(self._ptr).DownDuration = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def down_duration_prev(self):
        """
        Last frame duration the key has been down
        """
        cdef float res = dereference(self._ptr).DownDurationPrev
        return res
    @down_duration_prev.setter
    def down_duration_prev(self, value: float):
        # dereference(self._ptr).DownDurationPrev = value
        raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(True)
cdef class ImGuiListClipper:
    """
    Helper: Manually clip large list of items.
    If you have lots evenly spaced items and you have random access to the list, you can perform coarse
    clipping based on visibility to only submit items that are in view.
    The clipper calculates the range of visible items and advance the cursor to compensate for the non-visible items we have skipped.
    (Dear ImGui already clip items based on their bounds but: it needs to first layout the item to do so, and generally
    fetching/submitting your own data incurs additional cost. Coarse clipping using ImGuiListClipper allows you to easily
    scale using lists with tens of thousands of items without a problem)
    Usage:
    ImGuiListClipper clipper;
    clipper.Begin(1000); // We have 1000 elements, evenly spaced.
    while (clipper.Step())
    for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
    ImGui::Text("line number %d", i);
    Generally what happens is:
    - Clipper lets you process the first element (DisplayStart = 0, DisplayEnd = 1) regardless of it being visible or not.
    - User code submit that one element.
    - Clipper can measure the height of the first element
    - Clipper calculate the actual range of elements to display based on the current clipping rectangle, position the cursor before the first visible element.
    - User code submit visible elements.
    - The clipper also handles various subtleties related to keyboard/gamepad navigation, wrapping etc.
    pygui note: This class is instantiable with ImGuiListClipper.create()
    """
    cdef ccimgui.ImGuiListClipper* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiListClipper from_ptr(ccimgui.ImGuiListClipper* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiListClipper wrapper = ImGuiListClipper.__new__(ImGuiListClipper)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiListClipper from_heap_ptr(ccimgui.ImGuiListClipper* _ptr):
        wrapper = ImGuiListClipper.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGuiContext)
    @property
    def ctx(self):
        """
        Parent ui context
        """
        cdef ccimgui.ImGuiContext* res = dereference(self._ptr).Ctx
        return ImGuiContext.from_ptr(res)
    @ctx.setter
    def ctx(self, value: ImGuiContext):
        # dereference(self._ptr).Ctx = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def display_end(self):
        """
        End of items to display (exclusive)
        """
        cdef int res = dereference(self._ptr).DisplayEnd
        return res
    @display_end.setter
    def display_end(self, value: int):
        # dereference(self._ptr).DisplayEnd = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def display_start(self):
        """
        First item to display, updated by each call to step()
        """
        cdef int res = dereference(self._ptr).DisplayStart
        return res
    @display_start.setter
    def display_start(self, value: int):
        # dereference(self._ptr).DisplayStart = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def items_count(self):
    #     """
    #     [internal] number of items
    #     """
    #     cdef int res = dereference(self._ptr).ItemsCount
    #     return res
    # @items_count.setter
    # def items_count(self, value: int):
    #     # dereference(self._ptr).ItemsCount = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def items_height(self):
    #     """
    #     [internal] height of item after a first step and item submission can calculate it
    #     """
    #     cdef float res = dereference(self._ptr).ItemsHeight
    #     return res
    # @items_height.setter
    # def items_height(self, value: float):
    #     # dereference(self._ptr).ItemsHeight = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def start_pos_y(self):
    #     """
    #     [internal] cursor position at the time of begin() or after table frozen rows are all processed
    #     """
    #     cdef float res = dereference(self._ptr).StartPosY
    #     return res
    # @start_pos_y.setter
    # def start_pos_y(self, value: float):
    #     # dereference(self._ptr).StartPosY = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def temp_data(self):
    #     """
    #     [internal] internal data
    #     """
    #     cdef void* res = dereference(self._ptr).TempData
    #     return res
    # @temp_data.setter
    # def temp_data(self, value: Any):
    #     # dereference(self._ptr).TempData = value
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def begin(self: ImGuiListClipper, items_count: int, items_height: float=-1.0):
        ccimgui.ImGuiListClipper_Begin(
            self._ptr,
            items_count,
            items_height
        )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(ImGuiListClipper)
    @staticmethod
    def create():
        """
        Create a dynamically allocated instance of ImGuiListClipper. Must
        also be freed with destroy().
        """
        cdef ccimgui.ImGuiListClipper* clipper = <ccimgui.ImGuiListClipper*>ccimgui.ImGui_MemAlloc(sizeof(ccimgui.ImGuiListClipper))
        # DearBindings doesn't expose constructors but zero initialisation has
        # been added for this class.

        memset(clipper, 0, sizeof(ccimgui.ImGuiListClipper))
        return ImGuiListClipper.from_heap_ptr(clipper)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(None)
    def destroy(self: ImGuiListClipper):
        """
        Explicitly frees this instance.
        """
        if self._ptr != NULL:
            ccimgui.ImGui_MemFree(self._ptr)
            self._ptr = NULL
    def __dealloc__(self):
        """
        Just in case the user forgets to free the memory.
        """
        if not self.dynamically_allocated:
            return
        
        self.destroy()
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    def end(self: ImGuiListClipper):
        """
        Automatically called on the last call of step() that returns false.
        """
        ccimgui.ImGuiListClipper_End(
            self._ptr
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(True)
    # ?returns(None)
    def include_item_by_index(self: ImGuiListClipper, item_index: int):
        """
        Call IncludeItemByIndex() or IncludeItemsByIndex() *BEFORE* first call to Step() if you need a range of items to not be clipped, regardless of their visibility.
        (Due to alignment / padding of certain items it is possible that an extra item may be included on either end of the display range).
        """
        ccimgui.ImGuiListClipper_IncludeItemByIndex(
            self._ptr,
            item_index
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(True)
    # ?returns(None)
    def include_items_by_index(self: ImGuiListClipper, item_begin: int, item_end: int):
        """
        Item_end is exclusive e.g. use (42, 42+1) to make item 42 never clipped.

        [#6424](https://github.com/ocornut/imgui/issues/6424) JaedanC Easteregg. This is my suggestion!
        """
        ccimgui.ImGuiListClipper_IncludeItemsByIndex(
            self._ptr,
            item_begin,
            item_end
        )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    def step(self: ImGuiListClipper):
        """
        Call until it returns false. the displaystart/displayend fields will be set and you can process/draw those items.
        """
        cdef bool res = ccimgui.ImGuiListClipper_Step(
            self._ptr
        )
        return res
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiPayload:
    """
    Data payload for Drag and Drop operations: AcceptDragDropPayload(), GetDragDropPayload()
    """
    cdef const ccimgui.ImGuiPayload* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiPayload from_ptr(const ccimgui.ImGuiPayload* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiPayload wrapper = ImGuiPayload.__new__(ImGuiPayload)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiPayload from_heap_ptr(ccimgui.ImGuiPayload* _ptr):
        wrapper = ImGuiPayload.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Vec4 | Any)
    @property
    def data(self):
        """
        Data (copied and owned by dear imgui)
        pygui note: Nope, the data is owned by us :). If the payload came from
        imgui we use that instead.
        """
        _type = _from_bytes(dereference(self._ptr).DataType)
        # This check is only possible because we pass in _drag_drop_constant
        # into set_drag_drop_payload
        _drag_drop_constant
        cdef void* data = dereference(self._ptr).Data
        if data is NULL:
            return None
        
        cdef float* colour
        if _type == PAYLOAD_TYPE_COLOR_3F:
            colour = <float*>data
            return Vec4(
                colour[0],
                colour[1],
                colour[2],
                1
            )
        elif _type == PAYLOAD_TYPE_COLOR_4F:
            colour = <float*>data
            return Vec4(
                colour[0],
                colour[1],
                colour[2],
                colour[3]
            )
        cdef uintptr_t lookup = <uintptr_t>ccimgui.ImGui_GetCurrentContext()
        if lookup in _drag_drop_payload:
            return _drag_drop_payload[lookup]
        return None
    @data.setter
    def data(self, value: Any):
        # dereference(self._ptr).Data = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def data_frame_count(self):
        """
        Data timestamp
        """
        cdef int res = dereference(self._ptr).DataFrameCount
        return res
    @data_frame_count.setter
    def data_frame_count(self, value: int):
        # dereference(self._ptr).DataFrameCount = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def data_size(self):
        """
        Data size.
        pygui note: It doesn't make much sense to keep this in the API because
        the type passed to set_drag_drop_payload is a constant integer. The data
        passed to pygui doesn't go to imgui, but rather stays inside cython so
        that we can accept abitrary python objects. This function then just
        calls len(_drag_drop_payload), which is still not ideal but better than
        returning sizeof(int) I guess.
        """
        cdef uintptr_t lookup = <uintptr_t>ccimgui.ImGui_GetCurrentContext()
        if lookup in _drag_drop_payload:
           return len(_drag_drop_payload[lookup])
        return 0
    @data_size.setter
    def data_size(self, value: int):
        # dereference(self._ptr).DataSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def data_type(self):
        """
        Data type tag (short user-supplied string, 32 characters max)
        """
        # Explicit cast is required
        cdef char* res = <char*>dereference(self._ptr).DataType
        return _from_bytes(res)
    @data_type.setter
    def data_type(self, value: str):
        # dereference(self._ptr).DataType = _bytes(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def delivery(self):
        """
        Set when acceptdragdroppayload() was called and mouse button is released over the target item.
        """
        cdef bool res = dereference(self._ptr).Delivery
        return res
    @delivery.setter
    def delivery(self, value: bool):
        # dereference(self._ptr).Delivery = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def preview(self):
        """
        Set when acceptdragdroppayload() was called and mouse has been hovering the target item (nb: handle overlapping drag targets)
        """
        cdef bool res = dereference(self._ptr).Preview
        return res
    @preview.setter
    def preview(self, value: bool):
        # dereference(self._ptr).Preview = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def source_id(self):
        """
        [Internal]
        Source item id
        """
        cdef ccimgui.ImGuiID res = dereference(self._ptr).SourceId
        return res
    @source_id.setter
    def source_id(self, value: int):
        # dereference(self._ptr).SourceId = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def source_parent_id(self):
        """
        Source parent id (if available)
        """
        cdef ccimgui.ImGuiID res = dereference(self._ptr).SourceParentId
        return res
    @source_parent_id.setter
    def source_parent_id(self, value: int):
        # dereference(self._ptr).SourceParentId = value
        raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear(self: ImGuiPayload):
    #     ccimgui.ImGuiPayload_Clear(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def is_data_type(self: ImGuiPayload, type_: str):
    #     cdef bool res = ccimgui.ImGuiPayload_IsDataType(
    #         self._ptr,
    #         _bytes(type_)
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def is_delivery(self: ImGuiPayload):
    #     cdef bool res = ccimgui.ImGuiPayload_IsDelivery(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def is_preview(self: ImGuiPayload):
    #     cdef bool res = ccimgui.ImGuiPayload_IsPreview(
    #         self._ptr
    #     )
    #     return res
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiPlatformIO:
    """
    (Optional) Access via ImGui::GetPlatformIO()
    """
    cdef ccimgui.ImGuiPlatformIO* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiPlatformIO from_ptr(ccimgui.ImGuiPlatformIO* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiPlatformIO wrapper = ImGuiPlatformIO.__new__(ImGuiPlatformIO)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiPlatformIO from_heap_ptr(ccimgui.ImGuiPlatformIO* _ptr):
        wrapper = ImGuiPlatformIO.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImGuiPlatformMonitor])
    @property
    def monitors(self):
        """
        (Optional) Monitor list
        - Updated by: app/backend. Update every frame to dynamically support changing monitor or DPI configuration.
        - Used by: dear imgui to query DPI info, clamp popups/tooltips within same monitor and not have them straddle monitors.
        """
        return [
            ImGuiPlatformMonitor.from_ptr(&dereference(self._ptr).Monitors.Data[idx])
            for idx in range(dereference(self._ptr).Monitors.Size)
        ]
    @monitors.setter
    def monitors(self, value: ImVector_ImGuiPlatformMonitor):
        # dereference(self._ptr).Monitors = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_create_vk_surface(self):
    #     """
    #     (optional) for a vulkan renderer to call into platform code (since the surface creation needs to tie them both).
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_CreateVkSurface
    #     return res
    # @platform_create_vk_surface.setter
    # def platform_create_vk_surface(self, value: Callable):
    #     # dereference(self._ptr).Platform_CreateVkSurface = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_create_window(self):
    #     """
    #     Platform function --------------------------------------------------- Called by -----
    #     . . u . .  // create a new platform window for the given viewport
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_CreateWindow
    #     return res
    # @platform_create_window.setter
    # def platform_create_window(self, value: Callable):
    #     # dereference(self._ptr).Platform_CreateWindow = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_destroy_window(self):
    #     """
    #     N . u . d  //
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_DestroyWindow
    #     return res
    # @platform_destroy_window.setter
    # def platform_destroy_window(self, value: Callable):
    #     # dereference(self._ptr).Platform_DestroyWindow = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_get_window_dpi_scale(self):
    #     """
    #     N . . . .  // (optional) [beta] fixme-dpi: dpi handling: return dpi scale for this viewport. 1.0f = 96 dpi.
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_GetWindowDpiScale
    #     return res
    # @platform_get_window_dpi_scale.setter
    # def platform_get_window_dpi_scale(self, value: Callable):
    #     # dereference(self._ptr).Platform_GetWindowDpiScale = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_get_window_focus(self):
    #     """
    #     . . u . .  //
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_GetWindowFocus
    #     return res
    # @platform_get_window_focus.setter
    # def platform_get_window_focus(self, value: Callable):
    #     # dereference(self._ptr).Platform_GetWindowFocus = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_get_window_minimized(self):
    #     """
    #     N . . . .  // get platform window minimized state. when minimized, we generally won't attempt to get/set size and contents will be culled more easily
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_GetWindowMinimized
    #     return res
    # @platform_get_window_minimized.setter
    # def platform_get_window_minimized(self, value: Callable):
    #     # dereference(self._ptr).Platform_GetWindowMinimized = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_get_window_pos(self):
    #     """
    #     N . . . .  //
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_GetWindowPos
    #     return res
    # @platform_get_window_pos.setter
    # def platform_get_window_pos(self, value: Callable):
    #     # dereference(self._ptr).Platform_GetWindowPos = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_get_window_size(self):
    #     """
    #     N . . . .  // get platform window client area size
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_GetWindowSize
    #     return res
    # @platform_get_window_size.setter
    # def platform_get_window_size(self, value: Callable):
    #     # dereference(self._ptr).Platform_GetWindowSize = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_on_changed_viewport(self):
    #     """
    #     . f . . .  // (optional) [beta] fixme-dpi: dpi handling: called during begin() every time the viewport we are outputting into changes, so backend has a chance to swap fonts to adjust style.
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_OnChangedViewport
    #     return res
    # @platform_on_changed_viewport.setter
    # def platform_on_changed_viewport(self, value: Callable):
    #     # dereference(self._ptr).Platform_OnChangedViewport = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_render_window(self):
    #     """
    #     . . . r .  // (optional) main rendering (platform side! this is often unused, or just setting a 'current' context for opengl bindings). 'render_arg' is the value passed to renderplatformwindowsdefault().
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_RenderWindow
    #     return res
    # @platform_render_window.setter
    # def platform_render_window(self, value: Callable):
    #     # dereference(self._ptr).Platform_RenderWindow = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_set_window_alpha(self):
    #     """
    #     . . u . .  // (optional) setup global transparency (not per-pixel transparency)
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_SetWindowAlpha
    #     return res
    # @platform_set_window_alpha.setter
    # def platform_set_window_alpha(self, value: Callable):
    #     # dereference(self._ptr).Platform_SetWindowAlpha = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_set_window_focus(self):
    #     """
    #     N . . . .  // move window to front and set input focus
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_SetWindowFocus
    #     return res
    # @platform_set_window_focus.setter
    # def platform_set_window_focus(self, value: Callable):
    #     # dereference(self._ptr).Platform_SetWindowFocus = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_set_window_pos(self):
    #     """
    #     . . u . .  // set platform window position (given the upper-left corner of client area)
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_SetWindowPos
    #     return res
    # @platform_set_window_pos.setter
    # def platform_set_window_pos(self, value: Callable):
    #     # dereference(self._ptr).Platform_SetWindowPos = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_set_window_size(self):
    #     """
    #     . . u . .  // set platform window client area size (ignoring os decorations such as os title bar etc.)
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_SetWindowSize
    #     return res
    # @platform_set_window_size.setter
    # def platform_set_window_size(self, value: Callable):
    #     # dereference(self._ptr).Platform_SetWindowSize = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_set_window_title(self):
    #     """
    #     . . u . .  // set platform window title (given an utf-8 string)
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_SetWindowTitle
    #     return res
    # @platform_set_window_title.setter
    # def platform_set_window_title(self, value: Callable):
    #     # dereference(self._ptr).Platform_SetWindowTitle = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_show_window(self):
    #     """
    #     . . u . .  // newly created windows are initially hidden so setwindowpos/size/title can be called on them before showing the window
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_ShowWindow
    #     return res
    # @platform_show_window.setter
    # def platform_show_window(self, value: Callable):
    #     # dereference(self._ptr).Platform_ShowWindow = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_swap_buffers(self):
    #     """
    #     . . . r .  // (optional) call present/swapbuffers (platform side! this is often unused!). 'render_arg' is the value passed to renderplatformwindowsdefault().
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_SwapBuffers
    #     return res
    # @platform_swap_buffers.setter
    # def platform_swap_buffers(self, value: Callable):
    #     # dereference(self._ptr).Platform_SwapBuffers = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def platform_update_window(self):
    #     """
    #     . . u . .  // (optional) called by updateplatformwindows(). optional hook to allow the platform backend from doing general book-keeping every frame.
    #     """
    #     cdef Callable res = dereference(self._ptr).Platform_UpdateWindow
    #     return res
    # @platform_update_window.setter
    # def platform_update_window(self, value: Callable):
    #     # dereference(self._ptr).Platform_UpdateWindow = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def renderer_create_window(self):
    #     """
    #     (Optional) Renderer functions (e.g. DirectX, OpenGL, Vulkan)
    #     . . u . .  // create swap chain, frame buffers etc. (called after platform_createwindow)
    #     """
    #     cdef Callable res = dereference(self._ptr).Renderer_CreateWindow
    #     return res
    # @renderer_create_window.setter
    # def renderer_create_window(self, value: Callable):
    #     # dereference(self._ptr).Renderer_CreateWindow = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def renderer_destroy_window(self):
    #     """
    #     N . u . d  // destroy swap chain, frame buffers etc. (called before platform_destroywindow)
    #     """
    #     cdef Callable res = dereference(self._ptr).Renderer_DestroyWindow
    #     return res
    # @renderer_destroy_window.setter
    # def renderer_destroy_window(self, value: Callable):
    #     # dereference(self._ptr).Renderer_DestroyWindow = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def renderer_render_window(self):
    #     """
    #     . . . r .  // (optional) clear framebuffer, setup render target, then render the viewport->drawdata. 'render_arg' is the value passed to renderplatformwindowsdefault().
    #     """
    #     cdef Callable res = dereference(self._ptr).Renderer_RenderWindow
    #     return res
    # @renderer_render_window.setter
    # def renderer_render_window(self, value: Callable):
    #     # dereference(self._ptr).Renderer_RenderWindow = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def renderer_set_window_size(self):
    #     """
    #     . . u . .  // resize swap chain, frame buffers etc. (called after platform_setwindowsize)
    #     """
    #     cdef Callable res = dereference(self._ptr).Renderer_SetWindowSize
    #     return res
    # @renderer_set_window_size.setter
    # def renderer_set_window_size(self, value: Callable):
    #     # dereference(self._ptr).Renderer_SetWindowSize = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Callable)
    # @property
    # def renderer_swap_buffers(self):
    #     """
    #     . . . r .  // (optional) call present/swapbuffers. 'render_arg' is the value passed to renderplatformwindowsdefault().
    #     """
    #     cdef Callable res = dereference(self._ptr).Renderer_SwapBuffers
    #     return res
    # @renderer_swap_buffers.setter
    # def renderer_swap_buffers(self, value: Callable):
    #     # dereference(self._ptr).Renderer_SwapBuffers = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImGuiViewport])
    @property
    def viewports(self):
        """
        Viewports list (the list is updated by calling ImGui::EndFrame or ImGui::Render)
        (in the future we will attempt to organize this feature to remove the need for a "main viewport")
        Main viewports, followed by all secondary viewports.
        """
        return [
            ImGuiViewport.from_ptr(dereference(self._ptr).Viewports.Data[idx])
            for idx in range(dereference(self._ptr).Viewports.Size)
        ]
    @viewports.setter
    def viewports(self, value: ImVector_ImGuiViewportPtr):
        # dereference(self._ptr).Viewports = value._ptr
        raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiPlatformImeData:
    """
    (Optional) Support for IME (Input Method Editor) via the io.SetPlatformImeDataFn() function.
    """
    cdef ccimgui.ImGuiPlatformImeData* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiPlatformImeData from_ptr(ccimgui.ImGuiPlatformImeData* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiPlatformImeData wrapper = ImGuiPlatformImeData.__new__(ImGuiPlatformImeData)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiPlatformImeData from_heap_ptr(ccimgui.ImGuiPlatformImeData* _ptr):
        wrapper = ImGuiPlatformImeData.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def input_line_height(self):
    #     """
    #     Line height
    #     """
    #     cdef float res = dereference(self._ptr).InputLineHeight
    #     return res
    # @input_line_height.setter
    # def input_line_height(self, value: float):
    #     # dereference(self._ptr).InputLineHeight = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    # @property
    # def input_pos(self):
    #     """
    #     Position of the input cursor
    #     """
    #     cdef ccimgui.ImVec2 res = dereference(self._ptr).InputPos
    #     return _cast_ImVec2_tuple(res)
    # @input_pos.setter
    # def input_pos(self, value: Tuple[float, float]):
    #     # dereference(self._ptr).InputPos = _cast_tuple_ImVec2(value)
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # @property
    # def want_visible(self):
    #     """
    #     A widget wants the ime to be visible
    #     """
    #     cdef bool res = dereference(self._ptr).WantVisible
    #     return res
    # @want_visible.setter
    # def want_visible(self, value: bool):
    #     # dereference(self._ptr).WantVisible = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiPlatformMonitor:
    """
    (Optional) This is required when enabling multi-viewport. Represent the bounds of each connected monitor/display and their DPI.
    We use this information for multiple DPI support + clamping the position of popups and tooltips so they don't straddle multiple monitors.
    """
    cdef ccimgui.ImGuiPlatformMonitor* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiPlatformMonitor from_ptr(ccimgui.ImGuiPlatformMonitor* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiPlatformMonitor wrapper = ImGuiPlatformMonitor.__new__(ImGuiPlatformMonitor)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiPlatformMonitor from_heap_ptr(ccimgui.ImGuiPlatformMonitor* _ptr):
        wrapper = ImGuiPlatformMonitor.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def dpi_scale(self):
        """
        1.0f = 96 dpi
        """
        cdef float res = dereference(self._ptr).DpiScale
        return res
    @dpi_scale.setter
    def dpi_scale(self, value: float):
        # dereference(self._ptr).DpiScale = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def main_pos(self):
        """
        Coordinates of the area displayed on this monitor (min = upper left, max = bottom right)
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).MainPos
        return _cast_ImVec2_tuple(res)
    @main_pos.setter
    def main_pos(self, value: Tuple[float, float]):
        # dereference(self._ptr).MainPos = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def main_size(self):
        """
        Coordinates of the area displayed on this monitor (min = upper left, max = bottom right)
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).MainSize
        return _cast_ImVec2_tuple(res)
    @main_size.setter
    def main_size(self, value: Tuple[float, float]):
        # dereference(self._ptr).MainSize = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def platform_handle(self):
    #     """
    #     Backend dependant data (e.g. hmonitor, glfwmonitor*, sdl display index, nsscreen*)
    #     """
    #     cdef void* res = dereference(self._ptr).PlatformHandle
    #     return res
    # @platform_handle.setter
    # def platform_handle(self, value: Any):
    #     # dereference(self._ptr).PlatformHandle = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def work_pos(self):
        """
        Coordinates without task bars / side bars / menu bars. used to avoid positioning popups/tooltips inside this region. if you don't have this info, please copy the value for mainpos/mainsize.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).WorkPos
        return _cast_ImVec2_tuple(res)
    @work_pos.setter
    def work_pos(self, value: Tuple[float, float]):
        # dereference(self._ptr).WorkPos = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def work_size(self):
        """
        Coordinates without task bars / side bars / menu bars. used to avoid positioning popups/tooltips inside this region. if you don't have this info, please copy the value for mainpos/mainsize.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).WorkSize
        return _cast_ImVec2_tuple(res)
    @work_size.setter
    def work_size(self, value: Tuple[float, float]):
        # dereference(self._ptr).WorkSize = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiSizeCallbackData:
    """
    Resizing callback data to apply custom constraint. As enabled by SetNextWindowSizeConstraints(). Callback is called during the next Begin().
    NB: For basic min/max size constraint on each axis you don't need to use the callback! The SetNextWindowSizeConstraints() parameters are enough.
    """
    cdef ccimgui.ImGuiSizeCallbackData* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiSizeCallbackData from_ptr(ccimgui.ImGuiSizeCallbackData* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiSizeCallbackData wrapper = ImGuiSizeCallbackData.__new__(ImGuiSizeCallbackData)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiSizeCallbackData from_heap_ptr(ccimgui.ImGuiSizeCallbackData* _ptr):
        wrapper = ImGuiSizeCallbackData.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def current_size(self):
        """
        Read-only.   current window size.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).CurrentSize
        return _cast_ImVec2_tuple(res)
    @current_size.setter
    def current_size(self, value: Tuple[float, float]):
        # dereference(self._ptr).CurrentSize = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def desired_size(self):
        """
        Read-write.  desired size, based on user's mouse position. write to this field to restrain resizing.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).DesiredSize
        return _cast_ImVec2_tuple(res)
    @desired_size.setter
    def desired_size(self, value: Tuple[float, float]):
        dereference(self._ptr).DesiredSize = _cast_tuple_ImVec2(value)
        # raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def pos(self):
        """
        Read-only.   window position, for reference.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).Pos
        return _cast_ImVec2_tuple(res)
    @pos.setter
    def pos(self, value: Tuple[float, float]):
        # dereference(self._ptr).Pos = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    @property
    def user_data(self):
        """
        Read-only.   what user passed to setnextwindowsizeconstraints(). generally store an integer or float in here (need reinterpret_cast<>).
        """
        cdef int lookup = <int><uintptr_t>dereference(self._ptr).UserData
        callback, user_data = _set_next_window_size_constraints_data[lookup]
        return user_data
    @user_data.setter
    def user_data(self, value: Any):
        # dereference(self._ptr).UserData = value
        raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# cdef class ImGuiStorage:
#     """
#     Helper: Key->Value storage
#     Typically you don't have to worry about this since a storage is held within each Window.
#     We use it to e.g. store collapse state for a tree (Int 0/1)
#     This is optimized for efficient lookup (dichotomy into a contiguous buffer) and rare insertion (typically tied to user interactions aka max once a frame)
#     You can use it as custom user storage for temporary values. Declare your own storage if, for example:
#     - You want to manipulate the open/close state of a particular sub-tree in your interface (tree node uses Int 0/1 to store their state).
#     - You want to store custom debug data easily without adding or editing structures in your code (probably not efficient, but convenient)
#     Types are NOT stored, so it is up to you to make sure your Key don't collide with different types.
#     """
#     cdef ccimgui.ImGuiStorage* _ptr
#     cdef bool dynamically_allocated

#     @staticmethod
#     cdef ImGuiStorage from_ptr(ccimgui.ImGuiStorage* _ptr):
#         if _ptr == NULL:
#             return None
#         cdef ImGuiStorage wrapper = ImGuiStorage.__new__(ImGuiStorage)
#         wrapper._ptr = _ptr
#         wrapper.dynamically_allocated = False
#         return wrapper

#     @staticmethod
#     cdef ImGuiStorage from_heap_ptr(ccimgui.ImGuiStorage* _ptr):
#         wrapper = ImGuiStorage.from_ptr(_ptr)
#         if wrapper is None:
#             return None
#         wrapper.dynamically_allocated = True
#         return wrapper

#     def __init__(self):
#         raise TypeError("This class cannot be instantiated directly.")

#     def __hash__(self) -> int:
#         if self._ptr == NULL:
#             raise RuntimeError("Won't hash a NULL pointer")
#         cdef unsigned int ptr_int = <uintptr_t>self._ptr
#         return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImVector_ImGuiStorage_ImGuiStoragePair)
    # @property
    # def data(self):
    #     cdef ccimgui.ImVector_ImGuiStorage_ImGuiStoragePair res = dereference(self._ptr).Data
    #     return ImVector_ImGuiStorage_ImGuiStoragePair.from_ptr(res)
    # @data.setter
    # def data(self, value: ImVector_ImGuiStorage_ImGuiStoragePair):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def build_sort_by_key(self: ImGuiStorage):
    #     """
    #     Advanced: for quicker full rebuild of a storage (instead of an incremental one), you may add all your contents and then sort once.
    #     """
    #     ccimgui.ImGuiStorage_BuildSortByKey(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear(self: ImGuiStorage):
    #     """
    #     - Get***() functions find pair, never add/allocate. Pairs are sorted so a query is O(log N)
    #     - Set***() functions find pair, insertion on demand if missing.
    #     - Sorted insertion is costly, paid once. A typical frame shouldn't need to insert any new pair.
    #     """
    #     ccimgui.ImGuiStorage_Clear(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def get_bool(self: ImGuiStorage, key: int, default_val: bool=False):
    #     cdef bool res = ccimgui.ImGuiStorage_GetBool(
    #         self._ptr,
    #         key,
    #         default_val
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Bool)
    # def get_bool_ref(self: ImGuiStorage, key: int, default_val: bool=False):
    #     cdef bool* res = ccimgui.ImGuiStorage_GetBoolRef(
    #         self._ptr,
    #         key,
    #         default_val
    #     )
    #     return Bool(dereference(res))
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # def get_float(self: ImGuiStorage, key: int, default_val: float=0.0):
    #     cdef float res = ccimgui.ImGuiStorage_GetFloat(
    #         self._ptr,
    #         key,
    #         default_val
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Float)
    # def get_float_ref(self: ImGuiStorage, key: int, default_val: float=0.0):
    #     cdef float* res = ccimgui.ImGuiStorage_GetFloatRef(
    #         self._ptr,
    #         key,
    #         default_val
    #     )
    #     return Float(dereference(res))
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # def get_int(self: ImGuiStorage, key: int, default_val: int=0):
    #     cdef int res = ccimgui.ImGuiStorage_GetInt(
    #         self._ptr,
    #         key,
    #         default_val
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Int)
    # def get_int_ref(self: ImGuiStorage, key: int, default_val: int=0):
    #     """
    #     - Get***Ref() functions finds pair, insert on demand if missing, return pointer. Useful if you intend to do Get+Set.
    #     - References are only valid until a new value is added to the storage. Calling a Set***() function or a Get***Ref() function invalidates the pointer.
    #     - A typical use case where this is convenient for quick hacking (e.g. add storage during a live Edit&Continue session if you can't modify existing struct)
    #     float* pvar = ImGui::GetFloatRef(key); ImGui::SliderFloat("var", pvar, 0, 100.0f); some_var += *pvar;
    #     """
    #     cdef int* res = ccimgui.ImGuiStorage_GetIntRef(
    #         self._ptr,
    #         key,
    #         default_val
    #     )
    #     return Int(dereference(res))
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # def get_void_ptr(self: ImGuiStorage, key: int):
    #     """
    #     Default_val is null
    #     """
    #     cdef void* res = ccimgui.ImGuiStorage_GetVoidPtr(
    #         self._ptr,
    #         key
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # def get_void_ptr_ref(self: ImGuiStorage, key: int, default_val: Any=None):
    #     cdef void** res = ccimgui.ImGuiStorage_GetVoidPtrRef(
    #         self._ptr,
    #         key,
    #         default_val
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_all_int(self: ImGuiStorage, val: int):
    #     """
    #     Obsolete: use on your own storage if you know only integer are being stored (open/close all tree nodes)
    #     """
    #     ccimgui.ImGuiStorage_SetAllInt(
    #         self._ptr,
    #         val
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_bool(self: ImGuiStorage, key: int, val: bool):
    #     ccimgui.ImGuiStorage_SetBool(
    #         self._ptr,
    #         key,
    #         val
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_float(self: ImGuiStorage, key: int, val: float):
    #     ccimgui.ImGuiStorage_SetFloat(
    #         self._ptr,
    #         key,
    #         val
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_int(self: ImGuiStorage, key: int, val: int):
    #     ccimgui.ImGuiStorage_SetInt(
    #         self._ptr,
    #         key,
    #         val
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def set_void_ptr(self: ImGuiStorage, key: int, val: Any):
    #     ccimgui.ImGuiStorage_SetVoidPtr(
    #         self._ptr,
    #         key,
    #         val
    #     )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# cdef class ImGuiStorage_ImGuiStoragePair:
#     """
#     [Internal]
#     """
#     cdef ccimgui.ImGuiStorage_ImGuiStoragePair* _ptr
#     cdef bool dynamically_allocated

#     @staticmethod
#     cdef ImGuiStorage_ImGuiStoragePair from_ptr(ccimgui.ImGuiStorage_ImGuiStoragePair* _ptr):
#         if _ptr == NULL:
#             return None
#         cdef ImGuiStorage_ImGuiStoragePair wrapper = ImGuiStorage_ImGuiStoragePair.__new__(ImGuiStorage_ImGuiStoragePair)
#         wrapper._ptr = _ptr
#         wrapper.dynamically_allocated = False
#         return wrapper

#     @staticmethod
#     cdef ImGuiStorage_ImGuiStoragePair from_heap_ptr(ccimgui.ImGuiStorage_ImGuiStoragePair* _ptr):
#         wrapper = ImGuiStorage_ImGuiStoragePair.from_ptr(_ptr)
#         if wrapper is None:
#             return None
#         wrapper.dynamically_allocated = True
#         return wrapper

#     def __init__(self):
#         raise TypeError("This class cannot be instantiated directly.")

#     def __hash__(self) -> int:
#         if self._ptr == NULL:
#             raise RuntimeError("Won't hash a NULL pointer")
#         cdef unsigned int ptr_int = <uintptr_t>self._ptr
#         return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def key(self):
    #     cdef ccimgui.ImGuiID res = dereference(self._ptr).key
    #     return res
    # @key.setter
    # def key(self, value: int):
    #     # dereference(self._ptr).key = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiStyle:
    cdef ccimgui.ImGuiStyle* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiStyle from_ptr(ccimgui.ImGuiStyle* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiStyle wrapper = ImGuiStyle.__new__(ImGuiStyle)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiStyle from_heap_ptr(ccimgui.ImGuiStyle* _ptr):
        wrapper = ImGuiStyle.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def alpha(self):
        """
        Global alpha applies to everything in dear imgui.
        """
        cdef float res = dereference(self._ptr).Alpha
        return res
    @alpha.setter
    def alpha(self, value: float):
        # dereference(self._ptr).Alpha = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def anti_aliased_fill(self):
        """
        Enable anti-aliased edges around filled shapes (rounded rectangles, circles, etc.). disable if you are really tight on cpu/gpu. latched at the beginning of the frame (copied to imdrawlist).
        """
        cdef bool res = dereference(self._ptr).AntiAliasedFill
        return res
    @anti_aliased_fill.setter
    def anti_aliased_fill(self, value: bool):
        # dereference(self._ptr).AntiAliasedFill = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def anti_aliased_lines(self):
        """
        Enable anti-aliased lines/borders. disable if you are really tight on cpu/gpu. latched at the beginning of the frame (copied to imdrawlist).
        """
        cdef bool res = dereference(self._ptr).AntiAliasedLines
        return res
    @anti_aliased_lines.setter
    def anti_aliased_lines(self, value: bool):
        # dereference(self._ptr).AntiAliasedLines = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def anti_aliased_lines_use_tex(self):
        """
        Enable anti-aliased lines/borders using textures where possible. require backend to render with bilinear filtering (not point/nearest filtering). latched at the beginning of the frame (copied to imdrawlist).
        """
        cdef bool res = dereference(self._ptr).AntiAliasedLinesUseTex
        return res
    @anti_aliased_lines_use_tex.setter
    def anti_aliased_lines_use_tex(self, value: bool):
        # dereference(self._ptr).AntiAliasedLinesUseTex = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def button_text_align(self):
        """
        Alignment of button text when button is larger than text. defaults to (0.5f, 0.5f) (centered).
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).ButtonTextAlign
        return _cast_ImVec2_tuple(res)
    @button_text_align.setter
    def button_text_align(self, value: Tuple[float, float]):
        # dereference(self._ptr).ButtonTextAlign = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def cell_padding(self):
        """
        Padding within a table cell. cellpadding.y may be altered between different rows.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).CellPadding
        return _cast_ImVec2_tuple(res)
    @cell_padding.setter
    def cell_padding(self, value: Tuple[float, float]):
        # dereference(self._ptr).CellPadding = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def child_border_size(self):
        """
        Thickness of border around child windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
        """
        cdef float res = dereference(self._ptr).ChildBorderSize
        return res
    @child_border_size.setter
    def child_border_size(self, value: float):
        # dereference(self._ptr).ChildBorderSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def child_rounding(self):
        """
        Radius of child window corners rounding. set to 0.0f to have rectangular windows.
        """
        cdef float res = dereference(self._ptr).ChildRounding
        return res
    @child_rounding.setter
    def child_rounding(self, value: float):
        # dereference(self._ptr).ChildRounding = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def circle_tessellation_max_error(self):
        """
        Maximum error (in pixels) allowed when using addcircle()/addcirclefilled() or drawing rounded corner rectangles with no explicit segment count specified. decrease for higher quality but more geometry.
        """
        cdef float res = dereference(self._ptr).CircleTessellationMaxError
        return res
    @circle_tessellation_max_error.setter
    def circle_tessellation_max_error(self, value: float):
        # dereference(self._ptr).CircleTessellationMaxError = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def color_button_position(self):
        """
        Side of the color button in the coloredit4 widget (left/right). defaults to imguidir_right.
        """
        cdef ccimgui.ImGuiDir res = dereference(self._ptr).ColorButtonPosition
        return res
    @color_button_position.setter
    def color_button_position(self, value: int):
        # dereference(self._ptr).ColorButtonPosition = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(tuple)
    @property
    def colors(self):
        cdef ccimgui.ImVec4* res = dereference(self._ptr).Colors
        return _cast_ImVec4_tuple(dereference(res))
    @colors.setter
    def colors(self, value: ImVec4):
        # dereference(self._ptr).Colors = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def columns_min_spacing(self):
        """
        Minimum horizontal spacing between two columns. preferably > (framepadding.x + 1).
        """
        cdef float res = dereference(self._ptr).ColumnsMinSpacing
        return res
    @columns_min_spacing.setter
    def columns_min_spacing(self, value: float):
        # dereference(self._ptr).ColumnsMinSpacing = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def curve_tessellation_tol(self):
        """
        Tessellation tolerance when using pathbeziercurveto() without a specific number of segments. decrease for highly tessellated curves (higher quality, more polygons), increase to reduce quality.
        """
        cdef float res = dereference(self._ptr).CurveTessellationTol
        return res
    @curve_tessellation_tol.setter
    def curve_tessellation_tol(self, value: float):
        # dereference(self._ptr).CurveTessellationTol = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def disabled_alpha(self):
        """
        Additional alpha multiplier applied by begindisabled(). multiply over current value of alpha.
        """
        cdef float res = dereference(self._ptr).DisabledAlpha
        return res
    @disabled_alpha.setter
    def disabled_alpha(self, value: float):
        # dereference(self._ptr).DisabledAlpha = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def display_safe_area_padding(self):
        """
        If you cannot see the edges of your screen (e.g. on a tv) increase the safe area padding. apply to popups/tooltips as well regular windows. nb: prefer configuring your tv sets correctly!
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).DisplaySafeAreaPadding
        return _cast_ImVec2_tuple(res)
    @display_safe_area_padding.setter
    def display_safe_area_padding(self, value: Tuple[float, float]):
        # dereference(self._ptr).DisplaySafeAreaPadding = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def display_window_padding(self):
        """
        Window position are clamped to be visible within the display area or monitors by at least this amount. only applies to regular windows.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).DisplayWindowPadding
        return _cast_ImVec2_tuple(res)
    @display_window_padding.setter
    def display_window_padding(self, value: Tuple[float, float]):
        # dereference(self._ptr).DisplayWindowPadding = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def docking_separator_size(self):
    #     """
    #     Thickness of resizing border between docked windows
    #     """
    #     cdef float res = dereference(self._ptr).DockingSeparatorSize
    #     return res
    # @docking_separator_size.setter
    # def docking_separator_size(self, value: float):
    #     # dereference(self._ptr).DockingSeparatorSize = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def frame_border_size(self):
        """
        Thickness of border around frames. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
        """
        cdef float res = dereference(self._ptr).FrameBorderSize
        return res
    @frame_border_size.setter
    def frame_border_size(self, value: float):
        # dereference(self._ptr).FrameBorderSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def frame_padding(self):
        """
        Padding within a framed rectangle (used by most widgets).
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).FramePadding
        return _cast_ImVec2_tuple(res)
    @frame_padding.setter
    def frame_padding(self, value: Tuple[float, float]):
        # dereference(self._ptr).FramePadding = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def frame_rounding(self):
        """
        Radius of frame corners rounding. set to 0.0f to have rectangular frame (used by most widgets).
        """
        cdef float res = dereference(self._ptr).FrameRounding
        return res
    @frame_rounding.setter
    def frame_rounding(self, value: float):
        # dereference(self._ptr).FrameRounding = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def grab_min_size(self):
        """
        Minimum width/height of a grab box for slider/scrollbar.
        """
        cdef float res = dereference(self._ptr).GrabMinSize
        return res
    @grab_min_size.setter
    def grab_min_size(self, value: float):
        # dereference(self._ptr).GrabMinSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def grab_rounding(self):
        """
        Radius of grabs corners rounding. set to 0.0f to have rectangular slider grabs.
        """
        cdef float res = dereference(self._ptr).GrabRounding
        return res
    @grab_rounding.setter
    def grab_rounding(self, value: float):
        # dereference(self._ptr).GrabRounding = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def hover_delay_normal(self):
        """
        Delay for isitemhovered(imguihoveredflags_delaynormal). '
        """
        cdef float res = dereference(self._ptr).HoverDelayNormal
        return res
    @hover_delay_normal.setter
    def hover_delay_normal(self, value: float):
        # dereference(self._ptr).HoverDelayNormal = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def hover_delay_short(self):
        """
        Delay for isitemhovered(imguihoveredflags_delayshort). usually used along with hoverstationarydelay.
        """
        cdef float res = dereference(self._ptr).HoverDelayShort
        return res
    @hover_delay_short.setter
    def hover_delay_short(self, value: float):
        # dereference(self._ptr).HoverDelayShort = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def hover_flags_for_tooltip_mouse(self):
    #     """
    #     Default flags when using isitemhovered(imguihoveredflags_fortooltip) or beginitemtooltip()/setitemtooltip() while using mouse.
    #     """
    #     cdef ccimgui.ImGuiHoveredFlags res = dereference(self._ptr).HoverFlagsForTooltipMouse
    #     return res
    # @hover_flags_for_tooltip_mouse.setter
    # def hover_flags_for_tooltip_mouse(self, value: int):
    #     # dereference(self._ptr).HoverFlagsForTooltipMouse = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def hover_flags_for_tooltip_nav(self):
    #     """
    #     Default flags when using isitemhovered(imguihoveredflags_fortooltip) or beginitemtooltip()/setitemtooltip() while using keyboard/gamepad.
    #     """
    #     cdef ccimgui.ImGuiHoveredFlags res = dereference(self._ptr).HoverFlagsForTooltipNav
    #     return res
    # @hover_flags_for_tooltip_nav.setter
    # def hover_flags_for_tooltip_nav(self, value: int):
    #     # dereference(self._ptr).HoverFlagsForTooltipNav = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def hover_stationary_delay(self):
    #     """
    #     Behaviors
    #     (It is possible to modify those fields mid-frame if specific behavior need it, unlike e.g. configuration fields in ImGuiIO)
    #     Delay for isitemhovered(imguihoveredflags_stationary). time required to consider mouse stationary.
    #     """
    #     cdef float res = dereference(self._ptr).HoverStationaryDelay
    #     return res
    # @hover_stationary_delay.setter
    # def hover_stationary_delay(self, value: float):
    #     # dereference(self._ptr).HoverStationaryDelay = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def indent_spacing(self):
        """
        Horizontal indentation when e.g. entering a tree node. generally == (fontsize + framepadding.x*2).
        """
        cdef float res = dereference(self._ptr).IndentSpacing
        return res
    @indent_spacing.setter
    def indent_spacing(self, value: float):
        # dereference(self._ptr).IndentSpacing = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def item_inner_spacing(self):
        """
        Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label).
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).ItemInnerSpacing
        return _cast_ImVec2_tuple(res)
    @item_inner_spacing.setter
    def item_inner_spacing(self, value: Tuple[float, float]):
        # dereference(self._ptr).ItemInnerSpacing = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def item_spacing(self):
        """
        Horizontal and vertical spacing between widgets/lines.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).ItemSpacing
        return _cast_ImVec2_tuple(res)
    @item_spacing.setter
    def item_spacing(self, value: Tuple[float, float]):
        # dereference(self._ptr).ItemSpacing = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def log_slider_deadzone(self):
        """
        The size in pixels of the dead-zone around zero on logarithmic sliders that cross zero.
        """
        cdef float res = dereference(self._ptr).LogSliderDeadzone
        return res
    @log_slider_deadzone.setter
    def log_slider_deadzone(self, value: float):
        # dereference(self._ptr).LogSliderDeadzone = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def mouse_cursor_scale(self):
        """
        Scale software rendered mouse cursor (when io.mousedrawcursor is enabled). we apply per-monitor dpi scaling over this scale. may be removed later.
        """
        cdef float res = dereference(self._ptr).MouseCursorScale
        return res
    @mouse_cursor_scale.setter
    def mouse_cursor_scale(self, value: float):
        # dereference(self._ptr).MouseCursorScale = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def popup_border_size(self):
        """
        Thickness of border around popup/tooltip windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
        """
        cdef float res = dereference(self._ptr).PopupBorderSize
        return res
    @popup_border_size.setter
    def popup_border_size(self, value: float):
        # dereference(self._ptr).PopupBorderSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def popup_rounding(self):
        """
        Radius of popup window corners rounding. (note that tooltip windows use windowrounding)
        """
        cdef float res = dereference(self._ptr).PopupRounding
        return res
    @popup_rounding.setter
    def popup_rounding(self, value: float):
        # dereference(self._ptr).PopupRounding = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def scrollbar_rounding(self):
        """
        Radius of grab corners for scrollbar.
        """
        cdef float res = dereference(self._ptr).ScrollbarRounding
        return res
    @scrollbar_rounding.setter
    def scrollbar_rounding(self, value: float):
        # dereference(self._ptr).ScrollbarRounding = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def scrollbar_size(self):
        """
        Width of the vertical scrollbar, height of the horizontal scrollbar.
        """
        cdef float res = dereference(self._ptr).ScrollbarSize
        return res
    @scrollbar_size.setter
    def scrollbar_size(self, value: float):
        # dereference(self._ptr).ScrollbarSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def selectable_text_align(self):
        """
        Alignment of selectable text. defaults to (0.0f, 0.0f) (top-left aligned). it's generally important to keep this left-aligned if you want to lay multiple items on a same line.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).SelectableTextAlign
        return _cast_ImVec2_tuple(res)
    @selectable_text_align.setter
    def selectable_text_align(self, value: Tuple[float, float]):
        # dereference(self._ptr).SelectableTextAlign = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def separator_text_align(self):
        """
        Alignment of text within the separator. defaults to (0.0f, 0.5f) (left aligned, center).
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).SeparatorTextAlign
        return _cast_ImVec2_tuple(res)
    @separator_text_align.setter
    def separator_text_align(self, value: Tuple[float, float]):
        # dereference(self._ptr).SeparatorTextAlign = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def separator_text_border_size(self):
        """
        Thickkness of border in separatortext()
        """
        cdef float res = dereference(self._ptr).SeparatorTextBorderSize
        return res
    @separator_text_border_size.setter
    def separator_text_border_size(self, value: float):
        # dereference(self._ptr).SeparatorTextBorderSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def separator_text_padding(self):
        """
        Horizontal offset of text from each edge of the separator + spacing on other axis. generally small values. .y is recommended to be == framepadding.y.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).SeparatorTextPadding
        return _cast_ImVec2_tuple(res)
    @separator_text_padding.setter
    def separator_text_padding(self, value: Tuple[float, float]):
        # dereference(self._ptr).SeparatorTextPadding = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def tab_bar_border_size(self):
    #     """
    #     Thickness of tab-bar separator, which takes on the tab active color to denote focus.
    #     """
    #     cdef float res = dereference(self._ptr).TabBarBorderSize
    #     return res
    # @tab_bar_border_size.setter
    # def tab_bar_border_size(self, value: float):
    #     # dereference(self._ptr).TabBarBorderSize = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def tab_border_size(self):
        """
        Thickness of border around tabs.
        """
        cdef float res = dereference(self._ptr).TabBorderSize
        return res
    @tab_border_size.setter
    def tab_border_size(self, value: float):
        # dereference(self._ptr).TabBorderSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def tab_min_width_for_close_button(self):
        """
        Minimum width for close button to appear on an unselected tab when hovered. set to 0.0f to always show when hovering, set to flt_max to never show close button unless selected.
        """
        cdef float res = dereference(self._ptr).TabMinWidthForCloseButton
        return res
    @tab_min_width_for_close_button.setter
    def tab_min_width_for_close_button(self, value: float):
        # dereference(self._ptr).TabMinWidthForCloseButton = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def tab_rounding(self):
        """
        Radius of upper corners of a tab. set to 0.0f to have rectangular tabs.
        """
        cdef float res = dereference(self._ptr).TabRounding
        return res
    @tab_rounding.setter
    def tab_rounding(self, value: float):
        # dereference(self._ptr).TabRounding = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def table_angled_headers_angle(self):
    #     """
    #     Angle of angled headers (supported values range from -50.0f degrees to +50.0f degrees).
    #     """
    #     cdef float res = dereference(self._ptr).TableAngledHeadersAngle
    #     return res
    # @table_angled_headers_angle.setter
    # def table_angled_headers_angle(self, value: float):
    #     # dereference(self._ptr).TableAngledHeadersAngle = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def touch_extra_padding(self):
        """
        Expand reactive bounding box for touch-based system where touch position is not accurate enough. unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. so don't grow this too much!
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).TouchExtraPadding
        return _cast_ImVec2_tuple(res)
    @touch_extra_padding.setter
    def touch_extra_padding(self, value: Tuple[float, float]):
        # dereference(self._ptr).TouchExtraPadding = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def window_border_size(self):
        """
        Thickness of border around windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
        """
        cdef float res = dereference(self._ptr).WindowBorderSize
        return res
    @window_border_size.setter
    def window_border_size(self, value: float):
        # dereference(self._ptr).WindowBorderSize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def window_menu_button_position(self):
        """
        Side of the collapsing/docking button in the title bar (none/left/right). defaults to imguidir_left.
        """
        cdef ccimgui.ImGuiDir res = dereference(self._ptr).WindowMenuButtonPosition
        return res
    @window_menu_button_position.setter
    def window_menu_button_position(self, value: int):
        # dereference(self._ptr).WindowMenuButtonPosition = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def window_min_size(self):
        """
        Minimum window size. this is a global setting. if you want to constrain individual windows, use setnextwindowsizeconstraints().
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).WindowMinSize
        return _cast_ImVec2_tuple(res)
    @window_min_size.setter
    def window_min_size(self, value: Tuple[float, float]):
        # dereference(self._ptr).WindowMinSize = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def window_padding(self):
        """
        Padding within a window.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).WindowPadding
        return _cast_ImVec2_tuple(res)
    @window_padding.setter
    def window_padding(self, value: Tuple[float, float]):
        # dereference(self._ptr).WindowPadding = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def window_rounding(self):
        """
        Radius of window corners rounding. set to 0.0f to have rectangular windows. large values tend to lead to variety of artifacts and are not recommended.
        """
        cdef float res = dereference(self._ptr).WindowRounding
        return res
    @window_rounding.setter
    def window_rounding(self, value: float):
        # dereference(self._ptr).WindowRounding = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def window_title_align(self):
        """
        Alignment for title bar text. defaults to (0.0f,0.5f) for left-aligned,vertically centered.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).WindowTitleAlign
        return _cast_ImVec2_tuple(res)
    @window_title_align.setter
    def window_title_align(self, value: Tuple[float, float]):
        # dereference(self._ptr).WindowTitleAlign = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def scale_all_sizes(self: ImGuiStyle, scale_factor: float):
    #     ccimgui.ImGuiStyle_ScaleAllSizes(
    #         self._ptr,
    #         scale_factor
    #     )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiTableColumnSortSpecs:
    """
    Sorting specification for one column of a table (sizeof == 12 bytes)
    """
    cdef const ccimgui.ImGuiTableColumnSortSpecs* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiTableColumnSortSpecs from_ptr(const ccimgui.ImGuiTableColumnSortSpecs* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiTableColumnSortSpecs wrapper = ImGuiTableColumnSortSpecs.__new__(ImGuiTableColumnSortSpecs)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiTableColumnSortSpecs from_heap_ptr(ccimgui.ImGuiTableColumnSortSpecs* _ptr):
        wrapper = ImGuiTableColumnSortSpecs.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def column_index(self):
        """
        Index of the column
        """
        cdef ccimgui.ImS16 res = dereference(self._ptr).ColumnIndex
        return res
    @column_index.setter
    def column_index(self, value: int):
        # dereference(self._ptr).ColumnIndex = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def column_user_id(self):
        """
        User id of the column (if specified by a tablesetupcolumn() call)
        """
        cdef ccimgui.ImGuiID res = dereference(self._ptr).ColumnUserID
        return res
    @column_user_id.setter
    def column_user_id(self, value: int):
        # dereference(self._ptr).ColumnUserID = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def sort_direction(self):
        """
        Imguisortdirection_ascending or imguisortdirection_descending
        """
        cdef ccimgui.ImGuiSortDirection res = dereference(self._ptr).SortDirection
        return res
    @sort_direction.setter
    def sort_direction(self, value: int):
        # dereference(self._ptr).SortDirection = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def sort_order(self):
    #     """
    #     Index within parent imguitablesortspecs (always stored in order starting from 0, tables sorted on a single criteria will always have a 0 here)
    #     """
    #     cdef ccimgui.ImS16 res = dereference(self._ptr).SortOrder
    #     return res
    # @sort_order.setter
    # def sort_order(self, value: int):
    #     # dereference(self._ptr).SortOrder = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiTableSortSpecs:
    """
    Sorting specifications for a table (often handling sort specs for a single column, occasionally more)
    Obtained by calling TableGetSortSpecs().
    When 'SpecsDirty == true' you can sort your data. It will be true with sorting specs have changed since last call, or the first time.
    Make sure to set 'SpecsDirty = false' after sorting, else you may wastefully sort your data every frame!
    """
    cdef ccimgui.ImGuiTableSortSpecs* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiTableSortSpecs from_ptr(ccimgui.ImGuiTableSortSpecs* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiTableSortSpecs wrapper = ImGuiTableSortSpecs.__new__(ImGuiTableSortSpecs)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiTableSortSpecs from_heap_ptr(ccimgui.ImGuiTableSortSpecs* _ptr):
        wrapper = ImGuiTableSortSpecs.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(List[ImGuiTableColumnSortSpecs])
    @property
    def specs(self):
        """
        Pointer to sort spec array.
        """
        return [
            ImGuiTableColumnSortSpecs.from_ptr(&dereference(self._ptr).Specs[idx])
            for idx in range(dereference(self._ptr).SpecsCount)
        ]
    @specs.setter
    def specs(self, value: ImGuiTableColumnSortSpecs):
        # dereference(self._ptr).Specs = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def specs_count(self):
        """
        Sort spec count. most often 1. may be > 1 when imguitableflags_sortmulti is enabled. may be == 0 when imguitableflags_sorttristate is enabled.
        """
        cdef int res = dereference(self._ptr).SpecsCount
        return res
    @specs_count.setter
    def specs_count(self, value: int):
        # dereference(self._ptr).SpecsCount = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def specs_dirty(self):
        """
        Set to true when specs have changed since last time! use this to sort again, then clear the flag.
        """
        cdef bool res = dereference(self._ptr).SpecsDirty
        return res
    @specs_dirty.setter
    def specs_dirty(self, value: bool):
        dereference(self._ptr).SpecsDirty = value
        # raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# cdef class ImGuiTextBuffer:
#     """
#     Helper: Growable text buffer for logging/accumulating text
#     (this could be called 'ImGuiTextBuilder' / 'ImGuiStringBuilder')
#     """
#     cdef ccimgui.ImGuiTextBuffer* _ptr
#     cdef bool dynamically_allocated

#     @staticmethod
#     cdef ImGuiTextBuffer from_ptr(ccimgui.ImGuiTextBuffer* _ptr):
#         if _ptr == NULL:
#             return None
#         cdef ImGuiTextBuffer wrapper = ImGuiTextBuffer.__new__(ImGuiTextBuffer)
#         wrapper._ptr = _ptr
#         wrapper.dynamically_allocated = False
#         return wrapper

#     @staticmethod
#     cdef ImGuiTextBuffer from_heap_ptr(ccimgui.ImGuiTextBuffer* _ptr):
#         wrapper = ImGuiTextBuffer.from_ptr(_ptr)
#         if wrapper is None:
#             return None
#         wrapper.dynamically_allocated = True
#         return wrapper

#     def __init__(self):
#         raise TypeError("This class cannot be instantiated directly.")

#     def __hash__(self) -> int:
#         if self._ptr == NULL:
#             raise RuntimeError("Won't hash a NULL pointer")
#         cdef unsigned int ptr_int = <uintptr_t>self._ptr
#         return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImVector_char)
    # @property
    # def buf(self):
    #     cdef ccimgui.ImVector_char res = dereference(self._ptr).Buf
    #     return ImVector_char.from_ptr(res)
    # @buf.setter
    # def buf(self, value: ImVector_char):
    #     # dereference(self._ptr).Buf = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
#     def append(self: ImGuiTextBuffer, str_: str, str_end: str=None):
#         bytes_str_end = _bytes(str_end) if str_end is not None else None

#         ccimgui.ImGuiTextBuffer_append(
#             self._ptr,
#             _bytes(str_),
#             ((<char*>bytes_str_end if str_end is not None else NULL))
#         )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def appendf(self: ImGuiTextBuffer, fmt: str):
    #     ccimgui.ImGuiTextBuffer_appendf(
    #         self._ptr,
    #         _bytes(fmt)
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def appendfv(self: ImGuiTextBuffer, fmt: str):
    #     ccimgui.ImGuiTextBuffer_appendfv(
    #         self._ptr,
    #         _bytes(fmt)
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    # def begin(self: ImGuiTextBuffer):
    #     cdef const char* res = ccimgui.ImGuiTextBuffer_begin(
    #         self._ptr
    #     )
    #     return _from_bytes(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    # def c_str(self: ImGuiTextBuffer):
    #     cdef const char* res = ccimgui.ImGuiTextBuffer_c_str(
    #         self._ptr
    #     )
    #     return _from_bytes(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear(self: ImGuiTextBuffer):
    #     ccimgui.ImGuiTextBuffer_clear(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def empty(self: ImGuiTextBuffer):
    #     cdef bool res = ccimgui.ImGuiTextBuffer_empty(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    # def end(self: ImGuiTextBuffer):
    #     """
    #     Buf is zero-terminated, so end() will point on the zero-terminator
    #     """
    #     cdef const char* res = ccimgui.ImGuiTextBuffer_end(
    #         self._ptr
    #     )
    #     return _from_bytes(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def reserve(self: ImGuiTextBuffer, capacity: int):
    #     ccimgui.ImGuiTextBuffer_reserve(
    #         self._ptr,
    #         capacity
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # def size(self: ImGuiTextBuffer):
    #     cdef int res = ccimgui.ImGuiTextBuffer_size(
    #         self._ptr
    #     )
    #     return res
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(True)
cdef class ImGuiTextFilter:
    """
    Helper: Parse and apply text filters. In format "aaaaa[,bbbb][,ccccc]"
    pygui note: This class is instantiable with ImGuiTextFilter.create()
    """
    cdef ccimgui.ImGuiTextFilter* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiTextFilter from_ptr(ccimgui.ImGuiTextFilter* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiTextFilter wrapper = ImGuiTextFilter.__new__(ImGuiTextFilter)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiTextFilter from_heap_ptr(ccimgui.ImGuiTextFilter* _ptr):
        wrapper = ImGuiTextFilter.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def count_grep(self):
    #     cdef int res = dereference(self._ptr).CountGrep
    #     return res
    # @count_grep.setter
    # def count_grep(self, value: int):
    #     # dereference(self._ptr).CountGrep = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImVector_ImGuiTextFilter_ImGuiTextRange)
    # @property
    # def filters(self):
    #     cdef ccimgui.ImVector_ImGuiTextFilter_ImGuiTextRange res = dereference(self._ptr).Filters
    #     return ImVector_ImGuiTextFilter_ImGuiTextRange.from_ptr(res)
    # @filters.setter
    # def filters(self, value: ImVector_ImGuiTextFilter_ImGuiTextRange):
    #     # dereference(self._ptr).Filters = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def input_buf(self):
    #     cdef char* res = dereference(self._ptr).InputBuf
    #     return _from_bytes(res)
    # @input_buf.setter
    # def input_buf(self, value: str):
    #     # dereference(self._ptr).InputBuf = _bytes(value)
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def build(self: ImGuiTextFilter):
    #     ccimgui.ImGuiTextFilter_Build(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def clear(self: ImGuiTextFilter):
    #     ccimgui.ImGuiTextFilter_Clear(
    #         self._ptr
    #     )
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(ImGuiTextFilter)
    @staticmethod
    def create(default_filter: str=""):
        """
        Mimics the constructor for struct ImGuiTextFilter
        """
        cdef ccimgui.ImGuiTextFilter* _filter = <ccimgui.ImGuiTextFilter*>ccimgui.ImGui_MemAlloc(sizeof(ccimgui.ImGuiTextFilter))
        memset(_filter, 0, sizeof(ccimgui.ImGuiTextFilter))
        
        cdef bytes default_filter_bytes = _bytes(default_filter)
        cdef unsigned int n_bytes = len(default_filter_bytes)
        if len(default_filter) > 0:
            strncpy(_filter.InputBuf, default_filter_bytes, 256)
            _filter.InputBuf[min(n_bytes, 256 - 1)] = 0
            ccimgui.ImGuiTextFilter_Build(_filter)

        return ImGuiTextFilter.from_heap_ptr(_filter)
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?returns(None)
    def destroy(self: ImGuiTextFilter):
        """
        Explicitly frees this instance.
        """
        if self._ptr != NULL:
            ccimgui.ImGui_MemFree(self._ptr)
            self._ptr = NULL
    def __dealloc__(self):
        """
        Just in case the user forgets to free the memory.
        """
        if not self.dynamically_allocated:
            return
        
        self.destroy()
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    def draw(self: ImGuiTextFilter, label: str="Filter (inc,-exc)", width: float=0.0):
        """
        Helper calling inputtext+build
        """
        cdef bool res = ccimgui.ImGuiTextFilter_Draw(
            self._ptr,
            _bytes(label),
            width
        )
        return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    def is_active(self: ImGuiTextFilter):
        cdef bool res = ccimgui.ImGuiTextFilter_IsActive(
            self._ptr
        )
        return res
    # [End Method]

    # [Method]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    def pass_filter(self: ImGuiTextFilter, text: str):
        cdef bool res = ccimgui.ImGuiTextFilter_PassFilter(
            self._ptr,
            _bytes(text),
            NULL
        )
        return res
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImGuiTextFilter_ImGuiTextRange:
    """
    [Internal]
    """
    cdef ccimgui.ImGuiTextFilter_ImGuiTextRange* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiTextFilter_ImGuiTextRange from_ptr(ccimgui.ImGuiTextFilter_ImGuiTextRange* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiTextFilter_ImGuiTextRange wrapper = ImGuiTextFilter_ImGuiTextRange.__new__(ImGuiTextFilter_ImGuiTextRange)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiTextFilter_ImGuiTextRange from_heap_ptr(ccimgui.ImGuiTextFilter_ImGuiTextRange* _ptr):
        wrapper = ImGuiTextFilter_ImGuiTextRange.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    # @property
    # def b(self):
    #     cdef const char* res = dereference(self._ptr).b
    #     return _from_bytes(res)
    # @b.setter
    # def b(self, value: str):
    #     # dereference(self._ptr).b = _bytes(value)
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    # @property
    # def e(self):
    #     cdef const char* res = dereference(self._ptr).e
    #     return _from_bytes(res)
    # @e.setter
    # def e(self, value: str):
    #     # dereference(self._ptr).e = _bytes(value)
    #     raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # def empty(self: ImGuiTextFilter_ImGuiTextRange):
    #     cdef bool res = ccimgui.ImGuiTextFilter_ImGuiTextRange_empty(
    #         self._ptr
    #     )
    #     return res
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(None)
    # def split(self: ImGuiTextFilter_ImGuiTextRange, separator: int, out: ImVector_ImGuiTextFilter_ImGuiTextRange):
    #     ccimgui.ImGuiTextFilter_ImGuiTextRange_split(
    #         self._ptr,
    #         separator,
    #         out._ptr
    #     )
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiViewport:
    """
    - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
    - With multi-viewport enabled, we extend this concept to have multiple active viewports.
    - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
    - About Main Area vs Work Area:
    - Main Area = entire viewport.
    - Work Area = entire viewport minus sections used by main menu bars (for platform windows), or by task bar (for platform monitor).
    - Windows are generally trying to stay within the Work Area of their host viewport.
    """
    cdef ccimgui.ImGuiViewport* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiViewport from_ptr(ccimgui.ImGuiViewport* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiViewport wrapper = ImGuiViewport.__new__(ImGuiViewport)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiViewport from_heap_ptr(ccimgui.ImGuiViewport* _ptr):
        wrapper = ImGuiViewport.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    @property
    def dpi_scale(self):
        """
        1.0f = 96 dpi = no extra scale.
        """
        cdef float res = dereference(self._ptr).DpiScale
        return res
    @dpi_scale.setter
    def dpi_scale(self, value: float):
        # dereference(self._ptr).DpiScale = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImDrawData)
    @property
    def draw_data(self):
        """
        The imdrawdata corresponding to this viewport. valid after render() and until the next call to newframe().
        """
        cdef ccimgui.ImDrawData* res = dereference(self._ptr).DrawData
        return ImDrawData.from_ptr(res)
    @draw_data.setter
    def draw_data(self, value: ImDrawData):
        # dereference(self._ptr).DrawData = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def flags(self):
        """
        See imguiviewportflags_
        """
        cdef ccimgui.ImGuiViewportFlags res = dereference(self._ptr).Flags
        return res
    @flags.setter
    def flags(self, value: int):
        # dereference(self._ptr).Flags = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def id(self):
        """
        Unique identifier for the viewport
        """
        cdef ccimgui.ImGuiID res = dereference(self._ptr).ID
        return res
    @id.setter
    def id(self, value: int):
        # dereference(self._ptr).ID = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def parent_viewport_id(self):
        """
        (advanced) 0: no parent. instruct the platform backend to setup a parent/child relationship between platform windows.
        """
        cdef ccimgui.ImGuiID res = dereference(self._ptr).ParentViewportId
        return res
    @parent_viewport_id.setter
    def parent_viewport_id(self, value: int):
        # dereference(self._ptr).ParentViewportId = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def platform_handle(self):
    #     """
    #     Void* for findviewportbyplatformhandle(). (e.g. suggested to use natural platform handle such as hwnd, glfwwindow*, sdl_window*)
    #     """
    #     cdef void* res = dereference(self._ptr).PlatformHandle
    #     return res
    # @platform_handle.setter
    # def platform_handle(self, value: Any):
    #     # dereference(self._ptr).PlatformHandle = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def platform_handle_raw(self):
    #     """
    #     Void* to hold lower-level, platform-native window handle (under win32 this is expected to be a hwnd, unused for other platforms), when using an abstraction layer like glfw or sdl (where platformhandle would be a sdl_window*)
    #     """
    #     cdef void* res = dereference(self._ptr).PlatformHandleRaw
    #     return res
    # @platform_handle_raw.setter
    # def platform_handle_raw(self, value: Any):
    #     # dereference(self._ptr).PlatformHandleRaw = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def platform_request_close(self):
        """
        Platform window requested closure (e.g. window was moved by the os / host window manager, e.g. pressing alt-f4)
        """
        cdef bool res = dereference(self._ptr).PlatformRequestClose
        return res
    @platform_request_close.setter
    def platform_request_close(self, value: bool):
        # dereference(self._ptr).PlatformRequestClose = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def platform_request_move(self):
        """
        Platform window requested move (e.g. window was moved by the os / host window manager, authoritative position will be os window position)
        """
        cdef bool res = dereference(self._ptr).PlatformRequestMove
        return res
    @platform_request_move.setter
    def platform_request_move(self, value: bool):
        # dereference(self._ptr).PlatformRequestMove = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def platform_request_resize(self):
        """
        Platform window requested resize (e.g. window was resized by the os / host window manager, authoritative size will be os window size)
        """
        cdef bool res = dereference(self._ptr).PlatformRequestResize
        return res
    @platform_request_resize.setter
    def platform_request_resize(self, value: bool):
        # dereference(self._ptr).PlatformRequestResize = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def platform_user_data(self):
    #     """
    #     Void* to hold custom data structure for the os / platform (e.g. windowing info, render context). generally set by your platform_createwindow function.
    #     """
    #     cdef void* res = dereference(self._ptr).PlatformUserData
    #     return res
    # @platform_user_data.setter
    # def platform_user_data(self, value: Any):
    #     # dereference(self._ptr).PlatformUserData = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    @property
    def platform_window_created(self):
        """
        Platform window has been created (platform_createwindow() has been called). this is false during the first frame where a viewport is being created.
        """
        cdef bool res = dereference(self._ptr).PlatformWindowCreated
        return res
    @platform_window_created.setter
    def platform_window_created(self, value: bool):
        # dereference(self._ptr).PlatformWindowCreated = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def pos(self):
        """
        Main area: position of the viewport (dear imgui coordinates are the same as os desktop/native coordinates)
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).Pos
        return _cast_ImVec2_tuple(res)
    @pos.setter
    def pos(self, value: Tuple[float, float]):
        # dereference(self._ptr).Pos = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(True)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def renderer_user_data(self):
    #     """
    #     Platform/Backend Dependent Data
    #     Our design separate the Renderer and Platform backends to facilitate combining default backends with each others.
    #     When our create your own backend for a custom engine, it is possible that both Renderer and Platform will be handled
    #     by the same system and you may not need to use all the UserData/Handle fields.
    #     The library never uses those fields, they are merely storage to facilitate backend implementation.
    #     Void* to hold custom data structure for the renderer (e.g. swap chain, framebuffers etc.). generally set by your renderer_createwindow function.
    #     """
    #     cdef void* res = dereference(self._ptr).RendererUserData
    #     return res
    # @renderer_user_data.setter
    # def renderer_user_data(self, value: Any):
    #     # dereference(self._ptr).RendererUserData = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def size(self):
        """
        Main area: size of the viewport.
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).Size
        return _cast_ImVec2_tuple(res)
    @size.setter
    def size(self, value: Tuple[float, float]):
        # dereference(self._ptr).Size = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def work_pos(self):
        """
        Work area: position of the viewport minus task bars, menus bars, status bars (>= pos)
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).WorkPos
        return _cast_ImVec2_tuple(res)
    @work_pos.setter
    def work_pos(self, value: Tuple[float, float]):
        # dereference(self._ptr).WorkPos = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    @property
    def work_size(self):
        """
        Work area: size of the viewport minus task bars, menu bars, status bars (<= size)
        """
        cdef ccimgui.ImVec2 res = dereference(self._ptr).WorkSize
        return _cast_ImVec2_tuple(res)
    @work_size.setter
    def work_size(self, value: Tuple[float, float]):
        # dereference(self._ptr).WorkSize = _cast_tuple_ImVec2(value)
        raise NotImplementedError
    # [End Field]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    def get_center(self: ImGuiViewport):
        """
        Helpers
        """
        cdef ccimgui.ImVec2 res = ccimgui.ImGuiViewport_GetCenter(
            self._ptr
        )
        return _cast_ImVec2_tuple(res)
    # [End Method]

    # [Method]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Tuple[float, float])
    def get_work_center(self: ImGuiViewport):
        cdef ccimgui.ImVec2 res = ccimgui.ImGuiViewport_GetWorkCenter(
            self._ptr
        )
        return _cast_ImVec2_tuple(res)
    # [End Method]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImGuiWindowClass:
    """
    [ALPHA] Rarely used / very advanced uses only. Use with SetNextWindowClass() and DockSpace() functions.
    Important: the content of this class is still highly WIP and likely to change and be refactored
    before we stabilize Docking features. Please be mindful if using this.
    Provide hints:
    - To the platform backend via altered viewport flags (enable/disable OS decoration, OS task bar icons, etc.)
    - To the platform backend for OS level parent/child relationships of viewport.
    - To the docking system for various options and filtering.
    """
    cdef ccimgui.ImGuiWindowClass* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImGuiWindowClass from_ptr(ccimgui.ImGuiWindowClass* _ptr):
        if _ptr == NULL:
            return None
        cdef ImGuiWindowClass wrapper = ImGuiWindowClass.__new__(ImGuiWindowClass)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImGuiWindowClass from_heap_ptr(ccimgui.ImGuiWindowClass* _ptr):
        wrapper = ImGuiWindowClass.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def class_id(self):
    #     """
    #     User data. 0 = default class (unclassed). windows of different classes cannot be docked with each others.
    #     """
    #     cdef ccimgui.ImGuiID res = dereference(self._ptr).ClassId
    #     return res
    # @class_id.setter
    # def class_id(self, value: int):
    #     # dereference(self._ptr).ClassId = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def dock_node_flags_override_set(self):
    #     """
    #     [experimental] dock node flags to set when a window of this class is hosted by a dock node (it doesn't have to be selected!)
    #     """
    #     cdef ccimgui.ImGuiDockNodeFlags res = dereference(self._ptr).DockNodeFlagsOverrideSet
    #     return res
    # @dock_node_flags_override_set.setter
    # def dock_node_flags_override_set(self, value: int):
    #     # dereference(self._ptr).DockNodeFlagsOverrideSet = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # @property
    # def docking_allow_unclassed(self):
    #     """
    #     Set to true to allow windows of this class to be docked/merged with an unclassed window. // fixme-dock: move to docknodeflags override?
    #     """
    #     cdef bool res = dereference(self._ptr).DockingAllowUnclassed
    #     return res
    # @docking_allow_unclassed.setter
    # def docking_allow_unclassed(self, value: bool):
    #     # dereference(self._ptr).DockingAllowUnclassed = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(bool)
    # @property
    # def docking_always_tab_bar(self):
    #     """
    #     Set to true to enforce single floating windows of this class always having their own docking node (equivalent of setting the global io.configdockingalwaystabbar)
    #     """
    #     cdef bool res = dereference(self._ptr).DockingAlwaysTabBar
    #     return res
    # @docking_always_tab_bar.setter
    # def docking_always_tab_bar(self, value: bool):
    #     # dereference(self._ptr).DockingAlwaysTabBar = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def focus_route_parent_window_id(self):
    #     """
    #     Id of parent window for shortcut focus route evaluation, e.g. shortcut() call from parent window will succeed when this window is focused.
    #     """
    #     cdef ccimgui.ImGuiID res = dereference(self._ptr).FocusRouteParentWindowId
    #     return res
    # @focus_route_parent_window_id.setter
    # def focus_route_parent_window_id(self, value: int):
    #     # dereference(self._ptr).FocusRouteParentWindowId = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def parent_viewport_id(self):
    #     """
    #     Hint for the platform backend. -1: use default. 0: request platform backend to not parent the platform. != 0: request platform backend to create a parent<>child relationship between the platform windows. not conforming backends are free to e.g. parent every viewport to the main viewport or not.
    #     """
    #     cdef ccimgui.ImGuiID res = dereference(self._ptr).ParentViewportId
    #     return res
    # @parent_viewport_id.setter
    # def parent_viewport_id(self, value: int):
    #     # dereference(self._ptr).ParentViewportId = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def tab_item_flags_override_set(self):
    #     """
    #     [experimental] tabitem flags to set when a window of this class gets submitted into a dock node tab bar. may use with imguitabitemflags_leading or imguitabitemflags_trailing.
    #     """
    #     cdef ccimgui.ImGuiTabItemFlags res = dereference(self._ptr).TabItemFlagsOverrideSet
    #     return res
    # @tab_item_flags_override_set.setter
    # def tab_item_flags_override_set(self, value: int):
    #     # dereference(self._ptr).TabItemFlagsOverrideSet = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def viewport_flags_override_clear(self):
    #     """
    #     Viewport flags to clear when a window of this class owns a viewport. this allows you to enforce os decoration or task bar icon, override the defaults on a per-window basis.
    #     """
    #     cdef ccimgui.ImGuiViewportFlags res = dereference(self._ptr).ViewportFlagsOverrideClear
    #     return res
    # @viewport_flags_override_clear.setter
    # def viewport_flags_override_clear(self, value: int):
    #     # dereference(self._ptr).ViewportFlagsOverrideClear = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def viewport_flags_override_set(self):
    #     """
    #     Viewport flags to set when a window of this class owns a viewport. this allows you to enforce os decoration or task bar icon, override the defaults on a per-window basis.
    #     """
    #     cdef ccimgui.ImGuiViewportFlags res = dereference(self._ptr).ViewportFlagsOverrideSet
    #     return res
    # @viewport_flags_override_set.setter
    # def viewport_flags_override_set(self, value: int):
    #     # dereference(self._ptr).ViewportFlagsOverrideSet = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVec2:
    cdef ccimgui.ImVec2* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVec2 from_ptr(ccimgui.ImVec2* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVec2 wrapper = ImVec2.__new__(ImVec2)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVec2 from_heap_ptr(ccimgui.ImVec2* _ptr):
        wrapper = ImVec2.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def x(self):
    #     cdef float res = dereference(self._ptr).x
    #     return res
    # @x.setter
    # def x(self, value: float):
    #     # dereference(self._ptr).x = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def y(self):
    #     cdef float res = dereference(self._ptr).y
    #     return res
    # @y.setter
    # def y(self, value: float):
    #     # dereference(self._ptr).y = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVec4:
    """
    ImVec4: 4D vector used to store clipping rectangles, colors etc. [Compile-time configurable type]
    """
    cdef ccimgui.ImVec4* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVec4 from_ptr(ccimgui.ImVec4* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVec4 wrapper = ImVec4.__new__(ImVec4)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVec4 from_heap_ptr(ccimgui.ImVec4* _ptr):
        wrapper = ImVec4.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def w(self):
    #     cdef float res = dereference(self._ptr).w
    #     return res
    # @w.setter
    # def w(self, value: float):
    #     # dereference(self._ptr).w = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def x(self):
    #     cdef float res = dereference(self._ptr).x
    #     return res
    # @x.setter
    # def x(self, value: float):
    #     # dereference(self._ptr).x = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def y(self):
    #     cdef float res = dereference(self._ptr).y
    #     return res
    # @y.setter
    # def y(self, value: float):
    #     # dereference(self._ptr).y = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(float)
    # @property
    # def z(self):
    #     cdef float res = dereference(self._ptr).z
    #     return res
    # @z.setter
    # def z(self, value: float):
    #     # dereference(self._ptr).z = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImDrawChannel:
    cdef ccimgui.ImVector_ImDrawChannel* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImDrawChannel from_ptr(ccimgui.ImVector_ImDrawChannel* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImDrawChannel wrapper = ImVector_ImDrawChannel.__new__(ImVector_ImDrawChannel)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImDrawChannel from_heap_ptr(ccimgui.ImVector_ImDrawChannel* _ptr):
        wrapper = ImVector_ImDrawChannel.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImDrawChannel)
    # @property
    # def data(self):
    #     cdef ccimgui.ImDrawChannel* res = dereference(self._ptr).Data
    #     return ImDrawChannel.from_ptr(res)
    # @data.setter
    # def data(self, value: ImDrawChannel):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImVector_ImDrawCmd:
    cdef ccimgui.ImVector_ImDrawCmd* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImDrawCmd from_ptr(ccimgui.ImVector_ImDrawCmd* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImDrawCmd wrapper = ImVector_ImDrawCmd.__new__(ImVector_ImDrawCmd)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImDrawCmd from_heap_ptr(ccimgui.ImVector_ImDrawCmd* _ptr):
        wrapper = ImVector_ImDrawCmd.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImDrawCmd)
    # @property
    # def data(self):
    #     cdef ccimgui.ImDrawCmd* res = dereference(self._ptr).Data
    #     return ImDrawCmd.from_ptr(res)
    # @data.setter
    # def data(self, value: ImDrawCmd):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImVector_ImDrawIdx:
    cdef ccimgui.ImVector_ImDrawIdx* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImDrawIdx from_ptr(ccimgui.ImVector_ImDrawIdx* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImDrawIdx wrapper = ImVector_ImDrawIdx.__new__(ImVector_ImDrawIdx)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImDrawIdx from_heap_ptr(ccimgui.ImVector_ImDrawIdx* _ptr):
        wrapper = ImVector_ImDrawIdx.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def data(self):
        cdef size_t res = <uintptr_t>dereference(self._ptr).Data
        return res
    @data.setter
    def data(self, value: int):
        # dereference(self._ptr).Data = value
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def size(self):
        cdef int res = dereference(self._ptr).Size
        return res
    @size.setter
    def size(self, value: int):
        # dereference(self._ptr).Size = value
        raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImVector_ImDrawListPtr:
    cdef ccimgui.ImVector_ImDrawListPtr* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImDrawListPtr from_ptr(ccimgui.ImVector_ImDrawListPtr* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImDrawListPtr wrapper = ImVector_ImDrawListPtr.__new__(ImVector_ImDrawListPtr)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImDrawListPtr from_heap_ptr(ccimgui.ImVector_ImDrawListPtr* _ptr):
        wrapper = ImVector_ImDrawListPtr.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImDrawList)
    # @property
    # def data(self):
    #     cdef ccimgui.ImDrawList** res = dereference(self._ptr).Data
    #     return ImDrawList.from_ptr(res)
    # @data.setter
    # def data(self, value: ImDrawList):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImVector_ImDrawVert:
    cdef ccimgui.ImVector_ImDrawVert* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImDrawVert from_ptr(ccimgui.ImVector_ImDrawVert* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImDrawVert wrapper = ImVector_ImDrawVert.__new__(ImVector_ImDrawVert)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImDrawVert from_heap_ptr(ccimgui.ImVector_ImDrawVert* _ptr):
        wrapper = ImVector_ImDrawVert.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(True)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImDrawVert)
    @property
    def data(self):
        cdef size_t res = <uintptr_t>dereference(self._ptr).Data
        return res
    @data.setter
    def data(self, value: ImDrawVert):
        # dereference(self._ptr).Data = value._ptr
        raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(True)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    @property
    def size(self):
        cdef int res = dereference(self._ptr).Size
        return res
    @size.setter
    def size(self, value: int):
        # dereference(self._ptr).Size = value
        raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImFontAtlasCustomRect:
    cdef ccimgui.ImVector_ImFontAtlasCustomRect* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImFontAtlasCustomRect from_ptr(ccimgui.ImVector_ImFontAtlasCustomRect* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImFontAtlasCustomRect wrapper = ImVector_ImFontAtlasCustomRect.__new__(ImVector_ImFontAtlasCustomRect)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImFontAtlasCustomRect from_heap_ptr(ccimgui.ImVector_ImFontAtlasCustomRect* _ptr):
        wrapper = ImVector_ImFontAtlasCustomRect.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontAtlasCustomRect)
    # @property
    # def data(self):
    #     cdef ccimgui.ImFontAtlasCustomRect* res = dereference(self._ptr).Data
    #     return ImFontAtlasCustomRect.from_ptr(res)
    # @data.setter
    # def data(self, value: ImFontAtlasCustomRect):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImFontConfig:
    cdef ccimgui.ImVector_ImFontConfig* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImFontConfig from_ptr(ccimgui.ImVector_ImFontConfig* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImFontConfig wrapper = ImVector_ImFontConfig.__new__(ImVector_ImFontConfig)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImFontConfig from_heap_ptr(ccimgui.ImVector_ImFontConfig* _ptr):
        wrapper = ImVector_ImFontConfig.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontConfig)
    # @property
    # def data(self):
    #     cdef ccimgui.ImFontConfig* res = dereference(self._ptr).Data
    #     return ImFontConfig.from_ptr(res)
    # @data.setter
    # def data(self, value: ImFontConfig):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImFontGlyph:
    cdef const ccimgui.ImVector_ImFontGlyph* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImFontGlyph from_ptr(const ccimgui.ImVector_ImFontGlyph* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImFontGlyph wrapper = ImVector_ImFontGlyph.__new__(ImVector_ImFontGlyph)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImFontGlyph from_heap_ptr(ccimgui.ImVector_ImFontGlyph* _ptr):
        wrapper = ImVector_ImFontGlyph.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFontGlyph)
    # @property
    # def data(self):
    #     cdef ccimgui.ImFontGlyph* res = dereference(self._ptr).Data
    #     return ImFontGlyph.from_ptr(res)
    # @data.setter
    # def data(self, value: ImFontGlyph):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImFontPtr:
    cdef ccimgui.ImVector_ImFontPtr* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImFontPtr from_ptr(ccimgui.ImVector_ImFontPtr* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImFontPtr wrapper = ImVector_ImFontPtr.__new__(ImVector_ImFontPtr)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImFontPtr from_heap_ptr(ccimgui.ImVector_ImFontPtr* _ptr):
        wrapper = ImVector_ImFontPtr.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImFont)
    # @property
    # def data(self):
    #     cdef ccimgui.ImFont** res = dereference(self._ptr).Data
    #     return ImFont.from_ptr(res)
    # @data.setter
    # def data(self, value: ImFont):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImGuiPlatformMonitor:
    cdef ccimgui.ImVector_ImGuiPlatformMonitor* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImGuiPlatformMonitor from_ptr(ccimgui.ImVector_ImGuiPlatformMonitor* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImGuiPlatformMonitor wrapper = ImVector_ImGuiPlatformMonitor.__new__(ImVector_ImGuiPlatformMonitor)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImGuiPlatformMonitor from_heap_ptr(ccimgui.ImVector_ImGuiPlatformMonitor* _ptr):
        wrapper = ImVector_ImGuiPlatformMonitor.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGuiPlatformMonitor)
    # @property
    # def data(self):
    #     cdef ccimgui.ImGuiPlatformMonitor* res = dereference(self._ptr).Data
    #     return ImGuiPlatformMonitor.from_ptr(res)
    # @data.setter
    # def data(self, value: ImGuiPlatformMonitor):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(False)
# ?invisible(True)
# ?custom_comment_only(False)
# cdef class ImVector_ImGuiStorage_ImGuiStoragePair:
#     cdef ccimgui.ImVector_ImGuiStorage_ImGuiStoragePair* _ptr
#     cdef bool dynamically_allocated

#     @staticmethod
#     cdef ImVector_ImGuiStorage_ImGuiStoragePair from_ptr(ccimgui.ImVector_ImGuiStorage_ImGuiStoragePair* _ptr):
#         if _ptr == NULL:
#             return None
#         cdef ImVector_ImGuiStorage_ImGuiStoragePair wrapper = ImVector_ImGuiStorage_ImGuiStoragePair.__new__(ImVector_ImGuiStorage_ImGuiStoragePair)
#         wrapper._ptr = _ptr
#         wrapper.dynamically_allocated = False
#         return wrapper

#     @staticmethod
#     cdef ImVector_ImGuiStorage_ImGuiStoragePair from_heap_ptr(ccimgui.ImVector_ImGuiStorage_ImGuiStoragePair* _ptr):
#         wrapper = ImVector_ImGuiStorage_ImGuiStoragePair.from_ptr(_ptr)
#         if wrapper is None:
#             return None
#         wrapper.dynamically_allocated = True
#         return wrapper

#     def __init__(self):
#         raise TypeError("This class cannot be instantiated directly.")

#     def __hash__(self) -> int:
#         if self._ptr == NULL:
#             raise RuntimeError("Won't hash a NULL pointer")
#         cdef unsigned int ptr_int = <uintptr_t>self._ptr
#         return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGuiStorage_ImGuiStoragePair)
    # @property
    # def data(self):
    #     cdef ccimgui.ImGuiStorage_ImGuiStoragePair* res = dereference(self._ptr).Data
    #     return ImGuiStorage_ImGuiStoragePair.from_ptr(res)
    # @data.setter
    # def data(self, value: ImGuiStorage_ImGuiStoragePair):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImGuiTextFilter_ImGuiTextRange:
    cdef ccimgui.ImVector_ImGuiTextFilter_ImGuiTextRange* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImGuiTextFilter_ImGuiTextRange from_ptr(ccimgui.ImVector_ImGuiTextFilter_ImGuiTextRange* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImGuiTextFilter_ImGuiTextRange wrapper = ImVector_ImGuiTextFilter_ImGuiTextRange.__new__(ImVector_ImGuiTextFilter_ImGuiTextRange)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImGuiTextFilter_ImGuiTextRange from_heap_ptr(ccimgui.ImVector_ImGuiTextFilter_ImGuiTextRange* _ptr):
        wrapper = ImVector_ImGuiTextFilter_ImGuiTextRange.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGuiTextFilter_ImGuiTextRange)
    # @property
    # def data(self):
    #     cdef ccimgui.ImGuiTextFilter_ImGuiTextRange* res = dereference(self._ptr).Data
    #     return ImGuiTextFilter_ImGuiTextRange.from_ptr(res)
    # @data.setter
    # def data(self, value: ImGuiTextFilter_ImGuiTextRange):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImGuiViewportPtr:
    cdef ccimgui.ImVector_ImGuiViewportPtr* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImGuiViewportPtr from_ptr(ccimgui.ImVector_ImGuiViewportPtr* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImGuiViewportPtr wrapper = ImVector_ImGuiViewportPtr.__new__(ImVector_ImGuiViewportPtr)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImGuiViewportPtr from_heap_ptr(ccimgui.ImVector_ImGuiViewportPtr* _ptr):
        wrapper = ImVector_ImGuiViewportPtr.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImGuiViewport)
    # @property
    # def data(self):
    #     cdef ccimgui.ImGuiViewport** res = dereference(self._ptr).Data
    #     return ImGuiViewport.from_ptr(res)
    # @data.setter
    # def data(self, value: ImGuiViewport):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImTextureID:
    cdef ccimgui.ImVector_ImTextureID* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImTextureID from_ptr(ccimgui.ImVector_ImTextureID* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImTextureID wrapper = ImVector_ImTextureID.__new__(ImVector_ImTextureID)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImTextureID from_heap_ptr(ccimgui.ImVector_ImTextureID* _ptr):
        wrapper = ImVector_ImTextureID.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Any)
    # @property
    # def data(self):
    #     cdef ccimgui.ImTextureID* res = dereference(self._ptr).Data
    #     return res
    # @data.setter
    # def data(self, value: Any):
    #     # dereference(self._ptr).Data = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImVector_ImU32:
    cdef ccimgui.ImVector_ImU32* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImU32 from_ptr(ccimgui.ImVector_ImU32* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImU32 wrapper = ImVector_ImU32.__new__(ImVector_ImU32)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImU32 from_heap_ptr(ccimgui.ImVector_ImU32* _ptr):
        wrapper = ImVector_ImU32.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def data(self):
    #     cdef ccimgui.ImU32* res = dereference(self._ptr).Data
    #     return res
    # @data.setter
    # def data(self, value: int):
    #     # dereference(self._ptr).Data = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImVec2:
    cdef ccimgui.ImVector_ImVec2* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImVec2 from_ptr(ccimgui.ImVector_ImVec2* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImVec2 wrapper = ImVector_ImVec2.__new__(ImVector_ImVec2)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImVec2 from_heap_ptr(ccimgui.ImVector_ImVec2* _ptr):
        wrapper = ImVector_ImVec2.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImVec2)
    # @property
    # def data(self):
    #     cdef ccimgui.ImVec2* res = dereference(self._ptr).Data
    #     return ImVec2.from_ptr(res)
    # @data.setter
    # def data(self, value: ImVec2):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_ImVec4:
    cdef ccimgui.ImVector_ImVec4* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImVec4 from_ptr(ccimgui.ImVector_ImVec4* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImVec4 wrapper = ImVector_ImVec4.__new__(ImVector_ImVec4)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImVec4 from_heap_ptr(ccimgui.ImVector_ImVec4* _ptr):
        wrapper = ImVector_ImVec4.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(ImVec4)
    # @property
    # def data(self):
    #     cdef ccimgui.ImVec4* res = dereference(self._ptr).Data
    #     return ImVec4.from_ptr(res)
    # @data.setter
    # def data(self, value: ImVec4):
    #     # dereference(self._ptr).Data = value._ptr
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImVector_ImWchar:
    cdef const ccimgui.ImVector_ImWchar* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_ImWchar from_ptr(const ccimgui.ImVector_ImWchar* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_ImWchar wrapper = ImVector_ImWchar.__new__(ImVector_ImWchar)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_ImWchar from_heap_ptr(ccimgui.ImVector_ImWchar* _ptr):
        wrapper = ImVector_ImWchar.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def data(self):
    #     cdef ccimgui.ImWchar* res = dereference(self._ptr).Data
    #     return res
    # @data.setter
    # def data(self, value: int):
    #     # dereference(self._ptr).Data = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class ImVector_char:
    cdef ccimgui.ImVector_char* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_char from_ptr(ccimgui.ImVector_char* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_char wrapper = ImVector_char.__new__(ImVector_char)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_char from_heap_ptr(ccimgui.ImVector_char* _ptr):
        wrapper = ImVector_char.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(str)
    # @property
    # def data(self):
    #     cdef char* res = dereference(self._ptr).Data
    #     return _from_bytes(res)
    # @data.setter
    # def data(self, value: str):
    #     # dereference(self._ptr).Data = _bytes(value)
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

# [Class]
# [Class Constants]
# ?use_template(True)
# ?active(True)
# ?invisible(True)
# ?custom_comment_only(False)
cdef class ImVector_float:
    cdef const ccimgui.ImVector_float* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef ImVector_float from_ptr(const ccimgui.ImVector_float* _ptr):
        if _ptr == NULL:
            return None
        cdef ImVector_float wrapper = ImVector_float.__new__(ImVector_float)
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef ImVector_float from_heap_ptr(ccimgui.ImVector_float* _ptr):
        wrapper = ImVector_float.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
    # [End Class Constants]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def capacity(self):
    #     cdef int res = dereference(self._ptr).Capacity
    #     return res
    # @capacity.setter
    # def capacity(self, value: int):
    #     # dereference(self._ptr).Capacity = value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(Float)
    # @property
    # def data(self):
    #     cdef float* res = dereference(self._ptr).Data
    #     return Float(dereference(res))
    # @data.setter
    # def data(self, value: Float):
    #     # dereference(self._ptr).Data = &value.value
    #     raise NotImplementedError
    # [End Field]

    # [Field]
    # ?use_template(False)
    # ?active(False)
    # ?invisible(False)
    # ?custom_comment_only(False)
    # ?returns(int)
    # @property
    # def size(self):
    #     cdef int res = dereference(self._ptr).Size
    #     return res
    # @size.setter
    # def size(self, value: int):
    #     # dereference(self._ptr).Size = value
    #     raise NotImplementedError
    # [End Field]
# [End Class]

