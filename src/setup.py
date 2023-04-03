import sys
import os
from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize


def main():
    if len(sys.argv) == 1:
        print("python setup.py clean build_ext --build-lib pygui")
        return
    
    # if not os.path.exists("core/cimgui.dll") and not os.path.exists("core/cimgui.lib"):
    #     print("No compiled cimgui library could be found in the pygui/ directory")
    #     return

    extensions = [
        Extension(
            "core",
            [ "core/core.pyx" ],
            include_dirs=["cimgui", "cimgui/generator/output", "glfw/include"],
            library_dirs=["pygui"],
            libraries=["cimgui", "glfw3"],
            define_macros=[
                ("CIMGUI_DEFINE_ENUMS_AND_STRUCTS", None),
                ("CIMGUI_USE_GLFW", None),
                ("CIMGUI_USE_OPENGL3", None),
                # ("CIMGUI_USE_OPENGL2", None),
                # ("CIMGUI_USE_SDL2", None),
            ],
        )
    ]

    setup(
        name="pygui",
        packages=find_packages("."),
        ext_modules=cythonize(extensions)
    )


if __name__ == "__main__":
    main()
