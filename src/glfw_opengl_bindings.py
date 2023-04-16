from dear_bindings_model import *


def main():
    impl_function = [
    # CIMGUI_API bool ImGui_ImplGlfw_InitForVulkan(GLFWwindow* window,bool install_callbacks);
        DearFunction("ImGui_ImplGlfw_InitForVulkan", "ImGui_ImplGlfw_InitForVulkan", DearType("bool"), [
                        DearFunction.Argument("window",            DearType("GLFWwindow*"), False, None, Comments([], None)),
                        DearFunction.Argument("install_callbacks", DearType("bool"),        False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API bool ImGui_ImplGlfw_InitForOther(GLFWwindow* window,bool install_callbacks);
        DearFunction("ImGui_ImplGlfw_InitForOther", "ImGui_ImplGlfw_InitForOther", DearType("bool"), [
                        DearFunction.Argument("window",            DearType("GLFWwindow*"), False, None, Comments([], None)),
                        DearFunction.Argument("install_callbacks", DearType("bool"),        False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_Shutdown(void);
        DearFunction("ImGui_ImplGlfw_Shutdown", "ImGui_ImplGlfw_Shutdown", DearType("void"), [], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_NewFrame(void);
        DearFunction("ImGui_ImplGlfw_NewFrame", "ImGui_ImplGlfw_NewFrame", DearType("void"), [], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_InstallCallbacks(GLFWwindow* window);
        DearFunction("ImGui_ImplGlfw_InstallCallbacks", "ImGui_ImplGlfw_InstallCallbacks", DearType("void"), [
                        DearFunction.Argument("window", DearType("GLFWwindow*"), False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_RestoreCallbacks(GLFWwindow* window);
        DearFunction("ImGui_ImplGlfw_RestoreCallbacks", "ImGui_ImplGlfw_RestoreCallbacks", DearType("void"), [
                        DearFunction.Argument("window", DearType("GLFWwindow*"), False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_SetCallbacksChainForAllWindows(bool chain_for_all_windows);
        DearFunction("ImGui_ImplGlfw_SetCallbacksChainForAllWindows", "ImGui_ImplGlfw_SetCallbacksChainForAllWindows", DearType("void"), [
                        DearFunction.Argument("chain_for_all_windows", DearType("bool"), False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),
                    
    # CIMGUI_API void ImGui_ImplGlfw_WindowFocusCallback(GLFWwindow* window,int focused);
        DearFunction("ImGui_ImplGlfw_WindowFocusCallback", "ImGui_ImplGlfw_WindowFocusCallback", DearType("void"), [
                        DearFunction.Argument("window",  DearType("GLFWwindow*"), False, None, Comments([], None)),
                        DearFunction.Argument("focused", DearType("int"),         False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),
        
    # CIMGUI_API void ImGui_ImplGlfw_CursorEnterCallback(GLFWwindow* window,int entered);
        DearFunction("ImGui_ImplGlfw_CursorEnterCallback", "ImGui_ImplGlfw_CursorEnterCallback", DearType("void"), [
                        DearFunction.Argument("window",  DearType("GLFWwindow*"), False, None, Comments([], None)),
                        DearFunction.Argument("entered", DearType("int"),         False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),
        
    # CIMGUI_API void ImGui_ImplGlfw_CursorPosCallback(GLFWwindow* window,double x,double y);
        DearFunction("ImGui_ImplGlfw_CursorPosCallback", "ImGui_ImplGlfw_CursorPosCallback", DearType("void"), [
                        DearFunction.Argument("window",  DearType("GLFWwindow*"), False, None, Comments([], None)),
                        DearFunction.Argument("x",       DearType("double"),      False, None, Comments([], None)),
                        DearFunction.Argument("y",       DearType("double"),      False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_MouseButtonCallback(GLFWwindow* window,int button,int action,int mods);
        DearFunction("ImGui_ImplGlfw_MouseButtonCallback", "ImGui_ImplGlfw_MouseButtonCallback", DearType("void"), [
                        DearFunction.Argument("window", DearType("GLFWwindow*"), False, None, Comments([], None)),
                        DearFunction.Argument("button", DearType("int"),         False, None, Comments([], None)),
                        DearFunction.Argument("action", DearType("int"),         False, None, Comments([], None)),
                        DearFunction.Argument("mods",   DearType("int"),         False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_ScrollCallback(GLFWwindow* window,double xoffset,double yoffset);
        DearFunction("ImGui_ImplGlfw_ScrollCallback", "ImGui_ImplGlfw_ScrollCallback", DearType("void"), [
                        DearFunction.Argument("window",  DearType("GLFWwindow*"), False, None, Comments([], None)),
                        DearFunction.Argument("xoffset", DearType("double"),      False, None, Comments([], None)),
                        DearFunction.Argument("yoffset", DearType("double"),      False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_KeyCallback(GLFWwindow* window,int key,int scancode,int action,int mods);
        DearFunction("ImGui_ImplGlfw_KeyCallback", "ImGui_ImplGlfw_KeyCallback", DearType("void"), [
                        DearFunction.Argument("window",   DearType("GLFWwindow*"), False, None, Comments([], None)),
                        DearFunction.Argument("key",      DearType("int"),         False, None, Comments([], None)),
                        DearFunction.Argument("scancode", DearType("int"),         False, None, Comments([], None)),
                        DearFunction.Argument("action",   DearType("int"),         False, None, Comments([], None)),
                        DearFunction.Argument("mods",     DearType("int"),         False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_CharCallback(GLFWwindow* window,unsigned int c);
        DearFunction("ImGui_ImplGlfw_CharCallback", "ImGui_ImplGlfw_CharCallback", DearType("void"), [
                        DearFunction.Argument("window", DearType("GLFWwindow*"),  False, None, Comments([], None)),
                        DearFunction.Argument("c",      DearType("unsigned int"), False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplGlfw_MonitorCallback(GLFWmonitor* monitor,int event);
        DearFunction("ImGui_ImplGlfw_MonitorCallback", "ImGui_ImplGlfw_MonitorCallback", DearType("void"), [
                        DearFunction.Argument("monitor", DearType("GLFWmonitor*"), False, None, Comments([], None)),
                        DearFunction.Argument("event",   DearType("int"),          False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),
        
    # CIMGUI_API bool ImGui_ImplOpenGL3_Init(const char* glsl_version);
        DearFunction("ImGui_ImplOpenGL3_Init", "ImGui_ImplOpenGL3_Init", DearType("bool"), [
                        DearFunction.Argument("glsl_version", DearType("const char*"), False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),
        
    # CIMGUI_API void ImGui_ImplOpenGL3_Shutdown(void);
        DearFunction("ImGui_ImplOpenGL3_Shutdown", "ImGui_ImplOpenGL3_Shutdown", DearType("void"), [], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplOpenGL3_NewFrame(void);
        DearFunction("ImGui_ImplOpenGL3_NewFrame", "ImGui_ImplOpenGL3_NewFrame", DearType("void"), [], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplOpenGL3_RenderDrawData(ImDrawData* draw_data);
        DearFunction("ImGui_ImplOpenGL3_RenderDrawData", "ImGui_ImplOpenGL3_RenderDrawData", DearType("void"), [
                        DearFunction.Argument("draw_data", DearType("ImDrawData*"), False, None, Comments([], None)),
                     ], False, False, False, False, Comments([], None)),

    # CIMGUI_API bool ImGui_ImplOpenGL3_CreateFontsTexture(void);
        DearFunction("ImGui_ImplOpenGL3_CreateFontsTexture", "ImGui_ImplOpenGL3_CreateFontsTexture", DearType("bool"), [], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplOpenGL3_DestroyFontsTexture(void);
        DearFunction("ImGui_ImplOpenGL3_DestroyFontsTexture", "ImGui_ImplOpenGL3_DestroyFontsTexture", DearType("void"), [], False, False, False, False, Comments([], None)),

    # CIMGUI_API bool ImGui_ImplOpenGL3_CreateDeviceObjects(void);
        DearFunction("ImGui_ImplOpenGL3_CreateDeviceObjects", "ImGui_ImplOpenGL3_CreateDeviceObjects", DearType("bool"), [], False, False, False, False, Comments([], None)),

    # CIMGUI_API void ImGui_ImplOpenGL3_DestroyDeviceObjects(void);
        DearFunction("ImGui_ImplOpenGL3_DestroyDeviceObjects", "ImGui_ImplOpenGL3_DestroyDeviceObjects", DearType("void"), [], False, False, False, False, Comments([], None)),
    ]
    impl_structs = [
        DearStruct("GLFWwindow",  "GLFWwindow",  False, [], Comments([], None)),
        DearStruct("GLFWmonitor", "GLFWmonitor", False, [], Comments([], None)),
        DearStruct("ImDrawData",  "ImDrawData",  False, [], Comments([], None)),
    ]


    impl_header = DearBinding([], [], impl_structs, impl_function)
    pxd_impl = to_pxd(impl_header, "ccimgui_dear_bindings_impl.h")
    with open("core/ccimgui_dear_bindings_impl.pxd", "w") as f:
        f.write(pxd_impl)
    
    imports = textwrap.dedent("""
    cimport ccimgui_dear_bindings_impl
    from libcpp cimport bool
    """)
    pyx_impl = to_pyx(impl_header, "ccimgui_dear_bindings_impl",
                      imports.strip(), include_constant_functions=False)
    with open("core/core_generated_dear_bindings_impl.pyx", "w") as f:
        f.write(pyx_impl)


if __name__ == "__main__":
    main()
