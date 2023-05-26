import json
import glob
import os
import sys
import shutil
from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize



def main():
    if len(sys.argv) == 1:
        print("python setup.py clean build_ext --build-lib pygui [--dev]")
        return
    
    with open("config.json") as f:
        config = json.load(f)

    extension_name = config["EXTENSION_NAME"]
    sources = [config["PYX_PATH"]]

    # For speeding up developer builds
    if "--dev" in sys.argv:
        compile_option = "/Od"
        sys.argv.remove("--dev")
    else:
        compile_option = "/Ox"
    
    extensions = [
        Extension(
            extension_name,
            sources=sources,
            # Any header files expected by implementations should have their
            # directory added here. Cython will attempt to statically compile
            # the functions we defined in our pxd file. So for the implementations,
            # since we are linking them with a dll, the impl functions should be
            # marked as extern "C" __declspec(dllexport)
            include_dirs=[
                "cpp_config",               # imconfig.h, pygui_config.h
                "external/dear_bindings",   # cimgui.h
                "core/backends",            # imgui_impl_*.h
            ],
            library_dirs=["pygui/libs"],
            libraries=["cimgui", "glfw3dll", "imgui_glfw_opengl3"],
            define_macros=[
                ("IMGUI_IMPL_API", 'extern "C" __declspec(dllexport)'),
                ("IMGUI_DISABLE_OBSOLETE_KEYIO", True),
                ("IMGUI_DISABLE_OBSOLETE_FUNCTIONS", True),
                ("PYGUI_COMPILING_CIMGUI", True),
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
