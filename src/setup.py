import sys
import os
from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize


def main():
    if len(sys.argv) == 1:
        print("python setup.py clean build_ext --build-lib .")
        return
    
    if not os.path.exists("pygui/cimgui.dll") and not os.path.exists("pygui/cimgui.lib"):
        print("No compiled cimgui library could be found in the pygui/ directory")
        return

    setup(
        name="pygui",
        packages=find_packages("."),
        ext_modules = cythonize(
            Extension(
                "pygui.core", 
                sources=[
                    "pygui/core.pyx"
                ],
                define_macros=[
                    ("CIMGUI_DEFINE_ENUMS_AND_STRUCTS", None)
                ],
                include_dirs=["pygui"],
                library_dirs=["pygui"],
                libraries=["cimgui"],
            )
        )
    )


if __name__ == "__main__":
    main()
