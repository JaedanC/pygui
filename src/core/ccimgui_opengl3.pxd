
# -*- coding: utf-8 -*-
# distutils: language = c++

from libcpp cimport bool

cdef extern from "imgui_impl_opengl3.h":
    ctypedef struct ImDrawData



    ctypedef struct ImDrawData:
        pass



    bool ImGui_ImplOpenGL3_CreateDeviceObjects() except +
    bool ImGui_ImplOpenGL3_CreateFontsTexture() except +
    void ImGui_ImplOpenGL3_DestroyDeviceObjects() except +
    void ImGui_ImplOpenGL3_DestroyFontsTexture() except +
    bool ImGui_ImplOpenGL3_Init(const char* glsl_version) except +
    void ImGui_ImplOpenGL3_NewFrame() except +
    void ImGui_ImplOpenGL3_RenderDrawData(ImDrawData* draw_data) except +
    void ImGui_ImplOpenGL3_ShutdownHello() except +


