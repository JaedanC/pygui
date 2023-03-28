# Pygui

This repo is designed to help generate python bindings for [Dear ImGui](https://github.com/ocornut/imgui). This project binds on top of [cimgui](https://github.com/cimgui/cimgui) and is heavily inspired by [pyimgui](https://github.com/pyimgui/pyimgui).

Much of the code in `core.pyx` was written by or inspired by the `pyimgui` developers.

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

Then, we will generate the `pyx` core and the `pyi` api with:

```bash
python model_creator.py --all
```

To compile the Cython bindings run:

```bash
python setup.py clean build_ext --build-lib .
```

Finally, to test that it works run `app.py`

```bash
python app.py
```

## How it works

*todo*
