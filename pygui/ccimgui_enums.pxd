cdef extern from "cimgui.h":
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