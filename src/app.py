import pygui
import glfw
import OpenGL.GL as gl
import inspect

# For imgui
import math
import time


class static:
    render_show_demo_window = pygui.BoolPtr(True)
    render_show_another_window = pygui.BoolPtr(False)

    widgets_clicked = 0
    widgets_check = pygui.BoolPtr(True)
    widgets_e = pygui.IntPtr(0)
    widgets_counter = 0
    widgets_str0 = pygui.StrPtr("Hello, World!", 128)
    widgets_str1 = pygui.StrPtr("", 128)
    widgets_i0 = pygui.IntPtr(123)
    widgets_f0 = pygui.FloatPtr(0.001)
    widgets_d0 = pygui.DoublePtr(999999.00000001)
    widgets_f1 = pygui.FloatPtr(1.e10)
    widgets_vec4a = [
        pygui.FloatPtr(0.1),
        pygui.FloatPtr(0.2),
        pygui.FloatPtr(0.3),
        pygui.FloatPtr(0.44)
    ]
    widgets_drag_i1 = pygui.IntPtr(50)
    widgets_drag_i2 = pygui.IntPtr(42)
    widgets_drag_f1 = pygui.FloatPtr(1.00)
    widgets_drag_f2 = pygui.FloatPtr(0.0067)



def help_marker(desc: str):
    pygui.text_disabled("(?)")
    if pygui.is_item_hovered(pygui.IMGUI_HOVERED_FLAGS_DELAY_SHORT) and pygui.begin_tooltip():
        pygui.push_text_wrap_pos(pygui.get_font_size() * 35)
        pygui.text_unformatted(desc)
        pygui.pop_text_wrap_pos()
        pygui.end_tooltip()


def show_demo_window_widgets():
    if not pygui.collapsing_header("Widgets"):
        return
    
    if pygui.tree_node("Basic"):
        pygui.separator_text("General")

        if pygui.button("Button"):
            static.widgets_clicked += 1
        
        if static.widgets_clicked & 1:
            pygui.same_line()
            pygui.text("Thanks for clicking me!")
        
        pygui.checkbox("checkbox", static.widgets_check)

        pygui.radio_button("radio a", static.widgets_e, 0)
        pygui.same_line()
        pygui.radio_button("radio b", static.widgets_e, 1)
        pygui.same_line()
        pygui.radio_button("radio c", static.widgets_e, 2)
        
        # Color buttons, demonstrate using PushID() to add unique identifier in the ID stack, and changing style.
        for i in range(6):
            if i > 0:
                pygui.same_line()
            
            pygui.push_id_int(i)
            pygui.push_style_color_vec4(pygui.IMGUI_COL_BUTTON,         pygui.ImColor.hsv(i / 7, 0.6, 0.6))
            pygui.push_style_color_vec4(pygui.IMGUI_COL_BUTTON_HOVERED, pygui.ImColor.hsv(i / 7, 0.7, 0.7))
            pygui.push_style_color_vec4(pygui.IMGUI_COL_BUTTON_ACTIVE,  pygui.ImColor.hsv(i / 7, 0.8, 0.8))
            pygui.button("Click")
            pygui.pop_style_color(3)
            pygui.pop_id()
        
        # Use AlignTextToFramePadding() to align text baseline to the baseline of framed widgets elements
        # (otherwise a Text+SameLine+Button sequence will have the text a little too high by default!)
        # See 'Demo->Layout->Text Baseline Alignment' for details.
        pygui.align_text_to_frame_padding()
        pygui.text("Hold to repeat:")
        pygui.same_line()

        spacing: float = pygui.get_style().item_inner_spacing.x
        pygui.push_button_repeat(True)
        if pygui.arrow_button("##left", pygui.IMGUI_DIR_LEFT):
            static.widgets_counter -= 1
        pygui.same_line(0, spacing)
        if pygui.arrow_button("##right", pygui.IMGUI_DIR_RIGHT):
            static.widgets_counter += 1
        pygui.pop_button_repeat()
        pygui.same_line()
        pygui.text(str(static.widgets_counter))

        # Tooltips

        pygui.text("Tooltips:")
        pygui.same_line()
        pygui.small_button("Button")
        if pygui.is_item_hovered():
            pygui.set_tooltip("I am a tooltip")
        
        pygui.same_line()
        pygui.small_button("Fancy")
        if pygui.is_item_hovered() and pygui.begin_tooltip():
            pygui.text("I am a fancy tooltip")
            arr = [0.6, 0.1, 1.0, 0.5, 0.92, 0.1, 0.2]
            pygui.plot_lines("Curve", arr)
            pygui.text("Sin(time) = {}".format(math.sin(time.time())))
            pygui.end_tooltip()
        
        pygui.same_line()
        pygui.small_button("Delayed")
        if pygui.is_item_hovered(pygui.IMGUI_HOVERED_FLAGS_DELAY_NORMAL):
            pygui.set_tooltip("I am a tooltip with a delay")
        
        pygui.same_line()
        help_marker("Tooltip are created by using the IsItemHovered() function over any kind of item.")

        pygui.label_text("label", "Value")

        pygui.separator_text("Inputs")

        pygui.input_text("input text", static.widgets_str0)
        pygui.same_line()
        help_marker("USER:\n"
            "Hold SHIFT or use mouse to select text.\n"
            "CTRL+Left/Right to word jump.\n"
            "CTRL+A or Double-Click to select all.\n"
            "CTRL+X,CTRL+C,CTRL+V clipboard.\n"
            "CTRL+Z,CTRL+Y undo/redo.\n"
            "ESCAPE to revert.\n\n"
            "PROGRAMMER:\n"
            "You can use the ImGuiInputTextFlags_CallbackResize facility if you need to wire InputText() "
            "to a dynamic string type. See misc/cpp/imgui_stdlib.h for an example (this is not demonstrated "
            "in imgui_demo.cpp)."
        )

        pygui.input_text_with_hint("input text (w/ hint)", "enter text here", static.widgets_str1)
        pygui.input_int("input int", static.widgets_i0)
        pygui.input_float("input float", static.widgets_f0, 0.01, 1.0, "%.3f")
        pygui.input_double("input double", static.widgets_d0, 0.01, 1.0, "%.8f")
        pygui.input_float("input scientific", static.widgets_f1, 0, 0, "%e")
        pygui.input_float2("input float2", static.widgets_vec4a)
        pygui.input_float3("input float3", static.widgets_vec4a)
        pygui.input_float4("input float4", static.widgets_vec4a)

        pygui.separator_text("Drags")

        pygui.drag_int("drag int", static.widgets_drag_i1, 1)
        pygui.same_line()
        help_marker(
            "Click and drag to edit value.\n"
            "Hold SHIFT/ALT for faster/slower edit.\n"
            "Double-click or CTRL+click to input value."
        )
        pygui.drag_int("drag int 0..100", static.widgets_drag_i2, 1, 0, 100, "%d%%", pygui.IMGUI_SLIDER_FLAGS_ALWAYS_CLAMP)
        pygui.drag_float("drag float", static.widgets_drag_f1, 0.005)
        pygui.drag_float("drag small float", static.widgets_drag_f2, 0.0001, 0, 0, "%.06f ns")

        pygui.tree_pop()


def render():
    if static.render_show_demo_window:
        pygui.show_demo_window()
    
    pygui.begin("Hello, World!")
    pygui.text("Some text")
    pygui.end()

    if static.render_show_another_window:
        pygui.begin("Another window")
        pygui.text("Some text")
        pygui.end()

    pygui.begin("Python Widgets", None, pygui.IMGUI_WINDOW_FLAGS_NO_MOVE)
    show_demo_window_widgets()
    pygui.end()


def main():
    if not glfw.init():
        return

    glfw.window_hint(glfw.OPENGL_FORWARD_COMPAT, glfw.TRUE)
    glfw.window_hint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
    glfw.window_hint(glfw.CONTEXT_VERSION_MAJOR, 3)
    glfw.window_hint(glfw.CONTEXT_VERSION_MINOR, 2)
    glfw.window_hint(glfw.RESIZABLE, glfw.TRUE)

    window = glfw.create_window(1024, 768, "Hello World!", None, None)
    if window is None:
       print("Failed to create window! Terminating")
       glfw.terminate()
       return
    
    glfw.make_context_current(window)

    # Vsync:
    # 1: On
    # 0: Off
    glfw.swap_interval(1)

    # Setup imgui
    pygui.create_context()

    # Setup config flags
    io = pygui.get_io()
    io.config_flags |= pygui.IMGUI_CONFIG_FLAGS_NAV_ENABLE_KEYBOARD
    io.config_flags |= pygui.IMGUI_CONFIG_FLAGS_NAV_ENABLE_GAMEPAD
    io.config_flags |= pygui.IMGUI_CONFIG_FLAGS_DOCKING_ENABLE
    io.config_flags |= pygui.IMGUI_CONFIG_FLAGS_VIEWPORTS_ENABLE

    pygui.impl_glfw_init_for_open_gl(window, True)
    pygui.impl_open_gl3_init("#version 130")

    # Check opengl version
    print("Opengl version: {}".format(gl.glGetString(gl.GL_VERSION).decode()))
    print("glfw version: {}.{}.{}".format(glfw.VERSION_MAJOR, glfw.VERSION_MINOR, glfw.VERSION_REVISION))

    # Not sure why this crashes imgui
    # pygui.style_colors_dark()
    clear_color = (0.45, 0.55, 0.6, 1.0)

    try:
        while not glfw.window_should_close(window):
            glfw.poll_events()
            pygui.impl_open_gl3_new_frame()
            pygui.impl_glfw_new_frame()
            pygui.new_frame()

            render()
            
            pygui.render()
            glfw.make_context_current(window)
            
            gl.glViewport(0, 0, int(io.display_size.x), int(io.display_size.y))
            gl.glClearColor(clear_color[0], clear_color[1], clear_color[2], clear_color[3])
            gl.glClear(gl.GL_COLOR_BUFFER_BIT)

            draw_data = pygui.get_draw_data()
            pygui.impl_open_gl3_render_draw_data(draw_data)

            if io.config_flags & pygui.IMGUI_CONFIG_FLAGS_VIEWPORTS_ENABLE:
                backup_current_window = glfw.get_current_context()
                pygui.update_platform_windows()
                pygui.render_platform_windows_default()
                glfw.make_context_current(backup_current_window)
            
            glfw.swap_buffers(window)
    except KeyboardInterrupt:
        pass
    
    pygui.impl_open_gl3_shutdown()
    pygui.impl_glfw_shutdown()
    pygui.destroy_context()
    glfw.destroy_window(window)
    glfw.terminate()


if __name__ == "__main__":
    main()
