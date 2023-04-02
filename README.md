# Pygui

This repo is designed to help generate python bindings for [Dear ImGui](https://github.com/ocornut/imgui). This project binds on top of [cimgui](https://github.com/cimgui/cimgui) and is heavily inspired by [pyimgui](https://github.com/pyimgui/pyimgui).

Much of the code in `core.pyx` was written by or inspired by the `pyimgui` developers.

## How to run

First, download this repository recursively:

```bash
git clone https://github.com/JaedanC/pygui.git --recursive
```

## Running ImGui

To compile pygui you will first need to complete a few steps. These are broadly the steps I will take you through.

1. Compile LuaJIT
2. Configure cimgui, and generate non-imgui-internal function definitions.
3. *Optionally:* Add function definitions for yet to be implemented cython-imgui functions.
4. Install python dependencies with `venv`
5. Run cmake to build the pygui

### Compiling LuaJIT

Comprehensive instructions for compiling LuaJIT can be found at <https://luajit.org/install.html>.

On windows, this can simplified to:

1. Open VS Developer Powershell. [How to?](https://learn.microsoft.com/en-us/visualstudio/ide/reference/command-prompt-powershell?view=vs-2022#start-from-windows-menu>)
2. From inside `pygui` run

    ```ps
    cd src\LuaJIT\src
    ./msvcbuild.bat
    ```

    This will create `lua*.dll` and `luajit.exe` inside the `src\LuaJIT\src` directory you ran the script from.
3. Copy these two files to `src/cimgui/generator`

### Configuring cimgui

On windows:

1. Navigate to `src\cimgui\generator` and open `generator.bat` in a text editor.
2. Make sure the compiler used is `cl` and the argument string is `"noimstrv comments"`. Line 22 should look something like this:

    ```bat
    luajit ./generator.lua cl "noimstrv comments" glfw opengl3 opengl2 sdl2
    ```

    All other lines can be commented out.
3. Run `generator.bat` (Command below shows `cd` for completion):

    ```ps
    cd src\cimgui\generator
    ./generator.bat
    ```

### Creating a python virtual environment

Inside the root folder of the `pygui` project run:

```ps
python -m venv .
```

Then on windows:

1. Run:

    ```ps
    ./Scripts/activate
    ```

    You will notice your terminal have a (pygui) prefix.

    ```ps
    (pygui) c:/pygui>
    ```

2. Then run:

    ```ps
    pip install -r ./requirements.txt
    ```

### Running CMake

To properly compile pygui it is important that a `x64` Developer PowerShell is used. A regular Visual Studio Developer PowerShell instance will not work. This is because the regular 32 bit `cl` compiler does not correctly compile Cython, and will produce an error when trying to compile.

You can open a `x64` developer powershell by searching for "x64 Native Tools" on windows. Run the resulting Command Prompt. Your cmd shouild look something like this:

```cmd
**********************************************************************
** Visual Studio 2022 Developer Command Prompt v17.5.2
** Copyright (c) 2022 Microsoft Corporation
**********************************************************************
[vcvarsall.bat] Environment initialized for: 'x64'

C:\Program Files\Microsoft Visual Studio\2022\Community>
```

Then run `powershell`.

You will then need to navigate to wherever you cloned `pygui`. For example:

```ps
cd "c:/pygui"
```

Then, start the python venv with:

```ps
./Scripts/activate
```

Then run:

```ps
cmake -S . -B out/build
cmake --build out/build --config RELEASE
```

After running the second command, a new directory called "portable" will be created in the repo. This folder contains everything you need to start your new `pygui` project and can be safely copied away to your project of choice.

## Developing pygui

CMake is a shortcut to installing a portable installation of pygui, but for developers this wish to implement more imgui-cython functions, these are the steps you need to do. First, complete Steps 1-4 above.

Compile `cimgui` with:

1. Option 1. Use `pygui` CMake

    ```ps
    cmake -S . -B out/build
    cmake --build out/build --config RELEASE
    ```

2. Option 2. Use `cimgui` CMake

    ```ps
    cd src/cimgui
    cmake -S . -B out/build
    cmake --build out/build --config RELEASE
    ```

    Copy:

    - `src/cimgui/out/build/Release/cimgui.dll`
    - `src/cimgui/out/build/Release/cimgui.lib`

    ...to `src/pygui`

To generate the Cython-imgui bindings run:

```ps
cd src
python model_creator.py --all
python setup.py clean build_ext --build-lib pygui
```

You can test the application with:

```ps
cd src
python app.py
```

## How are bindings created?

Bindings are creating by first reading the output of cimgui's generator. These can be found inside `src/cimgui/generator/output`. The definitions are then parsed and exported into three types of files:

1. `pxd`: (Located at `src/core/ccimgui.pxd`) This files contains all the 1 to 1 definitions that are defined inside `cimgui.h` (Located at `src/cimgui/cimgui.h`). This file does not need to be touched if the API changes.
2. `pyx`: (Located at `src/core/core.pyx`) This file contains the cython that is compiled. This file can be editted if you want, but new additions should instead be put inside `src/core/core_template.pyx`. More on this later.
3. `pyi`: (Located at `src/pygui/__init__.pyi`) This file contains the cython function definitions so that intellisense on editors work correctly with pygui. Cython does not export any symbols so this file is required if you don't want squiggly lines everywhere in your editor.

The `src/core/core_template.pyx` is the file that should be editted if you want to change any implementation between python and imgui. This file is the go-between, needing to marshall types between python and c. **A majority of functions are disabled by default**, but then can be turned on by changing the `use_template` to True, and the `active` to True. Example:

```python
# [Function]
# ?use_template(True)
# ?active(True)
# ?returns(None)
def show_demo_window(closable: bool=False):
    """
    Create demo window. demonstrate most imgui features. call this
    to learn about the library! try to make it always available
    in your application!
    """
    cdef bool opened = True
    if closable:
        ccimgui.igShowDemoWindow(&opened)
    else:
        ccimgui.igShowDemoWindow(NULL)
    
    return opened
# [End Function]
```

When activated, the function can be editted however you like, including the name of the function, or it's parameters. All that matters is that you also write the `returns` value. This is what will be used inside the `pyi` file. Cython syntax and usage can be found online, but here are a few tips:

1. Most functions have been given a template that is 50% correct. Sometimes it requires modification to work. Other times it will work straight away.
2. `char *` and `str` can be converted to and from using `_bytes` and `_from_bytes`. See: `begin()` and `get_version()`.
3. Tuples and ImVec2 can be converted using `_cast_tuple_ImVec2` and `_cast_ImVec2_tuple`. Use respective functions for ImVec4.
4. Instances of classes returned cannot store any information on them because they simply serve as wrappers for a pointer to the real instance in c. Any information required to be stored on a class should instead be written to a dictionary. See `get_clipboard_text_fn` and `set_clipboard_text_fn`.
5. Converting to and from lists is much harder. Consider looking at `ImDrawData.cmd_lists` and `ImGuiIO.key_map`.

Running `src/model_creator.py` with no options will give you a better look into the options provided. Importantly, whenever the pyx is generated, this will read `core_template.pyx` and merge it with `core_generated` to create `core.pyx`. **If a function inside `core_template.pyx` is not marked as `use_template`, it will be reset to whatever is inside `core_generated.pyx` and `core_template.pyx` will be modified!**. This is by design.

If you are unsure about the output, run `model_creator.py --trial`. This will generate `_trial.pyx` versions of `core.pyx` and `core_template.pyx` so you can see what each file *would* look like if you ran `model_creator.py --pyx`.
