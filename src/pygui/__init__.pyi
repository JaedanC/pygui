# This file is auto-generated. If you need to edit this file then edit the
# template that this is created from instead.
from typing import Any, Callable, Tuple, List, Sequence
from PIL import Image

FLT_MIN: float
FLT_MAX: float
PAYLOAD_TYPE_COLOR_3F: int
PAYLOAD_TYPE_COLOR_4F: int

class ImGuiError(Exception): ...

class BoolPtr:
    value: bool
    def __init__(self, initial_value: bool): ...
    def __bool__(self) -> bool: ...

class IntPtr:
    value: int
    def __init__(self, initial_value: int): ...

class FloatPtr:
    value: float
    def __float__(self) -> float: ...

class DoublePtr:
    value: float
    def __init__(self, initial_value: float): ...

class StrPtr:
    value: str
    buffer_size: int
    def __init__(self, initial_value: str, buffer_size=256): ...

class Vec4Ptr:
    x: float
    y: float
    z: float
    w: float
    def __init__(self, x: float, y: float, z: float, w: float): ...
    def vec(self) -> Tuple[float, float, float, float]: ...
    def to_u32(self) -> int: ...
    def as_floatptrs(self) -> Sequence[FloatPtr]: ...
    def from_floatptrs(self, float_ptrs: Sequence[FloatPtr]): ...
    def to_floatptrs(self) -> Sequence[FloatPtr]: ...
    def copy(self) -> Vec4Ptr: ...

class Vec2Ptr:
    x: float
    y: float
    def __init__(self, x: float, y: float): ...
    def vec(self) -> Tuple[float, float]: ...
    def as_floatptrs(self) -> Sequence[FloatPtr]: ...
    def from_floatptrs(self, float_ptrs: Sequence[FloatPtr]): ...
    def to_floatptrs(self) -> Sequence[FloatPtr]: ...
    def copy(self) -> Vec2Ptr: ...

def IM_COL32(r: int, g: int, b: int, a: int) -> int: ...

class ImGuiError(Exception): ...

def load_image(image: Image) -> int: ...

def IM_ASSERT(condition: bool, msg: str=""): ...

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
WINDOW_FLAGS_ALWAYS_USE_WINDOW_PADDING: int
WINDOW_FLAGS_NO_NAV_INPUTS: int
WINDOW_FLAGS_NO_NAV_FOCUS: int
WINDOW_FLAGS_UNSAVED_DOCUMENT: int
WINDOW_FLAGS_NO_DOCKING: int
WINDOW_FLAGS_NO_NAV: int
WINDOW_FLAGS_NO_DECORATION: int
WINDOW_FLAGS_NO_INPUTS: int
WINDOW_FLAGS_NAV_FLATTENED: int
WINDOW_FLAGS_CHILD_WINDOW: int
WINDOW_FLAGS_TOOLTIP: int
WINDOW_FLAGS_POPUP: int
WINDOW_FLAGS_MODAL: int
WINDOW_FLAGS_CHILD_MENU: int
WINDOW_FLAGS_DOCK_NODE_HOST: int
INPUT_TEXT_FLAGS_NONE: int
INPUT_TEXT_FLAGS_CHARS_DECIMAL: int
INPUT_TEXT_FLAGS_CHARS_HEXADECIMAL: int
INPUT_TEXT_FLAGS_CHARS_UPPERCASE: int
INPUT_TEXT_FLAGS_CHARS_NO_BLANK: int
INPUT_TEXT_FLAGS_AUTO_SELECT_ALL: int
INPUT_TEXT_FLAGS_ENTER_RETURNS_TRUE: int
INPUT_TEXT_FLAGS_CALLBACK_COMPLETION: int
INPUT_TEXT_FLAGS_CALLBACK_HISTORY: int
INPUT_TEXT_FLAGS_CALLBACK_ALWAYS: int
INPUT_TEXT_FLAGS_CALLBACK_CHAR_FILTER: int
INPUT_TEXT_FLAGS_ALLOW_TAB_INPUT: int
INPUT_TEXT_FLAGS_CTRL_ENTER_FOR_NEW_LINE: int
INPUT_TEXT_FLAGS_NO_HORIZONTAL_SCROLL: int
INPUT_TEXT_FLAGS_ALWAYS_OVERWRITE: int
INPUT_TEXT_FLAGS_READ_ONLY: int
INPUT_TEXT_FLAGS_PASSWORD: int
INPUT_TEXT_FLAGS_NO_UNDO_REDO: int
INPUT_TEXT_FLAGS_CHARS_SCIENTIFIC: int
INPUT_TEXT_FLAGS_CALLBACK_RESIZE: int
INPUT_TEXT_FLAGS_CALLBACK_EDIT: int
INPUT_TEXT_FLAGS_ESCAPE_CLEARS_ALL: int
TREE_NODE_FLAGS_NONE: int
TREE_NODE_FLAGS_SELECTED: int
TREE_NODE_FLAGS_FRAMED: int
TREE_NODE_FLAGS_ALLOW_ITEM_OVERLAP: int
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
TREE_NODE_FLAGS_NAV_LEFT_JUMPS_BACK_HERE: int
TREE_NODE_FLAGS_COLLAPSING_HEADER: int
POPUP_FLAGS_NONE: int
POPUP_FLAGS_MOUSE_BUTTON_LEFT: int
POPUP_FLAGS_MOUSE_BUTTON_RIGHT: int
POPUP_FLAGS_MOUSE_BUTTON_MIDDLE: int
POPUP_FLAGS_MOUSE_BUTTON_MASK: int
POPUP_FLAGS_MOUSE_BUTTON_DEFAULT: int
POPUP_FLAGS_NO_OPEN_OVER_EXISTING_POPUP: int
POPUP_FLAGS_NO_OPEN_OVER_ITEMS: int
POPUP_FLAGS_ANY_POPUP_ID: int
POPUP_FLAGS_ANY_POPUP_LEVEL: int
POPUP_FLAGS_ANY_POPUP: int
SELECTABLE_FLAGS_NONE: int
SELECTABLE_FLAGS_DONT_CLOSE_POPUPS: int
SELECTABLE_FLAGS_SPAN_ALL_COLUMNS: int
SELECTABLE_FLAGS_ALLOW_DOUBLE_CLICK: int
SELECTABLE_FLAGS_DISABLED: int
SELECTABLE_FLAGS_ALLOW_ITEM_OVERLAP: int
COMBO_FLAGS_NONE: int
COMBO_FLAGS_POPUP_ALIGN_LEFT: int
COMBO_FLAGS_HEIGHT_SMALL: int
COMBO_FLAGS_HEIGHT_REGULAR: int
COMBO_FLAGS_HEIGHT_LARGE: int
COMBO_FLAGS_HEIGHT_LARGEST: int
COMBO_FLAGS_NO_ARROW_BUTTON: int
COMBO_FLAGS_NO_PREVIEW: int
COMBO_FLAGS_HEIGHT_MASK: int
TAB_BAR_FLAGS_NONE: int
TAB_BAR_FLAGS_REORDERABLE: int
TAB_BAR_FLAGS_AUTO_SELECT_NEW_TABS: int
TAB_BAR_FLAGS_TAB_LIST_POPUP_BUTTON: int
TAB_BAR_FLAGS_NO_CLOSE_WITH_MIDDLE_MOUSE_BUTTON: int
TAB_BAR_FLAGS_NO_TAB_LIST_SCROLLING_BUTTONS: int
TAB_BAR_FLAGS_NO_TOOLTIP: int
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
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED: int
HOVERED_FLAGS_ALLOW_WHEN_DISABLED: int
HOVERED_FLAGS_NO_NAV_OVERRIDE: int
HOVERED_FLAGS_RECT_ONLY: int
HOVERED_FLAGS_ROOT_AND_CHILD_WINDOWS: int
HOVERED_FLAGS_DELAY_NORMAL: int
HOVERED_FLAGS_DELAY_SHORT: int
HOVERED_FLAGS_NO_SHARED_DELAY: int
DOCK_NODE_FLAGS_NONE: int
DOCK_NODE_FLAGS_KEEP_ALIVE_ONLY: int
DOCK_NODE_FLAGS_NO_DOCKING_IN_CENTRAL_NODE: int
DOCK_NODE_FLAGS_PASSTHRU_CENTRAL_NODE: int
DOCK_NODE_FLAGS_NO_SPLIT: int
DOCK_NODE_FLAGS_NO_RESIZE: int
DOCK_NODE_FLAGS_AUTO_HIDE_TAB_BAR: int
DRAG_DROP_FLAGS_NONE: int
DRAG_DROP_FLAGS_SOURCE_NO_PREVIEW_TOOLTIP: int
DRAG_DROP_FLAGS_SOURCE_NO_DISABLE_HOVER: int
DRAG_DROP_FLAGS_SOURCE_NO_HOLD_TO_OPEN_OTHERS: int
DRAG_DROP_FLAGS_SOURCE_ALLOW_NULL_ID: int
DRAG_DROP_FLAGS_SOURCE_EXTERN: int
DRAG_DROP_FLAGS_SOURCE_AUTO_EXPIRE_PAYLOAD: int
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
MOD_SHORTCUT: int
MOD_MASK: int
KEY_NAMED_KEY_BEGIN: int
KEY_NAMED_KEY_END: int
KEY_NAMED_KEY_COUNT: int
KEY_KEYS_DATA_SIZE: int
KEY_KEYS_DATA_OFFSET: int
CONFIG_FLAGS_NONE: int
CONFIG_FLAGS_NAV_ENABLE_KEYBOARD: int
CONFIG_FLAGS_NAV_ENABLE_GAMEPAD: int
CONFIG_FLAGS_NAV_ENABLE_SET_MOUSE_POS: int
CONFIG_FLAGS_NAV_NO_CAPTURE_KEYBOARD: int
CONFIG_FLAGS_NO_MOUSE: int
CONFIG_FLAGS_NO_MOUSE_CURSOR_CHANGE: int
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
COL_TAB: int
COL_TAB_HOVERED: int
COL_TAB_ACTIVE: int
COL_TAB_UNFOCUSED: int
COL_TAB_UNFOCUSED_ACTIVE: int
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
STYLE_VAR_BUTTON_TEXT_ALIGN: int
STYLE_VAR_SELECTABLE_TEXT_ALIGN: int
STYLE_VAR_SEPARATOR_TEXT_BORDER_SIZE: int
STYLE_VAR_SEPARATOR_TEXT_ALIGN: int
STYLE_VAR_SEPARATOR_TEXT_PADDING: int
STYLE_VAR_COUNT: int
BUTTON_FLAGS_NONE: int
BUTTON_FLAGS_MOUSE_BUTTON_LEFT: int
BUTTON_FLAGS_MOUSE_BUTTON_RIGHT: int
BUTTON_FLAGS_MOUSE_BUTTON_MIDDLE: int
BUTTON_FLAGS_MOUSE_BUTTON_MASK: int
BUTTON_FLAGS_MOUSE_BUTTON_DEFAULT: int
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



def accept_drag_drop_payload(type_: str, flags: int=0) -> Any:
    """
    Accept contents of a given type. if imguidragdropflags_acceptbeforedelivery is set you can peek into the payload before the mouse button is released.
    """
    pass

def align_text_to_frame_padding() -> None:
    """
    Vertically align upcoming text baseline to framepadding.y so that it will align properly to regularly framed items (call if you have text on a line before a framed item)
    """
    pass

def arrow_button(str_id: str, dir_: int) -> bool:
    """
    Square button with an arrow shape
    """
    pass

def begin(name: str, p_open: BoolPtr=None, flags: int=0) -> bool:
    """
    Windows
    - Begin() = push window to the stack and start appending to it. End() = pop window from the stack.
    - Passing 'bool* p_open != NULL' shows a window-closing widget in the upper-right corner of the window,
    which clicking will set the boolean to false when clicked.
    - You may append multiple times to the same window during the same frame by calling Begin()/End() pairs multiple times.
    Some information such as 'flags' or 'p_open' will only be considered by the first call to Begin().
    - Begin() return false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
    anything to the window. Always call a matching End() for each Begin() call, regardless of its return value!
    [Important: due to legacy reason, this is inconsistent with most other functions such as BeginMenu/EndMenu,
    BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding BeginXXX function
    returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
    - Note that the bottom of window stack always contains a window called "Debug".
    """
    pass

def begin_child(str_id: str, size: tuple=(0, 0), border: bool=False, flags: int=0) -> bool:
    """
    Child Windows
    - Use child windows to begin into a self-contained independent scrolling/clipping regions within a host window. Child windows can embed their own child.
    - For each independent axis of 'size': ==0.0f: use remaining host window size / >0.0f: fixed size / <0.0f: use remaining window size minus abs(size) / Each axis can use a different mode, e.g. ImVec2(0,400).
    - BeginChild() returns false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting anything to the window.
    Always call a matching EndChild() for each BeginChild() call, regardless of its return value.
    [Important: due to legacy reason, this is inconsistent with most other functions such as BeginMenu/EndMenu,
    BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding BeginXXX function
    returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
    """
    pass

# def begin_child_frame(id_: int, size: tuple, flags: int=0) -> bool:
#     """
#     Helper to create a child window / scrolling region that looks like a normal widget frame
#     """
#     pass

# def begin_child_id(id_: int, size: tuple=(0, 0), border: bool=False, flags: int=0) -> bool: ...
def begin_combo(label: str, preview_value: str, flags: int=0) -> bool:
    """
    Widgets: Combo Box (Dropdown)
    - The BeginCombo()/EndCombo() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() items.
    - The old Combo() api are helpers over BeginCombo()/EndCombo() which are kept available for convenience purpose. This is analogous to how ListBox are created.
    """
    pass

# def begin_disabled(disabled: bool=True) -> None:
#     """
#     Disabling [BETA API]
#     - Disable all user interactions and dim items visuals (applying style.DisabledAlpha over current colors)
#     - Those can be nested but it cannot be used to enable an already disabled section (a single BeginDisabled(true) in the stack is enough to keep everything disabled)
#     - BeginDisabled(false) essentially does nothing useful but is provided to facilitate use of boolean expressions. If you can avoid calling BeginDisabled(False)/EndDisabled() best to avoid it.
#     """
#     pass

def begin_drag_drop_source(flags: int=0) -> bool:
    """
    Drag and Drop
    - On source items, call BeginDragDropSource(), if it returns true also call SetDragDropPayload() + EndDragDropSource().
    - On target candidates, call BeginDragDropTarget(), if it returns true also call AcceptDragDropPayload() + EndDragDropTarget().
    - If you stop calling BeginDragDropSource() the payload is preserved however it won't have a preview tooltip (we currently display a fallback "..." tooltip, see #1725)
    - An item can be both drag source and drop target.
    Call after submitting an item which may be dragged. when this return true, you can call setdragdroppayload() + enddragdropsource()
    """
    pass

def begin_drag_drop_target() -> bool:
    """
    Call after submitting an item that may receive a payload. if this returns true, you can call acceptdragdroppayload() + enddragdroptarget()
    """
    pass

def begin_group() -> None:
    """
    Lock horizontal starting position
    """
    pass

def begin_list_box(label: str, size: tuple=(0, 0)) -> bool:
    """
    Widgets: List Boxes
    - This is essentially a thin wrapper to using BeginChild/EndChild with some stylistic changes.
    - The BeginListBox()/EndListBox() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() or any items.
    - The simplified/old ListBox() api are helpers over BeginListBox()/EndListBox() which are kept available for convenience purpose. This is analoguous to how Combos are created.
    - Choose frame width:   size.x > 0.0f: custom  /  size.x < 0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
    - Choose frame height:  size.y > 0.0f: custom  /  size.y < 0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
    Open a framed scrolling region
    """
    pass

# def begin_main_menu_bar() -> bool:
#     """
#     Create and append to a full screen menu-bar.
#     """
#     pass

def begin_menu(label: str, enabled: bool=True) -> bool:
    """
    Create a sub-menu entry. only call endmenu() if this returns true!
    """
    pass

def begin_menu_bar() -> bool:
    """
    Widgets: Menus
    - Use BeginMenuBar() on a window ImGuiWindowFlags_MenuBar to append to its menu bar.
    - Use BeginMainMenuBar() to create a menu bar at the top of the screen and append to it.
    - Use BeginMenu() to create a menu. You can call BeginMenu() multiple time with the same identifier to append more items to it.
    - Not that MenuItem() keyboardshortcuts are displayed as a convenience but _not processed_ by Dear ImGui at the moment.
    Append to menu-bar of current window (requires imguiwindowflags_menubar flag set on parent window).
    """
    pass

def begin_popup(str_id: str, flags: int=0) -> bool:
    """
    Popups: begin/end functions
    - BeginPopup(): query popup state, if open start appending into the window. Call EndPopup() afterwards. ImGuiWindowFlags are forwarded to the window.
    - BeginPopupModal(): block every interaction behind the window, cannot be closed by user, add a dimming background, has a title bar.
    Return true if the popup is open, and you can start outputting to it.
    """
    pass

def begin_popup_context_item(str_id: str=None, popup_flags: int=1) -> bool:
    """
    Popups: open+begin combined functions helpers
    - Helpers to do OpenPopup+BeginPopup where the Open action is triggered by e.g. hovering an item and right-clicking.
    - They are convenient to easily create context menus, hence the name.
    - IMPORTANT: Notice that BeginPopupContextXXX takes ImGuiPopupFlags just like OpenPopup() and unlike BeginPopup(). For full consistency, we may add ImGuiWindowFlags to the BeginPopupContextXXX functions in the future.
    - IMPORTANT: Notice that we exceptionally default their flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter, so if you add other flags remember to re-add the ImGuiPopupFlags_MouseButtonRight.
    Implied str_id = null, popup_flags = 1
    Open+begin popup when clicked on last item. use str_id==null to associate the popup to previous item. if you want to use that on a non-interactive item such as text() you need to pass in an explicit id here. read comments in .cpp!
    """
    pass

# def begin_popup_context_void() -> bool:
#     """
#     Implied str_id = null, popup_flags = 1
#     """
#     pass

# def begin_popup_context_void_ex(str_id: str=None, popup_flags: int=1) -> bool:
#     """
#     Open+begin popup when clicked in void (where there are no windows).
#     """
#     pass

def begin_popup_context_window(str_id: str=None, popup_flags: int=1) -> bool:
    """
    Open+begin popup when clicked on current window.
    """
    pass

# def begin_popup_modal(name: str, p_open: BoolPtr=None, flags: int=0) -> bool:
#     """
#     Return true if the modal is open, and you can start outputting to it.
#     """
#     pass

def begin_tab_bar(str_id: str, flags: int=0) -> bool:
    """
    Tab Bars, Tabs
    - Note: Tabs are automatically created by the docking system (when in 'docking' branch). Use this to create tab bars/tabs yourself.
    Create and append into a tabbar
    """
    pass

def begin_tab_item(label: str, p_open: BoolPtr=None, flags: int=0) -> bool:
    """
    Create a tab. returns true if the tab is selected.
    """
    pass

def begin_table(str_id: str, column: int, flags: int=0, outer_size: tuple=(0.0, 0.0), inner_width: float=0.0) -> bool:
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
    --------------------------------------------------------------------------------------------------------
    TableNextRow() -> TableSetColumnIndex(0) -> Text("Hello 0") -> TableSetColumnIndex(1) -> Text("Hello 1")  // OK
    TableNextRow() -> TableNextColumn()  -> Text("Hello 0") -> TableNextColumn()  -> Text("Hello 1")  // OK
    TableNextColumn()  -> Text("Hello 0") -> TableNextColumn()  -> Text("Hello 1")  // OK: TableNextColumn() automatically gets to next row!
    TableNextRow()   -> Text("Hello 0")   // Not OK! Missing TableSetColumnIndex() or TableNextColumn()! Text will not appear!
    --------------------------------------------------------------------------------------------------------
    - 5. Call EndTable()
    Implied outer_size = imvec2(0.0f, 0.0f), inner_width = 0.0f
    """
    pass

def begin_tooltip() -> bool:
    """
    Tooltips
    - Tooltip are windows following the mouse. They do not take focus away.
    Begin/append a tooltip window. to create full-featured tooltip (with any kind of items).
    """
    pass

def bullet() -> None:
    """
    Draw a small circle + keep the cursor on the same line. advance cursor x position by gettreenodetolabelspacing(), same distance that treenode() uses
    """
    pass

def bullet_text(fmt: str) -> None:
    """
    Shortcut for bullet()+text()
    """
    pass

# def bullet_text_v(fmt: str) -> None: ...
def button(label: str, size: tuple=(0, 0)) -> bool:
    """
    Widgets: Main
    - Most widgets return true when the value has been changed or when pressed/selected
    - You may also use one of the many IsItemXXX functions (e.g. IsItemActive, IsItemHovered, etc.) to query widget state.
    Implied size = imvec2(0, 0)
    """
    pass

def calc_item_width() -> float:
    """
    Width of item given pushed settings and current cursor position. not necessarily the width of last item unlike most 'item' functions.
    """
    pass

def calc_text_size(text: str, text_end: str=None, hide_text_after_double_hash: bool=False, wrap_width: float=-1.0) -> tuple:
    """
    Text Utilities
    Implied text_end = null, hide_text_after_double_hash = false, wrap_width = -1.0f
    """
    pass

def checkbox(label: str, v: BoolPtr) -> bool: ...
def checkbox_flags(label: str, flags: IntPtr, flags_value: int) -> bool: ...
# def checkbox_flags_int_ptr(label: str, flags: IntPtr, flags_value: int) -> bool: ...
# def checkbox_flags_uint_ptr(label: str, flags: IntPtr, flags_value: int) -> bool: ...
# def close_current_popup() -> None:
#     """
#     Manually close the popup we have begin-ed into.
#     """
#     pass

def collapsing_header(label: str, flags: int=0) -> bool:
    """
    If returning 'true' the header is open. doesn't indent nor push on id stack. user doesn't have to call treepop().
    """
    pass

def collapsing_header_bool_ptr(label: str, p_visible: BoolPtr, flags: int=0) -> bool:
    """
    When 'p_visible != null': if '*p_visible==true' display an additional small close button on upper right of the header which will set the bool to false when clicked, if '*p_visible==false' don't display the header.
    """
    pass

def color_button(desc_id: str, col: tuple, flags: int=0, size: tuple=(0, 0)) -> bool:
    """
    Display a color square/button, hover for details, return true when pressed.
    """
    pass

# def color_convert_float4_to_u32(in_: tuple) -> int: ...
def color_convert_hsv_to_rgb(h: float, s: float, value: float) -> tuple: ...
# def color_convert_rgb_to_hsv(r: float, g: float, b: float, out_h: FloatPtr, out_s: FloatPtr, out_v: FloatPtr) -> None: ...
# def color_convert_u32_to_float4(in_: int) -> tuple:
#     """
#     Color Utilities
#     """
#     pass

def color_edit3(label: str, colour: Vec4Ptr, flags: int=0) -> bool:
    """
    Widgets: Color Editor/Picker (tip: the ColorEdit* functions have a little color square that can be left-clicked to open a picker, and right-clicked to open an option menu.)
    - Note that in C++ a 'float v[X]' function argument is the _same_ as 'float* v', the array syntax is just a way to document the number of elements that are expected to be accessible.
    - You can pass the address of a first float element out of a contiguous structure, e.g. &myvector.x
    """
    pass

def color_edit4(label: str, colour: Vec4Ptr, flags: int=0) -> bool: ...
def color_picker3(label: str, colour: Vec4Ptr, flags: int=0) -> bool: ...
def color_picker4(label: str, colour: Vec4Ptr, flags: int=0, ref_col: Vec4Ptr=None) -> bool: ...
# def columns() -> None:
#     """
#     Legacy Columns API (prefer using Tables!)
#     - You can also use SameLine(pos_x) to mimic simplified columns.
#     Implied count = 1, id = null, border = true
#     """
#     pass

# def columns_ex(count: int=1, id_: str=None, border: bool=True) -> None: ...
def combo(label: str, current_item: IntPtr, items: Sequence[str], popup_max_height_in_items: int=-1) -> bool:
    """
    Separate items with \0 within a string, end item-list with \0\0. e.g. 'one\0two\0three\0'
    """
    pass

# def combo_callback(label: str, current_item: IntPtr, items_getter: Callable, data: Any, items_count: int) -> bool:
#     """
#     Implied popup_max_height_in_items = -1
#     """
#     pass

# def combo_callback_ex(label: str, current_item: IntPtr, items_getter: Callable, data: Any, items_count: int, popup_max_height_in_items: int=-1) -> bool: ...
# def combo_char(label: str, current_item: IntPtr, items: Any, items_count: int) -> bool:
#     """
#     Implied popup_max_height_in_items = -1
#     """
#     pass

# def combo_char_ex(label: str, current_item: IntPtr, items: Any, items_count: int, popup_max_height_in_items: int=-1) -> bool: ...
# def combo_ex(label: str, current_item: IntPtr, items_separated_by_zeros: str, popup_max_height_in_items: int=-1) -> bool:
#     """
#     Separate items with \0 within a string, end item-list with \0\0. e.g. 'one\0two\0three\0'
#     """
#     pass

def create_context(shared_font_atlas: ImFontAtlas=None) -> ImGuiContext:
    """
    Context creation and access
    - Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
    - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
    for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
    """
    pass

# def debug_check_version_and_data_layout(version_str: str, sz_io: Any, sz_style: Any, sz_vec2: Any, sz_vec4: Any, sz_drawvert: Any, sz_drawidx: Any) -> bool:
#     """
#     This is called by imgui_checkversion() macro.
#     """
#     pass

# def debug_text_encoding(text: str) -> None:
#     """
#     Debug Utilities
#     """
#     pass

def destroy_context(ctx: ImGuiContext=None) -> None:
    """
    Null = destroy current context
    """
    pass

# def destroy_platform_windows() -> None:
#     """
#     Call destroywindow platform functions for all viewports. call from backend shutdown() if you need to close platform windows before imgui shutdown. otherwise will be called by destroycontext().
#     """
#     pass

# def dock_space(id_: int) -> int:
#     """
#     Docking
#     [BETA API] Enable with io.ConfigFlags |= ImGuiConfigFlags_DockingEnable.
#     Note: You can use most Docking facilities without calling any API. You DO NOT need to call DockSpace() to use Docking!
#     - Drag from window title bar or their tab to dock/undock. Hold SHIFT to disable docking/undocking.
#     - Drag from window menu button (upper-left button) to undock an entire node (all windows).
#     - When io.ConfigDockingWithShift == true, you instead need to hold SHIFT to _enable_ docking/undocking.
#     About dockspaces:
#     - Use DockSpace() to create an explicit dock node _within_ an existing window. See Docking demo for details.
#     - Use DockSpaceOverViewport() to create an explicit dock node covering the screen or a specific viewport.
#     This is often used with ImGuiDockNodeFlags_PassthruCentralNode.
#     - Important: Dockspaces need to be submitted _before_ any window they can host. Submit it early in your frame!
#     - Important: Dockspaces need to be kept alive if hidden, otherwise windows docked into it will be undocked.
#     e.g. if you have multiple tabs with a dockspace inside each tab: submit the non-visible dockspaces with ImGuiDockNodeFlags_KeepAliveOnly.
#     Implied size = imvec2(0, 0), flags = 0, window_class = null
#     """
#     pass

# def dock_space_ex(id_: int, size: tuple=(0, 0), flags: int=0, window_class: ImGuiWindowClass=None) -> int: ...
# def dock_space_over_viewport() -> int:
#     """
#     Implied viewport = null, flags = 0, window_class = null
#     """
#     pass

# def dock_space_over_viewport_ex(viewport: ImGuiViewport=None, flags: int=0, window_class: ImGuiWindowClass=None) -> int: ...
def drag_float(label: str, v: FloatPtr, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool:
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
    pass

def drag_float2(label: str, float_ptrs: Sequence[FloatPtr], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    """
    pass

def drag_float3(label: str, float_ptrs: Sequence[FloatPtr], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    """
    pass

def drag_float4(label: str, float_ptrs: Sequence[FloatPtr], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    """
    pass

# def drag_float_range2(label: str, v_current_min: FloatPtr, v_current_max: FloatPtr) -> bool:
#     """
#     Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', format_max = null, flags = 0
#     """
#     pass

# def drag_float_range2_ex(label: str, v_current_min: FloatPtr, v_current_max: FloatPtr, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", format_max: str=None, flags: int=0) -> bool: ...
def drag_int(label: str, value: IntPtr, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool:
    """
    If v_min >= v_max we have no bound
    """
    pass

def drag_int2(label: str, int_ptrs: Sequence[IntPtr], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
def drag_int3(label: str, int_ptrs: Sequence[IntPtr], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
def drag_int4(label: str, int_ptrs: Sequence[IntPtr], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
# def drag_int_range2(label: str, v_current_min: IntPtr, v_current_max: IntPtr) -> bool:
#     """
#     Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = '%d', format_max = null, flags = 0
#     """
#     pass

# def drag_int_range2_ex(label: str, v_current_min: IntPtr, v_current_max: IntPtr, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", format_max: str=None, flags: int=0) -> bool: ...
# def drag_scalar(label: str, data_type: int, p_data: Any) -> bool:
#     """
#     Implied v_speed = 1.0f, p_min = null, p_max = null, format = null, flags = 0
#     """
#     pass

# def drag_scalar_ex(label: str, data_type: int, p_data: Any, v_speed: float=1.0, p_min: Any=None, p_max: Any=None, format_: str=None, flags: int=0) -> bool: ...
# def drag_scalar_n(label: str, data_type: int, p_data: Any, components: int) -> bool:
#     """
#     Implied v_speed = 1.0f, p_min = null, p_max = null, format = null, flags = 0
#     """
#     pass

# def drag_scalar_n_ex(label: str, data_type: int, p_data: Any, components: int, v_speed: float=1.0, p_min: Any=None, p_max: Any=None, format_: str=None, flags: int=0) -> bool: ...
def dummy(size: tuple) -> None:
    """
    Add a dummy item of given size. unlike invisiblebutton(), dummy() won't take the mouse click or be navigable into.
    """
    pass

def end() -> None: ...
def end_child() -> None: ...
# def end_child_frame() -> None:
#     """
#     Always call endchildframe() regardless of beginchildframe() return values (which indicates a collapsed/clipped window)
#     """
#     pass

def end_combo() -> None:
    """
    Only call endcombo() if begincombo() returns true!
    """
    pass

# def end_disabled() -> None: ...
def end_drag_drop_source() -> None:
    """
    Only call enddragdropsource() if begindragdropsource() returns true!
    """
    pass

def end_drag_drop_target() -> None:
    """
    Only call enddragdroptarget() if begindragdroptarget() returns true!
    """
    pass

# def end_frame() -> None:
#     """
#     Ends the dear imgui frame. automatically called by render(). if you don't need to render data (skipping rendering) you may call endframe() without render()... but you'll have wasted cpu already! if you don't need to render, better to not create any windows and not call newframe() at all!
#     """
#     pass

def end_group() -> None:
    """
    Unlock horizontal starting position + capture the whole group bounding box into one 'item' (so you can use isitemhovered() or layout primitives such as sameline() on whole group, etc.)
    """
    pass

def end_list_box() -> None:
    """
    Only call endlistbox() if beginlistbox() returned true!
    """
    pass

# def end_main_menu_bar() -> None:
#     """
#     Only call endmainmenubar() if beginmainmenubar() returns true!
#     """
#     pass

def end_menu() -> None:
    """
    Only call endmenu() if beginmenu() returns true!
    """
    pass

def end_menu_bar() -> None:
    """
    Only call endmenubar() if beginmenubar() returns true!
    """
    pass

def end_popup() -> None:
    """
    Only call endpopup() if beginpopupxxx() returns true!
    """
    pass

def end_tab_bar() -> None:
    """
    Only call endtabbar() if begintabbar() returns true!
    """
    pass

def end_tab_item() -> None:
    """
    Only call endtabitem() if begintabitem() returns true!
    """
    pass

def end_table() -> None:
    """
    Only call endtable() if begintable() returns true!
    """
    pass

def end_tooltip() -> None:
    """
    Only call endtooltip() if begintooltip() returns true!
    """
    pass

# def find_viewport_by_id(id_: int) -> ImGuiViewport:
#     """
#     This is a helper for backends.
#     """
#     pass

# def find_viewport_by_platform_handle(platform_handle: Any) -> ImGuiViewport:
#     """
#     This is a helper for backends. the type platform_handle is decided by the backend (e.g. hwnd, mywindow*, glfwwindow* etc.)
#     """
#     pass

# def get_allocator_functions(p_alloc_func: Callable, p_free_func: Callable, p_user_data: Any) -> None: ...
def get_background_draw_list() -> ImDrawList:
    """
    Background/Foreground Draw Lists
    Get background draw list for the viewport associated to the current window. this draw list will be the first rendering one. useful to quickly draw shapes/text behind dear imgui contents.
    """
    pass

# def get_background_draw_list_im_gui_viewport_ptr(viewport: ImGuiViewport) -> ImDrawList:
#     """
#     Get background draw list for the given viewport. this draw list will be the first rendering one. useful to quickly draw shapes/text behind dear imgui contents.
#     """
#     pass

# def get_clipboard_text() -> str:
#     """
#     Clipboard Utilities
#     - Also see the LogToClipboard() function to capture GUI into clipboard, or easily output text data to the clipboard.
#     """
#     pass

def get_color_u32(idx: int, alpha_mul: float=1.0) -> int:
    """
    Retrieve given style color with style alpha applied and optional extra alpha multiplier, packed as a 32-bit value suitable for imdrawlist
    """
    pass

def get_color_u32_im_u32(col: int) -> int:
    """
    Retrieve given color with style alpha applied, packed as a 32-bit value suitable for imdrawlist
    """
    pass

# def get_color_u32_im_vec4(col: tuple) -> int:
#     """
#     Retrieve given color with style alpha applied, packed as a 32-bit value suitable for imdrawlist
#     """
#     pass

# def get_column_index() -> int:
#     """
#     Get current column index
#     """
#     pass

# def get_column_offset(column_index: int=-1) -> float:
#     """
#     Get position of column line (in pixels, from the left side of the contents region). pass -1 to use current column, otherwise 0..getcolumnscount() inclusive. column 0 is typically 0.0f
#     """
#     pass

# def get_column_width(column_index: int=-1) -> float:
#     """
#     Get column width (in pixels). pass -1 to use current column
#     """
#     pass

# def get_columns_count() -> int: ...
def get_content_region_avail() -> tuple:
    """
    Content region
    - Retrieve available space from a given point. GetContentRegionAvail() is frequently useful.
    - Those functions are bound to be redesigned (they are confusing, incomplete and the Min/Max return values are in local window coordinates which increases confusion)
    == getcontentregionmax() - getcursorpos()
    """
    pass

# def get_content_region_max() -> tuple:
#     """
#     Current content boundaries (typically window boundaries including scrolling, or current column boundaries), in windows coordinates
#     """
#     pass

def get_current_context() -> ImGuiContext: ...
def get_cursor_pos() -> tuple:
    """
    Cursor position in window coordinates (relative to window position)
    """
    pass

# def get_cursor_pos_x() -> float:
#     """
#     (some functions are using window-relative coordinates, such as: getcursorpos, getcursorstartpos, getcontentregionmax, getwindowcontentregion* etc.
#     """
#     pass

# def get_cursor_pos_y() -> float:
#     """
#     Other functions such as getcursorscreenpos or everything in imdrawlist::
#     """
#     pass

def get_cursor_screen_pos() -> tuple:
    """
    Cursor position in absolute coordinates (useful to work with imdrawlist api). generally top-left == getmainviewport()->pos == (0,0) in single viewport mode, and bottom-right == getmainviewport()->pos+size == io.displaysize in single-viewport mode.
    """
    pass

# def get_cursor_start_pos() -> tuple:
#     """
#     Initial cursor position in window coordinates
#     """
#     pass

def get_drag_drop_payload() -> Tuple[str, Any]:
    """
    Peek directly into the current payload from anywhere. may return null. use imguipayload::isdatatype() to test for the payload type.
    """
    pass

def get_draw_data() -> ImDrawData:
    """
    Valid after render() and until the next call to newframe(). this is what you have to render.
    """
    pass

# def get_draw_list_shared_data() -> ImDrawListSharedData:
#     """
#     You may use this when creating your own imdrawlist instances.
#     """
#     pass

# def get_font() -> ImFont:
#     """
#     Style read access
#     - Use the ShowStyleEditor() function to interactively see/edit the colors.
#     Get current font
#     """
#     pass

def get_font_size() -> float:
    """
    Get current font size (= height in pixels) of current font with current scale applied
    """
    pass

# def get_font_tex_uv_white_pixel() -> tuple:
#     """
#     Get uv coordinate for a while pixel, useful to draw custom shapes via the imdrawlist api
#     """
#     pass

def get_foreground_draw_list() -> ImDrawList:
    """
    Get foreground draw list for the viewport associated to the current window. this draw list will be the last rendered one. useful to quickly draw shapes/text over dear imgui contents.
    """
    pass

# def get_foreground_draw_list_im_gui_viewport_ptr(viewport: ImGuiViewport) -> ImDrawList:
#     """
#     Get foreground draw list for the given viewport. this draw list will be the last rendered one. useful to quickly draw shapes/text over dear imgui contents.
#     """
#     pass

# def get_frame_count() -> int:
#     """
#     Get global imgui frame count. incremented by 1 every frame.
#     """
#     pass

def get_frame_height() -> float:
    """
    ~ fontsize + style.framepadding.y * 2
    """
    pass

def get_frame_height_with_spacing() -> float:
    """
    ~ fontsize + style.framepadding.y * 2 + style.itemspacing.y (distance in pixels between 2 consecutive lines of framed widgets)
    """
    pass

# def get_id(str_id: str) -> int:
#     """
#     Calculate unique id (hash of whole id stack + given parameter). e.g. if you want to query into imguistorage yourself
#     """
#     pass

# def get_id_ptr(ptr_id: Any) -> int: ...
# def get_id_str(str_id_begin: str, str_id_end: str) -> int: ...
def get_io() -> ImGuiIO:
    """
    Main
    Access the io structure (mouse/keyboard/gamepad inputs, time, various configuration options/flags)
    """
    pass

# def get_item_id() -> int:
#     """
#     Get id of last item (~~ often same imgui::getid(label) beforehand)
#     """
#     pass

def get_item_rect_max() -> tuple:
    """
    Get lower-right bounding rectangle of the last item (screen space)
    """
    pass

def get_item_rect_min() -> tuple:
    """
    Get upper-left bounding rectangle of the last item (screen space)
    """
    pass

def get_item_rect_size() -> tuple:
    """
    Get size of last item
    """
    pass

# def get_key_index(key: int) -> int: ...
# def get_key_name(key: int) -> str:
#     """
#     [debug] returns english name of the key. those names a provided for debugging purpose and are not meant to be saved persistently not compared.
#     """
#     pass

# def get_key_pressed_amount(key: int, repeat_delay: float, rate: float) -> int:
#     """
#     Uses provided repeat rate/delay. return a count, most often 0 or 1 but might be >1 if repeatrate is small enough that deltatime > repeatrate
#     """
#     pass

# def get_main_viewport() -> ImGuiViewport:
#     """
#     Viewports
#     - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
#     - In 'docking' branch with multi-viewport enabled, we extend this concept to have multiple active viewports.
#     - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
#     Return primary/default viewport. this can never be null.
#     """
#     pass

# def get_mouse_clicked_count(button: int) -> int:
#     """
#     Return the number of successive mouse-clicks at the time where a click happen (otherwise 0).
#     """
#     pass

# def get_mouse_cursor() -> int:
#     """
#     Get desired mouse cursor shape. important: reset in imgui::newframe(), this is updated during the frame. valid before render(). if you use software rendering by setting io.mousedrawcursor imgui will render those for you
#     """
#     pass

def get_mouse_drag_delta(button: int=0, lock_threshold: float=-1.0) -> tuple:
    """
    Return the delta from the initial clicking position while the mouse button is pressed or was just released. this is locked and return 0.0f until the mouse moves past a distance threshold at least once (if lock_threshold < -1.0f, uses io.mousedraggingthreshold)
    """
    pass

# def get_mouse_pos() -> tuple:
#     """
#     Shortcut to imgui::getio().mousepos provided by user, to be consistent with other calls
#     """
#     pass

# def get_mouse_pos_on_opening_current_popup() -> tuple:
#     """
#     Retrieve mouse position at the time of opening popup we have beginpopup() into (helper to avoid user backing that value themselves)
#     """
#     pass

def get_platform_io() -> ImGuiPlatformIO:
    """
    (Optional) Platform/OS interface for multi-viewport support
    Read comments around the ImGuiPlatformIO structure for more details.
    Note: You may use GetWindowViewport() to get the current viewport of the current window.
    Platform/renderer functions, for backend to setup + viewports list.
    """
    pass

# def get_scroll_max_x() -> float:
#     """
#     Get maximum scrolling amount ~~ contentsize.x - windowsize.x - decorationssize.x
#     """
#     pass

def get_scroll_max_y() -> float:
    """
    Get maximum scrolling amount ~~ contentsize.y - windowsize.y - decorationssize.y
    """
    pass

# def get_scroll_x() -> float:
#     """
#     Windows Scrolling
#     - Any change of Scroll will be applied at the beginning of next frame in the first call to Begin().
#     - You may instead use SetNextWindowScroll() prior to calling Begin() to avoid this delay, as an alternative to using SetScrollX()/SetScrollY().
#     Get scrolling amount [0 .. getscrollmaxx()]
#     """
#     pass

def get_scroll_y() -> float:
    """
    Get scrolling amount [0 .. getscrollmaxy()]
    """
    pass

# def get_state_storage() -> ImGuiStorage: ...
def get_style() -> ImGuiStyle:
    """
    Access the style structure (colors, sizes). always use pushstylecol(), pushstylevar() to modify style mid-frame!
    """
    pass

def get_style_color_name(idx: int) -> str:
    """
    Get a string corresponding to the enum value (for display, saving, etc.).
    """
    pass

def get_style_color_vec4(idx: int) -> ImVec4:
    """
    Retrieve style color as stored in imguistyle structure. use to feed back into pushstylecolor(), otherwise use getcoloru32() to get style color with style alpha baked in.
    """
    pass

def get_text_line_height() -> float:
    """
    ~ fontsize
    """
    pass

def get_text_line_height_with_spacing() -> float:
    """
    ~ fontsize + style.itemspacing.y (distance in pixels between 2 consecutive lines of text)
    """
    pass

def get_time() -> float:
    """
    Get global imgui time. incremented by io.deltatime every frame.
    """
    pass

def get_tree_node_to_label_spacing() -> float:
    """
    Horizontal distance preceding label when using treenode*() or bullet() == (g.fontsize + style.framepadding.x*2) for a regular unframed treenode
    """
    pass

def get_version() -> str:
    """
    Get the compiled version string e.g. '1.80 wip' (essentially the value for imgui_version from the compiled version of imgui.cpp)
    """
    pass

# def get_window_content_region_max() -> tuple:
#     """
#     Content boundaries max for the full window (roughly (0,0)+size-scroll) where size can be overridden with setnextwindowcontentsize(), in window coordinates
#     """
#     pass

# def get_window_content_region_min() -> tuple:
#     """
#     Content boundaries min for the full window (roughly (0,0)-scroll), in window coordinates
#     """
#     pass

# def get_window_dock_id() -> int: ...
# def get_window_dpi_scale() -> float:
#     """
#     Get dpi scale currently associated to the current window's viewport.
#     """
#     pass

def get_window_draw_list() -> ImDrawList:
    """
    Get draw list associated to the current window, to append your own drawing primitives
    """
    pass

# def get_window_height() -> float:
#     """
#     Get current window height (shortcut for getwindowsize().y)
#     """
#     pass

def get_window_pos() -> tuple:
    """
    Get current window position in screen space (useful if you want to do your own drawing via the drawlist api)
    """
    pass

def get_window_size() -> tuple:
    """
    Get current window size
    """
    pass

# def get_window_viewport() -> ImGuiViewport:
#     """
#     Get viewport currently associated to the current window.
#     """
#     pass

# def get_window_width() -> float:
#     """
#     Get current window width (shortcut for getwindowsize().x)
#     """
#     pass

# def im_vector_construct(vector: Any) -> None:
#     """
#     Construct a zero-size imvector<> (of any type). this is primarily useful when calling imfontglyphrangesbuilder_buildranges()
#     """
#     pass

# def im_vector_destruct(vector: Any) -> None:
#     """
#     Destruct an imvector<> (of any type). important: frees the vector memory but does not call destructors on contained objects (if they have them)
#     """
#     pass

def image(user_texture_id: int, size: tuple, uv0: tuple=(0, 0), uv1: tuple=(1, 1), tint_col: tuple=(1, 1, 1, 1), border_col: tuple=(0, 0, 0, 0)) -> None:
    """
    Widgets: Images
    - Read about ImTextureID here: https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples
    Implied uv0 = imvec2(0, 0), uv1 = imvec2(1, 1), tint_col = imvec4(1, 1, 1, 1), border_col = imvec4(0, 0, 0, 0)
    """
    pass

def image_button(str_id: str, user_texture_id: int, size: tuple, uv0: tuple=(0, 0), uv1: tuple=(1, 1), bg_col: tuple=(0, 0, 0, 0), tint_col: tuple=(1, 1, 1, 1)) -> bool:
    """
    Implied uv0 = imvec2(0, 0), uv1 = imvec2(1, 1), bg_col = imvec4(0, 0, 0, 0), tint_col = imvec4(1, 1, 1, 1)
    """
    pass

# def impl_glfw_char_callback(window: GLFWwindow, c: int) -> None: ...
# def impl_glfw_cursor_enter_callback(window: GLFWwindow, entered: int) -> None: ...
# def impl_glfw_cursor_pos_callback(window: GLFWwindow, x: float, y: float) -> None: ...
def impl_glfw_init_for_open_gl(window, install_callbacks: bool) -> bool: ...
# def impl_glfw_init_for_other(window: GLFWwindow, install_callbacks: bool) -> bool: ...
# def impl_glfw_init_for_vulkan(window: GLFWwindow, install_callbacks: bool) -> bool: ...
# def impl_glfw_install_callbacks(window: GLFWwindow) -> None: ...
# def impl_glfw_key_callback(window: GLFWwindow, key: int, scancode: int, action: int, mods: int) -> None: ...
# def impl_glfw_monitor_callback(monitor: GLFWmonitor, event: int) -> None: ...
# def impl_glfw_mouse_button_callback(window: GLFWwindow, button: int, action: int, mods: int) -> None: ...
def impl_glfw_new_frame() -> None: ...
# def impl_glfw_restore_callbacks(window: GLFWwindow) -> None: ...
# def impl_glfw_scroll_callback(window: GLFWwindow, xoffset: float, yoffset: float) -> None: ...
# def impl_glfw_set_callbacks_chain_for_all_windows(chain_for_all_windows: bool) -> None: ...
def impl_glfw_shutdown() -> None: ...
# def impl_glfw_window_focus_callback(window: GLFWwindow, focused: int) -> None: ...
# def impl_open_gl3_create_device_objects() -> bool: ...
# def impl_open_gl3_create_fonts_texture() -> bool: ...
# def impl_open_gl3_destroy_device_objects() -> None: ...
# def impl_open_gl3_destroy_fonts_texture() -> None: ...
def impl_open_gl3_init(glsl_version: str=None) -> bool: ...
def impl_open_gl3_new_frame() -> None: ...
def impl_open_gl3_render_draw_data(draw_data: ImDrawData) -> None: ...
def impl_open_gl3_shutdown() -> None: ...
def indent(indent_w: float=0.0) -> None:
    """
    Move content position toward the right, by indent_w, or style.indentspacing if indent_w <= 0
    """
    pass

def input_double(label: str, v: DoublePtr, step: float=0.0, step_fast: float=0.0, format_: str="%.6f", flags: int=0) -> bool: ...
def input_float(label: str, v: FloatPtr, step: float=0.0, step_fast: float=0.0, format_: str="%.3f", flags: int=0) -> bool: ...
def input_float2(label: str, float_ptrs: Sequence[FloatPtr], format_: str="%.3f", flags: int=0) -> bool: ...
def input_float3(label: str, float_ptrs: Sequence[FloatPtr], format_: str="%.3f", flags: int=0) -> bool: ...
def input_float4(label: str, float_ptrs: Sequence[FloatPtr], format_: str="%.3f", flags: int=0) -> bool: ...
def input_int(label: str, v: IntPtr) -> bool:
    """
    Implied step = 1, step_fast = 100, flags = 0
    """
    pass

def input_int2(label: str, int_ptrs: Sequence[IntPtr], flags: int=0) -> bool: ...
def input_int3(label: str, int_ptrs: Sequence[IntPtr], flags: int=0) -> bool: ...
def input_int4(label: str, int_ptrs: Sequence[IntPtr], flags: int=0) -> bool: ...
# def input_scalar(label: str, data_type: int, p_data: Any) -> bool:
#     """
#     Implied p_step = null, p_step_fast = null, format = null, flags = 0
#     """
#     pass

# def input_scalar_ex(label: str, data_type: int, p_data: Any, p_step: Any=None, p_step_fast: Any=None, format_: str=None, flags: int=0) -> bool: ...
# def input_scalar_n(label: str, data_type: int, p_data: Any, components: int) -> bool:
#     """
#     Implied p_step = null, p_step_fast = null, format = null, flags = 0
#     """
#     pass

# def input_scalar_n_ex(label: str, data_type: int, p_data: Any, components: int, p_step: Any=None, p_step_fast: Any=None, format_: str=None, flags: int=0) -> bool: ...
def input_text(label: str, buf: StrPtr, flags: int=0, callback: Callable[[ImGuiInputTextCallbackData, Any], int]=None, user_data: Any=None) -> bool:
    """
    Widgets: Input with Keyboard
    - If you want to use InputText() with std::string or any custom dynamic string type, see misc/cpp/imgui_stdlib.h and comments in imgui_demo.cpp.
    - Most of the ImGuiInputTextFlags flags are only useful for InputText() and not for InputFloatX, InputIntX, InputDouble etc.
    Implied callback = null, user_data = null
    """
    pass

# def input_text_multiline(label: str, buf: str, buf_size: Any) -> bool:
#     """
#     Implied size = imvec2(0, 0), flags = 0, callback = null, user_data = null
#     """
#     pass

# def input_text_multiline_ex(label: str, buf: str, buf_size: Any, size: tuple=(0, 0), flags: int=0, callback: Callable=None, user_data: Any=None) -> bool: ...
def input_text_with_hint(label: str, hint: str, buf: StrPtr, flags: int=0, callback: Callable=None, user_data: Any=None) -> bool:
    """
    Implied callback = null, user_data = null
    """
    pass

def invisible_button(str_id: str, size: tuple, flags: int=0) -> bool:
    """
    Flexible button behavior without the visuals, frequently useful to build custom behaviors using the public api (along with isitemactive, isitemhovered, etc.)
    """
    pass

# def is_any_item_active() -> bool:
#     """
#     Is any item active?
#     """
#     pass

# def is_any_item_focused() -> bool:
#     """
#     Is any item focused?
#     """
#     pass

# def is_any_item_hovered() -> bool:
#     """
#     Is any item hovered?
#     """
#     pass

# def is_any_mouse_down() -> bool:
#     """
#     [will obsolete] is any mouse button held? this was designed for backends, but prefer having backend maintain a mask of held mouse buttons, because upcoming input queue system will make this invalid.
#     """
#     pass

# def is_item_activated() -> bool:
#     """
#     Was the last item just made active (item was previously inactive).
#     """
#     pass

def is_item_active() -> bool:
    """
    Is the last item active? (e.g. button being held, text field being edited. this will continuously return true while holding mouse button on an item. items that don't interact will always return false)
    """
    pass

def is_item_clicked(mouse_button: int=0) -> bool:
    """
    Is the last item hovered and mouse clicked on? (**)  == ismouseclicked(mouse_button) && isitemhovered()important. (**) this is not equivalent to the behavior of e.g. button(). read comments in function definition.
    """
    pass

# def is_item_deactivated() -> bool:
#     """
#     Was the last item just made inactive (item was previously active). useful for undo/redo patterns with widgets that require continuous editing.
#     """
#     pass

# def is_item_deactivated_after_edit() -> bool:
#     """
#     Was the last item just made inactive and made a value change when it was active? (e.g. slider/drag moved). useful for undo/redo patterns with widgets that require continuous editing. note that you may get false positives (some widgets such as combo()/listbox()/selectable() will return true even when clicking an already selected item).
#     """
#     pass

# def is_item_edited() -> bool:
#     """
#     Did the last item modify its underlying value this frame? or was pressed? this is generally the same as the 'bool' return value of many widgets.
#     """
#     pass

# def is_item_focused() -> bool:
#     """
#     Is the last item focused for keyboard/gamepad navigation?
#     """
#     pass

def is_item_hovered(flags: int=0) -> bool:
    """
    Item/Widgets Utilities and Query Functions
    - Most of the functions are referring to the previous Item that has been submitted.
    - See Demo Window under "Widgets->Querying Status" for an interactive visualization of most of those functions.
    Is the last item hovered? (and usable, aka not blocked by a popup, etc.). see imguihoveredflags for more options.
    """
    pass

def is_item_toggled_open() -> bool:
    """
    Was the last item open state toggled? set by treenode().
    """
    pass

# def is_item_visible() -> bool:
#     """
#     Is the last item visible? (items may be out of sight because of clipping/scrolling)
#     """
#     pass

# def is_key_down(key: int) -> bool:
#     """
#     Inputs Utilities: Keyboard/Mouse/Gamepad
#     - the ImGuiKey enum contains all possible keyboard, mouse and gamepad inputs (e.g. ImGuiKey_A, ImGuiKey_MouseLeft, ImGuiKey_GamepadDpadUp...).
#     - before v1.87, we used ImGuiKey to carry native/user indices as defined by each backends. About use of those legacy ImGuiKey values:
#     - without IMGUI_DISABLE_OBSOLETE_KEYIO (legacy support): you can still use your legacy native/user indices (< 512) according to how your backend/engine stored them in io.KeysDown[], but need to cast them to ImGuiKey.
#     - withIMGUI_DISABLE_OBSOLETE_KEYIO (this is the way forward): any use of ImGuiKey will assert with key < 512. GetKeyIndex() is pass-through and therefore deprecated (gone if IMGUI_DISABLE_OBSOLETE_KEYIO is defined).
#     Is key being held.
#     """
#     pass

# def is_key_pressed(key: int) -> bool:
#     """
#     Implied repeat = true
#     """
#     pass

# def is_key_pressed_ex(key: int, repeat: bool=True) -> bool:
#     """
#     Was key pressed (went from !down to down)? if repeat=true, uses io.keyrepeatdelay / keyrepeatrate
#     """
#     pass

# def is_key_released(key: int) -> bool:
#     """
#     Was key released (went from down to !down)?
#     """
#     pass

def is_mouse_clicked(button: int, repeat: bool=False) -> bool:
    """
    Did mouse button clicked? (went from !down to down). same as getmouseclickedcount() == 1.
    """
    pass

def is_mouse_double_clicked(button: int) -> bool:
    """
    Did mouse button double-clicked? same as getmouseclickedcount() == 2. (note that a double-click will also report ismouseclicked() == true)
    """
    pass

def is_mouse_down(button: int) -> bool:
    """
    Inputs Utilities: Mouse specific
    - To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
    - You can also use regular integer: it is forever guaranteed that 0=Left, 1=Right, 2=Middle.
    - Dragging operations are only reported after mouse has moved a certain distance away from the initial clicking position (see 'lock_threshold' and 'io.MouseDraggingThreshold')
    Is mouse button held?
    """
    pass

def is_mouse_dragging(button: int, lock_threshold: float=-1.0) -> bool:
    """
    Is mouse dragging? (if lock_threshold < -1.0f, uses io.mousedraggingthreshold)
    """
    pass

# def is_mouse_hovering_rect(r_min: tuple, r_max: tuple) -> bool:
#     """
#     Implied clip = true
#     """
#     pass

# def is_mouse_hovering_rect_ex(r_min: tuple, r_max: tuple, clip: bool=True) -> bool:
#     """
#     Is mouse hovering given bounding rect (in screen space). clipped by current clipping settings, but disregarding of other consideration of focus/window ordering/popup-block.
#     """
#     pass

# def is_mouse_pos_valid(mouse_pos: ImVec2=None) -> bool:
#     """
#     By convention we use (-flt_max,-flt_max) to denote that there is no mouse available
#     """
#     pass

# def is_mouse_released(button: int) -> bool:
#     """
#     Did mouse button released? (went from down to !down)
#     """
#     pass

# def is_popup_open(str_id: str, flags: int=0) -> bool:
#     """
#     Popups: query functions
#     - IsPopupOpen(): return true if the popup is open at the current BeginPopup() level of the popup stack.
#     - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
#     - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
#     Return true if the popup is open.
#     """
#     pass

# def is_rect_visible(rect_min: tuple, rect_max: tuple) -> bool:
#     """
#     Test if rectangle (in screen space) is visible / not clipped. to perform coarse clipping on user's side.
#     """
#     pass

# def is_rect_visible_by_size(size: tuple) -> bool:
#     """
#     Miscellaneous Utilities
#     Test if rectangle (of given size, starting from cursor position) is visible / not clipped.
#     """
#     pass

# def is_window_appearing() -> bool:
#     """
#     Windows Utilities
#     - 'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.
#     """
#     pass

# def is_window_collapsed() -> bool: ...
# def is_window_docked() -> bool:
#     """
#     Is current window docked into another window?
#     """
#     pass

# def is_window_focused(flags: int=0) -> bool:
#     """
#     Is current window focused? or its root/child, depending on flags. see flags for options.
#     """
#     pass

# def is_window_hovered(flags: int=0) -> bool:
#     """
#     Is current window hovered (and typically: not blocked by a popup/modal)? see flags for options. nb: if you are trying to check whether your mouse should be dispatched to imgui or to your app, you should use the 'io.wantcapturemouse' boolean for that! please read the faq!
#     """
#     pass

def label_text(label: str, fmt: str) -> None:
    """
    Display text+label aligned the same way as value+label widgets
    """
    pass

# def label_text_v(label: str, fmt: str) -> None: ...
def list_box(label: str, current_item: IntPtr, items: Sequence[str], height_in_items: int=-1) -> bool: ...
# def list_box_callback(label: str, current_item: IntPtr, items_getter: Callable, data: Any, items_count: int) -> bool:
#     """
#     Implied height_in_items = -1
#     """
#     pass

# def list_box_callback_ex(label: str, current_item: IntPtr, items_getter: Callable, data: Any, items_count: int, height_in_items: int=-1) -> bool: ...
# def load_ini_settings_from_disk(ini_filename: str) -> None:
#     """
#     Settings/.Ini Utilities
#     - The disk functions are automatically called if io.IniFilename != NULL (default is "imgui.ini").
#     - Set io.IniFilename to NULL to load/save manually. Read io.WantSaveIniSettings description about handling .ini saving manually.
#     - Important: default value "imgui.ini" is relative to current working dir! Most apps will want to lock this to an absolute path (e.g. same path as executables).
#     Call after createcontext() and before the first call to newframe(). newframe() automatically calls loadinisettingsfromdisk(io.inifilename).
#     """
#     pass

# def load_ini_settings_from_memory(ini_data: str, ini_size: Any=0) -> None:
#     """
#     Call after createcontext() and before the first call to newframe() to provide .ini data from your own data source.
#     """
#     pass

# def log_buttons() -> None:
#     """
#     Helper to display buttons for logging to tty/file/clipboard
#     """
#     pass

def log_finish() -> None:
    """
    Stop logging (close file, etc.)
    """
    pass

# def log_text(fmt: str) -> None:
#     """
#     Pass text data straight to log (without being displayed)
#     """
#     pass

# def log_text_v(fmt: str) -> None: ...
def log_to_clipboard(auto_open_depth: int=-1) -> None:
    """
    Start logging to os clipboard
    """
    pass

# def log_to_file(auto_open_depth: int=-1, filename: str=None) -> None:
#     """
#     Start logging to file
#     """
#     pass

# def log_to_tty(auto_open_depth: int=-1) -> None:
#     """
#     Logging/Capture
#     - All text output from the interface can be captured into tty/file/clipboard. By default, tree nodes are automatically opened during logging.
#     Start logging to tty (stdout)
#     """
#     pass

# def mem_alloc(size: Any) -> Any: ...
# def mem_free(ptr: Any) -> None: ...
def menu_item(label: str, shortcut: str=None, selected: bool=False, enabled: bool=True) -> bool:
    """
    Return true when activated.
    """
    pass

def menu_item_bool_ptr(label: str, shortcut: str, p_selected: BoolPtr, enabled: bool=True) -> bool:
    """
    Return true when activated + toggle (*p_selected) if p_selected != null
    """
    pass

def new_frame() -> None:
    """
    Start a new dear imgui frame, you can submit any command from this point until render()/endframe().
    """
    pass

def new_line() -> None:
    """
    Undo a sameline() or force a new line when in a horizontal-layout context.
    """
    pass

# def next_column() -> None:
#     """
#     Next column, defaults to current row or next row if the current row is finished
#     """
#     pass

def open_popup(str_id: str, popup_flags: int=0) -> None:
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
    pass

# def open_popup_id(id_: int, popup_flags: int=0) -> None:
#     """
#     Id overload to facilitate calling from nested stacks
#     """
#     pass

def open_popup_on_item_click(str_id: str=None, popup_flags: int=1) -> None:
    """
    Helper to open popup when clicked on last item. default to imguipopupflags_mousebuttonright == 1. (note: actually triggers on the mouse _released_ event to be consistent with popup behaviors)
    """
    pass

def plot_histogram(label: str, values: Sequence[float], values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0), stride: int=sizeof(float)) -> None:
    """
    Implied values_offset = 0, overlay_text = null, scale_min = flt_max, scale_max = flt_max, graph_size = imvec2(0, 0), stride = sizeof(float)
    """
    pass

# def plot_histogram_callback(label: str, values_getter: Callable, data: Any, values_count: int) -> None:
#     """
#     Implied values_offset = 0, overlay_text = null, scale_min = flt_max, scale_max = flt_max, graph_size = imvec2(0, 0)
#     """
#     pass

# def plot_histogram_callback_ex(label: str, values_getter: Callable, data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)) -> None: ...
# def plot_histogram_ex(label: str, values: FloatPtr, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0), stride: int=sizeof(float)) -> None: ...
def plot_lines(label: str, values: Sequence[float], values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)) -> None:
    """
    Widgets: Data Plotting
    - Consider using ImPlot (https://github.com/epezent/implot) which is much better!
    Implied stride = sizeof(float)
    - Pygui note: stride has been omitted because we are instead passing in a list.
    the underlying c_float array is handled by Cython.
    """
    pass

# def plot_lines_callback(label: str, values_getter: Callable, data: Any, values_count: int) -> None:
#     """
#     Implied values_offset = 0, overlay_text = null, scale_min = flt_max, scale_max = flt_max, graph_size = imvec2(0, 0)
#     """
#     pass

# def plot_lines_callback_ex(label: str, values_getter: Callable, data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)) -> None: ...
def pop_button_repeat() -> None: ...
# def pop_clip_rect() -> None: ...
# def pop_font() -> None: ...
def pop_id() -> None:
    """
    Pop from the id stack.
    """
    pass

def pop_item_width() -> None: ...
def pop_style_color(count: int=1) -> None:
    """
    Implied count = 1
    """
    pass

def pop_style_var(count: int=1) -> None:
    """
    Implied count = 1
    """
    pass

# def pop_tab_stop() -> None: ...
def pop_text_wrap_pos() -> None: ...
def progress_bar(fraction: float, size_arg: tuple=(-FLT_MIN, 0), overlay: str=None) -> None: ...
def push_button_repeat(repeat: bool) -> None:
    """
    In 'repeat' mode, button*() functions return repeated true in a typematic manner (using io.keyrepeatdelay/io.keyrepeatrate setting). note that you can call isitemactive() after any button() to tell if the button is held in the current frame.
    """
    pass

def push_clip_rect(clip_rect_min: tuple, clip_rect_max: tuple, intersect_with_current_clip_rect: bool) -> None:
    """
    Clipping
    - Mouse hovering is affected by ImGui::PushClipRect() calls, unlike direct calls to ImDrawList::PushClipRect() which are render only.
    """
    pass

# def push_font(font: ImFont) -> None:
#     """
#     Parameters stacks (shared)
#     Use null as a shortcut to push default font
#     """
#     pass

def push_id(str_id: str) -> None:
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
    """
    pass

def push_id_int(int_id: int) -> None:
    """
    Push integer into the id stack (will hash integer).
    """
    pass

# def push_id_ptr(ptr_id: Any) -> None:
#     """
#     Push pointer into the id stack (will hash pointer).
#     """
#     pass

def push_id_str(str_id_begin: str, str_id_end: str) -> None:
    """
    Push string into the id stack (will hash string).
    """
    pass

def push_item_width(item_width: float) -> None:
    """
    Parameters stacks (current window)
    Push width of items for common large 'item+label' widgets. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -flt_min always align width to the right side).
    """
    pass

def push_style_color(idx: int, col: int) -> None:
    """
    Modify a style color. always use this if you modify the style after newframe().
    """
    pass

def push_style_color_im_vec4(idx: int, col: tuple) -> None: ...
def push_style_var(idx: int, val: float) -> None:
    """
    Modify a style float variable. always use this if you modify the style after newframe().
    """
    pass

def push_style_var_im_vec2(idx: int, val: tuple) -> None:
    """
    Modify a style imvec2 variable. always use this if you modify the style after newframe().
    """
    pass

# def push_tab_stop(tab_stop: bool) -> None:
#     """
#     == tab stop enable. allow focusing using tab/shift-tab, enabled by default but you can disable it for certain widgets
#     """
#     pass

def push_text_wrap_pos(wrap_local_pos_x: float=0.0) -> None:
    """
    Push word-wrapping position for text*() commands. < 0.0f: no wrapping; 0.0f: wrap to end of window (or column); > 0.0f: wrap at 'wrap_pos_x' position in window local space
    """
    pass

def radio_button(label: str, active: bool) -> bool:
    """
    Use with e.g. if (radiobutton('one', my_value==1)) { my_value = 1; }
    """
    pass

def radio_button_int_ptr(label: str, v: IntPtr, v_button: int) -> bool:
    """
    Shortcut to handle the above pattern when value is an integer
    """
    pass

def render() -> None:
    """
    Ends the dear imgui frame, finalize the draw data. you can then get call getdrawdata().
    """
    pass

def render_platform_windows_default(platform_render_arg: Any=None, renderer_render_arg: Any=None) -> None:
    """
    Call in main loop. will call renderwindow/swapbuffers platform functions for each secondary viewport which doesn't have the imguiviewportflags_minimized flag set. may be reimplemented by user for custom rendering needs.
    """
    pass

# def reset_mouse_drag_delta() -> None:
#     """
#     Implied button = 0
#     """
#     pass

# def reset_mouse_drag_delta_ex(button: int=0) -> None:
#     """

#     """
#     pass

def same_line(offset_from_start_x: float=0.0, spacing: float=-1.0) -> None:
    """
    Call between widgets or groups to layout them horizontally. x position given in window coordinates.
    """
    pass

# def save_ini_settings_to_disk(ini_filename: str) -> None:
#     """
#     This is automatically called (if io.inifilename is not empty) a few seconds after any modification that should be reflected in the .ini file (and also by destroycontext).
#     """
#     pass

# def save_ini_settings_to_memory(out_ini_size: Any=None) -> str:
#     """
#     Return a zero-terminated string with the .ini data which you can save by your own mean. call when io.wantsaveinisettings is set, then save data by your own mean and clear io.wantsaveinisettings.
#     """
#     pass

def selectable(label: str, selected: bool=False, flags: int=0, size: tuple=(0, 0)) -> bool:
    """
    Widgets: Selectables
    - A selectable highlights when hovered, and can display another color when selected.
    - Neighbors selectable extend their highlight bounds in order to leave no gap between them. This is so a series of selected Selectable appear contiguous.
    Implied selected = false, flags = 0, size = imvec2(0, 0)
    'bool selected' carry the selection state (read-only). selectable() is clicked is returns true so you can modify your selection state. size.x==0.0: use remaining width, size.x>0.0: specify width. size.y==0.0: use label height, size.y>0.0: specify height
    """
    pass

def selectable_bool_ptr(label: str, p_selected: BoolPtr, flags: int=0, size: tuple=(0, 0)) -> bool:
    """
    'bool* p_selected' point to the selection state (read-write), as a convenient helper.
    """
    pass

def separator() -> None:
    """
    Cursor / Layout
    - By "cursor" we mean the current output position.
    - The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
    - You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
    - Attention! We currently have inconsistencies between window-local and absolute positions we will aim to fix with future API:
    Window-local coordinates:   SameLine(), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), GetContentRegionMax(), GetWindowContentRegion*(), PushTextWrapPos()
    Absolute coordinate:GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions.
    Separator, generally horizontal. inside a menu bar or in horizontal layout mode, this becomes a vertical separator.
    """
    pass

def separator_text(label: str) -> None:
    """
    Currently: formatted text with an horizontal line
    """
    pass

# def set_allocator_functions(alloc_func: Callable, free_func: Callable, user_data: Any=None) -> None:
#     """
#     Memory Allocators
#     - Those functions are not reliant on the current context.
#     - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
#     for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for more details.

#     Pygui note: see create_context(). This is where the allocator functions are set for ImGui.
#     """
#     pass

# def set_clipboard_text(text: str) -> None: ...
def set_color_edit_options(flags: int) -> None:
    """
    Initialize current options (generally on application startup) if you want to select a default format, picker type, etc. user will be able to change many settings, unless you pass the _nooptions flag to your calls.
    """
    pass

# def set_column_offset(column_index: int, offset_x: float) -> None:
#     """
#     Set position of column line (in pixels, from the left side of the contents region). pass -1 to use current column
#     """
#     pass

# def set_column_width(column_index: int, width: float) -> None:
#     """
#     Set column width (in pixels). pass -1 to use current column
#     """
#     pass

# def set_current_context(ctx: ImGuiContext) -> None: ...
# def set_cursor_pos(local_pos: tuple) -> None:
#     """
#     Are using the main, absolute coordinate system.
#     """
#     pass

# def set_cursor_pos_x(local_x: float) -> None:
#     """
#     Getwindowpos() + getcursorpos() == getcursorscreenpos() etc.)
#     """
#     pass

# def set_cursor_pos_y(local_y: float) -> None:
#     """

#     """
#     pass

# def set_cursor_screen_pos(pos: tuple) -> None:
#     """
#     Cursor position in absolute coordinates
#     """
#     pass

def set_drag_drop_payload(type_: str, data: Any, cond: int=0) -> bool:
    """
    Type is a user defined string of maximum 32 characters. strings starting with '_' are reserved for dear imgui internal types. data is copied and held by imgui. return true when payload has been accepted.
    """
    pass

def set_item_allow_overlap() -> None:
    """
    Allow last item to be overlapped by a subsequent item. sometimes useful with invisible buttons, selectables, etc. to catch unused area.
    """
    pass

def set_item_default_focus() -> None:
    """
    Focus, Activation
    - Prefer using "SetItemDefaultFocus()" over "if (IsWindowAppearing()) SetScrollHereY()" when applicable to signify "this is the default item"
    Make last item the default focused item of a window.
    """
    pass

def set_keyboard_focus_here(offset: int=0) -> None:
    """
    Focus keyboard on the next widget. use positive 'offset' to access sub components of a multiple component widget. use -1 to access previous widget.
    """
    pass

# def set_mouse_cursor(cursor_type: int) -> None:
#     """
#     Set desired mouse cursor shape
#     """
#     pass

# def set_next_frame_want_capture_keyboard(want_capture_keyboard: bool) -> None:
#     """
#     Override io.wantcapturekeyboard flag next frame (said flag is left for your application to handle, typically when true it instructs your app to ignore inputs). e.g. force capture keyboard when your widget is being hovered. this is equivalent to setting 'io.wantcapturekeyboard = want_capture_keyboard'; after the next newframe() call.
#     """
#     pass

# def set_next_frame_want_capture_mouse(want_capture_mouse: bool) -> None:
#     """
#     Override io.wantcapturemouse flag next frame (said flag is left for your application to handle, typical when true it instucts your app to ignore inputs). this is equivalent to setting 'io.wantcapturemouse = want_capture_mouse;' after the next newframe() call.
#     """
#     pass

def set_next_item_open(is_open: bool, cond: int=0) -> None:
    """
    Set next treenode/collapsingheader open state.
    """
    pass

def set_next_item_width(item_width: float) -> None:
    """
    Set width of the _next_ common large 'item+label' widget. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -flt_min always align width to the right side)
    """
    pass

# def set_next_window_bg_alpha(alpha: float) -> None:
#     """
#     Set next window background color alpha. helper to easily override the alpha component of imguicol_windowbg/childbg/popupbg. you may also use imguiwindowflags_nobackground.
#     """
#     pass

# def set_next_window_class(window_class: ImGuiWindowClass) -> None:
#     """
#     Set next window class (control docking compatibility + provide hints to platform backend via custom viewport flags and platform parent/child relationship)
#     """
#     pass

# def set_next_window_collapsed(collapsed: bool, cond: int=0) -> None:
#     """
#     Set next window collapsed state. call before begin()
#     """
#     pass

# def set_next_window_content_size(size: tuple) -> None:
#     """
#     Set next window content size (~ scrollable client area, which enforce the range of scrollbars). not including window decorations (title bar, menu bar, etc.) nor windowpadding. set an axis to 0.0f to leave it automatic. call before begin()
#     """
#     pass

# def set_next_window_dock_id(dock_id: int, cond: int=0) -> None:
#     """
#     Set next window dock id
#     """
#     pass

# def set_next_window_focus() -> None:
#     """
#     Set next window to be focused / top-most. call before begin()
#     """
#     pass

# def set_next_window_pos(pos: tuple, cond: int=0) -> None:
#     """
#     Window manipulation
#     - Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
#     Implied pivot = imvec2(0, 0)
#     """
#     pass

# def set_next_window_pos_ex(pos: tuple, cond: int=0, pivot: tuple=(0, 0)) -> None:
#     """
#     Set next window position. call before begin(). use pivot=(0.5f,0.5f) to center on given point, etc.
#     """
#     pass

# def set_next_window_scroll(scroll: tuple) -> None:
#     """
#     Set next window scrolling value (use < 0.0f to not affect a given axis).
#     """
#     pass

def set_next_window_size(size: tuple, cond: int=0) -> None:
    """
    Set next window size. set axis to 0.0f to force an auto-fit on this axis. call before begin()
    """
    pass

# def set_next_window_size_constraints(size_min: tuple, size_max: tuple, custom_callback: Callable=None, custom_callback_data: Any=None) -> None:
#     """
#     Set next window size limits. use -1,-1 on either x/y axis to preserve the current size. sizes will be rounded down. use callback to apply non-trivial programmatic constraints.
#     """
#     pass

# def set_next_window_viewport(viewport_id: int) -> None:
#     """
#     Set next window viewport
#     """
#     pass

# def set_scroll_from_pos_x(local_x: float, center_x_ratio: float=0.5) -> None:
#     """
#     Adjust scrolling amount to make given position visible. generally getcursorstartpos() + offset to compute a valid position.
#     """
#     pass

# def set_scroll_from_pos_y(local_y: float, center_y_ratio: float=0.5) -> None:
#     """
#     Adjust scrolling amount to make given position visible. generally getcursorstartpos() + offset to compute a valid position.
#     """
#     pass

# def set_scroll_here_x(center_x_ratio: float=0.5) -> None:
#     """
#     Adjust scrolling amount to make current cursor position visible. center_x_ratio=0.0: left, 0.5: center, 1.0: right. when using to make a 'default/current item' visible, consider using setitemdefaultfocus() instead.
#     """
#     pass

def set_scroll_here_y(center_y_ratio: float=0.5) -> None:
    """
    Adjust scrolling amount to make current cursor position visible. center_y_ratio=0.0: top, 0.5: center, 1.0: bottom. when using to make a 'default/current item' visible, consider using setitemdefaultfocus() instead.
    """
    pass

# def set_scroll_x(scroll_x: float) -> None:
#     """
#     Set scrolling amount [0 .. getscrollmaxx()]
#     """
#     pass

# def set_scroll_y(scroll_y: float) -> None:
#     """
#     Set scrolling amount [0 .. getscrollmaxy()]
#     """
#     pass

# def set_state_storage(storage: ImGuiStorage) -> None:
#     """
#     Replace current window storage with our own (if you want to manipulate it yourself, typically clear subsection of it)
#     """
#     pass

# def set_tab_item_closed(tab_or_docked_window_label: str) -> None:
#     """
#     Notify tabbar or docking system of a closed tab/window ahead (useful to reduce visual flicker on reorderable tab bars). for tab-bar: call after begintabbar() and before tab submissions. otherwise call with a window name.
#     """
#     pass

def set_tooltip(fmt: str) -> None:
    """
    Set a text-only tooltip, typically use with imgui::isitemhovered(). override any previous call to settooltip().
    """
    pass

# def set_tooltip_v(fmt: str) -> None: ...
# def set_window_collapsed(collapsed: bool, cond: int=0) -> None:
#     """
#     (not recommended) set current window collapsed state. prefer using setnextwindowcollapsed().
#     """
#     pass

# def set_window_collapsed_str(name: str, collapsed: bool, cond: int=0) -> None:
#     """
#     Set named window collapsed state
#     """
#     pass

# def set_window_focus() -> None:
#     """
#     (not recommended) set current window to be focused / top-most. prefer using setnextwindowfocus().
#     """
#     pass

# def set_window_focus_str(name: str) -> None:
#     """
#     Set named window to be focused / top-most. use null to remove focus.
#     """
#     pass

# def set_window_font_scale(scale: float) -> None:
#     """
#     [obsolete] set font scale. adjust io.fontglobalscale if you want to scale all windows. this is an old api! for correct scaling, prefer to reload font + rebuild imfontatlas + call style.scaleallsizes().
#     """
#     pass

# def set_window_pos(pos: tuple, cond: int=0) -> None:
#     """
#     (not recommended) set current window position - call within begin()/end(). prefer using setnextwindowpos(), as this may incur tearing and side-effects.
#     """
#     pass

# def set_window_pos_str(name: str, pos: tuple, cond: int=0) -> None:
#     """
#     Set named window position.
#     """
#     pass

# def set_window_size(size: tuple, cond: int=0) -> None:
#     """
#     (not recommended) set current window size - call within begin()/end(). set to imvec2(0, 0) to force an auto-fit. prefer using setnextwindowsize(), as this may incur tearing and minor side-effects.
#     """
#     pass

# def set_window_size_str(name: str, size: tuple, cond: int=0) -> None:
#     """
#     Set named window size. set axis to 0.0f to force an auto-fit on this axis.
#     """
#     pass

def show_about_window(p_open: BoolPtr=None) -> None:
    """
    Create about window. display dear imgui version, credits and build/system information.
    """
    pass

# def show_debug_log_window(p_open: BoolPtr=None) -> None:
#     """
#     Create debug log window. display a simplified log of important dear imgui events.
#     """
#     pass

def show_demo_window(p_open: BoolPtr=None) -> None:
    """
    Demo, Debug, Information
    Create demo window. demonstrate most imgui features. call this to learn about the library! try to make it always available in your application!
    """
    pass

# def show_font_selector(label: str) -> None:
#     """
#     Add font selector block (not a window), essentially a combo listing the loaded fonts.
#     """
#     pass

# def show_metrics_window(p_open: BoolPtr=None) -> None:
#     """
#     Create metrics/debugger window. display dear imgui internals: windows, draw commands, various internal state, etc.
#     """
#     pass

# def show_stack_tool_window(p_open: BoolPtr=None) -> None:
#     """
#     Create stack tool window. hover items with mouse to query information about the source of their unique id.
#     """
#     pass

# def show_style_editor(ref: ImGuiStyle=None) -> None:
#     """
#     Add style editor block (not a window). you can pass in a reference imguistyle structure to compare to, revert to and save to (else it uses the default style)
#     """
#     pass

# def show_style_selector(label: str) -> bool:
#     """
#     Add style selector block (not a window), essentially a combo listing the default styles.
#     """
#     pass

def show_user_guide() -> None:
    """
    Add basic help/info block (not a window): how to manipulate imgui as an end-user (mouse/keyboard controls).
    """
    pass

def slider_angle(label: str, v_rad: FloatPtr, v_degrees_min: float=-360.0, v_degrees_max: float=+360.0, format_: str="%.0f deg", flags: int=0) -> bool:
    """
    Implied v_degrees_min = -360.0f, v_degrees_max = +360.0f, format = '%.0f deg', flags = 0
    """
    pass

def slider_float(label: str, value: FloatPtr, v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool:
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
    pass

def slider_float2(label: str, float_ptrs: Sequence[FloatPtr], v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied format = '%.3f', flags = 0
    """
    pass

def slider_float3(label: str, float_ptrs: Sequence[FloatPtr], v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied format = '%.3f', flags = 0
    """
    pass

def slider_float4(label: str, float_ptrs: Sequence[FloatPtr], v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied format = '%.3f', flags = 0
    """
    pass

def slider_int(label: str, value: IntPtr, v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool:
    """
    Implied format = '%d', flags = 0
    """
    pass

def slider_int2(label: str, int_ptrs: Sequence[IntPtr], v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool:
    """
    Implied format = '%d', flags = 0
    """
    pass

def slider_int3(label: str, int_ptrs: Sequence[IntPtr], v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool:
    """
    Implied format = '%d', flags = 0
    """
    pass

def slider_int4(label: str, int_ptrs: Sequence[IntPtr], v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool:
    """
    Implied format = '%d', flags = 0
    """
    pass

# def slider_scalar(label: str, data_type: int, p_data: Any, p_min: Any, p_max: Any) -> bool:
#     """
#     Implied format = null, flags = 0
#     """
#     pass

# def slider_scalar_ex(label: str, data_type: int, p_data: Any, p_min: Any, p_max: Any, format_: str=None, flags: int=0) -> bool: ...
# def slider_scalar_n(label: str, data_type: int, p_data: Any, components: int, p_min: Any, p_max: Any) -> bool:
#     """
#     Implied format = null, flags = 0
#     """
#     pass

# def slider_scalar_n_ex(label: str, data_type: int, p_data: Any, components: int, p_min: Any, p_max: Any, format_: str=None, flags: int=0) -> bool: ...
def small_button(label: str) -> bool:
    """
    Button with framepadding=(0,0) to easily embed within text
    """
    pass

def spacing() -> None:
    """
    Add vertical spacing.
    """
    pass

def style_colors_classic(dst: ImGuiStyle=None) -> None:
    """
    Classic imgui style
    """
    pass

def style_colors_dark(dst: ImGuiStyle=None) -> None:
    """
    Styles
    New, recommended style (default)
    """
    pass

def style_colors_light(dst: ImGuiStyle=None) -> None:
    """
    Best used with borders and a custom, thicker font
    """
    pass

# def tab_item_button(label: str, flags: int=0) -> bool:
#     """
#     Create a tab behaving like a button. return true when clicked. cannot be selected in the tab bar.
#     """
#     pass

# def table_get_column_count() -> int:
#     """
#     Return number of columns (value passed to begintable)
#     """
#     pass

# def table_get_column_flags(column_n: int=-1) -> int:
#     """
#     Return column flags so you can query their enabled/visible/sorted/hovered status flags. pass -1 to use current column.
#     """
#     pass

# def table_get_column_index() -> int:
#     """
#     Return current column index.
#     """
#     pass

# def table_get_column_name(column_n: int=-1) -> str:
#     """
#     Return '' if column didn't have a name declared by tablesetupcolumn(). pass -1 to use current column.
#     """
#     pass

# def table_get_row_index() -> int:
#     """
#     Return current row index.
#     """
#     pass

def table_get_sort_specs() -> ImGuiTableSortSpecs:
    """
    Tables: Sorting & Miscellaneous functions
    - Sorting: call TableGetSortSpecs() to retrieve latest sort specs for the table. NULL when not sorting.
    When 'sort_specs->SpecsDirty == true' you should sort your data. It will be true when sorting specs have
    changed since last call, or the first time. Make sure to set 'SpecsDirty = false' after sorting,
    else you may wastefully sort your data every frame!
    - Functions args 'int column_n' treat the default value of -1 as the same as passing the current column index.
    Get latest sort specs for the table (null if not sorting).  lifetime: don't hold on this pointer over multiple frames or past any subsequent call to begintable().
    """
    pass

# def table_header(label: str) -> None:
#     """
#     Submit one header cell manually (rarely used)
#     """
#     pass

def table_headers_row() -> None:
    """
    Submit all headers cells based on data provided to tablesetupcolumn() + submit context menu
    """
    pass

def table_next_column() -> bool:
    """
    Append into the next column (or first column of next row if currently in last column). return true when column is visible.
    """
    pass

def table_next_row(row_flags: int=0, min_row_height: float=0.0) -> None:
    """
    Append into the first cell of a new row.
    """
    pass

# def table_set_bg_color(target: int, color: int, column_n: int=-1) -> None:
#     """
#     Change the color of a cell, row, or column. see imguitablebgtarget_ flags for details.
#     """
#     pass

# def table_set_column_enabled(column_n: int, v: bool) -> None:
#     """
#     Change user accessible enabled/disabled state of a column. set to false to hide the column. user can use the context menu to change this themselves (right-click in headers, or right-click in columns body with imguitableflags_contextmenuinbody)
#     """
#     pass

def table_set_column_index(column_n: int) -> bool:
    """
    Append into the specified column. return true when column is visible.
    """
    pass

def table_setup_column(label: str, flags: int=0, init_width_or_weight: float=0.0, user_id: int=0) -> None:
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
    pass

def table_setup_scroll_freeze(cols: int, rows: int) -> None:
    """
    Lock columns/rows so they stay visible when scrolled.
    """
    pass

def text(fmt: str) -> None:
    """
    Formatted text
    """
    pass

def text_colored(col: tuple, fmt: str) -> None:
    """
    Shortcut for pushstylecolor(imguicol_text, col); text(fmt, ...); popstylecolor();
    """
    pass

# def text_colored_v(col: tuple, fmt: str) -> None: ...
def text_disabled(fmt: str) -> None:
    """
    Shortcut for pushstylecolor(imguicol_text, style.colors[imguicol_textdisabled]); text(fmt, ...); popstylecolor();
    """
    pass

# def text_disabled_v(fmt: str) -> None: ...
def text_unformatted(text: str, text_end: str=None) -> None:
    """
    Raw text without formatting. roughly equivalent to text('%s', text) but: a) doesn't require null terminated string if 'text_end' is specified, b) it's faster, no memory copy is done, no buffer size limits, recommended for long chunks of text.
    """
    pass

# def text_v(fmt: str) -> None: ...
def text_wrapped(fmt: str) -> None:
    """
    Shortcut for pushtextwrappos(0.0f); text(fmt, ...); poptextwrappos();. note that this won't work on an auto-resizing window if there's no other widgets to extend the window width, yoy may need to set a size using setnextwindowsize().
    """
    pass

# def text_wrapped_v(fmt: str) -> None: ...
def tree_node(label: str, flags: int=0) -> bool:
    """
    Widgets: Trees
    - TreeNode functions return true when the node is open, in which case you need to also call TreePop() when you are finished displaying the tree node contents.
    """
    pass

# def tree_node_ex_ptr(ptr_id: Any, flags: int, fmt: str) -> bool: ...
# def tree_node_ex_str(str_id: str, flags: int, fmt: str) -> bool: ...
# def tree_node_ex_v(str_id: str, flags: int, fmt: str) -> bool: ...
# def tree_node_ex_vptr(ptr_id: Any, flags: int, fmt: str) -> bool: ...
# def tree_node_ptr(ptr_id: Any, fmt: str) -> bool:
#     """
#     '
#     """
#     pass

# def tree_node_str(str_id: str, fmt: str) -> bool:
#     """
#     Helper variation to easily decorelate the id from the displayed string. read the faq about why and how to use id. to align arbitrary text at the same level as a treenode() you can use bullet().
#     """
#     pass

# def tree_node_v(str_id: str, fmt: str) -> bool: ...
# def tree_node_vptr(ptr_id: Any, fmt: str) -> bool: ...
def tree_pop() -> None:
    """
    ~ unindent()+popid()
    """
    pass

# def tree_push(str_id: str) -> None:
#     """
#     ~ indent()+pushid(). already called by treenode() when returning true, but you can call treepush/treepop yourself if desired.
#     """
#     pass

# def tree_push_ptr(ptr_id: Any) -> None:
#     """
#     '
#     """
#     pass

def unindent(indent_w: float=0.0) -> None:
    """
    Move content position back to the left, by indent_w, or style.indentspacing if indent_w <= 0
    """
    pass

def update_platform_windows() -> None:
    """
    Call in main loop. will call createwindow/resizewindow/etc. platform functions for each secondary viewport, and destroywindow for each inactive viewport.
    """
    pass

# def vslider_float(label: str, size: tuple, v: FloatPtr, v_min: float, v_max: float) -> bool:
#     """
#     Implied format = '%.3f', flags = 0
#     """
#     pass

# def vslider_float_ex(label: str, size: tuple, v: FloatPtr, v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool: ...
# def vslider_int(label: str, size: tuple, v: IntPtr, v_min: int, v_max: int) -> bool:
#     """
#     Implied format = '%d', flags = 0
#     """
#     pass

# def vslider_int_ex(label: str, size: tuple, v: IntPtr, v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool: ...
# def vslider_scalar(label: str, size: tuple, data_type: int, p_data: Any, p_min: Any, p_max: Any) -> bool:
#     """
#     Implied format = null, flags = 0
#     """
#     pass

# def vslider_scalar_ex(label: str, size: tuple, data_type: int, p_data: Any, p_min: Any, p_max: Any, format_: str=None, flags: int=0) -> bool: ...

class GLFWmonitor: ...

class GLFWwindow: ...

class ImColor:
    """
    Helper: ImColor() implicitly converts colors to either ImU32 (packed 4x1 byte) or ImVec4 (4x1 float)
    Prefer using IM_COL32() macros if you want a guaranteed compile-time ImU32 for usage with ImDrawList API.
    **Avoid storing ImColor! Store either u32 of ImVec4. This is not a full-featured color class. MAY OBSOLETE.
    **None of the ImGui API are using ImColor directly but you can use it as a convenience to pass colors in either ImU32 or ImVec4 formats. Explicitly cast to ImU32 or ImVec4 if needed.
    """
    pass
    # value: tuple
    # def hsv(self: ImColor, h: float, s: float, v: float, a: float=1.0) -> ImColor: ...
    # def set_hsv(self: ImColor, h: float, s: float, v: float, a: float=1.0) -> None:
    #     """
    #     FIXME-OBSOLETE: May need to obsolete/cleanup those helpers.
    #     """
    #     pass


class ImDrawChannel:
    """
    [Internal] For use by ImDrawListSplitter
    """
    pass
    # cmd_buffer: ImVector_ImDrawCmd
    # idx_buffer: ImVector_ImDrawIdx

class ImDrawCmd:
    """
    Typically, 1 command = 1 GPU draw call (unless command is a callback)
    - VtxOffset: When 'io.BackendFlags & ImGuiBackendFlags_RendererHasVtxOffset' is enabled,
    this fields allow us to render meshes larger than 64K vertices while keeping 16-bit indices.
    Backends made for <1.71. will typically ignore the VtxOffset fields.
    - The ClipRect/TextureId/VtxOffset fields must be contiguous as we memcmp() them together (this is asserted for).
    """
    clip_rect: tuple
    """
    4*4  // clipping rectangle (x1, y1, x2, y2). subtract imdrawdata->displaypos to get clipping rectangle in 'viewport' coordinates
    """
    elem_count: int
    """
    4// number of indices (multiple of 3) to be rendered as triangles. vertices are stored in the callee imdrawlist's vtx_buffer[] array, indices in idx_buffer[].
    """
    # idx_offset: int
    # """
    # 4// start offset in index buffer.
    # """
    texture_id: object
    """
    4-8  // user-provided texture id. set by user in imfontatlas::settexid() for fonts or passed to image*() functions. ignore if never using images or multiple fonts atlas.
    """
    # user_callback: Callable
    # """
    # 4-8  // if != null, call the function instead of rendering the vertices. clip_rect and texture_id will be set normally.
    # """
    # user_callback_data: Any
    # """
    # 4-8  // the draw callback code can access this.
    # """
    # vtx_offset: int
    # """
    # 4// start offset in vertex buffer. imguibackendflags_rendererhasvtxoffset: always 0, otherwise may be >0 to support meshes larger than 64k vertices with 16-bit indices.
    # """
    # def get_tex_id(self: ImDrawCmd) -> Any:
    #     """
    #     Since 1.83: returns ImTextureID associated with this draw call. Warning: DO NOT assume this is always same as 'TextureId' (we will change this function for an upcoming feature)
    #     """
    #     pass


class ImDrawCmdHeader:
    """
    [Internal] For use by ImDrawList
    """
    clip_rect: tuple
    # texture_id: Any
    # vtx_offset: int

class ImDrawData:
    """
    All draw data to render a Dear ImGui frame
    (NB: the style and the naming convention here is a little inconsistent, we currently preserve them for backward compatibility purpose,
    as this is one of the oldest structure exposed by the library! Basically, ImDrawList == CmdList)
    """
    cmd_lists: List[ImDrawList]
    """
    Array of imdrawlist* to render. the imdrawlist are owned by imguicontext and only pointed to from here.
    """
    # cmd_lists_count: int
    # """
    # Number of imdrawlist* to render
    # """
    # display_pos: tuple
    # """
    # Top-left position of the viewport to render (== top-left of the orthogonal projection matrix to use) (== getmainviewport()->pos for the main viewport, == (0.0) in most single-viewport applications)
    # """
    # display_size: tuple
    # """
    # Size of the viewport to render (== getmainviewport()->size for the main viewport, == io.displaysize in most single-viewport applications)
    # """
    # framebuffer_scale: tuple
    # """
    # Amount of pixels for each unit of displaysize. based on io.displayframebufferscale. generally (1,1) on normal display, (2,2) on osx with retina display.
    # """
    # owner_viewport: ImGuiViewport
    # """
    # Viewport carrying the imdrawdata instance, might be of use to the renderer (generally not).
    # """
    # total_idx_count: int
    # """
    # For convenience, sum of all imdrawlist's idxbuffer.size
    # """
    # total_vtx_count: int
    # """
    # For convenience, sum of all imdrawlist's vtxbuffer.size
    # """
    # valid: bool
    # """
    # Only valid after render() is called and before the next newframe() is called.
    # """
    # def clear(self: ImDrawData) -> None:
    #     """
    #     The imdrawlist are owned by imguicontext!
    #     """
    #     pass

    # def de_index_all_buffers(self: ImDrawData) -> None:
    #     """
    #     Helper to convert all buffers from indexed to non-indexed, in case you cannot render indexed. note: this is slow and most likely a waste of resources. always prefer indexed rendering!
    #     """
    #     pass

    def scale_clip_rects(self: ImDrawData, fb_scale: tuple) -> None:
        """
        Helper to scale the cliprect field of each imdrawcmd. use if your final output buffer is at a different scale than dear imgui expects, or if there is a difference between your window resolution and framebuffer resolution.
        """
        pass


class ImDrawList:
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
    # clip_rect_stack: ImVector_ImVec4
    # """
    # [internal]
    # """
    cmd_buffer: List[ImDrawCmd]
    """
    This is what you have to render
    Draw commands. typically 1 command = 1 gpu draw call, unless the command is a callback.
    """
    # cmd_header: ImDrawCmdHeader
    # """
    # [internal] template of active commands. fields should match those of cmdbuffer.back().
    # """
    # data: ImDrawListSharedData
    # """
    # Pointer to shared draw data (you can use imgui::getdrawlistshareddata() to get the one from current imgui context)
    # """
    # flags: int
    # """
    # Flags, you may poke into these to adjust anti-aliasing settings per-primitive.
    # """
    # fringe_scale: float
    # """
    # [internal] anti-alias fringe is scaled by this value, this helps to keep things sharp while zooming at vertex buffer content
    # """
    idx_buffer: ImVector_ImDrawIdx
    """
    Index buffer. each command consume imdrawcmd::elemcount of those
    """
    # idx_write_ptr: int
    # """
    # [internal] point within idxbuffer.data after each add command (to avoid using the imvector<> operators too much)
    # """
    # owner_name: str
    # """
    # Pointer to owner window's name for debugging
    # """
    # path: ImVector_ImVec2
    # """
    # [internal] current path building
    # """
    # splitter: ImDrawListSplitter
    # """
    # [internal] for channels api (note: prefer using your own persistent instance of imdrawlistsplitter!)
    # """
    # texture_id_stack: ImVector_ImTextureID
    # """
    # [internal]
    # """
    vtx_buffer: ImVector_ImDrawVert
    """
    Vertex buffer.
    """
    # vtx_current_idx: int
    # """
    # [Internal, used while building lists]
    # [internal] generally == vtxbuffer.size unless we are past 64k vertices, in which case this gets reset to 0.
    # """
    # vtx_write_ptr: ImDrawVert
    # """
    # [internal] point within vtxbuffer.data after each add command (to avoid using the imvector<> operators too much)
    # """
    def add_bezier_cubic(self: ImDrawList, p1: tuple, p2: tuple, p3: tuple, p4: tuple, col: int, thickness: float, num_segments: int=0) -> None:
        """
        Cubic bezier (4 control points)
        """
        pass

    def add_bezier_quadratic(self: ImDrawList, p1: tuple, p2: tuple, p3: tuple, col: int, thickness: float, num_segments: int=0) -> None:
        """
        Quadratic bezier (3 control points)
        """
        pass

    # def add_callback(self: ImDrawList, callback: Callable, callback_data: Any) -> None:
    #     """
    #     Advanced
    #     Your rendering function must check for 'usercallback' in imdrawcmd and call the function instead of rendering triangles.
    #     """
    #     pass

    def add_circle(self: ImDrawList, center: tuple, radius: float, col: int, num_segments: int=0, thickness: float=1.0) -> None: ...
    def add_circle_filled(self: ImDrawList, center: tuple, radius: float, col: int, num_segments: int=0) -> None: ...
    # def add_convex_poly_filled(self: ImDrawList, points: ImVec2, num_points: int, col: int) -> None: ...
    # def add_draw_cmd(self: ImDrawList) -> None:
    #     """
    #     This is useful if you need to forcefully create a new draw call (to allow for dependent rendering / blending). otherwise primitives are merged into the same draw-call as much as possible
    #     """
    #     pass

    # def add_image(self: ImDrawList, user_texture_id: Any, p_min: tuple, p_max: tuple) -> None:
    #     """
    #     Image primitives
    #     - Read FAQ to understand what ImTextureID is.
    #     - "p_min" and "p_max" represent the upper-left and lower-right corners of the rectangle.
    #     - "uv_min" and "uv_max" represent the normalized texture coordinates to use for those corners. Using (0,0)->(1,1) texture coordinates will generally display the entire texture.
    #     Implied uv_min = imvec2(0, 0), uv_max = imvec2(1, 1), col = im_col32_white
    #     """
    #     pass

    # def add_image_ex(self: ImDrawList, user_texture_id: Any, p_min: tuple, p_max: tuple, uv_min: tuple=(0, 0), uv_max: tuple=(1, 1), col: int=IM_COL32_WHITE) -> None: ...
    # def add_image_quad(self: ImDrawList, user_texture_id: Any, p1: tuple, p2: tuple, p3: tuple, p4: tuple) -> None:
    #     """
    #     Implied uv1 = imvec2(0, 0), uv2 = imvec2(1, 0), uv3 = imvec2(1, 1), uv4 = imvec2(0, 1), col = im_col32_white
    #     """
    #     pass

    # def add_image_quad_ex(self: ImDrawList, user_texture_id: Any, p1: tuple, p2: tuple, p3: tuple, p4: tuple, uv1: tuple=(0, 0), uv2: tuple=(1, 0), uv3: tuple=(1, 1), uv4: tuple=(0, 1), col: int=IM_COL32_WHITE) -> None: ...
    # def add_image_rounded(self: ImDrawList, user_texture_id: Any, p_min: tuple, p_max: tuple, uv_min: tuple, uv_max: tuple, col: int, rounding: float, flags: int=0) -> None: ...
    def add_line(self: ImDrawList, p1: tuple, p2: tuple, col: int, thickness: float=1.0) -> None:
        """
        Primitives
        - Filled shapes must always use clockwise winding order. The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
        - For rectangular primitives, "p_min" and "p_max" represent the upper-left and lower-right corners.
        - For circle primitives, use "num_segments == 0" to automatically calculate tessellation (preferred).
        In older versions (until Dear ImGui 1.77) the AddCircle functions defaulted to num_segments == 12.
        In future versions we will use textures to provide cheaper and higher-quality circles.
        Use AddNgon() and AddNgonFilled() functions if you need to guarantee a specific number of sides.
        """
        pass

    def add_ngon(self: ImDrawList, center: tuple, radius: float, col: int, num_segments: int, thickness: float=1.0) -> None: ...
    def add_ngon_filled(self: ImDrawList, center: tuple, radius: float, col: int, num_segments: int) -> None: ...
    # def add_polyline(self: ImDrawList, points: ImVec2, num_points: int, col: int, flags: int, thickness: float) -> None: ...
    # def add_quad(self: ImDrawList, p1: tuple, p2: tuple, p3: tuple, p4: tuple, col: int) -> None:
    #     """
    #     Implied thickness = 1.0f
    #     """
    #     pass

    # def add_quad_ex(self: ImDrawList, p1: tuple, p2: tuple, p3: tuple, p4: tuple, col: int, thickness: float=1.0) -> None: ...
    # def add_quad_filled(self: ImDrawList, p1: tuple, p2: tuple, p3: tuple, p4: tuple, col: int) -> None: ...
    def add_rect(self: ImDrawList, p_min: tuple, p_max: tuple, col: int, rounding: float=0.0, flags: int=0, thickness: float=1.0) -> None:
        """
        A: upper-left, b: lower-right (== upper-left + size)
        """
        pass

    def add_rect_filled(self: ImDrawList, p_min: tuple, p_max: tuple, col: int, rounding: float=0.0, flags: int=0) -> None:
        """
        A: upper-left, b: lower-right (== upper-left + size)
        """
        pass

    def add_rect_filled_multi_color(self: ImDrawList, p_min: tuple, p_max: tuple, col_upr_left: int, col_upr_right: int, col_bot_right: int, col_bot_left: int) -> None: ...
    # def add_text(self: ImDrawList, pos: tuple, col: int, text_begin: str) -> None:
    #     """
    #     Implied text_end = null
    #     """
    #     pass

    # def add_text_ex(self: ImDrawList, pos: tuple, col: int, text_begin: str, text_end: str=None) -> None: ...
    # def add_text_im_font_ptr(self: ImDrawList, font: ImFont, font_size: float, pos: tuple, col: int, text_begin: str) -> None:
    #     """
    #     Implied text_end = null, wrap_width = 0.0f, cpu_fine_clip_rect = null
    #     """
    #     pass

    # def add_text_im_font_ptr_ex(self: ImDrawList, font: ImFont, font_size: float, pos: tuple, col: int, text_begin: str, text_end: str=None, wrap_width: float=0.0, cpu_fine_clip_rect: ImVec4=None) -> None: ...
    def add_triangle(self: ImDrawList, p1: tuple, p2: tuple, p3: tuple, col: int, thickness: float=1.0) -> None: ...
    def add_triangle_filled(self: ImDrawList, p1: tuple, p2: tuple, p3: tuple, col: int) -> None: ...
    # def calc_circle_auto_segment_count(self: ImDrawList, radius: float) -> int: ...
    def channels_merge(self: ImDrawList) -> None: ...
    def channels_set_current(self: ImDrawList, n: int) -> None: ...
    def channels_split(self: ImDrawList, count: int) -> None:
        """
        Advanced: Channels
        - Use to split render into layers. By switching channels to can render out-of-order (e.g. submit FG primitives before BG primitives)
        - Use to minimize draw calls (e.g. if going back-and-forth between multiple clipping rectangles, prefer to append into separate channels then merge at the end)
        - FIXME-OBSOLETE: This API shouldn't have been in ImDrawList in the first place!
        Prefer using your own persistent instance of ImDrawListSplitter as you can stack them.
        Using the ImDrawList::ChannelsXXXX you cannot stack a split over another.
        """
        pass

    # def clear_free_memory(self: ImDrawList) -> None: ...
    # def clone_output(self: ImDrawList) -> ImDrawList:
    #     """
    #     Create a clone of the cmdbuffer/idxbuffer/vtxbuffer.
    #     """
    #     pass

    # def get_clip_rect_max(self: ImDrawList) -> tuple: ...
    # def get_clip_rect_min(self: ImDrawList) -> tuple: ...
    # def on_changed_clip_rect(self: ImDrawList) -> None: ...
    # def on_changed_texture_id(self: ImDrawList) -> None: ...
    # def on_changed_vtx_offset(self: ImDrawList) -> None: ...
    # def path_arc_to(self: ImDrawList, center: tuple, radius: float, a_min: float, a_max: float, num_segments: int=0) -> None: ...
    # def path_arc_to_fast(self: ImDrawList, center: tuple, radius: float, a_min_of_12: int, a_max_of_12: int) -> None:
    #     """
    #     Use precomputed angles for a 12 steps circle
    #     """
    #     pass

    # def path_arc_to_fast_ex(self: ImDrawList, center: tuple, radius: float, a_min_sample: int, a_max_sample: int, a_step: int) -> None: ...
    # def path_arc_to_n(self: ImDrawList, center: tuple, radius: float, a_min: float, a_max: float, num_segments: int) -> None: ...
    # def path_bezier_cubic_curve_to(self: ImDrawList, p2: tuple, p3: tuple, p4: tuple, num_segments: int=0) -> None:
    #     """
    #     Cubic bezier (4 control points)
    #     """
    #     pass

    # def path_bezier_quadratic_curve_to(self: ImDrawList, p2: tuple, p3: tuple, num_segments: int=0) -> None:
    #     """
    #     Quadratic bezier (3 control points)
    #     """
    #     pass

    # def path_clear(self: ImDrawList) -> None:
    #     """
    #     Stateful path API, add points then finish with PathFillConvex() or PathStroke()
    #     - Filled shapes must always use clockwise winding order. The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
    #     """
    #     pass

    # def path_fill_convex(self: ImDrawList, col: int) -> None: ...
    # def path_line_to(self: ImDrawList, pos: tuple) -> None: ...
    # def path_line_to_merge_duplicate(self: ImDrawList, pos: tuple) -> None: ...
    # def path_rect(self: ImDrawList, rect_min: tuple, rect_max: tuple, rounding: float=0.0, flags: int=0) -> None: ...
    # def path_stroke(self: ImDrawList, col: int, flags: int=0, thickness: float=1.0) -> None: ...
    def pop_clip_rect(self: ImDrawList) -> None: ...
    # def pop_texture_id(self: ImDrawList) -> None: ...
    # def pop_unused_draw_cmd(self: ImDrawList) -> None: ...
    # def prim_quad_uv(self: ImDrawList, a: tuple, b: tuple, c: tuple, d: tuple, uv_a: tuple, uv_b: tuple, uv_c: tuple, uv_d: tuple, col: int) -> None: ...
    # def prim_rect(self: ImDrawList, a: tuple, b: tuple, col: int) -> None:
    #     """
    #     Axis aligned rectangle (composed of two triangles)
    #     """
    #     pass

    # def prim_rect_uv(self: ImDrawList, a: tuple, b: tuple, uv_a: tuple, uv_b: tuple, col: int) -> None: ...
    # def prim_reserve(self: ImDrawList, idx_count: int, vtx_count: int) -> None:
    #     """
    #     Advanced: Primitives allocations
    #     - We render triangles (three vertices)
    #     - All primitives needs to be reserved via PrimReserve() beforehand.
    #     """
    #     pass

    # def prim_unreserve(self: ImDrawList, idx_count: int, vtx_count: int) -> None: ...
    # def prim_vtx(self: ImDrawList, pos: tuple, uv: tuple, col: int) -> None:
    #     """
    #     Write vertex with unique index
    #     """
    #     pass

    # def prim_write_idx(self: ImDrawList, idx: int) -> None: ...
    # def prim_write_vtx(self: ImDrawList, pos: tuple, uv: tuple, col: int) -> None: ...
    def push_clip_rect(self: ImDrawList, clip_rect_min: tuple, clip_rect_max: tuple, intersect_with_current_clip_rect: bool=False) -> None:
        """
        Render-level scissoring. this is passed down to your render function but not used for cpu-side coarse clipping. prefer using higher-level imgui::pushcliprect() to affect logic (hit-testing and widget culling)
        """
        pass

    # def push_clip_rect_full_screen(self: ImDrawList) -> None: ...
    # def push_texture_id(self: ImDrawList, texture_id: Any) -> None: ...
    # def reset_for_new_frame(self: ImDrawList) -> None:
    #     """
    #     [Internal helpers]
    #     """
    #     pass

    # def try_merge_draw_cmds(self: ImDrawList) -> None: ...

class ImDrawListSharedData:
    """
    Data shared among multiple draw lists (typically owned by parent imgui context, but you may create one yourself)
    """
    pass

class ImDrawListSplitter:
    """
    Split/Merge functions are used to split the draw list into different layers which can be drawn into out of order.
    This is used by the Columns/Tables API, so items of each column can be batched together in a same draw call.
    """
    pass
    # channels: ImVector_ImDrawChannel
    # """
    # Draw channels (not resized down so _count might be < channels.size)
    # """
    # count: int
    # """
    # Number of active channels (1+)
    # """
    # current: int
    # """
    # Current channel number (0)
    # """
    # def clear(self: ImDrawListSplitter) -> None:
    #     """
    #     Do not clear channels[] so our allocations are reused next frame
    #     """
    #     pass

    # def clear_free_memory(self: ImDrawListSplitter) -> None: ...
    # def merge(self: ImDrawListSplitter, draw_list: ImDrawList) -> None: ...
    # def set_current_channel(self: ImDrawListSplitter, draw_list: ImDrawList, channel_idx: int) -> None: ...
    # def split(self: ImDrawListSplitter, draw_list: ImDrawList, count: int) -> None: ...

class ImDrawVert: ...
    # col: int
    # pos: tuple
    # uv: tuple

class ImFont:
    """
    Font runtime data and rendering
    ImFontAtlas automatically loads a default embedded font for you when you call GetTexDataAsAlpha8() or GetTexDataAsRGBA32().
    """
    pass
    # ascent: float
    # """
    # 4+4   // out //// ascent: distance from top to bottom of e.g. 'a' [0..fontsize]
    # """
    # config_data: ImFontConfig
    # """
    # 4-8   // in  //// pointer within containeratlas->configdata
    # """
    # config_data_count: int
    # """
    # 2 // in  // ~ 1// number of imfontconfig involved in creating this font. bigger than 1 when merging multiple font sources into one imfont.
    # """
    # container_atlas: ImFontAtlas
    # """
    # Members: Cold ~32/40 bytes
    # 4-8   // out //// what we has been loaded into
    # """
    # descent: float
    # """
    # 4+4   // out //// ascent: distance from top to bottom of e.g. 'a' [0..fontsize]
    # """
    # dirty_lookup_tables: bool
    # """
    # 1 // out //
    # """
    # ellipsis_char: int
    # """
    # 2 // out // = '...'/'.'// character used for ellipsis rendering.
    # """
    # ellipsis_char_count: int
    # """
    # 1 // out // 1 or 3
    # """
    # ellipsis_char_step: float
    # """
    # 4 // out   // step between characters when ellipsiscount > 0
    # """
    # ellipsis_width: float
    # """
    # 4 // out   // width
    # """
    # fallback_advance_x: float
    # """
    # 4 // out // = fallbackglyph->advancex
    # """
    # fallback_char: int
    # """
    # 2 // out // = fffd/'?' // character used if a glyph isn't found.
    # """
    # fallback_glyph: ImFontGlyph
    # """
    # 4-8   // out // = findglyph(fontfallbackchar)
    # """
    # font_size: float
    # """
    # 4 // in  //// height of characters/line, set during loading (don't change after loading)
    # """
    # glyphs: ImVector_ImFontGlyph
    # """
    # 12-16 // out //// all glyphs.
    # """
    # index_advance_x: ImVector_float
    # """
    # Members: Hot ~20/24 bytes (for CalcTextSize)
    # 12-16 // out //// sparse. glyphs->advancex in a directly indexable way (cache-friendly for calctextsize functions which only this this info, and are often bottleneck in large ui).
    # """
    # index_lookup: ImVector_ImWchar
    # """
    # Members: Hot ~28/40 bytes (for CalcTextSize + render loop)
    # 12-16 // out //// sparse. index glyphs by unicode code-point.
    # """
    # metrics_total_surface: int
    # """
    # 4 // out //// total surface in pixels to get an idea of the font rasterization/texture cost (not exact, we approximate the cost of padding between glyphs)
    # """
    # scale: float
    # """
    # 4 // in  // = 1.f  // base font scale, multiplied by the per-window font scale which you can adjust with setwindowfontscale()
    # """
    # used4k_pages_map: int
    # """
    # 2 bytes if imwchar=imwchar16, 34 bytes if imwchar==imwchar32. store 1-bit for each block of 4k codepoints that has one active glyph. this is mainly used to facilitate iterations across all used codepoints.
    # """
    # def add_glyph(self: ImFont, src_cfg: ImFontConfig, c: int, x0: float, y0: float, x1: float, y1: float, u0: float, v0: float, u1: float, v1: float, advance_x: float) -> None: ...
    # def add_remap_char(self: ImFont, dst: int, src: int, overwrite_dst: bool=True) -> None:
    #     """
    #     Makes 'dst' character/glyph points to 'src' character/glyph. currently needs to be called after fonts have been built.
    #     """
    #     pass

    # def build_lookup_table(self: ImFont) -> None:
    #     """
    #     [Internal] Don't use!
    #     """
    #     pass

    # def calc_text_size_a(self: ImFont, size: float, max_width: float, wrap_width: float, text_begin: str) -> tuple:
    #     """
    #     'max_width' stops rendering after a certain width (could be turned into a 2d size). FLT_MAX to disable.
    #     'wrap_width' enable automatic word-wrapping across multiple lines to fit into given width. 0.0f to disable.
    #     Implied text_end = null, remaining = null
    #     """
    #     pass

    # def calc_text_size_a_ex(self: ImFont, size: float, max_width: float, wrap_width: float, text_begin: str, text_end: str=None, remaining: Any=None) -> tuple:
    #     """
    #     Utf8
    #     """
    #     pass

    # def calc_word_wrap_position_a(self: ImFont, scale: float, text: str, text_end: str, wrap_width: float) -> str: ...
    # def clear_output_data(self: ImFont) -> None: ...
    # def find_glyph(self: ImFont, c: int) -> ImFontGlyph: ...
    # def find_glyph_no_fallback(self: ImFont, c: int) -> ImFontGlyph: ...
    # def get_char_advance(self: ImFont, c: int) -> float: ...
    # def get_debug_name(self: ImFont) -> str: ...
    # def grow_index(self: ImFont, new_size: int) -> None: ...
    # def is_glyph_range_unused(self: ImFont, c_begin: int, c_last: int) -> bool: ...
    # def is_loaded(self: ImFont) -> bool: ...
    # def render_char(self: ImFont, draw_list: ImDrawList, size: float, pos: tuple, col: int, c: int) -> None: ...
    # def render_text(self: ImFont, draw_list: ImDrawList, size: float, pos: tuple, col: int, clip_rect: tuple, text_begin: str, text_end: str, wrap_width: float=0.0, cpu_fine_clip: bool=False) -> None: ...
    # def set_glyph_visible(self: ImFont, c: int, visible: bool) -> None: ...

class ImFontAtlas:
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
    # config_data: ImVector_ImFontConfig
    # """
    # Configuration data
    # """
    # custom_rects: ImVector_ImFontAtlasCustomRect
    # """
    # Rectangles for packing custom texture data into the atlas.
    # """
    # flags: int
    # """
    # Build flags (see imfontatlasflags_)
    # """
    # font_builder_flags: int
    # """
    # Shared flags (for all fonts) for custom font builder. this is build implementation dependent. per-font override is also available in imfontconfig.
    # """
    # font_builder_io: ImFontBuilderIO
    # """
    # [Internal] Font builder
    # Opaque interface to a font builder (default to stb_truetype, can be changed to use freetype by defining imgui_enable_freetype).
    # """
    # fonts: ImVector_ImFontPtr
    # """
    # Hold all the fonts returned by addfont*. fonts[0] is the default font upon calling imgui::newframe(), use imgui::pushfont()/popfont() to change the current font.
    # """
    # locked: bool
    # """
    # Marked as locked by imgui::newframe() so attempt to modify the atlas will assert.
    # """
    # pack_id_lines: int
    # """
    # Custom texture rectangle id for baked anti-aliased lines
    # """
    # pack_id_mouse_cursors: int
    # """
    # [Internal] Packing data
    # Custom texture rectangle id for white pixel and mouse cursors
    # """
    # tex_desired_width: int
    # """
    # Texture width desired by user before build(). must be a power-of-two. if have many glyphs your graphics api have texture size restrictions you may want to increase texture width to decrease height.
    # """
    # tex_glyph_padding: int
    # """
    # Padding between glyphs within texture in pixels. defaults to 1. if your rendering method doesn't rely on bilinear filtering you may set this to 0 (will also need to set antialiasedlinesusetex = false).
    # """
    tex_height: int
    """
    Texture height calculated during build().
    """
    tex_id: int
    """
    User data to refer to the texture once it has been uploaded to user's graphic systems. it is passed back to you during rendering via the imdrawcmd structure.
    """
    # tex_pixels_alpha8: str
    # """
    # 1 component per pixel, each component is unsigned 8-bit. total size = texwidth * texheight
    # """
    # tex_pixels_rgba_32: IntPtr
    # """
    # 4 component per pixel, each component is unsigned 8-bit. total size = texwidth * texheight * 4
    # """
    # tex_pixels_use_colors: bool
    # """
    # Tell whether our texture data is known to use colors (rather than just alpha channel), in order to help backend select a format.
    # """
    # tex_ready: bool
    # """
    # [Internal]
    # NB: Access texture data via GetTexData*() calls! Which will setup a default font for you.
    # Set when texture was built matching current font input
    # """
    # tex_uv_lines: tuple
    # """
    # Uvs for baked anti-aliased lines
    # """
    # tex_uv_scale: tuple
    # """
    # = (1.0f/texwidth, 1.0f/texheight)
    # """
    # tex_uv_white_pixel: tuple
    # """
    # Texture coordinates to a white pixel
    # """
    tex_width: int
    """
    Texture width calculated during build().
    """
    # user_data: Any
    # """
    # Store your own atlas related user-data (if e.g. you have multiple font atlas).
    # """
    # def add_custom_rect_font_glyph(self: ImFontAtlas, font: ImFont, id_: int, width: int, height: int, advance_x: float, offset: tuple=(0, 0)) -> int: ...
    # def add_custom_rect_regular(self: ImFontAtlas, width: int, height: int) -> int:
    #     """
    #     You can request arbitrary rectangles to be packed into the atlas, for your own purposes.
    #     - After calling Build(), you can query the rectangle position and render your pixels.
    #     - If you render colored output, set 'atlas->TexPixelsUseColors = true' as this may help some backends decide of prefered texture format.
    #     - You can also request your rectangles to be mapped as font glyph (given a font + Unicode point),
    #     so you can render e.g. custom colorful icons and use them as regular glyphs.
    #     - Read docs/FONTS.md for more details about using colorful icons.
    #     - Note: this API may be redesigned later in order to support multi-monitor varying DPI settings.
    #     """
    #     pass

    # def add_font(self: ImFontAtlas, font_cfg: ImFontConfig) -> ImFont: ...
    # def add_font_default(self: ImFontAtlas, font_cfg: ImFontConfig=None) -> ImFont: ...
    # def add_font_from_file_ttf(self: ImFontAtlas, filename: str, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont: ...
    # def add_font_from_memory_compressed_base85_ttf(self: ImFontAtlas, compressed_font_data_base85: str, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont:
    #     """
    #     'compressed_font_data_base85' still owned by caller. compress with binary_to_compressed_c.cpp with -base85 parameter.
    #     """
    #     pass

    # def add_font_from_memory_compressed_ttf(self: ImFontAtlas, compressed_font_data: Any, compressed_font_size: int, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont:
    #     """
    #     'compressed_font_data' still owned by caller. compress with binary_to_compressed_c.cpp.
    #     """
    #     pass

    # def add_font_from_memory_ttf(self: ImFontAtlas, font_data: Any, font_size: int, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont:
    #     """
    #     Note: transfer ownership of 'ttf_data' to imfontatlas! will be deleted after destruction of the atlas. set font_cfg->fontdataownedbyatlas=false to keep ownership of your data and it won't be freed.
    #     """
    #     pass

    # def build(self: ImFontAtlas) -> bool:
    #     """
    #     Build atlas, retrieve pixel data.
    #     User is in charge of copying the pixels into graphics memory (e.g. create a texture with your engine). Then store your texture handle with SetTexID().
    #     The pitch is always = Width * BytesPerPixels (1 or 4)
    #     Building in RGBA32 format is provided for convenience and compatibility, but note that unless you manually manipulate or copy color data into
    #     the texture (e.g. when using the AddCustomRect*** api), then the RGB pixels emitted will always be white (~75% of memory/bandwidth waste.
    #     Build pixels data. this is called automatically for you by the gettexdata*** functions.
    #     """
    #     pass

    # def calc_custom_rect_uv(self: ImFontAtlas, rect: ImFontAtlasCustomRect, out_uv_min: ImVec2, out_uv_max: ImVec2) -> None:
    #     """
    #     [Internal]
    #     """
    #     pass

    # def clear(self: ImFontAtlas) -> None:
    #     """
    #     Clear all input and output.
    #     """
    #     pass

    # def clear_fonts(self: ImFontAtlas) -> None:
    #     """
    #     Clear output font data (glyphs storage, uv coordinates).
    #     """
    #     pass

    # def clear_input_data(self: ImFontAtlas) -> None:
    #     """
    #     Clear input data (all imfontconfig structures including sizes, ttf data, glyph ranges, etc.) = all the data used to build the texture and fonts.
    #     """
    #     pass

    def clear_tex_data(self: ImFontAtlas) -> None:
        """
        Clear output texture data (cpu side). saves ram once the texture has been copied to graphics memory.
        """
        pass

    # def get_custom_rect_by_index(self: ImFontAtlas, index: int) -> ImFontAtlasCustomRect: ...
    # def get_glyph_ranges_chinese_full(self: ImFontAtlas) -> int:
    #     """
    #     Default + half-width + japanese hiragana/katakana + full set of about 21000 cjk unified ideographs
    #     """
    #     pass

    # def get_glyph_ranges_chinese_simplified_common(self: ImFontAtlas) -> int:
    #     """
    #     Default + half-width + japanese hiragana/katakana + set of 2500 cjk unified ideographs for common simplified chinese
    #     """
    #     pass

    # def get_glyph_ranges_cyrillic(self: ImFontAtlas) -> int:
    #     """
    #     Default + about 400 cyrillic characters
    #     """
    #     pass

    # def get_glyph_ranges_default(self: ImFontAtlas) -> int:
    #     """
    #     Helpers to retrieve list of common Unicode ranges (2 value per range, values are inclusive, zero-terminated list)
    #     NB: Make sure that your string are UTF-8 and NOT in your local code page. In C++11, you can create UTF-8 string literal using the u8"Hello world" syntax. See FAQ for details.
    #     NB: Consider using ImFontGlyphRangesBuilder to build glyph ranges from textual data.
    #     Basic latin, extended latin
    #     """
    #     pass

    # def get_glyph_ranges_greek(self: ImFontAtlas) -> int:
    #     """
    #     Default + greek and coptic
    #     """
    #     pass

    # def get_glyph_ranges_japanese(self: ImFontAtlas) -> int:
    #     """
    #     Default + hiragana, katakana, half-width, selection of 2999 ideographs
    #     """
    #     pass

    # def get_glyph_ranges_korean(self: ImFontAtlas) -> int:
    #     """
    #     Default + korean characters
    #     """
    #     pass

    # def get_glyph_ranges_thai(self: ImFontAtlas) -> int:
    #     """
    #     Default + thai characters
    #     """
    #     pass

    # def get_glyph_ranges_vietnamese(self: ImFontAtlas) -> int:
    #     """
    #     Default + vietnamese characters
    #     """
    #     pass

    # def get_mouse_cursor_tex_data(self: ImFontAtlas, cursor: int, out_offset: ImVec2, out_size: ImVec2, out_uv_border: ImVec2, out_uv_fill: ImVec2) -> bool: ...
    def get_tex_data_as_alpha8(self: ImFontAtlas, out_width: IntPtr, out_height: IntPtr, out_bytes_per_pixel: IntPtr=None) -> bytes:
        """
        1 byte per-pixel
        """
        pass

    def get_tex_data_as_rgba_32(self: ImFontAtlas, out_width: IntPtr, out_height: IntPtr, out_bytes_per_pixel: IntPtr=None) -> bytes:
        """
        4 bytes-per-pixel
        """
        pass

    # def is_built(self: ImFontAtlas) -> bool:
    #     """
    #     Bit ambiguous: used to detect when user didn't build texture but effectively we should check texid != 0 except that would be backend dependent...
    #     """
    #     pass

    # def set_tex_id(self: ImFontAtlas, id_: Any) -> None: ...

class ImFontAtlasCustomRect:
    """
    See ImFontAtlas::AddCustomRectXXX functions.
    """
    pass
    # font: ImFont
    # """
    # Input// for custom font glyphs only: target font
    # """
    # glyph_advance_x: float
    # """
    # Input// for custom font glyphs only: glyph xadvance
    # """
    # glyph_id: int
    # """
    # Input// for custom font glyphs only (id < 0x110000)
    # """
    # glyph_offset: tuple
    # """
    # Input// for custom font glyphs only: glyph display offset
    # """
    # height: int
    # """
    # Input// desired rectangle dimension
    # """
    # width: int
    # """
    # Input// desired rectangle dimension
    # """
    # x: int
    # """
    # Output   // packed position in atlas
    # """
    # y: int
    # """
    # Output   // packed position in atlas
    # """
    # def is_packed(self: ImFontAtlasCustomRect) -> bool: ...

class ImFontBuilderIO:
    """
    Opaque interface to a font builder (stb_truetype or freetype).
    """
    pass

class ImFontConfig:
    """
    -1   // explicitly specify unicode codepoint of ellipsis character. when fonts are being merged first specified ellipsis will be used.
    """
    pass
    # dst_font: ImFont
    # ellipsis_char: int
    # """
    # -1   // explicitly specify unicode codepoint of ellipsis character. when fonts are being merged first specified ellipsis will be used.
    # """
    # font_builder_flags: int
    # """
    # 0// settings for custom font builder. this is builder implementation dependent. leave as zero if unsure.
    # """
    # font_data: Any
    # """
    # Ttf/otf data
    # """
    # font_data_owned_by_atlas: bool
    # """
    # True // ttf/otf data ownership taken by the container imfontatlas (will delete memory itself).
    # """
    # font_data_size: int
    # """
    # Ttf/otf data size
    # """
    # font_no: int
    # """
    # 0// index of font within ttf/otf file
    # """
    # glyph_extra_spacing: tuple
    # """
    # 0, 0 // extra spacing (in pixels) between glyphs. only x axis is supported for now.
    # """
    # glyph_max_advance_x: float
    # """
    # Flt_max  // maximum advancex for glyphs
    # """
    # glyph_min_advance_x: float
    # """
    # 0// minimum advancex for glyphs, set min to align font icons, set both min/max to enforce mono-space font
    # """
    # glyph_offset: tuple
    # """
    # 0, 0 // offset all glyphs from this font input.
    # """
    # glyph_ranges: int
    # """
    # Null // the array data needs to persist as long as the font is alive. pointer to a user-provided list of unicode range (2 value per range, values are inclusive, zero-terminated list).
    # """
    # merge_mode: bool
    # """
    # False// merge into previous imfont, so you can combine multiple inputs font into one imfont (e.g. ascii font + icons + japanese glyphs). you may want to use glyphoffset.y when merge font of different heights.
    # """
    # name: int
    # """
    # [Internal]
    # Name (strictly to ease debugging)
    # """
    # oversample_h: int
    # """
    # 3// rasterize at higher quality for sub-pixel positioning. note the difference between 2 and 3 is minimal so you can reduce this to 2 to save memory. read https://github.com/nothings/stb/blob/master/tests/oversample/readme.md for details.
    # """
    # oversample_v: int
    # """
    # 1// rasterize at higher quality for sub-pixel positioning. this is not really useful as we don't use sub-pixel positions on the y axis.
    # """
    # pixel_snap_h: bool
    # """
    # False// align every glyph to pixel boundary. useful e.g. if you are merging a non-pixel aligned font with the default font. if enabled, you can set oversampleh/v to 1.
    # """
    # rasterizer_multiply: float
    # """
    # 1.0f // brighten (>1.0f) or darken (<1.0f) font output. brightening small fonts may be a good workaround to make them more readable.
    # """
    # size_pixels: float
    # """
    # Size in pixels for rasterizer (more or less maps to the resulting font height).
    # """

class ImFontGlyph:
    """
    Hold rendering data for one glyph.
    (Note: some language parsers may fail to convert the 31+1 bitfield members, in this case maybe drop store a single u32 or we can rework this)
    """
    pass
    # advance_x: float
    # """
    # Distance to next character (= data from font + imfontconfig::glyphextraspacing.x baked in)
    # """
    # codepoint: int
    # """
    # 0x0000..0x10ffff
    # """
    # colored: int
    # """
    # Flag to indicate glyph is colored and should generally ignore tinting (make it usable with no shift on little-endian as this is used in loops)
    # """
    # u0: float
    # """
    # Texture coordinates
    # """
    # u1: float
    # """
    # Texture coordinates
    # """
    # v0: float
    # """
    # Texture coordinates
    # """
    # v1: float
    # """
    # Texture coordinates
    # """
    # visible: int
    # """
    # Flag to indicate glyph has no visible pixels (e.g. space). allow early out when rendering.
    # """
    # x0: float
    # """
    # Glyph corners
    # """
    # x1: float
    # """
    # Glyph corners
    # """
    # y0: float
    # """
    # Glyph corners
    # """
    # y1: float
    # """
    # Glyph corners
    # """

class ImFontGlyphRangesBuilder:
    """
    Helper to build glyph ranges from text/string data. Feed your application strings/characters to it then call BuildRanges().
    This is essentially a tightly packed of vector of 64k booleans = 8KB storage.
    """
    pass
    # used_chars: ImVector_ImU32
    # """
    # Store 1-bit per unicode code point (0=unused, 1=used)
    # """
    # def add_char(self: ImFontGlyphRangesBuilder, c: int) -> None:
    #     """
    #     Add character
    #     """
    #     pass

    # def add_ranges(self: ImFontGlyphRangesBuilder, ranges: int) -> None:
    #     """
    #     Add ranges, e.g. builder.addranges(imfontatlas::getglyphrangesdefault()) to force add all of ascii/latin+ext
    #     """
    #     pass

    # def add_text(self: ImFontGlyphRangesBuilder, text: str, text_end: str=None) -> None:
    #     """
    #     Add string (each character of the utf-8 string are added)
    #     """
    #     pass

    # def build_ranges(self: ImFontGlyphRangesBuilder, out_ranges: ImVector_ImWchar) -> None:
    #     """
    #     Output new ranges (imvector_construct()/imvector_destruct() can be used to safely construct out_ranges)
    #     """
    #     pass

    # def clear(self: ImFontGlyphRangesBuilder) -> None: ...
    # def get_bit(self: ImFontGlyphRangesBuilder, n: Any) -> bool:
    #     """
    #     Get bit n in the array
    #     """
    #     pass

    # def set_bit(self: ImFontGlyphRangesBuilder, n: Any) -> None:
    #     """
    #     Set bit n in the array
    #     """
    #     pass


class ImGuiContext:
    """
    Dear imgui context (opaque structure, unless including imgui_internal.h)
    """
    pass

class ImGuiIO:
    """
    Only modify via setappacceptingevents()
    """
    # app_accepting_events: bool
    # """
    # Only modify via setappacceptingevents()
    # """
    # app_focus_lost: bool
    # """
    # Only modify via addfocusevent()
    # """
    # backend_flags: int
    # """
    # = 0  // see imguibackendflags_ enum. set by backend (imgui_impl_xxx files or custom backend) to communicate features supported by the backend.
    # """
    # backend_language_user_data: Any
    # """
    # = null   // user data for non c++ programming language backend
    # """
    # backend_platform_name: str
    # """
    # Optional: Platform/Renderer backend name (informational only! will be displayed in About Window) + User data for backend/wrappers to store their own stuff.
    # = null
    # """
    # backend_platform_user_data: Any
    # """
    # = null   // user data for platform backend
    # """
    # backend_renderer_name: str
    # """
    # = null
    # """
    # backend_renderer_user_data: Any
    # """
    # = null   // user data for renderer backend
    # """
    # backend_using_legacy_key_arrays: int
    # """
    # -1: unknown, 0: using addkeyevent(), 1: using legacy io.keysdown[]
    # """
    # backend_using_legacy_nav_input_array: bool
    # """
    # 0: using addkeyanalogevent(), 1: writing to legacy io.navinputs[] directly
    # """
    # clipboard_user_data: Any
    # config_debug_begin_return_value_loop: bool
    # """
    # = false // some calls to begin()/beginchild() will return false. will cycle through window depths then repeat. suggested use: add 'io.configdebugbeginreturnvalue = io.keyshift' in your main loop then occasionally press shift. windows should be flickering while running.
    # """
    # config_debug_begin_return_value_once: bool
    # """
    # Debug options
    # - tools to test correct Begin/End and BeginChild/EndChild behaviors.
    # - presently Begn()/End() and BeginChild()EndChild() needs to ALWAYS be called in tandem, regardless of return value of BeginXXX()
    # this is inconsistent with other BeginXXX functions and create confusion for many users.
    # - we expect to update the API eventually. In the meanwhile we provided tools to facilitate checking user-code behavior.
    # = false // first-time calls to begin()/beginchild() will return false. needs to be set at application boot time if you don't want to miss windows.
    # """
    # config_docking_always_tab_bar: bool
    # """
    # = false  // [beta] [fixme: this currently creates regression with auto-sizing and general overhead] make every single floating window display within a docking node.
    # """
    # config_docking_no_split: bool
    # """
    # Docking options (when ImGuiConfigFlags_DockingEnable is set)
    # = false  // simplified docking mode: disable window splitting, so docking is limited to merging multiple windows together into tab-bars.
    # """
    # config_docking_transparent_payload: bool
    # """
    # = false  // [beta] make window or viewport transparent when docking and only display docking boxes on the target viewport. useful if rendering of multiple viewport cannot be synced. best used with configviewportsnoautomerge.
    # """
    # config_docking_with_shift: bool
    # """
    # = false  // enable docking with holding shift key (reduce visual noise, allows dropping in wider space)
    # """
    # config_drag_click_to_input_text: bool
    # """
    # = false  // [beta] enable turning dragxxx widgets into text input with a simple mouse click-release (without moving). not desirable on devices without a keyboard.
    # """
    config_flags: int
    """
    = 0  // see imguiconfigflags_ enum. set by user/application. gamepad/keyboard navigation options, etc.
    """
    # config_input_text_cursor_blink: bool
    # """
    # = true   // enable blinking cursor (optional as some users consider it to be distracting).
    # """
    # config_input_text_enter_keep_active: bool
    # """
    # = false  // [beta] pressing enter will keep item active and select contents (single-line only).
    # """
    # config_input_trickle_event_queue: bool
    # """
    # = true   // enable input queue trickling: some types of events submitted during the same frame (e.g. button down + up) will be spread over multiple frames, improving interactions with low framerates.
    # """
    # config_mac_osx_behaviors: bool
    # """
    # = defined(__apple__) // os x style: text editing cursor movement using alt instead of ctrl, shortcuts using cmd/super instead of ctrl, line/text start and end using cmd+arrows instead of home/end, double click selects by word instead of selecting whole text, multi-selection in lists uses cmd/super instead of ctrl.
    # """
    # config_memory_compact_timer: float
    # """
    # = 60.0f  // timer (in seconds) to free transient windows/tables memory buffers when unused. set to -1.0f to disable.
    # """
    # config_viewports_no_auto_merge: bool
    # """
    # Viewport options (when ImGuiConfigFlags_ViewportsEnable is set)
    # = false; // set to make all floating imgui windows always create their own viewport. otherwise, they are merged into the main host viewports when overlapping it. may also set imguiviewportflags_noautomerge on individual viewport.
    # """
    # config_viewports_no_decoration: bool
    # """
    # = true   // disable default os window decoration flag for secondary viewports. when a viewport doesn't want window decorations, imguiviewportflags_nodecoration will be set on it. enabling decoration can create subsequent issues at os levels (e.g. minimum window size).
    # """
    # config_viewports_no_default_parent: bool
    # """
    # = false  // disable default os parenting to main viewport for secondary viewports. by default, viewports are marked with parentviewportid = <main_viewport>, expecting the platform backend to setup a parent/child relationship between the os windows (some backend may ignore this). set to true if you want the default to be 0, then all viewports will be top-level os windows.
    # """
    # config_viewports_no_task_bar_icon: bool
    # """
    # = false  // disable default os task bar icon flag for secondary viewports. when a viewport doesn't want a task bar icon, imguiviewportflags_notaskbaricon will be set on it.
    # """
    # config_windows_move_from_title_bar_only: bool
    # """
    # = false   // enable allowing to move windows only when clicking on their title bar. does not apply to windows without a title bar.
    # """
    # config_windows_resize_from_edges: bool
    # """
    # = true   // enable resizing of windows from their edges and from the lower-left corner. this requires (io.backendflags & imguibackendflags_hasmousecursors) because it needs mouse cursor feedback. (this used to be a per-window imguiwindowflags_resizefromanyside flag)
    # """
    # ctx: ImGuiContext
    # """
    # Parent ui context (needs to be set explicitly by parent).
    # """
    delta_time: float
    """
    = 1.0f/60.0f // time elapsed since last frame, in seconds. may change every frame.
    """
    display_framebuffer_scale: tuple
    """
    = (1, 1) // for retina display or other situations where window coordinates are different from framebuffer coordinates. this generally ends up in imdrawdata::framebufferscale.
    """
    display_size: tuple
    """
    <unset>  // main display size, in pixels (generally == getmainviewport()->size). may change every frame.
    """
    # font_allow_user_scaling: bool
    # """
    # = false  // allow user scaling text of individual window with ctrl+wheel.
    # """
    # font_default: ImFont
    # """
    # = null   // font to use on newframe(). use null to uses fonts->fonts[0].
    # """
    # font_global_scale: float
    # """
    # = 1.0f   // global scale all fonts
    # """
    fonts: ImFontAtlas
    """
    <auto>   // font atlas: load, rasterize and pack one or more fonts into a single texture.
    """
    framerate: float
    """
    Estimate of application framerate (rolling average over 60 frames, based on io.deltatime), in frame per second. solely for convenience. slow applications may not want to use a moving average or may want to reset underlying buffers occasionally.
    """
    get_clipboard_text_fn: Callable
    # hover_delay_normal: float
    # """
    # = 0.30 sec   // delay on hovering before isitemhovered(imguihoveredflags_delaynormal) returns true.
    # """
    # hover_delay_short: float
    # """
    # = 0.10 sec   // delay on hovering before isitemhovered(imguihoveredflags_delayshort) returns true.
    # """
    # ini_filename: str
    # """
    # = 'imgui.ini'// path to .ini file (important: default 'imgui.ini' is relative to current working dir!). set null to disable automatic .ini loading/saving or if you want to manually call loadinisettingsxxx() / saveinisettingsxxx() functions.
    # """
    # ini_saving_rate: float
    # """
    # = 5.0f   // minimum time between saving positions/sizes to .ini file, in seconds.
    # """
    # input_queue_characters: ImVector_ImWchar
    # """
    # Queue of _characters_ input (obtained by platform backend). fill using addinputcharacter() helper.
    # """
    # input_queue_surrogate: int
    # """
    # For addinputcharacterutf16()
    # """
    key_alt: bool
    """
    Keyboard modifier down: alt
    """
    key_ctrl: bool
    """
    Keyboard modifier down: control
    """
    # key_mods: int
    # """
    # Other state maintained from data above + IO function calls
    # Key mods flags (any of imguimod_ctrl/imguimod_shift/imguimod_alt/imguimod_super flags, same as io.keyctrl/keyshift/keyalt/keysuper but merged into flags. does not contains imguimod_shortcut which is pretranslated). read-only, updated by newframe()
    # """
    # key_repeat_delay: float
    # """
    # = 0.275f // when holding a key/button, time before it starts repeating, in seconds (for buttons in repeat mode, etc.).
    # """
    # key_repeat_rate: float
    # """
    # = 0.050f // when holding a key/button, rate at which it repeats, in seconds.
    # """
    key_shift: bool
    """
    Keyboard modifier down: shift
    """
    key_super: bool
    """
    Keyboard modifier down: cmd/super/windows
    """
    # keys_data: ImGuiKeyData
    # """
    # Key state for all known keys. use iskeyxxx() functions to access this.
    # """
    # log_filename: str
    # """
    # = 'imgui_log.txt'// path to .log file (default parameter to imgui::logtofile when no file is specified).
    # """
    # metrics_active_allocations: int
    # """
    # Number of active allocations, updated by memalloc/memfree based on current context. may be off if you have multiple imgui contexts.
    # """
    # metrics_active_windows: int
    # """
    # Number of active windows
    # """
    # metrics_render_indices: int
    # """
    # Indices output during last call to render() = number of triangles * 3
    # """
    # metrics_render_vertices: int
    # """
    # Vertices output during last call to render()
    # """
    # metrics_render_windows: int
    # """
    # Number of visible windows
    # """
    # mouse_clicked: bool
    # """
    # Mouse button went from !down to down (same as mouseclickedcount[x] != 0)
    # """
    # mouse_clicked_count: int
    # """
    # == 0 (not clicked), == 1 (same as mouseclicked[]), == 2 (double-clicked), == 3 (triple-clicked) etc. when going from !down to down
    # """
    # mouse_clicked_last_count: int
    # """
    # Count successive number of clicks. stays valid after mouse release. reset after another click is done.
    # """
    # mouse_clicked_pos: tuple
    # """
    # Position at time of clicking
    # """
    # mouse_clicked_time: float
    # """
    # Time of last click (used to figure out double-click)
    # """
    mouse_delta: tuple
    """
    Mouse delta. note that this is zero if either current or previous position are invalid (-flt_max,-flt_max), so a disappearing/reappearing mouse won't have a huge delta.
    """
    # mouse_double_click_max_dist: float
    # """
    # = 6.0f   // distance threshold to stay in to validate a double-click, in pixels.
    # """
    # mouse_double_click_time: float
    # """
    # = 0.30f  // time for a double-click, in seconds.
    # """
    # mouse_double_clicked: bool
    # """
    # Has mouse button been double-clicked? (same as mouseclickedcount[x] == 2)
    # """
    # mouse_down: bool
    # """
    # Mouse buttons: 0=left, 1=right, 2=middle + extras (imguimousebutton_count == 5). dear imgui mostly uses left and right buttons. other buttons allow us to track if the mouse is being used by your application + available to user as a convenience via ismouse** api.
    # """
    # mouse_down_duration: float
    # """
    # Duration the mouse button has been down (0.0f == just clicked)
    # """
    # mouse_down_duration_prev: float
    # """
    # Previous time the mouse button has been down
    # """
    # mouse_down_owned: bool
    # """
    # Track if button was clicked inside a dear imgui window or over void blocked by a popup. we don't request mouse capture from the application if click started outside imgui bounds.
    # """
    # mouse_down_owned_unless_popup_close: bool
    # """
    # Track if button was clicked inside a dear imgui window.
    # """
    # mouse_drag_max_distance_abs: tuple
    # """
    # Maximum distance, absolute, on each axis, of how much mouse has traveled from the clicking point
    # """
    # mouse_drag_max_distance_sqr: float
    # """
    # Squared maximum distance of how much mouse has traveled from the clicking point (used for moving thresholds)
    # """
    # mouse_drag_threshold: float
    # """
    # = 6.0f   // distance threshold before considering we are dragging.
    # """
    # mouse_draw_cursor: bool
    # """
    # Miscellaneous options
    # = false  // request imgui to draw a mouse cursor for you (if you are on a platform without a mouse cursor). cannot be easily renamed to 'io.configxxx' because this is frequently used by backend implementations.
    # """
    mouse_hovered_viewport: int
    """
    (optional) modify using io.addmouseviewportevent(). with multi-viewports: viewport the os mouse is hovering. if possible _ignoring_ viewports with the imguiviewportflags_noinputs flag is much better (few backends can handle that). set io.backendflags |= imguibackendflags_hasmousehoveredviewport if you can provide this info. if you don't imgui will infer the value using the rectangles and last focused time of the viewports it knows about (ignoring other os windows).
    """
    mouse_pos: tuple
    """
    Main Input State
    (this block used to be written by backend, since 1.87 it is best to NOT write to those directly, call the AddXXX functions above instead)
    (reading from those variables is fair game, as they are extremely unlikely to be moving anywhere)
    Mouse position, in pixels. set to imvec2(-flt_max, -flt_max) if mouse is unavailable (on another screen, etc.)
    """
    # mouse_pos_prev: tuple
    # """
    # Previous mouse position (note that mousedelta is not necessary == mousepos-mouseposprev, in case either position is invalid)
    # """
    # mouse_released: bool
    # """
    # Mouse button went from down to !down
    # """
    # mouse_source: int
    # """
    # Mouse actual input peripheral (mouse/touchscreen/pen).
    # """
    mouse_wheel: float
    """
    Mouse wheel vertical: 1 unit scrolls about 5 lines text. >0 scrolls up, <0 scrolls down. hold shift to turn vertical scroll into horizontal scroll.
    """
    mouse_wheel_h: float
    """
    Mouse wheel horizontal. >0 scrolls left, <0 scrolls right. most users don't have a mouse with a horizontal wheel, may not be filled by all backends.
    """
    # mouse_wheel_request_axis_swap: bool
    # """
    # On a non-mac system, holding shift requests wheely to perform the equivalent of a wheelx event. on a mac system this is already enforced by the system.
    # """
    # nav_active: bool
    # """
    # Keyboard/gamepad navigation is currently allowed (will handle imguikey_navxxx events) = a window is focused and it doesn't use the imguiwindowflags_nonavinputs flag.
    # """
    # nav_visible: bool
    # """
    # Keyboard/gamepad navigation is visible and allowed (will handle imguikey_navxxx events).
    # """
    # pen_pressure: float
    # """
    # Touch/pen pressure (0.0f to 1.0f, should be >0.0f only when mousedown[0] == true). helper storage currently unused by dear imgui.
    # """
    set_clipboard_text_fn: Callable
    # set_platform_ime_data_fn: Callable
    # """
    # Optional: Notify OS Input Method Editor of the screen position of your cursor for text input position (e.g. when using Japanese/Chinese IME on Windows)
    # (default to use native imm32 api on Windows)
    # """
    # user_data: Any
    # """
    # = null   // store your own data.
    # """
    # want_capture_keyboard: bool
    # """
    # Set when dear imgui will use keyboard inputs, in this case do not dispatch them to your main game/application (either way, always pass keyboard inputs to imgui). (e.g. inputtext active, or an imgui window is focused and navigation is enabled, etc.).
    # """
    # want_capture_mouse: bool
    # """
    # Set when dear imgui will use mouse inputs, in this case do not dispatch them to your main game/application (either way, always pass on mouse inputs to imgui). (e.g. unclicked mouse is hovering over an imgui window, widget is active, mouse was clicked over an imgui window, etc.).
    # """
    # want_capture_mouse_unless_popup_close: bool
    # """
    # Alternative to wantcapturemouse: (wantcapturemouse == true && wantcapturemouseunlesspopupclose == false) when a click over void is expected to close a popup.
    # """
    # want_save_ini_settings: bool
    # """
    # When manual .ini load/save is active (io.inifilename == null), this will be set to notify your application that you can call saveinisettingstomemory() and save yourself. important: clear io.wantsaveinisettings yourself after saving!
    # """
    # want_set_mouse_pos: bool
    # """
    # Mousepos has been altered, backend should reposition mouse on next frame. rarely used! set only when imguiconfigflags_navenablesetmousepos flag is enabled.
    # """
    # want_text_input: bool
    # """
    # Mobile/console: when set, you may display an on-screen keyboard. this is set by dear imgui when it wants textual keyboard input to happen (e.g. when a inputtext widget is active).
    # """
    # def add_focus_event(self: ImGuiIO, focused: bool) -> None:
    #     """
    #     Queue a gain/loss of focus for the application (generally based on os/platform focus of your window)
    #     """
    #     pass

    def add_input_character(self: ImGuiIO, c: int) -> None:
        """
        Queue a new character input
        """
        pass

    # def add_input_character_utf_16(self: ImGuiIO, c: int) -> None:
    #     """
    #     Queue a new character input from a utf-16 character, it can be a surrogate
    #     """
    #     pass

    # def add_input_characters_utf_8(self: ImGuiIO, str_: str) -> None:
    #     """
    #     Queue a new characters input from a utf-8 string
    #     """
    #     pass

    # def add_key_analog_event(self: ImGuiIO, key: int, down: bool, v: float) -> None:
    #     """
    #     Queue a new key down/up event for analog values (e.g. imguikey_gamepad_ values). dead-zones should be handled by the backend.
    #     """
    #     pass

    def add_key_event(self: ImGuiIO, key: int, down: bool) -> None:
        """
        Input Functions
        Queue a new key down/up event. key should be 'translated' (as in, generally imguikey_a matches the key end-user would use to emit an 'a' character)
        """
        pass

    def add_mouse_button_event(self: ImGuiIO, button: int, down: bool) -> None:
        """
        Queue a mouse button change
        """
        pass

    def add_mouse_pos_event(self: ImGuiIO, x: float, y: float) -> None:
        """
        Queue a mouse position update. use -flt_max,-flt_max to signify no mouse (e.g. app not focused and not hovered)
        """
        pass

    # def add_mouse_source_event(self: ImGuiIO, source: int) -> None:
    #     """
    #     Queue a mouse source change (mouse/touchscreen/pen)
    #     """
    #     pass

    # def add_mouse_viewport_event(self: ImGuiIO, id_: int) -> None:
    #     """
    #     Queue a mouse hovered viewport. requires backend to set imguibackendflags_hasmousehoveredviewport to call this (for multi-viewport support).
    #     """
    #     pass

    def add_mouse_wheel_event(self: ImGuiIO, wheel_x: float, wheel_y: float) -> None:
        """
        Queue a mouse wheel update. wheel_y<0: scroll down, wheel_y>0: scroll up, wheel_x<0: scroll right, wheel_x>0: scroll left.
        """
        pass

    # def clear_input_characters(self: ImGuiIO) -> None:
    #     """
    #     [internal] clear the text input buffer manually
    #     """
    #     pass

    # def clear_input_keys(self: ImGuiIO) -> None:
    #     """
    #     [internal] release all keys
    #     """
    #     pass

    # def set_app_accepting_events(self: ImGuiIO, accepting_events: bool) -> None:
    #     """
    #     Set master flag for accepting key/mouse/text events (default to true). useful if you have native dialog boxes that are interrupting your application loop/refresh, and you want to disable events being queued while your app is frozen.
    #     """
    #     pass

    # def set_key_event_native_data(self: ImGuiIO, key: int, native_keycode: int, native_scancode: int) -> None:
    #     """
    #     Implied native_legacy_index = -1
    #     """
    #     pass

    # def set_key_event_native_data_ex(self: ImGuiIO, key: int, native_keycode: int, native_scancode: int, native_legacy_index: int=-1) -> None:
    #     """
    #     [optional] specify index for legacy <1.87 iskeyxxx() functions with native indices + specify native keycode, scancode.
    #     """
    #     pass


class ImGuiInputTextCallbackData:
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
    buf: str
    """
    Text buffer  // read-write   // [resize] can replace pointer / [completion,history,always] only write to pointed data, don't replace the actual pointer!
    """
    # buf_dirty: bool
    # """
    # Set if you modify buf/buftextlen!// write// [completion,history,always]
    # """
    # buf_size: int
    # """
    # Buffer size (in bytes) = capacity+1  // read-only// [resize,completion,history,always] include zero-terminator storage. in c land == arraysize(my_char_array), in c++ land: string.capacity()+1
    # """
    buf_text_len: int
    """
    Text length (in bytes)   // read-write   // [resize,completion,history,always] exclude zero-terminator storage. in c land: == strlen(some_text), in c++ land: string.length()
    """
    # ctx: ImGuiContext
    # """
    # Parent ui context
    # """
    cursor_pos: int
    """
    Read-write   // [completion,history,always]
    """
    # event_char: int
    # """
    # Arguments for the different callback events
    # - To modify the text buffer in a callback, prefer using the InsertChars() / DeleteChars() function. InsertChars() will take care of calling the resize callback if necessary.
    # - If you know your edits are not going to resize the underlying buffer allocation, you may modify the contents of 'Buf[]' directly. You need to update 'BufTextLen' accordingly (0 <= BufTextLen < BufSize) and set 'BufDirty'' to true so InputText can update its internal state.
    # Character input  // read-write   // [charfilter] replace character with another one, or set to zero to drop. return 1 is equivalent to setting eventchar=0;
    # """
    event_flag: int
    """
    One imguiinputtextflags_callback*// read-only
    """
    event_key: int
    """
    Key pressed (up/down/tab)// read-only// [completion,history]
    """
    # flags: int
    # """
    # What user passed to inputtext()  // read-only
    # """
    # selection_end: int
    # """
    # Read-write   // [completion,history,always]
    # """
    # selection_start: int
    # """
    # Read-write   // [completion,history,always] == to selectionend when no selection)
    # """
    # user_data: Any
    # """
    # What user passed to inputtext()  // read-only
    # """
    # def clear_selection(self: ImGuiInputTextCallbackData) -> None: ...
    def delete_chars(self: ImGuiInputTextCallbackData, pos: int, bytes_count: int) -> None: ...
    # def has_selection(self: ImGuiInputTextCallbackData) -> bool: ...
    def insert_chars(self: ImGuiInputTextCallbackData, pos: int, text: str) -> None: ...
    # def select_all(self: ImGuiInputTextCallbackData) -> None: ...

class ImGuiKeyData:
    """
    [Internal] Storage used by IsKeyDown(), IsKeyPressed() etc functions.
    If prior to 1.87 you used io.KeysDownDuration[] (which was marked as internal), you should use GetKeyData(key)->DownDuration and *NOT* io.KeysData[key]->DownDuration.
    """
    pass
    # analog_value: float
    # """
    # 0.0f..1.0f for gamepad values
    # """
    # down: bool
    # """
    # True for if key is down
    # """
    # down_duration: float
    # """
    # Duration the key has been down (<0.0f: not pressed, 0.0f: just pressed, >0.0f: time held)
    # """
    # down_duration_prev: float
    # """
    # Last frame duration the key has been down
    # """

class ImGuiListClipper:
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
    """
    # ctx: ImGuiContext
    # """
    # Parent ui context
    # """
    display_end: int
    """
    End of items to display (exclusive)
    """
    display_start: int
    """
    First item to display, updated by each call to step()
    """
    # items_count: int
    # """
    # [internal] number of items
    # """
    # items_height: float
    # """
    # [internal] height of item after a first step and item submission can calculate it
    # """
    # start_pos_y: float
    # """
    # [internal] cursor position at the time of begin() or after table frozen rows are all processed
    # """
    # temp_data: Any
    # """
    # [internal] internal data
    # """
    def begin(self: ImGuiListClipper, items_count: int, items_height: float=-1.0) -> None: ...
    def create() -> ImGuiListClipper: ...
    def destroy(self: ImGuiListClipper) -> None: ...
    # def end(self: ImGuiListClipper) -> None:
    #     """
    #     Automatically called on the last call of step() that returns false.
    #     """
    #     pass

    # def force_display_range_by_indices(self: ImGuiListClipper, item_min: int, item_max: int) -> None:
    #     """
    #     Call ForceDisplayRangeByIndices() before first call to Step() if you need a range of items to be displayed regardless of visibility.
    #     Item_max is exclusive e.g. use (42, 42+1) to make item 42 always visible but due to alignment/padding of certain items it is likely that an extra item may be included on either end of the display range.
    #     """
    #     pass

    def step(self: ImGuiListClipper) -> bool:
        """
        Call until it returns false. the displaystart/displayend fields will be set and you can process/draw those items.
        """
        pass


class ImGuiPayload:
    """
    Data payload for Drag and Drop operations: AcceptDragDropPayload(), GetDragDropPayload()
    """
    pass
    # data: Any
    # """
    # Members
    # Data (copied and owned by dear imgui)
    # """
    # data_frame_count: int
    # """
    # Data timestamp
    # """
    # data_size: int
    # """
    # Data size
    # """
    # data_type: int
    # """
    # Data type tag (short user-supplied string, 32 characters max)
    # """
    # delivery: bool
    # """
    # Set when acceptdragdroppayload() was called and mouse button is released over the target item.
    # """
    # preview: bool
    # """
    # Set when acceptdragdroppayload() was called and mouse has been hovering the target item (nb: handle overlapping drag targets)
    # """
    # source_id: int
    # """
    # [Internal]
    # Source item id
    # """
    # source_parent_id: int
    # """
    # Source parent id (if available)
    # """
    # def clear(self: ImGuiPayload) -> None: ...
    # def is_data_type(self: ImGuiPayload, type_: str) -> bool: ...
    # def is_delivery(self: ImGuiPayload) -> bool: ...
    # def is_preview(self: ImGuiPayload) -> bool: ...

class ImGuiPlatformIO:
    """
    (Optional) Access via ImGui::GetPlatformIO()
    """
    pass
    # monitors: ImVector_ImGuiPlatformMonitor
    # """
    # (Optional) Monitor list
    # - Updated by: app/backend. Update every frame to dynamically support changing monitor or DPI configuration.
    # - Used by: dear imgui to query DPI info, clamp popups/tooltips within same monitor and not have them straddle monitors.
    # """
    # platform_create_vk_surface: Callable
    # """
    # (optional) for a vulkan renderer to call into platform code (since the surface creation needs to tie them both).
    # """
    # platform_create_window: Callable
    # """
    # Platform function --------------------------------------------------- Called by -----
    # . . u . .  // create a new platform window for the given viewport
    # """
    # platform_destroy_window: Callable
    # """
    # N . u . d  //
    # """
    # platform_get_window_dpi_scale: Callable
    # """
    # N . . . .  // (optional) [beta] fixme-dpi: dpi handling: return dpi scale for this viewport. 1.0f = 96 dpi.
    # """
    # platform_get_window_focus: Callable
    # """
    # . . u . .  //
    # """
    # platform_get_window_minimized: Callable
    # """
    # N . . . .  // get platform window minimized state. when minimized, we generally won't attempt to get/set size and contents will be culled more easily
    # """
    # platform_get_window_pos: Callable
    # """
    # N . . . .  //
    # """
    # platform_get_window_size: Callable
    # """
    # N . . . .  // get platform window client area size
    # """
    # platform_on_changed_viewport: Callable
    # """
    # . f . . .  // (optional) [beta] fixme-dpi: dpi handling: called during begin() every time the viewport we are outputting into changes, so backend has a chance to swap fonts to adjust style.
    # """
    # platform_render_window: Callable
    # """
    # . . . r .  // (optional) main rendering (platform side! this is often unused, or just setting a 'current' context for opengl bindings). 'render_arg' is the value passed to renderplatformwindowsdefault().
    # """
    # platform_set_window_alpha: Callable
    # """
    # . . u . .  // (optional) setup global transparency (not per-pixel transparency)
    # """
    # platform_set_window_focus: Callable
    # """
    # N . . . .  // move window to front and set input focus
    # """
    # platform_set_window_pos: Callable
    # """
    # . . u . .  // set platform window position (given the upper-left corner of client area)
    # """
    # platform_set_window_size: Callable
    # """
    # . . u . .  // set platform window client area size (ignoring os decorations such as os title bar etc.)
    # """
    # platform_set_window_title: Callable
    # """
    # . . u . .  // set platform window title (given an utf-8 string)
    # """
    # platform_show_window: Callable
    # """
    # . . u . .  // newly created windows are initially hidden so setwindowpos/size/title can be called on them before showing the window
    # """
    # platform_swap_buffers: Callable
    # """
    # . . . r .  // (optional) call present/swapbuffers (platform side! this is often unused!). 'render_arg' is the value passed to renderplatformwindowsdefault().
    # """
    # platform_update_window: Callable
    # """
    # . . u . .  // (optional) called by updateplatformwindows(). optional hook to allow the platform backend from doing general book-keeping every frame.
    # """
    # renderer_create_window: Callable
    # """
    # (Optional) Renderer functions (e.g. DirectX, OpenGL, Vulkan)
    # . . u . .  // create swap chain, frame buffers etc. (called after platform_createwindow)
    # """
    # renderer_destroy_window: Callable
    # """
    # N . u . d  // destroy swap chain, frame buffers etc. (called before platform_destroywindow)
    # """
    # renderer_render_window: Callable
    # """
    # . . . r .  // (optional) clear framebuffer, setup render target, then render the viewport->drawdata. 'render_arg' is the value passed to renderplatformwindowsdefault().
    # """
    # renderer_set_window_size: Callable
    # """
    # . . u . .  // resize swap chain, frame buffers etc. (called after platform_setwindowsize)
    # """
    # renderer_swap_buffers: Callable
    # """
    # . . . r .  // (optional) call present/swapbuffers. 'render_arg' is the value passed to renderplatformwindowsdefault().
    # """
    # viewports: ImVector_ImGuiViewportPtr
    # """
    # Viewports list (the list is updated by calling ImGui::EndFrame or ImGui::Render)
    # (in the future we will attempt to organize this feature to remove the need for a "main viewport")
    # Main viewports, followed by all secondary viewports.
    # """

class ImGuiPlatformImeData:
    """
    (Optional) Support for IME (Input Method Editor) via the io.SetPlatformImeDataFn() function.
    """
    pass
    # input_line_height: float
    # """
    # Line height
    # """
    # input_pos: tuple
    # """
    # Position of the input cursor
    # """
    # want_visible: bool
    # """
    # A widget wants the ime to be visible
    # """

class ImGuiPlatformMonitor:
    """
    (Optional) This is required when enabling multi-viewport. Represent the bounds of each connected monitor/display and their DPI.
    We use this information for multiple DPI support + clamping the position of popups and tooltips so they don't straddle multiple monitors.
    """
    pass
    # dpi_scale: float
    # """
    # 1.0f = 96 dpi
    # """
    # main_pos: tuple
    # """
    # Coordinates of the area displayed on this monitor (min = upper left, max = bottom right)
    # """
    # main_size: tuple
    # """
    # Coordinates of the area displayed on this monitor (min = upper left, max = bottom right)
    # """
    # work_pos: tuple
    # """
    # Coordinates without task bars / side bars / menu bars. used to avoid positioning popups/tooltips inside this region. if you don't have this info, please copy the value for mainpos/mainsize.
    # """
    # work_size: tuple
    # """
    # Coordinates without task bars / side bars / menu bars. used to avoid positioning popups/tooltips inside this region. if you don't have this info, please copy the value for mainpos/mainsize.
    # """

class ImGuiSizeCallbackData:
    """
    Resizing callback data to apply custom constraint. As enabled by SetNextWindowSizeConstraints(). Callback is called during the next Begin().
    NB: For basic min/max size constraint on each axis you don't need to use the callback! The SetNextWindowSizeConstraints() parameters are enough.
    """
    pass
    # current_size: tuple
    # """
    # Read-only.   current window size.
    # """
    # desired_size: tuple
    # """
    # Read-write.  desired size, based on user's mouse position. write to this field to restrain resizing.
    # """
    # pos: tuple
    # """
    # Read-only.   window position, for reference.
    # """
    # user_data: Any
    # """
    # Read-only.   what user passed to setnextwindowsizeconstraints(). generally store an integer or float in here (need reinterpret_cast<>).
    # """

class ImGuiStorage:
    """
    Helper: Key->Value storage
    Typically you don't have to worry about this since a storage is held within each Window.
    We use it to e.g. store collapse state for a tree (Int 0/1)
    This is optimized for efficient lookup (dichotomy into a contiguous buffer) and rare insertion (typically tied to user interactions aka max once a frame)
    You can use it as custom user storage for temporary values. Declare your own storage if, for example:
    - You want to manipulate the open/close state of a particular sub-tree in your interface (tree node uses Int 0/1 to store their state).
    - You want to store custom debug data easily without adding or editing structures in your code (probably not efficient, but convenient)
    Types are NOT stored, so it is up to you to make sure your Key don't collide with different types.
    """
    pass
    # data: ImVector_ImGuiStorage_ImGuiStoragePair
    # def build_sort_by_key(self: ImGuiStorage) -> None:
    #     """
    #     For quicker full rebuild of a storage (instead of an incremental one), you may add all your contents and then sort once.
    #     """
    #     pass

    # def clear(self: ImGuiStorage) -> None:
    #     """
    #     - Get***() functions find pair, never add/allocate. Pairs are sorted so a query is O(log N)
    #     - Set***() functions find pair, insertion on demand if missing.
    #     - Sorted insertion is costly, paid once. A typical frame shouldn't need to insert any new pair.
    #     """
    #     pass

    # def get_bool(self: ImGuiStorage, key: int, default_val: bool=False) -> bool: ...
    # def get_bool_ref(self: ImGuiStorage, key: int, default_val: bool=False) -> BoolPtr: ...
    # def get_float(self: ImGuiStorage, key: int, default_val: float=0.0) -> float: ...
    # def get_float_ref(self: ImGuiStorage, key: int, default_val: float=0.0) -> FloatPtr: ...
    # def get_int(self: ImGuiStorage, key: int, default_val: int=0) -> int: ...
    # def get_int_ref(self: ImGuiStorage, key: int, default_val: int=0) -> IntPtr:
    #     """
    #     - Get***Ref() functions finds pair, insert on demand if missing, return pointer. Useful if you intend to do Get+Set.
    #     - References are only valid until a new value is added to the storage. Calling a Set***() function or a Get***Ref() function invalidates the pointer.
    #     - A typical use case where this is convenient for quick hacking (e.g. add storage during a live Edit&Continue session if you can't modify existing struct)
    #     float* pvar = ImGui::GetFloatRef(key); ImGui::SliderFloat("var", pvar, 0, 100.0f); some_var += *pvar;
    #     """
    #     pass

    # def get_void_ptr(self: ImGuiStorage, key: int) -> Any:
    #     """
    #     Default_val is null
    #     """
    #     pass

    # def get_void_ptr_ref(self: ImGuiStorage, key: int, default_val: Any=None) -> Any: ...
    # def set_all_int(self: ImGuiStorage, val: int) -> None:
    #     """
    #     Use on your own storage if you know only integer are being stored (open/close all tree nodes)
    #     """
    #     pass

    # def set_bool(self: ImGuiStorage, key: int, val: bool) -> None: ...
    # def set_float(self: ImGuiStorage, key: int, val: float) -> None: ...
    # def set_int(self: ImGuiStorage, key: int, val: int) -> None: ...
    # def set_void_ptr(self: ImGuiStorage, key: int, val: Any) -> None: ...

class ImGuiStorage_ImGuiStoragePair:
    """
    [Internal]
    """
    pass
    # key: int

class ImGuiStyle:
    """
    Global alpha applies to everything in dear imgui.
    """
    # alpha: float
    # """
    # Global alpha applies to everything in dear imgui.
    # """
    # anti_aliased_fill: bool
    # """
    # Enable anti-aliased edges around filled shapes (rounded rectangles, circles, etc.). disable if you are really tight on cpu/gpu. latched at the beginning of the frame (copied to imdrawlist).
    # """
    # anti_aliased_lines: bool
    # """
    # Enable anti-aliased lines/borders. disable if you are really tight on cpu/gpu. latched at the beginning of the frame (copied to imdrawlist).
    # """
    # anti_aliased_lines_use_tex: bool
    # """
    # Enable anti-aliased lines/borders using textures where possible. require backend to render with bilinear filtering (not point/nearest filtering). latched at the beginning of the frame (copied to imdrawlist).
    # """
    # button_text_align: tuple
    # """
    # Alignment of button text when button is larger than text. defaults to (0.5f, 0.5f) (centered).
    # """
    # cell_padding: tuple
    # """
    # Padding within a table cell
    # """
    # child_border_size: float
    # """
    # Thickness of border around child windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
    # """
    # child_rounding: float
    # """
    # Radius of child window corners rounding. set to 0.0f to have rectangular windows.
    # """
    # circle_tessellation_max_error: float
    # """
    # Maximum error (in pixels) allowed when using addcircle()/addcirclefilled() or drawing rounded corner rectangles with no explicit segment count specified. decrease for higher quality but more geometry.
    # """
    # color_button_position: int
    # """
    # Side of the color button in the coloredit4 widget (left/right). defaults to imguidir_right.
    # """
    # colors: tuple
    # columns_min_spacing: float
    # """
    # Minimum horizontal spacing between two columns. preferably > (framepadding.x + 1).
    # """
    # curve_tessellation_tol: float
    # """
    # Tessellation tolerance when using pathbeziercurveto() without a specific number of segments. decrease for highly tessellated curves (higher quality, more polygons), increase to reduce quality.
    # """
    # disabled_alpha: float
    # """
    # Additional alpha multiplier applied by begindisabled(). multiply over current value of alpha.
    # """
    # display_safe_area_padding: tuple
    # """
    # If you cannot see the edges of your screen (e.g. on a tv) increase the safe area padding. apply to popups/tooltips as well regular windows. nb: prefer configuring your tv sets correctly!
    # """
    # display_window_padding: tuple
    # """
    # Window position are clamped to be visible within the display area or monitors by at least this amount. only applies to regular windows.
    # """
    # frame_border_size: float
    # """
    # Thickness of border around frames. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
    # """
    frame_padding: tuple
    """
    Padding within a framed rectangle (used by most widgets).
    """
    # frame_rounding: float
    # """
    # Radius of frame corners rounding. set to 0.0f to have rectangular frame (used by most widgets).
    # """
    # grab_min_size: float
    # """
    # Minimum width/height of a grab box for slider/scrollbar.
    # """
    # grab_rounding: float
    # """
    # Radius of grabs corners rounding. set to 0.0f to have rectangular slider grabs.
    # """
    # indent_spacing: float
    # """
    # Horizontal indentation when e.g. entering a tree node. generally == (fontsize + framepadding.x*2).
    # """
    item_inner_spacing: tuple
    """
    Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label).
    """
    item_spacing: tuple
    """
    Horizontal and vertical spacing between widgets/lines.
    """
    # log_slider_deadzone: float
    # """
    # The size in pixels of the dead-zone around zero on logarithmic sliders that cross zero.
    # """
    # mouse_cursor_scale: float
    # """
    # Scale software rendered mouse cursor (when io.mousedrawcursor is enabled). we apply per-monitor dpi scaling over this scale. may be removed later.
    # """
    # popup_border_size: float
    # """
    # Thickness of border around popup/tooltip windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
    # """
    # popup_rounding: float
    # """
    # Radius of popup window corners rounding. (note that tooltip windows use windowrounding)
    # """
    # scrollbar_rounding: float
    # """
    # Radius of grab corners for scrollbar.
    # """
    # scrollbar_size: float
    # """
    # Width of the vertical scrollbar, height of the horizontal scrollbar.
    # """
    # selectable_text_align: tuple
    # """
    # Alignment of selectable text. defaults to (0.0f, 0.0f) (top-left aligned). it's generally important to keep this left-aligned if you want to lay multiple items on a same line.
    # """
    # separator_text_align: tuple
    # """
    # Alignment of text within the separator. defaults to (0.0f, 0.5f) (left aligned, center).
    # """
    # separator_text_border_size: float
    # """
    # Thickkness of border in separatortext()
    # """
    # separator_text_padding: tuple
    # """
    # Horizontal offset of text from each edge of the separator + spacing on other axis. generally small values. .y is recommended to be == framepadding.y.
    # """
    # tab_border_size: float
    # """
    # Thickness of border around tabs.
    # """
    # tab_min_width_for_close_button: float
    # """
    # Minimum width for close button to appear on an unselected tab when hovered. set to 0.0f to always show when hovering, set to flt_max to never show close button unless selected.
    # """
    # tab_rounding: float
    # """
    # Radius of upper corners of a tab. set to 0.0f to have rectangular tabs.
    # """
    # touch_extra_padding: tuple
    # """
    # Expand reactive bounding box for touch-based system where touch position is not accurate enough. unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. so don't grow this too much!
    # """
    # window_border_size: float
    # """
    # Thickness of border around windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
    # """
    # window_menu_button_position: int
    # """
    # Side of the collapsing/docking button in the title bar (none/left/right). defaults to imguidir_left.
    # """
    # window_min_size: tuple
    # """
    # Minimum window size. this is a global setting. if you want to constrain individual windows, use setnextwindowsizeconstraints().
    # """
    # window_padding: tuple
    # """
    # Padding within a window.
    # """
    # window_rounding: float
    # """
    # Radius of window corners rounding. set to 0.0f to have rectangular windows. large values tend to lead to variety of artifacts and are not recommended.
    # """
    # window_title_align: tuple
    # """
    # Alignment for title bar text. defaults to (0.0f,0.5f) for left-aligned,vertically centered.
    # """
    # def scale_all_sizes(self: ImGuiStyle, scale_factor: float) -> None: ...

class ImGuiTableColumnSortSpecs:
    """
    Sorting specification for one column of a table (sizeof == 12 bytes)
    """
    column_index: int
    """
    Index of the column
    """
    column_user_id: int
    """
    User id of the column (if specified by a tablesetupcolumn() call)
    """
    sort_direction: int
    """
    Imguisortdirection_ascending or imguisortdirection_descending (you can use this or sortsign, whichever is more convenient for your sort function)
    """
    # sort_order: int
    # """
    # Index within parent imguitablesortspecs (always stored in order starting from 0, tables sorted on a single criteria will always have a 0 here)
    # """

class ImGuiTableSortSpecs:
    """
    Sorting specifications for a table (often handling sort specs for a single column, occasionally more)
    Obtained by calling TableGetSortSpecs().
    When 'SpecsDirty == true' you can sort your data. It will be true with sorting specs have changed since last call, or the first time.
    Make sure to set 'SpecsDirty = false' after sorting, else you may wastefully sort your data every frame!
    """
    specs: List[ImGuiTableColumnSortSpecs]
    """
    Pointer to sort spec array.
    """
    specs_count: int
    """
    Sort spec count. most often 1. may be > 1 when imguitableflags_sortmulti is enabled. may be == 0 when imguitableflags_sorttristate is enabled.
    """
    specs_dirty: bool
    """
    Set to true when specs have changed since last time! use this to sort again, then clear the flag.
    """

class ImGuiTextBuffer:
    """
    Helper: Growable text buffer for logging/accumulating text
    (this could be called 'ImGuiTextBuilder' / 'ImGuiStringBuilder')
    """
    pass
    # buf: ImVector_char
    # def append(self: ImGuiTextBuffer, str_: str, str_end: str=None) -> None: ...
    # def appendf(self: ImGuiTextBuffer, fmt: str) -> None: ...
    # def appendfv(self: ImGuiTextBuffer, fmt: str) -> None: ...
    # def begin(self: ImGuiTextBuffer) -> str: ...
    # def c_str(self: ImGuiTextBuffer) -> str: ...
    # def clear(self: ImGuiTextBuffer) -> None: ...
    # def empty(self: ImGuiTextBuffer) -> bool: ...
    # def end(self: ImGuiTextBuffer) -> str:
    #     """
    #     Buf is zero-terminated, so end() will point on the zero-terminator
    #     """
    #     pass

    # def reserve(self: ImGuiTextBuffer, capacity: int) -> None: ...
    # def size(self: ImGuiTextBuffer) -> int: ...

class ImGuiTextFilter:
    """
    Helper: Parse and apply text filters. In format "aaaaa[,bbbb][,ccccc]"
    """
    pass
    # count_grep: int
    # filters: ImVector_ImGuiTextFilter_ImGuiTextRange
    # input_buf: int
    # def build(self: ImGuiTextFilter) -> None: ...
    # def clear(self: ImGuiTextFilter) -> None: ...
    # def draw(self: ImGuiTextFilter, label: str="Filter (inc,-exc)", width: float=0.0) -> bool:
    #     """
    #     Helper calling inputtext+build
    #     """
    #     pass

    # def is_active(self: ImGuiTextFilter) -> bool: ...
    # def pass_filter(self: ImGuiTextFilter, text: str, text_end: str=None) -> bool: ...

class ImGuiTextFilter_ImGuiTextRange:
    """
    [Internal]
    """
    pass
    # b: str
    # e: str
    # def empty(self: ImGuiTextFilter_ImGuiTextRange) -> bool: ...
    # def split(self: ImGuiTextFilter_ImGuiTextRange, separator: int, out: ImVector_ImGuiTextFilter_ImGuiTextRange) -> None: ...

class ImGuiViewport:
    """
    - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
    - With multi-viewport enabled, we extend this concept to have multiple active viewports.
    - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
    - About Main Area vs Work Area:
    - Main Area = entire viewport.
    - Work Area = entire viewport minus sections used by main menu bars (for platform windows), or by task bar (for platform monitor).
    - Windows are generally trying to stay within the Work Area of their host viewport.
    """
    pass
    # dpi_scale: float
    # """
    # 1.0f = 96 dpi = no extra scale.
    # """
    # draw_data: ImDrawData
    # """
    # The imdrawdata corresponding to this viewport. valid after render() and until the next call to newframe().
    # """
    # flags: int
    # """
    # See imguiviewportflags_
    # """
    # id: int
    # """
    # Unique identifier for the viewport
    # """
    # parent_viewport_id: int
    # """
    # (advanced) 0: no parent. instruct the platform backend to setup a parent/child relationship between platform windows.
    # """
    # platform_handle: Any
    # """
    # Void* for findviewportbyplatformhandle(). (e.g. suggested to use natural platform handle such as hwnd, glfwwindow*, sdl_window*)
    # """
    # platform_handle_raw: Any
    # """
    # Void* to hold lower-level, platform-native window handle (under win32 this is expected to be a hwnd, unused for other platforms), when using an abstraction layer like glfw or sdl (where platformhandle would be a sdl_window*)
    # """
    # platform_request_close: bool
    # """
    # Platform window requested closure (e.g. window was moved by the os / host window manager, e.g. pressing alt-f4)
    # """
    # platform_request_move: bool
    # """
    # Platform window requested move (e.g. window was moved by the os / host window manager, authoritative position will be os window position)
    # """
    # platform_request_resize: bool
    # """
    # Platform window requested resize (e.g. window was resized by the os / host window manager, authoritative size will be os window size)
    # """
    # platform_user_data: Any
    # """
    # Void* to hold custom data structure for the os / platform (e.g. windowing info, render context). generally set by your platform_createwindow function.
    # """
    # platform_window_created: bool
    # """
    # Platform window has been created (platform_createwindow() has been called). this is false during the first frame where a viewport is being created.
    # """
    # pos: tuple
    # """
    # Main area: position of the viewport (dear imgui coordinates are the same as os desktop/native coordinates)
    # """
    # renderer_user_data: Any
    # """
    # Platform/Backend Dependent Data
    # Our design separate the Renderer and Platform backends to facilitate combining default backends with each others.
    # When our create your own backend for a custom engine, it is possible that both Renderer and Platform will be handled
    # by the same system and you may not need to use all the UserData/Handle fields.
    # The library never uses those fields, they are merely storage to facilitate backend implementation.
    # Void* to hold custom data structure for the renderer (e.g. swap chain, framebuffers etc.). generally set by your renderer_createwindow function.
    # """
    # size: tuple
    # """
    # Main area: size of the viewport.
    # """
    # work_pos: tuple
    # """
    # Work area: position of the viewport minus task bars, menus bars, status bars (>= pos)
    # """
    # work_size: tuple
    # """
    # Work area: size of the viewport minus task bars, menu bars, status bars (<= size)
    # """
    # def get_center(self: ImGuiViewport) -> tuple:
    #     """
    #     Helpers
    #     """
    #     pass

    # def get_work_center(self: ImGuiViewport) -> tuple: ...

class ImGuiWindowClass:
    """
    [ALPHA] Rarely used / very advanced uses only. Use with SetNextWindowClass() and DockSpace() functions.
    Important: the content of this class is still highly WIP and likely to change and be refactored
    before we stabilize Docking features. Please be mindful if using this.
    Provide hints:
    - To the platform backend via altered viewport flags (enable/disable OS decoration, OS task bar icons, etc.)
    - To the platform backend for OS level parent/child relationships of viewport.
    - To the docking system for various options and filtering.
    """
    pass
    # class_id: int
    # """
    # User data. 0 = default class (unclassed). windows of different classes cannot be docked with each others.
    # """
    # dock_node_flags_override_set: int
    # """
    # [experimental] dock node flags to set when a window of this class is hosted by a dock node (it doesn't have to be selected!)
    # """
    # docking_allow_unclassed: bool
    # """
    # Set to true to allow windows of this class to be docked/merged with an unclassed window. // fixme-dock: move to docknodeflags override?
    # """
    # docking_always_tab_bar: bool
    # """
    # Set to true to enforce single floating windows of this class always having their own docking node (equivalent of setting the global io.configdockingalwaystabbar)
    # """
    # parent_viewport_id: int
    # """
    # Hint for the platform backend. -1: use default. 0: request platform backend to not parent the platform. != 0: request platform backend to create a parent<>child relationship between the platform windows. not conforming backends are free to e.g. parent every viewport to the main viewport or not.
    # """
    # tab_item_flags_override_set: int
    # """
    # [experimental] tabitem flags to set when a window of this class gets submitted into a dock node tab bar. may use with imguitabitemflags_leading or imguitabitemflags_trailing.
    # """
    # viewport_flags_override_clear: int
    # """
    # Viewport flags to clear when a window of this class owns a viewport. this allows you to enforce os decoration or task bar icon, override the defaults on a per-window basis.
    # """
    # viewport_flags_override_set: int
    # """
    # Viewport flags to set when a window of this class owns a viewport. this allows you to enforce os decoration or task bar icon, override the defaults on a per-window basis.
    # """

class ImVec2: ...
    # x: float
    # y: float

class ImVec4:
    """
    ImVec4: 4D vector used to store clipping rectangles, colors etc. [Compile-time configurable type]
    """
    pass
    # w: float
    # x: float
    # y: float
    # z: float

class ImVector_ImDrawChannel: ...
    # capacity: int
    # data: ImDrawChannel
    # size: int

class ImVector_ImDrawCmd: ...
    # capacity: int
    # data: ImDrawCmd
    # size: int

class ImVector_ImDrawIdx:
    # capacity: int
    data: int
    size: int

class ImVector_ImDrawVert:
    # capacity: int
    data: ImDrawVert
    size: int

class ImVector_ImFontAtlasCustomRect: ...
    # capacity: int
    # data: ImFontAtlasCustomRect
    # size: int

class ImVector_ImFontConfig: ...
    # capacity: int
    # data: ImFontConfig
    # size: int

class ImVector_ImFontGlyph: ...
    # capacity: int
    # data: ImFontGlyph
    # size: int

class ImVector_ImFontPtr: ...
    # capacity: int
    # data: ImFont
    # size: int

class ImVector_ImGuiPlatformMonitor: ...
    # capacity: int
    # data: ImGuiPlatformMonitor
    # size: int

class ImVector_ImGuiStorage_ImGuiStoragePair: ...
    # capacity: int
    # data: ImGuiStorage_ImGuiStoragePair
    # size: int

class ImVector_ImGuiTextFilter_ImGuiTextRange: ...
    # capacity: int
    # data: ImGuiTextFilter_ImGuiTextRange
    # size: int

class ImVector_ImGuiViewportPtr: ...
    # capacity: int
    # data: ImGuiViewport
    # size: int

class ImVector_ImTextureID: ...
    # capacity: int
    # data: Any
    # size: int

class ImVector_ImU32: ...
    # capacity: int
    # data: int
    # size: int

class ImVector_ImVec2: ...
    # capacity: int
    # data: ImVec2
    # size: int

class ImVector_ImVec4: ...
    # capacity: int
    # data: ImVec4
    # size: int

class ImVector_ImWchar: ...
    # capacity: int
    # data: int
    # size: int

class ImVector_char: ...
    # capacity: int
    # data: str
    # size: int

class ImVector_float: ...
    # capacity: int
    # data: FloatPtr
    # size: int

