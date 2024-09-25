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
