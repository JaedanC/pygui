# Pygui

This repo is designed to help generate python bindings for [Dear ImGui](https://github.com/ocornut/imgui). This project binds on top of [cimgui](https://github.com/cimgui/cimgui) and is heavily inspired by [pyimgui](https://github.com/pyimgui/pyimgui).

Much of the code in the `core.pyx` was written by the `pyimgui` developers.

## How to run

First, download this repository recursively:

```bash
git clone https://github.com/JaedanC/pygui.git --recursive
```

Then, use Visual Studio to build `cimgui` to a `*.dll`. Move the `cimgui.dll` and `cimgui.lib` file to the `pygui` directory.

To create the Python environment feel free to use `venv`. Then run

```bash
pip install -r requirements.txt
```

To compile the Cython bindings run:

```bash
python setup.py clean build_ext --build-lib .
```

Finally, to test that it works run `app.py`

```bash
python app.py
```

The resulting `pygui` folder can then be moved to your project.

## How to compile pxd files

To regenerate the `.pxd` files, run:

```python
python code_creator.py
```

TODO: Make `code_creator.py` also create a helper `.pyx` and helper `.pyi` file.
