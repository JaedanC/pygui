import pygui
import glfw
import OpenGL.GL as gl

from python_demo_window import pygui_demo_window

show_another_window = pygui.BoolPtr(True)

def render():
    global show_another_window

    pygui.show_demo_window()
    
    pygui.begin("Hello, World!")
    pygui.text("Some text")
    pygui.progress_bar(0.25, (-pygui.FLT_MIN, 0), None)
    pygui.progress_bar(0.75, (-pygui.FLT_MIN, 0), "Hello")
    pygui.end()


    if show_another_window:
        pygui.begin("Another window", show_another_window)
        pygui.text("Some text")
        pygui.end()

    pygui.begin("Pygui Demo Window", None)
    # pygui.begin("Pygui Demo Window", None, pygui.IMGUI_WINDOW_FLAGS_NO_MOVE)
    pygui_demo_window()
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
    io.config_flags |= pygui.CONFIG_FLAGS_NAV_ENABLE_KEYBOARD
    io.config_flags |= pygui.CONFIG_FLAGS_NAV_ENABLE_GAMEPAD
    io.config_flags |= pygui.CONFIG_FLAGS_DOCKING_ENABLE
    io.config_flags |= pygui.CONFIG_FLAGS_VIEWPORTS_ENABLE

    pygui.impl_glfw_init_for_open_gl(window, True)
    # pygui.impl_open_gl_3_init("#version 130")
    pygui.impl_open_gl_3_init()

    # Check opengl version
    print("Opengl version: {}".format(gl.glGetString(gl.GL_VERSION).decode()))
    print("glfw version: {}.{}.{}".format(glfw.VERSION_MAJOR, glfw.VERSION_MINOR, glfw.VERSION_REVISION))
    print("ImGui version: {}".format(pygui.get_version()))

    # Try out different styles
    pygui.style_colors_dark()
    # pygui.style_colors_light()
    # pygui.style_colors_classic()
    clear_color = (0.45, 0.55, 0.6, 1.0)

    try:
        while not glfw.window_should_close(window):
            glfw.poll_events()
            pygui.impl_open_gl_3_new_frame()
            pygui.impl_glfw_new_frame()
            pygui.new_frame()

            render()
            
            pygui.render()
            glfw.make_context_current(window)
            
            gl.glViewport(0, 0, int(io.display_size[0]), int(io.display_size[1]))
            gl.glClearColor(clear_color[0], clear_color[1], clear_color[2], clear_color[3])
            gl.glClear(gl.GL_COLOR_BUFFER_BIT)

            draw_data = pygui.get_draw_data()
            pygui.impl_open_gl_3_render_draw_data(draw_data)

            if io.config_flags & pygui.CONFIG_FLAGS_VIEWPORTS_ENABLE:
                backup_current_window = glfw.get_current_context()
                pygui.update_platform_windows()
                pygui.render_platform_windows_default()
                glfw.make_context_current(backup_current_window)
            
            glfw.swap_buffers(window)
    except KeyboardInterrupt:
        pass
    
    pygui.impl_open_gl_3_shutdown()
    pygui.impl_glfw_shutdown()
    pygui.destroy_context()
    glfw.destroy_window(window)
    glfw.terminate()


if __name__ == "__main__":
    main()
