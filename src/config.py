import json
from typing import List
from model.dear_bindings.interfaces import IBinding
from model.dear_bindings.binding import Binding


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
with open("external/dear_bindings/generated/cimgui.json") as f:
    modules.append(
        Binding.from_json(json.load(f), "cimgui.h", defines)
    )

# glfw
with open("external/dear_bindings/generated/backends/cimgui_impl_glfw.json") as f:
    modules.append(
        Binding.from_json(json.load(f), "cimgui_impl_glfw.h", defines)
    )

# opengl
with open("external/dear_bindings/generated/backends/cimgui_impl_opengl3.json") as f:
    modules.append(
        Binding.from_json(json.load(f), "cimgui_impl_opengl3.h", defines)
    )

# Error handling from cimgui_internal.h
with open("external/dear_bindings/generated/cimgui_internal.json") as f:
    loaded_json = json.load(f)


    # ImGuiErrorRecoveryState
    structs = []
    for struct in loaded_json["structs"]:
        if struct["original_fully_qualified_name"] == "ImGuiErrorRecoveryState":
            structs = [struct]
            break

    # ImGui::ErrorRecoveryStoreState & ImGui::ErrorRecoveryTryToRecoverState
    functions = []
    for function in loaded_json["functions"]:
        if function["original_fully_qualified_name"] == "ImGui::ErrorRecoveryStoreState" or \
            function["original_fully_qualified_name"] == "ImGui::ErrorRecoveryTryToRecoverState":
            functions.append(function)

    loaded_json = {
        "enums": [],
        "typedefs": [],
        "structs": structs,
        "functions": functions,
    }

    modules.append(
        Binding.from_json(loaded_json, "cimgui_internal.h", defines)
    )
