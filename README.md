# pygui

Pygui is a dynamic wrapper for [Dear ImGui](https://github.com/ocornut/imgui) using Cython.

![Hello From pygui](./docs/img/hello_from_pygui.png)

## Features

1. Imgui Docking Support.
2. Imgui Multi-Viewport Support.
3. Intellisense Support. (`__init__.pyi` file)
4. Uses Imgui's `glfw_opengl3` backend. Minimal understanding of OpenGL is needed.
5. Includes a minimal c example.

![Intellisense](./docs/img/intellisense.png)

This project uses [cimgui](https://github.com/cimgui/cimgui) as the base, and much of the `core.pyx` code (Cython binding) was written by the developers of [pyimgui](https://github.com/pyimgui/pyimgui).

## Limitations

1. Current build assumes windows as the platform. Some work would be required to enable linux/mac builds.
2. glfw/cimgui/imgui_impl need to be linked at compile time which may hurt performance slightly.
3. Not all imgui functions are ported across. These would need to be worked on, but PR's welcome. See [pyimgui's](https://github.com/pyimgui/pyimgui) core.pyx for help.
4. More work would be required to enable additional backends. Though the modular design of using `dll's` should not make this too hard.

## How to run

First, download this repository recursively:

```bash
git clone https://github.com/JaedanC/pygui.git --recursive
```

You may use different versions of glfw, luajit or cimgui if you wish. Just checkout the version you want.

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
    cd src/external/cimgui/generator
    ./msvcbuild.bat
    ```

    This will create `lua*.dll` and `luajit.exe` inside the `./src/external/luajit/src` directory you ran the script from.
3. Copy these two files to `src/external/cimgui/generator`

### Configuring cimgui

On windows:

1. Edit `./src/external/cimgui/generator/generator.bat` file to contain only:

    ```bat
    luajit ./generator.lua cl "comments noimstrv" glfw opengl3
    ```

    - This will generate the bindings using window's C compiler `cl`.
    - Internal imgui functions are omitted.
    - Comments are included.
    - Only the relevant implementations are included.

2. Run `generator.bat`

    ```ps
    # ./src/external/cimgui/generator
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

This step will compile:

- cimgui
- imgui_glfw_opengl3
- glfw

All as shared `.dll`'s so that you can recompile each module and/or include extra implementations as a dll. It is very important that glfw is NOT compiled statically. If it is compiled statically then python's glfw will refer do a different instance, causing imgui to crash on startup.

You may use Visual Studio or the command-line (developer console on windows) to run CMake. I will be using Visual Studio.

Configure (build) CMake and then CMake "Install". This will build the targets and save them to `./src/pygui`. An additional `./src/pygui/my_program.exe` has been included that compiles from `main.c`. This is to demonstrate the `dll`'s in action. If this program does not run correctly, then the `dll`'s are not ready for python.

### Compiling Pygui

Finally we can compile pygui. From a default clone, no further configuration is required. But this is the step where we can update the cython bindings or generally perform any python-specific changes.

To compile pygui run setup.py like so:

```ps
cd src
python setup.py clean build_ext --build-lib pygui
```

This will compile to `./src/pygui`:

- The `core*.pyd` file. This contains the cython binding.
- The `__init__.py` file. This allows the `pygui` directory to be imported as `import pygui`
- The `__init__.pyi` file. This gives the `pygui` module correct intellisense in editors as cython does not export symbols.

It will also copy the entire `pygui` python module to directory called `portable`. This new directory will contains everythign required for a new `pygui` project to be portable. It will not include the `src/pygui/libs` directory or the `my_program.exe`.

## Developing pygui

To develop pygui, it's important that you first compile/install the 3 `dll`'s above using CMake.

After that, you can then begin to modify the bindings. More on that in the next section. But for now, let's look at how you would generate the bindings:

```ps
cd src
python model_creator.py --all
```

Then run the cython compiler again:

```ps
python setup.py clean build_ext --build-lib pygui
```

You can test the application with:

```ps
cd src
python app.py
```

## How are bindings created?

Bindings are creating by first reading the output of cimgui's generator. These can be found inside `./src/external/cimgui/generator/output`. The definitions are then parsed and exported into three types of files:

1. `pxd`: (Located at `src/core/ccimgui.pxd`) This files contains all the 1 to 1 definitions that are defined inside `cimgui.h` (Located at `src/external/cimgui/cimgui.h`). This file does not need to be touched if the API changes.
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

Running `./src/model_creator.py` with no options will give you a better look into the options provided. Importantly, whenever the pyx is generated, this will read `core_template.pyx` and merge it with `core_generated` to create `core.pyx`. **If a function inside `core_template.pyx` is not marked as `use_template`, it will be reset to whatever is inside `core_generated.pyx` and `core_template.pyx` will be modified!**. This is by design.

If you are unsure about the output, run `python model_creator.py --trial`. This will generate `*_trial.pyx` versions of `core.pyx` and `core_template.pyx` so you can see what each file *would* look like if you ran `model_creator.py --pyx`.
