from __future__ import annotations
import sys
import textwrap
from io import StringIO
from typing import List
from pyx_parser import *
from model.dear_bindings.interfaces import IBinding

from config import *


PYX_TEMPLATE_MARKER = "# ---- Start Generated Content ----\n\n"


class MergeFailed(Exception):
    pass


class MergeResult:
    def __init__(self, old_pyx: str, new_pyx: str, template_pyx: str):
        self.old_pyx: str      = old_pyx
        self.new_pyx: str      = new_pyx
        self.template_pyx: str = template_pyx

        self.old_model: PyxHeader = create_pyx_model(old_pyx)
        self.new_model: PyxHeader = create_pyx_model(new_pyx)
        self.template_model: PyxHeader = create_pyx_model(template_pyx)

        comparison = HeaderComparison(self.old_model, self.new_model)
        self.merged_model: PyxHeader = comparison.create_new_header_based_on_comparison(self.template_model)
        if self.merged_model is None:
            raise MergeFailed
        
        self.merged_pyx: str = replace_after(
            new_pyx,
            PYX_TEMPLATE_MARKER,
            self.merged_model.as_pyx()
        )
        self.merged_pyx_all_active: str = replace_after(
            new_pyx,
            PYX_TEMPLATE_MARKER,
            self.merged_model.as_pyx(ignore_active_flag=True)
        )


def replace_after(src: str, marker_substring: str, new_impl: str) -> str:
    ms_len = len(marker_substring)
    src = src[:src.index(marker_substring) + ms_len] + new_impl
    return src


def wrap_text(text, to_size=60) -> str:
    """
    Adds newlines to text such that at least 'to_size' characters are present on
    each line. When a 'to_size' characters are found, the next space will be
    replaced by a newline.
    """
    output = ""
    i = 0
    for char in text:
        if i < to_size:
            output += char
        elif char == " ":
            output += "\n"
            i = 0
        else:
            output += char

        i += 1
    return output


def to_pyi(
        modules: List[IBinding],
        model: PyxHeader,
        show_comments: bool
    ):
    base = textwrap.dedent('''
    # This file is auto-generated. If you need to edit this file then edit the
    # template this is created from instead.
    from typing import Any, Callable, Tuple, List, Sequence, Optional
    from PIL import Image

    FLT_MIN: float
    """
    Occasionally used by ImGui to mark boundaries for things. Usually used as
    `-pygui.FLT_MIN`
    """
    FLT_MAX: float
    """
    Occasionally used by ImGui to mark boundaries for things.
    """
    INT_MIN: int
    INT_MAX: int
    UINT_MAX: int
    LLONG_MIN: int
    LLONG_MAX: int
    ULLONG_MAX: int

    PAYLOAD_TYPE_COLOR_3F: int
    """
    Used by `pygui.accept_drag_drop_payload()` to retrieve colors that are
    dragged inside ImGui. No Alpha channel.
    """
    PAYLOAD_TYPE_COLOR_4F: int
    """
    Used by `pygui.accept_drag_drop_payload()` to retrieve colors that are
    dragged inside ImGui. Includes Alpha channel.
    """

    class ImGuiError(Exception):
        """
        Raised by ImGui if an `IM_ASSERT()` fails *and* custom exceptions have
        been turned on. Otherwise, this exception will be equal to
        `AssertionError` and ImGui exceptions will be left to crash your app.
        """
        pass

    class Bool:
        """
        A wrapper class for a c++ boolean. `Use Bool.value` to access the
        underlying value. This as a replacement for `bool*` in c++.
        """
        value: bool
        def __init__(self, initial_value: bool) -> Bool: ...
        def __bool__(self) -> bool:
            """
            Allows this instance to be directly used a boolean in an `if` statement
            without needing to extract the value.
                
                ```python
                my_boolean = pygui.Bool(True)
                if my_boolean:
                    print("This is true")
                ```
            """

    class Int:
        """
        A wrapper class for a c++ int. Use `Int.value` to access the underlying
        value. This as a replacement for `int*` in c++. The underlying `int` size
        will be platform specific. If more bytes are required then use a
        `pygui.Long`.
        """
        value: int
        def __init__(self, initial_value: int=0) -> Int: ...

    class Long:
        """
        A wrapper class for a c++ long long. Use `Long.value` to access the
        underlying value. This as a replacement for `long long*` in c++. The
        underlying `long long` size will be platform specific.
        """
        value: int
        def __init__(self, initial_value: int=0) -> Long: ...

    class Float:
        """
        A wrapper class for a c++ float. Use `Float.value` to access the
        underlying value. This as a replacement for `float*` in c++. The
        underlying `float` precision will be platform specific. If more precision
        is required then use a `pygui.Double`.
        """
        value: float
        def __init__(self, initial_value: float=0.0) -> Float: ...

    class Double:
        """
        A wrapper class for a c++ double. Use `Double.value` to access the
        underlying value. This as a replacement for `double*` in c++. The
        underlying `double` precision will be platform specific.
        """
        value: float
        def __init__(self, initial_value: float=0.0) -> Double: ...

    class String:
        """
        A wrapper class for a c++ heap allocated `char*` string. Use
        `String.value` to read the buffer as if it were a python string. The
        `buffer_size` indicates how large the buffer backing this string should
        be. Depending on the characters in the string, the `buffer_size`
        *may not* be the same `len()` as the string.
        
        The number of writable bytes is equal to `buffer_size - 1`, to make room
        for the NULL byte which is automatically handled by this class.

        Modifying the underling `String.value` is also supported. This will
        automically convert the string passed into bytes and populate the buffer
        using `strncpy` (no buffer overflow for you). Modifying the
        `buffer_size` is *not* supported and will raise a NotImplementedError if
        changed. `buffer_size` must be >= 0 on creation.
        
        This as a replacement for `char*` in c++.
        """
        value: str
        buffer_size: int
        """
        Read only size of the heap allocated buffer backing this string.
        """
        def __init__(self, initial_value: str="", buffer_size=256) -> String: ...

    class Vec2:
        """
        A wrapper class for a c++ ImVec2. Use `Vec2.x` and `Vec2.y` to access
        individual components of the Vector. Or use `Vec2.tuple()` to access the
        the underlying `ImVec2` as a read-only python `tuple`. Each component of
        this `Vec2` is a `pygui.Float`. See the methods on this class for more
        information.
        """
        x: float
        """
        Access/Modify the `x` component of the `Vec2` 
        """
        y: float
        """
        Access/Modify the `y` component of the `Vec2` 
        """
        x_ptr: Float
        """
        Access/Modify the `x` component of the `Vec2` as a `pygui.Float`
        """
        y_ptr: Float
        """
        Access/Modify the `y` component of the `Vec2` as a `pygui.Float`
        """
        def __init__(self, x: float, y: float) -> Vec2: ...
        @staticmethod
        def zero() -> Vec2:
            """
            Same as `Vec2(0, 0)`
            """
            pass
        
        def tuple(self) -> Sequence[float, float]:
            """
            Access a read-only tuple containing the `x`, `y` components of the
            `Vec2`
            """
            pass
        
        def from_tuple(self, vec: Sequence[float, float]) -> Vec2:
            """
            Modify the components of the `Vec2` using a (minimum) length 2
            Sequence. eg. tuple/list

                ```python
                vec2 = pygui.Vec2(0, 0)
                vec2.from_tuple((50, 100))
                ```
            
            Returns the same Vec2 so that this method can be chained.
            """
            pass
        
        def as_floatptrs(self) -> Sequence[Float, Float]:
            """
            Returns the internal components of the `Vec2` as a length 2 tuple of
            `pygui.Floats`. Each `pygui.Float` can be used to modify the
            internal state of the `Vec2` from elsewhere.
            """
            pass
        
        def from_floatptrs(self, float_ptrs: Sequence[Float, Float]) -> Vec2:
            """
            Modify the components of the `Vec2` using a (minimum) length 2
            Sequence of `pygui.Float`. eg. tuple/list. Returns the same Vec2 so
            that this method can be chained.
            """
            pass
        
        def copy(self) -> Vec2:
            """
            Returns a new deepcopied `Vec2`. The underlying `pygui.Float` are
            also new.
            """
            pass

    class Vec4:
        """
        A wrapper class for a c++ ImVec4. Use `Vec4.x`, `Vec4.y`, `Vec4.z` and
        `Vec4.w` to access individual components of the Vector. Or use
        `Vec4.tuple()` to access the the underlying `ImVec4` as a read-only
        python `tuple`. Each component of this `Vec4` is a `pygui.Float`. See
        the methods on this class for more information.
        """
        x: float
        """
        Access/Modify the `x` component of the `Vec4` 
        """
        y: float
        """
        Access/Modify the `y` component of the `Vec4` 
        """
        z: float
        """
        Access/Modify the `z` component of the `Vec4` 
        """
        w: float
        """
        Access/Modify the `w` component of the `Vec4` 
        """
        x_ptr: Float
        """
        Access/Modify the `x` component of the `Vec4` as a `pygui.Float`
        """
        y_ptr: Float
        """
        Access/Modify the `y` component of the `Vec4` as a `pygui.Float`
        """
        z_ptr: Float
        """
        Access/Modify the `z` component of the `Vec4` as a `pygui.Float`
        """
        w_ptr: Float
        """
        Access/Modify the `w` component of the `Vec4` as a `pygui.Float`
        """
        def __init__(self, x: float, y: float, z: float, w: float) -> Vec4: ...
        @staticmethod
        def zero() -> Vec4:
            """
            Same as `Vec4(0, 0)`
            """
            pass
        
        def tuple(self) -> Sequence[float, float, float, float]:
            """
            Access a read-only tuple containing the components of the `Vec4`
            """
            pass
        
        def from_tuple(self, vec: Sequence[float, float, float, float]) -> Vec4:
            """
            Modify the components of the `Vec4` using a (minimum)
            length 4 Sequence. eg. tuple/list

                ```python
                vec4 = pygui.Vec4(0, 0, 0, 0)
                vec4.from_tuple((50, 100, 150, 200))
                ```

            Returns the same Vec4 so that this method can be chained.
            """
            pass
        
        def as_floatptrs(self) -> Sequence[Float, Float, Float, Float]:
            """
            Returns the internal components of the `Vec2` as a length 4 tuple of
            `pygui.Floats`. Each `pygui.Float` can be used to modify the
            internal state of the `Vec4` from elsewhere.
            """
            pass
        
        def from_floatptrs(self, float_ptrs: Sequence[Float, Float, Float, Float]) -> Vec4:
            """
            Modify the components of the `Vec4` using a (minimum) length 4
            Sequence of `pygui.Float`. eg. tuple/list. Returns the same Vec4 so
            that this method can be chained.
            """
            pass
        
        def to_u32(self) -> int:
            """
            Converts this `Vec4` into a u32 integer. u32 integers are used in
            ImGui for coloring.
            """
            pass
        
        def copy(self) -> Vec4:
            """
            Returns a new deepcopied `Vec4`. The underlying `pygui.Float` are
            also new.
            """
            pass
    
    class ImGlyphRange:
        """
        A custom wrapper around an `unsigned short*` array. This is used to back
        the glyph range used by many of the font functions in pygui. Pass a list
        of 2 element tuples to create a valid range.
        
        For example:

            ```python
            range = pygui.ImGlyphRange([
                (0x01,   0xFF),   # Extended ASCII Range,
                (0x1F00, 0x1FFF), # Greek Extended Range
            ])
            ```

        Unlike ImGui, you do not need to pass a 0 element to mark the end of
        the array. This class will handle that. If any of the ranges start with
        a 0, that range will be changed to 1.

            ```python
            range = pygui.ImGlyphRange([
                (0x00, 0xFF) # Internally adds 1
            ]) 
            # Is the the same as
            range = pygui.ImGlyphRange([
                (0x01, 0xFF)
            ])
            ```
        """
        ranges: Sequence[tuple]
        """
        The (read-only) list of ranges backing this object. Modifying this value
        will raise a NotImplementedError.
        """
        def __init__(self, glyph_ranges: Sequence[tuple]): ...
        def destroy(self):
            """
            Internally, the memory backing the ImGlyphRange will be freed when
            the python object is cleaned up by the garbage collector, but this
            may actually free the memory backing this range before you call
            `ImFontAtlas.build()` which requires the buffer to be valid. Hence,
            this function exists.
            
            Call `ImGlyphRange.destroy()` explicitly after calling
            `ImFontAtlas.build()` to ensure Python does not garbage-collect this
            object.
            """
            pass


    def IM_COL32(r: int, g: int, b: int, a: int) -> int:
        """
        Mimics a macro in ImGui. Each components is between 0-255. The result is
        a u32 integer used commonly in ImGui for coloring.
        """
    
    IM_COL32_WHITE: int
    IM_COL32_BLACK: int
    IM_COL32_BLACK_TRANS: int

    class ImGuiError(Exception): ...

    def IM_ASSERT(condition: bool, msg: str=""):
        """
        Use like `assert`. If the condition is false an `ImGuiError` is raised.
        """
        pass
    
    def IM_CLAMP(n, smallest, largest):
        """
        Returns n clamped to [smallest, largest]
        """
        pass
        
    def load_image(image: Image) -> int:
        """
        Loads a PIL image into ImGui. Returns a texture handle that can be used
        in any `pygui.image` function.
        """
        pass
                           
    # def sizeof(_type) -> int:
    #     """
    #     Placeholder to make the pyi not get upset about sizeof() in cython.
    #     Do not use.
    #     """
    #     pass
    
    '''.lstrip("\n"))

    # __init__.pyi ------------------------------------

    pyi = StringIO()
    pyi.write(base)
    

    for header in modules:
        for enum in header.get_enums():
            longest_enum = 0
            for enum_value in enum.get_elements():
                longest_enum = max(longest_enum, len(enum_value.to_pyi()))
            
            for enum_value in enum.get_elements():
                pyi.write("{}: int".format(enum_value.to_pyi()))
                
                comment_text = enum_value.get_comment().hash_attached_only()
                if comment_text is not None and show_comments:
                    pyi.write(" " * (longest_enum - len(enum_value.to_pyi()) + 5) + comment_text)

                pyi.write("\n")
        pyi.write("\n")
    
    with open("core/templates/function.pyi") as f:
        function_template_base = f.read()
    
    with open("core/templates/class.pyi") as f:
        class_template_base = f.read()
    
    with open("core/templates/field.pyi") as f:
        field_template_base = f.read()
    
    pyi.write(model.to_pyi(
        function_template_base,
        class_template_base,
        field_template_base,
        show_comments
    ))

    return pyi.getvalue()


def to_py(extension_name: str):
    py = textwrap.dedent(f"""
    from .{extension_name} import *

    ImGuiError = {extension_name}.get_imgui_error()
    if ImGuiError is None:
        ImGuiError = AssertionError


    import OpenGL.GL as gl
    from PIL import Image

    # From https://stackoverflow.com/questions/72325672/opengl-doesnt-draw-anything-if-i-use-pil-or-pypng-to-load-textures
    def load_image(image: Image) -> int:
        convert = image.convert("RGBA")
        image_data = convert.tobytes()
        # image_data = convert.transpose(Image.Transpose.FLIP_TOP_BOTTOM).tobytes()
        w = image.width
        h = image.height

        # create the texture in VRAM
        texture: int = int(gl.glGenTextures(1))
        gl.glBindTexture(gl.GL_TEXTURE_2D, texture)

        # configure some texture settings
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_REPEAT) # when you try to reference points beyond the edge of the texture, how should it behave?
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, gl.GL_REPEAT) # in this case, repeat the texture data
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LINEAR) # when you zoom in, how should the new pixels be calculated?
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LINEAR_MIPMAP_LINEAR) # when you zoom out, how should the existing pixels be combined?
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_BASE_LEVEL, 0)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAX_LEVEL, 0)

        # load texture onto the GPU
        gl.glTexImage2D(
            gl.GL_TEXTURE_2D,    # where to load texture data
            0,                   # mipmap level
            gl.GL_RGBA8,         # format to store data in
            w,                   # image dimensions
            h,                   #
            0,                   # border thickness
            gl.GL_RGBA,          # format data is provided in
            gl.GL_UNSIGNED_BYTE, # type to read data as
            image_data
        )          # data to load as texture
        # gl.debug.check_gl_error()

        # generate smaller versions of the texture to save time when its zoomed out
        gl.glGenerateMipmap(gl.GL_TEXTURE_2D)

        # clean up afterwards
        gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
        return texture
    
    """.lstrip("\n"))
    return py


def main():
    def _help():
        print(textwrap.dedent("""
        Usage: python model_creator.py <Option>
        Note: This script expects a file called config.json to exist in the calling directory.
        The config file should contain the constants and backends used by the script.

          --help         Prints this
          --trial        Attempts to merge the old/new/template content but writes the result to
                           core_trial.pyx only.
          --all          Typical usage. Builds the pxd/pyx/pyi file. The merged file is written
                           to core.pyx.
          --pxd          Builds the pxd file only.
          --pyx          Builds the pyx file only.
          --pyi          Builds the pyi file only.
          --nocomments   Builds files without comments included.
          --reset        Creates a new template to manually modify pxy files with. This will not
                           complete if a template stil exists. You must delete core_template.pyx
                           yourself.
        """.lstrip("\n")))
        return

    def trial_pyx(modules: List[IBinding], pxd_libary_name: str):
        new_pyx = ""
        for i, header in enumerate(modules):
            new_pyx += header.to_pyx(pxd_libary_name, i == 0)

        try:
            with open(GENERATED_PYX_PATH) as f:
                old_pyx = f.read()
        except FileNotFoundError:
            print(f"Trial: '{GENERATED_PYX_PATH}' not found. Using new generated content as the old.")
            old_pyx = new_pyx

        try:
            with open(TEMPLATE_PYX_PATH) as f:
                template_pyx = f.read()
        except FileNotFoundError:
            print(f"Trial: '{TEMPLATE_PYX_PATH}' not found. Aborting. Use --reset first ")
            return

        try:
            merge_result = MergeResult(old_pyx, new_pyx, template_pyx)
        except MergeFailed:
            print("Trial: Merge failed. Aborting.")
            return
        
        with open(GENERATED_PYX_TRIAL_PATH, "w") as f:
            f.write(merge_result.new_pyx)
        with open(PYX_TRIAL_PATH, "w") as f:
            f.write(merge_result.merged_pyx)
        with open(TEMPLATE_PYX_TRIAL_PATH, "w") as f:
            f.write(merge_result.merged_pyx_all_active)
        print(f"Created {PYX_TRIAL_PATH}")
        print(f"Created {TEMPLATE_PYX_TRIAL_PATH}")
        # return

    def reset(modules: List[IBinding], pxd_libary_name: str):
        new_pyx = ""
        for i, header in enumerate(modules):
            new_pyx += header.to_pyx(pxd_libary_name, i == 0)
        
        new_model = create_pyx_model(new_pyx)
        try:
            with open(TEMPLATE_PYX_PATH) as f:
                print(f"Error: Template '{TEMPLATE_PYX_PATH}' still exists.")
                print("Please delete the file manually if you are sure.")
                return
        except FileNotFoundError:
            with open(PYX_PATH, "w") as f:
                f.write(replace_after(
                    new_pyx,
                    PYX_TEMPLATE_MARKER,
                    new_model.as_pyx()
                ))
            with open(TEMPLATE_PYX_PATH, "w") as f:
                f.write(replace_after(
                    new_pyx,
                    PYX_TEMPLATE_MARKER,
                    new_model.as_pyx(ignore_active_flag=True)
                ))
            print(f"Created {PYX_PATH}")
            print(f"Created {TEMPLATE_PYX_PATH}")

    def write_pxd(modules: List[IBinding]):
        pxd = ""
        for i, header in enumerate(modules):
            pxd += header.to_pxd(i == 0)
        
        with open(CIMGUI_PXD_PATH, "w") as f:
            f.write(pxd)
        print(f"Created {CIMGUI_PXD_PATH}")
    
    def write_pyx(modules: List[IBinding], pxd_libary_name: str):
        new_pyx = ""
        for i, header in enumerate(modules):
            new_pyx += header.to_pyx(pxd_libary_name, i == 0)

        try:
            with open(GENERATED_PYX_PATH) as f:
                old_pyx = f.read()
        except FileNotFoundError:
            print(f"'{GENERATED_PYX_PATH}' not found. Using new generated content as the old.")
            old_pyx = new_pyx

        try:
            with open(TEMPLATE_PYX_PATH) as f:
                template_pyx = f.read()
        except FileNotFoundError:
            print(f"'{TEMPLATE_PYX_PATH}' not found. Aborting. Use --reset first ")
            return
        
        try:
            merge_result = MergeResult(old_pyx, new_pyx, template_pyx)
        except MergeFailed:
            print("Merge failed. Aborting.")
            return

        with open(GENERATED_PYX_PATH, "w") as f:
            f.write(merge_result.new_pyx)
        with open(PYX_PATH, "w") as f:
            f.write(merge_result.merged_pyx)
        with open(TEMPLATE_PYX_PATH, "w") as f:
            f.write(merge_result.merged_pyx_all_active)
        print(f"Created {GENERATED_PYX_PATH}")
        print(f"Created {PYX_PATH}")
        print(f"Created {TEMPLATE_PYX_PATH}")
    
    def write_pyi(modules: List[IBinding], extension_name: str, show_comments: bool):
        try:
            with open(TEMPLATE_PYX_PATH) as f:
                model = create_pyx_model(f.read())
        except FileNotFoundError:
            print(f"'{TEMPLATE_PYX_PATH}' not found. This is required to create the pyi file")
            return
        
        pyi = to_pyi(modules, model, show_comments)
        py = to_py(extension_name)

        with open(INIT_PYI_PATH, "w") as f:
            f.write(pyi)
        with open(INIT_PY_PATH, "w") as f:
            f.write(py)
        print(f"Created {INIT_PYI_PATH}")
        print(f"Created {INIT_PY_PATH}")
        pass

    if len(sys.argv) < 2:
        _help()
        return
    
    show_comments = "--nocomments" not in sys.argv

    if "--help" in sys.argv:
        _help()
        return
    
    if "--trial" in sys.argv:
        trial_pyx(modules, CIMGUI_LIBRARY_NAME)
        return
    
    if "--reset" in sys.argv:
        reset(modules, CIMGUI_LIBRARY_NAME)
        return

    if "--pxd" in sys.argv:
        write_pxd(modules)
        return
    
    if "--pyx" in sys.argv:
        write_pyx(modules, CIMGUI_LIBRARY_NAME)
        return

    if "--pyi" in sys.argv:
        write_pyi(modules, EXTENSION_NAME, show_comments)
        return
    
    if "--all" in sys.argv:
        write_pxd(modules)
        write_pyx(modules, CIMGUI_LIBRARY_NAME)
        write_pyi(modules, EXTENSION_NAME, show_comments)
        return


if __name__ == "__main__":
    main()