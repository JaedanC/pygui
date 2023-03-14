# -*- coding: utf-8 -*-
# distutils: language = c++

from libcpp cimport bool

cdef extern from "cimgui.h":
    # ====
    # Forward declarations
    ctypedef struct ImDrawChannel
    ctypedef struct ImDrawCmd
    ctypedef struct ImDrawData
    ctypedef struct ImDrawList
    ctypedef struct ImDrawListSharedData
    ctypedef struct ImDrawListSplitter
    ctypedef struct ImDrawVert
    ctypedef struct ImFont
    ctypedef struct ImFontAtlas
    ctypedef struct ImFontBuilderIO
    ctypedef struct ImFontConfig
    ctypedef struct ImFontGlyph
    ctypedef struct ImFontGlyphRangesBuilder
    ctypedef struct ImColor
    ctypedef struct ImGuiContext
    ctypedef struct ImGuiIO
    ctypedef struct ImGuiInputTextCallbackData
    ctypedef struct ImGuiKeyData
    ctypedef struct ImGuiListClipper
    ctypedef struct ImGuiOnceUponAFrame
    ctypedef struct ImGuiPayload
    ctypedef struct ImGuiPlatformIO
    ctypedef struct ImGuiPlatformMonitor
    ctypedef struct ImGuiPlatformImeData
    ctypedef struct ImGuiSizeCallbackData
    ctypedef struct ImGuiStorage
    ctypedef struct ImGuiStyle
    ctypedef struct ImGuiTableSortSpecs
    ctypedef struct ImGuiTableColumnSortSpecs
    ctypedef struct ImGuiTextBuffer
    ctypedef struct ImGuiTextFilter
    ctypedef struct ImGuiViewport
    ctypedef struct ImGuiWindowClass
    ctypedef struct ImBitVector
    ctypedef struct ImRect
    ctypedef struct ImDrawDataBuilder
    ctypedef struct ImGuiColorMod
    ctypedef struct ImGuiContextHook
    ctypedef struct ImGuiDataTypeInfo
    ctypedef struct ImGuiDockContext
    ctypedef struct ImGuiDockRequest
    ctypedef struct ImGuiDockNode
    ctypedef struct ImGuiDockNodeSettings
    ctypedef struct ImGuiGroupData
    ctypedef struct ImGuiInputTextState
    ctypedef struct ImGuiLastItemData
    ctypedef struct ImGuiLocEntry
    ctypedef struct ImGuiMenuColumns
    ctypedef struct ImGuiNavItemData
    ctypedef struct ImGuiMetricsConfig
    ctypedef struct ImGuiNextWindowData
    ctypedef struct ImGuiNextItemData
    ctypedef struct ImGuiOldColumnData
    ctypedef struct ImGuiOldColumns
    ctypedef struct ImGuiPopupData
    ctypedef struct ImGuiSettingsHandler
    ctypedef struct ImGuiStackSizes
    ctypedef struct ImGuiStyleMod
    ctypedef struct ImGuiTabBar
    ctypedef struct ImGuiTabItem
    ctypedef struct ImGuiTable
    ctypedef struct ImGuiTableColumn
    ctypedef struct ImGuiTableInstanceData
    ctypedef struct ImGuiTableTempData
    ctypedef struct ImGuiTableSettings
    ctypedef struct ImGuiTableColumnsSettings
    ctypedef struct ImGuiWindow
    ctypedef struct ImGuiWindowTempData
    ctypedef struct ImGuiWindowSettings
    ctypedef struct ImVector_const_charPtr

    # # ====
    # # Various int typedefs and enumerations
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
    ctypedef int (*ImGuiInputTextCallback)(ImGuiInputTextCallbackData* data)
    ctypedef void (*ImGuiSizeCallback)(ImGuiSizeCallbackData* data)
    ctypedef void* (*ImGuiMemAllocFunc)(size_t sz, void* user_data)
    ctypedef void (*ImGuiMemFreeFunc)(void* ptr, void* user_data)
    
    # # Don't know if this will work
    # ctypedef char* va_list

    # # -----------------------

    ctypedef struct ImVec2:
        float x, y
    
    ctypedef struct ImVec4:
        float x, y, z, w

    # # # -----------------------

    # ctypedef struct ImGuiStyle:
    #     float Alpha
    #     float DisabledAlpha
    #     ImVec2 WindowPadding
    #     float WindowRounding
    #     float WindowBorderSize
    #     ImVec2 WindowMinSize
    #     ImVec2 WindowTitleAlign
    #     ImGuiDir WindowMenuButtonPosition
    #     float ChildRounding
    #     float ChildBorderSize
    #     float PopupRounding
    #     float PopupBorderSize
    #     ImVec2 FramePadding
    #     float FrameRounding
    #     float FrameBorderSize
    #     ImVec2 ItemSpacing
    #     ImVec2 ItemInnerSpacing
    #     ImVec2 CellPadding
    #     ImVec2 TouchExtraPadding
    #     float IndentSpacing
    #     float ColumnsMinSpacing
    #     float ScrollbarSize
    #     float ScrollbarRounding
    #     float GrabMinSize
    #     float GrabRounding
    #     float LogSliderDeadzone
    #     float TabRounding
    #     float TabBorderSize
    #     float TabMinWidthForCloseButton
    #     ImGuiDir ColorButtonPosition
    #     ImVec2 ButtonTextAlign
    #     ImVec2 SelectableTextAlign
    #     float SeparatorTextBorderSize
    #     ImVec2 SeparatorTextAlign
    #     ImVec2 SeparatorTextPadding
    #     ImVec2 DisplayWindowPadding
    #     ImVec2 DisplaySafeAreaPadding
    #     float MouseCursorScale
    #     bool AntiAliasedLines
    #     bool AntiAliasedLinesUseTex
    #     bool AntiAliasedFill
    #     float CurveTessellationTol
    #     float CircleTessellationMaxError
    #     # note: originally ImVec4 Colors[ImGuiCol_COUNT]
    #     # todo: find a way to access enum var here
    #     ImVec4*     Colors
    
    # ctypedef struct ImGuiKeyData:
    #     bool Down
    #     float DownDuration
    #     float DownDurationPrev
    #     float AnalogValue

    ctypedef struct ImVector_ImWchar:
        int Size
        int Capacity
        ImWchar* Data

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
        ImFontAtlas*Fonts
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
        # note: originally int KeyMap[ImGuiKey_COUNT]
        # todo: find a way to access enum var here
        int*          KeyMap
        # note: originally bool KeysDown[ImGuiKey_COUNT]
        # todo: find a way to access enum var here
        bool* KeysDown
        # note: originally float NavInputs[ImGuiNavInput_COUNT]
        # todo: find a way to access enum var here
        float* NavInputs
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
        # note: originally ImGuiKeyData KeysData[ImGuiKey_KeysData_SIZE]
        # todo: find a way to access enum var here
        ImGuiKeyData* KeysData
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

    # ctypedef struct ImGuiInputTextCallbackData:
    #     ImGuiInputTextFlags EventFlag
    #     ImGuiInputTextFlags Flags
    #     void* UserData
    #     ImWchar EventChar
    #     ImGuiKey EventKey
    #     char* Buf
    #     int BufTextLen
    #     int BufSize
    #     bool BufDirty
    #     int CursorPos
    #     int SelectionStart
    #     int SelectionEnd

    # ctypedef struct ImGuiSizeCallbackData:
    #     void* UserData
    #     ImVec2 Pos
    #     ImVec2 CurrentSize
    #     ImVec2 DesiredSize

    # ctypedef struct ImGuiWindowClass:
    #     ImGuiID ClassId
    #     ImGuiID ParentViewportId
    #     ImGuiViewportFlags ViewportFlagsOverrideSet
    #     ImGuiViewportFlags ViewportFlagsOverrideClear
    #     ImGuiTabItemFlags TabItemFlagsOverrideSet
    #     ImGuiDockNodeFlags DockNodeFlagsOverrideSet
    #     bool DockingAlwaysTabBar
    #     bool DockingAllowUnclassed

    # ctypedef struct ImGuiPayload:
    #     void* Data
    #     int DataSize
    #     ImGuiID SourceId
    #     ImGuiID SourceParentId
    #     int DataFrameCount
    #     char DataType[33]
    #     bool Preview
    #     bool Delivery

    # ctypedef struct ImGuiTableColumnSortSpecs:
    #     ImGuiID ColumnUserID
    #     ImS16 ColumnIndex
    #     ImS16 SortOrder
    #     # Came from ImGuiSortDirection SortDirection : 8
    #     ImGuiSortDirection SortDirection

    # ctypedef struct ImGuiOnceUponAFrame:
    #     int RefFrame

    # ctypedef struct ImGuiTextRange:
    #     const char* b
    #     const char* e

    # ctypedef struct ImVector_ImGuiTextRange:
    #     int Size
    #     int Capacity
    #     ImGuiTextRange* Data

    # ctypedef struct ImGuiTextFilter:
    #     char InputBuf[256]
    #     ImVector_ImGuiTextRange Filters
    #     int CountGrep

    # ctypedef struct ImVector_char:
    #     int Size
    #     int Capacity
    #     char* Data

    # ctypedef struct ImGuiTextBuffer:
    #     ImVector_char Buf

    # ctypedef struct ImGuiStoragePair:
    #     ImGuiID key
    #     # Came from a Union. Apparently this works
    #     int val_i
    #     float val_f
    #     void* val_p

    # ctypedef struct ImVector_ImGuiStoragePair:
    #     int Size
    #     int Capacity
    #     ImGuiStoragePair* Data

    # ctypedef struct ImGuiStorage:
    #     ImVector_ImGuiStoragePair Data

    # ctypedef struct ImGuiListClipper:
    #     int DisplayStart
    #     int DisplayEnd
    #     int ItemsCount
    #     float ItemsHeight
    #     float StartPosY
    #     void* TempData

    # ctypedef struct ImColor:
    #     ImVec4 Value

    # ctypedef void (*ImDrawCallback)(const ImDrawList* parent_list, const ImDrawCmd* cmd)

    # ctypedef struct ImDrawCmd:
    #     ImVec4 ClipRect
    #     ImTextureID TextureId
    #     unsigned int VtxOffset
    #     unsigned int IdxOffset
    #     unsigned int ElemCount
    #     ImDrawCallback UserCallback
    #     void* UserCallbackData

    ctypedef struct ImDrawVert:
        ImVec2 pos
        ImVec2 uv
        ImU32 col

    ctypedef struct ImDrawCmdHeader:
        ImVec4 ClipRect
        ImTextureID TextureId
        unsigned int VtxOffset

    ctypedef struct ImVector_ImDrawCmd:
        int Size
        int Capacity
        ImDrawCmd* Data

    ctypedef struct ImVector_ImDrawIdx:
        int Size
        int Capacity
        ImDrawIdx* Data

    ctypedef struct ImDrawChannel:
        ImVector_ImDrawCmd _CmdBuffer
        ImVector_ImDrawIdx _IdxBuffer

    ctypedef struct ImVector_ImDrawChannel:
        int Size
        int Capacity
        ImDrawChannel* Data

    ctypedef struct ImDrawListSplitter:
        int _Current
        int _Count
        ImVector_ImDrawChannel _Channels

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

    # ctypedef struct ImFontConfig:
    #     void* FontData
    #     int FontDataSize
    #     bool FontDataOwnedByAtlas
    #     int FontNo
    #     float SizePixels
    #     int OversampleH
    #     int OversampleV
    #     bool PixelSnapH
    #     ImVec2 GlyphExtraSpacing
    #     ImVec2 GlyphOffset
    #     const ImWchar* GlyphRanges
    #     float GlyphMinAdvanceX
    #     float GlyphMaxAdvanceX
    #     bool MergeMode
    #     unsigned int FontBuilderFlags
    #     float RasterizerMultiply
    #     ImWchar EllipsisChar
    #     char Name[40]
    #     ImFont* DstFont

    # ctypedef struct ImFontGlyph:
    #     # From unsigned int Colored : 1
    #     unsigned int Colored
    #     # From unsigned int Visible : 1
    #     unsigned int Visible
    #     # From unsigned int Codepoint : 30
    #     unsigned int Codepoint
    #     float AdvanceX
    #     float X0, Y0, X1, Y1
    #     float U0, V0, U1, V1

    # ctypedef struct ImVector_ImU32:
    #     int Size
    #     int Capacity
    #     ImU32* Data

    # ctypedef struct ImFontGlyphRangesBuilder:
    #     ImVector_ImU32 UsedChars

    ctypedef struct ImFontAtlasCustomRect:
        unsigned short Width, Height
        unsigned short X, Y
        unsigned int GlyphID
        float GlyphAdvanceX
        ImVec2 GlyphOffset
        ImFont* Font

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
        # From ImVec4 TexUvLines[(63) + 1]
        ImVec4 TexUvLines[64]
        const ImFontBuilderIO* FontBuilderIO
        unsigned int FontBuilderFlags
        int PackIdMouseCursors
        int PackIdLines

    # ctypedef struct ImVector_float:
    #     int Size
    #     int Capacity
    #     float* Data

    # ctypedef struct ImVector_ImFontGlyph:
    #     int Size
    #     int Capacity
    #     ImFontGlyph* Data

    # ctypedef struct ImFont:
    #     ImVector_float IndexAdvanceX
    #     float FallbackAdvanceX
    #     float FontSize
    #     ImVector_ImWchar IndexLookup
    #     ImVector_ImFontGlyph Glyphs
    #     const ImFontGlyph* FallbackGlyph
    #     ImFontAtlas* ContainerAtlas
    #     const ImFontConfig* ConfigData
    #     short ConfigDataCount
    #     ImWchar FallbackChar
    #     ImWchar EllipsisChar
    #     short EllipsisCharCount
    #     float EllipsisWidth
    #     float EllipsisCharStep
    #     bool DirtyLookupTables
    #     float Scale
    #     float Ascent, Descent
    #     int MetricsTotalSurface
    #     # From ImU8 Used4kPagesMap[(0xFFFF +1)/4096/8]
    #     ImU8* Used4kPagesMap

    # ctypedef struct ImGuiViewport:
    #     ImGuiID ID
    #     ImGuiViewportFlags Flags
    #     ImVec2 Pos
    #     ImVec2 Size
    #     ImVec2 WorkPos
    #     ImVec2 WorkSize
    #     float DpiScale
    #     ImGuiID ParentViewportId
    #     ImDrawData* DrawData
    #     void* RendererUserData
    #     void* PlatformUserData
    #     void* PlatformHandle
    #     void* PlatformHandleRaw
    #     bool PlatformWindowCreated
    #     bool PlatformRequestMove
    #     bool PlatformRequestResize
    #     bool PlatformRequestClose

    # ctypedef struct ImVector_ImGuiPlatformMonitor:
    #     int Size
    #     int Capacity
    #     ImGuiPlatformMonitor* Data

    # ctypedef struct ImVector_ImGuiViewportPtr:
    #     int Size
    #     int Capacity
    #     ImGuiViewport** Data

    # ctypedef struct ImGuiPlatformIO:
    #     void (*Platform_CreateWindow)(ImGuiViewport* vp)
    #     void (*Platform_DestroyWindow)(ImGuiViewport* vp)
    #     void (*Platform_ShowWindow)(ImGuiViewport* vp)
    #     void (*Platform_SetWindowPos)(ImGuiViewport* vp, ImVec2 pos)
    #     ImVec2 (*Platform_GetWindowPos)(ImGuiViewport* vp)
    #     void (*Platform_SetWindowSize)(ImGuiViewport* vp, ImVec2 size)
    #     ImVec2 (*Platform_GetWindowSize)(ImGuiViewport* vp)
    #     void (*Platform_SetWindowFocus)(ImGuiViewport* vp)
    #     bool (*Platform_GetWindowFocus)(ImGuiViewport* vp)
    #     bool (*Platform_GetWindowMinimized)(ImGuiViewport* vp)
    #     void (*Platform_SetWindowTitle)(ImGuiViewport* vp, const char* str)
    #     void (*Platform_SetWindowAlpha)(ImGuiViewport* vp, float alpha)
    #     void (*Platform_UpdateWindow)(ImGuiViewport* vp)
    #     void (*Platform_RenderWindow)(ImGuiViewport* vp, void* render_arg)
    #     void (*Platform_SwapBuffers)(ImGuiViewport* vp, void* render_arg)
    #     float (*Platform_GetWindowDpiScale)(ImGuiViewport* vp)
    #     void (*Platform_OnChangedViewport)(ImGuiViewport* vp)
    #     int (*Platform_CreateVkSurface)(ImGuiViewport* vp, ImU64 vk_inst, const void* vk_allocators, ImU64* out_vk_surface)
    #     void (*Renderer_CreateWindow)(ImGuiViewport* vp)
    #     void (*Renderer_DestroyWindow)(ImGuiViewport* vp)
    #     void (*Renderer_SetWindowSize)(ImGuiViewport* vp, ImVec2 size)
    #     void (*Renderer_RenderWindow)(ImGuiViewport* vp, void* render_arg)
    #     void (*Renderer_SwapBuffers)(ImGuiViewport* vp, void* render_arg)
    #     ImVector_ImGuiPlatformMonitor Monitors
    #     ImVector_ImGuiViewportPtr Viewports

    # ctypedef struct ImGuiPlatformMonitor:
    #     ImVec2 MainPos, MainSize
    #     ImVec2 WorkPos, WorkSize
    #     float DpiScale

    # ctypedef struct ImGuiPlatformImeData:
    #     bool WantVisible
    #     ImVec2 InputPos
    #     float InputLineHeight



    # ImVec2* ImVec2_ImVec2_Nil()
    # void ImVec2_destroy(ImVec2* self)
    # ImVec2* ImVec2_ImVec2_Float(float _x,float _y)
    # ImVec4* ImVec4_ImVec4_Nil()
    # void ImVec4_destroy(ImVec4* self)
    # ImVec4* ImVec4_ImVec4_Float(float _x,float _y,float _z,float _w)
    ImGuiContext* igCreateContext(ImFontAtlas* shared_font_atlas)
    void igDestroyContext(ImGuiContext* ctx)
    ImGuiContext* igGetCurrentContext()
    # void igSetCurrentContext(ImGuiContext* ctx)
    ImGuiIO* igGetIO()
    # ImGuiStyle* igGetStyle()
    void igNewFrame()
    # void igEndFrame()
    void igRender()
    ImDrawData* igGetDrawData()
    void igShowDemoWindow(bool* p_open)
    # void igShowMetricsWindow(bool* p_open)
    # void igShowDebugLogWindow(bool* p_open)
    # void igShowStackToolWindow(bool* p_open)
    # void igShowAboutWindow(bool* p_open)
    # void igShowStyleEditor(ImGuiStyle* ref)
    # bool igShowStyleSelector(const char* label)
    # void igShowFontSelector(const char* label)
    # void igShowUserGuide()
    # const char* igGetVersion()
    # void igStyleColorsDark(ImGuiStyle* dst)
    # void igStyleColorsLight(ImGuiStyle* dst)
    # void igStyleColorsClassic(ImGuiStyle* dst)
    # bool igBegin(const char* name,bool* p_open,ImGuiWindowFlags flags)
    # void igEnd()
    # bool igBeginChild_Str(const char* str_id,const ImVec2 size,bool border,ImGuiWindowFlags flags)
    # bool igBeginChild_ID(ImGuiID id,const ImVec2 size,bool border,ImGuiWindowFlags flags)
    # void igEndChild()
    # bool igIsWindowAppearing()
    # bool igIsWindowCollapsed()
    # bool igIsWindowFocused(ImGuiFocusedFlags flags)
    # bool igIsWindowHovered(ImGuiHoveredFlags flags)
    # ImDrawList* igGetWindowDrawList()
    # float igGetWindowDpiScale()
    # void igGetWindowPos(ImVec2 *pOut)
    # void igGetWindowSize(ImVec2 *pOut)
    # float igGetWindowWidth()
    # float igGetWindowHeight()
    # ImGuiViewport* igGetWindowViewport()
    # void igSetNextWindowPos(const ImVec2 pos,ImGuiCond cond,const ImVec2 pivot)
    # void igSetNextWindowSize(const ImVec2 size,ImGuiCond cond)
    # void igSetNextWindowSizeConstraints(const ImVec2 size_min,const ImVec2 size_max,ImGuiSizeCallback custom_callback,void* custom_callback_data)
    # void igSetNextWindowContentSize(const ImVec2 size)
    # void igSetNextWindowCollapsed(bool collapsed,ImGuiCond cond)
    # void igSetNextWindowFocus()
    # void igSetNextWindowScroll(const ImVec2 scroll)
    # void igSetNextWindowBgAlpha(float alpha)
    # void igSetNextWindowViewport(ImGuiID viewport_id)
    # void igSetWindowPos_Vec2(const ImVec2 pos,ImGuiCond cond)
    # void igSetWindowSize_Vec2(const ImVec2 size,ImGuiCond cond)
    # void igSetWindowCollapsed_Bool(bool collapsed,ImGuiCond cond)
    # void igSetWindowFocus_Nil()
    # void igSetWindowFontScale(float scale)
    # void igSetWindowPos_Str(const char* name,const ImVec2 pos,ImGuiCond cond)
    # void igSetWindowSize_Str(const char* name,const ImVec2 size,ImGuiCond cond)
    # void igSetWindowCollapsed_Str(const char* name,bool collapsed,ImGuiCond cond)
    # void igSetWindowFocus_Str(const char* name)
    # void igGetContentRegionAvail(ImVec2 *pOut)
    # void igGetContentRegionMax(ImVec2 *pOut)
    # void igGetWindowContentRegionMin(ImVec2 *pOut)
    # void igGetWindowContentRegionMax(ImVec2 *pOut)
    # float igGetScrollX()
    # float igGetScrollY()
    # void igSetScrollX_Float(float scroll_x)
    # void igSetScrollY_Float(float scroll_y)
    # float igGetScrollMaxX()
    # float igGetScrollMaxY()
    # void igSetScrollHereX(float center_x_ratio)
    # void igSetScrollHereY(float center_y_ratio)
    # void igSetScrollFromPosX_Float(float local_x,float center_x_ratio)
    # void igSetScrollFromPosY_Float(float local_y,float center_y_ratio)
    # void igPushFont(ImFont* font)
    # void igPopFont()
    # void igPushStyleColor_U32(ImGuiCol idx,ImU32 col)
    # void igPushStyleColor_Vec4(ImGuiCol idx,const ImVec4 col)
    # void igPopStyleColor(int count)
    # void igPushStyleVar_Float(ImGuiStyleVar idx,float val)
    # void igPushStyleVar_Vec2(ImGuiStyleVar idx,const ImVec2 val)
    # void igPopStyleVar(int count)
    # void igPushAllowKeyboardFocus(bool allow_keyboard_focus)
    # void igPopAllowKeyboardFocus()
    # void igPushButtonRepeat(bool repeat)
    # void igPopButtonRepeat()
    # void igPushItemWidth(float item_width)
    # void igPopItemWidth()
    # void igSetNextItemWidth(float item_width)
    # float igCalcItemWidth()
    # void igPushTextWrapPos(float wrap_local_pos_x)
    # void igPopTextWrapPos()
    # ImFont* igGetFont()
    # float igGetFontSize()
    # void igGetFontTexUvWhitePixel(ImVec2 *pOut)
    # ImU32 igGetColorU32_Col(ImGuiCol idx,float alpha_mul)
    # ImU32 igGetColorU32_Vec4(const ImVec4 col)
    # ImU32 igGetColorU32_U32(ImU32 col)
    # const ImVec4* igGetStyleColorVec4(ImGuiCol idx)
    # void igSeparator()
    # void igSameLine(float offset_from_start_x,float spacing)
    # void igNewLine()
    # void igSpacing()
    # void igDummy(const ImVec2 size)
    # void igIndent(float indent_w)
    # void igUnindent(float indent_w)
    # void igBeginGroup()
    # void igEndGroup()
    # void igGetCursorPos(ImVec2 *pOut)
    # float igGetCursorPosX()
    # float igGetCursorPosY()
    # void igSetCursorPos(const ImVec2 local_pos)
    # void igSetCursorPosX(float local_x)
    # void igSetCursorPosY(float local_y)
    # void igGetCursorStartPos(ImVec2 *pOut)
    # void igGetCursorScreenPos(ImVec2 *pOut)
    # void igSetCursorScreenPos(const ImVec2 pos)
    # void igAlignTextToFramePadding()
    # float igGetTextLineHeight()
    # float igGetTextLineHeightWithSpacing()
    # float igGetFrameHeight()
    # float igGetFrameHeightWithSpacing()
    # void igPushID_Str(const char* str_id)
    # void igPushID_StrStr(const char* str_id_begin,const char* str_id_end)
    # void igPushID_Ptr(const void* ptr_id)
    # void igPushID_Int(int int_id)
    # void igPopID()
    # ImGuiID igGetID_Str(const char* str_id)
    # ImGuiID igGetID_StrStr(const char* str_id_begin,const char* str_id_end)
    # ImGuiID igGetID_Ptr(const void* ptr_id)
    # void igTextUnformatted(const char* text,const char* text_end)
    # void igText(const char* fmt,...)
    # void igTextV(const char* fmt,va_list args)
    # void igTextColored(const ImVec4 col,const char* fmt,...)
    # void igTextColoredV(const ImVec4 col,const char* fmt,va_list args)
    # void igTextDisabled(const char* fmt,...)
    # void igTextDisabledV(const char* fmt,va_list args)
    # void igTextWrapped(const char* fmt,...)
    # void igTextWrappedV(const char* fmt,va_list args)
    # void igLabelText(const char* label,const char* fmt,...)
    # void igLabelTextV(const char* label,const char* fmt,va_list args)
    # void igBulletText(const char* fmt,...)
    # void igBulletTextV(const char* fmt,va_list args)
    # void igSeparatorText(const char* label)
    # bool igButton(const char* label,const ImVec2 size)
    # bool igSmallButton(const char* label)
    # bool igInvisibleButton(const char* str_id,const ImVec2 size,ImGuiButtonFlags flags)
    # bool igArrowButton(const char* str_id,ImGuiDir dir)
    # bool igCheckbox(const char* label,bool* v)
    # bool igCheckboxFlags_IntPtr(const char* label,int* flags,int flags_value)
    # bool igCheckboxFlags_UintPtr(const char* label,unsigned int* flags,unsigned int flags_value)
    # bool igRadioButton_Bool(const char* label,bool active)
    # bool igRadioButton_IntPtr(const char* label,int* v,int v_button)
    # void igProgressBar(float fraction,const ImVec2 size_arg,const char* overlay)
    # void igBullet()
    # void igImage(ImTextureID user_texture_id,const ImVec2 size,const ImVec2 uv0,const ImVec2 uv1,const ImVec4 tint_col,const ImVec4 border_col)
    # bool igImageButton(const char* str_id,ImTextureID user_texture_id,const ImVec2 size,const ImVec2 uv0,const ImVec2 uv1,const ImVec4 bg_col,const ImVec4 tint_col)
    # bool igBeginCombo(const char* label,const char* preview_value,ImGuiComboFlags flags)
    # void igEndCombo()
    # bool igCombo_Str_arr(const char* label,int* current_item,const char* const items[],int items_count,int popup_max_height_in_items)
    # bool igCombo_Str(const char* label,int* current_item,const char* items_separated_by_zeros,int popup_max_height_in_items)
    # bool igCombo_FnBoolPtr(const char* label,int* current_item,bool(*items_getter)(void* data,int idx,const char** out_text),void* data,int items_count,int popup_max_height_in_items)
    # bool igDragFloat(const char* label,float* v,float v_speed,float v_min,float v_max,const char* format,ImGuiSliderFlags flags)
    # bool igDragFloat2(const char* label,float v[2],float v_speed,float v_min,float v_max,const char* format,ImGuiSliderFlags flags)
    # bool igDragFloat3(const char* label,float v[3],float v_speed,float v_min,float v_max,const char* format,ImGuiSliderFlags flags)
    # bool igDragFloat4(const char* label,float v[4],float v_speed,float v_min,float v_max,const char* format,ImGuiSliderFlags flags)
    # bool igDragFloatRange2(const char* label,float* v_current_min,float* v_current_max,float v_speed,float v_min,float v_max,const char* format,const char* format_max,ImGuiSliderFlags flags)
    # bool igDragInt(const char* label,int* v,float v_speed,int v_min,int v_max,const char* format,ImGuiSliderFlags flags)
    # bool igDragInt2(const char* label,int v[2],float v_speed,int v_min,int v_max,const char* format,ImGuiSliderFlags flags)
    # bool igDragInt3(const char* label,int v[3],float v_speed,int v_min,int v_max,const char* format,ImGuiSliderFlags flags)
    # bool igDragInt4(const char* label,int v[4],float v_speed,int v_min,int v_max,const char* format,ImGuiSliderFlags flags)
    # bool igDragIntRange2(const char* label,int* v_current_min,int* v_current_max,float v_speed,int v_min,int v_max,const char* format,const char* format_max,ImGuiSliderFlags flags)
    # bool igDragScalar(const char* label,ImGuiDataType data_type,void* p_data,float v_speed,const void* p_min,const void* p_max,const char* format,ImGuiSliderFlags flags)
    # bool igDragScalarN(const char* label,ImGuiDataType data_type,void* p_data,int components,float v_speed,const void* p_min,const void* p_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderFloat(const char* label,float* v,float v_min,float v_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderFloat2(const char* label,float v[2],float v_min,float v_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderFloat3(const char* label,float v[3],float v_min,float v_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderFloat4(const char* label,float v[4],float v_min,float v_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderAngle(const char* label,float* v_rad,float v_degrees_min,float v_degrees_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderInt(const char* label,int* v,int v_min,int v_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderInt2(const char* label,int v[2],int v_min,int v_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderInt3(const char* label,int v[3],int v_min,int v_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderInt4(const char* label,int v[4],int v_min,int v_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderScalar(const char* label,ImGuiDataType data_type,void* p_data,const void* p_min,const void* p_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderScalarN(const char* label,ImGuiDataType data_type,void* p_data,int components,const void* p_min,const void* p_max,const char* format,ImGuiSliderFlags flags)
    # bool igVSliderFloat(const char* label,const ImVec2 size,float* v,float v_min,float v_max,const char* format,ImGuiSliderFlags flags)
    # bool igVSliderInt(const char* label,const ImVec2 size,int* v,int v_min,int v_max,const char* format,ImGuiSliderFlags flags)
    # bool igVSliderScalar(const char* label,const ImVec2 size,ImGuiDataType data_type,void* p_data,const void* p_min,const void* p_max,const char* format,ImGuiSliderFlags flags)
    # bool igInputText(const char* label,char* buf,size_t buf_size,ImGuiInputTextFlags flags,ImGuiInputTextCallback callback,void* user_data)
    # bool igInputTextMultiline(const char* label,char* buf,size_t buf_size,const ImVec2 size,ImGuiInputTextFlags flags,ImGuiInputTextCallback callback,void* user_data)
    # bool igInputTextWithHint(const char* label,const char* hint,char* buf,size_t buf_size,ImGuiInputTextFlags flags,ImGuiInputTextCallback callback,void* user_data)
    # bool igInputFloat(const char* label,float* v,float step,float step_fast,const char* format,ImGuiInputTextFlags flags)
    # bool igInputFloat2(const char* label,float v[2],const char* format,ImGuiInputTextFlags flags)
    # bool igInputFloat3(const char* label,float v[3],const char* format,ImGuiInputTextFlags flags)
    # bool igInputFloat4(const char* label,float v[4],const char* format,ImGuiInputTextFlags flags)
    # bool igInputInt(const char* label,int* v,int step,int step_fast,ImGuiInputTextFlags flags)
    # bool igInputInt2(const char* label,int v[2],ImGuiInputTextFlags flags)
    # bool igInputInt3(const char* label,int v[3],ImGuiInputTextFlags flags)
    # bool igInputInt4(const char* label,int v[4],ImGuiInputTextFlags flags)
    # bool igInputDouble(const char* label,double* v,double step,double step_fast,const char* format,ImGuiInputTextFlags flags)
    # bool igInputScalar(const char* label,ImGuiDataType data_type,void* p_data,const void* p_step,const void* p_step_fast,const char* format,ImGuiInputTextFlags flags)
    # bool igInputScalarN(const char* label,ImGuiDataType data_type,void* p_data,int components,const void* p_step,const void* p_step_fast,const char* format,ImGuiInputTextFlags flags)
    # bool igColorEdit3(const char* label,float col[3],ImGuiColorEditFlags flags)
    # bool igColorEdit4(const char* label,float col[4],ImGuiColorEditFlags flags)
    # bool igColorPicker3(const char* label,float col[3],ImGuiColorEditFlags flags)
    # bool igColorPicker4(const char* label,float col[4],ImGuiColorEditFlags flags,const float* ref_col)
    # bool igColorButton(const char* desc_id,const ImVec4 col,ImGuiColorEditFlags flags,const ImVec2 size)
    # void igSetColorEditOptions(ImGuiColorEditFlags flags)
    # bool igTreeNode_Str(const char* label)
    # bool igTreeNode_StrStr(const char* str_id,const char* fmt,...)
    # bool igTreeNode_Ptr(const void* ptr_id,const char* fmt,...)
    # bool igTreeNodeV_Str(const char* str_id,const char* fmt,va_list args)
    # bool igTreeNodeV_Ptr(const void* ptr_id,const char* fmt,va_list args)
    # bool igTreeNodeEx_Str(const char* label,ImGuiTreeNodeFlags flags)
    # bool igTreeNodeEx_StrStr(const char* str_id,ImGuiTreeNodeFlags flags,const char* fmt,...)
    # bool igTreeNodeEx_Ptr(const void* ptr_id,ImGuiTreeNodeFlags flags,const char* fmt,...)
    # bool igTreeNodeExV_Str(const char* str_id,ImGuiTreeNodeFlags flags,const char* fmt,va_list args)
    # bool igTreeNodeExV_Ptr(const void* ptr_id,ImGuiTreeNodeFlags flags,const char* fmt,va_list args)
    # void igTreePush_Str(const char* str_id)
    # void igTreePush_Ptr(const void* ptr_id)
    # void igTreePop()
    # float igGetTreeNodeToLabelSpacing()
    # bool igCollapsingHeader_TreeNodeFlags(const char* label,ImGuiTreeNodeFlags flags)
    # bool igCollapsingHeader_BoolPtr(const char* label,bool* p_visible,ImGuiTreeNodeFlags flags)
    # void igSetNextItemOpen(bool is_open,ImGuiCond cond)
    # bool igSelectable_Bool(const char* label,bool selected,ImGuiSelectableFlags flags,const ImVec2 size)
    # bool igSelectable_BoolPtr(const char* label,bool* p_selected,ImGuiSelectableFlags flags,const ImVec2 size)
    # bool igBeginListBox(const char* label,const ImVec2 size)
    # void igEndListBox()
    # bool igListBox_Str_arr(const char* label,int* current_item,const char* const items[],int items_count,int height_in_items)
    # bool igListBox_FnBoolPtr(const char* label,int* current_item,bool(*items_getter)(void* data,int idx,const char** out_text),void* data,int items_count,int height_in_items)
    # void igPlotLines_FloatPtr(const char* label,const float* values,int values_count,int values_offset,const char* overlay_text,float scale_min,float scale_max,ImVec2 graph_size,int stride)
    # void igPlotLines_FnFloatPtr(const char* label,float(*values_getter)(void* data,int idx),void* data,int values_count,int values_offset,const char* overlay_text,float scale_min,float scale_max,ImVec2 graph_size)
    # void igPlotHistogram_FloatPtr(const char* label,const float* values,int values_count,int values_offset,const char* overlay_text,float scale_min,float scale_max,ImVec2 graph_size,int stride)
    # void igPlotHistogram_FnFloatPtr(const char* label,float(*values_getter)(void* data,int idx),void* data,int values_count,int values_offset,const char* overlay_text,float scale_min,float scale_max,ImVec2 graph_size)
    # void igValue_Bool(const char* prefix,bool b)
    # void igValue_Int(const char* prefix,int v)
    # void igValue_Uint(const char* prefix,unsigned int v)
    # void igValue_Float(const char* prefix,float v,const char* float_format)
    # bool igBeginMenuBar()
    # void igEndMenuBar()
    # bool igBeginMainMenuBar()
    # void igEndMainMenuBar()
    # bool igBeginMenu(const char* label,bool enabled)
    # void igEndMenu()
    # bool igMenuItem_Bool(const char* label,const char* shortcut,bool selected,bool enabled)
    # bool igMenuItem_BoolPtr(const char* label,const char* shortcut,bool* p_selected,bool enabled)
    # void igBeginTooltip()
    # void igEndTooltip()
    # void igSetTooltip(const char* fmt,...)
    # void igSetTooltipV(const char* fmt,va_list args)
    # bool igBeginPopup(const char* str_id,ImGuiWindowFlags flags)
    # bool igBeginPopupModal(const char* name,bool* p_open,ImGuiWindowFlags flags)
    # void igEndPopup()
    # void igOpenPopup_Str(const char* str_id,ImGuiPopupFlags popup_flags)
    # void igOpenPopup_ID(ImGuiID id,ImGuiPopupFlags popup_flags)
    # void igOpenPopupOnItemClick(const char* str_id,ImGuiPopupFlags popup_flags)
    # void igCloseCurrentPopup()
    # bool igBeginPopupContextItem(const char* str_id,ImGuiPopupFlags popup_flags)
    # bool igBeginPopupContextWindow(const char* str_id,ImGuiPopupFlags popup_flags)
    # bool igBeginPopupContextVoid(const char* str_id,ImGuiPopupFlags popup_flags)
    # bool igIsPopupOpen_Str(const char* str_id,ImGuiPopupFlags flags)
    # bool igBeginTable(const char* str_id,int column,ImGuiTableFlags flags,const ImVec2 outer_size,float inner_width)
    # void igEndTable()
    # void igTableNextRow(ImGuiTableRowFlags row_flags,float min_row_height)
    # bool igTableNextColumn()
    # bool igTableSetColumnIndex(int column_n)
    # void igTableSetupColumn(const char* label,ImGuiTableColumnFlags flags,float init_width_or_weight,ImGuiID user_id)
    # void igTableSetupScrollFreeze(int cols,int rows)
    # void igTableHeadersRow()
    # void igTableHeader(const char* label)
    # ImGuiTableSortSpecs* igTableGetSortSpecs()
    # int igTableGetColumnCount()
    # int igTableGetColumnIndex()
    # int igTableGetRowIndex()
    # const char* igTableGetColumnName_Int(int column_n)
    # ImGuiTableColumnFlags igTableGetColumnFlags(int column_n)
    # void igTableSetColumnEnabled(int column_n,bool v)
    # void igTableSetBgColor(ImGuiTableBgTarget target,ImU32 color,int column_n)
    # void igColumns(int count,const char* id,bool border)
    # void igNextColumn()
    # int igGetColumnIndex()
    # float igGetColumnWidth(int column_index)
    # void igSetColumnWidth(int column_index,float width)
    # float igGetColumnOffset(int column_index)
    # void igSetColumnOffset(int column_index,float offset_x)
    # int igGetColumnsCount()
    # bool igBeginTabBar(const char* str_id,ImGuiTabBarFlags flags)
    # void igEndTabBar()
    # bool igBeginTabItem(const char* label,bool* p_open,ImGuiTabItemFlags flags)
    # void igEndTabItem()
    # bool igTabItemButton(const char* label,ImGuiTabItemFlags flags)
    # void igSetTabItemClosed(const char* tab_or_docked_window_label)
    # ImGuiID igDockSpace(ImGuiID id,const ImVec2 size,ImGuiDockNodeFlags flags,const ImGuiWindowClass* window_class)
    # ImGuiID igDockSpaceOverViewport(const ImGuiViewport* viewport,ImGuiDockNodeFlags flags,const ImGuiWindowClass* window_class)
    # void igSetNextWindowDockID(ImGuiID dock_id,ImGuiCond cond)
    # void igSetNextWindowClass(const ImGuiWindowClass* window_class)
    # ImGuiID igGetWindowDockID()
    # bool igIsWindowDocked()
    # void igLogToTTY(int auto_open_depth)
    # void igLogToFile(int auto_open_depth,const char* filename)
    # void igLogToClipboard(int auto_open_depth)
    # void igLogFinish()
    # void igLogButtons()
    # void igLogTextV(const char* fmt,va_list args)
    # bool igBeginDragDropSource(ImGuiDragDropFlags flags)
    # bool igSetDragDropPayload(const char* type,const void* data,size_t sz,ImGuiCond cond)
    # void igEndDragDropSource()
    # bool igBeginDragDropTarget()
    # const ImGuiPayload* igAcceptDragDropPayload(const char* type,ImGuiDragDropFlags flags)
    # void igEndDragDropTarget()
    # const ImGuiPayload* igGetDragDropPayload()
    # void igBeginDisabled(bool disabled)
    # void igEndDisabled()
    # void igPushClipRect(const ImVec2 clip_rect_min,const ImVec2 clip_rect_max,bool intersect_with_current_clip_rect)
    # void igPopClipRect()
    # void igSetItemDefaultFocus()
    # void igSetKeyboardFocusHere(int offset)
    # bool igIsItemHovered(ImGuiHoveredFlags flags)
    # bool igIsItemActive()
    # bool igIsItemFocused()
    # bool igIsItemClicked(ImGuiMouseButton mouse_button)
    # bool igIsItemVisible()
    # bool igIsItemEdited()
    # bool igIsItemActivated()
    # bool igIsItemDeactivated()
    # bool igIsItemDeactivatedAfterEdit()
    # bool igIsItemToggledOpen()
    # bool igIsAnyItemHovered()
    # bool igIsAnyItemActive()
    # bool igIsAnyItemFocused()
    # ImGuiID igGetItemID()
    # void igGetItemRectMin(ImVec2 *pOut)
    # void igGetItemRectMax(ImVec2 *pOut)
    # void igGetItemRectSize(ImVec2 *pOut)
    # void igSetItemAllowOverlap()
    # ImGuiViewport* igGetMainViewport()
    # ImDrawList* igGetBackgroundDrawList_Nil()
    # ImDrawList* igGetForegroundDrawList_Nil()
    # ImDrawList* igGetBackgroundDrawList_ViewportPtr(ImGuiViewport* viewport)
    # ImDrawList* igGetForegroundDrawList_ViewportPtr(ImGuiViewport* viewport)
    # bool igIsRectVisible_Nil(const ImVec2 size)
    # bool igIsRectVisible_Vec2(const ImVec2 rect_min,const ImVec2 rect_max)
    # double igGetTime()
    # int igGetFrameCount()
    # ImDrawListSharedData* igGetDrawListSharedData()
    # const char* igGetStyleColorName(ImGuiCol idx)
    # void igSetStateStorage(ImGuiStorage* storage)
    # ImGuiStorage* igGetStateStorage()
    # bool igBeginChildFrame(ImGuiID id,const ImVec2 size,ImGuiWindowFlags flags)
    # void igEndChildFrame()
    # void igCalcTextSize(ImVec2 *pOut,const char* text,const char* text_end,bool hide_text_after_double_hash,float wrap_width)
    # void igColorConvertU32ToFloat4(ImVec4 *pOut, ImU32 in_)
    # ImU32 igColorConvertFloat4ToU32(const ImVec4 in_)
    # void igColorConvertRGBtoHSV(float r,float g,float b,float* out_h,float* out_s,float* out_v)
    # void igColorConvertHSVtoRGB(float h,float s,float v,float* out_r,float* out_g,float* out_b)
    # bool igIsKeyDown_Nil(ImGuiKey key)
    # bool igIsKeyPressed_Bool(ImGuiKey key,bool repeat)
    # bool igIsKeyReleased_Nil(ImGuiKey key)
    # int igGetKeyPressedAmount(ImGuiKey key,float repeat_delay,float rate)
    # const char* igGetKeyName(ImGuiKey key)
    # void igSetNextFrameWantCaptureKeyboard(bool want_capture_keyboard)
    # bool igIsMouseDown_Nil(ImGuiMouseButton button)
    # bool igIsMouseClicked_Bool(ImGuiMouseButton button,bool repeat)
    # bool igIsMouseReleased_Nil(ImGuiMouseButton button)
    # bool igIsMouseDoubleClicked(ImGuiMouseButton button)
    # int igGetMouseClickedCount(ImGuiMouseButton button)
    # bool igIsMouseHoveringRect(const ImVec2 r_min,const ImVec2 r_max,bool clip)
    # bool igIsMousePosValid(const ImVec2* mouse_pos)
    # bool igIsAnyMouseDown()
    # void igGetMousePos(ImVec2 *pOut)
    # void igGetMousePosOnOpeningCurrentPopup(ImVec2 *pOut)
    # bool igIsMouseDragging(ImGuiMouseButton button,float lock_threshold)
    # void igGetMouseDragDelta(ImVec2 *pOut,ImGuiMouseButton button,float lock_threshold)
    # void igResetMouseDragDelta(ImGuiMouseButton button)
    # ImGuiMouseCursor igGetMouseCursor()
    # void igSetMouseCursor(ImGuiMouseCursor cursor_type)
    # void igSetNextFrameWantCaptureMouse(bool want_capture_mouse)
    # const char* igGetClipboardText()
    # void igSetClipboardText(const char* text)
    # void igLoadIniSettingsFromDisk(const char* ini_filename)
    # void igLoadIniSettingsFromMemory(const char* ini_data,size_t ini_size)
    # void igSaveIniSettingsToDisk(const char* ini_filename)
    # const char* igSaveIniSettingsToMemory(size_t* out_ini_size)
    # void igDebugTextEncoding(const char* text)
    # bool igDebugCheckVersionAndDataLayout(const char* version_str,size_t sz_io,size_t sz_style,size_t sz_vec2,size_t sz_vec4,size_t sz_drawvert,size_t sz_drawidx)
    # void igSetAllocatorFunctions(ImGuiMemAllocFunc alloc_func,ImGuiMemFreeFunc free_func,void* user_data)
    # void igGetAllocatorFunctions(ImGuiMemAllocFunc* p_alloc_func,ImGuiMemFreeFunc* p_free_func,void** p_user_data)
    # void* igMemAlloc(size_t size)
    # void igMemFree(void* ptr)
    # ImGuiPlatformIO* igGetPlatformIO()
    # void igUpdatePlatformWindows()
    # void igRenderPlatformWindowsDefault(void* platform_render_arg,void* renderer_render_arg)
    # void igDestroyPlatformWindows()
    # ImGuiViewport* igFindViewportByID(ImGuiID id)
    # ImGuiViewport* igFindViewportByPlatformHandle(void* platform_handle)
    # ImGuiStyle* ImGuiStyle_ImGuiStyle()
    # void ImGuiStyle_destroy(ImGuiStyle* self)
    # void ImGuiStyle_ScaleAllSizes(ImGuiStyle* self,float scale_factor)
    # void ImGuiIO_AddKeyEvent(ImGuiIO* self,ImGuiKey key,bool down)
    # void ImGuiIO_AddKeyAnalogEvent(ImGuiIO* self,ImGuiKey key,bool down,float v)
    # void ImGuiIO_AddMousePosEvent(ImGuiIO* self,float x,float y)
    # void ImGuiIO_AddMouseButtonEvent(ImGuiIO* self,int button,bool down)
    # void ImGuiIO_AddMouseWheelEvent(ImGuiIO* self,float wheel_x,float wheel_y)
    # void ImGuiIO_AddMouseViewportEvent(ImGuiIO* self,ImGuiID id)
    # void ImGuiIO_AddFocusEvent(ImGuiIO* self,bool focused)
    void ImGuiIO_AddInputCharacter(ImGuiIO* self,unsigned int c)
    # void ImGuiIO_AddInputCharacterUTF16(ImGuiIO* self,ImWchar16 c)
    # void ImGuiIO_AddInputCharactersUTF8(ImGuiIO* self,const char* str)
    # void ImGuiIO_SetKeyEventNativeData(ImGuiIO* self,ImGuiKey key,int native_keycode,int native_scancode,int native_legacy_index)
    # void ImGuiIO_SetAppAcceptingEvents(ImGuiIO* self,bool accepting_events)
    # void ImGuiIO_ClearInputCharacters(ImGuiIO* self)
    # void ImGuiIO_ClearInputKeys(ImGuiIO* self)
    # ImGuiIO* ImGuiIO_ImGuiIO()
    # void ImGuiIO_destroy(ImGuiIO* self)
    # ImGuiInputTextCallbackData* ImGuiInputTextCallbackData_ImGuiInputTextCallbackData()
    # void ImGuiInputTextCallbackData_destroy(ImGuiInputTextCallbackData* self)
    # void ImGuiInputTextCallbackData_DeleteChars(ImGuiInputTextCallbackData* self,int pos,int bytes_count)
    # void ImGuiInputTextCallbackData_InsertChars(ImGuiInputTextCallbackData* self,int pos,const char* text,const char* text_end)
    # void ImGuiInputTextCallbackData_SelectAll(ImGuiInputTextCallbackData* self)
    # void ImGuiInputTextCallbackData_ClearSelection(ImGuiInputTextCallbackData* self)
    # bool ImGuiInputTextCallbackData_HasSelection(ImGuiInputTextCallbackData* self)
    # ImGuiWindowClass* ImGuiWindowClass_ImGuiWindowClass()
    # void ImGuiWindowClass_destroy(ImGuiWindowClass* self)
    # ImGuiPayload* ImGuiPayload_ImGuiPayload()
    # void ImGuiPayload_destroy(ImGuiPayload* self)
    # void ImGuiPayload_Clear(ImGuiPayload* self)
    # bool ImGuiPayload_IsDataType(ImGuiPayload* self,const char* type)
    # bool ImGuiPayload_IsPreview(ImGuiPayload* self)
    # bool ImGuiPayload_IsDelivery(ImGuiPayload* self)
    # ImGuiTableColumnSortSpecs* ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs()
    # void ImGuiTableColumnSortSpecs_destroy(ImGuiTableColumnSortSpecs* self)
    # ImGuiTableSortSpecs* ImGuiTableSortSpecs_ImGuiTableSortSpecs()
    # void ImGuiTableSortSpecs_destroy(ImGuiTableSortSpecs* self)
    # ImGuiOnceUponAFrame* ImGuiOnceUponAFrame_ImGuiOnceUponAFrame()
    # void ImGuiOnceUponAFrame_destroy(ImGuiOnceUponAFrame* self)
    # ImGuiTextFilter* ImGuiTextFilter_ImGuiTextFilter(const char* default_filter)
    # void ImGuiTextFilter_destroy(ImGuiTextFilter* self)
    # bool ImGuiTextFilter_Draw(ImGuiTextFilter* self,const char* label,float width)
    # bool ImGuiTextFilter_PassFilter(ImGuiTextFilter* self,const char* text,const char* text_end)
    # void ImGuiTextFilter_Build(ImGuiTextFilter* self)
    # void ImGuiTextFilter_Clear(ImGuiTextFilter* self)
    # bool ImGuiTextFilter_IsActive(ImGuiTextFilter* self)
    # ImGuiTextRange* ImGuiTextRange_ImGuiTextRange_Nil()
    # void ImGuiTextRange_destroy(ImGuiTextRange* self)
    # ImGuiTextRange* ImGuiTextRange_ImGuiTextRange_Str(const char* _b,const char* _e)
    # bool ImGuiTextRange_empty(ImGuiTextRange* self)
    # void ImGuiTextRange_split(ImGuiTextRange* self,char separator,ImVector_ImGuiTextRange* out)
    # ImGuiTextBuffer* ImGuiTextBuffer_ImGuiTextBuffer()
    # void ImGuiTextBuffer_destroy(ImGuiTextBuffer* self)
    # const char* ImGuiTextBuffer_begin(ImGuiTextBuffer* self)
    # const char* ImGuiTextBuffer_end(ImGuiTextBuffer* self)
    # int ImGuiTextBuffer_size(ImGuiTextBuffer* self)
    # bool ImGuiTextBuffer_empty(ImGuiTextBuffer* self)
    # void ImGuiTextBuffer_clear(ImGuiTextBuffer* self)
    # void ImGuiTextBuffer_reserve(ImGuiTextBuffer* self,int capacity)
    # const char* ImGuiTextBuffer_c_str(ImGuiTextBuffer* self)
    # void ImGuiTextBuffer_append(ImGuiTextBuffer* self,const char* str,const char* str_end)
    # void ImGuiTextBuffer_appendfv(ImGuiTextBuffer* self,const char* fmt,va_list args)
    # ImGuiStoragePair* ImGuiStoragePair_ImGuiStoragePair_Int(ImGuiID _key,int _val_i)
    # void ImGuiStoragePair_destroy(ImGuiStoragePair* self)
    # ImGuiStoragePair* ImGuiStoragePair_ImGuiStoragePair_Float(ImGuiID _key,float _val_f)
    # ImGuiStoragePair* ImGuiStoragePair_ImGuiStoragePair_Ptr(ImGuiID _key,void* _val_p)
    # void ImGuiStorage_Clear(ImGuiStorage* self)
    # int ImGuiStorage_GetInt(ImGuiStorage* self,ImGuiID key,int default_val)
    # void ImGuiStorage_SetInt(ImGuiStorage* self,ImGuiID key,int val)
    # bool ImGuiStorage_GetBool(ImGuiStorage* self,ImGuiID key,bool default_val)
    # void ImGuiStorage_SetBool(ImGuiStorage* self,ImGuiID key,bool val)
    # float ImGuiStorage_GetFloat(ImGuiStorage* self,ImGuiID key,float default_val)
    # void ImGuiStorage_SetFloat(ImGuiStorage* self,ImGuiID key,float val)
    # void* ImGuiStorage_GetVoidPtr(ImGuiStorage* self,ImGuiID key)
    # void ImGuiStorage_SetVoidPtr(ImGuiStorage* self,ImGuiID key,void* val)
    # int* ImGuiStorage_GetIntRef(ImGuiStorage* self,ImGuiID key,int default_val)
    # bool* ImGuiStorage_GetBoolRef(ImGuiStorage* self,ImGuiID key,bool default_val)
    # float* ImGuiStorage_GetFloatRef(ImGuiStorage* self,ImGuiID key,float default_val)
    # void** ImGuiStorage_GetVoidPtrRef(ImGuiStorage* self,ImGuiID key,void* default_val)
    # void ImGuiStorage_SetAllInt(ImGuiStorage* self,int val)
    # void ImGuiStorage_BuildSortByKey(ImGuiStorage* self)
    # ImGuiListClipper* ImGuiListClipper_ImGuiListClipper()
    # void ImGuiListClipper_destroy(ImGuiListClipper* self)
    # void ImGuiListClipper_Begin(ImGuiListClipper* self,int items_count,float items_height)
    # void ImGuiListClipper_End(ImGuiListClipper* self)
    # bool ImGuiListClipper_Step(ImGuiListClipper* self)
    # void ImGuiListClipper_ForceDisplayRangeByIndices(ImGuiListClipper* self,int item_min,int item_max)
    # ImColor* ImColor_ImColor_Nil()
    # void ImColor_destroy(ImColor* self)
    # ImColor* ImColor_ImColor_Float(float r,float g,float b,float a)
    # ImColor* ImColor_ImColor_Vec4(const ImVec4 col)
    # ImColor* ImColor_ImColor_Int(int r,int g,int b,int a)
    # ImColor* ImColor_ImColor_U32(ImU32 rgba)
    # void ImColor_SetHSV(ImColor* self,float h,float s,float v,float a)
    # void ImColor_HSV(ImColor *pOut,float h,float s,float v,float a)
    # ImDrawCmd* ImDrawCmd_ImDrawCmd()
    # void ImDrawCmd_destroy(ImDrawCmd* self)
    # ImTextureID ImDrawCmd_GetTexID(ImDrawCmd* self)
    # ImDrawListSplitter* ImDrawListSplitter_ImDrawListSplitter()
    # void ImDrawListSplitter_destroy(ImDrawListSplitter* self)
    # void ImDrawListSplitter_Clear(ImDrawListSplitter* self)
    # void ImDrawListSplitter_ClearFreeMemory(ImDrawListSplitter* self)
    # void ImDrawListSplitter_Split(ImDrawListSplitter* self,ImDrawList* draw_list,int count)
    # void ImDrawListSplitter_Merge(ImDrawListSplitter* self,ImDrawList* draw_list)
    # void ImDrawListSplitter_SetCurrentChannel(ImDrawListSplitter* self,ImDrawList* draw_list,int channel_idx)
    # ImDrawList* ImDrawList_ImDrawList(ImDrawListSharedData* shared_data)
    # void ImDrawList_destroy(ImDrawList* self)
    # void ImDrawList_PushClipRect(ImDrawList* self,const ImVec2 clip_rect_min,const ImVec2 clip_rect_max,bool intersect_with_current_clip_rect)
    # void ImDrawList_PushClipRectFullScreen(ImDrawList* self)
    # void ImDrawList_PopClipRect(ImDrawList* self)
    # void ImDrawList_PushTextureID(ImDrawList* self,ImTextureID texture_id)
    # void ImDrawList_PopTextureID(ImDrawList* self)
    # void ImDrawList_GetClipRectMin(ImVec2 *pOut,ImDrawList* self)
    # void ImDrawList_GetClipRectMax(ImVec2 *pOut,ImDrawList* self)
    # void ImDrawList_AddLine(ImDrawList* self,const ImVec2 p1,const ImVec2 p2,ImU32 col,float thickness)
    # void ImDrawList_AddRect(ImDrawList* self,const ImVec2 p_min,const ImVec2 p_max,ImU32 col,float rounding,ImDrawFlags flags,float thickness)
    # void ImDrawList_AddRectFilled(ImDrawList* self,const ImVec2 p_min,const ImVec2 p_max,ImU32 col,float rounding,ImDrawFlags flags)
    # void ImDrawList_AddRectFilledMultiColor(ImDrawList* self,const ImVec2 p_min,const ImVec2 p_max,ImU32 col_upr_left,ImU32 col_upr_right,ImU32 col_bot_right,ImU32 col_bot_left)
    # void ImDrawList_AddQuad(ImDrawList* self,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,const ImVec2 p4,ImU32 col,float thickness)
    # void ImDrawList_AddQuadFilled(ImDrawList* self,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,const ImVec2 p4,ImU32 col)
    # void ImDrawList_AddTriangle(ImDrawList* self,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,ImU32 col,float thickness)
    # void ImDrawList_AddTriangleFilled(ImDrawList* self,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,ImU32 col)
    # void ImDrawList_AddCircle(ImDrawList* self,const ImVec2 center,float radius,ImU32 col,int num_segments,float thickness)
    # void ImDrawList_AddCircleFilled(ImDrawList* self,const ImVec2 center,float radius,ImU32 col,int num_segments)
    # void ImDrawList_AddNgon(ImDrawList* self,const ImVec2 center,float radius,ImU32 col,int num_segments,float thickness)
    # void ImDrawList_AddNgonFilled(ImDrawList* self,const ImVec2 center,float radius,ImU32 col,int num_segments)
    # void ImDrawList_AddText_Vec2(ImDrawList* self,const ImVec2 pos,ImU32 col,const char* text_begin,const char* text_end)
    # void ImDrawList_AddText_FontPtr(ImDrawList* self,const ImFont* font,float font_size,const ImVec2 pos,ImU32 col,const char* text_begin,const char* text_end,float wrap_width,const ImVec4* cpu_fine_clip_rect)
    # void ImDrawList_AddPolyline(ImDrawList* self,const ImVec2* points,int num_points,ImU32 col,ImDrawFlags flags,float thickness)
    # void ImDrawList_AddConvexPolyFilled(ImDrawList* self,const ImVec2* points,int num_points,ImU32 col)
    # void ImDrawList_AddBezierCubic(ImDrawList* self,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,const ImVec2 p4,ImU32 col,float thickness,int num_segments)
    # void ImDrawList_AddBezierQuadratic(ImDrawList* self,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,ImU32 col,float thickness,int num_segments)
    # void ImDrawList_AddImage(ImDrawList* self,ImTextureID user_texture_id,const ImVec2 p_min,const ImVec2 p_max,const ImVec2 uv_min,const ImVec2 uv_max,ImU32 col)
    # void ImDrawList_AddImageQuad(ImDrawList* self,ImTextureID user_texture_id,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,const ImVec2 p4,const ImVec2 uv1,const ImVec2 uv2,const ImVec2 uv3,const ImVec2 uv4,ImU32 col)
    # void ImDrawList_AddImageRounded(ImDrawList* self,ImTextureID user_texture_id,const ImVec2 p_min,const ImVec2 p_max,const ImVec2 uv_min,const ImVec2 uv_max,ImU32 col,float rounding,ImDrawFlags flags)
    # void ImDrawList_PathClear(ImDrawList* self)
    # void ImDrawList_PathLineTo(ImDrawList* self,const ImVec2 pos)
    # void ImDrawList_PathLineToMergeDuplicate(ImDrawList* self,const ImVec2 pos)
    # void ImDrawList_PathFillConvex(ImDrawList* self,ImU32 col)
    # void ImDrawList_PathStroke(ImDrawList* self,ImU32 col,ImDrawFlags flags,float thickness)
    # void ImDrawList_PathArcTo(ImDrawList* self,const ImVec2 center,float radius,float a_min,float a_max,int num_segments)
    # void ImDrawList_PathArcToFast(ImDrawList* self,const ImVec2 center,float radius,int a_min_of_12,int a_max_of_12)
    # void ImDrawList_PathBezierCubicCurveTo(ImDrawList* self,const ImVec2 p2,const ImVec2 p3,const ImVec2 p4,int num_segments)
    # void ImDrawList_PathBezierQuadraticCurveTo(ImDrawList* self,const ImVec2 p2,const ImVec2 p3,int num_segments)
    # void ImDrawList_PathRect(ImDrawList* self,const ImVec2 rect_min,const ImVec2 rect_max,float rounding,ImDrawFlags flags)
    # void ImDrawList_AddCallback(ImDrawList* self,ImDrawCallback callback,void* callback_data)
    # void ImDrawList_AddDrawCmd(ImDrawList* self)
    # ImDrawList* ImDrawList_CloneOutput(ImDrawList* self)
    # void ImDrawList_ChannelsSplit(ImDrawList* self,int count)
    # void ImDrawList_ChannelsMerge(ImDrawList* self)
    # void ImDrawList_ChannelsSetCurrent(ImDrawList* self,int n)
    # void ImDrawList_PrimReserve(ImDrawList* self,int idx_count,int vtx_count)
    # void ImDrawList_PrimUnreserve(ImDrawList* self,int idx_count,int vtx_count)
    # void ImDrawList_PrimRect(ImDrawList* self,const ImVec2 a,const ImVec2 b,ImU32 col)
    # void ImDrawList_PrimRectUV(ImDrawList* self,const ImVec2 a,const ImVec2 b,const ImVec2 uv_a,const ImVec2 uv_b,ImU32 col)
    # void ImDrawList_PrimQuadUV(ImDrawList* self,const ImVec2 a,const ImVec2 b,const ImVec2 c,const ImVec2 d,const ImVec2 uv_a,const ImVec2 uv_b,const ImVec2 uv_c,const ImVec2 uv_d,ImU32 col)
    # void ImDrawList_PrimWriteVtx(ImDrawList* self,const ImVec2 pos,const ImVec2 uv,ImU32 col)
    # void ImDrawList_PrimWriteIdx(ImDrawList* self,ImDrawIdx idx)
    # void ImDrawList_PrimVtx(ImDrawList* self,const ImVec2 pos,const ImVec2 uv,ImU32 col)
    # void ImDrawList__ResetForNewFrame(ImDrawList* self)
    # void ImDrawList__ClearFreeMemory(ImDrawList* self)
    # void ImDrawList__PopUnusedDrawCmd(ImDrawList* self)
    # void ImDrawList__TryMergeDrawCmds(ImDrawList* self)
    # void ImDrawList__OnChangedClipRect(ImDrawList* self)
    # void ImDrawList__OnChangedTextureID(ImDrawList* self)
    # void ImDrawList__OnChangedVtxOffset(ImDrawList* self)
    # int ImDrawList__CalcCircleAutoSegmentCount(ImDrawList* self,float radius)
    # void ImDrawList__PathArcToFastEx(ImDrawList* self,const ImVec2 center,float radius,int a_min_sample,int a_max_sample,int a_step)
    # void ImDrawList__PathArcToN(ImDrawList* self,const ImVec2 center,float radius,float a_min,float a_max,int num_segments)
    # ImDrawData* ImDrawData_ImDrawData()
    # void ImDrawData_destroy(ImDrawData* self)
    # void ImDrawData_Clear(ImDrawData* self)
    # void ImDrawData_DeIndexAllBuffers(ImDrawData* self)
    void ImDrawData_ScaleClipRects(ImDrawData* self,const ImVec2 fb_scale)
    # ImFontConfig* ImFontConfig_ImFontConfig()
    # void ImFontConfig_destroy(ImFontConfig* self)
    # ImFontGlyphRangesBuilder* ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder()
    # void ImFontGlyphRangesBuilder_destroy(ImFontGlyphRangesBuilder* self)
    # void ImFontGlyphRangesBuilder_Clear(ImFontGlyphRangesBuilder* self)
    # bool ImFontGlyphRangesBuilder_GetBit(ImFontGlyphRangesBuilder* self,size_t n)
    # void ImFontGlyphRangesBuilder_SetBit(ImFontGlyphRangesBuilder* self,size_t n)
    # void ImFontGlyphRangesBuilder_AddChar(ImFontGlyphRangesBuilder* self,ImWchar c)
    # void ImFontGlyphRangesBuilder_AddText(ImFontGlyphRangesBuilder* self,const char* text,const char* text_end)
    # void ImFontGlyphRangesBuilder_AddRanges(ImFontGlyphRangesBuilder* self,const ImWchar* ranges)
    # void ImFontGlyphRangesBuilder_BuildRanges(ImFontGlyphRangesBuilder* self,ImVector_ImWchar* out_ranges)
    # ImFontAtlasCustomRect* ImFontAtlasCustomRect_ImFontAtlasCustomRect()
    # void ImFontAtlasCustomRect_destroy(ImFontAtlasCustomRect* self)
    # bool ImFontAtlasCustomRect_IsPacked(ImFontAtlasCustomRect* self)
    # ImFontAtlas* ImFontAtlas_ImFontAtlas()
    # void ImFontAtlas_destroy(ImFontAtlas* self)
    # ImFont* ImFontAtlas_AddFont(ImFontAtlas* self,const ImFontConfig* font_cfg)
    # ImFont* ImFontAtlas_AddFontDefault(ImFontAtlas* self,const ImFontConfig* font_cfg)
    # ImFont* ImFontAtlas_AddFontFromFileTTF(ImFontAtlas* self,const char* filename,float size_pixels,const ImFontConfig* font_cfg,const ImWchar* glyph_ranges)
    # ImFont* ImFontAtlas_AddFontFromMemoryTTF(ImFontAtlas* self,void* font_data,int font_size,float size_pixels,const ImFontConfig* font_cfg,const ImWchar* glyph_ranges)
    # ImFont* ImFontAtlas_AddFontFromMemoryCompressedTTF(ImFontAtlas* self,const void* compressed_font_data,int compressed_font_size,float size_pixels,const ImFontConfig* font_cfg,const ImWchar* glyph_ranges)
    # ImFont* ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(ImFontAtlas* self,const char* compressed_font_data_base85,float size_pixels,const ImFontConfig* font_cfg,const ImWchar* glyph_ranges)
    # void ImFontAtlas_ClearInputData(ImFontAtlas* self)
    void ImFontAtlas_ClearTexData(ImFontAtlas* self)
    # void ImFontAtlas_ClearFonts(ImFontAtlas* self)
    # void ImFontAtlas_Clear(ImFontAtlas* self)
    # bool ImFontAtlas_Build(ImFontAtlas* self)
    void ImFontAtlas_GetTexDataAsAlpha8(ImFontAtlas* self,unsigned char** out_pixels,int* out_width,int* out_height,int* out_bytes_per_pixel)
    void ImFontAtlas_GetTexDataAsRGBA32(ImFontAtlas* self,unsigned char** out_pixels,int* out_width,int* out_height,int* out_bytes_per_pixel)
    # bool ImFontAtlas_IsBuilt(ImFontAtlas* self)
    # void ImFontAtlas_SetTexID(ImFontAtlas* self,ImTextureID id)
    # const ImWchar* ImFontAtlas_GetGlyphRangesDefault(ImFontAtlas* self)
    # const ImWchar* ImFontAtlas_GetGlyphRangesGreek(ImFontAtlas* self)
    # const ImWchar* ImFontAtlas_GetGlyphRangesKorean(ImFontAtlas* self)
    # const ImWchar* ImFontAtlas_GetGlyphRangesJapanese(ImFontAtlas* self)
    # const ImWchar* ImFontAtlas_GetGlyphRangesChineseFull(ImFontAtlas* self)
    # const ImWchar* ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(ImFontAtlas* self)
    # const ImWchar* ImFontAtlas_GetGlyphRangesCyrillic(ImFontAtlas* self)
    # const ImWchar* ImFontAtlas_GetGlyphRangesThai(ImFontAtlas* self)
    # const ImWchar* ImFontAtlas_GetGlyphRangesVietnamese(ImFontAtlas* self)
    # int ImFontAtlas_AddCustomRectRegular(ImFontAtlas* self,int width,int height)
    # int ImFontAtlas_AddCustomRectFontGlyph(ImFontAtlas* self,ImFont* font,ImWchar id,int width,int height,float advance_x,const ImVec2 offset)
    # ImFontAtlasCustomRect* ImFontAtlas_GetCustomRectByIndex(ImFontAtlas* self,int index)
    # void ImFontAtlas_CalcCustomRectUV(ImFontAtlas* self,const ImFontAtlasCustomRect* rect,ImVec2* out_uv_min,ImVec2* out_uv_max)
    # bool ImFontAtlas_GetMouseCursorTexData(ImFontAtlas* self,ImGuiMouseCursor cursor,ImVec2* out_offset,ImVec2* out_size,ImVec2 out_uv_border[2],ImVec2 out_uv_fill[2])
    # ImFont* ImFont_ImFont()
    # void ImFont_destroy(ImFont* self)
    # const ImFontGlyph* ImFont_FindGlyph(ImFont* self,ImWchar c)
    # const ImFontGlyph* ImFont_FindGlyphNoFallback(ImFont* self,ImWchar c)
    # float ImFont_GetCharAdvance(ImFont* self,ImWchar c)
    # bool ImFont_IsLoaded(ImFont* self)
    # const char* ImFont_GetDebugName(ImFont* self)
    # void ImFont_CalcTextSizeA(ImVec2 *pOut,ImFont* self,float size,float max_width,float wrap_width,const char* text_begin,const char* text_end,const char** remaining)
    # const char* ImFont_CalcWordWrapPositionA(ImFont* self,float scale,const char* text,const char* text_end,float wrap_width)
    # void ImFont_RenderChar(ImFont* self,ImDrawList* draw_list,float size,const ImVec2 pos,ImU32 col,ImWchar c)
    # void ImFont_RenderText(ImFont* self,ImDrawList* draw_list,float size,const ImVec2 pos,ImU32 col,const ImVec4 clip_rect,const char* text_begin,const char* text_end,float wrap_width,bool cpu_fine_clip)
    # void ImFont_BuildLookupTable(ImFont* self)
    # void ImFont_ClearOutputData(ImFont* self)
    # void ImFont_GrowIndex(ImFont* self,int new_size)
    # void ImFont_AddGlyph(ImFont* self,const ImFontConfig* src_cfg,ImWchar c,float x0,float y0,float x1,float y1,float u0,float v0,float u1,float v1,float advance_x)
    # void ImFont_AddRemapChar(ImFont* self,ImWchar dst,ImWchar src,bool overwrite_dst)
    # void ImFont_SetGlyphVisible(ImFont* self,ImWchar c,bool visible)
    # bool ImFont_IsGlyphRangeUnused(ImFont* self,unsigned int c_begin,unsigned int c_last)
    # ImGuiViewport* ImGuiViewport_ImGuiViewport()
    # void ImGuiViewport_destroy(ImGuiViewport* self)
    # void ImGuiViewport_GetCenter(ImVec2 *pOut,ImGuiViewport* self)
    # void ImGuiViewport_GetWorkCenter(ImVec2 *pOut,ImGuiViewport* self)
    # ImGuiPlatformIO* ImGuiPlatformIO_ImGuiPlatformIO()
    # void ImGuiPlatformIO_destroy(ImGuiPlatformIO* self)
    # ImGuiPlatformMonitor* ImGuiPlatformMonitor_ImGuiPlatformMonitor()
    # void ImGuiPlatformMonitor_destroy(ImGuiPlatformMonitor* self)
    # ImGuiPlatformImeData* ImGuiPlatformImeData_ImGuiPlatformImeData()
    # void ImGuiPlatformImeData_destroy(ImGuiPlatformImeData* self)
    # ImGuiKey igGetKeyIndex(ImGuiKey key)
    # ImGuiID igImHashData(const void* data,size_t data_size,ImGuiID seed)
    # ImGuiID igImHashStr(const char* data,size_t data_size,ImGuiID seed)
    # void igImQsort(void* base,size_t count,size_t size_of_element,int(*compare_func)(void const*,void const*))
    # ImU32 igImAlphaBlendColors(ImU32 col_a,ImU32 col_b)
    # bool igImIsPowerOfTwo_Int(int v)
    # bool igImIsPowerOfTwo_U64(ImU64 v)
    # int igImUpperPowerOfTwo(int v)
    # int igImStricmp(const char* str1,const char* str2)
    # int igImStrnicmp(const char* str1,const char* str2,size_t count)
    # void igImStrncpy(char* dst,const char* src,size_t count)
    # char* igImStrdup(const char* str)
    # char* igImStrdupcpy(char* dst,size_t* p_dst_size,const char* str)
    # const char* igImStrchrRange(const char* str_begin,const char* str_end,char c)
    # int igImStrlenW(const ImWchar* str)
    # const char* igImStreolRange(const char* str,const char* str_end)
    # const ImWchar* igImStrbolW(const ImWchar* buf_mid_line,const ImWchar* buf_begin)
    # const char* igImStristr(const char* haystack,const char* haystack_end,const char* needle,const char* needle_end)
    # void igImStrTrimBlanks(char* str)
    # const char* igImStrSkipBlank(const char* str)
    # char igImToUpper(char c)
    # bool igImCharIsBlankA(char c)
    # bool igImCharIsBlankW(unsigned int c)
    # int igImFormatString(char* buf,size_t buf_size,const char* fmt,...)
    # int igImFormatStringV(char* buf,size_t buf_size,const char* fmt,va_list args)
    # void igImFormatStringToTempBuffer(const char** out_buf,const char** out_buf_end,const char* fmt,...)
    # void igImFormatStringToTempBufferV(const char** out_buf,const char** out_buf_end,const char* fmt,va_list args)
    # const char* igImParseFormatFindStart(const char* format)
    # const char* igImParseFormatFindEnd(const char* format)
    # const char* igImParseFormatTrimDecorations(const char* format,char* buf,size_t buf_size)
    # void igImParseFormatSanitizeForPrinting(const char* fmt_in,char* fmt_out,size_t fmt_out_size)
    # const char* igImParseFormatSanitizeForScanning(const char* fmt_in,char* fmt_out,size_t fmt_out_size)
    # int igImParseFormatPrecision(const char* format,int default_value)
    # const char* igImTextCharToUtf8(char out_buf[5],unsigned int c)
    # int igImTextStrToUtf8(char* out_buf,int out_buf_size,const ImWchar* in_text,const ImWchar* in_text_end)
    # int igImTextCharFromUtf8(unsigned int* out_char,const char* in_text,const char* in_text_end)
    # int igImTextStrFromUtf8(ImWchar* out_buf,int out_buf_size,const char* in_text,const char* in_text_end,const char** in_remaining)
    # int igImTextCountCharsFromUtf8(const char* in_text,const char* in_text_end)
    # int igImTextCountUtf8BytesFromChar(const char* in_text,const char* in_text_end)
    # int igImTextCountUtf8BytesFromStr(const ImWchar* in_text,const ImWchar* in_text_end)
    # ImFileHandle igImFileOpen(const char* filename,const char* mode)
    # bool igImFileClose(ImFileHandle file)
    # ImU64 igImFileGetSize(ImFileHandle file)
    # ImU64 igImFileRead(void* data,ImU64 size,ImU64 count,ImFileHandle file)
    # ImU64 igImFileWrite(const void* data,ImU64 size,ImU64 count,ImFileHandle file)
    # void* igImFileLoadToMemory(const char* filename,const char* mode,size_t* out_file_size,int padding_bytes)
    # float igImPow_Float(float x,float y)
    # double igImPow_double(double x,double y)
    # float igImLog_Float(float x)
    # double igImLog_double(double x)
    # int igImAbs_Int(int x)
    # float igImAbs_Float(float x)
    # double igImAbs_double(double x)
    # float igImSign_Float(float x)
    # double igImSign_double(double x)
    # float igImRsqrt_Float(float x)
    # double igImRsqrt_double(double x)
    # void igImMin(ImVec2 *pOut,const ImVec2 lhs,const ImVec2 rhs)
    # void igImMax(ImVec2 *pOut,const ImVec2 lhs,const ImVec2 rhs)
    # void igImClamp(ImVec2 *pOut,const ImVec2 v,const ImVec2 mn,ImVec2 mx)
    # void igImLerp_Vec2Float(ImVec2 *pOut,const ImVec2 a,const ImVec2 b,float t)
    # void igImLerp_Vec2Vec2(ImVec2 *pOut,const ImVec2 a,const ImVec2 b,const ImVec2 t)
    # void igImLerp_Vec4(ImVec4 *pOut,const ImVec4 a,const ImVec4 b,float t)
    # float igImSaturate(float f)
    # float igImLengthSqr_Vec2(const ImVec2 lhs)
    # float igImLengthSqr_Vec4(const ImVec4 lhs)
    # float igImInvLength(const ImVec2 lhs,float fail_value)
    # float igImFloor_Float(float f)
    # float igImFloorSigned_Float(float f)
    # void igImFloor_Vec2(ImVec2 *pOut,const ImVec2 v)
    # void igImFloorSigned_Vec2(ImVec2 *pOut,const ImVec2 v)
    # int igImModPositive(int a,int b)
    # float igImDot(const ImVec2 a,const ImVec2 b)
    # void igImRotate(ImVec2 *pOut,const ImVec2 v,float cos_a,float sin_a)
    # float igImLinearSweep(float current,float target,float speed)
    # void igImMul(ImVec2 *pOut,const ImVec2 lhs,const ImVec2 rhs)
    # bool igImIsFloatAboveGuaranteedIntegerPrecision(float f)
    # float igImExponentialMovingAverage(float avg,float sample,int n)
    # void igImBezierCubicCalc(ImVec2 *pOut,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,const ImVec2 p4,float t)
    # void igImBezierCubicClosestPoint(ImVec2 *pOut,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,const ImVec2 p4,const ImVec2 p,int num_segments)
    # void igImBezierCubicClosestPointCasteljau(ImVec2 *pOut,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,const ImVec2 p4,const ImVec2 p,float tess_tol)
    # void igImBezierQuadraticCalc(ImVec2 *pOut,const ImVec2 p1,const ImVec2 p2,const ImVec2 p3,float t)
    # void igImLineClosestPoint(ImVec2 *pOut,const ImVec2 a,const ImVec2 b,const ImVec2 p)
    # bool igImTriangleContainsPoint(const ImVec2 a,const ImVec2 b,const ImVec2 c,const ImVec2 p)
    # void igImTriangleClosestPoint(ImVec2 *pOut,const ImVec2 a,const ImVec2 b,const ImVec2 c,const ImVec2 p)
    # void igImTriangleBarycentricCoords(const ImVec2 a,const ImVec2 b,const ImVec2 c,const ImVec2 p,float* out_u,float* out_v,float* out_w)
    # float igImTriangleArea(const ImVec2 a,const ImVec2 b,const ImVec2 c)
    # ImGuiDir igImGetDirQuadrantFromDelta(float dx,float dy)
    # ImVec1* ImVec1_ImVec1_Nil()
    # void ImVec1_destroy(ImVec1* self)
    # ImVec1* ImVec1_ImVec1_Float(float _x)
    # ImVec2ih* ImVec2ih_ImVec2ih_Nil()
    # void ImVec2ih_destroy(ImVec2ih* self)
    # ImVec2ih* ImVec2ih_ImVec2ih_short(short _x,short _y)
    # ImVec2ih* ImVec2ih_ImVec2ih_Vec2(const ImVec2 rhs)
    # ImRect* ImRect_ImRect_Nil()
    # void ImRect_destroy(ImRect* self)
    # ImRect* ImRect_ImRect_Vec2(const ImVec2 min,const ImVec2 max)
    # ImRect* ImRect_ImRect_Vec4(const ImVec4 v)
    # ImRect* ImRect_ImRect_Float(float x1,float y1,float x2,float y2)
    # void ImRect_GetCenter(ImVec2 *pOut,ImRect* self)
    # void ImRect_GetSize(ImVec2 *pOut,ImRect* self)
    # float ImRect_GetWidth(ImRect* self)
    # float ImRect_GetHeight(ImRect* self)
    # float ImRect_GetArea(ImRect* self)
    # void ImRect_GetTL(ImVec2 *pOut,ImRect* self)
    # void ImRect_GetTR(ImVec2 *pOut,ImRect* self)
    # void ImRect_GetBL(ImVec2 *pOut,ImRect* self)
    # void ImRect_GetBR(ImVec2 *pOut,ImRect* self)
    # bool ImRect_Contains_Vec2(ImRect* self,const ImVec2 p)
    # bool ImRect_Contains_Rect(ImRect* self,const ImRect r)
    # bool ImRect_Overlaps(ImRect* self,const ImRect r)
    # void ImRect_Add_Vec2(ImRect* self,const ImVec2 p)
    # void ImRect_Add_Rect(ImRect* self,const ImRect r)
    # void ImRect_Expand_Float(ImRect* self,const float amount)
    # void ImRect_Expand_Vec2(ImRect* self,const ImVec2 amount)
    # void ImRect_Translate(ImRect* self,const ImVec2 d)
    # void ImRect_TranslateX(ImRect* self,float dx)
    # void ImRect_TranslateY(ImRect* self,float dy)
    # void ImRect_ClipWith(ImRect* self,const ImRect r)
    # void ImRect_ClipWithFull(ImRect* self,const ImRect r)
    # void ImRect_Floor(ImRect* self)
    # bool ImRect_IsInverted(ImRect* self)
    # void ImRect_ToVec4(ImVec4 *pOut,ImRect* self)
    # size_t igImBitArrayGetStorageSizeInBytes(int bitcount)
    # void igImBitArrayClearAllBits(ImU32* arr,int bitcount)
    # bool igImBitArrayTestBit(const ImU32* arr,int n)
    # void igImBitArrayClearBit(ImU32* arr,int n)
    # void igImBitArraySetBit(ImU32* arr,int n)
    # void igImBitArraySetBitRange(ImU32* arr,int n,int n2)
    # void ImBitVector_Create(ImBitVector* self,int sz)
    # void ImBitVector_Clear(ImBitVector* self)
    # bool ImBitVector_TestBit(ImBitVector* self,int n)
    # void ImBitVector_SetBit(ImBitVector* self,int n)
    # void ImBitVector_ClearBit(ImBitVector* self,int n)
    # void ImGuiTextIndex_clear(ImGuiTextIndex* self)
    # int ImGuiTextIndex_size(ImGuiTextIndex* self)
    # const char* ImGuiTextIndex_get_line_begin(ImGuiTextIndex* self,const char* base,int n)
    # const char* ImGuiTextIndex_get_line_end(ImGuiTextIndex* self,const char* base,int n)
    # void ImGuiTextIndex_append(ImGuiTextIndex* self,const char* base,int old_size,int new_size)
    # ImDrawListSharedData* ImDrawListSharedData_ImDrawListSharedData()
    # void ImDrawListSharedData_destroy(ImDrawListSharedData* self)
    # void ImDrawListSharedData_SetCircleTessellationMaxError(ImDrawListSharedData* self,float max_error)
    # void ImDrawDataBuilder_Clear(ImDrawDataBuilder* self)
    # void ImDrawDataBuilder_ClearFreeMemory(ImDrawDataBuilder* self)
    # int ImDrawDataBuilder_GetDrawListCount(ImDrawDataBuilder* self)
    # void ImDrawDataBuilder_FlattenIntoSingleLayer(ImDrawDataBuilder* self)
    # ImGuiStyleMod* ImGuiStyleMod_ImGuiStyleMod_Int(ImGuiStyleVar idx,int v)
    # void ImGuiStyleMod_destroy(ImGuiStyleMod* self)
    # ImGuiStyleMod* ImGuiStyleMod_ImGuiStyleMod_Float(ImGuiStyleVar idx,float v)
    # ImGuiStyleMod* ImGuiStyleMod_ImGuiStyleMod_Vec2(ImGuiStyleVar idx,ImVec2 v)
    # ImGuiComboPreviewData* ImGuiComboPreviewData_ImGuiComboPreviewData()
    # void ImGuiComboPreviewData_destroy(ImGuiComboPreviewData* self)
    # ImGuiMenuColumns* ImGuiMenuColumns_ImGuiMenuColumns()
    # void ImGuiMenuColumns_destroy(ImGuiMenuColumns* self)
    # void ImGuiMenuColumns_Update(ImGuiMenuColumns* self,float spacing,bool window_reappearing)
    # float ImGuiMenuColumns_DeclColumns(ImGuiMenuColumns* self,float w_icon,float w_label,float w_shortcut,float w_mark)
    # void ImGuiMenuColumns_CalcNextTotalWidth(ImGuiMenuColumns* self,bool update_offsets)
    # ImGuiInputTextState* ImGuiInputTextState_ImGuiInputTextState(ImGuiContext* ctx)
    # void ImGuiInputTextState_destroy(ImGuiInputTextState* self)
    # void ImGuiInputTextState_ClearText(ImGuiInputTextState* self)
    # void ImGuiInputTextState_ClearFreeMemory(ImGuiInputTextState* self)
    # int ImGuiInputTextState_GetUndoAvailCount(ImGuiInputTextState* self)
    # int ImGuiInputTextState_GetRedoAvailCount(ImGuiInputTextState* self)
    # void ImGuiInputTextState_OnKeyPressed(ImGuiInputTextState* self,int key)
    # void ImGuiInputTextState_CursorAnimReset(ImGuiInputTextState* self)
    # void ImGuiInputTextState_CursorClamp(ImGuiInputTextState* self)
    # bool ImGuiInputTextState_HasSelection(ImGuiInputTextState* self)
    # void ImGuiInputTextState_ClearSelection(ImGuiInputTextState* self)
    # int ImGuiInputTextState_GetCursorPos(ImGuiInputTextState* self)
    # int ImGuiInputTextState_GetSelectionStart(ImGuiInputTextState* self)
    # int ImGuiInputTextState_GetSelectionEnd(ImGuiInputTextState* self)
    # void ImGuiInputTextState_SelectAll(ImGuiInputTextState* self)
    # ImGuiPopupData* ImGuiPopupData_ImGuiPopupData()
    # void ImGuiPopupData_destroy(ImGuiPopupData* self)
    # ImGuiNextWindowData* ImGuiNextWindowData_ImGuiNextWindowData()
    # void ImGuiNextWindowData_destroy(ImGuiNextWindowData* self)
    # void ImGuiNextWindowData_ClearFlags(ImGuiNextWindowData* self)
    # ImGuiNextItemData* ImGuiNextItemData_ImGuiNextItemData()
    # void ImGuiNextItemData_destroy(ImGuiNextItemData* self)
    # void ImGuiNextItemData_ClearFlags(ImGuiNextItemData* self)
    # ImGuiLastItemData* ImGuiLastItemData_ImGuiLastItemData()
    # void ImGuiLastItemData_destroy(ImGuiLastItemData* self)
    # ImGuiStackSizes* ImGuiStackSizes_ImGuiStackSizes()
    # void ImGuiStackSizes_destroy(ImGuiStackSizes* self)
    # void ImGuiStackSizes_SetToCurrentState(ImGuiStackSizes* self)
    # void ImGuiStackSizes_CompareWithCurrentState(ImGuiStackSizes* self)
    # ImGuiPtrOrIndex* ImGuiPtrOrIndex_ImGuiPtrOrIndex_Ptr(void* ptr)
    # void ImGuiPtrOrIndex_destroy(ImGuiPtrOrIndex* self)
    # ImGuiPtrOrIndex* ImGuiPtrOrIndex_ImGuiPtrOrIndex_Int(int index)
    # ImGuiInputEvent* ImGuiInputEvent_ImGuiInputEvent()
    # void ImGuiInputEvent_destroy(ImGuiInputEvent* self)
    # ImGuiKeyRoutingData* ImGuiKeyRoutingData_ImGuiKeyRoutingData()
    # void ImGuiKeyRoutingData_destroy(ImGuiKeyRoutingData* self)
    # ImGuiKeyRoutingTable* ImGuiKeyRoutingTable_ImGuiKeyRoutingTable()
    # void ImGuiKeyRoutingTable_destroy(ImGuiKeyRoutingTable* self)
    # void ImGuiKeyRoutingTable_Clear(ImGuiKeyRoutingTable* self)
    # ImGuiKeyOwnerData* ImGuiKeyOwnerData_ImGuiKeyOwnerData()
    # void ImGuiKeyOwnerData_destroy(ImGuiKeyOwnerData* self)
    # ImGuiListClipperRange ImGuiListClipperRange_FromIndices(int min,int max)
    # ImGuiListClipperRange ImGuiListClipperRange_FromPositions(float y1,float y2,int off_min,int off_max)
    # ImGuiListClipperData* ImGuiListClipperData_ImGuiListClipperData()
    # void ImGuiListClipperData_destroy(ImGuiListClipperData* self)
    # void ImGuiListClipperData_Reset(ImGuiListClipperData* self,ImGuiListClipper* clipper)
    # ImGuiNavItemData* ImGuiNavItemData_ImGuiNavItemData()
    # void ImGuiNavItemData_destroy(ImGuiNavItemData* self)
    # void ImGuiNavItemData_Clear(ImGuiNavItemData* self)
    # ImGuiOldColumnData* ImGuiOldColumnData_ImGuiOldColumnData()
    # void ImGuiOldColumnData_destroy(ImGuiOldColumnData* self)
    # ImGuiOldColumns* ImGuiOldColumns_ImGuiOldColumns()
    # void ImGuiOldColumns_destroy(ImGuiOldColumns* self)
    # ImGuiDockNode* ImGuiDockNode_ImGuiDockNode(ImGuiID id)
    # void ImGuiDockNode_destroy(ImGuiDockNode* self)
    # bool ImGuiDockNode_IsRootNode(ImGuiDockNode* self)
    # bool ImGuiDockNode_IsDockSpace(ImGuiDockNode* self)
    # bool ImGuiDockNode_IsFloatingNode(ImGuiDockNode* self)
    # bool ImGuiDockNode_IsCentralNode(ImGuiDockNode* self)
    # bool ImGuiDockNode_IsHiddenTabBar(ImGuiDockNode* self)
    # bool ImGuiDockNode_IsNoTabBar(ImGuiDockNode* self)
    # bool ImGuiDockNode_IsSplitNode(ImGuiDockNode* self)
    # bool ImGuiDockNode_IsLeafNode(ImGuiDockNode* self)
    # bool ImGuiDockNode_IsEmpty(ImGuiDockNode* self)
    # void ImGuiDockNode_Rect(ImRect *pOut,ImGuiDockNode* self)
    # void ImGuiDockNode_SetLocalFlags(ImGuiDockNode* self,ImGuiDockNodeFlags flags)
    # void ImGuiDockNode_UpdateMergedFlags(ImGuiDockNode* self)
    # ImGuiDockContext* ImGuiDockContext_ImGuiDockContext()
    # void ImGuiDockContext_destroy(ImGuiDockContext* self)
    # ImGuiViewportP* ImGuiViewportP_ImGuiViewportP()
    # void ImGuiViewportP_destroy(ImGuiViewportP* self)
    # void ImGuiViewportP_ClearRequestFlags(ImGuiViewportP* self)
    # void ImGuiViewportP_CalcWorkRectPos(ImVec2 *pOut,ImGuiViewportP* self,const ImVec2 off_min)
    # void ImGuiViewportP_CalcWorkRectSize(ImVec2 *pOut,ImGuiViewportP* self,const ImVec2 off_min,const ImVec2 off_max)
    # void ImGuiViewportP_UpdateWorkRect(ImGuiViewportP* self)
    # void ImGuiViewportP_GetMainRect(ImRect *pOut,ImGuiViewportP* self)
    # void ImGuiViewportP_GetWorkRect(ImRect *pOut,ImGuiViewportP* self)
    # void ImGuiViewportP_GetBuildWorkRect(ImRect *pOut,ImGuiViewportP* self)
    # ImGuiWindowSettings* ImGuiWindowSettings_ImGuiWindowSettings()
    # void ImGuiWindowSettings_destroy(ImGuiWindowSettings* self)
    # char* ImGuiWindowSettings_GetName(ImGuiWindowSettings* self)
    # ImGuiSettingsHandler* ImGuiSettingsHandler_ImGuiSettingsHandler()
    # void ImGuiSettingsHandler_destroy(ImGuiSettingsHandler* self)
    # ImGuiStackLevelInfo* ImGuiStackLevelInfo_ImGuiStackLevelInfo()
    # void ImGuiStackLevelInfo_destroy(ImGuiStackLevelInfo* self)
    # ImGuiStackTool* ImGuiStackTool_ImGuiStackTool()
    # void ImGuiStackTool_destroy(ImGuiStackTool* self)
    # ImGuiContextHook* ImGuiContextHook_ImGuiContextHook()
    # void ImGuiContextHook_destroy(ImGuiContextHook* self)
    # ImGuiContext* ImGuiContext_ImGuiContext(ImFontAtlas* shared_font_atlas)
    # void ImGuiContext_destroy(ImGuiContext* self)
    # ImGuiWindow* ImGuiWindow_ImGuiWindow(ImGuiContext* context,const char* name)
    # void ImGuiWindow_destroy(ImGuiWindow* self)
    # ImGuiID ImGuiWindow_GetID_Str(ImGuiWindow* self,const char* str,const char* str_end)
    # ImGuiID ImGuiWindow_GetID_Ptr(ImGuiWindow* self,const void* ptr)
    # ImGuiID ImGuiWindow_GetID_Int(ImGuiWindow* self,int n)
    # ImGuiID ImGuiWindow_GetIDFromRectangle(ImGuiWindow* self,const ImRect r_abs)
    # void ImGuiWindow_Rect(ImRect *pOut,ImGuiWindow* self)
    # float ImGuiWindow_CalcFontSize(ImGuiWindow* self)
    # float ImGuiWindow_TitleBarHeight(ImGuiWindow* self)
    # void ImGuiWindow_TitleBarRect(ImRect *pOut,ImGuiWindow* self)
    # float ImGuiWindow_MenuBarHeight(ImGuiWindow* self)
    # void ImGuiWindow_MenuBarRect(ImRect *pOut,ImGuiWindow* self)
    # ImGuiTabItem* ImGuiTabItem_ImGuiTabItem()
    # void ImGuiTabItem_destroy(ImGuiTabItem* self)
    # ImGuiTabBar* ImGuiTabBar_ImGuiTabBar()
    # void ImGuiTabBar_destroy(ImGuiTabBar* self)
    # ImGuiTableColumn* ImGuiTableColumn_ImGuiTableColumn()
    # void ImGuiTableColumn_destroy(ImGuiTableColumn* self)
    # ImGuiTableInstanceData* ImGuiTableInstanceData_ImGuiTableInstanceData()
    # void ImGuiTableInstanceData_destroy(ImGuiTableInstanceData* self)
    # ImGuiTable* ImGuiTable_ImGuiTable()
    # void ImGuiTable_destroy(ImGuiTable* self)
    # ImGuiTableTempData* ImGuiTableTempData_ImGuiTableTempData()
    # void ImGuiTableTempData_destroy(ImGuiTableTempData* self)
    # ImGuiTableColumnSettings* ImGuiTableColumnSettings_ImGuiTableColumnSettings()
    # void ImGuiTableColumnSettings_destroy(ImGuiTableColumnSettings* self)
    # ImGuiTableSettings* ImGuiTableSettings_ImGuiTableSettings()
    # void ImGuiTableSettings_destroy(ImGuiTableSettings* self)
    # ImGuiTableColumnSettings* ImGuiTableSettings_GetColumnSettings(ImGuiTableSettings* self)
    # ImGuiWindow* igGetCurrentWindowRead()
    # ImGuiWindow* igGetCurrentWindow()
    # ImGuiWindow* igFindWindowByID(ImGuiID id)
    # ImGuiWindow* igFindWindowByName(const char* name)
    # void igUpdateWindowParentAndRootLinks(ImGuiWindow* window,ImGuiWindowFlags flags,ImGuiWindow* parent_window)
    # void igCalcWindowNextAutoFitSize(ImVec2 *pOut,ImGuiWindow* window)
    # bool igIsWindowChildOf(ImGuiWindow* window,ImGuiWindow* potential_parent,bool popup_hierarchy,bool dock_hierarchy)
    # bool igIsWindowWithinBeginStackOf(ImGuiWindow* window,ImGuiWindow* potential_parent)
    # bool igIsWindowAbove(ImGuiWindow* potential_above,ImGuiWindow* potential_below)
    # bool igIsWindowNavFocusable(ImGuiWindow* window)
    # void igSetWindowPos_WindowPtr(ImGuiWindow* window,const ImVec2 pos,ImGuiCond cond)
    # void igSetWindowSize_WindowPtr(ImGuiWindow* window,const ImVec2 size,ImGuiCond cond)
    # void igSetWindowCollapsed_WindowPtr(ImGuiWindow* window,bool collapsed,ImGuiCond cond)
    # void igSetWindowHitTestHole(ImGuiWindow* window,const ImVec2 pos,const ImVec2 size)
    # void igWindowRectAbsToRel(ImRect *pOut,ImGuiWindow* window,const ImRect r)
    # void igWindowRectRelToAbs(ImRect *pOut,ImGuiWindow* window,const ImRect r)
    # void igFocusWindow(ImGuiWindow* window)
    # void igFocusTopMostWindowUnderOne(ImGuiWindow* under_this_window,ImGuiWindow* ignore_window)
    # void igBringWindowToFocusFront(ImGuiWindow* window)
    # void igBringWindowToDisplayFront(ImGuiWindow* window)
    # void igBringWindowToDisplayBack(ImGuiWindow* window)
    # void igBringWindowToDisplayBehind(ImGuiWindow* window,ImGuiWindow* above_window)
    # int igFindWindowDisplayIndex(ImGuiWindow* window)
    # ImGuiWindow* igFindBottomMostVisibleWindowWithinBeginStack(ImGuiWindow* window)
    # void igSetCurrentFont(ImFont* font)
    # ImFont* igGetDefaultFont()
    # ImDrawList* igGetForegroundDrawList_WindowPtr(ImGuiWindow* window)
    # void igInitialize()
    # void igShutdown()
    # void igUpdateInputEvents(bool trickle_fast_inputs)
    # void igUpdateHoveredWindowAndCaptureFlags()
    # void igStartMouseMovingWindow(ImGuiWindow* window)
    # void igStartMouseMovingWindowOrNode(ImGuiWindow* window,ImGuiDockNode* node,bool undock_floating_node)
    # void igUpdateMouseMovingWindowNewFrame()
    # void igUpdateMouseMovingWindowEndFrame()
    # ImGuiID igAddContextHook(ImGuiContext* context,const ImGuiContextHook* hook)
    # void igRemoveContextHook(ImGuiContext* context,ImGuiID hook_to_remove)
    # void igCallContextHooks(ImGuiContext* context,ImGuiContextHookType type)
    # void igTranslateWindowsInViewport(ImGuiViewportP* viewport,const ImVec2 old_pos,const ImVec2 new_pos)
    # void igScaleWindowsInViewport(ImGuiViewportP* viewport,float scale)
    # void igDestroyPlatformWindow(ImGuiViewportP* viewport)
    # void igSetWindowViewport(ImGuiWindow* window,ImGuiViewportP* viewport)
    # void igSetCurrentViewport(ImGuiWindow* window,ImGuiViewportP* viewport)
    # const ImGuiPlatformMonitor* igGetViewportPlatformMonitor(ImGuiViewport* viewport)
    # ImGuiViewportP* igFindHoveredViewportFromPlatformWindowStack(const ImVec2 mouse_platform_pos)
    # void igMarkIniSettingsDirty_Nil()
    # void igMarkIniSettingsDirty_WindowPtr(ImGuiWindow* window)
    # void igClearIniSettings()
    # void igAddSettingsHandler(const ImGuiSettingsHandler* handler)
    # void igRemoveSettingsHandler(const char* type_name)
    # ImGuiSettingsHandler* igFindSettingsHandler(const char* type_name)
    # ImGuiWindowSettings* igCreateNewWindowSettings(const char* name)
    # ImGuiWindowSettings* igFindWindowSettingsByID(ImGuiID id)
    # ImGuiWindowSettings* igFindWindowSettingsByWindow(ImGuiWindow* window)
    # void igClearWindowSettings(const char* name)
    # void igLocalizeRegisterEntries(const ImGuiLocEntry* entries,int count)
    # const char* igLocalizeGetMsg(ImGuiLocKey key)
    # void igSetScrollX_WindowPtr(ImGuiWindow* window,float scroll_x)
    # void igSetScrollY_WindowPtr(ImGuiWindow* window,float scroll_y)
    # void igSetScrollFromPosX_WindowPtr(ImGuiWindow* window,float local_x,float center_x_ratio)
    # void igSetScrollFromPosY_WindowPtr(ImGuiWindow* window,float local_y,float center_y_ratio)
    # void igScrollToItem(ImGuiScrollFlags flags)
    # void igScrollToRect(ImGuiWindow* window,const ImRect rect,ImGuiScrollFlags flags)
    # void igScrollToRectEx(ImVec2 *pOut,ImGuiWindow* window,const ImRect rect,ImGuiScrollFlags flags)
    # void igScrollToBringRectIntoView(ImGuiWindow* window,const ImRect rect)
    # ImGuiItemStatusFlags igGetItemStatusFlags()
    # ImGuiItemFlags igGetItemFlags()
    # ImGuiID igGetActiveID()
    # ImGuiID igGetFocusID()
    # void igSetActiveID(ImGuiID id,ImGuiWindow* window)
    # void igSetFocusID(ImGuiID id,ImGuiWindow* window)
    # void igClearActiveID()
    # ImGuiID igGetHoveredID()
    # void igSetHoveredID(ImGuiID id)
    # void igKeepAliveID(ImGuiID id)
    # void igMarkItemEdited(ImGuiID id)
    # void igPushOverrideID(ImGuiID id)
    # ImGuiID igGetIDWithSeed_Str(const char* str_id_begin,const char* str_id_end,ImGuiID seed)
    # ImGuiID igGetIDWithSeed_Int(int n,ImGuiID seed)
    # void igItemSize_Vec2(const ImVec2 size,float text_baseline_y)
    # void igItemSize_Rect(const ImRect bb,float text_baseline_y)
    # bool igItemAdd(const ImRect bb,ImGuiID id,const ImRect* nav_bb,ImGuiItemFlags extra_flags)
    # bool igItemHoverable(const ImRect bb,ImGuiID id)
    # bool igIsClippedEx(const ImRect bb,ImGuiID id)
    # void igSetLastItemData(ImGuiID item_id,ImGuiItemFlags in_flags,ImGuiItemStatusFlags status_flags,const ImRect item_rect)
    # void igCalcItemSize(ImVec2 *pOut,ImVec2 size,float default_w,float default_h)
    # float igCalcWrapWidthForPos(const ImVec2 pos,float wrap_pos_x)
    # void igPushMultiItemsWidths(int components,float width_full)
    # bool igIsItemToggledSelection()
    # void igGetContentRegionMaxAbs(ImVec2 *pOut)
    # void igShrinkWidths(ImGuiShrinkWidthItem* items,int count,float width_excess)
    # void igPushItemFlag(ImGuiItemFlags option,bool enabled)
    # void igPopItemFlag()
    # void igLogBegin(ImGuiLogType type,int auto_open_depth)
    # void igLogToBuffer(int auto_open_depth)
    # void igLogRenderedText(const ImVec2* ref_pos,const char* text,const char* text_end)
    # void igLogSetNextTextDecoration(const char* prefix,const char* suffix)
    # bool igBeginChildEx(const char* name,ImGuiID id,const ImVec2 size_arg,bool border,ImGuiWindowFlags flags)
    # void igOpenPopupEx(ImGuiID id,ImGuiPopupFlags popup_flags)
    # void igClosePopupToLevel(int remaining,bool restore_focus_to_window_under_popup)
    # void igClosePopupsOverWindow(ImGuiWindow* ref_window,bool restore_focus_to_window_under_popup)
    # void igClosePopupsExceptModals()
    # bool igIsPopupOpen_ID(ImGuiID id,ImGuiPopupFlags popup_flags)
    # bool igBeginPopupEx(ImGuiID id,ImGuiWindowFlags extra_flags)
    # void igBeginTooltipEx(ImGuiTooltipFlags tooltip_flags,ImGuiWindowFlags extra_window_flags)
    # void igGetPopupAllowedExtentRect(ImRect *pOut,ImGuiWindow* window)
    # ImGuiWindow* igGetTopMostPopupModal()
    # ImGuiWindow* igGetTopMostAndVisiblePopupModal()
    # void igFindBestWindowPosForPopup(ImVec2 *pOut,ImGuiWindow* window)
    # void igFindBestWindowPosForPopupEx(ImVec2 *pOut,const ImVec2 ref_pos,const ImVec2 size,ImGuiDir* last_dir,const ImRect r_outer,const ImRect r_avoid,ImGuiPopupPositionPolicy policy)
    # bool igBeginViewportSideBar(const char* name,ImGuiViewport* viewport,ImGuiDir dir,float size,ImGuiWindowFlags window_flags)
    # bool igBeginMenuEx(const char* label,const char* icon,bool enabled)
    # bool igMenuItemEx(const char* label,const char* icon,const char* shortcut,bool selected,bool enabled)
    # bool igBeginComboPopup(ImGuiID popup_id,const ImRect bb,ImGuiComboFlags flags)
    # bool igBeginComboPreview()
    # void igEndComboPreview()
    # void igNavInitWindow(ImGuiWindow* window,bool force_reinit)
    # void igNavInitRequestApplyResult()
    # bool igNavMoveRequestButNoResultYet()
    # void igNavMoveRequestSubmit(ImGuiDir move_dir,ImGuiDir clip_dir,ImGuiNavMoveFlags move_flags,ImGuiScrollFlags scroll_flags)
    # void igNavMoveRequestForward(ImGuiDir move_dir,ImGuiDir clip_dir,ImGuiNavMoveFlags move_flags,ImGuiScrollFlags scroll_flags)
    # void igNavMoveRequestResolveWithLastItem(ImGuiNavItemData* result)
    # void igNavMoveRequestCancel()
    # void igNavMoveRequestApplyResult()
    # void igNavMoveRequestTryWrapping(ImGuiWindow* window,ImGuiNavMoveFlags move_flags)
    # void igActivateItem(ImGuiID id)
    # void igSetNavWindow(ImGuiWindow* window)
    # void igSetNavID(ImGuiID id,ImGuiNavLayer nav_layer,ImGuiID focus_scope_id,const ImRect rect_rel)
    # bool igIsNamedKey(ImGuiKey key)
    # bool igIsNamedKeyOrModKey(ImGuiKey key)
    # bool igIsLegacyKey(ImGuiKey key)
    # bool igIsKeyboardKey(ImGuiKey key)
    # bool igIsGamepadKey(ImGuiKey key)
    # bool igIsMouseKey(ImGuiKey key)
    # bool igIsAliasKey(ImGuiKey key)
    # ImGuiKeyChord igConvertShortcutMod(ImGuiKeyChord key_chord)
    # ImGuiKey igConvertSingleModFlagToKey(ImGuiKey key)
    # ImGuiKeyData* igGetKeyData(ImGuiKey key)
    # void igGetKeyChordName(ImGuiKeyChord key_chord,char* out_buf,int out_buf_size)
    # ImGuiKey igMouseButtonToKey(ImGuiMouseButton button)
    # bool igIsMouseDragPastThreshold(ImGuiMouseButton button,float lock_threshold)
    # void igGetKeyMagnitude2d(ImVec2 *pOut,ImGuiKey key_left,ImGuiKey key_right,ImGuiKey key_up,ImGuiKey key_down)
    # float igGetNavTweakPressedAmount(ImGuiAxis axis)
    # int igCalcTypematicRepeatAmount(float t0,float t1,float repeat_delay,float repeat_rate)
    # void igGetTypematicRepeatRate(ImGuiInputFlags flags,float* repeat_delay,float* repeat_rate)
    # void igSetActiveIdUsingAllKeyboardKeys()
    # bool igIsActiveIdUsingNavDir(ImGuiDir dir)
    # ImGuiID igGetKeyOwner(ImGuiKey key)
    # void igSetKeyOwner(ImGuiKey key,ImGuiID owner_id,ImGuiInputFlags flags)
    # void igSetItemKeyOwner(ImGuiKey key,ImGuiInputFlags flags)
    # bool igTestKeyOwner(ImGuiKey key,ImGuiID owner_id)
    # ImGuiKeyOwnerData* igGetKeyOwnerData(ImGuiKey key)
    # bool igIsKeyDown_ID(ImGuiKey key,ImGuiID owner_id)
    # bool igIsKeyPressed_ID(ImGuiKey key,ImGuiID owner_id,ImGuiInputFlags flags)
    # bool igIsKeyReleased_ID(ImGuiKey key,ImGuiID owner_id)
    # bool igIsMouseDown_ID(ImGuiMouseButton button,ImGuiID owner_id)
    # bool igIsMouseClicked_ID(ImGuiMouseButton button,ImGuiID owner_id,ImGuiInputFlags flags)
    # bool igIsMouseReleased_ID(ImGuiMouseButton button,ImGuiID owner_id)
    # bool igShortcut(ImGuiKeyChord key_chord,ImGuiID owner_id,ImGuiInputFlags flags)
    # bool igSetShortcutRouting(ImGuiKeyChord key_chord,ImGuiID owner_id,ImGuiInputFlags flags)
    # bool igTestShortcutRouting(ImGuiKeyChord key_chord,ImGuiID owner_id)
    # ImGuiKeyRoutingData* igGetShortcutRoutingData(ImGuiKeyChord key_chord)
    # void igDockContextInitialize(ImGuiContext* ctx)
    # void igDockContextShutdown(ImGuiContext* ctx)
    # void igDockContextClearNodes(ImGuiContext* ctx,ImGuiID root_id,bool clear_settings_refs)
    # void igDockContextRebuildNodes(ImGuiContext* ctx)
    # void igDockContextNewFrameUpdateUndocking(ImGuiContext* ctx)
    # void igDockContextNewFrameUpdateDocking(ImGuiContext* ctx)
    # void igDockContextEndFrame(ImGuiContext* ctx)
    # ImGuiID igDockContextGenNodeID(ImGuiContext* ctx)
    # void igDockContextQueueDock(ImGuiContext* ctx,ImGuiWindow* target,ImGuiDockNode* target_node,ImGuiWindow* payload,ImGuiDir split_dir,float split_ratio,bool split_outer)
    # void igDockContextQueueUndockWindow(ImGuiContext* ctx,ImGuiWindow* window)
    # void igDockContextQueueUndockNode(ImGuiContext* ctx,ImGuiDockNode* node)
    # void igDockContextProcessUndockWindow(ImGuiContext* ctx,ImGuiWindow* window,bool clear_persistent_docking_ref)
    # void igDockContextProcessUndockNode(ImGuiContext* ctx,ImGuiDockNode* node)
    # bool igDockContextCalcDropPosForDocking(ImGuiWindow* target,ImGuiDockNode* target_node,ImGuiWindow* payload_window,ImGuiDockNode* payload_node,ImGuiDir split_dir,bool split_outer,ImVec2* out_pos)
    # ImGuiDockNode* igDockContextFindNodeByID(ImGuiContext* ctx,ImGuiID id)
    # bool igDockNodeBeginAmendTabBar(ImGuiDockNode* node)
    # void igDockNodeEndAmendTabBar()
    # ImGuiDockNode* igDockNodeGetRootNode(ImGuiDockNode* node)
    # bool igDockNodeIsInHierarchyOf(ImGuiDockNode* node,ImGuiDockNode* parent)
    # int igDockNodeGetDepth(const ImGuiDockNode* node)
    # ImGuiID igDockNodeGetWindowMenuButtonId(const ImGuiDockNode* node)
    # ImGuiDockNode* igGetWindowDockNode()
    # bool igGetWindowAlwaysWantOwnTabBar(ImGuiWindow* window)
    # void igBeginDocked(ImGuiWindow* window,bool* p_open)
    # void igBeginDockableDragDropSource(ImGuiWindow* window)
    # void igBeginDockableDragDropTarget(ImGuiWindow* window)
    # void igSetWindowDock(ImGuiWindow* window,ImGuiID dock_id,ImGuiCond cond)
    # void igDockBuilderDockWindow(const char* window_name,ImGuiID node_id)
    # ImGuiDockNode* igDockBuilderGetNode(ImGuiID node_id)
    # ImGuiDockNode* igDockBuilderGetCentralNode(ImGuiID node_id)
    # ImGuiID igDockBuilderAddNode(ImGuiID node_id,ImGuiDockNodeFlags flags)
    # void igDockBuilderRemoveNode(ImGuiID node_id)
    # void igDockBuilderRemoveNodeDockedWindows(ImGuiID node_id,bool clear_settings_refs)
    # void igDockBuilderRemoveNodeChildNodes(ImGuiID node_id)
    # void igDockBuilderSetNodePos(ImGuiID node_id,ImVec2 pos)
    # void igDockBuilderSetNodeSize(ImGuiID node_id,ImVec2 size)
    # ImGuiID igDockBuilderSplitNode(ImGuiID node_id,ImGuiDir split_dir,float size_ratio_for_node_at_dir,ImGuiID* out_id_at_dir,ImGuiID* out_id_at_opposite_dir)
    # void igDockBuilderCopyDockSpace(ImGuiID src_dockspace_id,ImGuiID dst_dockspace_id,ImVector_const_charPtr* in_window_remap_pairs)
    # void igDockBuilderCopyNode(ImGuiID src_node_id,ImGuiID dst_node_id,ImVector_ImGuiID* out_node_remap_pairs)
    # void igDockBuilderCopyWindowSettings(const char* src_name,const char* dst_name)
    # void igDockBuilderFinish(ImGuiID node_id)
    # void igPushFocusScope(ImGuiID id)
    # void igPopFocusScope()
    # ImGuiID igGetCurrentFocusScope()
    # bool igIsDragDropActive()
    # bool igBeginDragDropTargetCustom(const ImRect bb,ImGuiID id)
    # void igClearDragDrop()
    # bool igIsDragDropPayloadBeingAccepted()
    # void igRenderDragDropTargetRect(const ImRect bb)
    # void igSetWindowClipRectBeforeSetChannel(ImGuiWindow* window,const ImRect clip_rect)
    # void igBeginColumns(const char* str_id,int count,ImGuiOldColumnFlags flags)
    # void igEndColumns()
    # void igPushColumnClipRect(int column_index)
    # void igPushColumnsBackground()
    # void igPopColumnsBackground()
    # ImGuiID igGetColumnsID(const char* str_id,int count)
    # ImGuiOldColumns* igFindOrCreateColumns(ImGuiWindow* window,ImGuiID id)
    # float igGetColumnOffsetFromNorm(const ImGuiOldColumns* columns,float offset_norm)
    # float igGetColumnNormFromOffset(const ImGuiOldColumns* columns,float offset)
    # void igTableOpenContextMenu(int column_n)
    # void igTableSetColumnWidth(int column_n,float width)
    # void igTableSetColumnSortDirection(int column_n,ImGuiSortDirection sort_direction,bool append_to_sort_specs)
    # int igTableGetHoveredColumn()
    # float igTableGetHeaderRowHeight()
    # void igTablePushBackgroundChannel()
    # void igTablePopBackgroundChannel()
    # ImGuiTable* igGetCurrentTable()
    # ImGuiTable* igTableFindByID(ImGuiID id)
    # bool igBeginTableEx(const char* name,ImGuiID id,int columns_count,ImGuiTableFlags flags,const ImVec2 outer_size,float inner_width)
    # void igTableBeginInitMemory(ImGuiTable* table,int columns_count)
    # void igTableBeginApplyRequests(ImGuiTable* table)
    # void igTableSetupDrawChannels(ImGuiTable* table)
    # void igTableUpdateLayout(ImGuiTable* table)
    # void igTableUpdateBorders(ImGuiTable* table)
    # void igTableUpdateColumnsWeightFromWidth(ImGuiTable* table)
    # void igTableDrawBorders(ImGuiTable* table)
    # void igTableDrawContextMenu(ImGuiTable* table)
    # bool igTableBeginContextMenuPopup(ImGuiTable* table)
    # void igTableMergeDrawChannels(ImGuiTable* table)
    # ImGuiTableInstanceData* igTableGetInstanceData(ImGuiTable* table,int instance_no)
    # ImGuiID igTableGetInstanceID(ImGuiTable* table,int instance_no)
    # void igTableSortSpecsSanitize(ImGuiTable* table)
    # void igTableSortSpecsBuild(ImGuiTable* table)
    # ImGuiSortDirection igTableGetColumnNextSortDirection(ImGuiTableColumn* column)
    # void igTableFixColumnSortDirection(ImGuiTable* table,ImGuiTableColumn* column)
    # float igTableGetColumnWidthAuto(ImGuiTable* table,ImGuiTableColumn* column)
    # void igTableBeginRow(ImGuiTable* table)
    # void igTableEndRow(ImGuiTable* table)
    # void igTableBeginCell(ImGuiTable* table,int column_n)
    # void igTableEndCell(ImGuiTable* table)
    # void igTableGetCellBgRect(ImRect *pOut,const ImGuiTable* table,int column_n)
    # const char* igTableGetColumnName_TablePtr(const ImGuiTable* table,int column_n)
    # ImGuiID igTableGetColumnResizeID(ImGuiTable* table,int column_n,int instance_no)
    # float igTableGetMaxColumnWidth(const ImGuiTable* table,int column_n)
    # void igTableSetColumnWidthAutoSingle(ImGuiTable* table,int column_n)
    # void igTableSetColumnWidthAutoAll(ImGuiTable* table)
    # void igTableRemove(ImGuiTable* table)
    # void igTableGcCompactTransientBuffers_TablePtr(ImGuiTable* table)
    # void igTableGcCompactTransientBuffers_TableTempDataPtr(ImGuiTableTempData* table)
    # void igTableGcCompactSettings()
    # void igTableLoadSettings(ImGuiTable* table)
    # void igTableSaveSettings(ImGuiTable* table)
    # void igTableResetSettings(ImGuiTable* table)
    # ImGuiTableSettings* igTableGetBoundSettings(ImGuiTable* table)
    # void igTableSettingsAddSettingsHandler()
    # ImGuiTableSettings* igTableSettingsCreate(ImGuiID id,int columns_count)
    # ImGuiTableSettings* igTableSettingsFindByID(ImGuiID id)
    # ImGuiTabBar* igGetCurrentTabBar()
    # bool igBeginTabBarEx(ImGuiTabBar* tab_bar,const ImRect bb,ImGuiTabBarFlags flags,ImGuiDockNode* dock_node)
    # ImGuiTabItem* igTabBarFindTabByID(ImGuiTabBar* tab_bar,ImGuiID tab_id)
    # ImGuiTabItem* igTabBarFindTabByOrder(ImGuiTabBar* tab_bar,int order)
    # ImGuiTabItem* igTabBarFindMostRecentlySelectedTabForActiveWindow(ImGuiTabBar* tab_bar)
    # ImGuiTabItem* igTabBarGetCurrentTab(ImGuiTabBar* tab_bar)
    # int igTabBarGetTabOrder(ImGuiTabBar* tab_bar,ImGuiTabItem* tab)
    # const char* igTabBarGetTabName(ImGuiTabBar* tab_bar,ImGuiTabItem* tab)
    # void igTabBarAddTab(ImGuiTabBar* tab_bar,ImGuiTabItemFlags tab_flags,ImGuiWindow* window)
    # void igTabBarRemoveTab(ImGuiTabBar* tab_bar,ImGuiID tab_id)
    # void igTabBarCloseTab(ImGuiTabBar* tab_bar,ImGuiTabItem* tab)
    # void igTabBarQueueFocus(ImGuiTabBar* tab_bar,ImGuiTabItem* tab)
    # void igTabBarQueueReorder(ImGuiTabBar* tab_bar,ImGuiTabItem* tab,int offset)
    # void igTabBarQueueReorderFromMousePos(ImGuiTabBar* tab_bar,ImGuiTabItem* tab,ImVec2 mouse_pos)
    # bool igTabBarProcessReorder(ImGuiTabBar* tab_bar)
    # bool igTabItemEx(ImGuiTabBar* tab_bar,const char* label,bool* p_open,ImGuiTabItemFlags flags,ImGuiWindow* docked_window)
    # void igTabItemCalcSize_Str(ImVec2 *pOut,const char* label,bool has_close_button_or_unsaved_marker)
    # void igTabItemCalcSize_WindowPtr(ImVec2 *pOut,ImGuiWindow* window)
    # void igTabItemBackground(ImDrawList* draw_list,const ImRect bb,ImGuiTabItemFlags flags,ImU32 col)
    # void igTabItemLabelAndCloseButton(ImDrawList* draw_list,const ImRect bb,ImGuiTabItemFlags flags,ImVec2 frame_padding,const char* label,ImGuiID tab_id,ImGuiID close_button_id,bool is_contents_visible,bool* out_just_closed,bool* out_text_clipped)
    # void igRenderText(ImVec2 pos,const char* text,const char* text_end,bool hide_text_after_hash)
    # void igRenderTextWrapped(ImVec2 pos,const char* text,const char* text_end,float wrap_width)
    # void igRenderTextClipped(const ImVec2 pos_min,const ImVec2 pos_max,const char* text,const char* text_end,const ImVec2* text_size_if_known,const ImVec2 align,const ImRect* clip_rect)
    # void igRenderTextClippedEx(ImDrawList* draw_list,const ImVec2 pos_min,const ImVec2 pos_max,const char* text,const char* text_end,const ImVec2* text_size_if_known,const ImVec2 align,const ImRect* clip_rect)
    # void igRenderTextEllipsis(ImDrawList* draw_list,const ImVec2 pos_min,const ImVec2 pos_max,float clip_max_x,float ellipsis_max_x,const char* text,const char* text_end,const ImVec2* text_size_if_known)
    # void igRenderFrame(ImVec2 p_min,ImVec2 p_max,ImU32 fill_col,bool border,float rounding)
    # void igRenderFrameBorder(ImVec2 p_min,ImVec2 p_max,float rounding)
    # void igRenderColorRectWithAlphaCheckerboard(ImDrawList* draw_list,ImVec2 p_min,ImVec2 p_max,ImU32 fill_col,float grid_step,ImVec2 grid_off,float rounding,ImDrawFlags flags)
    # void igRenderNavHighlight(const ImRect bb,ImGuiID id,ImGuiNavHighlightFlags flags)
    # const char* igFindRenderedTextEnd(const char* text,const char* text_end)
    # void igRenderMouseCursor(ImVec2 pos,float scale,ImGuiMouseCursor mouse_cursor,ImU32 col_fill,ImU32 col_border,ImU32 col_shadow)
    # void igRenderArrow(ImDrawList* draw_list,ImVec2 pos,ImU32 col,ImGuiDir dir,float scale)
    # void igRenderBullet(ImDrawList* draw_list,ImVec2 pos,ImU32 col)
    # void igRenderCheckMark(ImDrawList* draw_list,ImVec2 pos,ImU32 col,float sz)
    # void igRenderArrowPointingAt(ImDrawList* draw_list,ImVec2 pos,ImVec2 half_sz,ImGuiDir direction,ImU32 col)
    # void igRenderArrowDockMenu(ImDrawList* draw_list,ImVec2 p_min,float sz,ImU32 col)
    # void igRenderRectFilledRangeH(ImDrawList* draw_list,const ImRect rect,ImU32 col,float x_start_norm,float x_end_norm,float rounding)
    # void igRenderRectFilledWithHole(ImDrawList* draw_list,const ImRect outer,const ImRect inner,ImU32 col,float rounding)
    # ImDrawFlags igCalcRoundingFlagsForRectInRect(const ImRect r_in,const ImRect r_outer,float threshold)
    # void igTextEx(const char* text,const char* text_end,ImGuiTextFlags flags)
    # bool igButtonEx(const char* label,const ImVec2 size_arg,ImGuiButtonFlags flags)
    # bool igArrowButtonEx(const char* str_id,ImGuiDir dir,ImVec2 size_arg,ImGuiButtonFlags flags)
    # bool igImageButtonEx(ImGuiID id,ImTextureID texture_id,const ImVec2 size,const ImVec2 uv0,const ImVec2 uv1,const ImVec4 bg_col,const ImVec4 tint_col,ImGuiButtonFlags flags)
    # void igSeparatorEx(ImGuiSeparatorFlags flags)
    # void igSeparatorTextEx(ImGuiID id,const char* label,const char* label_end,float extra_width)
    # bool igCheckboxFlags_S64Ptr(const char* label,ImS64* flags,ImS64 flags_value)
    # bool igCheckboxFlags_U64Ptr(const char* label,ImU64* flags,ImU64 flags_value)
    # bool igCloseButton(ImGuiID id,const ImVec2 pos)
    # bool igCollapseButton(ImGuiID id,const ImVec2 pos,ImGuiDockNode* dock_node)
    # void igScrollbar(ImGuiAxis axis)
    # bool igScrollbarEx(const ImRect bb,ImGuiID id,ImGuiAxis axis,ImS64* p_scroll_v,ImS64 avail_v,ImS64 contents_v,ImDrawFlags flags)
    # void igGetWindowScrollbarRect(ImRect *pOut,ImGuiWindow* window,ImGuiAxis axis)
    # ImGuiID igGetWindowScrollbarID(ImGuiWindow* window,ImGuiAxis axis)
    # ImGuiID igGetWindowResizeCornerID(ImGuiWindow* window,int n)
    # ImGuiID igGetWindowResizeBorderID(ImGuiWindow* window,ImGuiDir dir)
    # bool igButtonBehavior(const ImRect bb,ImGuiID id,bool* out_hovered,bool* out_held,ImGuiButtonFlags flags)
    # bool igDragBehavior(ImGuiID id,ImGuiDataType data_type,void* p_v,float v_speed,const void* p_min,const void* p_max,const char* format,ImGuiSliderFlags flags)
    # bool igSliderBehavior(const ImRect bb,ImGuiID id,ImGuiDataType data_type,void* p_v,const void* p_min,const void* p_max,const char* format,ImGuiSliderFlags flags,ImRect* out_grab_bb)
    # bool igSplitterBehavior(const ImRect bb,ImGuiID id,ImGuiAxis axis,float* size1,float* size2,float min_size1,float min_size2,float hover_extend,float hover_visibility_delay,ImU32 bg_col)
    # bool igTreeNodeBehavior(ImGuiID id,ImGuiTreeNodeFlags flags,const char* label,const char* label_end)
    # void igTreePushOverrideID(ImGuiID id)
    # void igTreeNodeSetOpen(ImGuiID id,bool open)
    # bool igTreeNodeUpdateNextOpen(ImGuiID id,ImGuiTreeNodeFlags flags)
    # const ImGuiDataTypeInfo* igDataTypeGetInfo(ImGuiDataType data_type)
    # int igDataTypeFormatString(char* buf,int buf_size,ImGuiDataType data_type,const void* p_data,const char* format)
    # void igDataTypeApplyOp(ImGuiDataType data_type,int op,void* output,const void* arg_1,const void* arg_2)
    # bool igDataTypeApplyFromText(const char* buf,ImGuiDataType data_type,void* p_data,const char* format)
    # int igDataTypeCompare(ImGuiDataType data_type,const void* arg_1,const void* arg_2)
    # bool igDataTypeClamp(ImGuiDataType data_type,void* p_data,const void* p_min,const void* p_max)
    # bool igInputTextEx(const char* label,const char* hint,char* buf,int buf_size,const ImVec2 size_arg,ImGuiInputTextFlags flags,ImGuiInputTextCallback callback,void* user_data)
    # bool igTempInputText(const ImRect bb,ImGuiID id,const char* label,char* buf,int buf_size,ImGuiInputTextFlags flags)
    # bool igTempInputScalar(const ImRect bb,ImGuiID id,const char* label,ImGuiDataType data_type,void* p_data,const char* format,const void* p_clamp_min,const void* p_clamp_max)
    # bool igTempInputIsActive(ImGuiID id)
    # ImGuiInputTextState* igGetInputTextState(ImGuiID id)
    # void igColorTooltip(const char* text,const float* col,ImGuiColorEditFlags flags)
    # void igColorEditOptionsPopup(const float* col,ImGuiColorEditFlags flags)
    # void igColorPickerOptionsPopup(const float* ref_col,ImGuiColorEditFlags flags)
    # int igPlotEx(ImGuiPlotType plot_type,const char* label,float(*values_getter)(void* data,int idx),void* data,int values_count,int values_offset,const char* overlay_text,float scale_min,float scale_max,const ImVec2 size_arg)
    # void igShadeVertsLinearColorGradientKeepAlpha(ImDrawList* draw_list,int vert_start_idx,int vert_end_idx,ImVec2 gradient_p0,ImVec2 gradient_p1,ImU32 col0,ImU32 col1)
    # void igShadeVertsLinearUV(ImDrawList* draw_list,int vert_start_idx,int vert_end_idx,const ImVec2 a,const ImVec2 b,const ImVec2 uv_a,const ImVec2 uv_b,bool clamp)
    # void igGcCompactTransientMiscBuffers()
    # void igGcCompactTransientWindowBuffers(ImGuiWindow* window)
    # void igGcAwakeTransientWindowBuffers(ImGuiWindow* window)
    # void igDebugLog(const char* fmt,...)
    # void igDebugLogV(const char* fmt,va_list args)
    # void igErrorCheckEndFrameRecover(ImGuiErrorLogCallback log_callback,void* user_data)
    # void igErrorCheckEndWindowRecover(ImGuiErrorLogCallback log_callback,void* user_data)
    # void igErrorCheckUsingSetCursorPosToExtendParentBoundaries()
    # void igDebugLocateItem(ImGuiID target_id)
    # void igDebugLocateItemOnHover(ImGuiID target_id)
    # void igDebugLocateItemResolveWithLastItem()
    # void igDebugDrawItemRect(ImU32 col)
    # void igDebugStartItemPicker()
    # void igShowFontAtlas(ImFontAtlas* atlas)
    # void igDebugHookIdInfo(ImGuiID id,ImGuiDataType data_type,const void* data_id,const void* data_id_end)
    # void igDebugNodeColumns(ImGuiOldColumns* columns)
    # void igDebugNodeDockNode(ImGuiDockNode* node,const char* label)
    # void igDebugNodeDrawList(ImGuiWindow* window,ImGuiViewportP* viewport,const ImDrawList* draw_list,const char* label)
    # void igDebugNodeDrawCmdShowMeshAndBoundingBox(ImDrawList* out_draw_list,const ImDrawList* draw_list,const ImDrawCmd* draw_cmd,bool show_mesh,bool show_aabb)
    # void igDebugNodeFont(ImFont* font)
    # void igDebugNodeFontGlyph(ImFont* font,const ImFontGlyph* glyph)
    # void igDebugNodeStorage(ImGuiStorage* storage,const char* label)
    # void igDebugNodeTabBar(ImGuiTabBar* tab_bar,const char* label)
    # void igDebugNodeTable(ImGuiTable* table)
    # void igDebugNodeTableSettings(ImGuiTableSettings* settings)
    # void igDebugNodeInputTextState(ImGuiInputTextState* state)
    # void igDebugNodeWindow(ImGuiWindow* window,const char* label)
    # void igDebugNodeWindowSettings(ImGuiWindowSettings* settings)
    # void igDebugNodeWindowsList(ImVector_ImGuiWindowPtr* windows,const char* label)
    # void igDebugNodeWindowsListByBeginStackParent(ImGuiWindow** windows,int windows_size,ImGuiWindow* parent_in_begin_stack)
    # void igDebugNodeViewport(ImGuiViewportP* viewport)
    # void igDebugRenderKeyboardPreview(ImDrawList* draw_list)
    # void igDebugRenderViewportThumbnail(ImDrawList* draw_list,ImGuiViewportP* viewport,const ImRect bb)
    # bool igIsKeyPressedMap(ImGuiKey key,bool repeat)
    # const ImFontBuilderIO* igImFontAtlasGetBuilderForStbTruetype()
    # void igImFontAtlasBuildInit(ImFontAtlas* atlas)
    # void igImFontAtlasBuildSetupFont(ImFontAtlas* atlas,ImFont* font,ImFontConfig* font_config,float ascent,float descent)
    # void igImFontAtlasBuildPackCustomRects(ImFontAtlas* atlas,void* stbrp_context_opaque)
    # void igImFontAtlasBuildFinish(ImFontAtlas* atlas)
    # void igImFontAtlasBuildRender8bppRectFromString(ImFontAtlas* atlas,int x,int y,int w,int h,const char* in_str,char in_marker_char,unsigned char in_marker_pixel_value)
    # void igImFontAtlasBuildRender32bppRectFromString(ImFontAtlas* atlas,int x,int y,int w,int h,const char* in_str,char in_marker_char,unsigned int in_marker_pixel_value)
    # void igImFontAtlasBuildMultiplyCalcLookupTable(unsigned char out_table[256],float in_multiply_factor)
    # void igImFontAtlasBuildMultiplyRectAlpha8(const unsigned char table[256],unsigned char* pixels,int x,int y,int w,int h,int stride)


# /////////////////////////hand written functions
# //no LogTextV
#     void igLogText(const char *fmt, ...)
# # //no appendfV
#     void ImGuiTextBuffer_appendf(ImGuiTextBuffer *buffer, const char *fmt, ...)
# # //for getting FLT_MAX in bindings
#     float igGET_FLT_MAX()
# # //for getting FLT_MIN in bindings
#     float igGET_FLT_MIN()


#     ImVector_ImWchar* ImVector_ImWchar_create()
#     void ImVector_ImWchar_destroy(ImVector_ImWchar* self)
#     void ImVector_ImWchar_Init(ImVector_ImWchar* p)
#     void ImVector_ImWchar_UnInit(ImVector_ImWchar* p)



# cdef extern from "imgui.h":
#     ctypedef struct ImGuiKeyData:
#         bool Down
#         float DownDuration
#         float DownDurationPrev
#         float AnalogValue

#     ctypedef struct ImVector_ImWchar:
#         int Size
#         int Capacity
#         ImWchar* Data

    

#     cdef cppclass ImVector[T]:
#         int        Size
#         int        Capacity
#         T*         Data

#     ctypedef struct ImGuiContext:
#         pass
    
#     ctypedef struct ImGuiIO:
#         # ====
#         # source-note: Settings (fill once)
#         ImGuiConfigFlags   ConfigFlags # ✗
#         ImGuiBackendFlags  BackendFlags # ✗
#         ImVec2        DisplaySize # ✓
#         float         DeltaTime  # ✓
#         float         IniSavingRate  # ✓
#         const char*   IniFilename  # ✓
#         const char*   LogFilename  # ✓
#         float         MouseDoubleClickTime  # ✓
#         float         MouseDoubleClickMaxDist  # ✓
#         float         MouseDragThreshold  # ✓
#         # note: originally KeyMap[ImGuiKey_COUNT]
#         # todo: find a way to access enum var here
#         int*          KeyMap
#         float         KeyRepeatDelay  # ✓
#         float         KeyRepeatRate  # ✓
#         void*         UserData

#         ImFontAtlas*  Fonts  # ✓
#         float         FontGlobalScale  # ✓
#         bool          FontAllowUserScaling  # ✓
#         ImVec2        DisplayFramebufferScale  # ✓
#         ImVec2        DisplayVisibleMin  # ✓
#         ImVec2        DisplayVisibleMax  # ✓
#         bool          ConfigMacOSXBehaviors  # ✓
#         bool          ConfigInputTextCursorBlink  # ✓
#         bool          ConfigResizeWindowsFromEdges  # ✓

#         # ====
#         # source-note: User Functions
#         # note: callbacks may wrap arbitrary Python code so we need to
#         #       propagate exceptions from them (as well as C++ exceptions)
#         const char* (*GetClipboardTextFn)(void* user_data) except +  # ✓
#         void        (*SetClipboardTextFn)(void* user_data, const char* text) except +  # ✓
#         void*       ClipboardUserData  # ✗

#         void*       (*MemAllocFn)(size_t sz) except +  # ✗
#         void        (*MemFreeFn)(void* ptr) except +  # ✗
#         void        (*ImeSetInputScreenPosFn)(int x, int y) except +  # ✗
#         void*       ImeWindowHandle  # ✗

#         # ====
#         # source-note: Input - Fill before calling NewFrame()

#         ImVec2      MousePos  # ✓
#         bool        MouseDown[5]  # ✓
#         float       MouseWheel  # ✓
#         float       MouseWheelH  # ✓
#         bool        MouseDrawCursor  # ✓
#         bool        KeyCtrl  # ✓
#         bool        KeyShift  # ✓
#         bool        KeyAlt  # ✓
#         bool        KeySuper  # ✓
#         bool        KeysDown[512]  # ✓
#         ImWchar     InputCharacters[17]  # ✗

#         void        AddInputCharacter(ImWchar c) except +  # ✓
#         void        AddInputCharactersUTF8(const char* utf8_chars) except +  # ✓
#         void        ClearInputCharacters() except +  # ✓

#         # ====
#         # source-note: Output - Retrieve after calling NewFrame(), you can use
#         #              them to discard inputs or hide them from the rest of
#         #              your application
#         bool        WantCaptureMouse  # ✓
#         bool        WantCaptureKeyboard  # ✓
#         bool        WantTextInput  # ✓
#         bool        WantSetMousePos  # ✓
#         bool        WantSaveIniSettings  # ✓
#         bool        NavActive  # ✓
#         bool        NavVisible  # ✓
#         float       Framerate  # ✓
#         int         MetricsRenderVertices  # ✓
#         int         MetricsRenderIndices  # ✓
#         int         MetricsActiveWindows  # ✓
#         ImVec2      MouseDelta  # ✓

#         # ====
#         # source-note: [Internal] ImGui will maintain those fields for you
#         #ImVec2      MousePosPrev  # ✗
#         #ImVec2      MouseClickedPos[5]  # ✗
#         #float       MouseClickedTime[5]  # ✗
#         #bool        MouseClicked[5]  # ✗
#         #bool        MouseDoubleClicked[5]  # ✗
#         #bool        MouseReleased[5]  # ✗
#         #bool        MouseDownOwned[5]  # ✗
#         #float       MouseDownDuration[5]  # ✗
#         #float       MouseDownDurationPrev[5]  # ✗
#         #float       MouseDragMaxDistanceAbs[5]  # ✗
#         #float       MouseDragMaxDistanceSqr[5]  # ✗
#         #float       KeysDownDuration[512]  # ✗
#         #float       KeysDownDurationPrev[512]  # ✗
#         #float       NavInputsDownDuration[ImGuiNavInput_COUNT]   # ✗
#         #float       NavInputsDownDurationPrev[ImGuiNavInput_COUNT] # ✗

#     ctypedef struct ImDrawList:
#         # we map only buffer vectors since everything else is internal
#         # and right now we dont want to suport it.
#         ImVector[ImDrawCmd]  CmdBuffer  # ✓
#         ImVector[ImDrawIdx]  IdxBuffer  # ✓
#         ImVector[ImDrawVert] VtxBuffer  # ✓

#         void AddLine(
#             const ImVec2& a,
#             const ImVec2& b,
#             ImU32 col,
#             # note: optional
#             float thickness            # = 1.0f
#         ) except +  # ✓


#         void AddRect(
#             const ImVec2& a,
#             const ImVec2& b,
#             ImU32 col,
#             # note: optional
#             float rounding,             # = 0.0f,
#             int rounding_corners_flags, # = ImDrawCornerFlags_All,
#             float thickness             # = 1.0f
#         ) except +  # ✓


#         void AddRectFilled(
#             const ImVec2& a,
#             const ImVec2& b,
#             ImU32 col,
#             # note: optional
#             float rounding,            # = 0.0f
#             int rounding_corners_flags # = ImDrawCornerFlags_All
#         ) except +  # ✓


#         void  AddCircle(
#            const ImVec2& centre,
#            float radius,
#            ImU32 col,
#            # note:optional
#            int num_segments,           # = 12
#            float thickness             # = 1.0f
#         ) except +  # ✓


#         void AddCircleFilled(
#            const ImVec2& centre,
#            float radius,
#            ImU32 col,
#            # note:optional
#            int num_segments            # = 12
#         ) except +  # ✓


#         void AddText(
#            const ImVec2& pos,
#            ImU32 col,
#            const char* text_begin,
#            # note:optional
#            const char* text_end        # = NULL
#         ) except +  # ✓


#         void AddImage(
#            ImTextureID user_texture_id,
#            const ImVec2& a,
#            const ImVec2& b,
#            # note:optional
#            const ImVec2& uv_a,         # = ImVec2(0,0)
#            const ImVec2& uv_b,         # = ImVec2(1,1)
#            ImU32 col                   # = 0xFFFFFFFF
#         ) except +  # ✓


#         void AddPolyline(
#             const ImVec2* points,
#             int num_points,
#             ImU32 col,
#             bool closed,
#             float thickness
#         ) except +  # ✓


#         void ChannelsSplit(int channels_count) except + # ✓
#         void ChannelsMerge() except + # ✓
#         void ChannelsSetCurrent(int idx) except + # ✓
    
    ctypedef void (*ImDrawCallback)(const ImDrawList* parent_list, const ImDrawCmd* cmd)  # ✗

    ctypedef struct ImDrawCmd:
        unsigned int   ElemCount
        ImVec4         ClipRect
        ImTextureID    TextureId
        ImDrawCallback UserCallback
        void*          UserCallbackData
    
#     ctypedef struct ImDrawData:  # ✓
#         bool            Valid  # ✓
#         ImDrawList**    CmdLists  # ✓
#         int             CmdListsCount  # ✓
#         int             TotalVtxCount  # ✓
#         int             TotalIdxCount  # ✓
#         void            DeIndexAllBuffers() except +  # ✓
#         void            ScaleClipRects(const ImVec2&) except +  # ✓
    
    

#     ctypedef struct ImFont:
#         pass
    
#     ctypedef struct ImFontAtlas:
#         void*   TexID
#         int   TexWidth
#         int   TexHeight

#         ImFont* AddFontDefault(  # ✓
#                    # note: optional
#                    const ImFontConfig* font_cfg
#         ) except +
#         ImFont* AddFontFromFileTTF(  # ✓
#                     const char* filename, float size_pixels,
#                     # note: optional
#                     const ImFontConfig* font_cfg,
#                     const ImWchar* glyph_ranges
#         ) except +
#         void GetTexDataAsAlpha8(unsigned char**, int*, int*, int* = NULL) except +  # ✓
#         void GetTexDataAsRGBA32(unsigned char**, int*, int*, int* = NULL) except +  # ✓

#         void ClearTexData() except +  # ✓
#         void ClearInputData() except +  # ✓
#         void ClearFonts() except +  # ✓
#         void Clear() except +  # ✓

#         const ImWchar* GetGlyphRangesDefault() except +  # ✓
#         const ImWchar* GetGlyphRangesKorean() except +  # ✓
#         const ImWchar* GetGlyphRangesJapanese() except +  # ✓
#         const ImWchar* GetGlyphRangesChineseFull() except +  # ✓
#         const ImWchar* GetGlyphRangesChineseSimplifiedCommon() except +  # ✓
#         const ImWchar* GetGlyphRangesCyrillic() except +  # ✓
    
#     ctypedef struct ImFontConfig:
#         pass


# cdef extern from "imgui.h" namespace "ImGui":
#     void ShowDemoWindow(bool* p_open) except +

#     # ====
#     # Context creation and access
#     ImGuiContext* CreateContext(
#             # note: optional
#             ImFontAtlas* shared_font_atlas
#     ) except +
#     void DestroyContext(ImGuiContext* ctx) except +
#     ImGuiContext* GetCurrentContext() except +
#     void SetCurrentContext(ImGuiContext* ctx) except +
    
#     ImGuiIO& GetIO() except +  # ✓

#     void NewFrame() except +  # ✓
#     # note: Render runs callbacks that may be arbitrary Python code
#     #       so we need to propagate exceptions from them
#     void Render() except +  # ✓
#     ImDrawData* GetDrawData() except +  # ✓
