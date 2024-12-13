import os
import sys
import shutil
from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize

from binding.constants import PYX_PATH, EXTENSION_NAME


def main():
    if len(sys.argv) == 1:
        print("python setup.py clean build_ext --build-lib deploy/pygui [--dev]")
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
                "c/cpp_config",                              # pygui_config.h
                "external/dear_bindings/generated",          # dcimgui.h
                "external/dear_bindings/generated/backends", # imgui_impl_*.h
                "external/imgui",                            # imconfig.h (Ununsed)
            ],
            library_dirs=[
                "deploy/pygui/libs",
            ],
            libraries=["dcimgui_glfw_opengl3", "glfw3dll"],
            define_macros=[
                ("PYGUI_COMPILING_DLL", True),
                ("USE_CUSTOM_PYTHON_ERROR", True),
            ],
            extra_compile_args=([compile_option])
        )
    ]

    setup(
        name="deploy/pygui",
        packages=find_packages("."),
        ext_modules=cythonize(extensions)
    )


    PORTABLE_SAVE_LOCATION = "../portable"

    # Create the portible pygui installation
    if os.path.exists(PORTABLE_SAVE_LOCATION):
        shutil.rmtree(PORTABLE_SAVE_LOCATION)

    def verbose_copy(start, dest):
        print(f"Creating {dest}")
        return shutil.copy2(start, dest)

    shutil.copytree("deploy/pygui", PORTABLE_SAVE_LOCATION + "/pygui",
        copy_function=verbose_copy,
        ignore=shutil.ignore_patterns(
            "__pycache__",
            "libs",
            "*.ini",
            "*.exe",
        ))

    verbose_copy("deploy/requirements.txt", PORTABLE_SAVE_LOCATION + "/requirements.txt")
    verbose_copy("deploy/pygui_demo.py",    PORTABLE_SAVE_LOCATION + "/pygui_demo.py")
    verbose_copy("deploy/app.py",           PORTABLE_SAVE_LOCATION + "/app.py")


if __name__ == "__main__":
    main()
