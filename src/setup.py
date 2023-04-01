import sys
import os
from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize


def main():
    if len(sys.argv) == 1:
        print("python setup.py clean build_ext --build-lib .")
        print("python setup.py clean build_ext")
        return
    
    # if not os.path.exists("core/cimgui.dll") and not os.path.exists("core/cimgui.lib"):
    #     print("No compiled cimgui library could be found in the pygui/ directory")
    #     return

    extensions = [
        Extension(
            "core",
            [ "core/core.pyx" ],
            include_dirs=["cimgui"],
            library_dirs=["pygui"],
            libraries=["cimgui"],
            define_macros=[
                ("CIMGUI_DEFINE_ENUMS_AND_STRUCTS", None)
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
