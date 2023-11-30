import json
from typing import List
from model.dear_bindings.interfaces import IBinding
from model.dear_bindings.binding import Binding
from model.dear_bindings.struct import Struct
from model.dear_bindings.function import Function
from model.dear_bindings.db_type import _Type, Kind, Kinds
from model.dear_bindings.argument import Argument
from model.comments import Comments


EXTENSION_NAME =           "core"
CIMGUI_PXD_PATH =          "core/ccimgui.pxd"
PYX_PATH =                 "core/core.pyx"
CIMGUI_LIBRARY_NAME =      "ccimgui"
GENERATED_PYX_PATH =       "core/core_generated.pyx"
GENERATED_PYX_TRIAL_PATH = "core/core_generated_trial.pyx"
PYX_TRIAL_PATH =           "core/core_trial.pyx"
TEMPLATE_PYX_PATH =        "core/core_template.pyx"
TEMPLATE_PYX_TRIAL_PATH =  "core/core_template_trial.pyx"
INIT_PYI_PATH =            "pygui/__init__.pyi"
INIT_PY_PATH =             "pygui/__init__.py"

defines = [
    ("IMGUI_DISABLE_OBSOLETE_KEYIO", True),
    ("IMGUI_DISABLE_OBSOLETE_FUNCTIONS", True),
    ("IMGUI_HAS_IMSTR", False),
]

modules: List[IBinding] = []

# core
with open("external/dear_bindings/cimgui.json") as f:
    modules.append(
        Binding.from_json(json.load(f), "cimgui.h", defines)
    )

# glfw
with open("core/backends/glfw.json") as f:
    glfw = Binding(
        enums=[],
        typedefs=[],
        structs=[
            Struct("GLFWwindow",  []),
            Struct("GLFWmonitor", []),
        ],
        functions=[
            Function("ImGui_ImplGlfw_InitForOpenGL",
                _Type("bool", Kind(Kinds.Builtin, "bool")),
                [
                    Argument("window",            _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("install_callbacks", _Type("bool",        Kind(Kinds.Builtin, "bool"))),
                ],
            ),
            Function("ImGui_ImplGlfw_InitForVulkan",
                _Type("bool", Kind(Kinds.Builtin, "bool")),
                [
                    Argument("window",            _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("install_callbacks", _Type("bool",        Kind(Kinds.Builtin, "bool"))),
                ],
                Comments([], None)
            ),
            Function("ImGui_ImplGlfw_InitForOther",
                _Type("bool", Kind(Kinds.Builtin, "bool")),
                [
                    Argument("window",            _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("install_callbacks", _Type("bool",        Kind(Kinds.Builtin, "bool"))),
                ],
            ),
            Function("ImGui_ImplGlfw_Shutdown",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [],
            ),
            Function("ImGui_ImplGlfw_NewFrame",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [],
            ),
            Function("ImGui_ImplGlfw_InstallCallbacks",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window", _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                ],
            ),
            Function("ImGui_ImplGlfw_RestoreCallbacks",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window", _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                ],
            ),
            Function("ImGui_ImplGlfw_SetCallbacksChainForAllWindows",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("chain_for_all_windows", _Type("bool", Kind(Kinds.Builtin, "bool"))),
                ],
            ),
            Function("ImGui_ImplGlfw_WindowFocusCallback",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window",  _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("focused", _Type("int",         Kind(Kinds.Builtin, "int"))),
                ],
            ),
            Function("ImGui_ImplGlfw_CursorEnterCallback",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window",  _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("entered", _Type("double",      Kind(Kinds.Builtin, "double"))),
                ],
            ),
            Function("ImGui_ImplGlfw_CursorPosCallback",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window", _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("x",      _Type("double",      Kind(Kinds.Builtin, "double"))),
                    Argument("y",      _Type("double",      Kind(Kinds.Builtin, "double"))),
                ],
            ),
            Function("ImGui_ImplGlfw_MouseButtonCallback",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window", _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("button", _Type("int",         Kind(Kinds.Builtin, "int"))),
                    Argument("action", _Type("int",         Kind(Kinds.Builtin, "int"))),
                    Argument("mods",   _Type("int",         Kind(Kinds.Builtin, "int"))),
                ],
            ),
            Function("ImGui_ImplGlfw_ScrollCallback",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window",  _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("xoffset", _Type("double",      Kind(Kinds.Builtin, "double"))),
                    Argument("yoffset", _Type("double",      Kind(Kinds.Builtin, "double"))),
                ],
            ),
            Function("ImGui_ImplGlfw_KeyCallback",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window",   _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("key",      _Type("int",         Kind(Kinds.Builtin, "int"))),
                    Argument("scancode", _Type("int",         Kind(Kinds.Builtin, "int"))),
                    Argument("action",   _Type("int",         Kind(Kinds.Builtin, "int"))),
                    Argument("mods",     _Type("int",         Kind(Kinds.Builtin, "int"))),
                ],
            ),
            Function("ImGui_ImplGlfw_CharCallback",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window", _Type("GLFWwindow*",  Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("c",      _Type("unsigned int", Kind(Kinds.Builtin, "unsigned int"))),
                ],
            ),
            Function("ImGui_ImplGlfw_MonitorCallback",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("window", _Type("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    Argument("event",  _Type("int",         Kind(Kinds.Builtin, "int"))),
                ],
            ),
        ],
        pxd_header="imgui_impl_glfw.h"
    )
    modules.append(glfw)


# opengl3
with open("core/backends/opengl3.json") as f:
    opengl3 = Binding(
        enums=[],
        typedefs=[],
        structs=[],
        functions=[
            Function("ImGui_ImplOpenGL3_Init",
                _Type("bool", Kind(Kinds.Builtin, "bool")),
                [
                    Argument("glsl_version", _Type("const char*", Kind(Kinds.Pointer, Kind(Kinds.Builtin, "char", is_const=True))), default_value="None"),
                ],
            ),
            Function("ImGui_ImplOpenGL3_Shutdown",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [],
            ),
            Function("ImGui_ImplOpenGL3_NewFrame",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [],
            ),
            Function("ImGui_ImplOpenGL3_RenderDrawData",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [
                    Argument("draw_data", _Type("ImDrawData*", Kind(Kinds.Pointer, Kind(Kinds.User, "ImDrawData")))),
                ],
            ),
            Function("ImGui_ImplOpenGL3_CreateFontsTexture",
                _Type("bool", Kind(Kinds.Builtin, "bool")),
                [],
            ),
            Function("ImGui_ImplOpenGL3_DestroyFontsTexture",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [],
            ),
            Function("ImGui_ImplOpenGL3_CreateDeviceObjects",
                _Type("bool", Kind(Kinds.Builtin, "bool")),
                [],
            ),
            Function("ImGui_ImplOpenGL3_DestroyDeviceObjects",
                _Type("void", Kind(Kinds.Builtin, "void")),
                [],
            ),
        ],
        pxd_header="imgui_impl_opengl3.h"
    )
    modules.append(opengl3)
