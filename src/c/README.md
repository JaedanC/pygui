Step 1:
Compile ImGui into a DLL:

This contains the following:
- imgui.cpp related files
- imgui_impl_glfw/opengl.cpp related files
- dcimgui related cpp files
- Python custom error implementation linked with Python library

Exported Symbols:
- CIMGUI
- CIMGUI_IMPLEMENTATION
- Custom python errors under CIMGUI

Done with:
#define CIMGUI_API      __declspec(dllexport)
#define CIMGUI_IMPL_API __declspec(dllexport)