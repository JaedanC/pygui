EXTENSION_NAME =           "core"
DCIMGUI_PXD_PATH =         "binding/core/dcimgui.pxd"
PYX_PATH =                 "binding/core/core.pyx"
DCIMGUI_LIBRARY_NAME =     "dcimgui"
GENERATED_PYX_PATH =       "binding/core/core_generated.pyx"
GENERATED_PYX_TRIAL_PATH = "binding/core/core_generated_trial.pyx"
PYX_TRIAL_PATH =           "binding/core/core_trial.pyx"
TEMPLATE_PYX_PATH =        "binding/core/core_template.pyx"
TEMPLATE_PYX_TRIAL_PATH =  "binding/core/core_template_trial.pyx"
INIT_PYI_PATH =            "deploy/pygui/__init__.pyi"
INIT_PY_PATH =             "deploy/pygui/__init__.py"

PYI_CLASS_TEMPLATE =    "binding/model/dear_bindings/templates/class.pyi"
PYI_FUNCTION_TEMPLATE = "binding/model/dear_bindings/templates/function.pyi"
PYI_FIELD_TEMPLATE =    "binding/model/dear_bindings/templates/field.pyi"

CLASS_TEMPLATE =        "binding/model/dear_bindings/templates/class.h"
FUNCTION_TEMPLATE =     "binding/model/dear_bindings/templates/function.h"
FIELD_TEMPLATE =        "binding/model/dear_bindings/templates/field.h"

defines = [
    ("IMGUI_DISABLE_OBSOLETE_KEYIO", True),
    ("IMGUI_DISABLE_OBSOLETE_FUNCTIONS", True),
    ("IMGUI_HAS_IMSTR", False),
]
