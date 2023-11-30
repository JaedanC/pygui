import json
from typing import List
from .model.parsed.interfaces import IBinding
from .model.parsed.dear_bindings.binding import DearBindingNew
from .model.parsed.dear_bindings.struct import DearBindingsStructNew
from .model.parsed.dear_bindings.function import DearBindingsFunctionNew
from .model.parsed.dear_bindings.db_type import DearBindingsTypeNew, Kind, Kinds
from .model.parsed.dear_bindings.argument import DearBindingsArgumentNew
from .model.comments import Comments


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
        DearBindingNew.from_json(json.load(f), "cimgui.h", defines)
    )

# glfw
with open("core/backends/glfw.json") as f:
    glfw = DearBindingNew(
        enums=[],
        typedefs=[],
        structs=[
            DearBindingsStructNew("GLFWwindow",  []),
            DearBindingsStructNew("GLFWmonitor", []),
        ],
        functions=[
            DearBindingsFunctionNew("ImGui_ImplGlfw_InitForOpenGL",
                DearBindingsTypeNew("bool", Kind(Kinds.Builtin, "bool")),
                [
                    DearBindingsArgumentNew("window",            DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("install_callbacks", DearBindingsTypeNew("bool",        Kind(Kinds.Builtin, "bool"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_InitForVulkan",
                DearBindingsTypeNew("bool", Kind(Kinds.Builtin, "bool")),
                [
                    DearBindingsArgumentNew("window",            DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("install_callbacks", DearBindingsTypeNew("bool",        Kind(Kinds.Builtin, "bool"))),
                ],
                Comments([], None)
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_InitForOther",
                DearBindingsTypeNew("bool", Kind(Kinds.Builtin, "bool")),
                [
                    DearBindingsArgumentNew("window",            DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("install_callbacks", DearBindingsTypeNew("bool",        Kind(Kinds.Builtin, "bool"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_Shutdown",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_NewFrame",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_InstallCallbacks",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window", DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_RestoreCallbacks",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window", DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_SetCallbacksChainForAllWindows",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("chain_for_all_windows", DearBindingsTypeNew("bool", Kind(Kinds.Builtin, "bool"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_SetCallbacksChainForAllWindows",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window",  DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("focused", DearBindingsTypeNew("int",         Kind(Kinds.Builtin, "int"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_CursorEnterCallback",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window",  DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("entered", DearBindingsTypeNew("double",      Kind(Kinds.Builtin, "double"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_CursorPosCallback",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window", DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("x",      DearBindingsTypeNew("double",      Kind(Kinds.Builtin, "double"))),
                    DearBindingsArgumentNew("y",      DearBindingsTypeNew("double",      Kind(Kinds.Builtin, "double"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_MouseButtonCallback",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window", DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("button", DearBindingsTypeNew("double",      Kind(Kinds.Builtin, "double"))),
                    DearBindingsArgumentNew("action", DearBindingsTypeNew("double",      Kind(Kinds.Builtin, "double"))),
                    DearBindingsArgumentNew("mods",   DearBindingsTypeNew("double",      Kind(Kinds.Builtin, "double"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_ScrollCallback",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window",  DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("xoffset", DearBindingsTypeNew("double",      Kind(Kinds.Builtin, "double"))),
                    DearBindingsArgumentNew("yoffset", DearBindingsTypeNew("double",      Kind(Kinds.Builtin, "double"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_KeyCallback",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window",   DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("key",      DearBindingsTypeNew("int",         Kind(Kinds.Builtin, "int"))),
                    DearBindingsArgumentNew("scancode", DearBindingsTypeNew("int",         Kind(Kinds.Builtin, "int"))),
                    DearBindingsArgumentNew("action",   DearBindingsTypeNew("int",         Kind(Kinds.Builtin, "int"))),
                    DearBindingsArgumentNew("mods",     DearBindingsTypeNew("int",         Kind(Kinds.Builtin, "int"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_CharCallback",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window", DearBindingsTypeNew("GLFWwindow*",  Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("c",      DearBindingsTypeNew("unsigned int", Kind(Kinds.Builtin, "unsigned int"))),
                ],
            ),
            DearBindingsFunctionNew("ImGui_ImplGlfw_MonitorCallback",
                DearBindingsTypeNew("void", Kind(Kinds.Builtin, "void")),
                [
                    DearBindingsArgumentNew("window", DearBindingsTypeNew("GLFWwindow*", Kind(Kinds.Pointer, Kind(Kinds.User, "GLFWwindow")))),
                    DearBindingsArgumentNew("event",  DearBindingsTypeNew("int",         Kind(Kinds.Builtin, "int"))),
                ],
            ),

        ]
    )
    modules.append(glfw)


# opengl3
with open("core/backends/opengl3.json") as f:
    modules.append(
        DearBindingNew.from_json(json.load(f), "imgui_impl_opengl3.h", defines)
    )
