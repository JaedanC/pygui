import glob
import os
import sys
import shutil
from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize



def main():
    if len(sys.argv) == 1:
        print("python dear_setup.py clean build_ext --build-lib pygui")
        return
    
    extensions = [
        Extension(
            "core",
            [ "core/core_db.pyx" ],
            include_dirs=[
                "external",
                "external/dear_bindings",
                "external/cimgui/generator/output",
            ],
            library_dirs=["pygui/libs"],
            libraries=["db_cimgui", "glfw3dll", "db_imgui_glfw_opengl3"],
            define_macros=[
                ("CIMGUI_DEFINE_ENUMS_AND_STRUCTS", None),
                ("CIMGUI_USE_GLFW", None),
                ("CIMGUI_USE_OPENGL3", None),
                ("IMGUI_DISABLE_OBSOLETE_KEYIO", True),
                ("IMGUI_DISABLE_OBSOLETE_FUNCTIONS", True),
                ("IMGUI_HAS_IMSTR", False),
            ],
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
