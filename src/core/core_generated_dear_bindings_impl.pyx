
# distutils: language = c++
# cython: language_level = 3
# cython: embedsignature=True

# [Imports]
cimport ccimgui_dear_bindings_impl
from libcpp cimport bool
# [End Imports]

# [Enums]
# [End Enums]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_glfw_init_for_vulkan(window: GLFWwindow, install_callbacks: bool):
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplGlfw_InitForVulkan(
        window,
        install_callbacks
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_glfw_init_for_other(window: GLFWwindow, install_callbacks: bool):
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplGlfw_InitForOther(
        window,
        install_callbacks
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_shutdown():
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_Shutdown()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_new_frame():
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_NewFrame()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_install_callbacks(window: GLFWwindow):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_InstallCallbacks(
        window
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_restore_callbacks(window: GLFWwindow):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_RestoreCallbacks(
        window
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_set_callbacks_chain_for_all_windows(chain_for_all_windows: bool):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_SetCallbacksChainForAllWindows(
        chain_for_all_windows
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_window_focus_callback(window: GLFWwindow, focused: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_WindowFocusCallback(
        window,
        focused
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_cursor_enter_callback(window: GLFWwindow, entered: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_CursorEnterCallback(
        window,
        entered
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_cursor_pos_callback(window: GLFWwindow, x: float, y: float):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_CursorPosCallback(
        window,
        x,
        y
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_mouse_button_callback(window: GLFWwindow, button: int, action: int, mods: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_MouseButtonCallback(
        window,
        button,
        action,
        mods
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_scroll_callback(window: GLFWwindow, xoffset: float, yoffset: float):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_ScrollCallback(
        window,
        xoffset,
        yoffset
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_key_callback(window: GLFWwindow, key: int, scancode: int, action: int, mods: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_KeyCallback(
        window,
        key,
        scancode,
        action,
        mods
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_char_callback(window: GLFWwindow, c: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_CharCallback(
        window,
        c
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_glfw_monitor_callback(monitor: GLFWmonitor, event: int):
    ccimgui_dear_bindings_impl.ImGui_ImplGlfw_MonitorCallback(
        monitor,
        event
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_open_gl_3_init(glsl_version: str):
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_Init(
        _bytes(glsl_version)
    )
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_shutdown():
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_Shutdown()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_new_frame():
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_NewFrame()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_render_draw_data(draw_data: ImDrawData):
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_RenderDrawData(
        draw_data
    )
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_open_gl_3_create_fonts_texture():
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_CreateFontsTexture()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_destroy_fonts_texture():
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_DestroyFontsTexture()
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(bool)
def impl_open_gl_3_create_device_objects():
    cdef bool res = ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_CreateDeviceObjects()
    return res
# [End Function]

# [Function]
# ?use_template(False)
# ?active(False)
# ?returns(None)
def impl_open_gl_3_destroy_device_objects():
    ccimgui_dear_bindings_impl.ImGui_ImplOpenGL3_DestroyDeviceObjects()
# [End Function]

# [Class]
# [Class Constants]
# ?use_template(False)
cdef class GLFWwindow:
    cdef ccimgui_dear_bindings_impl.GLFWwindow* _ptr
    
    @staticmethod
    cdef GLFWwindow from_ptr(ccimgui_dear_bindings_impl.GLFWwindow* _ptr):
        cdef GLFWwindow wrapper = GLFWwindow.__new__(GLFWwindow)
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
    # [End Class Constants]

# [End Class]


# [Class]
# [Class Constants]
# ?use_template(False)
cdef class GLFWmonitor:
    cdef ccimgui_dear_bindings_impl.GLFWmonitor* _ptr
    
    @staticmethod
    cdef GLFWmonitor from_ptr(ccimgui_dear_bindings_impl.GLFWmonitor* _ptr):
        cdef GLFWmonitor wrapper = GLFWmonitor.__new__(GLFWmonitor)
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
    # [End Class Constants]

# [End Class]


# [Class]
# [Class Constants]
# ?use_template(False)
cdef class ImDrawData:
    cdef ccimgui_dear_bindings_impl.ImDrawData* _ptr
    
    @staticmethod
    cdef ImDrawData from_ptr(ccimgui_dear_bindings_impl.ImDrawData* _ptr):
        cdef ImDrawData wrapper = ImDrawData.__new__(ImDrawData)
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
    # [End Class Constants]

# [End Class]


