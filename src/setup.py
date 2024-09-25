import os
import sys
import shutil
from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize
from config import *


def main():
    if len(sys.argv) == 1:
        print("python setup.py clean build_ext --build-lib pygui [--dev]")
        return
    
    sources = [PYX_PATH]

    # For speeding up developer builds
    if "--dev" in sys.argv:
        compile_option = "/Od"
        sys.argv.remove("--dev")
    else:
        compile_option = "/Ox"
    
    extensions = [
        Extension(
            EXTENSION_NAME,
            sources=sources,
            # Any header files expected by implementations should have their
            # directory added here. Cython will attempt to statically compile
            # the functions we defined in our pxd file.
            include_dirs=[
                "cpp_config",                                # pygui_config.h
                "external/dear_bindings/generated",          # cimgui.h
                "external/dear_bindings/generated/backends", # imgui_impl_*.h
                "external/imgui",                            # imconfig.h (Ununsed)
            ],
            library_dirs=[
                "pygui/libs",
            ],
            libraries=["cimgui_glfw_opengl3", "glfw3dll"],
            define_macros=[
                ("PYGUI_COMPILING_DLL", True),
                ("USE_CUSTOM_PYTHON_ERROR", True),
            ],
            extra_compile_args=([compile_option])
        )
    ]

    setup(
        name="pygui",
        packages=find_packages("."),
        ext_modules=cythonize(extensions)
    )


    # Create the portible pygui installation
    if os.path.exists("../portable"):
        shutil.rmtree("../portable")

    def verbose_copy(start, dest):
        print(f"Created {dest}")
        return shutil.copy2(start, dest)

    shutil.copytree("pygui", "../portable/pygui",
        copy_function=verbose_copy,
        ignore=shutil.ignore_patterns(
            "__pycache__",
            "libs",
            "*.ini",
            "*.exe",
        ))

    verbose_copy("requirements.txt", "../portable/requirements.txt")
    verbose_copy("pygui_demo.py",    "../portable/pygui_demo.py")
    verbose_copy("app.py",           "../portable/app.py")


if __name__ == "__main__":
    main()
