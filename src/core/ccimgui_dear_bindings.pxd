
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

    ctypedef int ImGuiKey
    ctypedef int ImGuiCol
    ctypedef int ImGuiCond
    ctypedef int ImGuiDataType
    ctypedef int ImGuiDir
    ctypedef int ImGuiMouseButton
    ctypedef int ImGuiMouseCursor
    ctypedef int ImGuiSortDirection
    ctypedef int ImGuiStyleVar
    ctypedef int ImGuiTableBgTarget
    ctypedef int ImDrawFlags
    ctypedef int ImDrawListFlags
    ctypedef int ImFontAtlasFlags
    ctypedef int ImGuiBackendFlags
    ctypedef int ImGuiButtonFlags
    ctypedef int ImGuiColorEditFlags
    ctypedef int ImGuiConfigFlags
    ctypedef int ImGuiComboFlags
    ctypedef int ImGuiDockNodeFlags
    ctypedef int ImGuiDragDropFlags
    ctypedef int ImGuiFocusedFlags
    ctypedef int ImGuiHoveredFlags
    ctypedef int ImGuiInputTextFlags
    ctypedef int ImGuiKeyChord
    ctypedef int ImGuiPopupFlags
    ctypedef int ImGuiSelectableFlags
    ctypedef int ImGuiSliderFlags
    ctypedef int ImGuiTabBarFlags
    ctypedef int ImGuiTabItemFlags
    ctypedef int ImGuiTableFlags
    ctypedef int ImGuiTableColumnFlags
    ctypedef int ImGuiTableRowFlags
    ctypedef int ImGuiTreeNodeFlags
    ctypedef int ImGuiViewportFlags
    ctypedef int ImGuiWindowFlags
    ctypedef void* ImTextureID
    ctypedef unsigned short ImDrawIdx
    ctypedef unsigned int ImGuiID
    ctypedef signed char ImS8
    ctypedef unsigned char ImU8
    ctypedef signed short ImS16
    ctypedef unsigned short ImU16
    ctypedef signed int ImS32
    ctypedef unsigned int ImU32
    ctypedef signed long long ImS64
    ctypedef unsigned long long ImU64
    ctypedef unsigned short ImWchar16
    ctypedef unsigned int ImWchar32
    ctypedef ImWchar16 ImWchar
    ctypedef int (*ImGuiInputTextCallback)(ImGuiInputTextCallbackData* data) ImGuiInputTextCallback
    ctypedef void (*ImGuiSizeCallback)(ImGuiSizeCallbackData* data) ImGuiSizeCallback
    ctypedef void* (*ImGuiMemAllocFunc)(size_t sz, void* user_data) ImGuiMemAllocFunc
    ctypedef void (*ImGuiMemFreeFunc)(void* ptr, void* user_data) ImGuiMemFreeFunc
    ctypedef void (*ImDrawCallback)(const ImDrawList* parent_list, const ImDrawCmd* cmd) ImDrawCallback

    ctypedef enum ImGuiWindowFlags_:
        ImGuiWindowFlags_None
        ImGuiWindowFlags_NoTitleBar
        ImGuiWindowFlags_NoResize
        ImGuiWindowFlags_NoMove
        ImGuiWindowFlags_NoScrollbar
        ImGuiWindowFlags_NoScrollWithMouse
        ImGuiWindowFlags_NoCollapse
        ImGuiWindowFlags_AlwaysAutoResize
        ImGuiWindowFlags_NoBackground
        ImGuiWindowFlags_NoSavedSettings
        ImGuiWindowFlags_NoMouseInputs
        ImGuiWindowFlags_MenuBar
        ImGuiWindowFlags_HorizontalScrollbar
        ImGuiWindowFlags_NoFocusOnAppearing
        ImGuiWindowFlags_NoBringToFrontOnFocus
        ImGuiWindowFlags_AlwaysVerticalScrollbar
        ImGuiWindowFlags_AlwaysHorizontalScrollbar
        ImGuiWindowFlags_AlwaysUseWindowPadding
        ImGuiWindowFlags_NoNavInputs
        ImGuiWindowFlags_NoNavFocus
        ImGuiWindowFlags_UnsavedDocument
        ImGuiWindowFlags_NoDocking
        ImGuiWindowFlags_NoNav
        ImGuiWindowFlags_NoDecoration
        ImGuiWindowFlags_NoInputs
        ImGuiWindowFlags_NavFlattened
        ImGuiWindowFlags_ChildWindow
        ImGuiWindowFlags_Tooltip
        ImGuiWindowFlags_Popup
        ImGuiWindowFlags_Modal
        ImGuiWindowFlags_ChildMenu
        ImGuiWindowFlags_DockNodeHost

    ctypedef enum ImGuiInputTextFlags_:
        ImGuiInputTextFlags_None
        ImGuiInputTextFlags_CharsDecimal
        ImGuiInputTextFlags_CharsHexadecimal
        ImGuiInputTextFlags_CharsUppercase
        ImGuiInputTextFlags_CharsNoBlank
        ImGuiInputTextFlags_AutoSelectAll
        ImGuiInputTextFlags_EnterReturnsTrue
        ImGuiInputTextFlags_CallbackCompletion
        ImGuiInputTextFlags_CallbackHistory
        ImGuiInputTextFlags_CallbackAlways
        ImGuiInputTextFlags_CallbackCharFilter
        ImGuiInputTextFlags_AllowTabInput
        ImGuiInputTextFlags_CtrlEnterForNewLine
        ImGuiInputTextFlags_NoHorizontalScroll
        ImGuiInputTextFlags_AlwaysOverwrite
        ImGuiInputTextFlags_ReadOnly
        ImGuiInputTextFlags_Password
        ImGuiInputTextFlags_NoUndoRedo
        ImGuiInputTextFlags_CharsScientific
        ImGuiInputTextFlags_CallbackResize
        ImGuiInputTextFlags_CallbackEdit
        ImGuiInputTextFlags_EscapeClearsAll

    ctypedef enum ImGuiTreeNodeFlags_:
        ImGuiTreeNodeFlags_None
        ImGuiTreeNodeFlags_Selected
        ImGuiTreeNodeFlags_Framed
        ImGuiTreeNodeFlags_AllowItemOverlap
        ImGuiTreeNodeFlags_NoTreePushOnOpen
        ImGuiTreeNodeFlags_NoAutoOpenOnLog
        ImGuiTreeNodeFlags_DefaultOpen
        ImGuiTreeNodeFlags_OpenOnDoubleClick
        ImGuiTreeNodeFlags_OpenOnArrow
        ImGuiTreeNodeFlags_Leaf
        ImGuiTreeNodeFlags_Bullet
        ImGuiTreeNodeFlags_FramePadding
        ImGuiTreeNodeFlags_SpanAvailWidth
        ImGuiTreeNodeFlags_SpanFullWidth
        ImGuiTreeNodeFlags_NavLeftJumpsBackHere
        ImGuiTreeNodeFlags_CollapsingHeader

    ctypedef enum ImGuiPopupFlags_:
        ImGuiPopupFlags_None
        ImGuiPopupFlags_MouseButtonLeft
        ImGuiPopupFlags_MouseButtonRight
        ImGuiPopupFlags_MouseButtonMiddle
        ImGuiPopupFlags_MouseButtonMask_
        ImGuiPopupFlags_MouseButtonDefault_
        ImGuiPopupFlags_NoOpenOverExistingPopup
        ImGuiPopupFlags_NoOpenOverItems
        ImGuiPopupFlags_AnyPopupId
        ImGuiPopupFlags_AnyPopupLevel
        ImGuiPopupFlags_AnyPopup

    ctypedef enum ImGuiSelectableFlags_:
        ImGuiSelectableFlags_None
        ImGuiSelectableFlags_DontClosePopups
        ImGuiSelectableFlags_SpanAllColumns
        ImGuiSelectableFlags_AllowDoubleClick
        ImGuiSelectableFlags_Disabled
        ImGuiSelectableFlags_AllowItemOverlap

    ctypedef enum ImGuiComboFlags_:
        ImGuiComboFlags_None
        ImGuiComboFlags_PopupAlignLeft
        ImGuiComboFlags_HeightSmall
        ImGuiComboFlags_HeightRegular
        ImGuiComboFlags_HeightLarge
        ImGuiComboFlags_HeightLargest
        ImGuiComboFlags_NoArrowButton
        ImGuiComboFlags_NoPreview
        ImGuiComboFlags_HeightMask_

    ctypedef enum ImGuiTabBarFlags_:
        ImGuiTabBarFlags_None
        ImGuiTabBarFlags_Reorderable
        ImGuiTabBarFlags_AutoSelectNewTabs
        ImGuiTabBarFlags_TabListPopupButton
        ImGuiTabBarFlags_NoCloseWithMiddleMouseButton
        ImGuiTabBarFlags_NoTabListScrollingButtons
        ImGuiTabBarFlags_NoTooltip
        ImGuiTabBarFlags_FittingPolicyResizeDown
        ImGuiTabBarFlags_FittingPolicyScroll
        ImGuiTabBarFlags_FittingPolicyMask_
        ImGuiTabBarFlags_FittingPolicyDefault_

    ctypedef enum ImGuiTabItemFlags_:
        ImGuiTabItemFlags_None
        ImGuiTabItemFlags_UnsavedDocument
        ImGuiTabItemFlags_SetSelected
        ImGuiTabItemFlags_NoCloseWithMiddleMouseButton
        ImGuiTabItemFlags_NoPushId
        ImGuiTabItemFlags_NoTooltip
        ImGuiTabItemFlags_NoReorder
        ImGuiTabItemFlags_Leading
        ImGuiTabItemFlags_Trailing

    ctypedef enum ImGuiTableFlags_:
        ImGuiTableFlags_None
        ImGuiTableFlags_Resizable
        ImGuiTableFlags_Reorderable
        ImGuiTableFlags_Hideable
        ImGuiTableFlags_Sortable
        ImGuiTableFlags_NoSavedSettings
        ImGuiTableFlags_ContextMenuInBody
        ImGuiTableFlags_RowBg
        ImGuiTableFlags_BordersInnerH
        ImGuiTableFlags_BordersOuterH
        ImGuiTableFlags_BordersInnerV
        ImGuiTableFlags_BordersOuterV
        ImGuiTableFlags_BordersH
        ImGuiTableFlags_BordersV
        ImGuiTableFlags_BordersInner
        ImGuiTableFlags_BordersOuter
        ImGuiTableFlags_Borders
        ImGuiTableFlags_NoBordersInBody
        ImGuiTableFlags_NoBordersInBodyUntilResize
        ImGuiTableFlags_SizingFixedFit
        ImGuiTableFlags_SizingFixedSame
        ImGuiTableFlags_SizingStretchProp
        ImGuiTableFlags_SizingStretchSame
        ImGuiTableFlags_NoHostExtendX
        ImGuiTableFlags_NoHostExtendY
        ImGuiTableFlags_NoKeepColumnsVisible
        ImGuiTableFlags_PreciseWidths
        ImGuiTableFlags_NoClip
        ImGuiTableFlags_PadOuterX
        ImGuiTableFlags_NoPadOuterX
        ImGuiTableFlags_NoPadInnerX
        ImGuiTableFlags_ScrollX
        ImGuiTableFlags_ScrollY
        ImGuiTableFlags_SortMulti
        ImGuiTableFlags_SortTristate
        ImGuiTableFlags_SizingMask_

    ctypedef enum ImGuiTableColumnFlags_:
        ImGuiTableColumnFlags_None
        ImGuiTableColumnFlags_Disabled
        ImGuiTableColumnFlags_DefaultHide
        ImGuiTableColumnFlags_DefaultSort
        ImGuiTableColumnFlags_WidthStretch
        ImGuiTableColumnFlags_WidthFixed
        ImGuiTableColumnFlags_NoResize
        ImGuiTableColumnFlags_NoReorder
        ImGuiTableColumnFlags_NoHide
        ImGuiTableColumnFlags_NoClip
        ImGuiTableColumnFlags_NoSort
        ImGuiTableColumnFlags_NoSortAscending
        ImGuiTableColumnFlags_NoSortDescending
        ImGuiTableColumnFlags_NoHeaderLabel
        ImGuiTableColumnFlags_NoHeaderWidth
        ImGuiTableColumnFlags_PreferSortAscending
        ImGuiTableColumnFlags_PreferSortDescending
        ImGuiTableColumnFlags_IndentEnable
        ImGuiTableColumnFlags_IndentDisable
        ImGuiTableColumnFlags_IsEnabled
        ImGuiTableColumnFlags_IsVisible
        ImGuiTableColumnFlags_IsSorted
        ImGuiTableColumnFlags_IsHovered
        ImGuiTableColumnFlags_WidthMask_
        ImGuiTableColumnFlags_IndentMask_
        ImGuiTableColumnFlags_StatusMask_
        ImGuiTableColumnFlags_NoDirectResize_

    ctypedef enum ImGuiTableRowFlags_:
        ImGuiTableRowFlags_None
        ImGuiTableRowFlags_Headers

    ctypedef enum ImGuiTableBgTarget_:
        ImGuiTableBgTarget_None
        ImGuiTableBgTarget_RowBg0
        ImGuiTableBgTarget_RowBg1
        ImGuiTableBgTarget_CellBg

    ctypedef enum ImGuiFocusedFlags_:
        ImGuiFocusedFlags_None
        ImGuiFocusedFlags_ChildWindows
        ImGuiFocusedFlags_RootWindow
        ImGuiFocusedFlags_AnyWindow
        ImGuiFocusedFlags_NoPopupHierarchy
        ImGuiFocusedFlags_DockHierarchy
        ImGuiFocusedFlags_RootAndChildWindows

    ctypedef enum ImGuiHoveredFlags_:
        ImGuiHoveredFlags_None
        ImGuiHoveredFlags_ChildWindows
        ImGuiHoveredFlags_RootWindow
        ImGuiHoveredFlags_AnyWindow
        ImGuiHoveredFlags_NoPopupHierarchy
        ImGuiHoveredFlags_DockHierarchy
        ImGuiHoveredFlags_AllowWhenBlockedByPopup
        ImGuiHoveredFlags_AllowWhenBlockedByActiveItem
        ImGuiHoveredFlags_AllowWhenOverlapped
        ImGuiHoveredFlags_AllowWhenDisabled
        ImGuiHoveredFlags_NoNavOverride
        ImGuiHoveredFlags_RectOnly
        ImGuiHoveredFlags_RootAndChildWindows
        ImGuiHoveredFlags_DelayNormal
        ImGuiHoveredFlags_DelayShort
        ImGuiHoveredFlags_NoSharedDelay

    ctypedef enum ImGuiDockNodeFlags_:
        ImGuiDockNodeFlags_None
        ImGuiDockNodeFlags_KeepAliveOnly
        ImGuiDockNodeFlags_NoDockingInCentralNode
        ImGuiDockNodeFlags_PassthruCentralNode
        ImGuiDockNodeFlags_NoSplit
        ImGuiDockNodeFlags_NoResize
        ImGuiDockNodeFlags_AutoHideTabBar

    ctypedef enum ImGuiDragDropFlags_:
        ImGuiDragDropFlags_None
        ImGuiDragDropFlags_SourceNoPreviewTooltip
        ImGuiDragDropFlags_SourceNoDisableHover
        ImGuiDragDropFlags_SourceNoHoldToOpenOthers
        ImGuiDragDropFlags_SourceAllowNullID
        ImGuiDragDropFlags_SourceExtern
        ImGuiDragDropFlags_SourceAutoExpirePayload
        ImGuiDragDropFlags_AcceptBeforeDelivery
        ImGuiDragDropFlags_AcceptNoDrawDefaultRect
        ImGuiDragDropFlags_AcceptNoPreviewTooltip
        ImGuiDragDropFlags_AcceptPeekOnly

    ctypedef enum ImGuiDataType_:
        ImGuiDataType_S8
        ImGuiDataType_U8
        ImGuiDataType_S16
        ImGuiDataType_U16
        ImGuiDataType_S32
        ImGuiDataType_U32
        ImGuiDataType_S64
        ImGuiDataType_U64
        ImGuiDataType_Float
        ImGuiDataType_Double
        ImGuiDataType_COUNT

    ctypedef enum ImGuiDir_:
        ImGuiDir_None
        ImGuiDir_Left
        ImGuiDir_Right
        ImGuiDir_Up
        ImGuiDir_Down
        ImGuiDir_COUNT

    ctypedef enum ImGuiSortDirection_:
        ImGuiSortDirection_None
        ImGuiSortDirection_Ascending
        ImGuiSortDirection_Descending

    ctypedef enum ImGuiKey:
        ImGuiKey_None
        ImGuiKey_Tab
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
        ImGuiKey_Apostrophe
        ImGuiKey_Comma
        ImGuiKey_Minus
        ImGuiKey_Period
        ImGuiKey_Slash
        ImGuiKey_Semicolon
        ImGuiKey_Equal
        ImGuiKey_LeftBracket
        ImGuiKey_Backslash
        ImGuiKey_RightBracket
        ImGuiKey_GraveAccent
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
        ImGuiKey_GamepadStart
        ImGuiKey_GamepadBack
        ImGuiKey_GamepadFaceLeft
        ImGuiKey_GamepadFaceRight
        ImGuiKey_GamepadFaceUp
        ImGuiKey_GamepadFaceDown
        ImGuiKey_GamepadDpadLeft
        ImGuiKey_GamepadDpadRight
        ImGuiKey_GamepadDpadUp
        ImGuiKey_GamepadDpadDown
        ImGuiKey_GamepadL1
        ImGuiKey_GamepadR1
        ImGuiKey_GamepadL2
        ImGuiKey_GamepadR2
        ImGuiKey_GamepadL3
        ImGuiKey_GamepadR3
        ImGuiKey_GamepadLStickLeft
        ImGuiKey_GamepadLStickRight
        ImGuiKey_GamepadLStickUp
        ImGuiKey_GamepadLStickDown
        ImGuiKey_GamepadRStickLeft
        ImGuiKey_GamepadRStickRight
        ImGuiKey_GamepadRStickUp
        ImGuiKey_GamepadRStickDown
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
        ImGuiMod_Ctrl
        ImGuiMod_Shift
        ImGuiMod_Alt
        ImGuiMod_Super
        ImGuiMod_Shortcut
        ImGuiMod_Mask_
        ImGuiKey_NamedKey_BEGIN
        ImGuiKey_NamedKey_END
        ImGuiKey_NamedKey_COUNT
        ImGuiKey_KeysData_SIZE
        ImGuiKey_KeysData_OFFSET

    ctypedef enum ImGuiConfigFlags_:
        ImGuiConfigFlags_None
        ImGuiConfigFlags_NavEnableKeyboard
        ImGuiConfigFlags_NavEnableGamepad
        ImGuiConfigFlags_NavEnableSetMousePos
        ImGuiConfigFlags_NavNoCaptureKeyboard
        ImGuiConfigFlags_NoMouse
        ImGuiConfigFlags_NoMouseCursorChange
        ImGuiConfigFlags_DockingEnable
        ImGuiConfigFlags_ViewportsEnable
        ImGuiConfigFlags_DpiEnableScaleViewports
        ImGuiConfigFlags_DpiEnableScaleFonts
        ImGuiConfigFlags_IsSRGB
        ImGuiConfigFlags_IsTouchScreen

    ctypedef enum ImGuiBackendFlags_:
        ImGuiBackendFlags_None
        ImGuiBackendFlags_HasGamepad
        ImGuiBackendFlags_HasMouseCursors
        ImGuiBackendFlags_HasSetMousePos
        ImGuiBackendFlags_RendererHasVtxOffset
        ImGuiBackendFlags_PlatformHasViewports
        ImGuiBackendFlags_HasMouseHoveredViewport
        ImGuiBackendFlags_RendererHasViewports

    ctypedef enum ImGuiCol_:
        ImGuiCol_Text
        ImGuiCol_TextDisabled
        ImGuiCol_WindowBg
        ImGuiCol_ChildBg
        ImGuiCol_PopupBg
        ImGuiCol_Border
        ImGuiCol_BorderShadow
        ImGuiCol_FrameBg
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
        ImGuiCol_Header
        ImGuiCol_HeaderHovered
        ImGuiCol_HeaderActive
        ImGuiCol_Separator
        ImGuiCol_SeparatorHovered
        ImGuiCol_SeparatorActive
        ImGuiCol_ResizeGrip
        ImGuiCol_ResizeGripHovered
        ImGuiCol_ResizeGripActive
        ImGuiCol_Tab
        ImGuiCol_TabHovered
        ImGuiCol_TabActive
        ImGuiCol_TabUnfocused
        ImGuiCol_TabUnfocusedActive
        ImGuiCol_DockingPreview
        ImGuiCol_DockingEmptyBg
        ImGuiCol_PlotLines
        ImGuiCol_PlotLinesHovered
        ImGuiCol_PlotHistogram
        ImGuiCol_PlotHistogramHovered
        ImGuiCol_TableHeaderBg
        ImGuiCol_TableBorderStrong
        ImGuiCol_TableBorderLight
        ImGuiCol_TableRowBg
        ImGuiCol_TableRowBgAlt
        ImGuiCol_TextSelectedBg
        ImGuiCol_DragDropTarget
        ImGuiCol_NavHighlight
        ImGuiCol_NavWindowingHighlight
        ImGuiCol_NavWindowingDimBg
        ImGuiCol_ModalWindowDimBg
        ImGuiCol_COUNT

    ctypedef enum ImGuiStyleVar_:
        ImGuiStyleVar_Alpha
        ImGuiStyleVar_DisabledAlpha
        ImGuiStyleVar_WindowPadding
        ImGuiStyleVar_WindowRounding
        ImGuiStyleVar_WindowBorderSize
        ImGuiStyleVar_WindowMinSize
        ImGuiStyleVar_WindowTitleAlign
        ImGuiStyleVar_ChildRounding
        ImGuiStyleVar_ChildBorderSize
        ImGuiStyleVar_PopupRounding
        ImGuiStyleVar_PopupBorderSize
        ImGuiStyleVar_FramePadding
        ImGuiStyleVar_FrameRounding
        ImGuiStyleVar_FrameBorderSize
        ImGuiStyleVar_ItemSpacing
        ImGuiStyleVar_ItemInnerSpacing
        ImGuiStyleVar_IndentSpacing
        ImGuiStyleVar_CellPadding
        ImGuiStyleVar_ScrollbarSize
        ImGuiStyleVar_ScrollbarRounding
        ImGuiStyleVar_GrabMinSize
        ImGuiStyleVar_GrabRounding
        ImGuiStyleVar_TabRounding
        ImGuiStyleVar_ButtonTextAlign
        ImGuiStyleVar_SelectableTextAlign
        ImGuiStyleVar_SeparatorTextBorderSize
        ImGuiStyleVar_SeparatorTextAlign
        ImGuiStyleVar_SeparatorTextPadding
        ImGuiStyleVar_COUNT

    ctypedef enum ImGuiButtonFlags_:
        ImGuiButtonFlags_None
        ImGuiButtonFlags_MouseButtonLeft
        ImGuiButtonFlags_MouseButtonRight
        ImGuiButtonFlags_MouseButtonMiddle
        ImGuiButtonFlags_MouseButtonMask_
        ImGuiButtonFlags_MouseButtonDefault_

    ctypedef enum ImGuiColorEditFlags_:
        ImGuiColorEditFlags_None
        ImGuiColorEditFlags_NoAlpha
        ImGuiColorEditFlags_NoPicker
        ImGuiColorEditFlags_NoOptions
        ImGuiColorEditFlags_NoSmallPreview
        ImGuiColorEditFlags_NoInputs
        ImGuiColorEditFlags_NoTooltip
        ImGuiColorEditFlags_NoLabel
        ImGuiColorEditFlags_NoSidePreview
        ImGuiColorEditFlags_NoDragDrop
        ImGuiColorEditFlags_NoBorder
        ImGuiColorEditFlags_AlphaBar
        ImGuiColorEditFlags_AlphaPreview
        ImGuiColorEditFlags_AlphaPreviewHalf
        ImGuiColorEditFlags_HDR
        ImGuiColorEditFlags_DisplayRGB
        ImGuiColorEditFlags_DisplayHSV
        ImGuiColorEditFlags_DisplayHex
        ImGuiColorEditFlags_Uint8
        ImGuiColorEditFlags_Float
        ImGuiColorEditFlags_PickerHueBar
        ImGuiColorEditFlags_PickerHueWheel
        ImGuiColorEditFlags_InputRGB
        ImGuiColorEditFlags_InputHSV
        ImGuiColorEditFlags_DefaultOptions_
        ImGuiColorEditFlags_DisplayMask_
        ImGuiColorEditFlags_DataTypeMask_
        ImGuiColorEditFlags_PickerMask_
        ImGuiColorEditFlags_InputMask_

    ctypedef enum ImGuiSliderFlags_:
        ImGuiSliderFlags_None
        ImGuiSliderFlags_AlwaysClamp
        ImGuiSliderFlags_Logarithmic
        ImGuiSliderFlags_NoRoundToFormat
        ImGuiSliderFlags_NoInput
        ImGuiSliderFlags_InvalidMask_

    ctypedef enum ImGuiMouseButton_:
        ImGuiMouseButton_Left
        ImGuiMouseButton_Right
        ImGuiMouseButton_Middle
        ImGuiMouseButton_COUNT

    ctypedef enum ImGuiMouseCursor_:
        ImGuiMouseCursor_None
        ImGuiMouseCursor_Arrow
        ImGuiMouseCursor_TextInput
        ImGuiMouseCursor_ResizeAll
        ImGuiMouseCursor_ResizeNS
        ImGuiMouseCursor_ResizeEW
        ImGuiMouseCursor_ResizeNESW
        ImGuiMouseCursor_ResizeNWSE
        ImGuiMouseCursor_Hand
        ImGuiMouseCursor_NotAllowed
        ImGuiMouseCursor_COUNT

    ctypedef enum ImGuiCond_:
        ImGuiCond_None
        ImGuiCond_Always
        ImGuiCond_Once
        ImGuiCond_FirstUseEver
        ImGuiCond_Appearing

    ctypedef enum ImDrawFlags_:
        ImDrawFlags_None
        ImDrawFlags_Closed
        ImDrawFlags_RoundCornersTopLeft
        ImDrawFlags_RoundCornersTopRight
        ImDrawFlags_RoundCornersBottomLeft
        ImDrawFlags_RoundCornersBottomRight
        ImDrawFlags_RoundCornersNone
        ImDrawFlags_RoundCornersTop
        ImDrawFlags_RoundCornersBottom
        ImDrawFlags_RoundCornersLeft
        ImDrawFlags_RoundCornersRight
        ImDrawFlags_RoundCornersAll
        ImDrawFlags_RoundCornersDefault_
        ImDrawFlags_RoundCornersMask_

    ctypedef enum ImDrawListFlags_:
        ImDrawListFlags_None
        ImDrawListFlags_AntiAliasedLines
        ImDrawListFlags_AntiAliasedLinesUseTex
        ImDrawListFlags_AntiAliasedFill
        ImDrawListFlags_AllowVtxOffset

    ctypedef enum ImFontAtlasFlags_:
        ImFontAtlasFlags_None
        ImFontAtlasFlags_NoPowerOfTwoHeight
        ImFontAtlasFlags_NoMouseCursors
        ImFontAtlasFlags_NoBakedLines

    ctypedef enum ImGuiViewportFlags_:
        ImGuiViewportFlags_None
        ImGuiViewportFlags_IsPlatformWindow
        ImGuiViewportFlags_IsPlatformMonitor
        ImGuiViewportFlags_OwnedByApp
        ImGuiViewportFlags_NoDecoration
        ImGuiViewportFlags_NoTaskBarIcon
        ImGuiViewportFlags_NoFocusOnAppearing
        ImGuiViewportFlags_NoFocusOnClick
        ImGuiViewportFlags_NoInputs
        ImGuiViewportFlags_NoRendererClear
        ImGuiViewportFlags_TopMost
        ImGuiViewportFlags_Minimized
        ImGuiViewportFlags_NoAutoMerge
        ImGuiViewportFlags_CanHostOtherWindows


    ctypedef struct ImDrawListSharedData:
        pass

    ctypedef struct ImFontBuilderIO:
        pass

    ctypedef struct ImGuiContext:
        pass

    ctypedef struct ImVec2:
        float x
        float y

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
        float Alpha
        float DisabledAlpha
        ImVec2 WindowPadding
        float WindowRounding
        float WindowBorderSize
        ImVec2 WindowMinSize
        ImVec2 WindowTitleAlign
        ImGuiDir WindowMenuButtonPosition
        float ChildRounding
        float ChildBorderSize
        float PopupRounding
        float PopupBorderSize
        ImVec2 FramePadding
        float FrameRounding
        float FrameBorderSize
        ImVec2 ItemSpacing
        ImVec2 ItemInnerSpacing
        ImVec2 CellPadding
        ImVec2 TouchExtraPadding
        float IndentSpacing
        float ColumnsMinSpacing
        float ScrollbarSize
        float ScrollbarRounding
        float GrabMinSize
        float GrabRounding
        float LogSliderDeadzone
        float TabRounding
        float TabBorderSize
        float TabMinWidthForCloseButton
        ImGuiDir ColorButtonPosition
        ImVec2 ButtonTextAlign
        ImVec2 SelectableTextAlign
        float SeparatorTextBorderSize
        ImVec2 SeparatorTextAlign
        ImVec2 SeparatorTextPadding
        ImVec2 DisplayWindowPadding
        ImVec2 DisplaySafeAreaPadding
        float MouseCursorScale
        bool AntiAliasedLines
        bool AntiAliasedLinesUseTex
        bool AntiAliasedFill
        float CurveTessellationTol
        float CircleTessellationMaxError
        ImVec4 Colors

    ctypedef struct ImGuiKeyData:
        bool Down
        float DownDuration
        float DownDurationPrev
        float AnalogValue

    ctypedef struct ImGuiIO:
        ImGuiConfigFlags ConfigFlags
        ImGuiBackendFlags BackendFlags
        ImVec2 DisplaySize
        float DeltaTime
        float IniSavingRate
        const char* IniFilename
        const char* LogFilename
        float MouseDoubleClickTime
        float MouseDoubleClickMaxDist
        float MouseDragThreshold
        float KeyRepeatDelay
        float KeyRepeatRate
        float HoverDelayNormal
        float HoverDelayShort
        void* UserData
        ImFontAtlas* Fonts
        float FontGlobalScale
        bool FontAllowUserScaling
        ImFont* FontDefault
        ImVec2 DisplayFramebufferScale
        bool ConfigDockingNoSplit
        bool ConfigDockingWithShift
        bool ConfigDockingAlwaysTabBar
        bool ConfigDockingTransparentPayload
        bool ConfigViewportsNoAutoMerge
        bool ConfigViewportsNoTaskBarIcon
        bool ConfigViewportsNoDecoration
        bool ConfigViewportsNoDefaultParent
        bool MouseDrawCursor
        bool ConfigMacOSXBehaviors
        bool ConfigInputTrickleEventQueue
        bool ConfigInputTextCursorBlink
        bool ConfigInputTextEnterKeepActive
        bool ConfigDragClickToInputText
        bool ConfigWindowsResizeFromEdges
        bool ConfigWindowsMoveFromTitleBarOnly
        float ConfigMemoryCompactTimer
        bool ConfigDebugBeginReturnValueOnce
        bool ConfigDebugBeginReturnValueLoop
        const char* BackendPlatformName
        const char* BackendRendererName
        void* BackendPlatformUserData
        void* BackendRendererUserData
        void* BackendLanguageUserData
        const char* (*GetClipboardTextFn)(void* user_data)
        void (*SetClipboardTextFn)(void* user_data, const char* text)
        void* ClipboardUserData
        void (*SetPlatformImeDataFn)(ImGuiViewport* viewport, ImGuiPlatformImeData* data)
        bool WantCaptureMouse
        bool WantCaptureKeyboard
        bool WantTextInput
        bool WantSetMousePos
        bool WantSaveIniSettings
        bool NavActive
        bool NavVisible
        float Framerate
        int MetricsRenderVertices
        int MetricsRenderIndices
        int MetricsRenderWindows
        int MetricsActiveWindows
        int MetricsActiveAllocations
        ImVec2 MouseDelta
        ImGuiContext* Ctx
        ImVec2 MousePos
        bool MouseDown
        float MouseWheel
        float MouseWheelH
        ImGuiID MouseHoveredViewport
        bool KeyCtrl
        bool KeyShift
        bool KeyAlt
        bool KeySuper
        ImGuiKeyChord KeyMods
        ImGuiKeyData KeysData
        bool WantCaptureMouseUnlessPopupClose
        ImVec2 MousePosPrev
        ImVec2 MouseClickedPos
        double MouseClickedTime
        bool MouseClicked
        bool MouseDoubleClicked
        ImU16 MouseClickedCount
        ImU16 MouseClickedLastCount
        bool MouseReleased
        bool MouseDownOwned
        bool MouseDownOwnedUnlessPopupClose
        float MouseDownDuration
        float MouseDownDurationPrev
        ImVec2 MouseDragMaxDistanceAbs
        float MouseDragMaxDistanceSqr
        float PenPressure
        bool AppFocusLost
        bool AppAcceptingEvents
        ImS8 BackendUsingLegacyKeyArrays
        bool BackendUsingLegacyNavInputArray
        ImWchar16 InputQueueSurrogate
        ImVector_ImWchar InputQueueCharacters

    ctypedef struct ImGuiInputTextCallbackData:
        ImGuiContext* Ctx
        ImGuiInputTextFlags EventFlag
        ImGuiInputTextFlags Flags
        void* UserData
        ImWchar EventChar
        ImGuiKey EventKey
        char* Buf
        int BufTextLen
        int BufSize
        bool BufDirty
        int CursorPos
        int SelectionStart
        int SelectionEnd

    ctypedef struct ImGuiSizeCallbackData:
        void* UserData
        ImVec2 Pos
        ImVec2 CurrentSize
        ImVec2 DesiredSize

    ctypedef struct ImGuiWindowClass:
        ImGuiID ClassId
        ImGuiID ParentViewportId
        ImGuiViewportFlags ViewportFlagsOverrideSet
        ImGuiViewportFlags ViewportFlagsOverrideClear
        ImGuiTabItemFlags TabItemFlagsOverrideSet
        ImGuiDockNodeFlags DockNodeFlagsOverrideSet
        bool DockingAlwaysTabBar
        bool DockingAllowUnclassed

    ctypedef struct ImGuiPayload:
        void* Data
        int DataSize
        ImGuiID SourceId
        ImGuiID SourceParentId
        int DataFrameCount
        char DataType
        bool Preview
        bool Delivery

    ctypedef struct ImGuiTableColumnSortSpecs:
        ImGuiID ColumnUserID
        ImS16 ColumnIndex
        ImS16 SortOrder
        ImGuiSortDirection SortDirection

    ctypedef struct ImGuiTableSortSpecs:
        const ImGuiTableColumnSortSpecs* Specs
        int SpecsCount
        bool SpecsDirty

    ctypedef struct ImGuiTextFilter_ImGuiTextRange:
        const char* b
        const char* e

    ctypedef struct ImGuiTextFilter:
        char InputBuf
        ImVector_ImGuiTextFilter_ImGuiTextRange Filters
        int CountGrep

    ctypedef struct ImGuiTextBuffer:
        ImVector_char Buf

    ctypedef struct ImGuiStorage_ImGuiStoragePair:
        ImGuiID key

    ctypedef struct ImGuiStorage:
        ImVector_ImGuiStorage_ImGuiStoragePair Data

    ctypedef struct ImGuiListClipper:
        ImGuiContext* Ctx
        int DisplayStart
        int DisplayEnd
        int ItemsCount
        float ItemsHeight
        float StartPosY
        void* TempData

    ctypedef struct ImColor:
        ImVec4 Value

    ctypedef struct ImDrawCmd:
        ImVec4 ClipRect
        ImTextureID TextureId
        unsigned int VtxOffset
        unsigned int IdxOffset
        unsigned int ElemCount
        ImDrawCallback UserCallback
        void* UserCallbackData

    ctypedef struct ImDrawVert:
        ImVec2 pos
        ImVec2 uv
        ImU32 col

    ctypedef struct ImDrawCmdHeader:
        ImVec4 ClipRect
        ImTextureID TextureId
        unsigned int VtxOffset

    ctypedef struct ImDrawChannel:
        ImVector_ImDrawCmd _CmdBuffer
        ImVector_ImDrawIdx _IdxBuffer

    ctypedef struct ImDrawListSplitter:
        int _Current
        int _Count
        ImVector_ImDrawChannel _Channels

    ctypedef struct ImDrawList:
        ImVector_ImDrawCmd CmdBuffer
        ImVector_ImDrawIdx IdxBuffer
        ImVector_ImDrawVert VtxBuffer
        ImDrawListFlags Flags
        unsigned int _VtxCurrentIdx
        ImDrawListSharedData* _Data
        const char* _OwnerName
        ImDrawVert* _VtxWritePtr
        ImDrawIdx* _IdxWritePtr
        ImVector_ImVec4 _ClipRectStack
        ImVector_ImTextureID _TextureIdStack
        ImVector_ImVec2 _Path
        ImDrawCmdHeader _CmdHeader
        ImDrawListSplitter _Splitter
        float _FringeScale

    ctypedef struct ImDrawData:
        bool Valid
        int CmdListsCount
        int TotalIdxCount
        int TotalVtxCount
        ImDrawList** CmdLists
        ImVec2 DisplayPos
        ImVec2 DisplaySize
        ImVec2 FramebufferScale
        ImGuiViewport* OwnerViewport

    ctypedef struct ImFontConfig:
        void* FontData
        int FontDataSize
        bool FontDataOwnedByAtlas
        int FontNo
        float SizePixels
        int OversampleH
        int OversampleV
        bool PixelSnapH
        ImVec2 GlyphExtraSpacing
        ImVec2 GlyphOffset
        const ImWchar* GlyphRanges
        float GlyphMinAdvanceX
        float GlyphMaxAdvanceX
        bool MergeMode
        unsigned int FontBuilderFlags
        float RasterizerMultiply
        ImWchar EllipsisChar
        char Name
        ImFont* DstFont

    ctypedef struct ImFontGlyph:
        unsigned int Colored
        unsigned int Visible
        unsigned int Codepoint
        float AdvanceX
        float X0
        float Y0
        float X1
        float Y1
        float U0
        float V0
        float U1
        float V1

    ctypedef struct ImFontGlyphRangesBuilder:
        ImVector_ImU32 UsedChars

    ctypedef struct ImFontAtlasCustomRect:
        unsigned short Width
        unsigned short Height
        unsigned short X
        unsigned short Y
        unsigned int GlyphID
        float GlyphAdvanceX
        ImVec2 GlyphOffset
        ImFont* Font

    ctypedef struct ImFontAtlas:
        ImFontAtlasFlags Flags
        ImTextureID TexID
        int TexDesiredWidth
        int TexGlyphPadding
        bool Locked
        void* UserData
        bool TexReady
        bool TexPixelsUseColors
        unsigned char* TexPixelsAlpha8
        unsigned int* TexPixelsRGBA32
        int TexWidth
        int TexHeight
        ImVec2 TexUvScale
        ImVec2 TexUvWhitePixel
        ImVector_ImFontPtr Fonts
        ImVector_ImFontAtlasCustomRect CustomRects
        ImVector_ImFontConfig ConfigData
        ImVec4 TexUvLines
        const ImFontBuilderIO* FontBuilderIO
        unsigned int FontBuilderFlags
        int PackIdMouseCursors
        int PackIdLines

    ctypedef struct ImFont:
        ImVector_float IndexAdvanceX
        float FallbackAdvanceX
        float FontSize
        ImVector_ImWchar IndexLookup
        ImVector_ImFontGlyph Glyphs
        const ImFontGlyph* FallbackGlyph
        ImFontAtlas* ContainerAtlas
        const ImFontConfig* ConfigData
        short ConfigDataCount
        ImWchar FallbackChar
        ImWchar EllipsisChar
        short EllipsisCharCount
        float EllipsisWidth
        float EllipsisCharStep
        bool DirtyLookupTables
        float Scale
        float Ascent
        float Descent
        int MetricsTotalSurface
        ImU8 Used4kPagesMap

    ctypedef struct ImGuiViewport:
        ImGuiID ID
        ImGuiViewportFlags Flags
        ImVec2 Pos
        ImVec2 Size
        ImVec2 WorkPos
        ImVec2 WorkSize
        float DpiScale
        ImGuiID ParentViewportId
        ImDrawData* DrawData
        void* RendererUserData
        void* PlatformUserData
        void* PlatformHandle
        void* PlatformHandleRaw
        bool PlatformWindowCreated
        bool PlatformRequestMove
        bool PlatformRequestResize
        bool PlatformRequestClose

    ctypedef struct ImGuiPlatformIO:
        void (*Platform_CreateWindow)(ImGuiViewport* vp)
        void (*Platform_DestroyWindow)(ImGuiViewport* vp)
        void (*Platform_ShowWindow)(ImGuiViewport* vp)
        void (*Platform_SetWindowPos)(ImGuiViewport* vp, ImVec2 pos)
        ImVec2 (*Platform_GetWindowPos)(ImGuiViewport* vp)
        void (*Platform_SetWindowSize)(ImGuiViewport* vp, ImVec2 size)
        ImVec2 (*Platform_GetWindowSize)(ImGuiViewport* vp)
        void (*Platform_SetWindowFocus)(ImGuiViewport* vp)
        bool (*Platform_GetWindowFocus)(ImGuiViewport* vp)
        bool (*Platform_GetWindowMinimized)(ImGuiViewport* vp)
        void (*Platform_SetWindowTitle)(ImGuiViewport* vp, const char* str)
        void (*Platform_SetWindowAlpha)(ImGuiViewport* vp, float alpha)
        void (*Platform_UpdateWindow)(ImGuiViewport* vp)
        void (*Platform_RenderWindow)(ImGuiViewport* vp, void* render_arg)
        void (*Platform_SwapBuffers)(ImGuiViewport* vp, void* render_arg)
        float (*Platform_GetWindowDpiScale)(ImGuiViewport* vp)
        void (*Platform_OnChangedViewport)(ImGuiViewport* vp)
        int (*Platform_CreateVkSurface)(ImGuiViewport* vp, ImU64 vk_inst, const void* vk_allocators, ImU64* out_vk_surface)
        void (*Renderer_CreateWindow)(ImGuiViewport* vp)
        void (*Renderer_DestroyWindow)(ImGuiViewport* vp)
        void (*Renderer_SetWindowSize)(ImGuiViewport* vp, ImVec2 size)
        void (*Renderer_RenderWindow)(ImGuiViewport* vp, void* render_arg)
        void (*Renderer_SwapBuffers)(ImGuiViewport* vp, void* render_arg)
        ImVector_ImGuiPlatformMonitor Monitors
        ImVector_ImGuiViewportPtr Viewports

    ctypedef struct ImGuiPlatformMonitor:
        ImVec2 MainPos
        ImVec2 MainSize
        ImVec2 WorkPos
        ImVec2 WorkSize
        float DpiScale

    ctypedef struct ImGuiPlatformImeData:
        bool WantVisible
        ImVec2 InputPos
        float InputLineHeight


    ImGuiKey GetKeyIndex(ImGuiKey key) except +
    ImColor ImColor_HSV(ImColor* self, float h, float s, float v, float a) except +
    void ImColor_SetHSV(ImColor* self, float h, float s, float v, float a) except +
    ImTextureID ImDrawCmd_GetTexID(const ImDrawCmd* self) except +
    void ImDrawData_Clear(ImDrawData* self) except +
    void ImDrawData_DeIndexAllBuffers(ImDrawData* self) except +
    void ImDrawData_ScaleClipRects(ImDrawData* self, ImVec2 fb_scale) except +
    void ImDrawListSplitter_Clear(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_Merge(ImDrawListSplitter* self, ImDrawList* draw_list) except +
    void ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter* self, ImDrawList* draw_list, int channel_idx) except +
    void ImDrawListSplitter_Split(ImDrawListSplitter* self, ImDrawList* draw_list, int count) except +
    void ImDrawList_AddBezierCubic(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col, float thickness, int num_segments) except +
    void ImDrawList_AddBezierQuadratic(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col, float thickness, int num_segments) except +
    void ImDrawList_AddCallback(ImDrawList* self, ImDrawCallback callback, void* callback_data) except +
    void ImDrawList_AddCircle(ImDrawList* self, ImVec2 center, float radius, ImU32 col) except +
    void ImDrawList_AddCircleEx(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments, float thickness) except +
    void ImDrawList_AddCircleFilled(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddConvexPolyFilled(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col) except +
    void ImDrawList_AddDrawCmd(ImDrawList* self) except +
    void ImDrawList_AddImage(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p_min, ImVec2 p_max) except +
    void ImDrawList_AddImageEx(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p_min, ImVec2 p_max, ImVec2 uv_min, ImVec2 uv_max, ImU32 col) except +
    void ImDrawList_AddImageQuad(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4) except +
    void ImDrawList_AddImageQuadEx(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImVec2 uv1, ImVec2 uv2, ImVec2 uv3, ImVec2 uv4, ImU32 col) except +
    void ImDrawList_AddImageRounded(ImDrawList* self, ImTextureID user_texture_id, ImVec2 p_min, ImVec2 p_max, ImVec2 uv_min, ImVec2 uv_max, ImU32 col, float rounding, ImDrawFlags flags) except +
    void ImDrawList_AddLine(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImU32 col) except +
    void ImDrawList_AddLineEx(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImU32 col, float thickness) except +
    void ImDrawList_AddNgon(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddNgonEx(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments, float thickness) except +
    void ImDrawList_AddNgonFilled(ImDrawList* self, ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddPolyline(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col, ImDrawFlags flags, float thickness) except +
    void ImDrawList_AddQuad(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col) except +
    void ImDrawList_AddQuadEx(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col, float thickness) except +
    void ImDrawList_AddQuadFilled(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImVec2 p4, ImU32 col) except +
    void ImDrawList_AddRect(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col) except +
    void ImDrawList_AddRectEx(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags, float thickness) except +
    void ImDrawList_AddRectFilled(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col) except +
    void ImDrawList_AddRectFilledEx(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags) except +
    void ImDrawList_AddRectFilledMultiColor(ImDrawList* self, ImVec2 p_min, ImVec2 p_max, ImU32 col_upr_left, ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left) except +
    void ImDrawList_AddText(ImDrawList* self, ImVec2 pos, ImU32 col, const char* text_begin) except +
    void ImDrawList_AddTextEx(ImDrawList* self, ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end) except +
    void ImDrawList_AddTextImFontPtr(ImDrawList* self, const ImFont* font, float font_size, ImVec2 pos, ImU32 col, const char* text_begin) except +
    void ImDrawList_AddTextImFontPtrEx(ImDrawList* self, const ImFont* font, float font_size, ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end, float wrap_width, const ImVec4* cpu_fine_clip_rect) except +
    void ImDrawList_AddTriangle(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col) except +
    void ImDrawList_AddTriangleEx(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col, float thickness) except +
    void ImDrawList_AddTriangleFilled(ImDrawList* self, ImVec2 p1, ImVec2 p2, ImVec2 p3, ImU32 col) except +
    void ImDrawList_ChannelsMerge(ImDrawList* self) except +
    void ImDrawList_ChannelsSetCurrent(ImDrawList* self, int n) except +
    void ImDrawList_ChannelsSplit(ImDrawList* self, int count) except +
    ImDrawList* ImDrawList_CloneOutput(const ImDrawList* self) except +
    ImVec2 ImDrawList_GetClipRectMax(const ImDrawList* self) except +
    ImVec2 ImDrawList_GetClipRectMin(const ImDrawList* self) except +
    void ImDrawList_PathArcTo(ImDrawList* self, ImVec2 center, float radius, float a_min, float a_max, int num_segments) except +
    void ImDrawList_PathArcToFast(ImDrawList* self, ImVec2 center, float radius, int a_min_of_12, int a_max_of_12) except +
    void ImDrawList_PathBezierCubicCurveTo(ImDrawList* self, ImVec2 p2, ImVec2 p3, ImVec2 p4, int num_segments) except +
    void ImDrawList_PathBezierQuadraticCurveTo(ImDrawList* self, ImVec2 p2, ImVec2 p3, int num_segments) except +
    void ImDrawList_PathClear(ImDrawList* self) except +
    void ImDrawList_PathFillConvex(ImDrawList* self, ImU32 col) except +
    void ImDrawList_PathLineTo(ImDrawList* self, ImVec2 pos) except +
    void ImDrawList_PathLineToMergeDuplicate(ImDrawList* self, ImVec2 pos) except +
    void ImDrawList_PathRect(ImDrawList* self, ImVec2 rect_min, ImVec2 rect_max, float rounding, ImDrawFlags flags) except +
    void ImDrawList_PathStroke(ImDrawList* self, ImU32 col, ImDrawFlags flags, float thickness) except +
    void ImDrawList_PopClipRect(ImDrawList* self) except +
    void ImDrawList_PopTextureID(ImDrawList* self) except +
    void ImDrawList_PrimQuadUV(ImDrawList* self, ImVec2 a, ImVec2 b, ImVec2 c, ImVec2 d, ImVec2 uv_a, ImVec2 uv_b, ImVec2 uv_c, ImVec2 uv_d, ImU32 col) except +
    void ImDrawList_PrimRect(ImDrawList* self, ImVec2 a, ImVec2 b, ImU32 col) except +
    void ImDrawList_PrimRectUV(ImDrawList* self, ImVec2 a, ImVec2 b, ImVec2 uv_a, ImVec2 uv_b, ImU32 col) except +
    void ImDrawList_PrimReserve(ImDrawList* self, int idx_count, int vtx_count) except +
    void ImDrawList_PrimUnreserve(ImDrawList* self, int idx_count, int vtx_count) except +
    void ImDrawList_PrimVtx(ImDrawList* self, ImVec2 pos, ImVec2 uv, ImU32 col) except +
    void ImDrawList_PrimWriteIdx(ImDrawList* self, ImDrawIdx idx) except +
    void ImDrawList_PrimWriteVtx(ImDrawList* self, ImVec2 pos, ImVec2 uv, ImU32 col) except +
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
    void ImDrawList__ResetForNewFrame(ImDrawList* self) except +
    void ImDrawList__TryMergeDrawCmds(ImDrawList* self) except +
    bool ImFontAtlasCustomRect_IsPacked(const ImFontAtlasCustomRect* self) except +
    int ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas* self, ImFont* font, ImWchar id_, int width, int height, float advance_x, ImVec2 offset) except +
    int ImFontAtlas_AddCustomRectRegular(ImFontAtlas* self, int width, int height) except +
    ImFont* ImFontAtlas_AddFont(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontDefault(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontFromFileTTF(ImFontAtlas* self, const char* filename, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas* self, const char* compressed_font_data_base85, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas* self, const void* compressed_font_data, int compressed_font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas* self, void* font_data, int font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    bool ImFontAtlas_Build(ImFontAtlas* self) except +
    void ImFontAtlas_CalcCustomRectUV(const ImFontAtlas* self, const ImFontAtlasCustomRect* rect, ImVec2* out_uv_min, ImVec2* out_uv_max) except +
    void ImFontAtlas_Clear(ImFontAtlas* self) except +
    void ImFontAtlas_ClearFonts(ImFontAtlas* self) except +
    void ImFontAtlas_ClearInputData(ImFontAtlas* self) except +
    void ImFontAtlas_ClearTexData(ImFontAtlas* self) except +
    ImFontAtlasCustomRect* ImFontAtlas_GetCustomRectByIndex(ImFontAtlas* self, int index) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseFull(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesCyrillic(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesDefault(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesGreek(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesJapanese(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesKorean(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesThai(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesVietnamese(ImFontAtlas* self) except +
    bool ImFontAtlas_GetMouseCursorTexData(ImFontAtlas* self, ImGuiMouseCursor cursor, ImVec2* out_offset, ImVec2* out_size, ImVec2 out_uv_border, ImVec2 out_uv_fill) except +
    void ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +
    void ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +
    bool ImFontAtlas_IsBuilt(const ImFontAtlas* self) except +
    void ImFontAtlas_SetTexID(ImFontAtlas* self, ImTextureID id_) except +
    void ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder* self, ImWchar c) except +
    void ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder* self, const ImWchar* ranges) except +
    void ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder* self, const char* text, const char* text_end) except +
    void ImFontGlyphRangesBuilder_BuildRanges(ImFontGlyphRangesBuilder* self, ImVector_ImWchar* out_ranges) except +
    void ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder* self) except +
    bool ImFontGlyphRangesBuilder_GetBit(const ImFontGlyphRangesBuilder* self, size_t n) except +
    void ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder* self, size_t n) except +
    void ImFont_AddGlyph(ImFont* self, const ImFontConfig* src_cfg, ImWchar c, float x0, float y0, float x1, float y1, float u0, float v0, float u1, float v1, float advance_x) except +
    void ImFont_AddRemapChar(ImFont* self, ImWchar dst, ImWchar src, bool overwrite_dst) except +
    void ImFont_BuildLookupTable(ImFont* self) except +
    ImVec2 ImFont_CalcTextSizeA(const ImFont* self, float size, float max_width, float wrap_width, const char* text_begin) except +
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
    void ImGuiIO_AddFocusEvent(ImGuiIO* self, bool focused) except +
    void ImGuiIO_AddInputCharacter(ImGuiIO* self, unsigned int c) except +
    void ImGuiIO_AddInputCharacterUTF16(ImGuiIO* self, ImWchar16 c) except +
    void ImGuiIO_AddInputCharactersUTF8(ImGuiIO* self, const char* str_) except +
    void ImGuiIO_AddKeyAnalogEvent(ImGuiIO* self, ImGuiKey key, bool down, float v) except +
    void ImGuiIO_AddKeyEvent(ImGuiIO* self, ImGuiKey key, bool down) except +
    void ImGuiIO_AddMouseButtonEvent(ImGuiIO* self, int button, bool down) except +
    void ImGuiIO_AddMousePosEvent(ImGuiIO* self, float x, float y) except +
    void ImGuiIO_AddMouseViewportEvent(ImGuiIO* self, ImGuiID id_) except +
    void ImGuiIO_AddMouseWheelEvent(ImGuiIO* self, float wheel_x, float wheel_y) except +
    void ImGuiIO_ClearInputCharacters(ImGuiIO* self) except +
    void ImGuiIO_ClearInputKeys(ImGuiIO* self) except +
    void ImGuiIO_SetAppAcceptingEvents(ImGuiIO* self, bool accepting_events) except +
    void ImGuiIO_SetKeyEventNativeData(ImGuiIO* self, ImGuiKey key, int native_keycode, int native_scancode) except +
    void ImGuiIO_SetKeyEventNativeDataEx(ImGuiIO* self, ImGuiKey key, int native_keycode, int native_scancode, int native_legacy_index) except +
    void ImGuiInputTextCallbackData_ClearSelection(ImGuiInputTextCallbackData* self) except +
    void ImGuiInputTextCallbackData_DeleteChars(ImGuiInputTextCallbackData* self, int pos, int bytes_count) except +
    bool ImGuiInputTextCallbackData_HasSelection(const ImGuiInputTextCallbackData* self) except +
    void ImGuiInputTextCallbackData_InsertChars(ImGuiInputTextCallbackData* self, int pos, const char* text, const char* text_end) except +
    void ImGuiInputTextCallbackData_SelectAll(ImGuiInputTextCallbackData* self) except +
    void ImGuiListClipper_Begin(ImGuiListClipper* self, int items_count, float items_height) except +
    void ImGuiListClipper_End(ImGuiListClipper* self) except +
    void ImGuiListClipper_ForceDisplayRangeByIndices(ImGuiListClipper* self, int item_min, int item_max) except +
    bool ImGuiListClipper_Step(ImGuiListClipper* self) except +
    void ImGuiPayload_Clear(ImGuiPayload* self) except +
    bool ImGuiPayload_IsDataType(const ImGuiPayload* self, const char* type_) except +
    bool ImGuiPayload_IsDelivery(const ImGuiPayload* self) except +
    bool ImGuiPayload_IsPreview(const ImGuiPayload* self) except +
    void ImGuiStorage_BuildSortByKey(ImGuiStorage* self) except +
    void ImGuiStorage_Clear(ImGuiStorage* self) except +
    bool ImGuiStorage_GetBool(const ImGuiStorage* self, ImGuiID key, bool default_val) except +
    bool* ImGuiStorage_GetBoolRef(ImGuiStorage* self, ImGuiID key, bool default_val) except +
    float ImGuiStorage_GetFloat(const ImGuiStorage* self, ImGuiID key, float default_val) except +
    float* ImGuiStorage_GetFloatRef(ImGuiStorage* self, ImGuiID key, float default_val) except +
    int ImGuiStorage_GetInt(const ImGuiStorage* self, ImGuiID key, int default_val) except +
    int* ImGuiStorage_GetIntRef(ImGuiStorage* self, ImGuiID key, int default_val) except +
    void* ImGuiStorage_GetVoidPtr(const ImGuiStorage* self, ImGuiID key) except +
    void** ImGuiStorage_GetVoidPtrRef(ImGuiStorage* self, ImGuiID key, void* default_val) except +
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
    const char* ImGuiTextBuffer_end(const ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_reserve(ImGuiTextBuffer* self, int capacity) except +
    int ImGuiTextBuffer_size(const ImGuiTextBuffer* self) except +
    void ImGuiTextFilter_Build(ImGuiTextFilter* self) except +
    void ImGuiTextFilter_Clear(ImGuiTextFilter* self) except +
    bool ImGuiTextFilter_Draw(ImGuiTextFilter* self, const char* label, float width) except +
    bool ImGuiTextFilter_ImGuiTextRange_empty(const ImGuiTextFilter_ImGuiTextRange* self) except +
    void ImGuiTextFilter_ImGuiTextRange_split(const ImGuiTextFilter_ImGuiTextRange* self, char separator, ImVector_ImGuiTextFilter_ImGuiTextRange* out) except +
    bool ImGuiTextFilter_IsActive(const ImGuiTextFilter* self) except +
    bool ImGuiTextFilter_PassFilter(const ImGuiTextFilter* self, const char* text, const char* text_end) except +
    ImVec2 ImGuiViewport_GetCenter(const ImGuiViewport* self) except +
    ImVec2 ImGuiViewport_GetWorkCenter(const ImGuiViewport* self) except +
    const ImGuiPayload* ImGui_AcceptDragDropPayload(const char* type_, ImGuiDragDropFlags flags) except +
    void ImGui_AlignTextToFramePadding() except +
    bool ImGui_ArrowButton(const char* str_id, ImGuiDir dir_) except +
    bool ImGui_Begin(const char* name, bool* p_open, ImGuiWindowFlags flags) except +
    bool ImGui_BeginChild(const char* str_id, ImVec2 size, bool border, ImGuiWindowFlags flags) except +
    bool ImGui_BeginChildFrame(ImGuiID id_, ImVec2 size, ImGuiWindowFlags flags) except +
    bool ImGui_BeginChildID(ImGuiID id_, ImVec2 size, bool border, ImGuiWindowFlags flags) except +
    bool ImGui_BeginCombo(const char* label, const char* preview_value, ImGuiComboFlags flags) except +
    void ImGui_BeginDisabled(bool disabled) except +
    bool ImGui_BeginDragDropSource(ImGuiDragDropFlags flags) except +
    bool ImGui_BeginDragDropTarget() except +
    void ImGui_BeginGroup() except +
    bool ImGui_BeginListBox(const char* label, ImVec2 size) except +
    bool ImGui_BeginMainMenuBar() except +
    bool ImGui_BeginMenu(const char* label) except +
    bool ImGui_BeginMenuBar() except +
    bool ImGui_BeginMenuEx(const char* label, bool enabled) except +
    bool ImGui_BeginPopup(const char* str_id, ImGuiWindowFlags flags) except +
    bool ImGui_BeginPopupContextItem() except +
    bool ImGui_BeginPopupContextItemEx(const char* str_id, ImGuiPopupFlags popup_flags) except +
    bool ImGui_BeginPopupContextVoid() except +
    bool ImGui_BeginPopupContextVoidEx(const char* str_id, ImGuiPopupFlags popup_flags) except +
    bool ImGui_BeginPopupContextWindow() except +
    bool ImGui_BeginPopupContextWindowEx(const char* str_id, ImGuiPopupFlags popup_flags) except +
    bool ImGui_BeginPopupModal(const char* name, bool* p_open, ImGuiWindowFlags flags) except +
    bool ImGui_BeginTabBar(const char* str_id, ImGuiTabBarFlags flags) except +
    bool ImGui_BeginTabItem(const char* label, bool* p_open, ImGuiTabItemFlags flags) except +
    bool ImGui_BeginTable(const char* str_id, int column, ImGuiTableFlags flags) except +
    bool ImGui_BeginTableEx(const char* str_id, int column, ImGuiTableFlags flags, ImVec2 outer_size, float inner_width) except +
    bool ImGui_BeginTooltip() except +
    void ImGui_Bullet() except +
    void ImGui_BulletText(const char* fmt) except +
    void ImGui_BulletTextV(const char* fmt) except +
    bool ImGui_Button(const char* label) except +
    bool ImGui_ButtonEx(const char* label, ImVec2 size) except +
    float ImGui_CalcItemWidth() except +
    ImVec2 ImGui_CalcTextSize(const char* text) except +
    ImVec2 ImGui_CalcTextSizeEx(const char* text, const char* text_end, bool hide_text_after_double_hash, float wrap_width) except +
    bool ImGui_Checkbox(const char* label, bool* v) except +
    bool ImGui_CheckboxFlagsIntPtr(const char* label, int* flags, int flags_value) except +
    bool ImGui_CheckboxFlagsUintPtr(const char* label, unsigned int* flags, unsigned int flags_value) except +
    void ImGui_CloseCurrentPopup() except +
    bool ImGui_CollapsingHeader(const char* label, ImGuiTreeNodeFlags flags) except +
    bool ImGui_CollapsingHeaderBoolPtr(const char* label, bool* p_visible, ImGuiTreeNodeFlags flags) except +
    bool ImGui_ColorButton(const char* desc_id, ImVec4 col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorButtonEx(const char* desc_id, ImVec4 col, ImGuiColorEditFlags flags, ImVec2 size) except +
    ImU32 ImGui_ColorConvertFloat4ToU32(ImVec4 in_) except +
    void ImGui_ColorConvertHSVtoRGB(float h, float s, float v, float* out_r, float* out_g, float* out_b) except +
    void ImGui_ColorConvertRGBtoHSV(float r, float g, float b, float* out_h, float* out_s, float* out_v) except +
    ImVec4 ImGui_ColorConvertU32ToFloat4(ImU32 in_) except +
    bool ImGui_ColorEdit3(const char* label, float col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorEdit4(const char* label, float col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorPicker3(const char* label, float col, ImGuiColorEditFlags flags) except +
    bool ImGui_ColorPicker4(const char* label, float col, ImGuiColorEditFlags flags, const float* ref_col) except +
    void ImGui_Columns() except +
    void ImGui_ColumnsEx(int count, const char* id_, bool border) except +
    bool ImGui_Combo(const char* label, int* current_item, const char* items_separated_by_zeros) except +
    bool ImGui_ComboCallback(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count) except +
    bool ImGui_ComboCallbackEx(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int popup_max_height_in_items) except +
    bool ImGui_ComboChar(const char* label, int* current_item, const char* items, int items_count) except +
    bool ImGui_ComboCharEx(const char* label, int* current_item, const char* items, int items_count, int popup_max_height_in_items) except +
    bool ImGui_ComboEx(const char* label, int* current_item, const char* items_separated_by_zeros, int popup_max_height_in_items) except +
    ImGuiContext* ImGui_CreateContext(ImFontAtlas* shared_font_atlas) except +
    bool ImGui_DebugCheckVersionAndDataLayout(const char* version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx) except +
    void ImGui_DebugTextEncoding(const char* text) except +
    void ImGui_DestroyContext(ImGuiContext* ctx) except +
    void ImGui_DestroyPlatformWindows() except +
    ImGuiID ImGui_DockSpace(ImGuiID id_) except +
    ImGuiID ImGui_DockSpaceEx(ImGuiID id_, ImVec2 size, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +
    ImGuiID ImGui_DockSpaceOverViewport() except +
    ImGuiID ImGui_DockSpaceOverViewportEx(const ImGuiViewport* viewport, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +
    bool ImGui_DragFloat(const char* label, float* v) except +
    bool ImGui_DragFloat2(const char* label, float v) except +
    bool ImGui_DragFloat2Ex(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_DragFloat3(const char* label, float v) except +
    bool ImGui_DragFloat3Ex(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_DragFloat4(const char* label, float v) except +
    bool ImGui_DragFloat4Ex(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_DragFloatEx(const char* label, float* v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_DragFloatRange2(const char* label, float* v_current_min, float* v_current_max) except +
    bool ImGui_DragFloatRange2Ex(const char* label, float* v_current_min, float* v_current_max, float v_speed, float v_min, float v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +
    bool ImGui_DragInt(const char* label, int* v) except +
    bool ImGui_DragInt2(const char* label, int v) except +
    bool ImGui_DragInt2Ex(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_DragInt3(const char* label, int v) except +
    bool ImGui_DragInt3Ex(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_DragInt4(const char* label, int v) except +
    bool ImGui_DragInt4Ex(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_DragIntEx(const char* label, int* v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_DragIntRange2(const char* label, int* v_current_min, int* v_current_max) except +
    bool ImGui_DragIntRange2Ex(const char* label, int* v_current_min, int* v_current_max, float v_speed, int v_min, int v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +
    bool ImGui_DragScalar(const char* label, ImGuiDataType data_type, void* p_data) except +
    bool ImGui_DragScalarEx(const char* label, ImGuiDataType data_type, void* p_data, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_DragScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components) except +
    bool ImGui_DragScalarNEx(const char* label, ImGuiDataType data_type, void* p_data, int components, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    void ImGui_Dummy(ImVec2 size) except +
    void ImGui_End() except +
    void ImGui_EndChild() except +
    void ImGui_EndChildFrame() except +
    void ImGui_EndCombo() except +
    void ImGui_EndDisabled() except +
    void ImGui_EndDragDropSource() except +
    void ImGui_EndDragDropTarget() except +
    void ImGui_EndFrame() except +
    void ImGui_EndGroup() except +
    void ImGui_EndListBox() except +
    void ImGui_EndMainMenuBar() except +
    void ImGui_EndMenu() except +
    void ImGui_EndMenuBar() except +
    void ImGui_EndPopup() except +
    void ImGui_EndTabBar() except +
    void ImGui_EndTabItem() except +
    void ImGui_EndTable() except +
    void ImGui_EndTooltip() except +
    ImGuiViewport* ImGui_FindViewportByID(ImGuiID id_) except +
    ImGuiViewport* ImGui_FindViewportByPlatformHandle(void* platform_handle) except +
    void ImGui_GetAllocatorFunctions(ImGuiMemAllocFunc* p_alloc_func, ImGuiMemFreeFunc* p_free_func, void** p_user_data) except +
    ImDrawList* ImGui_GetBackgroundDrawList() except +
    ImDrawList* ImGui_GetBackgroundDrawListImGuiViewportPtr(ImGuiViewport* viewport) except +
    const char* ImGui_GetClipboardText() except +
    ImU32 ImGui_GetColorU32(ImGuiCol idx) except +
    ImU32 ImGui_GetColorU32Ex(ImGuiCol idx, float alpha_mul) except +
    ImU32 ImGui_GetColorU32ImU32(ImU32 col) except +
    ImU32 ImGui_GetColorU32ImVec4(ImVec4 col) except +
    int ImGui_GetColumnIndex() except +
    float ImGui_GetColumnOffset(int column_index) except +
    float ImGui_GetColumnWidth(int column_index) except +
    int ImGui_GetColumnsCount() except +
    ImVec2 ImGui_GetContentRegionAvail() except +
    ImVec2 ImGui_GetContentRegionMax() except +
    ImGuiContext* ImGui_GetCurrentContext() except +
    ImVec2 ImGui_GetCursorPos() except +
    float ImGui_GetCursorPosX() except +
    float ImGui_GetCursorPosY() except +
    ImVec2 ImGui_GetCursorScreenPos() except +
    ImVec2 ImGui_GetCursorStartPos() except +
    const ImGuiPayload* ImGui_GetDragDropPayload() except +
    ImDrawData* ImGui_GetDrawData() except +
    ImDrawListSharedData* ImGui_GetDrawListSharedData() except +
    ImFont* ImGui_GetFont() except +
    float ImGui_GetFontSize() except +
    ImVec2 ImGui_GetFontTexUvWhitePixel() except +
    ImDrawList* ImGui_GetForegroundDrawList() except +
    ImDrawList* ImGui_GetForegroundDrawListImGuiViewportPtr(ImGuiViewport* viewport) except +
    int ImGui_GetFrameCount() except +
    float ImGui_GetFrameHeight() except +
    float ImGui_GetFrameHeightWithSpacing() except +
    ImGuiID ImGui_GetID(const char* str_id) except +
    ImGuiID ImGui_GetIDPtr(const void* ptr_id) except +
    ImGuiID ImGui_GetIDStr(const char* str_id_begin, const char* str_id_end) except +
    ImGuiIO* ImGui_GetIO() except +
    ImGuiID ImGui_GetItemID() except +
    ImVec2 ImGui_GetItemRectMax() except +
    ImVec2 ImGui_GetItemRectMin() except +
    ImVec2 ImGui_GetItemRectSize() except +
    const char* ImGui_GetKeyName(ImGuiKey key) except +
    int ImGui_GetKeyPressedAmount(ImGuiKey key, float repeat_delay, float rate) except +
    ImGuiViewport* ImGui_GetMainViewport() except +
    int ImGui_GetMouseClickedCount(ImGuiMouseButton button) except +
    ImGuiMouseCursor ImGui_GetMouseCursor() except +
    ImVec2 ImGui_GetMouseDragDelta(ImGuiMouseButton button, float lock_threshold) except +
    ImVec2 ImGui_GetMousePos() except +
    ImVec2 ImGui_GetMousePosOnOpeningCurrentPopup() except +
    ImGuiPlatformIO* ImGui_GetPlatformIO() except +
    float ImGui_GetScrollMaxX() except +
    float ImGui_GetScrollMaxY() except +
    float ImGui_GetScrollX() except +
    float ImGui_GetScrollY() except +
    ImGuiStorage* ImGui_GetStateStorage() except +
    ImGuiStyle* ImGui_GetStyle() except +
    const char* ImGui_GetStyleColorName(ImGuiCol idx) except +
    const ImVec4* ImGui_GetStyleColorVec4(ImGuiCol idx) except +
    float ImGui_GetTextLineHeight() except +
    float ImGui_GetTextLineHeightWithSpacing() except +
    double ImGui_GetTime() except +
    float ImGui_GetTreeNodeToLabelSpacing() except +
    const char* ImGui_GetVersion() except +
    ImVec2 ImGui_GetWindowContentRegionMax() except +
    ImVec2 ImGui_GetWindowContentRegionMin() except +
    ImGuiID ImGui_GetWindowDockID() except +
    float ImGui_GetWindowDpiScale() except +
    ImDrawList* ImGui_GetWindowDrawList() except +
    float ImGui_GetWindowHeight() except +
    ImVec2 ImGui_GetWindowPos() except +
    ImVec2 ImGui_GetWindowSize() except +
    ImGuiViewport* ImGui_GetWindowViewport() except +
    float ImGui_GetWindowWidth() except +
    void ImGui_Image(ImTextureID user_texture_id, ImVec2 size) except +
    bool ImGui_ImageButton(const char* str_id, ImTextureID user_texture_id, ImVec2 size) except +
    bool ImGui_ImageButtonEx(const char* str_id, ImTextureID user_texture_id, ImVec2 size, ImVec2 uv0, ImVec2 uv1, ImVec4 bg_col, ImVec4 tint_col) except +
    void ImGui_ImageEx(ImTextureID user_texture_id, ImVec2 size, ImVec2 uv0, ImVec2 uv1, ImVec4 tint_col, ImVec4 border_col) except +
    void ImGui_Indent() except +
    void ImGui_IndentEx(float indent_w) except +
    bool ImGui_InputDouble(const char* label, double* v) except +
    bool ImGui_InputDoubleEx(const char* label, double* v, double step, double step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool ImGui_InputFloat(const char* label, float* v) except +
    bool ImGui_InputFloat2(const char* label, float v) except +
    bool ImGui_InputFloat2Ex(const char* label, float v, const char* format_, ImGuiInputTextFlags flags) except +
    bool ImGui_InputFloat3(const char* label, float v) except +
    bool ImGui_InputFloat3Ex(const char* label, float v, const char* format_, ImGuiInputTextFlags flags) except +
    bool ImGui_InputFloat4(const char* label, float v) except +
    bool ImGui_InputFloat4Ex(const char* label, float v, const char* format_, ImGuiInputTextFlags flags) except +
    bool ImGui_InputFloatEx(const char* label, float* v, float step, float step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool ImGui_InputInt(const char* label, int* v) except +
    bool ImGui_InputInt2(const char* label, int v, ImGuiInputTextFlags flags) except +
    bool ImGui_InputInt3(const char* label, int v, ImGuiInputTextFlags flags) except +
    bool ImGui_InputInt4(const char* label, int v, ImGuiInputTextFlags flags) except +
    bool ImGui_InputIntEx(const char* label, int* v, int step, int step_fast, ImGuiInputTextFlags flags) except +
    bool ImGui_InputScalar(const char* label, ImGuiDataType data_type, void* p_data) except +
    bool ImGui_InputScalarEx(const char* label, ImGuiDataType data_type, void* p_data, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool ImGui_InputScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components) except +
    bool ImGui_InputScalarNEx(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool ImGui_InputText(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags) except +
    bool ImGui_InputTextEx(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +
    bool ImGui_InputTextMultiline(const char* label, char* buf, size_t buf_size) except +
    bool ImGui_InputTextMultilineEx(const char* label, char* buf, size_t buf_size, ImVec2 size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +
    bool ImGui_InputTextWithHint(const char* label, const char* hint, char* buf, size_t buf_size, ImGuiInputTextFlags flags) except +
    bool ImGui_InputTextWithHintEx(const char* label, const char* hint, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +
    bool ImGui_InvisibleButton(const char* str_id, ImVec2 size, ImGuiButtonFlags flags) except +
    bool ImGui_IsAnyItemActive() except +
    bool ImGui_IsAnyItemFocused() except +
    bool ImGui_IsAnyItemHovered() except +
    bool ImGui_IsAnyMouseDown() except +
    bool ImGui_IsItemActivated() except +
    bool ImGui_IsItemActive() except +
    bool ImGui_IsItemClicked() except +
    bool ImGui_IsItemClickedEx(ImGuiMouseButton mouse_button) except +
    bool ImGui_IsItemDeactivated() except +
    bool ImGui_IsItemDeactivatedAfterEdit() except +
    bool ImGui_IsItemEdited() except +
    bool ImGui_IsItemFocused() except +
    bool ImGui_IsItemHovered(ImGuiHoveredFlags flags) except +
    bool ImGui_IsItemToggledOpen() except +
    bool ImGui_IsItemVisible() except +
    bool ImGui_IsKeyDown(ImGuiKey key) except +
    bool ImGui_IsKeyPressed(ImGuiKey key) except +
    bool ImGui_IsKeyPressedEx(ImGuiKey key, bool repeat) except +
    bool ImGui_IsKeyReleased(ImGuiKey key) except +
    bool ImGui_IsMouseClicked(ImGuiMouseButton button) except +
    bool ImGui_IsMouseClickedEx(ImGuiMouseButton button, bool repeat) except +
    bool ImGui_IsMouseDoubleClicked(ImGuiMouseButton button) except +
    bool ImGui_IsMouseDown(ImGuiMouseButton button) except +
    bool ImGui_IsMouseDragging(ImGuiMouseButton button, float lock_threshold) except +
    bool ImGui_IsMouseHoveringRect(ImVec2 r_min, ImVec2 r_max) except +
    bool ImGui_IsMouseHoveringRectEx(ImVec2 r_min, ImVec2 r_max, bool clip) except +
    bool ImGui_IsMousePosValid(const ImVec2* mouse_pos) except +
    bool ImGui_IsMouseReleased(ImGuiMouseButton button) except +
    bool ImGui_IsPopupOpen(const char* str_id, ImGuiPopupFlags flags) except +
    bool ImGui_IsRectVisible(ImVec2 rect_min, ImVec2 rect_max) except +
    bool ImGui_IsRectVisibleBySize(ImVec2 size) except +
    bool ImGui_IsWindowAppearing() except +
    bool ImGui_IsWindowCollapsed() except +
    bool ImGui_IsWindowDocked() except +
    bool ImGui_IsWindowFocused(ImGuiFocusedFlags flags) except +
    bool ImGui_IsWindowHovered(ImGuiHoveredFlags flags) except +
    void ImGui_LabelText(const char* label, const char* fmt) except +
    void ImGui_LabelTextV(const char* label, const char* fmt) except +
    bool ImGui_ListBox(const char* label, int* current_item, const char* items, int items_count, int height_in_items) except +
    bool ImGui_ListBoxCallback(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count) except +
    bool ImGui_ListBoxCallbackEx(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int height_in_items) except +
    void ImGui_LoadIniSettingsFromDisk(const char* ini_filename) except +
    void ImGui_LoadIniSettingsFromMemory(const char* ini_data, size_t ini_size) except +
    void ImGui_LogButtons() except +
    void ImGui_LogFinish() except +
    void ImGui_LogText(const char* fmt) except +
    void ImGui_LogTextV(const char* fmt) except +
    void ImGui_LogToClipboard(int auto_open_depth) except +
    void ImGui_LogToFile(int auto_open_depth, const char* filename) except +
    void ImGui_LogToTTY(int auto_open_depth) except +
    void* ImGui_MemAlloc(size_t size) except +
    void ImGui_MemFree(void* ptr) except +
    bool ImGui_MenuItem(const char* label) except +
    bool ImGui_MenuItemBoolPtr(const char* label, const char* shortcut, bool* p_selected, bool enabled) except +
    bool ImGui_MenuItemEx(const char* label, const char* shortcut, bool selected, bool enabled) except +
    void ImGui_NewFrame() except +
    void ImGui_NewLine() except +
    void ImGui_NextColumn() except +
    void ImGui_OpenPopup(const char* str_id, ImGuiPopupFlags popup_flags) except +
    void ImGui_OpenPopupID(ImGuiID id_, ImGuiPopupFlags popup_flags) except +
    void ImGui_OpenPopupOnItemClick(const char* str_id, ImGuiPopupFlags popup_flags) except +
    void ImGui_PlotHistogram(const char* label, const float* values, int values_count) except +
    void ImGui_PlotHistogramCallback(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count) except +
    void ImGui_PlotHistogramCallbackEx(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void ImGui_PlotHistogramEx(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +
    void ImGui_PlotLines(const char* label, const float* values, int values_count) except +
    void ImGui_PlotLinesCallback(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count) except +
    void ImGui_PlotLinesCallbackEx(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void ImGui_PlotLinesEx(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +
    void ImGui_PopButtonRepeat() except +
    void ImGui_PopClipRect() except +
    void ImGui_PopFont() except +
    void ImGui_PopID() except +
    void ImGui_PopItemWidth() except +
    void ImGui_PopStyleColor() except +
    void ImGui_PopStyleColorEx(int count) except +
    void ImGui_PopStyleVar() except +
    void ImGui_PopStyleVarEx(int count) except +
    void ImGui_PopTabStop() except +
    void ImGui_PopTextWrapPos() except +
    void ImGui_ProgressBar(float fraction, ImVec2 size_arg, const char* overlay) except +
    void ImGui_PushButtonRepeat(bool repeat) except +
    void ImGui_PushClipRect(ImVec2 clip_rect_min, ImVec2 clip_rect_max, bool intersect_with_current_clip_rect) except +
    void ImGui_PushFont(ImFont* font) except +
    void ImGui_PushID(const char* str_id) except +
    void ImGui_PushIDInt(int int_id) except +
    void ImGui_PushIDPtr(const void* ptr_id) except +
    void ImGui_PushIDStr(const char* str_id_begin, const char* str_id_end) except +
    void ImGui_PushItemWidth(float item_width) except +
    void ImGui_PushStyleColor(ImGuiCol idx, ImU32 col) except +
    void ImGui_PushStyleColorImVec4(ImGuiCol idx, ImVec4 col) except +
    void ImGui_PushStyleVar(ImGuiStyleVar idx, float val) except +
    void ImGui_PushStyleVarImVec2(ImGuiStyleVar idx, ImVec2 val) except +
    void ImGui_PushTabStop(bool tab_stop) except +
    void ImGui_PushTextWrapPos(float wrap_local_pos_x) except +
    bool ImGui_RadioButton(const char* label, bool active) except +
    bool ImGui_RadioButtonIntPtr(const char* label, int* v, int v_button) except +
    void ImGui_Render() except +
    void ImGui_RenderPlatformWindowsDefault() except +
    void ImGui_RenderPlatformWindowsDefaultEx(void* platform_render_arg, void* renderer_render_arg) except +
    void ImGui_ResetMouseDragDelta() except +
    void ImGui_ResetMouseDragDeltaEx(ImGuiMouseButton button) except +
    void ImGui_SameLine() except +
    void ImGui_SameLineEx(float offset_from_start_x, float spacing) except +
    void ImGui_SaveIniSettingsToDisk(const char* ini_filename) except +
    const char* ImGui_SaveIniSettingsToMemory(size_t* out_ini_size) except +
    bool ImGui_Selectable(const char* label) except +
    bool ImGui_SelectableBoolPtr(const char* label, bool* p_selected, ImGuiSelectableFlags flags) except +
    bool ImGui_SelectableBoolPtrEx(const char* label, bool* p_selected, ImGuiSelectableFlags flags, ImVec2 size) except +
    bool ImGui_SelectableEx(const char* label, bool selected, ImGuiSelectableFlags flags, ImVec2 size) except +
    void ImGui_Separator() except +
    void ImGui_SeparatorText(const char* label) except +
    void ImGui_SetAllocatorFunctions(ImGuiMemAllocFunc alloc_func, ImGuiMemFreeFunc free_func, void* user_data) except +
    void ImGui_SetClipboardText(const char* text) except +
    void ImGui_SetColorEditOptions(ImGuiColorEditFlags flags) except +
    void ImGui_SetColumnOffset(int column_index, float offset_x) except +
    void ImGui_SetColumnWidth(int column_index, float width) except +
    void ImGui_SetCurrentContext(ImGuiContext* ctx) except +
    void ImGui_SetCursorPos(ImVec2 local_pos) except +
    void ImGui_SetCursorPosX(float local_x) except +
    void ImGui_SetCursorPosY(float local_y) except +
    void ImGui_SetCursorScreenPos(ImVec2 pos) except +
    bool ImGui_SetDragDropPayload(const char* type_, const void* data, size_t sz, ImGuiCond cond) except +
    void ImGui_SetItemAllowOverlap() except +
    void ImGui_SetItemDefaultFocus() except +
    void ImGui_SetKeyboardFocusHere() except +
    void ImGui_SetKeyboardFocusHereEx(int offset) except +
    void ImGui_SetMouseCursor(ImGuiMouseCursor cursor_type) except +
    void ImGui_SetNextFrameWantCaptureKeyboard(bool want_capture_keyboard) except +
    void ImGui_SetNextFrameWantCaptureMouse(bool want_capture_mouse) except +
    void ImGui_SetNextItemOpen(bool is_open, ImGuiCond cond) except +
    void ImGui_SetNextItemWidth(float item_width) except +
    void ImGui_SetNextWindowBgAlpha(float alpha) except +
    void ImGui_SetNextWindowClass(const ImGuiWindowClass* window_class) except +
    void ImGui_SetNextWindowCollapsed(bool collapsed, ImGuiCond cond) except +
    void ImGui_SetNextWindowContentSize(ImVec2 size) except +
    void ImGui_SetNextWindowDockID(ImGuiID dock_id, ImGuiCond cond) except +
    void ImGui_SetNextWindowFocus() except +
    void ImGui_SetNextWindowPos(ImVec2 pos, ImGuiCond cond) except +
    void ImGui_SetNextWindowPosEx(ImVec2 pos, ImGuiCond cond, ImVec2 pivot) except +
    void ImGui_SetNextWindowScroll(ImVec2 scroll) except +
    void ImGui_SetNextWindowSize(ImVec2 size, ImGuiCond cond) except +
    void ImGui_SetNextWindowSizeConstraints(ImVec2 size_min, ImVec2 size_max, ImGuiSizeCallback custom_callback, void* custom_callback_data) except +
    void ImGui_SetNextWindowViewport(ImGuiID viewport_id) except +
    void ImGui_SetScrollFromPosX(float local_x, float center_x_ratio) except +
    void ImGui_SetScrollFromPosY(float local_y, float center_y_ratio) except +
    void ImGui_SetScrollHereX(float center_x_ratio) except +
    void ImGui_SetScrollHereY(float center_y_ratio) except +
    void ImGui_SetScrollX(float scroll_x) except +
    void ImGui_SetScrollY(float scroll_y) except +
    void ImGui_SetStateStorage(ImGuiStorage* storage) except +
    void ImGui_SetTabItemClosed(const char* tab_or_docked_window_label) except +
    void ImGui_SetTooltip(const char* fmt) except +
    void ImGui_SetTooltipV(const char* fmt) except +
    void ImGui_SetWindowCollapsed(bool collapsed, ImGuiCond cond) except +
    void ImGui_SetWindowCollapsedStr(const char* name, bool collapsed, ImGuiCond cond) except +
    void ImGui_SetWindowFocus() except +
    void ImGui_SetWindowFocusStr(const char* name) except +
    void ImGui_SetWindowFontScale(float scale) except +
    void ImGui_SetWindowPos(ImVec2 pos, ImGuiCond cond) except +
    void ImGui_SetWindowPosStr(const char* name, ImVec2 pos, ImGuiCond cond) except +
    void ImGui_SetWindowSize(ImVec2 size, ImGuiCond cond) except +
    void ImGui_SetWindowSizeStr(const char* name, ImVec2 size, ImGuiCond cond) except +
    void ImGui_ShowAboutWindow(bool* p_open) except +
    void ImGui_ShowDebugLogWindow(bool* p_open) except +
    void ImGui_ShowDemoWindow(bool* p_open) except +
    void ImGui_ShowFontSelector(const char* label) except +
    void ImGui_ShowMetricsWindow(bool* p_open) except +
    void ImGui_ShowStackToolWindow(bool* p_open) except +
    void ImGui_ShowStyleEditor(ImGuiStyle* ref) except +
    bool ImGui_ShowStyleSelector(const char* label) except +
    void ImGui_ShowUserGuide() except +
    bool ImGui_SliderAngle(const char* label, float* v_rad) except +
    bool ImGui_SliderAngleEx(const char* label, float* v_rad, float v_degrees_min, float v_degrees_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderFloat(const char* label, float* v, float v_min, float v_max) except +
    bool ImGui_SliderFloat2(const char* label, float v, float v_min, float v_max) except +
    bool ImGui_SliderFloat2Ex(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderFloat3(const char* label, float v, float v_min, float v_max) except +
    bool ImGui_SliderFloat3Ex(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderFloat4(const char* label, float v, float v_min, float v_max) except +
    bool ImGui_SliderFloat4Ex(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderFloatEx(const char* label, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderInt(const char* label, int* v, int v_min, int v_max) except +
    bool ImGui_SliderInt2(const char* label, int v, int v_min, int v_max) except +
    bool ImGui_SliderInt2Ex(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderInt3(const char* label, int v, int v_min, int v_max) except +
    bool ImGui_SliderInt3Ex(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderInt4(const char* label, int v, int v_min, int v_max) except +
    bool ImGui_SliderInt4Ex(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderIntEx(const char* label, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderScalar(const char* label, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max) except +
    bool ImGui_SliderScalarEx(const char* label, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SliderScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_min, const void* p_max) except +
    bool ImGui_SliderScalarNEx(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_SmallButton(const char* label) except +
    void ImGui_Spacing() except +
    void ImGui_StyleColorsClassic(ImGuiStyle* dst) except +
    void ImGui_StyleColorsDark(ImGuiStyle* dst) except +
    void ImGui_StyleColorsLight(ImGuiStyle* dst) except +
    bool ImGui_TabItemButton(const char* label, ImGuiTabItemFlags flags) except +
    int ImGui_TableGetColumnCount() except +
    ImGuiTableColumnFlags ImGui_TableGetColumnFlags(int column_n) except +
    int ImGui_TableGetColumnIndex() except +
    const char* ImGui_TableGetColumnName(int column_n) except +
    int ImGui_TableGetRowIndex() except +
    ImGuiTableSortSpecs* ImGui_TableGetSortSpecs() except +
    void ImGui_TableHeader(const char* label) except +
    void ImGui_TableHeadersRow() except +
    bool ImGui_TableNextColumn() except +
    void ImGui_TableNextRow() except +
    void ImGui_TableNextRowEx(ImGuiTableRowFlags row_flags, float min_row_height) except +
    void ImGui_TableSetBgColor(ImGuiTableBgTarget target, ImU32 color, int column_n) except +
    void ImGui_TableSetColumnEnabled(int column_n, bool v) except +
    bool ImGui_TableSetColumnIndex(int column_n) except +
    void ImGui_TableSetupColumn(const char* label, ImGuiTableColumnFlags flags) except +
    void ImGui_TableSetupColumnEx(const char* label, ImGuiTableColumnFlags flags, float init_width_or_weight, ImGuiID user_id) except +
    void ImGui_TableSetupScrollFreeze(int cols, int rows) except +
    void ImGui_Text(const char* fmt) except +
    void ImGui_TextColored(ImVec4 col, const char* fmt) except +
    void ImGui_TextColoredV(ImVec4 col, const char* fmt) except +
    void ImGui_TextDisabled(const char* fmt) except +
    void ImGui_TextDisabledV(const char* fmt) except +
    void ImGui_TextUnformatted(const char* text) except +
    void ImGui_TextUnformattedEx(const char* text, const char* text_end) except +
    void ImGui_TextV(const char* fmt) except +
    void ImGui_TextWrapped(const char* fmt) except +
    void ImGui_TextWrappedV(const char* fmt) except +
    bool ImGui_TreeNode(const char* label) except +
    bool ImGui_TreeNodeEx(const char* label, ImGuiTreeNodeFlags flags) except +
    bool ImGui_TreeNodeExPtr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodeExStr(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodeExV(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodeExVPtr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool ImGui_TreeNodePtr(const void* ptr_id, const char* fmt) except +
    bool ImGui_TreeNodeStr(const char* str_id, const char* fmt) except +
    bool ImGui_TreeNodeV(const char* str_id, const char* fmt) except +
    bool ImGui_TreeNodeVPtr(const void* ptr_id, const char* fmt) except +
    void ImGui_TreePop() except +
    void ImGui_TreePush(const char* str_id) except +
    void ImGui_TreePushPtr(const void* ptr_id) except +
    void ImGui_Unindent() except +
    void ImGui_UnindentEx(float indent_w) except +
    void ImGui_UpdatePlatformWindows() except +
    bool ImGui_VSliderFloat(const char* label, ImVec2 size, float* v, float v_min, float v_max) except +
    bool ImGui_VSliderFloatEx(const char* label, ImVec2 size, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_VSliderInt(const char* label, ImVec2 size, int* v, int v_min, int v_max) except +
    bool ImGui_VSliderIntEx(const char* label, ImVec2 size, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool ImGui_VSliderScalar(const char* label, ImVec2 size, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max) except +
    bool ImGui_VSliderScalarEx(const char* label, ImVec2 size, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    void ImVector_Construct(void* vector) except +
    void ImVector_Destruct(void* vector) except +


