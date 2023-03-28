import glfw
import pygui
import sys

import OpenGL.GL as gl
from pygui.integrations.glfw import GlfwRenderer

is_open = pygui.BoolPtr(True)

def render_frame(impl, window):
    glfw.poll_events()
    impl.process_inputs()

    pygui.new_frame()

    gl.glClearColor(0.1, 0.1, 0.1, 1)
    gl.glClear(gl.GL_COLOR_BUFFER_BIT)

    pygui.show_demo_window()
    pygui.show_user_guide()

    io: pygui.ImGuiIO = pygui.get_io()
    global is_open
    if is_open and pygui.begin("FPS Window", is_open):
        pygui.text("Dear ImGui {}".format(pygui.get_version()))
        pygui.text("Application average {:.2f} ms/frame ({:.2f} FPS)".format(1000 / io.framerate, io.framerate))
        pygui.end()

    pygui.render()
    impl.render(pygui.get_draw_data())
    glfw.swap_buffers(window)


def impl_glfw_init():
    width, height = 1600, 900
    window_name = "minimal core/GLFW3 example"

    if not glfw.init():
        print("Could not initialize OpenGL context")
        sys.exit(1)

    glfw.window_hint(glfw.CONTEXT_VERSION_MAJOR, 3)
    glfw.window_hint(glfw.CONTEXT_VERSION_MINOR, 3)
    glfw.window_hint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
    glfw.window_hint(glfw.OPENGL_FORWARD_COMPAT, gl.GL_TRUE)

    window = glfw.create_window(int(width), int(height), window_name, None, None)
    glfw.make_context_current(window)
    glfw.swap_interval(1)

    if not window:
        glfw.terminate()
        print("Could not initialize Window")
        sys.exit(1)

    return window


def main():
    ctx = pygui.create_context()
    window = impl_glfw_init()

    impl = GlfwRenderer(window)

    io: pygui.ImGuiIO = pygui.get_io()
    impl.refresh_font_texture()

    while not glfw.window_should_close(window):
        render_frame(impl, window)

    impl.shutdown()
    glfw.terminate()
    pygui.destroy_context(ctx)


if __name__ == "__main__":
    main()
