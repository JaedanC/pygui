import pygui
import glfw
import OpenGL.GL as gl
import inspect


show_demo_window = pygui.BoolPtr(True)
show_another_window = pygui.BoolPtr(False)
quit = pygui.BoolPtr(False)
clicked = 0



class StaticVarCls(object):
    def __init__(self):
        super().__setattr__("__static_vars_lookup", {})

    def __getattribute__(self, __name):
        try:
            return super().__getattribute__(__name)
        except AttributeError:
            pass
        
        __name = __name + "." + inspect.stack(1)[1].function
        if __name not in super().__getattribute__("__static_vars_lookup"):
            raise AttributeError
        
        return super().__getattribute__("__static_vars_lookup")[__name]
    
    def __setattr__(self, __name: str, __value):
        __name = __name + "." + inspect.stack(1)[1].function
        super().__getattribute__("__static_vars_lookup")[__name] = __value
        
    def new(self, __name, __value):
        __name = __name + "." + inspect.stack(1)[1].function
        if __name not in super().__getattribute__("__static_vars_lookup"):
            super().__getattribute__("__static_vars_lookup")[__name] = __value
            print(f"Creating static: {__name}: {__value}")


static = StaticVarCls()

def show_demo_window_widgets():
    global static

    if not pygui.collapsing_header_bool_ptr("Widgets"):
        return
    
    if pygui.tree_node_str("Basic"):
        pygui.separator_text("General")

        # static.new("clicked", 0)
        # if pygui.button("Button"):
        #     static.clicked += 1
        
        # if static.clicked & 1:
        #     pygui.same_line()
        #     pygui.text("Thanks for clicking me!")
        
        # static.new("check", pygui.BoolPtr(True))
        # pygui.checkbox("checkbox", static.check)

        pygui.tree_pop()


def render():
    global show_demo_window
    global show_another_window

    if show_demo_window:
        pygui.show_demo_window()
    
    pygui.begin("Hello, World!")
    pygui.text("Some text")
    pygui.end()

    if show_another_window:
        pygui.begin("Another window")
        pygui.text("Some text")
        pygui.end()

    pygui.begin("Python Widgets")
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
    glfw.swap_interval(0)

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
