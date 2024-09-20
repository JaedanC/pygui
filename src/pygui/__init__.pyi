# This file is auto-generated. If you need to edit this file then edit the
# template this is created from instead.
from typing import Any, Callable, Tuple, List, Sequence, Optional
from PIL import Image

FLT_MIN: float
"""
Occasionally used by ImGui to mark boundaries for things. Usually used as
`-pygui.FLT_MIN`
"""
FLT_MAX: float
"""
Occasionally used by ImGui to mark boundaries for things.
"""
INT_MIN: int
INT_MAX: int
UINT_MAX: int
LLONG_MIN: int
LLONG_MAX: int
ULLONG_MAX: int

PAYLOAD_TYPE_COLOR_3F: int
"""
Used by `pygui.accept_drag_drop_payload()` to retrieve colors that are
dragged inside ImGui. No Alpha channel.
"""
PAYLOAD_TYPE_COLOR_4F: int
"""
Used by `pygui.accept_drag_drop_payload()` to retrieve colors that are
dragged inside ImGui. Includes Alpha channel.
"""

class ImGuiError(Exception):
    """
    Raised by ImGui if an `IM_ASSERT()` fails *and* custom exceptions have
    been turned on. Otherwise, this exception will be equal to
    `AssertionError` and ImGui exceptions will be left to crash your app.
    """
    pass

class Bool:
    """
    A wrapper class for a c++ boolean. `Use Bool.value` to access the
    underlying value. This as a replacement for `bool*` in c++.
    """
    value: bool
    def __init__(self, initial_value: bool) -> Bool: ...
    def __bool__(self) -> bool:
        """
        Allows this instance to be directly used a boolean in an `if` statement
        without needing to extract the value.

            ```python
            my_boolean = pygui.Bool(True)
            if my_boolean:
                print("This is true")
            ```
        """

class Int:
    """
    A wrapper class for a c++ int. Use `Int.value` to access the underlying
    value. This as a replacement for `int*` in c++. The underlying `int` size
    will be platform specific. If more bytes are required then use a
    `pygui.Long`.
    """
    value: int
    def __init__(self, initial_value: int=0) -> Int: ...

class Long:
    """
    A wrapper class for a c++ long long. Use `Long.value` to access the
    underlying value. This as a replacement for `long long*` in c++. The
    underlying `long long` size will be platform specific.
    """
    value: int
    def __init__(self, initial_value: int=0) -> Long: ...

class Float:
    """
    A wrapper class for a c++ float. Use `Float.value` to access the
    underlying value. This as a replacement for `float*` in c++. The
    underlying `float` precision will be platform specific. If more precision
    is required then use a `pygui.Double`.
    """
    value: float
    def __init__(self, initial_value: float=0.0) -> Float: ...

class Double:
    """
    A wrapper class for a c++ double. Use `Double.value` to access the
    underlying value. This as a replacement for `double*` in c++. The
    underlying `double` precision will be platform specific.
    """
    value: float
    def __init__(self, initial_value: float=0.0) -> Double: ...

class String:
    """
    A wrapper class for a c++ heap allocated `char*` string. Use
    `String.value` to read the buffer as if it were a python string. The
    `buffer_size` indicates how large the buffer backing this string should
    be. Depending on the characters in the string, the `buffer_size`
    *may not* be the same `len()` as the string.

    The number of writable bytes is equal to `buffer_size - 1`, to make room
    for the NULL byte which is automatically handled by this class.

    Modifying the underling `String.value` is also supported. This will
    automically convert the string passed into bytes and populate the buffer
    using `strncpy` (no buffer overflow for you). Modifying the
    `buffer_size` is *not* supported and will raise a NotImplementedError if
    changed. `buffer_size` must be >= 0 on creation.

    This as a replacement for `char*` in c++.
    """
    value: str
    buffer_size: int
    """
    Read only size of the heap allocated buffer backing this string.
    """
    def __init__(self, initial_value: str="", buffer_size=256) -> String: ...

class Vec2:
    """
    A wrapper class for a c++ ImVec2. Use `Vec2.x` and `Vec2.y` to access
    individual components of the Vector. Or use `Vec2.tuple()` to access the
    the underlying `ImVec2` as a read-only python `tuple`. Each component of
    this `Vec2` is a `pygui.Float`. See the methods on this class for more
    information.
    """
    x: float
    """
    Access/Modify the `x` component of the `Vec2` 
    """
    y: float
    """
    Access/Modify the `y` component of the `Vec2` 
    """
    x_ptr: Float
    """
    Access/Modify the `x` component of the `Vec2` as a `pygui.Float`
    """
    y_ptr: Float
    """
    Access/Modify the `y` component of the `Vec2` as a `pygui.Float`
    """
    def __init__(self, x: float, y: float) -> Vec2: ...
    @staticmethod
    def zero() -> Vec2:
        """
        Same as `Vec2(0, 0)`
        """
        pass

    def tuple(self) -> Sequence[float, float]:
        """
        Access a read-only tuple containing the `x`, `y` components of the
        `Vec2`
        """
        pass

    def from_tuple(self, vec: Sequence[float, float]) -> Vec2:
        """
        Modify the components of the `Vec2` using a (minimum) length 2
        Sequence. eg. tuple/list

            ```python
            vec2 = pygui.Vec2(0, 0)
            vec2.from_tuple((50, 100))
            ```

        Returns the same Vec2 so that this method can be chained.
        """
        pass

    def as_floatptrs(self) -> Sequence[Float, Float]:
        """
        Returns the internal components of the `Vec2` as a length 2 tuple of
        `pygui.Floats`. Each `pygui.Float` can be used to modify the
        internal state of the `Vec2` from elsewhere.
        """
        pass

    def from_floatptrs(self, float_ptrs: Sequence[Float, Float]) -> Vec2:
        """
        Modify the components of the `Vec2` using a (minimum) length 2
        Sequence of `pygui.Float`. eg. tuple/list. Returns the same Vec2 so
        that this method can be chained.
        """
        pass

    def copy(self) -> Vec2:
        """
        Returns a new deepcopied `Vec2`. The underlying `pygui.Float` are
        also new.
        """
        pass

class Vec4:
    """
    A wrapper class for a c++ ImVec4. Use `Vec4.x`, `Vec4.y`, `Vec4.z` and
    `Vec4.w` to access individual components of the Vector. Or use
    `Vec4.tuple()` to access the the underlying `ImVec4` as a read-only
    python `tuple`. Each component of this `Vec4` is a `pygui.Float`. See
    the methods on this class for more information.
    """
    x: float
    """
    Access/Modify the `x` component of the `Vec4` 
    """
    y: float
    """
    Access/Modify the `y` component of the `Vec4` 
    """
    z: float
    """
    Access/Modify the `z` component of the `Vec4` 
    """
    w: float
    """
    Access/Modify the `w` component of the `Vec4` 
    """
    x_ptr: Float
    """
    Access/Modify the `x` component of the `Vec4` as a `pygui.Float`
    """
    y_ptr: Float
    """
    Access/Modify the `y` component of the `Vec4` as a `pygui.Float`
    """
    z_ptr: Float
    """
    Access/Modify the `z` component of the `Vec4` as a `pygui.Float`
    """
    w_ptr: Float
    """
    Access/Modify the `w` component of the `Vec4` as a `pygui.Float`
    """
    def __init__(self, x: float, y: float, z: float, w: float) -> Vec4: ...
    @staticmethod
    def zero() -> Vec4:
        """
        Same as `Vec4(0, 0)`
        """
        pass

    def tuple(self) -> Sequence[float, float, float, float]:
        """
        Access a read-only tuple containing the components of the `Vec4`
        """
        pass

    def from_tuple(self, vec: Sequence[float, float, float, float]) -> Vec4:
        """
        Modify the components of the `Vec4` using a (minimum)
        length 4 Sequence. eg. tuple/list

            ```python
            vec4 = pygui.Vec4(0, 0, 0, 0)
            vec4.from_tuple((50, 100, 150, 200))
            ```

        Returns the same Vec4 so that this method can be chained.
        """
        pass

    def as_floatptrs(self) -> Sequence[Float, Float, Float, Float]:
        """
        Returns the internal components of the `Vec2` as a length 4 tuple of
        `pygui.Floats`. Each `pygui.Float` can be used to modify the
        internal state of the `Vec4` from elsewhere.
        """
        pass

    def from_floatptrs(self, float_ptrs: Sequence[Float, Float, Float, Float]) -> Vec4:
        """
        Modify the components of the `Vec4` using a (minimum) length 4
        Sequence of `pygui.Float`. eg. tuple/list. Returns the same Vec4 so
        that this method can be chained.
        """
        pass

    def to_u32(self) -> int:
        """
        Converts this `Vec4` into a u32 integer. u32 integers are used in
        ImGui for coloring.
        """
        pass

    def copy(self) -> Vec4:
        """
        Returns a new deepcopied `Vec4`. The underlying `pygui.Float` are
        also new.
        """
        pass

class ImGlyphRange:
    """
    A custom wrapper around an `unsigned short*` array. This is used to back
    the glyph range used by many of the font functions in pygui. Pass a list
    of 2 element tuples to create a valid range.

    For example:

        ```python
        range = pygui.ImGlyphRange([
            (0x01,   0xFF),   # Extended ASCII Range,
            (0x1F00, 0x1FFF), # Greek Extended Range
        ])
        ```

    Unlike ImGui, you do not need to pass a 0 element to mark the end of
    the array. This class will handle that. If any of the ranges start with
    a 0, that range will be changed to 1.

        ```python
        range = pygui.ImGlyphRange([
            (0x00, 0xFF) # Internally adds 1
        ]) 
        # Is the the same as
        range = pygui.ImGlyphRange([
            (0x01, 0xFF)
        ])
        ```
    """
    ranges: Sequence[tuple]
    """
    The (read-only) list of ranges backing this object. Modifying this value
    will raise a NotImplementedError.
    """
    def __init__(self, glyph_ranges: Sequence[tuple]): ...
    def destroy(self):
        """
        Internally, the memory backing the ImGlyphRange will be freed when
        the python object is cleaned up by the garbage collector, but this
        may actually free the memory backing this range before you call
        `ImFontAtlas.build()` which requires the buffer to be valid. Hence,
        this function exists.

        Call `ImGlyphRange.destroy()` explicitly after calling
        `ImFontAtlas.build()` to ensure Python does not garbage-collect this
        object.
        """
        pass


def IM_COL32(r: int, g: int, b: int, a: int) -> int:
    """
    Mimics a macro in ImGui. Each components is between 0-255. The result is
    a u32 integer used commonly in ImGui for coloring.
    """

IM_COL32_WHITE: int
IM_COL32_BLACK: int
IM_COL32_BLACK_TRANS: int

class ImGuiError(Exception): ...

def IM_ASSERT(condition: bool, msg: str=""):
    """
    Use like `assert`. If the condition is false an `ImGuiError` is raised.
    """
    pass

def IM_CLAMP(n, smallest, largest):
    """
    Returns n clamped to [smallest, largest]
    """
    pass

def load_image(image: Image) -> int:
    """
    Loads a PIL image into ImGui. Returns a texture handle that can be used
    in any `pygui.image` function.
    """
    pass

# def sizeof(_type) -> int:
#     """
#     Placeholder to make the pyi not get upset about sizeof() in cython.
#     Do not use.
#     """
#     pass

WINDOW_FLAGS_NONE: int
WINDOW_FLAGS_NO_TITLE_BAR: int
WINDOW_FLAGS_NO_RESIZE: int
WINDOW_FLAGS_NO_MOVE: int
WINDOW_FLAGS_NO_SCROLLBAR: int
WINDOW_FLAGS_NO_SCROLL_WITH_MOUSE: int
WINDOW_FLAGS_NO_COLLAPSE: int
WINDOW_FLAGS_ALWAYS_AUTO_RESIZE: int
WINDOW_FLAGS_NO_BACKGROUND: int
WINDOW_FLAGS_NO_SAVED_SETTINGS: int
WINDOW_FLAGS_NO_MOUSE_INPUTS: int
WINDOW_FLAGS_MENU_BAR: int
WINDOW_FLAGS_HORIZONTAL_SCROLLBAR: int
WINDOW_FLAGS_NO_FOCUS_ON_APPEARING: int
WINDOW_FLAGS_NO_BRING_TO_FRONT_ON_FOCUS: int
WINDOW_FLAGS_ALWAYS_VERTICAL_SCROLLBAR: int
WINDOW_FLAGS_ALWAYS_HORIZONTAL_SCROLLBAR: int
WINDOW_FLAGS_NO_NAV_INPUTS: int
WINDOW_FLAGS_NO_NAV_FOCUS: int
WINDOW_FLAGS_UNSAVED_DOCUMENT: int
WINDOW_FLAGS_NO_DOCKING: int
WINDOW_FLAGS_NO_NAV: int
WINDOW_FLAGS_NO_DECORATION: int
WINDOW_FLAGS_NO_INPUTS: int
WINDOW_FLAGS_CHILD_WINDOW: int
WINDOW_FLAGS_TOOLTIP: int
WINDOW_FLAGS_POPUP: int
WINDOW_FLAGS_MODAL: int
WINDOW_FLAGS_CHILD_MENU: int
WINDOW_FLAGS_DOCK_NODE_HOST: int
CHILD_FLAGS_NONE: int
CHILD_FLAGS_BORDERS: int
CHILD_FLAGS_ALWAYS_USE_WINDOW_PADDING: int
CHILD_FLAGS_RESIZE_X: int
CHILD_FLAGS_RESIZE_Y: int
CHILD_FLAGS_AUTO_RESIZE_X: int
CHILD_FLAGS_AUTO_RESIZE_Y: int
CHILD_FLAGS_ALWAYS_AUTO_RESIZE: int
CHILD_FLAGS_FRAME_STYLE: int
CHILD_FLAGS_NAV_FLATTENED: int
ITEM_FLAGS_NONE: int
ITEM_FLAGS_NO_TAB_STOP: int
ITEM_FLAGS_NO_NAV: int
ITEM_FLAGS_NO_NAV_DEFAULT_FOCUS: int
ITEM_FLAGS_BUTTON_REPEAT: int
ITEM_FLAGS_AUTO_CLOSE_POPUPS: int
INPUT_TEXT_FLAGS_NONE: int
INPUT_TEXT_FLAGS_CHARS_DECIMAL: int
INPUT_TEXT_FLAGS_CHARS_HEXADECIMAL: int
INPUT_TEXT_FLAGS_CHARS_SCIENTIFIC: int
INPUT_TEXT_FLAGS_CHARS_UPPERCASE: int
INPUT_TEXT_FLAGS_CHARS_NO_BLANK: int
INPUT_TEXT_FLAGS_ALLOW_TAB_INPUT: int
INPUT_TEXT_FLAGS_ENTER_RETURNS_TRUE: int
INPUT_TEXT_FLAGS_ESCAPE_CLEARS_ALL: int
INPUT_TEXT_FLAGS_CTRL_ENTER_FOR_NEW_LINE: int
INPUT_TEXT_FLAGS_READ_ONLY: int
INPUT_TEXT_FLAGS_PASSWORD: int
INPUT_TEXT_FLAGS_ALWAYS_OVERWRITE: int
INPUT_TEXT_FLAGS_AUTO_SELECT_ALL: int
INPUT_TEXT_FLAGS_PARSE_EMPTY_REF_VAL: int
INPUT_TEXT_FLAGS_DISPLAY_EMPTY_REF_VAL: int
INPUT_TEXT_FLAGS_NO_HORIZONTAL_SCROLL: int
INPUT_TEXT_FLAGS_NO_UNDO_REDO: int
INPUT_TEXT_FLAGS_CALLBACK_COMPLETION: int
INPUT_TEXT_FLAGS_CALLBACK_HISTORY: int
INPUT_TEXT_FLAGS_CALLBACK_ALWAYS: int
INPUT_TEXT_FLAGS_CALLBACK_CHAR_FILTER: int
INPUT_TEXT_FLAGS_CALLBACK_RESIZE: int
INPUT_TEXT_FLAGS_CALLBACK_EDIT: int
TREE_NODE_FLAGS_NONE: int
TREE_NODE_FLAGS_SELECTED: int
TREE_NODE_FLAGS_FRAMED: int
TREE_NODE_FLAGS_ALLOW_OVERLAP: int
TREE_NODE_FLAGS_NO_TREE_PUSH_ON_OPEN: int
TREE_NODE_FLAGS_NO_AUTO_OPEN_ON_LOG: int
TREE_NODE_FLAGS_DEFAULT_OPEN: int
TREE_NODE_FLAGS_OPEN_ON_DOUBLE_CLICK: int
TREE_NODE_FLAGS_OPEN_ON_ARROW: int
TREE_NODE_FLAGS_LEAF: int
TREE_NODE_FLAGS_BULLET: int
TREE_NODE_FLAGS_FRAME_PADDING: int
TREE_NODE_FLAGS_SPAN_AVAIL_WIDTH: int
TREE_NODE_FLAGS_SPAN_FULL_WIDTH: int
TREE_NODE_FLAGS_SPAN_TEXT_WIDTH: int
TREE_NODE_FLAGS_SPAN_ALL_COLUMNS: int
TREE_NODE_FLAGS_NAV_LEFT_JUMPS_BACK_HERE: int
TREE_NODE_FLAGS_COLLAPSING_HEADER: int
POPUP_FLAGS_NONE: int
POPUP_FLAGS_MOUSE_BUTTON_LEFT: int
POPUP_FLAGS_MOUSE_BUTTON_RIGHT: int
POPUP_FLAGS_MOUSE_BUTTON_MIDDLE: int
POPUP_FLAGS_MOUSE_BUTTON_MASK: int
POPUP_FLAGS_MOUSE_BUTTON_DEFAULT: int
POPUP_FLAGS_NO_REOPEN: int
POPUP_FLAGS_NO_OPEN_OVER_EXISTING_POPUP: int
POPUP_FLAGS_NO_OPEN_OVER_ITEMS: int
POPUP_FLAGS_ANY_POPUP_ID: int
POPUP_FLAGS_ANY_POPUP_LEVEL: int
POPUP_FLAGS_ANY_POPUP: int
SELECTABLE_FLAGS_NONE: int
SELECTABLE_FLAGS_NO_AUTO_CLOSE_POPUPS: int
SELECTABLE_FLAGS_SPAN_ALL_COLUMNS: int
SELECTABLE_FLAGS_ALLOW_DOUBLE_CLICK: int
SELECTABLE_FLAGS_DISABLED: int
SELECTABLE_FLAGS_ALLOW_OVERLAP: int
SELECTABLE_FLAGS_HIGHLIGHT: int
COMBO_FLAGS_NONE: int
COMBO_FLAGS_POPUP_ALIGN_LEFT: int
COMBO_FLAGS_HEIGHT_SMALL: int
COMBO_FLAGS_HEIGHT_REGULAR: int
COMBO_FLAGS_HEIGHT_LARGE: int
COMBO_FLAGS_HEIGHT_LARGEST: int
COMBO_FLAGS_NO_ARROW_BUTTON: int
COMBO_FLAGS_NO_PREVIEW: int
COMBO_FLAGS_WIDTH_FIT_PREVIEW: int
COMBO_FLAGS_HEIGHT_MASK: int
TAB_BAR_FLAGS_NONE: int
TAB_BAR_FLAGS_REORDERABLE: int
TAB_BAR_FLAGS_AUTO_SELECT_NEW_TABS: int
TAB_BAR_FLAGS_TAB_LIST_POPUP_BUTTON: int
TAB_BAR_FLAGS_NO_CLOSE_WITH_MIDDLE_MOUSE_BUTTON: int
TAB_BAR_FLAGS_NO_TAB_LIST_SCROLLING_BUTTONS: int
TAB_BAR_FLAGS_NO_TOOLTIP: int
TAB_BAR_FLAGS_DRAW_SELECTED_OVERLINE: int
TAB_BAR_FLAGS_FITTING_POLICY_RESIZE_DOWN: int
TAB_BAR_FLAGS_FITTING_POLICY_SCROLL: int
TAB_BAR_FLAGS_FITTING_POLICY_MASK: int
TAB_BAR_FLAGS_FITTING_POLICY_DEFAULT: int
TAB_ITEM_FLAGS_NONE: int
TAB_ITEM_FLAGS_UNSAVED_DOCUMENT: int
TAB_ITEM_FLAGS_SET_SELECTED: int
TAB_ITEM_FLAGS_NO_CLOSE_WITH_MIDDLE_MOUSE_BUTTON: int
TAB_ITEM_FLAGS_NO_PUSH_ID: int
TAB_ITEM_FLAGS_NO_TOOLTIP: int
TAB_ITEM_FLAGS_NO_REORDER: int
TAB_ITEM_FLAGS_LEADING: int
TAB_ITEM_FLAGS_TRAILING: int
TAB_ITEM_FLAGS_NO_ASSUMED_CLOSURE: int
FOCUSED_FLAGS_NONE: int
FOCUSED_FLAGS_CHILD_WINDOWS: int
FOCUSED_FLAGS_ROOT_WINDOW: int
FOCUSED_FLAGS_ANY_WINDOW: int
FOCUSED_FLAGS_NO_POPUP_HIERARCHY: int
FOCUSED_FLAGS_DOCK_HIERARCHY: int
FOCUSED_FLAGS_ROOT_AND_CHILD_WINDOWS: int
HOVERED_FLAGS_NONE: int
HOVERED_FLAGS_CHILD_WINDOWS: int
HOVERED_FLAGS_ROOT_WINDOW: int
HOVERED_FLAGS_ANY_WINDOW: int
HOVERED_FLAGS_NO_POPUP_HIERARCHY: int
HOVERED_FLAGS_DOCK_HIERARCHY: int
HOVERED_FLAGS_ALLOW_WHEN_BLOCKED_BY_POPUP: int
HOVERED_FLAGS_ALLOW_WHEN_BLOCKED_BY_ACTIVE_ITEM: int
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED_BY_ITEM: int
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED_BY_WINDOW: int
HOVERED_FLAGS_ALLOW_WHEN_DISABLED: int
HOVERED_FLAGS_NO_NAV_OVERRIDE: int
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED: int
HOVERED_FLAGS_RECT_ONLY: int
HOVERED_FLAGS_ROOT_AND_CHILD_WINDOWS: int
HOVERED_FLAGS_FOR_TOOLTIP: int
HOVERED_FLAGS_STATIONARY: int
HOVERED_FLAGS_DELAY_NONE: int
HOVERED_FLAGS_DELAY_SHORT: int
HOVERED_FLAGS_DELAY_NORMAL: int
HOVERED_FLAGS_NO_SHARED_DELAY: int
DOCK_NODE_FLAGS_NONE: int
DOCK_NODE_FLAGS_KEEP_ALIVE_ONLY: int
DOCK_NODE_FLAGS_NO_DOCKING_OVER_CENTRAL_NODE: int
DOCK_NODE_FLAGS_PASSTHRU_CENTRAL_NODE: int
DOCK_NODE_FLAGS_NO_DOCKING_SPLIT: int
DOCK_NODE_FLAGS_NO_RESIZE: int
DOCK_NODE_FLAGS_AUTO_HIDE_TAB_BAR: int
DOCK_NODE_FLAGS_NO_UNDOCKING: int
DRAG_DROP_FLAGS_NONE: int
DRAG_DROP_FLAGS_SOURCE_NO_PREVIEW_TOOLTIP: int
DRAG_DROP_FLAGS_SOURCE_NO_DISABLE_HOVER: int
DRAG_DROP_FLAGS_SOURCE_NO_HOLD_TO_OPEN_OTHERS: int
DRAG_DROP_FLAGS_SOURCE_ALLOW_NULL_ID: int
DRAG_DROP_FLAGS_SOURCE_EXTERN: int
DRAG_DROP_FLAGS_PAYLOAD_AUTO_EXPIRE: int
DRAG_DROP_FLAGS_PAYLOAD_NO_CROSS_CONTEXT: int
DRAG_DROP_FLAGS_PAYLOAD_NO_CROSS_PROCESS: int
DRAG_DROP_FLAGS_ACCEPT_BEFORE_DELIVERY: int
DRAG_DROP_FLAGS_ACCEPT_NO_DRAW_DEFAULT_RECT: int
DRAG_DROP_FLAGS_ACCEPT_NO_PREVIEW_TOOLTIP: int
DRAG_DROP_FLAGS_ACCEPT_PEEK_ONLY: int
DATA_TYPE_S8: int
DATA_TYPE_U8: int
DATA_TYPE_S16: int
DATA_TYPE_U16: int
DATA_TYPE_S32: int
DATA_TYPE_U32: int
DATA_TYPE_S64: int
DATA_TYPE_U64: int
DATA_TYPE_FLOAT: int
DATA_TYPE_DOUBLE: int
DATA_TYPE_BOOL: int
DATA_TYPE_COUNT: int
DIR_NONE: int
DIR_LEFT: int
DIR_RIGHT: int
DIR_UP: int
DIR_DOWN: int
DIR_COUNT: int
SORT_DIRECTION_NONE: int
SORT_DIRECTION_ASCENDING: int
SORT_DIRECTION_DESCENDING: int
KEY_NONE: int
KEY_TAB: int
KEY_LEFT_ARROW: int
KEY_RIGHT_ARROW: int
KEY_UP_ARROW: int
KEY_DOWN_ARROW: int
KEY_PAGE_UP: int
KEY_PAGE_DOWN: int
KEY_HOME: int
KEY_END: int
KEY_INSERT: int
KEY_DELETE: int
KEY_BACKSPACE: int
KEY_SPACE: int
KEY_ENTER: int
KEY_ESCAPE: int
KEY_LEFT_CTRL: int
KEY_LEFT_SHIFT: int
KEY_LEFT_ALT: int
KEY_LEFT_SUPER: int
KEY_RIGHT_CTRL: int
KEY_RIGHT_SHIFT: int
KEY_RIGHT_ALT: int
KEY_RIGHT_SUPER: int
KEY_MENU: int
KEY_0: int
KEY_1: int
KEY_2: int
KEY_3: int
KEY_4: int
KEY_5: int
KEY_6: int
KEY_7: int
KEY_8: int
KEY_9: int
KEY_A: int
KEY_B: int
KEY_C: int
KEY_D: int
KEY_E: int
KEY_F: int
KEY_G: int
KEY_H: int
KEY_I: int
KEY_J: int
KEY_K: int
KEY_L: int
KEY_M: int
KEY_N: int
KEY_O: int
KEY_P: int
KEY_Q: int
KEY_R: int
KEY_S: int
KEY_T: int
KEY_U: int
KEY_V: int
KEY_W: int
KEY_X: int
KEY_Y: int
KEY_Z: int
KEY_F1: int
KEY_F2: int
KEY_F3: int
KEY_F4: int
KEY_F5: int
KEY_F6: int
KEY_F7: int
KEY_F8: int
KEY_F9: int
KEY_F10: int
KEY_F11: int
KEY_F12: int
KEY_F13: int
KEY_F14: int
KEY_F15: int
KEY_F16: int
KEY_F17: int
KEY_F18: int
KEY_F19: int
KEY_F20: int
KEY_F21: int
KEY_F22: int
KEY_F23: int
KEY_F24: int
KEY_APOSTROPHE: int
KEY_COMMA: int
KEY_MINUS: int
KEY_PERIOD: int
KEY_SLASH: int
KEY_SEMICOLON: int
KEY_EQUAL: int
KEY_LEFT_BRACKET: int
KEY_BACKSLASH: int
KEY_RIGHT_BRACKET: int
KEY_GRAVE_ACCENT: int
KEY_CAPS_LOCK: int
KEY_SCROLL_LOCK: int
KEY_NUM_LOCK: int
KEY_PRINT_SCREEN: int
KEY_PAUSE: int
KEY_KEYPAD0: int
KEY_KEYPAD1: int
KEY_KEYPAD2: int
KEY_KEYPAD3: int
KEY_KEYPAD4: int
KEY_KEYPAD5: int
KEY_KEYPAD6: int
KEY_KEYPAD7: int
KEY_KEYPAD8: int
KEY_KEYPAD9: int
KEY_KEYPAD_DECIMAL: int
KEY_KEYPAD_DIVIDE: int
KEY_KEYPAD_MULTIPLY: int
KEY_KEYPAD_SUBTRACT: int
KEY_KEYPAD_ADD: int
KEY_KEYPAD_ENTER: int
KEY_KEYPAD_EQUAL: int
KEY_APP_BACK: int
KEY_APP_FORWARD: int
KEY_GAMEPAD_START: int
KEY_GAMEPAD_BACK: int
KEY_GAMEPAD_FACE_LEFT: int
KEY_GAMEPAD_FACE_RIGHT: int
KEY_GAMEPAD_FACE_UP: int
KEY_GAMEPAD_FACE_DOWN: int
KEY_GAMEPAD_DPAD_LEFT: int
KEY_GAMEPAD_DPAD_RIGHT: int
KEY_GAMEPAD_DPAD_UP: int
KEY_GAMEPAD_DPAD_DOWN: int
KEY_GAMEPAD_L1: int
KEY_GAMEPAD_R1: int
KEY_GAMEPAD_L2: int
KEY_GAMEPAD_R2: int
KEY_GAMEPAD_L3: int
KEY_GAMEPAD_R3: int
KEY_GAMEPAD_LSTICK_LEFT: int
KEY_GAMEPAD_LSTICK_RIGHT: int
KEY_GAMEPAD_LSTICK_UP: int
KEY_GAMEPAD_LSTICK_DOWN: int
KEY_GAMEPAD_RSTICK_LEFT: int
KEY_GAMEPAD_RSTICK_RIGHT: int
KEY_GAMEPAD_RSTICK_UP: int
KEY_GAMEPAD_RSTICK_DOWN: int
KEY_MOUSE_LEFT: int
KEY_MOUSE_RIGHT: int
KEY_MOUSE_MIDDLE: int
KEY_MOUSE_X1: int
KEY_MOUSE_X2: int
KEY_MOUSE_WHEEL_X: int
KEY_MOUSE_WHEEL_Y: int
KEY_RESERVED_FOR_MOD_CTRL: int
KEY_RESERVED_FOR_MOD_SHIFT: int
KEY_RESERVED_FOR_MOD_ALT: int
KEY_RESERVED_FOR_MOD_SUPER: int
KEY_COUNT: int
MOD_NONE: int
MOD_CTRL: int
MOD_SHIFT: int
MOD_ALT: int
MOD_SUPER: int
MOD_MASK: int
KEY_NAMED_KEY_BEGIN: int
KEY_NAMED_KEY_END: int
KEY_NAMED_KEY_COUNT: int
KEY_KEYS_DATA_SIZE: int
KEY_KEYS_DATA_OFFSET: int
INPUT_FLAGS_NONE: int
INPUT_FLAGS_REPEAT: int
INPUT_FLAGS_ROUTE_ACTIVE: int
INPUT_FLAGS_ROUTE_FOCUSED: int
INPUT_FLAGS_ROUTE_GLOBAL: int
INPUT_FLAGS_ROUTE_ALWAYS: int
INPUT_FLAGS_ROUTE_OVER_FOCUSED: int
INPUT_FLAGS_ROUTE_OVER_ACTIVE: int
INPUT_FLAGS_ROUTE_UNLESS_BG_FOCUSED: int
INPUT_FLAGS_ROUTE_FROM_ROOT_WINDOW: int
INPUT_FLAGS_TOOLTIP: int
CONFIG_FLAGS_NONE: int
CONFIG_FLAGS_NAV_ENABLE_KEYBOARD: int
CONFIG_FLAGS_NAV_ENABLE_GAMEPAD: int
CONFIG_FLAGS_NAV_ENABLE_SET_MOUSE_POS: int
CONFIG_FLAGS_NAV_NO_CAPTURE_KEYBOARD: int
CONFIG_FLAGS_NO_MOUSE: int
CONFIG_FLAGS_NO_MOUSE_CURSOR_CHANGE: int
CONFIG_FLAGS_NO_KEYBOARD: int
CONFIG_FLAGS_DOCKING_ENABLE: int
CONFIG_FLAGS_VIEWPORTS_ENABLE: int
CONFIG_FLAGS_DPI_ENABLE_SCALE_VIEWPORTS: int
CONFIG_FLAGS_DPI_ENABLE_SCALE_FONTS: int
CONFIG_FLAGS_IS_S_RGB: int
CONFIG_FLAGS_IS_TOUCH_SCREEN: int
BACKEND_FLAGS_NONE: int
BACKEND_FLAGS_HAS_GAMEPAD: int
BACKEND_FLAGS_HAS_MOUSE_CURSORS: int
BACKEND_FLAGS_HAS_SET_MOUSE_POS: int
BACKEND_FLAGS_RENDERER_HAS_VTX_OFFSET: int
BACKEND_FLAGS_PLATFORM_HAS_VIEWPORTS: int
BACKEND_FLAGS_HAS_MOUSE_HOVERED_VIEWPORT: int
BACKEND_FLAGS_RENDERER_HAS_VIEWPORTS: int
COL_TEXT: int
COL_TEXT_DISABLED: int
COL_WINDOW_BG: int
COL_CHILD_BG: int
COL_POPUP_BG: int
COL_BORDER: int
COL_BORDER_SHADOW: int
COL_FRAME_BG: int
COL_FRAME_BG_HOVERED: int
COL_FRAME_BG_ACTIVE: int
COL_TITLE_BG: int
COL_TITLE_BG_ACTIVE: int
COL_TITLE_BG_COLLAPSED: int
COL_MENU_BAR_BG: int
COL_SCROLLBAR_BG: int
COL_SCROLLBAR_GRAB: int
COL_SCROLLBAR_GRAB_HOVERED: int
COL_SCROLLBAR_GRAB_ACTIVE: int
COL_CHECK_MARK: int
COL_SLIDER_GRAB: int
COL_SLIDER_GRAB_ACTIVE: int
COL_BUTTON: int
COL_BUTTON_HOVERED: int
COL_BUTTON_ACTIVE: int
COL_HEADER: int
COL_HEADER_HOVERED: int
COL_HEADER_ACTIVE: int
COL_SEPARATOR: int
COL_SEPARATOR_HOVERED: int
COL_SEPARATOR_ACTIVE: int
COL_RESIZE_GRIP: int
COL_RESIZE_GRIP_HOVERED: int
COL_RESIZE_GRIP_ACTIVE: int
COL_TAB_HOVERED: int
COL_TAB: int
COL_TAB_SELECTED: int
COL_TAB_SELECTED_OVERLINE: int
COL_TAB_DIMMED: int
COL_TAB_DIMMED_SELECTED: int
COL_TAB_DIMMED_SELECTED_OVERLINE: int
COL_DOCKING_PREVIEW: int
COL_DOCKING_EMPTY_BG: int
COL_PLOT_LINES: int
COL_PLOT_LINES_HOVERED: int
COL_PLOT_HISTOGRAM: int
COL_PLOT_HISTOGRAM_HOVERED: int
COL_TABLE_HEADER_BG: int
COL_TABLE_BORDER_STRONG: int
COL_TABLE_BORDER_LIGHT: int
COL_TABLE_ROW_BG: int
COL_TABLE_ROW_BG_ALT: int
COL_TEXT_LINK: int
COL_TEXT_SELECTED_BG: int
COL_DRAG_DROP_TARGET: int
COL_NAV_HIGHLIGHT: int
COL_NAV_WINDOWING_HIGHLIGHT: int
COL_NAV_WINDOWING_DIM_BG: int
COL_MODAL_WINDOW_DIM_BG: int
COL_COUNT: int
STYLE_VAR_ALPHA: int
STYLE_VAR_DISABLED_ALPHA: int
STYLE_VAR_WINDOW_PADDING: int
STYLE_VAR_WINDOW_ROUNDING: int
STYLE_VAR_WINDOW_BORDER_SIZE: int
STYLE_VAR_WINDOW_MIN_SIZE: int
STYLE_VAR_WINDOW_TITLE_ALIGN: int
STYLE_VAR_CHILD_ROUNDING: int
STYLE_VAR_CHILD_BORDER_SIZE: int
STYLE_VAR_POPUP_ROUNDING: int
STYLE_VAR_POPUP_BORDER_SIZE: int
STYLE_VAR_FRAME_PADDING: int
STYLE_VAR_FRAME_ROUNDING: int
STYLE_VAR_FRAME_BORDER_SIZE: int
STYLE_VAR_ITEM_SPACING: int
STYLE_VAR_ITEM_INNER_SPACING: int
STYLE_VAR_INDENT_SPACING: int
STYLE_VAR_CELL_PADDING: int
STYLE_VAR_SCROLLBAR_SIZE: int
STYLE_VAR_SCROLLBAR_ROUNDING: int
STYLE_VAR_GRAB_MIN_SIZE: int
STYLE_VAR_GRAB_ROUNDING: int
STYLE_VAR_TAB_ROUNDING: int
STYLE_VAR_TAB_BORDER_SIZE: int
STYLE_VAR_TAB_BAR_BORDER_SIZE: int
STYLE_VAR_TAB_BAR_OVERLINE_SIZE: int
STYLE_VAR_TABLE_ANGLED_HEADERS_ANGLE: int
STYLE_VAR_TABLE_ANGLED_HEADERS_TEXT_ALIGN: int
STYLE_VAR_BUTTON_TEXT_ALIGN: int
STYLE_VAR_SELECTABLE_TEXT_ALIGN: int
STYLE_VAR_SEPARATOR_TEXT_BORDER_SIZE: int
STYLE_VAR_SEPARATOR_TEXT_ALIGN: int
STYLE_VAR_SEPARATOR_TEXT_PADDING: int
STYLE_VAR_DOCKING_SEPARATOR_SIZE: int
STYLE_VAR_COUNT: int
BUTTON_FLAGS_NONE: int
BUTTON_FLAGS_MOUSE_BUTTON_LEFT: int
BUTTON_FLAGS_MOUSE_BUTTON_RIGHT: int
BUTTON_FLAGS_MOUSE_BUTTON_MIDDLE: int
BUTTON_FLAGS_MOUSE_BUTTON_MASK: int
COLOR_EDIT_FLAGS_NONE: int
COLOR_EDIT_FLAGS_NO_ALPHA: int
COLOR_EDIT_FLAGS_NO_PICKER: int
COLOR_EDIT_FLAGS_NO_OPTIONS: int
COLOR_EDIT_FLAGS_NO_SMALL_PREVIEW: int
COLOR_EDIT_FLAGS_NO_INPUTS: int
COLOR_EDIT_FLAGS_NO_TOOLTIP: int
COLOR_EDIT_FLAGS_NO_LABEL: int
COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW: int
COLOR_EDIT_FLAGS_NO_DRAG_DROP: int
COLOR_EDIT_FLAGS_NO_BORDER: int
COLOR_EDIT_FLAGS_ALPHA_BAR: int
COLOR_EDIT_FLAGS_ALPHA_PREVIEW: int
COLOR_EDIT_FLAGS_ALPHA_PREVIEW_HALF: int
COLOR_EDIT_FLAGS_HDR: int
COLOR_EDIT_FLAGS_DISPLAY_RGB: int
COLOR_EDIT_FLAGS_DISPLAY_HSV: int
COLOR_EDIT_FLAGS_DISPLAY_HEX: int
COLOR_EDIT_FLAGS_UINT8: int
COLOR_EDIT_FLAGS_FLOAT: int
COLOR_EDIT_FLAGS_PICKER_HUE_BAR: int
COLOR_EDIT_FLAGS_PICKER_HUE_WHEEL: int
COLOR_EDIT_FLAGS_INPUT_RGB: int
COLOR_EDIT_FLAGS_INPUT_HSV: int
COLOR_EDIT_FLAGS_DEFAULT_OPTIONS: int
COLOR_EDIT_FLAGS_DISPLAY_MASK: int
COLOR_EDIT_FLAGS_DATA_TYPE_MASK: int
COLOR_EDIT_FLAGS_PICKER_MASK: int
COLOR_EDIT_FLAGS_INPUT_MASK: int
SLIDER_FLAGS_NONE: int
SLIDER_FLAGS_ALWAYS_CLAMP: int
SLIDER_FLAGS_LOGARITHMIC: int
SLIDER_FLAGS_NO_ROUND_TO_FORMAT: int
SLIDER_FLAGS_NO_INPUT: int
SLIDER_FLAGS_WRAP_AROUND: int
SLIDER_FLAGS_INVALID_MASK: int
MOUSE_BUTTON_LEFT: int
MOUSE_BUTTON_RIGHT: int
MOUSE_BUTTON_MIDDLE: int
MOUSE_BUTTON_COUNT: int
MOUSE_CURSOR_NONE: int
MOUSE_CURSOR_ARROW: int
MOUSE_CURSOR_TEXT_INPUT: int
MOUSE_CURSOR_RESIZE_ALL: int
MOUSE_CURSOR_RESIZE_NS: int
MOUSE_CURSOR_RESIZE_EW: int
MOUSE_CURSOR_RESIZE_NESW: int
MOUSE_CURSOR_RESIZE_NWSE: int
MOUSE_CURSOR_HAND: int
MOUSE_CURSOR_NOT_ALLOWED: int
MOUSE_CURSOR_COUNT: int
MOUSE_SOURCE_MOUSE: int
MOUSE_SOURCE_TOUCH_SCREEN: int
MOUSE_SOURCE_PEN: int
MOUSE_SOURCE_COUNT: int
COND_NONE: int
COND_ALWAYS: int
COND_ONCE: int
COND_FIRST_USE_EVER: int
COND_APPEARING: int
TABLE_FLAGS_NONE: int
TABLE_FLAGS_RESIZABLE: int
TABLE_FLAGS_REORDERABLE: int
TABLE_FLAGS_HIDEABLE: int
TABLE_FLAGS_SORTABLE: int
TABLE_FLAGS_NO_SAVED_SETTINGS: int
TABLE_FLAGS_CONTEXT_MENU_IN_BODY: int
TABLE_FLAGS_ROW_BG: int
TABLE_FLAGS_BORDERS_INNER_H: int
TABLE_FLAGS_BORDERS_OUTER_H: int
TABLE_FLAGS_BORDERS_INNER_V: int
TABLE_FLAGS_BORDERS_OUTER_V: int
TABLE_FLAGS_BORDERS_H: int
TABLE_FLAGS_BORDERS_V: int
TABLE_FLAGS_BORDERS_INNER: int
TABLE_FLAGS_BORDERS_OUTER: int
TABLE_FLAGS_BORDERS: int
TABLE_FLAGS_NO_BORDERS_IN_BODY: int
TABLE_FLAGS_NO_BORDERS_IN_BODY_UNTIL_RESIZE: int
TABLE_FLAGS_SIZING_FIXED_FIT: int
TABLE_FLAGS_SIZING_FIXED_SAME: int
TABLE_FLAGS_SIZING_STRETCH_PROP: int
TABLE_FLAGS_SIZING_STRETCH_SAME: int
TABLE_FLAGS_NO_HOST_EXTEND_X: int
TABLE_FLAGS_NO_HOST_EXTEND_Y: int
TABLE_FLAGS_NO_KEEP_COLUMNS_VISIBLE: int
TABLE_FLAGS_PRECISE_WIDTHS: int
TABLE_FLAGS_NO_CLIP: int
TABLE_FLAGS_PAD_OUTER_X: int
TABLE_FLAGS_NO_PAD_OUTER_X: int
TABLE_FLAGS_NO_PAD_INNER_X: int
TABLE_FLAGS_SCROLL_X: int
TABLE_FLAGS_SCROLL_Y: int
TABLE_FLAGS_SORT_MULTI: int
TABLE_FLAGS_SORT_TRISTATE: int
TABLE_FLAGS_HIGHLIGHT_HOVERED_COLUMN: int
TABLE_FLAGS_SIZING_MASK: int
TABLE_COLUMN_FLAGS_NONE: int
TABLE_COLUMN_FLAGS_DISABLED: int
TABLE_COLUMN_FLAGS_DEFAULT_HIDE: int
TABLE_COLUMN_FLAGS_DEFAULT_SORT: int
TABLE_COLUMN_FLAGS_WIDTH_STRETCH: int
TABLE_COLUMN_FLAGS_WIDTH_FIXED: int
TABLE_COLUMN_FLAGS_NO_RESIZE: int
TABLE_COLUMN_FLAGS_NO_REORDER: int
TABLE_COLUMN_FLAGS_NO_HIDE: int
TABLE_COLUMN_FLAGS_NO_CLIP: int
TABLE_COLUMN_FLAGS_NO_SORT: int
TABLE_COLUMN_FLAGS_NO_SORT_ASCENDING: int
TABLE_COLUMN_FLAGS_NO_SORT_DESCENDING: int
TABLE_COLUMN_FLAGS_NO_HEADER_LABEL: int
TABLE_COLUMN_FLAGS_NO_HEADER_WIDTH: int
TABLE_COLUMN_FLAGS_PREFER_SORT_ASCENDING: int
TABLE_COLUMN_FLAGS_PREFER_SORT_DESCENDING: int
TABLE_COLUMN_FLAGS_INDENT_ENABLE: int
TABLE_COLUMN_FLAGS_INDENT_DISABLE: int
TABLE_COLUMN_FLAGS_ANGLED_HEADER: int
TABLE_COLUMN_FLAGS_IS_ENABLED: int
TABLE_COLUMN_FLAGS_IS_VISIBLE: int
TABLE_COLUMN_FLAGS_IS_SORTED: int
TABLE_COLUMN_FLAGS_IS_HOVERED: int
TABLE_COLUMN_FLAGS_WIDTH_MASK: int
TABLE_COLUMN_FLAGS_INDENT_MASK: int
TABLE_COLUMN_FLAGS_STATUS_MASK: int
TABLE_COLUMN_FLAGS_NO_DIRECT_RESIZE: int
TABLE_ROW_FLAGS_NONE: int
TABLE_ROW_FLAGS_HEADERS: int
TABLE_BG_TARGET_NONE: int
TABLE_BG_TARGET_ROW_BG0: int
TABLE_BG_TARGET_ROW_BG1: int
TABLE_BG_TARGET_CELL_BG: int
MULTI_SELECT_FLAGS_NONE: int
MULTI_SELECT_FLAGS_SINGLE_SELECT: int
MULTI_SELECT_FLAGS_NO_SELECT_ALL: int
MULTI_SELECT_FLAGS_NO_RANGE_SELECT: int
MULTI_SELECT_FLAGS_NO_AUTO_SELECT: int
MULTI_SELECT_FLAGS_NO_AUTO_CLEAR: int
MULTI_SELECT_FLAGS_NO_AUTO_CLEAR_ON_RESELECT: int
MULTI_SELECT_FLAGS_BOX_SELECT1D: int
MULTI_SELECT_FLAGS_BOX_SELECT2D: int
MULTI_SELECT_FLAGS_BOX_SELECT_NO_SCROLL: int
MULTI_SELECT_FLAGS_CLEAR_ON_ESCAPE: int
MULTI_SELECT_FLAGS_CLEAR_ON_CLICK_VOID: int
MULTI_SELECT_FLAGS_SCOPE_WINDOW: int
MULTI_SELECT_FLAGS_SCOPE_RECT: int
MULTI_SELECT_FLAGS_SELECT_ON_CLICK: int
MULTI_SELECT_FLAGS_SELECT_ON_CLICK_RELEASE: int
MULTI_SELECT_FLAGS_NAV_WRAP_X: int
SELECTION_REQUEST_TYPE_NONE: int
SELECTION_REQUEST_TYPE_SET_ALL: int
SELECTION_REQUEST_TYPE_SET_RANGE: int
IM_DRAW_FLAGS_NONE: int
IM_DRAW_FLAGS_CLOSED: int
IM_DRAW_FLAGS_ROUND_CORNERS_TOP_LEFT: int
IM_DRAW_FLAGS_ROUND_CORNERS_TOP_RIGHT: int
IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM_LEFT: int
IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM_RIGHT: int
IM_DRAW_FLAGS_ROUND_CORNERS_NONE: int
IM_DRAW_FLAGS_ROUND_CORNERS_TOP: int
IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM: int
IM_DRAW_FLAGS_ROUND_CORNERS_LEFT: int
IM_DRAW_FLAGS_ROUND_CORNERS_RIGHT: int
IM_DRAW_FLAGS_ROUND_CORNERS_ALL: int
IM_DRAW_FLAGS_ROUND_CORNERS_DEFAULT: int
IM_DRAW_FLAGS_ROUND_CORNERS_MASK: int
IM_DRAW_LIST_FLAGS_NONE: int
IM_DRAW_LIST_FLAGS_ANTI_ALIASED_LINES: int
IM_DRAW_LIST_FLAGS_ANTI_ALIASED_LINES_USE_TEX: int
IM_DRAW_LIST_FLAGS_ANTI_ALIASED_FILL: int
IM_DRAW_LIST_FLAGS_ALLOW_VTX_OFFSET: int
IM_FONT_ATLAS_FLAGS_NONE: int
IM_FONT_ATLAS_FLAGS_NO_POWER_OF_TWO_HEIGHT: int
IM_FONT_ATLAS_FLAGS_NO_MOUSE_CURSORS: int
IM_FONT_ATLAS_FLAGS_NO_BAKED_LINES: int
VIEWPORT_FLAGS_NONE: int
VIEWPORT_FLAGS_IS_PLATFORM_WINDOW: int
VIEWPORT_FLAGS_IS_PLATFORM_MONITOR: int
VIEWPORT_FLAGS_OWNED_BY_APP: int
VIEWPORT_FLAGS_NO_DECORATION: int
VIEWPORT_FLAGS_NO_TASK_BAR_ICON: int
VIEWPORT_FLAGS_NO_FOCUS_ON_APPEARING: int
VIEWPORT_FLAGS_NO_FOCUS_ON_CLICK: int
VIEWPORT_FLAGS_NO_INPUTS: int
VIEWPORT_FLAGS_NO_RENDERER_CLEAR: int
VIEWPORT_FLAGS_NO_AUTO_MERGE: int
VIEWPORT_FLAGS_TOP_MOST: int
VIEWPORT_FLAGS_CAN_HOST_OTHER_WINDOWS: int
VIEWPORT_FLAGS_IS_MINIMIZED: int
VIEWPORT_FLAGS_IS_FOCUSED: int



def accept_drag_drop_payload(type_: str, flags: int=0) -> ImGuiPayload: ...
def align_text_to_frame_padding() -> None: ...
def arrow_button(str_id: str, dir_: int) -> bool: ...
def begin(name: str, p_open: Bool=None, flags: int=0) -> bool: ...
def begin_child(str_id: str, size: Tuple[float, float]=(0, 0), child_flags: int=0, window_flags: int=0) -> bool: ...
def begin_child_id(id_: int, size: Tuple[float, float]=(0, 0), child_flags: int=0, window_flags: int=0) -> bool: ...
def begin_combo(label: str, preview_value: str, flags: int=0) -> bool: ...
def begin_disabled(disabled: bool=True) -> None: ...
def begin_drag_drop_source(flags: int=0) -> bool: ...
def begin_drag_drop_target() -> bool: ...
def begin_group() -> None: ...
def begin_item_tooltip() -> bool: ...
def begin_list_box(label: str, size: Tuple[float, float]=(0, 0)) -> bool: ...
def begin_main_menu_bar() -> bool: ...
def begin_menu(label: str, enabled: bool=True) -> bool: ...
def begin_menu_bar() -> bool: ...
# def begin_multi_select(flags: int) -> ImGuiMultiSelectIO: ...
# def begin_multi_select_ex(flags: int, selection_size: int=-1, items_count: int=-1) -> ImGuiMultiSelectIO: ...
def begin_popup(str_id: str, flags: int=0) -> bool: ...
def begin_popup_context_item(str_id: str=None, popup_flags: int=1) -> bool: ...
def begin_popup_context_void(str_id: str=None, popup_flags: int=1) -> bool: ...
def begin_popup_context_window(str_id: str=None, popup_flags: int=1) -> bool: ...
def begin_popup_modal(name: str, p_open: Bool=None, flags: int=0) -> bool: ...
def begin_tab_bar(str_id: str, flags: int=0) -> bool: ...
def begin_tab_item(label: str, p_open: Bool=None, flags: int=0) -> bool: ...
def begin_table(str_id: str, columns: int, flags: int=0, outer_size: tuple=(0.0, 0.0), inner_width: float=0.0) -> bool: ...
def begin_tooltip() -> bool: ...
def bullet() -> None: ...
def bullet_text(fmt: str) -> None: ...
def button(label: str, size: tuple=(0, 0)) -> bool: ...
# def c_impl_glfw_char_callback(window: GLFWwindow, c: int) -> None: ...
# def c_impl_glfw_cursor_enter_callback(window: GLFWwindow, entered: int) -> None: ...
# def c_impl_glfw_cursor_pos_callback(window: GLFWwindow, x: float, y: float) -> None: ...
def c_impl_glfw_init_for_open_gl(window, install_callbacks: bool) -> bool: ...
# def c_impl_glfw_init_for_other(window: GLFWwindow, install_callbacks: bool) -> bool: ...
# def c_impl_glfw_init_for_vulkan(window: GLFWwindow, install_callbacks: bool) -> bool: ...
# def c_impl_glfw_install_callbacks(window: GLFWwindow) -> None: ...
# def c_impl_glfw_key_callback(window: GLFWwindow, key: int, scancode: int, action: int, mods: int) -> None: ...
# def c_impl_glfw_monitor_callback(monitor: GLFWmonitor, event: int) -> None: ...
# def c_impl_glfw_mouse_button_callback(window: GLFWwindow, button: int, action: int, mods: int) -> None: ...
def c_impl_glfw_new_frame() -> None: ...
# def c_impl_glfw_restore_callbacks(window: GLFWwindow) -> None: ...
# def c_impl_glfw_scroll_callback(window: GLFWwindow, xoffset: float, yoffset: float) -> None: ...
# def c_impl_glfw_set_callbacks_chain_for_all_windows(chain_for_all_windows: bool) -> None: ...
def c_impl_glfw_shutdown() -> None: ...
# def c_impl_glfw_sleep(milliseconds: int) -> None: ...
# def c_impl_glfw_window_focus_callback(window: GLFWwindow, focused: int) -> None: ...
# def c_impl_open_gl3_create_device_objects() -> bool: ...
# def c_impl_open_gl3_create_fonts_texture() -> bool: ...
# def c_impl_open_gl3_destroy_device_objects() -> None: ...
# def c_impl_open_gl3_destroy_fonts_texture() -> None: ...
def c_impl_open_gl3_init(glsl_version: str=None) -> bool: ...
def c_impl_open_gl3_new_frame() -> None: ...
def c_impl_open_gl3_render_draw_data(draw_data: ImDrawData) -> None: ...
def c_impl_open_gl3_shutdown() -> None: ...
def calc_item_width() -> float: ...
def calc_text_size(text: str, text_end: str=None, hide_text_after_double_hash: bool=False, wrap_width: float=-1.0) -> Tuple[float, float]: ...
def checkbox(label: str, v: Bool) -> bool: ...
def checkbox_flags(label: str, flags: Int, flags_value: int) -> bool: ...
def close_current_popup() -> None: ...
def collapsing_header(label: str, flags: int=0) -> bool: ...
def collapsing_header_bool_ptr(label: str, p_visible: Bool, flags: int=0) -> bool: ...
def color_button(desc_id: str, col: Tuple[float, float, float, float], flags: int=0, size: tuple=(0, 0)) -> bool: ...
def color_convert_float4_to_u32(in_: Tuple[float, float, float, float]) -> int: ...
def color_convert_hsv_to_rgb(h: float, s: float, value: float, a: float=1) -> tuple: ...
def color_convert_rgb_to_hsv(r: float, g: float, b: float, a: float=1) -> tuple: ...
def color_convert_u32_to_float4(in_: int) -> Tuple[float, float, float, float]: ...
def color_edit3(label: str, colour: Vec4, flags: int=0) -> bool: ...
def color_edit4(label: str, colour: Vec4, flags: int=0) -> bool: ...
def color_picker3(label: str, colour: Vec4, flags: int=0) -> bool: ...
def color_picker4(label: str, colour: Vec4, flags: int=0, ref_col: Vec4=None) -> bool: ...
def columns(count: int=1, id_: str=None, border: bool=True) -> None: ...
def combo(label: str, current_item: Int, items: Sequence[str], popup_max_height_in_items: int=-1) -> bool: ...
def combo_callback(label: str, current_item: Int, items_getter: Callable[[Any, int], str], data: Any, items_count: int, popup_max_height_in_items: int=-1) -> bool: ...
def create_context(shared_font_atlas: ImFontAtlas=None) -> ImGuiContext: ...
def debug_check_version_and_data_layout() -> bool: ...
# def debug_flash_style_color(idx: int) -> None: ...
# def debug_log(fmt: str) -> None: ...
# def debug_log_v(fmt: str) -> None: ...
# def debug_start_item_picker() -> None: ...
def debug_text_encoding(text: str) -> None: ...
def destroy_context(ctx: ImGuiContext=None) -> None: ...
# def destroy_platform_windows() -> None: ...
def dock_space(dockspace_id: int, size: tuple=(0, 0), flags: int=0, window_class: ImGuiWindowClass=None) -> int: ...
def dock_space_over_viewport(dockspace_id: int, viewport: ImGuiViewport=None, flags: int=0, window_class: ImGuiWindowClass=None) -> int: ...
def drag_float(label: str, v: Float, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool: ...
def drag_float2(label: str, float_ptrs: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool: ...
def drag_float3(label: str, float_ptrs: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool: ...
def drag_float4(label: str, float_ptrs: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool: ...
def drag_float_range2(label: str, v_current_min: Float, v_current_max: Float, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", format_max: str=None, flags: int=0) -> bool: ...
def drag_int(label: str, value: Int, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
def drag_int2(label: str, int_ptrs: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
def drag_int3(label: str, int_ptrs: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
def drag_int4(label: str, int_ptrs: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
def drag_int_range2(label: str, v_current_min: Int, v_current_max: Int, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", format_max: str=None, flags: int=0) -> bool: ...
def drag_scalar(label: str, data_type: int, p_data: "Int | Long | Float | Double", v_speed: float=1.0, _min: "int | float"=None, _max: "int | float"=None, format_: str=None, flags: int=0) -> bool: ...
def drag_scalar_n(label: str, data_type: int, p_data: "Sequence[Int | Long | Float | Double]", components: int, v_speed: float=1.0, p_min: "int | float"=None, p_max: "int | float"=None, format_: str=None, flags: int=0) -> bool: ...
def dummy(size: Tuple[float, float]) -> None: ...
def end() -> None: ...
def end_child() -> None: ...
def end_combo() -> None: ...
def end_disabled() -> None: ...
def end_drag_drop_source() -> None: ...
def end_drag_drop_target() -> None: ...
def end_frame() -> None: ...
def end_group() -> None: ...
def end_list_box() -> None: ...
def end_main_menu_bar() -> None: ...
def end_menu() -> None: ...
def end_menu_bar() -> None: ...
# def end_multi_select() -> ImGuiMultiSelectIO: ...
def end_popup() -> None: ...
def end_tab_bar() -> None: ...
def end_tab_item() -> None: ...
def end_table() -> None: ...
def end_tooltip() -> None: ...
# def find_viewport_by_id(id_: int) -> ImGuiViewport: ...
# def find_viewport_by_platform_handle(platform_handle: Any) -> ImGuiViewport: ...
def get_background_draw_list() -> ImDrawList: ...
# def get_background_draw_list_ex(viewport: ImGuiViewport=None) -> ImDrawList: ...
def get_clipboard_text() -> str: ...
def get_color_u32(idx: int, alpha_mul: float=1.0) -> int: ...
def get_color_u32_im_u32(col: int) -> int: ...
# def get_color_u32_im_u32_ex(col: int, alpha_mul: float=1.0) -> int: ...
def get_color_u32_im_vec4(col: Tuple[float, float, float, float]) -> int: ...
# def get_column_index() -> int: ...
# def get_column_offset(column_index: int=-1) -> float: ...
# def get_column_width(column_index: int=-1) -> float: ...
# def get_columns_count() -> int: ...
def get_content_region_avail() -> Tuple[float, float]: ...
def get_current_context() -> ImGuiContext: ...
def get_cursor_pos() -> Tuple[float, float]: ...
def get_cursor_pos_x() -> float: ...
def get_cursor_pos_y() -> float: ...
def get_cursor_screen_pos() -> Tuple[float, float]: ...
def get_cursor_start_pos() -> Tuple[float, float]: ...
def get_drag_drop_payload() -> ImGuiPayload: ...
def get_draw_data() -> ImDrawData: ...
def get_font() -> ImFont: ...
def get_font_size() -> float: ...
def get_font_tex_uv_white_pixel() -> Tuple[float, float]: ...
def get_foreground_draw_list(viewport: ImGuiViewport=None) -> ImDrawList: ...
def get_frame_count() -> int: ...
def get_frame_height() -> float: ...
def get_frame_height_with_spacing() -> float: ...
def get_id(str_id: str) -> int: ...
# def get_id_int(int_id: int) -> int: ...
# def get_id_ptr(ptr_id: Any) -> int: ...
# def get_id_str(str_id_begin: str, str_id_end: str) -> int: ...
def get_io() -> ImGuiIO: ...
def get_item_id() -> int: ...
def get_item_rect_max() -> Tuple[float, float]: ...
def get_item_rect_min() -> Tuple[float, float]: ...
def get_item_rect_size() -> Tuple[float, float]: ...
def get_key_pressed_amount(key: int, repeat_delay: float, rate: float) -> int: ...
def get_main_viewport() -> ImGuiViewport: ...
def get_mouse_clicked_count(button: int) -> int: ...
def get_mouse_cursor() -> int: ...
def get_mouse_drag_delta(button: int=0, lock_threshold: float=-1.0) -> Tuple[float, float]: ...
def get_mouse_pos() -> Tuple[float, float]: ...
def get_mouse_pos_on_opening_current_popup() -> Tuple[float, float]: ...
def get_platform_io() -> ImGuiPlatformIO: ...
def get_scroll_max_x() -> float: ...
def get_scroll_max_y() -> float: ...
def get_scroll_x() -> float: ...
def get_scroll_y() -> float: ...
# def get_state_storage() -> ImGuiStorage: ...
def get_style() -> ImGuiStyle: ...
def get_style_color_name(idx: int) -> str: ...
def get_style_color_vec4(idx: int) -> tuple: ...
def get_text_line_height() -> float: ...
def get_text_line_height_with_spacing() -> float: ...
def get_time() -> float: ...
def get_tree_node_to_label_spacing() -> float: ...
def get_version() -> str: ...
def get_window_dock_id() -> int: ...
def get_window_dpi_scale() -> float: ...
def get_window_draw_list() -> ImDrawList: ...
def get_window_height() -> float: ...
def get_window_pos() -> Tuple[float, float]: ...
def get_window_size() -> Tuple[float, float]: ...
def get_window_viewport() -> ImGuiViewport: ...
def get_window_width() -> float: ...
# def im_color_hsv(h: float, s: float, v: float, a: float=1.0) -> ImColor: ...
# def im_vector_construct(vector: Any) -> None: ...
# def im_vector_destruct(vector: Any) -> None: ...
def image(user_texture_id: int, image_size: Tuple[float, float], uv0: tuple=(0, 0), uv1: tuple=(1, 1), tint_col: tuple=(1, 1, 1, 1), border_col: tuple=(0, 0, 0, 0)) -> None: ...
def image_button(str_id: str, user_texture_id: int, image_size: Tuple[float, float], uv0: tuple=(0, 0), uv1: tuple=(1, 1), bg_col: tuple=(0, 0, 0, 0), tint_col: tuple=(1, 1, 1, 1)) -> bool: ...
def indent(indent_w: float=0.0) -> None: ...
def input_double(label: str, v: Double, step: float=0.0, step_fast: float=0.0, format_: str="%.6f", flags: int=0) -> bool: ...
def input_float(label: str, v: Float, step: float=0.0, step_fast: float=0.0, format_: str="%.3f", flags: int=0) -> bool: ...
def input_float2(label: str, float_ptrs: Sequence[Float], format_: str="%.3f", flags: int=0) -> bool: ...
def input_float3(label: str, float_ptrs: Sequence[Float], format_: str="%.3f", flags: int=0) -> bool: ...
def input_float4(label: str, float_ptrs: Sequence[Float], format_: str="%.3f", flags: int=0) -> bool: ...
def input_int(label: str, v: Int) -> bool: ...
def input_int2(label: str, int_ptrs: Sequence[Int], flags: int=0) -> bool: ...
def input_int3(label: str, int_ptrs: Sequence[Int], flags: int=0) -> bool: ...
def input_int4(label: str, int_ptrs: Sequence[Int], flags: int=0) -> bool: ...
def input_scalar(label: str, data_type: int, p_data: "Int | Long | Float | Double", step: "int | float"=None, step_fast: "int | float"=None, format_: str=None, flags: int=0) -> bool: ...
def input_scalar_n(label: str, data_type: int, p_data: "Sequence[Int | Long | Float | Double]", components: int, p_step: "int | float"=None, p_step_fast: "int | float"=None, format_: str=None, flags: int=0) -> bool: ...
def input_text(label: str, buf: String, flags: int=0, callback: "Callable[[ImGuiInputTextCallbackData, Any], int]"=None, user_data: Any=None) -> bool: ...
def input_text_multiline(label: str, buf: String, size: tuple=(0, 0), flags: int=0, callback: "Callable[[ImGuiInputTextCallbackData, Any], int]"=None, user_data: Any=None) -> bool: ...
def input_text_with_hint(label: str, hint: str, buf: String, flags: int=0, callback: "Callable[[ImGuiInputTextCallbackData, Any], int]"=None, user_data: Any=None) -> bool: ...
def invisible_button(str_id: str, size: Tuple[float, float], flags: int=0) -> bool: ...
def is_any_item_active() -> bool: ...
def is_any_item_focused() -> bool: ...
def is_any_item_hovered() -> bool: ...
def is_any_mouse_down() -> bool: ...
def is_item_activated() -> bool: ...
def is_item_active() -> bool: ...
def is_item_clicked(mouse_button: int=0) -> bool: ...
def is_item_deactivated() -> bool: ...
def is_item_deactivated_after_edit() -> bool: ...
def is_item_edited() -> bool: ...
def is_item_focused() -> bool: ...
def is_item_hovered(flags: int=0) -> bool: ...
def is_item_toggled_open() -> bool: ...
# def is_item_toggled_selection() -> bool: ...
def is_item_visible() -> bool: ...
# def is_key_chord_pressed(key_chord: int) -> bool: ...
def is_key_down(key: int) -> bool: ...
def is_key_pressed(key: int, repeat: bool=True) -> bool: ...
def is_key_released(key: int) -> bool: ...
def is_mouse_clicked(button: int, repeat: bool=False) -> bool: ...
def is_mouse_double_clicked(button: int) -> bool: ...
def is_mouse_down(button: int) -> bool: ...
def is_mouse_dragging(button: int, lock_threshold: float=-1.0) -> bool: ...
def is_mouse_hovering_rect(r_min: Tuple[float, float], r_max: Tuple[float, float], clip: bool=True) -> bool: ...
def is_mouse_pos_valid(mouse_pos: tuple=None) -> bool: ...
def is_mouse_released(button: int) -> bool: ...
def is_popup_open(str_id: str, flags: int=0) -> bool: ...
def is_rect_visible(rect_min: Tuple[float, float], rect_max: Tuple[float, float]) -> bool: ...
def is_rect_visible_by_size(size: Tuple[float, float]) -> bool: ...
def is_window_appearing() -> bool: ...
def is_window_collapsed() -> bool: ...
def is_window_docked() -> bool: ...
def is_window_focused(flags: int=0) -> bool: ...
def is_window_hovered(flags: int=0) -> bool: ...
def label_text(label: str, fmt: str) -> None: ...
def list_box(label: str, current_item: Int, items: Sequence[str], height_in_items: int=-1) -> bool: ...
def list_box_callback(label: str, current_item: Int, items_getter: Callable[[Any, int], str], data: Any, items_count: int, height_in_items: int=-1) -> bool: ...
# def load_ini_settings_from_disk(ini_filename: str) -> None: ...
# def load_ini_settings_from_memory(ini_data: str, ini_size: int=0) -> None: ...
def log_buttons() -> None: ...
def log_finish() -> None: ...
def log_text(fmt: str) -> None: ...
def log_to_clipboard(auto_open_depth: int=-1) -> None: ...
# def log_to_file(auto_open_depth: int=-1, filename: str=None) -> None: ...
# def log_to_tty(auto_open_depth: int=-1) -> None: ...
def menu_item(label: str, shortcut: str=None, selected: bool=False, enabled: bool=True) -> bool: ...
def menu_item_bool_ptr(label: str, shortcut: Optional[str], p_selected: Bool, enabled: bool=True) -> bool: ...
def new_frame() -> None: ...
def new_line() -> None: ...
# def next_column() -> None: ...
def open_popup(str_id: str, popup_flags: int=0) -> None: ...
def open_popup_id(id_: int, popup_flags: int=0) -> None: ...
def open_popup_on_item_click(str_id: str=None, popup_flags: int=1) -> None: ...
def plot_histogram(label: str, values: Sequence[float], values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0), stride: int=4) -> None: ...
def plot_histogram_callback(label: str, values_getter: Callable[[Any, int], float], data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)) -> None: ...
def plot_lines(label: str, values: Sequence[float], values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)) -> None: ...
def plot_lines_callback(label: str, values_getter: Callable[[Any, int], float], data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)) -> None: ...
# def pop_clip_rect() -> None: ...
def pop_font() -> None: ...
def pop_id() -> None: ...
def pop_item_flag() -> None: ...
def pop_item_width() -> None: ...
def pop_style_color(count: int=1) -> None: ...
def pop_style_var(count: int=1) -> None: ...
def pop_text_wrap_pos() -> None: ...
def progress_bar(fraction: float, size_arg: Tuple[float, float]=(-FLT_MIN, 0), overlay: str=None) -> None: ...
# def push_clip_rect(clip_rect_min: Tuple[float, float], clip_rect_max: Tuple[float, float], intersect_with_current_clip_rect: bool) -> None: ...
def push_font(font: ImFont) -> None: ...
def push_id(obj: object) -> None: ...
def push_item_flag(option: int, enabled: bool) -> None: ...
def push_item_width(item_width: float) -> None: ...
def push_style_color(idx: int, col: "int | tuple") -> None: ...
def push_style_var(idx: int, val: "float | tuple") -> None: ...
# def push_style_var_x(idx: int, val_x: float) -> None: ...
# def push_style_var_y(idx: int, val_y: float) -> None: ...
def push_text_wrap_pos(wrap_local_pos_x: float=0.0) -> None: ...
def radio_button(label: str, active: bool) -> bool: ...
def radio_button_int_ptr(label: str, v: Int, v_button: int) -> bool: ...
def render() -> None: ...
def render_platform_windows_default(platform_render_arg: Any=None, renderer_render_arg: Any=None) -> None: ...
# def reset_mouse_drag_delta() -> None: ...
# def reset_mouse_drag_delta_ex(button: int=0) -> None: ...
def same_line(offset_from_start_x: float=0.0, spacing: float=-1.0) -> None: ...
# def save_ini_settings_to_disk(ini_filename: str) -> None: ...
# def save_ini_settings_to_memory(out_ini_size: Any=None) -> str: ...
def selectable(label: str, selected: bool=False, flags: int=0, size: tuple=(0, 0)) -> bool: ...
def selectable_bool_ptr(label: str, p_selected: Bool, flags: int=0, size: tuple=(0, 0)) -> bool: ...
def separator() -> None: ...
def separator_text(label: str) -> None: ...
def set_clipboard_text(text: str) -> None: ...
def set_color_edit_options(flags: int) -> None: ...
# def set_column_offset(column_index: int, offset_x: float) -> None: ...
# def set_column_width(column_index: int, width: float) -> None: ...
# def set_current_context(ctx: ImGuiContext) -> None: ...
def set_cursor_pos(local_pos: Tuple[float, float]) -> None: ...
def set_cursor_pos_x(local_x: float) -> None: ...
def set_cursor_pos_y(local_y: float) -> None: ...
def set_cursor_screen_pos(pos: Tuple[float, float]) -> None: ...
def set_drag_drop_payload(type_: str, data: Any, cond: int=0) -> bool: ...
def set_item_default_focus() -> None: ...
# def set_item_key_owner(key: int) -> None: ...
def set_item_tooltip(fmt: str) -> None: ...
def set_keyboard_focus_here(offset: int=0) -> None: ...
def set_mouse_cursor(cursor_type: int) -> None: ...
# def set_next_frame_want_capture_keyboard(want_capture_keyboard: bool) -> None: ...
# def set_next_frame_want_capture_mouse(want_capture_mouse: bool) -> None: ...
# def set_next_item_allow_overlap() -> None: ...
def set_next_item_open(is_open: bool, cond: int=0) -> None: ...
# def set_next_item_selection_user_data(selection_user_data: Any) -> None: ...
# def set_next_item_shortcut(key_chord: int, flags: int=0) -> None: ...
# def set_next_item_storage_id(storage_id: int) -> None: ...
def set_next_item_width(item_width: float) -> None: ...
def set_next_window_bg_alpha(alpha: float) -> None: ...
# def set_next_window_class(window_class: ImGuiWindowClass) -> None: ...
def set_next_window_collapsed(collapsed: bool, cond: int=0) -> None: ...
def set_next_window_content_size(size: Tuple[float, float]) -> None: ...
def set_next_window_dock_id(dock_id: int, cond: int=0) -> None: ...
def set_next_window_focus() -> None: ...
def set_next_window_pos(pos: Tuple[float, float], cond: int=0, pivot: tuple=(0, 0)) -> None: ...
def set_next_window_scroll(scroll: Tuple[float, float]) -> None: ...
def set_next_window_size(size: Tuple[float, float], cond: int=0) -> None: ...
def set_next_window_size_constraints(size_min: Tuple[float, float], size_max: Tuple[float, float], custom_callback: Callable=None, custom_callback_data: Any=None) -> None: ...
def set_next_window_viewport(viewport_id: int) -> None: ...
def set_scroll_from_pos_x(local_x: float, center_x_ratio: float=0.5) -> None: ...
def set_scroll_from_pos_y(local_y: float, center_y_ratio: float=0.5) -> None: ...
def set_scroll_here_x(center_x_ratio: float=0.5) -> None: ...
def set_scroll_here_y(center_y_ratio: float=0.5) -> None: ...
def set_scroll_x(scroll_x: float) -> None: ...
def set_scroll_y(scroll_y: float) -> None: ...
# def set_state_storage(storage: ImGuiStorage) -> None: ...
def set_tab_item_closed(tab_or_docked_window_label: str) -> None: ...
def set_tooltip(fmt: str) -> None: ...
# def set_window_collapsed(collapsed: bool, cond: int=0) -> None: ...
# def set_window_collapsed_str(name: str, collapsed: bool, cond: int=0) -> None: ...
# def set_window_focus() -> None: ...
# def set_window_focus_str(name: str) -> None: ...
# def set_window_font_scale(scale: float) -> None: ...
# def set_window_pos(pos: Tuple[float, float], cond: int=0) -> None: ...
# def set_window_pos_str(name: str, pos: Tuple[float, float], cond: int=0) -> None: ...
# def set_window_size(size: Tuple[float, float], cond: int=0) -> None: ...
# def set_window_size_str(name: str, size: Tuple[float, float], cond: int=0) -> None: ...
# def shortcut(key_chord: int, flags: int=0) -> bool: ...
def show_about_window(p_open: Bool=None) -> None: ...
def show_debug_log_window(p_open: Bool=None) -> None: ...
def show_demo_window(p_open: Bool=None) -> None: ...
def show_font_selector(label: str) -> None: ...
def show_id_stack_tool_window(p_open: Bool=None) -> None: ...
def show_metrics_window(p_open: Bool=None) -> None: ...
def show_style_editor(ref: ImGuiStyle=None) -> None: ...
def show_style_selector(label: str) -> bool: ...
def show_user_guide() -> None: ...
def slider_angle(label: str, v_rad: Float, v_degrees_min: float=-360.0, v_degrees_max: float=+360.0, format_: str="%.0f deg", flags: int=0) -> bool: ...
def slider_float(label: str, value: Float, v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool: ...
def slider_float2(label: str, float_ptrs: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool: ...
def slider_float3(label: str, float_ptrs: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool: ...
def slider_float4(label: str, float_ptrs: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool: ...
def slider_int(label: str, value: Int, v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool: ...
def slider_int2(label: str, int_ptrs: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool: ...
def slider_int3(label: str, int_ptrs: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool: ...
def slider_int4(label: str, int_ptrs: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool: ...
def slider_scalar(label: str, data_type: int, p_data: "Int | Long | Float | Double", _min: "int | float", _max: "int | float", format_: str=None, flags: int=0) -> bool: ...
def slider_scalar_n(label: str, data_type: int, p_data: "Sequence[Int | Long | Float | Double]", components: int, p_min: "int | float", p_max: "int | float", format_: str=None, flags: int=0) -> bool: ...
def small_button(label: str) -> bool: ...
def spacing() -> None: ...
def style_colors_classic(dst: ImGuiStyle=None) -> None: ...
def style_colors_dark(dst: ImGuiStyle=None) -> None: ...
def style_colors_light(dst: ImGuiStyle=None) -> None: ...
def tab_item_button(label: str, flags: int=0) -> bool: ...
# def table_angled_headers_row() -> None: ...
# def table_get_column_count() -> int: ...
# def table_get_column_flags(column_n: int=-1) -> int: ...
# def table_get_column_index() -> int: ...
# def table_get_column_name(column_n: int=-1) -> str: ...
# def table_get_hovered_column() -> int: ...
# def table_get_row_index() -> int: ...
def table_get_sort_specs() -> ImGuiTableSortSpecs: ...
def table_header(label: str) -> None: ...
def table_headers_row() -> None: ...
def table_next_column() -> bool: ...
def table_next_row(row_flags: int=0, min_row_height: float=0.0) -> None: ...
def table_set_bg_color(target: int, color: int, column_n: int=-1) -> None: ...
def table_set_column_enabled(column_n: int, v: bool) -> None: ...
def table_set_column_index(column_n: int) -> bool: ...
def table_setup_column(label: str, flags: int=0, init_width_or_weight: float=0.0, user_id: int=0) -> None: ...
def table_setup_scroll_freeze(cols: int, rows: int) -> None: ...
def text(fmt: str) -> None: ...
def text_colored(col: Tuple[float, float, float, float], fmt: str) -> None: ...
def text_disabled(fmt: str) -> None: ...
# def text_link(label: str) -> bool: ...
# def text_link_open_url(label: str) -> None: ...
# def text_link_open_url_ex(label: str, url: str=None) -> None: ...
def text_unformatted(text: str, text_end: str=None) -> None: ...
def text_wrapped(fmt: str) -> None: ...
def tree_node(label: str, flags: int=0) -> bool: ...
def tree_node_str(str_id: str, fmt: str) -> bool: ...
def tree_pop() -> None: ...
def tree_push(obj: object) -> None: ...
def unindent(indent_w: float=0.0) -> None: ...
def update_platform_windows() -> None: ...
def vslider_float(label: str, size: Tuple[float, float], v: Float, v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool: ...
def vslider_int(label: str, size: Tuple[float, float], v: Int, v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool: ...
def vslider_scalar(label: str, size: Tuple[float, float], data_type: int, p_data: "Int | Long | Float | Double", _min: "int | float", _max: "int | float", format_: str=None, flags: int=0) -> bool: ...

class GLFWmonitor: ...

class GLFWwindow: ...

class ImDrawCmd:
    clip_rect: Tuple[float, float, float, float]
    elem_count: int
    idx_offset: int
    # texture_id: object
    # user_callback: Callable
    # user_callback_data: Any
    vtx_offset: int
    # def get_tex_id(self: ImDrawCmd) -> Any: ...

class ImDrawData:
    cmd_lists: List[ImVector_ImDrawListPtr]
    cmd_lists_count: int
    # display_pos: Tuple[float, float]
    # display_size: Tuple[float, float]
    # framebuffer_scale: Tuple[float, float]
    # owner_viewport: ImGuiViewport
    # total_idx_count: int
    # total_vtx_count: int
    # valid: bool
    # def add_draw_list(self: ImDrawData, draw_list: ImDrawList) -> None: ...
    # def clear(self: ImDrawData) -> None: ...
    # def de_index_all_buffers(self: ImDrawData) -> None: ...
    def scale_clip_rects(self: ImDrawData, fb_scale: Tuple[float, float]) -> None: ...

class ImDrawList:
    cmd_buffer: List[ImDrawCmd]
    flags: int
    idx_buffer: ImVector_ImDrawIdx
    owner_name: str
    vtx_buffer: List[ImDrawVert]
    def add_bezier_cubic(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int, thickness: float, num_segments: int=0) -> None: ...
    def add_bezier_quadratic(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int, thickness: float, num_segments: int=0) -> None: ...
    # def add_callback(self: ImDrawList, callback: Callable, callback_data: Any) -> None: ...
    def add_circle(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int=0, thickness: float=1.0) -> None: ...
    def add_circle_filled(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int=0) -> None: ...
    def add_concave_poly_filled(self: ImDrawList, points: Sequence[tuple], col: int) -> None: ...
    def add_convex_poly_filled(self: ImDrawList, points: Sequence[tuple], col: int) -> None: ...
    # def add_draw_cmd(self: ImDrawList) -> None: ...
    def add_ellipse(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], col: int, rot: float=0.0, num_segments: int=0, thickness: float=1.0) -> None: ...
    def add_ellipse_filled(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], col: int, rot: float=0.0, num_segments: int=0) -> None: ...
    def add_image(self: ImDrawList, user_texture_id: int, p_min: Tuple[float, float], p_max: Tuple[float, float], uv_min: tuple=(0, 0), uv_max: tuple=(1, 1), col: int=IM_COL32_WHITE) -> None: ...
    def add_image_quad(self: ImDrawList, user_texture_id: int, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], uv1: tuple=(0, 0), uv2: tuple=(1, 0), uv3: tuple=(1, 1), uv4: tuple=(0, 1), col: int=IM_COL32_WHITE) -> None: ...
    def add_image_rounded(self: ImDrawList, user_texture_id: int, p_min: Tuple[float, float], p_max: Tuple[float, float], uv_min: Tuple[float, float], uv_max: Tuple[float, float], col: int, rounding: float, flags: int=0) -> None: ...
    def add_line(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], col: int, thickness: float=1.0) -> None: ...
    def add_ngon(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int, thickness: float=1.0) -> None: ...
    def add_ngon_filled(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int) -> None: ...
    def add_polyline(self: ImDrawList, points: Sequence[tuple], col: int, flags: int, thickness: float) -> None: ...
    def add_quad(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int, thickness: float=1.0) -> None: ...
    def add_quad_filled(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int) -> None: ...
    def add_rect(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col: int, rounding: float=0.0, flags: int=0, thickness: float=1.0) -> None: ...
    def add_rect_filled(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col: int, rounding: float=0.0, flags: int=0) -> None: ...
    def add_rect_filled_multi_color(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col_upr_left: int, col_upr_right: int, col_bot_right: int, col_bot_left: int) -> None: ...
    def add_text(self: ImDrawList, pos: Tuple[float, float], col: int, text: str) -> None: ...
    def add_text_imfont(self: ImDrawList, font: ImFont, font_size: float, pos: tuple, col: int, text: str, wrap_width: float=0.0, cpu_fine_clip_rect: Tuple[float, float, float, float]=None) -> None: ...
    def add_triangle(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int, thickness: float=1.0) -> None: ...
    def add_triangle_filled(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int) -> None: ...
    def channels_merge(self: ImDrawList) -> None: ...
    def channels_set_current(self: ImDrawList, n: int) -> None: ...
    def channels_split(self: ImDrawList, count: int) -> None: ...
    # def clone_output(self: ImDrawList) -> ImDrawList: ...
    def path_arc_to(self: ImDrawList, center: Tuple[float, float], radius: float, a_min: float, a_max: float, num_segments: int=0) -> None: ...
    def path_arc_to_fast(self: ImDrawList, center: Tuple[float, float], radius: float, a_min_of_12: int, a_max_of_12: int) -> None: ...
    def path_bezier_cubic_curve_to(self: ImDrawList, p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], num_segments: int=0) -> None: ...
    def path_bezier_quadratic_curve_to(self: ImDrawList, p2: Tuple[float, float], p3: Tuple[float, float], num_segments: int=0) -> None: ...
    def path_clear(self: ImDrawList) -> None: ...
    # def path_elliptical_arc_to(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], rot: float, a_min: float, a_max: float) -> None: ...
    # def path_elliptical_arc_to_ex(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], rot: float, a_min: float, a_max: float, num_segments: int=0) -> None: ...
    # def path_fill_concave(self: ImDrawList, col: int) -> None: ...
    def path_fill_convex(self: ImDrawList, col: int) -> None: ...
    def path_line_to(self: ImDrawList, pos: Tuple[float, float]) -> None: ...
    def path_line_to_merge_duplicate(self: ImDrawList, pos: Tuple[float, float]) -> None: ...
    def path_rect(self: ImDrawList, rect_min: Tuple[float, float], rect_max: Tuple[float, float], rounding: float=0.0, flags: int=0) -> None: ...
    def path_stroke(self: ImDrawList, col: int, flags: int=0, thickness: float=1.0) -> None: ...
    def pop_clip_rect(self: ImDrawList) -> None: ...
    # def pop_texture_id(self: ImDrawList) -> None: ...
    def push_clip_rect(self: ImDrawList, clip_rect_min: Tuple[float, float], clip_rect_max: Tuple[float, float], intersect_with_current_clip_rect: bool=False) -> None: ...
    # def push_clip_rect_full_screen(self: ImDrawList) -> None: ...
    # def push_texture_id(self: ImDrawList, texture_id: Any) -> None: ...
    # def set_texture_id(self: ImDrawList, texture_id: Any) -> None: ...

class ImDrawListSplitter:
    def create() -> ImDrawListSplitter: ...
    def destroy(self: ImDrawListSplitter) -> None: ...
    def merge(self: ImDrawListSplitter, draw_list: ImDrawList) -> None: ...
    def set_current_channel(self: ImDrawListSplitter, draw_list: ImDrawList, channel_idx: int) -> None: ...
    def split(self: ImDrawListSplitter, draw_list: ImDrawList, count: int) -> None: ...

class ImDrawVert:
    col: int
    pos: Tuple[float, float]
    uv: Tuple[float, float]

class ImFont:
    ascent: float
    config_data: ImFontConfig
    config_data_count: int
    container_atlas: ImFontAtlas
    descent: float
    dirty_lookup_tables: bool
    ellipsis_char: int
    ellipsis_char_count: int
    ellipsis_char_step: float
    ellipsis_width: float
    fallback_advance_x: float
    fallback_char: int
    fallback_glyph: ImFontGlyph
    font_size: float
    glyphs: List[ImFontGlyph]
    index_advance_x: List[float]
    index_lookup: List[int]
    metrics_total_surface: int
    scale: float
    used4k_pages_map: bytes
    # def calc_text_size_a(self: ImFont, size: float, max_width: float, wrap_width: float, text_begin: str) -> Tuple[float, float]: ...
    # def calc_text_size_a_ex(self: ImFont, size: float, max_width: float, wrap_width: float, text_begin: str, text_end: str=None, remaining: Any=None) -> Tuple[float, float]: ...
    # def calc_word_wrap_position_a(self: ImFont, scale: float, text: str, text_end: str, wrap_width: float) -> str: ...
    # def find_glyph(self: ImFont, c: int) -> ImFontGlyph: ...
    # def find_glyph_no_fallback(self: ImFont, c: int) -> ImFontGlyph: ...
    def get_debug_name(self: ImFont) -> str: ...
    # def render_char(self: ImFont, draw_list: ImDrawList, size: float, pos: Tuple[float, float], col: int, c: int) -> None: ...
    # def render_text(self: ImFont, draw_list: ImDrawList, size: float, pos: Tuple[float, float], col: int, clip_rect: Tuple[float, float, float, float], text_begin: str, text_end: str, wrap_width: float=0.0, cpu_fine_clip: bool=False) -> None: ...

class ImFontAtlas:
    config_data: List[ImFontConfig]
    custom_rects: List[ImFontAtlasCustomRect]
    flags: int
    font_builder_flags: int
    font_builder_io: ImFontBuilderIO
    fonts: List[ImFont]
    locked: bool
    pack_id_lines: int
    pack_id_mouse_cursors: int
    tex_desired_width: int
    tex_glyph_padding: int
    tex_height: int
    tex_id: int
    tex_pixels_alpha8: bytes
    tex_pixels_rgba_32: bytes
    tex_pixels_use_colors: bool
    tex_ready: bool
    tex_uv_lines: Vec4
    tex_uv_scale: Tuple[float, float]
    tex_uv_white_pixel: Tuple[float, float]
    tex_width: int
    # user_data: Any
    # def add_custom_rect_font_glyph(self: ImFontAtlas, font: ImFont, id_: int, width: int, height: int, advance_x: float, offset: Tuple[float, float]=(0, 0)) -> int: ...
    # def add_custom_rect_regular(self: ImFontAtlas, width: int, height: int) -> int: ...
    # def add_font(self: ImFontAtlas, font_cfg: ImFontConfig) -> ImFont: ...
    def add_font_default(self: ImFontAtlas, font_cfg: ImFontConfig=None) -> ImFont: ...
    def add_font_from_file_ttf(self: ImFontAtlas, filename: str, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: ImGlyphRange=None) -> ImFont: ...
    # def add_font_from_memory_compressed_base85_ttf(self: ImFontAtlas, compressed_font_data_base85: str, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont: ...
    # def add_font_from_memory_compressed_ttf(self: ImFontAtlas, compressed_font_data: Any, compressed_font_data_size: int, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont: ...
    # def add_font_from_memory_ttf(self: ImFontAtlas, font_data: Any, font_data_size: int, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont: ...
    def build(self: ImFontAtlas) -> bool: ...
    # def calc_custom_rect_uv(self: ImFontAtlas, rect: ImFontAtlasCustomRect, out_uv_min: ImVec2, out_uv_max: ImVec2) -> None: ...
    # def clear(self: ImFontAtlas) -> None: ...
    # def clear_fonts(self: ImFontAtlas) -> None: ...
    # def clear_input_data(self: ImFontAtlas) -> None: ...
    def clear_tex_data(self: ImFontAtlas) -> None: ...
    # def get_custom_rect_by_index(self: ImFontAtlas, index: int) -> ImFontAtlasCustomRect: ...
    def get_glyph_ranges_chinese_full(self: ImFontAtlas) -> ImGlyphRange: ...
    # def get_glyph_ranges_chinese_simplified_common(self: ImFontAtlas) -> int: ...
    def get_glyph_ranges_cyrillic(self: ImFontAtlas) -> ImGlyphRange: ...
    def get_glyph_ranges_default(self: ImFontAtlas) -> ImGlyphRange: ...
    # def get_glyph_ranges_greek(self: ImFontAtlas) -> int: ...
    def get_glyph_ranges_japanese(self: ImFontAtlas) -> ImGlyphRange: ...
    # def get_glyph_ranges_korean(self: ImFontAtlas) -> ImGlyphRange: ...
    # def get_glyph_ranges_thai(self: ImFontAtlas) -> int: ...
    # def get_glyph_ranges_vietnamese(self: ImFontAtlas) -> int: ...
    # def get_mouse_cursor_tex_data(self: ImFontAtlas, cursor: int, out_offset: ImVec2, out_size: ImVec2, out_uv_border: ImVec2, out_uv_fill: ImVec2) -> bool: ...
    def get_tex_data_as_alpha8(self: ImFontAtlas, out_width: Int, out_height: Int, out_bytes_per_pixel: Int=None) -> bytes: ...
    def get_tex_data_as_rgba_32(self: ImFontAtlas, out_width: Int, out_height: Int, out_bytes_per_pixel: Int=None) -> bytes: ...
    # def is_built(self: ImFontAtlas) -> bool: ...
    # def set_tex_id(self: ImFontAtlas, id_: Any) -> None: ...

class ImFontAtlasCustomRect:
    font: ImFont
    glyph_advance_x: float
    glyph_id: int
    glyph_offset: Tuple[float, float]
    height: int
    width: int
    x: int
    y: int
    def is_packed(self: ImFontAtlasCustomRect) -> bool: ...

class ImFontBuilderIO:
    pass

class ImFontConfig:
    dst_font: ImFont
    ellipsis_char: int
    font_builder_flags: int
    font_data_owned_by_atlas: bool
    font_data_size: int
    font_no: int
    glyph_extra_spacing: Tuple[float, float]
    glyph_max_advance_x: float
    glyph_min_advance_x: float
    glyph_offset: Tuple[float, float]
    glyph_ranges: List[int]
    merge_mode: bool
    name: int
    oversample_h: int
    oversample_v: int
    pixel_snap_h: bool
    # rasterizer_density: float
    rasterizer_multiply: float
    size_pixels: float
    def create() -> ImFontConfig: ...
    def destroy(self: ImFontConfig) -> None: ...

class ImFontGlyph:
    advance_x: float
    codepoint: int
    colored: int
    u0: float
    u1: float
    v0: float
    v1: float
    visible: int
    x0: float
    x1: float
    y0: float
    y1: float

class ImFontGlyphRangesBuilder:
    used_chars: List[int]
    def add_char(self: ImFontGlyphRangesBuilder, c: int) -> None: ...
    def add_ranges(self: ImFontGlyphRangesBuilder, ranges: ImGlyphRange) -> None: ...
    def add_text(self: ImFontGlyphRangesBuilder, text: str) -> None: ...
    def build_ranges(self: ImFontGlyphRangesBuilder) -> ImGlyphRange: ...
    def clear(self: ImFontGlyphRangesBuilder) -> None: ...
    def create() -> ImFontGlyphRangesBuilder: ...
    def destroy(self: ImFontGlyphRangesBuilder) -> None: ...
    def get_bit(self: ImFontGlyphRangesBuilder, n: int) -> bool: ...
    def set_bit(self: ImFontGlyphRangesBuilder, n: int) -> None: ...

class ImGuiContext:
    pass

class ImGuiIO:
    app_accepting_events: bool
    app_focus_lost: bool
    backend_flags: int
    backend_platform_name: str
    backend_renderer_name: str
    backend_using_legacy_key_arrays: int
    backend_using_legacy_nav_input_array: bool
    config_debug_begin_return_value_loop: bool
    config_debug_begin_return_value_once: bool
    # config_debug_ignore_focus_loss: bool
    config_debug_ini_settings: bool
    # config_debug_is_debugger_present: bool
    config_docking_always_tab_bar: bool
    config_docking_no_split: bool
    config_docking_transparent_payload: bool
    config_docking_with_shift: bool
    config_drag_click_to_input_text: bool
    config_flags: int
    config_input_text_cursor_blink: bool
    config_input_text_enter_keep_active: bool
    config_input_trickle_event_queue: bool
    config_mac_osx_behaviors: bool
    config_memory_compact_timer: float
    # config_nav_swap_gamepad_buttons: bool
    config_viewports_no_auto_merge: bool
    config_viewports_no_decoration: bool
    config_viewports_no_default_parent: bool
    config_viewports_no_task_bar_icon: bool
    config_windows_move_from_title_bar_only: bool
    config_windows_resize_from_edges: bool
    ctx: ImGuiContext
    delta_time: float
    display_framebuffer_scale: Tuple[float, float]
    display_size: Tuple[float, float]
    font_allow_user_scaling: bool
    font_default: ImFont
    font_global_scale: float
    fonts: ImFontAtlas
    framerate: float
    ini_filename: str
    ini_saving_rate: float
    input_queue_characters: List[int]
    input_queue_surrogate: int
    key_alt: bool
    key_ctrl: bool
    key_mods: int
    key_repeat_delay: float
    key_repeat_rate: float
    key_shift: bool
    key_super: bool
    keys_data: ImGuiKeyData
    log_filename: str
    metrics_active_windows: int
    metrics_render_indices: int
    metrics_render_vertices: int
    metrics_render_windows: int
    mouse_clicked: Sequence[bool]
    mouse_clicked_count: int
    mouse_clicked_last_count: int
    mouse_clicked_pos: tuple
    # mouse_clicked_time: Sequence[Double]
    # mouse_ctrl_left_as_right_click: bool
    mouse_delta: Tuple[float, float]
    mouse_double_click_max_dist: float
    mouse_double_click_time: float
    mouse_double_clicked: Sequence[bool]
    mouse_down: Sequence[bool]
    mouse_down_duration: Sequence[float]
    mouse_down_duration_prev: Sequence[float]
    mouse_down_owned: Sequence[bool]
    mouse_down_owned_unless_popup_close: Sequence[bool]
    mouse_drag_max_distance_abs: tuple
    mouse_drag_max_distance_sqr: Sequence[float]
    mouse_drag_threshold: float
    mouse_draw_cursor: bool
    mouse_hovered_viewport: int
    mouse_pos: Tuple[float, float]
    mouse_pos_prev: Tuple[float, float]
    mouse_released: Sequence[bool]
    mouse_source: int
    mouse_wheel: float
    mouse_wheel_h: float
    mouse_wheel_request_axis_swap: bool
    nav_active: bool
    nav_visible: bool
    pen_pressure: float
    user_data: Any
    want_capture_keyboard: bool
    want_capture_mouse: bool
    want_capture_mouse_unless_popup_close: bool
    want_save_ini_settings: bool
    want_set_mouse_pos: bool
    want_text_input: bool
    # def add_focus_event(self: ImGuiIO, focused: bool) -> None: ...
    def add_input_character(self: ImGuiIO, c: int) -> None: ...
    # def add_input_character_utf_16(self: ImGuiIO, c: int) -> None: ...
    # def add_input_characters_utf_8(self: ImGuiIO, str_: str) -> None: ...
    # def add_key_analog_event(self: ImGuiIO, key: int, down: bool, v: float) -> None: ...
    def add_key_event(self: ImGuiIO, key: int, down: bool) -> None: ...
    def add_mouse_button_event(self: ImGuiIO, button: int, down: bool) -> None: ...
    def add_mouse_pos_event(self: ImGuiIO, x: float, y: float) -> None: ...
    # def add_mouse_source_event(self: ImGuiIO, source: int) -> None: ...
    # def add_mouse_viewport_event(self: ImGuiIO, id_: int) -> None: ...
    def add_mouse_wheel_event(self: ImGuiIO, wheel_x: float, wheel_y: float) -> None: ...
    # def clear_events_queue(self: ImGuiIO) -> None: ...
    # def clear_input_keys(self: ImGuiIO) -> None: ...
    # def clear_input_mouse(self: ImGuiIO) -> None: ...
    # def set_app_accepting_events(self: ImGuiIO, accepting_events: bool) -> None: ...
    # def set_key_event_native_data(self: ImGuiIO, key: int, native_keycode: int, native_scancode: int) -> None: ...
    # def set_key_event_native_data_ex(self: ImGuiIO, key: int, native_keycode: int, native_scancode: int, native_legacy_index: int=-1) -> None: ...

class ImGuiInputTextCallbackData:
    buf: str
    buf_dirty: bool
    buf_size: int
    buf_text_len: int
    ctx: ImGuiContext
    cursor_pos: int
    event_char: int
    event_flag: int
    event_key: int
    flags: int
    selection_end: int
    selection_start: int
    user_data: Any
    def clear_selection(self: ImGuiInputTextCallbackData) -> None: ...
    def delete_chars(self: ImGuiInputTextCallbackData, pos: int, bytes_count: int) -> None: ...
    def has_selection(self: ImGuiInputTextCallbackData) -> bool: ...
    def insert_chars(self: ImGuiInputTextCallbackData, pos: int, text: str) -> None: ...
    def select_all(self: ImGuiInputTextCallbackData) -> None: ...

class ImGuiKeyData:
    analog_value: float
    down: bool
    down_duration: float
    down_duration_prev: float

class ImGuiListClipper:
    ctx: ImGuiContext
    display_end: int
    display_start: int
    # start_seek_offset_y: float
    def begin(self: ImGuiListClipper, items_count: int, items_height: float=-1.0) -> None: ...
    def create() -> ImGuiListClipper: ...
    def destroy(self: ImGuiListClipper) -> None: ...
    def end(self: ImGuiListClipper) -> None: ...
    def include_item_by_index(self: ImGuiListClipper, item_index: int) -> None: ...
    def include_items_by_index(self: ImGuiListClipper, item_begin: int, item_end: int) -> None: ...
    # def seek_cursor_for_item(self: ImGuiListClipper, item_index: int) -> None: ...
    def step(self: ImGuiListClipper) -> bool: ...

class ImGuiMultiSelectIO:
    pass
    # items_count: int
    # nav_id_item: Any
    # nav_id_selected: bool
    # range_src_item: Any
    # range_src_reset: bool
    # requests: ImVector_ImGuiSelectionRequest

class ImGuiPayload:
    data: Vec4 | Any
    data_frame_count: int
    data_size: int
    data_type: int
    delivery: bool
    preview: bool
    source_id: int
    source_parent_id: int
    # def clear(self: ImGuiPayload) -> None: ...
    # def is_data_type(self: ImGuiPayload, type_: str) -> bool: ...
    # def is_delivery(self: ImGuiPayload) -> bool: ...
    # def is_preview(self: ImGuiPayload) -> bool: ...

class ImGuiPlatformIO:
    monitors: List[ImGuiPlatformMonitor]
    # platform_clipboard_user_data: Any
    # platform_create_vk_surface: Callable
    # platform_create_window: Callable
    # platform_destroy_window: Callable
    # platform_get_clipboard_text_fn: Callable
    # platform_get_window_dpi_scale: Callable
    # platform_get_window_focus: Callable
    # platform_get_window_minimized: Callable
    # platform_get_window_pos: Callable
    # platform_get_window_size: Callable
    # platform_get_window_work_area_insets: Callable
    # platform_ime_user_data: Any
    # platform_locale_decimal_point: int
    # platform_on_changed_viewport: Callable
    # platform_open_in_shell_fn: Callable
    # platform_open_in_shell_user_data: Any
    # platform_render_window: Callable
    # platform_set_clipboard_text_fn: Callable
    # platform_set_ime_data_fn: Callable
    # platform_set_window_alpha: Callable
    # platform_set_window_focus: Callable
    # platform_set_window_pos: Callable
    # platform_set_window_size: Callable
    # platform_set_window_title: Callable
    # platform_show_window: Callable
    # platform_swap_buffers: Callable
    # platform_update_window: Callable
    # renderer_create_window: Callable
    # renderer_destroy_window: Callable
    # renderer_render_window: Callable
    # renderer_set_window_size: Callable
    # renderer_swap_buffers: Callable
    viewports: List[ImGuiViewport]

class ImGuiPlatformImeData:
    pass
    # input_line_height: float
    # input_pos: Tuple[float, float]
    # want_visible: bool

class ImGuiPlatformMonitor:
    dpi_scale: float
    main_pos: Tuple[float, float]
    main_size: Tuple[float, float]
    # platform_handle: Any
    work_pos: Tuple[float, float]
    work_size: Tuple[float, float]

class ImGuiSelectionBasicStorage:
    pass
    # adapter_index_to_storage_id: Callable
    # preserve_order: bool
    # selection_order: int
    # size: int
    # storage: ImGuiStorage
    # user_data: Any
    # def apply_requests(self: ImGuiSelectionBasicStorage, ms_io: ImGuiMultiSelectIO) -> None: ...
    # def clear(self: ImGuiSelectionBasicStorage) -> None: ...
    # def contains(self: ImGuiSelectionBasicStorage, id_: int) -> bool: ...
    # def get_next_selected_item(self: ImGuiSelectionBasicStorage, opaque_it: Any, out_id: int) -> bool: ...
    # def get_storage_id_from_index(self: ImGuiSelectionBasicStorage, idx: int) -> int: ...
    # def set_item_selected(self: ImGuiSelectionBasicStorage, id_: int, selected: bool) -> None: ...
    # def swap(self: ImGuiSelectionBasicStorage, r: ImGuiSelectionBasicStorage) -> None: ...

class ImGuiSelectionExternalStorage:
    pass
    # adapter_set_item_selected: Callable
    # user_data: Any
    # def apply_requests(self: ImGuiSelectionExternalStorage, ms_io: ImGuiMultiSelectIO) -> None: ...

class ImGuiSelectionRequest:
    pass
    # range_direction: int
    # range_first_item: Any
    # range_last_item: Any
    # selected: bool
    # type: Any

class ImGuiSizeCallbackData:
    current_size: Tuple[float, float]
    desired_size: Tuple[float, float]
    pos: Tuple[float, float]
    user_data: Any

class ImGuiStoragePair:
    pass
    # key: int

class ImGuiStyle:
    alpha: float
    anti_aliased_fill: bool
    anti_aliased_lines: bool
    anti_aliased_lines_use_tex: bool
    button_text_align: Tuple[float, float]
    cell_padding: Tuple[float, float]
    child_border_size: float
    child_rounding: float
    circle_tessellation_max_error: float
    color_button_position: int
    colors: tuple
    columns_min_spacing: float
    curve_tessellation_tol: float
    disabled_alpha: float
    display_safe_area_padding: Tuple[float, float]
    display_window_padding: Tuple[float, float]
    # docking_separator_size: float
    frame_border_size: float
    frame_padding: Tuple[float, float]
    frame_rounding: float
    grab_min_size: float
    grab_rounding: float
    hover_delay_normal: float
    hover_delay_short: float
    # hover_flags_for_tooltip_mouse: int
    # hover_flags_for_tooltip_nav: int
    # hover_stationary_delay: float
    indent_spacing: float
    item_inner_spacing: Tuple[float, float]
    item_spacing: Tuple[float, float]
    log_slider_deadzone: float
    mouse_cursor_scale: float
    popup_border_size: float
    popup_rounding: float
    scrollbar_rounding: float
    scrollbar_size: float
    selectable_text_align: Tuple[float, float]
    separator_text_align: Tuple[float, float]
    separator_text_border_size: float
    separator_text_padding: Tuple[float, float]
    # tab_bar_border_size: float
    # tab_bar_overline_size: float
    tab_border_size: float
    tab_min_width_for_close_button: float
    tab_rounding: float
    table_angled_headers_angle: float
    table_angled_headers_text_align: Tuple[float, float]
    touch_extra_padding: Tuple[float, float]
    window_border_size: float
    window_menu_button_position: int
    window_min_size: Tuple[float, float]
    window_padding: Tuple[float, float]
    window_rounding: float
    window_title_align: Tuple[float, float]
    # def scale_all_sizes(self: ImGuiStyle, scale_factor: float) -> None: ...

class ImGuiTableColumnSortSpecs:
    column_index: int
    column_user_id: int
    sort_direction: int
    # sort_order: int

class ImGuiTableSortSpecs:
    specs: List[ImGuiTableColumnSortSpecs]
    specs_count: int
    specs_dirty: bool

class ImGuiTextFilter:
    # count_grep: int
    # filters: ImVector_ImGuiTextFilter_ImGuiTextRange
    # input_buf: int
    # def build(self: ImGuiTextFilter) -> None: ...
    # def clear(self: ImGuiTextFilter) -> None: ...
    def create(default_filter: str="") -> ImGuiTextFilter: ...
    def destroy(self: ImGuiTextFilter) -> None: ...
    def draw(self: ImGuiTextFilter, label: str="Filter (inc,-exc)", width: float=0.0) -> bool: ...
    def is_active(self: ImGuiTextFilter) -> bool: ...
    def pass_filter(self: ImGuiTextFilter, text: str) -> bool: ...

class ImGuiViewport:
    dpi_scale: float
    draw_data: ImDrawData
    flags: int
    id: int
    parent_viewport_id: int
    # platform_handle: Any
    # platform_handle_raw: Any
    platform_request_close: bool
    platform_request_move: bool
    platform_request_resize: bool
    platform_window_created: bool
    pos: Tuple[float, float]
    size: Tuple[float, float]
    work_pos: Tuple[float, float]
    work_size: Tuple[float, float]
    def get_center(self: ImGuiViewport) -> Tuple[float, float]: ...
    def get_work_center(self: ImGuiViewport) -> Tuple[float, float]: ...

class ImGuiWindowClass:
    pass
    # class_id: int
    # dock_node_flags_override_set: int
    # docking_allow_unclassed: bool
    # docking_always_tab_bar: bool
    # focus_route_parent_window_id: int
    # parent_viewport_id: int
    # tab_item_flags_override_set: int
    # viewport_flags_override_clear: int
    # viewport_flags_override_set: int

class ImVector_ImDrawCmd: ...
    # capacity: int
    # data: ImDrawCmd
    # size: int

class ImVector_ImDrawIdx:
    # capacity: int
    data: int
    size: int

class ImVector_ImDrawListPtr: ...
    # capacity: int
    # data: ImDrawList
    # size: int

class ImVector_ImDrawVert:
    # capacity: int
    data: ImDrawVert
    size: int

class ImVector_ImGuiSelectionRequest: ...
    # capacity: int
    # data: ImGuiSelectionRequest
    # size: int

class ImVector_ImGuiStoragePair: ...
    # capacity: int
    # data: ImGuiStoragePair
    # size: int

class ImVector_ImU32: ...
    # capacity: int
    # data: int
    # size: int

class ImVector_ImWchar: ...
    # capacity: int
    # data: int
    # size: int

class ImVector_char: ...
    # capacity: int
    # data: str
    # size: int

