
# -*- coding: utf-8 -*-
# distutils: language = c++

from libcpp cimport bool

cdef extern from "cimgui.h":
    ctypedef struct ImDrawListSharedData
    ctypedef struct ImFontBuilderIO
    ctypedef struct ImGuiContext
    ctypedef struct ImVec2
    ctypedef struct ImVec4
    ctypedef struct ImVector_ImWchar
    ctypedef struct ImVector_ImGuiTextFilter_ImGuiTextRange
    ctypedef struct ImVector_char
    ctypedef struct ImVector_ImGuiStorage_ImGuiStoragePair
    ctypedef struct ImVector_ImDrawCmd
    ctypedef struct ImVector_ImDrawIdx
    ctypedef struct ImVector_ImDrawChannel
    ctypedef struct ImVector_ImDrawVert
    ctypedef struct ImVector_ImVec4
    ctypedef struct ImVector_ImTextureID
    ctypedef struct ImVector_ImVec2
    ctypedef struct ImVector_ImU32
    ctypedef struct ImVector_ImFontPtr
    ctypedef struct ImVector_ImFontAtlasCustomRect
    ctypedef struct ImVector_ImFontConfig
    ctypedef struct ImVector_float
    ctypedef struct ImVector_ImFontGlyph
    ctypedef struct ImVector_ImGuiPlatformMonitor
    ctypedef struct ImVector_ImGuiViewportPtr
    ctypedef struct ImGuiStyle
    ctypedef struct ImGuiKeyData
    ctypedef struct ImGuiIO
    ctypedef struct ImGuiInputTextCallbackData
    ctypedef struct ImGuiSizeCallbackData
    ctypedef struct ImGuiWindowClass
    ctypedef struct ImGuiPayload
    ctypedef struct ImGuiTableColumnSortSpecs
    ctypedef struct ImGuiTableSortSpecs
    ctypedef struct ImGuiTextFilter_ImGuiTextRange
    ctypedef struct ImGuiTextFilter
    ctypedef struct ImGuiTextBuffer
    ctypedef struct ImGuiStorage_ImGuiStoragePair
    ctypedef struct ImGuiStorage
    ctypedef struct ImGuiListClipper
    ctypedef struct ImColor
    ctypedef struct ImDrawCmd
    ctypedef struct ImDrawVert
    ctypedef struct ImDrawCmdHeader
    ctypedef struct ImDrawChannel
    ctypedef struct ImDrawListSplitter
    ctypedef struct ImDrawList
    ctypedef struct ImDrawData
    ctypedef struct ImFontConfig
    ctypedef struct ImFontGlyph
    ctypedef struct ImFontGlyphRangesBuilder
    ctypedef struct ImFontAtlasCustomRect
    ctypedef struct ImFontAtlas
    ctypedef struct ImFont
    ctypedef struct ImGuiViewport
    ctypedef struct ImGuiPlatformIO
    ctypedef struct ImGuiPlatformMonitor
    ctypedef struct ImGuiPlatformImeData


    """
    Enumerations
    - We don't use strongly typed enums much because they add constraints (can't extend in private code, can't store typed in bit fields, extra casting on iteration)
    - Tip: Use your programming IDE navigation facilities on the names in the _central column_ below to find the actual flags/enum lists!
    In Visual Studio IDE: CTRL+comma ("Edit.GoToAll") can follow symbols in comments, whereas CTRL+F12 ("Edit.GoToImplementation") cannot.
    With Visual Assist installed: ALT+G ("VAssistX.GoToImplementation") can also follow symbols in comments.
    -> enum ImGuiKey              // Enum: A key identifier (ImGuiKey_XXX or ImGuiMod_XXX value)
    """
    ctypedef int ImGuiKey

    """
    -> enum ImGuiCol_             // Enum: A color identifier for styling
    """
    ctypedef int ImGuiCol

    """
    -> enum ImGuiCond_            // Enum: A condition for many Set*() functions
    """
    ctypedef int ImGuiCond

    """
    -> enum ImGuiDataType_        // Enum: A primary data type
    """
    ctypedef int ImGuiDataType

    """
    -> enum ImGuiDir_             // Enum: A cardinal direction
    """
    ctypedef int ImGuiDir

    """
    -> enum ImGuiMouseButton_     // Enum: A mouse button identifier (0=left, 1=right, 2=middle)
    """
    ctypedef int ImGuiMouseButton

    """
    -> enum ImGuiMouseCursor_     // Enum: A mouse cursor shape
    """
    ctypedef int ImGuiMouseCursor

    """
    -> enum ImGuiSortDirection_   // Enum: A sorting direction (ascending or descending)
    """
    ctypedef int ImGuiSortDirection

    """
    -> enum ImGuiStyleVar_        // Enum: A variable identifier for styling
    """
    ctypedef int ImGuiStyleVar

    """
    -> enum ImGuiTableBgTarget_   // Enum: A color target for TableSetBgColor()
    """
    ctypedef int ImGuiTableBgTarget

    """
    Flags (declared as int for compatibility with old C++, to allow using as flags without overhead, and to not pollute the top of this file)
    - Tip: Use your programming IDE navigation facilities on the names in the _central column_ below to find the actual flags/enum lists!
    In Visual Studio IDE: CTRL+comma ("Edit.GoToAll") can follow symbols in comments, whereas CTRL+F12 ("Edit.GoToImplementation") cannot.
    With Visual Assist installed: ALT+G ("VAssistX.GoToImplementation") can also follow symbols in comments.
    -> enum ImDrawFlags_          // Flags: for ImDrawList functions
    """
    ctypedef int ImDrawFlags

    """
    -> enum ImDrawListFlags_      // Flags: for ImDrawList instance
    """
    ctypedef int ImDrawListFlags

    """
    -> enum ImFontAtlasFlags_     // Flags: for ImFontAtlas build
    """
    ctypedef int ImFontAtlasFlags

    """
    -> enum ImGuiBackendFlags_    // Flags: for io.BackendFlags
    """
    ctypedef int ImGuiBackendFlags

    """
    -> enum ImGuiButtonFlags_     // Flags: for InvisibleButton()
    """
    ctypedef int ImGuiButtonFlags

    """
    -> enum ImGuiColorEditFlags_  // Flags: for ColorEdit4(), ColorPicker4() etc.
    """
    ctypedef int ImGuiColorEditFlags

    """
    -> enum ImGuiConfigFlags_     // Flags: for io.ConfigFlags
    """
    ctypedef int ImGuiConfigFlags

    """
    -> enum ImGuiComboFlags_      // Flags: for BeginCombo()
    """
    ctypedef int ImGuiComboFlags

    """
    -> enum ImGuiDockNodeFlags_   // Flags: for DockSpace()
    """
    ctypedef int ImGuiDockNodeFlags

    """
    -> enum ImGuiDragDropFlags_   // Flags: for BeginDragDropSource(), AcceptDragDropPayload()
    """
    ctypedef int ImGuiDragDropFlags

    """
    -> enum ImGuiFocusedFlags_    // Flags: for IsWindowFocused()
    """
    ctypedef int ImGuiFocusedFlags

    """
    -> enum ImGuiHoveredFlags_    // Flags: for IsItemHovered(), IsWindowHovered() etc.
    """
    ctypedef int ImGuiHoveredFlags

    """
    -> enum ImGuiInputTextFlags_  // Flags: for InputText(), InputTextMultiline()
    """
    ctypedef int ImGuiInputTextFlags

    """
    -> ImGuiKey | ImGuiMod_XXX    // Flags: for storage only for now: an ImGuiKey optionally OR-ed with one or more ImGuiMod_XXX values.
    """
    ctypedef int ImGuiKeyChord

    """
    -> enum ImGuiPopupFlags_      // Flags: for OpenPopup*(), BeginPopupContext*(), IsPopupOpen()
    """
    ctypedef int ImGuiPopupFlags

    """
    -> enum ImGuiSelectableFlags_ // Flags: for Selectable()
    """
    ctypedef int ImGuiSelectableFlags

    """
    -> enum ImGuiSliderFlags_     // Flags: for DragFloat(), DragInt(), SliderFloat(), SliderInt() etc.
    """
    ctypedef int ImGuiSliderFlags

    """
    -> enum ImGuiTabBarFlags_     // Flags: for BeginTabBar()
    """
    ctypedef int ImGuiTabBarFlags

    """
    -> enum ImGuiTabItemFlags_    // Flags: for BeginTabItem()
    """
    ctypedef int ImGuiTabItemFlags

    """
    -> enum ImGuiTableFlags_      // Flags: For BeginTable()
    """
    ctypedef int ImGuiTableFlags

    """
    -> enum ImGuiTableColumnFlags_// Flags: For TableSetupColumn()
    """
    ctypedef int ImGuiTableColumnFlags

    """
    -> enum ImGuiTableRowFlags_   // Flags: For TableNextRow()
    """
    ctypedef int ImGuiTableRowFlags

    """
    -> enum ImGuiTreeNodeFlags_   // Flags: for TreeNode(), TreeNodeEx(), CollapsingHeader()
    """
    ctypedef int ImGuiTreeNodeFlags

    """
    -> enum ImGuiViewportFlags_   // Flags: for ImGuiViewport
    """
    ctypedef int ImGuiViewportFlags

    """
    -> enum ImGuiWindowFlags_     // Flags: for Begin(), BeginChild()
    """
    ctypedef int ImGuiWindowFlags

    """
    Default: store a pointer or an integer fitting in a pointer (most renderer backends are ok with that)
    """
    ctypedef void* ImTextureID

    """
    Default: 16-bit (for maximum compatibility with renderer backends)
    """
    ctypedef unsigned short ImDrawIdx

    """
    Scalar data types
    A unique ID used by widgets (typically the result of hashing a stack of string)
    """
    ctypedef unsigned int ImGuiID

    """
    8-bit signed integer
    """
    ctypedef signed char ImS8

    """
    8-bit unsigned integer
    """
    ctypedef unsigned char ImU8

    """
    16-bit signed integer
    """
    ctypedef signed short ImS16

    """
    16-bit unsigned integer
    """
    ctypedef unsigned short ImU16

    """
    32-bit signed integer == int
    """
    ctypedef signed int ImS32

    """
    32-bit unsigned integer (often used to store packed colors)
    """
    ctypedef unsigned int ImU32

    """
    64-bit signed integer
    """
    ctypedef signed long long ImS64

    """
    64-bit unsigned integer
    """
    ctypedef unsigned long long ImU64

    """
    Character types
    (we generally use UTF-8 encoded string in the API. This is storage specifically for a decoded character used for keyboard input and display)
    A single decoded U16 character/code point. We encode them as multi bytes UTF-8 when used in strings.
    """
    ctypedef unsigned short ImWchar16

    """
    A single decoded U32 character/code point. We encode them as multi bytes UTF-8 when used in strings.
    """
    ctypedef unsigned int ImWchar32
    ctypedef ImWchar16 ImWchar

    """
    Callback and functions types
    Callback function for ImGui::InputText()
    """
    ctypedef int (*ImGuiInputTextCallback)(ImGuiInputTextCallbackData* data) ImGuiInputTextCallback

    """
    Callback function for ImGui::SetNextWindowSizeConstraints()
    """
    ctypedef void (*ImGuiSizeCallback)(ImGuiSizeCallbackData* data) ImGuiSizeCallback

    """
    Function signature for ImGui::SetAllocatorFunctions()
    """
    ctypedef void* (*ImGuiMemAllocFunc)(size_t sz, void* user_data) ImGuiMemAllocFunc

    """
    Function signature for ImGui::SetAllocatorFunctions()
    """
    ctypedef void (*ImGuiMemFreeFunc)(void* ptr, void* user_data) ImGuiMemFreeFunc
    ctypedef void (*ImDrawCallback)(const ImDrawList* parent_list, const ImDrawCmd* cmd) ImDrawCallback


    """
    Flags for ImGui::Begin()
    (Those are per-window flags. There are shared flags in ImGuiIO: io.ConfigWindowsResizeFromEdges and io.ConfigWindowsMoveFromTitleBarOnly)
    """
    ctypedef enum ImGuiWindowFlags_:
        ImGuiWindowFlags_None
        ImGuiWindowFlags_NoTitleBar                    # Disable title-bar
        ImGuiWindowFlags_NoResize                      # Disable user resizing with the lower-right grip
        ImGuiWindowFlags_NoMove                        # Disable user moving the window
        ImGuiWindowFlags_NoScrollbar                   # Disable scrollbars (window can still scroll with mouse or programmatically)
        ImGuiWindowFlags_NoScrollWithMouse             # Disable user vertically scrolling with mouse wheel. On child window, mouse wheel will be forwarded to the parent unless NoScrollbar is also set.
        ImGuiWindowFlags_NoCollapse                    # Disable user collapsing window by double-clicking on it. Also referred to as Window Menu Button (e.g. within a docking node).
        ImGuiWindowFlags_AlwaysAutoResize              # Resize every window to its content every frame
        ImGuiWindowFlags_NoBackground                  # Disable drawing background color (WindowBg, etc.) and outside border. Similar as using SetNextWindowBgAlpha(0.0f).
        ImGuiWindowFlags_NoSavedSettings               # Never load/save settings in .ini file
        ImGuiWindowFlags_NoMouseInputs                 # Disable catching mouse, hovering test with pass through.
        ImGuiWindowFlags_MenuBar                       # Has a menu-bar
        ImGuiWindowFlags_HorizontalScrollbar           # Allow horizontal scrollbar to appear (off by default). You may use SetNextWindowContentSize(ImVec2(width,0.0f)); prior to calling Begin() to specify width. Read code in imgui_demo in the "Horizontal Scrolling" section.
        ImGuiWindowFlags_NoFocusOnAppearing            # Disable taking focus when transitioning from hidden to visible state
        ImGuiWindowFlags_NoBringToFrontOnFocus         # Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus)
        ImGuiWindowFlags_AlwaysVerticalScrollbar       # Always show vertical scrollbar (even if ContentSize.y < Size.y)
        ImGuiWindowFlags_AlwaysHorizontalScrollbar     # Always show horizontal scrollbar (even if ContentSize.x < Size.x)
        ImGuiWindowFlags_AlwaysUseWindowPadding        # Ensure child windows without border uses style.WindowPadding (ignored by default for non-bordered child windows, because more convenient)
        ImGuiWindowFlags_NoNavInputs                   # No gamepad/keyboard navigation within the window
        ImGuiWindowFlags_NoNavFocus                    # No focusing toward this window with gamepad/keyboard navigation (e.g. skipped by CTRL+TAB)
        ImGuiWindowFlags_UnsavedDocument               # Display a dot next to the title. When used in a tab/docking context, tab is selected when clicking the X + closure is not assumed (will wait for user to stop submitting the tab). Otherwise closure is assumed when pressing the X, so if you keep submitting the tab may reappear at end of tab bar.
        ImGuiWindowFlags_NoDocking                     # Disable docking of this window
        ImGuiWindowFlags_NoNav
        ImGuiWindowFlags_NoDecoration
        ImGuiWindowFlags_NoInputs
        ImGuiWindowFlags_NavFlattened                  # [BETA] On child window: allow gamepad/keyboard navigation to cross over parent border to this child or between sibling child windows.
        ImGuiWindowFlags_ChildWindow                   # Don't use! For internal use by BeginChild()
        ImGuiWindowFlags_Tooltip                       # Don't use! For internal use by BeginTooltip()
        ImGuiWindowFlags_Popup                         # Don't use! For internal use by BeginPopup()
        ImGuiWindowFlags_Modal                         # Don't use! For internal use by BeginPopupModal()
        ImGuiWindowFlags_ChildMenu                     # Don't use! For internal use by BeginMenu()
        ImGuiWindowFlags_DockNodeHost                  # Don't use! For internal use by Begin()/NewFrame()


    """
    Flags for ImGui::InputText()
    (Those are per-item flags. There are shared flags in ImGuiIO: io.ConfigInputTextCursorBlink and io.ConfigInputTextEnterKeepActive)
    """
    ctypedef enum ImGuiInputTextFlags_:
        ImGuiInputTextFlags_None
        ImGuiInputTextFlags_CharsDecimal            # Allow 0123456789.+-*/
        ImGuiInputTextFlags_CharsHexadecimal        # Allow 0123456789ABCDEFabcdef
        ImGuiInputTextFlags_CharsUppercase          # Turn a..z into A..Z
        ImGuiInputTextFlags_CharsNoBlank            # Filter out spaces, tabs
        ImGuiInputTextFlags_AutoSelectAll           # Select entire text when first taking mouse focus
        ImGuiInputTextFlags_EnterReturnsTrue        # Return 'true' when Enter is pressed (as opposed to every time the value was modified). Consider looking at the IsItemDeactivatedAfterEdit() function.
        ImGuiInputTextFlags_CallbackCompletion      # Callback on pressing TAB (for completion handling)
        ImGuiInputTextFlags_CallbackHistory         # Callback on pressing Up/Down arrows (for history handling)
        ImGuiInputTextFlags_CallbackAlways          # Callback on each iteration. User code may query cursor position, modify text buffer.
        ImGuiInputTextFlags_CallbackCharFilter      # Callback on character inputs to replace or discard them. Modify 'EventChar' to replace or discard, or return 1 in callback to discard.
        ImGuiInputTextFlags_AllowTabInput           # Pressing TAB input a '\t' character into the text field
        ImGuiInputTextFlags_CtrlEnterForNewLine     # In multi-line mode, unfocus with Enter, add new line with Ctrl+Enter (default is opposite: unfocus with Ctrl+Enter, add line with Enter).
        ImGuiInputTextFlags_NoHorizontalScroll      # Disable following the cursor horizontally
        ImGuiInputTextFlags_AlwaysOverwrite         # Overwrite mode
        ImGuiInputTextFlags_ReadOnly                # Read-only mode
        ImGuiInputTextFlags_Password                # Password mode, display all characters as '*'
        ImGuiInputTextFlags_NoUndoRedo              # Disable undo/redo. Note that input text owns the text data while active, if you want to provide your own undo/redo stack you need e.g. to call ClearActiveID().
        ImGuiInputTextFlags_CharsScientific         # Allow 0123456789.+-*/eE (Scientific notation input)
        ImGuiInputTextFlags_CallbackResize          # Callback on buffer capacity changes request (beyond 'buf_size' parameter value), allowing the string to grow. Notify when the string wants to be resized (for string types which hold a cache of their Size). You will be provided a new BufSize in the callback and NEED to honor it. (see misc/cpp/imgui_stdlib.h for an example of using this)
        ImGuiInputTextFlags_CallbackEdit            # Callback on any edit (note that InputText() already returns true on edit, the callback is useful mainly to manipulate the underlying buffer while focus is active)
        ImGuiInputTextFlags_EscapeClearsAll         # Escape key clears content if not empty, and deactivate otherwise (contrast to default behavior of Escape to revert)


    """
    Flags for ImGui::TreeNodeEx(), ImGui::CollapsingHeader*()
    """
    ctypedef enum ImGuiTreeNodeFlags_:
        ImGuiTreeNodeFlags_None
        ImGuiTreeNodeFlags_Selected                 # Draw as selected
        ImGuiTreeNodeFlags_Framed                   # Draw frame with background (e.g. for CollapsingHeader)
        ImGuiTreeNodeFlags_AllowItemOverlap         # Hit testing to allow subsequent widgets to overlap this one
        ImGuiTreeNodeFlags_NoTreePushOnOpen         # Don't do a TreePush() when open (e.g. for CollapsingHeader) = no extra indent nor pushing on ID stack
        ImGuiTreeNodeFlags_NoAutoOpenOnLog          # Don't automatically and temporarily open node when Logging is active (by default logging will automatically open tree nodes)
        ImGuiTreeNodeFlags_DefaultOpen              # Default node to be open
        ImGuiTreeNodeFlags_OpenOnDoubleClick        # Need double-click to open node
        ImGuiTreeNodeFlags_OpenOnArrow              # Only open when clicking on the arrow part. If ImGuiTreeNodeFlags_OpenOnDoubleClick is also set, single-click arrow or double-click all box to open.
        ImGuiTreeNodeFlags_Leaf                     # No collapsing, no arrow (use as a convenience for leaf nodes).
        ImGuiTreeNodeFlags_Bullet                   # Display a bullet instead of arrow
        ImGuiTreeNodeFlags_FramePadding             # Use FramePadding (even for an unframed text node) to vertically align text baseline to regular widget height. Equivalent to calling AlignTextToFramePadding().
        ImGuiTreeNodeFlags_SpanAvailWidth           # Extend hit box to the right-most edge, even if not framed. This is not the default in order to allow adding other items on the same line. In the future we may refactor the hit system to be front-to-back, allowing natural overlaps and then this can become the default.
        ImGuiTreeNodeFlags_SpanFullWidth            # Extend hit box to the left-most and right-most edges (bypass the indented area).
        ImGuiTreeNodeFlags_NavLeftJumpsBackHere     # (WIP) Nav: left direction may move to this TreeNode() from any of its child (items submitted between TreeNode and TreePop)
        ImGuiTreeNodeFlags_CollapsingHeader


    """
    Flags for OpenPopup*(), BeginPopupContext*(), IsPopupOpen() functions.
    - To be backward compatible with older API which took an 'int mouse_button = 1' argument, we need to treat
    small flags values as a mouse button index, so we encode the mouse button in the first few bits of the flags.
    It is therefore guaranteed to be legal to pass a mouse button index in ImGuiPopupFlags.
    - For the same reason, we exceptionally default the ImGuiPopupFlags argument of BeginPopupContextXXX functions to 1 instead of 0.
    IMPORTANT: because the default parameter is 1 (==ImGuiPopupFlags_MouseButtonRight), if you rely on the default parameter
    and want to use another flag, you need to pass in the ImGuiPopupFlags_MouseButtonRight flag explicitly.
    - Multiple buttons currently cannot be combined/or-ed in those functions (we could allow it later).
    """
    ctypedef enum ImGuiPopupFlags_:
        ImGuiPopupFlags_None
        ImGuiPopupFlags_MouseButtonLeft             # For BeginPopupContext*(): open on Left Mouse release. Guaranteed to always be == 0 (same as ImGuiMouseButton_Left)
        ImGuiPopupFlags_MouseButtonRight            # For BeginPopupContext*(): open on Right Mouse release. Guaranteed to always be == 1 (same as ImGuiMouseButton_Right)
        ImGuiPopupFlags_MouseButtonMiddle           # For BeginPopupContext*(): open on Middle Mouse release. Guaranteed to always be == 2 (same as ImGuiMouseButton_Middle)
        ImGuiPopupFlags_MouseButtonMask_
        ImGuiPopupFlags_MouseButtonDefault_
        ImGuiPopupFlags_NoOpenOverExistingPopup     # For OpenPopup*(), BeginPopupContext*(): don't open if there's already a popup at the same level of the popup stack
        ImGuiPopupFlags_NoOpenOverItems             # For BeginPopupContextWindow(): don't return true when hovering items, only when hovering empty space
        ImGuiPopupFlags_AnyPopupId                  # For IsPopupOpen(): ignore the ImGuiID parameter and test for any popup.
        ImGuiPopupFlags_AnyPopupLevel               # For IsPopupOpen(): search/test at any level of the popup stack (default test in the current level)
        ImGuiPopupFlags_AnyPopup


    """
    Flags for ImGui::Selectable()
    """
    ctypedef enum ImGuiSelectableFlags_:
        ImGuiSelectableFlags_None
        ImGuiSelectableFlags_DontClosePopups      # Clicking this doesn't close parent popup window
        ImGuiSelectableFlags_SpanAllColumns       # Selectable frame can span all columns (text will still fit in current column)
        ImGuiSelectableFlags_AllowDoubleClick     # Generate press events on double clicks too
        ImGuiSelectableFlags_Disabled             # Cannot be selected, display grayed out text
        ImGuiSelectableFlags_AllowItemOverlap     # (WIP) Hit testing to allow subsequent widgets to overlap this one


    """
    Flags for ImGui::BeginCombo()
    """
    ctypedef enum ImGuiComboFlags_:
        ImGuiComboFlags_None
        ImGuiComboFlags_PopupAlignLeft     # Align the popup toward the left by default
        ImGuiComboFlags_HeightSmall        # Max ~4 items visible. Tip: If you want your combo popup to be a specific size you can use SetNextWindowSizeConstraints() prior to calling BeginCombo()
        ImGuiComboFlags_HeightRegular      # Max ~8 items visible (default)
        ImGuiComboFlags_HeightLarge        # Max ~20 items visible
        ImGuiComboFlags_HeightLargest      # As many fitting items as possible
        ImGuiComboFlags_NoArrowButton      # Display on the preview box without the square arrow button
        ImGuiComboFlags_NoPreview          # Display only a square arrow button
        ImGuiComboFlags_HeightMask_


    """
    Flags for ImGui::BeginTabBar()
    """
    ctypedef enum ImGuiTabBarFlags_:
        ImGuiTabBarFlags_None
        ImGuiTabBarFlags_Reorderable                      # Allow manually dragging tabs to re-order them + New tabs are appended at the end of list
        ImGuiTabBarFlags_AutoSelectNewTabs                # Automatically select new tabs when they appear
        ImGuiTabBarFlags_TabListPopupButton               # Disable buttons to open the tab list popup
        ImGuiTabBarFlags_NoCloseWithMiddleMouseButton     # Disable behavior of closing tabs (that are submitted with p_open != NULL) with middle mouse button. You can still repro this behavior on user's side with if (IsItemHovered() && IsMouseClicked(2)) *p_open = false.
        ImGuiTabBarFlags_NoTabListScrollingButtons        # Disable scrolling buttons (apply when fitting policy is ImGuiTabBarFlags_FittingPolicyScroll)
        ImGuiTabBarFlags_NoTooltip                        # Disable tooltips when hovering a tab
        ImGuiTabBarFlags_FittingPolicyResizeDown          # Resize tabs when they don't fit
        ImGuiTabBarFlags_FittingPolicyScroll              # Add scroll buttons when tabs don't fit
        ImGuiTabBarFlags_FittingPolicyMask_
        ImGuiTabBarFlags_FittingPolicyDefault_


    """
    Flags for ImGui::BeginTabItem()
    """
    ctypedef enum ImGuiTabItemFlags_:
        ImGuiTabItemFlags_None
        ImGuiTabItemFlags_UnsavedDocument                  # Display a dot next to the title + tab is selected when clicking the X + closure is not assumed (will wait for user to stop submitting the tab). Otherwise closure is assumed when pressing the X, so if you keep submitting the tab may reappear at end of tab bar.
        ImGuiTabItemFlags_SetSelected                      # Trigger flag to programmatically make the tab selected when calling BeginTabItem()
        ImGuiTabItemFlags_NoCloseWithMiddleMouseButton     # Disable behavior of closing tabs (that are submitted with p_open != NULL) with middle mouse button. You can still repro this behavior on user's side with if (IsItemHovered() && IsMouseClicked(2)) *p_open = false.
        ImGuiTabItemFlags_NoPushId                         # Don't call PushID(tab->ID)/PopID() on BeginTabItem()/EndTabItem()
        ImGuiTabItemFlags_NoTooltip                        # Disable tooltip for the given tab
        ImGuiTabItemFlags_NoReorder                        # Disable reordering this tab or having another tab cross over this tab
        ImGuiTabItemFlags_Leading                          # Enforce the tab position to the left of the tab bar (after the tab list popup button)
        ImGuiTabItemFlags_Trailing                         # Enforce the tab position to the right of the tab bar (before the scrolling buttons)


    """
    Flags for ImGui::BeginTable()
    - Important! Sizing policies have complex and subtle side effects, much more so than you would expect.
    Read comments/demos carefully + experiment with live demos to get acquainted with them.
    - The DEFAULT sizing policies are:
    - Default to ImGuiTableFlags_SizingFixedFit    if ScrollX is on, or if host window has ImGuiWindowFlags_AlwaysAutoResize.
    - Default to ImGuiTableFlags_SizingStretchSame if ScrollX is off.
    - When ScrollX is off:
    - Table defaults to ImGuiTableFlags_SizingStretchSame -> all Columns defaults to ImGuiTableColumnFlags_WidthStretch with same weight.
    - Columns sizing policy allowed: Stretch (default), Fixed/Auto.
    - Fixed Columns (if any) will generally obtain their requested width (unless the table cannot fit them all).
    - Stretch Columns will share the remaining width according to their respective weight.
    - Mixed Fixed/Stretch columns is possible but has various side-effects on resizing behaviors.
    The typical use of mixing sizing policies is: any number of LEADING Fixed columns, followed by one or two TRAILING Stretch columns.
    (this is because the visible order of columns have subtle but necessary effects on how they react to manual resizing).
    - When ScrollX is on:
    - Table defaults to ImGuiTableFlags_SizingFixedFit -> all Columns defaults to ImGuiTableColumnFlags_WidthFixed
    - Columns sizing policy allowed: Fixed/Auto mostly.
    - Fixed Columns can be enlarged as needed. Table will show a horizontal scrollbar if needed.
    - When using auto-resizing (non-resizable) fixed columns, querying the content width to use item right-alignment e.g. SetNextItemWidth(-FLT_MIN) doesn't make sense, would create a feedback loop.
    - Using Stretch columns OFTEN DOES NOT MAKE SENSE if ScrollX is on, UNLESS you have specified a value for 'inner_width' in BeginTable().
    If you specify a value for 'inner_width' then effectively the scrolling space is known and Stretch or mixed Fixed/Stretch columns become meaningful again.
    - Read on documentation at the top of imgui_tables.cpp for details.
    """
    ctypedef enum ImGuiTableFlags_:
        ImGuiTableFlags_None
        ImGuiTableFlags_Resizable                      # Enable resizing columns.
        ImGuiTableFlags_Reorderable                    # Enable reordering columns in header row (need calling TableSetupColumn() + TableHeadersRow() to display headers)
        ImGuiTableFlags_Hideable                       # Enable hiding/disabling columns in context menu.
        ImGuiTableFlags_Sortable                       # Enable sorting. Call TableGetSortSpecs() to obtain sort specs. Also see ImGuiTableFlags_SortMulti and ImGuiTableFlags_SortTristate.
        ImGuiTableFlags_NoSavedSettings                # Disable persisting columns order, width and sort settings in the .ini file.
        ImGuiTableFlags_ContextMenuInBody              # Right-click on columns body/contents will display table context menu. By default it is available in TableHeadersRow().
        ImGuiTableFlags_RowBg                          # Set each RowBg color with ImGuiCol_TableRowBg or ImGuiCol_TableRowBgAlt (equivalent of calling TableSetBgColor with ImGuiTableBgFlags_RowBg0 on each row manually)
        ImGuiTableFlags_BordersInnerH                  # Draw horizontal borders between rows.
        ImGuiTableFlags_BordersOuterH                  # Draw horizontal borders at the top and bottom.
        ImGuiTableFlags_BordersInnerV                  # Draw vertical borders between columns.
        ImGuiTableFlags_BordersOuterV                  # Draw vertical borders on the left and right sides.
        ImGuiTableFlags_BordersH                       # Draw horizontal borders.
        ImGuiTableFlags_BordersV                       # Draw vertical borders.
        ImGuiTableFlags_BordersInner                   # Draw inner borders.
        ImGuiTableFlags_BordersOuter                   # Draw outer borders.
        ImGuiTableFlags_Borders                        # Draw all borders.
        ImGuiTableFlags_NoBordersInBody                # [ALPHA] Disable vertical borders in columns Body (borders will always appear in Headers). -> May move to style
        ImGuiTableFlags_NoBordersInBodyUntilResize     # [ALPHA] Disable vertical borders in columns Body until hovered for resize (borders will always appear in Headers). -> May move to style
        ImGuiTableFlags_SizingFixedFit                 # Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable), matching contents width.
        ImGuiTableFlags_SizingFixedSame                # Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable), matching the maximum contents width of all columns. Implicitly enable ImGuiTableFlags_NoKeepColumnsVisible.
        ImGuiTableFlags_SizingStretchProp              # Columns default to _WidthStretch with default weights proportional to each columns contents widths.
        ImGuiTableFlags_SizingStretchSame              # Columns default to _WidthStretch with default weights all equal, unless overridden by TableSetupColumn().
        ImGuiTableFlags_NoHostExtendX                  # Make outer width auto-fit to columns, overriding outer_size.x value. Only available when ScrollX/ScrollY are disabled and Stretch columns are not used.
        ImGuiTableFlags_NoHostExtendY                  # Make outer height stop exactly at outer_size.y (prevent auto-extending table past the limit). Only available when ScrollX/ScrollY are disabled. Data below the limit will be clipped and not visible.
        ImGuiTableFlags_NoKeepColumnsVisible           # Disable keeping column always minimally visible when ScrollX is off and table gets too small. Not recommended if columns are resizable.
        ImGuiTableFlags_PreciseWidths                  # Disable distributing remainder width to stretched columns (width allocation on a 100-wide table with 3 columns: Without this flag: 33,33,34. With this flag: 33,33,33). With larger number of columns, resizing will appear to be less smooth.
        ImGuiTableFlags_NoClip                         # Disable clipping rectangle for every individual columns (reduce draw command count, items will be able to overflow into other columns). Generally incompatible with TableSetupScrollFreeze().
        ImGuiTableFlags_PadOuterX                      # Default if BordersOuterV is on. Enable outermost padding. Generally desirable if you have headers.
        ImGuiTableFlags_NoPadOuterX                    # Default if BordersOuterV is off. Disable outermost padding.
        ImGuiTableFlags_NoPadInnerX                    # Disable inner padding between columns (double inner padding if BordersOuterV is on, single inner padding if BordersOuterV is off).
        ImGuiTableFlags_ScrollX                        # Enable horizontal scrolling. Require 'outer_size' parameter of BeginTable() to specify the container size. Changes default sizing policy. Because this creates a child window, ScrollY is currently generally recommended when using ScrollX.
        ImGuiTableFlags_ScrollY                        # Enable vertical scrolling. Require 'outer_size' parameter of BeginTable() to specify the container size.
        ImGuiTableFlags_SortMulti                      # Hold shift when clicking headers to sort on multiple column. TableGetSortSpecs() may return specs where (SpecsCount > 1).
        ImGuiTableFlags_SortTristate                   # Allow no sorting, disable default sorting. TableGetSortSpecs() may return specs where (SpecsCount == 0).
        ImGuiTableFlags_SizingMask_


    """
    Flags for ImGui::TableSetupColumn()
    """
    ctypedef enum ImGuiTableColumnFlags_:
        ImGuiTableColumnFlags_None
        ImGuiTableColumnFlags_Disabled                 # Overriding/master disable flag: hide column, won't show in context menu (unlike calling TableSetColumnEnabled() which manipulates the user accessible state)
        ImGuiTableColumnFlags_DefaultHide              # Default as a hidden/disabled column.
        ImGuiTableColumnFlags_DefaultSort              # Default as a sorting column.
        ImGuiTableColumnFlags_WidthStretch             # Column will stretch. Preferable with horizontal scrolling disabled (default if table sizing policy is _SizingStretchSame or _SizingStretchProp).
        ImGuiTableColumnFlags_WidthFixed               # Column will not stretch. Preferable with horizontal scrolling enabled (default if table sizing policy is _SizingFixedFit and table is resizable).
        ImGuiTableColumnFlags_NoResize                 # Disable manual resizing.
        ImGuiTableColumnFlags_NoReorder                # Disable manual reordering this column, this will also prevent other columns from crossing over this column.
        ImGuiTableColumnFlags_NoHide                   # Disable ability to hide/disable this column.
        ImGuiTableColumnFlags_NoClip                   # Disable clipping for this column (all NoClip columns will render in a same draw command).
        ImGuiTableColumnFlags_NoSort                   # Disable ability to sort on this field (even if ImGuiTableFlags_Sortable is set on the table).
        ImGuiTableColumnFlags_NoSortAscending          # Disable ability to sort in the ascending direction.
        ImGuiTableColumnFlags_NoSortDescending         # Disable ability to sort in the descending direction.
        ImGuiTableColumnFlags_NoHeaderLabel            # TableHeadersRow() will not submit label for this column. Convenient for some small columns. Name will still appear in context menu.
        ImGuiTableColumnFlags_NoHeaderWidth            # Disable header text width contribution to automatic column width.
        ImGuiTableColumnFlags_PreferSortAscending      # Make the initial sort direction Ascending when first sorting on this column (default).
        ImGuiTableColumnFlags_PreferSortDescending     # Make the initial sort direction Descending when first sorting on this column.
        ImGuiTableColumnFlags_IndentEnable             # Use current Indent value when entering cell (default for column 0).
        ImGuiTableColumnFlags_IndentDisable            # Ignore current Indent value when entering cell (default for columns > 0). Indentation changes _within_ the cell will still be honored.
        ImGuiTableColumnFlags_IsEnabled                # Status: is enabled == not hidden by user/api (referred to as "Hide" in _DefaultHide and _NoHide) flags.
        ImGuiTableColumnFlags_IsVisible                # Status: is visible == is enabled AND not clipped by scrolling.
        ImGuiTableColumnFlags_IsSorted                 # Status: is currently part of the sort specs
        ImGuiTableColumnFlags_IsHovered                # Status: is hovered by mouse
        ImGuiTableColumnFlags_WidthMask_
        ImGuiTableColumnFlags_IndentMask_
        ImGuiTableColumnFlags_StatusMask_
        ImGuiTableColumnFlags_NoDirectResize_          # [Internal] Disable user resizing this column directly (it may however we resized indirectly from its left edge)


    """
    Flags for ImGui::TableNextRow()
    """
    ctypedef enum ImGuiTableRowFlags_:
        ImGuiTableRowFlags_None
        ImGuiTableRowFlags_Headers     # Identify header row (set default background color + width of its contents accounted differently for auto column width)


    """
    Enum for ImGui::TableSetBgColor()
    Background colors are rendering in 3 layers:
    - Layer 0: draw with RowBg0 color if set, otherwise draw with ColumnBg0 if set.
    - Layer 1: draw with RowBg1 color if set, otherwise draw with ColumnBg1 if set.
    - Layer 2: draw with CellBg color if set.
    The purpose of the two row/columns layers is to let you decide if a background color change should override or blend with the existing color.
    When using ImGuiTableFlags_RowBg on the table, each row has the RowBg0 color automatically set for odd/even rows.
    If you set the color of RowBg0 target, your color will override the existing RowBg0 color.
    If you set the color of RowBg1 or ColumnBg1 target, your color will blend over the RowBg0 color.
    """
    ctypedef enum ImGuiTableBgTarget_:
        ImGuiTableBgTarget_None
        ImGuiTableBgTarget_RowBg0     # Set row background color 0 (generally used for background, automatically set when ImGuiTableFlags_RowBg is used)
        ImGuiTableBgTarget_RowBg1     # Set row background color 1 (generally used for selection marking)
        ImGuiTableBgTarget_CellBg     # Set cell background color (top-most color)


    """
    Flags for ImGui::IsWindowFocused()
    """
    ctypedef enum ImGuiFocusedFlags_:
        ImGuiFocusedFlags_None
        ImGuiFocusedFlags_ChildWindows            # Return true if any children of the window is focused
        ImGuiFocusedFlags_RootWindow              # Test from root window (top most parent of the current hierarchy)
        ImGuiFocusedFlags_AnyWindow               # Return true if any window is focused. Important: If you are trying to tell how to dispatch your low-level inputs, do NOT use this. Use 'io.WantCaptureMouse' instead! Please read the FAQ!
        ImGuiFocusedFlags_NoPopupHierarchy        # Do not consider popup hierarchy (do not treat popup emitter as parent of popup) (when used with _ChildWindows or _RootWindow)
        ImGuiFocusedFlags_DockHierarchy           # Consider docking hierarchy (treat dockspace host as parent of docked window) (when used with _ChildWindows or _RootWindow)
        ImGuiFocusedFlags_RootAndChildWindows


    """
    Flags for ImGui::IsItemHovered(), ImGui::IsWindowHovered()
    Note: if you are trying to check whether your mouse should be dispatched to Dear ImGui or to your app, you should use 'io.WantCaptureMouse' instead! Please read the FAQ!
    Note: windows with the ImGuiWindowFlags_NoInputs flag are ignored by IsWindowHovered() calls.
    """
    ctypedef enum ImGuiHoveredFlags_:
        ImGuiHoveredFlags_None                             # Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
        ImGuiHoveredFlags_ChildWindows                     # IsWindowHovered() only: Return true if any children of the window is hovered
        ImGuiHoveredFlags_RootWindow                       # IsWindowHovered() only: Test from root window (top most parent of the current hierarchy)
        ImGuiHoveredFlags_AnyWindow                        # IsWindowHovered() only: Return true if any window is hovered
        ImGuiHoveredFlags_NoPopupHierarchy                 # IsWindowHovered() only: Do not consider popup hierarchy (do not treat popup emitter as parent of popup) (when used with _ChildWindows or _RootWindow)
        ImGuiHoveredFlags_DockHierarchy                    # IsWindowHovered() only: Consider docking hierarchy (treat dockspace host as parent of docked window) (when used with _ChildWindows or _RootWindow)
        ImGuiHoveredFlags_AllowWhenBlockedByPopup          # Return true even if a popup window is normally blocking access to this item/window
        ImGuiHoveredFlags_AllowWhenBlockedByActiveItem     # Return true even if an active item is blocking access to this item/window. Useful for Drag and Drop patterns.
        ImGuiHoveredFlags_AllowWhenOverlapped              # IsItemHovered() only: Return true even if the position is obstructed or overlapped by another window
        ImGuiHoveredFlags_AllowWhenDisabled                # IsItemHovered() only: Return true even if the item is disabled
        ImGuiHoveredFlags_NoNavOverride                    # Disable using gamepad/keyboard navigation state when active, always query mouse.
        ImGuiHoveredFlags_RectOnly
        ImGuiHoveredFlags_RootAndChildWindows
        ImGuiHoveredFlags_DelayNormal                      # Return true after io.HoverDelayNormal elapsed (~0.30 sec)
        ImGuiHoveredFlags_DelayShort                       # Return true after io.HoverDelayShort elapsed (~0.10 sec)
        ImGuiHoveredFlags_NoSharedDelay                    # Disable shared delay system where moving from one item to the next keeps the previous timer for a short time (standard for tooltips with long delays)


    """
    Flags for ImGui::DockSpace(), shared/inherited by child nodes.
    (Some flags can be applied to individual nodes directly)
    FIXME-DOCK: Also see ImGuiDockNodeFlagsPrivate_ which may involve using the WIP and internal DockBuilder api.
    """
    ctypedef enum ImGuiDockNodeFlags_:
        ImGuiDockNodeFlags_None
        ImGuiDockNodeFlags_KeepAliveOnly              # Shared       // Don't display the dockspace node but keep it alive. Windows docked into this dockspace node won't be undocked.
        ImGuiDockNodeFlags_NoDockingInCentralNode     # Shared       // Disable docking inside the Central Node, which will be always kept empty.
        ImGuiDockNodeFlags_PassthruCentralNode        # Shared       // Enable passthru dockspace: 1) DockSpace() will render a ImGuiCol_WindowBg background covering everything excepted the Central Node when empty. Meaning the host window should probably use SetNextWindowBgAlpha(0.0f) prior to Begin() when using this. 2) When Central Node is empty: let inputs pass-through + won't display a DockingEmptyBg background. See demo for details.
        ImGuiDockNodeFlags_NoSplit                    # Shared/Local // Disable splitting the node into smaller nodes. Useful e.g. when embedding dockspaces into a main root one (the root one may have splitting disabled to reduce confusion). Note: when turned off, existing splits will be preserved.
        ImGuiDockNodeFlags_NoResize                   # Shared/Local // Disable resizing node using the splitter/separators. Useful with programmatically setup dockspaces.
        ImGuiDockNodeFlags_AutoHideTabBar             # Shared/Local // Tab bar will automatically hide when there is a single window in the dock node.


    """
    Flags for ImGui::BeginDragDropSource(), ImGui::AcceptDragDropPayload()
    """
    ctypedef enum ImGuiDragDropFlags_:
        ImGuiDragDropFlags_None
        ImGuiDragDropFlags_SourceNoPreviewTooltip       # Disable preview tooltip. By default, a successful call to BeginDragDropSource opens a tooltip so you can display a preview or description of the source contents. This flag disables this behavior.
        ImGuiDragDropFlags_SourceNoDisableHover         # By default, when dragging we clear data so that IsItemHovered() will return false, to avoid subsequent user code submitting tooltips. This flag disables this behavior so you can still call IsItemHovered() on the source item.
        ImGuiDragDropFlags_SourceNoHoldToOpenOthers     # Disable the behavior that allows to open tree nodes and collapsing header by holding over them while dragging a source item.
        ImGuiDragDropFlags_SourceAllowNullID            # Allow items such as Text(), Image() that have no unique identifier to be used as drag source, by manufacturing a temporary identifier based on their window-relative position. This is extremely unusual within the dear imgui ecosystem and so we made it explicit.
        ImGuiDragDropFlags_SourceExtern                 # External source (from outside of dear imgui), won't attempt to read current item/window info. Will always return true. Only one Extern source can be active simultaneously.
        ImGuiDragDropFlags_SourceAutoExpirePayload      # Automatically expire the payload if the source cease to be submitted (otherwise payloads are persisting while being dragged)
        ImGuiDragDropFlags_AcceptBeforeDelivery         # AcceptDragDropPayload() will returns true even before the mouse button is released. You can then call IsDelivery() to test if the payload needs to be delivered.
        ImGuiDragDropFlags_AcceptNoDrawDefaultRect      # Do not draw the default highlight rectangle when hovering over target.
        ImGuiDragDropFlags_AcceptNoPreviewTooltip       # Request hiding the BeginDragDropSource tooltip from the BeginDragDropTarget site.
        ImGuiDragDropFlags_AcceptPeekOnly               # For peeking ahead and inspecting the payload before delivery.


    """
    A primary data type
    """
    ctypedef enum ImGuiDataType_:
        ImGuiDataType_S8         # signed char / char (with sensible compilers)
        ImGuiDataType_U8         # unsigned char
        ImGuiDataType_S16        # short
        ImGuiDataType_U16        # unsigned short
        ImGuiDataType_S32        # int
        ImGuiDataType_U32        # unsigned int
        ImGuiDataType_S64        # long long / __int64
        ImGuiDataType_U64        # unsigned long long / unsigned __int64
        ImGuiDataType_Float      # float
        ImGuiDataType_Double     # double
        ImGuiDataType_COUNT


    """
    A cardinal direction
    """
    ctypedef enum ImGuiDir_:
        ImGuiDir_None
        ImGuiDir_Left
        ImGuiDir_Right
        ImGuiDir_Up
        ImGuiDir_Down
        ImGuiDir_COUNT


    """
    A sorting direction
    """
    ctypedef enum ImGuiSortDirection_:
        ImGuiSortDirection_None
        ImGuiSortDirection_Ascending      # Ascending = 0->9, A->Z etc.
        ImGuiSortDirection_Descending     # Descending = 9->0, Z->A etc.


    """
    A key identifier (ImGuiKey_XXX or ImGuiMod_XXX value): can represent Keyboard, Mouse and Gamepad values.
    All our named keys are >= 512. Keys value 0 to 511 are left unused as legacy native/opaque key values (< 1.87).
    Since >= 1.89 we increased typing (went from int to enum), some legacy code may need a cast to ImGuiKey.
    Read details about the 1.87 and 1.89 transition : https://github.com/ocornut/imgui/issues/4921
    Note that "Keys" related to physical keys and are not the same concept as input "Characters", the later are submitted via io.AddInputCharacter().
    Forward declared enum type ImGuiKey
    """
    ctypedef enum ImGuiKey:
        ImGuiKey_None
        ImGuiKey_Tab                     # == ImGuiKey_NamedKey_BEGIN
        ImGuiKey_LeftArrow
        ImGuiKey_RightArrow
        ImGuiKey_UpArrow
        ImGuiKey_DownArrow
        ImGuiKey_PageUp
        ImGuiKey_PageDown
        ImGuiKey_Home
        ImGuiKey_End
        ImGuiKey_Insert
        ImGuiKey_Delete
        ImGuiKey_Backspace
        ImGuiKey_Space
        ImGuiKey_Enter
        ImGuiKey_Escape
        ImGuiKey_LeftCtrl
        ImGuiKey_LeftShift
        ImGuiKey_LeftAlt
        ImGuiKey_LeftSuper
        ImGuiKey_RightCtrl
        ImGuiKey_RightShift
        ImGuiKey_RightAlt
        ImGuiKey_RightSuper
        ImGuiKey_Menu
        ImGuiKey_0
        ImGuiKey_1
        ImGuiKey_2
        ImGuiKey_3
        ImGuiKey_4
        ImGuiKey_5
        ImGuiKey_6
        ImGuiKey_7
        ImGuiKey_8
        ImGuiKey_9
        ImGuiKey_A
        ImGuiKey_B
        ImGuiKey_C
        ImGuiKey_D
        ImGuiKey_E
        ImGuiKey_F
        ImGuiKey_G
        ImGuiKey_H
        ImGuiKey_I
        ImGuiKey_J
        ImGuiKey_K
        ImGuiKey_L
        ImGuiKey_M
        ImGuiKey_N
        ImGuiKey_O
        ImGuiKey_P
        ImGuiKey_Q
        ImGuiKey_R
        ImGuiKey_S
        ImGuiKey_T
        ImGuiKey_U
        ImGuiKey_V
        ImGuiKey_W
        ImGuiKey_X
        ImGuiKey_Y
        ImGuiKey_Z
        ImGuiKey_F1
        ImGuiKey_F2
        ImGuiKey_F3
        ImGuiKey_F4
        ImGuiKey_F5
        ImGuiKey_F6
        ImGuiKey_F7
        ImGuiKey_F8
        ImGuiKey_F9
        ImGuiKey_F10
        ImGuiKey_F11
        ImGuiKey_F12
        ImGuiKey_Apostrophe              # '
        ImGuiKey_Comma                   # ,
        ImGuiKey_Minus                   # -
        ImGuiKey_Period                  # .
        ImGuiKey_Slash                   # 
        ImGuiKey_Semicolon               # ;
        ImGuiKey_Equal                   # =
        ImGuiKey_LeftBracket             # [
        ImGuiKey_Backslash               # \ (this text inhibit multiline comment caused by backslash)
        ImGuiKey_RightBracket            # ]
        ImGuiKey_GraveAccent             # `
        ImGuiKey_CapsLock
        ImGuiKey_ScrollLock
        ImGuiKey_NumLock
        ImGuiKey_PrintScreen
        ImGuiKey_Pause
        ImGuiKey_Keypad0
        ImGuiKey_Keypad1
        ImGuiKey_Keypad2
        ImGuiKey_Keypad3
        ImGuiKey_Keypad4
        ImGuiKey_Keypad5
        ImGuiKey_Keypad6
        ImGuiKey_Keypad7
        ImGuiKey_Keypad8
        ImGuiKey_Keypad9
        ImGuiKey_KeypadDecimal
        ImGuiKey_KeypadDivide
        ImGuiKey_KeypadMultiply
        ImGuiKey_KeypadSubtract
        ImGuiKey_KeypadAdd
        ImGuiKey_KeypadEnter
        ImGuiKey_KeypadEqual
        ImGuiKey_GamepadStart            # Menu (Xbox)      + (Switch)   Start/Options (PS)
        ImGuiKey_GamepadBack             # View (Xbox)      - (Switch)   Share (PS)
        ImGuiKey_GamepadFaceLeft         # X (Xbox)         Y (Switch)   Square (PS)        // Tap: Toggle Menu. Hold: Windowing mode (Focus/Move/Resize windows)
        ImGuiKey_GamepadFaceRight        # B (Xbox)         A (Switch)   Circle (PS)        // Cancel / Close / Exit
        ImGuiKey_GamepadFaceUp           # Y (Xbox)         X (Switch)   Triangle (PS)      // Text Input / On-screen Keyboard
        ImGuiKey_GamepadFaceDown         # A (Xbox)         B (Switch)   Cross (PS)         // Activate / Open / Toggle / Tweak
        ImGuiKey_GamepadDpadLeft         # D-pad Left                                       // Move / Tweak / Resize Window (in Windowing mode)
        ImGuiKey_GamepadDpadRight        # D-pad Right                                      // Move / Tweak / Resize Window (in Windowing mode)
        ImGuiKey_GamepadDpadUp           # D-pad Up                                         // Move / Tweak / Resize Window (in Windowing mode)
        ImGuiKey_GamepadDpadDown         # D-pad Down                                       // Move / Tweak / Resize Window (in Windowing mode)
        ImGuiKey_GamepadL1               # L Bumper (Xbox)  L (Switch)   L1 (PS)            // Tweak Slower / Focus Previous (in Windowing mode)
        ImGuiKey_GamepadR1               # R Bumper (Xbox)  R (Switch)   R1 (PS)            // Tweak Faster / Focus Next (in Windowing mode)
        ImGuiKey_GamepadL2               # L Trig. (Xbox)   ZL (Switch)  L2 (PS) [Analog]
        ImGuiKey_GamepadR2               # R Trig. (Xbox)   ZR (Switch)  R2 (PS) [Analog]
        ImGuiKey_GamepadL3               # L Stick (Xbox)   L3 (Switch)  L3 (PS)
        ImGuiKey_GamepadR3               # R Stick (Xbox)   R3 (Switch)  R3 (PS)
        ImGuiKey_GamepadLStickLeft       # [Analog]                                         // Move Window (in Windowing mode)
        ImGuiKey_GamepadLStickRight      # [Analog]                                         // Move Window (in Windowing mode)
        ImGuiKey_GamepadLStickUp         # [Analog]                                         // Move Window (in Windowing mode)
        ImGuiKey_GamepadLStickDown       # [Analog]                                         // Move Window (in Windowing mode)
        ImGuiKey_GamepadRStickLeft       # [Analog]
        ImGuiKey_GamepadRStickRight      # [Analog]
        ImGuiKey_GamepadRStickUp         # [Analog]
        ImGuiKey_GamepadRStickDown       # [Analog]
        ImGuiKey_MouseLeft
        ImGuiKey_MouseRight
        ImGuiKey_MouseMiddle
        ImGuiKey_MouseX1
        ImGuiKey_MouseX2
        ImGuiKey_MouseWheelX
        ImGuiKey_MouseWheelY
        ImGuiKey_ReservedForModCtrl
        ImGuiKey_ReservedForModShift
        ImGuiKey_ReservedForModAlt
        ImGuiKey_ReservedForModSuper
        ImGuiKey_COUNT
        ImGuiMod_None
        ImGuiMod_Ctrl                    # Ctrl
        ImGuiMod_Shift                   # Shift
        ImGuiMod_Alt                     # Option/Menu
        ImGuiMod_Super                   # Cmd/Super/Windows
        ImGuiMod_Shortcut                # Alias for Ctrl (non-macOS) _or_ Super (macOS).
        ImGuiMod_Mask_                   # 5-bits
        ImGuiKey_NamedKey_BEGIN
        ImGuiKey_NamedKey_END
        ImGuiKey_NamedKey_COUNT
        ImGuiKey_KeysData_SIZE           # Size of KeysData[]: only hold named keys
        ImGuiKey_KeysData_OFFSET         # Accesses to io.KeysData[] must use (key - ImGuiKey_KeysData_OFFSET) index.


    """
    Configuration flags stored in io.ConfigFlags. Set by user/application.
    """
    ctypedef enum ImGuiConfigFlags_:
        ImGuiConfigFlags_None
        ImGuiConfigFlags_NavEnableKeyboard           # Master keyboard navigation enable flag. Enable full Tabbing + directional arrows + space/enter to activate.
        ImGuiConfigFlags_NavEnableGamepad            # Master gamepad navigation enable flag. Backend also needs to set ImGuiBackendFlags_HasGamepad.
        ImGuiConfigFlags_NavEnableSetMousePos        # Instruct navigation to move the mouse cursor. May be useful on TV/console systems where moving a virtual mouse is awkward. Will update io.MousePos and set io.WantSetMousePos=true. If enabled you MUST honor io.WantSetMousePos requests in your backend, otherwise ImGui will react as if the mouse is jumping around back and forth.
        ImGuiConfigFlags_NavNoCaptureKeyboard        # Instruct navigation to not set the io.WantCaptureKeyboard flag when io.NavActive is set.
        ImGuiConfigFlags_NoMouse                     # Instruct imgui to clear mouse position/buttons in NewFrame(). This allows ignoring the mouse information set by the backend.
        ImGuiConfigFlags_NoMouseCursorChange         # Instruct backend to not alter mouse cursor shape and visibility. Use if the backend cursor changes are interfering with yours and you don't want to use SetMouseCursor() to change mouse cursor. You may want to honor requests from imgui by reading GetMouseCursor() yourself instead.
        ImGuiConfigFlags_DockingEnable               # Docking enable flags.
        ImGuiConfigFlags_ViewportsEnable             # Viewport enable flags (require both ImGuiBackendFlags_PlatformHasViewports + ImGuiBackendFlags_RendererHasViewports set by the respective backends)
        ImGuiConfigFlags_DpiEnableScaleViewports     # [BETA: Don't use] FIXME-DPI: Reposition and resize imgui windows when the DpiScale of a viewport changed (mostly useful for the main viewport hosting other window). Note that resizing the main window itself is up to your application.
        ImGuiConfigFlags_DpiEnableScaleFonts         # [BETA: Don't use] FIXME-DPI: Request bitmap-scaled fonts to match DpiScale. This is a very low-quality workaround. The correct way to handle DPI is _currently_ to replace the atlas and/or fonts in the Platform_OnChangedViewport callback, but this is all early work in progress.
        ImGuiConfigFlags_IsSRGB                      # Application is SRGB-aware.
        ImGuiConfigFlags_IsTouchScreen               # Application is using a touch screen instead of a mouse.


    """
    Backend capabilities flags stored in io.BackendFlags. Set by imgui_impl_xxx or custom backend.
    """
    ctypedef enum ImGuiBackendFlags_:
        ImGuiBackendFlags_None
        ImGuiBackendFlags_HasGamepad                  # Backend Platform supports gamepad and currently has one connected.
        ImGuiBackendFlags_HasMouseCursors             # Backend Platform supports honoring GetMouseCursor() value to change the OS cursor shape.
        ImGuiBackendFlags_HasSetMousePos              # Backend Platform supports io.WantSetMousePos requests to reposition the OS mouse position (only used if ImGuiConfigFlags_NavEnableSetMousePos is set).
        ImGuiBackendFlags_RendererHasVtxOffset        # Backend Renderer supports ImDrawCmd::VtxOffset. This enables output of large meshes (64K+ vertices) while still using 16-bit indices.
        ImGuiBackendFlags_PlatformHasViewports        # Backend Platform supports multiple viewports.
        ImGuiBackendFlags_HasMouseHoveredViewport     # Backend Platform supports calling io.AddMouseViewportEvent() with the viewport under the mouse. IF POSSIBLE, ignore viewports with the ImGuiViewportFlags_NoInputs flag (Win32 backend, GLFW 3.30+ backend can do this, SDL backend cannot). If this cannot be done, Dear ImGui needs to use a flawed heuristic to find the viewport under.
        ImGuiBackendFlags_RendererHasViewports        # Backend Renderer supports multiple viewports.


    """
    Enumeration for PushStyleColor() / PopStyleColor()
    """
    ctypedef enum ImGuiCol_:
        ImGuiCol_Text
        ImGuiCol_TextDisabled
        ImGuiCol_WindowBg                  # Background of normal windows
        ImGuiCol_ChildBg                   # Background of child windows
        ImGuiCol_PopupBg                   # Background of popups, menus, tooltips windows
        ImGuiCol_Border
        ImGuiCol_BorderShadow
        ImGuiCol_FrameBg                   # Background of checkbox, radio button, plot, slider, text input
        ImGuiCol_FrameBgHovered
        ImGuiCol_FrameBgActive
        ImGuiCol_TitleBg
        ImGuiCol_TitleBgActive
        ImGuiCol_TitleBgCollapsed
        ImGuiCol_MenuBarBg
        ImGuiCol_ScrollbarBg
        ImGuiCol_ScrollbarGrab
        ImGuiCol_ScrollbarGrabHovered
        ImGuiCol_ScrollbarGrabActive
        ImGuiCol_CheckMark
        ImGuiCol_SliderGrab
        ImGuiCol_SliderGrabActive
        ImGuiCol_Button
        ImGuiCol_ButtonHovered
        ImGuiCol_ButtonActive
        ImGuiCol_Header                    # Header* colors are used for CollapsingHeader, TreeNode, Selectable, MenuItem
        ImGuiCol_HeaderHovered
        ImGuiCol_HeaderActive
        ImGuiCol_Separator
        ImGuiCol_SeparatorHovered
        ImGuiCol_SeparatorActive
        ImGuiCol_ResizeGrip                # Resize grip in lower-right and lower-left corners of windows.
        ImGuiCol_ResizeGripHovered
        ImGuiCol_ResizeGripActive
        ImGuiCol_Tab                       # TabItem in a TabBar
        ImGuiCol_TabHovered
        ImGuiCol_TabActive
        ImGuiCol_TabUnfocused
        ImGuiCol_TabUnfocusedActive
        ImGuiCol_DockingPreview            # Preview overlay color when about to docking something
        ImGuiCol_DockingEmptyBg            # Background color for empty node (e.g. CentralNode with no window docked into it)
        ImGuiCol_PlotLines
        ImGuiCol_PlotLinesHovered
        ImGuiCol_PlotHistogram
        ImGuiCol_PlotHistogramHovered
        ImGuiCol_TableHeaderBg             # Table header background
        ImGuiCol_TableBorderStrong         # Table outer and header borders (prefer using Alpha=1.0 here)
        ImGuiCol_TableBorderLight          # Table inner borders (prefer using Alpha=1.0 here)
        ImGuiCol_TableRowBg                # Table row background (even rows)
        ImGuiCol_TableRowBgAlt             # Table row background (odd rows)
        ImGuiCol_TextSelectedBg
        ImGuiCol_DragDropTarget            # Rectangle highlighting a drop target
        ImGuiCol_NavHighlight              # Gamepad/keyboard: current highlighted item
        ImGuiCol_NavWindowingHighlight     # Highlight window when using CTRL+TAB
        ImGuiCol_NavWindowingDimBg         # Darken/colorize entire screen behind the CTRL+TAB window list, when active
        ImGuiCol_ModalWindowDimBg          # Darken/colorize entire screen behind a modal window, when one is active
        ImGuiCol_COUNT


    """
    Enumeration for PushStyleVar() / PopStyleVar() to temporarily modify the ImGuiStyle structure.
    - The enum only refers to fields of ImGuiStyle which makes sense to be pushed/popped inside UI code.
    During initialization or between frames, feel free to just poke into ImGuiStyle directly.
    - Tip: Use your programming IDE navigation facilities on the names in the _second column_ below to find the actual members and their description.
    In Visual Studio IDE: CTRL+comma ("Edit.GoToAll") can follow symbols in comments, whereas CTRL+F12 ("Edit.GoToImplementation") cannot.
    With Visual Assist installed: ALT+G ("VAssistX.GoToImplementation") can also follow symbols in comments.
    - When changing this enum, you need to update the associated internal table GStyleVarInfo[] accordingly. This is where we link enum values to members offset/type.
    """
    ctypedef enum ImGuiStyleVar_:
        ImGuiStyleVar_Alpha                       # float     Alpha
        ImGuiStyleVar_DisabledAlpha               # float     DisabledAlpha
        ImGuiStyleVar_WindowPadding               # ImVec2    WindowPadding
        ImGuiStyleVar_WindowRounding              # float     WindowRounding
        ImGuiStyleVar_WindowBorderSize            # float     WindowBorderSize
        ImGuiStyleVar_WindowMinSize               # ImVec2    WindowMinSize
        ImGuiStyleVar_WindowTitleAlign            # ImVec2    WindowTitleAlign
        ImGuiStyleVar_ChildRounding               # float     ChildRounding
        ImGuiStyleVar_ChildBorderSize             # float     ChildBorderSize
        ImGuiStyleVar_PopupRounding               # float     PopupRounding
        ImGuiStyleVar_PopupBorderSize             # float     PopupBorderSize
        ImGuiStyleVar_FramePadding                # ImVec2    FramePadding
        ImGuiStyleVar_FrameRounding               # float     FrameRounding
        ImGuiStyleVar_FrameBorderSize             # float     FrameBorderSize
        ImGuiStyleVar_ItemSpacing                 # ImVec2    ItemSpacing
        ImGuiStyleVar_ItemInnerSpacing            # ImVec2    ItemInnerSpacing
        ImGuiStyleVar_IndentSpacing               # float     IndentSpacing
        ImGuiStyleVar_CellPadding                 # ImVec2    CellPadding
        ImGuiStyleVar_ScrollbarSize               # float     ScrollbarSize
        ImGuiStyleVar_ScrollbarRounding           # float     ScrollbarRounding
        ImGuiStyleVar_GrabMinSize                 # float     GrabMinSize
        ImGuiStyleVar_GrabRounding                # float     GrabRounding
        ImGuiStyleVar_TabRounding                 # float     TabRounding
        ImGuiStyleVar_ButtonTextAlign             # ImVec2    ButtonTextAlign
        ImGuiStyleVar_SelectableTextAlign         # ImVec2    SelectableTextAlign
        ImGuiStyleVar_SeparatorTextBorderSize     # float  SeparatorTextBorderSize
        ImGuiStyleVar_SeparatorTextAlign          # ImVec2    SeparatorTextAlign
        ImGuiStyleVar_SeparatorTextPadding        # ImVec2    SeparatorTextPadding
        ImGuiStyleVar_COUNT


    """
    Flags for InvisibleButton() [extended in imgui_internal.h]
    """
    ctypedef enum ImGuiButtonFlags_:
        ImGuiButtonFlags_None
        ImGuiButtonFlags_MouseButtonLeft         # React on left mouse button (default)
        ImGuiButtonFlags_MouseButtonRight        # React on right mouse button
        ImGuiButtonFlags_MouseButtonMiddle       # React on center mouse button
        ImGuiButtonFlags_MouseButtonMask_
        ImGuiButtonFlags_MouseButtonDefault_


    """
    Flags for ColorEdit3() / ColorEdit4() / ColorPicker3() / ColorPicker4() / ColorButton()
    """
    ctypedef enum ImGuiColorEditFlags_:
        ImGuiColorEditFlags_None
        ImGuiColorEditFlags_NoAlpha              # ColorEdit, ColorPicker, ColorButton: ignore Alpha component (will only read 3 components from the input pointer).
        ImGuiColorEditFlags_NoPicker             # ColorEdit: disable picker when clicking on color square.
        ImGuiColorEditFlags_NoOptions            # ColorEdit: disable toggling options menu when right-clicking on inputs/small preview.
        ImGuiColorEditFlags_NoSmallPreview       # ColorEdit, ColorPicker: disable color square preview next to the inputs. (e.g. to show only the inputs)
        ImGuiColorEditFlags_NoInputs             # ColorEdit, ColorPicker: disable inputs sliders/text widgets (e.g. to show only the small preview color square).
        ImGuiColorEditFlags_NoTooltip            # ColorEdit, ColorPicker, ColorButton: disable tooltip when hovering the preview.
        ImGuiColorEditFlags_NoLabel              # ColorEdit, ColorPicker: disable display of inline text label (the label is still forwarded to the tooltip and picker).
        ImGuiColorEditFlags_NoSidePreview        # ColorPicker: disable bigger color preview on right side of the picker, use small color square preview instead.
        ImGuiColorEditFlags_NoDragDrop           # ColorEdit: disable drag and drop target. ColorButton: disable drag and drop source.
        ImGuiColorEditFlags_NoBorder             # ColorButton: disable border (which is enforced by default)
        ImGuiColorEditFlags_AlphaBar             # ColorEdit, ColorPicker: show vertical alpha bar/gradient in picker.
        ImGuiColorEditFlags_AlphaPreview         # ColorEdit, ColorPicker, ColorButton: display preview as a transparent color over a checkerboard, instead of opaque.
        ImGuiColorEditFlags_AlphaPreviewHalf     # ColorEdit, ColorPicker, ColorButton: display half opaque / half checkerboard, instead of opaque.
        ImGuiColorEditFlags_HDR                  # (WIP) ColorEdit: Currently only disable 0.0f..1.0f limits in RGBA edition (note: you probably want to use ImGuiColorEditFlags_Float flag as well).
        ImGuiColorEditFlags_DisplayRGB           # [Display]    // ColorEdit: override _display_ type among RGB/HSV/Hex. ColorPicker: select any combination using one or more of RGB/HSV/Hex.
        ImGuiColorEditFlags_DisplayHSV           # [Display]    // "
        ImGuiColorEditFlags_DisplayHex           # [Display]    // "
        ImGuiColorEditFlags_Uint8                # [DataType]   // ColorEdit, ColorPicker, ColorButton: _display_ values formatted as 0..255.
        ImGuiColorEditFlags_Float                # [DataType]   // ColorEdit, ColorPicker, ColorButton: _display_ values formatted as 0.0f..1.0f floats instead of 0..255 integers. No round-trip of value via integers.
        ImGuiColorEditFlags_PickerHueBar         # [Picker]     // ColorPicker: bar for Hue, rectangle for Sat/Value.
        ImGuiColorEditFlags_PickerHueWheel       # [Picker]     // ColorPicker: wheel for Hue, triangle for Sat/Value.
        ImGuiColorEditFlags_InputRGB             # [Input]      // ColorEdit, ColorPicker: input and output data in RGB format.
        ImGuiColorEditFlags_InputHSV             # [Input]      // ColorEdit, ColorPicker: input and output data in HSV format.
        ImGuiColorEditFlags_DefaultOptions_
        ImGuiColorEditFlags_DisplayMask_
        ImGuiColorEditFlags_DataTypeMask_
        ImGuiColorEditFlags_PickerMask_
        ImGuiColorEditFlags_InputMask_


    """
    Flags for DragFloat(), DragInt(), SliderFloat(), SliderInt() etc.
    We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
    (Those are per-item flags. There are shared flags in ImGuiIO: io.ConfigDragClickToInputText)
    """
    ctypedef enum ImGuiSliderFlags_:
        ImGuiSliderFlags_None
        ImGuiSliderFlags_AlwaysClamp         # Clamp value to min/max bounds when input manually with CTRL+Click. By default CTRL+Click allows going out of bounds.
        ImGuiSliderFlags_Logarithmic         # Make the widget logarithmic (linear otherwise). Consider using ImGuiSliderFlags_NoRoundToFormat with this if using a format-string with small amount of digits.
        ImGuiSliderFlags_NoRoundToFormat     # Disable rounding underlying value to match precision of the display format string (e.g. %.3f values are rounded to those 3 digits)
        ImGuiSliderFlags_NoInput             # Disable CTRL+Click or Enter key allowing to input text directly into the widget
        ImGuiSliderFlags_InvalidMask_        # [Internal] We treat using those bits as being potentially a 'float power' argument from the previous API that has got miscast to this enum, and will trigger an assert if needed.


    """
    Identify a mouse button.
    Those values are guaranteed to be stable and we frequently use 0/1 directly. Named enums provided for convenience.
    """
    ctypedef enum ImGuiMouseButton_:
        ImGuiMouseButton_Left
        ImGuiMouseButton_Right
        ImGuiMouseButton_Middle
        ImGuiMouseButton_COUNT


    """
    Enumeration for GetMouseCursor()
    User code may request backend to display given cursor by calling SetMouseCursor(), which is why we have some cursors that are marked unused here
    """
    ctypedef enum ImGuiMouseCursor_:
        ImGuiMouseCursor_None
        ImGuiMouseCursor_Arrow
        ImGuiMouseCursor_TextInput      # When hovering over InputText, etc.
        ImGuiMouseCursor_ResizeAll      # (Unused by Dear ImGui functions)
        ImGuiMouseCursor_ResizeNS       # When hovering over a horizontal border
        ImGuiMouseCursor_ResizeEW       # When hovering over a vertical border or a column
        ImGuiMouseCursor_ResizeNESW     # When hovering over the bottom-left corner of a window
        ImGuiMouseCursor_ResizeNWSE     # When hovering over the bottom-right corner of a window
        ImGuiMouseCursor_Hand           # (Unused by Dear ImGui functions. Use for e.g. hyperlinks)
        ImGuiMouseCursor_NotAllowed     # When hovering something with disallowed interaction. Usually a crossed circle.
        ImGuiMouseCursor_COUNT


    """
    Enumeration for ImGui::SetWindow***(), SetNextWindow***(), SetNextItem***() functions
    Represent a condition.
    Important: Treat as a regular enum! Do NOT combine multiple values using binary operators! All the functions above treat 0 as a shortcut to ImGuiCond_Always.
    """
    ctypedef enum ImGuiCond_:
        ImGuiCond_None             # No condition (always set the variable), same as _Always
        ImGuiCond_Always           # No condition (always set the variable), same as _None
        ImGuiCond_Once             # Set the variable once per runtime session (only the first call will succeed)
        ImGuiCond_FirstUseEver     # Set the variable if the object/window has no persistently saved data (no entry in .ini file)
        ImGuiCond_Appearing        # Set the variable if the object/window is appearing after being hidden/inactive (or the first time)


    """
    Flags for ImDrawList functions
    (Legacy: bit 0 must always correspond to ImDrawFlags_Closed to be backward compatible with old API using a bool. Bits 1..3 must be unused)
    """
    ctypedef enum ImDrawFlags_:
        ImDrawFlags_None
        ImDrawFlags_Closed                      # PathStroke(), AddPolyline(): specify that shape should be closed (Important: this is always == 1 for legacy reason)
        ImDrawFlags_RoundCornersTopLeft         # AddRect(), AddRectFilled(), PathRect(): enable rounding top-left corner only (when rounding > 0.0f, we default to all corners). Was 0x01.
        ImDrawFlags_RoundCornersTopRight        # AddRect(), AddRectFilled(), PathRect(): enable rounding top-right corner only (when rounding > 0.0f, we default to all corners). Was 0x02.
        ImDrawFlags_RoundCornersBottomLeft      # AddRect(), AddRectFilled(), PathRect(): enable rounding bottom-left corner only (when rounding > 0.0f, we default to all corners). Was 0x04.
        ImDrawFlags_RoundCornersBottomRight     # AddRect(), AddRectFilled(), PathRect(): enable rounding bottom-right corner only (when rounding > 0.0f, we default to all corners). Wax 0x08.
        ImDrawFlags_RoundCornersNone            # AddRect(), AddRectFilled(), PathRect(): disable rounding on all corners (when rounding > 0.0f). This is NOT zero, NOT an implicit flag!
        ImDrawFlags_RoundCornersTop
        ImDrawFlags_RoundCornersBottom
        ImDrawFlags_RoundCornersLeft
        ImDrawFlags_RoundCornersRight
        ImDrawFlags_RoundCornersAll
        ImDrawFlags_RoundCornersDefault_        # Default to ALL corners if none of the _RoundCornersXX flags are specified.
        ImDrawFlags_RoundCornersMask_


    """
    Flags for ImDrawList instance. Those are set automatically by ImGui:: functions from ImGuiIO settings, and generally not manipulated directly.
    It is however possible to temporarily alter flags between calls to ImDrawList:: functions.
    """
    ctypedef enum ImDrawListFlags_:
        ImDrawListFlags_None
        ImDrawListFlags_AntiAliasedLines           # Enable anti-aliased lines/borders (*2 the number of triangles for 1.0f wide line or lines thin enough to be drawn using textures, otherwise *3 the number of triangles)
        ImDrawListFlags_AntiAliasedLinesUseTex     # Enable anti-aliased lines/borders using textures when possible. Require backend to render with bilinear filtering (NOT point/nearest filtering).
        ImDrawListFlags_AntiAliasedFill            # Enable anti-aliased edge around filled shapes (rounded rectangles, circles).
        ImDrawListFlags_AllowVtxOffset             # Can emit 'VtxOffset > 0' to allow large meshes. Set when 'ImGuiBackendFlags_RendererHasVtxOffset' is enabled.


    """
    Flags for ImFontAtlas build
    """
    ctypedef enum ImFontAtlasFlags_:
        ImFontAtlasFlags_None
        ImFontAtlasFlags_NoPowerOfTwoHeight     # Don't round the height to next power of two
        ImFontAtlasFlags_NoMouseCursors         # Don't build software mouse cursors into the atlas (save a little texture memory)
        ImFontAtlasFlags_NoBakedLines           # Don't build thick line textures into the atlas (save a little texture memory, allow support for point/nearest filtering). The AntiAliasedLinesUseTex features uses them, otherwise they will be rendered using polygons (more expensive for CPU/GPU).


    """
    Flags stored in ImGuiViewport::Flags, giving indications to the platform backends.
    """
    ctypedef enum ImGuiViewportFlags_:
        ImGuiViewportFlags_None
        ImGuiViewportFlags_IsPlatformWindow        # Represent a Platform Window
        ImGuiViewportFlags_IsPlatformMonitor       # Represent a Platform Monitor (unused yet)
        ImGuiViewportFlags_OwnedByApp              # Platform Window: is created/managed by the application (rather than a dear imgui backend)
        ImGuiViewportFlags_NoDecoration            # Platform Window: Disable platform decorations: title bar, borders, etc. (generally set all windows, but if ImGuiConfigFlags_ViewportsDecoration is set we only set this on popups/tooltips)
        ImGuiViewportFlags_NoTaskBarIcon           # Platform Window: Disable platform task bar icon (generally set on popups/tooltips, or all windows if ImGuiConfigFlags_ViewportsNoTaskBarIcon is set)
        ImGuiViewportFlags_NoFocusOnAppearing      # Platform Window: Don't take focus when created.
        ImGuiViewportFlags_NoFocusOnClick          # Platform Window: Don't take focus when clicked on.
        ImGuiViewportFlags_NoInputs                # Platform Window: Make mouse pass through so we can drag this window while peaking behind it.
        ImGuiViewportFlags_NoRendererClear         # Platform Window: Renderer doesn't need to clear the framebuffer ahead (because we will fill it entirely).
        ImGuiViewportFlags_TopMost                 # Platform Window: Display on top (for tooltips only).
        ImGuiViewportFlags_Minimized               # Platform Window: Window is minimized, can skip render. When minimized we tend to avoid using the viewport pos/size for clipping window or testing if they are contained in the viewport.
        ImGuiViewportFlags_NoAutoMerge             # Platform Window: Avoid merging this window into another host window. This can only be set via ImGuiWindowClass viewport flags override (because we need to now ahead if we are going to create a viewport in the first place!).
        ImGuiViewportFlags_CanHostOtherWindows     # Main viewport: can host multiple imgui windows (secondary viewports are associated to a single window).



    """
    Data shared among multiple draw lists (typically owned by parent ImGui context, but you may create one yourself)
    """
    ctypedef struct ImDrawListSharedData:
        pass


    """
    Opaque interface to a font builder (stb_truetype or FreeType).
    """
    ctypedef struct ImFontBuilderIO:
        pass


    """
    Dear ImGui context (opaque structure, unless including imgui_internal.h)
    """
    ctypedef struct ImGuiContext:
        pass

    ctypedef struct ImVec2:
        float x
        float y


    """
    ImVec4: 4D vector used to store clipping rectangles, colors etc. [Compile-time configurable type]
    """
    ctypedef struct ImVec4:
        float x
        float y
        float z
        float w

    ctypedef struct ImVector_ImWchar:
        int Size
        int Capacity
        ImWchar* Data

    ctypedef struct ImVector_ImGuiTextFilter_ImGuiTextRange:
        int Size
        int Capacity
        ImGuiTextFilter_ImGuiTextRange* Data

    ctypedef struct ImVector_char:
        int Size
        int Capacity
        char* Data

    ctypedef struct ImVector_ImGuiStorage_ImGuiStoragePair:
        int Size
        int Capacity
        ImGuiStorage_ImGuiStoragePair* Data

    ctypedef struct ImVector_ImDrawCmd:
        int Size
        int Capacity
        ImDrawCmd* Data

    ctypedef struct ImVector_ImDrawIdx:
        int Size
        int Capacity
        ImDrawIdx* Data

    ctypedef struct ImVector_ImDrawChannel:
        int Size
        int Capacity
        ImDrawChannel* Data

    ctypedef struct ImVector_ImDrawVert:
        int Size
        int Capacity
        ImDrawVert* Data

    ctypedef struct ImVector_ImVec4:
        int Size
        int Capacity
        ImVec4* Data

    ctypedef struct ImVector_ImTextureID:
        int Size
        int Capacity
        ImTextureID* Data

    ctypedef struct ImVector_ImVec2:
        int Size
        int Capacity
        ImVec2* Data

    ctypedef struct ImVector_ImU32:
        int Size
        int Capacity
        ImU32* Data

    ctypedef struct ImVector_ImFontPtr:
        int Size
        int Capacity
        ImFont** Data

    ctypedef struct ImVector_ImFontAtlasCustomRect:
        int Size
        int Capacity
        ImFontAtlasCustomRect* Data

    ctypedef struct ImVector_ImFontConfig:
        int Size
        int Capacity
        ImFontConfig* Data

    ctypedef struct ImVector_float:
        int Size
        int Capacity
        float* Data

    ctypedef struct ImVector_ImFontGlyph:
        int Size
        int Capacity
        ImFontGlyph* Data

    ctypedef struct ImVector_ImGuiPlatformMonitor:
        int Size
        int Capacity
        ImGuiPlatformMonitor* Data

    ctypedef struct ImVector_ImGuiViewportPtr:
        int Size
        int Capacity
        ImGuiViewport** Data

    ctypedef struct ImGuiStyle:
        float Alpha                           # Global alpha applies to everything in Dear ImGui.
        float DisabledAlpha                   # Additional alpha multiplier applied by BeginDisabled(). Multiply over current value of Alpha.
        ImVec2 WindowPadding                  # Padding within a window.
        float WindowRounding                  # Radius of window corners rounding. Set to 0.0f to have rectangular windows. Large values tend to lead to variety of artifacts and are not recommended.
        float WindowBorderSize                # Thickness of border around windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
        ImVec2 WindowMinSize                  # Minimum window size. This is a global setting. If you want to constrain individual windows, use SetNextWindowSizeConstraints().
        ImVec2 WindowTitleAlign               # Alignment for title bar text. Defaults to (0.0f,0.5f) for left-aligned,vertically centered.
        ImGuiDir WindowMenuButtonPosition     # Side of the collapsing/docking button in the title bar (None/Left/Right). Defaults to ImGuiDir_Left.
        float ChildRounding                   # Radius of child window corners rounding. Set to 0.0f to have rectangular windows.
        float ChildBorderSize                 # Thickness of border around child windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
        float PopupRounding                   # Radius of popup window corners rounding. (Note that tooltip windows use WindowRounding)
        float PopupBorderSize                 # Thickness of border around popup/tooltip windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
        ImVec2 FramePadding                   # Padding within a framed rectangle (used by most widgets).
        float FrameRounding                   # Radius of frame corners rounding. Set to 0.0f to have rectangular frame (used by most widgets).
        float FrameBorderSize                 # Thickness of border around frames. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
        ImVec2 ItemSpacing                    # Horizontal and vertical spacing between widgets/lines.
        ImVec2 ItemInnerSpacing               # Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label).
        ImVec2 CellPadding                    # Padding within a table cell
        ImVec2 TouchExtraPadding              # Expand reactive bounding box for touch-based system where touch position is not accurate enough. Unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. So don't grow this too much!
        float IndentSpacing                   # Horizontal indentation when e.g. entering a tree node. Generally == (FontSize + FramePadding.x*2).
        float ColumnsMinSpacing               # Minimum horizontal spacing between two columns. Preferably > (FramePadding.x + 1).
        float ScrollbarSize                   # Width of the vertical scrollbar, Height of the horizontal scrollbar.
        float ScrollbarRounding               # Radius of grab corners for scrollbar.
        float GrabMinSize                     # Minimum width/height of a grab box for slider/scrollbar.
        float GrabRounding                    # Radius of grabs corners rounding. Set to 0.0f to have rectangular slider grabs.
        float LogSliderDeadzone               # The size in pixels of the dead-zone around zero on logarithmic sliders that cross zero.
        float TabRounding                     # Radius of upper corners of a tab. Set to 0.0f to have rectangular tabs.
        float TabBorderSize                   # Thickness of border around tabs.
        float TabMinWidthForCloseButton       # Minimum width for close button to appear on an unselected tab when hovered. Set to 0.0f to always show when hovering, set to FLT_MAX to never show close button unless selected.
        ImGuiDir ColorButtonPosition          # Side of the color button in the ColorEdit4 widget (left/right). Defaults to ImGuiDir_Right.
        ImVec2 ButtonTextAlign                # Alignment of button text when button is larger than text. Defaults to (0.5f, 0.5f) (centered).
        ImVec2 SelectableTextAlign            # Alignment of selectable text. Defaults to (0.0f, 0.0f) (top-left aligned). It's generally important to keep this left-aligned if you want to lay multiple items on a same line.
        float SeparatorTextBorderSize         # Thickkness of border in SeparatorText()
        ImVec2 SeparatorTextAlign             # Alignment of text within the separator. Defaults to (0.0f, 0.5f) (left aligned, center).
        ImVec2 SeparatorTextPadding           # Horizontal offset of text from each edge of the separator + spacing on other axis. Generally small values. .y is recommended to be == FramePadding.y.
        ImVec2 DisplayWindowPadding           # Window position are clamped to be visible within the display area or monitors by at least this amount. Only applies to regular windows.
        ImVec2 DisplaySafeAreaPadding         # If you cannot see the edges of your screen (e.g. on a TV) increase the safe area padding. Apply to popups/tooltips as well regular windows. NB: Prefer configuring your TV sets correctly!
        float MouseCursorScale                # Scale software rendered mouse cursor (when io.MouseDrawCursor is enabled). We apply per-monitor DPI scaling over this scale. May be removed later.
        bool AntiAliasedLines                 # Enable anti-aliased lines/borders. Disable if you are really tight on CPU/GPU. Latched at the beginning of the frame (copied to ImDrawList).
        bool AntiAliasedLinesUseTex           # Enable anti-aliased lines/borders using textures where possible. Require backend to render with bilinear filtering (NOT point/nearest filtering). Latched at the beginning of the frame (copied to ImDrawList).
        bool AntiAliasedFill                  # Enable anti-aliased edges around filled shapes (rounded rectangles, circles, etc.). Disable if you are really tight on CPU/GPU. Latched at the beginning of the frame (copied to ImDrawList).
        float CurveTessellationTol            # Tessellation tolerance when using PathBezierCurveTo() without a specific number of segments. Decrease for highly tessellated curves (higher quality, more polygons), increase to reduce quality.
        float CircleTessellationMaxError      # Maximum error (in pixels) allowed when using AddCircle()/AddCircleFilled() or drawing rounded corner rectangles with no explicit segment count specified. Decrease for higher quality but more geometry.
        ImVec4 Colors


    """
    [Internal] Storage used by IsKeyDown(), IsKeyPressed() etc functions.
    If prior to 1.87 you used io.KeysDownDuration[] (which was marked as internal), you should use GetKeyData(key)->DownDuration and *NOT* io.KeysData[key]->DownDuration.
    """
    ctypedef struct ImGuiKeyData:
        bool Down                  # True for if key is down
        float DownDuration         # Duration the key has been down (<0.0f: not pressed, 0.0f: just pressed, >0.0f: time held)
        float DownDurationPrev     # Last frame duration the key has been down
        float AnalogValue          # 0.0f..1.0f for gamepad values

    ctypedef struct ImGuiIO:
        ImGuiConfigFlags ConfigFlags                                                                               # = 0              // See ImGuiConfigFlags_ enum. Set by user/application. Gamepad/keyboard navigation options, etc.
        ImGuiBackendFlags BackendFlags                                                                             # = 0              // See ImGuiBackendFlags_ enum. Set by backend (imgui_impl_xxx files or custom backend) to communicate features supported by the backend.
        ImVec2 DisplaySize                                                                                         # <unset>          // Main display size, in pixels (generally == GetMainViewport()->Size). May change every frame.
        float DeltaTime                                                                                            # = 1.0f/60.0f     // Time elapsed since last frame, in seconds. May change every frame.
        float IniSavingRate                                                                                        # = 5.0f           // Minimum time between saving positions/sizes to .ini file, in seconds.
        const char* IniFilename                                                                                    # = "imgui.ini"    // Path to .ini file (important: default "imgui.ini" is relative to current working dir!). Set NULL to disable automatic .ini loading/saving or if you want to manually call LoadIniSettingsXXX() / SaveIniSettingsXXX() functions.
        const char* LogFilename                                                                                    # = "imgui_log.txt"// Path to .log file (default parameter to ImGui::LogToFile when no file is specified).
        float MouseDoubleClickTime                                                                                 # = 0.30f          // Time for a double-click, in seconds.
        float MouseDoubleClickMaxDist                                                                              # = 6.0f           // Distance threshold to stay in to validate a double-click, in pixels.
        float MouseDragThreshold                                                                                   # = 6.0f           // Distance threshold before considering we are dragging.
        float KeyRepeatDelay                                                                                       # = 0.275f         // When holding a key/button, time before it starts repeating, in seconds (for buttons in Repeat mode, etc.).
        float KeyRepeatRate                                                                                        # = 0.050f         // When holding a key/button, rate at which it repeats, in seconds.
        float HoverDelayNormal                                                                                     # = 0.30 sec       // Delay on hovering before IsItemHovered(ImGuiHoveredFlags_DelayNormal) returns true.
        float HoverDelayShort                                                                                      # = 0.10 sec       // Delay on hovering before IsItemHovered(ImGuiHoveredFlags_DelayShort) returns true.
        void* UserData                                                                                             # = NULL           // Store your own data.
        ImFontAtlas* Fonts                                                                                         # <auto>           // Font atlas: load, rasterize and pack one or more fonts into a single texture.
        float FontGlobalScale                                                                                      # = 1.0f           // Global scale all fonts
        bool FontAllowUserScaling                                                                                  # = false          // Allow user scaling text of individual window with CTRL+Wheel.
        ImFont* FontDefault                                                                                        # = NULL           // Font to use on NewFrame(). Use NULL to uses Fonts->Fonts[0].
        ImVec2 DisplayFramebufferScale                                                                             # = (1, 1)         // For retina display or other situations where window coordinates are different from framebuffer coordinates. This generally ends up in ImDrawData::FramebufferScale.
        bool ConfigDockingNoSplit                                                                                  # = false          // Simplified docking mode: disable window splitting, so docking is limited to merging multiple windows together into tab-bars.
        bool ConfigDockingWithShift                                                                                # = false          // Enable docking with holding Shift key (reduce visual noise, allows dropping in wider space)
        bool ConfigDockingAlwaysTabBar                                                                             # = false          // [BETA] [FIXME: This currently creates regression with auto-sizing and general overhead] Make every single floating window display within a docking node.
        bool ConfigDockingTransparentPayload                                                                       # = false          // [BETA] Make window or viewport transparent when docking and only display docking boxes on the target viewport. Useful if rendering of multiple viewport cannot be synced. Best used with ConfigViewportsNoAutoMerge.
        bool ConfigViewportsNoAutoMerge                                                                            # = false;         // Set to make all floating imgui windows always create their own viewport. Otherwise, they are merged into the main host viewports when overlapping it. May also set ImGuiViewportFlags_NoAutoMerge on individual viewport.
        bool ConfigViewportsNoTaskBarIcon                                                                          # = false          // Disable default OS task bar icon flag for secondary viewports. When a viewport doesn't want a task bar icon, ImGuiViewportFlags_NoTaskBarIcon will be set on it.
        bool ConfigViewportsNoDecoration                                                                           # = true           // Disable default OS window decoration flag for secondary viewports. When a viewport doesn't want window decorations, ImGuiViewportFlags_NoDecoration will be set on it. Enabling decoration can create subsequent issues at OS levels (e.g. minimum window size).
        bool ConfigViewportsNoDefaultParent                                                                        # = false          // Disable default OS parenting to main viewport for secondary viewports. By default, viewports are marked with ParentViewportId = <main_viewport>, expecting the platform backend to setup a parent/child relationship between the OS windows (some backend may ignore this). Set to true if you want the default to be 0, then all viewports will be top-level OS windows.
        bool MouseDrawCursor                                                                                       # = false          // Request ImGui to draw a mouse cursor for you (if you are on a platform without a mouse cursor). Cannot be easily renamed to 'io.ConfigXXX' because this is frequently used by backend implementations.
        bool ConfigMacOSXBehaviors                                                                                 # = defined(__APPLE__) // OS X style: Text editing cursor movement using Alt instead of Ctrl, Shortcuts using Cmd/Super instead of Ctrl, Line/Text Start and End using Cmd+Arrows instead of Home/End, Double click selects by word instead of selecting whole text, Multi-selection in lists uses Cmd/Super instead of Ctrl.
        bool ConfigInputTrickleEventQueue                                                                          # = true           // Enable input queue trickling: some types of events submitted during the same frame (e.g. button down + up) will be spread over multiple frames, improving interactions with low framerates.
        bool ConfigInputTextCursorBlink                                                                            # = true           // Enable blinking cursor (optional as some users consider it to be distracting).
        bool ConfigInputTextEnterKeepActive                                                                        # = false          // [BETA] Pressing Enter will keep item active and select contents (single-line only).
        bool ConfigDragClickToInputText                                                                            # = false          // [BETA] Enable turning DragXXX widgets into text input with a simple mouse click-release (without moving). Not desirable on devices without a keyboard.
        bool ConfigWindowsResizeFromEdges                                                                          # = true           // Enable resizing of windows from their edges and from the lower-left corner. This requires (io.BackendFlags & ImGuiBackendFlags_HasMouseCursors) because it needs mouse cursor feedback. (This used to be a per-window ImGuiWindowFlags_ResizeFromAnySide flag)
        bool ConfigWindowsMoveFromTitleBarOnly                                                                     # = false       // Enable allowing to move windows only when clicking on their title bar. Does not apply to windows without a title bar.
        float ConfigMemoryCompactTimer                                                                             # = 60.0f          // Timer (in seconds) to free transient windows/tables memory buffers when unused. Set to -1.0f to disable.
        bool ConfigDebugBeginReturnValueOnce                                                                       # = false         // First-time calls to Begin()/BeginChild() will return false. NEEDS TO BE SET AT APPLICATION BOOT TIME if you don't want to miss windows.
        bool ConfigDebugBeginReturnValueLoop                                                                       # = false         // Some calls to Begin()/BeginChild() will return false. Will cycle through window depths then repeat. Suggested use: add "io.ConfigDebugBeginReturnValue = io.KeyShift" in your main loop then occasionally press SHIFT. Windows should be flickering while running.
        const char* BackendPlatformName                                                                            # = NULL
        const char* BackendRendererName                                                                            # = NULL
        void* BackendPlatformUserData                                                                              # = NULL           // User data for platform backend
        void* BackendRendererUserData                                                                              # = NULL           // User data for renderer backend
        void* BackendLanguageUserData                                                                              # = NULL           // User data for non C++ programming language backend
        const char* (*GetClipboardTextFn)(void* user_data)
        void (*SetClipboardTextFn)(void* user_data, const char* text)
        void* ClipboardUserData
        void (*SetPlatformImeDataFn)(ImGuiViewport* viewport, ImGuiPlatformImeData* data)
        bool WantCaptureMouse                                                                                      # Set when Dear ImGui will use mouse inputs, in this case do not dispatch them to your main game/application (either way, always pass on mouse inputs to imgui). (e.g. unclicked mouse is hovering over an imgui window, widget is active, mouse was clicked over an imgui window, etc.).
        bool WantCaptureKeyboard                                                                                   # Set when Dear ImGui will use keyboard inputs, in this case do not dispatch them to your main game/application (either way, always pass keyboard inputs to imgui). (e.g. InputText active, or an imgui window is focused and navigation is enabled, etc.).
        bool WantTextInput                                                                                         # Mobile/console: when set, you may display an on-screen keyboard. This is set by Dear ImGui when it wants textual keyboard input to happen (e.g. when a InputText widget is active).
        bool WantSetMousePos                                                                                       # MousePos has been altered, backend should reposition mouse on next frame. Rarely used! Set only when ImGuiConfigFlags_NavEnableSetMousePos flag is enabled.
        bool WantSaveIniSettings                                                                                   # When manual .ini load/save is active (io.IniFilename == NULL), this will be set to notify your application that you can call SaveIniSettingsToMemory() and save yourself. Important: clear io.WantSaveIniSettings yourself after saving!
        bool NavActive                                                                                             # Keyboard/Gamepad navigation is currently allowed (will handle ImGuiKey_NavXXX events) = a window is focused and it doesn't use the ImGuiWindowFlags_NoNavInputs flag.
        bool NavVisible                                                                                            # Keyboard/Gamepad navigation is visible and allowed (will handle ImGuiKey_NavXXX events).
        float Framerate                                                                                            # Estimate of application framerate (rolling average over 60 frames, based on io.DeltaTime), in frame per second. Solely for convenience. Slow applications may not want to use a moving average or may want to reset underlying buffers occasionally.
        int MetricsRenderVertices                                                                                  # Vertices output during last call to Render()
        int MetricsRenderIndices                                                                                   # Indices output during last call to Render() = number of triangles * 3
        int MetricsRenderWindows                                                                                   # Number of visible windows
        int MetricsActiveWindows                                                                                   # Number of active windows
        int MetricsActiveAllocations                                                                               # Number of active allocations, updated by MemAlloc/MemFree based on current context. May be off if you have multiple imgui contexts.
        ImVec2 MouseDelta                                                                                          # Mouse delta. Note that this is zero if either current or previous position are invalid (-FLT_MAX,-FLT_MAX), so a disappearing/reappearing mouse won't have a huge delta.
        ImGuiContext* Ctx                                                                                          # Parent UI context (needs to be set explicitly by parent).
        ImVec2 MousePos                                                                                            # Mouse position, in pixels. Set to ImVec2(-FLT_MAX, -FLT_MAX) if mouse is unavailable (on another screen, etc.)
        bool MouseDown                                                                                             # Mouse buttons: 0=left, 1=right, 2=middle + extras (ImGuiMouseButton_COUNT == 5). Dear ImGui mostly uses left and right buttons. Other buttons allow us to track if the mouse is being used by your application + available to user as a convenience via IsMouse** API.
        float MouseWheel                                                                                           # Mouse wheel Vertical: 1 unit scrolls about 5 lines text. >0 scrolls Up, <0 scrolls Down. Hold SHIFT to turn vertical scroll into horizontal scroll.
        float MouseWheelH                                                                                          # Mouse wheel Horizontal. >0 scrolls Left, <0 scrolls Right. Most users don't have a mouse with a horizontal wheel, may not be filled by all backends.
        ImGuiID MouseHoveredViewport                                                                               # (Optional) Modify using io.AddMouseViewportEvent(). With multi-viewports: viewport the OS mouse is hovering. If possible _IGNORING_ viewports with the ImGuiViewportFlags_NoInputs flag is much better (few backends can handle that). Set io.BackendFlags |= ImGuiBackendFlags_HasMouseHoveredViewport if you can provide this info. If you don't imgui will infer the value using the rectangles and last focused time of the viewports it knows about (ignoring other OS windows).
        bool KeyCtrl                                                                                               # Keyboard modifier down: Control
        bool KeyShift                                                                                              # Keyboard modifier down: Shift
        bool KeyAlt                                                                                                # Keyboard modifier down: Alt
        bool KeySuper                                                                                              # Keyboard modifier down: Cmd/Super/Windows
        ImGuiKeyChord KeyMods                                                                                      # Key mods flags (any of ImGuiMod_Ctrl/ImGuiMod_Shift/ImGuiMod_Alt/ImGuiMod_Super flags, same as io.KeyCtrl/KeyShift/KeyAlt/KeySuper but merged into flags. DOES NOT CONTAINS ImGuiMod_Shortcut which is pretranslated). Read-only, updated by NewFrame()
        ImGuiKeyData KeysData                                                                                      # Key state for all known keys. Use IsKeyXXX() functions to access this.
        bool WantCaptureMouseUnlessPopupClose                                                                      # Alternative to WantCaptureMouse: (WantCaptureMouse == true && WantCaptureMouseUnlessPopupClose == false) when a click over void is expected to close a popup.
        ImVec2 MousePosPrev                                                                                        # Previous mouse position (note that MouseDelta is not necessary == MousePos-MousePosPrev, in case either position is invalid)
        ImVec2 MouseClickedPos                                                                                     # Position at time of clicking
        double MouseClickedTime                                                                                    # Time of last click (used to figure out double-click)
        bool MouseClicked                                                                                          # Mouse button went from !Down to Down (same as MouseClickedCount[x] != 0)
        bool MouseDoubleClicked                                                                                    # Has mouse button been double-clicked? (same as MouseClickedCount[x] == 2)
        ImU16 MouseClickedCount                                                                                    # == 0 (not clicked), == 1 (same as MouseClicked[]), == 2 (double-clicked), == 3 (triple-clicked) etc. when going from !Down to Down
        ImU16 MouseClickedLastCount                                                                                # Count successive number of clicks. Stays valid after mouse release. Reset after another click is done.
        bool MouseReleased                                                                                         # Mouse button went from Down to !Down
        bool MouseDownOwned                                                                                        # Track if button was clicked inside a dear imgui window or over void blocked by a popup. We don't request mouse capture from the application if click started outside ImGui bounds.
        bool MouseDownOwnedUnlessPopupClose                                                                        # Track if button was clicked inside a dear imgui window.
        float MouseDownDuration                                                                                    # Duration the mouse button has been down (0.0f == just clicked)
        float MouseDownDurationPrev                                                                                # Previous time the mouse button has been down
        ImVec2 MouseDragMaxDistanceAbs                                                                             # Maximum distance, absolute, on each axis, of how much mouse has traveled from the clicking point
        float MouseDragMaxDistanceSqr                                                                              # Squared maximum distance of how much mouse has traveled from the clicking point (used for moving thresholds)
        float PenPressure                                                                                          # Touch/Pen pressure (0.0f to 1.0f, should be >0.0f only when MouseDown[0] == true). Helper storage currently unused by Dear ImGui.
        bool AppFocusLost                                                                                          # Only modify via AddFocusEvent()
        bool AppAcceptingEvents                                                                                    # Only modify via SetAppAcceptingEvents()
        ImS8 BackendUsingLegacyKeyArrays                                                                           # -1: unknown, 0: using AddKeyEvent(), 1: using legacy io.KeysDown[]
        bool BackendUsingLegacyNavInputArray                                                                       # 0: using AddKeyAnalogEvent(), 1: writing to legacy io.NavInputs[] directly
        ImWchar16 InputQueueSurrogate                                                                              # For AddInputCharacterUTF16()
        ImVector_ImWchar InputQueueCharacters                                                                      # Queue of _characters_ input (obtained by platform backend). Fill using AddInputCharacter() helper.


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
    ctypedef struct ImGuiInputTextCallbackData:
        ImGuiContext* Ctx                 # Parent UI context
        ImGuiInputTextFlags EventFlag     # One ImGuiInputTextFlags_Callback*    // Read-only
        ImGuiInputTextFlags Flags         # What user passed to InputText()      // Read-only
        void* UserData                    # What user passed to InputText()      // Read-only
        ImWchar EventChar                 # Character input                      // Read-write   // [CharFilter] Replace character with another one, or set to zero to drop. return 1 is equivalent to setting EventChar=0;
        ImGuiKey EventKey                 # Key pressed (Up/Down/TAB)            // Read-only    // [Completion,History]
        char* Buf                         # Text buffer                          // Read-write   // [Resize] Can replace pointer / [Completion,History,Always] Only write to pointed data, don't replace the actual pointer!
        int BufTextLen                    # Text length (in bytes)               // Read-write   // [Resize,Completion,History,Always] Exclude zero-terminator storage. In C land: == strlen(some_text), in C++ land: string.length()
        int BufSize                       # Buffer size (in bytes) = capacity+1  // Read-only    // [Resize,Completion,History,Always] Include zero-terminator storage. In C land == ARRAYSIZE(my_char_array), in C++ land: string.capacity()+1
        bool BufDirty                     # Set if you modify Buf/BufTextLen!    // Write        // [Completion,History,Always]
        int CursorPos                     # Read-write   // [Completion,History,Always]
        int SelectionStart                # Read-write   // [Completion,History,Always] == to SelectionEnd when no selection)
        int SelectionEnd                  # Read-write   // [Completion,History,Always]


    """
    Resizing callback data to apply custom constraint. As enabled by SetNextWindowSizeConstraints(). Callback is called during the next Begin().
    NB: For basic min/max size constraint on each axis you don't need to use the callback! The SetNextWindowSizeConstraints() parameters are enough.
    """
    ctypedef struct ImGuiSizeCallbackData:
        void* UserData         # Read-only.   What user passed to SetNextWindowSizeConstraints(). Generally store an integer or float in here (need reinterpret_cast<>).
        ImVec2 Pos             # Read-only.   Window position, for reference.
        ImVec2 CurrentSize     # Read-only.   Current window size.
        ImVec2 DesiredSize     # Read-write.  Desired size, based on user's mouse position. Write to this field to restrain resizing.


    """
    [ALPHA] Rarely used / very advanced uses only. Use with SetNextWindowClass() and DockSpace() functions.
    Important: the content of this class is still highly WIP and likely to change and be refactored
    before we stabilize Docking features. Please be mindful if using this.
    Provide hints:
    - To the platform backend via altered viewport flags (enable/disable OS decoration, OS task bar icons, etc.)
    - To the platform backend for OS level parent/child relationships of viewport.
    - To the docking system for various options and filtering.
    """
    ctypedef struct ImGuiWindowClass:
        ImGuiID ClassId                                   # User data. 0 = Default class (unclassed). Windows of different classes cannot be docked with each others.
        ImGuiID ParentViewportId                          # Hint for the platform backend. -1: use default. 0: request platform backend to not parent the platform. != 0: request platform backend to create a parent<>child relationship between the platform windows. Not conforming backends are free to e.g. parent every viewport to the main viewport or not.
        ImGuiViewportFlags ViewportFlagsOverrideSet       # Viewport flags to set when a window of this class owns a viewport. This allows you to enforce OS decoration or task bar icon, override the defaults on a per-window basis.
        ImGuiViewportFlags ViewportFlagsOverrideClear     # Viewport flags to clear when a window of this class owns a viewport. This allows you to enforce OS decoration or task bar icon, override the defaults on a per-window basis.
        ImGuiTabItemFlags TabItemFlagsOverrideSet         # [EXPERIMENTAL] TabItem flags to set when a window of this class gets submitted into a dock node tab bar. May use with ImGuiTabItemFlags_Leading or ImGuiTabItemFlags_Trailing.
        ImGuiDockNodeFlags DockNodeFlagsOverrideSet       # [EXPERIMENTAL] Dock node flags to set when a window of this class is hosted by a dock node (it doesn't have to be selected!)
        bool DockingAlwaysTabBar                          # Set to true to enforce single floating windows of this class always having their own docking node (equivalent of setting the global io.ConfigDockingAlwaysTabBar)
        bool DockingAllowUnclassed                        # Set to true to allow windows of this class to be docked/merged with an unclassed window. // FIXME-DOCK: Move to DockNodeFlags override?


    """
    Data payload for Drag and Drop operations: AcceptDragDropPayload(), GetDragDropPayload()
    """
    ctypedef struct ImGuiPayload:
        void* Data                 # Data (copied and owned by dear imgui)
        int DataSize               # Data size
        ImGuiID SourceId           # Source item id
        ImGuiID SourceParentId     # Source parent id (if available)
        int DataFrameCount         # Data timestamp
        char DataType              # Data type tag (short user-supplied string, 32 characters max)
        bool Preview               # Set when AcceptDragDropPayload() was called and mouse has been hovering the target item (nb: handle overlapping drag targets)
        bool Delivery              # Set when AcceptDragDropPayload() was called and mouse button is released over the target item.


    """
    Sorting specification for one column of a table (sizeof == 12 bytes)
    """
    ctypedef struct ImGuiTableColumnSortSpecs:
        ImGuiID ColumnUserID                 # User id of the column (if specified by a TableSetupColumn() call)
        ImS16 ColumnIndex                    # Index of the column
        ImS16 SortOrder                      # Index within parent ImGuiTableSortSpecs (always stored in order starting from 0, tables sorted on a single criteria will always have a 0 here)
        ImGuiSortDirection SortDirection     # ImGuiSortDirection_Ascending or ImGuiSortDirection_Descending (you can use this or SortSign, whichever is more convenient for your sort function)


    """
    Sorting specifications for a table (often handling sort specs for a single column, occasionally more)
    Obtained by calling TableGetSortSpecs().
    When 'SpecsDirty == true' you can sort your data. It will be true with sorting specs have changed since last call, or the first time.
    Make sure to set 'SpecsDirty = false' after sorting, else you may wastefully sort your data every frame!
    """
    ctypedef struct ImGuiTableSortSpecs:
        const ImGuiTableColumnSortSpecs* Specs     # Pointer to sort spec array.
        int SpecsCount                             # Sort spec count. Most often 1. May be > 1 when ImGuiTableFlags_SortMulti is enabled. May be == 0 when ImGuiTableFlags_SortTristate is enabled.
        bool SpecsDirty                            # Set to true when specs have changed since last time! Use this to sort again, then clear the flag.


    """
    [Internal]
    """
    ctypedef struct ImGuiTextFilter_ImGuiTextRange:
        const char* b
        const char* e


    """
    Helper: Parse and apply text filters. In format "aaaaa[,bbbb][,ccccc]"
    """
    ctypedef struct ImGuiTextFilter:
        char InputBuf
        ImVector_ImGuiTextFilter_ImGuiTextRange Filters
        int CountGrep


    """
    Helper: Growable text buffer for logging/accumulating text
    (this could be called 'ImGuiTextBuilder' / 'ImGuiStringBuilder')
    """
    ctypedef struct ImGuiTextBuffer:
        ImVector_char Buf


    """
    [Internal]
    """
    ctypedef struct ImGuiStorage_ImGuiStoragePair:
        ImGuiID key


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
    ctypedef struct ImGuiStorage:
        ImVector_ImGuiStorage_ImGuiStoragePair Data


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
    clipper.Begin(1000);         // We have 1000 elements, evenly spaced.
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
    ctypedef struct ImGuiListClipper:
        ImGuiContext* Ctx     # Parent UI context
        int DisplayStart      # First item to display, updated by each call to Step()
        int DisplayEnd        # End of items to display (exclusive)
        int ItemsCount        # [Internal] Number of items
        float ItemsHeight     # [Internal] Height of item after a first step and item submission can calculate it
        float StartPosY       # [Internal] Cursor position at the time of Begin() or after table frozen rows are all processed
        void* TempData        # [Internal] Internal data


    """
    Helper: ImColor() implicitly converts colors to either ImU32 (packed 4x1 byte) or ImVec4 (4x1 float)
    Prefer using IM_COL32() macros if you want a guaranteed compile-time ImU32 for usage with ImDrawList API.
    **Avoid storing ImColor! Store either u32 of ImVec4. This is not a full-featured color class. MAY OBSOLETE.
    **None of the ImGui API are using ImColor directly but you can use it as a convenience to pass colors in either ImU32 or ImVec4 formats. Explicitly cast to ImU32 or ImVec4 if needed.
    """
    ctypedef struct ImColor:
        ImVec4 Value


    """
    Typically, 1 command = 1 GPU draw call (unless command is a callback)
    - VtxOffset: When 'io.BackendFlags & ImGuiBackendFlags_RendererHasVtxOffset' is enabled,
    this fields allow us to render meshes larger than 64K vertices while keeping 16-bit indices.
    Backends made for <1.71. will typically ignore the VtxOffset fields.
    - The ClipRect/TextureId/VtxOffset fields must be contiguous as we memcmp() them together (this is asserted for).
    """
    ctypedef struct ImDrawCmd:
        ImVec4 ClipRect                 # 4*4  // Clipping rectangle (x1, y1, x2, y2). Subtract ImDrawData->DisplayPos to get clipping rectangle in "viewport" coordinates
        ImTextureID TextureId           # 4-8  // User-provided texture ID. Set by user in ImfontAtlas::SetTexID() for fonts or passed to Image*() functions. Ignore if never using images or multiple fonts atlas.
        unsigned int VtxOffset          # 4    // Start offset in vertex buffer. ImGuiBackendFlags_RendererHasVtxOffset: always 0, otherwise may be >0 to support meshes larger than 64K vertices with 16-bit indices.
        unsigned int IdxOffset          # 4    // Start offset in index buffer.
        unsigned int ElemCount          # 4    // Number of indices (multiple of 3) to be rendered as triangles. Vertices are stored in the callee ImDrawList's vtx_buffer[] array, indices in idx_buffer[].
        ImDrawCallback UserCallback     # 4-8  // If != NULL, call the function instead of rendering the vertices. clip_rect and texture_id will be set normally.
        void* UserCallbackData          # 4-8  // The draw callback code can access this.

    ctypedef struct ImDrawVert:
        ImVec2 pos
        ImVec2 uv
        ImU32 col


    """
    [Internal] For use by ImDrawList
    """
    ctypedef struct ImDrawCmdHeader:
        ImVec4 ClipRect
        ImTextureID TextureId
        unsigned int VtxOffset


    """
    [Internal] For use by ImDrawListSplitter
    """
    ctypedef struct ImDrawChannel:
        ImVector_ImDrawCmd _CmdBuffer
        ImVector_ImDrawIdx _IdxBuffer


    """
    Split/Merge functions are used to split the draw list into different layers which can be drawn into out of order.
    This is used by the Columns/Tables API, so items of each column can be batched together in a same draw call.
    """
    ctypedef struct ImDrawListSplitter:
        int _Current                         # Current channel number (0)
        int _Count                           # Number of active channels (1+)
        ImVector_ImDrawChannel _Channels     # Draw channels (not resized down so _Count might be < Channels.Size)


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
    ctypedef struct ImDrawList:
        ImVector_ImDrawCmd CmdBuffer             # Draw commands. Typically 1 command = 1 GPU draw call, unless the command is a callback.
        ImVector_ImDrawIdx IdxBuffer             # Index buffer. Each command consume ImDrawCmd::ElemCount of those
        ImVector_ImDrawVert VtxBuffer            # Vertex buffer.
        ImDrawListFlags Flags                    # Flags, you may poke into these to adjust anti-aliasing settings per-primitive.
        unsigned int _VtxCurrentIdx              # [Internal] generally == VtxBuffer.Size unless we are past 64K vertices, in which case this gets reset to 0.
        ImDrawListSharedData* _Data              # Pointer to shared draw data (you can use ImGui::GetDrawListSharedData() to get the one from current ImGui context)
        const char* _OwnerName                   # Pointer to owner window's name for debugging
        ImDrawVert* _VtxWritePtr                 # [Internal] point within VtxBuffer.Data after each add command (to avoid using the ImVector<> operators too much)
        ImDrawIdx* _IdxWritePtr                  # [Internal] point within IdxBuffer.Data after each add command (to avoid using the ImVector<> operators too much)
        ImVector_ImVec4 _ClipRectStack           # [Internal]
        ImVector_ImTextureID _TextureIdStack     # [Internal]
        ImVector_ImVec2 _Path                    # [Internal] current path building
        ImDrawCmdHeader _CmdHeader               # [Internal] template of active commands. Fields should match those of CmdBuffer.back().
        ImDrawListSplitter _Splitter             # [Internal] for channels api (note: prefer using your own persistent instance of ImDrawListSplitter!)
        float _FringeScale                       # [Internal] anti-alias fringe is scaled by this value, this helps to keep things sharp while zooming at vertex buffer content


    """
    All draw data to render a Dear ImGui frame
    (NB: the style and the naming convention here is a little inconsistent, we currently preserve them for backward compatibility purpose,
    as this is one of the oldest structure exposed by the library! Basically, ImDrawList == CmdList)
    """
    ctypedef struct ImDrawData:
        bool Valid                       # Only valid after Render() is called and before the next NewFrame() is called.
        int CmdListsCount                # Number of ImDrawList* to render
        int TotalIdxCount                # For convenience, sum of all ImDrawList's IdxBuffer.Size
        int TotalVtxCount                # For convenience, sum of all ImDrawList's VtxBuffer.Size
        ImDrawList** CmdLists            # Array of ImDrawList* to render. The ImDrawList are owned by ImGuiContext and only pointed to from here.
        ImVec2 DisplayPos                # Top-left position of the viewport to render (== top-left of the orthogonal projection matrix to use) (== GetMainViewport()->Pos for the main viewport, == (0.0) in most single-viewport applications)
        ImVec2 DisplaySize               # Size of the viewport to render (== GetMainViewport()->Size for the main viewport, == io.DisplaySize in most single-viewport applications)
        ImVec2 FramebufferScale          # Amount of pixels for each unit of DisplaySize. Based on io.DisplayFramebufferScale. Generally (1,1) on normal display, (2,2) on OSX with Retina display.
        ImGuiViewport* OwnerViewport     # Viewport carrying the ImDrawData instance, might be of use to the renderer (generally not).

    ctypedef struct ImFontConfig:
        void* FontData                    # TTF/OTF data
        int FontDataSize                  # TTF/OTF data size
        bool FontDataOwnedByAtlas         # true     // TTF/OTF data ownership taken by the container ImFontAtlas (will delete memory itself).
        int FontNo                        # 0        // Index of font within TTF/OTF file
        float SizePixels                  # Size in pixels for rasterizer (more or less maps to the resulting font height).
        int OversampleH                   # 3        // Rasterize at higher quality for sub-pixel positioning. Note the difference between 2 and 3 is minimal so you can reduce this to 2 to save memory. Read https://github.com/nothings/stb/blob/master/tests/oversample/README.md for details.
        int OversampleV                   # 1        // Rasterize at higher quality for sub-pixel positioning. This is not really useful as we don't use sub-pixel positions on the Y axis.
        bool PixelSnapH                   # false    // Align every glyph to pixel boundary. Useful e.g. if you are merging a non-pixel aligned font with the default font. If enabled, you can set OversampleH/V to 1.
        ImVec2 GlyphExtraSpacing          # 0, 0     // Extra spacing (in pixels) between glyphs. Only X axis is supported for now.
        ImVec2 GlyphOffset                # 0, 0     // Offset all glyphs from this font input.
        const ImWchar* GlyphRanges        # NULL     // THE ARRAY DATA NEEDS TO PERSIST AS LONG AS THE FONT IS ALIVE. Pointer to a user-provided list of Unicode range (2 value per range, values are inclusive, zero-terminated list).
        float GlyphMinAdvanceX            # 0        // Minimum AdvanceX for glyphs, set Min to align font icons, set both Min/Max to enforce mono-space font
        float GlyphMaxAdvanceX            # FLT_MAX  // Maximum AdvanceX for glyphs
        bool MergeMode                    # false    // Merge into previous ImFont, so you can combine multiple inputs font into one ImFont (e.g. ASCII font + icons + Japanese glyphs). You may want to use GlyphOffset.y when merge font of different heights.
        unsigned int FontBuilderFlags     # 0        // Settings for custom font builder. THIS IS BUILDER IMPLEMENTATION DEPENDENT. Leave as zero if unsure.
        float RasterizerMultiply          # 1.0f     // Brighten (>1.0f) or darken (<1.0f) font output. Brightening small fonts may be a good workaround to make them more readable.
        ImWchar EllipsisChar              # -1       // Explicitly specify unicode codepoint of ellipsis character. When fonts are being merged first specified ellipsis will be used.
        char Name                         # Name (strictly to ease debugging)
        ImFont* DstFont


    """
    Hold rendering data for one glyph.
    (Note: some language parsers may fail to convert the 31+1 bitfield members, in this case maybe drop store a single u32 or we can rework this)
    """
    ctypedef struct ImFontGlyph:
        unsigned int Colored       # Flag to indicate glyph is colored and should generally ignore tinting (make it usable with no shift on little-endian as this is used in loops)
        unsigned int Visible       # Flag to indicate glyph has no visible pixels (e.g. space). Allow early out when rendering.
        unsigned int Codepoint     # 0x0000..0x10FFFF
        float AdvanceX             # Distance to next character (= data from font + ImFontConfig::GlyphExtraSpacing.x baked in)
        float X0                   # Glyph corners
        float Y0                   # Glyph corners
        float X1                   # Glyph corners
        float Y1                   # Glyph corners
        float U0                   # Texture coordinates
        float V0                   # Texture coordinates
        float U1                   # Texture coordinates
        float V1                   # Texture coordinates


    """
    Helper to build glyph ranges from text/string data. Feed your application strings/characters to it then call BuildRanges().
    This is essentially a tightly packed of vector of 64k booleans = 8KB storage.
    """
    ctypedef struct ImFontGlyphRangesBuilder:
        ImVector_ImU32 UsedChars     # Store 1-bit per Unicode code point (0=unused, 1=used)


    """
    See ImFontAtlas::AddCustomRectXXX functions.
    """
    ctypedef struct ImFontAtlasCustomRect:
        unsigned short Width      # Input    // Desired rectangle dimension
        unsigned short Height     # Input    // Desired rectangle dimension
        unsigned short X          # Output   // Packed position in Atlas
        unsigned short Y          # Output   // Packed position in Atlas
        unsigned int GlyphID      # Input    // For custom font glyphs only (ID < 0x110000)
        float GlyphAdvanceX       # Input    // For custom font glyphs only: glyph xadvance
        ImVec2 GlyphOffset        # Input    // For custom font glyphs only: glyph display offset
        ImFont* Font              # Input    // For custom font glyphs only: target font


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
    ctypedef struct ImFontAtlas:
        ImFontAtlasFlags Flags                         # Build flags (see ImFontAtlasFlags_)
        ImTextureID TexID                              # User data to refer to the texture once it has been uploaded to user's graphic systems. It is passed back to you during rendering via the ImDrawCmd structure.
        int TexDesiredWidth                            # Texture width desired by user before Build(). Must be a power-of-two. If have many glyphs your graphics API have texture size restrictions you may want to increase texture width to decrease height.
        int TexGlyphPadding                            # Padding between glyphs within texture in pixels. Defaults to 1. If your rendering method doesn't rely on bilinear filtering you may set this to 0 (will also need to set AntiAliasedLinesUseTex = false).
        bool Locked                                    # Marked as Locked by ImGui::NewFrame() so attempt to modify the atlas will assert.
        void* UserData                                 # Store your own atlas related user-data (if e.g. you have multiple font atlas).
        bool TexReady                                  # Set when texture was built matching current font input
        bool TexPixelsUseColors                        # Tell whether our texture data is known to use colors (rather than just alpha channel), in order to help backend select a format.
        unsigned char* TexPixelsAlpha8                 # 1 component per pixel, each component is unsigned 8-bit. Total size = TexWidth * TexHeight
        unsigned int* TexPixelsRGBA32                  # 4 component per pixel, each component is unsigned 8-bit. Total size = TexWidth * TexHeight * 4
        int TexWidth                                   # Texture width calculated during Build().
        int TexHeight                                  # Texture height calculated during Build().
        ImVec2 TexUvScale                              # = (1.0f/TexWidth, 1.0f/TexHeight)
        ImVec2 TexUvWhitePixel                         # Texture coordinates to a white pixel
        ImVector_ImFontPtr Fonts                       # Hold all the fonts returned by AddFont*. Fonts[0] is the default font upon calling ImGui::NewFrame(), use ImGui::PushFont()/PopFont() to change the current font.
        ImVector_ImFontAtlasCustomRect CustomRects     # Rectangles for packing custom texture data into the atlas.
        ImVector_ImFontConfig ConfigData               # Configuration data
        ImVec4 TexUvLines                              # UVs for baked anti-aliased lines
        const ImFontBuilderIO* FontBuilderIO           # Opaque interface to a font builder (default to stb_truetype, can be changed to use FreeType by defining IMGUI_ENABLE_FREETYPE).
        unsigned int FontBuilderFlags                  # Shared flags (for all fonts) for custom font builder. THIS IS BUILD IMPLEMENTATION DEPENDENT. Per-font override is also available in ImFontConfig.
        int PackIdMouseCursors                         # Custom texture rectangle ID for white pixel and mouse cursors
        int PackIdLines                                # Custom texture rectangle ID for baked anti-aliased lines


    """
    Font runtime data and rendering
    ImFontAtlas automatically loads a default embedded font for you when you call GetTexDataAsAlpha8() or GetTexDataAsRGBA32().
    """
    ctypedef struct ImFont:
        ImVector_float IndexAdvanceX         # 12-16 // out //            // Sparse. Glyphs->AdvanceX in a directly indexable way (cache-friendly for CalcTextSize functions which only this this info, and are often bottleneck in large UI).
        float FallbackAdvanceX               # 4     // out // = FallbackGlyph->AdvanceX
        float FontSize                       # 4     // in  //            // Height of characters/line, set during loading (don't change after loading)
        ImVector_ImWchar IndexLookup         # 12-16 // out //            // Sparse. Index glyphs by Unicode code-point.
        ImVector_ImFontGlyph Glyphs          # 12-16 // out //            // All glyphs.
        const ImFontGlyph* FallbackGlyph     # 4-8   // out // = FindGlyph(FontFallbackChar)
        ImFontAtlas* ContainerAtlas          # 4-8   // out //            // What we has been loaded into
        const ImFontConfig* ConfigData       # 4-8   // in  //            // Pointer within ContainerAtlas->ConfigData
        short ConfigDataCount                # 2     // in  // ~ 1        // Number of ImFontConfig involved in creating this font. Bigger than 1 when merging multiple font sources into one ImFont.
        ImWchar FallbackChar                 # 2     // out // = FFFD/'?' // Character used if a glyph isn't found.
        ImWchar EllipsisChar                 # 2     // out // = '...'/'.'// Character used for ellipsis rendering.
        short EllipsisCharCount              # 1     // out // 1 or 3
        float EllipsisWidth                  # 4     // out               // Width
        float EllipsisCharStep               # 4     // out               // Step between characters when EllipsisCount > 0
        bool DirtyLookupTables               # 1     // out //
        float Scale                          # 4     // in  // = 1.f      // Base font scale, multiplied by the per-window font scale which you can adjust with SetWindowFontScale()
        float Ascent                         # 4+4   // out //            // Ascent: distance from top to bottom of e.g. 'A' [0..FontSize]
        float Descent                        # 4+4   // out //            // Ascent: distance from top to bottom of e.g. 'A' [0..FontSize]
        int MetricsTotalSurface              # 4     // out //            // Total surface in pixels to get an idea of the font rasterization/texture cost (not exact, we approximate the cost of padding between glyphs)
        ImU8 Used4kPagesMap                  # 2 bytes if ImWchar=ImWchar16, 34 bytes if ImWchar==ImWchar32. Store 1-bit for each block of 4K codepoints that has one active glyph. This is mainly used to facilitate iterations across all used codepoints.


    """
    - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
    - With multi-viewport enabled, we extend this concept to have multiple active viewports.
    - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
    - About Main Area vs Work Area:
    - Main Area = entire viewport.
    - Work Area = entire viewport minus sections used by main menu bars (for platform windows), or by task bar (for platform monitor).
    - Windows are generally trying to stay within the Work Area of their host viewport.
    """
    ctypedef struct ImGuiViewport:
        ImGuiID ID                     # Unique identifier for the viewport
        ImGuiViewportFlags Flags       # See ImGuiViewportFlags_
        ImVec2 Pos                     # Main Area: Position of the viewport (Dear ImGui coordinates are the same as OS desktop/native coordinates)
        ImVec2 Size                    # Main Area: Size of the viewport.
        ImVec2 WorkPos                 # Work Area: Position of the viewport minus task bars, menus bars, status bars (>= Pos)
        ImVec2 WorkSize                # Work Area: Size of the viewport minus task bars, menu bars, status bars (<= Size)
        float DpiScale                 # 1.0f = 96 DPI = No extra scale.
        ImGuiID ParentViewportId       # (Advanced) 0: no parent. Instruct the platform backend to setup a parent/child relationship between platform windows.
        ImDrawData* DrawData           # The ImDrawData corresponding to this viewport. Valid after Render() and until the next call to NewFrame().
        void* RendererUserData         # void* to hold custom data structure for the renderer (e.g. swap chain, framebuffers etc.). generally set by your Renderer_CreateWindow function.
        void* PlatformUserData         # void* to hold custom data structure for the OS / platform (e.g. windowing info, render context). generally set by your Platform_CreateWindow function.
        void* PlatformHandle           # void* for FindViewportByPlatformHandle(). (e.g. suggested to use natural platform handle such as HWND, GLFWWindow*, SDL_Window*)
        void* PlatformHandleRaw        # void* to hold lower-level, platform-native window handle (under Win32 this is expected to be a HWND, unused for other platforms), when using an abstraction layer like GLFW or SDL (where PlatformHandle would be a SDL_Window*)
        bool PlatformWindowCreated     # Platform window has been created (Platform_CreateWindow() has been called). This is false during the first frame where a viewport is being created.
        bool PlatformRequestMove       # Platform window requested move (e.g. window was moved by the OS / host window manager, authoritative position will be OS window position)
        bool PlatformRequestResize     # Platform window requested resize (e.g. window was resized by the OS / host window manager, authoritative size will be OS window size)
        bool PlatformRequestClose      # Platform window requested closure (e.g. window was moved by the OS / host window manager, e.g. pressing ALT-F4)


    """
    (Optional) Access via ImGui::GetPlatformIO()
    """
    ctypedef struct ImGuiPlatformIO:
        void (*Platform_CreateWindow)(ImGuiViewport* vp)                                                                           # . . U . .  // Create a new platform window for the given viewport
        void (*Platform_DestroyWindow)(ImGuiViewport* vp)                                                                         # N . U . D  //
        void (*Platform_ShowWindow)(ImGuiViewport* vp)                                                                               # . . U . .  // Newly created windows are initially hidden so SetWindowPos/Size/Title can be called on them before showing the window
        void (*Platform_SetWindowPos)(ImGuiViewport* vp, ImVec2 pos)                                                               # . . U . .  // Set platform window position (given the upper-left corner of client area)
        ImVec2 (*Platform_GetWindowPos)(ImGuiViewport* vp)                                                                         # N . . . .  //
        void (*Platform_SetWindowSize)(ImGuiViewport* vp, ImVec2 size)                                                            # . . U . .  // Set platform window client area size (ignoring OS decorations such as OS title bar etc.)
        ImVec2 (*Platform_GetWindowSize)(ImGuiViewport* vp)                                                                       # N . . . .  // Get platform window client area size
        void (*Platform_SetWindowFocus)(ImGuiViewport* vp)                                                                       # N . . . .  // Move window to front and set input focus
        bool (*Platform_GetWindowFocus)(ImGuiViewport* vp)                                                                       # . . U . .  //
        bool (*Platform_GetWindowMinimized)(ImGuiViewport* vp)                                                               # N . . . .  // Get platform window minimized state. When minimized, we generally won't attempt to get/set size and contents will be culled more easily
        void (*Platform_SetWindowTitle)(ImGuiViewport* vp, const char* str)                                                      # . . U . .  // Set platform window title (given an UTF-8 string)
        void (*Platform_SetWindowAlpha)(ImGuiViewport* vp, float alpha)                                                          # . . U . .  // (Optional) Setup global transparency (not per-pixel transparency)
        void (*Platform_UpdateWindow)(ImGuiViewport* vp)                                                                           # . . U . .  // (Optional) Called by UpdatePlatformWindows(). Optional hook to allow the platform backend from doing general book-keeping every frame.
        void (*Platform_RenderWindow)(ImGuiViewport* vp, void* render_arg)                                                         # . . . R .  // (Optional) Main rendering (platform side! This is often unused, or just setting a "current" context for OpenGL bindings). 'render_arg' is the value passed to RenderPlatformWindowsDefault().
        void (*Platform_SwapBuffers)(ImGuiViewport* vp, void* render_arg)                                                           # . . . R .  // (Optional) Call Present/SwapBuffers (platform side! This is often unused!). 'render_arg' is the value passed to RenderPlatformWindowsDefault().
        float (*Platform_GetWindowDpiScale)(ImGuiViewport* vp)                                                                # N . . . .  // (Optional) [BETA] FIXME-DPI: DPI handling: Return DPI scale for this viewport. 1.0f = 96 DPI.
        void (*Platform_OnChangedViewport)(ImGuiViewport* vp)                                                                 # . F . . .  // (Optional) [BETA] FIXME-DPI: DPI handling: Called during Begin() every time the viewport we are outputting into changes, so backend has a chance to swap fonts to adjust style.
        int (*Platform_CreateVkSurface)(ImGuiViewport* vp, ImU64 vk_inst, const void* vk_allocators, ImU64* out_vk_surface)     # (Optional) For a Vulkan Renderer to call into Platform code (since the surface creation needs to tie them both).
        void (*Renderer_CreateWindow)(ImGuiViewport* vp)                                                                           # . . U . .  // Create swap chain, frame buffers etc. (called after Platform_CreateWindow)
        void (*Renderer_DestroyWindow)(ImGuiViewport* vp)                                                                         # N . U . D  // Destroy swap chain, frame buffers etc. (called before Platform_DestroyWindow)
        void (*Renderer_SetWindowSize)(ImGuiViewport* vp, ImVec2 size)                                                            # . . U . .  // Resize swap chain, frame buffers etc. (called after Platform_SetWindowSize)
        void (*Renderer_RenderWindow)(ImGuiViewport* vp, void* render_arg)                                                         # . . . R .  // (Optional) Clear framebuffer, setup render target, then render the viewport->DrawData. 'render_arg' is the value passed to RenderPlatformWindowsDefault().
        void (*Renderer_SwapBuffers)(ImGuiViewport* vp, void* render_arg)                                                           # . . . R .  // (Optional) Call Present/SwapBuffers. 'render_arg' is the value passed to RenderPlatformWindowsDefault().
        ImVector_ImGuiPlatformMonitor Monitors
        ImVector_ImGuiViewportPtr Viewports                                                                                                              # Main viewports, followed by all secondary viewports.


    """
    (Optional) This is required when enabling multi-viewport. Represent the bounds of each connected monitor/display and their DPI.
    We use this information for multiple DPI support + clamping the position of popups and tooltips so they don't straddle multiple monitors.
    """
    ctypedef struct ImGuiPlatformMonitor:
        ImVec2 MainPos      # Coordinates of the area displayed on this monitor (Min = upper left, Max = bottom right)
        ImVec2 MainSize     # Coordinates of the area displayed on this monitor (Min = upper left, Max = bottom right)
        ImVec2 WorkPos      # Coordinates without task bars / side bars / menu bars. Used to avoid positioning popups/tooltips inside this region. If you don't have this info, please copy the value for MainPos/MainSize.
        ImVec2 WorkSize     # Coordinates without task bars / side bars / menu bars. Used to avoid positioning popups/tooltips inside this region. If you don't have this info, please copy the value for MainPos/MainSize.
        float DpiScale      # 1.0f = 96 DPI


    """
    (Optional) Support for IME (Input Method Editor) via the io.SetPlatformImeDataFn() function.
    """
    ctypedef struct ImGuiPlatformImeData:
        bool WantVisible          # A widget wants the IME to be visible
        ImVec2 InputPos           # Position of the input cursor
        float InputLineHeight     # Line height


    ImGuiKey GetKeyIndex(ImGuiKey key) except +
    ImColor ImColor_HSV(ImColor* self, float h, float s, float v, float a) except +

    """
    FIXME-OBSOLETE: May need to obsolete/cleanup those helpers.
    """
    void ImColor_SetHSV(ImColor* self, float h, float s, float v, float a) except +

    """
    Since 1.83: returns ImTextureID associated with this draw call. Warning: DO NOT assume this is always same as 'TextureId' (we will change this function for an upcoming feature)
    """
    ImTextureID ImDrawCmd_GetTexID(const ImDrawCmd* self) except +

    """
    The ImDrawList are owned by ImGuiContext!
    """
    void ImDrawData_Clear(ImDrawData* self) except +

    """
    Helper to convert all buffers from indexed to non-indexed, in case you cannot render indexed. Note: this is slow and most likely a waste of resources. Always prefer indexed rendering!
    """
    void ImDrawData_DeIndexAllBuffers(ImDrawData* self) except +

    """
    Helper to scale the ClipRect field of each ImDrawCmd. Use if your final output buffer is at a different scale than Dear ImGui expects, or if there is a difference between your window resolution and framebuffer resolution.
    """
    void ImDrawData_ScaleClipRects(ImDrawData* self, ImVec2 fb_scale) except +

    """
    Do not clear Channels[] so our allocations are reused next frame
    """
    void ImDrawListSplitter_Clear(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_Merge(ImDrawListSplitter* self, ImDrawList* draw_list) except +
    void ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter* self, ImDrawList* draw_list, int channel_idx) except +
    void ImDrawListSplitter_Split(ImDrawListSplitter* self, ImDrawList* draw_list, int count) except +

    """
    Cubic Bezier (4 control points)
    """
    void ImDrawList_AddBezierCubic(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col, float thickness, int num_segments) except +

    """
    Quadratic Bezier (3 control points)
    """
    void ImDrawList_AddBezierQuadratic(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col, float thickness, int num_segments) except +

    """
    Advanced
    Your rendering function must check for 'UserCallback' in ImDrawCmd and call the function instead of rendering triangles.
    """
    void ImDrawList_AddCallback(ImDrawList* self, ImDrawCallback callback, void* callback_data) except +

    """
    Implied num_segments = 0, thickness = 1.0f
    """
    void ImDrawList_AddCircle(ImDrawList* self, ImVec2 center, float radius, ImU32 col) except +
    void ImDrawList_AddCircleEx(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments, float thickness) except +
    void ImDrawList_AddCircleFilled(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddConvexPolyFilled(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col) except +

    """
    This is useful if you need to forcefully create a new draw call (to allow for dependent rendering / blending). Otherwise primitives are merged into the same draw-call as much as possible
    """
    void ImDrawList_AddDrawCmd(ImDrawList* self) except +

    """
    Image primitives
    - Read FAQ to understand what ImTextureID is.
    - "p_min" and "p_max" represent the upper-left and lower-right corners of the rectangle.
    - "uv_min" and "uv_max" represent the normalized texture coordinates to use for those corners. Using (0,0)->(1,1) texture coordinates will generally display the entire texture.
    Implied uv_min = ImVec2(0, 0), uv_max = ImVec2(1, 1), col = IM_COL32_WHITE
    """
    void ImDrawList_AddImage(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p_min, ImVec2 p_max) except +
    void ImDrawList_AddImageEx(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p_min, ImVec2 p_max, ImVec2 uv_min, ImVec2 uv_max, ImU32 col) except +

    """
    Implied uv1 = ImVec2(0, 0), uv2 = ImVec2(1, 0), uv3 = ImVec2(1, 1), uv4 = ImVec2(0, 1), col = IM_COL32_WHITE
    """
    void ImDrawList_AddImageQuad(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4) except +
    void ImDrawList_AddImageQuadEx(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImVec2 uv1, ImVec2 uv2, ImVec2 uv3, ImVec2 uv4, ImU32 col) except +
    void ImDrawList_AddImageRounded(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p_min, ImVec2 p_max, ImVec2 uv_min, ImVec2 uv_max, ImU32 col, float rounding, ImDrawFlags flags) except +

    """
    Primitives
    - Filled shapes must always use clockwise winding order. The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
    - For rectangular primitives, "p_min" and "p_max" represent the upper-left and lower-right corners.
    - For circle primitives, use "num_segments == 0" to automatically calculate tessellation (preferred).
    In older versions (until Dear ImGui 1.77) the AddCircle functions defaulted to num_segments == 12.
    In future versions we will use textures to provide cheaper and higher-quality circles.
    Use AddNgon() and AddNgonFilled() functions if you need to guarantee a specific number of sides.
    Implied thickness = 1.0f
    """
    void ImDrawList_AddLine(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImU32 col) except +
    void ImDrawList_AddLineEx(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImU32 col, float thickness) except +

    """
    Implied thickness = 1.0f
    """
    void ImDrawList_AddNgon(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddNgonEx(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments, float thickness) except +
    void ImDrawList_AddNgonFilled(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddPolyline(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col, ImDrawFlags flags, float thickness) except +

    """
    Implied thickness = 1.0f
    """
    void ImDrawList_AddQuad(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col) except +
    void ImDrawList_AddQuadEx(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col, float thickness) except +
    void ImDrawList_AddQuadFilled(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col) except +

    """
    Implied rounding = 0.0f, flags = 0, thickness = 1.0f
    """
    void ImDrawList_AddRect(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col) except +

    """
    a: upper-left, b: lower-right (== upper-left + size)
    """
    void ImDrawList_AddRectEx(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags, float thickness) except +

    """
    Implied rounding = 0.0f, flags = 0
    """
    void ImDrawList_AddRectFilled(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col) except +

    """
    a: upper-left, b: lower-right (== upper-left + size)
    """
    void ImDrawList_AddRectFilledEx(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags) except +
    void ImDrawList_AddRectFilledMultiColor(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col_upr_left, ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left) except +

    """
    Implied text_end = NULL
    """
    void ImDrawList_AddText(ImDrawList* self, ImVec2 pos, ImU32 col, const char* text_begin) except +
    void ImDrawList_AddTextEx(ImDrawList* self, ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end) except +

    """
    Implied text_end = NULL, wrap_width = 0.0f, cpu_fine_clip_rect = NULL
    """
    void ImDrawList_AddTextImFontPtr(ImDrawList* self, const ImFont* font, float font_size, ImVec2 pos, ImU32 col, const char* text_begin) except +
    void ImDrawList_AddTextImFontPtrEx(ImDrawList* self, const ImFont* font, float font_size, ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end, float wrap_width, const ImVec4* cpu_fine_clip_rect) except +

    """
    Implied thickness = 1.0f
    """
    void ImDrawList_AddTriangle(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col) except +
    void ImDrawList_AddTriangleEx(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col, float thickness) except +
    void ImDrawList_AddTriangleFilled(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col) except +
    void ImDrawList_ChannelsMerge(ImDrawList* self) except +
    void ImDrawList_ChannelsSetCurrent(ImDrawList* self, int n) except +

    """
    Advanced: Channels
    - Use to split render into layers. By switching channels to can render out-of-order (e.g. submit FG primitives before BG primitives)
    - Use to minimize draw calls (e.g. if going back-and-forth between multiple clipping rectangles, prefer to append into separate channels then merge at the end)
    - FIXME-OBSOLETE: This API shouldn't have been in ImDrawList in the first place!
    Prefer using your own persistent instance of ImDrawListSplitter as you can stack them.
    Using the ImDrawList::ChannelsXXXX you cannot stack a split over another.
    """
    void ImDrawList_ChannelsSplit(ImDrawList* self, int count) except +

    """
    Create a clone of the CmdBuffer/IdxBuffer/VtxBuffer.
    """
    ImDrawList* ImDrawList_CloneOutput(const ImDrawList* self) except +
    ImVec2 ImDrawList_GetClipRectMax(const ImDrawList* self) except +
    ImVec2 ImDrawList_GetClipRectMin(const ImDrawList* self) except +
    void ImDrawList_PathArcTo(ImDrawList* self, ImVec2 center, float radius, float a_min, float a_max, int num_segments) except +

    """
    Use precomputed angles for a 12 steps circle
    """
    void ImDrawList_PathArcToFast(ImDrawList* self, ImVec2 center, float radius, int a_min_of_12, int a_max_of_12) except +

    """
    Cubic Bezier (4 control points)
    """
    void ImDrawList_PathBezierCubicCurveTo(ImDrawList* self, ImVec2 p2, ImVec2 p3, ImVec2 p4, int num_segments) except +

    """
    Quadratic Bezier (3 control points)
    """
    void ImDrawList_PathBezierQuadraticCurveTo(ImDrawList* self, ImVec2 p2, ImVec2 p3, int num_segments) except +

    """
    Stateful path API, add points then finish with PathFillConvex() or PathStroke()
    - Filled shapes must always use clockwise winding order. The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
    """
    void ImDrawList_PathClear(ImDrawList* self) except +
    void ImDrawList_PathFillConvex(ImDrawList* self, ImU32 col) except +
    void ImDrawList_PathLineTo(ImDrawList* self, ImVec2 pos) except +
    void ImDrawList_PathLineToMergeDuplicate(ImDrawList* self, ImVec2 pos) except +
    void ImDrawList_PathRect(ImDrawList* self, ImVec2 rect_min, ImVec2 rect_max, float rounding, ImDrawFlags flags) except +
    void ImDrawList_PathStroke(ImDrawList* self, ImU32 col, ImDrawFlags flags, float thickness) except +
    void ImDrawList_PopClipRect(ImDrawList* self) except +
    void ImDrawList_PopTextureID(ImDrawList* self) except +
    void ImDrawList_PrimQuadUV(ImDrawList* self, ImVec2 a, ImVec2 b, ImVec2 c, ImVec2 d, ImVec2 uv_a, ImVec2 uv_b, ImVec2 uv_c, ImVec2 uv_d, ImU32 col) except +

    """
    Axis aligned rectangle (composed of two triangles)
    """
    void ImDrawList_PrimRect(ImDrawList* self, ImVec2 a, ImVec2 b, ImU32 col) except +
    void ImDrawList_PrimRectUV(ImDrawList* self, ImVec2 a, ImVec2 b, ImVec2 uv_a, ImVec2 uv_b, ImU32 col) except +

    """
    Advanced: Primitives allocations
    - We render triangles (three vertices)
    - All primitives needs to be reserved via PrimReserve() beforehand.
    """
    void ImDrawList_PrimReserve(ImDrawList* self, int idx_count, int vtx_count) except +
    void ImDrawList_PrimUnreserve(ImDrawList* self, int idx_count, int vtx_count) except +

    """
    Write vertex with unique index
    """
    void ImDrawList_PrimVtx(ImDrawList* self, ImVec2 pos, ImVec2 uv, ImU32 col) except +
    void ImDrawList_PrimWriteIdx(ImDrawList* self, ImDrawIdx idx) except +
    void ImDrawList_PrimWriteVtx(ImDrawList* self, ImVec2 pos, ImVec2 uv, ImU32 col) except +

    """
    Render-level scissoring. This is passed down to your render function but not used for CPU-side coarse clipping. Prefer using higher-level ImGui::PushClipRect() to affect logic (hit-testing and widget culling)
    """
    void ImDrawList_PushClipRect(ImDrawList* self, ImVec2 clip_rect_min, ImVec2 clip_rect_max, bool intersect_with_current_clip_rect) except +
    void ImDrawList_PushClipRectFullScreen(ImDrawList* self) except +
    void ImDrawList_PushTextureID(ImDrawList* self, ImTextureID texture_id) except +
    int ImDrawList__CalcCircleAutoSegmentCount(const ImDrawList* self, float radius) except +
    void ImDrawList__ClearFreeMemory(ImDrawList* self) except +
    void ImDrawList__OnChangedClipRect(ImDrawList* self) except +
    void ImDrawList__OnChangedTextureID(ImDrawList* self) except +
    void ImDrawList__OnChangedVtxOffset(ImDrawList* self) except +
    void ImDrawList__PathArcToFastEx(ImDrawList* self, ImVec2 center, float radius, int a_min_sample, int a_max_sample, int a_step) except +
    void ImDrawList__PathArcToN(ImDrawList* self, ImVec2 center, float radius, float a_min, float a_max, int num_segments) except +
    void ImDrawList__PopUnusedDrawCmd(ImDrawList* self) except +

    """
    [Internal helpers]
    """
    void ImDrawList__ResetForNewFrame(ImDrawList* self) except +
    void ImDrawList__TryMergeDrawCmds(ImDrawList* self) except +
    bool ImFontAtlasCustomRect_IsPacked(const ImFontAtlasCustomRect* self) except +
    int ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas* self, ImFont* font, ImWchar id_, int width, int height, float advance_x, ImVec2 offset) except +

    """
    You can request arbitrary rectangles to be packed into the atlas, for your own purposes.
    - After calling Build(), you can query the rectangle position and render your pixels.
    - If you render colored output, set 'atlas->TexPixelsUseColors = true' as this may help some backends decide of prefered texture format.
    - You can also request your rectangles to be mapped as font glyph (given a font + Unicode point),
    so you can render e.g. custom colorful icons and use them as regular glyphs.
    - Read docs/FONTS.md for more details about using colorful icons.
    - Note: this API may be redesigned later in order to support multi-monitor varying DPI settings.
    """
    int ImFontAtlas_AddCustomRectRegular(ImFontAtlas* self, int width, int height) except +
    ImFont* ImFontAtlas_AddFont(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontDefault(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontFromFileTTF(ImFontAtlas* self, const char* filename, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +

    """
    'compressed_font_data_base85' still owned by caller. Compress with binary_to_compressed_c.cpp with -base85 parameter.
    """
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas* self, const char* compressed_font_data_base85, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +

    """
    'compressed_font_data' still owned by caller. Compress with binary_to_compressed_c.cpp.
    """
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas* self, const void* compressed_font_data, int compressed_font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +

    """
    Note: Transfer ownership of 'ttf_data' to ImFontAtlas! Will be deleted after destruction of the atlas. Set font_cfg->FontDataOwnedByAtlas=false to keep ownership of your data and it won't be freed.
    """
    ImFont* ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas* self, void* font_data, int font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +

    """
    Build atlas, retrieve pixel data.
    User is in charge of copying the pixels into graphics memory (e.g. create a texture with your engine). Then store your texture handle with SetTexID().
    The pitch is always = Width * BytesPerPixels (1 or 4)
    Building in RGBA32 format is provided for convenience and compatibility, but note that unless you manually manipulate or copy color data into
    the texture (e.g. when using the AddCustomRect*** api), then the RGB pixels emitted will always be white (~75% of memory/bandwidth waste.
    Build pixels data. This is called automatically for you by the GetTexData*** functions.
    """
    bool ImFontAtlas_Build(ImFontAtlas* self) except +

    """
    [Internal]
    """
    void ImFontAtlas_CalcCustomRectUV(const ImFontAtlas* self, const ImFontAtlasCustomRect* rect, ImVec2* out_uv_min, ImVec2* out_uv_max) except +

    """
    Clear all input and output.
    """
    void ImFontAtlas_Clear(ImFontAtlas* self) except +

    """
    Clear output font data (glyphs storage, UV coordinates).
    """
    void ImFontAtlas_ClearFonts(ImFontAtlas* self) except +

    """
    Clear input data (all ImFontConfig structures including sizes, TTF data, glyph ranges, etc.) = all the data used to build the texture and fonts.
    """
    void ImFontAtlas_ClearInputData(ImFontAtlas* self) except +

    """
    Clear output texture data (CPU side). Saves RAM once the texture has been copied to graphics memory.
    """
    void ImFontAtlas_ClearTexData(ImFontAtlas* self) except +
    ImFontAtlasCustomRect* ImFontAtlas_GetCustomRectByIndex(ImFontAtlas* self, int index) except +

    """
    Default + Half-Width + Japanese Hiragana/Katakana + full set of about 21000 CJK Unified Ideographs
    """
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseFull(ImFontAtlas* self) except +

    """
    Default + Half-Width + Japanese Hiragana/Katakana + set of 2500 CJK Unified Ideographs for common simplified Chinese
    """
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(ImFontAtlas* self) except +

    """
    Default + about 400 Cyrillic characters
    """
    const ImWchar* ImFontAtlas_GetGlyphRangesCyrillic(ImFontAtlas* self) except +

    """
    Helpers to retrieve list of common Unicode ranges (2 value per range, values are inclusive, zero-terminated list)
    NB: Make sure that your string are UTF-8 and NOT in your local code page. In C++11, you can create UTF-8 string literal using the u8"Hello world" syntax. See FAQ for details.
    NB: Consider using ImFontGlyphRangesBuilder to build glyph ranges from textual data.
    Basic Latin, Extended Latin
    """
    const ImWchar* ImFontAtlas_GetGlyphRangesDefault(ImFontAtlas* self) except +

    """
    Default + Greek and Coptic
    """
    const ImWchar* ImFontAtlas_GetGlyphRangesGreek(ImFontAtlas* self) except +

    """
    Default + Hiragana, Katakana, Half-Width, Selection of 2999 Ideographs
    """
    const ImWchar* ImFontAtlas_GetGlyphRangesJapanese(ImFontAtlas* self) except +

    """
    Default + Korean characters
    """
    const ImWchar* ImFontAtlas_GetGlyphRangesKorean(ImFontAtlas* self) except +

    """
    Default + Thai characters
    """
    const ImWchar* ImFontAtlas_GetGlyphRangesThai(ImFontAtlas* self) except +

    """
    Default + Vietnamese characters
    """
    const ImWchar* ImFontAtlas_GetGlyphRangesVietnamese(ImFontAtlas* self) except +
    bool ImFontAtlas_GetMouseCursorTexData(ImFontAtlas* self, ImGuiMouseCursor cursor, ImVec2* out_offset, ImVec2* out_size, ImVec2 out_uv_border, ImVec2 out_uv_fill) except +

    """
    1 byte per-pixel
    """
    void ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +

    """
    4 bytes-per-pixel
    """
    void ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +

    """
    Bit ambiguous: used to detect when user didn't build texture but effectively we should check TexID != 0 except that would be backend dependent...
    """
    bool ImFontAtlas_IsBuilt(const ImFontAtlas* self) except +
    void ImFontAtlas_SetTexID(ImFontAtlas* self, ImTextureID id_) except +

    """
    Add character
    """
    void ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder* self, ImWchar c) except +

    """
    Add ranges, e.g. builder.AddRanges(ImFontAtlas::GetGlyphRangesDefault()) to force add all of ASCII/Latin+Ext
    """
    void ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder* self, const ImWchar* ranges) except +

    """
    Add string (each character of the UTF-8 string are added)
    """
    void ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder* self, const char* text, const char* text_end) except +

    """
    Output new ranges (ImVector_Construct()/ImVector_Destruct() can be used to safely construct out_ranges)
    """
    void ImFontGlyphRangesBuilder_BuildRanges(ImFontGlyphRangesBuilder* self, ImVector_ImWchar* out_ranges) except +
    void ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder* self) except +

    """
    Get bit n in the array
    """
    bool ImFontGlyphRangesBuilder_GetBit(const ImFontGlyphRangesBuilder* self, size_t n) except +

    """
    Set bit n in the array
    """
    void ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder* self, size_t n) except +
    void ImFont_AddGlyph(ImFont* self, const ImFontConfig* src_cfg, ImWchar c, float x0, float y0, float x1, float y1, float u0, float v0, float u1, float v1, float advance_x) except +

    """
    Makes 'dst' character/glyph points to 'src' character/glyph. Currently needs to be called AFTER fonts have been built.
    """
    void ImFont_AddRemapChar(ImFont* self, ImWchar dst, ImWchar src, bool overwrite_dst) except +

    """
    [Internal] Don't use!
    """
    void ImFont_BuildLookupTable(ImFont* self) except +

    """
    'max_width' stops rendering after a certain width (could be turned into a 2d size). FLT_MAX to disable.
    'wrap_width' enable automatic word-wrapping across multiple lines to fit into given width. 0.0f to disable.
    Implied text_end = NULL, remaining = NULL
    """
    ImVec2 ImFont_CalcTextSizeA(const ImFont* self, float size, float max_width, float wrap_width, const char* text_begin) except +

    """
    utf8
    """
    ImVec2 ImFont_CalcTextSizeAEx(const ImFont* self, float size, float max_width, float wrap_width, const char* text_begin, const char* text_end, const char** remaining) except +
    const char* ImFont_CalcWordWrapPositionA(const ImFont* self, float scale, const char* text, const char* text_end, float wrap_width) except +
    void ImFont_ClearOutputData(ImFont* self) except +
    const ImFontGlyph* ImFont_FindGlyph(const ImFont* self, ImWchar c) except +
    const ImFontGlyph* ImFont_FindGlyphNoFallback(const ImFont* self, ImWchar c) except +
    float ImFont_GetCharAdvance(const ImFont* self, ImWchar c) except +
    const char* ImFont_GetDebugName(const ImFont* self) except +
    void ImFont_GrowIndex(ImFont* self, int new_size) except +
    bool ImFont_IsGlyphRangeUnused(ImFont* self, unsigned int c_begin, unsigned int c_last) except +
    bool ImFont_IsLoaded(const ImFont* self) except +
    void ImFont_RenderChar(const ImFont* self, ImDrawList* draw_list, float size, ImVec2 pos, ImU32 col, ImWchar c) except +
    void ImFont_RenderText(const ImFont* self, ImDrawList* draw_list, float size, ImVec2 pos, ImU32 col, ImVec4 clip_rect, const char* text_begin, const char* text_end, float wrap_width, bool cpu_fine_clip) except +
    void ImFont_SetGlyphVisible(ImFont* self, ImWchar c, bool visible) except +

    """
    Queue a gain/loss of focus for the application (generally based on OS/platform focus of your window)
    """
    void ImGuiIO_AddFocusEvent(ImGuiIO* self, bool focused) except +

    """
    Queue a new character input
    """
    void ImGuiIO_AddInputCharacter(ImGuiIO* self, unsigned int c) except +

    """
    Queue a new character input from a UTF-16 character, it can be a surrogate
    """
    void ImGuiIO_AddInputCharacterUTF16(ImGuiIO* self, ImWchar16 c) except +

    """
    Queue a new characters input from a UTF-8 string
    """
    void ImGuiIO_AddInputCharactersUTF8(ImGuiIO* self, const char* str_) except +

    """
    Queue a new key down/up event for analog values (e.g. ImGuiKey_Gamepad_ values). Dead-zones should be handled by the backend.
    """
    void ImGuiIO_AddKeyAnalogEvent(ImGuiIO* self, ImGuiKey key, bool down, float v) except +

    """
    Input Functions
    Queue a new key down/up event. Key should be "translated" (as in, generally ImGuiKey_A matches the key end-user would use to emit an 'A' character)
    """
    void ImGuiIO_AddKeyEvent(ImGuiIO* self, ImGuiKey key, bool down) except +

    """
    Queue a mouse button change
    """
    void ImGuiIO_AddMouseButtonEvent(ImGuiIO* self, int button, bool down) except +

    """
    Queue a mouse position update. Use -FLT_MAX,-FLT_MAX to signify no mouse (e.g. app not focused and not hovered)
    """
    void ImGuiIO_AddMousePosEvent(ImGuiIO* self, float x, float y) except +

    """
    Queue a mouse hovered viewport. Requires backend to set ImGuiBackendFlags_HasMouseHoveredViewport to call this (for multi-viewport support).
    """
    void ImGuiIO_AddMouseViewportEvent(ImGuiIO* self, ImGuiID id_) except +

    """
    Queue a mouse wheel update. wheel_y<0: scroll down, wheel_y>0: scroll up, wheel_x<0: scroll right, wheel_x>0: scroll left.
    """
    void ImGuiIO_AddMouseWheelEvent(ImGuiIO* self, float wheel_x, float wheel_y) except +

    """
    [Internal] Clear the text input buffer manually
    """
    void ImGuiIO_ClearInputCharacters(ImGuiIO* self) except +

    """
    [Internal] Release all keys
    """
    void ImGuiIO_ClearInputKeys(ImGuiIO* self) except +

    """
    Set master flag for accepting key/mouse/text events (default to true). Useful if you have native dialog boxes that are interrupting your application loop/refresh, and you want to disable events being queued while your app is frozen.
    """
    void ImGuiIO_SetAppAcceptingEvents(ImGuiIO* self, bool accepting_events) except +

    """
    Implied native_legacy_index = -1
    """
    void ImGuiIO_SetKeyEventNativeData(ImGuiIO* self, ImGuiKey key, int native_keycode, int native_scancode) except +

    """
    [Optional] Specify index for legacy <1.87 IsKeyXXX() functions with native indices + specify native keycode, scancode.
    """
    void ImGuiIO_SetKeyEventNativeDataEx(ImGuiIO* self, ImGuiKey key, int native_keycode, int native_scancode, int native_legacy_index) except +
    void ImGuiInputTextCallbackData_ClearSelection(ImGuiInputTextCallbackData* self) except +
    void ImGuiInputTextCallbackData_DeleteChars(ImGuiInputTextCallbackData* self, int pos, int bytes_count) except +
    bool ImGuiInputTextCallbackData_HasSelection(const ImGuiInputTextCallbackData* self) except +
    void ImGuiInputTextCallbackData_InsertChars(ImGuiInputTextCallbackData* self, int pos, const char* text, const char* text_end) except +
    void ImGuiInputTextCallbackData_SelectAll(ImGuiInputTextCallbackData* self) except +
    void ImGuiListClipper_Begin(ImGuiListClipper* self, int items_count, float items_height) except +

    """
    Automatically called on the last call of Step() that returns false.
    """
    void ImGuiListClipper_End(ImGuiListClipper* self) except +

    """
    Call ForceDisplayRangeByIndices() before first call to Step() if you need a range of items to be displayed regardless of visibility.
    item_max is exclusive e.g. use (42, 42+1) to make item 42 always visible BUT due to alignment/padding of certain items it is likely that an extra item may be included on either end of the display range.
    """
    void ImGuiListClipper_ForceDisplayRangeByIndices(ImGuiListClipper* self, int item_min, int item_max) except +

    """
    Call until it returns false. The DisplayStart/DisplayEnd fields will be set and you can process/draw those items.
    """
    bool ImGuiListClipper_Step(ImGuiListClipper* self) except +
    void ImGuiPayload_Clear(ImGuiPayload* self) except +
    bool ImGuiPayload_IsDataType(const ImGuiPayload* self, const char* type_) except +
    bool ImGuiPayload_IsDelivery(const ImGuiPayload* self) except +
    bool ImGuiPayload_IsPreview(const ImGuiPayload* self) except +

    """
    For quicker full rebuild of a storage (instead of an incremental one), you may add all your contents and then sort once.
    """
    void ImGuiStorage_BuildSortByKey(ImGuiStorage* self) except +

    """
    - Get***() functions find pair, never add/allocate. Pairs are sorted so a query is O(log N)
    - Set***() functions find pair, insertion on demand if missing.
    - Sorted insertion is costly, paid once. A typical frame shouldn't need to insert any new pair.
    """
    void ImGuiStorage_Clear(ImGuiStorage* self) except +
    bool ImGuiStorage_GetBool(const ImGuiStorage* self, ImGuiID key, bool default_val) except +
    bool* ImGuiStorage_GetBoolRef(ImGuiStorage* self, ImGuiID key, bool default_val) except +
    float ImGuiStorage_GetFloat(const ImGuiStorage* self, ImGuiID key, float default_val) except +
    float* ImGuiStorage_GetFloatRef(ImGuiStorage* self, ImGuiID key, float default_val) except +
    int ImGuiStorage_GetInt(const ImGuiStorage* self, ImGuiID key, int default_val) except +

    """
    - Get***Ref() functions finds pair, insert on demand if missing, return pointer. Useful if you intend to do Get+Set.
    - References are only valid until a new value is added to the storage. Calling a Set***() function or a Get***Ref() function invalidates the pointer.
    - A typical use case where this is convenient for quick hacking (e.g. add storage during a live Edit&Continue session if you can't modify existing struct)
    float* pvar = ImGui::GetFloatRef(key); ImGui::SliderFloat("var", pvar, 0, 100.0f); some_var += *pvar;
    """
    int* ImGuiStorage_GetIntRef(ImGuiStorage* self, ImGuiID key, int default_val) except +

    """
    default_val is NULL
    """
    void* ImGuiStorage_GetVoidPtr(const ImGuiStorage* self, ImGuiID key) except +
    void** ImGuiStorage_GetVoidPtrRef(ImGuiStorage* self, ImGuiID key, void* default_val) except +

    """
    Use on your own storage if you know only integer are being stored (open/close all tree nodes)
    """
    void ImGuiStorage_SetAllInt(ImGuiStorage* self, int val) except +
    void ImGuiStorage_SetBool(ImGuiStorage* self, ImGuiID key, bool val) except +
    void ImGuiStorage_SetFloat(ImGuiStorage* self, ImGuiID key, float val) except +
    void ImGuiStorage_SetInt(ImGuiStorage* self, ImGuiID key, int val) except +
    void ImGuiStorage_SetVoidPtr(ImGuiStorage* self, ImGuiID key, void* val) except +
    void ImGuiStyle_ScaleAllSizes(ImGuiStyle* self, float scale_factor) except +
    void ImGuiTextBuffer_append(ImGuiTextBuffer* self, const char* str_, const char* str_end) except +
    void ImGuiTextBuffer_appendf(ImGuiTextBuffer* self, const char* fmt) except +
    void ImGuiTextBuffer_appendfv(ImGuiTextBuffer* self, const char* fmt) except +
    const char* ImGuiTextBuffer_begin(const ImGuiTextBuffer* self) except +
    const char* ImGuiTextBuffer_c_str(const ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_clear(ImGuiTextBuffer* self) except +
    bool ImGuiTextBuffer_empty(const ImGuiTextBuffer* self) except +

    """
    Buf is zero-terminated, so end() will point on the zero-terminator
    """
    const char* ImGuiTextBuffer_end(const ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_reserve(ImGuiTextBuffer* self, int capacity) except +
    int ImGuiTextBuffer_size(const ImGuiTextBuffer* self) except +
    void ImGuiTextFilter_Build(ImGuiTextFilter* self) except +
    void ImGuiTextFilter_Clear(ImGuiTextFilter* self) except +

    """
    Helper calling InputText+Build
    """
    bool ImGuiTextFilter_Draw(ImGuiTextFilter* self, const char* label, float width) except +
    bool ImGuiTextFilter_ImGuiTextRange_empty(const ImGuiTextFilter_ImGuiTextRange* self) except +
    void ImGuiTextFilter_ImGuiTextRange_split(const ImGuiTextFilter_ImGuiTextRange* self, char separator, ImVector_ImGuiTextFilter_ImGuiTextRange* out) except +
    bool ImGuiTextFilter_IsActive(const ImGuiTextFilter* self) except +
    bool ImGuiTextFilter_PassFilter(const ImGuiTextFilter* self, const char* text, const char* text_end) except +

    """
    Helpers
    """
    ImVec2 ImGuiViewport_GetCenter(const ImGuiViewport* self) except +
    ImVec2 ImGuiViewport_GetWorkCenter(const ImGuiViewport* self) except +

    """
    accept contents of a given type. If ImGuiDragDropFlags_AcceptBeforeDelivery is set you can peek into the payload before the mouse button is released.
    """
    const ImGuiPayload* ImGui_AcceptDragDropPayload(const char* type_, ImGuiDragDropFlags flags) except +

    """
    vertically align upcoming text baseline to FramePadding.y so that it will align properly to regularly framed items (call if you have text on a line before a framed item)
    """
    void ImGui_AlignTextToFramePadding() except +

    """
    square button with an arrow shape
    """
    bool ImGui_ArrowButton(const char* str_id, ImGuiDir dir_) except +

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
    bool ImGui_Begin(const char* name, bool* p_open, ImGuiWindowFlags flags) except +

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
    bool ImGui_BeginChild(const char* str_id, ImVec2 size, bool border, ImGuiWindowFlags flags) except +

    """
    helper to create a child window / scrolling region that looks like a normal widget frame
    """
    bool ImGui_BeginChildFrame(ImGuiID id_, ImVec2 size, ImGuiWindowFlags flags) except +
    bool ImGui_BeginChildID(ImGuiID id_, ImVec2 size, bool border, ImGuiWindowFlags flags) except +

    """
    Widgets: Combo Box (Dropdown)
    - The BeginCombo()/EndCombo() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() items.
    - The old Combo() api are helpers over BeginCombo()/EndCombo() which are kept available for convenience purpose. This is analogous to how ListBox are created.
    """
    bool ImGui_BeginCombo(const char* label, const char* preview_value, ImGuiComboFlags flags) except +

    """
    Disabling [BETA API]
    - Disable all user interactions and dim items visuals (applying style.DisabledAlpha over current colors)
    - Those can be nested but it cannot be used to enable an already disabled section (a single BeginDisabled(true) in the stack is enough to keep everything disabled)
    - BeginDisabled(false) essentially does nothing useful but is provided to facilitate use of boolean expressions. If you can avoid calling BeginDisabled(False)/EndDisabled() best to avoid it.
    """
    void ImGui_BeginDisabled(bool disabled) except +

    """
    Drag and Drop
    - On source items, call BeginDragDropSource(), if it returns true also call SetDragDropPayload() + EndDragDropSource().
    - On target candidates, call BeginDragDropTarget(), if it returns true also call AcceptDragDropPayload() + EndDragDropTarget().
    - If you stop calling BeginDragDropSource() the payload is preserved however it won't have a preview tooltip (we currently display a fallback "..." tooltip, see #1725)
    - An item can be both drag source and drop target.
    call after submitting an item which may be dragged. when this return true, you can call SetDragDropPayload() + EndDragDropSource()
    """
    bool ImGui_BeginDragDropSource(ImGuiDragDropFlags flags) except +

    """
    call after submitting an item that may receive a payload. If this returns true, you can call AcceptDragDropPayload() + EndDragDropTarget()
    """
    bool ImGui_BeginDragDropTarget() except +

    """
    lock horizontal starting position
    """
    void ImGui_BeginGroup() except +

    """
    Widgets: List Boxes
    - This is essentially a thin wrapper to using BeginChild/EndChild with some stylistic changes.
    - The BeginListBox()/EndListBox() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() or any items.
    - The simplified/old ListBox() api are helpers over BeginListBox()/EndListBox() which are kept available for convenience purpose. This is analoguous to how Combos are created.
    - Choose frame width:   size.x > 0.0f: custom  /  size.x < 0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
    - Choose frame height:  size.y > 0.0f: custom  /  size.y < 0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
    open a framed scrolling region
    """
    bool ImGui_BeginListBox(const char* label, ImVec2 size) except +

    """
    create and append to a full screen menu-bar.
    """
    bool ImGui_BeginMainMenuBar() except +

    """
    Implied enabled = true
    """
    bool ImGui_BeginMenu(const char* label) except +

    """
    Widgets: Menus
    - Use BeginMenuBar() on a window ImGuiWindowFlags_MenuBar to append to its menu bar.
    - Use BeginMainMenuBar() to create a menu bar at the top of the screen and append to it.
    - Use BeginMenu() to create a menu. You can call BeginMenu() multiple time with the same identifier to append more items to it.
    - Not that MenuItem() keyboardshortcuts are displayed as a convenience but _not processed_ by Dear ImGui at the moment.
    append to menu-bar of current window (requires ImGuiWindowFlags_MenuBar flag set on parent window).
    """
    bool ImGui_BeginMenuBar() except +

    """
    create a sub-menu entry. only call EndMenu() if this returns true!
    """
    bool ImGui_BeginMenuEx(const char* label, bool enabled) except +

    """
    Popups: begin/end functions
    - BeginPopup(): query popup state, if open start appending into the window. Call EndPopup() afterwards. ImGuiWindowFlags are forwarded to the window.
    - BeginPopupModal(): block every interaction behind the window, cannot be closed by user, add a dimming background, has a title bar.
    return true if the popup is open, and you can start outputting to it.
    """
    bool ImGui_BeginPopup(const char* str_id, ImGuiWindowFlags flags) except +

    """
    Popups: open+begin combined functions helpers
    - Helpers to do OpenPopup+BeginPopup where the Open action is triggered by e.g. hovering an item and right-clicking.
    - They are convenient to easily create context menus, hence the name.
    - IMPORTANT: Notice that BeginPopupContextXXX takes ImGuiPopupFlags just like OpenPopup() and unlike BeginPopup(). For full consistency, we may add ImGuiWindowFlags to the BeginPopupContextXXX functions in the future.
    - IMPORTANT: Notice that we exceptionally default their flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter, so if you add other flags remember to re-add the ImGuiPopupFlags_MouseButtonRight.
    Implied str_id = NULL, popup_flags = 1
    """
    bool ImGui_BeginPopupContextItem() except +

    """
    open+begin popup when clicked on last item. Use str_id==NULL to associate the popup to previous item. If you want to use that on a non-interactive item such as Text() you need to pass in an explicit ID here. read comments in .cpp!
    """
    bool ImGui_BeginPopupContextItemEx(const char* str_id, ImGuiPopupFlags popup_flags) except +

    """
    Implied str_id = NULL, popup_flags = 1
    """
    bool ImGui_BeginPopupContextVoid() except +

    """
    open+begin popup when clicked in void (where there are no windows).
    """
    bool ImGui_BeginPopupContextVoidEx(const char* str_id, ImGuiPopupFlags popup_flags) except +

    """
    Implied str_id = NULL, popup_flags = 1
    """
    bool ImGui_BeginPopupContextWindow() except +

    """
    open+begin popup when clicked on current window.
    """
    bool ImGui_BeginPopupContextWindowEx(const char* str_id, ImGuiPopupFlags popup_flags) except +

    """
    return true if the modal is open, and you can start outputting to it.
    """
    bool ImGui_BeginPopupModal(const char* name, bool* p_open, ImGuiWindowFlags flags) except +

    """
    Tab Bars, Tabs
    - Note: Tabs are automatically created by the docking system (when in 'docking' branch). Use this to create tab bars/tabs yourself.
    create and append into a TabBar
    """
    bool ImGui_BeginTabBar(const char* str_id, ImGuiTabBarFlags flags) except +

    """
    create a Tab. Returns true if the Tab is selected.
    """
    bool ImGui_BeginTabItem(const char* label, bool* p_open, ImGuiTabItemFlags flags) except +

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
    TableNextRow() -> TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK
    TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK: TableNextColumn() automatically gets to next row!
    TableNextRow()                           -> Text("Hello 0")                                               // Not OK! Missing TableSetColumnIndex() or TableNextColumn()! Text will not appear!
    --------------------------------------------------------------------------------------------------------
    - 5. Call EndTable()
    Implied outer_size = ImVec2(0.0f, 0.0f), inner_width = 0.0f
    """
    bool ImGui_BeginTable(const char* str_id, int column, ImGuiTableFlags flags) except +
    bool ImGui_BeginTableEx(const char* str_id, int column, ImGuiTableFlags flags, ImVec2 outer_size, float inner_width) except +

    """
    Tooltips
    - Tooltip are windows following the mouse. They do not take focus away.
    begin/append a tooltip window. to create full-featured tooltip (with any kind of items).
    """
    bool ImGui_BeginTooltip() except +

    """
    draw a small circle + keep the cursor on the same line. advance cursor x position by GetTreeNodeToLabelSpacing(), same distance that TreeNode() uses
    """
    void ImGui_Bullet() except +

    """
    shortcut for Bullet()+Text()
    """
    void ImGui_BulletText(const char* fmt) except +
    void ImGui_BulletTextV(const char* fmt) except +

    """
    Widgets: Main
    - Most widgets return true when the value has been changed or when pressed/selected
    - You may also use one of the many IsItemXXX functions (e.g. IsItemActive, IsItemHovered, etc.) to query widget state.
    Implied size = ImVec2(0, 0)
    """
    bool ImGui_Button(const char* label) except +

    """
    button
    """
    bool ImGui_ButtonEx(const char* label, ImVec2 size) except +

    """
    width of item given pushed settings and current cursor position. NOT necessarily the width of last item unlike most 'Item' functions.
    """
    float ImGui_CalcItemWidth() except +

    """
    Text Utilities
    Implied text_end = NULL, hide_text_after_double_hash = false, wrap_width = -1.0f
    """
    ImVec2 ImGui_CalcTextSize(const char* text) except +
    ImVec2 ImGui_CalcTextSizeEx(const char* text, const char* text_end, bool hide_text_after_double_hash, float wrap_width) except +
    bool ImGui_Checkbox(const char* label, bool* v) except +
    bool ImGui_CheckboxFlagsIntPtr(const char* label, int* flags, int flags_value) except +
    bool ImGui_CheckboxFlagsUintPtr(const char* label, unsigned int* flags, unsigned int flags_value) except +

    """
    manually close the popup we have begin-ed into.
    """
    void ImGui_CloseCurrentPopup() except +

    """
    if returning 'true' the header is open. doesn't indent nor push on ID stack. user doesn't have to call TreePop().
    """
    bool ImGui_CollapsingHeader(const char* label, ImGuiTreeNodeFlags flags) except +

    """
    when 'p_visible != NULL': if '*p_visible==true' display an additional small close button on upper right of the header which will set the bool to false when clicked, if '*p_visible==false' don't display the header.
    """
    bool ImGui_CollapsingHeaderBoolPtr(const char* label, bool* p_visible, ImGuiTreeNodeFlags flags) except +

    """
    Implied size = ImVec2(0, 0)
    """
    bool ImGui_ColorButton(const char* desc_id, ImVec4 col, ImGuiColorEditFlags flags) except +

    """
    display a color square/button, hover for details, return true when pressed.
    """
    bool ImGui_ColorButtonEx(const char* desc_id, ImVec4 col, ImGuiColorEditFlags flags, ImVec2 size) except +
    ImU32 ImGui_ColorConvertFloat4ToU32(ImVec4 in_) except +
    void ImGui_ColorConvertHSVtoRGB(float h, float s, float v, float* out_r, float* out_g, float* out_b) except +
    void ImGui_ColorConvertRGBtoHSV(float r, float g, float b, float* out_h, float* out_s, float* out_v) except +

    """
    Color Utilities
    """
    ImVec4 ImGui_ColorConvertU32ToFloat4(ImU32 in_) except +

    """
    Widgets: Color Editor/Picker (tip: the ColorEdit* functions have a little color square that can be left-clicked to open a picker, and right-clicked to open an option menu.)
    - Note that in C++ a 'float v[X]' function argument is the _same_ as 'float* v', the array syntax is just a way to document the number of elements that are expected to be accessible.
    - You can pass the address of a first float element out of a contiguous structure, e.g. &myvector.x
    """
    bool ImGui_ColorEdit3(const char* label, float col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorEdit4(const char* label, float col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorPicker3(const char* label, float col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorPicker4(const char* label, float col, ImGuiColorEditFlags flags, const float* ref_col) except +

    """
    Legacy Columns API (prefer using Tables!)
    - You can also use SameLine(pos_x) to mimic simplified columns.
    Implied count = 1, id = NULL, border = true
    """
    void ImGui_Columns() except +
    void ImGui_ColumnsEx(int count, const char* id_, bool border) except +

    """
    Implied popup_max_height_in_items = -1
    """
    bool ImGui_Combo(const char* label, int* current_item, const char* items_separated_by_zeros) except +

    """
    Implied popup_max_height_in_items = -1
    """
    bool ImGui_ComboCallback(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count) except +
    bool ImGui_ComboCallbackEx(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int popup_max_height_in_items) except +

    """
    Implied popup_max_height_in_items = -1
    """
    bool ImGui_ComboChar(const char* label, int* current_item, const char* items, int items_count) except +
    bool ImGui_ComboCharEx(const char* label, int* current_item, const char* items, int items_count, int popup_max_height_in_items) except +

    """
    Separate items with \0 within a string, end item-list with \0\0. e.g. "One\0Two\0Three\0"
    """
    bool ImGui_ComboEx(const char* label, int* current_item, const char* items_separated_by_zeros, int popup_max_height_in_items) except +

    """
    Context creation and access
    - Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
    - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
    for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
    """
    ImGuiContext* ImGui_CreateContext(ImFontAtlas* shared_font_atlas) except +

    """
    This is called by IMGUI_CHECKVERSION() macro.
    """
    bool ImGui_DebugCheckVersionAndDataLayout(const char* version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx) except +

    """
    Debug Utilities
    """
    void ImGui_DebugTextEncoding(const char* text) except +

    """
    NULL = destroy current context
    """
    void ImGui_DestroyContext(ImGuiContext* ctx) except +

    """
    call DestroyWindow platform functions for all viewports. call from backend Shutdown() if you need to close platform windows before imgui shutdown. otherwise will be called by DestroyContext().
    """
    void ImGui_DestroyPlatformWindows() except +

    """
    Docking
    [BETA API] Enable with io.ConfigFlags |= ImGuiConfigFlags_DockingEnable.
    Note: You can use most Docking facilities without calling any API. You DO NOT need to call DockSpace() to use Docking!
    - Drag from window title bar or their tab to dock/undock. Hold SHIFT to disable docking/undocking.
    - Drag from window menu button (upper-left button) to undock an entire node (all windows).
    - When io.ConfigDockingWithShift == true, you instead need to hold SHIFT to _enable_ docking/undocking.
    About dockspaces:
    - Use DockSpace() to create an explicit dock node _within_ an existing window. See Docking demo for details.
    - Use DockSpaceOverViewport() to create an explicit dock node covering the screen or a specific viewport.
    This is often used with ImGuiDockNodeFlags_PassthruCentralNode.
    - Important: Dockspaces need to be submitted _before_ any window they can host. Submit it early in your frame!
    - Important: Dockspaces need to be kept alive if hidden, otherwise windows docked into it will be undocked.
    e.g. if you have multiple tabs with a dockspace inside each tab: submit the non-visible dockspaces with ImGuiDockNodeFlags_KeepAliveOnly.
    Implied size = ImVec2(0, 0), flags = 0, window_class = NULL
    """
    ImGuiID ImGui_DockSpace(ImGuiID id_) except +
    ImGuiID ImGui_DockSpaceEx(ImGuiID id_, ImVec2 size, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +

    """
    Implied viewport = NULL, flags = 0, window_class = NULL
    """
    ImGuiID ImGui_DockSpaceOverViewport() except +
    ImGuiID ImGui_DockSpaceOverViewportEx(const ImGuiViewport* viewport, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +

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
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = "%.3f", flags = 0
    """
    bool ImGui_DragFloat(const char* label, float* v) except +

    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = "%.3f", flags = 0
    """
    bool ImGui_DragFloat2(const char* label, float v) except +
    bool ImGui_DragFloat2Ex(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = "%.3f", flags = 0
    """
    bool ImGui_DragFloat3(const char* label, float v) except +
    bool ImGui_DragFloat3Ex(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = "%.3f", flags = 0
    """
    bool ImGui_DragFloat4(const char* label, float v) except +
    bool ImGui_DragFloat4Ex(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    If v_min >= v_max we have no bound
    """
    bool ImGui_DragFloatEx(const char* label, float* v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = "%.3f", format_max = NULL, flags = 0
    """
    bool ImGui_DragFloatRange2(const char* label, float* v_current_min, float* v_current_max) except +
    bool ImGui_DragFloatRange2Ex(const char* label, float* v_current_min, float* v_current_max, float v_speed, float v_min, float v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +

    """
    Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = "%d", flags = 0
    """
    bool ImGui_DragInt(const char* label, int* v) except +

    """
    Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = "%d", flags = 0
    """
    bool ImGui_DragInt2(const char* label, int v) except +
    bool ImGui_DragInt2Ex(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = "%d", flags = 0
    """
    bool ImGui_DragInt3(const char* label, int v) except +
    bool ImGui_DragInt3Ex(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = "%d", flags = 0
    """
    bool ImGui_DragInt4(const char* label, int v) except +
    bool ImGui_DragInt4Ex(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    If v_min >= v_max we have no bound
    """
    bool ImGui_DragIntEx(const char* label, int* v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = "%d", format_max = NULL, flags = 0
    """
    bool ImGui_DragIntRange2(const char* label, int* v_current_min, int* v_current_max) except +
    bool ImGui_DragIntRange2Ex(const char* label, int* v_current_min, int* v_current_max, float v_speed, int v_min, int v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +

    """
    Implied v_speed = 1.0f, p_min = NULL, p_max = NULL, format = NULL, flags = 0
    """
    bool ImGui_DragScalar(const char* label, ImGuiDataType data_type, void* p_data) except +
    bool ImGui_DragScalarEx(const char* label, ImGuiDataType data_type, void* p_data, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied v_speed = 1.0f, p_min = NULL, p_max = NULL, format = NULL, flags = 0
    """
    bool ImGui_DragScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components) except +
    bool ImGui_DragScalarNEx(const char* label, ImGuiDataType data_type, void* p_data, int components, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    add a dummy item of given size. unlike InvisibleButton(), Dummy() won't take the mouse click or be navigable into.
    """
    void ImGui_Dummy(ImVec2 size) except +
    void ImGui_End() except +
    void ImGui_EndChild() except +

    """
    always call EndChildFrame() regardless of BeginChildFrame() return values (which indicates a collapsed/clipped window)
    """
    void ImGui_EndChildFrame() except +

    """
    only call EndCombo() if BeginCombo() returns true!
    """
    void ImGui_EndCombo() except +
    void ImGui_EndDisabled() except +

    """
    only call EndDragDropSource() if BeginDragDropSource() returns true!
    """
    void ImGui_EndDragDropSource() except +

    """
    only call EndDragDropTarget() if BeginDragDropTarget() returns true!
    """
    void ImGui_EndDragDropTarget() except +

    """
    ends the Dear ImGui frame. automatically called by Render(). If you don't need to render data (skipping rendering) you may call EndFrame() without Render()... but you'll have wasted CPU already! If you don't need to render, better to not create any windows and not call NewFrame() at all!
    """
    void ImGui_EndFrame() except +

    """
    unlock horizontal starting position + capture the whole group bounding box into one "item" (so you can use IsItemHovered() or layout primitives such as SameLine() on whole group, etc.)
    """
    void ImGui_EndGroup() except +

    """
    only call EndListBox() if BeginListBox() returned true!
    """
    void ImGui_EndListBox() except +

    """
    only call EndMainMenuBar() if BeginMainMenuBar() returns true!
    """
    void ImGui_EndMainMenuBar() except +

    """
    only call EndMenu() if BeginMenu() returns true!
    """
    void ImGui_EndMenu() except +

    """
    only call EndMenuBar() if BeginMenuBar() returns true!
    """
    void ImGui_EndMenuBar() except +

    """
    only call EndPopup() if BeginPopupXXX() returns true!
    """
    void ImGui_EndPopup() except +

    """
    only call EndTabBar() if BeginTabBar() returns true!
    """
    void ImGui_EndTabBar() except +

    """
    only call EndTabItem() if BeginTabItem() returns true!
    """
    void ImGui_EndTabItem() except +

    """
    only call EndTable() if BeginTable() returns true!
    """
    void ImGui_EndTable() except +

    """
    only call EndTooltip() if BeginTooltip() returns true!
    """
    void ImGui_EndTooltip() except +

    """
    this is a helper for backends.
    """
    ImGuiViewport* ImGui_FindViewportByID(ImGuiID id_) except +

    """
    this is a helper for backends. the type platform_handle is decided by the backend (e.g. HWND, MyWindow*, GLFWwindow* etc.)
    """
    ImGuiViewport* ImGui_FindViewportByPlatformHandle(void* platform_handle) except +
    void ImGui_GetAllocatorFunctions(ImGuiMemAllocFunc* p_alloc_func, ImGuiMemFreeFunc* p_free_func, void** p_user_data) except +

    """
    Background/Foreground Draw Lists
    get background draw list for the viewport associated to the current window. this draw list will be the first rendering one. Useful to quickly draw shapes/text behind dear imgui contents.
    """
    ImDrawList* ImGui_GetBackgroundDrawList() except +

    """
    get background draw list for the given viewport. this draw list will be the first rendering one. Useful to quickly draw shapes/text behind dear imgui contents.
    """
    ImDrawList* ImGui_GetBackgroundDrawListImGuiViewportPtr(ImGuiViewport* viewport) except +

    """
    Clipboard Utilities
    - Also see the LogToClipboard() function to capture GUI into clipboard, or easily output text data to the clipboard.
    """
    const char* ImGui_GetClipboardText() except +

    """
    Implied alpha_mul = 1.0f
    """
    ImU32 ImGui_GetColorU32(ImGuiCol idx) except +

    """
    retrieve given style color with style alpha applied and optional extra alpha multiplier, packed as a 32-bit value suitable for ImDrawList
    """
    ImU32 ImGui_GetColorU32Ex(ImGuiCol idx, float alpha_mul) except +

    """
    retrieve given color with style alpha applied, packed as a 32-bit value suitable for ImDrawList
    """
    ImU32 ImGui_GetColorU32ImU32(ImU32 col) except +

    """
    retrieve given color with style alpha applied, packed as a 32-bit value suitable for ImDrawList
    """
    ImU32 ImGui_GetColorU32ImVec4(ImVec4 col) except +

    """
    get current column index
    """
    int ImGui_GetColumnIndex() except +

    """
    get position of column line (in pixels, from the left side of the contents region). pass -1 to use current column, otherwise 0..GetColumnsCount() inclusive. column 0 is typically 0.0f
    """
    float ImGui_GetColumnOffset(int column_index) except +

    """
    get column width (in pixels). pass -1 to use current column
    """
    float ImGui_GetColumnWidth(int column_index) except +
    int ImGui_GetColumnsCount() except +

    """
    Content region
    - Retrieve available space from a given point. GetContentRegionAvail() is frequently useful.
    - Those functions are bound to be redesigned (they are confusing, incomplete and the Min/Max return values are in local window coordinates which increases confusion)
    == GetContentRegionMax() - GetCursorPos()
    """
    ImVec2 ImGui_GetContentRegionAvail() except +

    """
    current content boundaries (typically window boundaries including scrolling, or current column boundaries), in windows coordinates
    """
    ImVec2 ImGui_GetContentRegionMax() except +
    ImGuiContext* ImGui_GetCurrentContext() except +

    """
    cursor position in window coordinates (relative to window position)
    """
    ImVec2 ImGui_GetCursorPos() except +

    """
    (some functions are using window-relative coordinates, such as: GetCursorPos, GetCursorStartPos, GetContentRegionMax, GetWindowContentRegion* etc.
    """
    float ImGui_GetCursorPosX() except +

    """
    other functions such as GetCursorScreenPos or everything in ImDrawList::
    """
    float ImGui_GetCursorPosY() except +

    """
    cursor position in absolute coordinates (useful to work with ImDrawList API). generally top-left == GetMainViewport()->Pos == (0,0) in single viewport mode, and bottom-right == GetMainViewport()->Pos+Size == io.DisplaySize in single-viewport mode.
    """
    ImVec2 ImGui_GetCursorScreenPos() except +

    """
    initial cursor position in window coordinates
    """
    ImVec2 ImGui_GetCursorStartPos() except +

    """
    peek directly into the current payload from anywhere. may return NULL. use ImGuiPayload::IsDataType() to test for the payload type.
    """
    const ImGuiPayload* ImGui_GetDragDropPayload() except +

    """
    valid after Render() and until the next call to NewFrame(). this is what you have to render.
    """
    ImDrawData* ImGui_GetDrawData() except +

    """
    you may use this when creating your own ImDrawList instances.
    """
    ImDrawListSharedData* ImGui_GetDrawListSharedData() except +

    """
    Style read access
    - Use the ShowStyleEditor() function to interactively see/edit the colors.
    get current font
    """
    ImFont* ImGui_GetFont() except +

    """
    get current font size (= height in pixels) of current font with current scale applied
    """
    float ImGui_GetFontSize() except +

    """
    get UV coordinate for a while pixel, useful to draw custom shapes via the ImDrawList API
    """
    ImVec2 ImGui_GetFontTexUvWhitePixel() except +

    """
    get foreground draw list for the viewport associated to the current window. this draw list will be the last rendered one. Useful to quickly draw shapes/text over dear imgui contents.
    """
    ImDrawList* ImGui_GetForegroundDrawList() except +

    """
    get foreground draw list for the given viewport. this draw list will be the last rendered one. Useful to quickly draw shapes/text over dear imgui contents.
    """
    ImDrawList* ImGui_GetForegroundDrawListImGuiViewportPtr(ImGuiViewport* viewport) except +

    """
    get global imgui frame count. incremented by 1 every frame.
    """
    int ImGui_GetFrameCount() except +

    """
    ~ FontSize + style.FramePadding.y * 2
    """
    float ImGui_GetFrameHeight() except +

    """
    ~ FontSize + style.FramePadding.y * 2 + style.ItemSpacing.y (distance in pixels between 2 consecutive lines of framed widgets)
    """
    float ImGui_GetFrameHeightWithSpacing() except +

    """
    calculate unique ID (hash of whole ID stack + given parameter). e.g. if you want to query into ImGuiStorage yourself
    """
    ImGuiID ImGui_GetID(const char* str_id) except +
    ImGuiID ImGui_GetIDPtr(const void* ptr_id) except +
    ImGuiID ImGui_GetIDStr(const char* str_id_begin, const char* str_id_end) except +

    """
    Main
    access the IO structure (mouse/keyboard/gamepad inputs, time, various configuration options/flags)
    """
    ImGuiIO* ImGui_GetIO() except +

    """
    get ID of last item (~~ often same ImGui::GetID(label) beforehand)
    """
    ImGuiID ImGui_GetItemID() except +

    """
    get lower-right bounding rectangle of the last item (screen space)
    """
    ImVec2 ImGui_GetItemRectMax() except +

    """
    get upper-left bounding rectangle of the last item (screen space)
    """
    ImVec2 ImGui_GetItemRectMin() except +

    """
    get size of last item
    """
    ImVec2 ImGui_GetItemRectSize() except +

    """
    [DEBUG] returns English name of the key. Those names a provided for debugging purpose and are not meant to be saved persistently not compared.
    """
    const char* ImGui_GetKeyName(ImGuiKey key) except +

    """
    uses provided repeat rate/delay. return a count, most often 0 or 1 but might be >1 if RepeatRate is small enough that DeltaTime > RepeatRate
    """
    int ImGui_GetKeyPressedAmount(ImGuiKey key, float repeat_delay, float rate) except +

    """
    Viewports
    - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
    - In 'docking' branch with multi-viewport enabled, we extend this concept to have multiple active viewports.
    - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
    return primary/default viewport. This can never be NULL.
    """
    ImGuiViewport* ImGui_GetMainViewport() except +

    """
    return the number of successive mouse-clicks at the time where a click happen (otherwise 0).
    """
    int ImGui_GetMouseClickedCount(ImGuiMouseButton button) except +

    """
    get desired mouse cursor shape. Important: reset in ImGui::NewFrame(), this is updated during the frame. valid before Render(). If you use software rendering by setting io.MouseDrawCursor ImGui will render those for you
    """
    ImGuiMouseCursor ImGui_GetMouseCursor() except +

    """
    return the delta from the initial clicking position while the mouse button is pressed or was just released. This is locked and return 0.0f until the mouse moves past a distance threshold at least once (if lock_threshold < -1.0f, uses io.MouseDraggingThreshold)
    """
    ImVec2 ImGui_GetMouseDragDelta(ImGuiMouseButton button, float lock_threshold) except +

    """
    shortcut to ImGui::GetIO().MousePos provided by user, to be consistent with other calls
    """
    ImVec2 ImGui_GetMousePos() except +

    """
    retrieve mouse position at the time of opening popup we have BeginPopup() into (helper to avoid user backing that value themselves)
    """
    ImVec2 ImGui_GetMousePosOnOpeningCurrentPopup() except +

    """
    (Optional) Platform/OS interface for multi-viewport support
    Read comments around the ImGuiPlatformIO structure for more details.
    Note: You may use GetWindowViewport() to get the current viewport of the current window.
    platform/renderer functions, for backend to setup + viewports list.
    """
    ImGuiPlatformIO* ImGui_GetPlatformIO() except +

    """
    get maximum scrolling amount ~~ ContentSize.x - WindowSize.x - DecorationsSize.x
    """
    float ImGui_GetScrollMaxX() except +

    """
    get maximum scrolling amount ~~ ContentSize.y - WindowSize.y - DecorationsSize.y
    """
    float ImGui_GetScrollMaxY() except +

    """
    Windows Scrolling
    - Any change of Scroll will be applied at the beginning of next frame in the first call to Begin().
    - You may instead use SetNextWindowScroll() prior to calling Begin() to avoid this delay, as an alternative to using SetScrollX()/SetScrollY().
    get scrolling amount [0 .. GetScrollMaxX()]
    """
    float ImGui_GetScrollX() except +

    """
    get scrolling amount [0 .. GetScrollMaxY()]
    """
    float ImGui_GetScrollY() except +
    ImGuiStorage* ImGui_GetStateStorage() except +

    """
    access the Style structure (colors, sizes). Always use PushStyleCol(), PushStyleVar() to modify style mid-frame!
    """
    ImGuiStyle* ImGui_GetStyle() except +

    """
    get a string corresponding to the enum value (for display, saving, etc.).
    """
    const char* ImGui_GetStyleColorName(ImGuiCol idx) except +

    """
    retrieve style color as stored in ImGuiStyle structure. use to feed back into PushStyleColor(), otherwise use GetColorU32() to get style color with style alpha baked in.
    """
    const ImVec4* ImGui_GetStyleColorVec4(ImGuiCol idx) except +

    """
    ~ FontSize
    """
    float ImGui_GetTextLineHeight() except +

    """
    ~ FontSize + style.ItemSpacing.y (distance in pixels between 2 consecutive lines of text)
    """
    float ImGui_GetTextLineHeightWithSpacing() except +

    """
    get global imgui time. incremented by io.DeltaTime every frame.
    """
    double ImGui_GetTime() except +

    """
    horizontal distance preceding label when using TreeNode*() or Bullet() == (g.FontSize + style.FramePadding.x*2) for a regular unframed TreeNode
    """
    float ImGui_GetTreeNodeToLabelSpacing() except +

    """
    get the compiled version string e.g. "1.80 WIP" (essentially the value for IMGUI_VERSION from the compiled version of imgui.cpp)
    """
    const char* ImGui_GetVersion() except +

    """
    content boundaries max for the full window (roughly (0,0)+Size-Scroll) where Size can be overridden with SetNextWindowContentSize(), in window coordinates
    """
    ImVec2 ImGui_GetWindowContentRegionMax() except +

    """
    content boundaries min for the full window (roughly (0,0)-Scroll), in window coordinates
    """
    ImVec2 ImGui_GetWindowContentRegionMin() except +
    ImGuiID ImGui_GetWindowDockID() except +

    """
    get DPI scale currently associated to the current window's viewport.
    """
    float ImGui_GetWindowDpiScale() except +

    """
    get draw list associated to the current window, to append your own drawing primitives
    """
    ImDrawList* ImGui_GetWindowDrawList() except +

    """
    get current window height (shortcut for GetWindowSize().y)
    """
    float ImGui_GetWindowHeight() except +

    """
    get current window position in screen space (useful if you want to do your own drawing via the DrawList API)
    """
    ImVec2 ImGui_GetWindowPos() except +

    """
    get current window size
    """
    ImVec2 ImGui_GetWindowSize() except +

    """
    get viewport currently associated to the current window.
    """
    ImGuiViewport* ImGui_GetWindowViewport() except +

    """
    get current window width (shortcut for GetWindowSize().x)
    """
    float ImGui_GetWindowWidth() except +

    """
    Widgets: Images
    - Read about ImTextureID here: https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples
    Implied uv0 = ImVec2(0, 0), uv1 = ImVec2(1, 1), tint_col = ImVec4(1, 1, 1, 1), border_col = ImVec4(0, 0, 0, 0)
    """
    void ImGui_Image(ImTextureID user_texture_id, ImVec2 size) except +

    """
    Implied uv0 = ImVec2(0, 0), uv1 = ImVec2(1, 1), bg_col = ImVec4(0, 0, 0, 0), tint_col = ImVec4(1, 1, 1, 1)
    """
    bool ImGui_ImageButton(const char* str_id, ImTextureID user_texture_id, ImVec2 size) except +
    bool ImGui_ImageButtonEx(const char* str_id, ImTextureID user_texture_id, ImVec2 size, ImVec2 uv0, ImVec2 uv1, ImVec4 bg_col, ImVec4 tint_col) except +
    void ImGui_ImageEx(ImTextureID user_texture_id, ImVec2 size, ImVec2 uv0, ImVec2 uv1, ImVec4 tint_col, ImVec4 border_col) except +

    """
    Implied indent_w = 0.0f
    """
    void ImGui_Indent() except +

    """
    move content position toward the right, by indent_w, or style.IndentSpacing if indent_w <= 0
    """
    void ImGui_IndentEx(float indent_w) except +

    """
    Implied step = 0.0, step_fast = 0.0, format = "%.6f", flags = 0
    """
    bool ImGui_InputDouble(const char* label, double* v) except +
    bool ImGui_InputDoubleEx(const char* label, double* v, double step, double step_fast, const char* format_, ImGuiInputTextFlags flags) except +

    """
    Implied step = 0.0f, step_fast = 0.0f, format = "%.3f", flags = 0
    """
    bool ImGui_InputFloat(const char* label, float* v) except +

    """
    Implied format = "%.3f", flags = 0
    """
    bool ImGui_InputFloat2(const char* label, float v) except +
    bool ImGui_InputFloat2Ex(const char* label, float v, const char* format_, ImGuiInputTextFlags flags) except +

    """
    Implied format = "%.3f", flags = 0
    """
    bool ImGui_InputFloat3(const char* label, float v) except +
    bool ImGui_InputFloat3Ex(const char* label, float v, const char* format_, ImGuiInputTextFlags flags) except +

    """
    Implied format = "%.3f", flags = 0
    """
    bool ImGui_InputFloat4(const char* label, float v) except +
    bool ImGui_InputFloat4Ex(const char* label, float v, const char* format_, ImGuiInputTextFlags flags) except +
    bool ImGui_InputFloatEx(const char* label, float* v, float step, float step_fast, const char* format_, ImGuiInputTextFlags flags) except +

    """
    Implied step = 1, step_fast = 100, flags = 0
    """
    bool ImGui_InputInt(const char* label, int* v) except +
    bool ImGui_InputInt2(const char* label, int v, ImGuiInputTextFlags flags) except +
    bool ImGui_InputInt3(const char* label, int v, ImGuiInputTextFlags flags) except +
    bool ImGui_InputInt4(const char* label, int v, ImGuiInputTextFlags flags) except +
    bool ImGui_InputIntEx(const char* label, int* v, int step, int step_fast, ImGuiInputTextFlags flags) except +

    """
    Implied p_step = NULL, p_step_fast = NULL, format = NULL, flags = 0
    """
    bool ImGui_InputScalar(const char* label, ImGuiDataType data_type, void* p_data) except +
    bool ImGui_InputScalarEx(const char* label, ImGuiDataType data_type, void* p_data, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +

    """
    Implied p_step = NULL, p_step_fast = NULL, format = NULL, flags = 0
    """
    bool ImGui_InputScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components) except +
    bool ImGui_InputScalarNEx(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +

    """
    Widgets: Input with Keyboard
    - If you want to use InputText() with std::string or any custom dynamic string type, see misc/cpp/imgui_stdlib.h and comments in imgui_demo.cpp.
    - Most of the ImGuiInputTextFlags flags are only useful for InputText() and not for InputFloatX, InputIntX, InputDouble etc.
    Implied callback = NULL, user_data = NULL
    """
    bool ImGui_InputText(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags) except +
    bool ImGui_InputTextEx(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +

    """
    Implied size = ImVec2(0, 0), flags = 0, callback = NULL, user_data = NULL
    """
    bool ImGui_InputTextMultiline(const char* label, char* buf, size_t buf_size) except +
    bool ImGui_InputTextMultilineEx(const char* label, char* buf, size_t buf_size, ImVec2 size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +

    """
    Implied callback = NULL, user_data = NULL
    """
    bool ImGui_InputTextWithHint(const char* label, const char* hint, char* buf, size_t buf_size, ImGuiInputTextFlags flags) except +
    bool ImGui_InputTextWithHintEx(const char* label, const char* hint, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +

    """
    flexible button behavior without the visuals, frequently useful to build custom behaviors using the public api (along with IsItemActive, IsItemHovered, etc.)
    """
    bool ImGui_InvisibleButton(const char* str_id, ImVec2 size, ImGuiButtonFlags flags) except +

    """
    is any item active?
    """
    bool ImGui_IsAnyItemActive() except +

    """
    is any item focused?
    """
    bool ImGui_IsAnyItemFocused() except +

    """
    is any item hovered?
    """
    bool ImGui_IsAnyItemHovered() except +

    """
    [WILL OBSOLETE] is any mouse button held? This was designed for backends, but prefer having backend maintain a mask of held mouse buttons, because upcoming input queue system will make this invalid.
    """
    bool ImGui_IsAnyMouseDown() except +

    """
    was the last item just made active (item was previously inactive).
    """
    bool ImGui_IsItemActivated() except +

    """
    is the last item active? (e.g. button being held, text field being edited. This will continuously return true while holding mouse button on an item. Items that don't interact will always return false)
    """
    bool ImGui_IsItemActive() except +

    """
    Implied mouse_button = 0
    """
    bool ImGui_IsItemClicked() except +

    """
    is the last item hovered and mouse clicked on? (**)  == IsMouseClicked(mouse_button) && IsItemHovered()Important. (**) this is NOT equivalent to the behavior of e.g. Button(). Read comments in function definition.
    """
    bool ImGui_IsItemClickedEx(ImGuiMouseButton mouse_button) except +

    """
    was the last item just made inactive (item was previously active). Useful for Undo/Redo patterns with widgets that require continuous editing.
    """
    bool ImGui_IsItemDeactivated() except +

    """
    was the last item just made inactive and made a value change when it was active? (e.g. Slider/Drag moved). Useful for Undo/Redo patterns with widgets that require continuous editing. Note that you may get false positives (some widgets such as Combo()/ListBox()/Selectable() will return true even when clicking an already selected item).
    """
    bool ImGui_IsItemDeactivatedAfterEdit() except +

    """
    did the last item modify its underlying value this frame? or was pressed? This is generally the same as the "bool" return value of many widgets.
    """
    bool ImGui_IsItemEdited() except +

    """
    is the last item focused for keyboard/gamepad navigation?
    """
    bool ImGui_IsItemFocused() except +

    """
    Item/Widgets Utilities and Query Functions
    - Most of the functions are referring to the previous Item that has been submitted.
    - See Demo Window under "Widgets->Querying Status" for an interactive visualization of most of those functions.
    is the last item hovered? (and usable, aka not blocked by a popup, etc.). See ImGuiHoveredFlags for more options.
    """
    bool ImGui_IsItemHovered(ImGuiHoveredFlags flags) except +

    """
    was the last item open state toggled? set by TreeNode().
    """
    bool ImGui_IsItemToggledOpen() except +

    """
    is the last item visible? (items may be out of sight because of clipping/scrolling)
    """
    bool ImGui_IsItemVisible() except +

    """
    Inputs Utilities: Keyboard/Mouse/Gamepad
    - the ImGuiKey enum contains all possible keyboard, mouse and gamepad inputs (e.g. ImGuiKey_A, ImGuiKey_MouseLeft, ImGuiKey_GamepadDpadUp...).
    - before v1.87, we used ImGuiKey to carry native/user indices as defined by each backends. About use of those legacy ImGuiKey values:
    - without IMGUI_DISABLE_OBSOLETE_KEYIO (legacy support): you can still use your legacy native/user indices (< 512) according to how your backend/engine stored them in io.KeysDown[], but need to cast them to ImGuiKey.
    - with    IMGUI_DISABLE_OBSOLETE_KEYIO (this is the way forward): any use of ImGuiKey will assert with key < 512. GetKeyIndex() is pass-through and therefore deprecated (gone if IMGUI_DISABLE_OBSOLETE_KEYIO is defined).
    is key being held.
    """
    bool ImGui_IsKeyDown(ImGuiKey key) except +

    """
    Implied repeat = true
    """
    bool ImGui_IsKeyPressed(ImGuiKey key) except +

    """
    was key pressed (went from !Down to Down)? if repeat=true, uses io.KeyRepeatDelay / KeyRepeatRate
    """
    bool ImGui_IsKeyPressedEx(ImGuiKey key, bool repeat) except +

    """
    was key released (went from Down to !Down)?
    """
    bool ImGui_IsKeyReleased(ImGuiKey key) except +

    """
    Implied repeat = false
    """
    bool ImGui_IsMouseClicked(ImGuiMouseButton button) except +

    """
    did mouse button clicked? (went from !Down to Down). Same as GetMouseClickedCount() == 1.
    """
    bool ImGui_IsMouseClickedEx(ImGuiMouseButton button, bool repeat) except +

    """
    did mouse button double-clicked? Same as GetMouseClickedCount() == 2. (note that a double-click will also report IsMouseClicked() == true)
    """
    bool ImGui_IsMouseDoubleClicked(ImGuiMouseButton button) except +

    """
    Inputs Utilities: Mouse specific
    - To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
    - You can also use regular integer: it is forever guaranteed that 0=Left, 1=Right, 2=Middle.
    - Dragging operations are only reported after mouse has moved a certain distance away from the initial clicking position (see 'lock_threshold' and 'io.MouseDraggingThreshold')
    is mouse button held?
    """
    bool ImGui_IsMouseDown(ImGuiMouseButton button) except +

    """
    is mouse dragging? (if lock_threshold < -1.0f, uses io.MouseDraggingThreshold)
    """
    bool ImGui_IsMouseDragging(ImGuiMouseButton button, float lock_threshold) except +

    """
    Implied clip = true
    """
    bool ImGui_IsMouseHoveringRect(ImVec2 r_min, ImVec2 r_max) except +

    """
    is mouse hovering given bounding rect (in screen space). clipped by current clipping settings, but disregarding of other consideration of focus/window ordering/popup-block.
    """
    bool ImGui_IsMouseHoveringRectEx(ImVec2 r_min, ImVec2 r_max, bool clip) except +

    """
    by convention we use (-FLT_MAX,-FLT_MAX) to denote that there is no mouse available
    """
    bool ImGui_IsMousePosValid(const ImVec2* mouse_pos) except +

    """
    did mouse button released? (went from Down to !Down)
    """
    bool ImGui_IsMouseReleased(ImGuiMouseButton button) except +

    """
    Popups: query functions
    - IsPopupOpen(): return true if the popup is open at the current BeginPopup() level of the popup stack.
    - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
    - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
    return true if the popup is open.
    """
    bool ImGui_IsPopupOpen(const char* str_id, ImGuiPopupFlags flags) except +

    """
    test if rectangle (in screen space) is visible / not clipped. to perform coarse clipping on user's side.
    """
    bool ImGui_IsRectVisible(ImVec2 rect_min, ImVec2 rect_max) except +

    """
    Miscellaneous Utilities
    test if rectangle (of given size, starting from cursor position) is visible / not clipped.
    """
    bool ImGui_IsRectVisibleBySize(ImVec2 size) except +

    """
    Windows Utilities
    - 'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.
    """
    bool ImGui_IsWindowAppearing() except +
    bool ImGui_IsWindowCollapsed() except +

    """
    is current window docked into another window?
    """
    bool ImGui_IsWindowDocked() except +

    """
    is current window focused? or its root/child, depending on flags. see flags for options.
    """
    bool ImGui_IsWindowFocused(ImGuiFocusedFlags flags) except +

    """
    is current window hovered (and typically: not blocked by a popup/modal)? see flags for options. NB: If you are trying to check whether your mouse should be dispatched to imgui or to your app, you should use the 'io.WantCaptureMouse' boolean for that! Please read the FAQ!
    """
    bool ImGui_IsWindowHovered(ImGuiHoveredFlags flags) except +

    """
    display text+label aligned the same way as value+label widgets
    """
    void ImGui_LabelText(const char* label, const char* fmt) except +
    void ImGui_LabelTextV(const char* label, const char* fmt) except +
    bool ImGui_ListBox(const char* label, int* current_item, const char* items, int items_count, int height_in_items) except +

    """
    Implied height_in_items = -1
    """
    bool ImGui_ListBoxCallback(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count) except +
    bool ImGui_ListBoxCallbackEx(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int height_in_items) except +

    """
    Settings/.Ini Utilities
    - The disk functions are automatically called if io.IniFilename != NULL (default is "imgui.ini").
    - Set io.IniFilename to NULL to load/save manually. Read io.WantSaveIniSettings description about handling .ini saving manually.
    - Important: default value "imgui.ini" is relative to current working dir! Most apps will want to lock this to an absolute path (e.g. same path as executables).
    call after CreateContext() and before the first call to NewFrame(). NewFrame() automatically calls LoadIniSettingsFromDisk(io.IniFilename).
    """
    void ImGui_LoadIniSettingsFromDisk(const char* ini_filename) except +

    """
    call after CreateContext() and before the first call to NewFrame() to provide .ini data from your own data source.
    """
    void ImGui_LoadIniSettingsFromMemory(const char* ini_data, size_t ini_size) except +

    """
    helper to display buttons for logging to tty/file/clipboard
    """
    void ImGui_LogButtons() except +

    """
    stop logging (close file, etc.)
    """
    void ImGui_LogFinish() except +

    """
    pass text data straight to log (without being displayed)
    """
    void ImGui_LogText(const char* fmt) except +
    void ImGui_LogTextV(const char* fmt) except +

    """
    start logging to OS clipboard
    """
    void ImGui_LogToClipboard(int auto_open_depth) except +

    """
    start logging to file
    """
    void ImGui_LogToFile(int auto_open_depth, const char* filename) except +

    """
    Logging/Capture
    - All text output from the interface can be captured into tty/file/clipboard. By default, tree nodes are automatically opened during logging.
    start logging to tty (stdout)
    """
    void ImGui_LogToTTY(int auto_open_depth) except +
    void* ImGui_MemAlloc(size_t size) except +
    void ImGui_MemFree(void* ptr) except +

    """
    Implied shortcut = NULL, selected = false, enabled = true
    """
    bool ImGui_MenuItem(const char* label) except +

    """
    return true when activated + toggle (*p_selected) if p_selected != NULL
    """
    bool ImGui_MenuItemBoolPtr(const char* label, const char* shortcut, bool* p_selected, bool enabled) except +

    """
    return true when activated.
    """
    bool ImGui_MenuItemEx(const char* label, const char* shortcut, bool selected, bool enabled) except +

    """
    start a new Dear ImGui frame, you can submit any command from this point until Render()/EndFrame().
    """
    void ImGui_NewFrame() except +

    """
    undo a SameLine() or force a new line when in a horizontal-layout context.
    """
    void ImGui_NewLine() except +

    """
    next column, defaults to current row or next row if the current row is finished
    """
    void ImGui_NextColumn() except +

    """
    Popups: open/close functions
    - OpenPopup(): set popup state to open. ImGuiPopupFlags are available for opening options.
    - If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
    - CloseCurrentPopup(): use inside the BeginPopup()/EndPopup() scope to close manually.
    - CloseCurrentPopup() is called by default by Selectable()/MenuItem() when activated (FIXME: need some options).
    - Use ImGuiPopupFlags_NoOpenOverExistingPopup to avoid opening a popup if there's already one at the same level. This is equivalent to e.g. testing for !IsAnyPopupOpen() prior to OpenPopup().
    - Use IsWindowAppearing() after BeginPopup() to tell if a window just opened.
    - IMPORTANT: Notice that for OpenPopupOnItemClick() we exceptionally default flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter
    call to mark popup as open (don't call every frame!).
    """
    void ImGui_OpenPopup(const char* str_id, ImGuiPopupFlags popup_flags) except +

    """
    id overload to facilitate calling from nested stacks
    """
    void ImGui_OpenPopupID(ImGuiID id_, ImGuiPopupFlags popup_flags) except +

    """
    helper to open popup when clicked on last item. Default to ImGuiPopupFlags_MouseButtonRight == 1. (note: actually triggers on the mouse _released_ event to be consistent with popup behaviors)
    """
    void ImGui_OpenPopupOnItemClick(const char* str_id, ImGuiPopupFlags popup_flags) except +

    """
    Implied values_offset = 0, overlay_text = NULL, scale_min = FLT_MAX, scale_max = FLT_MAX, graph_size = ImVec2(0, 0), stride = sizeof(float)
    """
    void ImGui_PlotHistogram(const char* label, const float* values, int values_count) except +

    """
    Implied values_offset = 0, overlay_text = NULL, scale_min = FLT_MAX, scale_max = FLT_MAX, graph_size = ImVec2(0, 0)
    """
    void ImGui_PlotHistogramCallback(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count) except +
    void ImGui_PlotHistogramCallbackEx(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void ImGui_PlotHistogramEx(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +

    """
    Widgets: Data Plotting
    - Consider using ImPlot (https://github.com/epezent/implot) which is much better!
    Implied values_offset = 0, overlay_text = NULL, scale_min = FLT_MAX, scale_max = FLT_MAX, graph_size = ImVec2(0, 0), stride = sizeof(float)
    """
    void ImGui_PlotLines(const char* label, const float* values, int values_count) except +

    """
    Implied values_offset = 0, overlay_text = NULL, scale_min = FLT_MAX, scale_max = FLT_MAX, graph_size = ImVec2(0, 0)
    """
    void ImGui_PlotLinesCallback(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count) except +
    void ImGui_PlotLinesCallbackEx(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void ImGui_PlotLinesEx(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +
    void ImGui_PopButtonRepeat() except +
    void ImGui_PopClipRect() except +
    void ImGui_PopFont() except +

    """
    pop from the ID stack.
    """
    void ImGui_PopID() except +
    void ImGui_PopItemWidth() except +

    """
    Implied count = 1
    """
    void ImGui_PopStyleColor() except +
    void ImGui_PopStyleColorEx(int count) except +

    """
    Implied count = 1
    """
    void ImGui_PopStyleVar() except +
    void ImGui_PopStyleVarEx(int count) except +
    void ImGui_PopTabStop() except +
    void ImGui_PopTextWrapPos() except +
    void ImGui_ProgressBar(float fraction, ImVec2 size_arg, const char* overlay) except +

    """
    in 'repeat' mode, Button*() functions return repeated true in a typematic manner (using io.KeyRepeatDelay/io.KeyRepeatRate setting). Note that you can call IsItemActive() after any Button() to tell if the button is held in the current frame.
    """
    void ImGui_PushButtonRepeat(bool repeat) except +

    """
    Clipping
    - Mouse hovering is affected by ImGui::PushClipRect() calls, unlike direct calls to ImDrawList::PushClipRect() which are render only.
    """
    void ImGui_PushClipRect(ImVec2 clip_rect_min, ImVec2 clip_rect_max, bool intersect_with_current_clip_rect) except +

    """
    Parameters stacks (shared)
    use NULL as a shortcut to push default font
    """
    void ImGui_PushFont(ImFont* font) except +

    """
    ID stack/scopes
    Read the FAQ (docs/FAQ.md or http://dearimgui.org/faq) for more details about how ID are handled in dear imgui.
    - Those questions are answered and impacted by understanding of the ID stack system:
    - "Q: Why is my widget not reacting when I click on it?"
    - "Q: How can I have widgets with an empty label?"
    - "Q: How can I have multiple widgets with the same label?"
    - Short version: ID are hashes of the entire ID stack. If you are creating widgets in a loop you most likely
    want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them.
    - You can also use the "Label##foobar" syntax within widget label to distinguish them from each others.
    - In this header file we use the "label"/"name" terminology to denote a string that will be displayed + used as an ID,
    whereas "str_id" denote a string that is only used as an ID and not normally displayed.
    push string into the ID stack (will hash string).
    """
    void ImGui_PushID(const char* str_id) except +

    """
    push integer into the ID stack (will hash integer).
    """
    void ImGui_PushIDInt(int int_id) except +

    """
    push pointer into the ID stack (will hash pointer).
    """
    void ImGui_PushIDPtr(const void* ptr_id) except +

    """
    push string into the ID stack (will hash string).
    """
    void ImGui_PushIDStr(const char* str_id_begin, const char* str_id_end) except +

    """
    Parameters stacks (current window)
    push width of items for common large "item+label" widgets. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -FLT_MIN always align width to the right side).
    """
    void ImGui_PushItemWidth(float item_width) except +

    """
    modify a style color. always use this if you modify the style after NewFrame().
    """
    void ImGui_PushStyleColor(ImGuiCol idx, ImU32 col) except +
    void ImGui_PushStyleColorImVec4(ImGuiCol idx, ImVec4 col) except +

    """
    modify a style float variable. always use this if you modify the style after NewFrame().
    """
    void ImGui_PushStyleVar(ImGuiStyleVar idx, float val) except +

    """
    modify a style ImVec2 variable. always use this if you modify the style after NewFrame().
    """
    void ImGui_PushStyleVarImVec2(ImGuiStyleVar idx, ImVec2 val) except +

    """
    == tab stop enable. Allow focusing using TAB/Shift-TAB, enabled by default but you can disable it for certain widgets
    """
    void ImGui_PushTabStop(bool tab_stop) except +

    """
    push word-wrapping position for Text*() commands. < 0.0f: no wrapping; 0.0f: wrap to end of window (or column); > 0.0f: wrap at 'wrap_pos_x' position in window local space
    """
    void ImGui_PushTextWrapPos(float wrap_local_pos_x) except +

    """
    use with e.g. if (RadioButton("one", my_value==1)) { my_value = 1; }
    """
    bool ImGui_RadioButton(const char* label, bool active) except +

    """
    shortcut to handle the above pattern when value is an integer
    """
    bool ImGui_RadioButtonIntPtr(const char* label, int* v, int v_button) except +

    """
    ends the Dear ImGui frame, finalize the draw data. You can then get call GetDrawData().
    """
    void ImGui_Render() except +

    """
    Implied platform_render_arg = NULL, renderer_render_arg = NULL
    """
    void ImGui_RenderPlatformWindowsDefault() except +

    """
    call in main loop. will call RenderWindow/SwapBuffers platform functions for each secondary viewport which doesn't have the ImGuiViewportFlags_Minimized flag set. May be reimplemented by user for custom rendering needs.
    """
    void ImGui_RenderPlatformWindowsDefaultEx(void* platform_render_arg, void* renderer_render_arg) except +

    """
    Implied button = 0
    """
    void ImGui_ResetMouseDragDelta() except +

    """

    """
    void ImGui_ResetMouseDragDeltaEx(ImGuiMouseButton button) except +

    """
    Implied offset_from_start_x = 0.0f, spacing = -1.0f
    """
    void ImGui_SameLine() except +

    """
    call between widgets or groups to layout them horizontally. X position given in window coordinates.
    """
    void ImGui_SameLineEx(float offset_from_start_x, float spacing) except +

    """
    this is automatically called (if io.IniFilename is not empty) a few seconds after any modification that should be reflected in the .ini file (and also by DestroyContext).
    """
    void ImGui_SaveIniSettingsToDisk(const char* ini_filename) except +

    """
    return a zero-terminated string with the .ini data which you can save by your own mean. call when io.WantSaveIniSettings is set, then save data by your own mean and clear io.WantSaveIniSettings.
    """
    const char* ImGui_SaveIniSettingsToMemory(size_t* out_ini_size) except +

    """
    Widgets: Selectables
    - A selectable highlights when hovered, and can display another color when selected.
    - Neighbors selectable extend their highlight bounds in order to leave no gap between them. This is so a series of selected Selectable appear contiguous.
    Implied selected = false, flags = 0, size = ImVec2(0, 0)
    """
    bool ImGui_Selectable(const char* label) except +

    """
    Implied size = ImVec2(0, 0)
    """
    bool ImGui_SelectableBoolPtr(const char* label, bool* p_selected, ImGuiSelectableFlags flags) except +

    """
    "bool* p_selected" point to the selection state (read-write), as a convenient helper.
    """
    bool ImGui_SelectableBoolPtrEx(const char* label, bool* p_selected, ImGuiSelectableFlags flags, ImVec2 size) except +

    """
    "bool selected" carry the selection state (read-only). Selectable() is clicked is returns true so you can modify your selection state. size.x==0.0: use remaining width, size.x>0.0: specify width. size.y==0.0: use label height, size.y>0.0: specify height
    """
    bool ImGui_SelectableEx(const char* label, bool selected, ImGuiSelectableFlags flags, ImVec2 size) except +

    """
    Cursor / Layout
    - By "cursor" we mean the current output position.
    - The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
    - You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
    - Attention! We currently have inconsistencies between window-local and absolute positions we will aim to fix with future API:
    Window-local coordinates:   SameLine(), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), GetContentRegionMax(), GetWindowContentRegion*(), PushTextWrapPos()
    Absolute coordinate:        GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions.
    separator, generally horizontal. inside a menu bar or in horizontal layout mode, this becomes a vertical separator.
    """
    void ImGui_Separator() except +

    """
    currently: formatted text with an horizontal line
    """
    void ImGui_SeparatorText(const char* label) except +

    """
    Memory Allocators
    - Those functions are not reliant on the current context.
    - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
    for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for more details.
    """
    void ImGui_SetAllocatorFunctions(ImGuiMemAllocFunc alloc_func, ImGuiMemFreeFunc free_func, void* user_data) except +
    void ImGui_SetClipboardText(const char* text) except +

    """
    initialize current options (generally on application startup) if you want to select a default format, picker type, etc. User will be able to change many settings, unless you pass the _NoOptions flag to your calls.
    """
    void ImGui_SetColorEditOptions(ImGuiColorEditFlags flags) except +

    """
    set position of column line (in pixels, from the left side of the contents region). pass -1 to use current column
    """
    void ImGui_SetColumnOffset(int column_index, float offset_x) except +

    """
    set column width (in pixels). pass -1 to use current column
    """
    void ImGui_SetColumnWidth(int column_index, float width) except +
    void ImGui_SetCurrentContext(ImGuiContext* ctx) except +

    """
    are using the main, absolute coordinate system.
    """
    void ImGui_SetCursorPos(ImVec2 local_pos) except +

    """
    GetWindowPos() + GetCursorPos() == GetCursorScreenPos() etc.)
    """
    void ImGui_SetCursorPosX(float local_x) except +

    """

    """
    void ImGui_SetCursorPosY(float local_y) except +

    """
    cursor position in absolute coordinates
    """
    void ImGui_SetCursorScreenPos(ImVec2 pos) except +

    """
    type is a user defined string of maximum 32 characters. Strings starting with '_' are reserved for dear imgui internal types. Data is copied and held by imgui. Return true when payload has been accepted.
    """
    bool ImGui_SetDragDropPayload(const char* type_, const void* data, size_t sz, ImGuiCond cond) except +

    """
    allow last item to be overlapped by a subsequent item. sometimes useful with invisible buttons, selectables, etc. to catch unused area.
    """
    void ImGui_SetItemAllowOverlap() except +

    """
    Focus, Activation
    - Prefer using "SetItemDefaultFocus()" over "if (IsWindowAppearing()) SetScrollHereY()" when applicable to signify "this is the default item"
    make last item the default focused item of a window.
    """
    void ImGui_SetItemDefaultFocus() except +

    """
    Implied offset = 0
    """
    void ImGui_SetKeyboardFocusHere() except +

    """
    focus keyboard on the next widget. Use positive 'offset' to access sub components of a multiple component widget. Use -1 to access previous widget.
    """
    void ImGui_SetKeyboardFocusHereEx(int offset) except +

    """
    set desired mouse cursor shape
    """
    void ImGui_SetMouseCursor(ImGuiMouseCursor cursor_type) except +

    """
    Override io.WantCaptureKeyboard flag next frame (said flag is left for your application to handle, typically when true it instructs your app to ignore inputs). e.g. force capture keyboard when your widget is being hovered. This is equivalent to setting "io.WantCaptureKeyboard = want_capture_keyboard"; after the next NewFrame() call.
    """
    void ImGui_SetNextFrameWantCaptureKeyboard(bool want_capture_keyboard) except +

    """
    Override io.WantCaptureMouse flag next frame (said flag is left for your application to handle, typical when true it instucts your app to ignore inputs). This is equivalent to setting "io.WantCaptureMouse = want_capture_mouse;" after the next NewFrame() call.
    """
    void ImGui_SetNextFrameWantCaptureMouse(bool want_capture_mouse) except +

    """
    set next TreeNode/CollapsingHeader open state.
    """
    void ImGui_SetNextItemOpen(bool is_open, ImGuiCond cond) except +

    """
    set width of the _next_ common large "item+label" widget. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -FLT_MIN always align width to the right side)
    """
    void ImGui_SetNextItemWidth(float item_width) except +

    """
    set next window background color alpha. helper to easily override the Alpha component of ImGuiCol_WindowBg/ChildBg/PopupBg. you may also use ImGuiWindowFlags_NoBackground.
    """
    void ImGui_SetNextWindowBgAlpha(float alpha) except +

    """
    set next window class (control docking compatibility + provide hints to platform backend via custom viewport flags and platform parent/child relationship)
    """
    void ImGui_SetNextWindowClass(const ImGuiWindowClass* window_class) except +

    """
    set next window collapsed state. call before Begin()
    """
    void ImGui_SetNextWindowCollapsed(bool collapsed, ImGuiCond cond) except +

    """
    set next window content size (~ scrollable client area, which enforce the range of scrollbars). Not including window decorations (title bar, menu bar, etc.) nor WindowPadding. set an axis to 0.0f to leave it automatic. call before Begin()
    """
    void ImGui_SetNextWindowContentSize(ImVec2 size) except +

    """
    set next window dock id
    """
    void ImGui_SetNextWindowDockID(ImGuiID dock_id, ImGuiCond cond) except +

    """
    set next window to be focused / top-most. call before Begin()
    """
    void ImGui_SetNextWindowFocus() except +

    """
    Window manipulation
    - Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
    Implied pivot = ImVec2(0, 0)
    """
    void ImGui_SetNextWindowPos(ImVec2 pos, ImGuiCond cond) except +

    """
    set next window position. call before Begin(). use pivot=(0.5f,0.5f) to center on given point, etc.
    """
    void ImGui_SetNextWindowPosEx(ImVec2 pos, ImGuiCond cond, ImVec2 pivot) except +

    """
    set next window scrolling value (use < 0.0f to not affect a given axis).
    """
    void ImGui_SetNextWindowScroll(ImVec2 scroll) except +

    """
    set next window size. set axis to 0.0f to force an auto-fit on this axis. call before Begin()
    """
    void ImGui_SetNextWindowSize(ImVec2 size, ImGuiCond cond) except +

    """
    set next window size limits. use -1,-1 on either X/Y axis to preserve the current size. Sizes will be rounded down. Use callback to apply non-trivial programmatic constraints.
    """
    void ImGui_SetNextWindowSizeConstraints(ImVec2 size_min, ImVec2 size_max, ImGuiSizeCallback custom_callback, void* custom_callback_data) except +

    """
    set next window viewport
    """
    void ImGui_SetNextWindowViewport(ImGuiID viewport_id) except +

    """
    adjust scrolling amount to make given position visible. Generally GetCursorStartPos() + offset to compute a valid position.
    """
    void ImGui_SetScrollFromPosX(float local_x, float center_x_ratio) except +

    """
    adjust scrolling amount to make given position visible. Generally GetCursorStartPos() + offset to compute a valid position.
    """
    void ImGui_SetScrollFromPosY(float local_y, float center_y_ratio) except +

    """
    adjust scrolling amount to make current cursor position visible. center_x_ratio=0.0: left, 0.5: center, 1.0: right. When using to make a "default/current item" visible, consider using SetItemDefaultFocus() instead.
    """
    void ImGui_SetScrollHereX(float center_x_ratio) except +

    """
    adjust scrolling amount to make current cursor position visible. center_y_ratio=0.0: top, 0.5: center, 1.0: bottom. When using to make a "default/current item" visible, consider using SetItemDefaultFocus() instead.
    """
    void ImGui_SetScrollHereY(float center_y_ratio) except +

    """
    set scrolling amount [0 .. GetScrollMaxX()]
    """
    void ImGui_SetScrollX(float scroll_x) except +

    """
    set scrolling amount [0 .. GetScrollMaxY()]
    """
    void ImGui_SetScrollY(float scroll_y) except +

    """
    replace current window storage with our own (if you want to manipulate it yourself, typically clear subsection of it)
    """
    void ImGui_SetStateStorage(ImGuiStorage* storage) except +

    """
    notify TabBar or Docking system of a closed tab/window ahead (useful to reduce visual flicker on reorderable tab bars). For tab-bar: call after BeginTabBar() and before Tab submissions. Otherwise call with a window name.
    """
    void ImGui_SetTabItemClosed(const char* tab_or_docked_window_label) except +

    """
    set a text-only tooltip, typically use with ImGui::IsItemHovered(). override any previous call to SetTooltip().
    """
    void ImGui_SetTooltip(const char* fmt) except +
    void ImGui_SetTooltipV(const char* fmt) except +

    """
    (not recommended) set current window collapsed state. prefer using SetNextWindowCollapsed().
    """
    void ImGui_SetWindowCollapsed(bool collapsed, ImGuiCond cond) except +

    """
    set named window collapsed state
    """
    void ImGui_SetWindowCollapsedStr(const char* name, bool collapsed, ImGuiCond cond) except +

    """
    (not recommended) set current window to be focused / top-most. prefer using SetNextWindowFocus().
    """
    void ImGui_SetWindowFocus() except +

    """
    set named window to be focused / top-most. use NULL to remove focus.
    """
    void ImGui_SetWindowFocusStr(const char* name) except +

    """
    [OBSOLETE] set font scale. Adjust IO.FontGlobalScale if you want to scale all windows. This is an old API! For correct scaling, prefer to reload font + rebuild ImFontAtlas + call style.ScaleAllSizes().
    """
    void ImGui_SetWindowFontScale(float scale) except +

    """
    (not recommended) set current window position - call within Begin()/End(). prefer using SetNextWindowPos(), as this may incur tearing and side-effects.
    """
    void ImGui_SetWindowPos(ImVec2 pos, ImGuiCond cond) except +

    """
    set named window position.
    """
    void ImGui_SetWindowPosStr(const char* name, ImVec2 pos, ImGuiCond cond) except +

    """
    (not recommended) set current window size - call within Begin()/End(). set to ImVec2(0, 0) to force an auto-fit. prefer using SetNextWindowSize(), as this may incur tearing and minor side-effects.
    """
    void ImGui_SetWindowSize(ImVec2 size, ImGuiCond cond) except +

    """
    set named window size. set axis to 0.0f to force an auto-fit on this axis.
    """
    void ImGui_SetWindowSizeStr(const char* name, ImVec2 size, ImGuiCond cond) except +

    """
    create About window. display Dear ImGui version, credits and build/system information.
    """
    void ImGui_ShowAboutWindow(bool* p_open) except +

    """
    create Debug Log window. display a simplified log of important dear imgui events.
    """
    void ImGui_ShowDebugLogWindow(bool* p_open) except +

    """
    Demo, Debug, Information
    create Demo window. demonstrate most ImGui features. call this to learn about the library! try to make it always available in your application!
    """
    void ImGui_ShowDemoWindow(bool* p_open) except +

    """
    add font selector block (not a window), essentially a combo listing the loaded fonts.
    """
    void ImGui_ShowFontSelector(const char* label) except +

    """
    create Metrics/Debugger window. display Dear ImGui internals: windows, draw commands, various internal state, etc.
    """
    void ImGui_ShowMetricsWindow(bool* p_open) except +

    """
    create Stack Tool window. hover items with mouse to query information about the source of their unique ID.
    """
    void ImGui_ShowStackToolWindow(bool* p_open) except +

    """
    add style editor block (not a window). you can pass in a reference ImGuiStyle structure to compare to, revert to and save to (else it uses the default style)
    """
    void ImGui_ShowStyleEditor(ImGuiStyle* ref) except +

    """
    add style selector block (not a window), essentially a combo listing the default styles.
    """
    bool ImGui_ShowStyleSelector(const char* label) except +

    """
    add basic help/info block (not a window): how to manipulate ImGui as an end-user (mouse/keyboard controls).
    """
    void ImGui_ShowUserGuide() except +

    """
    Implied v_degrees_min = -360.0f, v_degrees_max = +360.0f, format = "%.0f deg", flags = 0
    """
    bool ImGui_SliderAngle(const char* label, float* v_rad) except +
    bool ImGui_SliderAngleEx(const char* label, float* v_rad, float v_degrees_min, float v_degrees_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Widgets: Regular Sliders
    - CTRL+Click on any slider to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
    - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
    - Format string may also be set to NULL or use the default format ("%f" or "%d").
    - Legacy: Pre-1.78 there are SliderXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
    If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
    Implied format = "%.3f", flags = 0
    """
    bool ImGui_SliderFloat(const char* label, float* v, float v_min, float v_max) except +

    """
    Implied format = "%.3f", flags = 0
    """
    bool ImGui_SliderFloat2(const char* label, float v, float v_min, float v_max) except +
    bool ImGui_SliderFloat2Ex(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied format = "%.3f", flags = 0
    """
    bool ImGui_SliderFloat3(const char* label, float v, float v_min, float v_max) except +
    bool ImGui_SliderFloat3Ex(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied format = "%.3f", flags = 0
    """
    bool ImGui_SliderFloat4(const char* label, float v, float v_min, float v_max) except +
    bool ImGui_SliderFloat4Ex(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    adjust format to decorate the value with a prefix or a suffix for in-slider labels or unit display.
    """
    bool ImGui_SliderFloatEx(const char* label, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied format = "%d", flags = 0
    """
    bool ImGui_SliderInt(const char* label, int* v, int v_min, int v_max) except +

    """
    Implied format = "%d", flags = 0
    """
    bool ImGui_SliderInt2(const char* label, int v, int v_min, int v_max) except +
    bool ImGui_SliderInt2Ex(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied format = "%d", flags = 0
    """
    bool ImGui_SliderInt3(const char* label, int v, int v_min, int v_max) except +
    bool ImGui_SliderInt3Ex(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied format = "%d", flags = 0
    """
    bool ImGui_SliderInt4(const char* label, int v, int v_min, int v_max) except +
    bool ImGui_SliderInt4Ex(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderIntEx(const char* label, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied format = NULL, flags = 0
    """
    bool ImGui_SliderScalar(const char* label, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max) except +
    bool ImGui_SliderScalarEx(const char* label, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied format = NULL, flags = 0
    """
    bool ImGui_SliderScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_min, const void* p_max) except +
    bool ImGui_SliderScalarNEx(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    button with FramePadding=(0,0) to easily embed within text
    """
    bool ImGui_SmallButton(const char* label) except +

    """
    add vertical spacing.
    """
    void ImGui_Spacing() except +

    """
    classic imgui style
    """
    void ImGui_StyleColorsClassic(ImGuiStyle* dst) except +

    """
    Styles
    new, recommended style (default)
    """
    void ImGui_StyleColorsDark(ImGuiStyle* dst) except +

    """
    best used with borders and a custom, thicker font
    """
    void ImGui_StyleColorsLight(ImGuiStyle* dst) except +

    """
    create a Tab behaving like a button. return true when clicked. cannot be selected in the tab bar.
    """
    bool ImGui_TabItemButton(const char* label, ImGuiTabItemFlags flags) except +

    """
    return number of columns (value passed to BeginTable)
    """
    int ImGui_TableGetColumnCount() except +

    """
    return column flags so you can query their Enabled/Visible/Sorted/Hovered status flags. Pass -1 to use current column.
    """
    ImGuiTableColumnFlags ImGui_TableGetColumnFlags(int column_n) except +

    """
    return current column index.
    """
    int ImGui_TableGetColumnIndex() except +

    """
    return "" if column didn't have a name declared by TableSetupColumn(). Pass -1 to use current column.
    """
    const char* ImGui_TableGetColumnName(int column_n) except +

    """
    return current row index.
    """
    int ImGui_TableGetRowIndex() except +

    """
    Tables: Sorting & Miscellaneous functions
    - Sorting: call TableGetSortSpecs() to retrieve latest sort specs for the table. NULL when not sorting.
    When 'sort_specs->SpecsDirty == true' you should sort your data. It will be true when sorting specs have
    changed since last call, or the first time. Make sure to set 'SpecsDirty = false' after sorting,
    else you may wastefully sort your data every frame!
    - Functions args 'int column_n' treat the default value of -1 as the same as passing the current column index.
    get latest sort specs for the table (NULL if not sorting).  Lifetime: don't hold on this pointer over multiple frames or past any subsequent call to BeginTable().
    """
    ImGuiTableSortSpecs* ImGui_TableGetSortSpecs() except +

    """
    submit one header cell manually (rarely used)
    """
    void ImGui_TableHeader(const char* label) except +

    """
    submit all headers cells based on data provided to TableSetupColumn() + submit context menu
    """
    void ImGui_TableHeadersRow() except +

    """
    append into the next column (or first column of next row if currently in last column). Return true when column is visible.
    """
    bool ImGui_TableNextColumn() except +

    """
    Implied row_flags = 0, min_row_height = 0.0f
    """
    void ImGui_TableNextRow() except +

    """
    append into the first cell of a new row.
    """
    void ImGui_TableNextRowEx(ImGuiTableRowFlags row_flags, float min_row_height) except +

    """
    change the color of a cell, row, or column. See ImGuiTableBgTarget_ flags for details.
    """
    void ImGui_TableSetBgColor(ImGuiTableBgTarget target, ImU32 color, int column_n) except +

    """
    change user accessible enabled/disabled state of a column. Set to false to hide the column. User can use the context menu to change this themselves (right-click in headers, or right-click in columns body with ImGuiTableFlags_ContextMenuInBody)
    """
    void ImGui_TableSetColumnEnabled(int column_n, bool v) except +

    """
    append into the specified column. Return true when column is visible.
    """
    bool ImGui_TableSetColumnIndex(int column_n) except +

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
    void ImGui_TableSetupColumn(const char* label, ImGuiTableColumnFlags flags) except +
    void ImGui_TableSetupColumnEx(const char* label, ImGuiTableColumnFlags flags, float init_width_or_weight, ImGuiID user_id) except +

    """
    lock columns/rows so they stay visible when scrolled.
    """
    void ImGui_TableSetupScrollFreeze(int cols, int rows) except +

    """
    formatted text
    """
    void ImGui_Text(const char* fmt) except +

    """
    shortcut for PushStyleColor(ImGuiCol_Text, col); Text(fmt, ...); PopStyleColor();
    """
    void ImGui_TextColored(ImVec4 col, const char* fmt) except +
    void ImGui_TextColoredV(ImVec4 col, const char* fmt) except +

    """
    shortcut for PushStyleColor(ImGuiCol_Text, style.Colors[ImGuiCol_TextDisabled]); Text(fmt, ...); PopStyleColor();
    """
    void ImGui_TextDisabled(const char* fmt) except +
    void ImGui_TextDisabledV(const char* fmt) except +

    """
    Widgets: Text
    Implied text_end = NULL
    """
    void ImGui_TextUnformatted(const char* text) except +

    """
    raw text without formatting. Roughly equivalent to Text("%s", text) but: A) doesn't require null terminated string if 'text_end' is specified, B) it's faster, no memory copy is done, no buffer size limits, recommended for long chunks of text.
    """
    void ImGui_TextUnformattedEx(const char* text, const char* text_end) except +
    void ImGui_TextV(const char* fmt) except +

    """
    shortcut for PushTextWrapPos(0.0f); Text(fmt, ...); PopTextWrapPos();. Note that this won't work on an auto-resizing window if there's no other widgets to extend the window width, yoy may need to set a size using SetNextWindowSize().
    """
    void ImGui_TextWrapped(const char* fmt) except +
    void ImGui_TextWrappedV(const char* fmt) except +

    """
    Widgets: Trees
    - TreeNode functions return true when the node is open, in which case you need to also call TreePop() when you are finished displaying the tree node contents.
    """
    bool ImGui_TreeNode(const char* label) except +
    bool ImGui_TreeNodeEx(const char* label, ImGuiTreeNodeFlags flags) except +
    bool ImGui_TreeNodeExPtr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodeExStr(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodeExV(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodeExVPtr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt) except +

    """
    "
    """
    bool ImGui_TreeNodePtr(const void* ptr_id, const char* fmt) except +

    """
    helper variation to easily decorelate the id from the displayed string. Read the FAQ about why and how to use ID. to align arbitrary text at the same level as a TreeNode() you can use Bullet().
    """
    bool ImGui_TreeNodeStr(const char* str_id, const char* fmt) except +
    bool ImGui_TreeNodeV(const char* str_id, const char* fmt) except +
    bool ImGui_TreeNodeVPtr(const void* ptr_id, const char* fmt) except +

    """
    ~ Unindent()+PopId()
    """
    void ImGui_TreePop() except +

    """
    ~ Indent()+PushId(). Already called by TreeNode() when returning true, but you can call TreePush/TreePop yourself if desired.
    """
    void ImGui_TreePush(const char* str_id) except +

    """
    "
    """
    void ImGui_TreePushPtr(const void* ptr_id) except +

    """
    Implied indent_w = 0.0f
    """
    void ImGui_Unindent() except +

    """
    move content position back to the left, by indent_w, or style.IndentSpacing if indent_w <= 0
    """
    void ImGui_UnindentEx(float indent_w) except +

    """
    call in main loop. will call CreateWindow/ResizeWindow/etc. platform functions for each secondary viewport, and DestroyWindow for each inactive viewport.
    """
    void ImGui_UpdatePlatformWindows() except +

    """
    Implied format = "%.3f", flags = 0
    """
    bool ImGui_VSliderFloat(const char* label, ImVec2 size, float* v, float v_min, float v_max) except +
    bool ImGui_VSliderFloatEx(const char* label, ImVec2 size, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied format = "%d", flags = 0
    """
    bool ImGui_VSliderInt(const char* label, ImVec2 size, int* v, int v_min, int v_max) except +
    bool ImGui_VSliderIntEx(const char* label, ImVec2 size, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Implied format = NULL, flags = 0
    """
    bool ImGui_VSliderScalar(const char* label, ImVec2 size, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max) except +
    bool ImGui_VSliderScalarEx(const char* label, ImVec2 size, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    """
    Construct a zero-size ImVector<> (of any type). This is primarily useful when calling ImFontGlyphRangesBuilder_BuildRanges()
    """
    void ImVector_Construct(void* vector) except +

    """
    Destruct an ImVector<> (of any type). Important: Frees the vector memory but does not call destructors on contained objects (if they have them)
    """
    void ImVector_Destruct(void* vector) except +


