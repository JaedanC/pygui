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
                "external",                 # My imconfig.h
                "external/dear_bindings",   # cimgui.h
                "core/backends",            # imgui_impl_*.h
            ],
            library_dirs=["pygui/libs"],
            libraries=["cimgui", "glfw3dll", "imgui_glfw_opengl3"],
            define_macros=[
                ("IMGUI_IMPL_API", 'extern "C" __declspec(dllexport)'),
                ("IMGUI_DISABLE_OBSOLETE_KEYIO", True),
                ("IMGUI_DISABLE_OBSOLETE_FUNCTIONS", True),
            ],
            extra_compile_args=([compile_option])
        )
    ]

    setup(
        name="pygui",
        packages=find_packages("."),
        ext_modules=cythonize(extensions)
    )


    if os.path.exists("../portable"):
        shutil.rmtree("../portable")

    os.makedirs("../portable/pygui")

    to_copy = \
        glob.glob(r"pygui/*.dll") + \
        glob.glob(r"pygui/*.pyd") + \
        glob.glob(r"pygui/*.py") + \
        glob.glob(r"pygui/*.pyi")
    to_copy.sort()
    to_copy = [f.replace("\\", "/") for f in to_copy]
    
    for file_to_copy in to_copy:
        shutil.copy(file_to_copy, "../portable/pygui")
        print(f"Created ../portable/{file_to_copy}")
    
    shutil.copy("requirements.txt", "../portable")
    print(f"Created ../portable/requirements.txt")
    shutil.copy("app.py", "../portable")
    print(f"Created ../portable/app.py")
    


if __name__ == "__main__":
    main()
