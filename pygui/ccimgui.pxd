# -*- coding: utf-8 -*-
# distutils: language = c++

from libcpp cimport bool

cdef extern from "cimgui.h":
    ctypedef struct ImBitArray_ImGuiKey_NamedKey_COUNT__lessImGuiKey_NamedKey_BEGIN
    ctypedef struct ImFontBuilderIO
    ctypedef struct ImFontGlyph
    ctypedef struct ImGuiContextHook
    ctypedef struct ImGuiDataTypeInfo
    ctypedef struct ImGuiDataTypeTempStorage
    ctypedef struct ImGuiDockNodeSettings
    ctypedef struct ImGuiDockRequest
    ctypedef struct ImGuiInputEventAppFocused
    ctypedef struct ImGuiInputEventKey
    ctypedef struct ImGuiInputEventMouseButton
    ctypedef struct ImGuiInputEventMousePos
    ctypedef struct ImGuiInputEventMouseViewport
    ctypedef struct ImGuiInputEventMouseWheel
    ctypedef struct ImGuiInputEventText
    ctypedef struct ImGuiInputTextCallbackData
    ctypedef struct ImGuiKeyData
    ctypedef struct ImGuiKeyOwnerData
    ctypedef struct ImGuiKeyRoutingData
    ctypedef struct ImGuiListClipper
    ctypedef struct ImGuiListClipperRange
    ctypedef struct ImGuiLocEntry
    ctypedef struct ImGuiMenuColumns
    ctypedef struct ImGuiMetricsConfig
    ctypedef struct ImGuiNextItemData
    ctypedef struct ImGuiOnceUponAFrame
    ctypedef struct ImGuiPayload
    ctypedef struct ImGuiPtrOrIndex
    ctypedef struct ImGuiSettingsHandler
    ctypedef struct ImGuiShrinkWidthItem
    ctypedef struct ImGuiStackLevelInfo
    ctypedef struct ImGuiStackSizes
    ctypedef struct ImGuiStoragePair
    ctypedef struct ImGuiStyleMod
    ctypedef struct ImGuiTabItem
    ctypedef struct ImGuiTableCellData
    ctypedef struct ImGuiTableColumnSettings
    ctypedef struct ImGuiTableColumnSortSpecs
    ctypedef struct ImGuiTableColumnsSettings
    ctypedef struct ImGuiTableInstanceData
    ctypedef struct ImGuiTableSettings
    ctypedef struct ImGuiTableSortSpecs
    ctypedef struct ImGuiTextRange
    ctypedef struct ImGuiWindowClass
    ctypedef struct ImGuiWindowDockStyle
    ctypedef struct ImSpan_ImGuiTableCellData
    ctypedef struct ImSpan_ImGuiTableColumnIdx
    ctypedef struct ImSpan_ImGuiTableColumn
    ctypedef struct ImVec1
    ctypedef struct ImVec2
    ctypedef struct ImVec2ih
    ctypedef struct ImVec4
    ctypedef struct ImVector_ImDrawChannel
    ctypedef struct ImVector_ImDrawCmd
    ctypedef struct ImVector_ImDrawIdx
    ctypedef struct ImVector_ImDrawListPtr
    ctypedef struct ImVector_ImDrawVert
    ctypedef struct ImVector_ImFontAtlasCustomRect
    ctypedef struct ImVector_ImFontConfig
    ctypedef struct ImVector_ImFontGlyph
    ctypedef struct ImVector_ImFontPtr
    ctypedef struct ImVector_ImGuiColorMod
    ctypedef struct ImVector_ImGuiContextHook
    ctypedef struct ImVector_ImGuiDockNodeSettings
    ctypedef struct ImVector_ImGuiDockRequest
    ctypedef struct ImVector_ImGuiGroupData
    ctypedef struct ImVector_ImGuiID
    ctypedef struct ImVector_ImGuiInputEvent
    ctypedef struct ImVector_ImGuiItemFlags
    ctypedef struct ImVector_ImGuiKeyRoutingData
    ctypedef struct ImVector_ImGuiListClipperData
    ctypedef struct ImVector_ImGuiListClipperRange
    ctypedef struct ImVector_ImGuiOldColumnData
    ctypedef struct ImVector_ImGuiOldColumns
    ctypedef struct ImVector_ImGuiPlatformMonitor
    ctypedef struct ImVector_ImGuiPopupData
    ctypedef struct ImVector_ImGuiPtrOrIndex
    ctypedef struct ImVector_ImGuiSettingsHandler
    ctypedef struct ImVector_ImGuiShrinkWidthItem
    ctypedef struct ImVector_ImGuiStackLevelInfo
    ctypedef struct ImVector_ImGuiStoragePair
    ctypedef struct ImVector_ImGuiStyleMod
    ctypedef struct ImVector_ImGuiTabBar
    ctypedef struct ImVector_ImGuiTabItem
    ctypedef struct ImVector_ImGuiTableColumnSortSpecs
    ctypedef struct ImVector_ImGuiTableInstanceData
    ctypedef struct ImVector_ImGuiTableTempData
    ctypedef struct ImVector_ImGuiTable
    ctypedef struct ImVector_ImGuiTextRange
    ctypedef struct ImVector_ImGuiViewportPPtr
    ctypedef struct ImVector_ImGuiViewportPtr
    ctypedef struct ImVector_ImGuiWindowPtr
    ctypedef struct ImVector_ImGuiWindowStackData
    ctypedef struct ImVector_ImTextureID
    ctypedef struct ImVector_ImU32
    ctypedef struct ImVector_ImVec2
    ctypedef struct ImVector_ImVec4
    ctypedef struct ImVector_ImWchar
    ctypedef struct ImVector_char
    ctypedef struct ImVector_const_charPtr
    ctypedef struct ImVector_float
    ctypedef struct ImVector_int
    ctypedef struct ImVector_unsigned_char
    ctypedef struct StbTexteditRow
    ctypedef struct StbUndoRecord
    ctypedef struct ImBitVector
    ctypedef struct ImChunkStream_ImGuiTableSettings
    ctypedef struct ImChunkStream_ImGuiWindowSettings
    ctypedef struct ImColor
    ctypedef struct ImDrawChannel
    ctypedef struct ImDrawCmd
    ctypedef struct ImDrawCmdHeader
    ctypedef struct ImDrawData
    ctypedef struct ImDrawDataBuilder
    ctypedef struct ImDrawListSharedData
    ctypedef struct ImDrawListSplitter
    ctypedef struct ImDrawVert
    ctypedef struct ImFont
    ctypedef struct ImFontAtlas
    ctypedef struct ImFontAtlasCustomRect
    ctypedef struct ImFontConfig
    ctypedef struct ImFontGlyphRangesBuilder
    ctypedef struct ImGuiColorMod
    ctypedef struct ImGuiDockNode
    ctypedef struct ImGuiGroupData
    ctypedef struct ImGuiIO
    ctypedef struct ImGuiInputEvent
    ctypedef struct ImGuiKeyRoutingTable
    ctypedef struct ImGuiListClipperData
    ctypedef struct ImGuiPlatformIO
    ctypedef struct ImGuiPlatformImeData
    ctypedef struct ImGuiPlatformMonitor
    ctypedef struct ImGuiPopupData
    ctypedef struct ImGuiSizeCallbackData
    ctypedef struct ImGuiStackTool
    ctypedef struct ImGuiStorage
    ctypedef struct ImGuiStyle
    ctypedef struct ImGuiTextBuffer
    ctypedef struct ImGuiTextFilter
    ctypedef struct ImGuiTextIndex
    ctypedef struct ImGuiViewport
    ctypedef struct ImGuiWindowSettings
    ctypedef struct ImGuiWindowTempData
    ctypedef struct ImRect
    ctypedef struct StbUndoState
    ctypedef struct ImDrawList
    ctypedef struct ImGuiComboPreviewData
    ctypedef struct ImGuiDockContext
    ctypedef struct ImGuiLastItemData
    ctypedef struct ImGuiNavItemData
    ctypedef struct ImGuiNextWindowData
    ctypedef struct ImGuiOldColumnData
    ctypedef struct ImGuiOldColumns
    ctypedef struct ImGuiTabBar
    ctypedef struct ImGuiTable
    ctypedef struct ImGuiTableColumn
    ctypedef struct ImGuiTableTempData
    ctypedef struct ImGuiViewportP
    ctypedef struct ImPool_ImGuiTabBar
    ctypedef struct ImPool_ImGuiTable
    ctypedef struct STB_TexteditState
    ctypedef struct ImGuiInputTextState
    ctypedef struct ImGuiWindow
    ctypedef struct ImGuiWindowStackData
    ctypedef struct ImGuiContext

    ctypedef int (*ImGuiInputTextCallback)(ImGuiInputTextCallbackData* data)
    ctypedef int ImDrawFlags
    ctypedef int ImDrawListFlags
    ctypedef int ImFontAtlasFlags
    ctypedef int ImGuiActivateFlags
    ctypedef int ImGuiBackendFlags
    ctypedef int ImGuiButtonFlags
    ctypedef int ImGuiCol
    ctypedef int ImGuiColorEditFlags
    ctypedef int ImGuiComboFlags
    ctypedef int ImGuiCond
    ctypedef int ImGuiConfigFlags
    ctypedef int ImGuiDataAuthority
    ctypedef int ImGuiDataType
    ctypedef int ImGuiDebugLogFlags
    ctypedef int ImGuiDir
    ctypedef int ImGuiDockNodeFlags
    ctypedef int ImGuiDragDropFlags
    ctypedef int ImGuiFocusedFlags
    ctypedef int ImGuiHoveredFlags
    ctypedef int ImGuiInputFlags
    ctypedef int ImGuiInputTextFlags
    ctypedef int ImGuiItemFlags
    ctypedef int ImGuiItemStatusFlags
    ctypedef int ImGuiKeyChord
    ctypedef int ImGuiLayoutType
    ctypedef int ImGuiMouseButton
    ctypedef int ImGuiMouseCursor
    ctypedef int ImGuiNavHighlightFlags
    ctypedef int ImGuiNavMoveFlags
    ctypedef int ImGuiNextItemDataFlags
    ctypedef int ImGuiNextWindowDataFlags
    ctypedef int ImGuiOldColumnFlags
    ctypedef int ImGuiPopupFlags
    ctypedef int ImGuiScrollFlags
    ctypedef int ImGuiSelectableFlags
    ctypedef int ImGuiSeparatorFlags
    ctypedef int ImGuiSliderFlags
    ctypedef int ImGuiSortDirection
    ctypedef int ImGuiStyleVar
    ctypedef int ImGuiTabBarFlags
    ctypedef int ImGuiTabItemFlags
    ctypedef int ImGuiTableBgTarget
    ctypedef int ImGuiTableColumnFlags
    ctypedef int ImGuiTableFlags
    ctypedef int ImGuiTableRowFlags
    ctypedef int ImGuiTextFlags
    ctypedef int ImGuiTooltipFlags
    ctypedef int ImGuiTreeNodeFlags
    ctypedef int ImGuiViewportFlags
    ctypedef int ImGuiWindowFlags
    ctypedef int ImPoolIdx
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
    ctypedef ImBitArray_ImGuiKey_NamedKey_COUNT__lessImGuiKey_NamedKey_BEGIN ImBitArrayForNamedKeys
    ctypedef ImS16 ImGuiKeyRoutingIndex
    ctypedef ImS16 ImGuiTableColumnIdx
    ctypedef ImU16 ImGuiTableDrawChannelIdx
    ctypedef ImU32* ImBitArrayPtr
    ctypedef ImWchar16 ImWchar
    ctypedef void (*ImDrawCallback)(const ImDrawList* parent_list,const ImDrawCmd* cmd)
    ctypedef void (*ImGuiContextHookCallback)(ImGuiContext* ctx,ImGuiContextHook* hook)
    ctypedef void (*ImGuiErrorLogCallback)(void* user_data,const char* fmt)
    ctypedef void (*ImGuiMemFreeFunc)(void* ptr,void* user_data)
    ctypedef void (*ImGuiSizeCallback)(ImGuiSizeCallbackData* data)
    ctypedef void* (*ImGuiMemAllocFunc)(size_t sz,void* user_data)
    ctypedef void* ImTextureID
    ctypedef void** ImFileHandle
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

    ctypedef enum ImGuiActivateFlags_:
        ImGuiActivateFlags_None
        ImGuiActivateFlags_PreferInput
        ImGuiActivateFlags_PreferTweak
        ImGuiActivateFlags_TryToPreserveState

    ctypedef enum ImGuiAxis:
        ImGuiAxis_None
        ImGuiAxis_X
        ImGuiAxis_Y

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

    ctypedef enum ImGuiButtonFlagsPrivate_:
        ImGuiButtonFlags_PressedOnClick
        ImGuiButtonFlags_PressedOnClickRelease
        ImGuiButtonFlags_PressedOnClickReleaseAnywhere
        ImGuiButtonFlags_PressedOnRelease
        ImGuiButtonFlags_PressedOnDoubleClick
        ImGuiButtonFlags_PressedOnDragDropHold
        ImGuiButtonFlags_Repeat
        ImGuiButtonFlags_FlattenChildren
        ImGuiButtonFlags_AllowItemOverlap
        ImGuiButtonFlags_DontClosePopups
        ImGuiButtonFlags_AlignTextBaseLine
        ImGuiButtonFlags_NoKeyModifiers
        ImGuiButtonFlags_NoHoldingActiveId
        ImGuiButtonFlags_NoNavFocus
        ImGuiButtonFlags_NoHoveredOnFocus
        ImGuiButtonFlags_NoSetKeyOwner
        ImGuiButtonFlags_NoTestKeyOwner
        ImGuiButtonFlags_PressedOnMask_
        ImGuiButtonFlags_PressedOnDefault_

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

    ctypedef enum ImGuiComboFlagsPrivate_:
        ImGuiComboFlags_CustomPreview

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

    ctypedef enum ImGuiContextHookType:
        ImGuiContextHookType_NewFramePre
        ImGuiContextHookType_NewFramePost
        ImGuiContextHookType_EndFramePre
        ImGuiContextHookType_EndFramePost
        ImGuiContextHookType_RenderPre
        ImGuiContextHookType_RenderPost
        ImGuiContextHookType_Shutdown
        ImGuiContextHookType_PendingRemoval_

    ctypedef enum ImGuiDataAuthority_:
        ImGuiDataAuthority_Auto
        ImGuiDataAuthority_DockNode
        ImGuiDataAuthority_Window

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

    ctypedef enum ImGuiDataTypePrivate_:
        ImGuiDataType_String
        ImGuiDataType_Pointer
        ImGuiDataType_ID

    ctypedef enum ImGuiDebugLogFlags_:
        ImGuiDebugLogFlags_None
        ImGuiDebugLogFlags_EventActiveId
        ImGuiDebugLogFlags_EventFocus
        ImGuiDebugLogFlags_EventPopup
        ImGuiDebugLogFlags_EventNav
        ImGuiDebugLogFlags_EventClipper
        ImGuiDebugLogFlags_EventIO
        ImGuiDebugLogFlags_EventDocking
        ImGuiDebugLogFlags_EventViewport
        ImGuiDebugLogFlags_EventMask_
        ImGuiDebugLogFlags_OutputToTTY

    ctypedef enum ImGuiDir_:
        ImGuiDir_None
        ImGuiDir_Left
        ImGuiDir_Right
        ImGuiDir_Up
        ImGuiDir_Down
        ImGuiDir_COUNT

    ctypedef enum ImGuiDockNodeFlagsPrivate_:
        ImGuiDockNodeFlags_DockSpace
        ImGuiDockNodeFlags_CentralNode
        ImGuiDockNodeFlags_NoTabBar
        ImGuiDockNodeFlags_HiddenTabBar
        ImGuiDockNodeFlags_NoWindowMenuButton
        ImGuiDockNodeFlags_NoCloseButton
        ImGuiDockNodeFlags_NoDocking
        ImGuiDockNodeFlags_NoDockingSplitMe
        ImGuiDockNodeFlags_NoDockingSplitOther
        ImGuiDockNodeFlags_NoDockingOverMe
        ImGuiDockNodeFlags_NoDockingOverOther
        ImGuiDockNodeFlags_NoDockingOverEmpty
        ImGuiDockNodeFlags_NoResizeX
        ImGuiDockNodeFlags_NoResizeY
        ImGuiDockNodeFlags_SharedFlagsInheritMask_
        ImGuiDockNodeFlags_NoResizeFlagsMask_
        ImGuiDockNodeFlags_LocalFlagsMask_
        ImGuiDockNodeFlags_LocalFlagsTransferMask_
        ImGuiDockNodeFlags_SavedFlagsMask_

    ctypedef enum ImGuiDockNodeFlags_:
        ImGuiDockNodeFlags_None
        ImGuiDockNodeFlags_KeepAliveOnly
        ImGuiDockNodeFlags_NoDockingInCentralNode
        ImGuiDockNodeFlags_PassthruCentralNode
        ImGuiDockNodeFlags_NoSplit
        ImGuiDockNodeFlags_NoResize
        ImGuiDockNodeFlags_AutoHideTabBar

    ctypedef enum ImGuiDockNodeState:
        ImGuiDockNodeState_Unknown
        ImGuiDockNodeState_HostWindowHiddenBecauseSingleWindow
        ImGuiDockNodeState_HostWindowHiddenBecauseWindowsAreResizing
        ImGuiDockNodeState_HostWindowVisible

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

    ctypedef enum ImGuiInputEventType:
        ImGuiInputEventType_None
        ImGuiInputEventType_MousePos
        ImGuiInputEventType_MouseWheel
        ImGuiInputEventType_MouseButton
        ImGuiInputEventType_MouseViewport
        ImGuiInputEventType_Key
        ImGuiInputEventType_Text
        ImGuiInputEventType_Focus
        ImGuiInputEventType_COUNT

    ctypedef enum ImGuiInputFlags_:
        ImGuiInputFlags_None
        ImGuiInputFlags_Repeat
        ImGuiInputFlags_RepeatRateDefault
        ImGuiInputFlags_RepeatRateNavMove
        ImGuiInputFlags_RepeatRateNavTweak
        ImGuiInputFlags_RepeatRateMask_
        ImGuiInputFlags_CondHovered
        ImGuiInputFlags_CondActive
        ImGuiInputFlags_CondDefault_
        ImGuiInputFlags_CondMask_
        ImGuiInputFlags_LockThisFrame
        ImGuiInputFlags_LockUntilRelease
        ImGuiInputFlags_RouteFocused
        ImGuiInputFlags_RouteGlobalLow
        ImGuiInputFlags_RouteGlobal
        ImGuiInputFlags_RouteGlobalHigh
        ImGuiInputFlags_RouteMask_
        ImGuiInputFlags_RouteAlways
        ImGuiInputFlags_RouteUnlessBgFocused
        ImGuiInputFlags_RouteExtraMask_
        ImGuiInputFlags_SupportedByIsKeyPressed
        ImGuiInputFlags_SupportedByShortcut
        ImGuiInputFlags_SupportedBySetKeyOwner
        ImGuiInputFlags_SupportedBySetItemKeyOwner

    ctypedef enum ImGuiInputSource:
        ImGuiInputSource_None
        ImGuiInputSource_Mouse
        ImGuiInputSource_Keyboard
        ImGuiInputSource_Gamepad
        ImGuiInputSource_Clipboard
        ImGuiInputSource_Nav
        ImGuiInputSource_COUNT

    ctypedef enum ImGuiInputTextFlagsPrivate_:
        ImGuiInputTextFlags_Multiline
        ImGuiInputTextFlags_NoMarkEdited
        ImGuiInputTextFlags_MergedItem

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

    ctypedef enum ImGuiItemFlags_:
        ImGuiItemFlags_None
        ImGuiItemFlags_NoTabStop
        ImGuiItemFlags_ButtonRepeat
        ImGuiItemFlags_Disabled
        ImGuiItemFlags_NoNav
        ImGuiItemFlags_NoNavDefaultFocus
        ImGuiItemFlags_SelectableDontClosePopup
        ImGuiItemFlags_MixedValue
        ImGuiItemFlags_ReadOnly
        ImGuiItemFlags_NoWindowHoverableCheck
        ImGuiItemFlags_Inputable

    ctypedef enum ImGuiItemStatusFlags_:
        ImGuiItemStatusFlags_None
        ImGuiItemStatusFlags_HoveredRect
        ImGuiItemStatusFlags_HasDisplayRect
        ImGuiItemStatusFlags_Edited
        ImGuiItemStatusFlags_ToggledSelection
        ImGuiItemStatusFlags_ToggledOpen
        ImGuiItemStatusFlags_HasDeactivated
        ImGuiItemStatusFlags_Deactivated
        ImGuiItemStatusFlags_HoveredWindow
        ImGuiItemStatusFlags_FocusedByTabbing
        ImGuiItemStatusFlags_Visible

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

    ctypedef enum ImGuiLayoutType_:
        ImGuiLayoutType_Horizontal
        ImGuiLayoutType_Vertical

    ctypedef enum ImGuiLocKey:
        ImGuiLocKey_TableSizeOne
        ImGuiLocKey_TableSizeAllFit
        ImGuiLocKey_TableSizeAllDefault
        ImGuiLocKey_TableResetOrder
        ImGuiLocKey_WindowingMainMenuBar
        ImGuiLocKey_WindowingPopup
        ImGuiLocKey_WindowingUntitled
        ImGuiLocKey_DockingHideTabBar
        ImGuiLocKey_COUNT

    ctypedef enum ImGuiLogType:
        ImGuiLogType_None
        ImGuiLogType_TTY
        ImGuiLogType_File
        ImGuiLogType_Buffer
        ImGuiLogType_Clipboard

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

    ctypedef enum ImGuiNavHighlightFlags_:
        ImGuiNavHighlightFlags_None
        ImGuiNavHighlightFlags_TypeDefault
        ImGuiNavHighlightFlags_TypeThin
        ImGuiNavHighlightFlags_AlwaysDraw
        ImGuiNavHighlightFlags_NoRounding

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

    ctypedef enum ImGuiNavLayer:
        ImGuiNavLayer_Main
        ImGuiNavLayer_Menu
        ImGuiNavLayer_COUNT

    ctypedef enum ImGuiNavMoveFlags_:
        ImGuiNavMoveFlags_None
        ImGuiNavMoveFlags_LoopX
        ImGuiNavMoveFlags_LoopY
        ImGuiNavMoveFlags_WrapX
        ImGuiNavMoveFlags_WrapY
        ImGuiNavMoveFlags_AllowCurrentNavId
        ImGuiNavMoveFlags_AlsoScoreVisibleSet
        ImGuiNavMoveFlags_ScrollToEdgeY
        ImGuiNavMoveFlags_Forwarded
        ImGuiNavMoveFlags_DebugNoResult
        ImGuiNavMoveFlags_FocusApi
        ImGuiNavMoveFlags_Tabbing
        ImGuiNavMoveFlags_Activate
        ImGuiNavMoveFlags_DontSetNavHighlight

    ctypedef enum ImGuiNextItemDataFlags_:
        ImGuiNextItemDataFlags_None
        ImGuiNextItemDataFlags_HasWidth
        ImGuiNextItemDataFlags_HasOpen

    ctypedef enum ImGuiNextWindowDataFlags_:
        ImGuiNextWindowDataFlags_None
        ImGuiNextWindowDataFlags_HasPos
        ImGuiNextWindowDataFlags_HasSize
        ImGuiNextWindowDataFlags_HasContentSize
        ImGuiNextWindowDataFlags_HasCollapsed
        ImGuiNextWindowDataFlags_HasSizeConstraint
        ImGuiNextWindowDataFlags_HasFocus
        ImGuiNextWindowDataFlags_HasBgAlpha
        ImGuiNextWindowDataFlags_HasScroll
        ImGuiNextWindowDataFlags_HasViewport
        ImGuiNextWindowDataFlags_HasDock
        ImGuiNextWindowDataFlags_HasWindowClass

    ctypedef enum ImGuiOldColumnFlags_:
        ImGuiOldColumnFlags_None
        ImGuiOldColumnFlags_NoBorder
        ImGuiOldColumnFlags_NoResize
        ImGuiOldColumnFlags_NoPreserveWidths
        ImGuiOldColumnFlags_NoForceWithinWindow
        ImGuiOldColumnFlags_GrowParentContentsSize

    ctypedef enum ImGuiPlotType:
        ImGuiPlotType_Lines
        ImGuiPlotType_Histogram

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

    ctypedef enum ImGuiPopupPositionPolicy:
        ImGuiPopupPositionPolicy_Default
        ImGuiPopupPositionPolicy_ComboBox
        ImGuiPopupPositionPolicy_Tooltip

    ctypedef enum ImGuiScrollFlags_:
        ImGuiScrollFlags_None
        ImGuiScrollFlags_KeepVisibleEdgeX
        ImGuiScrollFlags_KeepVisibleEdgeY
        ImGuiScrollFlags_KeepVisibleCenterX
        ImGuiScrollFlags_KeepVisibleCenterY
        ImGuiScrollFlags_AlwaysCenterX
        ImGuiScrollFlags_AlwaysCenterY
        ImGuiScrollFlags_NoScrollParent
        ImGuiScrollFlags_MaskX_
        ImGuiScrollFlags_MaskY_

    ctypedef enum ImGuiSelectableFlagsPrivate_:
        ImGuiSelectableFlags_NoHoldingActiveID
        ImGuiSelectableFlags_SelectOnNav
        ImGuiSelectableFlags_SelectOnClick
        ImGuiSelectableFlags_SelectOnRelease
        ImGuiSelectableFlags_SpanAvailWidth
        ImGuiSelectableFlags_SetNavIdOnHover
        ImGuiSelectableFlags_NoPadWithHalfSpacing
        ImGuiSelectableFlags_NoSetKeyOwner

    ctypedef enum ImGuiSelectableFlags_:
        ImGuiSelectableFlags_None
        ImGuiSelectableFlags_DontClosePopups
        ImGuiSelectableFlags_SpanAllColumns
        ImGuiSelectableFlags_AllowDoubleClick
        ImGuiSelectableFlags_Disabled
        ImGuiSelectableFlags_AllowItemOverlap

    ctypedef enum ImGuiSeparatorFlags_:
        ImGuiSeparatorFlags_None
        ImGuiSeparatorFlags_Horizontal
        ImGuiSeparatorFlags_Vertical
        ImGuiSeparatorFlags_SpanAllColumns

    ctypedef enum ImGuiSliderFlags_:
        ImGuiSliderFlags_None
        ImGuiSliderFlags_AlwaysClamp
        ImGuiSliderFlags_Logarithmic
        ImGuiSliderFlags_NoRoundToFormat
        ImGuiSliderFlags_NoInput
        ImGuiSliderFlags_InvalidMask_

    ctypedef enum ImGuiSliderFlagsPrivate_:
        ImGuiSliderFlags_Vertical
        ImGuiSliderFlags_ReadOnly

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

    ctypedef enum ImGuiTabBarFlagsPrivate_:
        ImGuiTabBarFlags_DockNode
        ImGuiTabBarFlags_IsFocused
        ImGuiTabBarFlags_SaveSettings

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

    ctypedef enum ImGuiTabItemFlagsPrivate_:
        ImGuiTabItemFlags_SectionMask_
        ImGuiTabItemFlags_NoCloseButton
        ImGuiTabItemFlags_Button
        ImGuiTabItemFlags_Unsorted
        ImGuiTabItemFlags_Preview

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

    ctypedef enum ImGuiTextFlags_:
        ImGuiTextFlags_None
        ImGuiTextFlags_NoWidthForLargeClippedText

    ctypedef enum ImGuiTooltipFlags_:
        ImGuiTooltipFlags_None
        ImGuiTooltipFlags_OverridePreviousTooltip

    ctypedef enum ImGuiTreeNodeFlagsPrivate_:
        ImGuiTreeNodeFlags_ClipLabelForTrailingButton

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

    ctypedef enum ImGuiWindowDockStyleCol:
        ImGuiWindowDockStyleCol_Text
        ImGuiWindowDockStyleCol_Tab
        ImGuiWindowDockStyleCol_TabHovered
        ImGuiWindowDockStyleCol_TabActive
        ImGuiWindowDockStyleCol_TabUnfocused
        ImGuiWindowDockStyleCol_TabUnfocusedActive
        ImGuiWindowDockStyleCol_COUNT

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



    ctypedef struct ImBitArray_ImGuiKey_NamedKey_COUNT__lessImGuiKey_NamedKey_BEGIN:
        ImU32 Storage

    ctypedef struct ImFontBuilderIO:
        bool (*FontBuilder_Build)(ImFontAtlas* atlas)

    ctypedef struct ImFontGlyph:
        unsigned int Colored
        unsigned int Visible
        unsigned int Codepoint
        float AdvanceX
        float X0, Y0, X1, Y1
        float U0, V0, U1, V1

    ctypedef struct ImGuiContextHook:
        ImGuiID HookId
        ImGuiContextHookType Type
        ImGuiID Owner
        ImGuiContextHookCallback Callback
        void* UserData

    ctypedef struct ImGuiDataTypeInfo:
        size_t Size
        const char* Name
        const char* PrintFmt
        const char* ScanFmt

    ctypedef struct ImGuiDataTypeTempStorage:
        ImU8 Data

    ctypedef struct ImGuiDockNodeSettings:
        pass

    ctypedef struct ImGuiDockRequest:
        pass

    ctypedef struct ImGuiInputEventAppFocused:
        bool Focused

    ctypedef struct ImGuiInputEventKey:
        ImGuiKey Key
        bool Down
        float AnalogValue

    ctypedef struct ImGuiInputEventMouseButton:
        int Button
        bool Down

    ctypedef struct ImGuiInputEventMousePos:
        float PosX, PosY

    ctypedef struct ImGuiInputEventMouseViewport:
        ImGuiID HoveredViewportID

    ctypedef struct ImGuiInputEventMouseWheel:
        float WheelX, WheelY

    ctypedef struct ImGuiInputEventText:
        unsigned int Char

    ctypedef struct ImGuiInputTextCallbackData:
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

    ctypedef struct ImGuiKeyData:
        bool Down
        float DownDuration
        float DownDurationPrev
        float AnalogValue

    ctypedef struct ImGuiKeyOwnerData:
        ImGuiID OwnerCurr
        ImGuiID OwnerNext
        bool LockThisFrame
        bool LockUntilRelease

    ctypedef struct ImGuiKeyRoutingData:
        ImGuiKeyRoutingIndex NextEntryIndex
        ImU16 Mods
        ImU8 RoutingNextScore
        ImGuiID RoutingCurr
        ImGuiID RoutingNext

    ctypedef struct ImGuiListClipper:
        int DisplayStart
        int DisplayEnd
        int ItemsCount
        float ItemsHeight
        float StartPosY
        void* TempData

    ctypedef struct ImGuiListClipperRange:
        int Min
        int Max
        bool PosToIndexConvert
        ImS8 PosToIndexOffsetMin
        ImS8 PosToIndexOffsetMax

    ctypedef struct ImGuiLocEntry:
        ImGuiLocKey Key
        const char* Text

    ctypedef struct ImGuiMenuColumns:
        ImU32 TotalWidth
        ImU32 NextTotalWidth
        ImU16 Spacing
        ImU16 OffsetIcon
        ImU16 OffsetLabel
        ImU16 OffsetShortcut
        ImU16 OffsetMark
        ImU16 Widths

    ctypedef struct ImGuiMetricsConfig:
        bool ShowDebugLog
        bool ShowStackTool
        bool ShowWindowsRects
        bool ShowWindowsBeginOrder
        bool ShowTablesRects
        bool ShowDrawCmdMesh
        bool ShowDrawCmdBoundingBoxes
        bool ShowAtlasTintedWithTextColor
        bool ShowDockingNodes
        int ShowWindowsRectsType
        int ShowTablesRectsType

    ctypedef struct ImGuiNextItemData:
        ImGuiNextItemDataFlags Flags
        float Width
        ImGuiID FocusScopeId
        ImGuiCond OpenCond
        bool OpenVal

    ctypedef struct ImGuiOnceUponAFrame:
        int RefFrame

    ctypedef struct ImGuiPayload:
        void* Data
        int DataSize
        ImGuiID SourceId
        ImGuiID SourceParentId
        int DataFrameCount
        char DataType
        bool Preview
        bool Delivery

    ctypedef struct ImGuiPtrOrIndex:
        void* Ptr
        int Index

    ctypedef struct ImGuiSettingsHandler:
        const char* TypeName
        ImGuiID TypeHash
        void (*ClearAllFn)(ImGuiContext* ctx, ImGuiSettingsHandler* handler)
        void (*ReadInitFn)(ImGuiContext* ctx, ImGuiSettingsHandler* handler)
        void* (*ReadOpenFn)(ImGuiContext* ctx, ImGuiSettingsHandler* handler, const char* name)
        void (*ReadLineFn)(ImGuiContext* ctx, ImGuiSettingsHandler* handler, void* entry, const char* line)
        void (*ApplyAllFn)(ImGuiContext* ctx, ImGuiSettingsHandler* handler)
        void (*WriteAllFn)(ImGuiContext* ctx, ImGuiSettingsHandler* handler, ImGuiTextBuffer* out_buf)
        void* UserData

    ctypedef struct ImGuiShrinkWidthItem:
        int Index
        float Width
        float InitialWidth

    ctypedef struct ImGuiStackLevelInfo:
        ImGuiID ID
        ImS8 QueryFrameCount
        bool QuerySuccess
        ImGuiDataType DataType
        char Desc

    ctypedef struct ImGuiStackSizes:
        short SizeOfIDStack
        short SizeOfColorStack
        short SizeOfStyleVarStack
        short SizeOfFontStack
        short SizeOfFocusScopeStack
        short SizeOfGroupStack
        short SizeOfItemFlagsStack
        short SizeOfBeginPopupStack
        short SizeOfDisabledStack

    ctypedef struct ImGuiStoragePair:
        ImGuiID key
        int val_i
        float val_f
        void* val_p

    ctypedef struct ImGuiStyleMod:
        ImGuiStyleVar VarIdx
        int BackupInt
        float BackupFloat

    ctypedef struct ImGuiTabItem:
        ImGuiID ID
        ImGuiTabItemFlags Flags
        ImGuiWindow* Window
        int LastFrameVisible
        int LastFrameSelected
        float Offset
        float Width
        float ContentWidth
        float RequestedWidth
        ImS32 NameOffset
        ImS16 BeginOrder
        ImS16 IndexDuringLayout
        bool WantClose

    ctypedef struct ImGuiTableCellData:
        ImU32 BgColor
        ImGuiTableColumnIdx Column

    ctypedef struct ImGuiTableColumnSettings:
        float WidthOrWeight
        ImGuiID UserID
        ImGuiTableColumnIdx Index
        ImGuiTableColumnIdx DisplayOrder
        ImGuiTableColumnIdx SortOrder
        ImU8 SortDirection
        ImU8 IsEnabled
        ImU8 IsStretch

    ctypedef struct ImGuiTableColumnSortSpecs:
        ImGuiID ColumnUserID
        ImS16 ColumnIndex
        ImS16 SortOrder
        ImGuiSortDirection SortDirection

    ctypedef struct ImGuiTableColumnsSettings:
        pass

    ctypedef struct ImGuiTableInstanceData:
        ImGuiID TableInstanceID
        float LastOuterHeight
        float LastFirstRowHeight
        float LastFrozenHeight

    ctypedef struct ImGuiTableSettings:
        ImGuiID ID
        ImGuiTableFlags SaveFlags
        float RefScale
        ImGuiTableColumnIdx ColumnsCount
        ImGuiTableColumnIdx ColumnsCountMax
        bool WantApply

    ctypedef struct ImGuiTableSortSpecs:
        const ImGuiTableColumnSortSpecs* Specs
        int SpecsCount
        bool SpecsDirty

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

    ctypedef struct ImGuiWindowDockStyle:
        ImU32 Colors

    ctypedef struct ImSpan_ImGuiTableCellData:
        ImGuiTableCellData* Data
        ImGuiTableCellData* DataEnd

    ctypedef struct ImSpan_ImGuiTableColumnIdx:
        ImGuiTableColumnIdx* Data
        ImGuiTableColumnIdx* DataEnd

    ctypedef struct ImSpan_ImGuiTableColumn:
        ImGuiTableColumn* Data
        ImGuiTableColumn* DataEnd

    ctypedef struct ImVec1:
        float x

    ctypedef struct ImVec2:
        float x, y

    ctypedef struct ImVec2ih:
        short x, y

    ctypedef struct ImVec4:
        float x, y, z, w

    ctypedef struct ImVector_ImDrawChannel:
        int Size
        int Capacity
        ImDrawChannel* Data

    ctypedef struct ImVector_ImDrawCmd:
        int Size
        int Capacity
        ImDrawCmd* Data

    ctypedef struct ImVector_ImDrawIdx:
        int Size
        int Capacity
        ImDrawIdx* Data

    ctypedef struct ImVector_ImDrawListPtr:
        int Size
        int Capacity
        ImDrawList** Data

    ctypedef struct ImVector_ImDrawVert:
        int Size
        int Capacity
        ImDrawVert* Data

    ctypedef struct ImVector_ImFontAtlasCustomRect:
        int Size
        int Capacity
        ImFontAtlasCustomRect* Data

    ctypedef struct ImVector_ImFontConfig:
        int Size
        int Capacity
        ImFontConfig* Data

    ctypedef struct ImVector_ImFontGlyph:
        int Size
        int Capacity
        ImFontGlyph* Data

    ctypedef struct ImVector_ImFontPtr:
        int Size
        int Capacity
        ImFont** Data

    ctypedef struct ImVector_ImGuiColorMod:
        int Size
        int Capacity
        ImGuiColorMod* Data

    ctypedef struct ImVector_ImGuiContextHook:
        int Size
        int Capacity
        ImGuiContextHook* Data

    ctypedef struct ImVector_ImGuiDockNodeSettings:
        int Size
        int Capacity
        ImGuiDockNodeSettings* Data

    ctypedef struct ImVector_ImGuiDockRequest:
        int Size
        int Capacity
        ImGuiDockRequest* Data

    ctypedef struct ImVector_ImGuiGroupData:
        int Size
        int Capacity
        ImGuiGroupData* Data

    ctypedef struct ImVector_ImGuiID:
        int Size
        int Capacity
        ImGuiID* Data

    ctypedef struct ImVector_ImGuiInputEvent:
        int Size
        int Capacity
        ImGuiInputEvent* Data

    ctypedef struct ImVector_ImGuiItemFlags:
        int Size
        int Capacity
        ImGuiItemFlags* Data

    ctypedef struct ImVector_ImGuiKeyRoutingData:
        int Size
        int Capacity
        ImGuiKeyRoutingData* Data

    ctypedef struct ImVector_ImGuiListClipperData:
        int Size
        int Capacity
        ImGuiListClipperData* Data

    ctypedef struct ImVector_ImGuiListClipperRange:
        int Size
        int Capacity
        ImGuiListClipperRange* Data

    ctypedef struct ImVector_ImGuiOldColumnData:
        int Size
        int Capacity
        ImGuiOldColumnData* Data

    ctypedef struct ImVector_ImGuiOldColumns:
        int Size
        int Capacity
        ImGuiOldColumns* Data

    ctypedef struct ImVector_ImGuiPlatformMonitor:
        int Size
        int Capacity
        ImGuiPlatformMonitor* Data

    ctypedef struct ImVector_ImGuiPopupData:
        int Size
        int Capacity
        ImGuiPopupData* Data

    ctypedef struct ImVector_ImGuiPtrOrIndex:
        int Size
        int Capacity
        ImGuiPtrOrIndex* Data

    ctypedef struct ImVector_ImGuiSettingsHandler:
        int Size
        int Capacity
        ImGuiSettingsHandler* Data

    ctypedef struct ImVector_ImGuiShrinkWidthItem:
        int Size
        int Capacity
        ImGuiShrinkWidthItem* Data

    ctypedef struct ImVector_ImGuiStackLevelInfo:
        int Size
        int Capacity
        ImGuiStackLevelInfo* Data

    ctypedef struct ImVector_ImGuiStoragePair:
        int Size
        int Capacity
        ImGuiStoragePair* Data

    ctypedef struct ImVector_ImGuiStyleMod:
        int Size
        int Capacity
        ImGuiStyleMod* Data

    ctypedef struct ImVector_ImGuiTabBar:
        int Size
        int Capacity
        ImGuiTabBar* Data

    ctypedef struct ImVector_ImGuiTabItem:
        int Size
        int Capacity
        ImGuiTabItem* Data

    ctypedef struct ImVector_ImGuiTableColumnSortSpecs:
        int Size
        int Capacity
        ImGuiTableColumnSortSpecs* Data

    ctypedef struct ImVector_ImGuiTableInstanceData:
        int Size
        int Capacity
        ImGuiTableInstanceData* Data

    ctypedef struct ImVector_ImGuiTableTempData:
        int Size
        int Capacity
        ImGuiTableTempData* Data

    ctypedef struct ImVector_ImGuiTable:
        int Size
        int Capacity
        ImGuiTable* Data

    ctypedef struct ImVector_ImGuiTextRange:
        int Size
        int Capacity
        ImGuiTextRange* Data

    ctypedef struct ImVector_ImGuiViewportPPtr:
        int Size
        int Capacity
        ImGuiViewportP** Data

    ctypedef struct ImVector_ImGuiViewportPtr:
        int Size
        int Capacity
        ImGuiViewport** Data

    ctypedef struct ImVector_ImGuiWindowPtr:
        int Size
        int Capacity
        ImGuiWindow** Data

    ctypedef struct ImVector_ImGuiWindowStackData:
        int Size
        int Capacity
        ImGuiWindowStackData* Data

    ctypedef struct ImVector_ImTextureID:
        int Size
        int Capacity
        ImTextureID* Data

    ctypedef struct ImVector_ImU32:
        int Size
        int Capacity
        ImU32* Data

    ctypedef struct ImVector_ImVec2:
        int Size
        int Capacity
        ImVec2* Data

    ctypedef struct ImVector_ImVec4:
        int Size
        int Capacity
        ImVec4* Data

    ctypedef struct ImVector_ImWchar:
        int Size
        int Capacity
        ImWchar* Data

    ctypedef struct ImVector_char:
        int Size
        int Capacity
        char* Data

    ctypedef struct ImVector_const_charPtr:
        int Size
        int Capacity
        const char** Data

    ctypedef struct ImVector_float:
        int Size
        int Capacity
        float* Data

    ctypedef struct ImVector_int:
        int Size
        int Capacity
        int* Data

    ctypedef struct ImVector_unsigned_char:
        int Size
        int Capacity
        unsigned char* Data

    ctypedef struct StbTexteditRow:
        float x0, x1
        float baseline_y_delta
        float ymin, ymax
        int num_chars

    ctypedef struct StbUndoRecord:
        int where
        int insert_length
        int delete_length
        int char_storage

    ctypedef struct ImBitVector:
        ImVector_ImU32 Storage

    ctypedef struct ImChunkStream_ImGuiTableSettings:
        ImVector_char Buf

    ctypedef struct ImChunkStream_ImGuiWindowSettings:
        ImVector_char Buf

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
        ImDrawCallback UserCallback
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

    ctypedef struct ImDrawDataBuilder:
        ImVector_ImDrawListPtr Layers

    ctypedef struct ImDrawListSharedData:
        ImVec2 TexUvWhitePixel
        ImFont* Font
        float FontSize
        float CurveTessellationTol
        float CircleSegmentMaxError
        ImVec4 ClipRectFullscreen
        ImDrawListFlags InitialFlags
        ImVector_ImVec2 TempBuffer
        ImVec2 ArcFastVtx
        float ArcFastRadiusCutoff
        ImU8 CircleSegmentCounts
        const ImVec4* TexUvLines

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
        float Ascent, Descent
        int MetricsTotalSurface
        ImU8 Used4kPagesMap

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

    ctypedef struct ImFontAtlasCustomRect:
        unsigned short Width, Height
        unsigned short X, Y
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
        char Name
        ImFont* DstFont

    ctypedef struct ImFontGlyphRangesBuilder:
        ImVector_ImU32 UsedChars

    ctypedef struct ImGuiColorMod:
        ImGuiCol Col
        ImVec4 BackupValue

    ctypedef struct ImGuiDockNode:
        ImGuiID ID
        ImGuiDockNodeFlags SharedFlags
        ImGuiDockNodeFlags LocalFlags
        ImGuiDockNodeFlags LocalFlagsInWindows
        ImGuiDockNodeFlags MergedFlags
        ImGuiDockNodeState State
        ImGuiDockNode* ParentNode
        ImGuiDockNode* ChildNodes
        ImVector_ImGuiWindowPtr Windows
        ImGuiTabBar* TabBar
        ImVec2 Pos
        ImVec2 Size
        ImVec2 SizeRef
        ImGuiAxis SplitAxis
        ImGuiWindowClass WindowClass
        ImU32 LastBgColor
        ImGuiWindow* HostWindow
        ImGuiWindow* VisibleWindow
        ImGuiDockNode* CentralNode
        ImGuiDockNode* OnlyNodeWithWindows
        int CountNodeWithWindows
        int LastFrameAlive
        int LastFrameActive
        int LastFrameFocused
        ImGuiID LastFocusedNodeId
        ImGuiID SelectedTabId
        ImGuiID WantCloseTabId
        ImGuiDataAuthority AuthorityForPos
        ImGuiDataAuthority AuthorityForSize
        ImGuiDataAuthority AuthorityForViewport
        bool IsVisible
        bool IsFocused
        bool IsBgDrawnThisFrame
        bool HasCloseButton
        bool HasWindowMenuButton
        bool HasCentralNodeChild
        bool WantCloseAll
        bool WantLockSizeOnce
        bool WantMouseMove
        bool WantHiddenTabBarUpdate
        bool WantHiddenTabBarToggle

    ctypedef struct ImGuiGroupData:
        ImGuiID WindowID
        ImVec2 BackupCursorPos
        ImVec2 BackupCursorMaxPos
        ImVec1 BackupIndent
        ImVec1 BackupGroupOffset
        ImVec2 BackupCurrLineSize
        float BackupCurrLineTextBaseOffset
        ImGuiID BackupActiveIdIsAlive
        bool BackupActiveIdPreviousFrameIsAlive
        bool BackupHoveredIdIsAlive
        bool EmitItem

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
        const char* (*GetClipboardTextFn)(void* user_data)
        void (*SetClipboardTextFn)(void* user_data, const char* text)
        void* ClipboardUserData
        void (*SetPlatformImeDataFn)(ImGuiViewport* viewport, ImGuiPlatformImeData* data)
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
        int KeyMap
        bool KeysDown
        float NavInputs
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

    ctypedef struct ImGuiInputEvent:
        ImGuiInputEventType Type
        ImGuiInputSource Source
        ImGuiInputEventMousePos MousePos
        ImGuiInputEventMouseWheel MouseWheel
        ImGuiInputEventMouseButton MouseButton
        ImGuiInputEventMouseViewport MouseViewport
        ImGuiInputEventKey Key
        ImGuiInputEventText Text
        ImGuiInputEventAppFocused AppFocused
        bool AddedByTestEngine

    ctypedef struct ImGuiKeyRoutingTable:
        ImGuiKeyRoutingIndex Index
        ImVector_ImGuiKeyRoutingData Entries
        ImVector_ImGuiKeyRoutingData EntriesNext

    ctypedef struct ImGuiListClipperData:
        ImGuiListClipper* ListClipper
        float LossynessOffset
        int StepNo
        int ItemsFrozen
        ImVector_ImGuiListClipperRange Ranges

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

    ctypedef struct ImGuiPlatformImeData:
        bool WantVisible
        ImVec2 InputPos
        float InputLineHeight

    ctypedef struct ImGuiPlatformMonitor:
        ImVec2 MainPos, MainSize
        ImVec2 WorkPos, WorkSize
        float DpiScale

    ctypedef struct ImGuiPopupData:
        ImGuiID PopupId
        ImGuiWindow* Window
        ImGuiWindow* BackupNavWindow
        int ParentNavLayer
        int OpenFrameCount
        ImGuiID OpenParentId
        ImVec2 OpenPopupPos
        ImVec2 OpenMousePos

    ctypedef struct ImGuiSizeCallbackData:
        void* UserData
        ImVec2 Pos
        ImVec2 CurrentSize
        ImVec2 DesiredSize

    ctypedef struct ImGuiStackTool:
        int LastActiveFrame
        int StackLevel
        ImGuiID QueryId
        ImVector_ImGuiStackLevelInfo Results
        bool CopyToClipboardOnCtrlC
        float CopyToClipboardLastTime

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
        ImVec4 Colors

    ctypedef struct ImGuiTextBuffer:
        ImVector_char Buf

    ctypedef struct ImGuiTextFilter:
        char InputBuf
        ImVector_ImGuiTextRange Filters
        int CountGrep

    ctypedef struct ImGuiTextIndex:
        ImVector_int LineOffsets
        int EndOffset

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

    ctypedef struct ImGuiWindowSettings:
        ImGuiID ID
        ImVec2ih Pos
        ImVec2ih Size
        ImVec2ih ViewportPos
        ImGuiID ViewportId
        ImGuiID DockId
        ImGuiID ClassId
        short DockOrder
        bool Collapsed
        bool WantApply
        bool WantDelete

    ctypedef struct ImGuiWindowTempData:
        ImVec2 CursorPos
        ImVec2 CursorPosPrevLine
        ImVec2 CursorStartPos
        ImVec2 CursorMaxPos
        ImVec2 IdealMaxPos
        ImVec2 CurrLineSize
        ImVec2 PrevLineSize
        float CurrLineTextBaseOffset
        float PrevLineTextBaseOffset
        bool IsSameLine
        bool IsSetPos
        ImVec1 Indent
        ImVec1 ColumnsOffset
        ImVec1 GroupOffset
        ImVec2 CursorStartPosLossyness
        ImGuiNavLayer NavLayerCurrent
        short NavLayersActiveMask
        short NavLayersActiveMaskNext
        bool NavHideHighlightOneFrame
        bool NavHasScroll
        bool MenuBarAppending
        ImVec2 MenuBarOffset
        ImGuiMenuColumns MenuColumns
        int TreeDepth
        ImU32 TreeJumpToParentOnPopMask
        ImVector_ImGuiWindowPtr ChildWindows
        ImGuiStorage* StateStorage
        ImGuiOldColumns* CurrentColumns
        int CurrentTableIdx
        ImGuiLayoutType LayoutType
        ImGuiLayoutType ParentLayoutType
        float ItemWidth
        float TextWrapPos
        ImVector_float ItemWidthStack
        ImVector_float TextWrapPosStack

    ctypedef struct ImRect:
        ImVec2 Min
        ImVec2 Max

    ctypedef struct StbUndoState:
        StbUndoRecord undo_rec
        ImWchar undo_char
        short undo_point, redo_point
        int undo_char_point, redo_char_point

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

    ctypedef struct ImGuiComboPreviewData:
        ImRect PreviewRect
        ImVec2 BackupCursorPos
        ImVec2 BackupCursorMaxPos
        ImVec2 BackupCursorPosPrevLine
        float BackupPrevLineTextBaseOffset
        ImGuiLayoutType BackupLayout

    ctypedef struct ImGuiDockContext:
        ImGuiStorage Nodes
        ImVector_ImGuiDockRequest Requests
        ImVector_ImGuiDockNodeSettings NodesSettings
        bool WantFullRebuild

    ctypedef struct ImGuiLastItemData:
        ImGuiID ID
        ImGuiItemFlags InFlags
        ImGuiItemStatusFlags StatusFlags
        ImRect Rect
        ImRect NavRect
        ImRect DisplayRect

    ctypedef struct ImGuiNavItemData:
        ImGuiWindow* Window
        ImGuiID ID
        ImGuiID FocusScopeId
        ImRect RectRel
        ImGuiItemFlags InFlags
        float DistBox
        float DistCenter
        float DistAxial

    ctypedef struct ImGuiNextWindowData:
        ImGuiNextWindowDataFlags Flags
        ImGuiCond PosCond
        ImGuiCond SizeCond
        ImGuiCond CollapsedCond
        ImGuiCond DockCond
        ImVec2 PosVal
        ImVec2 PosPivotVal
        ImVec2 SizeVal
        ImVec2 ContentSizeVal
        ImVec2 ScrollVal
        bool PosUndock
        bool CollapsedVal
        ImRect SizeConstraintRect
        ImGuiSizeCallback SizeCallback
        void* SizeCallbackUserData
        float BgAlphaVal
        ImGuiID ViewportId
        ImGuiID DockId
        ImGuiWindowClass WindowClass
        ImVec2 MenuBarOffsetMinVal

    ctypedef struct ImGuiOldColumnData:
        float OffsetNorm
        float OffsetNormBeforeResize
        ImGuiOldColumnFlags Flags
        ImRect ClipRect

    ctypedef struct ImGuiOldColumns:
        ImGuiID ID
        ImGuiOldColumnFlags Flags
        bool IsFirstFrame
        bool IsBeingResized
        int Current
        int Count
        float OffMinX, OffMaxX
        float LineMinY, LineMaxY
        float HostCursorPosY
        float HostCursorMaxPosX
        ImRect HostInitialClipRect
        ImRect HostBackupClipRect
        ImRect HostBackupParentWorkRect
        ImVector_ImGuiOldColumnData Columns
        ImDrawListSplitter Splitter

    ctypedef struct ImGuiTabBar:
        ImVector_ImGuiTabItem Tabs
        ImGuiTabBarFlags Flags
        ImGuiID ID
        ImGuiID SelectedTabId
        ImGuiID NextSelectedTabId
        ImGuiID VisibleTabId
        int CurrFrameVisible
        int PrevFrameVisible
        ImRect BarRect
        float CurrTabsContentsHeight
        float PrevTabsContentsHeight
        float WidthAllTabs
        float WidthAllTabsIdeal
        float ScrollingAnim
        float ScrollingTarget
        float ScrollingTargetDistToVisibility
        float ScrollingSpeed
        float ScrollingRectMinX
        float ScrollingRectMaxX
        ImGuiID ReorderRequestTabId
        ImS16 ReorderRequestOffset
        ImS8 BeginCount
        bool WantLayout
        bool VisibleTabWasSubmitted
        bool TabsAddedNew
        ImS16 TabsActiveCount
        ImS16 LastTabItemIdx
        float ItemSpacingY
        ImVec2 FramePadding
        ImVec2 BackupCursorPos
        ImGuiTextBuffer TabsNames

    ctypedef struct ImGuiTable:
        ImGuiID ID
        ImGuiTableFlags Flags
        void* RawData
        ImGuiTableTempData* TempData
        ImSpan_ImGuiTableColumn Columns
        ImSpan_ImGuiTableColumnIdx DisplayOrderToIndex
        ImSpan_ImGuiTableCellData RowCellData
        ImBitArrayPtr EnabledMaskByDisplayOrder
        ImBitArrayPtr EnabledMaskByIndex
        ImBitArrayPtr VisibleMaskByIndex
        ImGuiTableFlags SettingsLoadedFlags
        int SettingsOffset
        int LastFrameActive
        int ColumnsCount
        int CurrentRow
        int CurrentColumn
        ImS16 InstanceCurrent
        ImS16 InstanceInteracted
        float RowPosY1
        float RowPosY2
        float RowMinHeight
        float RowTextBaseline
        float RowIndentOffsetX
        ImGuiTableRowFlags RowFlags
        ImGuiTableRowFlags LastRowFlags
        int RowBgColorCounter
        ImU32 RowBgColor
        ImU32 BorderColorStrong
        ImU32 BorderColorLight
        float BorderX1
        float BorderX2
        float HostIndentX
        float MinColumnWidth
        float OuterPaddingX
        float CellPaddingX
        float CellPaddingY
        float CellSpacingX1
        float CellSpacingX2
        float InnerWidth
        float ColumnsGivenWidth
        float ColumnsAutoFitWidth
        float ColumnsStretchSumWeights
        float ResizedColumnNextWidth
        float ResizeLockMinContentsX2
        float RefScale
        ImRect OuterRect
        ImRect InnerRect
        ImRect WorkRect
        ImRect InnerClipRect
        ImRect BgClipRect
        ImRect Bg0ClipRectForDrawCmd
        ImRect Bg2ClipRectForDrawCmd
        ImRect HostClipRect
        ImRect HostBackupInnerClipRect
        ImGuiWindow* OuterWindow
        ImGuiWindow* InnerWindow
        ImGuiTextBuffer ColumnsNames
        ImDrawListSplitter* DrawSplitter
        ImGuiTableInstanceData InstanceDataFirst
        ImVector_ImGuiTableInstanceData InstanceDataExtra
        ImGuiTableColumnSortSpecs SortSpecsSingle
        ImVector_ImGuiTableColumnSortSpecs SortSpecsMulti
        ImGuiTableSortSpecs SortSpecs
        ImGuiTableColumnIdx SortSpecsCount
        ImGuiTableColumnIdx ColumnsEnabledCount
        ImGuiTableColumnIdx ColumnsEnabledFixedCount
        ImGuiTableColumnIdx DeclColumnsCount
        ImGuiTableColumnIdx HoveredColumnBody
        ImGuiTableColumnIdx HoveredColumnBorder
        ImGuiTableColumnIdx AutoFitSingleColumn
        ImGuiTableColumnIdx ResizedColumn
        ImGuiTableColumnIdx LastResizedColumn
        ImGuiTableColumnIdx HeldHeaderColumn
        ImGuiTableColumnIdx ReorderColumn
        ImGuiTableColumnIdx ReorderColumnDir
        ImGuiTableColumnIdx LeftMostEnabledColumn
        ImGuiTableColumnIdx RightMostEnabledColumn
        ImGuiTableColumnIdx LeftMostStretchedColumn
        ImGuiTableColumnIdx RightMostStretchedColumn
        ImGuiTableColumnIdx ContextPopupColumn
        ImGuiTableColumnIdx FreezeRowsRequest
        ImGuiTableColumnIdx FreezeRowsCount
        ImGuiTableColumnIdx FreezeColumnsRequest
        ImGuiTableColumnIdx FreezeColumnsCount
        ImGuiTableColumnIdx RowCellDataCurrent
        ImGuiTableDrawChannelIdx DummyDrawChannel
        ImGuiTableDrawChannelIdx Bg2DrawChannelCurrent
        ImGuiTableDrawChannelIdx Bg2DrawChannelUnfrozen
        bool IsLayoutLocked
        bool IsInsideRow
        bool IsInitializing
        bool IsSortSpecsDirty
        bool IsUsingHeaders
        bool IsContextPopupOpen
        bool IsSettingsRequestLoad
        bool IsSettingsDirty
        bool IsDefaultDisplayOrder
        bool IsResetAllRequest
        bool IsResetDisplayOrderRequest
        bool IsUnfrozenRows
        bool IsDefaultSizingPolicy
        bool HasScrollbarYCurr
        bool HasScrollbarYPrev
        bool MemoryCompacted
        bool HostSkipItems

    ctypedef struct ImGuiTableColumn:
        ImGuiTableColumnFlags Flags
        float WidthGiven
        float MinX
        float MaxX
        float WidthRequest
        float WidthAuto
        float StretchWeight
        float InitStretchWeightOrWidth
        ImRect ClipRect
        ImGuiID UserID
        float WorkMinX
        float WorkMaxX
        float ItemWidth
        float ContentMaxXFrozen
        float ContentMaxXUnfrozen
        float ContentMaxXHeadersUsed
        float ContentMaxXHeadersIdeal
        ImS16 NameOffset
        ImGuiTableColumnIdx DisplayOrder
        ImGuiTableColumnIdx IndexWithinEnabledSet
        ImGuiTableColumnIdx PrevEnabledColumn
        ImGuiTableColumnIdx NextEnabledColumn
        ImGuiTableColumnIdx SortOrder
        ImGuiTableDrawChannelIdx DrawChannelCurrent
        ImGuiTableDrawChannelIdx DrawChannelFrozen
        ImGuiTableDrawChannelIdx DrawChannelUnfrozen
        bool IsEnabled
        bool IsUserEnabled
        bool IsUserEnabledNextFrame
        bool IsVisibleX
        bool IsVisibleY
        bool IsRequestOutput
        bool IsSkipItems
        bool IsPreserveWidthAuto
        ImS8 NavLayerCurrent
        ImU8 AutoFitQueue
        ImU8 CannotSkipItemsQueue
        ImU8 SortDirection
        ImU8 SortDirectionsAvailCount
        ImU8 SortDirectionsAvailMask
        ImU8 SortDirectionsAvailList

    ctypedef struct ImGuiTableTempData:
        int TableIndex
        float LastTimeActive
        ImVec2 UserOuterSize
        ImDrawListSplitter DrawSplitter
        ImRect HostBackupWorkRect
        ImRect HostBackupParentWorkRect
        ImVec2 HostBackupPrevLineSize
        ImVec2 HostBackupCurrLineSize
        ImVec2 HostBackupCursorMaxPos
        ImVec1 HostBackupColumnsOffset
        float HostBackupItemWidth
        int HostBackupItemWidthStackSize

    ctypedef struct ImGuiViewportP:
        ImGuiViewport _ImGuiViewport
        int Idx
        int LastFrameActive
        int LastFrontMostStampCount
        ImGuiID LastNameHash
        ImVec2 LastPos
        float Alpha
        float LastAlpha
        short PlatformMonitor
        ImGuiWindow* Window
        int DrawListsLastFrame
        ImDrawList* DrawLists
        ImDrawData DrawDataP
        ImDrawDataBuilder DrawDataBuilder
        ImVec2 LastPlatformPos
        ImVec2 LastPlatformSize
        ImVec2 LastRendererSize
        ImVec2 WorkOffsetMin
        ImVec2 WorkOffsetMax
        ImVec2 BuildWorkOffsetMin
        ImVec2 BuildWorkOffsetMax

    ctypedef struct ImPool_ImGuiTabBar:
        ImVector_ImGuiTabBar Buf
        ImGuiStorage Map
        ImPoolIdx FreeIdx
        ImPoolIdx AliveCount

    ctypedef struct ImPool_ImGuiTable:
        ImVector_ImGuiTable Buf
        ImGuiStorage Map
        ImPoolIdx FreeIdx
        ImPoolIdx AliveCount

    ctypedef struct STB_TexteditState:
        int cursor
        int select_start
        int select_end
        unsigned char insert_mode
        int row_count_per_page
        unsigned char cursor_at_end_of_line
        unsigned char initialized
        unsigned char has_preferred_x
        unsigned char single_line
        unsigned char padding1, padding2, padding3
        float preferred_x
        StbUndoState undostate

    ctypedef struct ImGuiInputTextState:
        ImGuiContext* Ctx
        ImGuiID ID
        int CurLenW, CurLenA
        ImVector_ImWchar TextW
        ImVector_char TextA
        ImVector_char InitialTextA
        bool TextAIsValid
        int BufCapacityA
        float ScrollX
        STB_TexteditState Stb
        float CursorAnim
        bool CursorFollow
        bool SelectedAllMouseLock
        bool Edited
        ImGuiInputTextFlags Flags

    ctypedef struct ImGuiWindow:
        char* Name
        ImGuiID ID
        ImGuiWindowFlags Flags, FlagsPreviousFrame
        ImGuiWindowClass WindowClass
        ImGuiViewportP* Viewport
        ImGuiID ViewportId
        ImVec2 ViewportPos
        int ViewportAllowPlatformMonitorExtend
        ImVec2 Pos
        ImVec2 Size
        ImVec2 SizeFull
        ImVec2 ContentSize
        ImVec2 ContentSizeIdeal
        ImVec2 ContentSizeExplicit
        ImVec2 WindowPadding
        float WindowRounding
        float WindowBorderSize
        float DecoOuterSizeX1, DecoOuterSizeY1
        float DecoOuterSizeX2, DecoOuterSizeY2
        float DecoInnerSizeX1, DecoInnerSizeY1
        int NameBufLen
        ImGuiID MoveId
        ImGuiID TabId
        ImGuiID ChildId
        ImVec2 Scroll
        ImVec2 ScrollMax
        ImVec2 ScrollTarget
        ImVec2 ScrollTargetCenterRatio
        ImVec2 ScrollTargetEdgeSnapDist
        ImVec2 ScrollbarSizes
        bool ScrollbarX, ScrollbarY
        bool ViewportOwned
        bool Active
        bool WasActive
        bool WriteAccessed
        bool Collapsed
        bool WantCollapseToggle
        bool SkipItems
        bool Appearing
        bool Hidden
        bool IsFallbackWindow
        bool IsExplicitChild
        bool HasCloseButton
        signed char ResizeBorderHeld
        short BeginCount
        short BeginCountPreviousFrame
        short BeginOrderWithinParent
        short BeginOrderWithinContext
        short FocusOrder
        ImGuiID PopupId
        ImS8 AutoFitFramesX, AutoFitFramesY
        ImS8 AutoFitChildAxises
        bool AutoFitOnlyGrows
        ImGuiDir AutoPosLastDirection
        ImS8 HiddenFramesCanSkipItems
        ImS8 HiddenFramesCannotSkipItems
        ImS8 HiddenFramesForRenderOnly
        ImS8 DisableInputsFrames
        ImGuiCond SetWindowPosAllowFlags
        ImGuiCond SetWindowSizeAllowFlags
        ImGuiCond SetWindowCollapsedAllowFlags
        ImGuiCond SetWindowDockAllowFlags
        ImVec2 SetWindowPosVal
        ImVec2 SetWindowPosPivot
        ImVector_ImGuiID IDStack
        ImGuiWindowTempData DC
        ImRect OuterRectClipped
        ImRect InnerRect
        ImRect InnerClipRect
        ImRect WorkRect
        ImRect ParentWorkRect
        ImRect ClipRect
        ImRect ContentRegionRect
        ImVec2ih HitTestHoleSize
        ImVec2ih HitTestHoleOffset
        int LastFrameActive
        int LastFrameJustFocused
        float LastTimeActive
        float ItemWidthDefault
        ImGuiStorage StateStorage
        ImVector_ImGuiOldColumns ColumnsStorage
        float FontWindowScale
        float FontDpiScale
        int SettingsOffset
        ImDrawList* DrawList
        ImDrawList DrawListInst
        ImGuiWindow* ParentWindow
        ImGuiWindow* ParentWindowInBeginStack
        ImGuiWindow* RootWindow
        ImGuiWindow* RootWindowPopupTree
        ImGuiWindow* RootWindowDockTree
        ImGuiWindow* RootWindowForTitleBarHighlight
        ImGuiWindow* RootWindowForNav
        ImGuiWindow* NavLastChildNavWindow
        ImGuiID NavLastIds
        ImRect NavRectRel
        ImGuiID NavRootFocusScopeId
        int MemoryDrawListIdxCapacity
        int MemoryDrawListVtxCapacity
        bool MemoryCompacted
        bool DockIsActive
        bool DockNodeIsVisible
        bool DockTabIsVisible
        bool DockTabWantClose
        short DockOrder
        ImGuiWindowDockStyle DockStyle
        ImGuiDockNode* DockNode
        ImGuiDockNode* DockNodeAsHost
        ImGuiID DockId
        ImGuiItemStatusFlags DockTabItemStatusFlags
        ImRect DockTabItemRect

    ctypedef struct ImGuiWindowStackData:
        ImGuiWindow* Window
        ImGuiLastItemData ParentLastItemDataBackup
        ImGuiStackSizes StackSizesOnBegin

    ctypedef struct ImGuiContext:
        bool Initialized
        bool FontAtlasOwnedByContext
        ImGuiIO IO
        ImGuiPlatformIO PlatformIO
        ImVector_ImGuiInputEvent InputEventsQueue
        ImVector_ImGuiInputEvent InputEventsTrail
        ImGuiStyle Style
        ImGuiConfigFlags ConfigFlagsCurrFrame
        ImGuiConfigFlags ConfigFlagsLastFrame
        ImFont* Font
        float FontSize
        float FontBaseSize
        ImDrawListSharedData DrawListSharedData
        double Time
        int FrameCount
        int FrameCountEnded
        int FrameCountPlatformEnded
        int FrameCountRendered
        bool WithinFrameScope
        bool WithinFrameScopeWithImplicitWindow
        bool WithinEndChild
        bool GcCompactAll
        bool TestEngineHookItems
        void* TestEngine
        ImVector_ImGuiWindowPtr Windows
        ImVector_ImGuiWindowPtr WindowsFocusOrder
        ImVector_ImGuiWindowPtr WindowsTempSortBuffer
        ImVector_ImGuiWindowStackData CurrentWindowStack
        ImGuiStorage WindowsById
        int WindowsActiveCount
        ImVec2 WindowsHoverPadding
        ImGuiWindow* CurrentWindow
        ImGuiWindow* HoveredWindow
        ImGuiWindow* HoveredWindowUnderMovingWindow
        ImGuiWindow* MovingWindow
        ImGuiWindow* WheelingWindow
        ImVec2 WheelingWindowRefMousePos
        int WheelingWindowStartFrame
        float WheelingWindowReleaseTimer
        ImVec2 WheelingWindowWheelRemainder
        ImVec2 WheelingAxisAvg
        ImGuiID DebugHookIdInfo
        ImGuiID HoveredId
        ImGuiID HoveredIdPreviousFrame
        bool HoveredIdAllowOverlap
        bool HoveredIdDisabled
        float HoveredIdTimer
        float HoveredIdNotActiveTimer
        ImGuiID ActiveId
        ImGuiID ActiveIdIsAlive
        float ActiveIdTimer
        bool ActiveIdIsJustActivated
        bool ActiveIdAllowOverlap
        bool ActiveIdNoClearOnFocusLoss
        bool ActiveIdHasBeenPressedBefore
        bool ActiveIdHasBeenEditedBefore
        bool ActiveIdHasBeenEditedThisFrame
        ImVec2 ActiveIdClickOffset
        ImGuiWindow* ActiveIdWindow
        ImGuiInputSource ActiveIdSource
        int ActiveIdMouseButton
        ImGuiID ActiveIdPreviousFrame
        bool ActiveIdPreviousFrameIsAlive
        bool ActiveIdPreviousFrameHasBeenEditedBefore
        ImGuiWindow* ActiveIdPreviousFrameWindow
        ImGuiID LastActiveId
        float LastActiveIdTimer
        ImGuiKeyOwnerData KeysOwnerData
        ImGuiKeyRoutingTable KeysRoutingTable
        ImU32 ActiveIdUsingNavDirMask
        bool ActiveIdUsingAllKeyboardKeys
        ImU32 ActiveIdUsingNavInputMask
        ImGuiID CurrentFocusScopeId
        ImGuiItemFlags CurrentItemFlags
        ImGuiID DebugLocateId
        ImGuiNextItemData NextItemData
        ImGuiLastItemData LastItemData
        ImGuiNextWindowData NextWindowData
        ImVector_ImGuiColorMod ColorStack
        ImVector_ImGuiStyleMod StyleVarStack
        ImVector_ImFontPtr FontStack
        ImVector_ImGuiID FocusScopeStack
        ImVector_ImGuiItemFlags ItemFlagsStack
        ImVector_ImGuiGroupData GroupStack
        ImVector_ImGuiPopupData OpenPopupStack
        ImVector_ImGuiPopupData BeginPopupStack
        int BeginMenuCount
        ImVector_ImGuiViewportPPtr Viewports
        float CurrentDpiScale
        ImGuiViewportP* CurrentViewport
        ImGuiViewportP* MouseViewport
        ImGuiViewportP* MouseLastHoveredViewport
        ImGuiID PlatformLastFocusedViewportId
        ImGuiPlatformMonitor FallbackMonitor
        int ViewportFrontMostStampCount
        ImGuiWindow* NavWindow
        ImGuiID NavId
        ImGuiID NavFocusScopeId
        ImGuiID NavActivateId
        ImGuiID NavActivateDownId
        ImGuiID NavActivatePressedId
        ImGuiID NavActivateInputId
        ImGuiActivateFlags NavActivateFlags
        ImGuiID NavJustMovedToId
        ImGuiID NavJustMovedToFocusScopeId
        ImGuiKeyChord NavJustMovedToKeyMods
        ImGuiID NavNextActivateId
        ImGuiActivateFlags NavNextActivateFlags
        ImGuiInputSource NavInputSource
        ImGuiNavLayer NavLayer
        bool NavIdIsAlive
        bool NavMousePosDirty
        bool NavDisableHighlight
        bool NavDisableMouseHover
        bool NavAnyRequest
        bool NavInitRequest
        bool NavInitRequestFromMove
        ImGuiID NavInitResultId
        ImRect NavInitResultRectRel
        bool NavMoveSubmitted
        bool NavMoveScoringItems
        bool NavMoveForwardToNextFrame
        ImGuiNavMoveFlags NavMoveFlags
        ImGuiScrollFlags NavMoveScrollFlags
        ImGuiKeyChord NavMoveKeyMods
        ImGuiDir NavMoveDir
        ImGuiDir NavMoveDirForDebug
        ImGuiDir NavMoveClipDir
        ImRect NavScoringRect
        ImRect NavScoringNoClipRect
        int NavScoringDebugCount
        int NavTabbingDir
        int NavTabbingCounter
        ImGuiNavItemData NavMoveResultLocal
        ImGuiNavItemData NavMoveResultLocalVisible
        ImGuiNavItemData NavMoveResultOther
        ImGuiNavItemData NavTabbingResultFirst
        ImGuiKeyChord ConfigNavWindowingKeyNext
        ImGuiKeyChord ConfigNavWindowingKeyPrev
        ImGuiWindow* NavWindowingTarget
        ImGuiWindow* NavWindowingTargetAnim
        ImGuiWindow* NavWindowingListWindow
        float NavWindowingTimer
        float NavWindowingHighlightAlpha
        bool NavWindowingToggleLayer
        ImVec2 NavWindowingAccumDeltaPos
        ImVec2 NavWindowingAccumDeltaSize
        float DimBgRatio
        ImGuiMouseCursor MouseCursor
        bool DragDropActive
        bool DragDropWithinSource
        bool DragDropWithinTarget
        ImGuiDragDropFlags DragDropSourceFlags
        int DragDropSourceFrameCount
        int DragDropMouseButton
        ImGuiPayload DragDropPayload
        ImRect DragDropTargetRect
        ImGuiID DragDropTargetId
        ImGuiDragDropFlags DragDropAcceptFlags
        float DragDropAcceptIdCurrRectSurface
        ImGuiID DragDropAcceptIdCurr
        ImGuiID DragDropAcceptIdPrev
        int DragDropAcceptFrameCount
        ImGuiID DragDropHoldJustPressedId
        ImVector_unsigned_char DragDropPayloadBufHeap
        unsigned char DragDropPayloadBufLocal
        int ClipperTempDataStacked
        ImVector_ImGuiListClipperData ClipperTempData
        ImGuiTable* CurrentTable
        int TablesTempDataStacked
        ImVector_ImGuiTableTempData TablesTempData
        ImPool_ImGuiTable Tables
        ImVector_float TablesLastTimeActive
        ImVector_ImDrawChannel DrawChannelsTempMergeBuffer
        ImGuiTabBar* CurrentTabBar
        ImPool_ImGuiTabBar TabBars
        ImVector_ImGuiPtrOrIndex CurrentTabBarStack
        ImVector_ImGuiShrinkWidthItem ShrinkWidthBuffer
        ImGuiID HoverDelayId
        ImGuiID HoverDelayIdPreviousFrame
        float HoverDelayTimer
        float HoverDelayClearTimer
        ImVec2 MouseLastValidPos
        ImGuiInputTextState InputTextState
        ImFont InputTextPasswordFont
        ImGuiID TempInputId
        ImGuiColorEditFlags ColorEditOptions
        ImGuiID ColorEditCurrentID
        ImGuiID ColorEditSavedID
        float ColorEditSavedHue
        float ColorEditSavedSat
        ImU32 ColorEditSavedColor
        ImVec4 ColorPickerRef
        ImGuiComboPreviewData ComboPreviewData
        float SliderGrabClickOffset
        float SliderCurrentAccum
        bool SliderCurrentAccumDirty
        bool DragCurrentAccumDirty
        float DragCurrentAccum
        float DragSpeedDefaultRatio
        float ScrollbarClickDeltaToGrabCenter
        float DisabledAlphaBackup
        short DisabledStackSize
        short TooltipOverrideCount
        ImVector_char ClipboardHandlerData
        ImVector_ImGuiID MenusIdSubmittedThisFrame
        ImGuiPlatformImeData PlatformImeData
        ImGuiPlatformImeData PlatformImeDataPrev
        ImGuiID PlatformImeViewport
        char PlatformLocaleDecimalPoint
        ImGuiDockContext DockContext
        bool SettingsLoaded
        float SettingsDirtyTimer
        ImGuiTextBuffer SettingsIniData
        ImVector_ImGuiSettingsHandler SettingsHandlers
        ImChunkStream_ImGuiWindowSettings SettingsWindows
        ImChunkStream_ImGuiTableSettings SettingsTables
        ImVector_ImGuiContextHook Hooks
        ImGuiID HookIdNext
        const char* LocalizationTable
        bool LogEnabled
        ImGuiLogType LogType
        ImFileHandle LogFile
        ImGuiTextBuffer LogBuffer
        const char* LogNextPrefix
        const char* LogNextSuffix
        float LogLinePosY
        bool LogLineFirstItem
        int LogDepthRef
        int LogDepthToExpand
        int LogDepthToExpandDefault
        ImGuiDebugLogFlags DebugLogFlags
        ImGuiTextBuffer DebugLogBuf
        ImGuiTextIndex DebugLogIndex
        ImU8 DebugLocateFrames
        bool DebugItemPickerActive
        ImU8 DebugItemPickerMouseButton
        ImGuiID DebugItemPickerBreakId
        ImGuiMetricsConfig DebugMetricsConfig
        ImGuiStackTool DebugStackTool
        ImGuiDockNode* DebugHoveredDockNode
        float FramerateSecPerFrame
        int FramerateSecPerFrameIdx
        int FramerateSecPerFrameCount
        float FramerateSecPerFrameAccum
        int WantCaptureMouseNextFrame
        int WantCaptureKeyboardNextFrame
        int WantTextInputNextFrame
        ImVector_char TempBuffer

    ImColor* ImColor_ImColor_Float(float r, float g, float b, float a)
    ImColor* ImColor_ImColor_Int(int r, int g, int b, int a)
    ImColor* ImColor_ImColor_Nil()
    ImColor* ImColor_ImColor_U32(ImU32 rgba)
    ImColor* ImColor_ImColor_Vec4(const ImVec4 col)
    ImDrawCmd* ImDrawCmd_ImDrawCmd()
    ImDrawData* ImDrawData_ImDrawData()
    ImDrawData* igGetDrawData()
    ImDrawFlags igCalcRoundingFlagsForRectInRect(const ImRect r_in, const ImRect r_outer, float threshold)
    ImDrawList* ImDrawList_CloneOutput(ImDrawList* self)
    ImDrawList* ImDrawList_ImDrawList(ImDrawListSharedData* shared_data)
    ImDrawList* igGetBackgroundDrawList_Nil()
    ImDrawList* igGetBackgroundDrawList_ViewportPtr(ImGuiViewport* viewport)
    ImDrawList* igGetForegroundDrawList_Nil()
    ImDrawList* igGetForegroundDrawList_ViewportPtr(ImGuiViewport* viewport)
    ImDrawList* igGetForegroundDrawList_WindowPtr(ImGuiWindow* window)
    ImDrawList* igGetWindowDrawList()
    ImDrawListSharedData* ImDrawListSharedData_ImDrawListSharedData()
    ImDrawListSharedData* igGetDrawListSharedData()
    ImDrawListSplitter* ImDrawListSplitter_ImDrawListSplitter()
    ImFileHandle igImFileOpen(const char* filename, const char* mode)
    ImFont* ImFontAtlas_AddFont(ImFontAtlas* self, const ImFontConfig* font_cfg)
    ImFont* ImFontAtlas_AddFontDefault(ImFontAtlas* self, const ImFontConfig* font_cfg)
    ImFont* ImFontAtlas_AddFontFromFileTTF(ImFontAtlas* self, const char* filename, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges)
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas* self, const char* compressed_font_data_base85, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges)
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas* self, const void* compressed_font_data, int compressed_font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges)
    ImFont* ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas* self, void* font_data, int font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges)
    ImFont* ImFont_ImFont()
    ImFont* igGetDefaultFont()
    ImFont* igGetFont()
    ImFontAtlas* ImFontAtlas_ImFontAtlas()
    ImFontAtlasCustomRect* ImFontAtlasCustomRect_ImFontAtlasCustomRect()
    ImFontAtlasCustomRect* ImFontAtlas_GetCustomRectByIndex(ImFontAtlas* self, int index)
    ImFontConfig* ImFontConfig_ImFontConfig()
    ImFontGlyphRangesBuilder* ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder()
    ImGuiComboPreviewData* ImGuiComboPreviewData_ImGuiComboPreviewData()
    ImGuiContext* ImGuiContext_ImGuiContext(ImFontAtlas* shared_font_atlas)
    ImGuiContext* igCreateContext(ImFontAtlas* shared_font_atlas)
    ImGuiContext* igGetCurrentContext()
    ImGuiContextHook* ImGuiContextHook_ImGuiContextHook()
    ImGuiDir igImGetDirQuadrantFromDelta(float dx, float dy)
    ImGuiDockContext* ImGuiDockContext_ImGuiDockContext()
    ImGuiDockNode* ImGuiDockNode_ImGuiDockNode(ImGuiID id_)
    ImGuiDockNode* igDockBuilderGetCentralNode(ImGuiID node_id)
    ImGuiDockNode* igDockBuilderGetNode(ImGuiID node_id)
    ImGuiDockNode* igDockContextFindNodeByID(ImGuiContext* ctx, ImGuiID id_)
    ImGuiDockNode* igDockNodeGetRootNode(ImGuiDockNode* node)
    ImGuiDockNode* igGetWindowDockNode()
    ImGuiID ImGuiWindow_GetIDFromRectangle(ImGuiWindow* self, const ImRect r_abs)
    ImGuiID ImGuiWindow_GetID_Int(ImGuiWindow* self, int n)
    ImGuiID ImGuiWindow_GetID_Ptr(ImGuiWindow* self, const void* ptr)
    ImGuiID ImGuiWindow_GetID_Str(ImGuiWindow* self, const char* str_, const char* str_end)
    ImGuiID igAddContextHook(ImGuiContext* context, const ImGuiContextHook* hook)
    ImGuiID igDockBuilderAddNode(ImGuiID node_id, ImGuiDockNodeFlags flags)
    ImGuiID igDockBuilderSplitNode(ImGuiID node_id, ImGuiDir split_dir, float size_ratio_for_node_at_dir, ImGuiID* out_id_at_dir, ImGuiID* out_id_at_opposite_dir)
    ImGuiID igDockContextGenNodeID(ImGuiContext* ctx)
    ImGuiID igDockNodeGetWindowMenuButtonId(const ImGuiDockNode* node)
    ImGuiID igDockSpace(ImGuiID id_, const ImVec2 size, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class)
    ImGuiID igDockSpaceOverViewport(const ImGuiViewport* viewport, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class)
    ImGuiID igGetActiveID()
    ImGuiID igGetColumnsID(const char* str_id, int count)
    ImGuiID igGetCurrentFocusScope()
    ImGuiID igGetFocusID()
    ImGuiID igGetHoveredID()
    ImGuiID igGetIDWithSeed_Int(int n, ImGuiID seed)
    ImGuiID igGetIDWithSeed_Str(const char* str_id_begin, const char* str_id_end, ImGuiID seed)
    ImGuiID igGetID_Ptr(const void* ptr_id)
    ImGuiID igGetID_Str(const char* str_id)
    ImGuiID igGetID_StrStr(const char* str_id_begin, const char* str_id_end)
    ImGuiID igGetItemID()
    ImGuiID igGetKeyOwner(ImGuiKey key)
    ImGuiID igGetWindowDockID()
    ImGuiID igGetWindowResizeBorderID(ImGuiWindow* window, ImGuiDir dir_)
    ImGuiID igGetWindowResizeCornerID(ImGuiWindow* window, int n)
    ImGuiID igGetWindowScrollbarID(ImGuiWindow* window, ImGuiAxis axis)
    ImGuiID igImHashData(const void* data, size_t data_size, ImGuiID seed)
    ImGuiID igImHashStr(const char* data, size_t data_size, ImGuiID seed)
    ImGuiID igTableGetColumnResizeID(ImGuiTable* table, int column_n, int instance_no)
    ImGuiID igTableGetInstanceID(ImGuiTable* table, int instance_no)
    ImGuiIO* ImGuiIO_ImGuiIO()
    ImGuiIO* igGetIO()
    ImGuiInputEvent* ImGuiInputEvent_ImGuiInputEvent()
    ImGuiInputTextCallbackData* ImGuiInputTextCallbackData_ImGuiInputTextCallbackData()
    ImGuiInputTextState* ImGuiInputTextState_ImGuiInputTextState(ImGuiContext* ctx)
    ImGuiInputTextState* igGetInputTextState(ImGuiID id_)
    ImGuiItemFlags igGetItemFlags()
    ImGuiItemStatusFlags igGetItemStatusFlags()
    ImGuiKey igConvertSingleModFlagToKey(ImGuiKey key)
    ImGuiKey igGetKeyIndex(ImGuiKey key)
    ImGuiKey igMouseButtonToKey(ImGuiMouseButton button)
    ImGuiKeyChord igConvertShortcutMod(ImGuiKeyChord key_chord)
    ImGuiKeyData* igGetKeyData(ImGuiKey key)
    ImGuiKeyOwnerData* ImGuiKeyOwnerData_ImGuiKeyOwnerData()
    ImGuiKeyOwnerData* igGetKeyOwnerData(ImGuiKey key)
    ImGuiKeyRoutingData* ImGuiKeyRoutingData_ImGuiKeyRoutingData()
    ImGuiKeyRoutingData* igGetShortcutRoutingData(ImGuiKeyChord key_chord)
    ImGuiKeyRoutingTable* ImGuiKeyRoutingTable_ImGuiKeyRoutingTable()
    ImGuiLastItemData* ImGuiLastItemData_ImGuiLastItemData()
    ImGuiListClipper* ImGuiListClipper_ImGuiListClipper()
    ImGuiListClipperData* ImGuiListClipperData_ImGuiListClipperData()
    ImGuiListClipperRange ImGuiListClipperRange_FromIndices(int min_, int max_)
    ImGuiListClipperRange ImGuiListClipperRange_FromPositions(float y1, float y2, int off_min, int off_max)
    ImGuiMenuColumns* ImGuiMenuColumns_ImGuiMenuColumns()
    ImGuiMouseCursor igGetMouseCursor()
    ImGuiNavItemData* ImGuiNavItemData_ImGuiNavItemData()
    ImGuiNextItemData* ImGuiNextItemData_ImGuiNextItemData()
    ImGuiNextWindowData* ImGuiNextWindowData_ImGuiNextWindowData()
    ImGuiOldColumnData* ImGuiOldColumnData_ImGuiOldColumnData()
    ImGuiOldColumns* ImGuiOldColumns_ImGuiOldColumns()
    ImGuiOldColumns* igFindOrCreateColumns(ImGuiWindow* window, ImGuiID id_)
    ImGuiOnceUponAFrame* ImGuiOnceUponAFrame_ImGuiOnceUponAFrame()
    ImGuiPayload* ImGuiPayload_ImGuiPayload()
    ImGuiPlatformIO* ImGuiPlatformIO_ImGuiPlatformIO()
    ImGuiPlatformIO* igGetPlatformIO()
    ImGuiPlatformImeData* ImGuiPlatformImeData_ImGuiPlatformImeData()
    ImGuiPlatformMonitor* ImGuiPlatformMonitor_ImGuiPlatformMonitor()
    ImGuiPopupData* ImGuiPopupData_ImGuiPopupData()
    ImGuiPtrOrIndex* ImGuiPtrOrIndex_ImGuiPtrOrIndex_Int(int index)
    ImGuiPtrOrIndex* ImGuiPtrOrIndex_ImGuiPtrOrIndex_Ptr(void* ptr)
    ImGuiSettingsHandler* ImGuiSettingsHandler_ImGuiSettingsHandler()
    ImGuiSettingsHandler* igFindSettingsHandler(const char* type_name)
    ImGuiSortDirection igTableGetColumnNextSortDirection(ImGuiTableColumn* column)
    ImGuiStackLevelInfo* ImGuiStackLevelInfo_ImGuiStackLevelInfo()
    ImGuiStackSizes* ImGuiStackSizes_ImGuiStackSizes()
    ImGuiStackTool* ImGuiStackTool_ImGuiStackTool()
    ImGuiStorage* igGetStateStorage()
    ImGuiStoragePair* ImGuiStoragePair_ImGuiStoragePair_Float(ImGuiID _key, float _val_f)
    ImGuiStoragePair* ImGuiStoragePair_ImGuiStoragePair_Int(ImGuiID _key, int _val_i)
    ImGuiStoragePair* ImGuiStoragePair_ImGuiStoragePair_Ptr(ImGuiID _key, void* _val_p)
    ImGuiStyle* ImGuiStyle_ImGuiStyle()
    ImGuiStyle* igGetStyle()
    ImGuiStyleMod* ImGuiStyleMod_ImGuiStyleMod_Float(ImGuiStyleVar idx, float v)
    ImGuiStyleMod* ImGuiStyleMod_ImGuiStyleMod_Int(ImGuiStyleVar idx, int v)
    ImGuiStyleMod* ImGuiStyleMod_ImGuiStyleMod_Vec2(ImGuiStyleVar idx, ImVec2 v)
    ImGuiTabBar* ImGuiTabBar_ImGuiTabBar()
    ImGuiTabBar* igGetCurrentTabBar()
    ImGuiTabItem* ImGuiTabItem_ImGuiTabItem()
    ImGuiTabItem* igTabBarFindMostRecentlySelectedTabForActiveWindow(ImGuiTabBar* tab_bar)
    ImGuiTabItem* igTabBarFindTabByID(ImGuiTabBar* tab_bar, ImGuiID tab_id)
    ImGuiTabItem* igTabBarFindTabByOrder(ImGuiTabBar* tab_bar, int order)
    ImGuiTabItem* igTabBarGetCurrentTab(ImGuiTabBar* tab_bar)
    ImGuiTable* ImGuiTable_ImGuiTable()
    ImGuiTable* igGetCurrentTable()
    ImGuiTable* igTableFindByID(ImGuiID id_)
    ImGuiTableColumn* ImGuiTableColumn_ImGuiTableColumn()
    ImGuiTableColumnFlags igTableGetColumnFlags(int column_n)
    ImGuiTableColumnSettings* ImGuiTableColumnSettings_ImGuiTableColumnSettings()
    ImGuiTableColumnSettings* ImGuiTableSettings_GetColumnSettings(ImGuiTableSettings* self)
    ImGuiTableColumnSortSpecs* ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs()
    ImGuiTableInstanceData* ImGuiTableInstanceData_ImGuiTableInstanceData()
    ImGuiTableInstanceData* igTableGetInstanceData(ImGuiTable* table, int instance_no)
    ImGuiTableSettings* ImGuiTableSettings_ImGuiTableSettings()
    ImGuiTableSettings* igTableGetBoundSettings(ImGuiTable* table)
    ImGuiTableSettings* igTableSettingsCreate(ImGuiID id_, int columns_count)
    ImGuiTableSettings* igTableSettingsFindByID(ImGuiID id_)
    ImGuiTableSortSpecs* ImGuiTableSortSpecs_ImGuiTableSortSpecs()
    ImGuiTableSortSpecs* igTableGetSortSpecs()
    ImGuiTableTempData* ImGuiTableTempData_ImGuiTableTempData()
    ImGuiTextBuffer* ImGuiTextBuffer_ImGuiTextBuffer()
    ImGuiTextFilter* ImGuiTextFilter_ImGuiTextFilter(const char* default_filter)
    ImGuiTextRange* ImGuiTextRange_ImGuiTextRange_Nil()
    ImGuiTextRange* ImGuiTextRange_ImGuiTextRange_Str(const char* _b, const char* _e)
    ImGuiViewport* ImGuiViewport_ImGuiViewport()
    ImGuiViewport* igFindViewportByID(ImGuiID id_)
    ImGuiViewport* igFindViewportByPlatformHandle(void* platform_handle)
    ImGuiViewport* igGetMainViewport()
    ImGuiViewport* igGetWindowViewport()
    ImGuiViewportP* ImGuiViewportP_ImGuiViewportP()
    ImGuiViewportP* igFindHoveredViewportFromPlatformWindowStack(const ImVec2 mouse_platform_pos)
    ImGuiWindow* ImGuiWindow_ImGuiWindow(ImGuiContext* context, const char* name)
    ImGuiWindow* igFindBottomMostVisibleWindowWithinBeginStack(ImGuiWindow* window)
    ImGuiWindow* igFindWindowByID(ImGuiID id_)
    ImGuiWindow* igFindWindowByName(const char* name)
    ImGuiWindow* igGetCurrentWindow()
    ImGuiWindow* igGetCurrentWindowRead()
    ImGuiWindow* igGetTopMostAndVisiblePopupModal()
    ImGuiWindow* igGetTopMostPopupModal()
    ImGuiWindowClass* ImGuiWindowClass_ImGuiWindowClass()
    ImGuiWindowSettings* ImGuiWindowSettings_ImGuiWindowSettings()
    ImGuiWindowSettings* igCreateNewWindowSettings(const char* name)
    ImGuiWindowSettings* igFindWindowSettingsByID(ImGuiID id_)
    ImGuiWindowSettings* igFindWindowSettingsByWindow(ImGuiWindow* window)
    ImRect* ImRect_ImRect_Float(float x1, float y1, float x2, float y2)
    ImRect* ImRect_ImRect_Nil()
    ImRect* ImRect_ImRect_Vec2(const ImVec2 min_, const ImVec2 max_)
    ImRect* ImRect_ImRect_Vec4(const ImVec4 v)
    ImTextureID ImDrawCmd_GetTexID(ImDrawCmd* self)
    ImU32 igColorConvertFloat4ToU32(const ImVec4 in_)
    ImU32 igGetColorU32_Col(ImGuiCol idx, float alpha_mul)
    ImU32 igGetColorU32_U32(ImU32 col)
    ImU32 igGetColorU32_Vec4(const ImVec4 col)
    ImU32 igImAlphaBlendColors(ImU32 col_a, ImU32 col_b)
    ImU64 igImFileGetSize(ImFileHandle file)
    ImU64 igImFileRead(void* data, ImU64 size, ImU64 count, ImFileHandle file)
    ImU64 igImFileWrite(const void* data, ImU64 size, ImU64 count, ImFileHandle file)
    ImVec1* ImVec1_ImVec1_Float(float _x)
    ImVec1* ImVec1_ImVec1_Nil()
    ImVec2* ImVec2_ImVec2_Float(float _x, float _y)
    ImVec2* ImVec2_ImVec2_Nil()
    ImVec2ih* ImVec2ih_ImVec2ih_Nil()
    ImVec2ih* ImVec2ih_ImVec2ih_Vec2(const ImVec2 rhs)
    ImVec2ih* ImVec2ih_ImVec2ih_short(short _x, short _y)
    ImVec4* ImVec4_ImVec4_Float(float _x, float _y, float _z, float _w)
    ImVec4* ImVec4_ImVec4_Nil()
    ImVector_ImWchar* ImVector_ImWchar_create()
    bool ImBitVector_TestBit(ImBitVector* self, int n)
    bool ImFontAtlasCustomRect_IsPacked(ImFontAtlasCustomRect* self)
    bool ImFontAtlas_Build(ImFontAtlas* self)
    bool ImFontAtlas_GetMouseCursorTexData(ImFontAtlas* self, ImGuiMouseCursor cursor, ImVec2* out_offset, ImVec2* out_size, ImVec2 out_uv_border, ImVec2 out_uv_fill)
    bool ImFontAtlas_IsBuilt(ImFontAtlas* self)
    bool ImFontGlyphRangesBuilder_GetBit(ImFontGlyphRangesBuilder* self, size_t n)
    bool ImFont_IsGlyphRangeUnused(ImFont* self, unsigned int c_begin, unsigned int c_last)
    bool ImFont_IsLoaded(ImFont* self)
    bool ImGuiDockNode_IsCentralNode(ImGuiDockNode* self)
    bool ImGuiDockNode_IsDockSpace(ImGuiDockNode* self)
    bool ImGuiDockNode_IsEmpty(ImGuiDockNode* self)
    bool ImGuiDockNode_IsFloatingNode(ImGuiDockNode* self)
    bool ImGuiDockNode_IsHiddenTabBar(ImGuiDockNode* self)
    bool ImGuiDockNode_IsLeafNode(ImGuiDockNode* self)
    bool ImGuiDockNode_IsNoTabBar(ImGuiDockNode* self)
    bool ImGuiDockNode_IsRootNode(ImGuiDockNode* self)
    bool ImGuiDockNode_IsSplitNode(ImGuiDockNode* self)
    bool ImGuiInputTextCallbackData_HasSelection(ImGuiInputTextCallbackData* self)
    bool ImGuiInputTextState_HasSelection(ImGuiInputTextState* self)
    bool ImGuiListClipper_Step(ImGuiListClipper* self)
    bool ImGuiPayload_IsDataType(ImGuiPayload* self, const char* type_)
    bool ImGuiPayload_IsDelivery(ImGuiPayload* self)
    bool ImGuiPayload_IsPreview(ImGuiPayload* self)
    bool ImGuiStorage_GetBool(ImGuiStorage* self, ImGuiID key, bool default_val)
    bool ImGuiTextBuffer_empty(ImGuiTextBuffer* self)
    bool ImGuiTextFilter_Draw(ImGuiTextFilter* self, const char* label, float width)
    bool ImGuiTextFilter_IsActive(ImGuiTextFilter* self)
    bool ImGuiTextFilter_PassFilter(ImGuiTextFilter* self, const char* text, const char* text_end)
    bool ImGuiTextRange_empty(ImGuiTextRange* self)
    bool ImRect_Contains_Rect(ImRect* self, const ImRect r)
    bool ImRect_Contains_Vec2(ImRect* self, const ImVec2 p)
    bool ImRect_IsInverted(ImRect* self)
    bool ImRect_Overlaps(ImRect* self, const ImRect r)
    bool igArrowButton(const char* str_id, ImGuiDir dir_)
    bool igArrowButtonEx(const char* str_id, ImGuiDir dir_, ImVec2 size_arg, ImGuiButtonFlags flags)
    bool igBegin(const char* name, bool* p_open, ImGuiWindowFlags flags)
    bool igBeginChildEx(const char* name, ImGuiID id_, const ImVec2 size_arg, bool border, ImGuiWindowFlags flags)
    bool igBeginChildFrame(ImGuiID id_, const ImVec2 size, ImGuiWindowFlags flags)
    bool igBeginChild_ID(ImGuiID id_, const ImVec2 size, bool border, ImGuiWindowFlags flags)
    bool igBeginChild_Str(const char* str_id, const ImVec2 size, bool border, ImGuiWindowFlags flags)
    bool igBeginCombo(const char* label, const char* preview_value, ImGuiComboFlags flags)
    bool igBeginComboPopup(ImGuiID popup_id, const ImRect bb, ImGuiComboFlags flags)
    bool igBeginComboPreview()
    bool igBeginDragDropSource(ImGuiDragDropFlags flags)
    bool igBeginDragDropTarget()
    bool igBeginDragDropTargetCustom(const ImRect bb, ImGuiID id_)
    bool igBeginListBox(const char* label, const ImVec2 size)
    bool igBeginMainMenuBar()
    bool igBeginMenu(const char* label, bool enabled)
    bool igBeginMenuBar()
    bool igBeginMenuEx(const char* label, const char* icon, bool enabled)
    bool igBeginPopup(const char* str_id, ImGuiWindowFlags flags)
    bool igBeginPopupContextItem(const char* str_id, ImGuiPopupFlags popup_flags)
    bool igBeginPopupContextVoid(const char* str_id, ImGuiPopupFlags popup_flags)
    bool igBeginPopupContextWindow(const char* str_id, ImGuiPopupFlags popup_flags)
    bool igBeginPopupEx(ImGuiID id_, ImGuiWindowFlags extra_flags)
    bool igBeginPopupModal(const char* name, bool* p_open, ImGuiWindowFlags flags)
    bool igBeginTabBar(const char* str_id, ImGuiTabBarFlags flags)
    bool igBeginTabBarEx(ImGuiTabBar* tab_bar, const ImRect bb, ImGuiTabBarFlags flags, ImGuiDockNode* dock_node)
    bool igBeginTabItem(const char* label, bool* p_open, ImGuiTabItemFlags flags)
    bool igBeginTable(const char* str_id, int column, ImGuiTableFlags flags, const ImVec2 outer_size, float inner_width)
    bool igBeginTableEx(const char* name, ImGuiID id_, int columns_count, ImGuiTableFlags flags, const ImVec2 outer_size, float inner_width)
    bool igBeginViewportSideBar(const char* name, ImGuiViewport* viewport, ImGuiDir dir_, float size, ImGuiWindowFlags window_flags)
    bool igButton(const char* label, const ImVec2 size)
    bool igButtonBehavior(const ImRect bb, ImGuiID id_, bool* out_hovered, bool* out_held, ImGuiButtonFlags flags)
    bool igButtonEx(const char* label, const ImVec2 size_arg, ImGuiButtonFlags flags)
    bool igCheckbox(const char* label, bool* v)
    bool igCheckboxFlags_IntPtr(const char* label, int* flags, int flags_value)
    bool igCheckboxFlags_S64Ptr(const char* label, ImS64* flags, ImS64 flags_value)
    bool igCheckboxFlags_U64Ptr(const char* label, ImU64* flags, ImU64 flags_value)
    bool igCheckboxFlags_UintPtr(const char* label, unsigned int* flags, unsigned int flags_value)
    bool igCloseButton(ImGuiID id_, const ImVec2 pos)
    bool igCollapseButton(ImGuiID id_, const ImVec2 pos, ImGuiDockNode* dock_node)
    bool igCollapsingHeader_BoolPtr(const char* label, bool* p_visible, ImGuiTreeNodeFlags flags)
    bool igCollapsingHeader_TreeNodeFlags(const char* label, ImGuiTreeNodeFlags flags)
    bool igColorButton(const char* desc_id, const ImVec4 col, ImGuiColorEditFlags flags, const ImVec2 size)
    bool igColorEdit3(const char* label, float col, ImGuiColorEditFlags flags)
    bool igColorEdit4(const char* label, float col, ImGuiColorEditFlags flags)
    bool igColorPicker3(const char* label, float col, ImGuiColorEditFlags flags)
    bool igColorPicker4(const char* label, float col, ImGuiColorEditFlags flags, const float* ref_col)
    bool igCombo_FnBoolPtr(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int popup_max_height_in_items)
    bool igCombo_Str(const char* label, int* current_item, const char* items_separated_by_zeros, int popup_max_height_in_items)
    bool igCombo_Str_arr(const char* label, int* current_item, char* items, int items_count, int popup_max_height_in_items)
    bool igDataTypeApplyFromText(const char* buf, ImGuiDataType data_type, void* p_data, const char* format_)
    bool igDataTypeClamp(ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max)
    bool igDebugCheckVersionAndDataLayout(const char* version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx)
    bool igDockContextCalcDropPosForDocking(ImGuiWindow* target, ImGuiDockNode* target_node, ImGuiWindow* payload_window, ImGuiDockNode* payload_node, ImGuiDir split_dir, bool split_outer, ImVec2* out_pos)
    bool igDockNodeBeginAmendTabBar(ImGuiDockNode* node)
    bool igDockNodeIsInHierarchyOf(ImGuiDockNode* node, ImGuiDockNode* parent)
    bool igDragBehavior(ImGuiID id_, ImGuiDataType data_type, void* p_v, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragFloat(const char* label, float* v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragFloat2(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragFloat3(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragFloat4(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragFloatRange2(const char* label, float* v_current_min, float* v_current_max, float v_speed, float v_min, float v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags)
    bool igDragInt(const char* label, int* v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragInt2(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragInt3(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragInt4(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragIntRange2(const char* label, int* v_current_min, int* v_current_max, float v_speed, int v_min, int v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags)
    bool igDragScalar(const char* label, ImGuiDataType data_type, void* p_data, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags)
    bool igDragScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags)
    bool igGetWindowAlwaysWantOwnTabBar(ImGuiWindow* window)
    bool igImBitArrayTestBit(const ImU32* arr, int n)
    bool igImCharIsBlankA(char c)
    bool igImCharIsBlankW(unsigned int c)
    bool igImFileClose(ImFileHandle file)
    bool igImIsFloatAboveGuaranteedIntegerPrecision(float f)
    bool igImIsPowerOfTwo_Int(int v)
    bool igImIsPowerOfTwo_U64(ImU64 v)
    bool igImTriangleContainsPoint(const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 p)
    bool igImageButton(const char* str_id, ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec4 bg_col, const ImVec4 tint_col)
    bool igImageButtonEx(ImGuiID id_, ImTextureID texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec4 bg_col, const ImVec4 tint_col, ImGuiButtonFlags flags)
    bool igInputDouble(const char* label, double* v, double step, double step_fast, const char* format_, ImGuiInputTextFlags flags)
    bool igInputFloat(const char* label, float* v, float step, float step_fast, const char* format_, ImGuiInputTextFlags flags)
    bool igInputFloat2(const char* label, float v, const char* format_, ImGuiInputTextFlags flags)
    bool igInputFloat3(const char* label, float v, const char* format_, ImGuiInputTextFlags flags)
    bool igInputFloat4(const char* label, float v, const char* format_, ImGuiInputTextFlags flags)
    bool igInputInt(const char* label, int* v, int step, int step_fast, ImGuiInputTextFlags flags)
    bool igInputInt2(const char* label, int v, ImGuiInputTextFlags flags)
    bool igInputInt3(const char* label, int v, ImGuiInputTextFlags flags)
    bool igInputInt4(const char* label, int v, ImGuiInputTextFlags flags)
    bool igInputScalar(const char* label, ImGuiDataType data_type, void* p_data, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags)
    bool igInputScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags)
    bool igInputText(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data)
    bool igInputTextEx(const char* label, const char* hint, char* buf, int buf_size, const ImVec2 size_arg, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data)
    bool igInputTextMultiline(const char* label, char* buf, size_t buf_size, const ImVec2 size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data)
    bool igInputTextWithHint(const char* label, const char* hint, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data)
    bool igInvisibleButton(const char* str_id, const ImVec2 size, ImGuiButtonFlags flags)
    bool igIsActiveIdUsingNavDir(ImGuiDir dir_)
    bool igIsAliasKey(ImGuiKey key)
    bool igIsAnyItemActive()
    bool igIsAnyItemFocused()
    bool igIsAnyItemHovered()
    bool igIsAnyMouseDown()
    bool igIsClippedEx(const ImRect bb, ImGuiID id_)
    bool igIsDragDropActive()
    bool igIsDragDropPayloadBeingAccepted()
    bool igIsGamepadKey(ImGuiKey key)
    bool igIsItemActivated()
    bool igIsItemActive()
    bool igIsItemClicked(ImGuiMouseButton mouse_button)
    bool igIsItemDeactivated()
    bool igIsItemDeactivatedAfterEdit()
    bool igIsItemEdited()
    bool igIsItemFocused()
    bool igIsItemHovered(ImGuiHoveredFlags flags)
    bool igIsItemToggledOpen()
    bool igIsItemToggledSelection()
    bool igIsItemVisible()
    bool igIsKeyDown_ID(ImGuiKey key, ImGuiID owner_id)
    bool igIsKeyDown_Nil(ImGuiKey key)
    bool igIsKeyPressedMap(ImGuiKey key, bool repeat)
    bool igIsKeyPressed_Bool(ImGuiKey key, bool repeat)
    bool igIsKeyPressed_ID(ImGuiKey key, ImGuiID owner_id, ImGuiInputFlags flags)
    bool igIsKeyReleased_ID(ImGuiKey key, ImGuiID owner_id)
    bool igIsKeyReleased_Nil(ImGuiKey key)
    bool igIsKeyboardKey(ImGuiKey key)
    bool igIsLegacyKey(ImGuiKey key)
    bool igIsMouseClicked_Bool(ImGuiMouseButton button, bool repeat)
    bool igIsMouseClicked_ID(ImGuiMouseButton button, ImGuiID owner_id, ImGuiInputFlags flags)
    bool igIsMouseDoubleClicked(ImGuiMouseButton button)
    bool igIsMouseDown_ID(ImGuiMouseButton button, ImGuiID owner_id)
    bool igIsMouseDown_Nil(ImGuiMouseButton button)
    bool igIsMouseDragPastThreshold(ImGuiMouseButton button, float lock_threshold)
    bool igIsMouseDragging(ImGuiMouseButton button, float lock_threshold)
    bool igIsMouseHoveringRect(const ImVec2 r_min, const ImVec2 r_max, bool clip)
    bool igIsMouseKey(ImGuiKey key)
    bool igIsMousePosValid(const ImVec2* mouse_pos)
    bool igIsMouseReleased_ID(ImGuiMouseButton button, ImGuiID owner_id)
    bool igIsMouseReleased_Nil(ImGuiMouseButton button)
    bool igIsNamedKey(ImGuiKey key)
    bool igIsNamedKeyOrModKey(ImGuiKey key)
    bool igIsPopupOpen_ID(ImGuiID id_, ImGuiPopupFlags popup_flags)
    bool igIsPopupOpen_Str(const char* str_id, ImGuiPopupFlags flags)
    bool igIsRectVisible_Nil(const ImVec2 size)
    bool igIsRectVisible_Vec2(const ImVec2 rect_min, const ImVec2 rect_max)
    bool igIsWindowAbove(ImGuiWindow* potential_above, ImGuiWindow* potential_below)
    bool igIsWindowAppearing()
    bool igIsWindowChildOf(ImGuiWindow* window, ImGuiWindow* potential_parent, bool popup_hierarchy, bool dock_hierarchy)
    bool igIsWindowCollapsed()
    bool igIsWindowDocked()
    bool igIsWindowFocused(ImGuiFocusedFlags flags)
    bool igIsWindowHovered(ImGuiHoveredFlags flags)
    bool igIsWindowNavFocusable(ImGuiWindow* window)
    bool igIsWindowWithinBeginStackOf(ImGuiWindow* window, ImGuiWindow* potential_parent)
    bool igItemAdd(const ImRect bb, ImGuiID id_, const ImRect* nav_bb, ImGuiItemFlags extra_flags)
    bool igItemHoverable(const ImRect bb, ImGuiID id_)
    bool igListBox_FnBoolPtr(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int height_in_items)
    bool igListBox_Str_arr(const char* label, int* current_item, char* items, int items_count, int height_in_items)
    bool igMenuItemEx(const char* label, const char* icon, const char* shortcut, bool selected, bool enabled)
    bool igMenuItem_Bool(const char* label, const char* shortcut, bool selected, bool enabled)
    bool igMenuItem_BoolPtr(const char* label, const char* shortcut, bool* p_selected, bool enabled)
    bool igNavMoveRequestButNoResultYet()
    bool igRadioButton_Bool(const char* label, bool active)
    bool igRadioButton_IntPtr(const char* label, int* v, int v_button)
    bool igScrollbarEx(const ImRect bb, ImGuiID id_, ImGuiAxis axis, ImS64* p_scroll_v, ImS64 avail_v, ImS64 contents_v, ImDrawFlags flags)
    bool igSelectable_Bool(const char* label, bool selected, ImGuiSelectableFlags flags, const ImVec2 size)
    bool igSelectable_BoolPtr(const char* label, bool* p_selected, ImGuiSelectableFlags flags, const ImVec2 size)
    bool igSetDragDropPayload(const char* type_, const void* data, size_t sz, ImGuiCond cond)
    bool igSetShortcutRouting(ImGuiKeyChord key_chord, ImGuiID owner_id, ImGuiInputFlags flags)
    bool igShortcut(ImGuiKeyChord key_chord, ImGuiID owner_id, ImGuiInputFlags flags)
    bool igShowStyleSelector(const char* label)
    bool igSliderAngle(const char* label, float* v_rad, float v_degrees_min, float v_degrees_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderBehavior(const ImRect bb, ImGuiID id_, ImGuiDataType data_type, void* p_v, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags, ImRect* out_grab_bb)
    bool igSliderFloat(const char* label, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderFloat2(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderFloat3(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderFloat4(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderInt(const char* label, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderInt2(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderInt3(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderInt4(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderScalar(const char* label, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags)
    bool igSliderScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags)
    bool igSmallButton(const char* label)
    bool igSplitterBehavior(const ImRect bb, ImGuiID id_, ImGuiAxis axis, float* size1, float* size2, float min_size1, float min_size2, float hover_extend, float hover_visibility_delay, ImU32 bg_col)
    bool igTabBarProcessReorder(ImGuiTabBar* tab_bar)
    bool igTabItemButton(const char* label, ImGuiTabItemFlags flags)
    bool igTabItemEx(ImGuiTabBar* tab_bar, const char* label, bool* p_open, ImGuiTabItemFlags flags, ImGuiWindow* docked_window)
    bool igTableBeginContextMenuPopup(ImGuiTable* table)
    bool igTableNextColumn()
    bool igTableSetColumnIndex(int column_n)
    bool igTempInputIsActive(ImGuiID id_)
    bool igTempInputScalar(const ImRect bb, ImGuiID id_, const char* label, ImGuiDataType data_type, void* p_data, const char* format_, const void* p_clamp_min, const void* p_clamp_max)
    bool igTempInputText(const ImRect bb, ImGuiID id_, const char* label, char* buf, int buf_size, ImGuiInputTextFlags flags)
    bool igTestKeyOwner(ImGuiKey key, ImGuiID owner_id)
    bool igTestShortcutRouting(ImGuiKeyChord key_chord, ImGuiID owner_id)
    bool igTreeNodeBehavior(ImGuiID id_, ImGuiTreeNodeFlags flags, const char* label, const char* label_end)
    bool igTreeNodeExV_Ptr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt, char* args)
    bool igTreeNodeExV_Str(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt, char* args)
    bool igTreeNodeEx_Ptr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt)
    bool igTreeNodeEx_Str(const char* label, ImGuiTreeNodeFlags flags)
    bool igTreeNodeEx_StrStr(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt)
    bool igTreeNodeUpdateNextOpen(ImGuiID id_, ImGuiTreeNodeFlags flags)
    bool igTreeNodeV_Ptr(const void* ptr_id, const char* fmt, char* args)
    bool igTreeNodeV_Str(const char* str_id, const char* fmt, char* args)
    bool igTreeNode_Ptr(const void* ptr_id, const char* fmt)
    bool igTreeNode_Str(const char* label)
    bool igTreeNode_StrStr(const char* str_id, const char* fmt)
    bool igVSliderFloat(const char* label, const ImVec2 size, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags)
    bool igVSliderInt(const char* label, const ImVec2 size, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags)
    bool igVSliderScalar(const char* label, const ImVec2 size, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags)
    bool* ImGuiStorage_GetBoolRef(ImGuiStorage* self, ImGuiID key, bool default_val)
    char igImToUpper(char c)
    char* ImGuiWindowSettings_GetName(ImGuiWindowSettings* self)
    char* igImStrdup(const char* str_)
    char* igImStrdupcpy(char* dst, size_t* p_dst_size, const char* str_)
    const ImFontBuilderIO* igImFontAtlasGetBuilderForStbTruetype()
    const ImFontGlyph* ImFont_FindGlyph(ImFont* self, ImWchar c)
    const ImFontGlyph* ImFont_FindGlyphNoFallback(ImFont* self, ImWchar c)
    const ImGuiDataTypeInfo* igDataTypeGetInfo(ImGuiDataType data_type)
    const ImGuiPayload* igAcceptDragDropPayload(const char* type_, ImGuiDragDropFlags flags)
    const ImGuiPayload* igGetDragDropPayload()
    const ImGuiPlatformMonitor* igGetViewportPlatformMonitor(ImGuiViewport* viewport)
    const ImVec4* igGetStyleColorVec4(ImGuiCol idx)
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseFull(ImFontAtlas* self)
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(ImFontAtlas* self)
    const ImWchar* ImFontAtlas_GetGlyphRangesCyrillic(ImFontAtlas* self)
    const ImWchar* ImFontAtlas_GetGlyphRangesDefault(ImFontAtlas* self)
    const ImWchar* ImFontAtlas_GetGlyphRangesGreek(ImFontAtlas* self)
    const ImWchar* ImFontAtlas_GetGlyphRangesJapanese(ImFontAtlas* self)
    const ImWchar* ImFontAtlas_GetGlyphRangesKorean(ImFontAtlas* self)
    const ImWchar* ImFontAtlas_GetGlyphRangesThai(ImFontAtlas* self)
    const ImWchar* ImFontAtlas_GetGlyphRangesVietnamese(ImFontAtlas* self)
    const ImWchar* igImStrbolW(const ImWchar* buf_mid_line, const ImWchar* buf_begin)
    const char* ImFont_CalcWordWrapPositionA(ImFont* self, float scale, const char* text, const char* text_end, float wrap_width)
    const char* ImFont_GetDebugName(ImFont* self)
    const char* ImGuiTextBuffer_begin(ImGuiTextBuffer* self)
    const char* ImGuiTextBuffer_c_str(ImGuiTextBuffer* self)
    const char* ImGuiTextBuffer_end(ImGuiTextBuffer* self)
    const char* ImGuiTextIndex_get_line_begin(ImGuiTextIndex* self, const char* base, int n)
    const char* ImGuiTextIndex_get_line_end(ImGuiTextIndex* self, const char* base, int n)
    const char* igFindRenderedTextEnd(const char* text, const char* text_end)
    const char* igGetClipboardText()
    const char* igGetKeyName(ImGuiKey key)
    const char* igGetStyleColorName(ImGuiCol idx)
    const char* igGetVersion()
    const char* igImParseFormatFindEnd(const char* format_)
    const char* igImParseFormatFindStart(const char* format_)
    const char* igImParseFormatSanitizeForScanning(const char* fmt_in, char* fmt_out, size_t fmt_out_size)
    const char* igImParseFormatTrimDecorations(const char* format_, char* buf, size_t buf_size)
    const char* igImStrSkipBlank(const char* str_)
    const char* igImStrchrRange(const char* str_begin, const char* str_end, char c)
    const char* igImStreolRange(const char* str_, const char* str_end)
    const char* igImStristr(const char* haystack, const char* haystack_end, const char* needle, const char* needle_end)
    const char* igImTextCharToUtf8(char out_buf, unsigned int c)
    const char* igLocalizeGetMsg(ImGuiLocKey key)
    const char* igSaveIniSettingsToMemory(size_t* out_ini_size)
    const char* igTabBarGetTabName(ImGuiTabBar* tab_bar, ImGuiTabItem* tab)
    const char* igTableGetColumnName_Int(int column_n)
    const char* igTableGetColumnName_TablePtr(const ImGuiTable* table, int column_n)
    double igGetTime()
    double igImAbs_double(double x)
    double igImLog_double(double x)
    double igImPow_double(double x, double y)
    double igImRsqrt_double(double x)
    double igImSign_double(double x)
    float ImFont_GetCharAdvance(ImFont* self, ImWchar c)
    float ImGuiMenuColumns_DeclColumns(ImGuiMenuColumns* self, float w_icon, float w_label, float w_shortcut, float w_mark)
    float ImGuiStorage_GetFloat(ImGuiStorage* self, ImGuiID key, float default_val)
    float ImGuiWindow_CalcFontSize(ImGuiWindow* self)
    float ImGuiWindow_MenuBarHeight(ImGuiWindow* self)
    float ImGuiWindow_TitleBarHeight(ImGuiWindow* self)
    float ImRect_GetArea(ImRect* self)
    float ImRect_GetHeight(ImRect* self)
    float ImRect_GetWidth(ImRect* self)
    float igCalcItemWidth()
    float igCalcWrapWidthForPos(const ImVec2 pos, float wrap_pos_x)
    float igGET_FLT_MAX()
    float igGET_FLT_MIN()
    float igGetColumnNormFromOffset(const ImGuiOldColumns* columns, float offset)
    float igGetColumnOffset(int column_index)
    float igGetColumnOffsetFromNorm(const ImGuiOldColumns* columns, float offset_norm)
    float igGetColumnWidth(int column_index)
    float igGetCursorPosX()
    float igGetCursorPosY()
    float igGetFontSize()
    float igGetFrameHeight()
    float igGetFrameHeightWithSpacing()
    float igGetNavTweakPressedAmount(ImGuiAxis axis)
    float igGetScrollMaxX()
    float igGetScrollMaxY()
    float igGetScrollX()
    float igGetScrollY()
    float igGetTextLineHeight()
    float igGetTextLineHeightWithSpacing()
    float igGetTreeNodeToLabelSpacing()
    float igGetWindowDpiScale()
    float igGetWindowHeight()
    float igGetWindowWidth()
    float igImAbs_Float(float x)
    float igImDot(const ImVec2 a, const ImVec2 b)
    float igImExponentialMovingAverage(float avg, float sample, int n)
    float igImFloorSigned_Float(float f)
    float igImFloor_Float(float f)
    float igImInvLength(const ImVec2 lhs, float fail_value)
    float igImLengthSqr_Vec2(const ImVec2 lhs)
    float igImLengthSqr_Vec4(const ImVec4 lhs)
    float igImLinearSweep(float current, float target, float speed)
    float igImLog_Float(float x)
    float igImPow_Float(float x, float y)
    float igImRsqrt_Float(float x)
    float igImSaturate(float f)
    float igImSign_Float(float x)
    float igImTriangleArea(const ImVec2 a, const ImVec2 b, const ImVec2 c)
    float igTableGetColumnWidthAuto(ImGuiTable* table, ImGuiTableColumn* column)
    float igTableGetHeaderRowHeight()
    float igTableGetMaxColumnWidth(const ImGuiTable* table, int column_n)
    float* ImGuiStorage_GetFloatRef(ImGuiStorage* self, ImGuiID key, float default_val)
    int ImDrawDataBuilder_GetDrawListCount(ImDrawDataBuilder* self)
    int ImDrawList__CalcCircleAutoSegmentCount(ImDrawList* self, float radius)
    int ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas* self, ImFont* font, ImWchar id_, int width, int height, float advance_x, const ImVec2 offset)
    int ImFontAtlas_AddCustomRectRegular(ImFontAtlas* self, int width, int height)
    int ImGuiInputTextState_GetCursorPos(ImGuiInputTextState* self)
    int ImGuiInputTextState_GetRedoAvailCount(ImGuiInputTextState* self)
    int ImGuiInputTextState_GetSelectionEnd(ImGuiInputTextState* self)
    int ImGuiInputTextState_GetSelectionStart(ImGuiInputTextState* self)
    int ImGuiInputTextState_GetUndoAvailCount(ImGuiInputTextState* self)
    int ImGuiStorage_GetInt(ImGuiStorage* self, ImGuiID key, int default_val)
    int ImGuiTextBuffer_size(ImGuiTextBuffer* self)
    int ImGuiTextIndex_size(ImGuiTextIndex* self)
    int igCalcTypematicRepeatAmount(float t0, float t1, float repeat_delay, float repeat_rate)
    int igDataTypeCompare(ImGuiDataType data_type, const void* arg_1, const void* arg_2)
    int igDataTypeFormatString(char* buf, int buf_size, ImGuiDataType data_type, const void* p_data, const char* format_)
    int igDockNodeGetDepth(const ImGuiDockNode* node)
    int igFindWindowDisplayIndex(ImGuiWindow* window)
    int igGetColumnIndex()
    int igGetColumnsCount()
    int igGetFrameCount()
    int igGetKeyPressedAmount(ImGuiKey key, float repeat_delay, float rate)
    int igGetMouseClickedCount(ImGuiMouseButton button)
    int igImAbs_Int(int x)
    int igImFormatString(char* buf, size_t buf_size, const char* fmt)
    int igImFormatStringV(char* buf, size_t buf_size, const char* fmt, char* args)
    int igImModPositive(int a, int b)
    int igImParseFormatPrecision(const char* format_, int default_value)
    int igImStricmp(const char* str1, const char* str2)
    int igImStrlenW(const ImWchar* str_)
    int igImStrnicmp(const char* str1, const char* str2, size_t count)
    int igImTextCharFromUtf8(unsigned int* out_char, const char* in_text, const char* in_text_end)
    int igImTextCountCharsFromUtf8(const char* in_text, const char* in_text_end)
    int igImTextCountUtf8BytesFromChar(const char* in_text, const char* in_text_end)
    int igImTextCountUtf8BytesFromStr(const ImWchar* in_text, const ImWchar* in_text_end)
    int igImTextStrFromUtf8(ImWchar* out_buf, int out_buf_size, const char* in_text, const char* in_text_end, const char** in_remaining)
    int igImTextStrToUtf8(char* out_buf, int out_buf_size, const ImWchar* in_text, const ImWchar* in_text_end)
    int igImUpperPowerOfTwo(int v)
    int igPlotEx(ImGuiPlotType plot_type, const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, const ImVec2 size_arg)
    int igTabBarGetTabOrder(ImGuiTabBar* tab_bar, ImGuiTabItem* tab)
    int igTableGetColumnCount()
    int igTableGetColumnIndex()
    int igTableGetHoveredColumn()
    int igTableGetRowIndex()
    int* ImGuiStorage_GetIntRef(ImGuiStorage* self, ImGuiID key, int default_val)
    size_t igImBitArrayGetStorageSizeInBytes(int bitcount)
    void ImBitVector_Clear(ImBitVector* self)
    void ImBitVector_ClearBit(ImBitVector* self, int n)
    void ImBitVector_Create(ImBitVector* self, int sz)
    void ImBitVector_SetBit(ImBitVector* self, int n)
    void ImColor_HSV(ImColor *pOut, float h, float s, float v, float a)
    void ImColor_SetHSV(ImColor* self, float h, float s, float v, float a)
    void ImColor_destroy(ImColor* self)
    void ImDrawCmd_destroy(ImDrawCmd* self)
    void ImDrawDataBuilder_Clear(ImDrawDataBuilder* self)
    void ImDrawDataBuilder_ClearFreeMemory(ImDrawDataBuilder* self)
    void ImDrawDataBuilder_FlattenIntoSingleLayer(ImDrawDataBuilder* self)
    void ImDrawData_Clear(ImDrawData* self)
    void ImDrawData_DeIndexAllBuffers(ImDrawData* self)
    void ImDrawData_ScaleClipRects(ImDrawData* self, const ImVec2 fb_scale)
    void ImDrawData_destroy(ImDrawData* self)
    void ImDrawListSharedData_SetCircleTessellationMaxError(ImDrawListSharedData* self, float max_error)
    void ImDrawListSharedData_destroy(ImDrawListSharedData* self)
    void ImDrawListSplitter_Clear(ImDrawListSplitter* self)
    void ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter* self)
    void ImDrawListSplitter_Merge(ImDrawListSplitter* self, ImDrawList* draw_list)
    void ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter* self, ImDrawList* draw_list, int channel_idx)
    void ImDrawListSplitter_Split(ImDrawListSplitter* self, ImDrawList* draw_list, int count)
    void ImDrawListSplitter_destroy(ImDrawListSplitter* self)
    void ImDrawList_AddBezierCubic(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col, float thickness, int num_segments)
    void ImDrawList_AddBezierQuadratic(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, ImU32 col, float thickness, int num_segments)
    void ImDrawList_AddCallback(ImDrawList* self, ImDrawCallback callback, void* callback_data)
    void ImDrawList_AddCircle(ImDrawList* self, const ImVec2 center, float radius, ImU32 col, int num_segments, float thickness)
    void ImDrawList_AddCircleFilled(ImDrawList* self, const ImVec2 center, float radius, ImU32 col, int num_segments)
    void ImDrawList_AddConvexPolyFilled(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col)
    void ImDrawList_AddDrawCmd(ImDrawList* self)
    void ImDrawList_AddImage(ImDrawList* self, ImTextureID user_texture_id, const ImVec2 p_min, const ImVec2 p_max, const ImVec2 uv_min, const ImVec2 uv_max, ImU32 col)
    void ImDrawList_AddImageQuad(ImDrawList* self, ImTextureID user_texture_id, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, const ImVec2 uv1, const ImVec2 uv2, const ImVec2 uv3, const ImVec2 uv4, ImU32 col)
    void ImDrawList_AddImageRounded(ImDrawList* self, ImTextureID user_texture_id, const ImVec2 p_min, const ImVec2 p_max, const ImVec2 uv_min, const ImVec2 uv_max, ImU32 col, float rounding, ImDrawFlags flags)
    void ImDrawList_AddLine(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, ImU32 col, float thickness)
    void ImDrawList_AddNgon(ImDrawList* self, const ImVec2 center, float radius, ImU32 col, int num_segments, float thickness)
    void ImDrawList_AddNgonFilled(ImDrawList* self, const ImVec2 center, float radius, ImU32 col, int num_segments)
    void ImDrawList_AddPolyline(ImDrawList* self, const ImVec2* points, int num_points, ImU32 col, ImDrawFlags flags, float thickness)
    void ImDrawList_AddQuad(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col, float thickness)
    void ImDrawList_AddQuadFilled(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col)
    void ImDrawList_AddRect(ImDrawList* self, const ImVec2 p_min, const ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags, float thickness)
    void ImDrawList_AddRectFilled(ImDrawList* self, const ImVec2 p_min, const ImVec2 p_max, ImU32 col, float rounding, ImDrawFlags flags)
    void ImDrawList_AddRectFilledMultiColor(ImDrawList* self, const ImVec2 p_min, const ImVec2 p_max, ImU32 col_upr_left, ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left)
    void ImDrawList_AddText_FontPtr(ImDrawList* self, const ImFont* font, float font_size, const ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end, float wrap_width, const ImVec4* cpu_fine_clip_rect)
    void ImDrawList_AddText_Vec2(ImDrawList* self, const ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end)
    void ImDrawList_AddTriangle(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, ImU32 col, float thickness)
    void ImDrawList_AddTriangleFilled(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, ImU32 col)
    void ImDrawList_ChannelsMerge(ImDrawList* self)
    void ImDrawList_ChannelsSetCurrent(ImDrawList* self, int n)
    void ImDrawList_ChannelsSplit(ImDrawList* self, int count)
    void ImDrawList_GetClipRectMax(ImVec2 *pOut, ImDrawList* self)
    void ImDrawList_GetClipRectMin(ImVec2 *pOut, ImDrawList* self)
    void ImDrawList_PathArcTo(ImDrawList* self, const ImVec2 center, float radius, float a_min, float a_max, int num_segments)
    void ImDrawList_PathArcToFast(ImDrawList* self, const ImVec2 center, float radius, int a_min_of_12, int a_max_of_12)
    void ImDrawList_PathBezierCubicCurveTo(ImDrawList* self, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, int num_segments)
    void ImDrawList_PathBezierQuadraticCurveTo(ImDrawList* self, const ImVec2 p2, const ImVec2 p3, int num_segments)
    void ImDrawList_PathClear(ImDrawList* self)
    void ImDrawList_PathFillConvex(ImDrawList* self, ImU32 col)
    void ImDrawList_PathLineTo(ImDrawList* self, const ImVec2 pos)
    void ImDrawList_PathLineToMergeDuplicate(ImDrawList* self, const ImVec2 pos)
    void ImDrawList_PathRect(ImDrawList* self, const ImVec2 rect_min, const ImVec2 rect_max, float rounding, ImDrawFlags flags)
    void ImDrawList_PathStroke(ImDrawList* self, ImU32 col, ImDrawFlags flags, float thickness)
    void ImDrawList_PopClipRect(ImDrawList* self)
    void ImDrawList_PopTextureID(ImDrawList* self)
    void ImDrawList_PrimQuadUV(ImDrawList* self, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 d, const ImVec2 uv_a, const ImVec2 uv_b, const ImVec2 uv_c, const ImVec2 uv_d, ImU32 col)
    void ImDrawList_PrimRect(ImDrawList* self, const ImVec2 a, const ImVec2 b, ImU32 col)
    void ImDrawList_PrimRectUV(ImDrawList* self, const ImVec2 a, const ImVec2 b, const ImVec2 uv_a, const ImVec2 uv_b, ImU32 col)
    void ImDrawList_PrimReserve(ImDrawList* self, int idx_count, int vtx_count)
    void ImDrawList_PrimUnreserve(ImDrawList* self, int idx_count, int vtx_count)
    void ImDrawList_PrimVtx(ImDrawList* self, const ImVec2 pos, const ImVec2 uv, ImU32 col)
    void ImDrawList_PrimWriteIdx(ImDrawList* self, ImDrawIdx idx)
    void ImDrawList_PrimWriteVtx(ImDrawList* self, const ImVec2 pos, const ImVec2 uv, ImU32 col)
    void ImDrawList_PushClipRect(ImDrawList* self, const ImVec2 clip_rect_min, const ImVec2 clip_rect_max, bool intersect_with_current_clip_rect)
    void ImDrawList_PushClipRectFullScreen(ImDrawList* self)
    void ImDrawList_PushTextureID(ImDrawList* self, ImTextureID texture_id)
    void ImDrawList__ClearFreeMemory(ImDrawList* self)
    void ImDrawList__OnChangedClipRect(ImDrawList* self)
    void ImDrawList__OnChangedTextureID(ImDrawList* self)
    void ImDrawList__OnChangedVtxOffset(ImDrawList* self)
    void ImDrawList__PathArcToFastEx(ImDrawList* self, const ImVec2 center, float radius, int a_min_sample, int a_max_sample, int a_step)
    void ImDrawList__PathArcToN(ImDrawList* self, const ImVec2 center, float radius, float a_min, float a_max, int num_segments)
    void ImDrawList__PopUnusedDrawCmd(ImDrawList* self)
    void ImDrawList__ResetForNewFrame(ImDrawList* self)
    void ImDrawList__TryMergeDrawCmds(ImDrawList* self)
    void ImDrawList_destroy(ImDrawList* self)
    void ImFontAtlasCustomRect_destroy(ImFontAtlasCustomRect* self)
    void ImFontAtlas_CalcCustomRectUV(ImFontAtlas* self, const ImFontAtlasCustomRect* rect, ImVec2* out_uv_min, ImVec2* out_uv_max)
    void ImFontAtlas_Clear(ImFontAtlas* self)
    void ImFontAtlas_ClearFonts(ImFontAtlas* self)
    void ImFontAtlas_ClearInputData(ImFontAtlas* self)
    void ImFontAtlas_ClearTexData(ImFontAtlas* self)
    void ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel)
    void ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel)
    void ImFontAtlas_SetTexID(ImFontAtlas* self, ImTextureID id_)
    void ImFontAtlas_destroy(ImFontAtlas* self)
    void ImFontConfig_destroy(ImFontConfig* self)
    void ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder* self, ImWchar c)
    void ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder* self, const ImWchar* ranges)
    void ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder* self, const char* text, const char* text_end)
    void ImFontGlyphRangesBuilder_BuildRanges(ImFontGlyphRangesBuilder* self, ImVector_ImWchar* out_ranges)
    void ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder* self)
    void ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder* self, size_t n)
    void ImFontGlyphRangesBuilder_destroy(ImFontGlyphRangesBuilder* self)
    void ImFont_AddGlyph(ImFont* self, const ImFontConfig* src_cfg, ImWchar c, float x0, float y0, float x1, float y1, float u0, float v0, float u1, float v1, float advance_x)
    void ImFont_AddRemapChar(ImFont* self, ImWchar dst, ImWchar src, bool overwrite_dst)
    void ImFont_BuildLookupTable(ImFont* self)
    void ImFont_CalcTextSizeA(ImVec2 *pOut, ImFont* self, float size, float max_width, float wrap_width, const char* text_begin, const char* text_end, const char** remaining)
    void ImFont_ClearOutputData(ImFont* self)
    void ImFont_GrowIndex(ImFont* self, int new_size)
    void ImFont_RenderChar(ImFont* self, ImDrawList* draw_list, float size, const ImVec2 pos, ImU32 col, ImWchar c)
    void ImFont_RenderText(ImFont* self, ImDrawList* draw_list, float size, const ImVec2 pos, ImU32 col, const ImVec4 clip_rect, const char* text_begin, const char* text_end, float wrap_width, bool cpu_fine_clip)
    void ImFont_SetGlyphVisible(ImFont* self, ImWchar c, bool visible)
    void ImFont_destroy(ImFont* self)
    void ImGuiComboPreviewData_destroy(ImGuiComboPreviewData* self)
    void ImGuiContextHook_destroy(ImGuiContextHook* self)
    void ImGuiContext_destroy(ImGuiContext* self)
    void ImGuiDockContext_destroy(ImGuiDockContext* self)
    void ImGuiDockNode_Rect(ImRect *pOut, ImGuiDockNode* self)
    void ImGuiDockNode_SetLocalFlags(ImGuiDockNode* self, ImGuiDockNodeFlags flags)
    void ImGuiDockNode_UpdateMergedFlags(ImGuiDockNode* self)
    void ImGuiDockNode_destroy(ImGuiDockNode* self)
    void ImGuiIO_AddFocusEvent(ImGuiIO* self, bool focused)
    void ImGuiIO_AddInputCharacter(ImGuiIO* self, unsigned int c)
    void ImGuiIO_AddInputCharacterUTF16(ImGuiIO* self, ImWchar16 c)
    void ImGuiIO_AddInputCharactersUTF8(ImGuiIO* self, const char* str_)
    void ImGuiIO_AddKeyAnalogEvent(ImGuiIO* self, ImGuiKey key, bool down, float v)
    void ImGuiIO_AddKeyEvent(ImGuiIO* self, ImGuiKey key, bool down)
    void ImGuiIO_AddMouseButtonEvent(ImGuiIO* self, int button, bool down)
    void ImGuiIO_AddMousePosEvent(ImGuiIO* self, float x, float y)
    void ImGuiIO_AddMouseViewportEvent(ImGuiIO* self, ImGuiID id_)
    void ImGuiIO_AddMouseWheelEvent(ImGuiIO* self, float wheel_x, float wheel_y)
    void ImGuiIO_ClearInputCharacters(ImGuiIO* self)
    void ImGuiIO_ClearInputKeys(ImGuiIO* self)
    void ImGuiIO_SetAppAcceptingEvents(ImGuiIO* self, bool accepting_events)
    void ImGuiIO_SetKeyEventNativeData(ImGuiIO* self, ImGuiKey key, int native_keycode, int native_scancode, int native_legacy_index)
    void ImGuiIO_destroy(ImGuiIO* self)
    void ImGuiInputEvent_destroy(ImGuiInputEvent* self)
    void ImGuiInputTextCallbackData_ClearSelection(ImGuiInputTextCallbackData* self)
    void ImGuiInputTextCallbackData_DeleteChars(ImGuiInputTextCallbackData* self, int pos, int bytes_count)
    void ImGuiInputTextCallbackData_InsertChars(ImGuiInputTextCallbackData* self, int pos, const char* text, const char* text_end)
    void ImGuiInputTextCallbackData_SelectAll(ImGuiInputTextCallbackData* self)
    void ImGuiInputTextCallbackData_destroy(ImGuiInputTextCallbackData* self)
    void ImGuiInputTextState_ClearFreeMemory(ImGuiInputTextState* self)
    void ImGuiInputTextState_ClearSelection(ImGuiInputTextState* self)
    void ImGuiInputTextState_ClearText(ImGuiInputTextState* self)
    void ImGuiInputTextState_CursorAnimReset(ImGuiInputTextState* self)
    void ImGuiInputTextState_CursorClamp(ImGuiInputTextState* self)
    void ImGuiInputTextState_OnKeyPressed(ImGuiInputTextState* self, int key)
    void ImGuiInputTextState_SelectAll(ImGuiInputTextState* self)
    void ImGuiInputTextState_destroy(ImGuiInputTextState* self)
    void ImGuiKeyOwnerData_destroy(ImGuiKeyOwnerData* self)
    void ImGuiKeyRoutingData_destroy(ImGuiKeyRoutingData* self)
    void ImGuiKeyRoutingTable_Clear(ImGuiKeyRoutingTable* self)
    void ImGuiKeyRoutingTable_destroy(ImGuiKeyRoutingTable* self)
    void ImGuiLastItemData_destroy(ImGuiLastItemData* self)
    void ImGuiListClipperData_Reset(ImGuiListClipperData* self, ImGuiListClipper* clipper)
    void ImGuiListClipperData_destroy(ImGuiListClipperData* self)
    void ImGuiListClipper_Begin(ImGuiListClipper* self, int items_count, float items_height)
    void ImGuiListClipper_End(ImGuiListClipper* self)
    void ImGuiListClipper_ForceDisplayRangeByIndices(ImGuiListClipper* self, int item_min, int item_max)
    void ImGuiListClipper_destroy(ImGuiListClipper* self)
    void ImGuiMenuColumns_CalcNextTotalWidth(ImGuiMenuColumns* self, bool update_offsets)
    void ImGuiMenuColumns_Update(ImGuiMenuColumns* self, float spacing, bool window_reappearing)
    void ImGuiMenuColumns_destroy(ImGuiMenuColumns* self)
    void ImGuiNavItemData_Clear(ImGuiNavItemData* self)
    void ImGuiNavItemData_destroy(ImGuiNavItemData* self)
    void ImGuiNextItemData_ClearFlags(ImGuiNextItemData* self)
    void ImGuiNextItemData_destroy(ImGuiNextItemData* self)
    void ImGuiNextWindowData_ClearFlags(ImGuiNextWindowData* self)
    void ImGuiNextWindowData_destroy(ImGuiNextWindowData* self)
    void ImGuiOldColumnData_destroy(ImGuiOldColumnData* self)
    void ImGuiOldColumns_destroy(ImGuiOldColumns* self)
    void ImGuiOnceUponAFrame_destroy(ImGuiOnceUponAFrame* self)
    void ImGuiPayload_Clear(ImGuiPayload* self)
    void ImGuiPayload_destroy(ImGuiPayload* self)
    void ImGuiPlatformIO_destroy(ImGuiPlatformIO* self)
    void ImGuiPlatformImeData_destroy(ImGuiPlatformImeData* self)
    void ImGuiPlatformMonitor_destroy(ImGuiPlatformMonitor* self)
    void ImGuiPopupData_destroy(ImGuiPopupData* self)
    void ImGuiPtrOrIndex_destroy(ImGuiPtrOrIndex* self)
    void ImGuiSettingsHandler_destroy(ImGuiSettingsHandler* self)
    void ImGuiStackLevelInfo_destroy(ImGuiStackLevelInfo* self)
    void ImGuiStackSizes_CompareWithCurrentState(ImGuiStackSizes* self)
    void ImGuiStackSizes_SetToCurrentState(ImGuiStackSizes* self)
    void ImGuiStackSizes_destroy(ImGuiStackSizes* self)
    void ImGuiStackTool_destroy(ImGuiStackTool* self)
    void ImGuiStoragePair_destroy(ImGuiStoragePair* self)
    void ImGuiStorage_BuildSortByKey(ImGuiStorage* self)
    void ImGuiStorage_Clear(ImGuiStorage* self)
    void ImGuiStorage_SetAllInt(ImGuiStorage* self, int val)
    void ImGuiStorage_SetBool(ImGuiStorage* self, ImGuiID key, bool val)
    void ImGuiStorage_SetFloat(ImGuiStorage* self, ImGuiID key, float val)
    void ImGuiStorage_SetInt(ImGuiStorage* self, ImGuiID key, int val)
    void ImGuiStorage_SetVoidPtr(ImGuiStorage* self, ImGuiID key, void* val)
    void ImGuiStyleMod_destroy(ImGuiStyleMod* self)
    void ImGuiStyle_ScaleAllSizes(ImGuiStyle* self, float scale_factor)
    void ImGuiStyle_destroy(ImGuiStyle* self)
    void ImGuiTabBar_destroy(ImGuiTabBar* self)
    void ImGuiTabItem_destroy(ImGuiTabItem* self)
    void ImGuiTableColumnSettings_destroy(ImGuiTableColumnSettings* self)
    void ImGuiTableColumnSortSpecs_destroy(ImGuiTableColumnSortSpecs* self)
    void ImGuiTableColumn_destroy(ImGuiTableColumn* self)
    void ImGuiTableInstanceData_destroy(ImGuiTableInstanceData* self)
    void ImGuiTableSettings_destroy(ImGuiTableSettings* self)
    void ImGuiTableSortSpecs_destroy(ImGuiTableSortSpecs* self)
    void ImGuiTableTempData_destroy(ImGuiTableTempData* self)
    void ImGuiTable_destroy(ImGuiTable* self)
    void ImGuiTextBuffer_append(ImGuiTextBuffer* self, const char* str_, const char* str_end)
    void ImGuiTextBuffer_appendf(ImGuiTextBuffer *buffer, const char *fmt)
    void ImGuiTextBuffer_appendfv(ImGuiTextBuffer* self, const char* fmt, char* args)
    void ImGuiTextBuffer_clear(ImGuiTextBuffer* self)
    void ImGuiTextBuffer_destroy(ImGuiTextBuffer* self)
    void ImGuiTextBuffer_reserve(ImGuiTextBuffer* self, int capacity)
    void ImGuiTextFilter_Build(ImGuiTextFilter* self)
    void ImGuiTextFilter_Clear(ImGuiTextFilter* self)
    void ImGuiTextFilter_destroy(ImGuiTextFilter* self)
    void ImGuiTextIndex_append(ImGuiTextIndex* self, const char* base, int old_size, int new_size)
    void ImGuiTextIndex_clear(ImGuiTextIndex* self)
    void ImGuiTextRange_destroy(ImGuiTextRange* self)
    void ImGuiTextRange_split(ImGuiTextRange* self, char separator, ImVector_ImGuiTextRange* out)
    void ImGuiViewportP_CalcWorkRectPos(ImVec2 *pOut, ImGuiViewportP* self, const ImVec2 off_min)
    void ImGuiViewportP_CalcWorkRectSize(ImVec2 *pOut, ImGuiViewportP* self, const ImVec2 off_min, const ImVec2 off_max)
    void ImGuiViewportP_ClearRequestFlags(ImGuiViewportP* self)
    void ImGuiViewportP_GetBuildWorkRect(ImRect *pOut, ImGuiViewportP* self)
    void ImGuiViewportP_GetMainRect(ImRect *pOut, ImGuiViewportP* self)
    void ImGuiViewportP_GetWorkRect(ImRect *pOut, ImGuiViewportP* self)
    void ImGuiViewportP_UpdateWorkRect(ImGuiViewportP* self)
    void ImGuiViewportP_destroy(ImGuiViewportP* self)
    void ImGuiViewport_GetCenter(ImVec2 *pOut, ImGuiViewport* self)
    void ImGuiViewport_GetWorkCenter(ImVec2 *pOut, ImGuiViewport* self)
    void ImGuiViewport_destroy(ImGuiViewport* self)
    void ImGuiWindowClass_destroy(ImGuiWindowClass* self)
    void ImGuiWindowSettings_destroy(ImGuiWindowSettings* self)
    void ImGuiWindow_MenuBarRect(ImRect *pOut, ImGuiWindow* self)
    void ImGuiWindow_Rect(ImRect *pOut, ImGuiWindow* self)
    void ImGuiWindow_TitleBarRect(ImRect *pOut, ImGuiWindow* self)
    void ImGuiWindow_destroy(ImGuiWindow* self)
    void ImRect_Add_Rect(ImRect* self, const ImRect r)
    void ImRect_Add_Vec2(ImRect* self, const ImVec2 p)
    void ImRect_ClipWith(ImRect* self, const ImRect r)
    void ImRect_ClipWithFull(ImRect* self, const ImRect r)
    void ImRect_Expand_Float(ImRect* self, const float amount)
    void ImRect_Expand_Vec2(ImRect* self, const ImVec2 amount)
    void ImRect_Floor(ImRect* self)
    void ImRect_GetBL(ImVec2 *pOut, ImRect* self)
    void ImRect_GetBR(ImVec2 *pOut, ImRect* self)
    void ImRect_GetCenter(ImVec2 *pOut, ImRect* self)
    void ImRect_GetSize(ImVec2 *pOut, ImRect* self)
    void ImRect_GetTL(ImVec2 *pOut, ImRect* self)
    void ImRect_GetTR(ImVec2 *pOut, ImRect* self)
    void ImRect_ToVec4(ImVec4 *pOut, ImRect* self)
    void ImRect_Translate(ImRect* self, const ImVec2 d)
    void ImRect_TranslateX(ImRect* self, float dx)
    void ImRect_TranslateY(ImRect* self, float dy)
    void ImRect_destroy(ImRect* self)
    void ImVec1_destroy(ImVec1* self)
    void ImVec2_destroy(ImVec2* self)
    void ImVec2ih_destroy(ImVec2ih* self)
    void ImVec4_destroy(ImVec4* self)
    void ImVector_ImWchar_Init(ImVector_ImWchar* p)
    void ImVector_ImWchar_UnInit(ImVector_ImWchar* p)
    void ImVector_ImWchar_destroy(ImVector_ImWchar* self)
    void igActivateItem(ImGuiID id_)
    void igAddSettingsHandler(const ImGuiSettingsHandler* handler)
    void igAlignTextToFramePadding()
    void igBeginColumns(const char* str_id, int count, ImGuiOldColumnFlags flags)
    void igBeginDisabled(bool disabled)
    void igBeginDockableDragDropSource(ImGuiWindow* window)
    void igBeginDockableDragDropTarget(ImGuiWindow* window)
    void igBeginDocked(ImGuiWindow* window, bool* p_open)
    void igBeginGroup()
    void igBeginTooltip()
    void igBeginTooltipEx(ImGuiTooltipFlags tooltip_flags, ImGuiWindowFlags extra_window_flags)
    void igBringWindowToDisplayBack(ImGuiWindow* window)
    void igBringWindowToDisplayBehind(ImGuiWindow* window, ImGuiWindow* above_window)
    void igBringWindowToDisplayFront(ImGuiWindow* window)
    void igBringWindowToFocusFront(ImGuiWindow* window)
    void igBullet()
    void igBulletText(const char* fmt)
    void igBulletTextV(const char* fmt, char* args)
    void igCalcItemSize(ImVec2 *pOut, ImVec2 size, float default_w, float default_h)
    void igCalcTextSize(ImVec2 *pOut, const char* text, const char* text_end, bool hide_text_after_double_hash, float wrap_width)
    void igCalcWindowNextAutoFitSize(ImVec2 *pOut, ImGuiWindow* window)
    void igCallContextHooks(ImGuiContext* context, ImGuiContextHookType type_)
    void igClearActiveID()
    void igClearDragDrop()
    void igClearIniSettings()
    void igClearWindowSettings(const char* name)
    void igCloseCurrentPopup()
    void igClosePopupToLevel(int remaining, bool restore_focus_to_window_under_popup)
    void igClosePopupsExceptModals()
    void igClosePopupsOverWindow(ImGuiWindow* ref_window, bool restore_focus_to_window_under_popup)
    void igColorConvertHSVtoRGB(float h, float s, float v, float* out_r, float* out_g, float* out_b)
    void igColorConvertRGBtoHSV(float r, float g, float b, float* out_h, float* out_s, float* out_v)
    void igColorConvertU32ToFloat4(ImVec4 *pOut, ImU32 in_)
    void igColorEditOptionsPopup(const float* col, ImGuiColorEditFlags flags)
    void igColorPickerOptionsPopup(const float* ref_col, ImGuiColorEditFlags flags)
    void igColorTooltip(const char* text, const float* col, ImGuiColorEditFlags flags)
    void igColumns(int count, const char* id_, bool border)
    void igDataTypeApplyOp(ImGuiDataType data_type, int op, void* output, const void* arg_1, const void* arg_2)
    void igDebugDrawItemRect(ImU32 col)
    void igDebugHookIdInfo(ImGuiID id_, ImGuiDataType data_type, const void* data_id, const void* data_id_end)
    void igDebugLocateItem(ImGuiID target_id)
    void igDebugLocateItemOnHover(ImGuiID target_id)
    void igDebugLocateItemResolveWithLastItem()
    void igDebugLog(const char* fmt)
    void igDebugLogV(const char* fmt, char* args)
    void igDebugNodeColumns(ImGuiOldColumns* columns)
    void igDebugNodeDockNode(ImGuiDockNode* node, const char* label)
    void igDebugNodeDrawCmdShowMeshAndBoundingBox(ImDrawList* out_draw_list, const ImDrawList* draw_list, const ImDrawCmd* draw_cmd, bool show_mesh, bool show_aabb)
    void igDebugNodeDrawList(ImGuiWindow* window, ImGuiViewportP* viewport, const ImDrawList* draw_list, const char* label)
    void igDebugNodeFont(ImFont* font)
    void igDebugNodeFontGlyph(ImFont* font, const ImFontGlyph* glyph)
    void igDebugNodeInputTextState(ImGuiInputTextState* state)
    void igDebugNodeStorage(ImGuiStorage* storage, const char* label)
    void igDebugNodeTabBar(ImGuiTabBar* tab_bar, const char* label)
    void igDebugNodeTable(ImGuiTable* table)
    void igDebugNodeTableSettings(ImGuiTableSettings* settings)
    void igDebugNodeViewport(ImGuiViewportP* viewport)
    void igDebugNodeWindow(ImGuiWindow* window, const char* label)
    void igDebugNodeWindowSettings(ImGuiWindowSettings* settings)
    void igDebugNodeWindowsList(ImVector_ImGuiWindowPtr* windows, const char* label)
    void igDebugNodeWindowsListByBeginStackParent(ImGuiWindow** windows, int windows_size, ImGuiWindow* parent_in_begin_stack)
    void igDebugRenderKeyboardPreview(ImDrawList* draw_list)
    void igDebugRenderViewportThumbnail(ImDrawList* draw_list, ImGuiViewportP* viewport, const ImRect bb)
    void igDebugStartItemPicker()
    void igDebugTextEncoding(const char* text)
    void igDestroyContext(ImGuiContext* ctx)
    void igDestroyPlatformWindow(ImGuiViewportP* viewport)
    void igDestroyPlatformWindows()
    void igDockBuilderCopyDockSpace(ImGuiID src_dockspace_id, ImGuiID dst_dockspace_id, ImVector_const_charPtr* in_window_remap_pairs)
    void igDockBuilderCopyNode(ImGuiID src_node_id, ImGuiID dst_node_id, ImVector_ImGuiID* out_node_remap_pairs)
    void igDockBuilderCopyWindowSettings(const char* src_name, const char* dst_name)
    void igDockBuilderDockWindow(const char* window_name, ImGuiID node_id)
    void igDockBuilderFinish(ImGuiID node_id)
    void igDockBuilderRemoveNode(ImGuiID node_id)
    void igDockBuilderRemoveNodeChildNodes(ImGuiID node_id)
    void igDockBuilderRemoveNodeDockedWindows(ImGuiID node_id, bool clear_settings_refs)
    void igDockBuilderSetNodePos(ImGuiID node_id, ImVec2 pos)
    void igDockBuilderSetNodeSize(ImGuiID node_id, ImVec2 size)
    void igDockContextClearNodes(ImGuiContext* ctx, ImGuiID root_id, bool clear_settings_refs)
    void igDockContextEndFrame(ImGuiContext* ctx)
    void igDockContextInitialize(ImGuiContext* ctx)
    void igDockContextNewFrameUpdateDocking(ImGuiContext* ctx)
    void igDockContextNewFrameUpdateUndocking(ImGuiContext* ctx)
    void igDockContextProcessUndockNode(ImGuiContext* ctx, ImGuiDockNode* node)
    void igDockContextProcessUndockWindow(ImGuiContext* ctx, ImGuiWindow* window, bool clear_persistent_docking_ref)
    void igDockContextQueueDock(ImGuiContext* ctx, ImGuiWindow* target, ImGuiDockNode* target_node, ImGuiWindow* payload, ImGuiDir split_dir, float split_ratio, bool split_outer)
    void igDockContextQueueUndockNode(ImGuiContext* ctx, ImGuiDockNode* node)
    void igDockContextQueueUndockWindow(ImGuiContext* ctx, ImGuiWindow* window)
    void igDockContextRebuildNodes(ImGuiContext* ctx)
    void igDockContextShutdown(ImGuiContext* ctx)
    void igDockNodeEndAmendTabBar()
    void igDummy(const ImVec2 size)
    void igEnd()
    void igEndChild()
    void igEndChildFrame()
    void igEndColumns()
    void igEndCombo()
    void igEndComboPreview()
    void igEndDisabled()
    void igEndDragDropSource()
    void igEndDragDropTarget()
    void igEndFrame()
    void igEndGroup()
    void igEndListBox()
    void igEndMainMenuBar()
    void igEndMenu()
    void igEndMenuBar()
    void igEndPopup()
    void igEndTabBar()
    void igEndTabItem()
    void igEndTable()
    void igEndTooltip()
    void igErrorCheckEndFrameRecover(ImGuiErrorLogCallback log_callback, void* user_data)
    void igErrorCheckEndWindowRecover(ImGuiErrorLogCallback log_callback, void* user_data)
    void igErrorCheckUsingSetCursorPosToExtendParentBoundaries()
    void igFindBestWindowPosForPopup(ImVec2 *pOut, ImGuiWindow* window)
    void igFindBestWindowPosForPopupEx(ImVec2 *pOut, const ImVec2 ref_pos, const ImVec2 size, ImGuiDir* last_dir, const ImRect r_outer, const ImRect r_avoid, ImGuiPopupPositionPolicy policy)
    void igFocusTopMostWindowUnderOne(ImGuiWindow* under_this_window, ImGuiWindow* ignore_window)
    void igFocusWindow(ImGuiWindow* window)
    void igGcAwakeTransientWindowBuffers(ImGuiWindow* window)
    void igGcCompactTransientMiscBuffers()
    void igGcCompactTransientWindowBuffers(ImGuiWindow* window)
    void igGetAllocatorFunctions(ImGuiMemAllocFunc* p_alloc_func, ImGuiMemFreeFunc* p_free_func, void** p_user_data)
    void igGetContentRegionAvail(ImVec2 *pOut)
    void igGetContentRegionMax(ImVec2 *pOut)
    void igGetContentRegionMaxAbs(ImVec2 *pOut)
    void igGetCursorPos(ImVec2 *pOut)
    void igGetCursorScreenPos(ImVec2 *pOut)
    void igGetCursorStartPos(ImVec2 *pOut)
    void igGetFontTexUvWhitePixel(ImVec2 *pOut)
    void igGetItemRectMax(ImVec2 *pOut)
    void igGetItemRectMin(ImVec2 *pOut)
    void igGetItemRectSize(ImVec2 *pOut)
    void igGetKeyChordName(ImGuiKeyChord key_chord, char* out_buf, int out_buf_size)
    void igGetKeyMagnitude2d(ImVec2 *pOut, ImGuiKey key_left, ImGuiKey key_right, ImGuiKey key_up, ImGuiKey key_down)
    void igGetMouseDragDelta(ImVec2 *pOut, ImGuiMouseButton button, float lock_threshold)
    void igGetMousePos(ImVec2 *pOut)
    void igGetMousePosOnOpeningCurrentPopup(ImVec2 *pOut)
    void igGetPopupAllowedExtentRect(ImRect *pOut, ImGuiWindow* window)
    void igGetTypematicRepeatRate(ImGuiInputFlags flags, float* repeat_delay, float* repeat_rate)
    void igGetWindowContentRegionMax(ImVec2 *pOut)
    void igGetWindowContentRegionMin(ImVec2 *pOut)
    void igGetWindowPos(ImVec2 *pOut)
    void igGetWindowScrollbarRect(ImRect *pOut, ImGuiWindow* window, ImGuiAxis axis)
    void igGetWindowSize(ImVec2 *pOut)
    void igImBezierCubicCalc(ImVec2 *pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, float t)
    void igImBezierCubicClosestPoint(ImVec2 *pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, const ImVec2 p, int num_segments)
    void igImBezierCubicClosestPointCasteljau(ImVec2 *pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, const ImVec2 p, float tess_tol)
    void igImBezierQuadraticCalc(ImVec2 *pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, float t)
    void igImBitArrayClearAllBits(ImU32* arr, int bitcount)
    void igImBitArrayClearBit(ImU32* arr, int n)
    void igImBitArraySetBit(ImU32* arr, int n)
    void igImBitArraySetBitRange(ImU32* arr, int n, int n2)
    void igImClamp(ImVec2 *pOut, const ImVec2 v, const ImVec2 mn, ImVec2 mx)
    void igImFloorSigned_Vec2(ImVec2 *pOut, const ImVec2 v)
    void igImFloor_Vec2(ImVec2 *pOut, const ImVec2 v)
    void igImFontAtlasBuildFinish(ImFontAtlas* atlas)
    void igImFontAtlasBuildInit(ImFontAtlas* atlas)
    void igImFontAtlasBuildMultiplyCalcLookupTable(unsigned char out_table, float in_multiply_factor)
    void igImFontAtlasBuildMultiplyRectAlpha8(const unsigned char table, unsigned char* pixels, int x, int y, int w, int h, int stride)
    void igImFontAtlasBuildPackCustomRects(ImFontAtlas* atlas, void* stbrp_context_opaque)
    void igImFontAtlasBuildRender32bppRectFromString(ImFontAtlas* atlas, int x, int y, int w, int h, const char* in_str, char in_marker_char, unsigned int in_marker_pixel_value)
    void igImFontAtlasBuildRender8bppRectFromString(ImFontAtlas* atlas, int x, int y, int w, int h, const char* in_str, char in_marker_char, unsigned char in_marker_pixel_value)
    void igImFontAtlasBuildSetupFont(ImFontAtlas* atlas, ImFont* font, ImFontConfig* font_config, float ascent, float descent)
    void igImFormatStringToTempBuffer(const char** out_buf, const char** out_buf_end, const char* fmt)
    void igImFormatStringToTempBufferV(const char** out_buf, const char** out_buf_end, const char* fmt, char* args)
    void igImLerp_Vec2Float(ImVec2 *pOut, const ImVec2 a, const ImVec2 b, float t)
    void igImLerp_Vec2Vec2(ImVec2 *pOut, const ImVec2 a, const ImVec2 b, const ImVec2 t)
    void igImLerp_Vec4(ImVec4 *pOut, const ImVec4 a, const ImVec4 b, float t)
    void igImLineClosestPoint(ImVec2 *pOut, const ImVec2 a, const ImVec2 b, const ImVec2 p)
    void igImMax(ImVec2 *pOut, const ImVec2 lhs, const ImVec2 rhs)
    void igImMin(ImVec2 *pOut, const ImVec2 lhs, const ImVec2 rhs)
    void igImMul(ImVec2 *pOut, const ImVec2 lhs, const ImVec2 rhs)
    void igImParseFormatSanitizeForPrinting(const char* fmt_in, char* fmt_out, size_t fmt_out_size)
    void igImQsort(void* base, size_t count, size_t size_of_element, int (*compare_func)(void *, void *))
    void igImRotate(ImVec2 *pOut, const ImVec2 v, float cos_a, float sin_a)
    void igImStrTrimBlanks(char* str_)
    void igImStrncpy(char* dst, const char* src, size_t count)
    void igImTriangleBarycentricCoords(const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 p, float* out_u, float* out_v, float* out_w)
    void igImTriangleClosestPoint(ImVec2 *pOut, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 p)
    void igImage(ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec4 tint_col, const ImVec4 border_col)
    void igIndent(float indent_w)
    void igInitialize()
    void igItemSize_Rect(const ImRect bb, float text_baseline_y)
    void igItemSize_Vec2(const ImVec2 size, float text_baseline_y)
    void igKeepAliveID(ImGuiID id_)
    void igLabelText(const char* label, const char* fmt)
    void igLabelTextV(const char* label, const char* fmt, char* args)
    void igLoadIniSettingsFromDisk(const char* ini_filename)
    void igLoadIniSettingsFromMemory(const char* ini_data, size_t ini_size)
    void igLocalizeRegisterEntries(const ImGuiLocEntry* entries, int count)
    void igLogBegin(ImGuiLogType type_, int auto_open_depth)
    void igLogButtons()
    void igLogFinish()
    void igLogRenderedText(const ImVec2* ref_pos, const char* text, const char* text_end)
    void igLogSetNextTextDecoration(const char* prefix, const char* suffix)
    void igLogText(const char *fmt)
    void igLogTextV(const char* fmt, char* args)
    void igLogToBuffer(int auto_open_depth)
    void igLogToClipboard(int auto_open_depth)
    void igLogToFile(int auto_open_depth, const char* filename)
    void igLogToTTY(int auto_open_depth)
    void igMarkIniSettingsDirty_Nil()
    void igMarkIniSettingsDirty_WindowPtr(ImGuiWindow* window)
    void igMarkItemEdited(ImGuiID id_)
    void igMemFree(void* ptr)
    void igNavInitRequestApplyResult()
    void igNavInitWindow(ImGuiWindow* window, bool force_reinit)
    void igNavMoveRequestApplyResult()
    void igNavMoveRequestCancel()
    void igNavMoveRequestForward(ImGuiDir move_dir, ImGuiDir clip_dir, ImGuiNavMoveFlags move_flags, ImGuiScrollFlags scroll_flags)
    void igNavMoveRequestResolveWithLastItem(ImGuiNavItemData* result)
    void igNavMoveRequestSubmit(ImGuiDir move_dir, ImGuiDir clip_dir, ImGuiNavMoveFlags move_flags, ImGuiScrollFlags scroll_flags)
    void igNavMoveRequestTryWrapping(ImGuiWindow* window, ImGuiNavMoveFlags move_flags)
    void igNewFrame()
    void igNewLine()
    void igNextColumn()
    void igOpenPopupEx(ImGuiID id_, ImGuiPopupFlags popup_flags)
    void igOpenPopupOnItemClick(const char* str_id, ImGuiPopupFlags popup_flags)
    void igOpenPopup_ID(ImGuiID id_, ImGuiPopupFlags popup_flags)
    void igOpenPopup_Str(const char* str_id, ImGuiPopupFlags popup_flags)
    void igPlotHistogram_FloatPtr(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride)
    void igPlotHistogram_FnFloatPtr(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size)
    void igPlotLines_FloatPtr(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride)
    void igPlotLines_FnFloatPtr(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size)
    void igPopAllowKeyboardFocus()
    void igPopButtonRepeat()
    void igPopClipRect()
    void igPopColumnsBackground()
    void igPopFocusScope()
    void igPopFont()
    void igPopID()
    void igPopItemFlag()
    void igPopItemWidth()
    void igPopStyleColor(int count)
    void igPopStyleVar(int count)
    void igPopTextWrapPos()
    void igProgressBar(float fraction, const ImVec2 size_arg, const char* overlay)
    void igPushAllowKeyboardFocus(bool allow_keyboard_focus)
    void igPushButtonRepeat(bool repeat)
    void igPushClipRect(const ImVec2 clip_rect_min, const ImVec2 clip_rect_max, bool intersect_with_current_clip_rect)
    void igPushColumnClipRect(int column_index)
    void igPushColumnsBackground()
    void igPushFocusScope(ImGuiID id_)
    void igPushFont(ImFont* font)
    void igPushID_Int(int int_id)
    void igPushID_Ptr(const void* ptr_id)
    void igPushID_Str(const char* str_id)
    void igPushID_StrStr(const char* str_id_begin, const char* str_id_end)
    void igPushItemFlag(ImGuiItemFlags option, bool enabled)
    void igPushItemWidth(float item_width)
    void igPushMultiItemsWidths(int components, float width_full)
    void igPushOverrideID(ImGuiID id_)
    void igPushStyleColor_U32(ImGuiCol idx, ImU32 col)
    void igPushStyleColor_Vec4(ImGuiCol idx, const ImVec4 col)
    void igPushStyleVar_Float(ImGuiStyleVar idx, float val)
    void igPushStyleVar_Vec2(ImGuiStyleVar idx, const ImVec2 val)
    void igPushTextWrapPos(float wrap_local_pos_x)
    void igRemoveContextHook(ImGuiContext* context, ImGuiID hook_to_remove)
    void igRemoveSettingsHandler(const char* type_name)
    void igRender()
    void igRenderArrow(ImDrawList* draw_list, ImVec2 pos, ImU32 col, ImGuiDir dir_, float scale)
    void igRenderArrowDockMenu(ImDrawList* draw_list, ImVec2 p_min, float sz, ImU32 col)
    void igRenderArrowPointingAt(ImDrawList* draw_list, ImVec2 pos, ImVec2 half_sz, ImGuiDir direction, ImU32 col)
    void igRenderBullet(ImDrawList* draw_list, ImVec2 pos, ImU32 col)
    void igRenderCheckMark(ImDrawList* draw_list, ImVec2 pos, ImU32 col, float sz)
    void igRenderColorRectWithAlphaCheckerboard(ImDrawList* draw_list, ImVec2 p_min, ImVec2 p_max, ImU32 fill_col, float grid_step, ImVec2 grid_off, float rounding, ImDrawFlags flags)
    void igRenderDragDropTargetRect(const ImRect bb)
    void igRenderFrame(ImVec2 p_min, ImVec2 p_max, ImU32 fill_col, bool border, float rounding)
    void igRenderFrameBorder(ImVec2 p_min, ImVec2 p_max, float rounding)
    void igRenderMouseCursor(ImVec2 pos, float scale, ImGuiMouseCursor mouse_cursor, ImU32 col_fill, ImU32 col_border, ImU32 col_shadow)
    void igRenderNavHighlight(const ImRect bb, ImGuiID id_, ImGuiNavHighlightFlags flags)
    void igRenderPlatformWindowsDefault(void* platform_render_arg, void* renderer_render_arg)
    void igRenderRectFilledRangeH(ImDrawList* draw_list, const ImRect rect, ImU32 col, float x_start_norm, float x_end_norm, float rounding)
    void igRenderRectFilledWithHole(ImDrawList* draw_list, const ImRect outer, const ImRect inner, ImU32 col, float rounding)
    void igRenderText(ImVec2 pos, const char* text, const char* text_end, bool hide_text_after_hash)
    void igRenderTextClipped(const ImVec2 pos_min, const ImVec2 pos_max, const char* text, const char* text_end, const ImVec2* text_size_if_known, const ImVec2 align, const ImRect* clip_rect)
    void igRenderTextClippedEx(ImDrawList* draw_list, const ImVec2 pos_min, const ImVec2 pos_max, const char* text, const char* text_end, const ImVec2* text_size_if_known, const ImVec2 align, const ImRect* clip_rect)
    void igRenderTextEllipsis(ImDrawList* draw_list, const ImVec2 pos_min, const ImVec2 pos_max, float clip_max_x, float ellipsis_max_x, const char* text, const char* text_end, const ImVec2* text_size_if_known)
    void igRenderTextWrapped(ImVec2 pos, const char* text, const char* text_end, float wrap_width)
    void igResetMouseDragDelta(ImGuiMouseButton button)
    void igSameLine(float offset_from_start_x, float spacing)
    void igSaveIniSettingsToDisk(const char* ini_filename)
    void igScaleWindowsInViewport(ImGuiViewportP* viewport, float scale)
    void igScrollToBringRectIntoView(ImGuiWindow* window, const ImRect rect)
    void igScrollToItem(ImGuiScrollFlags flags)
    void igScrollToRect(ImGuiWindow* window, const ImRect rect, ImGuiScrollFlags flags)
    void igScrollToRectEx(ImVec2 *pOut, ImGuiWindow* window, const ImRect rect, ImGuiScrollFlags flags)
    void igScrollbar(ImGuiAxis axis)
    void igSeparator()
    void igSeparatorEx(ImGuiSeparatorFlags flags)
    void igSeparatorText(const char* label)
    void igSeparatorTextEx(ImGuiID id_, const char* label, const char* label_end, float extra_width)
    void igSetActiveID(ImGuiID id_, ImGuiWindow* window)
    void igSetActiveIdUsingAllKeyboardKeys()
    void igSetAllocatorFunctions(ImGuiMemAllocFunc alloc_func, ImGuiMemFreeFunc free_func, void* user_data)
    void igSetClipboardText(const char* text)
    void igSetColorEditOptions(ImGuiColorEditFlags flags)
    void igSetColumnOffset(int column_index, float offset_x)
    void igSetColumnWidth(int column_index, float width)
    void igSetCurrentContext(ImGuiContext* ctx)
    void igSetCurrentFont(ImFont* font)
    void igSetCurrentViewport(ImGuiWindow* window, ImGuiViewportP* viewport)
    void igSetCursorPos(const ImVec2 local_pos)
    void igSetCursorPosX(float local_x)
    void igSetCursorPosY(float local_y)
    void igSetCursorScreenPos(const ImVec2 pos)
    void igSetFocusID(ImGuiID id_, ImGuiWindow* window)
    void igSetHoveredID(ImGuiID id_)
    void igSetItemAllowOverlap()
    void igSetItemDefaultFocus()
    void igSetItemKeyOwner(ImGuiKey key, ImGuiInputFlags flags)
    void igSetKeyOwner(ImGuiKey key, ImGuiID owner_id, ImGuiInputFlags flags)
    void igSetKeyboardFocusHere(int offset)
    void igSetLastItemData(ImGuiID item_id, ImGuiItemFlags in_flags, ImGuiItemStatusFlags status_flags, const ImRect item_rect)
    void igSetMouseCursor(ImGuiMouseCursor cursor_type)
    void igSetNavID(ImGuiID id_, ImGuiNavLayer nav_layer, ImGuiID focus_scope_id, const ImRect rect_rel)
    void igSetNavWindow(ImGuiWindow* window)
    void igSetNextFrameWantCaptureKeyboard(bool want_capture_keyboard)
    void igSetNextFrameWantCaptureMouse(bool want_capture_mouse)
    void igSetNextItemOpen(bool is_open, ImGuiCond cond)
    void igSetNextItemWidth(float item_width)
    void igSetNextWindowBgAlpha(float alpha)
    void igSetNextWindowClass(const ImGuiWindowClass* window_class)
    void igSetNextWindowCollapsed(bool collapsed, ImGuiCond cond)
    void igSetNextWindowContentSize(const ImVec2 size)
    void igSetNextWindowDockID(ImGuiID dock_id, ImGuiCond cond)
    void igSetNextWindowFocus()
    void igSetNextWindowPos(const ImVec2 pos, ImGuiCond cond, const ImVec2 pivot)
    void igSetNextWindowScroll(const ImVec2 scroll)
    void igSetNextWindowSize(const ImVec2 size, ImGuiCond cond)
    void igSetNextWindowSizeConstraints(const ImVec2 size_min, const ImVec2 size_max, ImGuiSizeCallback custom_callback, void* custom_callback_data)
    void igSetNextWindowViewport(ImGuiID viewport_id)
    void igSetScrollFromPosX_Float(float local_x, float center_x_ratio)
    void igSetScrollFromPosX_WindowPtr(ImGuiWindow* window, float local_x, float center_x_ratio)
    void igSetScrollFromPosY_Float(float local_y, float center_y_ratio)
    void igSetScrollFromPosY_WindowPtr(ImGuiWindow* window, float local_y, float center_y_ratio)
    void igSetScrollHereX(float center_x_ratio)
    void igSetScrollHereY(float center_y_ratio)
    void igSetScrollX_Float(float scroll_x)
    void igSetScrollX_WindowPtr(ImGuiWindow* window, float scroll_x)
    void igSetScrollY_Float(float scroll_y)
    void igSetScrollY_WindowPtr(ImGuiWindow* window, float scroll_y)
    void igSetStateStorage(ImGuiStorage* storage)
    void igSetTabItemClosed(const char* tab_or_docked_window_label)
    void igSetTooltip(const char* fmt)
    void igSetTooltipV(const char* fmt, char* args)
    void igSetWindowClipRectBeforeSetChannel(ImGuiWindow* window, const ImRect clip_rect)
    void igSetWindowCollapsed_Bool(bool collapsed, ImGuiCond cond)
    void igSetWindowCollapsed_Str(const char* name, bool collapsed, ImGuiCond cond)
    void igSetWindowCollapsed_WindowPtr(ImGuiWindow* window, bool collapsed, ImGuiCond cond)
    void igSetWindowDock(ImGuiWindow* window, ImGuiID dock_id, ImGuiCond cond)
    void igSetWindowFocus_Nil()
    void igSetWindowFocus_Str(const char* name)
    void igSetWindowFontScale(float scale)
    void igSetWindowHitTestHole(ImGuiWindow* window, const ImVec2 pos, const ImVec2 size)
    void igSetWindowPos_Str(const char* name, const ImVec2 pos, ImGuiCond cond)
    void igSetWindowPos_Vec2(const ImVec2 pos, ImGuiCond cond)
    void igSetWindowPos_WindowPtr(ImGuiWindow* window, const ImVec2 pos, ImGuiCond cond)
    void igSetWindowSize_Str(const char* name, const ImVec2 size, ImGuiCond cond)
    void igSetWindowSize_Vec2(const ImVec2 size, ImGuiCond cond)
    void igSetWindowSize_WindowPtr(ImGuiWindow* window, const ImVec2 size, ImGuiCond cond)
    void igSetWindowViewport(ImGuiWindow* window, ImGuiViewportP* viewport)
    void igShadeVertsLinearColorGradientKeepAlpha(ImDrawList* draw_list, int vert_start_idx, int vert_end_idx, ImVec2 gradient_p0, ImVec2 gradient_p1, ImU32 col0, ImU32 col1)
    void igShadeVertsLinearUV(ImDrawList* draw_list, int vert_start_idx, int vert_end_idx, const ImVec2 a, const ImVec2 b, const ImVec2 uv_a, const ImVec2 uv_b, bool clamp)
    void igShowAboutWindow(bool* p_open)
    void igShowDebugLogWindow(bool* p_open)
    void igShowDemoWindow(bool* p_open)
    void igShowFontAtlas(ImFontAtlas* atlas)
    void igShowFontSelector(const char* label)
    void igShowMetricsWindow(bool* p_open)
    void igShowStackToolWindow(bool* p_open)
    void igShowStyleEditor(ImGuiStyle* ref)
    void igShowUserGuide()
    void igShrinkWidths(ImGuiShrinkWidthItem* items, int count, float width_excess)
    void igShutdown()
    void igSpacing()
    void igStartMouseMovingWindow(ImGuiWindow* window)
    void igStartMouseMovingWindowOrNode(ImGuiWindow* window, ImGuiDockNode* node, bool undock_floating_node)
    void igStyleColorsClassic(ImGuiStyle* dst)
    void igStyleColorsDark(ImGuiStyle* dst)
    void igStyleColorsLight(ImGuiStyle* dst)
    void igTabBarAddTab(ImGuiTabBar* tab_bar, ImGuiTabItemFlags tab_flags, ImGuiWindow* window)
    void igTabBarCloseTab(ImGuiTabBar* tab_bar, ImGuiTabItem* tab)
    void igTabBarQueueFocus(ImGuiTabBar* tab_bar, ImGuiTabItem* tab)
    void igTabBarQueueReorder(ImGuiTabBar* tab_bar, ImGuiTabItem* tab, int offset)
    void igTabBarQueueReorderFromMousePos(ImGuiTabBar* tab_bar, ImGuiTabItem* tab, ImVec2 mouse_pos)
    void igTabBarRemoveTab(ImGuiTabBar* tab_bar, ImGuiID tab_id)
    void igTabItemBackground(ImDrawList* draw_list, const ImRect bb, ImGuiTabItemFlags flags, ImU32 col)
    void igTabItemCalcSize_Str(ImVec2 *pOut, const char* label, bool has_close_button_or_unsaved_marker)
    void igTabItemCalcSize_WindowPtr(ImVec2 *pOut, ImGuiWindow* window)
    void igTabItemLabelAndCloseButton(ImDrawList* draw_list, const ImRect bb, ImGuiTabItemFlags flags, ImVec2 frame_padding, const char* label, ImGuiID tab_id, ImGuiID close_button_id, bool is_contents_visible, bool* out_just_closed, bool* out_text_clipped)
    void igTableBeginApplyRequests(ImGuiTable* table)
    void igTableBeginCell(ImGuiTable* table, int column_n)
    void igTableBeginInitMemory(ImGuiTable* table, int columns_count)
    void igTableBeginRow(ImGuiTable* table)
    void igTableDrawBorders(ImGuiTable* table)
    void igTableDrawContextMenu(ImGuiTable* table)
    void igTableEndCell(ImGuiTable* table)
    void igTableEndRow(ImGuiTable* table)
    void igTableFixColumnSortDirection(ImGuiTable* table, ImGuiTableColumn* column)
    void igTableGcCompactSettings()
    void igTableGcCompactTransientBuffers_TablePtr(ImGuiTable* table)
    void igTableGcCompactTransientBuffers_TableTempDataPtr(ImGuiTableTempData* table)
    void igTableGetCellBgRect(ImRect *pOut, const ImGuiTable* table, int column_n)
    void igTableHeader(const char* label)
    void igTableHeadersRow()
    void igTableLoadSettings(ImGuiTable* table)
    void igTableMergeDrawChannels(ImGuiTable* table)
    void igTableNextRow(ImGuiTableRowFlags row_flags, float min_row_height)
    void igTableOpenContextMenu(int column_n)
    void igTablePopBackgroundChannel()
    void igTablePushBackgroundChannel()
    void igTableRemove(ImGuiTable* table)
    void igTableResetSettings(ImGuiTable* table)
    void igTableSaveSettings(ImGuiTable* table)
    void igTableSetBgColor(ImGuiTableBgTarget target, ImU32 color, int column_n)
    void igTableSetColumnEnabled(int column_n, bool v)
    void igTableSetColumnSortDirection(int column_n, ImGuiSortDirection sort_direction, bool append_to_sort_specs)
    void igTableSetColumnWidth(int column_n, float width)
    void igTableSetColumnWidthAutoAll(ImGuiTable* table)
    void igTableSetColumnWidthAutoSingle(ImGuiTable* table, int column_n)
    void igTableSettingsAddSettingsHandler()
    void igTableSetupColumn(const char* label, ImGuiTableColumnFlags flags, float init_width_or_weight, ImGuiID user_id)
    void igTableSetupDrawChannels(ImGuiTable* table)
    void igTableSetupScrollFreeze(int cols, int rows)
    void igTableSortSpecsBuild(ImGuiTable* table)
    void igTableSortSpecsSanitize(ImGuiTable* table)
    void igTableUpdateBorders(ImGuiTable* table)
    void igTableUpdateColumnsWeightFromWidth(ImGuiTable* table)
    void igTableUpdateLayout(ImGuiTable* table)
    void igText(const char* fmt)
    void igTextColored(const ImVec4 col, const char* fmt)
    void igTextColoredV(const ImVec4 col, const char* fmt, char* args)
    void igTextDisabled(const char* fmt)
    void igTextDisabledV(const char* fmt, char* args)
    void igTextEx(const char* text, const char* text_end, ImGuiTextFlags flags)
    void igTextUnformatted(const char* text, const char* text_end)
    void igTextV(const char* fmt, char* args)
    void igTextWrapped(const char* fmt)
    void igTextWrappedV(const char* fmt, char* args)
    void igTranslateWindowsInViewport(ImGuiViewportP* viewport, const ImVec2 old_pos, const ImVec2 new_pos)
    void igTreeNodeSetOpen(ImGuiID id_, bool open_)
    void igTreePop()
    void igTreePushOverrideID(ImGuiID id_)
    void igTreePush_Ptr(const void* ptr_id)
    void igTreePush_Str(const char* str_id)
    void igUnindent(float indent_w)
    void igUpdateHoveredWindowAndCaptureFlags()
    void igUpdateInputEvents(bool trickle_fast_inputs)
    void igUpdateMouseMovingWindowEndFrame()
    void igUpdateMouseMovingWindowNewFrame()
    void igUpdatePlatformWindows()
    void igUpdateWindowParentAndRootLinks(ImGuiWindow* window, ImGuiWindowFlags flags, ImGuiWindow* parent_window)
    void igValue_Bool(const char* prefix, bool b)
    void igValue_Float(const char* prefix, float v, const char* float_format)
    void igValue_Int(const char* prefix, int v)
    void igValue_Uint(const char* prefix, unsigned int v)
    void igWindowRectAbsToRel(ImRect *pOut, ImGuiWindow* window, const ImRect r)
    void igWindowRectRelToAbs(ImRect *pOut, ImGuiWindow* window, const ImRect r)
    void* ImGuiStorage_GetVoidPtr(ImGuiStorage* self, ImGuiID key)
    void* igImFileLoadToMemory(const char* filename, const char* mode, size_t* out_file_size, int padding_bytes)
    void* igMemAlloc(size_t size)
    void** ImGuiStorage_GetVoidPtrRef(ImGuiStorage* self, ImGuiID key, void* default_val)
