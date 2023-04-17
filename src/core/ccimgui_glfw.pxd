
# -*- coding: utf-8 -*-
# distutils: language = c++

from libcpp cimport bool

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


