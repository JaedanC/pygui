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
        float X0
        float Y0
        float X1
        float Y1
        float U0
        float V0
        float U1
        float V1

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
        float PosX
        float PosY

    ctypedef struct ImGuiInputEventMouseViewport:
        ImGuiID HoveredViewportID

    ctypedef struct ImGuiInputEventMouseWheel:
        float WheelX
        float WheelY

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
        float x
        float y

    ctypedef struct ImVec2ih:
        short x
        short y

    ctypedef struct ImVec4:
        float x
        float y
        float z
        float w

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
        float x0
        float x1
        float baseline_y_delta
        float ymin
        float ymax
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
        float Ascent
        float Descent
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
        void (*Platform_SetWindowTitle)(ImGuiViewport* vp, const char* str_)
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
        ImVec2 MainPos
        ImVec2 MainSize
        ImVec2 WorkPos
        ImVec2 WorkSize
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
        short undo_point
        short redo_point
        int undo_char_point
        int redo_char_point

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
        float OffMinX
        float OffMaxX
        float LineMinY
        float LineMaxY
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
        unsigned char padding1
        unsigned char padding2
        unsigned char padding3
        float preferred_x
        StbUndoState undostate

    ctypedef struct ImGuiInputTextState:
        ImGuiContext* Ctx
        ImGuiID ID
        int CurLenW
        int CurLenA
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
        ImGuiWindowFlags Flags
        ImGuiWindowFlags FlagsPreviousFrame
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
        float DecoOuterSizeX1
        float DecoOuterSizeY1
        float DecoOuterSizeX2
        float DecoOuterSizeY2
        float DecoInnerSizeX1
        float DecoInnerSizeY1
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
        bool ScrollbarX
        bool ScrollbarY
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
        ImS8 AutoFitFramesX
        ImS8 AutoFitFramesY
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

    ImColor* ImColor_ImColor_Float(float r, float g, float b, float a) except +
    ImColor* ImColor_ImColor_Int(int r, int g, int b, int a) except +
    ImColor* ImColor_ImColor_Nil() except +
    ImColor* ImColor_ImColor_U32(ImU32 rgba) except +
    ImColor* ImColor_ImColor_Vec4(const ImVec4 col) except +
    ImDrawCmd* ImDrawCmd_ImDrawCmd() except +
    ImDrawData* ImDrawData_ImDrawData() except +
    ImDrawData* igGetDrawData() except +
    ImDrawFlags igCalcRoundingFlagsForRectInRect(const ImRect r_in, const ImRect r_outer, float threshold) except +
    ImDrawList* ImDrawList_CloneOutput(ImDrawList* self) except +
    ImDrawList* ImDrawList_ImDrawList(ImDrawListSharedData* shared_data) except +
    ImDrawList* igGetBackgroundDrawList_Nil() except +
    ImDrawList* igGetBackgroundDrawList_ViewportPtr(ImGuiViewport* viewport) except +
    ImDrawList* igGetForegroundDrawList_Nil() except +
    ImDrawList* igGetForegroundDrawList_ViewportPtr(ImGuiViewport* viewport) except +
    ImDrawList* igGetForegroundDrawList_WindowPtr(ImGuiWindow* window) except +
    ImDrawList* igGetWindowDrawList() except +
    ImDrawListSharedData* ImDrawListSharedData_ImDrawListSharedData() except +
    ImDrawListSharedData* igGetDrawListSharedData() except +
    ImDrawListSplitter* ImDrawListSplitter_ImDrawListSplitter() except +
    ImFileHandle igImFileOpen(const char* filename, const char* mode) except +
    ImFont* ImFontAtlas_AddFont(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontDefault(ImFontAtlas* self, const ImFontConfig* font_cfg) except +
    ImFont* ImFontAtlas_AddFontFromFileTTF(ImFontAtlas* self, const char* filename, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas* self, const char* compressed_font_data_base85, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas* self, const void* compressed_font_data, int compressed_font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas* self, void* font_data, int font_size, float size_pixels, const ImFontConfig* font_cfg, const ImWchar* glyph_ranges) except +
    ImFont* ImFont_ImFont() except +
    ImFont* igGetDefaultFont() except +
    ImFont* igGetFont() except +
    ImFontAtlas* ImFontAtlas_ImFontAtlas() except +
    ImFontAtlasCustomRect* ImFontAtlasCustomRect_ImFontAtlasCustomRect() except +
    ImFontAtlasCustomRect* ImFontAtlas_GetCustomRectByIndex(ImFontAtlas* self, int index) except +
    ImFontConfig* ImFontConfig_ImFontConfig() except +
    ImFontGlyphRangesBuilder* ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder() except +
    ImGuiComboPreviewData* ImGuiComboPreviewData_ImGuiComboPreviewData() except +
    ImGuiContext* ImGuiContext_ImGuiContext(ImFontAtlas* shared_font_atlas) except +
    ImGuiContext* igCreateContext(ImFontAtlas* shared_font_atlas) except +
    ImGuiContext* igGetCurrentContext() except +
    ImGuiContextHook* ImGuiContextHook_ImGuiContextHook() except +
    ImGuiDir igImGetDirQuadrantFromDelta(float dx, float dy) except +
    ImGuiDockContext* ImGuiDockContext_ImGuiDockContext() except +
    ImGuiDockNode* ImGuiDockNode_ImGuiDockNode(ImGuiID id_) except +
    ImGuiDockNode* igDockBuilderGetCentralNode(ImGuiID node_id) except +
    ImGuiDockNode* igDockBuilderGetNode(ImGuiID node_id) except +
    ImGuiDockNode* igDockContextFindNodeByID(ImGuiContext* ctx, ImGuiID id_) except +
    ImGuiDockNode* igDockNodeGetRootNode(ImGuiDockNode* node) except +
    ImGuiDockNode* igGetWindowDockNode() except +
    ImGuiID ImGuiWindow_GetIDFromRectangle(ImGuiWindow* self, const ImRect r_abs) except +
    ImGuiID ImGuiWindow_GetID_Int(ImGuiWindow* self, int n) except +
    ImGuiID ImGuiWindow_GetID_Ptr(ImGuiWindow* self, const void* ptr) except +
    ImGuiID ImGuiWindow_GetID_Str(ImGuiWindow* self, const char* str_, const char* str_end) except +
    ImGuiID igAddContextHook(ImGuiContext* context, const ImGuiContextHook* hook) except +
    ImGuiID igDockBuilderAddNode(ImGuiID node_id, ImGuiDockNodeFlags flags) except +
    ImGuiID igDockBuilderSplitNode(ImGuiID node_id, ImGuiDir split_dir, float size_ratio_for_node_at_dir, ImGuiID* out_id_at_dir, ImGuiID* out_id_at_opposite_dir) except +
    ImGuiID igDockContextGenNodeID(ImGuiContext* ctx) except +
    ImGuiID igDockNodeGetWindowMenuButtonId(const ImGuiDockNode* node) except +
    ImGuiID igDockSpace(ImGuiID id_, const ImVec2 size, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +
    ImGuiID igDockSpaceOverViewport(const ImGuiViewport* viewport, ImGuiDockNodeFlags flags, const ImGuiWindowClass* window_class) except +
    ImGuiID igGetActiveID() except +
    ImGuiID igGetColumnsID(const char* str_id, int count) except +
    ImGuiID igGetCurrentFocusScope() except +
    ImGuiID igGetFocusID() except +
    ImGuiID igGetHoveredID() except +
    ImGuiID igGetIDWithSeed_Int(int n, ImGuiID seed) except +
    ImGuiID igGetIDWithSeed_Str(const char* str_id_begin, const char* str_id_end, ImGuiID seed) except +
    ImGuiID igGetID_Ptr(const void* ptr_id) except +
    ImGuiID igGetID_Str(const char* str_id) except +
    ImGuiID igGetID_StrStr(const char* str_id_begin, const char* str_id_end) except +
    ImGuiID igGetItemID() except +
    ImGuiID igGetKeyOwner(ImGuiKey key) except +
    ImGuiID igGetWindowDockID() except +
    ImGuiID igGetWindowResizeBorderID(ImGuiWindow* window, ImGuiDir dir_) except +
    ImGuiID igGetWindowResizeCornerID(ImGuiWindow* window, int n) except +
    ImGuiID igGetWindowScrollbarID(ImGuiWindow* window, ImGuiAxis axis) except +
    ImGuiID igImHashData(const void* data, size_t data_size, ImGuiID seed) except +
    ImGuiID igImHashStr(const char* data, size_t data_size, ImGuiID seed) except +
    ImGuiID igTableGetColumnResizeID(ImGuiTable* table, int column_n, int instance_no) except +
    ImGuiID igTableGetInstanceID(ImGuiTable* table, int instance_no) except +
    ImGuiIO* ImGuiIO_ImGuiIO() except +
    ImGuiIO* igGetIO() except +
    ImGuiInputEvent* ImGuiInputEvent_ImGuiInputEvent() except +
    ImGuiInputTextCallbackData* ImGuiInputTextCallbackData_ImGuiInputTextCallbackData() except +
    ImGuiInputTextState* ImGuiInputTextState_ImGuiInputTextState(ImGuiContext* ctx) except +
    ImGuiInputTextState* igGetInputTextState(ImGuiID id_) except +
    ImGuiItemFlags igGetItemFlags() except +
    ImGuiItemStatusFlags igGetItemStatusFlags() except +
    ImGuiKey igConvertSingleModFlagToKey(ImGuiKey key) except +
    ImGuiKey igGetKeyIndex(ImGuiKey key) except +
    ImGuiKey igMouseButtonToKey(ImGuiMouseButton button) except +
    ImGuiKeyChord igConvertShortcutMod(ImGuiKeyChord key_chord) except +
    ImGuiKeyData* igGetKeyData(ImGuiKey key) except +
    ImGuiKeyOwnerData* ImGuiKeyOwnerData_ImGuiKeyOwnerData() except +
    ImGuiKeyOwnerData* igGetKeyOwnerData(ImGuiKey key) except +
    ImGuiKeyRoutingData* ImGuiKeyRoutingData_ImGuiKeyRoutingData() except +
    ImGuiKeyRoutingData* igGetShortcutRoutingData(ImGuiKeyChord key_chord) except +
    ImGuiKeyRoutingTable* ImGuiKeyRoutingTable_ImGuiKeyRoutingTable() except +
    ImGuiLastItemData* ImGuiLastItemData_ImGuiLastItemData() except +
    ImGuiListClipper* ImGuiListClipper_ImGuiListClipper() except +
    ImGuiListClipperData* ImGuiListClipperData_ImGuiListClipperData() except +
    ImGuiListClipperRange ImGuiListClipperRange_FromIndices(int min_, int max_) except +
    ImGuiListClipperRange ImGuiListClipperRange_FromPositions(float y1, float y2, int off_min, int off_max) except +
    ImGuiMenuColumns* ImGuiMenuColumns_ImGuiMenuColumns() except +
    ImGuiMouseCursor igGetMouseCursor() except +
    ImGuiNavItemData* ImGuiNavItemData_ImGuiNavItemData() except +
    ImGuiNextItemData* ImGuiNextItemData_ImGuiNextItemData() except +
    ImGuiNextWindowData* ImGuiNextWindowData_ImGuiNextWindowData() except +
    ImGuiOldColumnData* ImGuiOldColumnData_ImGuiOldColumnData() except +
    ImGuiOldColumns* ImGuiOldColumns_ImGuiOldColumns() except +
    ImGuiOldColumns* igFindOrCreateColumns(ImGuiWindow* window, ImGuiID id_) except +
    ImGuiOnceUponAFrame* ImGuiOnceUponAFrame_ImGuiOnceUponAFrame() except +
    ImGuiPayload* ImGuiPayload_ImGuiPayload() except +
    ImGuiPlatformIO* ImGuiPlatformIO_ImGuiPlatformIO() except +
    ImGuiPlatformIO* igGetPlatformIO() except +
    ImGuiPlatformImeData* ImGuiPlatformImeData_ImGuiPlatformImeData() except +
    ImGuiPlatformMonitor* ImGuiPlatformMonitor_ImGuiPlatformMonitor() except +
    ImGuiPopupData* ImGuiPopupData_ImGuiPopupData() except +
    ImGuiPtrOrIndex* ImGuiPtrOrIndex_ImGuiPtrOrIndex_Int(int index) except +
    ImGuiPtrOrIndex* ImGuiPtrOrIndex_ImGuiPtrOrIndex_Ptr(void* ptr) except +
    ImGuiSettingsHandler* ImGuiSettingsHandler_ImGuiSettingsHandler() except +
    ImGuiSettingsHandler* igFindSettingsHandler(const char* type_name) except +
    ImGuiSortDirection igTableGetColumnNextSortDirection(ImGuiTableColumn* column) except +
    ImGuiStackLevelInfo* ImGuiStackLevelInfo_ImGuiStackLevelInfo() except +
    ImGuiStackSizes* ImGuiStackSizes_ImGuiStackSizes() except +
    ImGuiStackTool* ImGuiStackTool_ImGuiStackTool() except +
    ImGuiStorage* igGetStateStorage() except +
    ImGuiStoragePair* ImGuiStoragePair_ImGuiStoragePair_Float(ImGuiID _key, float _val_f) except +
    ImGuiStoragePair* ImGuiStoragePair_ImGuiStoragePair_Int(ImGuiID _key, int _val_i) except +
    ImGuiStoragePair* ImGuiStoragePair_ImGuiStoragePair_Ptr(ImGuiID _key, void* _val_p) except +
    ImGuiStyle* ImGuiStyle_ImGuiStyle() except +
    ImGuiStyle* igGetStyle() except +
    ImGuiStyleMod* ImGuiStyleMod_ImGuiStyleMod_Float(ImGuiStyleVar idx, float v) except +
    ImGuiStyleMod* ImGuiStyleMod_ImGuiStyleMod_Int(ImGuiStyleVar idx, int v) except +
    ImGuiStyleMod* ImGuiStyleMod_ImGuiStyleMod_Vec2(ImGuiStyleVar idx, ImVec2 v) except +
    ImGuiTabBar* ImGuiTabBar_ImGuiTabBar() except +
    ImGuiTabBar* igGetCurrentTabBar() except +
    ImGuiTabItem* ImGuiTabItem_ImGuiTabItem() except +
    ImGuiTabItem* igTabBarFindMostRecentlySelectedTabForActiveWindow(ImGuiTabBar* tab_bar) except +
    ImGuiTabItem* igTabBarFindTabByID(ImGuiTabBar* tab_bar, ImGuiID tab_id) except +
    ImGuiTabItem* igTabBarFindTabByOrder(ImGuiTabBar* tab_bar, int order) except +
    ImGuiTabItem* igTabBarGetCurrentTab(ImGuiTabBar* tab_bar) except +
    ImGuiTable* ImGuiTable_ImGuiTable() except +
    ImGuiTable* igGetCurrentTable() except +
    ImGuiTable* igTableFindByID(ImGuiID id_) except +
    ImGuiTableColumn* ImGuiTableColumn_ImGuiTableColumn() except +
    ImGuiTableColumnFlags igTableGetColumnFlags(int column_n) except +
    ImGuiTableColumnSettings* ImGuiTableColumnSettings_ImGuiTableColumnSettings() except +
    ImGuiTableColumnSettings* ImGuiTableSettings_GetColumnSettings(ImGuiTableSettings* self) except +
    ImGuiTableColumnSortSpecs* ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs() except +
    ImGuiTableInstanceData* ImGuiTableInstanceData_ImGuiTableInstanceData() except +
    ImGuiTableInstanceData* igTableGetInstanceData(ImGuiTable* table, int instance_no) except +
    ImGuiTableSettings* ImGuiTableSettings_ImGuiTableSettings() except +
    ImGuiTableSettings* igTableGetBoundSettings(ImGuiTable* table) except +
    ImGuiTableSettings* igTableSettingsCreate(ImGuiID id_, int columns_count) except +
    ImGuiTableSettings* igTableSettingsFindByID(ImGuiID id_) except +
    ImGuiTableSortSpecs* ImGuiTableSortSpecs_ImGuiTableSortSpecs() except +
    ImGuiTableSortSpecs* igTableGetSortSpecs() except +
    ImGuiTableTempData* ImGuiTableTempData_ImGuiTableTempData() except +
    ImGuiTextBuffer* ImGuiTextBuffer_ImGuiTextBuffer() except +
    ImGuiTextFilter* ImGuiTextFilter_ImGuiTextFilter(const char* default_filter) except +
    ImGuiTextRange* ImGuiTextRange_ImGuiTextRange_Nil() except +
    ImGuiTextRange* ImGuiTextRange_ImGuiTextRange_Str(const char* _b, const char* _e) except +
    ImGuiViewport* ImGuiViewport_ImGuiViewport() except +
    ImGuiViewport* igFindViewportByID(ImGuiID id_) except +
    ImGuiViewport* igFindViewportByPlatformHandle(void* platform_handle) except +
    ImGuiViewport* igGetMainViewport() except +
    ImGuiViewport* igGetWindowViewport() except +
    ImGuiViewportP* ImGuiViewportP_ImGuiViewportP() except +
    ImGuiViewportP* igFindHoveredViewportFromPlatformWindowStack(const ImVec2 mouse_platform_pos) except +
    ImGuiWindow* ImGuiWindow_ImGuiWindow(ImGuiContext* context, const char* name) except +
    ImGuiWindow* igFindBottomMostVisibleWindowWithinBeginStack(ImGuiWindow* window) except +
    ImGuiWindow* igFindWindowByID(ImGuiID id_) except +
    ImGuiWindow* igFindWindowByName(const char* name) except +
    ImGuiWindow* igGetCurrentWindow() except +
    ImGuiWindow* igGetCurrentWindowRead() except +
    ImGuiWindow* igGetTopMostAndVisiblePopupModal() except +
    ImGuiWindow* igGetTopMostPopupModal() except +
    ImGuiWindowClass* ImGuiWindowClass_ImGuiWindowClass() except +
    ImGuiWindowSettings* ImGuiWindowSettings_ImGuiWindowSettings() except +
    ImGuiWindowSettings* igCreateNewWindowSettings(const char* name) except +
    ImGuiWindowSettings* igFindWindowSettingsByID(ImGuiID id_) except +
    ImGuiWindowSettings* igFindWindowSettingsByWindow(ImGuiWindow* window) except +
    ImRect* ImRect_ImRect_Float(float x1, float y1, float x2, float y2) except +
    ImRect* ImRect_ImRect_Nil() except +
    ImRect* ImRect_ImRect_Vec2(const ImVec2 min_, const ImVec2 max_) except +
    ImRect* ImRect_ImRect_Vec4(const ImVec4 v) except +
    ImTextureID ImDrawCmd_GetTexID(ImDrawCmd* self) except +
    ImU32 igColorConvertFloat4ToU32(const ImVec4 in_) except +
    ImU32 igGetColorU32_Col(ImGuiCol idx, float alpha_mul) except +
    ImU32 igGetColorU32_U32(ImU32 col) except +
    ImU32 igGetColorU32_Vec4(const ImVec4 col) except +
    ImU32 igImAlphaBlendColors(ImU32 col_a, ImU32 col_b) except +
    ImU64 igImFileGetSize(ImFileHandle file) except +
    ImU64 igImFileRead(void* data, ImU64 size, ImU64 count, ImFileHandle file) except +
    ImU64 igImFileWrite(const void* data, ImU64 size, ImU64 count, ImFileHandle file) except +
    ImVec1* ImVec1_ImVec1_Float(float _x) except +
    ImVec1* ImVec1_ImVec1_Nil() except +
    ImVec2* ImVec2_ImVec2_Float(float _x, float _y) except +
    ImVec2* ImVec2_ImVec2_Nil() except +
    ImVec2ih* ImVec2ih_ImVec2ih_Nil() except +
    ImVec2ih* ImVec2ih_ImVec2ih_Vec2(const ImVec2 rhs) except +
    ImVec2ih* ImVec2ih_ImVec2ih_short(short _x, short _y) except +
    ImVec4* ImVec4_ImVec4_Float(float _x, float _y, float _z, float _w) except +
    ImVec4* ImVec4_ImVec4_Nil() except +
    ImVector_ImWchar* ImVector_ImWchar_create() except +
    bool ImBitVector_TestBit(ImBitVector* self, int n) except +
    bool ImFontAtlasCustomRect_IsPacked(ImFontAtlasCustomRect* self) except +
    bool ImFontAtlas_Build(ImFontAtlas* self) except +
    bool ImFontAtlas_GetMouseCursorTexData(ImFontAtlas* self, ImGuiMouseCursor cursor, ImVec2* out_offset, ImVec2* out_size, ImVec2 out_uv_border, ImVec2 out_uv_fill) except +
    bool ImFontAtlas_IsBuilt(ImFontAtlas* self) except +
    bool ImFontGlyphRangesBuilder_GetBit(ImFontGlyphRangesBuilder* self, size_t n) except +
    bool ImFont_IsGlyphRangeUnused(ImFont* self, unsigned int c_begin, unsigned int c_last) except +
    bool ImFont_IsLoaded(ImFont* self) except +
    bool ImGuiDockNode_IsCentralNode(ImGuiDockNode* self) except +
    bool ImGuiDockNode_IsDockSpace(ImGuiDockNode* self) except +
    bool ImGuiDockNode_IsEmpty(ImGuiDockNode* self) except +
    bool ImGuiDockNode_IsFloatingNode(ImGuiDockNode* self) except +
    bool ImGuiDockNode_IsHiddenTabBar(ImGuiDockNode* self) except +
    bool ImGuiDockNode_IsLeafNode(ImGuiDockNode* self) except +
    bool ImGuiDockNode_IsNoTabBar(ImGuiDockNode* self) except +
    bool ImGuiDockNode_IsRootNode(ImGuiDockNode* self) except +
    bool ImGuiDockNode_IsSplitNode(ImGuiDockNode* self) except +
    bool ImGuiInputTextCallbackData_HasSelection(ImGuiInputTextCallbackData* self) except +
    bool ImGuiInputTextState_HasSelection(ImGuiInputTextState* self) except +
    bool ImGuiListClipper_Step(ImGuiListClipper* self) except +
    bool ImGuiPayload_IsDataType(ImGuiPayload* self, const char* type_) except +
    bool ImGuiPayload_IsDelivery(ImGuiPayload* self) except +
    bool ImGuiPayload_IsPreview(ImGuiPayload* self) except +
    bool ImGuiStorage_GetBool(ImGuiStorage* self, ImGuiID key, bool default_val) except +
    bool ImGuiTextBuffer_empty(ImGuiTextBuffer* self) except +
    bool ImGuiTextFilter_Draw(ImGuiTextFilter* self, const char* label, float width) except +
    bool ImGuiTextFilter_IsActive(ImGuiTextFilter* self) except +
    bool ImGuiTextFilter_PassFilter(ImGuiTextFilter* self, const char* text, const char* text_end) except +
    bool ImGuiTextRange_empty(ImGuiTextRange* self) except +
    bool ImRect_Contains_Rect(ImRect* self, const ImRect r) except +
    bool ImRect_Contains_Vec2(ImRect* self, const ImVec2 p) except +
    bool ImRect_IsInverted(ImRect* self) except +
    bool ImRect_Overlaps(ImRect* self, const ImRect r) except +
    bool igArrowButton(const char* str_id, ImGuiDir dir_) except +
    bool igArrowButtonEx(const char* str_id, ImGuiDir dir_, ImVec2 size_arg, ImGuiButtonFlags flags) except +
    bool igBegin(const char* name, bool* p_open, ImGuiWindowFlags flags) except +
    bool igBeginChildEx(const char* name, ImGuiID id_, const ImVec2 size_arg, bool border, ImGuiWindowFlags flags) except +
    bool igBeginChildFrame(ImGuiID id_, const ImVec2 size, ImGuiWindowFlags flags) except +
    bool igBeginChild_ID(ImGuiID id_, const ImVec2 size, bool border, ImGuiWindowFlags flags) except +
    bool igBeginChild_Str(const char* str_id, const ImVec2 size, bool border, ImGuiWindowFlags flags) except +
    bool igBeginCombo(const char* label, const char* preview_value, ImGuiComboFlags flags) except +
    bool igBeginComboPopup(ImGuiID popup_id, const ImRect bb, ImGuiComboFlags flags) except +
    bool igBeginComboPreview() except +
    bool igBeginDragDropSource(ImGuiDragDropFlags flags) except +
    bool igBeginDragDropTarget() except +
    bool igBeginDragDropTargetCustom(const ImRect bb, ImGuiID id_) except +
    bool igBeginListBox(const char* label, const ImVec2 size) except +
    bool igBeginMainMenuBar() except +
    bool igBeginMenu(const char* label, bool enabled) except +
    bool igBeginMenuBar() except +
    bool igBeginMenuEx(const char* label, const char* icon, bool enabled) except +
    bool igBeginPopup(const char* str_id, ImGuiWindowFlags flags) except +
    bool igBeginPopupContextItem(const char* str_id, ImGuiPopupFlags popup_flags) except +
    bool igBeginPopupContextVoid(const char* str_id, ImGuiPopupFlags popup_flags) except +
    bool igBeginPopupContextWindow(const char* str_id, ImGuiPopupFlags popup_flags) except +
    bool igBeginPopupEx(ImGuiID id_, ImGuiWindowFlags extra_flags) except +
    bool igBeginPopupModal(const char* name, bool* p_open, ImGuiWindowFlags flags) except +
    bool igBeginTabBar(const char* str_id, ImGuiTabBarFlags flags) except +
    bool igBeginTabBarEx(ImGuiTabBar* tab_bar, const ImRect bb, ImGuiTabBarFlags flags, ImGuiDockNode* dock_node) except +
    bool igBeginTabItem(const char* label, bool* p_open, ImGuiTabItemFlags flags) except +
    bool igBeginTable(const char* str_id, int column, ImGuiTableFlags flags, const ImVec2 outer_size, float inner_width) except +
    bool igBeginTableEx(const char* name, ImGuiID id_, int columns_count, ImGuiTableFlags flags, const ImVec2 outer_size, float inner_width) except +
    bool igBeginViewportSideBar(const char* name, ImGuiViewport* viewport, ImGuiDir dir_, float size, ImGuiWindowFlags window_flags) except +
    bool igButton(const char* label, const ImVec2 size) except +
    bool igButtonBehavior(const ImRect bb, ImGuiID id_, bool* out_hovered, bool* out_held, ImGuiButtonFlags flags) except +
    bool igButtonEx(const char* label, const ImVec2 size_arg, ImGuiButtonFlags flags) except +
    bool igCheckbox(const char* label, bool* v) except +
    bool igCheckboxFlags_IntPtr(const char* label, int* flags, int flags_value) except +
    bool igCheckboxFlags_S64Ptr(const char* label, ImS64* flags, ImS64 flags_value) except +
    bool igCheckboxFlags_U64Ptr(const char* label, ImU64* flags, ImU64 flags_value) except +
    bool igCheckboxFlags_UintPtr(const char* label, unsigned int* flags, unsigned int flags_value) except +
    bool igCloseButton(ImGuiID id_, const ImVec2 pos) except +
    bool igCollapseButton(ImGuiID id_, const ImVec2 pos, ImGuiDockNode* dock_node) except +
    bool igCollapsingHeader_BoolPtr(const char* label, bool* p_visible, ImGuiTreeNodeFlags flags) except +
    bool igCollapsingHeader_TreeNodeFlags(const char* label, ImGuiTreeNodeFlags flags) except +
    bool igColorButton(const char* desc_id, const ImVec4 col, ImGuiColorEditFlags flags, const ImVec2 size) except +
    bool igColorEdit3(const char* label, float col, ImGuiColorEditFlags flags) except +
    bool igColorEdit4(const char* label, float col, ImGuiColorEditFlags flags) except +
    bool igColorPicker3(const char* label, float col, ImGuiColorEditFlags flags) except +
    bool igColorPicker4(const char* label, float col, ImGuiColorEditFlags flags, const float* ref_col) except +
    bool igCombo_FnBoolPtr(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int popup_max_height_in_items) except +
    bool igCombo_Str(const char* label, int* current_item, const char* items_separated_by_zeros, int popup_max_height_in_items) except +
    bool igCombo_Str_arr(const char* label, int* current_item, char* items, int items_count, int popup_max_height_in_items) except +
    bool igDataTypeApplyFromText(const char* buf, ImGuiDataType data_type, void* p_data, const char* format_) except +
    bool igDataTypeClamp(ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max) except +
    bool igDebugCheckVersionAndDataLayout(const char* version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx) except +
    bool igDockContextCalcDropPosForDocking(ImGuiWindow* target, ImGuiDockNode* target_node, ImGuiWindow* payload_window, ImGuiDockNode* payload_node, ImGuiDir split_dir, bool split_outer, ImVec2* out_pos) except +
    bool igDockNodeBeginAmendTabBar(ImGuiDockNode* node) except +
    bool igDockNodeIsInHierarchyOf(ImGuiDockNode* node, ImGuiDockNode* parent) except +
    bool igDragBehavior(ImGuiID id_, ImGuiDataType data_type, void* p_v, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragFloat(const char* label, float* v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragFloat2(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragFloat3(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragFloat4(const char* label, float v, float v_speed, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragFloatRange2(const char* label, float* v_current_min, float* v_current_max, float v_speed, float v_min, float v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +
    bool igDragInt(const char* label, int* v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragInt2(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragInt3(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragInt4(const char* label, int v, float v_speed, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragIntRange2(const char* label, int* v_current_min, int* v_current_max, float v_speed, int v_min, int v_max, const char* format_, const char* format_max, ImGuiSliderFlags flags) except +
    bool igDragScalar(const char* label, ImGuiDataType data_type, void* p_data, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igDragScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, float v_speed, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igGetWindowAlwaysWantOwnTabBar(ImGuiWindow* window) except +
    bool igImBitArrayTestBit(const ImU32* arr, int n) except +
    bool igImCharIsBlankA(char c) except +
    bool igImCharIsBlankW(unsigned int c) except +
    bool igImFileClose(ImFileHandle file) except +
    bool igImIsFloatAboveGuaranteedIntegerPrecision(float f) except +
    bool igImIsPowerOfTwo_Int(int v) except +
    bool igImIsPowerOfTwo_U64(ImU64 v) except +
    bool igImTriangleContainsPoint(const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 p) except +
    bool igImageButton(const char* str_id, ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec4 bg_col, const ImVec4 tint_col) except +
    bool igImageButtonEx(ImGuiID id_, ImTextureID texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec4 bg_col, const ImVec4 tint_col, ImGuiButtonFlags flags) except +
    bool igInputDouble(const char* label, double* v, double step, double step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputFloat(const char* label, float* v, float step, float step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputFloat2(const char* label, float v, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputFloat3(const char* label, float v, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputFloat4(const char* label, float v, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputInt(const char* label, int* v, int step, int step_fast, ImGuiInputTextFlags flags) except +
    bool igInputInt2(const char* label, int v, ImGuiInputTextFlags flags) except +
    bool igInputInt3(const char* label, int v, ImGuiInputTextFlags flags) except +
    bool igInputInt4(const char* label, int v, ImGuiInputTextFlags flags) except +
    bool igInputScalar(const char* label, ImGuiDataType data_type, void* p_data, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_step, const void* p_step_fast, const char* format_, ImGuiInputTextFlags flags) except +
    bool igInputText(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +
    bool igInputTextEx(const char* label, const char* hint, char* buf, int buf_size, const ImVec2 size_arg, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +
    bool igInputTextMultiline(const char* label, char* buf, size_t buf_size, const ImVec2 size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +
    bool igInputTextWithHint(const char* label, const char* hint, char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, void* user_data) except +
    bool igInvisibleButton(const char* str_id, const ImVec2 size, ImGuiButtonFlags flags) except +
    bool igIsActiveIdUsingNavDir(ImGuiDir dir_) except +
    bool igIsAliasKey(ImGuiKey key) except +
    bool igIsAnyItemActive() except +
    bool igIsAnyItemFocused() except +
    bool igIsAnyItemHovered() except +
    bool igIsAnyMouseDown() except +
    bool igIsClippedEx(const ImRect bb, ImGuiID id_) except +
    bool igIsDragDropActive() except +
    bool igIsDragDropPayloadBeingAccepted() except +
    bool igIsGamepadKey(ImGuiKey key) except +
    bool igIsItemActivated() except +
    bool igIsItemActive() except +
    bool igIsItemClicked(ImGuiMouseButton mouse_button) except +
    bool igIsItemDeactivated() except +
    bool igIsItemDeactivatedAfterEdit() except +
    bool igIsItemEdited() except +
    bool igIsItemFocused() except +
    bool igIsItemHovered(ImGuiHoveredFlags flags) except +
    bool igIsItemToggledOpen() except +
    bool igIsItemToggledSelection() except +
    bool igIsItemVisible() except +
    bool igIsKeyDown_ID(ImGuiKey key, ImGuiID owner_id) except +
    bool igIsKeyDown_Nil(ImGuiKey key) except +
    bool igIsKeyPressedMap(ImGuiKey key, bool repeat) except +
    bool igIsKeyPressed_Bool(ImGuiKey key, bool repeat) except +
    bool igIsKeyPressed_ID(ImGuiKey key, ImGuiID owner_id, ImGuiInputFlags flags) except +
    bool igIsKeyReleased_ID(ImGuiKey key, ImGuiID owner_id) except +
    bool igIsKeyReleased_Nil(ImGuiKey key) except +
    bool igIsKeyboardKey(ImGuiKey key) except +
    bool igIsLegacyKey(ImGuiKey key) except +
    bool igIsMouseClicked_Bool(ImGuiMouseButton button, bool repeat) except +
    bool igIsMouseClicked_ID(ImGuiMouseButton button, ImGuiID owner_id, ImGuiInputFlags flags) except +
    bool igIsMouseDoubleClicked(ImGuiMouseButton button) except +
    bool igIsMouseDown_ID(ImGuiMouseButton button, ImGuiID owner_id) except +
    bool igIsMouseDown_Nil(ImGuiMouseButton button) except +
    bool igIsMouseDragPastThreshold(ImGuiMouseButton button, float lock_threshold) except +
    bool igIsMouseDragging(ImGuiMouseButton button, float lock_threshold) except +
    bool igIsMouseHoveringRect(const ImVec2 r_min, const ImVec2 r_max, bool clip) except +
    bool igIsMouseKey(ImGuiKey key) except +
    bool igIsMousePosValid(const ImVec2* mouse_pos) except +
    bool igIsMouseReleased_ID(ImGuiMouseButton button, ImGuiID owner_id) except +
    bool igIsMouseReleased_Nil(ImGuiMouseButton button) except +
    bool igIsNamedKey(ImGuiKey key) except +
    bool igIsNamedKeyOrModKey(ImGuiKey key) except +
    bool igIsPopupOpen_ID(ImGuiID id_, ImGuiPopupFlags popup_flags) except +
    bool igIsPopupOpen_Str(const char* str_id, ImGuiPopupFlags flags) except +
    bool igIsRectVisible_Nil(const ImVec2 size) except +
    bool igIsRectVisible_Vec2(const ImVec2 rect_min, const ImVec2 rect_max) except +
    bool igIsWindowAbove(ImGuiWindow* potential_above, ImGuiWindow* potential_below) except +
    bool igIsWindowAppearing() except +
    bool igIsWindowChildOf(ImGuiWindow* window, ImGuiWindow* potential_parent, bool popup_hierarchy, bool dock_hierarchy) except +
    bool igIsWindowCollapsed() except +
    bool igIsWindowDocked() except +
    bool igIsWindowFocused(ImGuiFocusedFlags flags) except +
    bool igIsWindowHovered(ImGuiHoveredFlags flags) except +
    bool igIsWindowNavFocusable(ImGuiWindow* window) except +
    bool igIsWindowWithinBeginStackOf(ImGuiWindow* window, ImGuiWindow* potential_parent) except +
    bool igItemAdd(const ImRect bb, ImGuiID id_, const ImRect* nav_bb, ImGuiItemFlags extra_flags) except +
    bool igItemHoverable(const ImRect bb, ImGuiID id_) except +
    bool igListBox_FnBoolPtr(const char* label, int* current_item, bool (*items_getter)(void* data, int idx, const char** out_text), void* data, int items_count, int height_in_items) except +
    bool igListBox_Str_arr(const char* label, int* current_item, char* items, int items_count, int height_in_items) except +
    bool igMenuItemEx(const char* label, const char* icon, const char* shortcut, bool selected, bool enabled) except +
    bool igMenuItem_Bool(const char* label, const char* shortcut, bool selected, bool enabled) except +
    bool igMenuItem_BoolPtr(const char* label, const char* shortcut, bool* p_selected, bool enabled) except +
    bool igNavMoveRequestButNoResultYet() except +
    bool igRadioButton_Bool(const char* label, bool active) except +
    bool igRadioButton_IntPtr(const char* label, int* v, int v_button) except +
    bool igScrollbarEx(const ImRect bb, ImGuiID id_, ImGuiAxis axis, ImS64* p_scroll_v, ImS64 avail_v, ImS64 contents_v, ImDrawFlags flags) except +
    bool igSelectable_Bool(const char* label, bool selected, ImGuiSelectableFlags flags, const ImVec2 size) except +
    bool igSelectable_BoolPtr(const char* label, bool* p_selected, ImGuiSelectableFlags flags, const ImVec2 size) except +
    bool igSetDragDropPayload(const char* type_, const void* data, size_t sz, ImGuiCond cond) except +
    bool igSetShortcutRouting(ImGuiKeyChord key_chord, ImGuiID owner_id, ImGuiInputFlags flags) except +
    bool igShortcut(ImGuiKeyChord key_chord, ImGuiID owner_id, ImGuiInputFlags flags) except +
    bool igShowStyleSelector(const char* label) except +
    bool igSliderAngle(const char* label, float* v_rad, float v_degrees_min, float v_degrees_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderBehavior(const ImRect bb, ImGuiID id_, ImGuiDataType data_type, void* p_v, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags, ImRect* out_grab_bb) except +
    bool igSliderFloat(const char* label, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderFloat2(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderFloat3(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderFloat4(const char* label, float v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderInt(const char* label, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderInt2(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderInt3(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderInt4(const char* label, int v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderScalar(const char* label, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSliderScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igSmallButton(const char* label) except +
    bool igSplitterBehavior(const ImRect bb, ImGuiID id_, ImGuiAxis axis, float* size1, float* size2, float min_size1, float min_size2, float hover_extend, float hover_visibility_delay, ImU32 bg_col) except +
    bool igTabBarProcessReorder(ImGuiTabBar* tab_bar) except +
    bool igTabItemButton(const char* label, ImGuiTabItemFlags flags) except +
    bool igTabItemEx(ImGuiTabBar* tab_bar, const char* label, bool* p_open, ImGuiTabItemFlags flags, ImGuiWindow* docked_window) except +
    bool igTableBeginContextMenuPopup(ImGuiTable* table) except +
    bool igTableNextColumn() except +
    bool igTableSetColumnIndex(int column_n) except +
    bool igTempInputIsActive(ImGuiID id_) except +
    bool igTempInputScalar(const ImRect bb, ImGuiID id_, const char* label, ImGuiDataType data_type, void* p_data, const char* format_, const void* p_clamp_min, const void* p_clamp_max) except +
    bool igTempInputText(const ImRect bb, ImGuiID id_, const char* label, char* buf, int buf_size, ImGuiInputTextFlags flags) except +
    bool igTestKeyOwner(ImGuiKey key, ImGuiID owner_id) except +
    bool igTestShortcutRouting(ImGuiKeyChord key_chord, ImGuiID owner_id) except +
    bool igTreeNodeBehavior(ImGuiID id_, ImGuiTreeNodeFlags flags, const char* label, const char* label_end) except +
    bool igTreeNodeExV_Ptr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt, char* args) except +
    bool igTreeNodeExV_Str(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt, char* args) except +
    bool igTreeNodeEx_Ptr(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool igTreeNodeEx_Str(const char* label, ImGuiTreeNodeFlags flags) except +
    bool igTreeNodeEx_StrStr(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt) except +
    bool igTreeNodeUpdateNextOpen(ImGuiID id_, ImGuiTreeNodeFlags flags) except +
    bool igTreeNodeV_Ptr(const void* ptr_id, const char* fmt, char* args) except +
    bool igTreeNodeV_Str(const char* str_id, const char* fmt, char* args) except +
    bool igTreeNode_Ptr(const void* ptr_id, const char* fmt) except +
    bool igTreeNode_Str(const char* label) except +
    bool igTreeNode_StrStr(const char* str_id, const char* fmt) except +
    bool igVSliderFloat(const char* label, const ImVec2 size, float* v, float v_min, float v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igVSliderInt(const char* label, const ImVec2 size, int* v, int v_min, int v_max, const char* format_, ImGuiSliderFlags flags) except +
    bool igVSliderScalar(const char* label, const ImVec2 size, ImGuiDataType data_type, void* p_data, const void* p_min, const void* p_max, const char* format_, ImGuiSliderFlags flags) except +
    bool* ImGuiStorage_GetBoolRef(ImGuiStorage* self, ImGuiID key, bool default_val) except +
    char igImToUpper(char c) except +
    char* ImGuiWindowSettings_GetName(ImGuiWindowSettings* self) except +
    char* igImStrdup(const char* str_) except +
    char* igImStrdupcpy(char* dst, size_t* p_dst_size, const char* str_) except +
    const ImFontBuilderIO* igImFontAtlasGetBuilderForStbTruetype() except +
    const ImFontGlyph* ImFont_FindGlyph(ImFont* self, ImWchar c) except +
    const ImFontGlyph* ImFont_FindGlyphNoFallback(ImFont* self, ImWchar c) except +
    const ImGuiDataTypeInfo* igDataTypeGetInfo(ImGuiDataType data_type) except +
    const ImGuiPayload* igAcceptDragDropPayload(const char* type_, ImGuiDragDropFlags flags) except +
    const ImGuiPayload* igGetDragDropPayload() except +
    const ImGuiPlatformMonitor* igGetViewportPlatformMonitor(ImGuiViewport* viewport) except +
    const ImVec4* igGetStyleColorVec4(ImGuiCol idx) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseFull(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesCyrillic(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesDefault(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesGreek(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesJapanese(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesKorean(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesThai(ImFontAtlas* self) except +
    const ImWchar* ImFontAtlas_GetGlyphRangesVietnamese(ImFontAtlas* self) except +
    const ImWchar* igImStrbolW(const ImWchar* buf_mid_line, const ImWchar* buf_begin) except +
    const char* ImFont_CalcWordWrapPositionA(ImFont* self, float scale, const char* text, const char* text_end, float wrap_width) except +
    const char* ImFont_GetDebugName(ImFont* self) except +
    const char* ImGuiTextBuffer_begin(ImGuiTextBuffer* self) except +
    const char* ImGuiTextBuffer_c_str(ImGuiTextBuffer* self) except +
    const char* ImGuiTextBuffer_end(ImGuiTextBuffer* self) except +
    const char* ImGuiTextIndex_get_line_begin(ImGuiTextIndex* self, const char* base, int n) except +
    const char* ImGuiTextIndex_get_line_end(ImGuiTextIndex* self, const char* base, int n) except +
    const char* igFindRenderedTextEnd(const char* text, const char* text_end) except +
    const char* igGetClipboardText() except +
    const char* igGetKeyName(ImGuiKey key) except +
    const char* igGetStyleColorName(ImGuiCol idx) except +
    const char* igGetVersion() except +
    const char* igImParseFormatFindEnd(const char* format_) except +
    const char* igImParseFormatFindStart(const char* format_) except +
    const char* igImParseFormatSanitizeForScanning(const char* fmt_in, char* fmt_out, size_t fmt_out_size) except +
    const char* igImParseFormatTrimDecorations(const char* format_, char* buf, size_t buf_size) except +
    const char* igImStrSkipBlank(const char* str_) except +
    const char* igImStrchrRange(const char* str_begin, const char* str_end, char c) except +
    const char* igImStreolRange(const char* str_, const char* str_end) except +
    const char* igImStristr(const char* haystack, const char* haystack_end, const char* needle, const char* needle_end) except +
    const char* igImTextCharToUtf8(char out_buf, unsigned int c) except +
    const char* igLocalizeGetMsg(ImGuiLocKey key) except +
    const char* igSaveIniSettingsToMemory(size_t* out_ini_size) except +
    const char* igTabBarGetTabName(ImGuiTabBar* tab_bar, ImGuiTabItem* tab) except +
    const char* igTableGetColumnName_Int(int column_n) except +
    const char* igTableGetColumnName_TablePtr(const ImGuiTable* table, int column_n) except +
    double igGetTime() except +
    double igImAbs_double(double x) except +
    double igImLog_double(double x) except +
    double igImPow_double(double x, double y) except +
    double igImRsqrt_double(double x) except +
    double igImSign_double(double x) except +
    float ImFont_GetCharAdvance(ImFont* self, ImWchar c) except +
    float ImGuiMenuColumns_DeclColumns(ImGuiMenuColumns* self, float w_icon, float w_label, float w_shortcut, float w_mark) except +
    float ImGuiStorage_GetFloat(ImGuiStorage* self, ImGuiID key, float default_val) except +
    float ImGuiWindow_CalcFontSize(ImGuiWindow* self) except +
    float ImGuiWindow_MenuBarHeight(ImGuiWindow* self) except +
    float ImGuiWindow_TitleBarHeight(ImGuiWindow* self) except +
    float ImRect_GetArea(ImRect* self) except +
    float ImRect_GetHeight(ImRect* self) except +
    float ImRect_GetWidth(ImRect* self) except +
    float igCalcItemWidth() except +
    float igCalcWrapWidthForPos(const ImVec2 pos, float wrap_pos_x) except +
    float igGET_FLT_MAX() except +
    float igGET_FLT_MIN() except +
    float igGetColumnNormFromOffset(const ImGuiOldColumns* columns, float offset) except +
    float igGetColumnOffset(int column_index) except +
    float igGetColumnOffsetFromNorm(const ImGuiOldColumns* columns, float offset_norm) except +
    float igGetColumnWidth(int column_index) except +
    float igGetCursorPosX() except +
    float igGetCursorPosY() except +
    float igGetFontSize() except +
    float igGetFrameHeight() except +
    float igGetFrameHeightWithSpacing() except +
    float igGetNavTweakPressedAmount(ImGuiAxis axis) except +
    float igGetScrollMaxX() except +
    float igGetScrollMaxY() except +
    float igGetScrollX() except +
    float igGetScrollY() except +
    float igGetTextLineHeight() except +
    float igGetTextLineHeightWithSpacing() except +
    float igGetTreeNodeToLabelSpacing() except +
    float igGetWindowDpiScale() except +
    float igGetWindowHeight() except +
    float igGetWindowWidth() except +
    float igImAbs_Float(float x) except +
    float igImDot(const ImVec2 a, const ImVec2 b) except +
    float igImExponentialMovingAverage(float avg, float sample, int n) except +
    float igImFloorSigned_Float(float f) except +
    float igImFloor_Float(float f) except +
    float igImInvLength(const ImVec2 lhs, float fail_value) except +
    float igImLengthSqr_Vec2(const ImVec2 lhs) except +
    float igImLengthSqr_Vec4(const ImVec4 lhs) except +
    float igImLinearSweep(float current, float target, float speed) except +
    float igImLog_Float(float x) except +
    float igImPow_Float(float x, float y) except +
    float igImRsqrt_Float(float x) except +
    float igImSaturate(float f) except +
    float igImSign_Float(float x) except +
    float igImTriangleArea(const ImVec2 a, const ImVec2 b, const ImVec2 c) except +
    float igTableGetColumnWidthAuto(ImGuiTable* table, ImGuiTableColumn* column) except +
    float igTableGetHeaderRowHeight() except +
    float igTableGetMaxColumnWidth(const ImGuiTable* table, int column_n) except +
    float* ImGuiStorage_GetFloatRef(ImGuiStorage* self, ImGuiID key, float default_val) except +
    int ImDrawDataBuilder_GetDrawListCount(ImDrawDataBuilder* self) except +
    int ImDrawList__CalcCircleAutoSegmentCount(ImDrawList* self, float radius) except +
    int ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas* self, ImFont* font, ImWchar id_, int width, int height, float advance_x, const ImVec2 offset) except +
    int ImFontAtlas_AddCustomRectRegular(ImFontAtlas* self, int width, int height) except +
    int ImGuiInputTextState_GetCursorPos(ImGuiInputTextState* self) except +
    int ImGuiInputTextState_GetRedoAvailCount(ImGuiInputTextState* self) except +
    int ImGuiInputTextState_GetSelectionEnd(ImGuiInputTextState* self) except +
    int ImGuiInputTextState_GetSelectionStart(ImGuiInputTextState* self) except +
    int ImGuiInputTextState_GetUndoAvailCount(ImGuiInputTextState* self) except +
    int ImGuiStorage_GetInt(ImGuiStorage* self, ImGuiID key, int default_val) except +
    int ImGuiTextBuffer_size(ImGuiTextBuffer* self) except +
    int ImGuiTextIndex_size(ImGuiTextIndex* self) except +
    int igCalcTypematicRepeatAmount(float t0, float t1, float repeat_delay, float repeat_rate) except +
    int igDataTypeCompare(ImGuiDataType data_type, const void* arg_1, const void* arg_2) except +
    int igDataTypeFormatString(char* buf, int buf_size, ImGuiDataType data_type, const void* p_data, const char* format_) except +
    int igDockNodeGetDepth(const ImGuiDockNode* node) except +
    int igFindWindowDisplayIndex(ImGuiWindow* window) except +
    int igGetColumnIndex() except +
    int igGetColumnsCount() except +
    int igGetFrameCount() except +
    int igGetKeyPressedAmount(ImGuiKey key, float repeat_delay, float rate) except +
    int igGetMouseClickedCount(ImGuiMouseButton button) except +
    int igImAbs_Int(int x) except +
    int igImFormatString(char* buf, size_t buf_size, const char* fmt) except +
    int igImFormatStringV(char* buf, size_t buf_size, const char* fmt, char* args) except +
    int igImModPositive(int a, int b) except +
    int igImParseFormatPrecision(const char* format_, int default_value) except +
    int igImStricmp(const char* str1, const char* str2) except +
    int igImStrlenW(const ImWchar* str_) except +
    int igImStrnicmp(const char* str1, const char* str2, size_t count) except +
    int igImTextCharFromUtf8(unsigned int* out_char, const char* in_text, const char* in_text_end) except +
    int igImTextCountCharsFromUtf8(const char* in_text, const char* in_text_end) except +
    int igImTextCountUtf8BytesFromChar(const char* in_text, const char* in_text_end) except +
    int igImTextCountUtf8BytesFromStr(const ImWchar* in_text, const ImWchar* in_text_end) except +
    int igImTextStrFromUtf8(ImWchar* out_buf, int out_buf_size, const char* in_text, const char* in_text_end, const char** in_remaining) except +
    int igImTextStrToUtf8(char* out_buf, int out_buf_size, const ImWchar* in_text, const ImWchar* in_text_end) except +
    int igImUpperPowerOfTwo(int v) except +
    int igPlotEx(ImGuiPlotType plot_type, const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, const ImVec2 size_arg) except +
    int igTabBarGetTabOrder(ImGuiTabBar* tab_bar, ImGuiTabItem* tab) except +
    int igTableGetColumnCount() except +
    int igTableGetColumnIndex() except +
    int igTableGetHoveredColumn() except +
    int igTableGetRowIndex() except +
    int* ImGuiStorage_GetIntRef(ImGuiStorage* self, ImGuiID key, int default_val) except +
    size_t igImBitArrayGetStorageSizeInBytes(int bitcount) except +
    void ImBitVector_Clear(ImBitVector* self) except +
    void ImBitVector_ClearBit(ImBitVector* self, int n) except +
    void ImBitVector_Create(ImBitVector* self, int sz) except +
    void ImBitVector_SetBit(ImBitVector* self, int n) except +
    void ImColor_HSV(ImColor* pOut, float h, float s, float v, float a) except +
    void ImColor_SetHSV(ImColor* self, float h, float s, float v, float a) except +
    void ImColor_destroy(ImColor* self) except +
    void ImDrawCmd_destroy(ImDrawCmd* self) except +
    void ImDrawDataBuilder_Clear(ImDrawDataBuilder* self) except +
    void ImDrawDataBuilder_ClearFreeMemory(ImDrawDataBuilder* self) except +
    void ImDrawDataBuilder_FlattenIntoSingleLayer(ImDrawDataBuilder* self) except +
    void ImDrawData_Clear(ImDrawData* self) except +
    void ImDrawData_DeIndexAllBuffers(ImDrawData* self) except +
    void ImDrawData_ScaleClipRects(ImDrawData* self, const ImVec2 fb_scale) except +
    void ImDrawData_destroy(ImDrawData* self) except +
    void ImDrawListSharedData_SetCircleTessellationMaxError(ImDrawListSharedData* self, float max_error) except +
    void ImDrawListSharedData_destroy(ImDrawListSharedData* self) except +
    void ImDrawListSplitter_Clear(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter* self) except +
    void ImDrawListSplitter_Merge(ImDrawListSplitter* self, ImDrawList* draw_list) except +
    void ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter* self, ImDrawList* draw_list, int channel_idx) except +
    void ImDrawListSplitter_Split(ImDrawListSplitter* self, ImDrawList* draw_list, int count) except +
    void ImDrawListSplitter_destroy(ImDrawListSplitter* self) except +
    void ImDrawList_AddBezierCubic(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, ImU32 col, float thickness, int num_segments) except +
    void ImDrawList_AddBezierQuadratic(ImDrawList* self, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, ImU32 col, float thickness, int num_segments) except +
    void ImDrawList_AddCallback(ImDrawList* self, ImDrawCallback callback, void* callback_data) except +
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
    void ImDrawList__ClearFreeMemory(ImDrawList* self) except +
    void ImDrawList__OnChangedClipRect(ImDrawList* self) except +
    void ImDrawList__OnChangedTextureID(ImDrawList* self) except +
    void ImDrawList__OnChangedVtxOffset(ImDrawList* self) except +
    void ImDrawList__PathArcToFastEx(ImDrawList* self, const ImVec2 center, float radius, int a_min_sample, int a_max_sample, int a_step) except +
    void ImDrawList__PathArcToN(ImDrawList* self, const ImVec2 center, float radius, float a_min, float a_max, int num_segments) except +
    void ImDrawList__PopUnusedDrawCmd(ImDrawList* self) except +
    void ImDrawList__ResetForNewFrame(ImDrawList* self) except +
    void ImDrawList__TryMergeDrawCmds(ImDrawList* self) except +
    void ImDrawList_destroy(ImDrawList* self) except +
    void ImFontAtlasCustomRect_destroy(ImFontAtlasCustomRect* self) except +
    void ImFontAtlas_CalcCustomRectUV(ImFontAtlas* self, const ImFontAtlasCustomRect* rect, ImVec2* out_uv_min, ImVec2* out_uv_max) except +
    void ImFontAtlas_Clear(ImFontAtlas* self) except +
    void ImFontAtlas_ClearFonts(ImFontAtlas* self) except +
    void ImFontAtlas_ClearInputData(ImFontAtlas* self) except +
    void ImFontAtlas_ClearTexData(ImFontAtlas* self) except +
    void ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +
    void ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas* self, unsigned char** out_pixels, int* out_width, int* out_height, int* out_bytes_per_pixel) except +
    void ImFontAtlas_SetTexID(ImFontAtlas* self, ImTextureID id_) except +
    void ImFontAtlas_destroy(ImFontAtlas* self) except +
    void ImFontConfig_destroy(ImFontConfig* self) except +
    void ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder* self, ImWchar c) except +
    void ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder* self, const ImWchar* ranges) except +
    void ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder* self, const char* text, const char* text_end) except +
    void ImFontGlyphRangesBuilder_BuildRanges(ImFontGlyphRangesBuilder* self, ImVector_ImWchar* out_ranges) except +
    void ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder* self) except +
    void ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder* self, size_t n) except +
    void ImFontGlyphRangesBuilder_destroy(ImFontGlyphRangesBuilder* self) except +
    void ImFont_AddGlyph(ImFont* self, const ImFontConfig* src_cfg, ImWchar c, float x0, float y0, float x1, float y1, float u0, float v0, float u1, float v1, float advance_x) except +
    void ImFont_AddRemapChar(ImFont* self, ImWchar dst, ImWchar src, bool overwrite_dst) except +
    void ImFont_BuildLookupTable(ImFont* self) except +
    void ImFont_CalcTextSizeA(ImVec2* pOut, ImFont* self, float size, float max_width, float wrap_width, const char* text_begin, const char* text_end, const char** remaining) except +
    void ImFont_ClearOutputData(ImFont* self) except +
    void ImFont_GrowIndex(ImFont* self, int new_size) except +
    void ImFont_RenderChar(ImFont* self, ImDrawList* draw_list, float size, const ImVec2 pos, ImU32 col, ImWchar c) except +
    void ImFont_RenderText(ImFont* self, ImDrawList* draw_list, float size, const ImVec2 pos, ImU32 col, const ImVec4 clip_rect, const char* text_begin, const char* text_end, float wrap_width, bool cpu_fine_clip) except +
    void ImFont_SetGlyphVisible(ImFont* self, ImWchar c, bool visible) except +
    void ImFont_destroy(ImFont* self) except +
    void ImGuiComboPreviewData_destroy(ImGuiComboPreviewData* self) except +
    void ImGuiContextHook_destroy(ImGuiContextHook* self) except +
    void ImGuiContext_destroy(ImGuiContext* self) except +
    void ImGuiDockContext_destroy(ImGuiDockContext* self) except +
    void ImGuiDockNode_Rect(ImRect* pOut, ImGuiDockNode* self) except +
    void ImGuiDockNode_SetLocalFlags(ImGuiDockNode* self, ImGuiDockNodeFlags flags) except +
    void ImGuiDockNode_UpdateMergedFlags(ImGuiDockNode* self) except +
    void ImGuiDockNode_destroy(ImGuiDockNode* self) except +
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
    void ImGuiIO_destroy(ImGuiIO* self) except +
    void ImGuiInputEvent_destroy(ImGuiInputEvent* self) except +
    void ImGuiInputTextCallbackData_ClearSelection(ImGuiInputTextCallbackData* self) except +
    void ImGuiInputTextCallbackData_DeleteChars(ImGuiInputTextCallbackData* self, int pos, int bytes_count) except +
    void ImGuiInputTextCallbackData_InsertChars(ImGuiInputTextCallbackData* self, int pos, const char* text, const char* text_end) except +
    void ImGuiInputTextCallbackData_SelectAll(ImGuiInputTextCallbackData* self) except +
    void ImGuiInputTextCallbackData_destroy(ImGuiInputTextCallbackData* self) except +
    void ImGuiInputTextState_ClearFreeMemory(ImGuiInputTextState* self) except +
    void ImGuiInputTextState_ClearSelection(ImGuiInputTextState* self) except +
    void ImGuiInputTextState_ClearText(ImGuiInputTextState* self) except +
    void ImGuiInputTextState_CursorAnimReset(ImGuiInputTextState* self) except +
    void ImGuiInputTextState_CursorClamp(ImGuiInputTextState* self) except +
    void ImGuiInputTextState_OnKeyPressed(ImGuiInputTextState* self, int key) except +
    void ImGuiInputTextState_SelectAll(ImGuiInputTextState* self) except +
    void ImGuiInputTextState_destroy(ImGuiInputTextState* self) except +
    void ImGuiKeyOwnerData_destroy(ImGuiKeyOwnerData* self) except +
    void ImGuiKeyRoutingData_destroy(ImGuiKeyRoutingData* self) except +
    void ImGuiKeyRoutingTable_Clear(ImGuiKeyRoutingTable* self) except +
    void ImGuiKeyRoutingTable_destroy(ImGuiKeyRoutingTable* self) except +
    void ImGuiLastItemData_destroy(ImGuiLastItemData* self) except +
    void ImGuiListClipperData_Reset(ImGuiListClipperData* self, ImGuiListClipper* clipper) except +
    void ImGuiListClipperData_destroy(ImGuiListClipperData* self) except +
    void ImGuiListClipper_Begin(ImGuiListClipper* self, int items_count, float items_height) except +
    void ImGuiListClipper_End(ImGuiListClipper* self) except +
    void ImGuiListClipper_ForceDisplayRangeByIndices(ImGuiListClipper* self, int item_min, int item_max) except +
    void ImGuiListClipper_destroy(ImGuiListClipper* self) except +
    void ImGuiMenuColumns_CalcNextTotalWidth(ImGuiMenuColumns* self, bool update_offsets) except +
    void ImGuiMenuColumns_Update(ImGuiMenuColumns* self, float spacing, bool window_reappearing) except +
    void ImGuiMenuColumns_destroy(ImGuiMenuColumns* self) except +
    void ImGuiNavItemData_Clear(ImGuiNavItemData* self) except +
    void ImGuiNavItemData_destroy(ImGuiNavItemData* self) except +
    void ImGuiNextItemData_ClearFlags(ImGuiNextItemData* self) except +
    void ImGuiNextItemData_destroy(ImGuiNextItemData* self) except +
    void ImGuiNextWindowData_ClearFlags(ImGuiNextWindowData* self) except +
    void ImGuiNextWindowData_destroy(ImGuiNextWindowData* self) except +
    void ImGuiOldColumnData_destroy(ImGuiOldColumnData* self) except +
    void ImGuiOldColumns_destroy(ImGuiOldColumns* self) except +
    void ImGuiOnceUponAFrame_destroy(ImGuiOnceUponAFrame* self) except +
    void ImGuiPayload_Clear(ImGuiPayload* self) except +
    void ImGuiPayload_destroy(ImGuiPayload* self) except +
    void ImGuiPlatformIO_destroy(ImGuiPlatformIO* self) except +
    void ImGuiPlatformImeData_destroy(ImGuiPlatformImeData* self) except +
    void ImGuiPlatformMonitor_destroy(ImGuiPlatformMonitor* self) except +
    void ImGuiPopupData_destroy(ImGuiPopupData* self) except +
    void ImGuiPtrOrIndex_destroy(ImGuiPtrOrIndex* self) except +
    void ImGuiSettingsHandler_destroy(ImGuiSettingsHandler* self) except +
    void ImGuiStackLevelInfo_destroy(ImGuiStackLevelInfo* self) except +
    void ImGuiStackSizes_CompareWithCurrentState(ImGuiStackSizes* self) except +
    void ImGuiStackSizes_SetToCurrentState(ImGuiStackSizes* self) except +
    void ImGuiStackSizes_destroy(ImGuiStackSizes* self) except +
    void ImGuiStackTool_destroy(ImGuiStackTool* self) except +
    void ImGuiStoragePair_destroy(ImGuiStoragePair* self) except +
    void ImGuiStorage_BuildSortByKey(ImGuiStorage* self) except +
    void ImGuiStorage_Clear(ImGuiStorage* self) except +
    void ImGuiStorage_SetAllInt(ImGuiStorage* self, int val) except +
    void ImGuiStorage_SetBool(ImGuiStorage* self, ImGuiID key, bool val) except +
    void ImGuiStorage_SetFloat(ImGuiStorage* self, ImGuiID key, float val) except +
    void ImGuiStorage_SetInt(ImGuiStorage* self, ImGuiID key, int val) except +
    void ImGuiStorage_SetVoidPtr(ImGuiStorage* self, ImGuiID key, void* val) except +
    void ImGuiStyleMod_destroy(ImGuiStyleMod* self) except +
    void ImGuiStyle_ScaleAllSizes(ImGuiStyle* self, float scale_factor) except +
    void ImGuiStyle_destroy(ImGuiStyle* self) except +
    void ImGuiTabBar_destroy(ImGuiTabBar* self) except +
    void ImGuiTabItem_destroy(ImGuiTabItem* self) except +
    void ImGuiTableColumnSettings_destroy(ImGuiTableColumnSettings* self) except +
    void ImGuiTableColumnSortSpecs_destroy(ImGuiTableColumnSortSpecs* self) except +
    void ImGuiTableColumn_destroy(ImGuiTableColumn* self) except +
    void ImGuiTableInstanceData_destroy(ImGuiTableInstanceData* self) except +
    void ImGuiTableSettings_destroy(ImGuiTableSettings* self) except +
    void ImGuiTableSortSpecs_destroy(ImGuiTableSortSpecs* self) except +
    void ImGuiTableTempData_destroy(ImGuiTableTempData* self) except +
    void ImGuiTable_destroy(ImGuiTable* self) except +
    void ImGuiTextBuffer_append(ImGuiTextBuffer* self, const char* str_, const char* str_end) except +
    void ImGuiTextBuffer_appendf( ImGuiTextBuffer* buffer, const char* fmt) except +
    void ImGuiTextBuffer_appendfv(ImGuiTextBuffer* self, const char* fmt, char* args) except +
    void ImGuiTextBuffer_clear(ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_destroy(ImGuiTextBuffer* self) except +
    void ImGuiTextBuffer_reserve(ImGuiTextBuffer* self, int capacity) except +
    void ImGuiTextFilter_Build(ImGuiTextFilter* self) except +
    void ImGuiTextFilter_Clear(ImGuiTextFilter* self) except +
    void ImGuiTextFilter_destroy(ImGuiTextFilter* self) except +
    void ImGuiTextIndex_append(ImGuiTextIndex* self, const char* base, int old_size, int new_size) except +
    void ImGuiTextIndex_clear(ImGuiTextIndex* self) except +
    void ImGuiTextRange_destroy(ImGuiTextRange* self) except +
    void ImGuiTextRange_split(ImGuiTextRange* self, char separator, ImVector_ImGuiTextRange* out) except +
    void ImGuiViewportP_CalcWorkRectPos(ImVec2* pOut, ImGuiViewportP* self, const ImVec2 off_min) except +
    void ImGuiViewportP_CalcWorkRectSize(ImVec2* pOut, ImGuiViewportP* self, const ImVec2 off_min, const ImVec2 off_max) except +
    void ImGuiViewportP_ClearRequestFlags(ImGuiViewportP* self) except +
    void ImGuiViewportP_GetBuildWorkRect(ImRect* pOut, ImGuiViewportP* self) except +
    void ImGuiViewportP_GetMainRect(ImRect* pOut, ImGuiViewportP* self) except +
    void ImGuiViewportP_GetWorkRect(ImRect* pOut, ImGuiViewportP* self) except +
    void ImGuiViewportP_UpdateWorkRect(ImGuiViewportP* self) except +
    void ImGuiViewportP_destroy(ImGuiViewportP* self) except +
    void ImGuiViewport_GetCenter(ImVec2* pOut, ImGuiViewport* self) except +
    void ImGuiViewport_GetWorkCenter(ImVec2* pOut, ImGuiViewport* self) except +
    void ImGuiViewport_destroy(ImGuiViewport* self) except +
    void ImGuiWindowClass_destroy(ImGuiWindowClass* self) except +
    void ImGuiWindowSettings_destroy(ImGuiWindowSettings* self) except +
    void ImGuiWindow_MenuBarRect(ImRect* pOut, ImGuiWindow* self) except +
    void ImGuiWindow_Rect(ImRect* pOut, ImGuiWindow* self) except +
    void ImGuiWindow_TitleBarRect(ImRect* pOut, ImGuiWindow* self) except +
    void ImGuiWindow_destroy(ImGuiWindow* self) except +
    void ImRect_Add_Rect(ImRect* self, const ImRect r) except +
    void ImRect_Add_Vec2(ImRect* self, const ImVec2 p) except +
    void ImRect_ClipWith(ImRect* self, const ImRect r) except +
    void ImRect_ClipWithFull(ImRect* self, const ImRect r) except +
    void ImRect_Expand_Float(ImRect* self, const float amount) except +
    void ImRect_Expand_Vec2(ImRect* self, const ImVec2 amount) except +
    void ImRect_Floor(ImRect* self) except +
    void ImRect_GetBL(ImVec2* pOut, ImRect* self) except +
    void ImRect_GetBR(ImVec2* pOut, ImRect* self) except +
    void ImRect_GetCenter(ImVec2* pOut, ImRect* self) except +
    void ImRect_GetSize(ImVec2* pOut, ImRect* self) except +
    void ImRect_GetTL(ImVec2* pOut, ImRect* self) except +
    void ImRect_GetTR(ImVec2* pOut, ImRect* self) except +
    void ImRect_ToVec4(ImVec4* pOut, ImRect* self) except +
    void ImRect_Translate(ImRect* self, const ImVec2 d) except +
    void ImRect_TranslateX(ImRect* self, float dx) except +
    void ImRect_TranslateY(ImRect* self, float dy) except +
    void ImRect_destroy(ImRect* self) except +
    void ImVec1_destroy(ImVec1* self) except +
    void ImVec2_destroy(ImVec2* self) except +
    void ImVec2ih_destroy(ImVec2ih* self) except +
    void ImVec4_destroy(ImVec4* self) except +
    void ImVector_ImWchar_Init(ImVector_ImWchar* p) except +
    void ImVector_ImWchar_UnInit(ImVector_ImWchar* p) except +
    void ImVector_ImWchar_destroy(ImVector_ImWchar* self) except +
    void igActivateItem(ImGuiID id_) except +
    void igAddSettingsHandler(const ImGuiSettingsHandler* handler) except +
    void igAlignTextToFramePadding() except +
    void igBeginColumns(const char* str_id, int count, ImGuiOldColumnFlags flags) except +
    void igBeginDisabled(bool disabled) except +
    void igBeginDockableDragDropSource(ImGuiWindow* window) except +
    void igBeginDockableDragDropTarget(ImGuiWindow* window) except +
    void igBeginDocked(ImGuiWindow* window, bool* p_open) except +
    void igBeginGroup() except +
    void igBeginTooltip() except +
    void igBeginTooltipEx(ImGuiTooltipFlags tooltip_flags, ImGuiWindowFlags extra_window_flags) except +
    void igBringWindowToDisplayBack(ImGuiWindow* window) except +
    void igBringWindowToDisplayBehind(ImGuiWindow* window, ImGuiWindow* above_window) except +
    void igBringWindowToDisplayFront(ImGuiWindow* window) except +
    void igBringWindowToFocusFront(ImGuiWindow* window) except +
    void igBullet() except +
    void igBulletText(const char* fmt) except +
    void igBulletTextV(const char* fmt, char* args) except +
    void igCalcItemSize(ImVec2* pOut, ImVec2 size, float default_w, float default_h) except +
    void igCalcTextSize(ImVec2* pOut, const char* text, const char* text_end, bool hide_text_after_double_hash, float wrap_width) except +
    void igCalcWindowNextAutoFitSize(ImVec2* pOut, ImGuiWindow* window) except +
    void igCallContextHooks(ImGuiContext* context, ImGuiContextHookType type_) except +
    void igClearActiveID() except +
    void igClearDragDrop() except +
    void igClearIniSettings() except +
    void igClearWindowSettings(const char* name) except +
    void igCloseCurrentPopup() except +
    void igClosePopupToLevel(int remaining, bool restore_focus_to_window_under_popup) except +
    void igClosePopupsExceptModals() except +
    void igClosePopupsOverWindow(ImGuiWindow* ref_window, bool restore_focus_to_window_under_popup) except +
    void igColorConvertHSVtoRGB(float h, float s, float v, float* out_r, float* out_g, float* out_b) except +
    void igColorConvertRGBtoHSV(float r, float g, float b, float* out_h, float* out_s, float* out_v) except +
    void igColorConvertU32ToFloat4(ImVec4* pOut, ImU32 in_) except +
    void igColorEditOptionsPopup(const float* col, ImGuiColorEditFlags flags) except +
    void igColorPickerOptionsPopup(const float* ref_col, ImGuiColorEditFlags flags) except +
    void igColorTooltip(const char* text, const float* col, ImGuiColorEditFlags flags) except +
    void igColumns(int count, const char* id_, bool border) except +
    void igDataTypeApplyOp(ImGuiDataType data_type, int op, void* output, const void* arg_1, const void* arg_2) except +
    void igDebugDrawItemRect(ImU32 col) except +
    void igDebugHookIdInfo(ImGuiID id_, ImGuiDataType data_type, const void* data_id, const void* data_id_end) except +
    void igDebugLocateItem(ImGuiID target_id) except +
    void igDebugLocateItemOnHover(ImGuiID target_id) except +
    void igDebugLocateItemResolveWithLastItem() except +
    void igDebugLog(const char* fmt) except +
    void igDebugLogV(const char* fmt, char* args) except +
    void igDebugNodeColumns(ImGuiOldColumns* columns) except +
    void igDebugNodeDockNode(ImGuiDockNode* node, const char* label) except +
    void igDebugNodeDrawCmdShowMeshAndBoundingBox(ImDrawList* out_draw_list, const ImDrawList* draw_list, const ImDrawCmd* draw_cmd, bool show_mesh, bool show_aabb) except +
    void igDebugNodeDrawList(ImGuiWindow* window, ImGuiViewportP* viewport, const ImDrawList* draw_list, const char* label) except +
    void igDebugNodeFont(ImFont* font) except +
    void igDebugNodeFontGlyph(ImFont* font, const ImFontGlyph* glyph) except +
    void igDebugNodeInputTextState(ImGuiInputTextState* state) except +
    void igDebugNodeStorage(ImGuiStorage* storage, const char* label) except +
    void igDebugNodeTabBar(ImGuiTabBar* tab_bar, const char* label) except +
    void igDebugNodeTable(ImGuiTable* table) except +
    void igDebugNodeTableSettings(ImGuiTableSettings* settings) except +
    void igDebugNodeViewport(ImGuiViewportP* viewport) except +
    void igDebugNodeWindow(ImGuiWindow* window, const char* label) except +
    void igDebugNodeWindowSettings(ImGuiWindowSettings* settings) except +
    void igDebugNodeWindowsList(ImVector_ImGuiWindowPtr* windows, const char* label) except +
    void igDebugNodeWindowsListByBeginStackParent(ImGuiWindow** windows, int windows_size, ImGuiWindow* parent_in_begin_stack) except +
    void igDebugRenderKeyboardPreview(ImDrawList* draw_list) except +
    void igDebugRenderViewportThumbnail(ImDrawList* draw_list, ImGuiViewportP* viewport, const ImRect bb) except +
    void igDebugStartItemPicker() except +
    void igDebugTextEncoding(const char* text) except +
    void igDestroyContext(ImGuiContext* ctx) except +
    void igDestroyPlatformWindow(ImGuiViewportP* viewport) except +
    void igDestroyPlatformWindows() except +
    void igDockBuilderCopyDockSpace(ImGuiID src_dockspace_id, ImGuiID dst_dockspace_id, ImVector_const_charPtr* in_window_remap_pairs) except +
    void igDockBuilderCopyNode(ImGuiID src_node_id, ImGuiID dst_node_id, ImVector_ImGuiID* out_node_remap_pairs) except +
    void igDockBuilderCopyWindowSettings(const char* src_name, const char* dst_name) except +
    void igDockBuilderDockWindow(const char* window_name, ImGuiID node_id) except +
    void igDockBuilderFinish(ImGuiID node_id) except +
    void igDockBuilderRemoveNode(ImGuiID node_id) except +
    void igDockBuilderRemoveNodeChildNodes(ImGuiID node_id) except +
    void igDockBuilderRemoveNodeDockedWindows(ImGuiID node_id, bool clear_settings_refs) except +
    void igDockBuilderSetNodePos(ImGuiID node_id, ImVec2 pos) except +
    void igDockBuilderSetNodeSize(ImGuiID node_id, ImVec2 size) except +
    void igDockContextClearNodes(ImGuiContext* ctx, ImGuiID root_id, bool clear_settings_refs) except +
    void igDockContextEndFrame(ImGuiContext* ctx) except +
    void igDockContextInitialize(ImGuiContext* ctx) except +
    void igDockContextNewFrameUpdateDocking(ImGuiContext* ctx) except +
    void igDockContextNewFrameUpdateUndocking(ImGuiContext* ctx) except +
    void igDockContextProcessUndockNode(ImGuiContext* ctx, ImGuiDockNode* node) except +
    void igDockContextProcessUndockWindow(ImGuiContext* ctx, ImGuiWindow* window, bool clear_persistent_docking_ref) except +
    void igDockContextQueueDock(ImGuiContext* ctx, ImGuiWindow* target, ImGuiDockNode* target_node, ImGuiWindow* payload, ImGuiDir split_dir, float split_ratio, bool split_outer) except +
    void igDockContextQueueUndockNode(ImGuiContext* ctx, ImGuiDockNode* node) except +
    void igDockContextQueueUndockWindow(ImGuiContext* ctx, ImGuiWindow* window) except +
    void igDockContextRebuildNodes(ImGuiContext* ctx) except +
    void igDockContextShutdown(ImGuiContext* ctx) except +
    void igDockNodeEndAmendTabBar() except +
    void igDummy(const ImVec2 size) except +
    void igEnd() except +
    void igEndChild() except +
    void igEndChildFrame() except +
    void igEndColumns() except +
    void igEndCombo() except +
    void igEndComboPreview() except +
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
    void igErrorCheckEndFrameRecover(ImGuiErrorLogCallback log_callback, void* user_data) except +
    void igErrorCheckEndWindowRecover(ImGuiErrorLogCallback log_callback, void* user_data) except +
    void igErrorCheckUsingSetCursorPosToExtendParentBoundaries() except +
    void igFindBestWindowPosForPopup(ImVec2* pOut, ImGuiWindow* window) except +
    void igFindBestWindowPosForPopupEx(ImVec2* pOut, const ImVec2 ref_pos, const ImVec2 size, ImGuiDir* last_dir, const ImRect r_outer, const ImRect r_avoid, ImGuiPopupPositionPolicy policy) except +
    void igFocusTopMostWindowUnderOne(ImGuiWindow* under_this_window, ImGuiWindow* ignore_window) except +
    void igFocusWindow(ImGuiWindow* window) except +
    void igGcAwakeTransientWindowBuffers(ImGuiWindow* window) except +
    void igGcCompactTransientMiscBuffers() except +
    void igGcCompactTransientWindowBuffers(ImGuiWindow* window) except +
    void igGetAllocatorFunctions(ImGuiMemAllocFunc* p_alloc_func, ImGuiMemFreeFunc* p_free_func, void** p_user_data) except +
    void igGetContentRegionAvail(ImVec2* pOut) except +
    void igGetContentRegionMax(ImVec2* pOut) except +
    void igGetContentRegionMaxAbs(ImVec2* pOut) except +
    void igGetCursorPos(ImVec2* pOut) except +
    void igGetCursorScreenPos(ImVec2* pOut) except +
    void igGetCursorStartPos(ImVec2* pOut) except +
    void igGetFontTexUvWhitePixel(ImVec2* pOut) except +
    void igGetItemRectMax(ImVec2* pOut) except +
    void igGetItemRectMin(ImVec2* pOut) except +
    void igGetItemRectSize(ImVec2* pOut) except +
    void igGetKeyChordName(ImGuiKeyChord key_chord, char* out_buf, int out_buf_size) except +
    void igGetKeyMagnitude2d(ImVec2* pOut, ImGuiKey key_left, ImGuiKey key_right, ImGuiKey key_up, ImGuiKey key_down) except +
    void igGetMouseDragDelta(ImVec2* pOut, ImGuiMouseButton button, float lock_threshold) except +
    void igGetMousePos(ImVec2* pOut) except +
    void igGetMousePosOnOpeningCurrentPopup(ImVec2* pOut) except +
    void igGetPopupAllowedExtentRect(ImRect* pOut, ImGuiWindow* window) except +
    void igGetTypematicRepeatRate(ImGuiInputFlags flags, float* repeat_delay, float* repeat_rate) except +
    void igGetWindowContentRegionMax(ImVec2* pOut) except +
    void igGetWindowContentRegionMin(ImVec2* pOut) except +
    void igGetWindowPos(ImVec2* pOut) except +
    void igGetWindowScrollbarRect(ImRect* pOut, ImGuiWindow* window, ImGuiAxis axis) except +
    void igGetWindowSize(ImVec2* pOut) except +
    void igImBezierCubicCalc(ImVec2* pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, float t) except +
    void igImBezierCubicClosestPoint(ImVec2* pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, const ImVec2 p, int num_segments) except +
    void igImBezierCubicClosestPointCasteljau(ImVec2* pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, const ImVec2 p4, const ImVec2 p, float tess_tol) except +
    void igImBezierQuadraticCalc(ImVec2* pOut, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, float t) except +
    void igImBitArrayClearAllBits(ImU32* arr, int bitcount) except +
    void igImBitArrayClearBit(ImU32* arr, int n) except +
    void igImBitArraySetBit(ImU32* arr, int n) except +
    void igImBitArraySetBitRange(ImU32* arr, int n, int n2) except +
    void igImClamp(ImVec2* pOut, const ImVec2 v, const ImVec2 mn, ImVec2 mx) except +
    void igImFloorSigned_Vec2(ImVec2* pOut, const ImVec2 v) except +
    void igImFloor_Vec2(ImVec2* pOut, const ImVec2 v) except +
    void igImFontAtlasBuildFinish(ImFontAtlas* atlas) except +
    void igImFontAtlasBuildInit(ImFontAtlas* atlas) except +
    void igImFontAtlasBuildMultiplyCalcLookupTable(unsigned char out_table, float in_multiply_factor) except +
    void igImFontAtlasBuildMultiplyRectAlpha8(const unsigned char table, unsigned char* pixels, int x, int y, int w, int h, int stride) except +
    void igImFontAtlasBuildPackCustomRects(ImFontAtlas* atlas, void* stbrp_context_opaque) except +
    void igImFontAtlasBuildRender32bppRectFromString(ImFontAtlas* atlas, int x, int y, int w, int h, const char* in_str, char in_marker_char, unsigned int in_marker_pixel_value) except +
    void igImFontAtlasBuildRender8bppRectFromString(ImFontAtlas* atlas, int x, int y, int w, int h, const char* in_str, char in_marker_char, unsigned char in_marker_pixel_value) except +
    void igImFontAtlasBuildSetupFont(ImFontAtlas* atlas, ImFont* font, ImFontConfig* font_config, float ascent, float descent) except +
    void igImFormatStringToTempBuffer(const char** out_buf, const char** out_buf_end, const char* fmt) except +
    void igImFormatStringToTempBufferV(const char** out_buf, const char** out_buf_end, const char* fmt, char* args) except +
    void igImLerp_Vec2Float(ImVec2* pOut, const ImVec2 a, const ImVec2 b, float t) except +
    void igImLerp_Vec2Vec2(ImVec2* pOut, const ImVec2 a, const ImVec2 b, const ImVec2 t) except +
    void igImLerp_Vec4(ImVec4* pOut, const ImVec4 a, const ImVec4 b, float t) except +
    void igImLineClosestPoint(ImVec2* pOut, const ImVec2 a, const ImVec2 b, const ImVec2 p) except +
    void igImMax(ImVec2* pOut, const ImVec2 lhs, const ImVec2 rhs) except +
    void igImMin(ImVec2* pOut, const ImVec2 lhs, const ImVec2 rhs) except +
    void igImMul(ImVec2* pOut, const ImVec2 lhs, const ImVec2 rhs) except +
    void igImParseFormatSanitizeForPrinting(const char* fmt_in, char* fmt_out, size_t fmt_out_size) except +
    void igImQsort(void* base, size_t count, size_t size_of_element, int (*compare_func)(void* , void* )) except +
    void igImRotate(ImVec2* pOut, const ImVec2 v, float cos_a, float sin_a) except +
    void igImStrTrimBlanks(char* str_) except +
    void igImStrncpy(char* dst, const char* src, size_t count) except +
    void igImTriangleBarycentricCoords(const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 p, float* out_u, float* out_v, float* out_w) except +
    void igImTriangleClosestPoint(ImVec2* pOut, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 p) except +
    void igImage(ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0, const ImVec2 uv1, const ImVec4 tint_col, const ImVec4 border_col) except +
    void igIndent(float indent_w) except +
    void igInitialize() except +
    void igItemSize_Rect(const ImRect bb, float text_baseline_y) except +
    void igItemSize_Vec2(const ImVec2 size, float text_baseline_y) except +
    void igKeepAliveID(ImGuiID id_) except +
    void igLabelText(const char* label, const char* fmt) except +
    void igLabelTextV(const char* label, const char* fmt, char* args) except +
    void igLoadIniSettingsFromDisk(const char* ini_filename) except +
    void igLoadIniSettingsFromMemory(const char* ini_data, size_t ini_size) except +
    void igLocalizeRegisterEntries(const ImGuiLocEntry* entries, int count) except +
    void igLogBegin(ImGuiLogType type_, int auto_open_depth) except +
    void igLogButtons() except +
    void igLogFinish() except +
    void igLogRenderedText(const ImVec2* ref_pos, const char* text, const char* text_end) except +
    void igLogSetNextTextDecoration(const char* prefix, const char* suffix) except +
    void igLogText(const char* fmt) except +
    void igLogTextV(const char* fmt, char* args) except +
    void igLogToBuffer(int auto_open_depth) except +
    void igLogToClipboard(int auto_open_depth) except +
    void igLogToFile(int auto_open_depth, const char* filename) except +
    void igLogToTTY(int auto_open_depth) except +
    void igMarkIniSettingsDirty_Nil() except +
    void igMarkIniSettingsDirty_WindowPtr(ImGuiWindow* window) except +
    void igMarkItemEdited(ImGuiID id_) except +
    void igMemFree(void* ptr) except +
    void igNavInitRequestApplyResult() except +
    void igNavInitWindow(ImGuiWindow* window, bool force_reinit) except +
    void igNavMoveRequestApplyResult() except +
    void igNavMoveRequestCancel() except +
    void igNavMoveRequestForward(ImGuiDir move_dir, ImGuiDir clip_dir, ImGuiNavMoveFlags move_flags, ImGuiScrollFlags scroll_flags) except +
    void igNavMoveRequestResolveWithLastItem(ImGuiNavItemData* result) except +
    void igNavMoveRequestSubmit(ImGuiDir move_dir, ImGuiDir clip_dir, ImGuiNavMoveFlags move_flags, ImGuiScrollFlags scroll_flags) except +
    void igNavMoveRequestTryWrapping(ImGuiWindow* window, ImGuiNavMoveFlags move_flags) except +
    void igNewFrame() except +
    void igNewLine() except +
    void igNextColumn() except +
    void igOpenPopupEx(ImGuiID id_, ImGuiPopupFlags popup_flags) except +
    void igOpenPopupOnItemClick(const char* str_id, ImGuiPopupFlags popup_flags) except +
    void igOpenPopup_ID(ImGuiID id_, ImGuiPopupFlags popup_flags) except +
    void igOpenPopup_Str(const char* str_id, ImGuiPopupFlags popup_flags) except +
    void igPlotHistogram_FloatPtr(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +
    void igPlotHistogram_FnFloatPtr(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void igPlotLines_FloatPtr(const char* label, const float* values, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) except +
    void igPlotLines_FnFloatPtr(const char* label, float (*values_getter)(void* data, int idx), void* data, int values_count, int values_offset, const char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) except +
    void igPopAllowKeyboardFocus() except +
    void igPopButtonRepeat() except +
    void igPopClipRect() except +
    void igPopColumnsBackground() except +
    void igPopFocusScope() except +
    void igPopFont() except +
    void igPopID() except +
    void igPopItemFlag() except +
    void igPopItemWidth() except +
    void igPopStyleColor(int count) except +
    void igPopStyleVar(int count) except +
    void igPopTextWrapPos() except +
    void igProgressBar(float fraction, const ImVec2 size_arg, const char* overlay) except +
    void igPushAllowKeyboardFocus(bool allow_keyboard_focus) except +
    void igPushButtonRepeat(bool repeat) except +
    void igPushClipRect(const ImVec2 clip_rect_min, const ImVec2 clip_rect_max, bool intersect_with_current_clip_rect) except +
    void igPushColumnClipRect(int column_index) except +
    void igPushColumnsBackground() except +
    void igPushFocusScope(ImGuiID id_) except +
    void igPushFont(ImFont* font) except +
    void igPushID_Int(int int_id) except +
    void igPushID_Ptr(const void* ptr_id) except +
    void igPushID_Str(const char* str_id) except +
    void igPushID_StrStr(const char* str_id_begin, const char* str_id_end) except +
    void igPushItemFlag(ImGuiItemFlags option, bool enabled) except +
    void igPushItemWidth(float item_width) except +
    void igPushMultiItemsWidths(int components, float width_full) except +
    void igPushOverrideID(ImGuiID id_) except +
    void igPushStyleColor_U32(ImGuiCol idx, ImU32 col) except +
    void igPushStyleColor_Vec4(ImGuiCol idx, const ImVec4 col) except +
    void igPushStyleVar_Float(ImGuiStyleVar idx, float val) except +
    void igPushStyleVar_Vec2(ImGuiStyleVar idx, const ImVec2 val) except +
    void igPushTextWrapPos(float wrap_local_pos_x) except +
    void igRemoveContextHook(ImGuiContext* context, ImGuiID hook_to_remove) except +
    void igRemoveSettingsHandler(const char* type_name) except +
    void igRender() except +
    void igRenderArrow(ImDrawList* draw_list, ImVec2 pos, ImU32 col, ImGuiDir dir_, float scale) except +
    void igRenderArrowDockMenu(ImDrawList* draw_list, ImVec2 p_min, float sz, ImU32 col) except +
    void igRenderArrowPointingAt(ImDrawList* draw_list, ImVec2 pos, ImVec2 half_sz, ImGuiDir direction, ImU32 col) except +
    void igRenderBullet(ImDrawList* draw_list, ImVec2 pos, ImU32 col) except +
    void igRenderCheckMark(ImDrawList* draw_list, ImVec2 pos, ImU32 col, float sz) except +
    void igRenderColorRectWithAlphaCheckerboard(ImDrawList* draw_list, ImVec2 p_min, ImVec2 p_max, ImU32 fill_col, float grid_step, ImVec2 grid_off, float rounding, ImDrawFlags flags) except +
    void igRenderDragDropTargetRect(const ImRect bb) except +
    void igRenderFrame(ImVec2 p_min, ImVec2 p_max, ImU32 fill_col, bool border, float rounding) except +
    void igRenderFrameBorder(ImVec2 p_min, ImVec2 p_max, float rounding) except +
    void igRenderMouseCursor(ImVec2 pos, float scale, ImGuiMouseCursor mouse_cursor, ImU32 col_fill, ImU32 col_border, ImU32 col_shadow) except +
    void igRenderNavHighlight(const ImRect bb, ImGuiID id_, ImGuiNavHighlightFlags flags) except +
    void igRenderPlatformWindowsDefault(void* platform_render_arg, void* renderer_render_arg) except +
    void igRenderRectFilledRangeH(ImDrawList* draw_list, const ImRect rect, ImU32 col, float x_start_norm, float x_end_norm, float rounding) except +
    void igRenderRectFilledWithHole(ImDrawList* draw_list, const ImRect outer, const ImRect inner, ImU32 col, float rounding) except +
    void igRenderText(ImVec2 pos, const char* text, const char* text_end, bool hide_text_after_hash) except +
    void igRenderTextClipped(const ImVec2 pos_min, const ImVec2 pos_max, const char* text, const char* text_end, const ImVec2* text_size_if_known, const ImVec2 align, const ImRect* clip_rect) except +
    void igRenderTextClippedEx(ImDrawList* draw_list, const ImVec2 pos_min, const ImVec2 pos_max, const char* text, const char* text_end, const ImVec2* text_size_if_known, const ImVec2 align, const ImRect* clip_rect) except +
    void igRenderTextEllipsis(ImDrawList* draw_list, const ImVec2 pos_min, const ImVec2 pos_max, float clip_max_x, float ellipsis_max_x, const char* text, const char* text_end, const ImVec2* text_size_if_known) except +
    void igRenderTextWrapped(ImVec2 pos, const char* text, const char* text_end, float wrap_width) except +
    void igResetMouseDragDelta(ImGuiMouseButton button) except +
    void igSameLine(float offset_from_start_x, float spacing) except +
    void igSaveIniSettingsToDisk(const char* ini_filename) except +
    void igScaleWindowsInViewport(ImGuiViewportP* viewport, float scale) except +
    void igScrollToBringRectIntoView(ImGuiWindow* window, const ImRect rect) except +
    void igScrollToItem(ImGuiScrollFlags flags) except +
    void igScrollToRect(ImGuiWindow* window, const ImRect rect, ImGuiScrollFlags flags) except +
    void igScrollToRectEx(ImVec2* pOut, ImGuiWindow* window, const ImRect rect, ImGuiScrollFlags flags) except +
    void igScrollbar(ImGuiAxis axis) except +
    void igSeparator() except +
    void igSeparatorEx(ImGuiSeparatorFlags flags) except +
    void igSeparatorText(const char* label) except +
    void igSeparatorTextEx(ImGuiID id_, const char* label, const char* label_end, float extra_width) except +
    void igSetActiveID(ImGuiID id_, ImGuiWindow* window) except +
    void igSetActiveIdUsingAllKeyboardKeys() except +
    void igSetAllocatorFunctions(ImGuiMemAllocFunc alloc_func, ImGuiMemFreeFunc free_func, void* user_data) except +
    void igSetClipboardText(const char* text) except +
    void igSetColorEditOptions(ImGuiColorEditFlags flags) except +
    void igSetColumnOffset(int column_index, float offset_x) except +
    void igSetColumnWidth(int column_index, float width) except +
    void igSetCurrentContext(ImGuiContext* ctx) except +
    void igSetCurrentFont(ImFont* font) except +
    void igSetCurrentViewport(ImGuiWindow* window, ImGuiViewportP* viewport) except +
    void igSetCursorPos(const ImVec2 local_pos) except +
    void igSetCursorPosX(float local_x) except +
    void igSetCursorPosY(float local_y) except +
    void igSetCursorScreenPos(const ImVec2 pos) except +
    void igSetFocusID(ImGuiID id_, ImGuiWindow* window) except +
    void igSetHoveredID(ImGuiID id_) except +
    void igSetItemAllowOverlap() except +
    void igSetItemDefaultFocus() except +
    void igSetItemKeyOwner(ImGuiKey key, ImGuiInputFlags flags) except +
    void igSetKeyOwner(ImGuiKey key, ImGuiID owner_id, ImGuiInputFlags flags) except +
    void igSetKeyboardFocusHere(int offset) except +
    void igSetLastItemData(ImGuiID item_id, ImGuiItemFlags in_flags, ImGuiItemStatusFlags status_flags, const ImRect item_rect) except +
    void igSetMouseCursor(ImGuiMouseCursor cursor_type) except +
    void igSetNavID(ImGuiID id_, ImGuiNavLayer nav_layer, ImGuiID focus_scope_id, const ImRect rect_rel) except +
    void igSetNavWindow(ImGuiWindow* window) except +
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
    void igSetNextWindowSizeConstraints(const ImVec2 size_min, const ImVec2 size_max, ImGuiSizeCallback custom_callback, void* custom_callback_data) except +
    void igSetNextWindowViewport(ImGuiID viewport_id) except +
    void igSetScrollFromPosX_Float(float local_x, float center_x_ratio) except +
    void igSetScrollFromPosX_WindowPtr(ImGuiWindow* window, float local_x, float center_x_ratio) except +
    void igSetScrollFromPosY_Float(float local_y, float center_y_ratio) except +
    void igSetScrollFromPosY_WindowPtr(ImGuiWindow* window, float local_y, float center_y_ratio) except +
    void igSetScrollHereX(float center_x_ratio) except +
    void igSetScrollHereY(float center_y_ratio) except +
    void igSetScrollX_Float(float scroll_x) except +
    void igSetScrollX_WindowPtr(ImGuiWindow* window, float scroll_x) except +
    void igSetScrollY_Float(float scroll_y) except +
    void igSetScrollY_WindowPtr(ImGuiWindow* window, float scroll_y) except +
    void igSetStateStorage(ImGuiStorage* storage) except +
    void igSetTabItemClosed(const char* tab_or_docked_window_label) except +
    void igSetTooltip(const char* fmt) except +
    void igSetTooltipV(const char* fmt, char* args) except +
    void igSetWindowClipRectBeforeSetChannel(ImGuiWindow* window, const ImRect clip_rect) except +
    void igSetWindowCollapsed_Bool(bool collapsed, ImGuiCond cond) except +
    void igSetWindowCollapsed_Str(const char* name, bool collapsed, ImGuiCond cond) except +
    void igSetWindowCollapsed_WindowPtr(ImGuiWindow* window, bool collapsed, ImGuiCond cond) except +
    void igSetWindowDock(ImGuiWindow* window, ImGuiID dock_id, ImGuiCond cond) except +
    void igSetWindowFocus_Nil() except +
    void igSetWindowFocus_Str(const char* name) except +
    void igSetWindowFontScale(float scale) except +
    void igSetWindowHitTestHole(ImGuiWindow* window, const ImVec2 pos, const ImVec2 size) except +
    void igSetWindowPos_Str(const char* name, const ImVec2 pos, ImGuiCond cond) except +
    void igSetWindowPos_Vec2(const ImVec2 pos, ImGuiCond cond) except +
    void igSetWindowPos_WindowPtr(ImGuiWindow* window, const ImVec2 pos, ImGuiCond cond) except +
    void igSetWindowSize_Str(const char* name, const ImVec2 size, ImGuiCond cond) except +
    void igSetWindowSize_Vec2(const ImVec2 size, ImGuiCond cond) except +
    void igSetWindowSize_WindowPtr(ImGuiWindow* window, const ImVec2 size, ImGuiCond cond) except +
    void igSetWindowViewport(ImGuiWindow* window, ImGuiViewportP* viewport) except +
    void igShadeVertsLinearColorGradientKeepAlpha(ImDrawList* draw_list, int vert_start_idx, int vert_end_idx, ImVec2 gradient_p0, ImVec2 gradient_p1, ImU32 col0, ImU32 col1) except +
    void igShadeVertsLinearUV(ImDrawList* draw_list, int vert_start_idx, int vert_end_idx, const ImVec2 a, const ImVec2 b, const ImVec2 uv_a, const ImVec2 uv_b, bool clamp) except +
    void igShowAboutWindow(bool* p_open) except +
    void igShowDebugLogWindow(bool* p_open) except +
    void igShowDemoWindow(bool* p_open) except +
    void igShowFontAtlas(ImFontAtlas* atlas) except +
    void igShowFontSelector(const char* label) except +
    void igShowMetricsWindow(bool* p_open) except +
    void igShowStackToolWindow(bool* p_open) except +
    void igShowStyleEditor(ImGuiStyle* ref) except +
    void igShowUserGuide() except +
    void igShrinkWidths(ImGuiShrinkWidthItem* items, int count, float width_excess) except +
    void igShutdown() except +
    void igSpacing() except +
    void igStartMouseMovingWindow(ImGuiWindow* window) except +
    void igStartMouseMovingWindowOrNode(ImGuiWindow* window, ImGuiDockNode* node, bool undock_floating_node) except +
    void igStyleColorsClassic(ImGuiStyle* dst) except +
    void igStyleColorsDark(ImGuiStyle* dst) except +
    void igStyleColorsLight(ImGuiStyle* dst) except +
    void igTabBarAddTab(ImGuiTabBar* tab_bar, ImGuiTabItemFlags tab_flags, ImGuiWindow* window) except +
    void igTabBarCloseTab(ImGuiTabBar* tab_bar, ImGuiTabItem* tab) except +
    void igTabBarQueueFocus(ImGuiTabBar* tab_bar, ImGuiTabItem* tab) except +
    void igTabBarQueueReorder(ImGuiTabBar* tab_bar, ImGuiTabItem* tab, int offset) except +
    void igTabBarQueueReorderFromMousePos(ImGuiTabBar* tab_bar, ImGuiTabItem* tab, ImVec2 mouse_pos) except +
    void igTabBarRemoveTab(ImGuiTabBar* tab_bar, ImGuiID tab_id) except +
    void igTabItemBackground(ImDrawList* draw_list, const ImRect bb, ImGuiTabItemFlags flags, ImU32 col) except +
    void igTabItemCalcSize_Str(ImVec2* pOut, const char* label, bool has_close_button_or_unsaved_marker) except +
    void igTabItemCalcSize_WindowPtr(ImVec2* pOut, ImGuiWindow* window) except +
    void igTabItemLabelAndCloseButton(ImDrawList* draw_list, const ImRect bb, ImGuiTabItemFlags flags, ImVec2 frame_padding, const char* label, ImGuiID tab_id, ImGuiID close_button_id, bool is_contents_visible, bool* out_just_closed, bool* out_text_clipped) except +
    void igTableBeginApplyRequests(ImGuiTable* table) except +
    void igTableBeginCell(ImGuiTable* table, int column_n) except +
    void igTableBeginInitMemory(ImGuiTable* table, int columns_count) except +
    void igTableBeginRow(ImGuiTable* table) except +
    void igTableDrawBorders(ImGuiTable* table) except +
    void igTableDrawContextMenu(ImGuiTable* table) except +
    void igTableEndCell(ImGuiTable* table) except +
    void igTableEndRow(ImGuiTable* table) except +
    void igTableFixColumnSortDirection(ImGuiTable* table, ImGuiTableColumn* column) except +
    void igTableGcCompactSettings() except +
    void igTableGcCompactTransientBuffers_TablePtr(ImGuiTable* table) except +
    void igTableGcCompactTransientBuffers_TableTempDataPtr(ImGuiTableTempData* table) except +
    void igTableGetCellBgRect(ImRect* pOut, const ImGuiTable* table, int column_n) except +
    void igTableHeader(const char* label) except +
    void igTableHeadersRow() except +
    void igTableLoadSettings(ImGuiTable* table) except +
    void igTableMergeDrawChannels(ImGuiTable* table) except +
    void igTableNextRow(ImGuiTableRowFlags row_flags, float min_row_height) except +
    void igTableOpenContextMenu(int column_n) except +
    void igTablePopBackgroundChannel() except +
    void igTablePushBackgroundChannel() except +
    void igTableRemove(ImGuiTable* table) except +
    void igTableResetSettings(ImGuiTable* table) except +
    void igTableSaveSettings(ImGuiTable* table) except +
    void igTableSetBgColor(ImGuiTableBgTarget target, ImU32 color, int column_n) except +
    void igTableSetColumnEnabled(int column_n, bool v) except +
    void igTableSetColumnSortDirection(int column_n, ImGuiSortDirection sort_direction, bool append_to_sort_specs) except +
    void igTableSetColumnWidth(int column_n, float width) except +
    void igTableSetColumnWidthAutoAll(ImGuiTable* table) except +
    void igTableSetColumnWidthAutoSingle(ImGuiTable* table, int column_n) except +
    void igTableSettingsAddSettingsHandler() except +
    void igTableSetupColumn(const char* label, ImGuiTableColumnFlags flags, float init_width_or_weight, ImGuiID user_id) except +
    void igTableSetupDrawChannels(ImGuiTable* table) except +
    void igTableSetupScrollFreeze(int cols, int rows) except +
    void igTableSortSpecsBuild(ImGuiTable* table) except +
    void igTableSortSpecsSanitize(ImGuiTable* table) except +
    void igTableUpdateBorders(ImGuiTable* table) except +
    void igTableUpdateColumnsWeightFromWidth(ImGuiTable* table) except +
    void igTableUpdateLayout(ImGuiTable* table) except +
    void igText(const char* fmt) except +
    void igTextColored(const ImVec4 col, const char* fmt) except +
    void igTextColoredV(const ImVec4 col, const char* fmt, char* args) except +
    void igTextDisabled(const char* fmt) except +
    void igTextDisabledV(const char* fmt, char* args) except +
    void igTextEx(const char* text, const char* text_end, ImGuiTextFlags flags) except +
    void igTextUnformatted(const char* text, const char* text_end) except +
    void igTextV(const char* fmt, char* args) except +
    void igTextWrapped(const char* fmt) except +
    void igTextWrappedV(const char* fmt, char* args) except +
    void igTranslateWindowsInViewport(ImGuiViewportP* viewport, const ImVec2 old_pos, const ImVec2 new_pos) except +
    void igTreeNodeSetOpen(ImGuiID id_, bool open_) except +
    void igTreePop() except +
    void igTreePushOverrideID(ImGuiID id_) except +
    void igTreePush_Ptr(const void* ptr_id) except +
    void igTreePush_Str(const char* str_id) except +
    void igUnindent(float indent_w) except +
    void igUpdateHoveredWindowAndCaptureFlags() except +
    void igUpdateInputEvents(bool trickle_fast_inputs) except +
    void igUpdateMouseMovingWindowEndFrame() except +
    void igUpdateMouseMovingWindowNewFrame() except +
    void igUpdatePlatformWindows() except +
    void igUpdateWindowParentAndRootLinks(ImGuiWindow* window, ImGuiWindowFlags flags, ImGuiWindow* parent_window) except +
    void igValue_Bool(const char* prefix, bool b) except +
    void igValue_Float(const char* prefix, float v, const char* float_format) except +
    void igValue_Int(const char* prefix, int v) except +
    void igValue_Uint(const char* prefix, unsigned int v) except +
    void igWindowRectAbsToRel(ImRect* pOut, ImGuiWindow* window, const ImRect r) except +
    void igWindowRectRelToAbs(ImRect* pOut, ImGuiWindow* window, const ImRect r) except +
    void* ImGuiStorage_GetVoidPtr(ImGuiStorage* self, ImGuiID key) except +
    void* igImFileLoadToMemory(const char* filename, const char* mode, size_t* out_file_size, int padding_bytes) except +
    void* igMemAlloc(size_t size) except +
    void** ImGuiStorage_GetVoidPtrRef(ImGuiStorage* self, ImGuiID key, void* default_val) except +
