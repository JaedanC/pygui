# distutils: language = c++
# cython: language_level = 3
# cython: embedsignature=True

import cython
from cython.operator import dereference

from collections import namedtuple

from . cimport ccimgui
from libcpp cimport bool
from libc.stdint cimport uintptr_t
from cython.view cimport array as cvarray
from cpython.version cimport PY_MAJOR_VERSION

# from libc.stdlib cimport malloc, free

# from cpython.version cimport PY_MAJOR_VERSION
# cimport enums

# cdef unsigned short* _LATIN_ALL = [0x0020, 0x024F , 0]


KEY_TAB = ccimgui.ImGuiKey_Tab                 # for tabbing through fields
KEY_LEFT_ARROW = ccimgui.ImGuiKey_LeftArrow    # for text edit
KEY_RIGHT_ARROW = ccimgui.ImGuiKey_RightArrow  # for text edit
KEY_UP_ARROW = ccimgui.ImGuiKey_UpArrow        # for text edit
KEY_DOWN_ARROW = ccimgui.ImGuiKey_DownArrow    # for text edit
KEY_PAGE_UP = ccimgui.ImGuiKey_PageUp
KEY_PAGE_DOWN = ccimgui.ImGuiKey_PageDown
KEY_HOME = ccimgui.ImGuiKey_Home               # for text edit
KEY_END = ccimgui.ImGuiKey_End                 # for text edit
KEY_INSERT = ccimgui.ImGuiKey_Insert           # for text edit
KEY_DELETE = ccimgui.ImGuiKey_Delete           # for text edit
KEY_BACKSPACE = ccimgui.ImGuiKey_Backspace     # for text edit
KEY_SPACE = ccimgui.ImGuiKey_Space             # for text edit
KEY_ENTER = ccimgui.ImGuiKey_Enter             # for text edit
KEY_ESCAPE = ccimgui.ImGuiKey_Escape           # for text edit
KEY_A = ccimgui.ImGuiKey_A                     # for text edit CTRL+A: select all
KEY_C = ccimgui.ImGuiKey_C                     # for text edit CTRL+C: copy
KEY_V = ccimgui.ImGuiKey_V                     # for text edit CTRL+V: paste
KEY_X = ccimgui.ImGuiKey_X                     # for text edit CTRL+X: cut
KEY_Y = ccimgui.ImGuiKey_Y                     # for text edit CTRL+Y: redo
KEY_Z = ccimgui.ImGuiKey_Z                     # for text edit CTRL+Z: undo


Vec2 = namedtuple("Vec2", ['x', 'y'])
Vec4 = namedtuple("Vec4", ['x', 'y', 'z', 'w'])

cdef _cast_ImVec2_tuple(ccimgui.ImVec2 vec):  # noqa
    return Vec2(vec.x, vec.y)


cdef ccimgui.ImVec2 _cast_tuple_ImVec2(pair) except +:  # noqa
    cdef ccimgui.ImVec2 vec

    if len(pair) != 2:
        raise ValueError("pair param must be length of 2")

    vec.x, vec.y = pair
    return vec


cdef _cast_ImVec4_tuple(ccimgui.ImVec4 vec):  # noqa
    return Vec4(vec.x, vec.y, vec.z, vec.w)


cdef bytes _bytes(str text):
    return <bytes>(text if PY_MAJOR_VERSION < 3 else text.encode('utf-8'))


cdef str _from_bytes(bytes text):
    return <str>(text if PY_MAJOR_VERSION < 3 else text.decode('utf-8', errors='ignore'))


cdef class _FontAtlas(object):
    cdef ccimgui.ImFontAtlas* _ptr

    @staticmethod
    cdef from_ptr(ccimgui.ImFontAtlas* ptr):
        if ptr == NULL:
            return None

        instance = _FontAtlas()
        instance._ptr = ptr
        return instance

    def _require_pointer(self):
        if self._ptr == NULL:
            raise RuntimeError(
                "%s improperly initialized" % self.__class__.__name__
            )

        return self._ptr != NULL
    
    def clear_tex_data(self):
        ccimgui.ImFontAtlas_ClearTexData(self._ptr)

    @property
    def texture_id(self):
        return <object>dereference(self._ptr).TexID
    
    @texture_id.setter
    def texture_id(self, value):
        dereference(self._ptr).TexID = <void *> value

    def get_tex_data_as_alpha8(self):
        self._require_pointer()

        cdef int width
        cdef int height
        cdef unsigned char* pixels

        ccimgui.ImFontAtlas_GetTexDataAsAlpha8(self._ptr, &pixels, &width, &height, NULL)

        return width, height, bytes(pixels[:width*height])

    def get_tex_data_as_rgba32(self):
        self._require_pointer()

        cdef int width
        cdef int height
        cdef unsigned char* pixels

        ccimgui.ImFontAtlas_GetTexDataAsRGBA32(self._ptr, &pixels, &width, &height, NULL)

        return width, height, bytes(pixels[:width*height*4])


cdef class _ImGuiContext(object):
    cdef ccimgui.ImGuiContext* _ptr

    @staticmethod
    cdef from_ptr(ccimgui.ImGuiContext* ptr):
        if ptr == NULL:
            return None

        instance = _ImGuiContext()
        instance._ptr = ptr
        return instance


@cython.returns(_ImGuiContext)
def get_current_context():
    return _ImGuiContext.from_ptr(ccimgui.igGetCurrentContext())


@cython.returns(_ImGuiContext)
def create_context(shared_font_atlas: _FontAtlas = None):
    cdef ccimgui.ImGuiContext* ctx
    
    if shared_font_atlas is None:
        ctx = ccimgui.igCreateContext(NULL)
    else:
        ctx = ccimgui.igCreateContext(shared_font_atlas._ptr)

    return _ImGuiContext.from_ptr(ctx)


@cython.returns(_ImGuiContext)
def destroy_context(ctx: _ImGuiContext):
    if ctx and ctx._ptr != NULL:
        ccimgui.igDestroyContext(ctx._ptr)
        ctx._ptr = NULL
    else:
        raise RuntimeError("Context invalid (None or destroyed)")


_io_clipboard = {}
cdef class _IO(object):
    cdef ccimgui.ImGuiIO* _ptr
    cdef _FontAtlas _fonts

    def __init__(self):
        self._ptr = ccimgui.igGetIO()
        self._fonts = _FontAtlas.from_ptr(self._ptr.Fonts)

        if <uintptr_t>ccimgui.igGetCurrentContext() not in _io_clipboard:
            _io_clipboard[<uintptr_t>ccimgui.igGetCurrentContext()] = {
                '_get_clipboard_text_fn': None,
                '_set_clipboard_text_fn': None
            }
    
    @property
    def keys_down(self):
        # todo: consider adding setter despite the fact that it can be
        # todo: modified in place
        cdef cvarray keys_down = cvarray(
            shape=(512,),
            format='b',
            itemsize=sizeof(bool),
            allocate_buffer=False
        )
        keys_down.data = <char*>dereference(self._ptr).KeysDown
        return keys_down

    def add_input_character(self, ccimgui.ImWchar c):
        ccimgui.ImGuiIO_AddInputCharacter(self._ptr, c)
    
    @property
    def display_size(self):
        return _cast_ImVec2_tuple(dereference(self._ptr).DisplaySize)

    @display_size.setter
    def display_size(self, value):
        dereference(self._ptr).DisplaySize = _cast_tuple_ImVec2(value)

    @property
    def display_fb_scale(self):
        return _cast_ImVec2_tuple(dereference(self._ptr).DisplayFramebufferScale)

    @display_fb_scale.setter
    def display_fb_scale(self, value):
        dereference(self._ptr).DisplayFramebufferScale = _cast_tuple_ImVec2(value)

    @property
    @cython.returns(cython.float)
    def delta_time(self):
        return dereference(self._ptr).DeltaTime

    @delta_time.setter
    def delta_time(self, float time):
        dereference(self._ptr).DeltaTime = time

    @property
    def key_ctrl(self):
        return dereference(self._ptr).KeyCtrl

    @key_ctrl.setter
    def key_ctrl(self, ccimgui.bool value):
        dereference(self._ptr).KeyCtrl = value

    @property
    def key_shift(self):
        return dereference(self._ptr).KeyShift

    @key_shift.setter
    def key_shift(self, ccimgui.bool value):
        dereference(self._ptr).KeyShift = value

    @property
    def key_alt(self):
        return dereference(self._ptr).KeyAlt

    @key_alt.setter
    def key_alt(self, ccimgui.bool value):
        dereference(self._ptr).KeyAlt = value

    @property
    def key_super(self):
        return dereference(self._ptr).KeySuper

    @key_super.setter
    def key_super(self, ccimgui.bool value):
        dereference(self._ptr).KeySuper = value

    @property
    def key_map(self):
        cdef cvarray key_map = cvarray(
            shape=(ccimgui.ImGuiKey.ImGuiKey_COUNT,),
            format='i',
            itemsize=sizeof(int),
            allocate_buffer=False
        )
        key_map.data = <char*>(dereference(self._ptr).KeyMap)
        return key_map

    @property
    def fonts(self):
        return self._fonts

    @staticmethod
    cdef const char* _get_clipboard_text(void* user_data):
        text = _io_clipboard[<uintptr_t>ccimgui.igGetCurrentContext()]['_get_clipboard_text_fn']()
        if type(text) is bytes:
            return text
        return _bytes(text)

    @property
    def get_clipboard_text_fn(self):
        return _io_clipboard[<uintptr_t>ccimgui.igGetCurrentContext()]['_get_clipboard_text_fn']

    @get_clipboard_text_fn.setter
    def get_clipboard_text_fn(self, func):
        if callable(func):
            _io_clipboard[<uintptr_t>ccimgui.igGetCurrentContext()]['_get_clipboard_text_fn'] = func
            dereference(self._ptr).GetClipboardTextFn = self._get_clipboard_text
        else:
            raise ValueError("func is not a callable: %s" % str(func))

    @staticmethod
    cdef void _set_clipboard_text(void* user_data, const char* text):
        _io_clipboard[<uintptr_t>ccimgui.igGetCurrentContext()]['_set_clipboard_text_fn'](_from_bytes(text))

    @property
    def set_clipboard_text_fn(self):
        return _io_clipboard[<uintptr_t>ccimgui.igGetCurrentContext()]['_set_clipboard_text_fn']

    @set_clipboard_text_fn.setter
    def set_clipboard_text_fn(self, func):
        if callable(func):
            _io_clipboard[<uintptr_t>ccimgui.igGetCurrentContext()]['_set_clipboard_text_fn'] = func
            dereference(self._ptr).SetClipboardTextFn = self._set_clipboard_text
        else:
            raise ValueError("func is not a callable: %s" % str(func))

    @property
    def mouse_pos(self):
        return _cast_ImVec2_tuple(dereference(self._ptr).MousePos)

    @mouse_pos.setter
    def mouse_pos(self, value):
        dereference(self._ptr).MousePos = _cast_tuple_ImVec2(value)

    @property
    def mouse_down(self):
        # todo: consider adding setter despite the fact that it can be
        # todo: modified in place
        cdef cvarray mouse_down = cvarray(
            shape=(5,),
            format='b',
            itemsize=sizeof(bool),
            allocate_buffer=False
        )
        mouse_down.data = <char*>dereference(self._ptr).MouseDown
        return mouse_down

    @property
    def mouse_wheel(self):
        return dereference(self._ptr).MouseWheel

    @mouse_wheel.setter
    def mouse_wheel(self, float value):
        dereference(self._ptr).MouseWheel = value

    @property
    def mouse_wheel_horizontal(self):
        return dereference(self._ptr).MouseWheelH

    @mouse_wheel_horizontal.setter
    def mouse_wheel_horizontal(self, float value):
        dereference(self._ptr).MouseWheelH = value


cdef class _DrawCmd(object):
    cdef ccimgui.ImDrawCmd* _ptr

    # todo: consider using fast instantiation here
    #       see: http://cython.readthedocs.io/en/latest/src/userguide/extension_types.html#fast-instantiation
    @staticmethod
    cdef from_ptr(ccimgui.ImDrawCmd* ptr):
        if ptr == NULL:
            return None

        instance = _DrawCmd()
        instance._ptr = ptr
        return instance
    
    @property
    def texture_id(self):
        return <object>dereference(self._ptr).TextureId

    @property
    def clip_rect(self):
        return _cast_ImVec4_tuple(dereference(self._ptr).ClipRect)
    
    @property
    def elem_count(self):
        return dereference(self._ptr).ElemCount


@cython.returns(_IO)
def get_io():
    return _IO()


cdef class _DrawList(object):
    cdef ccimgui.ImDrawList* _ptr

    @staticmethod
    cdef from_ptr(ccimgui.ImDrawList* ptr):
        if ptr == NULL:
            return None

        instance = _DrawList()
        instance._ptr = ptr
        return instance
    
    @property
    def vtx_buffer_size(self):
        return dereference(self._ptr).VtxBuffer.Size

    @property
    def vtx_buffer_data(self):
        return <uintptr_t>dereference(self._ptr).VtxBuffer.Data
    
    @property
    def idx_buffer_size(self):
        return dereference(self._ptr).IdxBuffer.Size

    @property
    def idx_buffer_data(self):
        return <uintptr_t>dereference(self._ptr).IdxBuffer.Data

    @property
    def commands(self):
        return [
            # todo: consider operator overloading in pxd file
            _DrawCmd.from_ptr(&dereference(self._ptr).CmdBuffer.Data[idx])
            # perf: short-wiring instead of using property
            # note: add py3k compat
            for idx in range(dereference(self._ptr).CmdBuffer.Size)
        ]


cdef class _DrawData(object):
    cdef ccimgui.ImDrawData* _ptr

    def _require_pointer(self):
        if self._ptr == NULL:
            raise RuntimeError(
                "%s improperly initialized" % self.__class__.__name__
            )

    @staticmethod
    cdef from_ptr(ccimgui.ImDrawData* ptr):
        if ptr == NULL:
            return None

        instance = _DrawData()
        instance._ptr = ptr
        return instance

    def scale_clip_rects(self, width, height):
        self._require_pointer()
        ccimgui.ImDrawData_ScaleClipRects(self._ptr, _cast_tuple_ImVec2((width, height)))

    @property
    def commands_lists(self):
        return [
            _DrawList.from_ptr(dereference(self._ptr).CmdLists[idx])
            # perf: short-wiring instead of using property
            for idx in range(dereference(self._ptr).CmdListsCount)
        ]
    
    
@cython.returns(_DrawData)
def get_draw_data():
    cdef ccimgui.ImDrawData* ptr = ccimgui.igGetDrawData()
    return _DrawData.from_ptr(ptr)


@cython.returns(ccimgui.bool)
def show_demo_window(closable: bool = False):
    cdef ccimgui.bool opened = True
    if closable:
        ccimgui.igShowDemoWindow(&opened)
    else:
        ccimgui.igShowDemoWindow(NULL)
    return opened


def new_frame():
    ccimgui.igNewFrame()


def render():
    ccimgui.igRender()


def show_user_guide():
    return ccimgui.igShowUserGuide()


def _py_vertex_buffer_vertex_pos_offset():
    return <uintptr_t><size_t>&(<ccimgui.ImDrawVert*>NULL).pos

def _py_vertex_buffer_vertex_uv_offset():
    return <uintptr_t><size_t>&(<ccimgui.ImDrawVert*>NULL).uv

def _py_vertex_buffer_vertex_col_offset():
    return <uintptr_t><size_t>&(<ccimgui.ImDrawVert*>NULL).col

def _py_vertex_buffer_vertex_size():
    return sizeof(ccimgui.ImDrawVert)

def _py_index_buffer_index_size():
    return sizeof(ccimgui.ImDrawIdx)