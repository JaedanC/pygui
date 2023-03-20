# -*- coding: utf-8 -*-
# distutils: language = c++

from libcpp cimport bool

cdef extern from "cimgui.h":
    ctypedef struct ImVector_ImDrawCmd
    ctypedef struct ImVector_ImDrawIdx
    ctypedef struct ImVector_ImDrawVert
    ctypedef struct ImVector_ImVec4
    ctypedef struct ImVector_ImTextureID
    ctypedef struct ImVector_ImVec2
    ctypedef struct ImVector_ImDrawChannel
    ctypedef struct ImVector_float
    ctypedef struct ImVector_ImWchar
    ctypedef struct ImVector_ImFontGlyph
    ctypedef struct ImVector_ImFontPtr
    ctypedef struct ImVector_ImFontAtlasCustomRect
    ctypedef struct ImVector_ImFontConfig
    ctypedef struct ImFontGlyph
    ctypedef struct ImVector_ImU32
    ctypedef struct ImGuiKeyData
    ctypedef struct ImGuiListClipper
    ctypedef struct ImGuiOnceUponAFrame
    ctypedef struct ImGuiPayload
    ctypedef struct ImVector_ImGuiPlatformMonitor
    ctypedef struct ImVector_ImGuiViewportPtr
    ctypedef struct ImVector_ImGuiStoragePair
    ctypedef struct ImGuiStoragePair
    ctypedef struct ImGuiTableColumnSortSpecs
    ctypedef struct ImGuiTableSortSpecs
    ctypedef struct ImVector_char
    ctypedef struct ImVector_ImGuiTextRange
    ctypedef struct ImGuiTextRange
    ctypedef struct ImGuiWindowClass
    ctypedef struct ImVec2
    ctypedef struct ImVec4
    ctypedef struct ImColor
    ctypedef struct ImDrawChannel
    ctypedef struct ImDrawCmd
    ctypedef struct ImDrawCmdHeader
    ctypedef struct ImDrawData
    ctypedef struct ImDrawListSplitter
    ctypedef struct ImDrawVert
    ctypedef struct ImFont
    ctypedef struct ImFontAtlas
    ctypedef struct ImFontAtlasCustomRect
    ctypedef struct ImFontConfig
    ctypedef struct ImFontGlyphRangesBuilder
    ctypedef struct ImGuiIO
    ctypedef struct ImGuiPlatformIO
    ctypedef struct ImGuiPlatformImeData
    ctypedef struct ImGuiPlatformMonitor
    ctypedef struct ImGuiStorage
    ctypedef struct ImGuiStyle
    ctypedef struct ImGuiTextBuffer
    ctypedef struct ImGuiTextFilter
    ctypedef struct ImGuiViewport
    ctypedef struct ImDrawList
    ctypedef struct ImDrawListSharedData
    ctypedef struct ImFontBuilderIO
    ctypedef struct ImGuiContext


    ctypedef int ImDrawFlags
    ctypedef int ImDrawListFlags
    ctypedef int ImFontAtlasFlags
    ctypedef int ImGuiBackendFlags
    ctypedef int ImGuiButtonFlags
    ctypedef int ImGuiCol
    ctypedef int ImGuiColorEditFlags
    ctypedef int ImGuiComboFlags
    ctypedef int ImGuiCond
    ctypedef int ImGuiConfigFlags
    ctypedef int ImGuiDataType
    ctypedef int ImGuiDir
    ctypedef int ImGuiDockNodeFlags
    ctypedef int ImGuiDragDropFlags
    ctypedef int ImGuiFocusedFlags
    ctypedef int ImGuiHoveredFlags
    ctypedef int ImGuiInputTextFlags
    ctypedef int ImGuiKeyChord
    ctypedef int ImGuiMouseButton
    ctypedef int ImGuiMouseCursor
    ctypedef int ImGuiPopupFlags
    ctypedef int ImGuiSelectableFlags
    ctypedef int ImGuiSliderFlags
    ctypedef int ImGuiSortDirection
    ctypedef int ImGuiStyleVar
    ctypedef int ImGuiTabBarFlags
    ctypedef int ImGuiTabItemFlags
    ctypedef int ImGuiTableBgTarget
    ctypedef int ImGuiTableColumnFlags
    ctypedef int ImGuiTableFlags
    ctypedef int ImGuiTableRowFlags
    ctypedef int ImGuiTreeNodeFlags
    ctypedef int ImGuiViewportFlags
    ctypedef int ImGuiWindowFlags
    ctypedef unsigned char ImU8
    ctypedef unsigned int ImGuiID
    ctypedef unsigned int ImU32
    ctypedef unsigned int ImWchar32
    ctypedef unsigned long long ImU64
    ctypedef unsigned short ImDrawIdx
    ctypedef unsigned short ImU16
    ctypedef unsigned short ImWchar16
    ctypedef signed char ImS8
    ctypedef signed int ImS32
    ctypedef signed long long ImS64
    ctypedef signed short ImS16
    ctypedef ImWchar16 ImWchar
    ctypedef void* ImTextureID


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

    ctypedef enum ImGuiBackendFlags_:
        ImGuiBackendFlags_None
        ImGuiBackendFlags_HasGamepad
        ImGuiBackendFlags_HasMouseCursors
        ImGuiBackendFlags_HasSetMousePos
        ImGuiBackendFlags_RendererHasVtxOffset
        ImGuiBackendFlags_PlatformHasViewports
        ImGuiBackendFlags_HasMouseHoveredViewport
        ImGuiBackendFlags_RendererHasViewports

    ctypedef enum ImGuiButtonFlags_:
        ImGuiButtonFlags_None
        ImGuiButtonFlags_MouseButtonLeft
        ImGuiButtonFlags_MouseButtonRight
        ImGuiButtonFlags_MouseButtonMiddle
        ImGuiButtonFlags_MouseButtonMask_
        ImGuiButtonFlags_MouseButtonDefault_

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

    ctypedef enum ImGuiCond_:
        ImGuiCond_None
        ImGuiCond_Always
        ImGuiCond_Once
        ImGuiCond_FirstUseEver
        ImGuiCond_Appearing

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

    ctypedef enum ImGuiNavInput:
        ImGuiNavInput_Activate
        ImGuiNavInput_Cancel
        ImGuiNavInput_Input
        ImGuiNavInput_Menu
        ImGuiNavInput_DpadLeft
        ImGuiNavInput_DpadRight
        ImGuiNavInput_DpadUp
        ImGuiNavInput_DpadDown
        ImGuiNavInput_LStickLeft
        ImGuiNavInput_LStickRight
        ImGuiNavInput_LStickUp
        ImGuiNavInput_LStickDown
        ImGuiNavInput_FocusPrev
        ImGuiNavInput_FocusNext
        ImGuiNavInput_TweakSlow
        ImGuiNavInput_TweakFast
        ImGuiNavInput_COUNT

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

    ctypedef enum ImGuiSliderFlags_:
        ImGuiSliderFlags_None
        ImGuiSliderFlags_AlwaysClamp
        ImGuiSliderFlags_Logarithmic
        ImGuiSliderFlags_NoRoundToFormat
        ImGuiSliderFlags_NoInput
        ImGuiSliderFlags_InvalidMask_

    ctypedef enum ImGuiSortDirection_:
        ImGuiSortDirection_None
        ImGuiSortDirection_Ascending
        ImGuiSortDirection_Descending

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

    ctypedef enum ImGuiTableBgTarget_:
        ImGuiTableBgTarget_None
        ImGuiTableBgTarget_RowBg0
        ImGuiTableBgTarget_RowBg1
        ImGuiTableBgTarget_CellBg

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

    ctypedef enum ImGuiTableRowFlags_:
        ImGuiTableRowFlags_None
        ImGuiTableRowFlags_Headers

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



    ctypedef struct ImVector_ImDrawCmd:
        int Size
        int Capacity
        ImDrawCmd* Data

    ctypedef struct ImVector_ImDrawIdx:
        int Size
        int Capacity
        ImDrawIdx* Data

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

    ctypedef struct ImVector_ImDrawChannel:
        int Size
        int Capacity
        ImDrawChannel* Data

    ctypedef struct ImVector_float:
        int Size
        int Capacity
        float* Data

    ctypedef struct ImVector_ImWchar:
        int Size
        int Capacity
        ImWchar* Data

    ctypedef struct ImVector_ImFontGlyph:
        int Size
        int Capacity
        ImFontGlyph* Data

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

    ctypedef struct ImVector_ImU32:
        int Size
        int Capacity
        ImU32* Data

    ctypedef struct ImGuiKeyData:
        bool Down
        float DownDuration
        float DownDurationPrev
        float AnalogValue

    ctypedef struct ImGuiListClipper:
        int DisplayStart
        int DisplayEnd
        int ItemsCount
        float ItemsHeight
        float StartPosY
        void* TempData

    ctypedef struct ImGuiOnceUponAFrame:
        int RefFrame

    ctypedef struct ImGuiPayload:
        void* Data
        int DataSize
        ImGuiID SourceId
        ImGuiID SourceParentId
        int DataFrameCount
        char DataType[33]
        bool Preview
        bool Delivery

    ctypedef struct ImVector_ImGuiPlatformMonitor:
        int Size
        int Capacity
        ImGuiPlatformMonitor* Data

    ctypedef struct ImVector_ImGuiViewportPtr:
        int Size
        int Capacity
        ImGuiViewport** Data

    ctypedef struct ImVector_ImGuiStoragePair:
        int Size
        int Capacity
        ImGuiStoragePair* Data

    ctypedef struct ImGuiStoragePair:
        ImGuiID key
        int val_i
        float val_f
        void* val_p

    ctypedef struct ImGuiTableColumnSortSpecs:
        ImGuiID ColumnUserID
        ImS16 ColumnIndex
        ImS16 SortOrder
        ImGuiSortDirection SortDirection

    ctypedef struct ImGuiTableSortSpecs:
        const ImGuiTableColumnSortSpecs* Specs
        int SpecsCount
        bool SpecsDirty

    ctypedef struct ImVector_char:
        int Size
        int Capacity
        char* Data

    ctypedef struct ImVector_ImGuiTextRange:
        int Size
        int Capacity
        ImGuiTextRange* Data

    ctypedef struct ImGuiTextRange:
        const char* b
        const char* e

    ctypedef struct ImGuiWindowClass:
        ImGuiID ClassId
        ImGuiID ParentViewportId
        ImGuiViewportFlags ViewportFlagsOverrideSet
        ImGuiViewportFlags ViewportFlagsOverrideClear
        ImGuiTabItemFlags TabItemFlagsOverrideSet
        ImGuiDockNodeFlags DockNodeFlagsOverrideSet
        bool DockingAlwaysTabBar
        bool DockingAllowUnclassed

    ctypedef struct ImVec2:
        float x
        float y

    ctypedef struct ImVec4:
        float x
        float y
        float z
        float w

    ctypedef struct ImColor:
        ImVec4 Value

    ctypedef struct ImDrawChannel:
        ImVector_ImDrawCmd _CmdBuffer
        ImVector_ImDrawIdx _IdxBuffer

    ctypedef struct ImDrawCmd:
        ImVec4 ClipRect
        ImTextureID TextureId
        unsigned int VtxOffset
        unsigned int IdxOffset
        unsigned int ElemCount
        void* UserCallbackData

    ctypedef struct ImDrawCmdHeader:
        ImVec4 ClipRect
        ImTextureID TextureId
        unsigned int VtxOffset

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

    ctypedef struct ImDrawListSplitter:
        int _Current
        int _Count
        ImVector_ImDrawChannel _Channels

    ctypedef struct ImDrawVert:
        ImVec2 pos
        ImVec2 uv
        ImU32 col

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
        ImU8 Used4kPagesMap[2]

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
        ImVec4 TexUvLines[64]
        const ImFontBuilderIO* FontBuilderIO
        unsigned int FontBuilderFlags
        int PackIdMouseCursors
        int PackIdLines

    ctypedef struct ImFontAtlasCustomRect:
        unsigned short Width
        unsigned short Height
        unsigned short X
        unsigned short Y
        unsigned int GlyphID
        float GlyphAdvanceX
        ImVec2 GlyphOffset
        ImFont* Font

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
        char Name[40]
        ImFont* DstFont

    ctypedef struct ImFontGlyphRangesBuilder:
        ImVector_ImU32 UsedChars

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
        const char* BackendPlatformName
        const char* BackendRendererName
        void* BackendPlatformUserData
        void* BackendRendererUserData
        void* BackendLanguageUserData
        const char*(*GetClipboardTextFn)(void* user_data)
        void(*SetClipboardTextFn)(void* user_data,const char* text)
        void* ClipboardUserData
        void(*SetPlatformImeDataFn)(ImGuiViewport* viewport,ImGuiPlatformImeData* data)
        void* _UnusedPadding
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
        int KeyMap[652]
        bool KeysDown[652]
        float NavInputs[16]
        ImVec2 MousePos
        bool MouseDown[5]
        float MouseWheel
        float MouseWheelH
        ImGuiID MouseHoveredViewport
        bool KeyCtrl
        bool KeyShift
        bool KeyAlt
        bool KeySuper
        ImGuiKeyChord KeyMods
        ImGuiKeyData KeysData[652]
        bool WantCaptureMouseUnlessPopupClose
        ImVec2 MousePosPrev
        ImVec2 MouseClickedPos[5]
        double MouseClickedTime[5]
        bool MouseClicked[5]
        bool MouseDoubleClicked[5]
        ImU16 MouseClickedCount[5]
        ImU16 MouseClickedLastCount[5]
        bool MouseReleased[5]
        bool MouseDownOwned[5]
        bool MouseDownOwnedUnlessPopupClose[5]
        float MouseDownDuration[5]
        float MouseDownDurationPrev[5]
        ImVec2 MouseDragMaxDistanceAbs[5]
        float MouseDragMaxDistanceSqr[5]
        float PenPressure
        bool AppFocusLost
        bool AppAcceptingEvents
        ImS8 BackendUsingLegacyKeyArrays
        bool BackendUsingLegacyNavInputArray
        ImWchar16 InputQueueSurrogate
        ImVector_ImWchar InputQueueCharacters

    ctypedef struct ImGuiPlatformIO:
        void(*Platform_CreateWindow)(ImGuiViewport* vp)
        void(*Platform_DestroyWindow)(ImGuiViewport* vp)
        void(*Platform_ShowWindow)(ImGuiViewport* vp)
        void(*Platform_SetWindowPos)(ImGuiViewport* vp,ImVec2 pos)
        ImVec2(*Platform_GetWindowPos)(ImGuiViewport* vp)
        void(*Platform_SetWindowSize)(ImGuiViewport* vp,ImVec2 size)
        ImVec2(*Platform_GetWindowSize)(ImGuiViewport* vp)
        void(*Platform_SetWindowFocus)(ImGuiViewport* vp)
        bool(*Platform_GetWindowFocus)(ImGuiViewport* vp)
        bool(*Platform_GetWindowMinimized)(ImGuiViewport* vp)
        void(*Platform_SetWindowTitle)(ImGuiViewport* vp,const char* str)
        void(*Platform_SetWindowAlpha)(ImGuiViewport* vp,float alpha)
        void(*Platform_UpdateWindow)(ImGuiViewport* vp)
        void(*Platform_RenderWindow)(ImGuiViewport* vp,void* render_arg)
        void(*Platform_SwapBuffers)(ImGuiViewport* vp,void* render_arg)
        float(*Platform_GetWindowDpiScale)(ImGuiViewport* vp)
        void(*Platform_OnChangedViewport)(ImGuiViewport* vp)
        int(*Platform_CreateVkSurface)(ImGuiViewport* vp,ImU64 vk_inst,const void* vk_allocators,ImU64* out_vk_surface)
        void(*Renderer_CreateWindow)(ImGuiViewport* vp)
        void(*Renderer_DestroyWindow)(ImGuiViewport* vp)
        void(*Renderer_SetWindowSize)(ImGuiViewport* vp,ImVec2 size)
        void(*Renderer_RenderWindow)(ImGuiViewport* vp,void* render_arg)
        void(*Renderer_SwapBuffers)(ImGuiViewport* vp,void* render_arg)
        ImVector_ImGuiPlatformMonitor Monitors
        ImVector_ImGuiViewportPtr Viewports

    ctypedef struct ImGuiPlatformImeData:
        bool WantVisible
        ImVec2 InputPos
        float InputLineHeight

    ctypedef struct ImGuiPlatformMonitor:
        ImVec2 MainPos
        ImVec2 MainSize
        ImVec2 WorkPos
        ImVec2 WorkSize
        float DpiScale

    ctypedef struct ImGuiStorage:
        ImVector_ImGuiStoragePair Data

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
        ImVec4 Colors[55]

    ctypedef struct ImGuiTextBuffer:
        ImVector_char Buf

    ctypedef struct ImGuiTextFilter:
        char InputBuf[256]
        ImVector_ImGuiTextRange Filters
        int CountGrep

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

    ctypedef struct ImDrawListSharedData:
        pass

    ctypedef struct ImFontBuilderIO:
        pass

    ctypedef struct ImGuiContext:
        pass

    const ImGuiPayload* igAcceptDragDropPayload(const char* type_, ImGuiDragDropFlags flags) except +
    void igAlignTextToFramePadding() except +
    bool igArrowButton(const char* str_id, ImGuiDir dir_) except +
    bool igBegin(const char* name, bool* p_open, ImGuiWindowFlags flags) except +
    bool igBeginChildFrame(ImGuiID id_, const ImVec2 size, ImGuiWindowFlags flags) except +
    bool igBeginChild_ID(ImGuiID id_, const ImVec2 size, bool border, ImGuiWindowFlags flags) except +
    bool igBeginChild_Str(const char* str_id, const ImVec2 size, bool border, ImGuiWindowFlags flags) except +
    bool igBeginCombo(const char* label, const char* preview_value, ImGuiComboFlags flags) except +
    void igBeginDisabled(bool disabled) except +
    bool igBeginDragDropSource(ImGuiDragDropFlags flags) except +
    bool igBeginDragDropTarget() except +
    void igBeginGroup() except +
    bool igBeginListBox(const char* label, const ImVec2 size) except +
    bool igBeginMainMenuBar() except +
    bool igBeginMenu(const char* label, bool enabled) except +
    bool igBeginMenuBar() except +
    bool igBeginPopup(const char* str_id, ImGuiWindowFlags flags) except +
    bool igBeginPopupContextItem(const char* str_id, ImGuiPopupFlags popup_flags) except +
    bool igBeginPopupContextVoid(const char* str_id, ImGuiPopupFlags popup_flags) except +
    bool igBeginPopupContextWindow(const char* str_id, ImGuiPopupFlags popup_flags) except +
    bool igBeginPopupModal(const char* name, bool* p_open, ImGuiWindowFlags flags) except +
    bool igBeginTabBar(const char* str_id, ImGuiTabBarFlags flags) except +
    bool igBeginTabItem(const char* label, bool* p_open, ImGuiTabItemFlags flags) except +
    bool igBeginTable(const char* str_id, int column, ImGuiTableFlags flags, const ImVec2 outer_size, float inner_width) except +
    void igBeginTooltip() except +
    void igBullet() except +
    void igBulletText(const char* fmt) except +
    void igBulletTextV(const char* fmt, char* args) except +
    bool igButton(const char* label, const ImVec2 size) except +
    float igCalcItemWidth() except +
    void igCalcTextSize(ImVec2* pOut, const char* text, const char* text_end, bool hide_text_after_double_hash, float wrap_width) except +
    bool igCheckbox(const char* label, bool* v) except +
    bool igCheckboxFlags_IntPtr(const char* label, int* flags, int flags_value) except +
    bool igCheckboxFlags_UintPtr(const char* label, unsigned int* flags, unsigned int flags_value) except +
    void igCloseCurrentPopup() except +
    bool igCollapsingHeader_BoolPtr(const char* label, bool* p_visible, ImGuiTreeNodeFlags flags) except +
    bool igCollapsingHeader_TreeNodeFlags(const char* label, ImGuiTreeNodeFlags flags) except +
    bool igColorButton(const char* desc_id, const ImVec4 col, ImGuiColorEditFlags flags, const ImVec2 size) except +
    ImU32 igColorConvertFloat4ToU32(const ImVec4 in_) except +
    void igColorConvertHSVtoRGB(float h, float s, float v, float* out_r, float* out_g, float* out_b) except +
    void igColorConvertRGBtoHSV(float r, float g, float b, float* out_h, float* out_s, float* out_v) except +
    void igColorConvertU32ToFloat4(ImVec4* pOut, ImU32 in_) except +
    bool igColorEdit3(const char* label, float[3] col, ImGuiColorEditFlags flags) except +
    bool igColorEdit4(const char* label, float[4] col, ImGuiColorEditFlags flags) except +
    bool igColorPicker3(const char* label, float[3] col, ImGuiColorEditFlags flags) except +
    bool igColorPicker4(const char* label, float[4] col, ImGuiColorEditFlags flags, const float* ref_col) except +
    void igColumns(int count, const char* id_, bool border) except +
    bool igCombo_FnBoolPtr(const char* label, int* current_item, bool(*items_getter)(void* data,int idx,const char** out_text), void* data, int items_count, int popup_max_height_in_items) except +
    bool igCombo_Str(const char* label, int* current_item, const char* items_separated_by_zeros, int popup_max_height_in_items) except +
    bool igCombo_Str_arr(const char* label, int* current_item, const char** items, int items_count, int popup_max_height_in_items) except +
    ImGuiContext* igCreateContext(ImFontAtlas* shared_font_atlas) except +
    bool igDebugCheckVersionAndDataLayout(const char* version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx) except +
    void igDebugTextEncoding(const char* text) except +
    void igDestroyContext(ImGuiContext* ctx) except +
    void igDestroyPlatformWindows() except +
    ImGuiID igDockSpace(ImGuiID id_, const ImVec2 size, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +
    ImGuiID igDockSpaceOverViewport(const ImGuiViewport* viewport, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +
    bool igDragFloat(const char* label, float* v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragFloat2(const char* label, float[2] v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragFloat3(const char* label, float[3] v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragFloat4(const char* label, float[4] v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragFloatRange2(const char* label, float* v_current_min, float* v_current_max, float v_speed, float v_min, float v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +
    bool igDragInt(const char* label, int* v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragInt2(const char* label, int[2] v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragInt3(const char* label, int[3] v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragInt4(const char* label, int[4] v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragIntRange2(const char* label, int* v_current_min, int* v_current_max, float v_speed, int v_min, int v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +
    bool igDragScalar(const char* label, ImGuiDataType data_type, void* p_data, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    void igDummy(const ImVec2 size) except +
    void igEnd() except +
    void igEndChild() except +
    void igEndChildFrame() except +
    void igEndCombo() except +
    void igEndDisabled() except +
    void igEndDragDropSource() except +
    void igEndDragDropTarget() except +
    void igEndFrame() except +
    void igEndGroup() except +
    void igEndListBox() except +
    void igEndMainMenuBar() except +
    void igEndMenu() except +
    void igEndMenuBar() except +
    void igEndPopup() except +
    void igEndTabBar() except +
    void igEndTabItem() except +
    void igEndTable() except +
    void igEndTooltip() except +
    ImGuiViewport* igFindViewportByID(ImGuiID id_) except +
    ImGuiViewport* igFindViewportByPlatformHandle(void* platform_handle) except +
    ImDrawList* igGetBackgroundDrawList_Nil() except +
    ImDrawList* igGetBackgroundDrawList_ViewportPtr(ImGuiViewport* viewport) except +
    const char* igGetClipboardText() except +
    ImU32 igGetColorU32_Col(ImGuiCol idx, float alpha_mul) except +
    ImU32 igGetColorU32_U32(ImU32 col) except +
    ImU32 igGetColorU32_Vec4(const ImVec4 col) except +
    int igGetColumnIndex() except +
    float igGetColumnOffset(int column_index) except +
    float igGetColumnWidth(int column_index) except +
    int igGetColumnsCount() except +
    void igGetContentRegionAvail(ImVec2* pOut) except +
    void igGetContentRegionMax(ImVec2* pOut) except +
    ImGuiContext* igGetCurrentContext() except +
    void igGetCursorPos(ImVec2* pOut) except +
    float igGetCursorPosX() except +
    float igGetCursorPosY() except +
    void igGetCursorScreenPos(ImVec2* pOut) except +
    void igGetCursorStartPos(ImVec2* pOut) except +
    const ImGuiPayload* igGetDragDropPayload() except +
    ImDrawData* igGetDrawData() except +
    ImDrawListSharedData* igGetDrawListSharedData() except +
    ImFont* igGetFont() except +
    float igGetFontSize() except +
    void igGetFontTexUvWhitePixel(ImVec2* pOut) except +
    ImDrawList* igGetForegroundDrawList_Nil() except +
    ImDrawList* igGetForegroundDrawList_ViewportPtr(ImGuiViewport* viewport) except +
    int igGetFrameCount() except +
    float igGetFrameHeight() except +
    float igGetFrameHeightWithSpacing() except +
    ImGuiID igGetID_Ptr(const void* ptr_id) except +
    ImGuiID igGetID_Str(const char* str_id) except +
    ImGuiID igGetID_StrStr(const char* str_id_begin, const char* str_id_end) except +
    ImGuiIO* igGetIO() except +
    ImGuiID igGetItemID() except +
    void igGetItemRectMax(ImVec2* pOut) except +
    void igGetItemRectMin(ImVec2* pOut) except +
    void igGetItemRectSize(ImVec2* pOut) except +
    ImGuiKey igGetKeyIndex(ImGuiKey key) except +
    const char* igGetKeyName(ImGuiKey key) except +
    int igGetKeyPressedAmount(ImGuiKey key, float repeat_delay, float rate) except +
    ImGuiViewport* igGetMainViewport() except +
    int igGetMouseClickedCount(ImGuiMouseButton button) except +
    ImGuiMouseCursor igGetMouseCursor() except +
    void igGetMouseDragDelta(ImVec2* pOut, ImGuiMouseButton button, float lock_threshold) except +
    void igGetMousePos(ImVec2* pOut) except +
    void igGetMousePosOnOpeningCurrentPopup(ImVec2* pOut) except +
    ImGuiPlatformIO* igGetPlatformIO() except +
    float igGetScrollMaxX() except +
    float igGetScrollMaxY() except +
    float igGetScrollX() except +
    float igGetScrollY() except +
    ImGuiStorage* igGetStateStorage() except +
    ImGuiStyle* igGetStyle() except +
    const char* igGetStyleColorName(ImGuiCol idx) except +
    const ImVec4* igGetStyleColorVec4(ImGuiCol idx) except +
    float igGetTextLineHeight() except +
    float igGetTextLineHeightWithSpacing() except +
    double igGetTime() except +
    float igGetTreeNodeToLabelSpacing() except +
    const char* igGetVersion() except +
    void igGetWindowContentRegionMax(ImVec2* pOut) except +
    void igGetWindowContentRegionMin(ImVec2* pOut) except +
    ImGuiID igGetWindowDockID() except +
    float igGetWindowDpiScale() except +
    ImDrawList* igGetWindowDrawList() except +
    float igGetWindowHeight() except +
    void igGetWindowPos(ImVec2* pOut) except +
    void igGetWindowSize(ImVec2* pOut) except +
    ImGuiViewport* igGetWindowViewport() except +
    float igGetWindowWidth() except +
    void igImage(ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec4 tint_col, const ImVec4 border_col) except +
    bool igImageButton(const char* str_id, ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec4 bg_col, const ImVec4 tint_col) except +
    void igIndent(float indent_w) except +
    bool igInputDouble(const char* label, double* v, double step, double step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputFloat(const char* label, float* v, float step, float step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputFloat2(const char* label, float[2] v, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputFloat3(const char* label, float[3] v, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputFloat4(const char* label, float[4] v, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputInt(const char* label, int* v, int step, int step_fast, ImGuiInputTextFlags flags) except +
    bool igInputInt2(const char* label, int[2] v, ImGuiInputTextFlags flags) except +
    bool igInputInt3(const char* label, int[3] v, ImGuiInputTextFlags flags) except +
    bool igInputInt4(const char* label, int[4] v, ImGuiInputTextFlags flags) except +
    bool igInputScalar(const char* label, ImGuiDataType data_type, void* p_data, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInvisibleButton(const char* str_id, const ImVec2 size, ImGuiButtonFlags flags) except +
    bool igIsAnyItemActive() except +
    bool igIsAnyItemFocused() except +
    bool igIsAnyItemHovered() except +
    bool igIsAnyMouseDown() except +
    bool igIsItemActivated() except +
    bool igIsItemActive() except +
    bool igIsItemClicked(ImGuiMouseButton mouse_button) except +
    bool igIsItemDeactivated() except +
    bool igIsItemDeactivatedAfterEdit() except +
    bool igIsItemEdited() except +
    bool igIsItemFocused() except +
    bool igIsItemHovered(ImGuiHoveredFlags flags) except +
    bool igIsItemToggledOpen() except +
    bool igIsItemVisible() except +
    bool igIsKeyDown(ImGuiKey key) except +
    bool igIsKeyPressed(ImGuiKey key, bool repeat) except +
    bool igIsKeyReleased(ImGuiKey key) except +
    bool igIsMouseClicked(ImGuiMouseButton button, bool repeat) except +
    bool igIsMouseDoubleClicked(ImGuiMouseButton button) except +
    bool igIsMouseDown(ImGuiMouseButton button) except +
    bool igIsMouseDragging(ImGuiMouseButton button, float lock_threshold) except +
    bool igIsMouseHoveringRect(const ImVec2 r_min, const ImVec2 r_max, bool clip) except +
    bool igIsMousePosValid(const ImVec2* mouse_pos) except +
    bool igIsMouseReleased(ImGuiMouseButton button) except +
    bool igIsPopupOpen(const char* str_id, ImGuiPopupFlags flags) except +
    bool igIsRectVisible_Nil(const ImVec2 size) except +
    bool igIsRectVisible_Vec2(const ImVec2 rect_min, const ImVec2 rect_max) except +
    bool igIsWindowAppearing() except +
    bool igIsWindowCollapsed() except +
    bool igIsWindowDocked() except +
    bool igIsWindowFocused(ImGuiFocusedFlags flags) except +
    bool igIsWindowHovered(ImGuiHoveredFlags flags) except +
    void igLabelText(const char* label, const char* fmt) except +
    void igLabelTextV(const char* label, const char* fmt, char* args) except +
    bool igListBox_FnBoolPtr(const char* label, int* current_item, bool(*items_getter)(void* data,int idx,const char** out_text), void* data, int items_count, int height_in_items) except +
    bool igListBox_Str_arr(const char* label, int* current_item, const char** items, int items_count, int height_in_items) except +
    void igLoadIniSettingsFromDisk(const char* ini_filename) except +
    void igLoadIniSettingsFromMemory(const char* ini_data, size_t ini_size) except +
    void igLogButtons() except +
    void igLogFinish() except +
    void igLogText(const char* fmt) except +
    void igLogTextV(const char* fmt, char* args) except +
    void igLogToClipboard(int auto_open_depth) except +
    void igLogToFile(int auto_open_depth, const char* filename) except +
    void igLogToTTY(int auto_open_depth) except +
    void* igMemAlloc(size_t size) except +
    void igMemFree(void* ptr) except +
    bool igMenuItem_Bool(const char* label, const char* shortcut, bool selected, bool enabled) except +
    bool igMenuItem_BoolPtr(const char* label, const char* shortcut, bool* p_selected, bool enabled) except +
    void igNewFrame() except +
    void igNewLine() except +
    void igNextColumn() except +
    void igOpenPopupOnItemClick(const char* str_id, ImGuiPopupFlags popup_flags) except +
    void igOpenPopup_ID(ImGuiID id_, ImGuiPopupFlags popup_flags) except +
    void igOpenPopup_Str(const char* str_id, ImGuiPopupFlags popup_flags) except +
    void igPlotHistogram_FloatPtr(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +
    void igPlotHistogram_FnFloatPtr(const char* label, float(*values_getter)(void* data,int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void igPlotLines_FloatPtr(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +
    void igPlotLines_FnFloatPtr(const char* label, float(*values_getter)(void* data,int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void igPopAllowKeyboardFocus() except +
    void igPopButtonRepeat() except +
    void igPopClipRect() except +
    void igPopFont() except +
    void igPopID() except +
    void igPopItemWidth() except +
    void igPopStyleColor(int count) except +
    void igPopStyleVar(int count) except +
    void igPopTextWrapPos() except +
    void igProgressBar(float fraction, const ImVec2 size_arg, const char* overlay) except +
    void igPushAllowKeyboardFocus(bool allow_keyboard_focus) except +
    void igPushButtonRepeat(bool repeat) except +
    void igPushClipRect(const ImVec2 clip_rect_min, const ImVec2 clip_rect_max, bool intersect_with_current_clip_rect) except +
    void igPushFont(ImFont* font) except +
    void igPushID_Int(int int_id) except +
    void igPushID_Ptr(const void* ptr_id) except +
    void igPushID_Str(const char* str_id) except +
    void igPushID_StrStr(const char* str_id_begin, const char* str_id_end) except +
    void igPushItemWidth(float item_width) except +
    void igPushStyleColor_U32(ImGuiCol idx, ImU32 col) except +
    void igPushStyleColor_Vec4(ImGuiCol idx, const ImVec4 col) except +
    void igPushStyleVar_Float(ImGuiStyleVar idx, float val) except +
    void igPushStyleVar_Vec2(ImGuiStyleVar idx, const ImVec2 val) except +
    void igPushTextWrapPos(float wrap_local_pos_x) except +
    bool igRadioButton_Bool(const char* label, bool active) except +
    bool igRadioButton_IntPtr(const char* label, int* v, int v_button) except +
    void igRender() except +
    void igRenderPlatformWindowsDefault(void* platform_render_arg, void* renderer_render_arg) except +
    void igResetMouseDragDelta(ImGuiMouseButton button) except +
    void igSameLine(float offset_from_start_x, float spacing) except +
    void igSaveIniSettingsToDisk(const char* ini_filename) except +
    const char* igSaveIniSettingsToMemory(size_t* out_ini_size) except +
    bool igSelectable_Bool(const char* label, bool selected, ImGuiSelectableFlags flags, const ImVec2 size) except +
    bool igSelectable_BoolPtr(const char* label, bool* p_selected, ImGuiSelectableFlags flags, const ImVec2 size) except +
    void igSeparator() except +
    void igSeparatorText(const char* label) except +
    void igSetClipboardText(const char* text) except +
    void igSetColorEditOptions(ImGuiColorEditFlags flags) except +
    void igSetColumnOffset(int column_index, float offset_x) except +
    void igSetColumnWidth(int column_index, float width) except +
    void igSetCurrentContext(ImGuiContext* ctx) except +
    void igSetCursorPos(const ImVec2 local_pos) except +
    void igSetCursorPosX(float local_x) except +
    void igSetCursorPosY(float local_y) except +
    void igSetCursorScreenPos(const ImVec2 pos) except +
    bool igSetDragDropPayload(const char* type_, const void* data, size_t sz, ImGuiCond cond) except +
    void igSetItemAllowOverlap() except +
    void igSetItemDefaultFocus() except +
    void igSetKeyboardFocusHere(int offset) except +
    void igSetMouseCursor(ImGuiMouseCursor cursor_type) except +
    void igSetNextFrameWantCaptureKeyboard(bool want_capture_keyboard) except +
    void igSetNextFrameWantCaptureMouse(bool want_capture_mouse) except +
    void igSetNextItemOpen(bool is_open, ImGuiCond cond) except +
    void igSetNextItemWidth(float item_width) except +
    void igSetNextWindowBgAlpha(float alpha) except +
    void igSetNextWindowClass(const ImGuiWindowClass* window_class) except +
    void igSetNextWindowCollapsed(bool collapsed, ImGuiCond cond) except +
    void igSetNextWindowContentSize(const ImVec2 size) except +
    void igSetNextWindowDockID(ImGuiID dock_id, ImGuiCond cond) except +
    void igSetNextWindowFocus() except +
    void igSetNextWindowPos(const ImVec2 pos, ImGuiCond cond, const ImVec2 pivot) except +
    void igSetNextWindowScroll(const ImVec2 scroll) except +
    void igSetNextWindowSize(const ImVec2 size, ImGuiCond cond) except +
    void igSetNextWindowViewport(ImGuiID viewport_id) except +
    void igSetScrollFromPosX(float local_x, float center_x_ratio) except +
    void igSetScrollFromPosY(float local_y, float center_y_ratio) except +
    void igSetScrollHereX(float center_x_ratio) except +
    void igSetScrollHereY(float center_y_ratio) except +
    void igSetScrollX(float scroll_x) except +
    void igSetScrollY(float scroll_y) except +
    void igSetStateStorage(ImGuiStorage* storage) except +
    void igSetTabItemClosed(const char* tab_or_docked_window_label) except +
    void igSetTooltip(const char* fmt) except +
    void igSetTooltipV(const char* fmt, char* args) except +
    void igSetWindowCollapsed_Bool(bool collapsed, ImGuiCond cond) except +
    void igSetWindowCollapsed_Str(const char* name, bool collapsed, ImGuiCond cond) except +
    void igSetWindowFocus_Nil() except +
    void igSetWindowFocus_Str(const char* name) except +
    void igSetWindowFontScale(float scale) except +
    void igSetWindowPos_Str(const char* name, const ImVec2 pos, ImGuiCond cond) except +
    void igSetWindowPos_Vec2(const ImVec2 pos, ImGuiCond cond) except +
    void igSetWindowSize_Str(const char* name, const ImVec2 size, ImGuiCond cond) except +
    void igSetWindowSize_Vec2(const ImVec2 size, ImGuiCond cond) except +
    void igShowAboutWindow(bool* p_open) except +
    void igShowDebugLogWindow(bool* p_open) except +
    void igShowDemoWindow(bool* p_open) except +
    void igShowFontSelector(const char* label) except +
    void igShowMetricsWindow(bool* p_open) except +
    void igShowStackToolWindow(bool* p_open) except +
    void igShowStyleEditor(ImGuiStyle* ref) except +
    bool igShowStyleSelector(const char* label) except +
    void igShowUserGuide() except +
    bool igSliderAngle(const char* label, float* v_rad, float v_degrees_min, float v_degrees_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderFloat(const char* label, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderFloat2(const char* label, float[2] v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderFloat3(const char* label, float[3] v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderFloat4(const char* label, float[4] v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderInt(const char* label, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderInt2(const char* label, int[2] v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderInt3(const char* label, int[3] v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderInt4(const char* label, int[4] v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderScalar(const char* label, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSmallButton(const char* label) except +
    void igSpacing() except +
    void igStyleColorsClassic(ImGuiStyle* dst) except +
    void igStyleColorsDark(ImGuiStyle* dst) except +
    void igStyleColorsLight(ImGuiStyle* dst) except +
    bool igTabItemButton(const char* label, ImGuiTabItemFlags flags) except +
    int igTableGetColumnCount() except +
    ImGuiTableColumnFlags igTableGetColumnFlags(int column_n) except +
    int igTableGetColumnIndex() except +
    const char* igTableGetColumnName(int column_n) except +
    int igTableGetRowIndex() except +
    ImGuiTableSortSpecs* igTableGetSortSpecs() except +
    void igTableHeader(const char* label) except +
    void igTableHeadersRow() except +
    bool igTableNextColumn() except +
    void igTableNextRow(ImGuiTableRowFlags row_flags, float min_row_height) except +
    void igTableSetBgColor(ImGuiTableBgTarget target, ImU32 color, int column_n) except +
    void igTableSetColumnEnabled(int column_n, bool v) except +
    bool igTableSetColumnIndex(int column_n) except +
    void igTableSetupColumn(const char* label, ImGuiTableColumnFlags flags, float init_width_or_weight, ImGuiID user_id) except +
    void igTableSetupScrollFreeze(int cols, int rows) except +
    void igText(const char* fmt) except +
    void igTextColored(const ImVec4 col, const char* fmt) except +
    void igTextColoredV(const ImVec4 col, const char* fmt, char* args) except +
    void igTextDisabled(const char* fmt) except +
    void igTextDisabledV(const char* fmt, char* args) except +
    void igTextUnformatted(const char* text, const char* text_end) except +
    void igTextV(const char* fmt, char* args) except +
    void igTextWrapped(const char* fmt) except +
    void igTextWrappedV(const char* fmt, char* args) except +
    bool igTreeNodeExV_Ptr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt, char* args) except +
    bool igTreeNodeExV_Str(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt, char* args) except +
    bool igTreeNodeEx_Ptr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool igTreeNodeEx_Str(const char* label, ImGuiTreeNodeFlags flags) except +
    bool igTreeNodeEx_StrStr(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool igTreeNodeV_Ptr(const void* ptr_id, const char* fmt, char* args) except +
    bool igTreeNodeV_Str(const char* str_id, const char* fmt, char* args) except +
    bool igTreeNode_Ptr(const void* ptr_id, const char* fmt) except +
    bool igTreeNode_Str(const char* label) except +
    bool igTreeNode_StrStr(const char* str_id, const char* fmt) except +
    void igTreePop() except +
    void igTreePush_Ptr(const void* ptr_id) except +
    void igTreePush_Str(const char* str_id) except +
    void igUnindent(float indent_w) except +
    void igUpdatePlatformWindows() except +
    bool igVSliderFloat(const char* label, const ImVec2 size, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igVSliderInt(const char* label, const ImVec2 size, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igVSliderScalar(const char* label, const ImVec2 size, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    void igValue_Bool(const char* prefix, bool b) except +
    void igValue_Float(const char* prefix, float v, const char* float_format) except +
    void igValue_Int(const char* prefix, int v) except +
    void igValue_Uint(const char* prefix, unsigned int v) except +

    void ImGuiListClipper_ImGuiListClipper() except +
    void ImGuiListClipper_destroy(ImGuiListClipper* self) except +
    void ImGuiListClipper_Begin(ImGuiListClipper* self, int items_count, float items_height) except +
    void ImGuiListClipper_End(ImGuiListClipper* self) except +
    void ImGuiListClipper_ForceDisplayRangeByIndices(ImGuiListClipper* self, int item_min, int item_max) except +
    bool ImGuiListClipper_Step(ImGuiListClipper* self) except +
    void ImGuiOnceUponAFrame_ImGuiOnceUponAFrame() except +
    void ImGuiOnceUponAFrame_destroy(ImGuiOnceUponAFrame* self) except +
    void ImGuiPayload_ImGuiPayload() except +
    void ImGuiPayload_destroy(ImGuiPayload* self) except +
    void ImGuiPayload_Clear(ImGuiPayload* self) except +
    bool ImGuiPayload_IsDataType(ImGuiPayload* self, const char* type_) except +
    bool ImGuiPayload_IsDelivery(ImGuiPayload* self) except +
    bool ImGuiPayload_IsPreview(ImGuiPayload* self) except +
    void ImGuiStoragePair_ImGuiStoragePair_Float(ImGuiID _key, float _val_f) except +
    void ImGuiStoragePair_ImGuiStoragePair_Int(ImGuiID _key, int _val_i) except +
    void ImGuiStoragePair_ImGuiStoragePair_Ptr(ImGuiID _key, void* _val_p) except +
    void ImGuiStoragePair_destroy(ImGuiStoragePair* self) except +
    void ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs() except +
    void ImGuiTableColumnSortSpecs_destroy(ImGuiTableColumnSortSpecs* self) except +
    void ImGuiTableSortSpecs_ImGuiTableSortSpecs() except +
    void ImGuiTableSortSpecs_destroy(ImGuiTableSortSpecs* self) except +
    void ImGuiTextRange_ImGuiTextRange_Nil() except +
    void ImGuiTextRange_ImGuiTextRange_Str(const char* _b, const char* _e) except +
    void ImGuiTextRange_destroy(ImGuiTextRange* self) except +
    bool ImGuiTextRange_empty(ImGuiTextRange* self) except +
    void ImGuiTextRange_split(ImGuiTextRange* self, char separator, ImVector_ImGuiTextRange* out) except +
    void ImGuiWindowClass_ImGuiWindowClass() except +
    void ImGuiWindowClass_destroy(ImGuiWindowClass* self) except +
    void ImVec2_ImVec2_Float(float _x, float _y) except +
    void ImVec2_ImVec2_Nil() except +
    void ImVec2_destroy(ImVec2* self) except +
    void ImVec4_ImVec4_Float(float _x, float _y, float _z, float _w) except +
    void ImVec4_ImVec4_Nil() except +
    void ImVec4_destroy(ImVec4* self) except +
    void ImColor_ImColor_Float(float r, float g, float b, float a) except +
    void ImColor_ImColor_Int(int r, int g, int b, int a) except +
    void ImColor_ImColor_Nil() except +
    void ImColor_ImColor_U32(ImU32 rgba) except +
    void ImColor_ImColor_Vec4(const ImVec4 col) except +
    void ImColor_destroy(ImColor* self) except +
    void ImColor_HSV(ImColor* pOut, float h, float s, float v, float a) except +
    void ImColor_SetHSV(ImColor* self, float h, float s, float v, float a) except +
    void ImDrawCmd_ImDrawCmd() except +
    void ImDrawCmd_destroy(ImDrawCmd* self) except +
    ImTextureID ImDrawCmd_GetTexID(ImDrawCmd* self) except +
    void ImDrawData_ImDrawData() except +
    void ImDrawData_destroy(ImDrawData* self) except +
    void ImDrawData_Clear(ImDrawData* self) except +
    void ImDrawData_DeIndexAllBuffers(ImDrawData* self) except +
    void ImDrawData_ScaleClipRects(ImDrawData* self, const ImVec2 fb_scale) except +
    void ImDrawListSplitter_ImDrawListSplitter() except +
    void ImDrawListSplitter_destroy(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_Clear(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_Merge(ImDrawListSplitter* self, ImDrawList* draw_list) except +
    void ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter* self, ImDrawList* draw_list, int channel_idx) except +
    void ImDrawListSplitter_Split(ImDrawListSplitter* self, ImDrawList* draw_list, int count) except +
    void ImFont_ImFont() except +
    void ImFont_destroy(ImFont* self) except +
    void ImFont_AddGlyph(ImFont* self, const ImFontConfig* src_cfg, ImWchar c, float x0, float y0, float x1, float y1, float u0, float v0, float u1, float v1, float advance_x) except +
    void ImFont_AddRemapChar(ImFont* self, ImWchar dst, ImWchar src, bool overwrite_dst) except +
    void ImFont_BuildLookupTable(ImFont* self) except +
    void ImFont_CalcTextSizeA(ImVec2* pOut, ImFont* self, float size, float max_width, float wrap_width, const char* text_begin, const char* text_end, const char** remaining) except +
    const char* ImFont_CalcWordWrapPositionA(ImFont* self, float scale, const char* text, const char* text_end, float wrap_width) except +
    void ImFont_ClearOutputData(ImFont* self) except +
    const ImFontGlyph* ImFont_FindGlyph(ImFont* self, ImWchar c) except +
    const ImFontGlyph* ImFont_FindGlyphNoFallback(ImFont* self, ImWchar c) except +
    float ImFont_GetCharAdvance(ImFont* self, ImWchar c) except +
    const char* ImFont_GetDebugName(ImFont* self) except +
    void ImFont_GrowIndex(ImFont* self, int new_size) except +
    bool ImFont_IsGlyphRangeUnused(ImFont* self, unsigned int c_begin, unsigned int c_last) except +
    bool ImFont_IsLoaded(ImFont* self) except +
    void ImFont_RenderChar(ImFont* self, ImDrawList* draw_list, float size, const ImVec2 pos, ImU32 col, ImWchar c) except +
    void ImFont_RenderText(ImFont* self, ImDrawList* draw_list, float size, const ImVec2 pos, ImU32 col, const ImVec4 clip_rect, const char* text_begin, const char* text_end, float wrap_width, bool cpu_fine_clip) except +
    void ImFont_SetGlyphVisible(ImFont* self, ImWchar c, bool visible) except +
    void ImFontAtlas_ImFontAtlas() except +
    void ImFontAtlas_destroy(ImFontAtlas* self) except +
    int ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas* self, ImFont* font, ImWchar id_, int width, int height, float advance_x, const ImVec2 offset) except +
    int ImFontAtlas_AddCustomRectRegular(ImFontAtlas* self, int width, int height) except +
    ImFont* ImFontAtlas_AddFont(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontDefault(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontFromFileTTF(ImFontAtlas* self, const char* filename, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas* self, const char* compressed_font_data_base85, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas* self, const void* compressed_font_data, int compressed_font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas* self, void* font_data, int font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    bool ImFontAtlas_Build(ImFontAtlas* self) except +
    void ImFontAtlas_CalcCustomRectUV(ImFontAtlas* self, const ImFontAtlasCustomRect* rect, ImVec2* out_uv_min, ImVec2* out_uv_max) except +
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
    bool ImFontAtlas_GetMouseCursorTexData(ImFontAtlas* self, ImGuiMouseCursor cursor, ImVec2* out_offset, ImVec2* out_size, ImVec2[2] out_uv_border, ImVec2[2] out_uv_fill) except +
    void ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +
    void ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +
    bool ImFontAtlas_IsBuilt(ImFontAtlas* self) except +
    void ImFontAtlas_SetTexID(ImFontAtlas* self, ImTextureID id_) except +
    void ImFontAtlasCustomRect_ImFontAtlasCustomRect() except +
    void ImFontAtlasCustomRect_destroy(ImFontAtlasCustomRect* self) except +
    bool ImFontAtlasCustomRect_IsPacked(ImFontAtlasCustomRect* self) except +
    void ImFontConfig_ImFontConfig() except +
    void ImFontConfig_destroy(ImFontConfig* self) except +
    void ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder() except +
    void ImFontGlyphRangesBuilder_destroy(ImFontGlyphRangesBuilder* self) except +
    void ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder* self, ImWchar c) except +
    void ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder* self, const ImWchar* ranges) except +
    void ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder* self, const char* text, const char* text_end) except +
    void ImFontGlyphRangesBuilder_BuildRanges(ImFontGlyphRangesBuilder* self, ImVector_ImWchar* out_ranges) except +
    void ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder* self) except +
    bool ImFontGlyphRangesBuilder_GetBit(ImFontGlyphRangesBuilder* self, size_t n) except +
    void ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder* self, size_t n) except +
    void ImGuiIO_ImGuiIO() except +
    void ImGuiIO_destroy(ImGuiIO* self) except +
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
    void ImGuiIO_SetKeyEventNativeData(ImGuiIO* self, ImGuiKey key, int native_keycode, int native_scancode, int native_legacy_index) except +
    void ImGuiPlatformIO_ImGuiPlatformIO() except +
    void ImGuiPlatformIO_destroy(ImGuiPlatformIO* self) except +
    void ImGuiPlatformImeData_ImGuiPlatformImeData() except +
    void ImGuiPlatformImeData_destroy(ImGuiPlatformImeData* self) except +
    void ImGuiPlatformMonitor_ImGuiPlatformMonitor() except +
    void ImGuiPlatformMonitor_destroy(ImGuiPlatformMonitor* self) except +
    void ImGuiStorage_BuildSortByKey(ImGuiStorage* self) except +
    void ImGuiStorage_Clear(ImGuiStorage* self) except +
    bool ImGuiStorage_GetBool(ImGuiStorage* self, ImGuiID key, bool default_val) except +
    bool* ImGuiStorage_GetBoolRef(ImGuiStorage* self, ImGuiID key, bool default_val) except +
    float ImGuiStorage_GetFloat(ImGuiStorage* self, ImGuiID key, float default_val) except +
    float* ImGuiStorage_GetFloatRef(ImGuiStorage* self, ImGuiID key, float default_val) except +
    int ImGuiStorage_GetInt(ImGuiStorage* self, ImGuiID key, int default_val) except +
    int* ImGuiStorage_GetIntRef(ImGuiStorage* self, ImGuiID key, int default_val) except +
    void* ImGuiStorage_GetVoidPtr(ImGuiStorage* self, ImGuiID key) except +
    void** ImGuiStorage_GetVoidPtrRef(ImGuiStorage* self, ImGuiID key, void* default_val) except +
    void ImGuiStorage_SetAllInt(ImGuiStorage* self, int val) except +
    void ImGuiStorage_SetBool(ImGuiStorage* self, ImGuiID key, bool val) except +
    void ImGuiStorage_SetFloat(ImGuiStorage* self, ImGuiID key, float val) except +
    void ImGuiStorage_SetInt(ImGuiStorage* self, ImGuiID key, int val) except +
    void ImGuiStorage_SetVoidPtr(ImGuiStorage* self, ImGuiID key, void* val) except +
    void ImGuiStyle_ImGuiStyle() except +
    void ImGuiStyle_destroy(ImGuiStyle* self) except +
    void ImGuiStyle_ScaleAllSizes(ImGuiStyle* self, float scale_factor) except +
    void ImGuiTextBuffer_ImGuiTextBuffer() except +
    void ImGuiTextBuffer_destroy(ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_append(ImGuiTextBuffer* self, const char* str_, const char* str_end) except +
    void ImGuiTextBuffer_appendf(ImGuiTextBuffer* self, const char* fmt) except +
    void ImGuiTextBuffer_appendfv(ImGuiTextBuffer* self, const char* fmt, char* args) except +
    const char* ImGuiTextBuffer_begin(ImGuiTextBuffer* self) except +
    const char* ImGuiTextBuffer_c_str(ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_clear(ImGuiTextBuffer* self) except +
    bool ImGuiTextBuffer_empty(ImGuiTextBuffer* self) except +
    const char* ImGuiTextBuffer_end(ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_reserve(ImGuiTextBuffer* self, int capacity) except +
    int ImGuiTextBuffer_size(ImGuiTextBuffer* self) except +
    void ImGuiTextFilter_ImGuiTextFilter(const char* default_filter) except +
    void ImGuiTextFilter_destroy(ImGuiTextFilter* self) except +
    void ImGuiTextFilter_Build(ImGuiTextFilter* self) except +
    void ImGuiTextFilter_Clear(ImGuiTextFilter* self) except +
    bool ImGuiTextFilter_Draw(ImGuiTextFilter* self, const char* label, float width) except +
    bool ImGuiTextFilter_IsActive(ImGuiTextFilter* self) except +
    bool ImGuiTextFilter_PassFilter(ImGuiTextFilter* self, const char* text, const char* text_end) except +
    void ImGuiViewport_ImGuiViewport() except +
    void ImGuiViewport_destroy(ImGuiViewport* self) except +
    void ImGuiViewport_GetCenter(ImVec2* pOut, ImGuiViewport* self) except +
    void ImGuiViewport_GetWorkCenter(ImVec2* pOut, ImGuiViewport* self) except +
    void ImDrawList_ImDrawList(ImDrawListSharedData* shared_data) except +
    void ImDrawList_destroy(ImDrawList* self) except +
    void ImDrawList_AddBezierCubic(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col, float thickness, int num_segments) except +
    void ImDrawList_AddBezierQuadratic(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, ImU32 col, float thickness, int num_segments) except +
    void ImDrawList_AddCircle(ImDrawList* self, const ImVec2 center, float radius, ImU32 col, int num_segments, float thickness) except +
    void ImDrawList_AddCircleFilled(ImDrawList* self, const ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddConvexPolyFilled(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col) except +
    void ImDrawList_AddDrawCmd(ImDrawList* self) except +
    void ImDrawList_AddImage(ImDrawList* self, ImTextureID user_texture_id, const ImVec2 p_min, const ImVec2 p_max, const ImVec2 uv_min, const ImVec2 uv_max, ImU32 col) except +
    void ImDrawList_AddImageQuad(ImDrawList* self, ImTextureID user_texture_id, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, const ImVec2 uv1, const ImVec2 uv2, const ImVec2 uv3, const ImVec2 uv4, ImU32 col) except +
    void ImDrawList_AddImageRounded(ImDrawList* self, ImTextureID user_texture_id, const ImVec2 p_min, const ImVec2 p_max, const ImVec2 uv_min, const ImVec2 uv_max, ImU32 col, float rounding, ImDrawFlags flags) except +
    void ImDrawList_AddLine(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, ImU32 col, float thickness) except +
    void ImDrawList_AddNgon(ImDrawList* self, const ImVec2 center, float radius, ImU32 col, int num_segments, float thickness) except +
    void ImDrawList_AddNgonFilled(ImDrawList* self, const ImVec2 center, float radius, ImU32 col, int num_segments) except +
    void ImDrawList_AddPolyline(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col, ImDrawFlags flags, float thickness) except +
    void ImDrawList_AddQuad(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col, float thickness) except +
    void ImDrawList_AddQuadFilled(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col) except +
    void ImDrawList_AddRect(ImDrawList* self, const ImVec2 p_min, const ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags, float thickness) except +
    void ImDrawList_AddRectFilled(ImDrawList* self, const ImVec2 p_min, const ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags) except +
    void ImDrawList_AddRectFilledMultiColor(ImDrawList* self, const ImVec2 p_min, const ImVec2 p_max, ImU32 col_upr_left, ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left) except +
    void ImDrawList_AddText_FontPtr(ImDrawList* self, const ImFont* font, float font_size, const ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end, float wrap_width, const ImVec4* cpu_fine_clip_rect) except +
    void ImDrawList_AddText_Vec2(ImDrawList* self, const ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end) except +
    void ImDrawList_AddTriangle(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, ImU32 col, float thickness) except +
    void ImDrawList_AddTriangleFilled(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, ImU32 col) except +
    void ImDrawList_ChannelsMerge(ImDrawList* self) except +
    void ImDrawList_ChannelsSetCurrent(ImDrawList* self, int n) except +
    void ImDrawList_ChannelsSplit(ImDrawList* self, int count) except +
    ImDrawList* ImDrawList_CloneOutput(ImDrawList* self) except +
    void ImDrawList_GetClipRectMax(ImVec2* pOut, ImDrawList* self) except +
    void ImDrawList_GetClipRectMin(ImVec2* pOut, ImDrawList* self) except +
    void ImDrawList_PathArcTo(ImDrawList* self, const ImVec2 center, float radius, float a_min, float a_max, int num_segments) except +
    void ImDrawList_PathArcToFast(ImDrawList* self, const ImVec2 center, float radius, int a_min_of_12, int a_max_of_12) except +
    void ImDrawList_PathBezierCubicCurveTo(ImDrawList* self, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, int num_segments) except +
    void ImDrawList_PathBezierQuadraticCurveTo(ImDrawList* self, const ImVec2 p2, const ImVec2 p3, int num_segments) except +
    void ImDrawList_PathClear(ImDrawList* self) except +
    void ImDrawList_PathFillConvex(ImDrawList* self, ImU32 col) except +
    void ImDrawList_PathLineTo(ImDrawList* self, const ImVec2 pos) except +
    void ImDrawList_PathLineToMergeDuplicate(ImDrawList* self, const ImVec2 pos) except +
    void ImDrawList_PathRect(ImDrawList* self, const ImVec2 rect_min, const ImVec2 rect_max, float rounding, ImDrawFlags flags) except +
    void ImDrawList_PathStroke(ImDrawList* self, ImU32 col, ImDrawFlags flags, float thickness) except +
    void ImDrawList_PopClipRect(ImDrawList* self) except +
    void ImDrawList_PopTextureID(ImDrawList* self) except +
    void ImDrawList_PrimQuadUV(ImDrawList* self, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 d, const ImVec2 uv_a, const ImVec2 uv_b, const ImVec2 uv_c, const ImVec2 uv_d, ImU32 col) except +
    void ImDrawList_PrimRect(ImDrawList* self, const ImVec2 a, const ImVec2 b, ImU32 col) except +
    void ImDrawList_PrimRectUV(ImDrawList* self, const ImVec2 a, const ImVec2 b, const ImVec2 uv_a, const ImVec2 uv_b, ImU32 col) except +
    void ImDrawList_PrimReserve(ImDrawList* self, int idx_count, int vtx_count) except +
    void ImDrawList_PrimUnreserve(ImDrawList* self, int idx_count, int vtx_count) except +
    void ImDrawList_PrimVtx(ImDrawList* self, const ImVec2 pos, const ImVec2 uv, ImU32 col) except +
    void ImDrawList_PrimWriteIdx(ImDrawList* self, ImDrawIdx idx) except +
    void ImDrawList_PrimWriteVtx(ImDrawList* self, const ImVec2 pos, const ImVec2 uv, ImU32 col) except +
    void ImDrawList_PushClipRect(ImDrawList* self, const ImVec2 clip_rect_min, const ImVec2 clip_rect_max, bool intersect_with_current_clip_rect) except +
    void ImDrawList_PushClipRectFullScreen(ImDrawList* self) except +
    void ImDrawList_PushTextureID(ImDrawList* self, ImTextureID texture_id) except +
    int ImDrawList__CalcCircleAutoSegmentCount(ImDrawList* self, float radius) except +
    void ImDrawList__ClearFreeMemory(ImDrawList* self) except +
    void ImDrawList__OnChangedClipRect(ImDrawList* self) except +
    void ImDrawList__OnChangedTextureID(ImDrawList* self) except +
    void ImDrawList__OnChangedVtxOffset(ImDrawList* self) except +
    void ImDrawList__PathArcToFastEx(ImDrawList* self, const ImVec2 center, float radius, int a_min_sample, int a_max_sample, int a_step) except +
    void ImDrawList__PathArcToN(ImDrawList* self, const ImVec2 center, float radius, float a_min, float a_max, int num_segments) except +
    void ImDrawList__PopUnusedDrawCmd(ImDrawList* self) except +
    void ImDrawList__ResetForNewFrame(ImDrawList* self) except +
    void ImDrawList__TryMergeDrawCmds(ImDrawList* self) except +
