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


    # Enumerations
    # - We don't use strongly typed enums much because they add constraints (can't extend in private code, can't store typed in bit fields, extra casting on iteration)
    # - Tip: Use your programming IDE navigation facilities on the names in the _central column_ below to find the actual flags/enum lists!
    # In Visual Studio IDE: CTRL+comma ("Edit.GoToAll") can follow symbols in comments, whereas CTRL+F12 ("Edit.GoToImplementation") cannot.
    # With Visual Assist installed: ALT+G ("VAssistX.GoToImplementation") can also follow symbols in comments.
    ctypedef int ImGuiKey                  # -> enum imguikey              // enum: a key identifier (imguikey_xxx or imguimod_xxx value)
    ctypedef int ImGuiMouseSource          # -> enum imguimousesource      // enum; a mouse input source identifier (mouse, touchscreen, pen)
    ctypedef int ImGuiCol                  # -> enum imguicol_             // enum: a color identifier for styling
    ctypedef int ImGuiCond                 # -> enum imguicond_            // enum: a condition for many set*() functions
    ctypedef int ImGuiDataType             # -> enum imguidatatype_        // enum: a primary data type
    ctypedef int ImGuiDir                  # -> enum imguidir_             // enum: a cardinal direction
    ctypedef int ImGuiMouseButton          # -> enum imguimousebutton_     // enum: a mouse button identifier (0=left, 1=right, 2=middle)
    ctypedef int ImGuiMouseCursor          # -> enum imguimousecursor_     // enum: a mouse cursor shape
    ctypedef int ImGuiSortDirection        # -> enum imguisortdirection_   // enum: a sorting direction (ascending or descending)
    ctypedef int ImGuiStyleVar             # -> enum imguistylevar_        // enum: a variable identifier for styling
    ctypedef int ImGuiTableBgTarget        # -> enum imguitablebgtarget_   // enum: a color target for tablesetbgcolor()

    # Flags (declared as int for compatibility with old C++, to allow using as flags without overhead, and to not pollute the top of this file)
    # - Tip: Use your programming IDE navigation facilities on the names in the _central column_ below to find the actual flags/enum lists!
    # In Visual Studio IDE: CTRL+comma ("Edit.GoToAll") can follow symbols in comments, whereas CTRL+F12 ("Edit.GoToImplementation") cannot.
    # With Visual Assist installed: ALT+G ("VAssistX.GoToImplementation") can also follow symbols in comments.
    ctypedef int ImDrawFlags               # -> enum imdrawflags_          // flags: for imdrawlist functions
    ctypedef int ImDrawListFlags           # -> enum imdrawlistflags_      // flags: for imdrawlist instance
    ctypedef int ImFontAtlasFlags          # -> enum imfontatlasflags_     // flags: for imfontatlas build
    ctypedef int ImGuiBackendFlags         # -> enum imguibackendflags_    // flags: for io.backendflags
    ctypedef int ImGuiButtonFlags          # -> enum imguibuttonflags_     // flags: for invisiblebutton()
    ctypedef int ImGuiColorEditFlags       # -> enum imguicoloreditflags_  // flags: for coloredit4(), colorpicker4() etc.
    ctypedef int ImGuiConfigFlags          # -> enum imguiconfigflags_     // flags: for io.configflags
    ctypedef int ImGuiComboFlags           # -> enum imguicomboflags_      // flags: for begincombo()
    ctypedef int ImGuiDockNodeFlags        # -> enum imguidocknodeflags_   // flags: for dockspace()
    ctypedef int ImGuiDragDropFlags        # -> enum imguidragdropflags_   // flags: for begindragdropsource(), acceptdragdroppayload()
    ctypedef int ImGuiFocusedFlags         # -> enum imguifocusedflags_    // flags: for iswindowfocused()
    ctypedef int ImGuiHoveredFlags         # -> enum imguihoveredflags_    // flags: for isitemhovered(), iswindowhovered() etc.
    ctypedef int ImGuiInputTextFlags       # -> enum imguiinputtextflags_  // flags: for inputtext(), inputtextmultiline()
    ctypedef int ImGuiKeyChord             # -> imguikey | imguimod_xxx    // flags: for storage only for now: an imguikey optionally or-ed with one or more imguimod_xxx values.
    ctypedef int ImGuiPopupFlags           # -> enum imguipopupflags_      // flags: for openpopup*(), beginpopupcontext*(), ispopupopen()
    ctypedef int ImGuiSelectableFlags      # -> enum imguiselectableflags_ // flags: for selectable()
    ctypedef int ImGuiSliderFlags          # -> enum imguisliderflags_     // flags: for dragfloat(), dragint(), sliderfloat(), sliderint() etc.
    ctypedef int ImGuiTabBarFlags          # -> enum imguitabbarflags_     // flags: for begintabbar()
    ctypedef int ImGuiTabItemFlags         # -> enum imguitabitemflags_    // flags: for begintabitem()
    ctypedef int ImGuiTableFlags           # -> enum imguitableflags_      // flags: for begintable()
    ctypedef int ImGuiTableColumnFlags     # -> enum imguitablecolumnflags_// flags: for tablesetupcolumn()
    ctypedef int ImGuiTableRowFlags        # -> enum imguitablerowflags_   // flags: for tablenextrow()
    ctypedef int ImGuiTreeNodeFlags        # -> enum imguitreenodeflags_   // flags: for treenode(), treenodeex(), collapsingheader()
    ctypedef int ImGuiViewportFlags        # -> enum imguiviewportflags_   // flags: for imguiviewport
    ctypedef int ImGuiWindowFlags          # -> enum imguiwindowflags_     // flags: for begin(), beginchild()
    ctypedef void* ImTextureID             # Default: store a pointer or an integer fitting in a pointer (most renderer backends are ok with that)
    ctypedef unsigned short ImDrawIdx      # Default: 16-bit (for maximum compatibility with renderer backends)

    # Scalar data types
    ctypedef unsigned int ImGuiID          # A unique id used by widgets (typically the result of hashing a stack of string)
    ctypedef signed char ImS8              # 8-bit signed integer
    ctypedef unsigned char ImU8            # 8-bit unsigned integer
    ctypedef signed short ImS16            # 16-bit signed integer
    ctypedef unsigned short ImU16          # 16-bit unsigned integer
    ctypedef signed int ImS32              # 32-bit signed integer == int
    ctypedef unsigned int ImU32            # 32-bit unsigned integer (often used to store packed colors)
    ctypedef signed long long ImS64        # 64-bit signed integer
    ctypedef unsigned long long ImU64      # 64-bit unsigned integer

    # Character types
    # (we generally use UTF-8 encoded string in the API. This is storage specifically for a decoded character used for keyboard input and display)
    ctypedef unsigned short ImWchar16      # A single decoded u16 character/code point. we encode them as multi bytes utf-8 when used in strings.
    ctypedef unsigned int ImWchar32        # A single decoded u32 character/code point. we encode them as multi bytes utf-8 when used in strings.
    ctypedef ImWchar16 ImWchar

    # Callback and functions types
    ctypedef int (*ImGuiInputTextCallback)(ImGuiInputTextCallbackData* data)                 # Callback function for imgui::inputtext()
    ctypedef void (*ImGuiSizeCallback)(ImGuiSizeCallbackData* data)                          # Callback function for imgui::setnextwindowsizeconstraints()
    ctypedef void* (*ImGuiMemAllocFunc)(size_t sz, void* user_data)                          # Function signature for imgui::setallocatorfunctions()
    ctypedef void (*ImGuiMemFreeFunc)(void* ptr, void* user_data)                            # Function signature for imgui::setallocatorfunctions()
    ctypedef void (*ImDrawCallback)(const ImDrawList* parent_list, const ImDrawCmd* cmd)

    # Flags for ImGui::Begin()
    # (Those are per-window flags. There are shared flags in ImGuiIO: io.ConfigWindowsResizeFromEdges and io.ConfigWindowsMoveFromTitleBarOnly)
    ctypedef enum ImGuiWindowFlags_:
        ImGuiWindowFlags_None
        ImGuiWindowFlags_NoTitleBar                    # Disable title-bar
        ImGuiWindowFlags_NoResize                      # Disable user resizing with the lower-right grip
        ImGuiWindowFlags_NoMove                        # Disable user moving the window
        ImGuiWindowFlags_NoScrollbar                   # Disable scrollbars (window can still scroll with mouse or programmatically)
        ImGuiWindowFlags_NoScrollWithMouse             # Disable user vertically scrolling with mouse wheel. on child window, mouse wheel will be forwarded to the parent unless noscrollbar is also set.
        ImGuiWindowFlags_NoCollapse                    # Disable user collapsing window by double-clicking on it. also referred to as window menu button (e.g. within a docking node).
        ImGuiWindowFlags_AlwaysAutoResize              # Resize every window to its content every frame
        ImGuiWindowFlags_NoBackground                  # Disable drawing background color (windowbg, etc.) and outside border. similar as using setnextwindowbgalpha(0.0f).
        ImGuiWindowFlags_NoSavedSettings               # Never load/save settings in .ini file
        ImGuiWindowFlags_NoMouseInputs                 # Disable catching mouse, hovering test with pass through.
        ImGuiWindowFlags_MenuBar                       # Has a menu-bar
        ImGuiWindowFlags_HorizontalScrollbar           # Allow horizontal scrollbar to appear (off by default). you may use setnextwindowcontentsize(imvec2(width,0.0f)); prior to calling begin() to specify width. read code in imgui_demo in the 'horizontal scrolling' section.
        ImGuiWindowFlags_NoFocusOnAppearing            # Disable taking focus when transitioning from hidden to visible state
        ImGuiWindowFlags_NoBringToFrontOnFocus         # Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus)
        ImGuiWindowFlags_AlwaysVerticalScrollbar       # Always show vertical scrollbar (even if contentsize.y < size.y)
        ImGuiWindowFlags_AlwaysHorizontalScrollbar     # Always show horizontal scrollbar (even if contentsize.x < size.x)
        ImGuiWindowFlags_AlwaysUseWindowPadding        # Ensure child windows without border uses style.windowpadding (ignored by default for non-bordered child windows, because more convenient)
        ImGuiWindowFlags_NoNavInputs                   # No gamepad/keyboard navigation within the window
        ImGuiWindowFlags_NoNavFocus                    # No focusing toward this window with gamepad/keyboard navigation (e.g. skipped by ctrl+tab)
        ImGuiWindowFlags_UnsavedDocument               # Display a dot next to the title. when used in a tab/docking context, tab is selected when clicking the x + closure is not assumed (will wait for user to stop submitting the tab). otherwise closure is assumed when pressing the x, so if you keep submitting the tab may reappear at end of tab bar.
        ImGuiWindowFlags_NoDocking                     # Disable docking of this window
        ImGuiWindowFlags_NoNav
        ImGuiWindowFlags_NoDecoration
        ImGuiWindowFlags_NoInputs
        ImGuiWindowFlags_NavFlattened                  # [beta] on child window: allow gamepad/keyboard navigation to cross over parent border to this child or between sibling child windows.
        ImGuiWindowFlags_ChildWindow                   # Don't use! for internal use by beginchild()
        ImGuiWindowFlags_Tooltip                       # Don't use! for internal use by begintooltip()
        ImGuiWindowFlags_Popup                         # Don't use! for internal use by beginpopup()
        ImGuiWindowFlags_Modal                         # Don't use! for internal use by beginpopupmodal()
        ImGuiWindowFlags_ChildMenu                     # Don't use! for internal use by beginmenu()
        ImGuiWindowFlags_DockNodeHost                  # Don't use! for internal use by begin()/newframe()

    # Flags for ImGui::InputText()
    # (Those are per-item flags. There are shared flags in ImGuiIO: io.ConfigInputTextCursorBlink and io.ConfigInputTextEnterKeepActive)
    ctypedef enum ImGuiInputTextFlags_:
        ImGuiInputTextFlags_None
        ImGuiInputTextFlags_CharsDecimal            # Allow 0123456789.+-*/
        ImGuiInputTextFlags_CharsHexadecimal        # Allow 0123456789abcdefabcdef
        ImGuiInputTextFlags_CharsUppercase          # Turn a..z into a..z
        ImGuiInputTextFlags_CharsNoBlank            # Filter out spaces, tabs
        ImGuiInputTextFlags_AutoSelectAll           # Select entire text when first taking mouse focus
        ImGuiInputTextFlags_EnterReturnsTrue        # Return 'true' when enter is pressed (as opposed to every time the value was modified). consider looking at the isitemdeactivatedafteredit() function.
        ImGuiInputTextFlags_CallbackCompletion      # Callback on pressing tab (for completion handling)
        ImGuiInputTextFlags_CallbackHistory         # Callback on pressing up/down arrows (for history handling)
        ImGuiInputTextFlags_CallbackAlways          # Callback on each iteration. user code may query cursor position, modify text buffer.
        ImGuiInputTextFlags_CallbackCharFilter      # Callback on character inputs to replace or discard them. modify 'eventchar' to replace or discard, or return 1 in callback to discard.
        ImGuiInputTextFlags_AllowTabInput           # Pressing tab input a '\t' character into the text field
        ImGuiInputTextFlags_CtrlEnterForNewLine     # In multi-line mode, unfocus with enter, add new line with ctrl+enter (default is opposite: unfocus with ctrl+enter, add line with enter).
        ImGuiInputTextFlags_NoHorizontalScroll      # Disable following the cursor horizontally
        ImGuiInputTextFlags_AlwaysOverwrite         # Overwrite mode
        ImGuiInputTextFlags_ReadOnly                # Read-only mode
        ImGuiInputTextFlags_Password                # Password mode, display all characters as '*'
        ImGuiInputTextFlags_NoUndoRedo              # Disable undo/redo. note that input text owns the text data while active, if you want to provide your own undo/redo stack you need e.g. to call clearactiveid().
        ImGuiInputTextFlags_CharsScientific         # Allow 0123456789.+-*/ee (scientific notation input)
        ImGuiInputTextFlags_CallbackResize          # Callback on buffer capacity changes request (beyond 'buf_size' parameter value), allowing the string to grow. notify when the string wants to be resized (for string types which hold a cache of their size). you will be provided a new bufsize in the callback and need to honor it. (see misc/cpp/imgui_stdlib.h for an example of using this)
        ImGuiInputTextFlags_CallbackEdit            # Callback on any edit (note that inputtext() already returns true on edit, the callback is useful mainly to manipulate the underlying buffer while focus is active)
        ImGuiInputTextFlags_EscapeClearsAll         # Escape key clears content if not empty, and deactivate otherwise (contrast to default behavior of escape to revert)

    # Flags for ImGui::TreeNodeEx(), ImGui::CollapsingHeader*()
    ctypedef enum ImGuiTreeNodeFlags_:
        ImGuiTreeNodeFlags_None
        ImGuiTreeNodeFlags_Selected                 # Draw as selected
        ImGuiTreeNodeFlags_Framed                   # Draw frame with background (e.g. for collapsingheader)
        ImGuiTreeNodeFlags_AllowItemOverlap         # Hit testing to allow subsequent widgets to overlap this one
        ImGuiTreeNodeFlags_NoTreePushOnOpen         # Don't do a treepush() when open (e.g. for collapsingheader) = no extra indent nor pushing on id stack
        ImGuiTreeNodeFlags_NoAutoOpenOnLog          # Don't automatically and temporarily open node when logging is active (by default logging will automatically open tree nodes)
        ImGuiTreeNodeFlags_DefaultOpen              # Default node to be open
        ImGuiTreeNodeFlags_OpenOnDoubleClick        # Need double-click to open node
        ImGuiTreeNodeFlags_OpenOnArrow              # Only open when clicking on the arrow part. if imguitreenodeflags_openondoubleclick is also set, single-click arrow or double-click all box to open.
        ImGuiTreeNodeFlags_Leaf                     # No collapsing, no arrow (use as a convenience for leaf nodes).
        ImGuiTreeNodeFlags_Bullet                   # Display a bullet instead of arrow
        ImGuiTreeNodeFlags_FramePadding             # Use framepadding (even for an unframed text node) to vertically align text baseline to regular widget height. equivalent to calling aligntexttoframepadding().
        ImGuiTreeNodeFlags_SpanAvailWidth           # Extend hit box to the right-most edge, even if not framed. this is not the default in order to allow adding other items on the same line. in the future we may refactor the hit system to be front-to-back, allowing natural overlaps and then this can become the default.
        ImGuiTreeNodeFlags_SpanFullWidth            # Extend hit box to the left-most and right-most edges (bypass the indented area).
        ImGuiTreeNodeFlags_NavLeftJumpsBackHere     # (wip) nav: left direction may move to this treenode() from any of its child (items submitted between treenode and treepop)
        ImGuiTreeNodeFlags_CollapsingHeader

    # Flags for OpenPopup*(), BeginPopupContext*(), IsPopupOpen() functions.
    # - To be backward compatible with older API which took an 'int mouse_button = 1' argument, we need to treat
    # small flags values as a mouse button index, so we encode the mouse button in the first few bits of the flags.
    # It is therefore guaranteed to be legal to pass a mouse button index in ImGuiPopupFlags.
    # - For the same reason, we exceptionally default the ImGuiPopupFlags argument of BeginPopupContextXXX functions to 1 instead of 0.
    # IMPORTANT: because the default parameter is 1 (==ImGuiPopupFlags_MouseButtonRight), if you rely on the default parameter
    # and want to use another flag, you need to pass in the ImGuiPopupFlags_MouseButtonRight flag explicitly.
    # - Multiple buttons currently cannot be combined/or-ed in those functions (we could allow it later).
    ctypedef enum ImGuiPopupFlags_:
        ImGuiPopupFlags_None
        ImGuiPopupFlags_MouseButtonLeft             # For beginpopupcontext*(): open on left mouse release. guaranteed to always be == 0 (same as imguimousebutton_left)
        ImGuiPopupFlags_MouseButtonRight            # For beginpopupcontext*(): open on right mouse release. guaranteed to always be == 1 (same as imguimousebutton_right)
        ImGuiPopupFlags_MouseButtonMiddle           # For beginpopupcontext*(): open on middle mouse release. guaranteed to always be == 2 (same as imguimousebutton_middle)
        ImGuiPopupFlags_MouseButtonMask_
        ImGuiPopupFlags_MouseButtonDefault_
        ImGuiPopupFlags_NoOpenOverExistingPopup     # For openpopup*(), beginpopupcontext*(): don't open if there's already a popup at the same level of the popup stack
        ImGuiPopupFlags_NoOpenOverItems             # For beginpopupcontextwindow(): don't return true when hovering items, only when hovering empty space
        ImGuiPopupFlags_AnyPopupId                  # For ispopupopen(): ignore the imguiid parameter and test for any popup.
        ImGuiPopupFlags_AnyPopupLevel               # For ispopupopen(): search/test at any level of the popup stack (default test in the current level)
        ImGuiPopupFlags_AnyPopup

    # Flags for ImGui::Selectable()
    ctypedef enum ImGuiSelectableFlags_:
        ImGuiSelectableFlags_None
        ImGuiSelectableFlags_DontClosePopups      # Clicking this doesn't close parent popup window
        ImGuiSelectableFlags_SpanAllColumns       # Selectable frame can span all columns (text will still fit in current column)
        ImGuiSelectableFlags_AllowDoubleClick     # Generate press events on double clicks too
        ImGuiSelectableFlags_Disabled             # Cannot be selected, display grayed out text
        ImGuiSelectableFlags_AllowItemOverlap     # (wip) hit testing to allow subsequent widgets to overlap this one

    # Flags for ImGui::BeginCombo()
    ctypedef enum ImGuiComboFlags_:
        ImGuiComboFlags_None
        ImGuiComboFlags_PopupAlignLeft     # Align the popup toward the left by default
        ImGuiComboFlags_HeightSmall        # Max ~4 items visible. tip: if you want your combo popup to be a specific size you can use setnextwindowsizeconstraints() prior to calling begincombo()
        ImGuiComboFlags_HeightRegular      # Max ~8 items visible (default)
        ImGuiComboFlags_HeightLarge        # Max ~20 items visible
        ImGuiComboFlags_HeightLargest      # As many fitting items as possible
        ImGuiComboFlags_NoArrowButton      # Display on the preview box without the square arrow button
        ImGuiComboFlags_NoPreview          # Display only a square arrow button
        ImGuiComboFlags_HeightMask_

    # Flags for ImGui::BeginTabBar()
    ctypedef enum ImGuiTabBarFlags_:
        ImGuiTabBarFlags_None
        ImGuiTabBarFlags_Reorderable                      # Allow manually dragging tabs to re-order them + new tabs are appended at the end of list
        ImGuiTabBarFlags_AutoSelectNewTabs                # Automatically select new tabs when they appear
        ImGuiTabBarFlags_TabListPopupButton               # Disable buttons to open the tab list popup
        ImGuiTabBarFlags_NoCloseWithMiddleMouseButton     # Disable behavior of closing tabs (that are submitted with p_open != null) with middle mouse button. you can still repro this behavior on user's side with if (isitemhovered() && ismouseclicked(2)) *p_open = false.
        ImGuiTabBarFlags_NoTabListScrollingButtons        # Disable scrolling buttons (apply when fitting policy is imguitabbarflags_fittingpolicyscroll)
        ImGuiTabBarFlags_NoTooltip                        # Disable tooltips when hovering a tab
        ImGuiTabBarFlags_FittingPolicyResizeDown          # Resize tabs when they don't fit
        ImGuiTabBarFlags_FittingPolicyScroll              # Add scroll buttons when tabs don't fit
        ImGuiTabBarFlags_FittingPolicyMask_
        ImGuiTabBarFlags_FittingPolicyDefault_

    # Flags for ImGui::BeginTabItem()
    ctypedef enum ImGuiTabItemFlags_:
        ImGuiTabItemFlags_None
        ImGuiTabItemFlags_UnsavedDocument                  # Display a dot next to the title + tab is selected when clicking the x + closure is not assumed (will wait for user to stop submitting the tab). otherwise closure is assumed when pressing the x, so if you keep submitting the tab may reappear at end of tab bar.
        ImGuiTabItemFlags_SetSelected                      # Trigger flag to programmatically make the tab selected when calling begintabitem()
        ImGuiTabItemFlags_NoCloseWithMiddleMouseButton     # Disable behavior of closing tabs (that are submitted with p_open != null) with middle mouse button. you can still repro this behavior on user's side with if (isitemhovered() && ismouseclicked(2)) *p_open = false.
        ImGuiTabItemFlags_NoPushId                         # Don't call pushid(tab->id)/popid() on begintabitem()/endtabitem()
        ImGuiTabItemFlags_NoTooltip                        # Disable tooltip for the given tab
        ImGuiTabItemFlags_NoReorder                        # Disable reordering this tab or having another tab cross over this tab
        ImGuiTabItemFlags_Leading                          # Enforce the tab position to the left of the tab bar (after the tab list popup button)
        ImGuiTabItemFlags_Trailing                         # Enforce the tab position to the right of the tab bar (before the scrolling buttons)

    # Flags for ImGui::BeginTable()
    # - Important! Sizing policies have complex and subtle side effects, much more so than you would expect.
    # Read comments/demos carefully + experiment with live demos to get acquainted with them.
    # - The DEFAULT sizing policies are:
    # - Default to ImGuiTableFlags_SizingFixedFit    if ScrollX is on, or if host window has ImGuiWindowFlags_AlwaysAutoResize.
    # - Default to ImGuiTableFlags_SizingStretchSame if ScrollX is off.
    # - When ScrollX is off:
    # - Table defaults to ImGuiTableFlags_SizingStretchSame -> all Columns defaults to ImGuiTableColumnFlags_WidthStretch with same weight.
    # - Columns sizing policy allowed: Stretch (default), Fixed/Auto.
    # - Fixed Columns (if any) will generally obtain their requested width (unless the table cannot fit them all).
    # - Stretch Columns will share the remaining width according to their respective weight.
    # - Mixed Fixed/Stretch columns is possible but has various side-effects on resizing behaviors.
    # The typical use of mixing sizing policies is: any number of LEADING Fixed columns, followed by one or two TRAILING Stretch columns.
    # (this is because the visible order of columns have subtle but necessary effects on how they react to manual resizing).
    # - When ScrollX is on:
    # - Table defaults to ImGuiTableFlags_SizingFixedFit -> all Columns defaults to ImGuiTableColumnFlags_WidthFixed
    # - Columns sizing policy allowed: Fixed/Auto mostly.
    # - Fixed Columns can be enlarged as needed. Table will show a horizontal scrollbar if needed.
    # - When using auto-resizing (non-resizable) fixed columns, querying the content width to use item right-alignment e.g. SetNextItemWidth(-FLT_MIN) doesn't make sense, would create a feedback loop.
    # - Using Stretch columns OFTEN DOES NOT MAKE SENSE if ScrollX is on, UNLESS you have specified a value for 'inner_width' in BeginTable().
    # If you specify a value for 'inner_width' then effectively the scrolling space is known and Stretch or mixed Fixed/Stretch columns become meaningful again.
    # - Read on documentation at the top of imgui_tables.cpp for details.
    ctypedef enum ImGuiTableFlags_:
        ImGuiTableFlags_None
        ImGuiTableFlags_Resizable                      # Enable resizing columns.
        ImGuiTableFlags_Reorderable                    # Enable reordering columns in header row (need calling tablesetupcolumn() + tableheadersrow() to display headers)
        ImGuiTableFlags_Hideable                       # Enable hiding/disabling columns in context menu.
        ImGuiTableFlags_Sortable                       # Enable sorting. call tablegetsortspecs() to obtain sort specs. also see imguitableflags_sortmulti and imguitableflags_sorttristate.
        ImGuiTableFlags_NoSavedSettings                # Disable persisting columns order, width and sort settings in the .ini file.
        ImGuiTableFlags_ContextMenuInBody              # Right-click on columns body/contents will display table context menu. by default it is available in tableheadersrow().
        ImGuiTableFlags_RowBg                          # Set each rowbg color with imguicol_tablerowbg or imguicol_tablerowbgalt (equivalent of calling tablesetbgcolor with imguitablebgflags_rowbg0 on each row manually)
        ImGuiTableFlags_BordersInnerH                  # Draw horizontal borders between rows.
        ImGuiTableFlags_BordersOuterH                  # Draw horizontal borders at the top and bottom.
        ImGuiTableFlags_BordersInnerV                  # Draw vertical borders between columns.
        ImGuiTableFlags_BordersOuterV                  # Draw vertical borders on the left and right sides.
        ImGuiTableFlags_BordersH                       # Draw horizontal borders.
        ImGuiTableFlags_BordersV                       # Draw vertical borders.
        ImGuiTableFlags_BordersInner                   # Draw inner borders.
        ImGuiTableFlags_BordersOuter                   # Draw outer borders.
        ImGuiTableFlags_Borders                        # Draw all borders.
        ImGuiTableFlags_NoBordersInBody                # [alpha] disable vertical borders in columns body (borders will always appear in headers). -> may move to style
        ImGuiTableFlags_NoBordersInBodyUntilResize     # [alpha] disable vertical borders in columns body until hovered for resize (borders will always appear in headers). -> may move to style
        ImGuiTableFlags_SizingFixedFit                 # Columns default to _widthfixed or _widthauto (if resizable or not resizable), matching contents width.
        ImGuiTableFlags_SizingFixedSame                # Columns default to _widthfixed or _widthauto (if resizable or not resizable), matching the maximum contents width of all columns. implicitly enable imguitableflags_nokeepcolumnsvisible.
        ImGuiTableFlags_SizingStretchProp              # Columns default to _widthstretch with default weights proportional to each columns contents widths.
        ImGuiTableFlags_SizingStretchSame              # Columns default to _widthstretch with default weights all equal, unless overridden by tablesetupcolumn().
        ImGuiTableFlags_NoHostExtendX                  # Make outer width auto-fit to columns, overriding outer_size.x value. only available when scrollx/scrolly are disabled and stretch columns are not used.
        ImGuiTableFlags_NoHostExtendY                  # Make outer height stop exactly at outer_size.y (prevent auto-extending table past the limit). only available when scrollx/scrolly are disabled. data below the limit will be clipped and not visible.
        ImGuiTableFlags_NoKeepColumnsVisible           # Disable keeping column always minimally visible when scrollx is off and table gets too small. not recommended if columns are resizable.
        ImGuiTableFlags_PreciseWidths                  # Disable distributing remainder width to stretched columns (width allocation on a 100-wide table with 3 columns: without this flag: 33,33,34. with this flag: 33,33,33). with larger number of columns, resizing will appear to be less smooth.
        ImGuiTableFlags_NoClip                         # Disable clipping rectangle for every individual columns (reduce draw command count, items will be able to overflow into other columns). generally incompatible with tablesetupscrollfreeze().
        ImGuiTableFlags_PadOuterX                      # Default if bordersouterv is on. enable outermost padding. generally desirable if you have headers.
        ImGuiTableFlags_NoPadOuterX                    # Default if bordersouterv is off. disable outermost padding.
        ImGuiTableFlags_NoPadInnerX                    # Disable inner padding between columns (double inner padding if bordersouterv is on, single inner padding if bordersouterv is off).
        ImGuiTableFlags_ScrollX                        # Enable horizontal scrolling. require 'outer_size' parameter of begintable() to specify the container size. changes default sizing policy. because this creates a child window, scrolly is currently generally recommended when using scrollx.
        ImGuiTableFlags_ScrollY                        # Enable vertical scrolling. require 'outer_size' parameter of begintable() to specify the container size.
        ImGuiTableFlags_SortMulti                      # Hold shift when clicking headers to sort on multiple column. tablegetsortspecs() may return specs where (specscount > 1).
        ImGuiTableFlags_SortTristate                   # Allow no sorting, disable default sorting. tablegetsortspecs() may return specs where (specscount == 0).
        ImGuiTableFlags_SizingMask_

    # Flags for ImGui::TableSetupColumn()
    ctypedef enum ImGuiTableColumnFlags_:
        ImGuiTableColumnFlags_None
        ImGuiTableColumnFlags_Disabled                 # Overriding/master disable flag: hide column, won't show in context menu (unlike calling tablesetcolumnenabled() which manipulates the user accessible state)
        ImGuiTableColumnFlags_DefaultHide              # Default as a hidden/disabled column.
        ImGuiTableColumnFlags_DefaultSort              # Default as a sorting column.
        ImGuiTableColumnFlags_WidthStretch             # Column will stretch. preferable with horizontal scrolling disabled (default if table sizing policy is _sizingstretchsame or _sizingstretchprop).
        ImGuiTableColumnFlags_WidthFixed               # Column will not stretch. preferable with horizontal scrolling enabled (default if table sizing policy is _sizingfixedfit and table is resizable).
        ImGuiTableColumnFlags_NoResize                 # Disable manual resizing.
        ImGuiTableColumnFlags_NoReorder                # Disable manual reordering this column, this will also prevent other columns from crossing over this column.
        ImGuiTableColumnFlags_NoHide                   # Disable ability to hide/disable this column.
        ImGuiTableColumnFlags_NoClip                   # Disable clipping for this column (all noclip columns will render in a same draw command).
        ImGuiTableColumnFlags_NoSort                   # Disable ability to sort on this field (even if imguitableflags_sortable is set on the table).
        ImGuiTableColumnFlags_NoSortAscending          # Disable ability to sort in the ascending direction.
        ImGuiTableColumnFlags_NoSortDescending         # Disable ability to sort in the descending direction.
        ImGuiTableColumnFlags_NoHeaderLabel            # Tableheadersrow() will not submit label for this column. convenient for some small columns. name will still appear in context menu.
        ImGuiTableColumnFlags_NoHeaderWidth            # Disable header text width contribution to automatic column width.
        ImGuiTableColumnFlags_PreferSortAscending      # Make the initial sort direction ascending when first sorting on this column (default).
        ImGuiTableColumnFlags_PreferSortDescending     # Make the initial sort direction descending when first sorting on this column.
        ImGuiTableColumnFlags_IndentEnable             # Use current indent value when entering cell (default for column 0).
        ImGuiTableColumnFlags_IndentDisable            # Ignore current indent value when entering cell (default for columns > 0). indentation changes _within_ the cell will still be honored.
        ImGuiTableColumnFlags_IsEnabled                # Status: is enabled == not hidden by user/api (referred to as 'hide' in _defaulthide and _nohide) flags.
        ImGuiTableColumnFlags_IsVisible                # Status: is visible == is enabled and not clipped by scrolling.
        ImGuiTableColumnFlags_IsSorted                 # Status: is currently part of the sort specs
        ImGuiTableColumnFlags_IsHovered                # Status: is hovered by mouse
        ImGuiTableColumnFlags_WidthMask_
        ImGuiTableColumnFlags_IndentMask_
        ImGuiTableColumnFlags_StatusMask_
        ImGuiTableColumnFlags_NoDirectResize_          # [internal] disable user resizing this column directly (it may however we resized indirectly from its left edge)

    # Flags for ImGui::TableNextRow()
    ctypedef enum ImGuiTableRowFlags_:
        ImGuiTableRowFlags_None
        ImGuiTableRowFlags_Headers     # Identify header row (set default background color + width of its contents accounted differently for auto column width)

    # Enum for ImGui::TableSetBgColor()
    # Background colors are rendering in 3 layers:
    # - Layer 0: draw with RowBg0 color if set, otherwise draw with ColumnBg0 if set.
    # - Layer 1: draw with RowBg1 color if set, otherwise draw with ColumnBg1 if set.
    # - Layer 2: draw with CellBg color if set.
    # The purpose of the two row/columns layers is to let you decide if a background color change should override or blend with the existing color.
    # When using ImGuiTableFlags_RowBg on the table, each row has the RowBg0 color automatically set for odd/even rows.
    # If you set the color of RowBg0 target, your color will override the existing RowBg0 color.
    # If you set the color of RowBg1 or ColumnBg1 target, your color will blend over the RowBg0 color.
    ctypedef enum ImGuiTableBgTarget_:
        ImGuiTableBgTarget_None
        ImGuiTableBgTarget_RowBg0     # Set row background color 0 (generally used for background, automatically set when imguitableflags_rowbg is used)
        ImGuiTableBgTarget_RowBg1     # Set row background color 1 (generally used for selection marking)
        ImGuiTableBgTarget_CellBg     # Set cell background color (top-most color)

    # Flags for ImGui::IsWindowFocused()
    ctypedef enum ImGuiFocusedFlags_:
        ImGuiFocusedFlags_None
        ImGuiFocusedFlags_ChildWindows            # Return true if any children of the window is focused
        ImGuiFocusedFlags_RootWindow              # Test from root window (top most parent of the current hierarchy)
        ImGuiFocusedFlags_AnyWindow               # Return true if any window is focused. important: if you are trying to tell how to dispatch your low-level inputs, do not use this. use 'io.wantcapturemouse' instead! please read the faq!
        ImGuiFocusedFlags_NoPopupHierarchy        # Do not consider popup hierarchy (do not treat popup emitter as parent of popup) (when used with _childwindows or _rootwindow)
        ImGuiFocusedFlags_DockHierarchy           # Consider docking hierarchy (treat dockspace host as parent of docked window) (when used with _childwindows or _rootwindow)
        ImGuiFocusedFlags_RootAndChildWindows

    # Flags for ImGui::IsItemHovered(), ImGui::IsWindowHovered()
    # Note: if you are trying to check whether your mouse should be dispatched to Dear ImGui or to your app, you should use 'io.WantCaptureMouse' instead! Please read the FAQ!
    # Note: windows with the ImGuiWindowFlags_NoInputs flag are ignored by IsWindowHovered() calls.
    ctypedef enum ImGuiHoveredFlags_:
        ImGuiHoveredFlags_None                             # Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
        ImGuiHoveredFlags_ChildWindows                     # Iswindowhovered() only: return true if any children of the window is hovered
        ImGuiHoveredFlags_RootWindow                       # Iswindowhovered() only: test from root window (top most parent of the current hierarchy)
        ImGuiHoveredFlags_AnyWindow                        # Iswindowhovered() only: return true if any window is hovered
        ImGuiHoveredFlags_NoPopupHierarchy                 # Iswindowhovered() only: do not consider popup hierarchy (do not treat popup emitter as parent of popup) (when used with _childwindows or _rootwindow)
        ImGuiHoveredFlags_DockHierarchy                    # Iswindowhovered() only: consider docking hierarchy (treat dockspace host as parent of docked window) (when used with _childwindows or _rootwindow)
        ImGuiHoveredFlags_AllowWhenBlockedByPopup          # Return true even if a popup window is normally blocking access to this item/window
        ImGuiHoveredFlags_AllowWhenBlockedByActiveItem     # Return true even if an active item is blocking access to this item/window. useful for drag and drop patterns.
        ImGuiHoveredFlags_AllowWhenOverlapped              # Isitemhovered() only: return true even if the position is obstructed or overlapped by another window
        ImGuiHoveredFlags_AllowWhenDisabled                # Isitemhovered() only: return true even if the item is disabled
        ImGuiHoveredFlags_NoNavOverride                    # Disable using gamepad/keyboard navigation state when active, always query mouse.
        ImGuiHoveredFlags_RectOnly
        ImGuiHoveredFlags_RootAndChildWindows
        ImGuiHoveredFlags_DelayNormal                      # Return true after io.hoverdelaynormal elapsed (~0.30 sec)
        ImGuiHoveredFlags_DelayShort                       # Return true after io.hoverdelayshort elapsed (~0.10 sec)
        ImGuiHoveredFlags_NoSharedDelay                    # Disable shared delay system where moving from one item to the next keeps the previous timer for a short time (standard for tooltips with long delays)

    # Flags for ImGui::DockSpace(), shared/inherited by child nodes.
    # (Some flags can be applied to individual nodes directly)
    # FIXME-DOCK: Also see ImGuiDockNodeFlagsPrivate_ which may involve using the WIP and internal DockBuilder api.
    ctypedef enum ImGuiDockNodeFlags_:
        ImGuiDockNodeFlags_None
        ImGuiDockNodeFlags_KeepAliveOnly              # Shared       // don't display the dockspace node but keep it alive. windows docked into this dockspace node won't be undocked.
        ImGuiDockNodeFlags_NoDockingInCentralNode     # Shared       // disable docking inside the central node, which will be always kept empty.
        ImGuiDockNodeFlags_PassthruCentralNode        # Shared       // enable passthru dockspace: 1) dockspace() will render a imguicol_windowbg background covering everything excepted the central node when empty. meaning the host window should probably use setnextwindowbgalpha(0.0f) prior to begin() when using this. 2) when central node is empty: let inputs pass-through + won't display a dockingemptybg background. see demo for details.
        ImGuiDockNodeFlags_NoSplit                    # Shared/local // disable splitting the node into smaller nodes. useful e.g. when embedding dockspaces into a main root one (the root one may have splitting disabled to reduce confusion). note: when turned off, existing splits will be preserved.
        ImGuiDockNodeFlags_NoResize                   # Shared/local // disable resizing node using the splitter/separators. useful with programmatically setup dockspaces.
        ImGuiDockNodeFlags_AutoHideTabBar             # Shared/local // tab bar will automatically hide when there is a single window in the dock node.

    # Flags for ImGui::BeginDragDropSource(), ImGui::AcceptDragDropPayload()
    ctypedef enum ImGuiDragDropFlags_:
        ImGuiDragDropFlags_None
        ImGuiDragDropFlags_SourceNoPreviewTooltip       # Disable preview tooltip. by default, a successful call to begindragdropsource opens a tooltip so you can display a preview or description of the source contents. this flag disables this behavior.
        ImGuiDragDropFlags_SourceNoDisableHover         # By default, when dragging we clear data so that isitemhovered() will return false, to avoid subsequent user code submitting tooltips. this flag disables this behavior so you can still call isitemhovered() on the source item.
        ImGuiDragDropFlags_SourceNoHoldToOpenOthers     # Disable the behavior that allows to open tree nodes and collapsing header by holding over them while dragging a source item.
        ImGuiDragDropFlags_SourceAllowNullID            # Allow items such as text(), image() that have no unique identifier to be used as drag source, by manufacturing a temporary identifier based on their window-relative position. this is extremely unusual within the dear imgui ecosystem and so we made it explicit.
        ImGuiDragDropFlags_SourceExtern                 # External source (from outside of dear imgui), won't attempt to read current item/window info. will always return true. only one extern source can be active simultaneously.
        ImGuiDragDropFlags_SourceAutoExpirePayload      # Automatically expire the payload if the source cease to be submitted (otherwise payloads are persisting while being dragged)
        ImGuiDragDropFlags_AcceptBeforeDelivery         # Acceptdragdroppayload() will returns true even before the mouse button is released. you can then call isdelivery() to test if the payload needs to be delivered.
        ImGuiDragDropFlags_AcceptNoDrawDefaultRect      # Do not draw the default highlight rectangle when hovering over target.
        ImGuiDragDropFlags_AcceptNoPreviewTooltip       # Request hiding the begindragdropsource tooltip from the begindragdroptarget site.
        ImGuiDragDropFlags_AcceptPeekOnly               # For peeking ahead and inspecting the payload before delivery.

    # A primary data type
    ctypedef enum ImGuiDataType_:
        ImGuiDataType_S8         # Signed char / char (with sensible compilers)
        ImGuiDataType_U8         # Unsigned char
        ImGuiDataType_S16        # Short
        ImGuiDataType_U16        # Unsigned short
        ImGuiDataType_S32        # Int
        ImGuiDataType_U32        # Unsigned int
        ImGuiDataType_S64        # Long long / __int64
        ImGuiDataType_U64        # Unsigned long long / unsigned __int64
        ImGuiDataType_Float      # Float
        ImGuiDataType_Double     # Double
        ImGuiDataType_COUNT

    # A cardinal direction
    ctypedef enum ImGuiDir_:
        ImGuiDir_None
        ImGuiDir_Left
        ImGuiDir_Right
        ImGuiDir_Up
        ImGuiDir_Down
        ImGuiDir_COUNT

    # A sorting direction
    ctypedef enum ImGuiSortDirection_:
        ImGuiSortDirection_None
        ImGuiSortDirection_Ascending      # Ascending = 0->9, a->z etc.
        ImGuiSortDirection_Descending     # Descending = 9->0, z->a etc.

    # A key identifier (ImGuiKey_XXX or ImGuiMod_XXX value): can represent Keyboard, Mouse and Gamepad values.
    # All our named keys are >= 512. Keys value 0 to 511 are left unused as legacy native/opaque key values (< 1.87).
    # Since >= 1.89 we increased typing (went from int to enum), some legacy code may need a cast to ImGuiKey.
    # Read details about the 1.87 and 1.89 transition : https://github.com/ocornut/imgui/issues/4921
    # Note that "Keys" related to physical keys and are not the same concept as input "Characters", the later are submitted via io.AddInputCharacter().
    # Forward declared enum type imguikey
    ctypedef enum ImGuiKey:
        ImGuiKey_None
        ImGuiKey_Tab                     # == imguikey_namedkey_begin
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
        ImGuiKey_GamepadStart            # Menu (xbox)      + (switch)   start/options (ps)
        ImGuiKey_GamepadBack             # View (xbox)      - (switch)   share (ps)
        ImGuiKey_GamepadFaceLeft         # X (xbox)         y (switch)   square (ps)        // tap: toggle menu. hold: windowing mode (focus/move/resize windows)
        ImGuiKey_GamepadFaceRight        # B (xbox)         a (switch)   circle (ps)        // cancel / close / exit
        ImGuiKey_GamepadFaceUp           # Y (xbox)         x (switch)   triangle (ps)      // text input / on-screen keyboard
        ImGuiKey_GamepadFaceDown         # A (xbox)         b (switch)   cross (ps)         // activate / open / toggle / tweak
        ImGuiKey_GamepadDpadLeft         # D-pad left                                       // move / tweak / resize window (in windowing mode)
        ImGuiKey_GamepadDpadRight        # D-pad right                                      // move / tweak / resize window (in windowing mode)
        ImGuiKey_GamepadDpadUp           # D-pad up                                         // move / tweak / resize window (in windowing mode)
        ImGuiKey_GamepadDpadDown         # D-pad down                                       // move / tweak / resize window (in windowing mode)
        ImGuiKey_GamepadL1               # L bumper (xbox)  l (switch)   l1 (ps)            // tweak slower / focus previous (in windowing mode)
        ImGuiKey_GamepadR1               # R bumper (xbox)  r (switch)   r1 (ps)            // tweak faster / focus next (in windowing mode)
        ImGuiKey_GamepadL2               # L trig. (xbox)   zl (switch)  l2 (ps) [analog]
        ImGuiKey_GamepadR2               # R trig. (xbox)   zr (switch)  r2 (ps) [analog]
        ImGuiKey_GamepadL3               # L stick (xbox)   l3 (switch)  l3 (ps)
        ImGuiKey_GamepadR3               # R stick (xbox)   r3 (switch)  r3 (ps)
        ImGuiKey_GamepadLStickLeft       # [analog]                                         // move window (in windowing mode)
        ImGuiKey_GamepadLStickRight      # [analog]                                         // move window (in windowing mode)
        ImGuiKey_GamepadLStickUp         # [analog]                                         // move window (in windowing mode)
        ImGuiKey_GamepadLStickDown       # [analog]                                         // move window (in windowing mode)
        ImGuiKey_GamepadRStickLeft       # [analog]
        ImGuiKey_GamepadRStickRight      # [analog]
        ImGuiKey_GamepadRStickUp         # [analog]
        ImGuiKey_GamepadRStickDown       # [analog]
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
        ImGuiMod_Alt                     # Option/menu
        ImGuiMod_Super                   # Cmd/super/windows
        ImGuiMod_Shortcut                # Alias for ctrl (non-macos) _or_ super (macos).
        ImGuiMod_Mask_                   # 5-bits
        ImGuiKey_NamedKey_BEGIN
        ImGuiKey_NamedKey_END
        ImGuiKey_NamedKey_COUNT
        ImGuiKey_KeysData_SIZE           # Size of keysdata[]: only hold named keys
        ImGuiKey_KeysData_OFFSET         # Accesses to io.keysdata[] must use (key - imguikey_keysdata_offset) index.

    # Configuration flags stored in io.ConfigFlags. Set by user/application.
    ctypedef enum ImGuiConfigFlags_:
        ImGuiConfigFlags_None
        ImGuiConfigFlags_NavEnableKeyboard           # Master keyboard navigation enable flag. enable full tabbing + directional arrows + space/enter to activate.
        ImGuiConfigFlags_NavEnableGamepad            # Master gamepad navigation enable flag. backend also needs to set imguibackendflags_hasgamepad.
        ImGuiConfigFlags_NavEnableSetMousePos        # Instruct navigation to move the mouse cursor. may be useful on tv/console systems where moving a virtual mouse is awkward. will update io.mousepos and set io.wantsetmousepos=true. if enabled you must honor io.wantsetmousepos requests in your backend, otherwise imgui will react as if the mouse is jumping around back and forth.
        ImGuiConfigFlags_NavNoCaptureKeyboard        # Instruct navigation to not set the io.wantcapturekeyboard flag when io.navactive is set.
        ImGuiConfigFlags_NoMouse                     # Instruct imgui to clear mouse position/buttons in newframe(). this allows ignoring the mouse information set by the backend.
        ImGuiConfigFlags_NoMouseCursorChange         # Instruct backend to not alter mouse cursor shape and visibility. use if the backend cursor changes are interfering with yours and you don't want to use setmousecursor() to change mouse cursor. you may want to honor requests from imgui by reading getmousecursor() yourself instead.
        ImGuiConfigFlags_DockingEnable               # Docking enable flags.
        ImGuiConfigFlags_ViewportsEnable             # Viewport enable flags (require both imguibackendflags_platformhasviewports + imguibackendflags_rendererhasviewports set by the respective backends)
        ImGuiConfigFlags_DpiEnableScaleViewports     # [beta: don't use] fixme-dpi: reposition and resize imgui windows when the dpiscale of a viewport changed (mostly useful for the main viewport hosting other window). note that resizing the main window itself is up to your application.
        ImGuiConfigFlags_DpiEnableScaleFonts         # [beta: don't use] fixme-dpi: request bitmap-scaled fonts to match dpiscale. this is a very low-quality workaround. the correct way to handle dpi is _currently_ to replace the atlas and/or fonts in the platform_onchangedviewport callback, but this is all early work in progress.
        ImGuiConfigFlags_IsSRGB                      # Application is srgb-aware.
        ImGuiConfigFlags_IsTouchScreen               # Application is using a touch screen instead of a mouse.

    # Backend capabilities flags stored in io.BackendFlags. Set by imgui_impl_xxx or custom backend.
    ctypedef enum ImGuiBackendFlags_:
        ImGuiBackendFlags_None
        ImGuiBackendFlags_HasGamepad                  # Backend platform supports gamepad and currently has one connected.
        ImGuiBackendFlags_HasMouseCursors             # Backend platform supports honoring getmousecursor() value to change the os cursor shape.
        ImGuiBackendFlags_HasSetMousePos              # Backend platform supports io.wantsetmousepos requests to reposition the os mouse position (only used if imguiconfigflags_navenablesetmousepos is set).
        ImGuiBackendFlags_RendererHasVtxOffset        # Backend renderer supports imdrawcmd::vtxoffset. this enables output of large meshes (64k+ vertices) while still using 16-bit indices.
        ImGuiBackendFlags_PlatformHasViewports        # Backend platform supports multiple viewports.
        ImGuiBackendFlags_HasMouseHoveredViewport     # Backend platform supports calling io.addmouseviewportevent() with the viewport under the mouse. if possible, ignore viewports with the imguiviewportflags_noinputs flag (win32 backend, glfw 3.30+ backend can do this, sdl backend cannot). if this cannot be done, dear imgui needs to use a flawed heuristic to find the viewport under.
        ImGuiBackendFlags_RendererHasViewports        # Backend renderer supports multiple viewports.

    # Enumeration for PushStyleColor() / PopStyleColor()
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
        ImGuiCol_Header                    # Header* colors are used for collapsingheader, treenode, selectable, menuitem
        ImGuiCol_HeaderHovered
        ImGuiCol_HeaderActive
        ImGuiCol_Separator
        ImGuiCol_SeparatorHovered
        ImGuiCol_SeparatorActive
        ImGuiCol_ResizeGrip                # Resize grip in lower-right and lower-left corners of windows.
        ImGuiCol_ResizeGripHovered
        ImGuiCol_ResizeGripActive
        ImGuiCol_Tab                       # Tabitem in a tabbar
        ImGuiCol_TabHovered
        ImGuiCol_TabActive
        ImGuiCol_TabUnfocused
        ImGuiCol_TabUnfocusedActive
        ImGuiCol_DockingPreview            # Preview overlay color when about to docking something
        ImGuiCol_DockingEmptyBg            # Background color for empty node (e.g. centralnode with no window docked into it)
        ImGuiCol_PlotLines
        ImGuiCol_PlotLinesHovered
        ImGuiCol_PlotHistogram
        ImGuiCol_PlotHistogramHovered
        ImGuiCol_TableHeaderBg             # Table header background
        ImGuiCol_TableBorderStrong         # Table outer and header borders (prefer using alpha=1.0 here)
        ImGuiCol_TableBorderLight          # Table inner borders (prefer using alpha=1.0 here)
        ImGuiCol_TableRowBg                # Table row background (even rows)
        ImGuiCol_TableRowBgAlt             # Table row background (odd rows)
        ImGuiCol_TextSelectedBg
        ImGuiCol_DragDropTarget            # Rectangle highlighting a drop target
        ImGuiCol_NavHighlight              # Gamepad/keyboard: current highlighted item
        ImGuiCol_NavWindowingHighlight     # Highlight window when using ctrl+tab
        ImGuiCol_NavWindowingDimBg         # Darken/colorize entire screen behind the ctrl+tab window list, when active
        ImGuiCol_ModalWindowDimBg          # Darken/colorize entire screen behind a modal window, when one is active
        ImGuiCol_COUNT

    # Enumeration for PushStyleVar() / PopStyleVar() to temporarily modify the ImGuiStyle structure.
    # - The enum only refers to fields of ImGuiStyle which makes sense to be pushed/popped inside UI code.
    # During initialization or between frames, feel free to just poke into ImGuiStyle directly.
    # - Tip: Use your programming IDE navigation facilities on the names in the _second column_ below to find the actual members and their description.
    # In Visual Studio IDE: CTRL+comma ("Edit.GoToAll") can follow symbols in comments, whereas CTRL+F12 ("Edit.GoToImplementation") cannot.
    # With Visual Assist installed: ALT+G ("VAssistX.GoToImplementation") can also follow symbols in comments.
    # - When changing this enum, you need to update the associated internal table GStyleVarInfo[] accordingly. This is where we link enum values to members offset/type.
    ctypedef enum ImGuiStyleVar_:
        ImGuiStyleVar_Alpha                       # Float     alpha
        ImGuiStyleVar_DisabledAlpha               # Float     disabledalpha
        ImGuiStyleVar_WindowPadding               # Imvec2    windowpadding
        ImGuiStyleVar_WindowRounding              # Float     windowrounding
        ImGuiStyleVar_WindowBorderSize            # Float     windowbordersize
        ImGuiStyleVar_WindowMinSize               # Imvec2    windowminsize
        ImGuiStyleVar_WindowTitleAlign            # Imvec2    windowtitlealign
        ImGuiStyleVar_ChildRounding               # Float     childrounding
        ImGuiStyleVar_ChildBorderSize             # Float     childbordersize
        ImGuiStyleVar_PopupRounding               # Float     popuprounding
        ImGuiStyleVar_PopupBorderSize             # Float     popupbordersize
        ImGuiStyleVar_FramePadding                # Imvec2    framepadding
        ImGuiStyleVar_FrameRounding               # Float     framerounding
        ImGuiStyleVar_FrameBorderSize             # Float     framebordersize
        ImGuiStyleVar_ItemSpacing                 # Imvec2    itemspacing
        ImGuiStyleVar_ItemInnerSpacing            # Imvec2    iteminnerspacing
        ImGuiStyleVar_IndentSpacing               # Float     indentspacing
        ImGuiStyleVar_CellPadding                 # Imvec2    cellpadding
        ImGuiStyleVar_ScrollbarSize               # Float     scrollbarsize
        ImGuiStyleVar_ScrollbarRounding           # Float     scrollbarrounding
        ImGuiStyleVar_GrabMinSize                 # Float     grabminsize
        ImGuiStyleVar_GrabRounding                # Float     grabrounding
        ImGuiStyleVar_TabRounding                 # Float     tabrounding
        ImGuiStyleVar_ButtonTextAlign             # Imvec2    buttontextalign
        ImGuiStyleVar_SelectableTextAlign         # Imvec2    selectabletextalign
        ImGuiStyleVar_SeparatorTextBorderSize     # Float  separatortextbordersize
        ImGuiStyleVar_SeparatorTextAlign          # Imvec2    separatortextalign
        ImGuiStyleVar_SeparatorTextPadding        # Imvec2    separatortextpadding
        ImGuiStyleVar_COUNT

    # Flags for InvisibleButton() [extended in imgui_internal.h]
    ctypedef enum ImGuiButtonFlags_:
        ImGuiButtonFlags_None
        ImGuiButtonFlags_MouseButtonLeft         # React on left mouse button (default)
        ImGuiButtonFlags_MouseButtonRight        # React on right mouse button
        ImGuiButtonFlags_MouseButtonMiddle       # React on center mouse button
        ImGuiButtonFlags_MouseButtonMask_
        ImGuiButtonFlags_MouseButtonDefault_

    # Flags for ColorEdit3() / ColorEdit4() / ColorPicker3() / ColorPicker4() / ColorButton()
    ctypedef enum ImGuiColorEditFlags_:
        ImGuiColorEditFlags_None
        ImGuiColorEditFlags_NoAlpha              # Coloredit, colorpicker, colorbutton: ignore alpha component (will only read 3 components from the input pointer).
        ImGuiColorEditFlags_NoPicker             # Coloredit: disable picker when clicking on color square.
        ImGuiColorEditFlags_NoOptions            # Coloredit: disable toggling options menu when right-clicking on inputs/small preview.
        ImGuiColorEditFlags_NoSmallPreview       # Coloredit, colorpicker: disable color square preview next to the inputs. (e.g. to show only the inputs)
        ImGuiColorEditFlags_NoInputs             # Coloredit, colorpicker: disable inputs sliders/text widgets (e.g. to show only the small preview color square).
        ImGuiColorEditFlags_NoTooltip            # Coloredit, colorpicker, colorbutton: disable tooltip when hovering the preview.
        ImGuiColorEditFlags_NoLabel              # Coloredit, colorpicker: disable display of inline text label (the label is still forwarded to the tooltip and picker).
        ImGuiColorEditFlags_NoSidePreview        # Colorpicker: disable bigger color preview on right side of the picker, use small color square preview instead.
        ImGuiColorEditFlags_NoDragDrop           # Coloredit: disable drag and drop target. colorbutton: disable drag and drop source.
        ImGuiColorEditFlags_NoBorder             # Colorbutton: disable border (which is enforced by default)
        ImGuiColorEditFlags_AlphaBar             # Coloredit, colorpicker: show vertical alpha bar/gradient in picker.
        ImGuiColorEditFlags_AlphaPreview         # Coloredit, colorpicker, colorbutton: display preview as a transparent color over a checkerboard, instead of opaque.
        ImGuiColorEditFlags_AlphaPreviewHalf     # Coloredit, colorpicker, colorbutton: display half opaque / half checkerboard, instead of opaque.
        ImGuiColorEditFlags_HDR                  # (wip) coloredit: currently only disable 0.0f..1.0f limits in rgba edition (note: you probably want to use imguicoloreditflags_float flag as well).
        ImGuiColorEditFlags_DisplayRGB           # [display]    // coloredit: override _display_ type among rgb/hsv/hex. colorpicker: select any combination using one or more of rgb/hsv/hex.
        ImGuiColorEditFlags_DisplayHSV           # [display]    // '
        ImGuiColorEditFlags_DisplayHex           # [display]    // '
        ImGuiColorEditFlags_Uint8                # [datatype]   // coloredit, colorpicker, colorbutton: _display_ values formatted as 0..255.
        ImGuiColorEditFlags_Float                # [datatype]   // coloredit, colorpicker, colorbutton: _display_ values formatted as 0.0f..1.0f floats instead of 0..255 integers. no round-trip of value via integers.
        ImGuiColorEditFlags_PickerHueBar         # [picker]     // colorpicker: bar for hue, rectangle for sat/value.
        ImGuiColorEditFlags_PickerHueWheel       # [picker]     // colorpicker: wheel for hue, triangle for sat/value.
        ImGuiColorEditFlags_InputRGB             # [input]      // coloredit, colorpicker: input and output data in rgb format.
        ImGuiColorEditFlags_InputHSV             # [input]      // coloredit, colorpicker: input and output data in hsv format.
        ImGuiColorEditFlags_DefaultOptions_
        ImGuiColorEditFlags_DisplayMask_
        ImGuiColorEditFlags_DataTypeMask_
        ImGuiColorEditFlags_PickerMask_
        ImGuiColorEditFlags_InputMask_

    # Flags for DragFloat(), DragInt(), SliderFloat(), SliderInt() etc.
    # We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
    # (Those are per-item flags. There are shared flags in ImGuiIO: io.ConfigDragClickToInputText)
    ctypedef enum ImGuiSliderFlags_:
        ImGuiSliderFlags_None
        ImGuiSliderFlags_AlwaysClamp         # Clamp value to min/max bounds when input manually with ctrl+click. by default ctrl+click allows going out of bounds.
        ImGuiSliderFlags_Logarithmic         # Make the widget logarithmic (linear otherwise). consider using imguisliderflags_noroundtoformat with this if using a format-string with small amount of digits.
        ImGuiSliderFlags_NoRoundToFormat     # Disable rounding underlying value to match precision of the display format string (e.g. %.3f values are rounded to those 3 digits)
        ImGuiSliderFlags_NoInput             # Disable ctrl+click or enter key allowing to input text directly into the widget
        ImGuiSliderFlags_InvalidMask_        # [internal] we treat using those bits as being potentially a 'float power' argument from the previous api that has got miscast to this enum, and will trigger an assert if needed.

    # Identify a mouse button.
    # Those values are guaranteed to be stable and we frequently use 0/1 directly. Named enums provided for convenience.
    ctypedef enum ImGuiMouseButton_:
        ImGuiMouseButton_Left
        ImGuiMouseButton_Right
        ImGuiMouseButton_Middle
        ImGuiMouseButton_COUNT

    # Enumeration for GetMouseCursor()
    # User code may request backend to display given cursor by calling SetMouseCursor(), which is why we have some cursors that are marked unused here
    ctypedef enum ImGuiMouseCursor_:
        ImGuiMouseCursor_None
        ImGuiMouseCursor_Arrow
        ImGuiMouseCursor_TextInput      # When hovering over inputtext, etc.
        ImGuiMouseCursor_ResizeAll      # (unused by dear imgui functions)
        ImGuiMouseCursor_ResizeNS       # When hovering over a horizontal border
        ImGuiMouseCursor_ResizeEW       # When hovering over a vertical border or a column
        ImGuiMouseCursor_ResizeNESW     # When hovering over the bottom-left corner of a window
        ImGuiMouseCursor_ResizeNWSE     # When hovering over the bottom-right corner of a window
        ImGuiMouseCursor_Hand           # (unused by dear imgui functions. use for e.g. hyperlinks)
        ImGuiMouseCursor_NotAllowed     # When hovering something with disallowed interaction. usually a crossed circle.
        ImGuiMouseCursor_COUNT

    # Enumeration for AddMouseSourceEvent() actual source of Mouse Input data.
    # Historically we use "Mouse" terminology everywhere to indicate pointer data, e.g. MousePos, IsMousePressed(), io.AddMousePosEvent()
    # But that "Mouse" data can come from different source which occasionally may be useful for application to know about.
    # You can submit a change of pointer type using io.AddMouseSourceEvent().
    # Forward declared enum type imguimousesource
    ctypedef enum ImGuiMouseSource:
        ImGuiMouseSource_Mouse           # Input is coming from an actual mouse.
        ImGuiMouseSource_TouchScreen     # Input is coming from a touch screen (no hovering prior to initial press, less precise initial press aiming, dual-axis wheeling possible).
        ImGuiMouseSource_Pen             # Input is coming from a pressure/magnetic pen (often used in conjunction with high-sampling rates).
        ImGuiMouseSource_COUNT

    # Enumeration for ImGui::SetWindow***(), SetNextWindow***(), SetNextItem***() functions
    # Represent a condition.
    # Important: Treat as a regular enum! Do NOT combine multiple values using binary operators! All the functions above treat 0 as a shortcut to ImGuiCond_Always.
    ctypedef enum ImGuiCond_:
        ImGuiCond_None             # No condition (always set the variable), same as _always
        ImGuiCond_Always           # No condition (always set the variable), same as _none
        ImGuiCond_Once             # Set the variable once per runtime session (only the first call will succeed)
        ImGuiCond_FirstUseEver     # Set the variable if the object/window has no persistently saved data (no entry in .ini file)
        ImGuiCond_Appearing        # Set the variable if the object/window is appearing after being hidden/inactive (or the first time)

    # Flags for ImDrawList functions
    # (Legacy: bit 0 must always correspond to ImDrawFlags_Closed to be backward compatible with old API using a bool. Bits 1..3 must be unused)
    ctypedef enum ImDrawFlags_:
        ImDrawFlags_None
        ImDrawFlags_Closed                      # Pathstroke(), addpolyline(): specify that shape should be closed (important: this is always == 1 for legacy reason)
        ImDrawFlags_RoundCornersTopLeft         # Addrect(), addrectfilled(), pathrect(): enable rounding top-left corner only (when rounding > 0.0f, we default to all corners). was 0x01.
        ImDrawFlags_RoundCornersTopRight        # Addrect(), addrectfilled(), pathrect(): enable rounding top-right corner only (when rounding > 0.0f, we default to all corners). was 0x02.
        ImDrawFlags_RoundCornersBottomLeft      # Addrect(), addrectfilled(), pathrect(): enable rounding bottom-left corner only (when rounding > 0.0f, we default to all corners). was 0x04.
        ImDrawFlags_RoundCornersBottomRight     # Addrect(), addrectfilled(), pathrect(): enable rounding bottom-right corner only (when rounding > 0.0f, we default to all corners). wax 0x08.
        ImDrawFlags_RoundCornersNone            # Addrect(), addrectfilled(), pathrect(): disable rounding on all corners (when rounding > 0.0f). this is not zero, not an implicit flag!
        ImDrawFlags_RoundCornersTop
        ImDrawFlags_RoundCornersBottom
        ImDrawFlags_RoundCornersLeft
        ImDrawFlags_RoundCornersRight
        ImDrawFlags_RoundCornersAll
        ImDrawFlags_RoundCornersDefault_        # Default to all corners if none of the _roundcornersxx flags are specified.
        ImDrawFlags_RoundCornersMask_

    # Flags for ImDrawList instance. Those are set automatically by ImGui:: functions from ImGuiIO settings, and generally not manipulated directly.
    # It is however possible to temporarily alter flags between calls to ImDrawList:: functions.
    ctypedef enum ImDrawListFlags_:
        ImDrawListFlags_None
        ImDrawListFlags_AntiAliasedLines           # Enable anti-aliased lines/borders (*2 the number of triangles for 1.0f wide line or lines thin enough to be drawn using textures, otherwise *3 the number of triangles)
        ImDrawListFlags_AntiAliasedLinesUseTex     # Enable anti-aliased lines/borders using textures when possible. require backend to render with bilinear filtering (not point/nearest filtering).
        ImDrawListFlags_AntiAliasedFill            # Enable anti-aliased edge around filled shapes (rounded rectangles, circles).
        ImDrawListFlags_AllowVtxOffset             # Can emit 'vtxoffset > 0' to allow large meshes. set when 'imguibackendflags_rendererhasvtxoffset' is enabled.

    # Flags for ImFontAtlas build
    ctypedef enum ImFontAtlasFlags_:
        ImFontAtlasFlags_None
        ImFontAtlasFlags_NoPowerOfTwoHeight     # Don't round the height to next power of two
        ImFontAtlasFlags_NoMouseCursors         # Don't build software mouse cursors into the atlas (save a little texture memory)
        ImFontAtlasFlags_NoBakedLines           # Don't build thick line textures into the atlas (save a little texture memory, allow support for point/nearest filtering). the antialiasedlinesusetex features uses them, otherwise they will be rendered using polygons (more expensive for cpu/gpu).

    # Flags stored in ImGuiViewport::Flags, giving indications to the platform backends.
    ctypedef enum ImGuiViewportFlags_:
        ImGuiViewportFlags_None
        ImGuiViewportFlags_IsPlatformWindow        # Represent a platform window
        ImGuiViewportFlags_IsPlatformMonitor       # Represent a platform monitor (unused yet)
        ImGuiViewportFlags_OwnedByApp              # Platform window: was created/managed by the user application? (rather than our backend)
        ImGuiViewportFlags_NoDecoration            # Platform window: disable platform decorations: title bar, borders, etc. (generally set all windows, but if imguiconfigflags_viewportsdecoration is set we only set this on popups/tooltips)
        ImGuiViewportFlags_NoTaskBarIcon           # Platform window: disable platform task bar icon (generally set on popups/tooltips, or all windows if imguiconfigflags_viewportsnotaskbaricon is set)
        ImGuiViewportFlags_NoFocusOnAppearing      # Platform window: don't take focus when created.
        ImGuiViewportFlags_NoFocusOnClick          # Platform window: don't take focus when clicked on.
        ImGuiViewportFlags_NoInputs                # Platform window: make mouse pass through so we can drag this window while peaking behind it.
        ImGuiViewportFlags_NoRendererClear         # Platform window: renderer doesn't need to clear the framebuffer ahead (because we will fill it entirely).
        ImGuiViewportFlags_NoAutoMerge             # Platform window: avoid merging this window into another host window. this can only be set via imguiwindowclass viewport flags override (because we need to now ahead if we are going to create a viewport in the first place!).
        ImGuiViewportFlags_TopMost                 # Platform window: display on top (for tooltips only).
        ImGuiViewportFlags_CanHostOtherWindows     # Viewport can host multiple imgui windows (secondary viewports are associated to a single window). // fixme: in practice there's still probably code making the assumption that this is always and only on the mainviewport. will fix once we add support for 'no main viewport'.
        ImGuiViewportFlags_IsMinimized             # Platform window: window is minimized, can skip render. when minimized we tend to avoid using the viewport pos/size for clipping window or testing if they are contained in the viewport.
        ImGuiViewportFlags_IsFocused               # Platform window: window is focused (last call to platform_getwindowfocus() returned true)


    # Data shared among multiple draw lists (typically owned by parent imgui context, but you may create one yourself)
    ctypedef struct ImDrawListSharedData:
        pass


    # Opaque interface to a font builder (stb_truetype or freetype).
    ctypedef struct ImFontBuilderIO:
        pass


    # Dear imgui context (opaque structure, unless including imgui_internal.h)
    ctypedef struct ImGuiContext:
        pass


    ctypedef struct ImVec2:
        float x
        float y


    # ImVec4: 4D vector used to store clipping rectangles, colors etc. [Compile-time configurable type]
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
        float Alpha                           # Global alpha applies to everything in dear imgui.
        float DisabledAlpha                   # Additional alpha multiplier applied by begindisabled(). multiply over current value of alpha.
        ImVec2 WindowPadding                  # Padding within a window.
        float WindowRounding                  # Radius of window corners rounding. set to 0.0f to have rectangular windows. large values tend to lead to variety of artifacts and are not recommended.
        float WindowBorderSize                # Thickness of border around windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
        ImVec2 WindowMinSize                  # Minimum window size. this is a global setting. if you want to constrain individual windows, use setnextwindowsizeconstraints().
        ImVec2 WindowTitleAlign               # Alignment for title bar text. defaults to (0.0f,0.5f) for left-aligned,vertically centered.
        ImGuiDir WindowMenuButtonPosition     # Side of the collapsing/docking button in the title bar (none/left/right). defaults to imguidir_left.
        float ChildRounding                   # Radius of child window corners rounding. set to 0.0f to have rectangular windows.
        float ChildBorderSize                 # Thickness of border around child windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
        float PopupRounding                   # Radius of popup window corners rounding. (note that tooltip windows use windowrounding)
        float PopupBorderSize                 # Thickness of border around popup/tooltip windows. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
        ImVec2 FramePadding                   # Padding within a framed rectangle (used by most widgets).
        float FrameRounding                   # Radius of frame corners rounding. set to 0.0f to have rectangular frame (used by most widgets).
        float FrameBorderSize                 # Thickness of border around frames. generally set to 0.0f or 1.0f. (other values are not well tested and more cpu/gpu costly).
        ImVec2 ItemSpacing                    # Horizontal and vertical spacing between widgets/lines.
        ImVec2 ItemInnerSpacing               # Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label).
        ImVec2 CellPadding                    # Padding within a table cell
        ImVec2 TouchExtraPadding              # Expand reactive bounding box for touch-based system where touch position is not accurate enough. unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. so don't grow this too much!
        float IndentSpacing                   # Horizontal indentation when e.g. entering a tree node. generally == (fontsize + framepadding.x*2).
        float ColumnsMinSpacing               # Minimum horizontal spacing between two columns. preferably > (framepadding.x + 1).
        float ScrollbarSize                   # Width of the vertical scrollbar, height of the horizontal scrollbar.
        float ScrollbarRounding               # Radius of grab corners for scrollbar.
        float GrabMinSize                     # Minimum width/height of a grab box for slider/scrollbar.
        float GrabRounding                    # Radius of grabs corners rounding. set to 0.0f to have rectangular slider grabs.
        float LogSliderDeadzone               # The size in pixels of the dead-zone around zero on logarithmic sliders that cross zero.
        float TabRounding                     # Radius of upper corners of a tab. set to 0.0f to have rectangular tabs.
        float TabBorderSize                   # Thickness of border around tabs.
        float TabMinWidthForCloseButton       # Minimum width for close button to appear on an unselected tab when hovered. set to 0.0f to always show when hovering, set to flt_max to never show close button unless selected.
        ImGuiDir ColorButtonPosition          # Side of the color button in the coloredit4 widget (left/right). defaults to imguidir_right.
        ImVec2 ButtonTextAlign                # Alignment of button text when button is larger than text. defaults to (0.5f, 0.5f) (centered).
        ImVec2 SelectableTextAlign            # Alignment of selectable text. defaults to (0.0f, 0.0f) (top-left aligned). it's generally important to keep this left-aligned if you want to lay multiple items on a same line.
        float SeparatorTextBorderSize         # Thickkness of border in separatortext()
        ImVec2 SeparatorTextAlign             # Alignment of text within the separator. defaults to (0.0f, 0.5f) (left aligned, center).
        ImVec2 SeparatorTextPadding           # Horizontal offset of text from each edge of the separator + spacing on other axis. generally small values. .y is recommended to be == framepadding.y.
        ImVec2 DisplayWindowPadding           # Window position are clamped to be visible within the display area or monitors by at least this amount. only applies to regular windows.
        ImVec2 DisplaySafeAreaPadding         # If you cannot see the edges of your screen (e.g. on a tv) increase the safe area padding. apply to popups/tooltips as well regular windows. nb: prefer configuring your tv sets correctly!
        float MouseCursorScale                # Scale software rendered mouse cursor (when io.mousedrawcursor is enabled). we apply per-monitor dpi scaling over this scale. may be removed later.
        bool AntiAliasedLines                 # Enable anti-aliased lines/borders. disable if you are really tight on cpu/gpu. latched at the beginning of the frame (copied to imdrawlist).
        bool AntiAliasedLinesUseTex           # Enable anti-aliased lines/borders using textures where possible. require backend to render with bilinear filtering (not point/nearest filtering). latched at the beginning of the frame (copied to imdrawlist).
        bool AntiAliasedFill                  # Enable anti-aliased edges around filled shapes (rounded rectangles, circles, etc.). disable if you are really tight on cpu/gpu. latched at the beginning of the frame (copied to imdrawlist).
        float CurveTessellationTol            # Tessellation tolerance when using pathbeziercurveto() without a specific number of segments. decrease for highly tessellated curves (higher quality, more polygons), increase to reduce quality.
        float CircleTessellationMaxError      # Maximum error (in pixels) allowed when using addcircle()/addcirclefilled() or drawing rounded corner rectangles with no explicit segment count specified. decrease for higher quality but more geometry.
        ImVec4* Colors

    void ImGuiStyle_ScaleAllSizes(ImGuiStyle* self, float scale_factor) except +

    # [Internal] Storage used by IsKeyDown(), IsKeyPressed() etc functions.
    # If prior to 1.87 you used io.KeysDownDuration[] (which was marked as internal), you should use GetKeyData(key)->DownDuration and *NOT* io.KeysData[key]->DownDuration.
    ctypedef struct ImGuiKeyData:
        bool Down                  # True for if key is down
        float DownDuration         # Duration the key has been down (<0.0f: not pressed, 0.0f: just pressed, >0.0f: time held)
        float DownDurationPrev     # Last frame duration the key has been down
        float AnalogValue          # 0.0f..1.0f for gamepad values


    ctypedef struct ImGuiIO:
        ImGuiConfigFlags ConfigFlags                                                                               # = 0              // see imguiconfigflags_ enum. set by user/application. gamepad/keyboard navigation options, etc.
        ImGuiBackendFlags BackendFlags                                                                             # = 0              // see imguibackendflags_ enum. set by backend (imgui_impl_xxx files or custom backend) to communicate features supported by the backend.
        ImVec2 DisplaySize                                                                                         # <unset>          // main display size, in pixels (generally == getmainviewport()->size). may change every frame.
        float DeltaTime                                                                                            # = 1.0f/60.0f     // time elapsed since last frame, in seconds. may change every frame.
        float IniSavingRate                                                                                        # = 5.0f           // minimum time between saving positions/sizes to .ini file, in seconds.
        const char* IniFilename                                                                                    # = 'imgui.ini'    // path to .ini file (important: default 'imgui.ini' is relative to current working dir!). set null to disable automatic .ini loading/saving or if you want to manually call loadinisettingsxxx() / saveinisettingsxxx() functions.
        const char* LogFilename                                                                                    # = 'imgui_log.txt'// path to .log file (default parameter to imgui::logtofile when no file is specified).
        float MouseDoubleClickTime                                                                                 # = 0.30f          // time for a double-click, in seconds.
        float MouseDoubleClickMaxDist                                                                              # = 6.0f           // distance threshold to stay in to validate a double-click, in pixels.
        float MouseDragThreshold                                                                                   # = 6.0f           // distance threshold before considering we are dragging.
        float KeyRepeatDelay                                                                                       # = 0.275f         // when holding a key/button, time before it starts repeating, in seconds (for buttons in repeat mode, etc.).
        float KeyRepeatRate                                                                                        # = 0.050f         // when holding a key/button, rate at which it repeats, in seconds.
        float HoverDelayNormal                                                                                     # = 0.30 sec       // delay on hovering before isitemhovered(imguihoveredflags_delaynormal) returns true.
        float HoverDelayShort                                                                                      # = 0.10 sec       // delay on hovering before isitemhovered(imguihoveredflags_delayshort) returns true.
        void* UserData                                                                                             # = null           // store your own data.
        ImFontAtlas* Fonts                                                                                         # <auto>           // font atlas: load, rasterize and pack one or more fonts into a single texture.
        float FontGlobalScale                                                                                      # = 1.0f           // global scale all fonts
        bool FontAllowUserScaling                                                                                  # = false          // allow user scaling text of individual window with ctrl+wheel.
        ImFont* FontDefault                                                                                        # = null           // font to use on newframe(). use null to uses fonts->fonts[0].
        ImVec2 DisplayFramebufferScale                                                                             # = (1, 1)         // for retina display or other situations where window coordinates are different from framebuffer coordinates. this generally ends up in imdrawdata::framebufferscale.
        bool ConfigDockingNoSplit                                                                                  # = false          // simplified docking mode: disable window splitting, so docking is limited to merging multiple windows together into tab-bars.
        bool ConfigDockingWithShift                                                                                # = false          // enable docking with holding shift key (reduce visual noise, allows dropping in wider space)
        bool ConfigDockingAlwaysTabBar                                                                             # = false          // [beta] [fixme: this currently creates regression with auto-sizing and general overhead] make every single floating window display within a docking node.
        bool ConfigDockingTransparentPayload                                                                       # = false          // [beta] make window or viewport transparent when docking and only display docking boxes on the target viewport. useful if rendering of multiple viewport cannot be synced. best used with configviewportsnoautomerge.
        bool ConfigViewportsNoAutoMerge                                                                            # = false;         // set to make all floating imgui windows always create their own viewport. otherwise, they are merged into the main host viewports when overlapping it. may also set imguiviewportflags_noautomerge on individual viewport.
        bool ConfigViewportsNoTaskBarIcon                                                                          # = false          // disable default os task bar icon flag for secondary viewports. when a viewport doesn't want a task bar icon, imguiviewportflags_notaskbaricon will be set on it.
        bool ConfigViewportsNoDecoration                                                                           # = true           // disable default os window decoration flag for secondary viewports. when a viewport doesn't want window decorations, imguiviewportflags_nodecoration will be set on it. enabling decoration can create subsequent issues at os levels (e.g. minimum window size).
        bool ConfigViewportsNoDefaultParent                                                                        # = false          // disable default os parenting to main viewport for secondary viewports. by default, viewports are marked with parentviewportid = <main_viewport>, expecting the platform backend to setup a parent/child relationship between the os windows (some backend may ignore this). set to true if you want the default to be 0, then all viewports will be top-level os windows.
        bool MouseDrawCursor                                                                                       # = false          // request imgui to draw a mouse cursor for you (if you are on a platform without a mouse cursor). cannot be easily renamed to 'io.configxxx' because this is frequently used by backend implementations.
        bool ConfigMacOSXBehaviors                                                                                 # = defined(__apple__) // os x style: text editing cursor movement using alt instead of ctrl, shortcuts using cmd/super instead of ctrl, line/text start and end using cmd+arrows instead of home/end, double click selects by word instead of selecting whole text, multi-selection in lists uses cmd/super instead of ctrl.
        bool ConfigInputTrickleEventQueue                                                                          # = true           // enable input queue trickling: some types of events submitted during the same frame (e.g. button down + up) will be spread over multiple frames, improving interactions with low framerates.
        bool ConfigInputTextCursorBlink                                                                            # = true           // enable blinking cursor (optional as some users consider it to be distracting).
        bool ConfigInputTextEnterKeepActive                                                                        # = false          // [beta] pressing enter will keep item active and select contents (single-line only).
        bool ConfigDragClickToInputText                                                                            # = false          // [beta] enable turning dragxxx widgets into text input with a simple mouse click-release (without moving). not desirable on devices without a keyboard.
        bool ConfigWindowsResizeFromEdges                                                                          # = true           // enable resizing of windows from their edges and from the lower-left corner. this requires (io.backendflags & imguibackendflags_hasmousecursors) because it needs mouse cursor feedback. (this used to be a per-window imguiwindowflags_resizefromanyside flag)
        bool ConfigWindowsMoveFromTitleBarOnly                                                                     # = false       // enable allowing to move windows only when clicking on their title bar. does not apply to windows without a title bar.
        float ConfigMemoryCompactTimer                                                                             # = 60.0f          // timer (in seconds) to free transient windows/tables memory buffers when unused. set to -1.0f to disable.
        bool ConfigDebugBeginReturnValueOnce                                                                       # = false         // first-time calls to begin()/beginchild() will return false. needs to be set at application boot time if you don't want to miss windows.
        bool ConfigDebugBeginReturnValueLoop                                                                       # = false         // some calls to begin()/beginchild() will return false. will cycle through window depths then repeat. suggested use: add 'io.configdebugbeginreturnvalue = io.keyshift' in your main loop then occasionally press shift. windows should be flickering while running.
        const char* BackendPlatformName                                                                            # = null
        const char* BackendRendererName                                                                            # = null
        void* BackendPlatformUserData                                                                              # = null           // user data for platform backend
        void* BackendRendererUserData                                                                              # = null           // user data for renderer backend
        void* BackendLanguageUserData                                                                              # = null           // user data for non c++ programming language backend
        const char* (*GetClipboardTextFn)(void* user_data)
        void (*SetClipboardTextFn)(void* user_data, const char* text)
        void* ClipboardUserData
        void (*SetPlatformImeDataFn)(ImGuiViewport* viewport, ImGuiPlatformImeData* data)
        bool WantCaptureMouse                                                                                      # Set when dear imgui will use mouse inputs, in this case do not dispatch them to your main game/application (either way, always pass on mouse inputs to imgui). (e.g. unclicked mouse is hovering over an imgui window, widget is active, mouse was clicked over an imgui window, etc.).
        bool WantCaptureKeyboard                                                                                   # Set when dear imgui will use keyboard inputs, in this case do not dispatch them to your main game/application (either way, always pass keyboard inputs to imgui). (e.g. inputtext active, or an imgui window is focused and navigation is enabled, etc.).
        bool WantTextInput                                                                                         # Mobile/console: when set, you may display an on-screen keyboard. this is set by dear imgui when it wants textual keyboard input to happen (e.g. when a inputtext widget is active).
        bool WantSetMousePos                                                                                       # Mousepos has been altered, backend should reposition mouse on next frame. rarely used! set only when imguiconfigflags_navenablesetmousepos flag is enabled.
        bool WantSaveIniSettings                                                                                   # When manual .ini load/save is active (io.inifilename == null), this will be set to notify your application that you can call saveinisettingstomemory() and save yourself. important: clear io.wantsaveinisettings yourself after saving!
        bool NavActive                                                                                             # Keyboard/gamepad navigation is currently allowed (will handle imguikey_navxxx events) = a window is focused and it doesn't use the imguiwindowflags_nonavinputs flag.
        bool NavVisible                                                                                            # Keyboard/gamepad navigation is visible and allowed (will handle imguikey_navxxx events).
        float Framerate                                                                                            # Estimate of application framerate (rolling average over 60 frames, based on io.deltatime), in frame per second. solely for convenience. slow applications may not want to use a moving average or may want to reset underlying buffers occasionally.
        int MetricsRenderVertices                                                                                  # Vertices output during last call to render()
        int MetricsRenderIndices                                                                                   # Indices output during last call to render() = number of triangles * 3
        int MetricsRenderWindows                                                                                   # Number of visible windows
        int MetricsActiveWindows                                                                                   # Number of active windows
        int MetricsActiveAllocations                                                                               # Number of active allocations, updated by memalloc/memfree based on current context. may be off if you have multiple imgui contexts.
        ImVec2 MouseDelta                                                                                          # Mouse delta. note that this is zero if either current or previous position are invalid (-flt_max,-flt_max), so a disappearing/reappearing mouse won't have a huge delta.
        ImGuiContext* Ctx                                                                                          # Parent ui context (needs to be set explicitly by parent).
        ImVec2 MousePos                                                                                            # Mouse position, in pixels. set to imvec2(-flt_max, -flt_max) if mouse is unavailable (on another screen, etc.)
        bool* MouseDown                                                                                            # Mouse buttons: 0=left, 1=right, 2=middle + extras (imguimousebutton_count == 5). dear imgui mostly uses left and right buttons. other buttons allow us to track if the mouse is being used by your application + available to user as a convenience via ismouse** api.
        float MouseWheel                                                                                           # Mouse wheel vertical: 1 unit scrolls about 5 lines text. >0 scrolls up, <0 scrolls down. hold shift to turn vertical scroll into horizontal scroll.
        float MouseWheelH                                                                                          # Mouse wheel horizontal. >0 scrolls left, <0 scrolls right. most users don't have a mouse with a horizontal wheel, may not be filled by all backends.
        ImGuiMouseSource MouseSource                                                                               # Mouse actual input peripheral (mouse/touchscreen/pen).
        ImGuiID MouseHoveredViewport                                                                               # (optional) modify using io.addmouseviewportevent(). with multi-viewports: viewport the os mouse is hovering. if possible _ignoring_ viewports with the imguiviewportflags_noinputs flag is much better (few backends can handle that). set io.backendflags |= imguibackendflags_hasmousehoveredviewport if you can provide this info. if you don't imgui will infer the value using the rectangles and last focused time of the viewports it knows about (ignoring other os windows).
        bool KeyCtrl                                                                                               # Keyboard modifier down: control
        bool KeyShift                                                                                              # Keyboard modifier down: shift
        bool KeyAlt                                                                                                # Keyboard modifier down: alt
        bool KeySuper                                                                                              # Keyboard modifier down: cmd/super/windows
        ImGuiKeyChord KeyMods                                                                                      # Key mods flags (any of imguimod_ctrl/imguimod_shift/imguimod_alt/imguimod_super flags, same as io.keyctrl/keyshift/keyalt/keysuper but merged into flags. does not contains imguimod_shortcut which is pretranslated). read-only, updated by newframe()
        ImGuiKeyData* KeysData                                                                                     # Key state for all known keys. use iskeyxxx() functions to access this.
        bool WantCaptureMouseUnlessPopupClose                                                                      # Alternative to wantcapturemouse: (wantcapturemouse == true && wantcapturemouseunlesspopupclose == false) when a click over void is expected to close a popup.
        ImVec2 MousePosPrev                                                                                        # Previous mouse position (note that mousedelta is not necessary == mousepos-mouseposprev, in case either position is invalid)
        ImVec2* MouseClickedPos                                                                                    # Position at time of clicking
        double* MouseClickedTime                                                                                   # Time of last click (used to figure out double-click)
        bool* MouseClicked                                                                                         # Mouse button went from !down to down (same as mouseclickedcount[x] != 0)
        bool* MouseDoubleClicked                                                                                   # Has mouse button been double-clicked? (same as mouseclickedcount[x] == 2)
        ImU16* MouseClickedCount                                                                                   # == 0 (not clicked), == 1 (same as mouseclicked[]), == 2 (double-clicked), == 3 (triple-clicked) etc. when going from !down to down
        ImU16* MouseClickedLastCount                                                                               # Count successive number of clicks. stays valid after mouse release. reset after another click is done.
        bool* MouseReleased                                                                                        # Mouse button went from down to !down
        bool* MouseDownOwned                                                                                       # Track if button was clicked inside a dear imgui window or over void blocked by a popup. we don't request mouse capture from the application if click started outside imgui bounds.
        bool* MouseDownOwnedUnlessPopupClose                                                                       # Track if button was clicked inside a dear imgui window.
        bool MouseWheelRequestAxisSwap                                                                             # On a non-mac system, holding shift requests wheely to perform the equivalent of a wheelx event. on a mac system this is already enforced by the system.
        float* MouseDownDuration                                                                                   # Duration the mouse button has been down (0.0f == just clicked)
        float* MouseDownDurationPrev                                                                               # Previous time the mouse button has been down
        ImVec2* MouseDragMaxDistanceAbs                                                                            # Maximum distance, absolute, on each axis, of how much mouse has traveled from the clicking point
        float* MouseDragMaxDistanceSqr                                                                             # Squared maximum distance of how much mouse has traveled from the clicking point (used for moving thresholds)
        float PenPressure                                                                                          # Touch/pen pressure (0.0f to 1.0f, should be >0.0f only when mousedown[0] == true). helper storage currently unused by dear imgui.
        bool AppFocusLost                                                                                          # Only modify via addfocusevent()
        bool AppAcceptingEvents                                                                                    # Only modify via setappacceptingevents()
        ImS8 BackendUsingLegacyKeyArrays                                                                           # -1: unknown, 0: using addkeyevent(), 1: using legacy io.keysdown[]
        bool BackendUsingLegacyNavInputArray                                                                       # 0: using addkeyanalogevent(), 1: writing to legacy io.navinputs[] directly
        ImWchar16 InputQueueSurrogate                                                                              # For addinputcharacterutf16()
        ImVector_ImWchar InputQueueCharacters                                                                      # Queue of _characters_ input (obtained by platform backend). fill using addinputcharacter() helper.


    # Queue a gain/loss of focus for the application (generally based on os/platform focus of your window)
    void ImGuiIO_AddFocusEvent(ImGuiIO* self, bool focused) except +

    # Queue a new character input
    void ImGuiIO_AddInputCharacter(ImGuiIO* self, unsigned int c) except +

    # Queue a new character input from a utf-16 character, it can be a surrogate
    void ImGuiIO_AddInputCharacterUTF16(ImGuiIO* self, ImWchar16 c) except +

    # Queue a new characters input from a utf-8 string
    void ImGuiIO_AddInputCharactersUTF8(ImGuiIO* self, const char* str_) except +

    # Queue a new key down/up event for analog values (e.g. imguikey_gamepad_ values). dead-zones should be handled by the backend.
    void ImGuiIO_AddKeyAnalogEvent(ImGuiIO* self, ImGuiKey key, bool down, float v) except +

    # Input Functions
    # Queue a new key down/up event. key should be 'translated' (as in, generally imguikey_a matches the key end-user would use to emit an 'a' character)
    void ImGuiIO_AddKeyEvent(ImGuiIO* self, ImGuiKey key, bool down) except +

    # Queue a mouse button change
    void ImGuiIO_AddMouseButtonEvent(ImGuiIO* self, int button, bool down) except +

    # Queue a mouse position update. use -flt_max,-flt_max to signify no mouse (e.g. app not focused and not hovered)
    void ImGuiIO_AddMousePosEvent(ImGuiIO* self, float x, float y) except +

    # Queue a mouse source change (mouse/touchscreen/pen)
    void ImGuiIO_AddMouseSourceEvent(ImGuiIO* self, ImGuiMouseSource source) except +

    # Queue a mouse hovered viewport. requires backend to set imguibackendflags_hasmousehoveredviewport to call this (for multi-viewport support).
    void ImGuiIO_AddMouseViewportEvent(ImGuiIO* self, ImGuiID id_) except +

    # Queue a mouse wheel update. wheel_y<0: scroll down, wheel_y>0: scroll up, wheel_x<0: scroll right, wheel_x>0: scroll left.
    void ImGuiIO_AddMouseWheelEvent(ImGuiIO* self, float wheel_x, float wheel_y) except +

    # [internal] clear the text input buffer manually
    void ImGuiIO_ClearInputCharacters(ImGuiIO* self) except +

    # [internal] release all keys
    void ImGuiIO_ClearInputKeys(ImGuiIO* self) except +

    # Set master flag for accepting key/mouse/text events (default to true). useful if you have native dialog boxes that are interrupting your application loop/refresh, and you want to disable events being queued while your app is frozen.
    void ImGuiIO_SetAppAcceptingEvents(ImGuiIO* self, bool accepting_events) except +

    # Implied native_legacy_index = -1
    void ImGuiIO_SetKeyEventNativeData(ImGuiIO* self, ImGuiKey key, int native_keycode, int native_scancode) except +

    # [optional] specify index for legacy <1.87 iskeyxxx() functions with native indices + specify native keycode, scancode.
    void ImGuiIO_SetKeyEventNativeDataEx(ImGuiIO* self, ImGuiKey key, int native_keycode, int native_scancode, int native_legacy_index) except +

    # Shared state of InputText(), passed as an argument to your callback when a ImGuiInputTextFlags_Callback* flag is used.
    # The callback function should return 0 by default.
    # Callbacks (follow a flag name and see comments in ImGuiInputTextFlags_ declarations for more details)
    # - ImGuiInputTextFlags_CallbackEdit:        Callback on buffer edit (note that InputText() already returns true on edit, the callback is useful mainly to manipulate the underlying buffer while focus is active)
    # - ImGuiInputTextFlags_CallbackAlways:      Callback on each iteration
    # - ImGuiInputTextFlags_CallbackCompletion:  Callback on pressing TAB
    # - ImGuiInputTextFlags_CallbackHistory:     Callback on pressing Up/Down arrows
    # - ImGuiInputTextFlags_CallbackCharFilter:  Callback on character inputs to replace or discard them. Modify 'EventChar' to replace or discard, or return 1 in callback to discard.
    # - ImGuiInputTextFlags_CallbackResize:      Callback on buffer capacity changes request (beyond 'buf_size' parameter value), allowing the string to grow.
    ctypedef struct ImGuiInputTextCallbackData:
        ImGuiContext* Ctx                 # Parent ui context
        ImGuiInputTextFlags EventFlag     # One imguiinputtextflags_callback*    // read-only
        ImGuiInputTextFlags Flags         # What user passed to inputtext()      // read-only
        void* UserData                    # What user passed to inputtext()      // read-only
        ImWchar EventChar                 # Character input                      // read-write   // [charfilter] replace character with another one, or set to zero to drop. return 1 is equivalent to setting eventchar=0;
        ImGuiKey EventKey                 # Key pressed (up/down/tab)            // read-only    // [completion,history]
        char* Buf                         # Text buffer                          // read-write   // [resize] can replace pointer / [completion,history,always] only write to pointed data, don't replace the actual pointer!
        int BufTextLen                    # Text length (in bytes)               // read-write   // [resize,completion,history,always] exclude zero-terminator storage. in c land: == strlen(some_text), in c++ land: string.length()
        int BufSize                       # Buffer size (in bytes) = capacity+1  // read-only    // [resize,completion,history,always] include zero-terminator storage. in c land == arraysize(my_char_array), in c++ land: string.capacity()+1
        bool BufDirty                     # Set if you modify buf/buftextlen!    // write        // [completion,history,always]
        int CursorPos                     # Read-write   // [completion,history,always]
        int SelectionStart                # Read-write   // [completion,history,always] == to selectionend when no selection)
        int SelectionEnd                  # Read-write   // [completion,history,always]

    void ImGuiInputTextCallbackData_ClearSelection(ImGuiInputTextCallbackData* self) except +
    void ImGuiInputTextCallbackData_DeleteChars(ImGuiInputTextCallbackData* self, int pos, int bytes_count) except +
    bool ImGuiInputTextCallbackData_HasSelection(const ImGuiInputTextCallbackData* self) except +
    void ImGuiInputTextCallbackData_InsertChars(ImGuiInputTextCallbackData* self, int pos, const char* text, const char* text_end) except +
    void ImGuiInputTextCallbackData_SelectAll(ImGuiInputTextCallbackData* self) except +

    # Resizing callback data to apply custom constraint. As enabled by SetNextWindowSizeConstraints(). Callback is called during the next Begin().
    # NB: For basic min/max size constraint on each axis you don't need to use the callback! The SetNextWindowSizeConstraints() parameters are enough.
    ctypedef struct ImGuiSizeCallbackData:
        void* UserData         # Read-only.   what user passed to setnextwindowsizeconstraints(). generally store an integer or float in here (need reinterpret_cast<>).
        ImVec2 Pos             # Read-only.   window position, for reference.
        ImVec2 CurrentSize     # Read-only.   current window size.
        ImVec2 DesiredSize     # Read-write.  desired size, based on user's mouse position. write to this field to restrain resizing.


    # [ALPHA] Rarely used / very advanced uses only. Use with SetNextWindowClass() and DockSpace() functions.
    # Important: the content of this class is still highly WIP and likely to change and be refactored
    # before we stabilize Docking features. Please be mindful if using this.
    # Provide hints:
    # - To the platform backend via altered viewport flags (enable/disable OS decoration, OS task bar icons, etc.)
    # - To the platform backend for OS level parent/child relationships of viewport.
    # - To the docking system for various options and filtering.
    ctypedef struct ImGuiWindowClass:
        ImGuiID ClassId                                   # User data. 0 = default class (unclassed). windows of different classes cannot be docked with each others.
        ImGuiID ParentViewportId                          # Hint for the platform backend. -1: use default. 0: request platform backend to not parent the platform. != 0: request platform backend to create a parent<>child relationship between the platform windows. not conforming backends are free to e.g. parent every viewport to the main viewport or not.
        ImGuiViewportFlags ViewportFlagsOverrideSet       # Viewport flags to set when a window of this class owns a viewport. this allows you to enforce os decoration or task bar icon, override the defaults on a per-window basis.
        ImGuiViewportFlags ViewportFlagsOverrideClear     # Viewport flags to clear when a window of this class owns a viewport. this allows you to enforce os decoration or task bar icon, override the defaults on a per-window basis.
        ImGuiTabItemFlags TabItemFlagsOverrideSet         # [experimental] tabitem flags to set when a window of this class gets submitted into a dock node tab bar. may use with imguitabitemflags_leading or imguitabitemflags_trailing.
        ImGuiDockNodeFlags DockNodeFlagsOverrideSet       # [experimental] dock node flags to set when a window of this class is hosted by a dock node (it doesn't have to be selected!)
        bool DockingAlwaysTabBar                          # Set to true to enforce single floating windows of this class always having their own docking node (equivalent of setting the global io.configdockingalwaystabbar)
        bool DockingAllowUnclassed                        # Set to true to allow windows of this class to be docked/merged with an unclassed window. // fixme-dock: move to docknodeflags override?


    # Data payload for Drag and Drop operations: AcceptDragDropPayload(), GetDragDropPayload()
    ctypedef struct ImGuiPayload:
        void* Data                 # Data (copied and owned by dear imgui)
        int DataSize               # Data size
        ImGuiID SourceId           # Source item id
        ImGuiID SourceParentId     # Source parent id (if available)
        int DataFrameCount         # Data timestamp
        char* DataType             # Data type tag (short user-supplied string, 32 characters max)
        bool Preview               # Set when acceptdragdroppayload() was called and mouse has been hovering the target item (nb: handle overlapping drag targets)
        bool Delivery              # Set when acceptdragdroppayload() was called and mouse button is released over the target item.

    void ImGuiPayload_Clear(ImGuiPayload* self) except +
    bool ImGuiPayload_IsDataType(const ImGuiPayload* self, const char* type_) except +
    bool ImGuiPayload_IsDelivery(const ImGuiPayload* self) except +
    bool ImGuiPayload_IsPreview(const ImGuiPayload* self) except +

    # Sorting specification for one column of a table (sizeof == 12 bytes)
    ctypedef struct ImGuiTableColumnSortSpecs:
        ImGuiID ColumnUserID                 # User id of the column (if specified by a tablesetupcolumn() call)
        ImS16 ColumnIndex                    # Index of the column
        ImS16 SortOrder                      # Index within parent imguitablesortspecs (always stored in order starting from 0, tables sorted on a single criteria will always have a 0 here)
        ImGuiSortDirection SortDirection     # Imguisortdirection_ascending or imguisortdirection_descending (you can use this or sortsign, whichever is more convenient for your sort function)


    # Sorting specifications for a table (often handling sort specs for a single column, occasionally more)
    # Obtained by calling TableGetSortSpecs().
    # When 'SpecsDirty == true' you can sort your data. It will be true with sorting specs have changed since last call, or the first time.
    # Make sure to set 'SpecsDirty = false' after sorting, else you may wastefully sort your data every frame!
    ctypedef struct ImGuiTableSortSpecs:
        const ImGuiTableColumnSortSpecs* Specs     # Pointer to sort spec array.
        int SpecsCount                             # Sort spec count. most often 1. may be > 1 when imguitableflags_sortmulti is enabled. may be == 0 when imguitableflags_sorttristate is enabled.
        bool SpecsDirty                            # Set to true when specs have changed since last time! use this to sort again, then clear the flag.


    # [Internal]
    ctypedef struct ImGuiTextFilter_ImGuiTextRange:
        const char* b
        const char* e

    bool ImGuiTextFilter_ImGuiTextRange_empty(const ImGuiTextFilter_ImGuiTextRange* self) except +
    void ImGuiTextFilter_ImGuiTextRange_split(const ImGuiTextFilter_ImGuiTextRange* self, char separator, ImVector_ImGuiTextFilter_ImGuiTextRange* out) except +

    # Helper: Parse and apply text filters. In format "aaaaa[,bbbb][,ccccc]"
    ctypedef struct ImGuiTextFilter:
        char* InputBuf
        ImVector_ImGuiTextFilter_ImGuiTextRange Filters
        int CountGrep

    void ImGuiTextFilter_Build(ImGuiTextFilter* self) except +
    void ImGuiTextFilter_Clear(ImGuiTextFilter* self) except +

    # Helper calling inputtext+build
    bool ImGuiTextFilter_Draw(ImGuiTextFilter* self, const char* label, float width) except +
    bool ImGuiTextFilter_IsActive(const ImGuiTextFilter* self) except +
    bool ImGuiTextFilter_PassFilter(const ImGuiTextFilter* self, const char* text, const char* text_end) except +

    # Helper: Growable text buffer for logging/accumulating text
    # (this could be called 'ImGuiTextBuilder' / 'ImGuiStringBuilder')
    ctypedef struct ImGuiTextBuffer:
        ImVector_char Buf

    void ImGuiTextBuffer_append(ImGuiTextBuffer* self, const char* str_, const char* str_end) except +
    void ImGuiTextBuffer_appendf(ImGuiTextBuffer* self, const char* fmt) except +
    void ImGuiTextBuffer_appendfv(ImGuiTextBuffer* self, const char* fmt) except +
    const char* ImGuiTextBuffer_begin(const ImGuiTextBuffer* self) except +
    const char* ImGuiTextBuffer_c_str(const ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_clear(ImGuiTextBuffer* self) except +
    bool ImGuiTextBuffer_empty(const ImGuiTextBuffer* self) except +

    # Buf is zero-terminated, so end() will point on the zero-terminator
    const char* ImGuiTextBuffer_end(const ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_reserve(ImGuiTextBuffer* self, int capacity) except +
    int ImGuiTextBuffer_size(const ImGuiTextBuffer* self) except +

    # [Internal]
    ctypedef struct ImGuiStorage_ImGuiStoragePair:
        ImGuiID key


    # Helper: Key->Value storage
    # Typically you don't have to worry about this since a storage is held within each Window.
    # We use it to e.g. store collapse state for a tree (Int 0/1)
    # This is optimized for efficient lookup (dichotomy into a contiguous buffer) and rare insertion (typically tied to user interactions aka max once a frame)
    # You can use it as custom user storage for temporary values. Declare your own storage if, for example:
    # - You want to manipulate the open/close state of a particular sub-tree in your interface (tree node uses Int 0/1 to store their state).
    # - You want to store custom debug data easily without adding or editing structures in your code (probably not efficient, but convenient)
    # Types are NOT stored, so it is up to you to make sure your Key don't collide with different types.
    ctypedef struct ImGuiStorage:
        ImVector_ImGuiStorage_ImGuiStoragePair Data


    # For quicker full rebuild of a storage (instead of an incremental one), you may add all your contents and then sort once.
    void ImGuiStorage_BuildSortByKey(ImGuiStorage* self) except +

    # - Get***() functions find pair, never add/allocate. Pairs are sorted so a query is O(log N)
    # - Set***() functions find pair, insertion on demand if missing.
    # - Sorted insertion is costly, paid once. A typical frame shouldn't need to insert any new pair.
    void ImGuiStorage_Clear(ImGuiStorage* self) except +
    bool ImGuiStorage_GetBool(const ImGuiStorage* self, ImGuiID key, bool default_val) except +
    bool* ImGuiStorage_GetBoolRef(ImGuiStorage* self, ImGuiID key, bool default_val) except +
    float ImGuiStorage_GetFloat(const ImGuiStorage* self, ImGuiID key, float default_val) except +
    float* ImGuiStorage_GetFloatRef(ImGuiStorage* self, ImGuiID key, float default_val) except +
    int ImGuiStorage_GetInt(const ImGuiStorage* self, ImGuiID key, int default_val) except +

    # - Get***Ref() functions finds pair, insert on demand if missing, return pointer. Useful if you intend to do Get+Set.
    # - References are only valid until a new value is added to the storage. Calling a Set***() function or a Get***Ref() function invalidates the pointer.
    # - A typical use case where this is convenient for quick hacking (e.g. add storage during a live Edit&Continue session if you can't modify existing struct)
    # float* pvar = ImGui::GetFloatRef(key); ImGui::SliderFloat("var", pvar, 0, 100.0f); some_var += *pvar;
    int* ImGuiStorage_GetIntRef(ImGuiStorage* self, ImGuiID key, int default_val) except +

    # Default_val is null
    void* ImGuiStorage_GetVoidPtr(const ImGuiStorage* self, ImGuiID key) except +
    void** ImGuiStorage_GetVoidPtrRef(ImGuiStorage* self, ImGuiID key, void* default_val) except +

    # Use on your own storage if you know only integer are being stored (open/close all tree nodes)
    void ImGuiStorage_SetAllInt(ImGuiStorage* self, int val) except +
    void ImGuiStorage_SetBool(ImGuiStorage* self, ImGuiID key, bool val) except +
    void ImGuiStorage_SetFloat(ImGuiStorage* self, ImGuiID key, float val) except +
    void ImGuiStorage_SetInt(ImGuiStorage* self, ImGuiID key, int val) except +
    void ImGuiStorage_SetVoidPtr(ImGuiStorage* self, ImGuiID key, void* val) except +

    # Helper: Manually clip large list of items.
    # If you have lots evenly spaced items and you have random access to the list, you can perform coarse
    # clipping based on visibility to only submit items that are in view.
    # The clipper calculates the range of visible items and advance the cursor to compensate for the non-visible items we have skipped.
    # (Dear ImGui already clip items based on their bounds but: it needs to first layout the item to do so, and generally
    # fetching/submitting your own data incurs additional cost. Coarse clipping using ImGuiListClipper allows you to easily
    # scale using lists with tens of thousands of items without a problem)
    # Usage:
    # ImGuiListClipper clipper;
    # clipper.Begin(1000);         // We have 1000 elements, evenly spaced.
    # while (clipper.Step())
    # for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
    # ImGui::Text("line number %d", i);
    # Generally what happens is:
    # - Clipper lets you process the first element (DisplayStart = 0, DisplayEnd = 1) regardless of it being visible or not.
    # - User code submit that one element.
    # - Clipper can measure the height of the first element
    # - Clipper calculate the actual range of elements to display based on the current clipping rectangle, position the cursor before the first visible element.
    # - User code submit visible elements.
    # - The clipper also handles various subtleties related to keyboard/gamepad navigation, wrapping etc.
    ctypedef struct ImGuiListClipper:
        ImGuiContext* Ctx     # Parent ui context
        int DisplayStart      # First item to display, updated by each call to step()
        int DisplayEnd        # End of items to display (exclusive)
        int ItemsCount        # [internal] number of items
        float ItemsHeight     # [internal] height of item after a first step and item submission can calculate it
        float StartPosY       # [internal] cursor position at the time of begin() or after table frozen rows are all processed
        void* TempData        # [internal] internal data

    void ImGuiListClipper_Begin(ImGuiListClipper* self, int items_count, float items_height) except +

    # Automatically called on the last call of step() that returns false.
    void ImGuiListClipper_End(ImGuiListClipper* self) except +

    # Call ForceDisplayRangeByIndices() before first call to Step() if you need a range of items to be displayed regardless of visibility.
    # Item_max is exclusive e.g. use (42, 42+1) to make item 42 always visible but due to alignment/padding of certain items it is likely that an extra item may be included on either end of the display range.
    void ImGuiListClipper_ForceDisplayRangeByIndices(ImGuiListClipper* self, int item_min, int item_max) except +

    # Call until it returns false. the displaystart/displayend fields will be set and you can process/draw those items.
    bool ImGuiListClipper_Step(ImGuiListClipper* self) except +

    # Helper: ImColor() implicitly converts colors to either ImU32 (packed 4x1 byte) or ImVec4 (4x1 float)
    # Prefer using IM_COL32() macros if you want a guaranteed compile-time ImU32 for usage with ImDrawList API.
    # **Avoid storing ImColor! Store either u32 of ImVec4. This is not a full-featured color class. MAY OBSOLETE.
    # **None of the ImGui API are using ImColor directly but you can use it as a convenience to pass colors in either ImU32 or ImVec4 formats. Explicitly cast to ImU32 or ImVec4 if needed.
    ctypedef struct ImColor:
        ImVec4 Value

    ImColor ImColor_HSV(ImColor* self, float h, float s, float v, float a) except +

    # FIXME-OBSOLETE: May need to obsolete/cleanup those helpers.
    void ImColor_SetHSV(ImColor* self, float h, float s, float v, float a) except +

    # Typically, 1 command = 1 GPU draw call (unless command is a callback)
    # - VtxOffset: When 'io.BackendFlags & ImGuiBackendFlags_RendererHasVtxOffset' is enabled,
    # this fields allow us to render meshes larger than 64K vertices while keeping 16-bit indices.
    # Backends made for <1.71. will typically ignore the VtxOffset fields.
    # - The ClipRect/TextureId/VtxOffset fields must be contiguous as we memcmp() them together (this is asserted for).
    ctypedef struct ImDrawCmd:
        ImVec4 ClipRect                 # 4*4  // clipping rectangle (x1, y1, x2, y2). subtract imdrawdata->displaypos to get clipping rectangle in 'viewport' coordinates
        ImTextureID TextureId           # 4-8  // user-provided texture id. set by user in imfontatlas::settexid() for fonts or passed to image*() functions. ignore if never using images or multiple fonts atlas.
        unsigned int VtxOffset          # 4    // start offset in vertex buffer. imguibackendflags_rendererhasvtxoffset: always 0, otherwise may be >0 to support meshes larger than 64k vertices with 16-bit indices.
        unsigned int IdxOffset          # 4    // start offset in index buffer.
        unsigned int ElemCount          # 4    // number of indices (multiple of 3) to be rendered as triangles. vertices are stored in the callee imdrawlist's vtx_buffer[] array, indices in idx_buffer[].
        ImDrawCallback UserCallback     # 4-8  // if != null, call the function instead of rendering the vertices. clip_rect and texture_id will be set normally.
        void* UserCallbackData          # 4-8  // the draw callback code can access this.


    # Since 1.83: returns ImTextureID associated with this draw call. Warning: DO NOT assume this is always same as 'TextureId' (we will change this function for an upcoming feature)
    ImTextureID ImDrawCmd_GetTexID(const ImDrawCmd* self) except +

    ctypedef struct ImDrawVert:
        ImVec2 pos
        ImVec2 uv
        ImU32 col


    # [Internal] For use by ImDrawList
    ctypedef struct ImDrawCmdHeader:
        ImVec4 ClipRect
        ImTextureID TextureId
        unsigned int VtxOffset


    # [Internal] For use by ImDrawListSplitter
    ctypedef struct ImDrawChannel:
        ImVector_ImDrawCmd _CmdBuffer
        ImVector_ImDrawIdx _IdxBuffer


    # Split/Merge functions are used to split the draw list into different layers which can be drawn into out of order.
    # This is used by the Columns/Tables API, so items of each column can be batched together in a same draw call.
    ctypedef struct ImDrawListSplitter:
        int _Current                         # Current channel number (0)
        int _Count                           # Number of active channels (1+)
        ImVector_ImDrawChannel _Channels     # Draw channels (not resized down so _count might be < channels.size)


    # Do not clear channels[] so our allocations are reused next frame
    void ImDrawListSplitter_Clear(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_Merge(ImDrawListSplitter* self, ImDrawList* draw_list) except +
    void ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter* self, ImDrawList* draw_list, int channel_idx) except +
    void ImDrawListSplitter_Split(ImDrawListSplitter* self, ImDrawList* draw_list, int count) except +

    # Draw command list
    # This is the low-level list of polygons that ImGui:: functions are filling. At the end of the frame,
    # all command lists are passed to your ImGuiIO::RenderDrawListFn function for rendering.
    # Each dear imgui window contains its own ImDrawList. You can use ImGui::GetWindowDrawList() to
    # access the current window draw list and draw custom primitives.
    # You can interleave normal ImGui:: calls and adding primitives to the current draw list.
    # In single viewport mode, top-left is == GetMainViewport()->Pos (generally 0,0), bottom-right is == GetMainViewport()->Pos+Size (generally io.DisplaySize).
    # You are totally free to apply whatever transformation matrix to want to the data (depending on the use of the transformation you may want to apply it to ClipRect as well!)
    # Important: Primitives are always added to the list and not culled (culling is done at higher-level by ImGui:: functions), if you use this API a lot consider coarse culling your drawn objects.
    ctypedef struct ImDrawList:
        ImVector_ImDrawCmd CmdBuffer             # Draw commands. typically 1 command = 1 gpu draw call, unless the command is a callback.
        ImVector_ImDrawIdx IdxBuffer             # Index buffer. each command consume imdrawcmd::elemcount of those
        ImVector_ImDrawVert VtxBuffer            # Vertex buffer.
        ImDrawListFlags Flags                    # Flags, you may poke into these to adjust anti-aliasing settings per-primitive.
        unsigned int _VtxCurrentIdx              # [internal] generally == vtxbuffer.size unless we are past 64k vertices, in which case this gets reset to 0.
        ImDrawListSharedData* _Data              # Pointer to shared draw data (you can use imgui::getdrawlistshareddata() to get the one from current imgui context)
        const char* _OwnerName                   # Pointer to owner window's name for debugging
        ImDrawVert* _VtxWritePtr                 # [internal] point within vtxbuffer.data after each add command (to avoid using the imvector<> operators too much)
        ImDrawIdx* _IdxWritePtr                  # [internal] point within idxbuffer.data after each add command (to avoid using the imvector<> operators too much)
        ImVector_ImVec4 _ClipRectStack           # [internal]
        ImVector_ImTextureID _TextureIdStack     # [internal]
        ImVector_ImVec2 _Path                    # [internal] current path building
        ImDrawCmdHeader _CmdHeader               # [internal] template of active commands. fields should match those of cmdbuffer.back().
        ImDrawListSplitter _Splitter             # [internal] for channels api (note: prefer using your own persistent instance of imdrawlistsplitter!)
        float _FringeScale                       # [internal] anti-alias fringe is scaled by this value, this helps to keep things sharp while zooming at vertex buffer content


    # Cubic bezier (4 control points)
    void ImDrawList_AddBezierCubic(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col, float thickness, int num_segments) except +

    # Quadratic bezier (3 control points)
    void ImDrawList_AddBezierQuadratic(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col, float thickness, int num_segments) except +

    # Advanced
    # Your rendering function must check for 'usercallback' in imdrawcmd and call the function instead of rendering triangles.
    void ImDrawList_AddCallback(ImDrawList* self, ImDrawCallback callback, void* callback_data) except +

    # Implied num_segments = 0, thickness = 1.0f
    void ImDrawList_AddCircle(ImDrawList* self, ImVec2 center, float radius, ImU32 col) except +
    void ImDrawList_AddCircleEx(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments, float thickness) except +
    void ImDrawList_AddCircleFilled(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddConvexPolyFilled(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col) except +

    # This is useful if you need to forcefully create a new draw call (to allow for dependent rendering / blending). otherwise primitives are merged into the same draw-call as much as possible
    void ImDrawList_AddDrawCmd(ImDrawList* self) except +

    # Image primitives
    # - Read FAQ to understand what ImTextureID is.
    # - "p_min" and "p_max" represent the upper-left and lower-right corners of the rectangle.
    # - "uv_min" and "uv_max" represent the normalized texture coordinates to use for those corners. Using (0,0)->(1,1) texture coordinates will generally display the entire texture.
    # Implied uv_min = imvec2(0, 0), uv_max = imvec2(1, 1), col = im_col32_white
    void ImDrawList_AddImage(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p_min, ImVec2 p_max) except +
    void ImDrawList_AddImageEx(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p_min, ImVec2 p_max, ImVec2 uv_min, ImVec2 uv_max, ImU32 col) except +

    # Implied uv1 = imvec2(0, 0), uv2 = imvec2(1, 0), uv3 = imvec2(1, 1), uv4 = imvec2(0, 1), col = im_col32_white
    void ImDrawList_AddImageQuad(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4) except +
    void ImDrawList_AddImageQuadEx(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImVec2 uv1, ImVec2 uv2, ImVec2 uv3, ImVec2 uv4, ImU32 col) except +
    void ImDrawList_AddImageRounded(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p_min, ImVec2 p_max, ImVec2 uv_min, ImVec2 uv_max, ImU32 col, float rounding, ImDrawFlags flags) except +

    # Primitives
    # - Filled shapes must always use clockwise winding order. The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
    # - For rectangular primitives, "p_min" and "p_max" represent the upper-left and lower-right corners.
    # - For circle primitives, use "num_segments == 0" to automatically calculate tessellation (preferred).
    # In older versions (until Dear ImGui 1.77) the AddCircle functions defaulted to num_segments == 12.
    # In future versions we will use textures to provide cheaper and higher-quality circles.
    # Use AddNgon() and AddNgonFilled() functions if you need to guarantee a specific number of sides.
    # Implied thickness = 1.0f
    void ImDrawList_AddLine(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImU32 col) except +
    void ImDrawList_AddLineEx(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImU32 col, float thickness) except +

    # Implied thickness = 1.0f
    void ImDrawList_AddNgon(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddNgonEx(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments, float thickness) except +
    void ImDrawList_AddNgonFilled(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddPolyline(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col, ImDrawFlags flags, float thickness) except +

    # Implied thickness = 1.0f
    void ImDrawList_AddQuad(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col) except +
    void ImDrawList_AddQuadEx(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col, float thickness) except +
    void ImDrawList_AddQuadFilled(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col) except +

    # Implied rounding = 0.0f, flags = 0, thickness = 1.0f
    void ImDrawList_AddRect(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col) except +

    # A: upper-left, b: lower-right (== upper-left + size)
    void ImDrawList_AddRectEx(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags, float thickness) except +

    # Implied rounding = 0.0f, flags = 0
    void ImDrawList_AddRectFilled(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col) except +

    # A: upper-left, b: lower-right (== upper-left + size)
    void ImDrawList_AddRectFilledEx(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags) except +
    void ImDrawList_AddRectFilledMultiColor(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col_upr_left, ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left) except +

    # Implied text_end = null
    void ImDrawList_AddText(ImDrawList* self, ImVec2 pos, ImU32 col, const char* text_begin) except +
    void ImDrawList_AddTextEx(ImDrawList* self, ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end) except +

    # Implied text_end = null, wrap_width = 0.0f, cpu_fine_clip_rect = null
    void ImDrawList_AddTextImFontPtr(ImDrawList* self, const ImFont* font, float font_size, ImVec2 pos, ImU32 col, const char* text_begin) except +
    void ImDrawList_AddTextImFontPtrEx(ImDrawList* self, const ImFont* font, float font_size, ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end, float wrap_width, const ImVec4* cpu_fine_clip_rect) except +

    # Implied thickness = 1.0f
    void ImDrawList_AddTriangle(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col) except +
    void ImDrawList_AddTriangleEx(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col, float thickness) except +
    void ImDrawList_AddTriangleFilled(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col) except +
    void ImDrawList_ChannelsMerge(ImDrawList* self) except +
    void ImDrawList_ChannelsSetCurrent(ImDrawList* self, int n) except +

    # Advanced: Channels
    # - Use to split render into layers. By switching channels to can render out-of-order (e.g. submit FG primitives before BG primitives)
    # - Use to minimize draw calls (e.g. if going back-and-forth between multiple clipping rectangles, prefer to append into separate channels then merge at the end)
    # - FIXME-OBSOLETE: This API shouldn't have been in ImDrawList in the first place!
    # Prefer using your own persistent instance of ImDrawListSplitter as you can stack them.
    # Using the ImDrawList::ChannelsXXXX you cannot stack a split over another.
    void ImDrawList_ChannelsSplit(ImDrawList* self, int count) except +

    # Create a clone of the cmdbuffer/idxbuffer/vtxbuffer.
    ImDrawList* ImDrawList_CloneOutput(const ImDrawList* self) except +
    ImVec2 ImDrawList_GetClipRectMax(const ImDrawList* self) except +
    ImVec2 ImDrawList_GetClipRectMin(const ImDrawList* self) except +
    void ImDrawList_PathArcTo(ImDrawList* self, ImVec2 center, float radius, float a_min, float a_max, int num_segments) except +

    # Use precomputed angles for a 12 steps circle
    void ImDrawList_PathArcToFast(ImDrawList* self, ImVec2 center, float radius, int a_min_of_12, int a_max_of_12) except +

    # Cubic bezier (4 control points)
    void ImDrawList_PathBezierCubicCurveTo(ImDrawList* self, ImVec2 p2, ImVec2 p3, ImVec2 p4, int num_segments) except +

    # Quadratic bezier (3 control points)
    void ImDrawList_PathBezierQuadraticCurveTo(ImDrawList* self, ImVec2 p2, ImVec2 p3, int num_segments) except +

    # Stateful path API, add points then finish with PathFillConvex() or PathStroke()
    # - Filled shapes must always use clockwise winding order. The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
    void ImDrawList_PathClear(ImDrawList* self) except +
    void ImDrawList_PathFillConvex(ImDrawList* self, ImU32 col) except +
    void ImDrawList_PathLineTo(ImDrawList* self, ImVec2 pos) except +
    void ImDrawList_PathLineToMergeDuplicate(ImDrawList* self, ImVec2 pos) except +
    void ImDrawList_PathRect(ImDrawList* self, ImVec2 rect_min, ImVec2 rect_max, float rounding, ImDrawFlags flags) except +
    void ImDrawList_PathStroke(ImDrawList* self, ImU32 col, ImDrawFlags flags, float thickness) except +
    void ImDrawList_PopClipRect(ImDrawList* self) except +
    void ImDrawList_PopTextureID(ImDrawList* self) except +
    void ImDrawList_PrimQuadUV(ImDrawList* self, ImVec2 a, ImVec2 b, ImVec2 c, ImVec2 d, ImVec2 uv_a, ImVec2 uv_b, ImVec2 uv_c, ImVec2 uv_d, ImU32 col) except +

    # Axis aligned rectangle (composed of two triangles)
    void ImDrawList_PrimRect(ImDrawList* self, ImVec2 a, ImVec2 b, ImU32 col) except +
    void ImDrawList_PrimRectUV(ImDrawList* self, ImVec2 a, ImVec2 b, ImVec2 uv_a, ImVec2 uv_b, ImU32 col) except +

    # Advanced: Primitives allocations
    # - We render triangles (three vertices)
    # - All primitives needs to be reserved via PrimReserve() beforehand.
    void ImDrawList_PrimReserve(ImDrawList* self, int idx_count, int vtx_count) except +
    void ImDrawList_PrimUnreserve(ImDrawList* self, int idx_count, int vtx_count) except +

    # Write vertex with unique index
    void ImDrawList_PrimVtx(ImDrawList* self, ImVec2 pos, ImVec2 uv, ImU32 col) except +
    void ImDrawList_PrimWriteIdx(ImDrawList* self, ImDrawIdx idx) except +
    void ImDrawList_PrimWriteVtx(ImDrawList* self, ImVec2 pos, ImVec2 uv, ImU32 col) except +

    # Render-level scissoring. this is passed down to your render function but not used for cpu-side coarse clipping. prefer using higher-level imgui::pushcliprect() to affect logic (hit-testing and widget culling)
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

    # [Internal helpers]
    void ImDrawList__ResetForNewFrame(ImDrawList* self) except +
    void ImDrawList__TryMergeDrawCmds(ImDrawList* self) except +

    # All draw data to render a Dear ImGui frame
    # (NB: the style and the naming convention here is a little inconsistent, we currently preserve them for backward compatibility purpose,
    # as this is one of the oldest structure exposed by the library! Basically, ImDrawList == CmdList)
    ctypedef struct ImDrawData:
        bool Valid                       # Only valid after render() is called and before the next newframe() is called.
        int CmdListsCount                # Number of imdrawlist* to render
        int TotalIdxCount                # For convenience, sum of all imdrawlist's idxbuffer.size
        int TotalVtxCount                # For convenience, sum of all imdrawlist's vtxbuffer.size
        ImDrawList** CmdLists            # Array of imdrawlist* to render. the imdrawlist are owned by imguicontext and only pointed to from here.
        ImVec2 DisplayPos                # Top-left position of the viewport to render (== top-left of the orthogonal projection matrix to use) (== getmainviewport()->pos for the main viewport, == (0.0) in most single-viewport applications)
        ImVec2 DisplaySize               # Size of the viewport to render (== getmainviewport()->size for the main viewport, == io.displaysize in most single-viewport applications)
        ImVec2 FramebufferScale          # Amount of pixels for each unit of displaysize. based on io.displayframebufferscale. generally (1,1) on normal display, (2,2) on osx with retina display.
        ImGuiViewport* OwnerViewport     # Viewport carrying the imdrawdata instance, might be of use to the renderer (generally not).


    # The imdrawlist are owned by imguicontext!
    void ImDrawData_Clear(ImDrawData* self) except +

    # Helper to convert all buffers from indexed to non-indexed, in case you cannot render indexed. note: this is slow and most likely a waste of resources. always prefer indexed rendering!
    void ImDrawData_DeIndexAllBuffers(ImDrawData* self) except +

    # Helper to scale the cliprect field of each imdrawcmd. use if your final output buffer is at a different scale than dear imgui expects, or if there is a difference between your window resolution and framebuffer resolution.
    void ImDrawData_ScaleClipRects(ImDrawData* self, ImVec2 fb_scale) except +

    ctypedef struct ImFontConfig:
        void* FontData                    # Ttf/otf data
        int FontDataSize                  # Ttf/otf data size
        bool FontDataOwnedByAtlas         # True     // ttf/otf data ownership taken by the container imfontatlas (will delete memory itself).
        int FontNo                        # 0        // index of font within ttf/otf file
        float SizePixels                  # Size in pixels for rasterizer (more or less maps to the resulting font height).
        int OversampleH                   # 3        // rasterize at higher quality for sub-pixel positioning. note the difference between 2 and 3 is minimal so you can reduce this to 2 to save memory. read https://github.com/nothings/stb/blob/master/tests/oversample/readme.md for details.
        int OversampleV                   # 1        // rasterize at higher quality for sub-pixel positioning. this is not really useful as we don't use sub-pixel positions on the y axis.
        bool PixelSnapH                   # False    // align every glyph to pixel boundary. useful e.g. if you are merging a non-pixel aligned font with the default font. if enabled, you can set oversampleh/v to 1.
        ImVec2 GlyphExtraSpacing          # 0, 0     // extra spacing (in pixels) between glyphs. only x axis is supported for now.
        ImVec2 GlyphOffset                # 0, 0     // offset all glyphs from this font input.
        const ImWchar* GlyphRanges        # Null     // the array data needs to persist as long as the font is alive. pointer to a user-provided list of unicode range (2 value per range, values are inclusive, zero-terminated list).
        float GlyphMinAdvanceX            # 0        // minimum advancex for glyphs, set min to align font icons, set both min/max to enforce mono-space font
        float GlyphMaxAdvanceX            # Flt_max  // maximum advancex for glyphs
        bool MergeMode                    # False    // merge into previous imfont, so you can combine multiple inputs font into one imfont (e.g. ascii font + icons + japanese glyphs). you may want to use glyphoffset.y when merge font of different heights.
        unsigned int FontBuilderFlags     # 0        // settings for custom font builder. this is builder implementation dependent. leave as zero if unsure.
        float RasterizerMultiply          # 1.0f     // brighten (>1.0f) or darken (<1.0f) font output. brightening small fonts may be a good workaround to make them more readable.
        ImWchar EllipsisChar              # -1       // explicitly specify unicode codepoint of ellipsis character. when fonts are being merged first specified ellipsis will be used.
        char* Name                        # Name (strictly to ease debugging)
        ImFont* DstFont


    # Hold rendering data for one glyph.
    # (Note: some language parsers may fail to convert the 31+1 bitfield members, in this case maybe drop store a single u32 or we can rework this)
    ctypedef struct ImFontGlyph:
        unsigned int Colored       # Flag to indicate glyph is colored and should generally ignore tinting (make it usable with no shift on little-endian as this is used in loops)
        unsigned int Visible       # Flag to indicate glyph has no visible pixels (e.g. space). allow early out when rendering.
        unsigned int Codepoint     # 0x0000..0x10ffff
        float AdvanceX             # Distance to next character (= data from font + imfontconfig::glyphextraspacing.x baked in)
        float X0                   # Glyph corners
        float Y0                   # Glyph corners
        float X1                   # Glyph corners
        float Y1                   # Glyph corners
        float U0                   # Texture coordinates
        float V0                   # Texture coordinates
        float U1                   # Texture coordinates
        float V1                   # Texture coordinates


    # Helper to build glyph ranges from text/string data. Feed your application strings/characters to it then call BuildRanges().
    # This is essentially a tightly packed of vector of 64k booleans = 8KB storage.
    ctypedef struct ImFontGlyphRangesBuilder:
        ImVector_ImU32 UsedChars     # Store 1-bit per unicode code point (0=unused, 1=used)


    # Add character
    void ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder* self, ImWchar c) except +

    # Add ranges, e.g. builder.addranges(imfontatlas::getglyphrangesdefault()) to force add all of ascii/latin+ext
    void ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder* self, const ImWchar* ranges) except +

    # Add string (each character of the utf-8 string are added)
    void ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder* self, const char* text, const char* text_end) except +

    # Output new ranges (imvector_construct()/imvector_destruct() can be used to safely construct out_ranges)
    void ImFontGlyphRangesBuilder_BuildRanges(ImFontGlyphRangesBuilder* self, ImVector_ImWchar* out_ranges) except +
    void ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder* self) except +

    # Get bit n in the array
    bool ImFontGlyphRangesBuilder_GetBit(const ImFontGlyphRangesBuilder* self, size_t n) except +

    # Set bit n in the array
    void ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder* self, size_t n) except +

    # See ImFontAtlas::AddCustomRectXXX functions.
    ctypedef struct ImFontAtlasCustomRect:
        unsigned short Width      # Input    // desired rectangle dimension
        unsigned short Height     # Input    // desired rectangle dimension
        unsigned short X          # Output   // packed position in atlas
        unsigned short Y          # Output   // packed position in atlas
        unsigned int GlyphID      # Input    // for custom font glyphs only (id < 0x110000)
        float GlyphAdvanceX       # Input    // for custom font glyphs only: glyph xadvance
        ImVec2 GlyphOffset        # Input    // for custom font glyphs only: glyph display offset
        ImFont* Font              # Input    // for custom font glyphs only: target font

    bool ImFontAtlasCustomRect_IsPacked(const ImFontAtlasCustomRect* self) except +

    # Load and rasterize multiple TTF/OTF fonts into a same texture. The font atlas will build a single texture holding:
    # - One or more fonts.
    # - Custom graphics data needed to render the shapes needed by Dear ImGui.
    # - Mouse cursor shapes for software cursor rendering (unless setting 'Flags |= ImFontAtlasFlags_NoMouseCursors' in the font atlas).
    # It is the user-code responsibility to setup/build the atlas, then upload the pixel data into a texture accessible by your graphics api.
    # - Optionally, call any of the AddFont*** functions. If you don't call any, the default font embedded in the code will be loaded for you.
    # - Call GetTexDataAsAlpha8() or GetTexDataAsRGBA32() to build and retrieve pixels data.
    # - Upload the pixels data into a texture within your graphics system (see imgui_impl_xxxx.cpp examples)
    # - Call SetTexID(my_tex_id); and pass the pointer/identifier to your texture in a format natural to your graphics API.
    # This value will be passed back to you during rendering to identify the texture. Read FAQ entry about ImTextureID for more details.
    # Common pitfalls:
    # - If you pass a 'glyph_ranges' array to AddFont*** functions, you need to make sure that your array persist up until the
    # atlas is build (when calling GetTexData*** or Build()). We only copy the pointer, not the data.
    # - Important: By default, AddFontFromMemoryTTF() takes ownership of the data. Even though we are not writing to it, we will free the pointer on destruction.
    # You can set font_cfg->FontDataOwnedByAtlas=false to keep ownership of your data and it won't be freed,
    # - Even though many functions are suffixed with "TTF", OTF data is supported just as well.
    # - This is an old API and it is currently awkward for those and various other reasons! We will address them in the future!
    ctypedef struct ImFontAtlas:
        ImFontAtlasFlags Flags                         # Build flags (see imfontatlasflags_)
        ImTextureID TexID                              # User data to refer to the texture once it has been uploaded to user's graphic systems. it is passed back to you during rendering via the imdrawcmd structure.
        int TexDesiredWidth                            # Texture width desired by user before build(). must be a power-of-two. if have many glyphs your graphics api have texture size restrictions you may want to increase texture width to decrease height.
        int TexGlyphPadding                            # Padding between glyphs within texture in pixels. defaults to 1. if your rendering method doesn't rely on bilinear filtering you may set this to 0 (will also need to set antialiasedlinesusetex = false).
        bool Locked                                    # Marked as locked by imgui::newframe() so attempt to modify the atlas will assert.
        void* UserData                                 # Store your own atlas related user-data (if e.g. you have multiple font atlas).
        bool TexReady                                  # Set when texture was built matching current font input
        bool TexPixelsUseColors                        # Tell whether our texture data is known to use colors (rather than just alpha channel), in order to help backend select a format.
        unsigned char* TexPixelsAlpha8                 # 1 component per pixel, each component is unsigned 8-bit. total size = texwidth * texheight
        unsigned int* TexPixelsRGBA32                  # 4 component per pixel, each component is unsigned 8-bit. total size = texwidth * texheight * 4
        int TexWidth                                   # Texture width calculated during build().
        int TexHeight                                  # Texture height calculated during build().
        ImVec2 TexUvScale                              # = (1.0f/texwidth, 1.0f/texheight)
        ImVec2 TexUvWhitePixel                         # Texture coordinates to a white pixel
        ImVector_ImFontPtr Fonts                       # Hold all the fonts returned by addfont*. fonts[0] is the default font upon calling imgui::newframe(), use imgui::pushfont()/popfont() to change the current font.
        ImVector_ImFontAtlasCustomRect CustomRects     # Rectangles for packing custom texture data into the atlas.
        ImVector_ImFontConfig ConfigData               # Configuration data
        ImVec4* TexUvLines                             # Uvs for baked anti-aliased lines
        const ImFontBuilderIO* FontBuilderIO           # Opaque interface to a font builder (default to stb_truetype, can be changed to use freetype by defining imgui_enable_freetype).
        unsigned int FontBuilderFlags                  # Shared flags (for all fonts) for custom font builder. this is build implementation dependent. per-font override is also available in imfontconfig.
        int PackIdMouseCursors                         # Custom texture rectangle id for white pixel and mouse cursors
        int PackIdLines                                # Custom texture rectangle id for baked anti-aliased lines

    int ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas* self, ImFont* font, ImWchar id_, int width, int height, float advance_x, ImVec2 offset) except +

    # You can request arbitrary rectangles to be packed into the atlas, for your own purposes.
    # - After calling Build(), you can query the rectangle position and render your pixels.
    # - If you render colored output, set 'atlas->TexPixelsUseColors = true' as this may help some backends decide of prefered texture format.
    # - You can also request your rectangles to be mapped as font glyph (given a font + Unicode point),
    # so you can render e.g. custom colorful icons and use them as regular glyphs.
    # - Read docs/FONTS.md for more details about using colorful icons.
    # - Note: this API may be redesigned later in order to support multi-monitor varying DPI settings.
    int ImFontAtlas_AddCustomRectRegular(ImFontAtlas* self, int width, int height) except +
    ImFont* ImFontAtlas_AddFont(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontDefault(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontFromFileTTF(ImFontAtlas* self, const char* filename, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +

    # 'compressed_font_data_base85' still owned by caller. compress with binary_to_compressed_c.cpp with -base85 parameter.
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas* self, const char* compressed_font_data_base85, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +

    # 'compressed_font_data' still owned by caller. compress with binary_to_compressed_c.cpp.
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas* self, const void* compressed_font_data, int compressed_font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +

    # Note: transfer ownership of 'ttf_data' to imfontatlas! will be deleted after destruction of the atlas. set font_cfg->fontdataownedbyatlas=false to keep ownership of your data and it won't be freed.
    ImFont* ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas* self, void* font_data, int font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +

    # Build atlas, retrieve pixel data.
    # User is in charge of copying the pixels into graphics memory (e.g. create a texture with your engine). Then store your texture handle with SetTexID().
    # The pitch is always = Width * BytesPerPixels (1 or 4)
    # Building in RGBA32 format is provided for convenience and compatibility, but note that unless you manually manipulate or copy color data into
    # the texture (e.g. when using the AddCustomRect*** api), then the RGB pixels emitted will always be white (~75% of memory/bandwidth waste.
    # Build pixels data. this is called automatically for you by the gettexdata*** functions.
    bool ImFontAtlas_Build(ImFontAtlas* self) except +

    # [Internal]
    void ImFontAtlas_CalcCustomRectUV(const ImFontAtlas* self, const ImFontAtlasCustomRect* rect, ImVec2* out_uv_min, ImVec2* out_uv_max) except +

    # Clear all input and output.
    void ImFontAtlas_Clear(ImFontAtlas* self) except +

    # Clear output font data (glyphs storage, uv coordinates).
    void ImFontAtlas_ClearFonts(ImFontAtlas* self) except +

    # Clear input data (all imfontconfig structures including sizes, ttf data, glyph ranges, etc.) = all the data used to build the texture and fonts.
    void ImFontAtlas_ClearInputData(ImFontAtlas* self) except +

    # Clear output texture data (cpu side). saves ram once the texture has been copied to graphics memory.
    void ImFontAtlas_ClearTexData(ImFontAtlas* self) except +
    ImFontAtlasCustomRect* ImFontAtlas_GetCustomRectByIndex(ImFontAtlas* self, int index) except +

    # Default + half-width + japanese hiragana/katakana + full set of about 21000 cjk unified ideographs
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseFull(ImFontAtlas* self) except +

    # Default + half-width + japanese hiragana/katakana + set of 2500 cjk unified ideographs for common simplified chinese
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(ImFontAtlas* self) except +

    # Default + about 400 cyrillic characters
    const ImWchar* ImFontAtlas_GetGlyphRangesCyrillic(ImFontAtlas* self) except +

    # Helpers to retrieve list of common Unicode ranges (2 value per range, values are inclusive, zero-terminated list)
    # NB: Make sure that your string are UTF-8 and NOT in your local code page. In C++11, you can create UTF-8 string literal using the u8"Hello world" syntax. See FAQ for details.
    # NB: Consider using ImFontGlyphRangesBuilder to build glyph ranges from textual data.
    # Basic latin, extended latin
    const ImWchar* ImFontAtlas_GetGlyphRangesDefault(ImFontAtlas* self) except +

    # Default + greek and coptic
    const ImWchar* ImFontAtlas_GetGlyphRangesGreek(ImFontAtlas* self) except +

    # Default + hiragana, katakana, half-width, selection of 2999 ideographs
    const ImWchar* ImFontAtlas_GetGlyphRangesJapanese(ImFontAtlas* self) except +

    # Default + korean characters
    const ImWchar* ImFontAtlas_GetGlyphRangesKorean(ImFontAtlas* self) except +

    # Default + thai characters
    const ImWchar* ImFontAtlas_GetGlyphRangesThai(ImFontAtlas* self) except +

    # Default + vietnamese characters
    const ImWchar* ImFontAtlas_GetGlyphRangesVietnamese(ImFontAtlas* self) except +
    bool ImFontAtlas_GetMouseCursorTexData(ImFontAtlas* self, ImGuiMouseCursor cursor, ImVec2* out_offset, ImVec2* out_size, ImVec2* out_uv_border, ImVec2* out_uv_fill) except +

    # 1 byte per-pixel
    void ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +

    # 4 bytes-per-pixel
    void ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +

    # Bit ambiguous: used to detect when user didn't build texture but effectively we should check texid != 0 except that would be backend dependent...
    bool ImFontAtlas_IsBuilt(const ImFontAtlas* self) except +
    void ImFontAtlas_SetTexID(ImFontAtlas* self, ImTextureID id_) except +

    # Font runtime data and rendering
    # ImFontAtlas automatically loads a default embedded font for you when you call GetTexDataAsAlpha8() or GetTexDataAsRGBA32().
    ctypedef struct ImFont:
        ImVector_float IndexAdvanceX         # 12-16 // out //            // sparse. glyphs->advancex in a directly indexable way (cache-friendly for calctextsize functions which only this this info, and are often bottleneck in large ui).
        float FallbackAdvanceX               # 4     // out // = fallbackglyph->advancex
        float FontSize                       # 4     // in  //            // height of characters/line, set during loading (don't change after loading)
        ImVector_ImWchar IndexLookup         # 12-16 // out //            // sparse. index glyphs by unicode code-point.
        ImVector_ImFontGlyph Glyphs          # 12-16 // out //            // all glyphs.
        const ImFontGlyph* FallbackGlyph     # 4-8   // out // = findglyph(fontfallbackchar)
        ImFontAtlas* ContainerAtlas          # 4-8   // out //            // what we has been loaded into
        const ImFontConfig* ConfigData       # 4-8   // in  //            // pointer within containeratlas->configdata
        short ConfigDataCount                # 2     // in  // ~ 1        // number of imfontconfig involved in creating this font. bigger than 1 when merging multiple font sources into one imfont.
        ImWchar FallbackChar                 # 2     // out // = fffd/'?' // character used if a glyph isn't found.
        ImWchar EllipsisChar                 # 2     // out // = '...'/'.'// character used for ellipsis rendering.
        short EllipsisCharCount              # 1     // out // 1 or 3
        float EllipsisWidth                  # 4     // out               // width
        float EllipsisCharStep               # 4     // out               // step between characters when ellipsiscount > 0
        bool DirtyLookupTables               # 1     // out //
        float Scale                          # 4     // in  // = 1.f      // base font scale, multiplied by the per-window font scale which you can adjust with setwindowfontscale()
        float Ascent                         # 4+4   // out //            // ascent: distance from top to bottom of e.g. 'a' [0..fontsize]
        float Descent                        # 4+4   // out //            // ascent: distance from top to bottom of e.g. 'a' [0..fontsize]
        int MetricsTotalSurface              # 4     // out //            // total surface in pixels to get an idea of the font rasterization/texture cost (not exact, we approximate the cost of padding between glyphs)
        ImU8* Used4kPagesMap                 # 2 bytes if imwchar=imwchar16, 34 bytes if imwchar==imwchar32. store 1-bit for each block of 4k codepoints that has one active glyph. this is mainly used to facilitate iterations across all used codepoints.

    void ImFont_AddGlyph(ImFont* self, const ImFontConfig* src_cfg, ImWchar c, float x0, float y0, float x1, float y1, float u0, float v0, float u1, float v1, float advance_x) except +

    # Makes 'dst' character/glyph points to 'src' character/glyph. currently needs to be called after fonts have been built.
    void ImFont_AddRemapChar(ImFont* self, ImWchar dst, ImWchar src, bool overwrite_dst) except +

    # [Internal] Don't use!
    void ImFont_BuildLookupTable(ImFont* self) except +

    # 'max_width' stops rendering after a certain width (could be turned into a 2d size). FLT_MAX to disable.
    # 'wrap_width' enable automatic word-wrapping across multiple lines to fit into given width. 0.0f to disable.
    # Implied text_end = null, remaining = null
    ImVec2 ImFont_CalcTextSizeA(const ImFont* self, float size, float max_width, float wrap_width, const char* text_begin) except +

    # Utf8
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

    # - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
    # - With multi-viewport enabled, we extend this concept to have multiple active viewports.
    # - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
    # - About Main Area vs Work Area:
    # - Main Area = entire viewport.
    # - Work Area = entire viewport minus sections used by main menu bars (for platform windows), or by task bar (for platform monitor).
    # - Windows are generally trying to stay within the Work Area of their host viewport.
    ctypedef struct ImGuiViewport:
        ImGuiID ID                     # Unique identifier for the viewport
        ImGuiViewportFlags Flags       # See imguiviewportflags_
        ImVec2 Pos                     # Main area: position of the viewport (dear imgui coordinates are the same as os desktop/native coordinates)
        ImVec2 Size                    # Main area: size of the viewport.
        ImVec2 WorkPos                 # Work area: position of the viewport minus task bars, menus bars, status bars (>= pos)
        ImVec2 WorkSize                # Work area: size of the viewport minus task bars, menu bars, status bars (<= size)
        float DpiScale                 # 1.0f = 96 dpi = no extra scale.
        ImGuiID ParentViewportId       # (advanced) 0: no parent. instruct the platform backend to setup a parent/child relationship between platform windows.
        ImDrawData* DrawData           # The imdrawdata corresponding to this viewport. valid after render() and until the next call to newframe().
        void* RendererUserData         # Void* to hold custom data structure for the renderer (e.g. swap chain, framebuffers etc.). generally set by your renderer_createwindow function.
        void* PlatformUserData         # Void* to hold custom data structure for the os / platform (e.g. windowing info, render context). generally set by your platform_createwindow function.
        void* PlatformHandle           # Void* for findviewportbyplatformhandle(). (e.g. suggested to use natural platform handle such as hwnd, glfwwindow*, sdl_window*)
        void* PlatformHandleRaw        # Void* to hold lower-level, platform-native window handle (under win32 this is expected to be a hwnd, unused for other platforms), when using an abstraction layer like glfw or sdl (where platformhandle would be a sdl_window*)
        bool PlatformWindowCreated     # Platform window has been created (platform_createwindow() has been called). this is false during the first frame where a viewport is being created.
        bool PlatformRequestMove       # Platform window requested move (e.g. window was moved by the os / host window manager, authoritative position will be os window position)
        bool PlatformRequestResize     # Platform window requested resize (e.g. window was resized by the os / host window manager, authoritative size will be os window size)
        bool PlatformRequestClose      # Platform window requested closure (e.g. window was moved by the os / host window manager, e.g. pressing alt-f4)


    # Helpers
    ImVec2 ImGuiViewport_GetCenter(const ImGuiViewport* self) except +
    ImVec2 ImGuiViewport_GetWorkCenter(const ImGuiViewport* self) except +

    # (Optional) Access via ImGui::GetPlatformIO()
    ctypedef struct ImGuiPlatformIO:
        void (*Platform_CreateWindow)(ImGuiViewport* vp)                                                                           # . . u . .  // create a new platform window for the given viewport
        void (*Platform_DestroyWindow)(ImGuiViewport* vp)                                                                         # N . u . d  //
        void (*Platform_ShowWindow)(ImGuiViewport* vp)                                                                               # . . u . .  // newly created windows are initially hidden so setwindowpos/size/title can be called on them before showing the window
        void (*Platform_SetWindowPos)(ImGuiViewport* vp, ImVec2 pos)                                                               # . . u . .  // set platform window position (given the upper-left corner of client area)
        ImVec2 (*Platform_GetWindowPos)(ImGuiViewport* vp)                                                                         # N . . . .  //
        void (*Platform_SetWindowSize)(ImGuiViewport* vp, ImVec2 size)                                                            # . . u . .  // set platform window client area size (ignoring os decorations such as os title bar etc.)
        ImVec2 (*Platform_GetWindowSize)(ImGuiViewport* vp)                                                                       # N . . . .  // get platform window client area size
        void (*Platform_SetWindowFocus)(ImGuiViewport* vp)                                                                       # N . . . .  // move window to front and set input focus
        bool (*Platform_GetWindowFocus)(ImGuiViewport* vp)                                                                       # . . u . .  //
        bool (*Platform_GetWindowMinimized)(ImGuiViewport* vp)                                                               # N . . . .  // get platform window minimized state. when minimized, we generally won't attempt to get/set size and contents will be culled more easily
        void (*Platform_SetWindowTitle)(ImGuiViewport* vp, const char* str)                                                      # . . u . .  // set platform window title (given an utf-8 string)
        void (*Platform_SetWindowAlpha)(ImGuiViewport* vp, float alpha)                                                          # . . u . .  // (optional) setup global transparency (not per-pixel transparency)
        void (*Platform_UpdateWindow)(ImGuiViewport* vp)                                                                           # . . u . .  // (optional) called by updateplatformwindows(). optional hook to allow the platform backend from doing general book-keeping every frame.
        void (*Platform_RenderWindow)(ImGuiViewport* vp, void* render_arg)                                                         # . . . r .  // (optional) main rendering (platform side! this is often unused, or just setting a 'current' context for opengl bindings). 'render_arg' is the value passed to renderplatformwindowsdefault().
        void (*Platform_SwapBuffers)(ImGuiViewport* vp, void* render_arg)                                                           # . . . r .  // (optional) call present/swapbuffers (platform side! this is often unused!). 'render_arg' is the value passed to renderplatformwindowsdefault().
        float (*Platform_GetWindowDpiScale)(ImGuiViewport* vp)                                                                # N . . . .  // (optional) [beta] fixme-dpi: dpi handling: return dpi scale for this viewport. 1.0f = 96 dpi.
        void (*Platform_OnChangedViewport)(ImGuiViewport* vp)                                                                 # . f . . .  // (optional) [beta] fixme-dpi: dpi handling: called during begin() every time the viewport we are outputting into changes, so backend has a chance to swap fonts to adjust style.
        int (*Platform_CreateVkSurface)(ImGuiViewport* vp, ImU64 vk_inst, const void* vk_allocators, ImU64* out_vk_surface)     # (optional) for a vulkan renderer to call into platform code (since the surface creation needs to tie them both).
        void (*Renderer_CreateWindow)(ImGuiViewport* vp)                                                                           # . . u . .  // create swap chain, frame buffers etc. (called after platform_createwindow)
        void (*Renderer_DestroyWindow)(ImGuiViewport* vp)                                                                         # N . u . d  // destroy swap chain, frame buffers etc. (called before platform_destroywindow)
        void (*Renderer_SetWindowSize)(ImGuiViewport* vp, ImVec2 size)                                                            # . . u . .  // resize swap chain, frame buffers etc. (called after platform_setwindowsize)
        void (*Renderer_RenderWindow)(ImGuiViewport* vp, void* render_arg)                                                         # . . . r .  // (optional) clear framebuffer, setup render target, then render the viewport->drawdata. 'render_arg' is the value passed to renderplatformwindowsdefault().
        void (*Renderer_SwapBuffers)(ImGuiViewport* vp, void* render_arg)                                                           # . . . r .  // (optional) call present/swapbuffers. 'render_arg' is the value passed to renderplatformwindowsdefault().
        ImVector_ImGuiPlatformMonitor Monitors
        ImVector_ImGuiViewportPtr Viewports                                                                                                              # Main viewports, followed by all secondary viewports.


    # (Optional) This is required when enabling multi-viewport. Represent the bounds of each connected monitor/display and their DPI.
    # We use this information for multiple DPI support + clamping the position of popups and tooltips so they don't straddle multiple monitors.
    ctypedef struct ImGuiPlatformMonitor:
        ImVec2 MainPos      # Coordinates of the area displayed on this monitor (min = upper left, max = bottom right)
        ImVec2 MainSize     # Coordinates of the area displayed on this monitor (min = upper left, max = bottom right)
        ImVec2 WorkPos      # Coordinates without task bars / side bars / menu bars. used to avoid positioning popups/tooltips inside this region. if you don't have this info, please copy the value for mainpos/mainsize.
        ImVec2 WorkSize     # Coordinates without task bars / side bars / menu bars. used to avoid positioning popups/tooltips inside this region. if you don't have this info, please copy the value for mainpos/mainsize.
        float DpiScale      # 1.0f = 96 dpi


    # (Optional) Support for IME (Input Method Editor) via the io.SetPlatformImeDataFn() function.
    ctypedef struct ImGuiPlatformImeData:
        bool WantVisible          # A widget wants the ime to be visible
        ImVec2 InputPos           # Position of the input cursor
        float InputLineHeight     # Line height



    ImGuiKey GetKeyIndex(ImGuiKey key) except +

    # Accept contents of a given type. if imguidragdropflags_acceptbeforedelivery is set you can peek into the payload before the mouse button is released.
    const ImGuiPayload* ImGui_AcceptDragDropPayload(const char* type_, ImGuiDragDropFlags flags) except +

    # Vertically align upcoming text baseline to framepadding.y so that it will align properly to regularly framed items (call if you have text on a line before a framed item)
    void ImGui_AlignTextToFramePadding() except +

    # Square button with an arrow shape
    bool ImGui_ArrowButton(const char* str_id, ImGuiDir dir_) except +

    # Windows
    # - Begin() = push window to the stack and start appending to it. End() = pop window from the stack.
    # - Passing 'bool* p_open != NULL' shows a window-closing widget in the upper-right corner of the window,
    # which clicking will set the boolean to false when clicked.
    # - You may append multiple times to the same window during the same frame by calling Begin()/End() pairs multiple times.
    # Some information such as 'flags' or 'p_open' will only be considered by the first call to Begin().
    # - Begin() return false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
    # anything to the window. Always call a matching End() for each Begin() call, regardless of its return value!
    # [Important: due to legacy reason, this is inconsistent with most other functions such as BeginMenu/EndMenu,
    # BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding BeginXXX function
    # returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
    # - Note that the bottom of window stack always contains a window called "Debug".
    bool ImGui_Begin(const char* name, bool* p_open, ImGuiWindowFlags flags) except +

    # Child Windows
    # - Use child windows to begin into a self-contained independent scrolling/clipping regions within a host window. Child windows can embed their own child.
    # - For each independent axis of 'size': ==0.0f: use remaining host window size / >0.0f: fixed size / <0.0f: use remaining window size minus abs(size) / Each axis can use a different mode, e.g. ImVec2(0,400).
    # - BeginChild() returns false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting anything to the window.
    # Always call a matching EndChild() for each BeginChild() call, regardless of its return value.
    # [Important: due to legacy reason, this is inconsistent with most other functions such as BeginMenu/EndMenu,
    # BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding BeginXXX function
    # returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
    bool ImGui_BeginChild(const char* str_id, ImVec2 size, bool border, ImGuiWindowFlags flags) except +

    # Helper to create a child window / scrolling region that looks like a normal widget frame
    bool ImGui_BeginChildFrame(ImGuiID id_, ImVec2 size, ImGuiWindowFlags flags) except +
    bool ImGui_BeginChildID(ImGuiID id_, ImVec2 size, bool border, ImGuiWindowFlags flags) except +

    # Widgets: Combo Box (Dropdown)
    # - The BeginCombo()/EndCombo() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() items.
    # - The old Combo() api are helpers over BeginCombo()/EndCombo() which are kept available for convenience purpose. This is analogous to how ListBox are created.
    bool ImGui_BeginCombo(const char* label, const char* preview_value, ImGuiComboFlags flags) except +

    # Disabling [BETA API]
    # - Disable all user interactions and dim items visuals (applying style.DisabledAlpha over current colors)
    # - Those can be nested but it cannot be used to enable an already disabled section (a single BeginDisabled(true) in the stack is enough to keep everything disabled)
    # - BeginDisabled(false) essentially does nothing useful but is provided to facilitate use of boolean expressions. If you can avoid calling BeginDisabled(False)/EndDisabled() best to avoid it.
    void ImGui_BeginDisabled(bool disabled) except +

    # Drag and Drop
    # - On source items, call BeginDragDropSource(), if it returns true also call SetDragDropPayload() + EndDragDropSource().
    # - On target candidates, call BeginDragDropTarget(), if it returns true also call AcceptDragDropPayload() + EndDragDropTarget().
    # - If you stop calling BeginDragDropSource() the payload is preserved however it won't have a preview tooltip (we currently display a fallback "..." tooltip, see #1725)
    # - An item can be both drag source and drop target.
    # Call after submitting an item which may be dragged. when this return true, you can call setdragdroppayload() + enddragdropsource()
    bool ImGui_BeginDragDropSource(ImGuiDragDropFlags flags) except +

    # Call after submitting an item that may receive a payload. if this returns true, you can call acceptdragdroppayload() + enddragdroptarget()
    bool ImGui_BeginDragDropTarget() except +

    # Lock horizontal starting position
    void ImGui_BeginGroup() except +

    # Widgets: List Boxes
    # - This is essentially a thin wrapper to using BeginChild/EndChild with some stylistic changes.
    # - The BeginListBox()/EndListBox() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() or any items.
    # - The simplified/old ListBox() api are helpers over BeginListBox()/EndListBox() which are kept available for convenience purpose. This is analoguous to how Combos are created.
    # - Choose frame width:   size.x > 0.0f: custom  /  size.x < 0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
    # - Choose frame height:  size.y > 0.0f: custom  /  size.y < 0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
    # Open a framed scrolling region
    bool ImGui_BeginListBox(const char* label, ImVec2 size) except +

    # Create and append to a full screen menu-bar.
    bool ImGui_BeginMainMenuBar() except +

    # Implied enabled = true
    bool ImGui_BeginMenu(const char* label) except +

    # Widgets: Menus
    # - Use BeginMenuBar() on a window ImGuiWindowFlags_MenuBar to append to its menu bar.
    # - Use BeginMainMenuBar() to create a menu bar at the top of the screen and append to it.
    # - Use BeginMenu() to create a menu. You can call BeginMenu() multiple time with the same identifier to append more items to it.
    # - Not that MenuItem() keyboardshortcuts are displayed as a convenience but _not processed_ by Dear ImGui at the moment.
    # Append to menu-bar of current window (requires imguiwindowflags_menubar flag set on parent window).
    bool ImGui_BeginMenuBar() except +

    # Create a sub-menu entry. only call endmenu() if this returns true!
    bool ImGui_BeginMenuEx(const char* label, bool enabled) except +

    # Popups: begin/end functions
    # - BeginPopup(): query popup state, if open start appending into the window. Call EndPopup() afterwards. ImGuiWindowFlags are forwarded to the window.
    # - BeginPopupModal(): block every interaction behind the window, cannot be closed by user, add a dimming background, has a title bar.
    # Return true if the popup is open, and you can start outputting to it.
    bool ImGui_BeginPopup(const char* str_id, ImGuiWindowFlags flags) except +

    # Popups: open+begin combined functions helpers
    # - Helpers to do OpenPopup+BeginPopup where the Open action is triggered by e.g. hovering an item and right-clicking.
    # - They are convenient to easily create context menus, hence the name.
    # - IMPORTANT: Notice that BeginPopupContextXXX takes ImGuiPopupFlags just like OpenPopup() and unlike BeginPopup(). For full consistency, we may add ImGuiWindowFlags to the BeginPopupContextXXX functions in the future.
    # - IMPORTANT: Notice that we exceptionally default their flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter, so if you add other flags remember to re-add the ImGuiPopupFlags_MouseButtonRight.
    # Implied str_id = null, popup_flags = 1
    bool ImGui_BeginPopupContextItem() except +

    # Open+begin popup when clicked on last item. use str_id==null to associate the popup to previous item. if you want to use that on a non-interactive item such as text() you need to pass in an explicit id here. read comments in .cpp!
    bool ImGui_BeginPopupContextItemEx(const char* str_id, ImGuiPopupFlags popup_flags) except +

    # Implied str_id = null, popup_flags = 1
    bool ImGui_BeginPopupContextVoid() except +

    # Open+begin popup when clicked in void (where there are no windows).
    bool ImGui_BeginPopupContextVoidEx(const char* str_id, ImGuiPopupFlags popup_flags) except +

    # Implied str_id = null, popup_flags = 1
    bool ImGui_BeginPopupContextWindow() except +

    # Open+begin popup when clicked on current window.
    bool ImGui_BeginPopupContextWindowEx(const char* str_id, ImGuiPopupFlags popup_flags) except +

    # Return true if the modal is open, and you can start outputting to it.
    bool ImGui_BeginPopupModal(const char* name, bool* p_open, ImGuiWindowFlags flags) except +

    # Tab Bars, Tabs
    # - Note: Tabs are automatically created by the docking system (when in 'docking' branch). Use this to create tab bars/tabs yourself.
    # Create and append into a tabbar
    bool ImGui_BeginTabBar(const char* str_id, ImGuiTabBarFlags flags) except +

    # Create a tab. returns true if the tab is selected.
    bool ImGui_BeginTabItem(const char* label, bool* p_open, ImGuiTabItemFlags flags) except +

    # Tables
    # - Full-featured replacement for old Columns API.
    # - See Demo->Tables for demo code. See top of imgui_tables.cpp for general commentary.
    # - See ImGuiTableFlags_ and ImGuiTableColumnFlags_ enums for a description of available flags.
    # The typical call flow is:
    # - 1. Call BeginTable(), early out if returning false.
    # - 2. Optionally call TableSetupColumn() to submit column name/flags/defaults.
    # - 3. Optionally call TableSetupScrollFreeze() to request scroll freezing of columns/rows.
    # - 4. Optionally call TableHeadersRow() to submit a header row. Names are pulled from TableSetupColumn() data.
    # - 5. Populate contents:
    # - In most situations you can use TableNextRow() + TableSetColumnIndex(N) to start appending into a column.
    # - If you are using tables as a sort of grid, where every column is holding the same type of contents,
    # you may prefer using TableNextColumn() instead of TableNextRow() + TableSetColumnIndex().
    # TableNextColumn() will automatically wrap-around into the next row if needed.
    # - IMPORTANT: Comparatively to the old Columns() API, we need to call TableNextColumn() for the first column!
    # - Summary of possible call flow:
    # --------------------------------------------------------------------------------------------------------
    # TableNextRow() -> TableSetColumnIndex(0) -> Text("Hello 0") -> TableSetColumnIndex(1) -> Text("Hello 1")  // OK
    # TableNextRow() -> TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK
    # TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK: TableNextColumn() automatically gets to next row!
    # TableNextRow()                           -> Text("Hello 0")                                               // Not OK! Missing TableSetColumnIndex() or TableNextColumn()! Text will not appear!
    # --------------------------------------------------------------------------------------------------------
    # - 5. Call EndTable()
    # Implied outer_size = imvec2(0.0f, 0.0f), inner_width = 0.0f
    bool ImGui_BeginTable(const char* str_id, int column, ImGuiTableFlags flags) except +
    bool ImGui_BeginTableEx(const char* str_id, int column, ImGuiTableFlags flags, ImVec2 outer_size, float inner_width) except +

    # Tooltips
    # - Tooltip are windows following the mouse. They do not take focus away.
    # Begin/append a tooltip window. to create full-featured tooltip (with any kind of items).
    bool ImGui_BeginTooltip() except +

    # Draw a small circle + keep the cursor on the same line. advance cursor x position by gettreenodetolabelspacing(), same distance that treenode() uses
    void ImGui_Bullet() except +

    # Shortcut for bullet()+text()
    void ImGui_BulletText(const char* fmt) except +
    void ImGui_BulletTextV(const char* fmt) except +

    # Widgets: Main
    # - Most widgets return true when the value has been changed or when pressed/selected
    # - You may also use one of the many IsItemXXX functions (e.g. IsItemActive, IsItemHovered, etc.) to query widget state.
    # Implied size = imvec2(0, 0)
    bool ImGui_Button(const char* label) except +

    # Button
    bool ImGui_ButtonEx(const char* label, ImVec2 size) except +

    # Width of item given pushed settings and current cursor position. not necessarily the width of last item unlike most 'item' functions.
    float ImGui_CalcItemWidth() except +

    # Text Utilities
    # Implied text_end = null, hide_text_after_double_hash = false, wrap_width = -1.0f
    ImVec2 ImGui_CalcTextSize(const char* text) except +
    ImVec2 ImGui_CalcTextSizeEx(const char* text, const char* text_end, bool hide_text_after_double_hash, float wrap_width) except +
    bool ImGui_Checkbox(const char* label, bool* v) except +
    bool ImGui_CheckboxFlagsIntPtr(const char* label, int* flags, int flags_value) except +
    bool ImGui_CheckboxFlagsUintPtr(const char* label, unsigned int* flags, unsigned int flags_value) except +

    # Manually close the popup we have begin-ed into.
    void ImGui_CloseCurrentPopup() except +

    # If returning 'true' the header is open. doesn't indent nor push on id stack. user doesn't have to call treepop().
    bool ImGui_CollapsingHeader(const char* label, ImGuiTreeNodeFlags flags) except +

    # When 'p_visible != null': if '*p_visible==true' display an additional small close button on upper right of the header which will set the bool to false when clicked, if '*p_visible==false' don't display the header.
    bool ImGui_CollapsingHeaderBoolPtr(const char* label, bool* p_visible, ImGuiTreeNodeFlags flags) except +

    # Implied size = imvec2(0, 0)
    bool ImGui_ColorButton(const char* desc_id, ImVec4 col, ImGuiColorEditFlags flags) except +

    # Display a color square/button, hover for details, return true when pressed.
    bool ImGui_ColorButtonEx(const char* desc_id, ImVec4 col, ImGuiColorEditFlags flags, ImVec2 size) except +
    ImU32 ImGui_ColorConvertFloat4ToU32(ImVec4 in_) except +
    void ImGui_ColorConvertHSVtoRGB(float h, float s, float v, float* out_r, float* out_g, float* out_b) except +
    void ImGui_ColorConvertRGBtoHSV(float r, float g, float b, float* out_h, float* out_s, float* out_v) except +

    # Color Utilities
    ImVec4 ImGui_ColorConvertU32ToFloat4(ImU32 in_) except +

    # Widgets: Color Editor/Picker (tip: the ColorEdit* functions have a little color square that can be left-clicked to open a picker, and right-clicked to open an option menu.)
    # - Note that in C++ a 'float v[X]' function argument is the _same_ as 'float* v', the array syntax is just a way to document the number of elements that are expected to be accessible.
    # - You can pass the address of a first float element out of a contiguous structure, e.g. &myvector.x
    bool ImGui_ColorEdit3(const char* label, float* col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorEdit4(const char* label, float* col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorPicker3(const char* label, float* col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorPicker4(const char* label, float* col, ImGuiColorEditFlags flags, const float* ref_col) except +

    # Legacy Columns API (prefer using Tables!)
    # - You can also use SameLine(pos_x) to mimic simplified columns.
    # Implied count = 1, id = null, border = true
    void ImGui_Columns() except +
    void ImGui_ColumnsEx(int count, const char* id_, bool border) except +

    # Implied popup_max_height_in_items = -1
    bool ImGui_Combo(const char* label, int* current_item, const char* items_separated_by_zeros) except +

    # Implied popup_max_height_in_items = -1
    bool ImGui_ComboCallback(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count) except +
    bool ImGui_ComboCallbackEx(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int popup_max_height_in_items) except +

    # Implied popup_max_height_in_items = -1
    bool ImGui_ComboChar(const char* label, int* current_item, const char** items, int items_count) except +
    bool ImGui_ComboCharEx(const char* label, int* current_item, const char** items, int items_count, int popup_max_height_in_items) except +

    # Separate items with \0 within a string, end item-list with \0\0. e.g. 'one\0two\0three\0'
    bool ImGui_ComboEx(const char* label, int* current_item, const char* items_separated_by_zeros, int popup_max_height_in_items) except +

    # Context creation and access
    # - Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
    # - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
    # for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
    ImGuiContext* ImGui_CreateContext(ImFontAtlas* shared_font_atlas) except +

    # This is called by imgui_checkversion() macro.
    bool ImGui_DebugCheckVersionAndDataLayout(const char* version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx) except +

    # Debug Utilities
    void ImGui_DebugTextEncoding(const char* text) except +

    # Null = destroy current context
    void ImGui_DestroyContext(ImGuiContext* ctx) except +

    # Call destroywindow platform functions for all viewports. call from backend shutdown() if you need to close platform windows before imgui shutdown. otherwise will be called by destroycontext().
    void ImGui_DestroyPlatformWindows() except +

    # Docking
    # [BETA API] Enable with io.ConfigFlags |= ImGuiConfigFlags_DockingEnable.
    # Note: You can use most Docking facilities without calling any API. You DO NOT need to call DockSpace() to use Docking!
    # - Drag from window title bar or their tab to dock/undock. Hold SHIFT to disable docking/undocking.
    # - Drag from window menu button (upper-left button) to undock an entire node (all windows).
    # - When io.ConfigDockingWithShift == true, you instead need to hold SHIFT to _enable_ docking/undocking.
    # About dockspaces:
    # - Use DockSpace() to create an explicit dock node _within_ an existing window. See Docking demo for details.
    # - Use DockSpaceOverViewport() to create an explicit dock node covering the screen or a specific viewport.
    # This is often used with ImGuiDockNodeFlags_PassthruCentralNode.
    # - Important: Dockspaces need to be submitted _before_ any window they can host. Submit it early in your frame!
    # - Important: Dockspaces need to be kept alive if hidden, otherwise windows docked into it will be undocked.
    # e.g. if you have multiple tabs with a dockspace inside each tab: submit the non-visible dockspaces with ImGuiDockNodeFlags_KeepAliveOnly.
    # Implied size = imvec2(0, 0), flags = 0, window_class = null
    ImGuiID ImGui_DockSpace(ImGuiID id_) except +
    ImGuiID ImGui_DockSpaceEx(ImGuiID id_, ImVec2 size, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +

    # Implied viewport = null, flags = 0, window_class = null
    ImGuiID ImGui_DockSpaceOverViewport() except +
    ImGuiID ImGui_DockSpaceOverViewportEx(const ImGuiViewport* viewport, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +

    # Widgets: Drag Sliders
    # - CTRL+Click on any drag box to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
    # - For all the Float2/Float3/Float4/Int2/Int3/Int4 versions of every function, note that a 'float v[X]' function argument is the same as 'float* v',
    # the array syntax is just a way to document the number of elements that are expected to be accessible. You can pass address of your first element out of a contiguous set, e.g. &myvector.x
    # - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
    # - Format string may also be set to NULL or use the default format ("%f" or "%d").
    # - Speed are per-pixel of mouse movement (v_speed=0.2f: mouse needs to move by 5 pixels to increase value by 1). For gamepad/keyboard navigation, minimum speed is Max(v_speed, minimum_step_at_given_precision).
    # - Use v_min < v_max to clamp edits to given limits. Note that CTRL+Click manual input can override those limits if ImGuiSliderFlags_AlwaysClamp is not used.
    # - Use v_max = FLT_MAX / INT_MAX etc to avoid clamping to a maximum, same with v_min = -FLT_MAX / INT_MIN to avoid clamping to a minimum.
    # - We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
    # - Legacy: Pre-1.78 there are DragXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
    # If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
    # Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    bool ImGui_DragFloat(const char* label, float* v) except +

    # Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    bool ImGui_DragFloat2(const char* label, float* v) except +
    bool ImGui_DragFloat2Ex(const char* label, float* v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    bool ImGui_DragFloat3(const char* label, float* v) except +
    bool ImGui_DragFloat3Ex(const char* label, float* v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', flags = 0
    bool ImGui_DragFloat4(const char* label, float* v) except +
    bool ImGui_DragFloat4Ex(const char* label, float* v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    # If v_min >= v_max we have no bound
    bool ImGui_DragFloatEx(const char* label, float* v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied v_speed = 1.0f, v_min = 0.0f, v_max = 0.0f, format = '%.3f', format_max = null, flags = 0
    bool ImGui_DragFloatRange2(const char* label, float* v_current_min, float* v_current_max) except +
    bool ImGui_DragFloatRange2Ex(const char* label, float* v_current_min, float* v_current_max, float v_speed, float v_min, float v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +

    # Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = '%d', flags = 0
    bool ImGui_DragInt(const char* label, int* v) except +

    # Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = '%d', flags = 0
    bool ImGui_DragInt2(const char* label, int* v) except +
    bool ImGui_DragInt2Ex(const char* label, int* v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = '%d', flags = 0
    bool ImGui_DragInt3(const char* label, int* v) except +
    bool ImGui_DragInt3Ex(const char* label, int* v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = '%d', flags = 0
    bool ImGui_DragInt4(const char* label, int* v) except +
    bool ImGui_DragInt4Ex(const char* label, int* v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    # If v_min >= v_max we have no bound
    bool ImGui_DragIntEx(const char* label, int* v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied v_speed = 1.0f, v_min = 0, v_max = 0, format = '%d', format_max = null, flags = 0
    bool ImGui_DragIntRange2(const char* label, int* v_current_min, int* v_current_max) except +
    bool ImGui_DragIntRange2Ex(const char* label, int* v_current_min, int* v_current_max, float v_speed, int v_min, int v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +

    # Implied v_speed = 1.0f, p_min = null, p_max = null, format = null, flags = 0
    bool ImGui_DragScalar(const char* label, ImGuiDataType data_type, void* p_data) except +
    bool ImGui_DragScalarEx(const char* label, ImGuiDataType data_type, void* p_data, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied v_speed = 1.0f, p_min = null, p_max = null, format = null, flags = 0
    bool ImGui_DragScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components) except +
    bool ImGui_DragScalarNEx(const char* label, ImGuiDataType data_type, void* p_data, int components, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    # Add a dummy item of given size. unlike invisiblebutton(), dummy() won't take the mouse click or be navigable into.
    void ImGui_Dummy(ImVec2 size) except +
    void ImGui_End() except +
    void ImGui_EndChild() except +

    # Always call endchildframe() regardless of beginchildframe() return values (which indicates a collapsed/clipped window)
    void ImGui_EndChildFrame() except +

    # Only call endcombo() if begincombo() returns true!
    void ImGui_EndCombo() except +
    void ImGui_EndDisabled() except +

    # Only call enddragdropsource() if begindragdropsource() returns true!
    void ImGui_EndDragDropSource() except +

    # Only call enddragdroptarget() if begindragdroptarget() returns true!
    void ImGui_EndDragDropTarget() except +

    # Ends the dear imgui frame. automatically called by render(). if you don't need to render data (skipping rendering) you may call endframe() without render()... but you'll have wasted cpu already! if you don't need to render, better to not create any windows and not call newframe() at all!
    void ImGui_EndFrame() except +

    # Unlock horizontal starting position + capture the whole group bounding box into one 'item' (so you can use isitemhovered() or layout primitives such as sameline() on whole group, etc.)
    void ImGui_EndGroup() except +

    # Only call endlistbox() if beginlistbox() returned true!
    void ImGui_EndListBox() except +

    # Only call endmainmenubar() if beginmainmenubar() returns true!
    void ImGui_EndMainMenuBar() except +

    # Only call endmenu() if beginmenu() returns true!
    void ImGui_EndMenu() except +

    # Only call endmenubar() if beginmenubar() returns true!
    void ImGui_EndMenuBar() except +

    # Only call endpopup() if beginpopupxxx() returns true!
    void ImGui_EndPopup() except +

    # Only call endtabbar() if begintabbar() returns true!
    void ImGui_EndTabBar() except +

    # Only call endtabitem() if begintabitem() returns true!
    void ImGui_EndTabItem() except +

    # Only call endtable() if begintable() returns true!
    void ImGui_EndTable() except +

    # Only call endtooltip() if begintooltip() returns true!
    void ImGui_EndTooltip() except +

    # This is a helper for backends.
    ImGuiViewport* ImGui_FindViewportByID(ImGuiID id_) except +

    # This is a helper for backends. the type platform_handle is decided by the backend (e.g. hwnd, mywindow*, glfwwindow* etc.)
    ImGuiViewport* ImGui_FindViewportByPlatformHandle(void* platform_handle) except +
    void ImGui_GetAllocatorFunctions(ImGuiMemAllocFunc* p_alloc_func, ImGuiMemFreeFunc* p_free_func, void** p_user_data) except +

    # Background/Foreground Draw Lists
    # Get background draw list for the viewport associated to the current window. this draw list will be the first rendering one. useful to quickly draw shapes/text behind dear imgui contents.
    ImDrawList* ImGui_GetBackgroundDrawList() except +

    # Get background draw list for the given viewport. this draw list will be the first rendering one. useful to quickly draw shapes/text behind dear imgui contents.
    ImDrawList* ImGui_GetBackgroundDrawListImGuiViewportPtr(ImGuiViewport* viewport) except +

    # Clipboard Utilities
    # - Also see the LogToClipboard() function to capture GUI into clipboard, or easily output text data to the clipboard.
    const char* ImGui_GetClipboardText() except +

    # Implied alpha_mul = 1.0f
    ImU32 ImGui_GetColorU32(ImGuiCol idx) except +

    # Retrieve given style color with style alpha applied and optional extra alpha multiplier, packed as a 32-bit value suitable for imdrawlist
    ImU32 ImGui_GetColorU32Ex(ImGuiCol idx, float alpha_mul) except +

    # Retrieve given color with style alpha applied, packed as a 32-bit value suitable for imdrawlist
    ImU32 ImGui_GetColorU32ImU32(ImU32 col) except +

    # Retrieve given color with style alpha applied, packed as a 32-bit value suitable for imdrawlist
    ImU32 ImGui_GetColorU32ImVec4(ImVec4 col) except +

    # Get current column index
    int ImGui_GetColumnIndex() except +

    # Get position of column line (in pixels, from the left side of the contents region). pass -1 to use current column, otherwise 0..getcolumnscount() inclusive. column 0 is typically 0.0f
    float ImGui_GetColumnOffset(int column_index) except +

    # Get column width (in pixels). pass -1 to use current column
    float ImGui_GetColumnWidth(int column_index) except +
    int ImGui_GetColumnsCount() except +

    # Content region
    # - Retrieve available space from a given point. GetContentRegionAvail() is frequently useful.
    # - Those functions are bound to be redesigned (they are confusing, incomplete and the Min/Max return values are in local window coordinates which increases confusion)
    # == getcontentregionmax() - getcursorpos()
    ImVec2 ImGui_GetContentRegionAvail() except +

    # Current content boundaries (typically window boundaries including scrolling, or current column boundaries), in windows coordinates
    ImVec2 ImGui_GetContentRegionMax() except +
    ImGuiContext* ImGui_GetCurrentContext() except +

    # Cursor position in window coordinates (relative to window position)
    ImVec2 ImGui_GetCursorPos() except +

    # (some functions are using window-relative coordinates, such as: getcursorpos, getcursorstartpos, getcontentregionmax, getwindowcontentregion* etc.
    float ImGui_GetCursorPosX() except +

    # Other functions such as getcursorscreenpos or everything in imdrawlist::
    float ImGui_GetCursorPosY() except +

    # Cursor position in absolute coordinates (useful to work with imdrawlist api). generally top-left == getmainviewport()->pos == (0,0) in single viewport mode, and bottom-right == getmainviewport()->pos+size == io.displaysize in single-viewport mode.
    ImVec2 ImGui_GetCursorScreenPos() except +

    # Initial cursor position in window coordinates
    ImVec2 ImGui_GetCursorStartPos() except +

    # Peek directly into the current payload from anywhere. may return null. use imguipayload::isdatatype() to test for the payload type.
    const ImGuiPayload* ImGui_GetDragDropPayload() except +

    # Valid after render() and until the next call to newframe(). this is what you have to render.
    ImDrawData* ImGui_GetDrawData() except +

    # You may use this when creating your own imdrawlist instances.
    ImDrawListSharedData* ImGui_GetDrawListSharedData() except +

    # Style read access
    # - Use the ShowStyleEditor() function to interactively see/edit the colors.
    # Get current font
    ImFont* ImGui_GetFont() except +

    # Get current font size (= height in pixels) of current font with current scale applied
    float ImGui_GetFontSize() except +

    # Get uv coordinate for a while pixel, useful to draw custom shapes via the imdrawlist api
    ImVec2 ImGui_GetFontTexUvWhitePixel() except +

    # Get foreground draw list for the viewport associated to the current window. this draw list will be the last rendered one. useful to quickly draw shapes/text over dear imgui contents.
    ImDrawList* ImGui_GetForegroundDrawList() except +

    # Get foreground draw list for the given viewport. this draw list will be the last rendered one. useful to quickly draw shapes/text over dear imgui contents.
    ImDrawList* ImGui_GetForegroundDrawListImGuiViewportPtr(ImGuiViewport* viewport) except +

    # Get global imgui frame count. incremented by 1 every frame.
    int ImGui_GetFrameCount() except +

    # ~ fontsize + style.framepadding.y * 2
    float ImGui_GetFrameHeight() except +

    # ~ fontsize + style.framepadding.y * 2 + style.itemspacing.y (distance in pixels between 2 consecutive lines of framed widgets)
    float ImGui_GetFrameHeightWithSpacing() except +

    # Calculate unique id (hash of whole id stack + given parameter). e.g. if you want to query into imguistorage yourself
    ImGuiID ImGui_GetID(const char* str_id) except +
    ImGuiID ImGui_GetIDPtr(const void* ptr_id) except +
    ImGuiID ImGui_GetIDStr(const char* str_id_begin, const char* str_id_end) except +

    # Main
    # Access the io structure (mouse/keyboard/gamepad inputs, time, various configuration options/flags)
    ImGuiIO* ImGui_GetIO() except +

    # Get id of last item (~~ often same imgui::getid(label) beforehand)
    ImGuiID ImGui_GetItemID() except +

    # Get lower-right bounding rectangle of the last item (screen space)
    ImVec2 ImGui_GetItemRectMax() except +

    # Get upper-left bounding rectangle of the last item (screen space)
    ImVec2 ImGui_GetItemRectMin() except +

    # Get size of last item
    ImVec2 ImGui_GetItemRectSize() except +

    # [debug] returns english name of the key. those names a provided for debugging purpose and are not meant to be saved persistently not compared.
    const char* ImGui_GetKeyName(ImGuiKey key) except +

    # Uses provided repeat rate/delay. return a count, most often 0 or 1 but might be >1 if repeatrate is small enough that deltatime > repeatrate
    int ImGui_GetKeyPressedAmount(ImGuiKey key, float repeat_delay, float rate) except +

    # Viewports
    # - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
    # - In 'docking' branch with multi-viewport enabled, we extend this concept to have multiple active viewports.
    # - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
    # Return primary/default viewport. this can never be null.
    ImGuiViewport* ImGui_GetMainViewport() except +

    # Return the number of successive mouse-clicks at the time where a click happen (otherwise 0).
    int ImGui_GetMouseClickedCount(ImGuiMouseButton button) except +

    # Get desired mouse cursor shape. important: reset in imgui::newframe(), this is updated during the frame. valid before render(). if you use software rendering by setting io.mousedrawcursor imgui will render those for you
    ImGuiMouseCursor ImGui_GetMouseCursor() except +

    # Return the delta from the initial clicking position while the mouse button is pressed or was just released. this is locked and return 0.0f until the mouse moves past a distance threshold at least once (if lock_threshold < -1.0f, uses io.mousedraggingthreshold)
    ImVec2 ImGui_GetMouseDragDelta(ImGuiMouseButton button, float lock_threshold) except +

    # Shortcut to imgui::getio().mousepos provided by user, to be consistent with other calls
    ImVec2 ImGui_GetMousePos() except +

    # Retrieve mouse position at the time of opening popup we have beginpopup() into (helper to avoid user backing that value themselves)
    ImVec2 ImGui_GetMousePosOnOpeningCurrentPopup() except +

    # (Optional) Platform/OS interface for multi-viewport support
    # Read comments around the ImGuiPlatformIO structure for more details.
    # Note: You may use GetWindowViewport() to get the current viewport of the current window.
    # Platform/renderer functions, for backend to setup + viewports list.
    ImGuiPlatformIO* ImGui_GetPlatformIO() except +

    # Get maximum scrolling amount ~~ contentsize.x - windowsize.x - decorationssize.x
    float ImGui_GetScrollMaxX() except +

    # Get maximum scrolling amount ~~ contentsize.y - windowsize.y - decorationssize.y
    float ImGui_GetScrollMaxY() except +

    # Windows Scrolling
    # - Any change of Scroll will be applied at the beginning of next frame in the first call to Begin().
    # - You may instead use SetNextWindowScroll() prior to calling Begin() to avoid this delay, as an alternative to using SetScrollX()/SetScrollY().
    # Get scrolling amount [0 .. getscrollmaxx()]
    float ImGui_GetScrollX() except +

    # Get scrolling amount [0 .. getscrollmaxy()]
    float ImGui_GetScrollY() except +
    ImGuiStorage* ImGui_GetStateStorage() except +

    # Access the style structure (colors, sizes). always use pushstylecol(), pushstylevar() to modify style mid-frame!
    ImGuiStyle* ImGui_GetStyle() except +

    # Get a string corresponding to the enum value (for display, saving, etc.).
    const char* ImGui_GetStyleColorName(ImGuiCol idx) except +

    # Retrieve style color as stored in imguistyle structure. use to feed back into pushstylecolor(), otherwise use getcoloru32() to get style color with style alpha baked in.
    const ImVec4* ImGui_GetStyleColorVec4(ImGuiCol idx) except +

    # ~ fontsize
    float ImGui_GetTextLineHeight() except +

    # ~ fontsize + style.itemspacing.y (distance in pixels between 2 consecutive lines of text)
    float ImGui_GetTextLineHeightWithSpacing() except +

    # Get global imgui time. incremented by io.deltatime every frame.
    double ImGui_GetTime() except +

    # Horizontal distance preceding label when using treenode*() or bullet() == (g.fontsize + style.framepadding.x*2) for a regular unframed treenode
    float ImGui_GetTreeNodeToLabelSpacing() except +

    # Get the compiled version string e.g. '1.80 wip' (essentially the value for imgui_version from the compiled version of imgui.cpp)
    const char* ImGui_GetVersion() except +

    # Content boundaries max for the full window (roughly (0,0)+size-scroll) where size can be overridden with setnextwindowcontentsize(), in window coordinates
    ImVec2 ImGui_GetWindowContentRegionMax() except +

    # Content boundaries min for the full window (roughly (0,0)-scroll), in window coordinates
    ImVec2 ImGui_GetWindowContentRegionMin() except +
    ImGuiID ImGui_GetWindowDockID() except +

    # Get dpi scale currently associated to the current window's viewport.
    float ImGui_GetWindowDpiScale() except +

    # Get draw list associated to the current window, to append your own drawing primitives
    ImDrawList* ImGui_GetWindowDrawList() except +

    # Get current window height (shortcut for getwindowsize().y)
    float ImGui_GetWindowHeight() except +

    # Get current window position in screen space (useful if you want to do your own drawing via the drawlist api)
    ImVec2 ImGui_GetWindowPos() except +

    # Get current window size
    ImVec2 ImGui_GetWindowSize() except +

    # Get viewport currently associated to the current window.
    ImGuiViewport* ImGui_GetWindowViewport() except +

    # Get current window width (shortcut for getwindowsize().x)
    float ImGui_GetWindowWidth() except +

    # Widgets: Images
    # - Read about ImTextureID here: https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples
    # Implied uv0 = imvec2(0, 0), uv1 = imvec2(1, 1), tint_col = imvec4(1, 1, 1, 1), border_col = imvec4(0, 0, 0, 0)
    void ImGui_Image(ImTextureID user_texture_id, ImVec2 size) except +

    # Implied uv0 = imvec2(0, 0), uv1 = imvec2(1, 1), bg_col = imvec4(0, 0, 0, 0), tint_col = imvec4(1, 1, 1, 1)
    bool ImGui_ImageButton(const char* str_id, ImTextureID user_texture_id, ImVec2 size) except +
    bool ImGui_ImageButtonEx(const char* str_id, ImTextureID user_texture_id, ImVec2 size, ImVec2 uv0, ImVec2 uv1, ImVec4 bg_col, ImVec4 tint_col) except +
    void ImGui_ImageEx(ImTextureID user_texture_id, ImVec2 size, ImVec2 uv0, ImVec2 uv1, ImVec4 tint_col, ImVec4 border_col) except +

    # Implied indent_w = 0.0f
    void ImGui_Indent() except +

    # Move content position toward the right, by indent_w, or style.indentspacing if indent_w <= 0
    void ImGui_IndentEx(float indent_w) except +

    # Implied step = 0.0, step_fast = 0.0, format = '%.6f', flags = 0
    bool ImGui_InputDouble(const char* label, double* v) except +
    bool ImGui_InputDoubleEx(const char* label, double* v, double step, double step_fast, const char* format_, ImGuiInputTextFlags flags) except +

    # Implied step = 0.0f, step_fast = 0.0f, format = '%.3f', flags = 0
    bool ImGui_InputFloat(const char* label, float* v) except +

    # Implied format = '%.3f', flags = 0
    bool ImGui_InputFloat2(const char* label, float* v) except +
    bool ImGui_InputFloat2Ex(const char* label, float* v, const char* format_, ImGuiInputTextFlags flags) except +

    # Implied format = '%.3f', flags = 0
    bool ImGui_InputFloat3(const char* label, float* v) except +
    bool ImGui_InputFloat3Ex(const char* label, float* v, const char* format_, ImGuiInputTextFlags flags) except +

    # Implied format = '%.3f', flags = 0
    bool ImGui_InputFloat4(const char* label, float* v) except +
    bool ImGui_InputFloat4Ex(const char* label, float* v, const char* format_, ImGuiInputTextFlags flags) except +
    bool ImGui_InputFloatEx(const char* label, float* v, float step, float step_fast, const char* format_, ImGuiInputTextFlags flags) except +

    # Implied step = 1, step_fast = 100, flags = 0
    bool ImGui_InputInt(const char* label, int* v) except +
    bool ImGui_InputInt2(const char* label, int* v, ImGuiInputTextFlags flags) except +
    bool ImGui_InputInt3(const char* label, int* v, ImGuiInputTextFlags flags) except +
    bool ImGui_InputInt4(const char* label, int* v, ImGuiInputTextFlags flags) except +
    bool ImGui_InputIntEx(const char* label, int* v, int step, int step_fast, ImGuiInputTextFlags flags) except +

    # Implied p_step = null, p_step_fast = null, format = null, flags = 0
    bool ImGui_InputScalar(const char* label, ImGuiDataType data_type, void* p_data) except +
    bool ImGui_InputScalarEx(const char* label, ImGuiDataType data_type, void* p_data, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +

    # Implied p_step = null, p_step_fast = null, format = null, flags = 0
    bool ImGui_InputScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components) except +
    bool ImGui_InputScalarNEx(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +

    # Widgets: Input with Keyboard
    # - If you want to use InputText() with std::string or any custom dynamic string type, see misc/cpp/imgui_stdlib.h and comments in imgui_demo.cpp.
    # - Most of the ImGuiInputTextFlags flags are only useful for InputText() and not for InputFloatX, InputIntX, InputDouble etc.
    # Implied callback = null, user_data = null
    bool ImGui_InputText(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags) except +
    bool ImGui_InputTextEx(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +

    # Implied size = imvec2(0, 0), flags = 0, callback = null, user_data = null
    bool ImGui_InputTextMultiline(const char* label, char* buf, size_t buf_size) except +
    bool ImGui_InputTextMultilineEx(const char* label, char* buf, size_t buf_size, ImVec2 size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +

    # Implied callback = null, user_data = null
    bool ImGui_InputTextWithHint(const char* label, const char* hint, char* buf, size_t buf_size, ImGuiInputTextFlags flags) except +
    bool ImGui_InputTextWithHintEx(const char* label, const char* hint, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +

    # Flexible button behavior without the visuals, frequently useful to build custom behaviors using the public api (along with isitemactive, isitemhovered, etc.)
    bool ImGui_InvisibleButton(const char* str_id, ImVec2 size, ImGuiButtonFlags flags) except +

    # Is any item active?
    bool ImGui_IsAnyItemActive() except +

    # Is any item focused?
    bool ImGui_IsAnyItemFocused() except +

    # Is any item hovered?
    bool ImGui_IsAnyItemHovered() except +

    # [will obsolete] is any mouse button held? this was designed for backends, but prefer having backend maintain a mask of held mouse buttons, because upcoming input queue system will make this invalid.
    bool ImGui_IsAnyMouseDown() except +

    # Was the last item just made active (item was previously inactive).
    bool ImGui_IsItemActivated() except +

    # Is the last item active? (e.g. button being held, text field being edited. this will continuously return true while holding mouse button on an item. items that don't interact will always return false)
    bool ImGui_IsItemActive() except +

    # Implied mouse_button = 0
    bool ImGui_IsItemClicked() except +

    # Is the last item hovered and mouse clicked on? (**)  == ismouseclicked(mouse_button) && isitemhovered()important. (**) this is not equivalent to the behavior of e.g. button(). read comments in function definition.
    bool ImGui_IsItemClickedEx(ImGuiMouseButton mouse_button) except +

    # Was the last item just made inactive (item was previously active). useful for undo/redo patterns with widgets that require continuous editing.
    bool ImGui_IsItemDeactivated() except +

    # Was the last item just made inactive and made a value change when it was active? (e.g. slider/drag moved). useful for undo/redo patterns with widgets that require continuous editing. note that you may get false positives (some widgets such as combo()/listbox()/selectable() will return true even when clicking an already selected item).
    bool ImGui_IsItemDeactivatedAfterEdit() except +

    # Did the last item modify its underlying value this frame? or was pressed? this is generally the same as the 'bool' return value of many widgets.
    bool ImGui_IsItemEdited() except +

    # Is the last item focused for keyboard/gamepad navigation?
    bool ImGui_IsItemFocused() except +

    # Item/Widgets Utilities and Query Functions
    # - Most of the functions are referring to the previous Item that has been submitted.
    # - See Demo Window under "Widgets->Querying Status" for an interactive visualization of most of those functions.
    # Is the last item hovered? (and usable, aka not blocked by a popup, etc.). see imguihoveredflags for more options.
    bool ImGui_IsItemHovered(ImGuiHoveredFlags flags) except +

    # Was the last item open state toggled? set by treenode().
    bool ImGui_IsItemToggledOpen() except +

    # Is the last item visible? (items may be out of sight because of clipping/scrolling)
    bool ImGui_IsItemVisible() except +

    # Inputs Utilities: Keyboard/Mouse/Gamepad
    # - the ImGuiKey enum contains all possible keyboard, mouse and gamepad inputs (e.g. ImGuiKey_A, ImGuiKey_MouseLeft, ImGuiKey_GamepadDpadUp...).
    # - before v1.87, we used ImGuiKey to carry native/user indices as defined by each backends. About use of those legacy ImGuiKey values:
    # - without IMGUI_DISABLE_OBSOLETE_KEYIO (legacy support): you can still use your legacy native/user indices (< 512) according to how your backend/engine stored them in io.KeysDown[], but need to cast them to ImGuiKey.
    # - with    IMGUI_DISABLE_OBSOLETE_KEYIO (this is the way forward): any use of ImGuiKey will assert with key < 512. GetKeyIndex() is pass-through and therefore deprecated (gone if IMGUI_DISABLE_OBSOLETE_KEYIO is defined).
    # Is key being held.
    bool ImGui_IsKeyDown(ImGuiKey key) except +

    # Implied repeat = true
    bool ImGui_IsKeyPressed(ImGuiKey key) except +

    # Was key pressed (went from !down to down)? if repeat=true, uses io.keyrepeatdelay / keyrepeatrate
    bool ImGui_IsKeyPressedEx(ImGuiKey key, bool repeat) except +

    # Was key released (went from down to !down)?
    bool ImGui_IsKeyReleased(ImGuiKey key) except +

    # Implied repeat = false
    bool ImGui_IsMouseClicked(ImGuiMouseButton button) except +

    # Did mouse button clicked? (went from !down to down). same as getmouseclickedcount() == 1.
    bool ImGui_IsMouseClickedEx(ImGuiMouseButton button, bool repeat) except +

    # Did mouse button double-clicked? same as getmouseclickedcount() == 2. (note that a double-click will also report ismouseclicked() == true)
    bool ImGui_IsMouseDoubleClicked(ImGuiMouseButton button) except +

    # Inputs Utilities: Mouse specific
    # - To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
    # - You can also use regular integer: it is forever guaranteed that 0=Left, 1=Right, 2=Middle.
    # - Dragging operations are only reported after mouse has moved a certain distance away from the initial clicking position (see 'lock_threshold' and 'io.MouseDraggingThreshold')
    # Is mouse button held?
    bool ImGui_IsMouseDown(ImGuiMouseButton button) except +

    # Is mouse dragging? (if lock_threshold < -1.0f, uses io.mousedraggingthreshold)
    bool ImGui_IsMouseDragging(ImGuiMouseButton button, float lock_threshold) except +

    # Implied clip = true
    bool ImGui_IsMouseHoveringRect(ImVec2 r_min, ImVec2 r_max) except +

    # Is mouse hovering given bounding rect (in screen space). clipped by current clipping settings, but disregarding of other consideration of focus/window ordering/popup-block.
    bool ImGui_IsMouseHoveringRectEx(ImVec2 r_min, ImVec2 r_max, bool clip) except +

    # By convention we use (-flt_max,-flt_max) to denote that there is no mouse available
    bool ImGui_IsMousePosValid(const ImVec2* mouse_pos) except +

    # Did mouse button released? (went from down to !down)
    bool ImGui_IsMouseReleased(ImGuiMouseButton button) except +

    # Popups: query functions
    # - IsPopupOpen(): return true if the popup is open at the current BeginPopup() level of the popup stack.
    # - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
    # - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
    # Return true if the popup is open.
    bool ImGui_IsPopupOpen(const char* str_id, ImGuiPopupFlags flags) except +

    # Test if rectangle (in screen space) is visible / not clipped. to perform coarse clipping on user's side.
    bool ImGui_IsRectVisible(ImVec2 rect_min, ImVec2 rect_max) except +

    # Miscellaneous Utilities
    # Test if rectangle (of given size, starting from cursor position) is visible / not clipped.
    bool ImGui_IsRectVisibleBySize(ImVec2 size) except +

    # Windows Utilities
    # - 'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.
    bool ImGui_IsWindowAppearing() except +
    bool ImGui_IsWindowCollapsed() except +

    # Is current window docked into another window?
    bool ImGui_IsWindowDocked() except +

    # Is current window focused? or its root/child, depending on flags. see flags for options.
    bool ImGui_IsWindowFocused(ImGuiFocusedFlags flags) except +

    # Is current window hovered (and typically: not blocked by a popup/modal)? see flags for options. nb: if you are trying to check whether your mouse should be dispatched to imgui or to your app, you should use the 'io.wantcapturemouse' boolean for that! please read the faq!
    bool ImGui_IsWindowHovered(ImGuiHoveredFlags flags) except +

    # Display text+label aligned the same way as value+label widgets
    void ImGui_LabelText(const char* label, const char* fmt) except +
    void ImGui_LabelTextV(const char* label, const char* fmt) except +
    bool ImGui_ListBox(const char* label, int* current_item, const char** items, int items_count, int height_in_items) except +

    # Implied height_in_items = -1
    bool ImGui_ListBoxCallback(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count) except +
    bool ImGui_ListBoxCallbackEx(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int height_in_items) except +

    # Settings/.Ini Utilities
    # - The disk functions are automatically called if io.IniFilename != NULL (default is "imgui.ini").
    # - Set io.IniFilename to NULL to load/save manually. Read io.WantSaveIniSettings description about handling .ini saving manually.
    # - Important: default value "imgui.ini" is relative to current working dir! Most apps will want to lock this to an absolute path (e.g. same path as executables).
    # Call after createcontext() and before the first call to newframe(). newframe() automatically calls loadinisettingsfromdisk(io.inifilename).
    void ImGui_LoadIniSettingsFromDisk(const char* ini_filename) except +

    # Call after createcontext() and before the first call to newframe() to provide .ini data from your own data source.
    void ImGui_LoadIniSettingsFromMemory(const char* ini_data, size_t ini_size) except +

    # Helper to display buttons for logging to tty/file/clipboard
    void ImGui_LogButtons() except +

    # Stop logging (close file, etc.)
    void ImGui_LogFinish() except +

    # Pass text data straight to log (without being displayed)
    void ImGui_LogText(const char* fmt) except +
    void ImGui_LogTextV(const char* fmt) except +

    # Start logging to os clipboard
    void ImGui_LogToClipboard(int auto_open_depth) except +

    # Start logging to file
    void ImGui_LogToFile(int auto_open_depth, const char* filename) except +

    # Logging/Capture
    # - All text output from the interface can be captured into tty/file/clipboard. By default, tree nodes are automatically opened during logging.
    # Start logging to tty (stdout)
    void ImGui_LogToTTY(int auto_open_depth) except +
    void* ImGui_MemAlloc(size_t size) except +
    void ImGui_MemFree(void* ptr) except +

    # Implied shortcut = null, selected = false, enabled = true
    bool ImGui_MenuItem(const char* label) except +

    # Return true when activated + toggle (*p_selected) if p_selected != null
    bool ImGui_MenuItemBoolPtr(const char* label, const char* shortcut, bool* p_selected, bool enabled) except +

    # Return true when activated.
    bool ImGui_MenuItemEx(const char* label, const char* shortcut, bool selected, bool enabled) except +

    # Start a new dear imgui frame, you can submit any command from this point until render()/endframe().
    void ImGui_NewFrame() except +

    # Undo a sameline() or force a new line when in a horizontal-layout context.
    void ImGui_NewLine() except +

    # Next column, defaults to current row or next row if the current row is finished
    void ImGui_NextColumn() except +

    # Popups: open/close functions
    # - OpenPopup(): set popup state to open. ImGuiPopupFlags are available for opening options.
    # - If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
    # - CloseCurrentPopup(): use inside the BeginPopup()/EndPopup() scope to close manually.
    # - CloseCurrentPopup() is called by default by Selectable()/MenuItem() when activated (FIXME: need some options).
    # - Use ImGuiPopupFlags_NoOpenOverExistingPopup to avoid opening a popup if there's already one at the same level. This is equivalent to e.g. testing for !IsAnyPopupOpen() prior to OpenPopup().
    # - Use IsWindowAppearing() after BeginPopup() to tell if a window just opened.
    # - IMPORTANT: Notice that for OpenPopupOnItemClick() we exceptionally default flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter
    # Call to mark popup as open (don't call every frame!).
    void ImGui_OpenPopup(const char* str_id, ImGuiPopupFlags popup_flags) except +

    # Id overload to facilitate calling from nested stacks
    void ImGui_OpenPopupID(ImGuiID id_, ImGuiPopupFlags popup_flags) except +

    # Helper to open popup when clicked on last item. default to imguipopupflags_mousebuttonright == 1. (note: actually triggers on the mouse _released_ event to be consistent with popup behaviors)
    void ImGui_OpenPopupOnItemClick(const char* str_id, ImGuiPopupFlags popup_flags) except +

    # Implied values_offset = 0, overlay_text = null, scale_min = flt_max, scale_max = flt_max, graph_size = imvec2(0, 0), stride = sizeof(float)
    void ImGui_PlotHistogram(const char* label, const float* values, int values_count) except +

    # Implied values_offset = 0, overlay_text = null, scale_min = flt_max, scale_max = flt_max, graph_size = imvec2(0, 0)
    void ImGui_PlotHistogramCallback(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count) except +
    void ImGui_PlotHistogramCallbackEx(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void ImGui_PlotHistogramEx(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +

    # Widgets: Data Plotting
    # - Consider using ImPlot (https://github.com/epezent/implot) which is much better!
    # Implied values_offset = 0, overlay_text = null, scale_min = flt_max, scale_max = flt_max, graph_size = imvec2(0, 0), stride = sizeof(float)
    void ImGui_PlotLines(const char* label, const float* values, int values_count) except +

    # Implied values_offset = 0, overlay_text = null, scale_min = flt_max, scale_max = flt_max, graph_size = imvec2(0, 0)
    void ImGui_PlotLinesCallback(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count) except +
    void ImGui_PlotLinesCallbackEx(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void ImGui_PlotLinesEx(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +
    void ImGui_PopButtonRepeat() except +
    void ImGui_PopClipRect() except +
    void ImGui_PopFont() except +

    # Pop from the id stack.
    void ImGui_PopID() except +
    void ImGui_PopItemWidth() except +

    # Implied count = 1
    void ImGui_PopStyleColor() except +
    void ImGui_PopStyleColorEx(int count) except +

    # Implied count = 1
    void ImGui_PopStyleVar() except +
    void ImGui_PopStyleVarEx(int count) except +
    void ImGui_PopTabStop() except +
    void ImGui_PopTextWrapPos() except +
    void ImGui_ProgressBar(float fraction, ImVec2 size_arg, const char* overlay) except +

    # In 'repeat' mode, button*() functions return repeated true in a typematic manner (using io.keyrepeatdelay/io.keyrepeatrate setting). note that you can call isitemactive() after any button() to tell if the button is held in the current frame.
    void ImGui_PushButtonRepeat(bool repeat) except +

    # Clipping
    # - Mouse hovering is affected by ImGui::PushClipRect() calls, unlike direct calls to ImDrawList::PushClipRect() which are render only.
    void ImGui_PushClipRect(ImVec2 clip_rect_min, ImVec2 clip_rect_max, bool intersect_with_current_clip_rect) except +

    # Parameters stacks (shared)
    # Use null as a shortcut to push default font
    void ImGui_PushFont(ImFont* font) except +

    # ID stack/scopes
    # Read the FAQ (docs/FAQ.md or http://dearimgui.com/faq) for more details about how ID are handled in dear imgui.
    # - Those questions are answered and impacted by understanding of the ID stack system:
    # - "Q: Why is my widget not reacting when I click on it?"
    # - "Q: How can I have widgets with an empty label?"
    # - "Q: How can I have multiple widgets with the same label?"
    # - Short version: ID are hashes of the entire ID stack. If you are creating widgets in a loop you most likely
    # want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them.
    # - You can also use the "Label##foobar" syntax within widget label to distinguish them from each others.
    # - In this header file we use the "label"/"name" terminology to denote a string that will be displayed + used as an ID,
    # whereas "str_id" denote a string that is only used as an ID and not normally displayed.
    # Push string into the id stack (will hash string).
    void ImGui_PushID(const char* str_id) except +

    # Push integer into the id stack (will hash integer).
    void ImGui_PushIDInt(int int_id) except +

    # Push pointer into the id stack (will hash pointer).
    void ImGui_PushIDPtr(const void* ptr_id) except +

    # Push string into the id stack (will hash string).
    void ImGui_PushIDStr(const char* str_id_begin, const char* str_id_end) except +

    # Parameters stacks (current window)
    # Push width of items for common large 'item+label' widgets. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -flt_min always align width to the right side).
    void ImGui_PushItemWidth(float item_width) except +

    # Modify a style color. always use this if you modify the style after newframe().
    void ImGui_PushStyleColor(ImGuiCol idx, ImU32 col) except +
    void ImGui_PushStyleColorImVec4(ImGuiCol idx, ImVec4 col) except +

    # Modify a style float variable. always use this if you modify the style after newframe().
    void ImGui_PushStyleVar(ImGuiStyleVar idx, float val) except +

    # Modify a style imvec2 variable. always use this if you modify the style after newframe().
    void ImGui_PushStyleVarImVec2(ImGuiStyleVar idx, ImVec2 val) except +

    # == tab stop enable. allow focusing using tab/shift-tab, enabled by default but you can disable it for certain widgets
    void ImGui_PushTabStop(bool tab_stop) except +

    # Push word-wrapping position for text*() commands. < 0.0f: no wrapping; 0.0f: wrap to end of window (or column); > 0.0f: wrap at 'wrap_pos_x' position in window local space
    void ImGui_PushTextWrapPos(float wrap_local_pos_x) except +

    # Use with e.g. if (radiobutton('one', my_value==1)) { my_value = 1; }
    bool ImGui_RadioButton(const char* label, bool active) except +

    # Shortcut to handle the above pattern when value is an integer
    bool ImGui_RadioButtonIntPtr(const char* label, int* v, int v_button) except +

    # Ends the dear imgui frame, finalize the draw data. you can then get call getdrawdata().
    void ImGui_Render() except +

    # Implied platform_render_arg = null, renderer_render_arg = null
    void ImGui_RenderPlatformWindowsDefault() except +

    # Call in main loop. will call renderwindow/swapbuffers platform functions for each secondary viewport which doesn't have the imguiviewportflags_minimized flag set. may be reimplemented by user for custom rendering needs.
    void ImGui_RenderPlatformWindowsDefaultEx(void* platform_render_arg, void* renderer_render_arg) except +

    # Implied button = 0
    void ImGui_ResetMouseDragDelta() except +

    # 
    void ImGui_ResetMouseDragDeltaEx(ImGuiMouseButton button) except +

    # Implied offset_from_start_x = 0.0f, spacing = -1.0f
    void ImGui_SameLine() except +

    # Call between widgets or groups to layout them horizontally. x position given in window coordinates.
    void ImGui_SameLineEx(float offset_from_start_x, float spacing) except +

    # This is automatically called (if io.inifilename is not empty) a few seconds after any modification that should be reflected in the .ini file (and also by destroycontext).
    void ImGui_SaveIniSettingsToDisk(const char* ini_filename) except +

    # Return a zero-terminated string with the .ini data which you can save by your own mean. call when io.wantsaveinisettings is set, then save data by your own mean and clear io.wantsaveinisettings.
    const char* ImGui_SaveIniSettingsToMemory(size_t* out_ini_size) except +

    # Widgets: Selectables
    # - A selectable highlights when hovered, and can display another color when selected.
    # - Neighbors selectable extend their highlight bounds in order to leave no gap between them. This is so a series of selected Selectable appear contiguous.
    # Implied selected = false, flags = 0, size = imvec2(0, 0)
    bool ImGui_Selectable(const char* label) except +

    # Implied size = imvec2(0, 0)
    bool ImGui_SelectableBoolPtr(const char* label, bool* p_selected, ImGuiSelectableFlags flags) except +

    # 'bool* p_selected' point to the selection state (read-write), as a convenient helper.
    bool ImGui_SelectableBoolPtrEx(const char* label, bool* p_selected, ImGuiSelectableFlags flags, ImVec2 size) except +

    # 'bool selected' carry the selection state (read-only). selectable() is clicked is returns true so you can modify your selection state. size.x==0.0: use remaining width, size.x>0.0: specify width. size.y==0.0: use label height, size.y>0.0: specify height
    bool ImGui_SelectableEx(const char* label, bool selected, ImGuiSelectableFlags flags, ImVec2 size) except +

    # Cursor / Layout
    # - By "cursor" we mean the current output position.
    # - The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
    # - You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
    # - Attention! We currently have inconsistencies between window-local and absolute positions we will aim to fix with future API:
    # Window-local coordinates:   SameLine(), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), GetContentRegionMax(), GetWindowContentRegion*(), PushTextWrapPos()
    # Absolute coordinate:        GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions.
    # Separator, generally horizontal. inside a menu bar or in horizontal layout mode, this becomes a vertical separator.
    void ImGui_Separator() except +

    # Currently: formatted text with an horizontal line
    void ImGui_SeparatorText(const char* label) except +

    # Memory Allocators
    # - Those functions are not reliant on the current context.
    # - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
    # for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for more details.
    void ImGui_SetAllocatorFunctions(ImGuiMemAllocFunc alloc_func, ImGuiMemFreeFunc free_func, void* user_data) except +
    void ImGui_SetClipboardText(const char* text) except +

    # Initialize current options (generally on application startup) if you want to select a default format, picker type, etc. user will be able to change many settings, unless you pass the _nooptions flag to your calls.
    void ImGui_SetColorEditOptions(ImGuiColorEditFlags flags) except +

    # Set position of column line (in pixels, from the left side of the contents region). pass -1 to use current column
    void ImGui_SetColumnOffset(int column_index, float offset_x) except +

    # Set column width (in pixels). pass -1 to use current column
    void ImGui_SetColumnWidth(int column_index, float width) except +
    void ImGui_SetCurrentContext(ImGuiContext* ctx) except +

    # Are using the main, absolute coordinate system.
    void ImGui_SetCursorPos(ImVec2 local_pos) except +

    # Getwindowpos() + getcursorpos() == getcursorscreenpos() etc.)
    void ImGui_SetCursorPosX(float local_x) except +

    # 
    void ImGui_SetCursorPosY(float local_y) except +

    # Cursor position in absolute coordinates
    void ImGui_SetCursorScreenPos(ImVec2 pos) except +

    # Type is a user defined string of maximum 32 characters. strings starting with '_' are reserved for dear imgui internal types. data is copied and held by imgui. return true when payload has been accepted.
    bool ImGui_SetDragDropPayload(const char* type_, const void* data, size_t sz, ImGuiCond cond) except +

    # Allow last item to be overlapped by a subsequent item. sometimes useful with invisible buttons, selectables, etc. to catch unused area.
    void ImGui_SetItemAllowOverlap() except +

    # Focus, Activation
    # - Prefer using "SetItemDefaultFocus()" over "if (IsWindowAppearing()) SetScrollHereY()" when applicable to signify "this is the default item"
    # Make last item the default focused item of a window.
    void ImGui_SetItemDefaultFocus() except +

    # Implied offset = 0
    void ImGui_SetKeyboardFocusHere() except +

    # Focus keyboard on the next widget. use positive 'offset' to access sub components of a multiple component widget. use -1 to access previous widget.
    void ImGui_SetKeyboardFocusHereEx(int offset) except +

    # Set desired mouse cursor shape
    void ImGui_SetMouseCursor(ImGuiMouseCursor cursor_type) except +

    # Override io.wantcapturekeyboard flag next frame (said flag is left for your application to handle, typically when true it instructs your app to ignore inputs). e.g. force capture keyboard when your widget is being hovered. this is equivalent to setting 'io.wantcapturekeyboard = want_capture_keyboard'; after the next newframe() call.
    void ImGui_SetNextFrameWantCaptureKeyboard(bool want_capture_keyboard) except +

    # Override io.wantcapturemouse flag next frame (said flag is left for your application to handle, typical when true it instucts your app to ignore inputs). this is equivalent to setting 'io.wantcapturemouse = want_capture_mouse;' after the next newframe() call.
    void ImGui_SetNextFrameWantCaptureMouse(bool want_capture_mouse) except +

    # Set next treenode/collapsingheader open state.
    void ImGui_SetNextItemOpen(bool is_open, ImGuiCond cond) except +

    # Set width of the _next_ common large 'item+label' widget. >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -flt_min always align width to the right side)
    void ImGui_SetNextItemWidth(float item_width) except +

    # Set next window background color alpha. helper to easily override the alpha component of imguicol_windowbg/childbg/popupbg. you may also use imguiwindowflags_nobackground.
    void ImGui_SetNextWindowBgAlpha(float alpha) except +

    # Set next window class (control docking compatibility + provide hints to platform backend via custom viewport flags and platform parent/child relationship)
    void ImGui_SetNextWindowClass(const ImGuiWindowClass* window_class) except +

    # Set next window collapsed state. call before begin()
    void ImGui_SetNextWindowCollapsed(bool collapsed, ImGuiCond cond) except +

    # Set next window content size (~ scrollable client area, which enforce the range of scrollbars). not including window decorations (title bar, menu bar, etc.) nor windowpadding. set an axis to 0.0f to leave it automatic. call before begin()
    void ImGui_SetNextWindowContentSize(ImVec2 size) except +

    # Set next window dock id
    void ImGui_SetNextWindowDockID(ImGuiID dock_id, ImGuiCond cond) except +

    # Set next window to be focused / top-most. call before begin()
    void ImGui_SetNextWindowFocus() except +

    # Window manipulation
    # - Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
    # Implied pivot = imvec2(0, 0)
    void ImGui_SetNextWindowPos(ImVec2 pos, ImGuiCond cond) except +

    # Set next window position. call before begin(). use pivot=(0.5f,0.5f) to center on given point, etc.
    void ImGui_SetNextWindowPosEx(ImVec2 pos, ImGuiCond cond, ImVec2 pivot) except +

    # Set next window scrolling value (use < 0.0f to not affect a given axis).
    void ImGui_SetNextWindowScroll(ImVec2 scroll) except +

    # Set next window size. set axis to 0.0f to force an auto-fit on this axis. call before begin()
    void ImGui_SetNextWindowSize(ImVec2 size, ImGuiCond cond) except +

    # Set next window size limits. use -1,-1 on either x/y axis to preserve the current size. sizes will be rounded down. use callback to apply non-trivial programmatic constraints.
    void ImGui_SetNextWindowSizeConstraints(ImVec2 size_min, ImVec2 size_max, ImGuiSizeCallback custom_callback, void* custom_callback_data) except +

    # Set next window viewport
    void ImGui_SetNextWindowViewport(ImGuiID viewport_id) except +

    # Adjust scrolling amount to make given position visible. generally getcursorstartpos() + offset to compute a valid position.
    void ImGui_SetScrollFromPosX(float local_x, float center_x_ratio) except +

    # Adjust scrolling amount to make given position visible. generally getcursorstartpos() + offset to compute a valid position.
    void ImGui_SetScrollFromPosY(float local_y, float center_y_ratio) except +

    # Adjust scrolling amount to make current cursor position visible. center_x_ratio=0.0: left, 0.5: center, 1.0: right. when using to make a 'default/current item' visible, consider using setitemdefaultfocus() instead.
    void ImGui_SetScrollHereX(float center_x_ratio) except +

    # Adjust scrolling amount to make current cursor position visible. center_y_ratio=0.0: top, 0.5: center, 1.0: bottom. when using to make a 'default/current item' visible, consider using setitemdefaultfocus() instead.
    void ImGui_SetScrollHereY(float center_y_ratio) except +

    # Set scrolling amount [0 .. getscrollmaxx()]
    void ImGui_SetScrollX(float scroll_x) except +

    # Set scrolling amount [0 .. getscrollmaxy()]
    void ImGui_SetScrollY(float scroll_y) except +

    # Replace current window storage with our own (if you want to manipulate it yourself, typically clear subsection of it)
    void ImGui_SetStateStorage(ImGuiStorage* storage) except +

    # Notify tabbar or docking system of a closed tab/window ahead (useful to reduce visual flicker on reorderable tab bars). for tab-bar: call after begintabbar() and before tab submissions. otherwise call with a window name.
    void ImGui_SetTabItemClosed(const char* tab_or_docked_window_label) except +

    # Set a text-only tooltip, typically use with imgui::isitemhovered(). override any previous call to settooltip().
    void ImGui_SetTooltip(const char* fmt) except +
    void ImGui_SetTooltipV(const char* fmt) except +

    # (not recommended) set current window collapsed state. prefer using setnextwindowcollapsed().
    void ImGui_SetWindowCollapsed(bool collapsed, ImGuiCond cond) except +

    # Set named window collapsed state
    void ImGui_SetWindowCollapsedStr(const char* name, bool collapsed, ImGuiCond cond) except +

    # (not recommended) set current window to be focused / top-most. prefer using setnextwindowfocus().
    void ImGui_SetWindowFocus() except +

    # Set named window to be focused / top-most. use null to remove focus.
    void ImGui_SetWindowFocusStr(const char* name) except +

    # [obsolete] set font scale. adjust io.fontglobalscale if you want to scale all windows. this is an old api! for correct scaling, prefer to reload font + rebuild imfontatlas + call style.scaleallsizes().
    void ImGui_SetWindowFontScale(float scale) except +

    # (not recommended) set current window position - call within begin()/end(). prefer using setnextwindowpos(), as this may incur tearing and side-effects.
    void ImGui_SetWindowPos(ImVec2 pos, ImGuiCond cond) except +

    # Set named window position.
    void ImGui_SetWindowPosStr(const char* name, ImVec2 pos, ImGuiCond cond) except +

    # (not recommended) set current window size - call within begin()/end(). set to imvec2(0, 0) to force an auto-fit. prefer using setnextwindowsize(), as this may incur tearing and minor side-effects.
    void ImGui_SetWindowSize(ImVec2 size, ImGuiCond cond) except +

    # Set named window size. set axis to 0.0f to force an auto-fit on this axis.
    void ImGui_SetWindowSizeStr(const char* name, ImVec2 size, ImGuiCond cond) except +

    # Create about window. display dear imgui version, credits and build/system information.
    void ImGui_ShowAboutWindow(bool* p_open) except +

    # Create debug log window. display a simplified log of important dear imgui events.
    void ImGui_ShowDebugLogWindow(bool* p_open) except +

    # Demo, Debug, Information
    # Create demo window. demonstrate most imgui features. call this to learn about the library! try to make it always available in your application!
    void ImGui_ShowDemoWindow(bool* p_open) except +

    # Add font selector block (not a window), essentially a combo listing the loaded fonts.
    void ImGui_ShowFontSelector(const char* label) except +

    # Create metrics/debugger window. display dear imgui internals: windows, draw commands, various internal state, etc.
    void ImGui_ShowMetricsWindow(bool* p_open) except +

    # Create stack tool window. hover items with mouse to query information about the source of their unique id.
    void ImGui_ShowStackToolWindow(bool* p_open) except +

    # Add style editor block (not a window). you can pass in a reference imguistyle structure to compare to, revert to and save to (else it uses the default style)
    void ImGui_ShowStyleEditor(ImGuiStyle* ref) except +

    # Add style selector block (not a window), essentially a combo listing the default styles.
    bool ImGui_ShowStyleSelector(const char* label) except +

    # Add basic help/info block (not a window): how to manipulate imgui as an end-user (mouse/keyboard controls).
    void ImGui_ShowUserGuide() except +

    # Implied v_degrees_min = -360.0f, v_degrees_max = +360.0f, format = '%.0f deg', flags = 0
    bool ImGui_SliderAngle(const char* label, float* v_rad) except +
    bool ImGui_SliderAngleEx(const char* label, float* v_rad, float v_degrees_min, float v_degrees_max, const char* format_, ImGuiSliderFlags flags) except +

    # Widgets: Regular Sliders
    # - CTRL+Click on any slider to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
    # - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
    # - Format string may also be set to NULL or use the default format ("%f" or "%d").
    # - Legacy: Pre-1.78 there are SliderXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
    # If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
    # Implied format = '%.3f', flags = 0
    bool ImGui_SliderFloat(const char* label, float* v, float v_min, float v_max) except +

    # Implied format = '%.3f', flags = 0
    bool ImGui_SliderFloat2(const char* label, float* v, float v_min, float v_max) except +
    bool ImGui_SliderFloat2Ex(const char* label, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied format = '%.3f', flags = 0
    bool ImGui_SliderFloat3(const char* label, float* v, float v_min, float v_max) except +
    bool ImGui_SliderFloat3Ex(const char* label, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied format = '%.3f', flags = 0
    bool ImGui_SliderFloat4(const char* label, float* v, float v_min, float v_max) except +
    bool ImGui_SliderFloat4Ex(const char* label, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Adjust format to decorate the value with a prefix or a suffix for in-slider labels or unit display.
    bool ImGui_SliderFloatEx(const char* label, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied format = '%d', flags = 0
    bool ImGui_SliderInt(const char* label, int* v, int v_min, int v_max) except +

    # Implied format = '%d', flags = 0
    bool ImGui_SliderInt2(const char* label, int* v, int v_min, int v_max) except +
    bool ImGui_SliderInt2Ex(const char* label, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied format = '%d', flags = 0
    bool ImGui_SliderInt3(const char* label, int* v, int v_min, int v_max) except +
    bool ImGui_SliderInt3Ex(const char* label, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied format = '%d', flags = 0
    bool ImGui_SliderInt4(const char* label, int* v, int v_min, int v_max) except +
    bool ImGui_SliderInt4Ex(const char* label, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderIntEx(const char* label, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied format = null, flags = 0
    bool ImGui_SliderScalar(const char* label, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max) except +
    bool ImGui_SliderScalarEx(const char* label, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied format = null, flags = 0
    bool ImGui_SliderScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_min, const void* p_max) except +
    bool ImGui_SliderScalarNEx(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    # Button with framepadding=(0,0) to easily embed within text
    bool ImGui_SmallButton(const char* label) except +

    # Add vertical spacing.
    void ImGui_Spacing() except +

    # Classic imgui style
    void ImGui_StyleColorsClassic(ImGuiStyle* dst) except +

    # Styles
    # New, recommended style (default)
    void ImGui_StyleColorsDark(ImGuiStyle* dst) except +

    # Best used with borders and a custom, thicker font
    void ImGui_StyleColorsLight(ImGuiStyle* dst) except +

    # Create a tab behaving like a button. return true when clicked. cannot be selected in the tab bar.
    bool ImGui_TabItemButton(const char* label, ImGuiTabItemFlags flags) except +

    # Return number of columns (value passed to begintable)
    int ImGui_TableGetColumnCount() except +

    # Return column flags so you can query their enabled/visible/sorted/hovered status flags. pass -1 to use current column.
    ImGuiTableColumnFlags ImGui_TableGetColumnFlags(int column_n) except +

    # Return current column index.
    int ImGui_TableGetColumnIndex() except +

    # Return '' if column didn't have a name declared by tablesetupcolumn(). pass -1 to use current column.
    const char* ImGui_TableGetColumnName(int column_n) except +

    # Return current row index.
    int ImGui_TableGetRowIndex() except +

    # Tables: Sorting & Miscellaneous functions
    # - Sorting: call TableGetSortSpecs() to retrieve latest sort specs for the table. NULL when not sorting.
    # When 'sort_specs->SpecsDirty == true' you should sort your data. It will be true when sorting specs have
    # changed since last call, or the first time. Make sure to set 'SpecsDirty = false' after sorting,
    # else you may wastefully sort your data every frame!
    # - Functions args 'int column_n' treat the default value of -1 as the same as passing the current column index.
    # Get latest sort specs for the table (null if not sorting).  lifetime: don't hold on this pointer over multiple frames or past any subsequent call to begintable().
    ImGuiTableSortSpecs* ImGui_TableGetSortSpecs() except +

    # Submit one header cell manually (rarely used)
    void ImGui_TableHeader(const char* label) except +

    # Submit all headers cells based on data provided to tablesetupcolumn() + submit context menu
    void ImGui_TableHeadersRow() except +

    # Append into the next column (or first column of next row if currently in last column). return true when column is visible.
    bool ImGui_TableNextColumn() except +

    # Implied row_flags = 0, min_row_height = 0.0f
    void ImGui_TableNextRow() except +

    # Append into the first cell of a new row.
    void ImGui_TableNextRowEx(ImGuiTableRowFlags row_flags, float min_row_height) except +

    # Change the color of a cell, row, or column. see imguitablebgtarget_ flags for details.
    void ImGui_TableSetBgColor(ImGuiTableBgTarget target, ImU32 color, int column_n) except +

    # Change user accessible enabled/disabled state of a column. set to false to hide the column. user can use the context menu to change this themselves (right-click in headers, or right-click in columns body with imguitableflags_contextmenuinbody)
    void ImGui_TableSetColumnEnabled(int column_n, bool v) except +

    # Append into the specified column. return true when column is visible.
    bool ImGui_TableSetColumnIndex(int column_n) except +

    # Tables: Headers & Columns declaration
    # - Use TableSetupColumn() to specify label, resizing policy, default width/weight, id, various other flags etc.
    # - Use TableHeadersRow() to create a header row and automatically submit a TableHeader() for each column.
    # Headers are required to perform: reordering, sorting, and opening the context menu.
    # The context menu can also be made available in columns body using ImGuiTableFlags_ContextMenuInBody.
    # - You may manually submit headers using TableNextRow() + TableHeader() calls, but this is only useful in
    # some advanced use cases (e.g. adding custom widgets in header row).
    # - Use TableSetupScrollFreeze() to lock columns/rows so they stay visible when scrolled.
    # Implied init_width_or_weight = 0.0f, user_id = 0
    void ImGui_TableSetupColumn(const char* label, ImGuiTableColumnFlags flags) except +
    void ImGui_TableSetupColumnEx(const char* label, ImGuiTableColumnFlags flags, float init_width_or_weight, ImGuiID user_id) except +

    # Lock columns/rows so they stay visible when scrolled.
    void ImGui_TableSetupScrollFreeze(int cols, int rows) except +

    # Formatted text
    void ImGui_Text(const char* fmt) except +

    # Shortcut for pushstylecolor(imguicol_text, col); text(fmt, ...); popstylecolor();
    void ImGui_TextColored(ImVec4 col, const char* fmt) except +
    void ImGui_TextColoredV(ImVec4 col, const char* fmt) except +

    # Shortcut for pushstylecolor(imguicol_text, style.colors[imguicol_textdisabled]); text(fmt, ...); popstylecolor();
    void ImGui_TextDisabled(const char* fmt) except +
    void ImGui_TextDisabledV(const char* fmt) except +

    # Widgets: Text
    # Implied text_end = null
    void ImGui_TextUnformatted(const char* text) except +

    # Raw text without formatting. roughly equivalent to text('%s', text) but: a) doesn't require null terminated string if 'text_end' is specified, b) it's faster, no memory copy is done, no buffer size limits, recommended for long chunks of text.
    void ImGui_TextUnformattedEx(const char* text, const char* text_end) except +
    void ImGui_TextV(const char* fmt) except +

    # Shortcut for pushtextwrappos(0.0f); text(fmt, ...); poptextwrappos();. note that this won't work on an auto-resizing window if there's no other widgets to extend the window width, yoy may need to set a size using setnextwindowsize().
    void ImGui_TextWrapped(const char* fmt) except +
    void ImGui_TextWrappedV(const char* fmt) except +

    # Widgets: Trees
    # - TreeNode functions return true when the node is open, in which case you need to also call TreePop() when you are finished displaying the tree node contents.
    bool ImGui_TreeNode(const char* label) except +
    bool ImGui_TreeNodeEx(const char* label, ImGuiTreeNodeFlags flags) except +
    bool ImGui_TreeNodeExPtr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodeExStr(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodeExV(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodeExVPtr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt) except +

    # '
    bool ImGui_TreeNodePtr(const void* ptr_id, const char* fmt) except +

    # Helper variation to easily decorelate the id from the displayed string. read the faq about why and how to use id. to align arbitrary text at the same level as a treenode() you can use bullet().
    bool ImGui_TreeNodeStr(const char* str_id, const char* fmt) except +
    bool ImGui_TreeNodeV(const char* str_id, const char* fmt) except +
    bool ImGui_TreeNodeVPtr(const void* ptr_id, const char* fmt) except +

    # ~ unindent()+popid()
    void ImGui_TreePop() except +

    # ~ indent()+pushid(). already called by treenode() when returning true, but you can call treepush/treepop yourself if desired.
    void ImGui_TreePush(const char* str_id) except +

    # '
    void ImGui_TreePushPtr(const void* ptr_id) except +

    # Implied indent_w = 0.0f
    void ImGui_Unindent() except +

    # Move content position back to the left, by indent_w, or style.indentspacing if indent_w <= 0
    void ImGui_UnindentEx(float indent_w) except +

    # Call in main loop. will call createwindow/resizewindow/etc. platform functions for each secondary viewport, and destroywindow for each inactive viewport.
    void ImGui_UpdatePlatformWindows() except +

    # Implied format = '%.3f', flags = 0
    bool ImGui_VSliderFloat(const char* label, ImVec2 size, float* v, float v_min, float v_max) except +
    bool ImGui_VSliderFloatEx(const char* label, ImVec2 size, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied format = '%d', flags = 0
    bool ImGui_VSliderInt(const char* label, ImVec2 size, int* v, int v_min, int v_max) except +
    bool ImGui_VSliderIntEx(const char* label, ImVec2 size, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +

    # Implied format = null, flags = 0
    bool ImGui_VSliderScalar(const char* label, ImVec2 size, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max) except +
    bool ImGui_VSliderScalarEx(const char* label, ImVec2 size, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +

    # Construct a zero-size imvector<> (of any type). this is primarily useful when calling imfontglyphrangesbuilder_buildranges()
    void ImVector_Construct(void* vector) except +

    # Destruct an imvector<> (of any type). important: frees the vector memory but does not call destructors on contained objects (if they have them)
    void ImVector_Destruct(void* vector) except +

cdef extern from "imgui_impl_glfw.h":
    ctypedef struct GLFWwindow
    ctypedef struct GLFWmonitor



    ctypedef struct GLFWwindow:
        pass


    ctypedef struct GLFWmonitor:
        pass



    void ImGui_ImplGlfw_CharCallback(GLFWwindow* window, unsigned int c) except +
    void ImGui_ImplGlfw_CursorEnterCallback(GLFWwindow* window, int entered) except +
    void ImGui_ImplGlfw_CursorPosCallback(GLFWwindow* window, double x, double y) except +
    bool ImGui_ImplGlfw_InitForOpenGL(GLFWwindow* window, bool install_callbacks) except +
    bool ImGui_ImplGlfw_InitForOther(GLFWwindow* window, bool install_callbacks) except +
    bool ImGui_ImplGlfw_InitForVulkan(GLFWwindow* window, bool install_callbacks) except +
    void ImGui_ImplGlfw_InstallCallbacks(GLFWwindow* window) except +
    void ImGui_ImplGlfw_KeyCallback(GLFWwindow* window, int key, int scancode, int action, int mods) except +
    void ImGui_ImplGlfw_MonitorCallback(GLFWmonitor* monitor, int event) except +
    void ImGui_ImplGlfw_MouseButtonCallback(GLFWwindow* window, int button, int action, int mods) except +
    void ImGui_ImplGlfw_NewFrame() except +
    void ImGui_ImplGlfw_RestoreCallbacks(GLFWwindow* window) except +
    void ImGui_ImplGlfw_ScrollCallback(GLFWwindow* window, double xoffset, double yoffset) except +
    void ImGui_ImplGlfw_SetCallbacksChainForAllWindows(bool chain_for_all_windows) except +
    void ImGui_ImplGlfw_Shutdown() except +
    void ImGui_ImplGlfw_WindowFocusCallback(GLFWwindow* window, int focused) except +

cdef extern from "imgui_impl_opengl3.h":




    bool ImGui_ImplOpenGL3_CreateDeviceObjects() except +
    bool ImGui_ImplOpenGL3_CreateFontsTexture() except +
    void ImGui_ImplOpenGL3_DestroyDeviceObjects() except +
    void ImGui_ImplOpenGL3_DestroyFontsTexture() except +
    bool ImGui_ImplOpenGL3_Init(const char* glsl_version) except +
    void ImGui_ImplOpenGL3_NewFrame() except +
    void ImGui_ImplOpenGL3_RenderDrawData(ImDrawData* draw_data) except +
    void ImGui_ImplOpenGL3_Shutdown() except +

