
# -*- coding: utf-8 -*-
# distutils: language = c++

from libcpp cimport bool

cdef extern from "cimgui.h":
    ctypedef struct GLFWwindow



    ctypedef struct GLFWwindow:
        pass


    bool ImGui_ImplGlfw_InitForVulkan(GLFWwindow* window, bool install_callbacks) except +


