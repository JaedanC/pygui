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
WINDOW_FLAGS_NO_TITLE_BAR: int                    # Disable title-bar
WINDOW_FLAGS_NO_RESIZE: int                       # Disable user resizing with the lower-right grip
WINDOW_FLAGS_NO_MOVE: int                         # Disable user moving the window
WINDOW_FLAGS_NO_SCROLLBAR: int                    # Disable scrollbars (window can still scroll with mouse or programmatically)
WINDOW_FLAGS_NO_SCROLL_WITH_MOUSE: int            # Disable user vertically scrolling with mouse wheel. on child window, mouse wheel will be forwarded to the parent unless noscrollbar is also set.
WINDOW_FLAGS_NO_COLLAPSE: int                     # Disable user collapsing window by double-clicking on it. also referred to as window menu button (e.g. within a docking node).
WINDOW_FLAGS_ALWAYS_AUTO_RESIZE: int              # Resize every window to its content every frame
WINDOW_FLAGS_NO_BACKGROUND: int                   # Disable drawing background color (windowbg, etc.) and outside border. similar as using setnextwindowbgalpha(0.0f).
WINDOW_FLAGS_NO_SAVED_SETTINGS: int               # Never load/save settings in .ini file
WINDOW_FLAGS_NO_MOUSE_INPUTS: int                 # Disable catching mouse, hovering test with pass through.
WINDOW_FLAGS_MENU_BAR: int                        # Has a menu-bar
WINDOW_FLAGS_HORIZONTAL_SCROLLBAR: int            # Allow horizontal scrollbar to appear (off by default). you may use setnextwindowcontentsize(imvec2(width,0.0f)); prior to calling begin() to specify width. read code in imgui_demo in the 'horizontal scrolling' section.
WINDOW_FLAGS_NO_FOCUS_ON_APPEARING: int           # Disable taking focus when transitioning from hidden to visible state
WINDOW_FLAGS_NO_BRING_TO_FRONT_ON_FOCUS: int      # Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus)
WINDOW_FLAGS_ALWAYS_VERTICAL_SCROLLBAR: int       # Always show vertical scrollbar (even if contentsize.y < size.y)
WINDOW_FLAGS_ALWAYS_HORIZONTAL_SCROLLBAR: int     # Always show horizontal scrollbar (even if contentsize.x < size.x)
WINDOW_FLAGS_NO_NAV_INPUTS: int                   # No keyboard/gamepad navigation within the window
WINDOW_FLAGS_NO_NAV_FOCUS: int                    # No focusing toward this window with keyboard/gamepad navigation (e.g. skipped by ctrl+tab)
WINDOW_FLAGS_UNSAVED_DOCUMENT: int                # Display a dot next to the title. when used in a tab/docking context, tab is selected when clicking the x + closure is not assumed (will wait for user to stop submitting the tab). otherwise closure is assumed when pressing the x, so if you keep submitting the tab may reappear at end of tab bar.
WINDOW_FLAGS_NO_DOCKING: int                      # Disable docking of this window
WINDOW_FLAGS_NO_NAV: int
WINDOW_FLAGS_NO_DECORATION: int
WINDOW_FLAGS_NO_INPUTS: int
WINDOW_FLAGS_CHILD_WINDOW: int                    # Don't use! for internal use by beginchild()
WINDOW_FLAGS_TOOLTIP: int                         # Don't use! for internal use by begintooltip()
WINDOW_FLAGS_POPUP: int                           # Don't use! for internal use by beginpopup()
WINDOW_FLAGS_MODAL: int                           # Don't use! for internal use by beginpopupmodal()
WINDOW_FLAGS_CHILD_MENU: int                      # Don't use! for internal use by beginmenu()
WINDOW_FLAGS_DOCK_NODE_HOST: int                  # Don't use! for internal use by begin()/newframe()
CHILD_FLAGS_NONE: int
CHILD_FLAGS_BORDERS: int                       # Show an outer border and enable windowpadding. (important: this is always == 1 == true for legacy reason)
CHILD_FLAGS_ALWAYS_USE_WINDOW_PADDING: int     # Pad with style.windowpadding even if no border are drawn (no padding by default for non-bordered child windows because it makes more sense)
CHILD_FLAGS_RESIZE_X: int                      # Allow resize from right border (layout direction). enable .ini saving (unless imguiwindowflags_nosavedsettings passed to window flags)
CHILD_FLAGS_RESIZE_Y: int                      # Allow resize from bottom border (layout direction). '
CHILD_FLAGS_AUTO_RESIZE_X: int                 # Enable auto-resizing width. read 'important: size measurement' details above.
CHILD_FLAGS_AUTO_RESIZE_Y: int                 # Enable auto-resizing height. read 'important: size measurement' details above.
CHILD_FLAGS_ALWAYS_AUTO_RESIZE: int            # Combined with autoresizex/autoresizey. always measure size even when child is hidden, always return true, always disable clipping optimization! not recommended.
CHILD_FLAGS_FRAME_STYLE: int                   # Style the child window like a framed item: use framebg, framerounding, framebordersize, framepadding instead of childbg, childrounding, childbordersize, windowpadding.
CHILD_FLAGS_NAV_FLATTENED: int                 # [beta] share focus scope, allow keyboard/gamepad navigation to cross over parent border to this child or between sibling child windows.
ITEM_FLAGS_NONE: int                     # (default)
ITEM_FLAGS_NO_TAB_STOP: int              # False    // disable keyboard tabbing. this is a 'lighter' version of imguiitemflags_nonav.
ITEM_FLAGS_NO_NAV: int                   # False    // disable any form of focusing (keyboard/gamepad directional navigation and setkeyboardfocushere() calls).
ITEM_FLAGS_NO_NAV_DEFAULT_FOCUS: int     # False    // disable item being a candidate for default focus (e.g. used by title bar items).
ITEM_FLAGS_BUTTON_REPEAT: int            # False    // any button-like behavior will have repeat mode enabled (based on io.keyrepeatdelay and io.keyrepeatrate values). note that you can also call isitemactive() after any button to tell if it is being held.
ITEM_FLAGS_AUTO_CLOSE_POPUPS: int        # True     // menuitem()/selectable() automatically close their parent popup window.
ITEM_FLAGS_ALLOW_DUPLICATE_ID: int       # False    // allow submitting an item with the same identifier as an item already submitted this frame without triggering a warning tooltip if io.configdebughighlightidconflicts is set.
INPUT_TEXT_FLAGS_NONE: int
INPUT_TEXT_FLAGS_CHARS_DECIMAL: int               # Allow 0123456789.+-*/
INPUT_TEXT_FLAGS_CHARS_HEXADECIMAL: int           # Allow 0123456789abcdefabcdef
INPUT_TEXT_FLAGS_CHARS_SCIENTIFIC: int            # Allow 0123456789.+-*/ee (scientific notation input)
INPUT_TEXT_FLAGS_CHARS_UPPERCASE: int             # Turn a..z into a..z
INPUT_TEXT_FLAGS_CHARS_NO_BLANK: int              # Filter out spaces, tabs
INPUT_TEXT_FLAGS_ALLOW_TAB_INPUT: int             # Pressing tab input a '\t' character into the text field
INPUT_TEXT_FLAGS_ENTER_RETURNS_TRUE: int          # Return 'true' when enter is pressed (as opposed to every time the value was modified). consider using isitemdeactivatedafteredit() instead!
INPUT_TEXT_FLAGS_ESCAPE_CLEARS_ALL: int           # Escape key clears content if not empty, and deactivate otherwise (contrast to default behavior of escape to revert)
INPUT_TEXT_FLAGS_CTRL_ENTER_FOR_NEW_LINE: int     # In multi-line mode, validate with enter, add new line with ctrl+enter (default is opposite: validate with ctrl+enter, add line with enter).
INPUT_TEXT_FLAGS_READ_ONLY: int                   # Read-only mode
INPUT_TEXT_FLAGS_PASSWORD: int                    # Password mode, display all characters as '*', disable copy
INPUT_TEXT_FLAGS_ALWAYS_OVERWRITE: int            # Overwrite mode
INPUT_TEXT_FLAGS_AUTO_SELECT_ALL: int             # Select entire text when first taking mouse focus
INPUT_TEXT_FLAGS_PARSE_EMPTY_REF_VAL: int         # Inputfloat(), inputint(), inputscalar() etc. only: parse empty string as zero value.
INPUT_TEXT_FLAGS_DISPLAY_EMPTY_REF_VAL: int       # Inputfloat(), inputint(), inputscalar() etc. only: when value is zero, do not display it. generally used with imguiinputtextflags_parseemptyrefval.
INPUT_TEXT_FLAGS_NO_HORIZONTAL_SCROLL: int        # Disable following the cursor horizontally
INPUT_TEXT_FLAGS_NO_UNDO_REDO: int                # Disable undo/redo. note that input text owns the text data while active, if you want to provide your own undo/redo stack you need e.g. to call clearactiveid().
INPUT_TEXT_FLAGS_CALLBACK_COMPLETION: int         # Callback on pressing tab (for completion handling)
INPUT_TEXT_FLAGS_CALLBACK_HISTORY: int            # Callback on pressing up/down arrows (for history handling)
INPUT_TEXT_FLAGS_CALLBACK_ALWAYS: int             # Callback on each iteration. user code may query cursor position, modify text buffer.
INPUT_TEXT_FLAGS_CALLBACK_CHAR_FILTER: int        # Callback on character inputs to replace or discard them. modify 'eventchar' to replace or discard, or return 1 in callback to discard.
INPUT_TEXT_FLAGS_CALLBACK_RESIZE: int             # Callback on buffer capacity changes request (beyond 'buf_size' parameter value), allowing the string to grow. notify when the string wants to be resized (for string types which hold a cache of their size). you will be provided a new bufsize in the callback and need to honor it. (see misc/cpp/imgui_stdlib.h for an example of using this)
INPUT_TEXT_FLAGS_CALLBACK_EDIT: int               # Callback on any edit (note that inputtext() already returns true on edit, the callback is useful mainly to manipulate the underlying buffer while focus is active)
TREE_NODE_FLAGS_NONE: int
TREE_NODE_FLAGS_SELECTED: int                     # Draw as selected
TREE_NODE_FLAGS_FRAMED: int                       # Draw frame with background (e.g. for collapsingheader)
TREE_NODE_FLAGS_ALLOW_OVERLAP: int                # Hit testing to allow subsequent widgets to overlap this one
TREE_NODE_FLAGS_NO_TREE_PUSH_ON_OPEN: int         # Don't do a treepush() when open (e.g. for collapsingheader) = no extra indent nor pushing on id stack
TREE_NODE_FLAGS_NO_AUTO_OPEN_ON_LOG: int          # Don't automatically and temporarily open node when logging is active (by default logging will automatically open tree nodes)
TREE_NODE_FLAGS_DEFAULT_OPEN: int                 # Default node to be open
TREE_NODE_FLAGS_OPEN_ON_DOUBLE_CLICK: int         # Open on double-click instead of simple click (default for multi-select unless any _openonxxx behavior is set explicitly). both behaviors may be combined.
TREE_NODE_FLAGS_OPEN_ON_ARROW: int                # Open when clicking on the arrow part (default for multi-select unless any _openonxxx behavior is set explicitly). both behaviors may be combined.
TREE_NODE_FLAGS_LEAF: int                         # No collapsing, no arrow (use as a convenience for leaf nodes).
TREE_NODE_FLAGS_BULLET: int                       # Display a bullet instead of arrow. important: node can still be marked open/close if you don't set the _leaf flag!
TREE_NODE_FLAGS_FRAME_PADDING: int                # Use framepadding (even for an unframed text node) to vertically align text baseline to regular widget height. equivalent to calling aligntexttoframepadding() before the node.
TREE_NODE_FLAGS_SPAN_AVAIL_WIDTH: int             # Extend hit box to the right-most edge, even if not framed. this is not the default in order to allow adding other items on the same line without using allowoverlap mode.
TREE_NODE_FLAGS_SPAN_FULL_WIDTH: int              # Extend hit box to the left-most and right-most edges (cover the indent area).
TREE_NODE_FLAGS_SPAN_TEXT_WIDTH: int              # Narrow hit box + narrow hovering highlight, will only cover the label text.
TREE_NODE_FLAGS_SPAN_ALL_COLUMNS: int             # Frame will span all columns of its container table (text will still fit in current column)
TREE_NODE_FLAGS_NAV_LEFT_JUMPS_BACK_HERE: int     # (wip) nav: left direction may move to this treenode() from any of its child (items submitted between treenode and treepop)
TREE_NODE_FLAGS_COLLAPSING_HEADER: int
POPUP_FLAGS_NONE: int
POPUP_FLAGS_MOUSE_BUTTON_LEFT: int               # For beginpopupcontext*(): open on left mouse release. guaranteed to always be == 0 (same as imguimousebutton_left)
POPUP_FLAGS_MOUSE_BUTTON_RIGHT: int              # For beginpopupcontext*(): open on right mouse release. guaranteed to always be == 1 (same as imguimousebutton_right)
POPUP_FLAGS_MOUSE_BUTTON_MIDDLE: int             # For beginpopupcontext*(): open on middle mouse release. guaranteed to always be == 2 (same as imguimousebutton_middle)
POPUP_FLAGS_MOUSE_BUTTON_MASK: int
POPUP_FLAGS_MOUSE_BUTTON_DEFAULT: int
POPUP_FLAGS_NO_REOPEN: int                       # For openpopup*(), beginpopupcontext*(): don't reopen same popup if already open (won't reposition, won't reinitialize navigation)
POPUP_FLAGS_NO_OPEN_OVER_EXISTING_POPUP: int     # For openpopup*(), beginpopupcontext*(): don't open if there's already a popup at the same level of the popup stack
POPUP_FLAGS_NO_OPEN_OVER_ITEMS: int              # For beginpopupcontextwindow(): don't return true when hovering items, only when hovering empty space
POPUP_FLAGS_ANY_POPUP_ID: int                    # For ispopupopen(): ignore the imguiid parameter and test for any popup.
POPUP_FLAGS_ANY_POPUP_LEVEL: int                 # For ispopupopen(): search/test at any level of the popup stack (default test in the current level)
POPUP_FLAGS_ANY_POPUP: int
SELECTABLE_FLAGS_NONE: int
SELECTABLE_FLAGS_NO_AUTO_CLOSE_POPUPS: int     # Clicking this doesn't close parent popup window (overrides imguiitemflags_autoclosepopups)
SELECTABLE_FLAGS_SPAN_ALL_COLUMNS: int         # Frame will span all columns of its container table (text will still fit in current column)
SELECTABLE_FLAGS_ALLOW_DOUBLE_CLICK: int       # Generate press events on double clicks too
SELECTABLE_FLAGS_DISABLED: int                 # Cannot be selected, display grayed out text
SELECTABLE_FLAGS_ALLOW_OVERLAP: int            # (wip) hit testing to allow subsequent widgets to overlap this one
SELECTABLE_FLAGS_HIGHLIGHT: int                # Make the item be displayed as if it is hovered
COMBO_FLAGS_NONE: int
COMBO_FLAGS_POPUP_ALIGN_LEFT: int      # Align the popup toward the left by default
COMBO_FLAGS_HEIGHT_SMALL: int          # Max ~4 items visible. tip: if you want your combo popup to be a specific size you can use setnextwindowsizeconstraints() prior to calling begincombo()
COMBO_FLAGS_HEIGHT_REGULAR: int        # Max ~8 items visible (default)
COMBO_FLAGS_HEIGHT_LARGE: int          # Max ~20 items visible
COMBO_FLAGS_HEIGHT_LARGEST: int        # As many fitting items as possible
COMBO_FLAGS_NO_ARROW_BUTTON: int       # Display on the preview box without the square arrow button
COMBO_FLAGS_NO_PREVIEW: int            # Display only a square arrow button
COMBO_FLAGS_WIDTH_FIT_PREVIEW: int     # Width dynamically calculated from preview contents
COMBO_FLAGS_HEIGHT_MASK: int
TAB_BAR_FLAGS_NONE: int
TAB_BAR_FLAGS_REORDERABLE: int                           # Allow manually dragging tabs to re-order them + new tabs are appended at the end of list
TAB_BAR_FLAGS_AUTO_SELECT_NEW_TABS: int                  # Automatically select new tabs when they appear
TAB_BAR_FLAGS_TAB_LIST_POPUP_BUTTON: int                 # Disable buttons to open the tab list popup
TAB_BAR_FLAGS_NO_CLOSE_WITH_MIDDLE_MOUSE_BUTTON: int     # Disable behavior of closing tabs (that are submitted with p_open != null) with middle mouse button. you may handle this behavior manually on user's side with if (isitemhovered() && ismouseclicked(2)) *p_open = false.
TAB_BAR_FLAGS_NO_TAB_LIST_SCROLLING_BUTTONS: int         # Disable scrolling buttons (apply when fitting policy is imguitabbarflags_fittingpolicyscroll)
TAB_BAR_FLAGS_NO_TOOLTIP: int                            # Disable tooltips when hovering a tab
TAB_BAR_FLAGS_DRAW_SELECTED_OVERLINE: int                # Draw selected overline markers over selected tab
TAB_BAR_FLAGS_FITTING_POLICY_RESIZE_DOWN: int            # Resize tabs when they don't fit
TAB_BAR_FLAGS_FITTING_POLICY_SCROLL: int                 # Add scroll buttons when tabs don't fit
TAB_BAR_FLAGS_FITTING_POLICY_MASK: int
TAB_BAR_FLAGS_FITTING_POLICY_DEFAULT: int
TAB_ITEM_FLAGS_NONE: int
TAB_ITEM_FLAGS_UNSAVED_DOCUMENT: int                      # Display a dot next to the title + set imguitabitemflags_noassumedclosure.
TAB_ITEM_FLAGS_SET_SELECTED: int                          # Trigger flag to programmatically make the tab selected when calling begintabitem()
TAB_ITEM_FLAGS_NO_CLOSE_WITH_MIDDLE_MOUSE_BUTTON: int     # Disable behavior of closing tabs (that are submitted with p_open != null) with middle mouse button. you may handle this behavior manually on user's side with if (isitemhovered() && ismouseclicked(2)) *p_open = false.
TAB_ITEM_FLAGS_NO_PUSH_ID: int                            # Don't call pushid()/popid() on begintabitem()/endtabitem()
TAB_ITEM_FLAGS_NO_TOOLTIP: int                            # Disable tooltip for the given tab
TAB_ITEM_FLAGS_NO_REORDER: int                            # Disable reordering this tab or having another tab cross over this tab
TAB_ITEM_FLAGS_LEADING: int                               # Enforce the tab position to the left of the tab bar (after the tab list popup button)
TAB_ITEM_FLAGS_TRAILING: int                              # Enforce the tab position to the right of the tab bar (before the scrolling buttons)
TAB_ITEM_FLAGS_NO_ASSUMED_CLOSURE: int                    # Tab is selected when trying to close + closure is not immediately assumed (will wait for user to stop submitting the tab). otherwise closure is assumed when pressing the x, so if you keep submitting the tab may reappear at end of tab bar.
FOCUSED_FLAGS_NONE: int
FOCUSED_FLAGS_CHILD_WINDOWS: int              # Return true if any children of the window is focused
FOCUSED_FLAGS_ROOT_WINDOW: int                # Test from root window (top most parent of the current hierarchy)
FOCUSED_FLAGS_ANY_WINDOW: int                 # Return true if any window is focused. important: if you are trying to tell how to dispatch your low-level inputs, do not use this. use 'io.wantcapturemouse' instead! please read the faq!
FOCUSED_FLAGS_NO_POPUP_HIERARCHY: int         # Do not consider popup hierarchy (do not treat popup emitter as parent of popup) (when used with _childwindows or _rootwindow)
FOCUSED_FLAGS_DOCK_HIERARCHY: int             # Consider docking hierarchy (treat dockspace host as parent of docked window) (when used with _childwindows or _rootwindow)
FOCUSED_FLAGS_ROOT_AND_CHILD_WINDOWS: int
HOVERED_FLAGS_NONE: int                                  # Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
HOVERED_FLAGS_CHILD_WINDOWS: int                         # Iswindowhovered() only: return true if any children of the window is hovered
HOVERED_FLAGS_ROOT_WINDOW: int                           # Iswindowhovered() only: test from root window (top most parent of the current hierarchy)
HOVERED_FLAGS_ANY_WINDOW: int                            # Iswindowhovered() only: return true if any window is hovered
HOVERED_FLAGS_NO_POPUP_HIERARCHY: int                    # Iswindowhovered() only: do not consider popup hierarchy (do not treat popup emitter as parent of popup) (when used with _childwindows or _rootwindow)
HOVERED_FLAGS_DOCK_HIERARCHY: int                        # Iswindowhovered() only: consider docking hierarchy (treat dockspace host as parent of docked window) (when used with _childwindows or _rootwindow)
HOVERED_FLAGS_ALLOW_WHEN_BLOCKED_BY_POPUP: int           # Return true even if a popup window is normally blocking access to this item/window
HOVERED_FLAGS_ALLOW_WHEN_BLOCKED_BY_ACTIVE_ITEM: int     # Return true even if an active item is blocking access to this item/window. useful for drag and drop patterns.
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED_BY_ITEM: int         # Isitemhovered() only: return true even if the item uses allowoverlap mode and is overlapped by another hoverable item.
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED_BY_WINDOW: int       # Isitemhovered() only: return true even if the position is obstructed or overlapped by another window.
HOVERED_FLAGS_ALLOW_WHEN_DISABLED: int                   # Isitemhovered() only: return true even if the item is disabled
HOVERED_FLAGS_NO_NAV_OVERRIDE: int                       # Isitemhovered() only: disable using keyboard/gamepad navigation state when active, always query mouse
HOVERED_FLAGS_ALLOW_WHEN_OVERLAPPED: int
HOVERED_FLAGS_RECT_ONLY: int
HOVERED_FLAGS_ROOT_AND_CHILD_WINDOWS: int
HOVERED_FLAGS_FOR_TOOLTIP: int                           # Shortcut for standard flags when using isitemhovered() + settooltip() sequence.
HOVERED_FLAGS_STATIONARY: int                            # Require mouse to be stationary for style.hoverstationarydelay (~0.15 sec) _at least one time_. after this, can move on same item/window. using the stationary test tends to reduces the need for a long delay.
HOVERED_FLAGS_DELAY_NONE: int                            # Isitemhovered() only: return true immediately (default). as this is the default you generally ignore this.
HOVERED_FLAGS_DELAY_SHORT: int                           # Isitemhovered() only: return true after style.hoverdelayshort elapsed (~0.15 sec) (shared between items) + requires mouse to be stationary for style.hoverstationarydelay (once per item).
HOVERED_FLAGS_DELAY_NORMAL: int                          # Isitemhovered() only: return true after style.hoverdelaynormal elapsed (~0.40 sec) (shared between items) + requires mouse to be stationary for style.hoverstationarydelay (once per item).
HOVERED_FLAGS_NO_SHARED_DELAY: int                       # Isitemhovered() only: disable shared delay system where moving from one item to the next keeps the previous timer for a short time (standard for tooltips with long delays)
DOCK_NODE_FLAGS_NONE: int
DOCK_NODE_FLAGS_KEEP_ALIVE_ONLY: int                  # Don't display the dockspace node but keep it alive. windows docked into this dockspace node won't be undocked.
DOCK_NODE_FLAGS_NO_DOCKING_OVER_CENTRAL_NODE: int     # Disable docking over the central node, which will be always kept empty.
DOCK_NODE_FLAGS_PASSTHRU_CENTRAL_NODE: int            # Enable passthru dockspace: 1) dockspace() will render a imguicol_windowbg background covering everything excepted the central node when empty. meaning the host window should probably use setnextwindowbgalpha(0.0f) prior to begin() when using this. 2) when central node is empty: let inputs pass-through + won't display a dockingemptybg background. see demo for details.
DOCK_NODE_FLAGS_NO_DOCKING_SPLIT: int                 # Disable other windows/nodes from splitting this node.
DOCK_NODE_FLAGS_NO_RESIZE: int                        # Saved // disable resizing node using the splitter/separators. useful with programmatically setup dockspaces.
DOCK_NODE_FLAGS_AUTO_HIDE_TAB_BAR: int                # Tab bar will automatically hide when there is a single window in the dock node.
DOCK_NODE_FLAGS_NO_UNDOCKING: int                     # Disable undocking this node.
DRAG_DROP_FLAGS_NONE: int
DRAG_DROP_FLAGS_SOURCE_NO_PREVIEW_TOOLTIP: int         # Disable preview tooltip. by default, a successful call to begindragdropsource opens a tooltip so you can display a preview or description of the source contents. this flag disables this behavior.
DRAG_DROP_FLAGS_SOURCE_NO_DISABLE_HOVER: int           # By default, when dragging we clear data so that isitemhovered() will return false, to avoid subsequent user code submitting tooltips. this flag disables this behavior so you can still call isitemhovered() on the source item.
DRAG_DROP_FLAGS_SOURCE_NO_HOLD_TO_OPEN_OTHERS: int     # Disable the behavior that allows to open tree nodes and collapsing header by holding over them while dragging a source item.
DRAG_DROP_FLAGS_SOURCE_ALLOW_NULL_ID: int              # Allow items such as text(), image() that have no unique identifier to be used as drag source, by manufacturing a temporary identifier based on their window-relative position. this is extremely unusual within the dear imgui ecosystem and so we made it explicit.
DRAG_DROP_FLAGS_SOURCE_EXTERN: int                     # External source (from outside of dear imgui), won't attempt to read current item/window info. will always return true. only one extern source can be active simultaneously.
DRAG_DROP_FLAGS_PAYLOAD_AUTO_EXPIRE: int               # Automatically expire the payload if the source cease to be submitted (otherwise payloads are persisting while being dragged)
DRAG_DROP_FLAGS_PAYLOAD_NO_CROSS_CONTEXT: int          # Hint to specify that the payload may not be copied outside current dear imgui context.
DRAG_DROP_FLAGS_PAYLOAD_NO_CROSS_PROCESS: int          # Hint to specify that the payload may not be copied outside current process.
DRAG_DROP_FLAGS_ACCEPT_BEFORE_DELIVERY: int            # Acceptdragdroppayload() will returns true even before the mouse button is released. you can then call isdelivery() to test if the payload needs to be delivered.
DRAG_DROP_FLAGS_ACCEPT_NO_DRAW_DEFAULT_RECT: int       # Do not draw the default highlight rectangle when hovering over target.
DRAG_DROP_FLAGS_ACCEPT_NO_PREVIEW_TOOLTIP: int         # Request hiding the begindragdropsource tooltip from the begindragdroptarget site.
DRAG_DROP_FLAGS_ACCEPT_PEEK_ONLY: int                  # For peeking ahead and inspecting the payload before delivery.
DATA_TYPE_S8: int         # Signed char / char (with sensible compilers)
DATA_TYPE_U8: int         # Unsigned char
DATA_TYPE_S16: int        # Short
DATA_TYPE_U16: int        # Unsigned short
DATA_TYPE_S32: int        # Int
DATA_TYPE_U32: int        # Unsigned int
DATA_TYPE_S64: int        # Long long / __int64
DATA_TYPE_U64: int        # Unsigned long long / unsigned __int64
DATA_TYPE_FLOAT: int      # Float
DATA_TYPE_DOUBLE: int     # Double
DATA_TYPE_BOOL: int       # Bool (provided for user convenience, not supported by scalar widgets)
DATA_TYPE_COUNT: int
DIR_NONE: int
DIR_LEFT: int
DIR_RIGHT: int
DIR_UP: int
DIR_DOWN: int
DIR_COUNT: int
SORT_DIRECTION_NONE: int
SORT_DIRECTION_ASCENDING: int      # Ascending = 0->9, a->z etc.
SORT_DIRECTION_DESCENDING: int     # Descending = 9->0, z->a etc.
KEY_NONE: int
KEY_NAMED_KEY_BEGIN: int            # First valid key value (other than 0)
KEY_TAB: int                        # == imguikey_namedkey_begin
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
KEY_APOSTROPHE: int                 # '
KEY_COMMA: int                      # ,
KEY_MINUS: int                      # -
KEY_PERIOD: int                     # .
KEY_SLASH: int                      # 
KEY_SEMICOLON: int                  # ;
KEY_EQUAL: int                      # =
KEY_LEFT_BRACKET: int               # [
KEY_BACKSLASH: int                  # \ (this text inhibit multiline comment caused by backslash)
KEY_RIGHT_BRACKET: int              # ]
KEY_GRAVE_ACCENT: int               # `
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
KEY_APP_BACK: int                   # Available on some keyboard/mouses. often referred as 'browser back'
KEY_APP_FORWARD: int
KEY_GAMEPAD_START: int              # Menu (xbox)      + (switch)   start/options (ps)
KEY_GAMEPAD_BACK: int               # View (xbox)      - (switch)   share (ps)
KEY_GAMEPAD_FACE_LEFT: int          # X (xbox)         y (switch)   square (ps)        // tap: toggle menu. hold: windowing mode (focus/move/resize windows)
KEY_GAMEPAD_FACE_RIGHT: int         # B (xbox)         a (switch)   circle (ps)        // cancel / close / exit
KEY_GAMEPAD_FACE_UP: int            # Y (xbox)         x (switch)   triangle (ps)      // text input / on-screen keyboard
KEY_GAMEPAD_FACE_DOWN: int          # A (xbox)         b (switch)   cross (ps)         // activate / open / toggle / tweak
KEY_GAMEPAD_DPAD_LEFT: int          # D-pad left                                       // move / tweak / resize window (in windowing mode)
KEY_GAMEPAD_DPAD_RIGHT: int         # D-pad right                                      // move / tweak / resize window (in windowing mode)
KEY_GAMEPAD_DPAD_UP: int            # D-pad up                                         // move / tweak / resize window (in windowing mode)
KEY_GAMEPAD_DPAD_DOWN: int          # D-pad down                                       // move / tweak / resize window (in windowing mode)
KEY_GAMEPAD_L1: int                 # L bumper (xbox)  l (switch)   l1 (ps)            // tweak slower / focus previous (in windowing mode)
KEY_GAMEPAD_R1: int                 # R bumper (xbox)  r (switch)   r1 (ps)            // tweak faster / focus next (in windowing mode)
KEY_GAMEPAD_L2: int                 # L trig. (xbox)   zl (switch)  l2 (ps) [analog]
KEY_GAMEPAD_R2: int                 # R trig. (xbox)   zr (switch)  r2 (ps) [analog]
KEY_GAMEPAD_L3: int                 # L stick (xbox)   l3 (switch)  l3 (ps)
KEY_GAMEPAD_R3: int                 # R stick (xbox)   r3 (switch)  r3 (ps)
KEY_GAMEPAD_LSTICK_LEFT: int        # [analog]                                         // move window (in windowing mode)
KEY_GAMEPAD_LSTICK_RIGHT: int       # [analog]                                         // move window (in windowing mode)
KEY_GAMEPAD_LSTICK_UP: int          # [analog]                                         // move window (in windowing mode)
KEY_GAMEPAD_LSTICK_DOWN: int        # [analog]                                         // move window (in windowing mode)
KEY_GAMEPAD_RSTICK_LEFT: int        # [analog]
KEY_GAMEPAD_RSTICK_RIGHT: int       # [analog]
KEY_GAMEPAD_RSTICK_UP: int          # [analog]
KEY_GAMEPAD_RSTICK_DOWN: int        # [analog]
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
KEY_NAMED_KEY_END: int
MOD_NONE: int
MOD_CTRL: int                       # Ctrl (non-macos), cmd (macos)
MOD_SHIFT: int                      # Shift
MOD_ALT: int                        # Option/menu
MOD_SUPER: int                      # Windows/super (non-macos), ctrl (macos)
MOD_MASK: int                       # 4-bits
KEY_NAMED_KEY_COUNT: int
INPUT_FLAGS_NONE: int
INPUT_FLAGS_REPEAT: int                      # Enable repeat. return true on successive repeats. default for legacy iskeypressed(). not default for legacy ismouseclicked(). must be == 1.
INPUT_FLAGS_ROUTE_ACTIVE: int                # Route to active item only.
INPUT_FLAGS_ROUTE_FOCUSED: int               # Route to windows in the focus stack (default). deep-most focused window takes inputs. active item takes inputs over deep-most focused window.
INPUT_FLAGS_ROUTE_GLOBAL: int                # Global route (unless a focused window or active item registered the route).
INPUT_FLAGS_ROUTE_ALWAYS: int                # Do not register route, poll keys directly.
INPUT_FLAGS_ROUTE_OVER_FOCUSED: int          # Option: global route: higher priority than focused route (unless active item in focused route).
INPUT_FLAGS_ROUTE_OVER_ACTIVE: int           # Option: global route: higher priority than active item. unlikely you need to use that: will interfere with every active items, e.g. ctrl+a registered by inputtext will be overridden by this. may not be fully honored as user/internal code is likely to always assume they can access keys when active.
INPUT_FLAGS_ROUTE_UNLESS_BG_FOCUSED: int     # Option: global route: will not be applied if underlying background/void is focused (== no dear imgui windows are focused). useful for overlay applications.
INPUT_FLAGS_ROUTE_FROM_ROOT_WINDOW: int      # Option: route evaluated from the point of view of root window rather than current window.
INPUT_FLAGS_TOOLTIP: int                     # Automatically display a tooltip when hovering item [beta] unsure of right api (opt-in/opt-out)
CONFIG_FLAGS_NONE: int
CONFIG_FLAGS_NAV_ENABLE_KEYBOARD: int            # Master keyboard navigation enable flag. enable full tabbing + directional arrows + space/enter to activate.
CONFIG_FLAGS_NAV_ENABLE_GAMEPAD: int             # Master gamepad navigation enable flag. backend also needs to set imguibackendflags_hasgamepad.
CONFIG_FLAGS_NO_MOUSE: int                       # Instruct dear imgui to disable mouse inputs and interactions.
CONFIG_FLAGS_NO_MOUSE_CURSOR_CHANGE: int         # Instruct backend to not alter mouse cursor shape and visibility. use if the backend cursor changes are interfering with yours and you don't want to use setmousecursor() to change mouse cursor. you may want to honor requests from imgui by reading getmousecursor() yourself instead.
CONFIG_FLAGS_NO_KEYBOARD: int                    # Instruct dear imgui to disable keyboard inputs and interactions. this is done by ignoring keyboard events and clearing existing states.
CONFIG_FLAGS_DOCKING_ENABLE: int                 # Docking enable flags.
CONFIG_FLAGS_VIEWPORTS_ENABLE: int               # Viewport enable flags (require both imguibackendflags_platformhasviewports + imguibackendflags_rendererhasviewports set by the respective backends)
CONFIG_FLAGS_DPI_ENABLE_SCALE_VIEWPORTS: int     # [beta: don't use] fixme-dpi: reposition and resize imgui windows when the dpiscale of a viewport changed (mostly useful for the main viewport hosting other window). note that resizing the main window itself is up to your application.
CONFIG_FLAGS_DPI_ENABLE_SCALE_FONTS: int         # [beta: don't use] fixme-dpi: request bitmap-scaled fonts to match dpiscale. this is a very low-quality workaround. the correct way to handle dpi is _currently_ to replace the atlas and/or fonts in the platform_onchangedviewport callback, but this is all early work in progress.
CONFIG_FLAGS_IS_S_RGB: int                       # Application is srgb-aware.
CONFIG_FLAGS_IS_TOUCH_SCREEN: int                # Application is using a touch screen instead of a mouse.
BACKEND_FLAGS_NONE: int
BACKEND_FLAGS_HAS_GAMEPAD: int                    # Backend platform supports gamepad and currently has one connected.
BACKEND_FLAGS_HAS_MOUSE_CURSORS: int              # Backend platform supports honoring getmousecursor() value to change the os cursor shape.
BACKEND_FLAGS_HAS_SET_MOUSE_POS: int              # Backend platform supports io.wantsetmousepos requests to reposition the os mouse position (only used if io.confignavmovesetmousepos is set).
BACKEND_FLAGS_RENDERER_HAS_VTX_OFFSET: int        # Backend renderer supports imdrawcmd::vtxoffset. this enables output of large meshes (64k+ vertices) while still using 16-bit indices.
BACKEND_FLAGS_PLATFORM_HAS_VIEWPORTS: int         # Backend platform supports multiple viewports.
BACKEND_FLAGS_HAS_MOUSE_HOVERED_VIEWPORT: int     # Backend platform supports calling io.addmouseviewportevent() with the viewport under the mouse. if possible, ignore viewports with the imguiviewportflags_noinputs flag (win32 backend, glfw 3.30+ backend can do this, sdl backend cannot). if this cannot be done, dear imgui needs to use a flawed heuristic to find the viewport under.
BACKEND_FLAGS_RENDERER_HAS_VIEWPORTS: int         # Backend renderer supports multiple viewports.
COL_TEXT: int
COL_TEXT_DISABLED: int
COL_WINDOW_BG: int                        # Background of normal windows
COL_CHILD_BG: int                         # Background of child windows
COL_POPUP_BG: int                         # Background of popups, menus, tooltips windows
COL_BORDER: int
COL_BORDER_SHADOW: int
COL_FRAME_BG: int                         # Background of checkbox, radio button, plot, slider, text input
COL_FRAME_BG_HOVERED: int
COL_FRAME_BG_ACTIVE: int
COL_TITLE_BG: int                         # Title bar
COL_TITLE_BG_ACTIVE: int                  # Title bar when focused
COL_TITLE_BG_COLLAPSED: int               # Title bar when collapsed
COL_MENU_BAR_BG: int
COL_SCROLLBAR_BG: int
COL_SCROLLBAR_GRAB: int
COL_SCROLLBAR_GRAB_HOVERED: int
COL_SCROLLBAR_GRAB_ACTIVE: int
COL_CHECK_MARK: int                       # Checkbox tick and radiobutton circle
COL_SLIDER_GRAB: int
COL_SLIDER_GRAB_ACTIVE: int
COL_BUTTON: int
COL_BUTTON_HOVERED: int
COL_BUTTON_ACTIVE: int
COL_HEADER: int                           # Header* colors are used for collapsingheader, treenode, selectable, menuitem
COL_HEADER_HOVERED: int
COL_HEADER_ACTIVE: int
COL_SEPARATOR: int
COL_SEPARATOR_HOVERED: int
COL_SEPARATOR_ACTIVE: int
COL_RESIZE_GRIP: int                      # Resize grip in lower-right and lower-left corners of windows.
COL_RESIZE_GRIP_HOVERED: int
COL_RESIZE_GRIP_ACTIVE: int
COL_TAB_HOVERED: int                      # Tab background, when hovered
COL_TAB: int                              # Tab background, when tab-bar is focused & tab is unselected
COL_TAB_SELECTED: int                     # Tab background, when tab-bar is focused & tab is selected
COL_TAB_SELECTED_OVERLINE: int            # Tab horizontal overline, when tab-bar is focused & tab is selected
COL_TAB_DIMMED: int                       # Tab background, when tab-bar is unfocused & tab is unselected
COL_TAB_DIMMED_SELECTED: int              # Tab background, when tab-bar is unfocused & tab is selected
COL_TAB_DIMMED_SELECTED_OVERLINE: int     # ..horizontal overline, when tab-bar is unfocused & tab is selected
COL_DOCKING_PREVIEW: int                  # Preview overlay color when about to docking something
COL_DOCKING_EMPTY_BG: int                 # Background color for empty node (e.g. centralnode with no window docked into it)
COL_PLOT_LINES: int
COL_PLOT_LINES_HOVERED: int
COL_PLOT_HISTOGRAM: int
COL_PLOT_HISTOGRAM_HOVERED: int
COL_TABLE_HEADER_BG: int                  # Table header background
COL_TABLE_BORDER_STRONG: int              # Table outer and header borders (prefer using alpha=1.0 here)
COL_TABLE_BORDER_LIGHT: int               # Table inner borders (prefer using alpha=1.0 here)
COL_TABLE_ROW_BG: int                     # Table row background (even rows)
COL_TABLE_ROW_BG_ALT: int                 # Table row background (odd rows)
COL_TEXT_LINK: int                        # Hyperlink color
COL_TEXT_SELECTED_BG: int
COL_DRAG_DROP_TARGET: int                 # Rectangle highlighting a drop target
COL_NAV_CURSOR: int                       # Color of keyboard/gamepad navigation cursor/rectangle, when visible
COL_NAV_WINDOWING_HIGHLIGHT: int          # Highlight window when using ctrl+tab
COL_NAV_WINDOWING_DIM_BG: int             # Darken/colorize entire screen behind the ctrl+tab window list, when active
COL_MODAL_WINDOW_DIM_BG: int              # Darken/colorize entire screen behind a modal window, when one is active
COL_COUNT: int
STYLE_VAR_ALPHA: int                               # Float     alpha
STYLE_VAR_DISABLED_ALPHA: int                      # Float     disabledalpha
STYLE_VAR_WINDOW_PADDING: int                      # Imvec2    windowpadding
STYLE_VAR_WINDOW_ROUNDING: int                     # Float     windowrounding
STYLE_VAR_WINDOW_BORDER_SIZE: int                  # Float     windowbordersize
STYLE_VAR_WINDOW_MIN_SIZE: int                     # Imvec2    windowminsize
STYLE_VAR_WINDOW_TITLE_ALIGN: int                  # Imvec2    windowtitlealign
STYLE_VAR_CHILD_ROUNDING: int                      # Float     childrounding
STYLE_VAR_CHILD_BORDER_SIZE: int                   # Float     childbordersize
STYLE_VAR_POPUP_ROUNDING: int                      # Float     popuprounding
STYLE_VAR_POPUP_BORDER_SIZE: int                   # Float     popupbordersize
STYLE_VAR_FRAME_PADDING: int                       # Imvec2    framepadding
STYLE_VAR_FRAME_ROUNDING: int                      # Float     framerounding
STYLE_VAR_FRAME_BORDER_SIZE: int                   # Float     framebordersize
STYLE_VAR_ITEM_SPACING: int                        # Imvec2    itemspacing
STYLE_VAR_ITEM_INNER_SPACING: int                  # Imvec2    iteminnerspacing
STYLE_VAR_INDENT_SPACING: int                      # Float     indentspacing
STYLE_VAR_CELL_PADDING: int                        # Imvec2    cellpadding
STYLE_VAR_SCROLLBAR_SIZE: int                      # Float     scrollbarsize
STYLE_VAR_SCROLLBAR_ROUNDING: int                  # Float     scrollbarrounding
STYLE_VAR_GRAB_MIN_SIZE: int                       # Float     grabminsize
STYLE_VAR_GRAB_ROUNDING: int                       # Float     grabrounding
STYLE_VAR_TAB_ROUNDING: int                        # Float     tabrounding
STYLE_VAR_TAB_BORDER_SIZE: int                     # Float     tabbordersize
STYLE_VAR_TAB_BAR_BORDER_SIZE: int                 # Float     tabbarbordersize
STYLE_VAR_TAB_BAR_OVERLINE_SIZE: int               # Float     tabbaroverlinesize
STYLE_VAR_TABLE_ANGLED_HEADERS_ANGLE: int          # Float     tableangledheadersangle
STYLE_VAR_TABLE_ANGLED_HEADERS_TEXT_ALIGN: int     # Imvec2  tableangledheaderstextalign
STYLE_VAR_BUTTON_TEXT_ALIGN: int                   # Imvec2    buttontextalign
STYLE_VAR_SELECTABLE_TEXT_ALIGN: int               # Imvec2    selectabletextalign
STYLE_VAR_SEPARATOR_TEXT_BORDER_SIZE: int          # Float     separatortextbordersize
STYLE_VAR_SEPARATOR_TEXT_ALIGN: int                # Imvec2    separatortextalign
STYLE_VAR_SEPARATOR_TEXT_PADDING: int              # Imvec2    separatortextpadding
STYLE_VAR_DOCKING_SEPARATOR_SIZE: int              # Float     dockingseparatorsize
STYLE_VAR_COUNT: int
BUTTON_FLAGS_NONE: int
BUTTON_FLAGS_MOUSE_BUTTON_LEFT: int       # React on left mouse button (default)
BUTTON_FLAGS_MOUSE_BUTTON_RIGHT: int      # React on right mouse button
BUTTON_FLAGS_MOUSE_BUTTON_MIDDLE: int     # React on center mouse button
BUTTON_FLAGS_MOUSE_BUTTON_MASK: int       # [internal]
BUTTON_FLAGS_ENABLE_NAV: int              # Invisiblebutton(): do not disable navigation/tabbing. otherwise disabled by default.
COLOR_EDIT_FLAGS_NONE: int
COLOR_EDIT_FLAGS_NO_ALPHA: int               # Coloredit, colorpicker, colorbutton: ignore alpha component (will only read 3 components from the input pointer).
COLOR_EDIT_FLAGS_NO_PICKER: int              # Coloredit: disable picker when clicking on color square.
COLOR_EDIT_FLAGS_NO_OPTIONS: int             # Coloredit: disable toggling options menu when right-clicking on inputs/small preview.
COLOR_EDIT_FLAGS_NO_SMALL_PREVIEW: int       # Coloredit, colorpicker: disable color square preview next to the inputs. (e.g. to show only the inputs)
COLOR_EDIT_FLAGS_NO_INPUTS: int              # Coloredit, colorpicker: disable inputs sliders/text widgets (e.g. to show only the small preview color square).
COLOR_EDIT_FLAGS_NO_TOOLTIP: int             # Coloredit, colorpicker, colorbutton: disable tooltip when hovering the preview.
COLOR_EDIT_FLAGS_NO_LABEL: int               # Coloredit, colorpicker: disable display of inline text label (the label is still forwarded to the tooltip and picker).
COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW: int        # Colorpicker: disable bigger color preview on right side of the picker, use small color square preview instead.
COLOR_EDIT_FLAGS_NO_DRAG_DROP: int           # Coloredit: disable drag and drop target. colorbutton: disable drag and drop source.
COLOR_EDIT_FLAGS_NO_BORDER: int              # Colorbutton: disable border (which is enforced by default)
COLOR_EDIT_FLAGS_ALPHA_BAR: int              # Coloredit, colorpicker: show vertical alpha bar/gradient in picker.
COLOR_EDIT_FLAGS_ALPHA_PREVIEW: int          # Coloredit, colorpicker, colorbutton: display preview as a transparent color over a checkerboard, instead of opaque.
COLOR_EDIT_FLAGS_ALPHA_PREVIEW_HALF: int     # Coloredit, colorpicker, colorbutton: display half opaque / half checkerboard, instead of opaque.
COLOR_EDIT_FLAGS_HDR: int                    # (wip) coloredit: currently only disable 0.0f..1.0f limits in rgba edition (note: you probably want to use imguicoloreditflags_float flag as well).
COLOR_EDIT_FLAGS_DISPLAY_RGB: int            # [display]    // coloredit: override _display_ type among rgb/hsv/hex. colorpicker: select any combination using one or more of rgb/hsv/hex.
COLOR_EDIT_FLAGS_DISPLAY_HSV: int            # [display]    // '
COLOR_EDIT_FLAGS_DISPLAY_HEX: int            # [display]    // '
COLOR_EDIT_FLAGS_UINT8: int                  # [datatype]   // coloredit, colorpicker, colorbutton: _display_ values formatted as 0..255.
COLOR_EDIT_FLAGS_FLOAT: int                  # [datatype]   // coloredit, colorpicker, colorbutton: _display_ values formatted as 0.0f..1.0f floats instead of 0..255 integers. no round-trip of value via integers.
COLOR_EDIT_FLAGS_PICKER_HUE_BAR: int         # [picker]     // colorpicker: bar for hue, rectangle for sat/value.
COLOR_EDIT_FLAGS_PICKER_HUE_WHEEL: int       # [picker]     // colorpicker: wheel for hue, triangle for sat/value.
COLOR_EDIT_FLAGS_INPUT_RGB: int              # [input]      // coloredit, colorpicker: input and output data in rgb format.
COLOR_EDIT_FLAGS_INPUT_HSV: int              # [input]      // coloredit, colorpicker: input and output data in hsv format.
COLOR_EDIT_FLAGS_DEFAULT_OPTIONS: int
COLOR_EDIT_FLAGS_DISPLAY_MASK: int
COLOR_EDIT_FLAGS_DATA_TYPE_MASK: int
COLOR_EDIT_FLAGS_PICKER_MASK: int
COLOR_EDIT_FLAGS_INPUT_MASK: int
SLIDER_FLAGS_NONE: int
SLIDER_FLAGS_LOGARITHMIC: int            # Make the widget logarithmic (linear otherwise). consider using imguisliderflags_noroundtoformat with this if using a format-string with small amount of digits.
SLIDER_FLAGS_NO_ROUND_TO_FORMAT: int     # Disable rounding underlying value to match precision of the display format string (e.g. %.3f values are rounded to those 3 digits).
SLIDER_FLAGS_NO_INPUT: int               # Disable ctrl+click or enter key allowing to input text directly into the widget.
SLIDER_FLAGS_WRAP_AROUND: int            # Enable wrapping around from max to min and from min to max. only supported by dragxxx() functions for now.
SLIDER_FLAGS_CLAMP_ON_INPUT: int         # Clamp value to min/max bounds when input manually with ctrl+click. by default ctrl+click allows going out of bounds.
SLIDER_FLAGS_CLAMP_ZERO_RANGE: int       # Clamp even if min==max==0.0f. otherwise due to legacy reason dragxxx functions don't clamp with those values. when your clamping limits are dynamic you almost always want to use it.
SLIDER_FLAGS_ALWAYS_CLAMP: int
SLIDER_FLAGS_INVALID_MASK: int           # [internal] we treat using those bits as being potentially a 'float power' argument from the previous api that has got miscast to this enum, and will trigger an assert if needed.
MOUSE_BUTTON_LEFT: int
MOUSE_BUTTON_RIGHT: int
MOUSE_BUTTON_MIDDLE: int
MOUSE_BUTTON_COUNT: int
MOUSE_CURSOR_NONE: int
MOUSE_CURSOR_ARROW: int
MOUSE_CURSOR_TEXT_INPUT: int      # When hovering over inputtext, etc.
MOUSE_CURSOR_RESIZE_ALL: int      # (unused by dear imgui functions)
MOUSE_CURSOR_RESIZE_NS: int       # When hovering over a horizontal border
MOUSE_CURSOR_RESIZE_EW: int       # When hovering over a vertical border or a column
MOUSE_CURSOR_RESIZE_NESW: int     # When hovering over the bottom-left corner of a window
MOUSE_CURSOR_RESIZE_NWSE: int     # When hovering over the bottom-right corner of a window
MOUSE_CURSOR_HAND: int            # (unused by dear imgui functions. use for e.g. hyperlinks)
MOUSE_CURSOR_NOT_ALLOWED: int     # When hovering something with disallowed interaction. usually a crossed circle.
MOUSE_CURSOR_COUNT: int
MOUSE_SOURCE_MOUSE: int            # Input is coming from an actual mouse.
MOUSE_SOURCE_TOUCH_SCREEN: int     # Input is coming from a touch screen (no hovering prior to initial press, less precise initial press aiming, dual-axis wheeling possible).
MOUSE_SOURCE_PEN: int              # Input is coming from a pressure/magnetic pen (often used in conjunction with high-sampling rates).
MOUSE_SOURCE_COUNT: int
COND_NONE: int               # No condition (always set the variable), same as _always
COND_ALWAYS: int             # No condition (always set the variable), same as _none
COND_ONCE: int               # Set the variable once per runtime session (only the first call will succeed)
COND_FIRST_USE_EVER: int     # Set the variable if the object/window has no persistently saved data (no entry in .ini file)
COND_APPEARING: int          # Set the variable if the object/window is appearing after being hidden/inactive (or the first time)
TABLE_FLAGS_NONE: int
TABLE_FLAGS_RESIZABLE: int                           # Enable resizing columns.
TABLE_FLAGS_REORDERABLE: int                         # Enable reordering columns in header row (need calling tablesetupcolumn() + tableheadersrow() to display headers)
TABLE_FLAGS_HIDEABLE: int                            # Enable hiding/disabling columns in context menu.
TABLE_FLAGS_SORTABLE: int                            # Enable sorting. call tablegetsortspecs() to obtain sort specs. also see imguitableflags_sortmulti and imguitableflags_sorttristate.
TABLE_FLAGS_NO_SAVED_SETTINGS: int                   # Disable persisting columns order, width and sort settings in the .ini file.
TABLE_FLAGS_CONTEXT_MENU_IN_BODY: int                # Right-click on columns body/contents will display table context menu. by default it is available in tableheadersrow().
TABLE_FLAGS_ROW_BG: int                              # Set each rowbg color with imguicol_tablerowbg or imguicol_tablerowbgalt (equivalent of calling tablesetbgcolor with imguitablebgflags_rowbg0 on each row manually)
TABLE_FLAGS_BORDERS_INNER_H: int                     # Draw horizontal borders between rows.
TABLE_FLAGS_BORDERS_OUTER_H: int                     # Draw horizontal borders at the top and bottom.
TABLE_FLAGS_BORDERS_INNER_V: int                     # Draw vertical borders between columns.
TABLE_FLAGS_BORDERS_OUTER_V: int                     # Draw vertical borders on the left and right sides.
TABLE_FLAGS_BORDERS_H: int                           # Draw horizontal borders.
TABLE_FLAGS_BORDERS_V: int                           # Draw vertical borders.
TABLE_FLAGS_BORDERS_INNER: int                       # Draw inner borders.
TABLE_FLAGS_BORDERS_OUTER: int                       # Draw outer borders.
TABLE_FLAGS_BORDERS: int                             # Draw all borders.
TABLE_FLAGS_NO_BORDERS_IN_BODY: int                  # [alpha] disable vertical borders in columns body (borders will always appear in headers). -> may move to style
TABLE_FLAGS_NO_BORDERS_IN_BODY_UNTIL_RESIZE: int     # [alpha] disable vertical borders in columns body until hovered for resize (borders will always appear in headers). -> may move to style
TABLE_FLAGS_SIZING_FIXED_FIT: int                    # Columns default to _widthfixed or _widthauto (if resizable or not resizable), matching contents width.
TABLE_FLAGS_SIZING_FIXED_SAME: int                   # Columns default to _widthfixed or _widthauto (if resizable or not resizable), matching the maximum contents width of all columns. implicitly enable imguitableflags_nokeepcolumnsvisible.
TABLE_FLAGS_SIZING_STRETCH_PROP: int                 # Columns default to _widthstretch with default weights proportional to each columns contents widths.
TABLE_FLAGS_SIZING_STRETCH_SAME: int                 # Columns default to _widthstretch with default weights all equal, unless overridden by tablesetupcolumn().
TABLE_FLAGS_NO_HOST_EXTEND_X: int                    # Make outer width auto-fit to columns, overriding outer_size.x value. only available when scrollx/scrolly are disabled and stretch columns are not used.
TABLE_FLAGS_NO_HOST_EXTEND_Y: int                    # Make outer height stop exactly at outer_size.y (prevent auto-extending table past the limit). only available when scrollx/scrolly are disabled. data below the limit will be clipped and not visible.
TABLE_FLAGS_NO_KEEP_COLUMNS_VISIBLE: int             # Disable keeping column always minimally visible when scrollx is off and table gets too small. not recommended if columns are resizable.
TABLE_FLAGS_PRECISE_WIDTHS: int                      # Disable distributing remainder width to stretched columns (width allocation on a 100-wide table with 3 columns: without this flag: 33,33,34. with this flag: 33,33,33). with larger number of columns, resizing will appear to be less smooth.
TABLE_FLAGS_NO_CLIP: int                             # Disable clipping rectangle for every individual columns (reduce draw command count, items will be able to overflow into other columns). generally incompatible with tablesetupscrollfreeze().
TABLE_FLAGS_PAD_OUTER_X: int                         # Default if bordersouterv is on. enable outermost padding. generally desirable if you have headers.
TABLE_FLAGS_NO_PAD_OUTER_X: int                      # Default if bordersouterv is off. disable outermost padding.
TABLE_FLAGS_NO_PAD_INNER_X: int                      # Disable inner padding between columns (double inner padding if bordersouterv is on, single inner padding if bordersouterv is off).
TABLE_FLAGS_SCROLL_X: int                            # Enable horizontal scrolling. require 'outer_size' parameter of begintable() to specify the container size. changes default sizing policy. because this creates a child window, scrolly is currently generally recommended when using scrollx.
TABLE_FLAGS_SCROLL_Y: int                            # Enable vertical scrolling. require 'outer_size' parameter of begintable() to specify the container size.
TABLE_FLAGS_SORT_MULTI: int                          # Hold shift when clicking headers to sort on multiple column. tablegetsortspecs() may return specs where (specscount > 1).
TABLE_FLAGS_SORT_TRISTATE: int                       # Allow no sorting, disable default sorting. tablegetsortspecs() may return specs where (specscount == 0).
TABLE_FLAGS_HIGHLIGHT_HOVERED_COLUMN: int            # Highlight column headers when hovered (may evolve into a fuller highlight)
TABLE_FLAGS_SIZING_MASK: int
TABLE_COLUMN_FLAGS_NONE: int
TABLE_COLUMN_FLAGS_DISABLED: int                   # Overriding/master disable flag: hide column, won't show in context menu (unlike calling tablesetcolumnenabled() which manipulates the user accessible state)
TABLE_COLUMN_FLAGS_DEFAULT_HIDE: int               # Default as a hidden/disabled column.
TABLE_COLUMN_FLAGS_DEFAULT_SORT: int               # Default as a sorting column.
TABLE_COLUMN_FLAGS_WIDTH_STRETCH: int              # Column will stretch. preferable with horizontal scrolling disabled (default if table sizing policy is _sizingstretchsame or _sizingstretchprop).
TABLE_COLUMN_FLAGS_WIDTH_FIXED: int                # Column will not stretch. preferable with horizontal scrolling enabled (default if table sizing policy is _sizingfixedfit and table is resizable).
TABLE_COLUMN_FLAGS_NO_RESIZE: int                  # Disable manual resizing.
TABLE_COLUMN_FLAGS_NO_REORDER: int                 # Disable manual reordering this column, this will also prevent other columns from crossing over this column.
TABLE_COLUMN_FLAGS_NO_HIDE: int                    # Disable ability to hide/disable this column.
TABLE_COLUMN_FLAGS_NO_CLIP: int                    # Disable clipping for this column (all noclip columns will render in a same draw command).
TABLE_COLUMN_FLAGS_NO_SORT: int                    # Disable ability to sort on this field (even if imguitableflags_sortable is set on the table).
TABLE_COLUMN_FLAGS_NO_SORT_ASCENDING: int          # Disable ability to sort in the ascending direction.
TABLE_COLUMN_FLAGS_NO_SORT_DESCENDING: int         # Disable ability to sort in the descending direction.
TABLE_COLUMN_FLAGS_NO_HEADER_LABEL: int            # Tableheadersrow() will submit an empty label for this column. convenient for some small columns. name will still appear in context menu or in angled headers. you may append into this cell by calling tablesetcolumnindex() right after the tableheadersrow() call.
TABLE_COLUMN_FLAGS_NO_HEADER_WIDTH: int            # Disable header text width contribution to automatic column width.
TABLE_COLUMN_FLAGS_PREFER_SORT_ASCENDING: int      # Make the initial sort direction ascending when first sorting on this column (default).
TABLE_COLUMN_FLAGS_PREFER_SORT_DESCENDING: int     # Make the initial sort direction descending when first sorting on this column.
TABLE_COLUMN_FLAGS_INDENT_ENABLE: int              # Use current indent value when entering cell (default for column 0).
TABLE_COLUMN_FLAGS_INDENT_DISABLE: int             # Ignore current indent value when entering cell (default for columns > 0). indentation changes _within_ the cell will still be honored.
TABLE_COLUMN_FLAGS_ANGLED_HEADER: int              # Tableheadersrow() will submit an angled header row for this column. note this will add an extra row.
TABLE_COLUMN_FLAGS_IS_ENABLED: int                 # Status: is enabled == not hidden by user/api (referred to as 'hide' in _defaulthide and _nohide) flags.
TABLE_COLUMN_FLAGS_IS_VISIBLE: int                 # Status: is visible == is enabled and not clipped by scrolling.
TABLE_COLUMN_FLAGS_IS_SORTED: int                  # Status: is currently part of the sort specs
TABLE_COLUMN_FLAGS_IS_HOVERED: int                 # Status: is hovered by mouse
TABLE_COLUMN_FLAGS_WIDTH_MASK: int
TABLE_COLUMN_FLAGS_INDENT_MASK: int
TABLE_COLUMN_FLAGS_STATUS_MASK: int
TABLE_COLUMN_FLAGS_NO_DIRECT_RESIZE: int           # [internal] disable user resizing this column directly (it may however we resized indirectly from its left edge)
TABLE_ROW_FLAGS_NONE: int
TABLE_ROW_FLAGS_HEADERS: int     # Identify header row (set default background color + width of its contents accounted differently for auto column width)
TABLE_BG_TARGET_NONE: int
TABLE_BG_TARGET_ROW_BG0: int     # Set row background color 0 (generally used for background, automatically set when imguitableflags_rowbg is used)
TABLE_BG_TARGET_ROW_BG1: int     # Set row background color 1 (generally used for selection marking)
TABLE_BG_TARGET_CELL_BG: int     # Set cell background color (top-most color)
MULTI_SELECT_FLAGS_NONE: int
MULTI_SELECT_FLAGS_SINGLE_SELECT: int                 # Disable selecting more than one item. this is available to allow single-selection code to share same code/logic if desired. it essentially disables the main purpose of beginmultiselect() tho!
MULTI_SELECT_FLAGS_NO_SELECT_ALL: int                 # Disable ctrl+a shortcut to select all.
MULTI_SELECT_FLAGS_NO_RANGE_SELECT: int               # Disable shift+selection mouse/keyboard support (useful for unordered 2d selection). with boxselect is also ensure contiguous setrange requests are not combined into one. this allows not handling interpolation in setrange requests.
MULTI_SELECT_FLAGS_NO_AUTO_SELECT: int                # Disable selecting items when navigating (useful for e.g. supporting range-select in a list of checkboxes).
MULTI_SELECT_FLAGS_NO_AUTO_CLEAR: int                 # Disable clearing selection when navigating or selecting another one (generally used with imguimultiselectflags_noautoselect. useful for e.g. supporting range-select in a list of checkboxes).
MULTI_SELECT_FLAGS_NO_AUTO_CLEAR_ON_RESELECT: int     # Disable clearing selection when clicking/selecting an already selected item.
MULTI_SELECT_FLAGS_BOX_SELECT1D: int                  # Enable box-selection with same width and same x pos items (e.g. full row selectable()). box-selection works better with little bit of spacing between items hit-box in order to be able to aim at empty space.
MULTI_SELECT_FLAGS_BOX_SELECT2D: int                  # Enable box-selection with varying width or varying x pos items support (e.g. different width labels, or 2d layout/grid). this is slower: alters clipping logic so that e.g. horizontal movements will update selection of normally clipped items.
MULTI_SELECT_FLAGS_BOX_SELECT_NO_SCROLL: int          # Disable scrolling when box-selecting near edges of scope.
MULTI_SELECT_FLAGS_CLEAR_ON_ESCAPE: int               # Clear selection when pressing escape while scope is focused.
MULTI_SELECT_FLAGS_CLEAR_ON_CLICK_VOID: int           # Clear selection when clicking on empty location within scope.
MULTI_SELECT_FLAGS_SCOPE_WINDOW: int                  # Scope for _boxselect and _clearonclickvoid is whole window (default). use if beginmultiselect() covers a whole window or used a single time in same window.
MULTI_SELECT_FLAGS_SCOPE_RECT: int                    # Scope for _boxselect and _clearonclickvoid is rectangle encompassing beginmultiselect()/endmultiselect(). use if beginmultiselect() is called multiple times in same window.
MULTI_SELECT_FLAGS_SELECT_ON_CLICK: int               # Apply selection on mouse down when clicking on unselected item. (default)
MULTI_SELECT_FLAGS_SELECT_ON_CLICK_RELEASE: int       # Apply selection on mouse release when clicking an unselected item. allow dragging an unselected item without altering selection.
MULTI_SELECT_FLAGS_NAV_WRAP_X: int                    # [temporary] enable navigation wrapping on x axis. provided as a convenience because we don't have a design for the general nav api for this yet. when the more general feature be public we may obsolete this flag in favor of new one.
SELECTION_REQUEST_TYPE_NONE: int
SELECTION_REQUEST_TYPE_SET_ALL: int       # Request app to clear selection (if selected==false) or select all items (if selected==true). we cannot set rangefirstitem/rangelastitem as its contents is entirely up to user (not necessarily an index)
SELECTION_REQUEST_TYPE_SET_RANGE: int     # Request app to select/unselect [rangefirstitem..rangelastitem] items (inclusive) based on value of selected. only endmultiselect() request this, app code can read after beginmultiselect() and it will always be false.
IM_DRAW_FLAGS_NONE: int
IM_DRAW_FLAGS_CLOSED: int                         # Pathstroke(), addpolyline(): specify that shape should be closed (important: this is always == 1 for legacy reason)
IM_DRAW_FLAGS_ROUND_CORNERS_TOP_LEFT: int         # Addrect(), addrectfilled(), pathrect(): enable rounding top-left corner only (when rounding > 0.0f, we default to all corners). was 0x01.
IM_DRAW_FLAGS_ROUND_CORNERS_TOP_RIGHT: int        # Addrect(), addrectfilled(), pathrect(): enable rounding top-right corner only (when rounding > 0.0f, we default to all corners). was 0x02.
IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM_LEFT: int      # Addrect(), addrectfilled(), pathrect(): enable rounding bottom-left corner only (when rounding > 0.0f, we default to all corners). was 0x04.
IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM_RIGHT: int     # Addrect(), addrectfilled(), pathrect(): enable rounding bottom-right corner only (when rounding > 0.0f, we default to all corners). wax 0x08.
IM_DRAW_FLAGS_ROUND_CORNERS_NONE: int             # Addrect(), addrectfilled(), pathrect(): disable rounding on all corners (when rounding > 0.0f). this is not zero, not an implicit flag!
IM_DRAW_FLAGS_ROUND_CORNERS_TOP: int
IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM: int
IM_DRAW_FLAGS_ROUND_CORNERS_LEFT: int
IM_DRAW_FLAGS_ROUND_CORNERS_RIGHT: int
IM_DRAW_FLAGS_ROUND_CORNERS_ALL: int
IM_DRAW_FLAGS_ROUND_CORNERS_DEFAULT: int          # Default to all corners if none of the _roundcornersxx flags are specified.
IM_DRAW_FLAGS_ROUND_CORNERS_MASK: int
IM_DRAW_LIST_FLAGS_NONE: int
IM_DRAW_LIST_FLAGS_ANTI_ALIASED_LINES: int             # Enable anti-aliased lines/borders (*2 the number of triangles for 1.0f wide line or lines thin enough to be drawn using textures, otherwise *3 the number of triangles)
IM_DRAW_LIST_FLAGS_ANTI_ALIASED_LINES_USE_TEX: int     # Enable anti-aliased lines/borders using textures when possible. require backend to render with bilinear filtering (not point/nearest filtering).
IM_DRAW_LIST_FLAGS_ANTI_ALIASED_FILL: int              # Enable anti-aliased edge around filled shapes (rounded rectangles, circles).
IM_DRAW_LIST_FLAGS_ALLOW_VTX_OFFSET: int               # Can emit 'vtxoffset > 0' to allow large meshes. set when 'imguibackendflags_rendererhasvtxoffset' is enabled.
IM_FONT_ATLAS_FLAGS_NONE: int
IM_FONT_ATLAS_FLAGS_NO_POWER_OF_TWO_HEIGHT: int     # Don't round the height to next power of two
IM_FONT_ATLAS_FLAGS_NO_MOUSE_CURSORS: int           # Don't build software mouse cursors into the atlas (save a little texture memory)
IM_FONT_ATLAS_FLAGS_NO_BAKED_LINES: int             # Don't build thick line textures into the atlas (save a little texture memory, allow support for point/nearest filtering). the antialiasedlinesusetex features uses them, otherwise they will be rendered using polygons (more expensive for cpu/gpu).
VIEWPORT_FLAGS_NONE: int
VIEWPORT_FLAGS_IS_PLATFORM_WINDOW: int         # Represent a platform window
VIEWPORT_FLAGS_IS_PLATFORM_MONITOR: int        # Represent a platform monitor (unused yet)
VIEWPORT_FLAGS_OWNED_BY_APP: int               # Platform window: is created/managed by the user application? (rather than our backend)
VIEWPORT_FLAGS_NO_DECORATION: int              # Platform window: disable platform decorations: title bar, borders, etc. (generally set all windows, but if imguiconfigflags_viewportsdecoration is set we only set this on popups/tooltips)
VIEWPORT_FLAGS_NO_TASK_BAR_ICON: int           # Platform window: disable platform task bar icon (generally set on popups/tooltips, or all windows if imguiconfigflags_viewportsnotaskbaricon is set)
VIEWPORT_FLAGS_NO_FOCUS_ON_APPEARING: int      # Platform window: don't take focus when created.
VIEWPORT_FLAGS_NO_FOCUS_ON_CLICK: int          # Platform window: don't take focus when clicked on.
VIEWPORT_FLAGS_NO_INPUTS: int                  # Platform window: make mouse pass through so we can drag this window while peaking behind it.
VIEWPORT_FLAGS_NO_RENDERER_CLEAR: int          # Platform window: renderer doesn't need to clear the framebuffer ahead (because we will fill it entirely).
VIEWPORT_FLAGS_NO_AUTO_MERGE: int              # Platform window: avoid merging this window into another host window. this can only be set via imguiwindowclass viewport flags override (because we need to now ahead if we are going to create a viewport in the first place!).
VIEWPORT_FLAGS_TOP_MOST: int                   # Platform window: display on top (for tooltips only).
VIEWPORT_FLAGS_CAN_HOST_OTHER_WINDOWS: int     # Viewport can host multiple imgui windows (secondary viewports are associated to a single window). // fixme: in practice there's still probably code making the assumption that this is always and only on the mainviewport. will fix once we add support for 'no main viewport'.
VIEWPORT_FLAGS_IS_MINIMIZED: int               # Platform window: window is minimized, can skip render. when minimized we tend to avoid using the viewport pos/size for clipping window or testing if they are contained in the viewport.
VIEWPORT_FLAGS_IS_FOCUSED: int                 # Platform window: window is focused (last call to platform_getwindowfocus() returned true)




def accept_drag_drop_payload(type_: str, flags: int=0) -> ImGuiPayload:
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

def begin(name: str, p_open: Bool=None, flags: int=0) -> bool:
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
    pass

def begin_child(str_id: str, size: Tuple[float, float]=(0, 0), child_flags: int=0, window_flags: int=0) -> bool:
    """
    Child Windows
    - Use child windows to begin into a self-contained independent scrolling/clipping regions within a host window. Child windows can embed their own child.
    - Before 1.90 (November 2023), the "ImGuiChildFlags child_flags = 0" parameter was "bool border = false".
    This API is backward compatible with old code, as we guarantee that ImGuiChildFlags_Borders == true.
    Consider updating your old code:
    BeginChild("Name", size, false)   -> Begin("Name", size, 0); or Begin("Name", size, ImGuiChildFlags_None);
    BeginChild("Name", size, true)    -> Begin("Name", size, ImGuiChildFlags_Borders);
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
    pass

def begin_child_id(id_: int, size: Tuple[float, float]=(0, 0), child_flags: int=0, window_flags: int=0) -> bool: ...
def begin_combo(label: str, preview_value: str, flags: int=0) -> bool:
    """
    Widgets: Combo Box (Dropdown)
    - The BeginCombo()/EndCombo() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() items.
    - The old Combo() api are helpers over BeginCombo()/EndCombo() which are kept available for convenience purpose. This is analogous to how ListBox are created.
    """
    pass

def begin_disabled(disabled: bool=True) -> None:
    """
    Disabling [BETA API]
    - Disable all user interactions and dim items visuals (applying style.DisabledAlpha over current colors)
    - Those can be nested but it cannot be used to enable an already disabled section (a single BeginDisabled(true) in the stack is enough to keep everything disabled)
    - Tooltips windows by exception are opted out of disabling.
    - BeginDisabled(false)/EndDisabled() essentially does nothing but is provided to facilitate use of boolean expressions (as a micro-optimization: if you have tens of thousands of BeginDisabled(false)/EndDisabled() pairs, you might want to reformulate your code to avoid making those calls)
    """
    pass

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

def begin_item_tooltip() -> bool:
    """
    Tooltips: helpers for showing a tooltip when hovering an item
    - BeginItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip) && BeginTooltip())' idiom.
    - SetItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip)) ( SetTooltip(...); )' idiom.
    - Where 'ImGuiHoveredFlags_ForTooltip' itself is a shortcut to use 'style.HoverFlagsForTooltipMouse' or 'style.HoverFlagsForTooltipNav' depending on active input type. For mouse it defaults to 'ImGuiHoveredFlags_Stationary | ImGuiHoveredFlags_DelayShort'.
    Begin/append a tooltip window if preceding item was hovered.
    """
    pass

def begin_list_box(label: str, size: Tuple[float, float]=(0, 0)) -> bool:
    """
    Widgets: List Boxes
    - This is essentially a thin wrapper to using BeginChild/EndChild with the ImGuiChildFlags_FrameStyle flag for stylistic changes + displaying a label.
    - You can submit contents and manage your selection state however you want it, by creating e.g. Selectable() or any other items.
    - The simplified/old ListBox() api are helpers over BeginListBox()/EndListBox() which are kept available for convenience purpose. This is analoguous to how Combos are created.
    - Choose frame width:   size.x > 0.0f: custom  /  size.x < 0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
    - Choose frame height:  size.y > 0.0f: custom  /  size.y < 0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
    Open a framed scrolling region
    """
    pass

def begin_main_menu_bar() -> bool:
    """
    Create and append to a full screen menu-bar.
    """
    pass

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

def begin_multi_select(flags: int, selection_size: int=-1, items_count: int=-1) -> ImGuiMultiSelectIO:
    """
    Multi-selection system for Selectable(), Checkbox(), TreeNode() functions [BETA]
    - This enables standard multi-selection/range-selection idioms (CTRL+Mouse/Keyboard, SHIFT+Mouse/Keyboard, etc.) in a way that also allow a clipper to be used.
    - ImGuiSelectionUserData is often used to store your item index within the current view (but may store something else).
    - Read comments near ImGuiMultiSelectIO for instructions/details and see 'Demo->Widgets->Selection State & Multi-Select' for demo.
    - TreeNode() is technically supported but... using this correctly is more complicated. You need some sort of linear/random access to your tree,
    which is suited to advanced trees setups already implementing filters and clipper. We will work simplifying the current demo.
    - 'selection_size' and 'items_count' parameters are optional and used by a few features. If they are costly for you to compute, you may avoid them.
    Implied selection_size = -1, items_count = -1
    """
    pass

def begin_popup(str_id: str, flags: int=0) -> bool:
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

def begin_popup_context_void(str_id: str=None, popup_flags: int=1) -> bool:
    """
    Open+begin popup when clicked in void (where there are no windows).
    """
    pass

def begin_popup_context_window(str_id: str=None, popup_flags: int=1) -> bool:
    """
    Open+begin popup when clicked on current window.
    """
    pass

def begin_popup_modal(name: str, p_open: Bool=None, flags: int=0) -> bool:
    """
    Return true if the modal is open, and you can start outputting to it.
    """
    pass

def begin_tab_bar(str_id: str, flags: int=0) -> bool:
    """
    Tab Bars, Tabs
    - Note: Tabs are automatically created by the docking system (when in 'docking' branch). Use this to create tab bars/tabs yourself.
    Create and append into a tabbar
    """
    pass

def begin_tab_item(label: str, p_open: Bool=None, flags: int=0) -> bool:
    """
    Create a tab. returns true if the tab is selected.
    """
    pass

def begin_table(str_id: str, columns: int, flags: int=0, outer_size: tuple=(0.0, 0.0), inner_width: float=0.0) -> bool:
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
    pass

def begin_tooltip() -> bool:
    """
    Tooltips
    - Tooltips are windows following the mouse. They do not take focus away.
    - A tooltip window can contain items of any types.
    - SetTooltip() is more or less a shortcut for the 'if (BeginTooltip()) ( Text(...); EndTooltip(); )' idiom (with a subtlety that it discard any previously submitted tooltip)
    Begin/append a tooltip window.
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

def button(label: str, size: tuple=(0, 0)) -> bool:
    """
    Widgets: Main
    - Most widgets return true when the value has been changed or when pressed/selected
    - You may also use one of the many IsItemXXX functions (e.g. IsItemActive, IsItemHovered, etc.) to query widget state.
    Implied size = imvec2(0, 0)
    """
    pass

# def c_impl_glfw_char_callback(window: GLFWwindow, c: int) -> None: ...
# def c_impl_glfw_cursor_enter_callback(window: GLFWwindow, entered: int) -> None:
#     """
#     Since 1.84
#     """
#     pass

# def c_impl_glfw_cursor_pos_callback(window: GLFWwindow, x: float, y: float) -> None:
#     """
#     Since 1.87
#     """
#     pass

def c_impl_glfw_init_for_open_gl(window, install_callbacks: bool) -> bool:
    """
    Follow "Getting Started" link and check examples/ folder to learn about using backends!
    """
    pass

# def c_impl_glfw_init_for_other(window: GLFWwindow, install_callbacks: bool) -> bool: ...
# def c_impl_glfw_init_for_vulkan(window: GLFWwindow, install_callbacks: bool) -> bool: ...
# def c_impl_glfw_install_callbacks(window: GLFWwindow) -> None:
#     """
#     GLFW callbacks install
#     - When calling Init with 'install_callbacks=true': ImGui_ImplGlfw_InstallCallbacks() is called. GLFW callbacks will be installed for you. They will chain-call user's previously installed callbacks, if any.
#     - When calling Init with 'install_callbacks=false': GLFW callbacks won't be installed. You will need to call individual function yourself from your own GLFW callbacks.
#     """
#     pass

# def c_impl_glfw_key_callback(window: GLFWwindow, key: int, scancode: int, action: int, mods: int) -> None: ...
# def c_impl_glfw_monitor_callback(monitor: GLFWmonitor, event: int) -> None: ...
# def c_impl_glfw_mouse_button_callback(window: GLFWwindow, button: int, action: int, mods: int) -> None: ...
def c_impl_glfw_new_frame() -> None: ...
# def c_impl_glfw_restore_callbacks(window: GLFWwindow) -> None: ...
# def c_impl_glfw_scroll_callback(window: GLFWwindow, xoffset: float, yoffset: float) -> None: ...
# def c_impl_glfw_set_callbacks_chain_for_all_windows(chain_for_all_windows: bool) -> None:
#     """
#     GFLW callbacks options:
#     - Set 'chain_for_all_windows=true' to enable chaining callbacks for all windows (including secondary viewports created by backends or by user)
#     """
#     pass

def c_impl_glfw_shutdown() -> None: ...
# def c_impl_glfw_sleep(milliseconds: int) -> None:
#     """
#     GLFW helpers
#     """
#     pass

# def c_impl_glfw_window_focus_callback(window: GLFWwindow, focused: int) -> None:
#     """
#     GLFW callbacks (individual callbacks to call yourself if you didn't install callbacks)
#     Since 1.84
#     """
#     pass

# def c_impl_open_gl3_create_device_objects() -> bool: ...
# def c_impl_open_gl3_create_fonts_texture() -> bool:
#     """
#     (Optional) Called by Init/NewFrame/Shutdown
#     """
#     pass

# def c_impl_open_gl3_destroy_device_objects() -> None: ...
# def c_impl_open_gl3_destroy_fonts_texture() -> None: ...
def c_impl_open_gl3_init(glsl_version: str=None) -> bool:
    """
    Follow "Getting Started" link and check examples/ folder to learn about using backends!
    Implied glsl_version = nullptr
    """
    pass

def c_impl_open_gl3_new_frame() -> None: ...
def c_impl_open_gl3_render_draw_data(draw_data: ImDrawData) -> None: ...
def c_impl_open_gl3_shutdown() -> None: ...
def calc_item_width() -> float:
    """
    Width of item given pushed settings and current cursor position. not necessarily the width of last item unlike most 'item' functions.
    """
    pass

def calc_text_size(text: str, text_end: str=None, hide_text_after_double_hash: bool=False, wrap_width: float=-1.0) -> Tuple[float, float]:
    """
    Text Utilities
    Implied text_end = null, hide_text_after_double_hash = false, wrap_width = -1.0f
    """
    pass

def checkbox(label: str, v: Bool) -> bool: ...
def checkbox_flags(label: str, flags: Int, flags_value: int) -> bool: ...
def close_current_popup() -> None:
    """
    Manually close the popup we have begin-ed into.
    """
    pass

def collapsing_header(label: str, flags: int=0) -> bool:
    """
    If returning 'true' the header is open. doesn't indent nor push on id stack. user doesn't have to call treepop().
    """
    pass

def collapsing_header_bool_ptr(label: str, p_visible: Bool, flags: int=0) -> bool:
    """
    When 'p_visible != null': if '*p_visible==true' display an additional small close button on upper right of the header which will set the bool to false when clicked, if '*p_visible==false' don't display the header.
    """
    pass

def color_button(desc_id: str, col: Tuple[float, float, float, float], flags: int=0, size: tuple=(0, 0)) -> bool:
    """
    Display a color square/button, hover for details, return true when pressed.
    """
    pass

def color_convert_float4_to_u32(in_: Tuple[float, float, float, float]) -> int: ...
def color_convert_hsv_to_rgb(h: float, s: float, value: float, a: float=1) -> tuple: ...
def color_convert_rgb_to_hsv(r: float, g: float, b: float, a: float=1) -> tuple: ...
def color_convert_u32_to_float4(in_: int) -> Tuple[float, float, float, float]:
    """
    Color Utilities
    """
    pass

def color_edit3(label: str, colour: Vec4, flags: int=0) -> bool:
    """
    Widgets: Color Editor/Picker (tip: the ColorEdit* functions have a little color square that can be left-clicked to open a picker, and right-clicked to open an option menu.)
    - Note that in C++ a 'float v[X]' function argument is the _same_ as 'float* v', the array syntax is just a way to document the number of elements that are expected to be accessible.
    - You can pass the address of a first float element out of a contiguous structure, e.g. &myvector.x
    """
    pass

def color_edit4(label: str, colour: Vec4, flags: int=0) -> bool: ...
def color_picker3(label: str, colour: Vec4, flags: int=0) -> bool: ...
def color_picker4(label: str, colour: Vec4, flags: int=0, ref_col: Vec4=None) -> bool: ...
def columns(count: int=1, id_: str=None, border: bool=True) -> None:
    """
    Legacy Columns API (prefer using Tables!)
    - You can also use SameLine(pos_x) to mimic simplified columns.
    Implied count = 1, id = null, borders = true
    """
    pass

def combo(label: str, current_item: Int, items: Sequence[str], popup_max_height_in_items: int=-1) -> bool:
    """
    Separate items with \\0 within a string, end item-list with \\0\\0. e.g. 'one\\0two\\0three\\0'
    """
    pass

def combo_callback(label: str, current_item: Int, items_getter: Callable[[Any, int], str], data: Any, items_count: int, popup_max_height_in_items: int=-1) -> bool: ...
def create_context(shared_font_atlas: ImFontAtlas=None) -> ImGuiContext:
    """
    Context creation and access
    - Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
    - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
    for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
    """
    pass

def debug_check_version_and_data_layout() -> bool:
    """
    This is called by imgui_checkversion() macro.
    """
    pass

# def debug_flash_style_color(idx: int) -> None: ...
# def debug_log(fmt: str) -> None:
#     """
#     Call via imgui_debug_log() for maximum stripping in caller code!
#     """
#     pass

# def debug_log_v(fmt: str) -> None: ...
# def debug_start_item_picker() -> None: ...
def debug_text_encoding(text: str) -> None:
    """
    Debug Utilities
    - Your main debugging friend is the ShowMetricsWindow() function, which is also accessible from Demo->Tools->Metrics Debugger
    """
    pass

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

def dock_space(dockspace_id: int, size: tuple=(0, 0), flags: int=0, window_class: ImGuiWindowClass=None) -> int:
    """
    Docking
    [BETA API] Enable with io.ConfigFlags |= ImGuiConfigFlags_DockingEnable.
    Note: You can use most Docking facilities without calling any API. You DO NOT need to call DockSpace() to use Docking!
    - Drag from window title bar or their tab to dock/undock. Hold SHIFT to disable docking.
    - Drag from window menu button (upper-left button) to undock an entire node (all windows).
    - When io.ConfigDockingWithShift == true, you instead need to hold SHIFT to enable docking.
    About dockspaces:
    - Use DockSpaceOverViewport() to create a window covering the screen or a specific viewport + a dockspace inside it.
    This is often used with ImGuiDockNodeFlags_PassthruCentralNode to make it transparent.
    - Use DockSpace() to create an explicit dock node _within_ an existing window. See Docking demo for details.
    - Important: Dockspaces need to be submitted _before_ any window they can host. Submit it early in your frame!
    - Important: Dockspaces need to be kept alive if hidden, otherwise windows docked into it will be undocked.
    e.g. if you have multiple tabs with a dockspace inside each tab: submit the non-visible dockspaces with ImGuiDockNodeFlags_KeepAliveOnly.
    Implied size = imvec2(0, 0), flags = 0, window_class = null
    """
    pass

def dock_space_over_viewport(dockspace_id: int, viewport: ImGuiViewport=None, flags: int=0, window_class: ImGuiWindowClass=None) -> int:
    """
    Implied dockspace_id = 0, viewport = null, flags = 0, window_class = null
    """
    pass

def drag_float(label: str, v: Float, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool:
    """
    Widgets: Drag Sliders
    - CTRL+Click on any drag box to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
    - For all the Float2/Float3/Float4/Int2/Int3/Int4 versions of every function, note that a 'float v[X]' function argument is the same as 'float* v',
    the array syntax is just a way to document the number of elements that are expected to be accessible. You can pass address of your first element out of a contiguous set, e.g. &myvector.x
    - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
    - Format string may also be set to NULL or use the default format ("%f" or "%d").
    - Speed are per-pixel of mouse movement (v_speed=0.2f: mouse needs to move by 5 pixels to increase value by 1). For keyboard/gamepad navigation, minimum speed is Max(v_speed, minimum_step_at_given_precision).
    - Use v_min < v_max to clamp edits to given limits. Note that CTRL+Click manual input can override those limits if ImGuiSliderFlags_AlwaysClamp is not used.
    - Use v_max = FLT_MAX / INT_MAX etc to avoid clamping to a maximum, same with v_min = -FLT_MAX / INT_MIN to avoid clamping to a minimum.
    - We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
    - Legacy: Pre-1.78 there are DragXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
    If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    If v_min >= v_max we have no bound
    """
    pass

def drag_float2(label: str, float_ptrs: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    """
    pass

def drag_float3(label: str, float_ptrs: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    """
    pass

def drag_float4(label: str, float_ptrs: Sequence[Float], v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    """
    pass

def drag_float_range2(label: str, v_current_min: Float, v_current_max: Float, v_speed: float=1.0, v_min: float=0.0, v_max: float=0.0, format_: str="%.3f", format_max: str=None, flags: int=0) -> bool: ...
def drag_int(label: str, value: Int, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool:
    """
    If v_min >= v_max we have no bound
    """
    pass

def drag_int2(label: str, int_ptrs: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
def drag_int3(label: str, int_ptrs: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
def drag_int4(label: str, int_ptrs: Sequence[Int], v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", flags: int=0) -> bool: ...
def drag_int_range2(label: str, v_current_min: Int, v_current_max: Int, v_speed: float=1.0, v_min: int=0, v_max: int=0, format_: str="%d", format_max: str=None, flags: int=0) -> bool: ...
def drag_scalar(label: str, data_type: int, p_data: "Int | Long | Float | Double", v_speed: float=1.0, _min: "int | float"=None, _max: "int | float"=None, format_: str=None, flags: int=0) -> bool: ...
def drag_scalar_n(label: str, data_type: int, p_data: "Sequence[Int | Long | Float | Double]", components: int, v_speed: float=1.0, p_min: "int | float"=None, p_max: "int | float"=None, format_: str=None, flags: int=0) -> bool:
    """
    Implied v_speed = 1.0f, p_min = null, p_max = null, format = null, flags = 0
    """
    pass

def dummy(size: Tuple[float, float]) -> None:
    """
    Add a dummy item of given size. unlike invisiblebutton(), dummy() won't take the mouse click or be navigable into.
    """
    pass

def end() -> None: ...
def end_child() -> None: ...
def end_combo() -> None:
    """
    Only call endcombo() if begincombo() returns true!
    """
    pass

def end_disabled() -> None: ...
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

def end_frame() -> None:
    """
    Ends the dear imgui frame. automatically called by render(). if you don't need to render data (skipping rendering) you may call endframe() without render()... but you'll have wasted cpu already! if you don't need to render, better to not create any windows and not call newframe() at all!
    """
    pass

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

def end_main_menu_bar() -> None:
    """
    Only call endmainmenubar() if beginmainmenubar() returns true!
    """
    pass

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

def end_multi_select() -> ImGuiMultiSelectIO: ...
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
    Only call endtooltip() if begintooltip()/beginitemtooltip() returns true!
    """
    pass

def error_recovery_store_state(state_out: ImGuiErrorRecoveryState) -> None: ...
def error_recovery_try_to_recover_state(state_in: ImGuiErrorRecoveryState) -> None: ...
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

def get_background_draw_list() -> ImDrawList:
    """
    Background/Foreground Draw Lists
    Implied viewport = null
    """
    pass

# def get_background_draw_list_ex(viewport: ImGuiViewport=None) -> ImDrawList:
#     """
#     Get background draw list for the given viewport or viewport associated to the current window. this draw list will be the first rendering one. useful to quickly draw shapes/text behind dear imgui contents.
#     """
#     pass

def get_clipboard_text() -> str:
    """
    Clipboard Utilities
    - Also see the LogToClipboard() function to capture GUI into clipboard, or easily output text data to the clipboard.
    """
    pass

def get_color_u32(idx: int, alpha_mul: float=1.0) -> int:
    """
    Retrieve given style color with style alpha applied and optional extra alpha multiplier, packed as a 32-bit value suitable for imdrawlist
    """
    pass

def get_color_u32_im_u32(col: int) -> int:
    """
    Implied alpha_mul = 1.0f
    """
    pass

# def get_color_u32_im_u32_ex(col: int, alpha_mul: float=1.0) -> int:
#     """
#     Retrieve given color with style alpha applied, packed as a 32-bit value suitable for imdrawlist
#     """
#     pass

def get_color_u32_im_vec4(col: Tuple[float, float, float, float]) -> int:
    """
    Retrieve given color with style alpha applied, packed as a 32-bit value suitable for imdrawlist
    """
    pass

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
def get_content_region_avail() -> Tuple[float, float]:
    """
    Available space from current position. this is your best friend.
    """
    pass

def get_current_context() -> ImGuiContext: ...
def get_cursor_pos() -> Tuple[float, float]:
    """
    [window-local] cursor position in window-local coordinates. this is not your best friend.
    """
    pass

def get_cursor_pos_x() -> float:
    """
    [window-local] '
    """
    pass

def get_cursor_pos_y() -> float:
    """
    [window-local] '
    """
    pass

def get_cursor_screen_pos() -> Tuple[float, float]:
    """
    Layout cursor positioning
    - By "cursor" we mean the current output position.
    - The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
    - You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
    - YOU CAN DO 99% OF WHAT YOU NEED WITH ONLY GetCursorScreenPos() and GetContentRegionAvail().
    - Attention! We currently have inconsistencies between window-local and absolute positions we will aim to fix with future API:
    - Absolute coordinate:        GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions. -> this is the preferred way forward.
    - Window-local coordinates:   SameLine(offset), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), PushTextWrapPos()
    - Window-local coordinates:   GetContentRegionMax(), GetWindowContentRegionMin(), GetWindowContentRegionMax() --> all obsoleted. YOU DON'T NEED THEM.
    - GetCursorScreenPos() = GetCursorPos() + GetWindowPos(). GetWindowPos() is almost only ever useful to convert from window-local to absolute coordinates. Try not to use it.
    Cursor position, absolute coordinates. this is your best friend (prefer using this rather than getcursorpos(), also more useful to work with imdrawlist api).
    """
    pass

def get_cursor_start_pos() -> Tuple[float, float]:
    """
    [window-local] initial cursor position, in window-local coordinates. call getcursorscreenpos() after begin() to get the absolute coordinates version.
    """
    pass

def get_drag_drop_payload() -> ImGuiPayload:
    """
    Peek directly into the current payload from anywhere. returns null when drag and drop is finished or inactive. use imguipayload::isdatatype() to test for the payload type.
    """
    pass

def get_draw_data() -> ImDrawData:
    """
    Valid after render() and until the next call to newframe(). this is what you have to render.
    """
    pass

def get_font() -> ImFont:
    """
    Style read access
    - Use the ShowStyleEditor() function to interactively see/edit the colors.
    Get current font
    pygui note: Returns a const ImFont. Fields should only be read, not modified.
    """
    pass

def get_font_size() -> float:
    """
    Get current font size (= height in pixels) of current font with current scale applied
    """
    pass

def get_font_tex_uv_white_pixel() -> Tuple[float, float]:
    """
    Get uv coordinate for a white pixel, useful to draw custom shapes via the imdrawlist api
    """
    pass

def get_foreground_draw_list(viewport: ImGuiViewport=None) -> ImDrawList:
    """
    Get foreground draw list for the given viewport or viewport associated to the current window. this draw list will be the top-most rendered one. useful to quickly draw shapes/text over dear imgui contents.
    """
    pass

def get_frame_count() -> int:
    """
    Get global imgui frame count. incremented by 1 every frame.
    """
    pass

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

def get_id(str_id: str) -> int:
    """
    Calculate unique id (hash of whole id stack + given parameter). e.g. if you want to query into imguistorage yourself
    """
    pass

# def get_id_int(int_id: int) -> int: ...
# def get_id_ptr(ptr_id: Any) -> int: ...
# def get_id_str(str_id_begin: str, str_id_end: str) -> int: ...
def get_io() -> ImGuiIO:
    """
    Main
    Access the imguiio structure (mouse/keyboard/gamepad inputs, time, various configuration options/flags)
    """
    pass

def get_item_id() -> int:
    """
    Get id of last item (~~ often same imgui::getid(label) beforehand)
    """
    pass

def get_item_rect_max() -> Tuple[float, float]:
    """
    Get lower-right bounding rectangle of the last item (screen space)
    """
    pass

def get_item_rect_min() -> Tuple[float, float]:
    """
    Get upper-left bounding rectangle of the last item (screen space)
    """
    pass

def get_item_rect_size() -> Tuple[float, float]:
    """
    Get size of last item
    """
    pass

def get_key_pressed_amount(key: int, repeat_delay: float, rate: float) -> int:
    """
    Uses provided repeat rate/delay. return a count, most often 0 or 1 but might be >1 if repeatrate is small enough that deltatime > repeatrate
    """
    pass

def get_main_viewport() -> ImGuiViewport:
    """
    Viewports
    - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
    - In 'docking' branch with multi-viewport enabled, we extend this concept to have multiple active viewports.
    - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
    Return primary/default viewport. this can never be null.
    """
    pass

def get_mouse_clicked_count(button: int) -> int:
    """
    Return the number of successive mouse-clicks at the time where a click happen (otherwise 0).
    """
    pass

def get_mouse_cursor() -> int:
    """
    Get desired mouse cursor shape. important: reset in imgui::newframe(), this is updated during the frame. valid before render(). if you use software rendering by setting io.mousedrawcursor imgui will render those for you
    """
    pass

def get_mouse_drag_delta(button: int=0, lock_threshold: float=-1.0) -> Tuple[float, float]:
    """
    Return the delta from the initial clicking position while the mouse button is pressed or was just released. this is locked and return 0.0f until the mouse moves past a distance threshold at least once (uses io.mousedraggingthreshold if lock_threshold < 0.0f)
    """
    pass

def get_mouse_pos() -> Tuple[float, float]:
    """
    Shortcut to imgui::getio().mousepos provided by user, to be consistent with other calls
    """
    pass

def get_mouse_pos_on_opening_current_popup() -> Tuple[float, float]:
    """
    Retrieve mouse position at the time of opening popup we have beginpopup() into (helper to avoid user backing that value themselves)
    """
    pass

def get_platform_io() -> ImGuiPlatformIO:
    """
    Access the imguiplatformio structure (mostly hooks/functions to connect to platform/renderer and os clipboard, ime etc.)
    """
    pass

def get_scroll_max_x() -> float:
    """
    Get maximum scrolling amount ~~ contentsize.x - windowsize.x - decorationssize.x
    """
    pass

def get_scroll_max_y() -> float:
    """
    Get maximum scrolling amount ~~ contentsize.y - windowsize.y - decorationssize.y
    """
    pass

def get_scroll_x() -> float:
    """
    Windows Scrolling
    - Any change of Scroll will be applied at the beginning of next frame in the first call to Begin().
    - You may instead use SetNextWindowScroll() prior to calling Begin() to avoid this delay, as an alternative to using SetScrollX()/SetScrollY().
    Get scrolling amount [0 .. getscrollmaxx()]
    """
    pass

def get_scroll_y() -> float:
    """
    Get scrolling amount [0 .. getscrollmaxy()]
    """
    pass

# def get_state_storage() -> ImGuiStorage: ...
def get_style() -> ImGuiStyle:
    """
    Access the style structure (colors, sizes). always use pushstylecolor(), pushstylevar() to modify style mid-frame!
    """
    pass

def get_style_color_name(idx: int) -> str:
    """
    Get a string corresponding to the enum value (for display, saving, etc.).
    """
    pass

def get_style_color_vec4(idx: int) -> tuple:
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

def get_window_dock_id() -> int: ...
def get_window_dpi_scale() -> float:
    """
    Get dpi scale currently associated to the current window's viewport.
    """
    pass

def get_window_draw_list() -> ImDrawList:
    """
    Get draw list associated to the current window, to append your own drawing primitives
    """
    pass

def get_window_height() -> float:
    """
    Get current window height (it is unlikely you ever need to use this). shortcut for getwindowsize().y.
    """
    pass

def get_window_pos() -> Tuple[float, float]:
    """
    Get current window position in screen space (it is unlikely you ever need to use this. consider always using getcursorscreenpos() and getcontentregionavail() instead)
    """
    pass

def get_window_size() -> Tuple[float, float]:
    """
    Get current window size (it is unlikely you ever need to use this. consider always using getcursorscreenpos() and getcontentregionavail() instead)
    """
    pass

def get_window_viewport() -> ImGuiViewport:
    """
    Get viewport currently associated to the current window.
    """
    pass

def get_window_width() -> float:
    """
    Get current window width (it is unlikely you ever need to use this). shortcut for getwindowsize().x.
    """
    pass

# def im_color_hsv(h: float, s: float, v: float, a: float=1.0) -> ImColor: ...
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

def image(user_texture_id: int, image_size: Tuple[float, float], uv0: tuple=(0, 0), uv1: tuple=(1, 1), tint_col: tuple=(1, 1, 1, 1), border_col: tuple=(0, 0, 0, 0)) -> None:
    """
    Widgets: Images
    - Read about ImTextureID here: https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples
    - 'uv0' and 'uv1' are texture coordinates. Read about them from the same link above.
    - Note that Image() may add +2.0f to provided size if a border is visible, ImageButton() adds style.FramePadding*2.0f to provided size.
    Implied uv0 = imvec2(0, 0), uv1 = imvec2(1, 1), tint_col = imvec4(1, 1, 1, 1), border_col = imvec4(0, 0, 0, 0)
    """
    pass

def image_button(str_id: str, user_texture_id: int, image_size: Tuple[float, float], uv0: tuple=(0, 0), uv1: tuple=(1, 1), bg_col: tuple=(0, 0, 0, 0), tint_col: tuple=(1, 1, 1, 1)) -> bool:
    """
    Implied uv0 = imvec2(0, 0), uv1 = imvec2(1, 1), bg_col = imvec4(0, 0, 0, 0), tint_col = imvec4(1, 1, 1, 1)
    """
    pass

def indent(indent_w: float=0.0) -> None:
    """
    Move content position toward the right, by indent_w, or style.indentspacing if indent_w <= 0
    """
    pass

def input_double(label: str, v: Double, step: float=0.0, step_fast: float=0.0, format_: str="%.6f", flags: int=0) -> bool: ...
def input_float(label: str, v: Float, step: float=0.0, step_fast: float=0.0, format_: str="%.3f", flags: int=0) -> bool: ...
def input_float2(label: str, float_ptrs: Sequence[Float], format_: str="%.3f", flags: int=0) -> bool: ...
def input_float3(label: str, float_ptrs: Sequence[Float], format_: str="%.3f", flags: int=0) -> bool: ...
def input_float4(label: str, float_ptrs: Sequence[Float], format_: str="%.3f", flags: int=0) -> bool: ...
def input_int(label: str, v: Int) -> bool:
    """
    Implied step = 1, step_fast = 100, flags = 0
    """
    pass

def input_int2(label: str, int_ptrs: Sequence[Int], flags: int=0) -> bool: ...
def input_int3(label: str, int_ptrs: Sequence[Int], flags: int=0) -> bool: ...
def input_int4(label: str, int_ptrs: Sequence[Int], flags: int=0) -> bool: ...
def input_scalar(label: str, data_type: int, p_data: "Int | Long | Float | Double", step: "int | float"=None, step_fast: "int | float"=None, format_: str=None, flags: int=0) -> bool: ...
def input_scalar_n(label: str, data_type: int, p_data: "Sequence[Int | Long | Float | Double]", components: int, p_step: "int | float"=None, p_step_fast: "int | float"=None, format_: str=None, flags: int=0) -> bool: ...
def input_text(label: str, buf: String, flags: int=0, callback: "Callable[[ImGuiInputTextCallbackData, Any], int]"=None, user_data: Any=None) -> bool:
    """
    Widgets: Input with Keyboard
    - If you want to use InputText() with std::string or any custom dynamic string type, see misc/cpp/imgui_stdlib.h and comments in imgui_demo.cpp.
    - Most of the ImGuiInputTextFlags flags are only useful for InputText() and not for InputFloatX, InputIntX, InputDouble etc.
    Implied callback = null, user_data = null
    """
    pass

def input_text_multiline(label: str, buf: String, size: tuple=(0, 0), flags: int=0, callback: "Callable[[ImGuiInputTextCallbackData, Any], int]"=None, user_data: Any=None) -> bool: ...
def input_text_with_hint(label: str, hint: str, buf: String, flags: int=0, callback: "Callable[[ImGuiInputTextCallbackData, Any], int]"=None, user_data: Any=None) -> bool: ...
def invisible_button(str_id: str, size: Tuple[float, float], flags: int=0) -> bool:
    """
    Flexible button behavior without the visuals, frequently useful to build custom behaviors using the public api (along with isitemactive, isitemhovered, etc.)
    """
    pass

def is_any_item_active() -> bool:
    """
    Is any item active?
    """
    pass

def is_any_item_focused() -> bool:
    """
    Is any item focused?
    """
    pass

def is_any_item_hovered() -> bool:
    """
    Is any item hovered?
    """
    pass

def is_any_mouse_down() -> bool:
    """
    [will obsolete] is any mouse button held? this was designed for backends, but prefer having backend maintain a mask of held mouse buttons, because upcoming input queue system will make this invalid.
    """
    pass

def is_item_activated() -> bool:
    """
    Was the last item just made active (item was previously inactive).
    """
    pass

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

def is_item_deactivated() -> bool:
    """
    Was the last item just made inactive (item was previously active). useful for undo/redo patterns with widgets that require continuous editing.
    """
    pass

def is_item_deactivated_after_edit() -> bool:
    """
    Was the last item just made inactive and made a value change when it was active? (e.g. slider/drag moved). useful for undo/redo patterns with widgets that require continuous editing. note that you may get false positives (some widgets such as combo()/listbox()/selectable() will return true even when clicking an already selected item).
    """
    pass

def is_item_edited() -> bool:
    """
    Did the last item modify its underlying value this frame? or was pressed? this is generally the same as the 'bool' return value of many widgets.
    """
    pass

def is_item_focused() -> bool:
    """
    Is the last item focused for keyboard/gamepad navigation?
    """
    pass

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

def is_item_toggled_selection() -> bool:
    """
    Was the last item selection state toggled? useful if you need the per-item information _before_ reaching endmultiselect(). we only returns toggle _event_ in order to handle clipping correctly.
    """
    pass

def is_item_visible() -> bool:
    """
    Is the last item visible? (items may be out of sight because of clipping/scrolling)
    """
    pass

# def is_key_chord_pressed(key_chord: int) -> bool:
#     """
#     Was key chord (mods + key) pressed, e.g. you can pass 'imguimod_ctrl | imguikey_s' as a key-chord. this doesn't do any routing or focus check, please consider using shortcut() function instead.
#     """
#     pass

def is_key_down(key: int) -> bool:
    """
    Inputs Utilities: Keyboard/Mouse/Gamepad
    - the ImGuiKey enum contains all possible keyboard, mouse and gamepad inputs (e.g. ImGuiKey_A, ImGuiKey_MouseLeft, ImGuiKey_GamepadDpadUp...).
    - (legacy: before v1.87, we used ImGuiKey to carry native/user indices as defined by each backends. This was obsoleted in 1.87 (2022-02) and completely removed in 1.91.5 (2024-11). See https://github.com/ocornut/imgui/issues/4921)
    - (legacy: any use of ImGuiKey will assert when key < 512 to detect passing legacy native/user indices)
    Is key being held.
    """
    pass

def is_key_pressed(key: int, repeat: bool=True) -> bool:
    """
    Was key pressed (went from !down to down)? if repeat=true, uses io.keyrepeatdelay / keyrepeatrate
    """
    pass

def is_key_released(key: int) -> bool:
    """
    Was key released (went from down to !down)?
    """
    pass

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
    Inputs Utilities: Mouse
    - To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
    - You can also use regular integer: it is forever guaranteed that 0=Left, 1=Right, 2=Middle.
    - Dragging operations are only reported after mouse has moved a certain distance away from the initial clicking position (see 'lock_threshold' and 'io.MouseDraggingThreshold')
    Is mouse button held?
    """
    pass

def is_mouse_dragging(button: int, lock_threshold: float=-1.0) -> bool:
    """
    Is mouse dragging? (uses io.mousedraggingthreshold if lock_threshold < 0.0f)
    """
    pass

def is_mouse_hovering_rect(r_min: Tuple[float, float], r_max: Tuple[float, float], clip: bool=True) -> bool:
    """
    Is mouse hovering given bounding rect (in screen space). clipped by current clipping settings, but disregarding of other consideration of focus/window ordering/popup-block.
    """
    pass

def is_mouse_pos_valid(mouse_pos: tuple=None) -> bool:
    """
    By convention we use (-flt_max,-flt_max) to denote that there is no mouse available
    """
    pass

def is_mouse_released(button: int) -> bool:
    """
    Did mouse button released? (went from down to !down)
    """
    pass

def is_popup_open(str_id: str, flags: int=0) -> bool:
    """
    Popups: query functions
    - IsPopupOpen(): return true if the popup is open at the current BeginPopup() level of the popup stack.
    - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
    - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
    Return true if the popup is open.
    """
    pass

def is_rect_visible(rect_min: Tuple[float, float], rect_max: Tuple[float, float]) -> bool:
    """
    Test if rectangle (in screen space) is visible / not clipped. to perform coarse clipping on user's side.
    """
    pass

def is_rect_visible_by_size(size: Tuple[float, float]) -> bool:
    """
    Miscellaneous Utilities
    Test if rectangle (of given size, starting from cursor position) is visible / not clipped.
    """
    pass

def is_window_appearing() -> bool:
    """
    Windows Utilities
    - 'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.
    """
    pass

def is_window_collapsed() -> bool: ...
def is_window_docked() -> bool:
    """
    Is current window docked into another window?
    """
    pass

def is_window_focused(flags: int=0) -> bool:
    """
    Is current window focused? or its root/child, depending on flags. see flags for options.
    """
    pass

def is_window_hovered(flags: int=0) -> bool:
    """
    Is current window hovered and hoverable (e.g. not blocked by a popup/modal)? see imguihoveredflags_ for options. important: if you are trying to check whether your mouse should be dispatched to dear imgui or to your underlying app, you should not use this function! use the 'io.wantcapturemouse' boolean for that! refer to faq entry 'how can i tell whether to dispatch mouse/keyboard to dear imgui or my application?' for details.
    """
    pass

def label_text(label: str, fmt: str) -> None:
    """
    Display text+label aligned the same way as value+label widgets
    """
    pass

def list_box(label: str, current_item: Int, items: Sequence[str], height_in_items: int=-1) -> bool: ...
def list_box_callback(label: str, current_item: Int, items_getter: Callable[[Any, int], str], data: Any, items_count: int, height_in_items: int=-1) -> bool: ...
# def load_ini_settings_from_disk(ini_filename: str) -> None:
#     """
#     Settings/.Ini Utilities
#     - The disk functions are automatically called if io.IniFilename != NULL (default is "imgui.ini").
#     - Set io.IniFilename to NULL to load/save manually. Read io.WantSaveIniSettings description about handling .ini saving manually.
#     - Important: default value "imgui.ini" is relative to current working dir! Most apps will want to lock this to an absolute path (e.g. same path as executables).
#     Call after createcontext() and before the first call to newframe(). newframe() automatically calls loadinisettingsfromdisk(io.inifilename).
#     """
#     pass

# def load_ini_settings_from_memory(ini_data: str, ini_size: int=0) -> None:
#     """
#     Call after createcontext() and before the first call to newframe() to provide .ini data from your own data source.
#     """
#     pass

def log_buttons() -> None:
    """
    Helper to display buttons for logging to tty/file/clipboard
    """
    pass

def log_finish() -> None:
    """
    Stop logging (close file, etc.)
    """
    pass

def log_text(fmt: str) -> None:
    """
    Pass text data straight to log (without being displayed)
    """
    pass

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

def menu_item(label: str, shortcut: str=None, selected: bool=False, enabled: bool=True) -> bool:
    """
    Return true when activated.
    """
    pass

def menu_item_bool_ptr(label: str, shortcut: Optional[str], p_selected: Bool, enabled: bool=True) -> bool:
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

def open_popup_id(id_: int, popup_flags: int=0) -> None:
    """
    Id overload to facilitate calling from nested stacks
    pygui note: This function really only makes sense when you also have
    BeginPopupEx from imgui_internal.h. Otherwise you might as well use the
    normal open_popup().
    """
    pass

def open_popup_on_item_click(str_id: str=None, popup_flags: int=1) -> None:
    """
    Helper to open popup when clicked on last item. default to imguipopupflags_mousebuttonright == 1. (note: actually triggers on the mouse _released_ event to be consistent with popup behaviors)
    """
    pass

def plot_histogram(label: str, values: Sequence[float], values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0), stride: int=4) -> None:
    """
    Implied values_offset = 0, overlay_text = null, scale_min = flt_max, scale_max = flt_max, graph_size = imvec2(0, 0), stride = sizeof(float)
    """
    pass

def plot_histogram_callback(label: str, values_getter: Callable[[Any, int], float], data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)) -> None: ...
def plot_lines(label: str, values: Sequence[float], values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)) -> None:
    """
    Widgets: Data Plotting
    - Consider using ImPlot (https://github.com/epezent/implot) which is much better!
    Implied stride = sizeof(float)
    - Pygui note: stride has been omitted because we are instead passing in a list.
    the underlying c_float array is handled by Cython.
    """
    pass

def plot_lines_callback(label: str, values_getter: Callable[[Any, int], float], data: Any, values_count: int, values_offset: int=0, overlay_text: str=None, scale_min: float=FLT_MAX, scale_max: float=FLT_MAX, graph_size: tuple=(0, 0)) -> None: ...
# def pop_clip_rect() -> None: ...
def pop_font() -> None: ...
def pop_id() -> None:
    """
    Pop from the id stack.
    """
    pass

def pop_item_flag() -> None: ...
def pop_item_width() -> None: ...
def pop_style_color(count: int=1) -> None: ...
def pop_style_var(count: int=1) -> None: ...
def pop_text_wrap_pos() -> None: ...
def progress_bar(fraction: float, size_arg: Tuple[float, float]=(-FLT_MIN, 0), overlay: str=None) -> None: ...
# def push_clip_rect(clip_rect_min: Tuple[float, float], clip_rect_max: Tuple[float, float], intersect_with_current_clip_rect: bool) -> None:
#     """
#     Clipping
#     - Mouse hovering is affected by ImGui::PushClipRect() calls, unlike direct calls to ImDrawList::PushClipRect() which are render only.
#     """
#     pass

def push_font(font: ImFont) -> None:
    """
    Parameters stacks (shared)
    Use null as a shortcut to push default font
    """
    pass

def push_id(obj: object) -> None:
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
    pass

def push_item_flag(option: int, enabled: bool) -> None:
    """
    Modify specified shared item flag, e.g. pushitemflag(imguiitemflags_notabstop, true)
    """
    pass

def push_item_width(item_width: float) -> None:
    """
    Parameters stacks (current window)
    Push width of items for common large 'item+label' widgets. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -flt_min always align width to the right side).
    """
    pass

def push_style_color(idx: int, col: "int | tuple") -> None:
    """
    Modify a style color. always use this if you modify the style after newframe().
    pygui note: You can pass a u32 color or a 0-1, length 4 tuple for color.
    """
    pass

def push_style_var(idx: int, val: "float | tuple") -> None:
    """
    Modify a style float variable. always use this if you modify the style after newframe()!
    pygui note: You can pass a float or length 2 tuple.
    """
    pass

# def push_style_var_x(idx: int, val_x: float) -> None:
#     """
#     Modify x component of a style imvec2 variable. '
#     """
#     pass

# def push_style_var_y(idx: int, val_y: float) -> None:
#     """
#     Modify y component of a style imvec2 variable. '
#     """
#     pass

def push_text_wrap_pos(wrap_local_pos_x: float=0.0) -> None:
    """
    Push word-wrapping position for text*() commands. < 0.0f: no wrapping; 0.0f: wrap to end of window (or column); > 0.0f: wrap at 'wrap_pos_x' position in window local space
    """
    pass

def radio_button(label: str, active: bool) -> bool:
    """
    Use with e.g. if (radiobutton('one', my_value==1)) ( my_value = 1; )
    """
    pass

def radio_button_int_ptr(label: str, v: Int, v_button: int) -> bool:
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
    TODO: Doesn't consider real inputs.
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

def selectable_bool_ptr(label: str, p_selected: Bool, flags: int=0, size: tuple=(0, 0)) -> bool:
    """
    'bool* p_selected' point to the selection state (read-write), as a convenient helper.
    """
    pass

def separator() -> None:
    """
    Other layout functions
    Separator, generally horizontal. inside a menu bar or in horizontal layout mode, this becomes a vertical separator.
    """
    pass

def separator_text(label: str) -> None:
    """
    Currently: formatted text with an horizontal line
    """
    pass

def set_clipboard_text(text: str) -> None: ...
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
def set_cursor_pos(local_pos: Tuple[float, float]) -> None:
    """
    [window-local] '
    """
    pass

def set_cursor_pos_x(local_x: float) -> None:
    """
    [window-local] '
    """
    pass

def set_cursor_pos_y(local_y: float) -> None:
    """
    [window-local] '
    """
    pass

def set_cursor_screen_pos(pos: Tuple[float, float]) -> None:
    """
    Cursor position, absolute coordinates. this is your best friend.
    """
    pass

def set_drag_drop_payload(type_: str, data: Any, cond: int=0) -> bool:
    """
    Type is a user defined string of maximum 32 characters. strings starting with '_' are reserved for dear imgui internal types.
    Return true when payload has been accepted.
    pygui note: Data is stored by pygui so that an abitrary python object can
    can stored.
    """
    pass

def set_item_default_focus() -> None:
    """
    Focus, Activation
    Make last item the default focused item of of a newly appearing window.
    """
    pass

# def set_item_key_owner(key: int) -> None:
#     """
#     Inputs Utilities: Key/Input Ownership [BETA]
#     - One common use case would be to allow your items to disable standard inputs behaviors such
#     as Tab or Alt key handling, Mouse Wheel scrolling, etc.
#     e.g. Button(...); SetItemKeyOwner(ImGuiKey_MouseWheelY); to make hovering/activating a button disable wheel for scrolling.
#     - Reminder ImGuiKey enum include access to mouse buttons and gamepad, so key ownership can apply to them.
#     - Many related features are still in imgui_internal.h. For instance, most IsKeyXXX()/IsMouseXXX() functions have an owner-id-aware version.
#     Set key owner to last item id if it is hovered or active. equivalent to 'if (isitemhovered() || isitemactive()) ( setkeyowner(key, getitemid());'.
#     """
#     pass

def set_item_tooltip(fmt: str) -> None:
    """
    Set a text-only tooltip if preceding item was hovered. override any previous call to settooltip().
    """
    pass

def set_keyboard_focus_here(offset: int=0) -> None:
    """
    Focus keyboard on the next widget. use positive 'offset' to access sub components of a multiple component widget. use -1 to access previous widget.
    """
    pass

def set_mouse_cursor(cursor_type: int) -> None:
    """
    Set desired mouse cursor shape
    """
    pass

# def set_nav_cursor_visible(visible: bool) -> None:
#     """
#     Keyboard/Gamepad Navigation
#     Alter visibility of keyboard/gamepad cursor. by default: show when using an arrow key, hide when clicking with mouse.
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

# def set_next_item_allow_overlap() -> None:
#     """
#     Overlapping mode
#     Allow next item to be overlapped by a subsequent item. useful with invisible buttons, selectable, treenode covering an area where subsequent items may need to be added. note that both selectable() and treenode() have dedicated flags doing this.
#     """
#     pass

def set_next_item_open(is_open: bool, cond: int=0) -> None:
    """
    Set next treenode/collapsingheader open state.
    """
    pass

def set_next_item_selection_user_data(selection_user_data: Any) -> None: ...
# def set_next_item_shortcut(key_chord: int, flags: int=0) -> None: ...
# def set_next_item_storage_id(storage_id: int) -> None:
#     """
#     Set id to use for open/close storage (default to same as item id).
#     """
#     pass

def set_next_item_width(item_width: float) -> None:
    """
    Set width of the _next_ common large 'item+label' widget. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -flt_min always align width to the right side)
    """
    pass

def set_next_window_bg_alpha(alpha: float) -> None:
    """
    Set next window background color alpha. helper to easily override the alpha component of imguicol_windowbg/childbg/popupbg. you may also use imguiwindowflags_nobackground.
    """
    pass

# def set_next_window_class(window_class: ImGuiWindowClass) -> None:
#     """
#     Set next window class (control docking compatibility + provide hints to platform backend via custom viewport flags and platform parent/child relationship)
#     """
#     pass

def set_next_window_collapsed(collapsed: bool, cond: int=0) -> None:
    """
    Set next window collapsed state. call before begin()
    """
    pass

def set_next_window_content_size(size: Tuple[float, float]) -> None:
    """
    Set next window content size (~ scrollable client area, which enforce the range of scrollbars). not including window decorations (title bar, menu bar, etc.) nor windowpadding. set an axis to 0.0f to leave it automatic. call before begin()
    """
    pass

def set_next_window_dock_id(dock_id: int, cond: int=0) -> None:
    """
    Set next window dock id
    """
    pass

def set_next_window_focus() -> None:
    """
    Set next window to be focused / top-most. call before begin()
    """
    pass

def set_next_window_pos(pos: Tuple[float, float], cond: int=0, pivot: tuple=(0, 0)) -> None:
    """
    Window manipulation
    - Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
    Set next window position. call before begin(). use pivot=(0.5f,0.5f) to center on given point, etc.
    """
    pass

def set_next_window_scroll(scroll: Tuple[float, float]) -> None:
    """
    Set next window scrolling value (use < 0.0f to not affect a given axis).
    """
    pass

def set_next_window_size(size: Tuple[float, float], cond: int=0) -> None:
    """
    Set next window size. set axis to 0.0f to force an auto-fit on this axis. call before begin()
    """
    pass

def set_next_window_size_constraints(size_min: Tuple[float, float], size_max: Tuple[float, float], custom_callback: Callable=None, custom_callback_data: Any=None) -> None:
    """
    Set next window size limits. use 0.0f or flt_max if you don't want limits. use -1 for both min and max of same axis to preserve current size (which itself is a constraint). use callback to apply non-trivial programmatic constraints.
    """
    pass

def set_next_window_viewport(viewport_id: int) -> None:
    """
    Set next window viewport
    """
    pass

def set_scroll_from_pos_x(local_x: float, center_x_ratio: float=0.5) -> None:
    """
    Adjust scrolling amount to make given position visible. generally getcursorstartpos() + offset to compute a valid position.
    """
    pass

def set_scroll_from_pos_y(local_y: float, center_y_ratio: float=0.5) -> None:
    """
    Adjust scrolling amount to make given position visible. generally getcursorstartpos() + offset to compute a valid position.
    """
    pass

def set_scroll_here_x(center_x_ratio: float=0.5) -> None:
    """
    Adjust scrolling amount to make current cursor position visible. center_x_ratio=0.0: left, 0.5: center, 1.0: right. when using to make a 'default/current item' visible, consider using setitemdefaultfocus() instead.
    """
    pass

def set_scroll_here_y(center_y_ratio: float=0.5) -> None:
    """
    Adjust scrolling amount to make current cursor position visible. center_y_ratio=0.0: top, 0.5: center, 1.0: bottom. when using to make a 'default/current item' visible, consider using setitemdefaultfocus() instead.
    """
    pass

def set_scroll_x(scroll_x: float) -> None:
    """
    Set scrolling amount [0 .. getscrollmaxx()]
    """
    pass

def set_scroll_y(scroll_y: float) -> None:
    """
    Set scrolling amount [0 .. getscrollmaxy()]
    """
    pass

# def set_state_storage(storage: ImGuiStorage) -> None:
#     """
#     Replace current window storage with our own (if you want to manipulate it yourself, typically clear subsection of it)
#     """
#     pass

def set_tab_item_closed(tab_or_docked_window_label: str) -> None:
    """
    Notify tabbar or docking system of a closed tab/window ahead (useful to reduce visual flicker on reorderable tab bars). for tab-bar: call after begintabbar() and before tab submissions. otherwise call with a window name.
    """
    pass

def set_tooltip(fmt: str) -> None:
    """
    Set a text-only tooltip. often used after a imgui::isitemhovered() check. override any previous call to settooltip().
    """
    pass

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

# def set_window_pos(pos: Tuple[float, float], cond: int=0) -> None:
#     """
#     (not recommended) set current window position - call within begin()/end(). prefer using setnextwindowpos(), as this may incur tearing and side-effects.
#     """
#     pass

# def set_window_pos_str(name: str, pos: Tuple[float, float], cond: int=0) -> None:
#     """
#     Set named window position.
#     """
#     pass

# def set_window_size(size: Tuple[float, float], cond: int=0) -> None:
#     """
#     (not recommended) set current window size - call within begin()/end(). set to imvec2(0, 0) to force an auto-fit. prefer using setnextwindowsize(), as this may incur tearing and minor side-effects.
#     """
#     pass

# def set_window_size_str(name: str, size: Tuple[float, float], cond: int=0) -> None:
#     """
#     Set named window size. set axis to 0.0f to force an auto-fit on this axis.
#     """
#     pass

def shortcut(key_chord: int, flags: int=0) -> bool:
    """
    Inputs Utilities: Shortcut Testing & Routing [BETA]
    - ImGuiKeyChord = a ImGuiKey + optional ImGuiMod_Alt/ImGuiMod_Ctrl/ImGuiMod_Shift/ImGuiMod_Super.
    ImGuiKey_C                          // Accepted by functions taking ImGuiKey or ImGuiKeyChord arguments)
    ImGuiMod_Ctrl | ImGuiKey_C          // Accepted by functions taking ImGuiKeyChord arguments)
    only ImGuiMod_XXX values are legal to combine with an ImGuiKey. You CANNOT combine two ImGuiKey values.
    - The general idea is that several callers may register interest in a shortcut, and only one owner gets it.
    Parent   -> call Shortcut(Ctrl+S)    // When Parent is focused, Parent gets the shortcut.
    Child1 -> call Shortcut(Ctrl+S)    // When Child1 is focused, Child1 gets the shortcut (Child1 overrides Parent shortcuts)
    Child2 -> no call                  // When Child2 is focused, Parent gets the shortcut.
    The whole system is order independent, so if Child1 makes its calls before Parent, results will be identical.
    This is an important property as it facilitate working with foreign code or larger codebase.
    - To understand the difference:
    - IsKeyChordPressed() compares mods and call IsKeyPressed() -> function has no side-effect.
    - Shortcut() submits a route, routes are resolved, if it currently can be routed it calls IsKeyChordPressed() -> function has (desirable) side-effects as it can prevents another call from getting the route.
    - Visualize registered routes in 'Metrics/Debugger->Inputs'.
    """
    pass

def show_about_window(p_open: Bool=None) -> None:
    """
    Create about window. display dear imgui version, credits and build/system information.
    """
    pass

def show_debug_log_window(p_open: Bool=None) -> None:
    """
    Create debug log window. display a simplified log of important dear imgui events.
    """
    pass

def show_demo_window(p_open: Bool=None) -> None:
    """
    Demo, Debug, Information
    Create demo window. demonstrate most imgui features. call this to learn about the library! try to make it always available in your application!
    """
    pass

def show_font_selector(label: str) -> None:
    """
    Add font selector block (not a window), essentially a combo listing the loaded fonts.
    """
    pass

def show_id_stack_tool_window(p_open: Bool=None) -> None:
    """
    Create stack tool window. hover items with mouse to query information about the source of their unique id.
    """
    pass

def show_metrics_window(p_open: Bool=None) -> None:
    """
    Create metrics/debugger window. display dear imgui internals: windows, draw commands, various internal state, etc.
    """
    pass

def show_style_editor(ref: ImGuiStyle=None) -> None:
    """
    Add style editor block (not a window). you can pass in a reference imguistyle structure to compare to, revert to and save to (else it uses the default style)
    """
    pass

def show_style_selector(label: str) -> bool:
    """
    Add style selector block (not a window), essentially a combo listing the default styles.
    """
    pass

def show_user_guide() -> None:
    """
    Add basic help/info block (not a window): how to manipulate imgui as an end-user (mouse/keyboard controls).
    """
    pass

def slider_angle(label: str, v_rad: Float, v_degrees_min: float=-360.0, v_degrees_max: float=+360.0, format_: str="%.0f deg", flags: int=0) -> bool:
    """
    Implied v_degrees_min = -360.0f, v_degrees_max = +360.0f, format = '%.0f deg', flags = 0
    """
    pass

def slider_float(label: str, value: Float, v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool:
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

def slider_float2(label: str, float_ptrs: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied format = '%.3f', flags = 0
    """
    pass

def slider_float3(label: str, float_ptrs: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied format = '%.3f', flags = 0
    """
    pass

def slider_float4(label: str, float_ptrs: Sequence[Float], v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool:
    """
    Implied format = '%.3f', flags = 0
    """
    pass

def slider_int(label: str, value: Int, v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool:
    """
    Implied format = '%d', flags = 0
    """
    pass

def slider_int2(label: str, int_ptrs: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool:
    """
    Implied format = '%d', flags = 0
    """
    pass

def slider_int3(label: str, int_ptrs: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool:
    """
    Implied format = '%d', flags = 0
    """
    pass

def slider_int4(label: str, int_ptrs: Sequence[Int], v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool:
    """
    Implied format = '%d', flags = 0
    """
    pass

def slider_scalar(label: str, data_type: int, p_data: "Int | Long | Float | Double", _min: "int | float", _max: "int | float", format_: str=None, flags: int=0) -> bool: ...
def slider_scalar_n(label: str, data_type: int, p_data: "Sequence[Int | Long | Float | Double]", components: int, p_min: "int | float", p_max: "int | float", format_: str=None, flags: int=0) -> bool: ...
def small_button(label: str) -> bool:
    """
    Button with (framepadding.y == 0) to easily embed within text
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

def tab_item_button(label: str, flags: int=0) -> bool:
    """
    Create a tab behaving like a button. return true when clicked. cannot be selected in the tab bar.
    """
    pass

# def table_angled_headers_row() -> None:
#     """
#     Submit a row with angled headers for every column with the imguitablecolumnflags_angledheader flag. must be first row.
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

# def table_get_hovered_column() -> int:
#     """
#     Return hovered column. return -1 when table is not hovered. return columns_count if the unused space at the right of visible columns is hovered. can also use (tablegetcolumnflags() & imguitablecolumnflags_ishovered) instead.
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

def table_header(label: str) -> None:
    """
    Submit one header cell manually (rarely used)
    """
    pass

def table_headers_row() -> None:
    """
    Submit a row with headers cells based on data provided to tablesetupcolumn() + submit context menu
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

def table_set_bg_color(target: int, color: int, column_n: int=-1) -> None:
    """
    Change the color of a cell, row, or column. see imguitablebgtarget_ flags for details.
    """
    pass

def table_set_column_enabled(column_n: int, v: bool) -> None:
    """
    Change user accessible enabled/disabled state of a column. set to false to hide the column. user can use the context menu to change this themselves (right-click in headers, or right-click in columns body with imguitableflags_contextmenuinbody)
    """
    pass

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

def text_colored(col: Tuple[float, float, float, float], fmt: str) -> None:
    """
    Shortcut for pushstylecolor(imguicol_text, col); text(fmt, ...); popstylecolor();
    """
    pass

def text_disabled(fmt: str) -> None:
    """
    Shortcut for pushstylecolor(imguicol_text, style.colors[imguicol_textdisabled]); text(fmt, ...); popstylecolor();
    """
    pass

# def text_link(label: str) -> bool:
#     """
#     Hyperlink text button, return true when clicked
#     """
#     pass

# def text_link_open_url(label: str) -> None:
#     """
#     Implied url = null
#     """
#     pass

# def text_link_open_url_ex(label: str, url: str=None) -> None:
#     """
#     Hyperlink text button, automatically open file/url when clicked
#     """
#     pass

def text_unformatted(text: str, text_end: str=None) -> None:
    """
    Raw text without formatting. roughly equivalent to text('%s', text) but: a) doesn't require null terminated string if 'text_end' is specified, b) it's faster, no memory copy is done, no buffer size limits, recommended for long chunks of text.
    """
    pass

def text_wrapped(fmt: str) -> None:
    """
    Shortcut for pushtextwrappos(0.0f); text(fmt, ...); poptextwrappos();. note that this won't work on an auto-resizing window if there's no other widgets to extend the window width, yoy may need to set a size using setnextwindowsize().
    """
    pass

def tree_node(label: str, flags: int=0) -> bool:
    """
    Widgets: Trees
    - TreeNode functions return true when the node is open, in which case you need to also call TreePop() when you are finished displaying the tree node contents.
    """
    pass

def tree_node_str(str_id: str, fmt: str) -> bool:
    """
    Helper variation to easily decorelate the id from the displayed string. read the faq about why and how to use id. to align arbitrary text at the same level as a treenode() you can use bullet().
    """
    pass

def tree_pop() -> None:
    """
    ~ unindent()+popid()
    """
    pass

def tree_push(obj: object) -> None:
    """
    ~ indent()+pushid(). already called by treenode() when returning true, but you can call treepush/treepop yourself if desired.
    pygui note: Uses python's hash() function on the object passed in.
    """
    pass

def unindent(indent_w: float=0.0) -> None:
    """
    Move content position back to the left, by indent_w, or style.indentspacing if indent_w <= 0
    """
    pass

def update_platform_windows() -> None:
    """
    (Optional) Platform/OS interface for multi-viewport support
    Read comments around the ImGuiPlatformIO structure for more details.
    Note: You may use GetWindowViewport() to get the current viewport of the current window.
    Call in main loop. will call createwindow/resizewindow/etc. platform functions for each secondary viewport, and destroywindow for each inactive viewport.
    """
    pass

def vslider_float(label: str, size: Tuple[float, float], v: Float, v_min: float, v_max: float, format_: str="%.3f", flags: int=0) -> bool: ...
def vslider_int(label: str, size: Tuple[float, float], v: Int, v_min: int, v_max: int, format_: str="%d", flags: int=0) -> bool: ...
def vslider_scalar(label: str, size: Tuple[float, float], data_type: int, p_data: "Int | Long | Float | Double", _min: "int | float", _max: "int | float", format_: str=None, flags: int=0) -> bool: ...

class GLFWmonitor: ...

class GLFWwindow: ...

class ImDrawCmd:
    """
    Typically, 1 command = 1 GPU draw call (unless command is a callback)
    - VtxOffset: When 'io.BackendFlags & ImGuiBackendFlags_RendererHasVtxOffset' is enabled,
    this fields allow us to render meshes larger than 64K vertices while keeping 16-bit indices.
    Backends made for <1.71. will typically ignore the VtxOffset fields.
    - The ClipRect/TextureId/VtxOffset fields must be contiguous as we memcmp() them together (this is asserted for).
    """
    clip_rect: Tuple[float, float, float, float]
    """
    4*4  // clipping rectangle (x1, y1, x2, y2). subtract imdrawdata->displaypos to get clipping rectangle in 'viewport' coordinates
    """
    elem_count: int
    """
    4    // number of indices (multiple of 3) to be rendered as triangles. vertices are stored in the callee imdrawlist's vtx_buffer[] array, indices in idx_buffer[].
    """
    idx_offset: int
    """
    4    // start offset in index buffer.
    """
    # texture_id: object
    # """
    # 4-8  // user-provided texture id. set by user in imfontatlas::settexid() for fonts or passed to image*() functions. ignore if never using images or multiple fonts atlas.
    # """
    # user_callback: Callable
    # """
    # 4-8  // if != null, call the function instead of rendering the vertices. clip_rect and texture_id will be set normally.
    # """
    # user_callback_data: Any
    # """
    # 4-8  // callback user data (when usercallback != null). if called addcallback() with size == 0, this is a copy of the addcallback() argument. if called addcallback() with size > 0, this is pointing to a buffer where data is stored.
    # """
    # user_callback_data_offset: int
    # """
    # 4 // [internal] offset of callback user data when using storage, otherwise -1.
    # """
    # user_callback_data_size: int
    # """
    # 4 // size of callback user data when using storage, otherwise 0.
    # """
    vtx_offset: int
    """
    4    // start offset in vertex buffer. imguibackendflags_rendererhasvtxoffset: always 0, otherwise may be >0 to support meshes larger than 64k vertices with 16-bit indices.
    """
    # def get_tex_id(self: ImDrawCmd) -> Any:
    #     """
    #     Since 1.83: returns ImTextureID associated with this draw call. Warning: DO NOT assume this is always same as 'TextureId' (we will change this function for an upcoming feature)
    #     """
    #     pass


class ImDrawData:
    """
    Array of imdrawlist* to render. the imdrawlists are owned by imguicontext and only pointed to from here.
    """
    cmd_lists: List[ImVector_ImDrawListPtr]
    """
    Array of imdrawlist* to render. the imdrawlists are owned by imguicontext and only pointed to from here.
    """
    cmd_lists_count: int
    """
    Number of imdrawlist* to render
    """
    # display_pos: Tuple[float, float]
    # """
    # Top-left position of the viewport to render (== top-left of the orthogonal projection matrix to use) (== getmainviewport()->pos for the main viewport, == (0.0) in most single-viewport applications)
    # """
    # display_size: Tuple[float, float]
    # """
    # Size of the viewport to render (== getmainviewport()->size for the main viewport, == io.displaysize in most single-viewport applications)
    # """
    # framebuffer_scale: Tuple[float, float]
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
    # def add_draw_list(self: ImDrawData, draw_list: ImDrawList) -> None:
    #     """
    #     Helper to add an external draw list into an existing imdrawdata.
    #     """
    #     pass

    # def clear(self: ImDrawData) -> None: ...
    # def de_index_all_buffers(self: ImDrawData) -> None:
    #     """
    #     Helper to convert all buffers from indexed to non-indexed, in case you cannot render indexed. note: this is slow and most likely a waste of resources. always prefer indexed rendering!
    #     """
    #     pass

    def scale_clip_rects(self: ImDrawData, fb_scale: Tuple[float, float]) -> None:
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
    You are totally free to apply whatever transformation matrix you want to the data (depending on the use of the transformation you may want to apply it to ClipRect as well!)
    Important: Primitives are always added to the list and not culled (culling is done at higher-level by ImGui:: functions), if you use this API a lot consider coarse culling your drawn objects.
    """
    # callbacks_data_buf: ImVector_ImU8
    # """
    # [internal]
    # """
    cmd_buffer: List[ImDrawCmd]
    """
    This is what you have to render
    Draw commands. typically 1 command = 1 gpu draw call, unless the command is a callback.
    """
    flags: int
    """
    Flags, you may poke into these to adjust anti-aliasing settings per-primitive.
    """
    idx_buffer: ImVector_ImDrawIdx
    """
    Index buffer. each command consume imdrawcmd::elemcount of those
    """
    owner_name: str
    """
    Pointer to owner window's name for debugging
    """
    vtx_buffer: List[ImDrawVert]
    """
    Vertex buffer.
    """
    def add_bezier_cubic(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int, thickness: float, num_segments: int=0) -> None:
        """
        Cubic bezier (4 control points)
        """
        pass

    def add_bezier_quadratic(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int, thickness: float, num_segments: int=0) -> None:
        """
        Quadratic bezier (3 control points)
        """
        pass

    # def add_callback(self: ImDrawList, callback: Callable, userdata: Any) -> None:
    #     """
    #     Advanced: Draw Callbacks
    #     - May be used to alter render state (change sampler, blending, current shader). May be used to emit custom rendering commands (difficult to do correctly, but possible).
    #     - Use special ImDrawCallback_ResetRenderState callback to instruct backend to reset its render state to the default.
    #     - Your rendering loop must check for 'UserCallback' in ImDrawCmd and call the function instead of rendering triangles. All standard backends are honoring this.
    #     - For some backends, the callback may access selected render-states exposed by the backend in a ImGui_ImplXXXX_RenderState structure pointed to by platform_io.Renderer_RenderState.
    #     - IMPORTANT: please be mindful of the different level of indirection between using size==0 (copying argument) and using size>0 (copying pointed data into a buffer).
    #     - If userdata_size == 0: we copy/store the 'userdata' argument as-is. It will be available unmodified in ImDrawCmd::UserCallbackData during render.
    #     - If userdata_size > 0,  we copy/store 'userdata_size' bytes pointed to by 'userdata'. We store them in a buffer stored inside the drawlist. ImDrawCmd::UserCallbackData will point inside that buffer so you have to retrieve data from there. Your callback may need to use ImDrawCmd::UserCallbackDataSize if you expect dynamically-sized data.
    #     - Support for userdata_size > 0 was added in v1.91.4, October 2024. So earlier code always only allowed to copy/store a simple void*.
    #     Implied userdata_size = 0
    #     """
    #     pass

    # def add_callback_ex(self: ImDrawList, callback: Callable, userdata: Any, userdata_size: int=0) -> None: ...
    def add_circle(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int=0, thickness: float=1.0) -> None: ...
    def add_circle_filled(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int=0) -> None: ...
    def add_concave_poly_filled(self: ImDrawList, points: Sequence[tuple], col: int) -> None: ...
    def add_convex_poly_filled(self: ImDrawList, points: Sequence[tuple], col: int) -> None: ...
    # def add_draw_cmd(self: ImDrawList) -> None:
    #     """
    #     Advanced: Miscellaneous
    #     This is useful if you need to forcefully create a new draw call (to allow for dependent rendering / blending). otherwise primitives are merged into the same draw-call as much as possible
    #     """
    #     pass

    def add_ellipse(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], col: int, rot: float=0.0, num_segments: int=0, thickness: float=1.0) -> None: ...
    def add_ellipse_filled(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], col: int, rot: float=0.0, num_segments: int=0) -> None: ...
    def add_image(self: ImDrawList, user_texture_id: int, p_min: Tuple[float, float], p_max: Tuple[float, float], uv_min: tuple=(0, 0), uv_max: tuple=(1, 1), col: int=IM_COL32_WHITE) -> None:
        """
        Image primitives
        - Read FAQ to understand what ImTextureID is.
        - "p_min" and "p_max" represent the upper-left and lower-right corners of the rectangle.
        - "uv_min" and "uv_max" represent the normalized texture coordinates to use for those corners. Using (0,0)->(1,1) texture coordinates will generally display the entire texture.
        Implied uv_min = imvec2(0, 0), uv_max = imvec2(1, 1), col = im_col32_white
        """
        pass

    def add_image_quad(self: ImDrawList, user_texture_id: int, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], uv1: tuple=(0, 0), uv2: tuple=(1, 0), uv3: tuple=(1, 1), uv4: tuple=(0, 1), col: int=IM_COL32_WHITE) -> None: ...
    def add_image_rounded(self: ImDrawList, user_texture_id: int, p_min: Tuple[float, float], p_max: Tuple[float, float], uv_min: Tuple[float, float], uv_max: Tuple[float, float], col: int, rounding: float, flags: int=0) -> None: ...
    def add_line(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], col: int, thickness: float=1.0) -> None:
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

    def add_ngon(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int, thickness: float=1.0) -> None: ...
    def add_ngon_filled(self: ImDrawList, center: Tuple[float, float], radius: float, col: int, num_segments: int) -> None: ...
    def add_polyline(self: ImDrawList, points: Sequence[tuple], col: int, flags: int, thickness: float) -> None:
        """
        General polygon
        - Only simple polygons are supported by filling functions (no self-intersections, no holes).
        - Concave polygon fill is more expensive than convex one: it has O(N^2) complexity. Provided as a convenience fo user but not used by main library.
        """
        pass

    def add_quad(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int, thickness: float=1.0) -> None: ...
    def add_quad_filled(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], col: int) -> None: ...
    def add_rect(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col: int, rounding: float=0.0, flags: int=0, thickness: float=1.0) -> None:
        """
        A: upper-left, b: lower-right (== upper-left + size)
        """
        pass

    def add_rect_filled(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col: int, rounding: float=0.0, flags: int=0) -> None:
        """
        A: upper-left, b: lower-right (== upper-left + size)
        """
        pass

    def add_rect_filled_multi_color(self: ImDrawList, p_min: Tuple[float, float], p_max: Tuple[float, float], col_upr_left: int, col_upr_right: int, col_bot_right: int, col_bot_left: int) -> None: ...
    def add_text(self: ImDrawList, pos: Tuple[float, float], col: int, text: str) -> None: ...
    def add_text_imfont(self: ImDrawList, font: ImFont, font_size: float, pos: tuple, col: int, text: str, wrap_width: float=0.0, cpu_fine_clip_rect: Tuple[float, float, float, float]=None) -> None: ...
    def add_triangle(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int, thickness: float=1.0) -> None: ...
    def add_triangle_filled(self: ImDrawList, p1: Tuple[float, float], p2: Tuple[float, float], p3: Tuple[float, float], col: int) -> None: ...
    def channels_merge(self: ImDrawList) -> None: ...
    def channels_set_current(self: ImDrawList, n: int) -> None: ...
    def channels_split(self: ImDrawList, count: int) -> None:
        """
        Advanced: Channels
        - Use to split render into layers. By switching channels to can render out-of-order (e.g. submit FG primitives before BG primitives)
        - Use to minimize draw calls (e.g. if going back-and-forth between multiple clipping rectangles, prefer to append into separate channels then merge at the end)
        - This API shouldn't have been in ImDrawList in the first place!
        Prefer using your own persistent instance of ImDrawListSplitter as you can stack them.
        Using the ImDrawList::ChannelsXXXX you cannot stack a split over another.
        """
        pass

    # def clone_output(self: ImDrawList) -> ImDrawList:
    #     """
    #     Create a clone of the cmdbuffer/idxbuffer/vtxbuffer.
    #     """
    #     pass

    def path_arc_to(self: ImDrawList, center: Tuple[float, float], radius: float, a_min: float, a_max: float, num_segments: int=0) -> None: ...
    def path_arc_to_fast(self: ImDrawList, center: Tuple[float, float], radius: float, a_min_of_12: int, a_max_of_12: int) -> None:
        """
        Use precomputed angles for a 12 steps circle
        pygui note: The _ex version of this function is a private function in imgui.h
        This function works like a clock. But 0 and 12 is East and 6 is West.
        """
        pass

    def path_bezier_cubic_curve_to(self: ImDrawList, p2: Tuple[float, float], p3: Tuple[float, float], p4: Tuple[float, float], num_segments: int=0) -> None:
        """
        Cubic bezier (4 control points)
        """
        pass

    def path_bezier_quadratic_curve_to(self: ImDrawList, p2: Tuple[float, float], p3: Tuple[float, float], num_segments: int=0) -> None:
        """
        Quadratic bezier (3 control points)
        """
        pass

    def path_clear(self: ImDrawList) -> None:
        """
        Stateful path API, add points then finish with PathFillConvex() or PathStroke()
        - Important: filled shapes must always use clockwise winding order! The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
        so e.g. 'PathArcTo(center, radius, PI * -0.5f, PI)' is ok, whereas 'PathArcTo(center, radius, PI, PI * -0.5f)' won't have correct anti-aliasing when followed by PathFillConvex().
        """
        pass

    # def path_elliptical_arc_to(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], rot: float, a_min: float, a_max: float) -> None:
    #     """
    #     Implied num_segments = 0
    #     """
    #     pass

    # def path_elliptical_arc_to_ex(self: ImDrawList, center: Tuple[float, float], radius: Tuple[float, float], rot: float, a_min: float, a_max: float, num_segments: int=0) -> None:
    #     """
    #     Ellipse
    #     """
    #     pass

    # def path_fill_concave(self: ImDrawList, col: int) -> None: ...
    def path_fill_convex(self: ImDrawList, col: int) -> None: ...
    def path_line_to(self: ImDrawList, pos: Tuple[float, float]) -> None: ...
    def path_line_to_merge_duplicate(self: ImDrawList, pos: Tuple[float, float]) -> None: ...
    def path_rect(self: ImDrawList, rect_min: Tuple[float, float], rect_max: Tuple[float, float], rounding: float=0.0, flags: int=0) -> None: ...
    def path_stroke(self: ImDrawList, col: int, flags: int=0, thickness: float=1.0) -> None: ...
    def pop_clip_rect(self: ImDrawList) -> None: ...
    # def pop_texture_id(self: ImDrawList) -> None: ...
    def push_clip_rect(self: ImDrawList, clip_rect_min: Tuple[float, float], clip_rect_max: Tuple[float, float], intersect_with_current_clip_rect: bool=False) -> None:
        """
        Render-level scissoring. this is passed down to your render function but not used for cpu-side coarse clipping. prefer using higher-level imgui::pushcliprect() to affect logic (hit-testing and widget culling)
        """
        pass

    # def push_clip_rect_full_screen(self: ImDrawList) -> None: ...
    # def push_texture_id(self: ImDrawList, texture_id: Any) -> None: ...
    # def set_texture_id(self: ImDrawList, texture_id: Any) -> None: ...

class ImDrawListSplitter:
    """
    Split/Merge functions are used to split the draw list into different layers which can be drawn into out of order.
    This is used by the Columns/Tables API, so items of each column can be batched together in a same draw call.
    pygui note: This class is instantiable with ImGuiListClipper.create()
    """
    def create() -> ImDrawListSplitter:
        """
        Create a dynamically allocated instance of ImDrawListSplitter. Must
        also be freed with destroy().
        """
        pass

    def destroy(self: ImDrawListSplitter) -> None:
        """
        Mimics the destructor of ccimgui.ImDrawListSplitter
        """
        pass

    def merge(self: ImDrawListSplitter, draw_list: ImDrawList) -> None: ...
    def set_current_channel(self: ImDrawListSplitter, draw_list: ImDrawList, channel_idx: int) -> None: ...
    def split(self: ImDrawListSplitter, draw_list: ImDrawList, count: int) -> None: ...

class ImDrawVert:
    col: int
    pos: Tuple[float, float]
    uv: Tuple[float, float]

class ImFont:
    """
    Font runtime data and rendering
    ImFontAtlas automatically loads a default embedded font for you when you call GetTexDataAsAlpha8() or GetTexDataAsRGBA32().
    """
    ascent: float
    """
    4+4   // out //// ascent: distance from top to bottom of e.g. 'a' [0..fontsize] (unscaled)
    """
    config_data: ImFontConfig
    """
    4-8   // in  //// pointer within containeratlas->configdata
    pygui note: Returns a const ImFontConfig. Fields should only be read,
    not modified.
    """
    config_data_count: int
    """
    2 // in  // ~ 1// number of imfontconfig involved in creating this font. bigger than 1 when merging multiple font sources into one imfont.
    """
    container_atlas: ImFontAtlas
    """
    Members: Cold ~32/40 bytes
    4-8   // out //// what we has been loaded into
    """
    descent: float
    """
    4+4   // out //// ascent: distance from top to bottom of e.g. 'a' [0..fontsize] (unscaled)
    """
    dirty_lookup_tables: bool
    """
    1 // out //
    """
    ellipsis_char: int
    """
    2 // out // = '...'/'.'// character used for ellipsis rendering.
    """
    ellipsis_char_count: int
    """
    1 // out // 1 or 3
    """
    ellipsis_char_step: float
    """
    4 // out   // step between characters when ellipsiscount > 0
    """
    ellipsis_width: float
    """
    4 // out   // width
    """
    fallback_advance_x: float
    """
    4 // out // = fallbackglyph->advancex
    """
    fallback_char: int
    """
    2 // out // = fffd/'?' // character used if a glyph isn't found.
    """
    fallback_glyph: ImFontGlyph
    """
    4-8   // out // = findglyph(fontfallbackchar)
    """
    font_size: float
    """
    4 // in  //// height of characters/line, set during loading (don't change after loading)
    """
    glyphs: List[ImFontGlyph]
    """
    12-16 // out //// all glyphs.
    """
    index_advance_x: List[float]
    """
    Members: Hot ~20/24 bytes (for CalcTextSize)
    12-16 // out //// sparse. glyphs->advancex in a directly indexable way (cache-friendly for calctextsize functions which only this info, and are often bottleneck in large ui).
    """
    index_lookup: List[int]
    """
    Members: Hot ~28/40 bytes (for CalcTextSize + render loop)
    12-16 // out //// sparse. index glyphs by unicode code-point.
    """
    metrics_total_surface: int
    """
    4 // out //// total surface in pixels to get an idea of the font rasterization/texture cost (not exact, we approximate the cost of padding between glyphs)
    """
    scale: float
    """
    4 // in  // = 1.f  // base font scale, multiplied by the per-window font scale which you can adjust with setwindowfontscale()
    """
    used4k_pages_map: bytes
    """
    2 bytes if imwchar=imwchar16, 34 bytes if imwchar==imwchar32. store 1-bit for each block of 4k codepoints that has one active glyph. this is mainly used to facilitate iterations across all used codepoints.
    """
    # def calc_text_size_a(self: ImFont, size: float, max_width: float, wrap_width: float, text_begin: str) -> Tuple[float, float]:
    #     """
    #     'max_width' stops rendering after a certain width (could be turned into a 2d size). FLT_MAX to disable.
    #     'wrap_width' enable automatic word-wrapping across multiple lines to fit into given width. 0.0f to disable.
    #     Implied text_end = null, remaining = null
    #     """
    #     pass

    # def calc_text_size_a_ex(self: ImFont, size: float, max_width: float, wrap_width: float, text_begin: str, text_end: str=None, remaining: Any=None) -> Tuple[float, float]:
    #     """
    #     Utf8
    #     """
    #     pass

    # def calc_word_wrap_position_a(self: ImFont, scale: float, text: str, text_end: str, wrap_width: float) -> str: ...
    # def find_glyph(self: ImFont, c: int) -> ImFontGlyph: ...
    # def find_glyph_no_fallback(self: ImFont, c: int) -> ImFontGlyph: ...
    def get_debug_name(self: ImFont) -> str: ...
    # def render_char(self: ImFont, draw_list: ImDrawList, size: float, pos: Tuple[float, float], col: int, c: int) -> None: ...
    # def render_text(self: ImFont, draw_list: ImDrawList, size: float, pos: Tuple[float, float], col: int, clip_rect: Tuple[float, float, float, float], text_begin: str, text_end: str, wrap_width: float=0.0, cpu_fine_clip: bool=False) -> None: ...

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
    config_data: List[ImFontConfig]
    """
    Configuration data
    """
    custom_rects: List[ImFontAtlasCustomRect]
    """
    Rectangles for packing custom texture data into the atlas.
    """
    flags: int
    """
    Build flags (see imfontatlasflags_)
    """
    font_builder_flags: int
    """
    Shared flags (for all fonts) for custom font builder. this is build implementation dependent. per-font override is also available in imfontconfig.
    """
    font_builder_io: ImFontBuilderIO
    """
    [Internal] Font builder
    Opaque interface to a font builder (default to stb_truetype, can be changed to use freetype by defining imgui_enable_freetype).
    """
    fonts: List[ImFont]
    """
    Hold all the fonts returned by addfont*. fonts[0] is the default font upon calling imgui::newframe(), use imgui::pushfont()/popfont() to change the current font.
    """
    locked: bool
    """
    Marked as locked by imgui::newframe() so attempt to modify the atlas will assert.
    """
    pack_id_lines: int
    """
    Custom texture rectangle id for baked anti-aliased lines
    """
    pack_id_mouse_cursors: int
    """
    [Internal] Packing data
    Custom texture rectangle id for white pixel and mouse cursors
    """
    tex_desired_width: int
    """
    Texture width desired by user before build(). must be a power-of-two. if have many glyphs your graphics api have texture size restrictions you may want to increase texture width to decrease height.
    """
    tex_glyph_padding: int
    """
    Padding between glyphs within texture in pixels. defaults to 1. if your rendering method doesn't rely on bilinear filtering you may set this to 0 (will also need to set antialiasedlinesusetex = false).
    """
    tex_height: int
    """
    Texture height calculated during build().
    """
    tex_id: int
    """
    User data to refer to the texture once it has been uploaded to user's graphic systems. it is passed back to you during rendering via the imdrawcmd structure.
    """
    tex_pixels_alpha8: bytes
    """
    1 component per pixel, each component is unsigned 8-bit. total size = texwidth * texheight
    """
    tex_pixels_rgba_32: bytes
    """
    4 component per pixel, each component is unsigned 8-bit. total size = texwidth * texheight * 4
    """
    tex_pixels_use_colors: bool
    """
    Tell whether our texture data is known to use colors (rather than just alpha channel), in order to help backend select a format.
    """
    tex_ready: bool
    """
    [Internal]
    NB: Access texture data via GetTexData*() calls! Which will setup a default font for you.
    Set when texture was built matching current font input
    """
    tex_uv_lines: Vec4
    """
    Uvs for baked anti-aliased lines
    """
    tex_uv_scale: Tuple[float, float]
    """
    = (1.0f/texwidth, 1.0f/texheight)
    """
    tex_uv_white_pixel: Tuple[float, float]
    """
    Texture coordinates to a white pixel
    """
    tex_width: int
    """
    Texture width calculated during build().
    """
    # user_data: Any
    # """
    # Store your own atlas related user-data (if e.g. you have multiple font atlas).
    # """
    # def add_custom_rect_font_glyph(self: ImFontAtlas, font: ImFont, id_: int, width: int, height: int, advance_x: float, offset: Tuple[float, float]=(0, 0)) -> int: ...
    # def add_custom_rect_regular(self: ImFontAtlas, width: int, height: int) -> int:
    #     """
    #     You can request arbitrary rectangles to be packed into the atlas, for your own purposes.
    #     - After calling Build(), you can query the rectangle position and render your pixels.
    #     - If you render colored output, set 'atlas->TexPixelsUseColors = true' as this may help some backends decide of preferred texture format.
    #     - You can also request your rectangles to be mapped as font glyph (given a font + Unicode point),
    #     so you can render e.g. custom colorful icons and use them as regular glyphs.
    #     - Read docs/FONTS.md for more details about using colorful icons.
    #     - Note: this API may be redesigned later in order to support multi-monitor varying DPI settings.
    #     """
    #     pass

    # def add_font(self: ImFontAtlas, font_cfg: ImFontConfig) -> ImFont: ...
    def add_font_default(self: ImFontAtlas, font_cfg: ImFontConfig=None) -> ImFont: ...
    def add_font_from_file_ttf(self: ImFontAtlas, filename: str, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: ImGlyphRange=None) -> ImFont:
        """
        pygui note: The ImFontConfig is copied in ImGui so there is no need to
        keep the object alive after calling this function.
        """
        pass

    # def add_font_from_memory_compressed_base85_ttf(self: ImFontAtlas, compressed_font_data_base85: str, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont:
    #     """
    #     'compressed_font_data_base85' still owned by caller. compress with binary_to_compressed_c.cpp with -base85 parameter.
    #     """
    #     pass

    # def add_font_from_memory_compressed_ttf(self: ImFontAtlas, compressed_font_data: Any, compressed_font_data_size: int, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont:
    #     """
    #     'compressed_font_data' still owned by caller. compress with binary_to_compressed_c.cpp.
    #     """
    #     pass

    # def add_font_from_memory_ttf(self: ImFontAtlas, font_data: Any, font_data_size: int, size_pixels: float, font_cfg: ImFontConfig=None, glyph_ranges: int=None) -> ImFont:
    #     """
    #     Note: transfer ownership of 'ttf_data' to imfontatlas! will be deleted after destruction of the atlas. set font_cfg->fontdataownedbyatlas=false to keep ownership of your data and it won't be freed.
    #     """
    #     pass

    def build(self: ImFontAtlas) -> bool:
        """
        Build atlas, retrieve pixel data.
        User is in charge of copying the pixels into graphics memory (e.g. create a texture with your engine). Then store your texture handle with SetTexID().
        The pitch is always = Width * BytesPerPixels (1 or 4)
        Building in RGBA32 format is provided for convenience and compatibility, but note that unless you manually manipulate or copy color data into
        the texture (e.g. when using the AddCustomRect*** api), then the RGB pixels emitted will always be white (~75% of memory/bandwidth waste.
        Build pixels data. this is called automatically for you by the gettexdata*** functions.
        """
        pass

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
    def get_glyph_ranges_chinese_full(self: ImFontAtlas) -> ImGlyphRange:
        """
        Default + half-width + japanese hiragana/katakana + full set of about 21000 cjk unified ideographs
        """
        pass

    # def get_glyph_ranges_chinese_simplified_common(self: ImFontAtlas) -> int:
    #     """
    #     Default + half-width + japanese hiragana/katakana + set of 2500 cjk unified ideographs for common simplified chinese
    #     """
    #     pass

    def get_glyph_ranges_cyrillic(self: ImFontAtlas) -> ImGlyphRange:
        """
        Default + about 400 cyrillic characters
        """
        pass

    def get_glyph_ranges_default(self: ImFontAtlas) -> ImGlyphRange:
        """
        Helpers to retrieve list of common Unicode ranges (2 value per range, values are inclusive, zero-terminated list)
        NB: Make sure that your string are UTF-8 and NOT in your local code page.
        Read https://github.com/ocornut/imgui/blob/master/docs/FONTS.md/#about-utf-8-encoding for details.
        NB: Consider using ImFontGlyphRangesBuilder to build glyph ranges from textual data.
        Basic latin, extended latin
        """
        pass

    # def get_glyph_ranges_greek(self: ImFontAtlas) -> int:
    #     """
    #     Default + greek and coptic
    #     """
    #     pass

    def get_glyph_ranges_japanese(self: ImFontAtlas) -> ImGlyphRange:
        """
        Default + hiragana, katakana, half-width, selection of 2999 ideographs
        """
        pass

    # def get_glyph_ranges_korean(self: ImFontAtlas) -> ImGlyphRange:
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
    def get_tex_data_as_alpha8(self: ImFontAtlas, out_width: Int, out_height: Int, out_bytes_per_pixel: Int=None) -> bytes:
        """
        1 byte per-pixel
        """
        pass

    def get_tex_data_as_rgba_32(self: ImFontAtlas, out_width: Int, out_height: Int, out_bytes_per_pixel: Int=None) -> bytes:
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
    font: ImFont
    """
    Input    // for custom font glyphs only: target font
    """
    glyph_advance_x: float
    """
    Input    // for custom font glyphs only: glyph xadvance
    """
    # glyph_colored: int
    # """
    # Input  // for custom font glyphs only: glyph is colored, removed tinting.
    # """
    glyph_id: int
    """
    Input    // for custom font glyphs only (id < 0x110000)
    """
    glyph_offset: Tuple[float, float]
    """
    Input    // for custom font glyphs only: glyph display offset
    """
    height: int
    """
    Input    // desired rectangle dimension
    """
    width: int
    """
    Input    // desired rectangle dimension
    """
    x: int
    """
    Output   // packed position in atlas
    """
    y: int
    """
    Output   // packed position in atlas
    """
    def is_packed(self: ImFontAtlasCustomRect) -> bool: ...

class ImFontBuilderIO:
    """
    Opaque interface to a font builder (stb_truetype or freetype).
    """
    pass

class ImFontConfig:
    """
    -1   // explicitly specify unicode codepoint of ellipsis character. when fonts are being merged first specified ellipsis will be used.
    """
    dst_font: ImFont
    ellipsis_char: int
    """
    -1   // explicitly specify unicode codepoint of ellipsis character. when fonts are being merged first specified ellipsis will be used.
    """
    font_builder_flags: int
    """
    0// settings for custom font builder. this is builder implementation dependent. leave as zero if unsure.
    """
    font_data_owned_by_atlas: bool
    """
    True // ttf/otf data ownership taken by the container imfontatlas (will delete memory itself).
    """
    font_data_size: int
    """
    Ttf/otf data size
    """
    font_no: int
    """
    0// index of font within ttf/otf file
    """
    glyph_extra_spacing: Tuple[float, float]
    """
    0, 0 // extra spacing (in pixels) between glyphs. only x axis is supported for now.
    """
    glyph_max_advance_x: float
    """
    Flt_max  // maximum advancex for glyphs
    """
    glyph_min_advance_x: float
    """
    0// minimum advancex for glyphs, set min to align font icons, set both min/max to enforce mono-space font
    """
    glyph_offset: Tuple[float, float]
    """
    0, 0 // offset all glyphs from this font input.
    """
    glyph_ranges: List[int]
    """
    Null // the array data needs to persist as long as the font is alive. pointer to a user-provided list of unicode range (2 value per range, values are inclusive, zero-terminated list).
    """
    merge_mode: bool
    """
    False// merge into previous imfont, so you can combine multiple inputs font into one imfont (e.g. ascii font + icons + japanese glyphs). you may want to use glyphoffset.y when merge font of different heights.
    """
    name: int
    """
    [Internal]
    Name (strictly to ease debugging)
    """
    oversample_h: int
    """
    2// rasterize at higher quality for sub-pixel positioning. note the difference between 2 and 3 is minimal. you can reduce this to 1 for large glyphs save memory. read https://github.com/nothings/stb/blob/master/tests/oversample/readme.md for details.
    """
    oversample_v: int
    """
    1// rasterize at higher quality for sub-pixel positioning. this is not really useful as we don't use sub-pixel positions on the y axis.
    """
    pixel_snap_h: bool
    """
    False// align every glyph to pixel boundary. useful e.g. if you are merging a non-pixel aligned font with the default font. if enabled, you can set oversampleh/v to 1.
    """
    rasterizer_density: float
    """
    1.0f     // dpi scale for rasterization, not altering other font metrics: make it easy to swap between e.g. a 100% and a 400% fonts for a zooming display. important: if you increase this it is expected that you increase font scale accordingly, otherwise quality may look lowered.
    """
    rasterizer_multiply: float
    """
    1.0f // linearly brighten (>1.0f) or darken (<1.0f) font output. brightening small fonts may be a good workaround to make them more readable. this is a silly thing we may remove in the future.
    """
    size_pixels: float
    """
    Size in pixels for rasterizer (more or less maps to the resulting font height).
    """
    def create() -> ImFontConfig:
        """
        Create a dynamically allocated instance of ImFontConfig. Must
        also be freed with destroy().
        """
        pass

    def destroy(self: ImFontConfig) -> None:
        """
        Explicitly frees this instance.
        """
        pass


class ImFontGlyph:
    """
    Hold rendering data for one glyph.
    (Note: some language parsers may fail to convert the 31+1 bitfield members, in this case maybe drop store a single u32 or we can rework this)
    """
    advance_x: float
    """
    Distance to next character (= data from font + imfontconfig::glyphextraspacing.x baked in)
    """
    codepoint: int
    """
    0x0000..0x10ffff
    """
    colored: int
    """
    Flag to indicate glyph is colored and should generally ignore tinting (make it usable with no shift on little-endian as this is used in loops)
    """
    u0: float
    """
    Texture coordinates
    """
    u1: float
    """
    Texture coordinates
    """
    v0: float
    """
    Texture coordinates
    """
    v1: float
    """
    Texture coordinates
    """
    visible: int
    """
    Flag to indicate glyph has no visible pixels (e.g. space). allow early out when rendering.
    """
    x0: float
    """
    Glyph corners
    """
    x1: float
    """
    Glyph corners
    """
    y0: float
    """
    Glyph corners
    """
    y1: float
    """
    Glyph corners
    """

class ImFontGlyphRangesBuilder:
    """
    Helper to build glyph ranges from text/string data. Feed your application strings/characters to it then call BuildRanges().
    This is essentially a tightly packed of vector of 64k booleans = 8KB storage.
    pygui note: This class is instantiable with ImFontGlyphRangesBuilder.create()
    """
    used_chars: List[int]
    """
    Store 1-bit per unicode code point (0=unused, 1=used).
    pygui note: Each integer is an unsigned 4 byte integer. Each integer is
    32 booleans. Use get_bit and set_bit to change the booleans.
    """
    def add_char(self: ImFontGlyphRangesBuilder, c: int) -> None:
        """
        Add character
        """
        pass

    def add_ranges(self: ImFontGlyphRangesBuilder, ranges: ImGlyphRange) -> None:
        """
        Add ranges, e.g. builder.addranges(imfontatlas::getglyphrangesdefault()) to force add all of ascii/latin+ext
        """
        pass

    def add_text(self: ImFontGlyphRangesBuilder, text: str) -> None:
        """
        Add string (each character of the utf-8 string are added)
        """
        pass

    def build_ranges(self: ImFontGlyphRangesBuilder) -> ImGlyphRange:
        """
        Output new ranges (imvector_construct()/imvector_destruct() can be used to safely construct out_ranges
        pygui note: Uses ImGlyphRange wrapper instead. This returns a copy of the
        internal buffer so this instance can be freed immediately after calling
        this function if you need.
        """
        pass

    def clear(self: ImFontGlyphRangesBuilder) -> None: ...
    def create() -> ImFontGlyphRangesBuilder:
        """
        Create a dynamically allocated instance of ImFontGlyphRangesBuilder. Must
        also be freed with destroy().
        """
        pass

    def destroy(self: ImFontGlyphRangesBuilder) -> None:
        """
        Explicitly frees this instance.
        """
        pass

    def get_bit(self: ImFontGlyphRangesBuilder, n: int) -> bool:
        """
        Get bit n in the array
        """
        pass

    def set_bit(self: ImFontGlyphRangesBuilder, n: int) -> None:
        """
        Set bit n in the array
        """
        pass


class ImGuiContext:
    """
    Dear imgui context (opaque structure, unless including imgui_internal.h)
    """
    pass

class ImGuiErrorRecoveryState:
    """
    sizeof() = 20
    """
    # size_of_begin_popup_stack: int
    # size_of_begin_popup_stack: int
    # size_of_color_stack: int
    # size_of_color_stack: int
    # size_of_disabled_stack: int
    # size_of_disabled_stack: int
    # size_of_focus_scope_stack: int
    # size_of_focus_scope_stack: int
    # size_of_font_stack: int
    # size_of_font_stack: int
    # size_of_group_stack: int
    # size_of_group_stack: int
    # size_of_id_stack: int
    # size_of_id_stack: int
    # size_of_item_flags_stack: int
    # size_of_item_flags_stack: int
    # size_of_style_var_stack: int
    # size_of_style_var_stack: int
    # size_of_tree_stack: int
    # size_of_tree_stack: int
    # size_of_window_stack: int
    # size_of_window_stack: int
    def create() -> ImGuiErrorRecoveryState:
        """
        Create a dynamically allocated instance of ImGuiErrorRecoveryState. Must
        also be freed with destroy().
        """
        pass

    def destroy(self: ImGuiErrorRecoveryState) -> None:
        """
        Explicitly frees this instance.
        """
        pass


class ImGuiIO:
    """
    Only modify via setappacceptingevents()
    """
    app_accepting_events: bool
    """
    Only modify via setappacceptingevents()
    """
    app_focus_lost: bool
    """
    Only modify via addfocusevent()
    """
    backend_flags: int
    """
    = 0              // see imguibackendflags_ enum. set by backend (imgui_impl_xxx files or custom backend) to communicate features supported by the backend.
    """
    backend_platform_name: str
    """
    Optional: Platform/Renderer backend name (informational only! will be displayed in About Window) + User data for backend/wrappers to store their own stuff.
    = null
    """
    backend_renderer_name: str
    """
    = null
    """
    config_debug_begin_return_value_loop: bool
    """
    = false          // some calls to begin()/beginchild() will return false. will cycle through window depths then repeat. suggested use: add 'io.configdebugbeginreturnvalue = io.keyshift' in your main loop then occasionally press shift. windows should be flickering while running.
    """
    config_debug_begin_return_value_once: bool
    """
    Tools to test correct Begin/End and BeginChild/EndChild behaviors.
    - Presently Begin()/End() and BeginChild()/EndChild() needs to ALWAYS be called in tandem, regardless of return value of BeginXXX()
    - This is inconsistent with other BeginXXX functions and create confusion for many users.
    - We expect to update the API eventually. In the meanwhile we provide tools to facilitate checking user-code behavior.
    = false          // first-time calls to begin()/beginchild() will return false. needs to be set at application boot time if you don't want to miss windows.
    """
    config_debug_highlight_id_conflicts: bool
    """
    Tools to detect code submitting items with conflicting/duplicate IDs
    - Code should use PushID()/PopID() in loops, or append "##xx" to same-label identifiers.
    - Empty label e.g. Button("") == same ID as parent widget/node. Use Button("##xx") instead!
    - See FAQ https://github.com/ocornut/imgui/blob/master/docs/FAQ.md#q-about-the-id-stack-system
    = true           // highlight and show an error message when multiple items have conflicting identifiers.
    """
    config_debug_ignore_focus_loss: bool
    """
    Option to deactivate io.AddFocusEvent(false) handling.
    - May facilitate interactions with a debugger when focus loss leads to clearing inputs data.
    - Backends may have other side-effects on focus loss, so this will reduce side-effects but not necessary remove all of them.
    = false          // ignore io.addfocusevent(false), consequently not calling io.clearinputkeys()/io.clearinputmouse() in input processing.
    """
    config_debug_ini_settings: bool
    """
    Option to audit .ini data
    = false  // save .ini data with extra comments (particularly helpful for docking, but makes saving slower)
    """
    config_debug_is_debugger_present: bool
    """
    Option to enable various debug tools showing buttons that will call the IM_DEBUG_BREAK() macro.
    - The Item Picker tool will be available regardless of this being enabled, in order to maximize its discoverability.
    - Requires a debugger being attached, otherwise IM_DEBUG_BREAK() options will appear to crash your application.
    e.g. io.ConfigDebugIsDebuggerPresent = ::IsDebuggerPresent() on Win32, or refer to ImOsIsDebuggerPresent() imgui_test_engine/imgui_te_utils.cpp for a Unix compatible version).
    = false          // enable various tools calling im_debug_break().
    """
    config_docking_always_tab_bar: bool
    """
    = false          // [beta] [fixme: this currently creates regression with auto-sizing and general overhead] make every single floating window display within a docking node.
    """
    config_docking_no_split: bool
    """
    Docking options (when ImGuiConfigFlags_DockingEnable is set)
    = false          // simplified docking mode: disable window splitting, so docking is limited to merging multiple windows together into tab-bars.
    """
    config_docking_transparent_payload: bool
    """
    = false          // [beta] make window or viewport transparent when docking and only display docking boxes on the target viewport. useful if rendering of multiple viewport cannot be synced. best used with configviewportsnoautomerge.
    """
    config_docking_with_shift: bool
    """
    = false          // enable docking with holding shift key (reduce visual noise, allows dropping in wider space)
    """
    config_drag_click_to_input_text: bool
    """
    = false          // [beta] enable turning dragxxx widgets into text input with a simple mouse click-release (without moving). not desirable on devices without a keyboard.
    """
    config_error_recovery: bool
    """
    Options to configure Error Handling and how we handle recoverable errors [EXPERIMENTAL]
    - Error recovery is provided as a way to facilitate:
    - Recovery after a programming error (native code or scripting language - the later tends to facilitate iterating on code while running).
    - Recovery after running an exception handler or any error processing which may skip code after an error has been detected.
    - Error recovery is not perfect nor guaranteed! It is a feature to ease development.
    You not are not supposed to rely on it in the course of a normal application run.
    - Functions that support error recovery are using IM_ASSERT_USER_ERROR() instead of IM_ASSERT().
    - By design, we do NOT allow error recovery to be 100% silent. One of the three options needs to be checked!
    - Always ensure that on programmers seats you have at minimum Asserts or Tooltips enabled when making direct imgui API calls!
    Otherwise it would severely hinder your ability to catch and correct mistakes!
    Read https://github.com/ocornut/imgui/wiki/Error-Handling for details.
    - Programmer seats: keep asserts (default), or disable asserts and keep error tooltips (new and nice!)
    - Non-programmer seats: maybe disable asserts, but make sure errors are resurfaced (tooltips, visible log entries, use callback etc.)
    - Recovery after error/exception: record stack sizes with ErrorRecoveryStoreState(), disable assert, set log callback (to e.g. trigger high-level breakpoint), recover with ErrorRecoveryTryToRecoverState(), restore settings.
    = true       // enable error recovery support. some errors won't be detected and lead to direct crashes if recovery is disabled.
    """
    config_error_recovery_enable_assert: bool
    """
    = true       // enable asserts on recoverable error. by default call im_assert() when returning from a failing im_assert_user_error()
    """
    config_error_recovery_enable_debug_log: bool
    """
    = true       // enable debug log output on recoverable errors.
    """
    config_error_recovery_enable_tooltip: bool
    """
    = true       // enable tooltip on recoverable errors. the tooltip include a way to enable asserts if they were disabled.
    """
    config_flags: int
    """
    = 0  // see imguiconfigflags_ enum. set by user/application. keyboard/gamepad navigation options, etc.
    """
    config_input_text_cursor_blink: bool
    """
    = true           // enable blinking cursor (optional as some users consider it to be distracting).
    """
    config_input_text_enter_keep_active: bool
    """
    = false          // [beta] pressing enter will keep item active and select contents (single-line only).
    """
    config_input_trickle_event_queue: bool
    """
    = true           // enable input queue trickling: some types of events submitted during the same frame (e.g. button down + up) will be spread over multiple frames, improving interactions with low framerates.
    """
    config_mac_osx_behaviors: bool
    """
    = defined(__apple__) // swap cmd<>ctrl keys + os x style text editing cursor movement using alt instead of ctrl, shortcuts using cmd/super instead of ctrl, line/text start and end using cmd+arrows instead of home/end, double click selects by word instead of selecting whole text, multi-selection in lists uses cmd/super instead of ctrl.
    """
    config_memory_compact_timer: float
    """
    = 60.0f          // timer (in seconds) to free transient windows/tables memory buffers when unused. set to -1.0f to disable.
    """
    # config_nav_capture_keyboard: bool
    # """
    # = true           // sets io.wantcapturekeyboard when io.navactive is set.
    # """
    # config_nav_cursor_visible_always: bool
    # """
    # = false          // navigation cursor is always visible.
    # """
    # config_nav_cursor_visible_auto: bool
    # """
    # = true           // using directional navigation key makes the cursor visible. mouse click hides the cursor.
    # """
    # config_nav_escape_clear_focus_item: bool
    # """
    # = true           // pressing escape can clear focused item + navigation id/highlight. set to false if you want to always keep highlight on.
    # """
    # config_nav_escape_clear_focus_window: bool
    # """
    # = false          // pressing escape can clear focused window as well (super set of io.confignavescapeclearfocusitem).
    # """
    # config_nav_move_set_mouse_pos: bool
    # """
    # = false          // directional/tabbing navigation teleports the mouse cursor. may be useful on tv/console systems where moving a virtual mouse is difficult. will update io.mousepos and set io.wantsetmousepos=true.
    # """
    config_nav_swap_gamepad_buttons: bool
    """
    Keyboard/Gamepad Navigation options
    = false          // swap activate<>cancel (a<>b) buttons, matching typical 'nintendo/japanese style' gamepad layout.
    """
    # config_scrollbar_scroll_by_page: bool
    # """
    # = true           // enable scrolling page by page when clicking outside the scrollbar grab. when disabled, always scroll to clicked location. when enabled, shift+click scrolls to clicked location.
    # """
    config_viewports_no_auto_merge: bool
    """
    Viewport options (when ImGuiConfigFlags_ViewportsEnable is set)
    = false;         // set to make all floating imgui windows always create their own viewport. otherwise, they are merged into the main host viewports when overlapping it. may also set imguiviewportflags_noautomerge on individual viewport.
    """
    config_viewports_no_decoration: bool
    """
    = true           // disable default os window decoration flag for secondary viewports. when a viewport doesn't want window decorations, imguiviewportflags_nodecoration will be set on it. enabling decoration can create subsequent issues at os levels (e.g. minimum window size).
    """
    config_viewports_no_default_parent: bool
    """
    = false          // disable default os parenting to main viewport for secondary viewports. by default, viewports are marked with parentviewportid = <main_viewport>, expecting the platform backend to setup a parent/child relationship between the os windows (some backend may ignore this). set to true if you want the default to be 0, then all viewports will be top-level os windows.
    """
    config_viewports_no_task_bar_icon: bool
    """
    = false          // disable default os task bar icon flag for secondary viewports. when a viewport doesn't want a task bar icon, imguiviewportflags_notaskbaricon will be set on it.
    """
    # config_windows_copy_contents_with_ctrl_c: bool
    # """
    # = false      // [experimental] ctrl+c copy the contents of focused window into the clipboard. experimental because: (1) has known issues with nested begin/end pairs (2) text output quality varies (3) text output is in submission order rather than spatial order.
    # """
    config_windows_move_from_title_bar_only: bool
    """
    = false      // enable allowing to move windows only when clicking on their title bar. does not apply to windows without a title bar.
    """
    config_windows_resize_from_edges: bool
    """
    = true           // enable resizing of windows from their edges and from the lower-left corner. this requires imguibackendflags_hasmousecursors for better mouse cursor feedback. (this used to be a per-window imguiwindowflags_resizefromanyside flag)
    """
    ctx: ImGuiContext
    """
    Parent ui context (needs to be set explicitly by parent).
    """
    delta_time: float
    """
    = 1.0f/60.0f     // time elapsed since last frame, in seconds. may change every frame.
    """
    display_framebuffer_scale: Tuple[float, float]
    """
    = (1, 1)         // for retina display or other situations where window coordinates are different from framebuffer coordinates. this generally ends up in imdrawdata::framebufferscale.
    """
    display_size: Tuple[float, float]
    """
    <unset>          // main display size, in pixels (generally == getmainviewport()->size). may change every frame.
    """
    font_allow_user_scaling: bool
    """
    = false          // [obsolete] allow user scaling text of individual window with ctrl+wheel.
    """
    font_default: ImFont
    """
    = null           // font to use on newframe(). use null to uses fonts->fonts[0].
    """
    font_global_scale: float
    """
    = 1.0f           // global scale all fonts
    """
    fonts: ImFontAtlas
    """
    Font system
    <auto>           // font atlas: load, rasterize and pack one or more fonts into a single texture.
    """
    framerate: float
    """
    Estimate of application framerate (rolling average over 60 frames, based on io.deltatime), in frame per second. solely for convenience. slow applications may not want to use a moving average or may want to reset underlying buffers occasionally.
    """
    ini_filename: str
    """
    = 'imgui.ini'    // path to .ini file (important: default 'imgui.ini' is relative to current working dir!). set null to disable automatic .ini loading/saving or if you want to manually call loadinisettingsxxx() / saveinisettingsxxx() functions.
    """
    ini_saving_rate: float
    """
    = 5.0f           // minimum time between saving positions/sizes to .ini file, in seconds.
    """
    input_queue_characters: List[int]
    """
    Queue of _characters_ input (obtained by platform backend). fill using addinputcharacter() helper.
    """
    input_queue_surrogate: int
    """
    For addinputcharacterutf16()
    """
    key_alt: bool
    """
    Keyboard modifier down: alt
    """
    key_ctrl: bool
    """
    Keyboard modifier down: control
    """
    key_mods: int
    """
    Other state maintained from data above + IO function calls
    Key mods flags (any of imguimod_ctrl/imguimod_shift/imguimod_alt/imguimod_super flags, same as io.keyctrl/keyshift/keyalt/keysuper but merged into flags. read-only, updated by newframe()
    """
    key_repeat_delay: float
    """
    = 0.275f         // when holding a key/button, time before it starts repeating, in seconds (for buttons in repeat mode, etc.).
    """
    key_repeat_rate: float
    """
    = 0.050f         // when holding a key/button, rate at which it repeats, in seconds.
    """
    key_shift: bool
    """
    Keyboard modifier down: shift
    """
    key_super: bool
    """
    Keyboard modifier down: cmd/super/windows
    """
    keys_data: ImGuiKeyData
    """
    Key state for all known keys. use iskeyxxx() functions to access this.
    """
    log_filename: str
    """
    = 'imgui_log.txt'// path to .log file (default parameter to imgui::logtofile when no file is specified).
    """
    metrics_active_windows: int
    """
    Number of active windows
    """
    metrics_render_indices: int
    """
    Indices output during last call to render() = number of triangles * 3
    """
    metrics_render_vertices: int
    """
    Vertices output during last call to render()
    """
    metrics_render_windows: int
    """
    Number of visible windows
    """
    mouse_clicked: Sequence[bool]
    """
    Mouse button went from !down to down (same as mouseclickedcount[x] != 0)
    """
    mouse_clicked_count: int
    """
    == 0 (not clicked), == 1 (same as mouseclicked[]), == 2 (double-clicked), == 3 (triple-clicked) etc. when going from !down to down
    """
    mouse_clicked_last_count: int
    """
    Count successive number of clicks. stays valid after mouse release. reset after another click is done.
    """
    mouse_clicked_pos: tuple
    """
    Position at time of clicking
    """
    mouse_clicked_time: float
    """
    Time of last click (used to figure out double-click)
    """
    mouse_ctrl_left_as_right_click: bool
    """
    (osx) set to true when the current click was a ctrl-click that spawned a simulated right click
    """
    mouse_delta: Tuple[float, float]
    """
    Mouse delta. note that this is zero if either current or previous position are invalid (-flt_max,-flt_max), so a disappearing/reappearing mouse won't have a huge delta.
    """
    mouse_double_click_max_dist: float
    """
    = 6.0f           // distance threshold to stay in to validate a double-click, in pixels.
    """
    mouse_double_click_time: float
    """
    Inputs Behaviors
    (other variables, ones which are expected to be tweaked within UI code, are exposed in ImGuiStyle)
    = 0.30f          // time for a double-click, in seconds.
    """
    mouse_double_clicked: Sequence[bool]
    """
    Has mouse button been double-clicked? (same as mouseclickedcount[x] == 2)
    """
    mouse_down: Sequence[bool]
    """
    Mouse buttons: 0=left, 1=right, 2=middle + extras (imguimousebutton_count == 5). dear imgui mostly uses left and right buttons. other buttons allow us to track if the mouse is being used by your application + available to user as a convenience via ismouse** api.
    """
    mouse_down_duration: Sequence[float]
    """
    Duration the mouse button has been down (0.0f == just clicked)
    """
    mouse_down_duration_prev: Sequence[float]
    """
    Previous time the mouse button has been down
    """
    mouse_down_owned: Sequence[bool]
    """
    Track if button was clicked inside a dear imgui window or over void blocked by a popup. we don't request mouse capture from the application if click started outside imgui bounds.
    """
    mouse_down_owned_unless_popup_close: Sequence[bool]
    """
    Track if button was clicked inside a dear imgui window.
    """
    mouse_drag_max_distance_abs: tuple
    """
    Maximum distance, absolute, on each axis, of how much mouse has traveled from the clicking point
    """
    mouse_drag_max_distance_sqr: Sequence[float]
    """
    Squared maximum distance of how much mouse has traveled from the clicking point (used for moving thresholds)
    """
    mouse_drag_threshold: float
    """
    = 6.0f           // distance threshold before considering we are dragging.
    """
    mouse_draw_cursor: bool
    """
    Miscellaneous options
    (you can visualize and interact with all options in 'Demo->Configuration')
    = false          // request imgui to draw a mouse cursor for you (if you are on a platform without a mouse cursor). cannot be easily renamed to 'io.configxxx' because this is frequently used by backend implementations.
    """
    mouse_hovered_viewport: int
    """
    (optional) modify using io.addmouseviewportevent(). with multi-viewports: viewport the os mouse is hovering. if possible _ignoring_ viewports with the imguiviewportflags_noinputs flag is much better (few backends can handle that). set io.backendflags |= imguibackendflags_hasmousehoveredviewport if you can provide this info. if you don't imgui will infer the value using the rectangles and last focused time of the viewports it knows about (ignoring other os windows).
    """
    mouse_pos: Tuple[float, float]
    """
    Main Input State
    (this block used to be written by backend, since 1.87 it is best to NOT write to those directly, call the AddXXX functions above instead)
    (reading from those variables is fair game, as they are extremely unlikely to be moving anywhere)
    Mouse position, in pixels. set to imvec2(-flt_max, -flt_max) if mouse is unavailable (on another screen, etc.)
    """
    mouse_pos_prev: Tuple[float, float]
    """
    Previous mouse position (note that mousedelta is not necessary == mousepos-mouseposprev, in case either position is invalid)
    """
    mouse_released: Sequence[bool]
    """
    Mouse button went from down to !down
    """
    mouse_source: int
    """
    Mouse actual input peripheral (mouse/touchscreen/pen).
    """
    mouse_wheel: float
    """
    Mouse wheel vertical: 1 unit scrolls about 5 lines text. >0 scrolls up, <0 scrolls down. hold shift to turn vertical scroll into horizontal scroll.
    """
    mouse_wheel_h: float
    """
    Mouse wheel horizontal. >0 scrolls left, <0 scrolls right. most users don't have a mouse with a horizontal wheel, may not be filled by all backends.
    """
    mouse_wheel_request_axis_swap: bool
    """
    On a non-mac system, holding shift requests wheely to perform the equivalent of a wheelx event. on a mac system this is already enforced by the system.
    """
    nav_active: bool
    """
    Keyboard/gamepad navigation is currently allowed (will handle imguikey_navxxx events) = a window is focused and it doesn't use the imguiwindowflags_nonavinputs flag.
    """
    nav_visible: bool
    """
    Keyboard/gamepad navigation highlight is visible and allowed (will handle imguikey_navxxx events).
    """
    pen_pressure: float
    """
    Touch/pen pressure (0.0f to 1.0f, should be >0.0f only when mousedown[0] == true). helper storage currently unused by dear imgui.
    """
    user_data: Any
    """
    = null   // store your own data.
    pygui note: Store anything in here if you need.
    """
    want_capture_keyboard: bool
    """
    Set when dear imgui will use keyboard inputs, in this case do not dispatch them to your main game/application (either way, always pass keyboard inputs to imgui). (e.g. inputtext active, or an imgui window is focused and navigation is enabled, etc.).
    """
    want_capture_mouse: bool
    """
    Set when dear imgui will use mouse inputs, in this case do not dispatch them to your main game/application (either way, always pass on mouse inputs to imgui). (e.g. unclicked mouse is hovering over an imgui window, widget is active, mouse was clicked over an imgui window, etc.).
    """
    want_capture_mouse_unless_popup_close: bool
    """
    Alternative to wantcapturemouse: (wantcapturemouse == true && wantcapturemouseunlesspopupclose == false) when a click over void is expected to close a popup.
    """
    want_save_ini_settings: bool
    """
    When manual .ini load/save is active (io.inifilename == null), this will be set to notify your application that you can call saveinisettingstomemory() and save yourself. important: clear io.wantsaveinisettings yourself after saving!
    """
    want_set_mouse_pos: bool
    """
    Mousepos has been altered, backend should reposition mouse on next frame. rarely used! set only when io.confignavmovesetmousepos is enabled.
    """
    want_text_input: bool
    """
    Mobile/console: when set, you may display an on-screen keyboard. this is set by dear imgui when it wants textual keyboard input to happen (e.g. when a inputtext widget is active).
    """
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

    # def clear_events_queue(self: ImGuiIO) -> None:
    #     """
    #     Clear all incoming events.
    #     """
    #     pass

    # def clear_input_keys(self: ImGuiIO) -> None:
    #     """
    #     Clear current keyboard/gamepad state + current frame text input buffer. equivalent to releasing all keys/buttons.
    #     """
    #     pass

    # def clear_input_mouse(self: ImGuiIO) -> None:
    #     """
    #     Clear current mouse state.
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
    - ImGuiInputTextFlags_CallbackEdit:        Callback on buffer edit (note that InputText() already returns true on edit, the callback is useful mainly to manipulate the underlying buffer while focus is active)
    - ImGuiInputTextFlags_CallbackAlways:      Callback on each iteration
    - ImGuiInputTextFlags_CallbackCompletion:  Callback on pressing TAB
    - ImGuiInputTextFlags_CallbackHistory:     Callback on pressing Up/Down arrows
    - ImGuiInputTextFlags_CallbackCharFilter:  Callback on character inputs to replace or discard them. Modify 'EventChar' to replace or discard, or return 1 in callback to discard.
    - ImGuiInputTextFlags_CallbackResize:      Callback on buffer capacity changes request (beyond 'buf_size' parameter value), allowing the string to grow.
    """
    buf: str
    """
    Text buffer  // read-write   // [resize] can replace pointer / [completion,history,always] only write to pointed data, don't replace the actual pointer!
    """
    buf_dirty: bool
    """
    Set if you modify buf/buftextlen!// write// [completion,history,always]
    """
    buf_size: int
    """
    Buffer size (in bytes) = capacity+1  // read-only    // [resize,completion,history,always] include zero-terminator storage. in c land == arraysize(my_char_array), in c++ land: string.capacity()+1
    """
    buf_text_len: int
    """
    Text length (in bytes)               // read-write   // [resize,completion,history,always] exclude zero-terminator storage. in c land: == strlen(some_text), in c++ land: string.length()
    """
    ctx: ImGuiContext
    """
    Parent ui context
    """
    cursor_pos: int
    """
    Read-write   // [completion,history,always]
    """
    event_char: int
    """
    Arguments for the different callback events
    - During Resize callback, Buf will be same as your input buffer.
    - However, during Completion/History/Always callback, Buf always points to our own internal data (it is not the same as your buffer)! Changes to it will be reflected into your own buffer shortly after the callback.
    - To modify the text buffer in a callback, prefer using the InsertChars() / DeleteChars() function. InsertChars() will take care of calling the resize callback if necessary.
    - If you know your edits are not going to resize the underlying buffer allocation, you may modify the contents of 'Buf[]' directly. You need to update 'BufTextLen' accordingly (0 <= BufTextLen < BufSize) and set 'BufDirty'' to true so InputText can update its internal state.
    Character input                      // read-write   // [charfilter] replace character with another one, or set to zero to drop. return 1 is equivalent to setting eventchar=0;
    """
    event_flag: int
    """
    One imguiinputtextflags_callback*    // read-only
    """
    event_key: int
    """
    Key pressed (up/down/tab)            // read-only    // [completion,history]
    """
    flags: int
    """
    What user passed to inputtext()      // read-only
    """
    selection_end: int
    """
    Read-write   // [completion,history,always]
    """
    selection_start: int
    """
    Read-write   // [completion,history,always] == to selectionend when no selection)
    """
    user_data: Any
    """
    What user passed to inputtext()  // read-only
    """
    def clear_selection(self: ImGuiInputTextCallbackData) -> None: ...
    def delete_chars(self: ImGuiInputTextCallbackData, pos: int, bytes_count: int) -> None: ...
    def has_selection(self: ImGuiInputTextCallbackData) -> bool: ...
    def insert_chars(self: ImGuiInputTextCallbackData, pos: int, text: str) -> None: ...
    def select_all(self: ImGuiInputTextCallbackData) -> None: ...

class ImGuiKeyData:
    """
    [Internal] Storage used by IsKeyDown(), IsKeyPressed() etc functions.
    If prior to 1.87 you used io.KeysDownDuration[] (which was marked as internal), you should use GetKeyData(key)->DownDuration and *NOT* io.KeysData[key]->DownDuration.
    """
    analog_value: float
    """
    0.0f..1.0f for gamepad values
    """
    down: bool
    """
    True for if key is down
    """
    down_duration: float
    """
    Duration the key has been down (<0.0f: not pressed, 0.0f: just pressed, >0.0f: time held)
    """
    down_duration_prev: float
    """
    Last frame duration the key has been down
    """

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
    pygui note: This class is instantiable with ImGuiListClipper.create()
    """
    ctx: ImGuiContext
    """
    Parent ui context
    """
    display_end: int
    """
    End of items to display (exclusive)
    """
    display_start: int
    """
    First item to display, updated by each call to step()
    """
    # start_seek_offset_y: float
    # """
    # [internal] account for frozen rows in a table and initial loss of precision in very large windows.
    # """
    def begin(self: ImGuiListClipper, items_count: int, items_height: float=-1.0) -> None: ...
    def create() -> ImGuiListClipper:
        """
        Create a dynamically allocated instance of ImGuiListClipper. Must
        also be freed with destroy().
        """
        pass

    def destroy(self: ImGuiListClipper) -> None:
        """
        Explicitly frees this instance.
        """
        pass

    def end(self: ImGuiListClipper) -> None:
        """
        Automatically called on the last call of step() that returns false.
        """
        pass

    def include_item_by_index(self: ImGuiListClipper, item_index: int) -> None:
        """
        Call IncludeItemByIndex() or IncludeItemsByIndex() *BEFORE* first call to Step() if you need a range of items to not be clipped, regardless of their visibility.
        (Due to alignment / padding of certain items it is possible that an extra item may be included on either end of the display range).
        """
        pass

    def include_items_by_index(self: ImGuiListClipper, item_begin: int, item_end: int) -> None:
        """
        Item_end is exclusive e.g. use (42, 42+1) to make item 42 never clipped.

        [#6424](https://github.com/ocornut/imgui/issues/6424) JaedanC Easteregg. This is my suggestion!
        """
        pass

    # def seek_cursor_for_item(self: ImGuiListClipper, item_index: int) -> None:
    #     """
    #     Seek cursor toward given item. This is automatically called while stepping.
    #     - The only reason to call this is: you can use ImGuiListClipper::Begin(INT_MAX) if you don't know item count ahead of time.
    #     - In this case, after all steps are done, you'll want to call SeekCursorForItem(item_count).
    #     """
    #     pass

    def step(self: ImGuiListClipper) -> bool:
        """
        Call until it returns false. the displaystart/displayend fields will be set and you can process/draw those items.
        """
        pass


class ImGuiMultiSelectIO:
    """
    Main IO structure returned by BeginMultiSelect()/EndMultiSelect().
    This mainly contains a list of selection requests.
    - Use 'Demo->Tools->Debug Log->Selection' to see requests as they happen.
    - Some fields are only useful if your list is dynamic and allows deletion (getting post-deletion focus/state right is shown in the demo)
    - Below: who reads/writes each fields? 'r'=read, 'w'=write, 'ms'=multi-select code, 'app'=application/user code.
    """
    # items_count: int
    # """
    # Ms:w, app:r     /        app:r   // 'int items_count' parameter to beginmultiselect() is copied here for convenience, allowing simpler calls to your applyrequests handler. not used internally.
    # """
    nav_id_item: Any
    """
    Ms:w, app:r     /                // (if using deletion) last known setnextitemselectionuserdata() value for navid (if part of submitted items).
    """
    nav_id_selected: bool
    """
    Ms:w, app:r     /        app:r   // (if using deletion) last known selection state for navid (if part of submitted items).
    """
    range_src_item: Any
    """
    Ms:w  app:r     /                // (if using clipper) begin: source item (often the first selected item) must never be clipped: use clipper.includeitembyindex() to ensure it is submitted.
    """
    range_src_reset: bool
    """
    App:w     /  ms:r          // (if using deletion) set before endmultiselect() to reset resetsrcitem (e.g. if deleted selection).
    """
    # requests: ImVector_ImGuiSelectionRequest
    # """
    # ------------------------------------------// BeginMultiSelect / EndMultiSelect
    # Ms:w, app:r     /  ms:w  app:r   // requests to apply to your selection data.
    # """

class ImGuiPayload:
    """
    Data payload for Drag and Drop operations: AcceptDragDropPayload(), GetDragDropPayload()
    """
    data: Vec4 | Any
    """
    Data (copied and owned by dear imgui)
    pygui note: Nope, the data is owned by us :). If the payload came from
    imgui we use that instead.
    """
    data_frame_count: int
    """
    Data timestamp
    """
    data_size: int
    """
    Data size.
    pygui note: It doesn't make much sense to keep this in the API because
    the type passed to set_drag_drop_payload is a constant integer. The data
    passed to pygui doesn't go to imgui, but rather stays inside cython so
    that we can accept abitrary python objects. This function then just
    calls len(_drag_drop_payload), which is still not ideal but better than
    returning sizeof(int) I guess.
    """
    data_type: str
    """
    Data type tag (short user-supplied string, 32 characters max)
    """
    delivery: bool
    """
    Set when acceptdragdroppayload() was called and mouse button is released over the target item.
    """
    preview: bool
    """
    Set when acceptdragdroppayload() was called and mouse has been hovering the target item (nb: handle overlapping drag targets)
    """
    source_id: int
    """
    [Internal]
    Source item id
    """
    source_parent_id: int
    """
    Source parent id (if available)
    """
    # def clear(self: ImGuiPayload) -> None: ...
    def is_data_type(self: ImGuiPayload, type_: str) -> bool: ...
    def is_delivery(self: ImGuiPayload) -> bool: ...
    def is_preview(self: ImGuiPayload) -> bool: ...

class ImGuiPlatformIO:
    """
    Access via ImGui::GetPlatformIO()
    """
    monitors: List[ImGuiPlatformMonitor]
    """
    (Optional) Monitor list
    - Updated by: app/backend. Update every frame to dynamically support changing monitor or DPI configuration.
    - Used by: dear imgui to query DPI info, clamp popups/tooltips within same monitor and not have them straddle monitors.
    """
    # platform_clipboard_user_data: Any
    # platform_create_vk_surface: Callable
    # """
    # (optional) for a vulkan renderer to call into platform code (since the surface creation needs to tie them both).
    # """
    # platform_create_window: Callable
    # """
    # Platform Backend functions (e.g. Win32, GLFW, SDL) ------------------- Called by -----
    # . . u . .  // create a new platform window for the given viewport
    # """
    # platform_destroy_window: Callable
    # """
    # N . u . d  //
    # """
    # platform_get_clipboard_text_fn: Callable
    # """
    # Optional: Access OS clipboard
    # (default to use native Win32 clipboard on Windows, otherwise uses a private clipboard. Override to access OS clipboard on other architectures)
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
    # platform_get_window_work_area_insets: Callable
    # """
    # N . . . .  // (optional) [beta] get initial work area inset for the viewport (won't be covered by main menu bar, dockspace over viewport etc.). default to (0,0),(0,0). 'safeareainsets' in ios land, 'displaycutout' in android land.
    # """
    # platform_ime_user_data: Any
    # platform_locale_decimal_point: int
    # """
    # Optional: Platform locale
    # [Experimental] Configure decimal point e.g. '.' or ',' useful for some languages (e.g. German), generally pulled from *localeconv()->decimal_point
    # '.'
    # """
    # platform_on_changed_viewport: Callable
    # """
    # . f . . .  // (optional) [beta] fixme-dpi: dpi handling: called during begin() every time the viewport we are outputting into changes, so backend has a chance to swap fonts to adjust style.
    # """
    # platform_open_in_shell_fn: Callable
    # """
    # Optional: Open link/folder/file in OS Shell
    # (default to use ShellExecuteA() on Windows, system() on Linux/Mac)
    # """
    # platform_open_in_shell_user_data: Any
    # platform_render_window: Callable
    # """
    # . . . r .  // (optional) main rendering (platform side! this is often unused, or just setting a 'current' context for opengl bindings). 'render_arg' is the value passed to renderplatformwindowsdefault().
    # """
    # platform_set_clipboard_text_fn: Callable
    # platform_set_ime_data_fn: Callable
    # """
    # Optional: Notify OS Input Method Editor of the screen position of your cursor for text input position (e.g. when using Japanese/Chinese IME on Windows)
    # (default to use native imm32 api on Windows)
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
    # Renderer Backend functions (e.g. DirectX, OpenGL, Vulkan) ------------ Called by -----
    # . . u . .  // create swap chain, frame buffers etc. (called after platform_createwindow)
    # """
    # renderer_destroy_window: Callable
    # """
    # N . u . d  // destroy swap chain, frame buffers etc. (called before platform_destroywindow)
    # """
    # renderer_render_state: Any
    # """
    # Written by some backends during ImGui_ImplXXXX_RenderDrawData() call to point backend_specific ImGui_ImplXXXX_RenderState* structure.
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
    viewports: List[ImGuiViewport]
    """
    Viewports list (the list is updated by calling ImGui::EndFrame or ImGui::Render)
    (in the future we will attempt to organize this feature to remove the need for a "main viewport")
    Main viewports, followed by all secondary viewports.
    """

class ImGuiPlatformImeData:
    """
    (Optional) Support for IME (Input Method Editor) via the platform_io.Platform_SetImeDataFn() function.
    """
    pass
    # input_line_height: float
    # """
    # Line height
    # """
    # input_pos: Tuple[float, float]
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
    dpi_scale: float
    """
    1.0f = 96 dpi
    """
    main_pos: Tuple[float, float]
    """
    Coordinates of the area displayed on this monitor (min = upper left, max = bottom right)
    """
    main_size: Tuple[float, float]
    """
    Coordinates of the area displayed on this monitor (min = upper left, max = bottom right)
    """
    # platform_handle: Any
    # """
    # Backend dependant data (e.g. hmonitor, glfwmonitor*, sdl display index, nsscreen*)
    # """
    work_pos: Tuple[float, float]
    """
    Coordinates without task bars / side bars / menu bars. used to avoid positioning popups/tooltips inside this region. if you don't have this info, please copy the value for mainpos/mainsize.
    """
    work_size: Tuple[float, float]
    """
    Coordinates without task bars / side bars / menu bars. used to avoid positioning popups/tooltips inside this region. if you don't have this info, please copy the value for mainpos/mainsize.
    """

class ImGuiSelectionBasicStorage:
    """
    Optional helper to store multi-selection state + apply multi-selection requests.
    - Used by our demos and provided as a convenience to easily implement basic multi-selection.
    - Iterate selection with 'void* it = NULL; ImGuiID id; while (selection.GetNextSelectedItem(&it, &id)) ( ... )'
    Or you can check 'if (Contains(id)) ( ... )' for each possible object if their number is not too high to iterate.
    - USING THIS IS NOT MANDATORY. This is only a helper and not a required API.
    To store a multi-selection, in your application you could:
    - Use this helper as a convenience. We use our simple key->value ImGuiStorage as a std::set<ImGuiID> replacement.
    - Use your own external storage: e.g. std::set<MyObjectId>, std::vector<MyObjectId>, interval trees, intrusively stored selection etc.
    In ImGuiSelectionBasicStorage we:
    - always use indices in the multi-selection API (passed to SetNextItemSelectionUserData(), retrieved in ImGuiMultiSelectIO)
    - use the AdapterIndexToStorageId() indirection layer to abstract how persistent selection data is derived from an index.
    - use decently optimized logic to allow queries and insertion of very large selection sets.
    - do not preserve selection order.
    Many combinations are possible depending on how you prefer to store your items and how you prefer to store your selection.
    Large applications are likely to eventually want to get rid of this indirection layer and do their own thing.
    See https://github.com/ocornut/imgui/wiki/Multi-Select for details and pseudo-code using this helper.
    """
    adapter_index_to_storage_id: Callable[[ImGuiSelectionBasicStorage, int], int] | None
    """
    E.g. selection.adapterindextostorageid = [](imguiselectionbasicstorage* self, int idx) ( return ((myitems**)self->userdata)[idx]->id; );
    """
    preserve_order: bool
    """
    = false  // getnextselecteditem() will return ordered selection (currently implemented by two additional sorts of selection. could be improved)
    """
    selection_order: int
    """
    [internal] increasing counter to store selection order
    """
    size: int
    """
    Members
    Number of selected items, maintained by this helper.
    """
    user_data: Any
    """
    = null   // user data for use by adapter function// e.g. selection.userdata = (void*)my_items;
    """
    def apply_requests(self: ImGuiSelectionBasicStorage, ms_io: ImGuiMultiSelectIO) -> None:
        """
        Apply selection requests coming from beginmultiselect() and endmultiselect() functions. it uses 'items_count' passed to beginmultiselect()
        """
        pass

    def clear(self: ImGuiSelectionBasicStorage) -> None:
        """
        Clear selection
        """
        pass

    def contains(self: ImGuiSelectionBasicStorage, id_: int) -> bool:
        """
        Query if an item id is in selection.
        """
        pass

    def create() -> ImGuiSelectionBasicStorage:
        """
        Create a dynamically allocated instance of ImGuiSelectionBasicStorage. Must
        also be freed with destroy(). Mimics the constructor for ImGuiSelectionBasicStorage
        """
        pass

    def destroy(self: ImGuiSelectionBasicStorage) -> None:
        """
        Mimics the destructor of ccimgui.ImGuiSelectionBasicStorage. (Currently none)
        """
        pass

    def get_next_selected_item(self: ImGuiSelectionBasicStorage, opaque_it: Int, out_id: Int) -> bool:
        """
        Iterate selection with 'void* it = null; imguiid id; while (selection.getnextselecteditem(&it, &id)) ( ... )'

        pygui note: This function usually requires the caller to keep a void* as an iterator.
        Now, we can do that in python, so instead we use pygui.Int() as a
        replacement. This means it is critical you do not modify to the value of
        the `opaque_it` supplied. You can iterate as follows:

        ```python
        selected_id = pygui.Int()
        it = pygui.Int()
        while (selection.get_next_selected_item(it, selected_id)):
            # Do work with selected_id
            pass
        ```
        """
        pass

    def get_storage_id_from_index(self: ImGuiSelectionBasicStorage, idx: int) -> int:
        """
        Convert index to item id based on provided adapter.
        """
        pass

    def set_item_selected(self: ImGuiSelectionBasicStorage, id_: int, selected: bool) -> None:
        """
        Add/remove an item from selection (generally done by applyrequests() function)
        """
        pass

    def swap(self: ImGuiSelectionBasicStorage, r: ImGuiSelectionBasicStorage) -> None:
        """
        Swap two selections
        """
        pass


class ImGuiSelectionExternalStorage:
    """
    Optional helper to apply multi-selection requests to existing randomly accessible storage.
    Convenient if you want to quickly wire multi-select API on e.g. an array of bool or items storing their own selection state.
    """
    adapter_set_item_selected: Callable[[ImGuiSelectionExternalStorage, int, bool], None] | None
    """
    E.g. adaptersetitemselected = [](imguiselectionexternalstorage* self, int idx, bool selected) ( ((myitems**)self->userdata)[idx]->selected = selected; )
    """
    user_data: Any
    """
    Members
    User data for use by adapter function// e.g. selection.userdata = (void*)my_items;
    """
    def apply_requests(self: ImGuiSelectionExternalStorage, ms_io: ImGuiMultiSelectIO) -> None:
        """
        Apply selection requests by using adaptersetitemselected() calls
        """
        pass

    def create() -> ImGuiSelectionExternalStorage:
        """
        Create a dynamically allocated instance of ImGuiSelectionExternalStorage. Must
        also be freed with destroy(). Mimics the constructor for ImGuiSelectionExternalStorage
        """
        pass

    def destroy(self: ImGuiSelectionExternalStorage) -> None:
        """
        Mimics the destructor of ccimgui.ImGuiSelectionExternalStorage. (Currently none)
        """
        pass


class ImGuiSelectionRequest:
    """
    Selection request item
    """
    pass
    # range_direction: int
    # """
    # Ms:w  app:r   // parameter for setrange request: +1 when rangefirstitem comes before rangelastitem, -1 otherwise. useful if you want to preserve selection order on a backward shift+click.
    # """
    # range_first_item: Any
    # """
    # Ms:w, app:r   // parameter for setrange request (this is generally == rangesrcitem when shift selecting from top to bottom).
    # """
    # range_last_item: Any
    # """
    # Ms:w, app:r   // parameter for setrange request (this is generally == rangesrcitem when shift selecting from bottom to top). inclusive!
    # """
    # selected: bool
    # """
    # Ms:w, app:r     /  ms:w, app:r   // parameter for setall/setrange requests (true = select, false = unselect)
    # """
    # type: Any
    # """
    # ------------------------------------------// BeginMultiSelect / EndMultiSelect
    # Ms:w, app:r     /  ms:w, app:r   // request type. you'll most often receive 1 clear + 1 setrange with a single-item range.
    # """

class ImGuiSizeCallbackData:
    """
    Resizing callback data to apply custom constraint. As enabled by SetNextWindowSizeConstraints(). Callback is called during the next Begin().
    NB: For basic min/max size constraint on each axis you don't need to use the callback! The SetNextWindowSizeConstraints() parameters are enough.
    """
    current_size: Tuple[float, float]
    """
    Read-only.   current window size.
    """
    desired_size: Tuple[float, float]
    """
    Read-write.  desired size, based on user's mouse position. write to this field to restrain resizing.
    """
    pos: Tuple[float, float]
    """
    Read-only.   window position, for reference.
    """
    user_data: Any
    """
    Read-only.   what user passed to setnextwindowsizeconstraints(). generally store an integer or float in here (need reinterpret_cast<>).
    """

class ImGuiStoragePair:
    """
    [Internal] Key+Value for ImGuiStorage
    """
    pass
    # key: int

class ImGuiStyle:
    """
    Global alpha applies to everything in dear imgui.
    """
    alpha: float
    """
    Global alpha applies to everything in dear imgui.
    """
    anti_aliased_fill: bool
    """
    Enable anti-aliased edges around filled shapes (rounded rectangles, circles, etc.). disable if you are really tight on cpu/gpu. latched at the beginning of the frame (copied to imdrawlist).
    """
    anti_aliased_lines: bool
    """
    Enable anti-aliased lines/borders. disable if you are really tight on cpu/gpu. latched at the beginning of the frame (copied to imdrawlist).
    """
    anti_aliased_lines_use_tex: bool
    """
    Enable anti-aliased lines/borders using textures where possible. require backend to render with bilinear filtering (not point/nearest filtering). latched at the beginning of the frame (copied to imdrawlist).
    """
    button_text_align: Tuple[float, float]
    """
    Alignment of button text when button is larger than text. defaults to (0.5f, 0.5f) (centered).
    """
    cell_padding: Tuple[float, float]
    """
    Padding within a table cell. cellpadding.x is locked for entire table. cellpadding.y may be altered between different rows.
    """
    child_border_size: float
    """
    Thickness of border around child windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
    """
    child_rounding: float
    """
    Radius of child window corners rounding. set to 0.0f to have rectangular windows.
    """
    circle_tessellation_max_error: float
    """
    Maximum error (in pixels) allowed when using addcircle()/addcirclefilled() or drawing rounded corner rectangles with no explicit segment count specified. decrease for higher quality but more geometry.
    """
    color_button_position: int
    """
    Side of the color button in the coloredit4 widget (left/right). defaults to imguidir_right.
    """
    colors: tuple
    columns_min_spacing: float
    """
    Minimum horizontal spacing between two columns. preferably > (framepadding.x + 1).
    """
    curve_tessellation_tol: float
    """
    Tessellation tolerance when using pathbeziercurveto() without a specific number of segments. decrease for highly tessellated curves (higher quality, more polygons), increase to reduce quality.
    """
    disabled_alpha: float
    """
    Additional alpha multiplier applied by begindisabled(). multiply over current value of alpha.
    """
    display_safe_area_padding: Tuple[float, float]
    """
    Apply to every windows, menus, popups, tooltips: amount where we avoid displaying contents. adjust if you cannot see the edges of your screen (e.g. on a tv where scaling has not been configured).
    """
    display_window_padding: Tuple[float, float]
    """
    Apply to regular windows: amount which we enforce to keep visible when moving near edges of your screen.
    """
    docking_separator_size: float
    """
    Thickness of resizing border between docked windows
    """
    frame_border_size: float
    """
    Thickness of border around frames. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
    """
    frame_padding: Tuple[float, float]
    """
    Padding within a framed rectangle (used by most widgets).
    """
    frame_rounding: float
    """
    Radius of frame corners rounding. set to 0.0f to have rectangular frame (used by most widgets).
    """
    grab_min_size: float
    """
    Minimum width/height of a grab box for slider/scrollbar.
    """
    grab_rounding: float
    """
    Radius of grabs corners rounding. set to 0.0f to have rectangular slider grabs.
    """
    hover_delay_normal: float
    """
    Delay for isitemhovered(imguihoveredflags_delaynormal). '
    """
    hover_delay_short: float
    """
    Delay for isitemhovered(imguihoveredflags_delayshort). usually used along with hoverstationarydelay.
    """
    hover_flags_for_tooltip_mouse: int
    """
    Default flags when using isitemhovered(imguihoveredflags_fortooltip) or beginitemtooltip()/setitemtooltip() while using mouse.
    """
    hover_flags_for_tooltip_nav: int
    """
    Default flags when using isitemhovered(imguihoveredflags_fortooltip) or beginitemtooltip()/setitemtooltip() while using keyboard/gamepad.
    """
    hover_stationary_delay: float
    """
    Behaviors
    (It is possible to modify those fields mid-frame if specific behavior need it, unlike e.g. configuration fields in ImGuiIO)
    Delay for isitemhovered(imguihoveredflags_stationary). time required to consider mouse stationary.
    """
    indent_spacing: float
    """
    Horizontal indentation when e.g. entering a tree node. generally == (fontsize + framepadding.x*2).
    """
    item_inner_spacing: Tuple[float, float]
    """
    Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label).
    """
    item_spacing: Tuple[float, float]
    """
    Horizontal and vertical spacing between widgets/lines.
    """
    log_slider_deadzone: float
    """
    The size in pixels of the dead-zone around zero on logarithmic sliders that cross zero.
    """
    mouse_cursor_scale: float
    """
    Scale software rendered mouse cursor (when io.mousedrawcursor is enabled). we apply per-monitor dpi scaling over this scale. may be removed later.
    """
    popup_border_size: float
    """
    Thickness of border around popup/tooltip windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
    """
    popup_rounding: float
    """
    Radius of popup window corners rounding. (note that tooltip windows use windowrounding)
    """
    scrollbar_rounding: float
    """
    Radius of grab corners for scrollbar.
    """
    scrollbar_size: float
    """
    Width of the vertical scrollbar, height of the horizontal scrollbar.
    """
    selectable_text_align: Tuple[float, float]
    """
    Alignment of selectable text. defaults to (0.0f, 0.0f) (top-left aligned). it's generally important to keep this left-aligned if you want to lay multiple items on a same line.
    """
    separator_text_align: Tuple[float, float]
    """
    Alignment of text within the separator. defaults to (0.0f, 0.5f) (left aligned, center).
    """
    separator_text_border_size: float
    """
    Thickness of border in separatortext()
    """
    separator_text_padding: Tuple[float, float]
    """
    Horizontal offset of text from each edge of the separator + spacing on other axis. generally small values. .y is recommended to be == framepadding.y.
    """
    tab_bar_border_size: float
    """
    Thickness of tab-bar separator, which takes on the tab active color to denote focus.
    """
    tab_bar_overline_size: float
    """
    Thickness of tab-bar overline, which highlights the selected tab-bar.
    """
    tab_border_size: float
    """
    Thickness of border around tabs.
    """
    tab_min_width_for_close_button: float
    """
    Minimum width for close button to appear on an unselected tab when hovered. set to 0.0f to always show when hovering, set to flt_max to never show close button unless selected.
    """
    tab_rounding: float
    """
    Radius of upper corners of a tab. set to 0.0f to have rectangular tabs.
    """
    table_angled_headers_angle: float
    """
    Angle of angled headers (supported values range from -50.0f degrees to +50.0f degrees).
    """
    table_angled_headers_text_align: Tuple[float, float]
    """
    Alignment of angled headers within the cell
    """
    touch_extra_padding: Tuple[float, float]
    """
    Expand reactive bounding box for touch-based system where touch position is not accurate enough. unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. so don't grow this too much!
    """
    window_border_size: float
    """
    Thickness of border around windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
    """
    window_menu_button_position: int
    """
    Side of the collapsing/docking button in the title bar (none/left/right). defaults to imguidir_left.
    """
    window_min_size: Tuple[float, float]
    """
    Minimum window size. this is a global setting. if you want to constrain individual windows, use setnextwindowsizeconstraints().
    """
    window_padding: Tuple[float, float]
    """
    Padding within a window.
    """
    window_rounding: float
    """
    Radius of window corners rounding. set to 0.0f to have rectangular windows. large values tend to lead to variety of artifacts and are not recommended.
    """
    window_title_align: Tuple[float, float]
    """
    Alignment for title bar text. defaults to (0.0f,0.5f) for left-aligned,vertically centered.
    """
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
    User id of the column (if specified by a table_setup_column() call)
    """
    sort_direction: int
    """
    Imguisortdirection_ascending or imguisortdirection_descending
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

class ImGuiTextFilter:
    """
    Helper: Parse and apply text filters. In format "aaaaa[,bbbb][,ccccc]"
    pygui note: This class is instantiable with ImGuiTextFilter.create()
    """
    # count_grep: int
    # filters: ImVector_ImGuiTextFilter_ImGuiTextRange
    # input_buf: int
    # def build(self: ImGuiTextFilter) -> None: ...
    # def clear(self: ImGuiTextFilter) -> None: ...
    def create(default_filter: str="") -> ImGuiTextFilter:
        """
        Mimics the constructor for struct ImGuiTextFilter
        """
        pass

    def destroy(self: ImGuiTextFilter) -> None:
        """
        Explicitly frees this instance.
        """
        pass

    def draw(self: ImGuiTextFilter, label: str="Filter (inc,-exc)", width: float=0.0) -> bool:
        """
        Helper calling inputtext+build
        """
        pass

    def is_active(self: ImGuiTextFilter) -> bool: ...
    def pass_filter(self: ImGuiTextFilter, text: str) -> bool: ...

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
    dpi_scale: float
    """
    1.0f = 96 dpi = no extra scale.
    """
    draw_data: ImDrawData
    """
    The imdrawdata corresponding to this viewport. valid after render() and until the next call to newframe().
    """
    flags: int
    """
    See imguiviewportflags_
    """
    id: int
    """
    Unique identifier for the viewport
    """
    parent_viewport_id: int
    """
    (advanced) 0: no parent. instruct the platform backend to setup a parent/child relationship between platform windows.
    """
    # platform_handle: Any
    # """
    # Void* to hold higher-level, platform window handle (e.g. hwnd, glfwwindow*, sdl_window*), for findviewportbyplatformhandle().
    # """
    # platform_handle_raw: Any
    # """
    # Void* to hold lower-level, platform-native window handle (under win32 this is expected to be a hwnd, unused for other platforms), when using an abstraction layer like glfw or sdl (where platformhandle would be a sdl_window*)
    # """
    platform_request_close: bool
    """
    Platform window requested closure (e.g. window was moved by the os / host window manager, e.g. pressing alt-f4)
    """
    platform_request_move: bool
    """
    Platform window requested move (e.g. window was moved by the os / host window manager, authoritative position will be os window position)
    """
    platform_request_resize: bool
    """
    Platform window requested resize (e.g. window was resized by the os / host window manager, authoritative size will be os window size)
    """
    platform_window_created: bool
    """
    Platform window has been created (platform_createwindow() has been called). this is false during the first frame where a viewport is being created.
    """
    pos: Tuple[float, float]
    """
    Main area: position of the viewport (dear imgui coordinates are the same as os desktop/native coordinates)
    """
    size: Tuple[float, float]
    """
    Main area: size of the viewport.
    """
    work_pos: Tuple[float, float]
    """
    Work area: position of the viewport minus task bars, menus bars, status bars (>= pos)
    """
    work_size: Tuple[float, float]
    """
    Work area: size of the viewport minus task bars, menu bars, status bars (<= size)
    """
    def get_center(self: ImGuiViewport) -> Tuple[float, float]:
        """
        Helpers
        """
        pass

    def get_work_center(self: ImGuiViewport) -> Tuple[float, float]: ...

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
    # focus_route_parent_window_id: int
    # """
    # Id of parent window for shortcut focus route evaluation, e.g. shortcut() call from parent window will succeed when this window is focused.
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

class ImVector_ImU8: ...
    # capacity: int
    # capacity: int
    # data: int
    # data: int
    # size: int
    # size: int

class ImVector_ImWchar: ...
    # capacity: int
    # data: int
    # size: int

class ImVector_char: ...
    # capacity: int
    # data: str
    # size: int

