# -*- coding: utf-8 -*-
from __future__ import absolute_import

import glfw
import pygui

from . import compute_fb_scale
from .opengl import ProgrammablePipelineRenderer

class GlfwRenderer(ProgrammablePipelineRenderer):
    def __init__(self, window, attach_callbacks=True):
        super(GlfwRenderer, self).__init__()
        self.window = window

        if attach_callbacks:
            glfw.set_key_callback(self.window, self.keyboard_callback)
            glfw.set_cursor_pos_callback(self.window, self.mouse_callback)
            glfw.set_window_size_callback(self.window, self.resize_callback)
            glfw.set_char_callback(self.window, self.char_callback)
            glfw.set_scroll_callback(self.window, self.scroll_callback)

        self.io.display_size = glfw.get_framebuffer_size(self.window)
        self.io.get_clipboard_text_fn = self._get_clipboard_text
        self.io.set_clipboard_text_fn = self._set_clipboard_text

        self._map_keys()
        self._gui_time = None

    def _get_clipboard_text(self):
        return glfw.get_clipboard_string(self.window)

    def _set_clipboard_text(self, text):
        glfw.set_clipboard_string(self.window, text)

    def _map_keys(self):
        key_map = self.io.key_map

        key_map[pygui.IMGUI_KEY_TAB] = glfw.KEY_TAB
        key_map[pygui.IMGUI_KEY_LEFT_ARROW] = glfw.KEY_LEFT
        key_map[pygui.IMGUI_KEY_RIGHT_ARROW] = glfw.KEY_RIGHT
        key_map[pygui.IMGUI_KEY_UP_ARROW] = glfw.KEY_UP
        key_map[pygui.IMGUI_KEY_DOWN_ARROW] = glfw.KEY_DOWN
        key_map[pygui.IMGUI_KEY_PAGE_UP] = glfw.KEY_PAGE_UP
        key_map[pygui.IMGUI_KEY_PAGE_DOWN] = glfw.KEY_PAGE_DOWN
        key_map[pygui.IMGUI_KEY_HOME] = glfw.KEY_HOME
        key_map[pygui.IMGUI_KEY_END] = glfw.KEY_END
        key_map[pygui.IMGUI_KEY_DELETE] = glfw.KEY_DELETE
        key_map[pygui.IMGUI_KEY_BACKSPACE] = glfw.KEY_BACKSPACE
        key_map[pygui.IMGUI_KEY_ENTER] = glfw.KEY_ENTER
        key_map[pygui.IMGUI_KEY_ESCAPE] = glfw.KEY_ESCAPE
        key_map[pygui.IMGUI_KEY_A] = glfw.KEY_A
        key_map[pygui.IMGUI_KEY_C] = glfw.KEY_C
        key_map[pygui.IMGUI_KEY_V] = glfw.KEY_V
        key_map[pygui.IMGUI_KEY_X] = glfw.KEY_X
        key_map[pygui.IMGUI_KEY_Y] = glfw.KEY_Y
        key_map[pygui.IMGUI_KEY_Z] = glfw.KEY_Z

        key_map2 = {
            # GLFW_KEY_UNKNOWN: pygui.KEY_UN
            # GLFW_KEY_SPACE: 
            # GLFW_KEY_APOSTROPHE: 
            # GLFW_KEY_COMMA: 
            # GLFW_KEY_MINUS: 
            # GLFW_KEY_PERIOD: 
            # GLFW_KEY_SLASH: 
            # GLFW_KEY_0: 
            # GLFW_KEY_1: 
            # GLFW_KEY_2: 
            # GLFW_KEY_3: 
            # GLFW_KEY_4: 
            # GLFW_KEY_5: 
            # GLFW_KEY_6: 
            # GLFW_KEY_7: 
            # GLFW_KEY_8: 
            # GLFW_KEY_9: 
            # GLFW_KEY_SEMICOLON: 
            # GLFW_KEY_EQUAL: 
            # GLFW_KEY_A: 
            # GLFW_KEY_B: 
            # GLFW_KEY_C: 
            # GLFW_KEY_D: 
            # GLFW_KEY_E: 
            # GLFW_KEY_F: 
            # GLFW_KEY_G: 
            # GLFW_KEY_H: 
            # GLFW_KEY_I: 
            # GLFW_KEY_J: 
            # GLFW_KEY_K: 
            # GLFW_KEY_L: 
            # GLFW_KEY_M: 
            # GLFW_KEY_N: 
            # GLFW_KEY_O: 
            # GLFW_KEY_P: 
            # GLFW_KEY_Q: 
            # GLFW_KEY_R: 
            # GLFW_KEY_S: 
            # GLFW_KEY_T: 
            # GLFW_KEY_U: 
            # GLFW_KEY_V: 
            # GLFW_KEY_W: 
            # GLFW_KEY_X: 
            # GLFW_KEY_Y: 
            # GLFW_KEY_Z: 
            # GLFW_KEY_LEFT_BRACKET: 
            # GLFW_KEY_BACKSLASH: 
            # GLFW_KEY_RIGHT_BRACKET: 
            # GLFW_KEY_GRAVE_ACCENT: 
            # GLFW_KEY_WORLD_1: 
            # GLFW_KEY_WORLD_2: 
            # GLFW_KEY_ESCAPE: 
            # GLFW_KEY_ENTER: 
            # GLFW_KEY_TAB: 
            # GLFW_KEY_BACKSPACE: 
            # GLFW_KEY_INSERT: 
            # GLFW_KEY_DELETE: 
            # GLFW_KEY_RIGHT: 
            # GLFW_KEY_LEFT: 
            # GLFW_KEY_DOWN: 
            # GLFW_KEY_UP: 
            # GLFW_KEY_PAGE_UP: 
            # GLFW_KEY_PAGE_DOWN: 
            # GLFW_KEY_HOME: 
            # GLFW_KEY_END: 
            # GLFW_KEY_CAPS_LOCK: 
            # GLFW_KEY_SCROLL_LOCK: 
            # GLFW_KEY_NUM_LOCK: 
            # GLFW_KEY_PRINT_SCREEN: 
            # GLFW_KEY_PAUSE: 
            # GLFW_KEY_F1: 
            # GLFW_KEY_F2: 
            # GLFW_KEY_F3: 
            # GLFW_KEY_F4: 
            # GLFW_KEY_F5: 
            # GLFW_KEY_F6: 
            # GLFW_KEY_F7: 
            # GLFW_KEY_F8: 
            # GLFW_KEY_F9: 
            # GLFW_KEY_F10: 
            # GLFW_KEY_F11: 
            # GLFW_KEY_F12: 
            # GLFW_KEY_F13: 
            # GLFW_KEY_F14: 
            # GLFW_KEY_F15: 
            # GLFW_KEY_F16: 
            # GLFW_KEY_F17: 
            # GLFW_KEY_F18: 
            # GLFW_KEY_F19: 
            # GLFW_KEY_F20: 
            # GLFW_KEY_F21: 
            # GLFW_KEY_F22: 
            # GLFW_KEY_F23: 
            # GLFW_KEY_F24: 
            # GLFW_KEY_F25: 
            # GLFW_KEY_KP_0: 
            # GLFW_KEY_KP_1: 
            # GLFW_KEY_KP_2: 
            # GLFW_KEY_KP_3: 
            # GLFW_KEY_KP_4: 
            # GLFW_KEY_KP_5: 
            # GLFW_KEY_KP_6: 
            # GLFW_KEY_KP_7: 
            # GLFW_KEY_KP_8: 
            # GLFW_KEY_KP_9: 
            # GLFW_KEY_KP_DECIMAL: 
            # GLFW_KEY_KP_DIVIDE: 
            # GLFW_KEY_KP_MULTIPLY: 
            # GLFW_KEY_KP_SUBTRACT: 
            # GLFW_KEY_KP_ADD: 
            # GLFW_KEY_KP_ENTER: 
            # GLFW_KEY_KP_EQUAL: 
            # GLFW_KEY_LEFT_SHIFT: 
            # GLFW_KEY_LEFT_CONTROL: 
            # GLFW_KEY_LEFT_ALT: 
            # GLFW_KEY_LEFT_SUPER: 
            # GLFW_KEY_RIGHT_SHIFT: 
            # GLFW_KEY_RIGHT_CONTROL: 
            # GLFW_KEY_RIGHT_ALT: 
            # GLFW_KEY_RIGHT_SUPER: 
            # GLFW_KEY_MENU: 
        }

    def keyboard_callback(self, window, key, scancode, action, mods):
        # perf: local for faster access
        io = self.io

        if action == glfw.PRESS:
            io.keys_down[key] = True
        elif action == glfw.RELEASE:
            io.keys_down[key] = False

        io.key_ctrl = (
            io.keys_down[glfw.KEY_LEFT_CONTROL] or
            io.keys_down[glfw.KEY_RIGHT_CONTROL]
        )

        io.key_alt = (
            io.keys_down[glfw.KEY_LEFT_ALT] or
            io.keys_down[glfw.KEY_RIGHT_ALT]
        )

        io.key_shift = (
            io.keys_down[glfw.KEY_LEFT_SHIFT] or
            io.keys_down[glfw.KEY_RIGHT_SHIFT]
        )

        io.key_super = (
            io.keys_down[glfw.KEY_LEFT_SUPER] or
            io.keys_down[glfw.KEY_RIGHT_SUPER]
        )

    def char_callback(self, window, char):
        io = pygui.get_io()

        if 0 < char < 0x10000:
            io.add_input_character(char)

    def resize_callback(self, window, width, height):
        self.io.display_size = width, height

    def mouse_callback(self, *args, **kwargs):
        pass

    def scroll_callback(self, window, x_offset, y_offset):
        self.io.mouse_wheelh = x_offset
        self.io.mouse_wheel = y_offset

    def process_inputs(self):
        io = pygui.get_io()

        window_size = glfw.get_window_size(self.window)
        fb_size = glfw.get_framebuffer_size(self.window)

        io.display_size = window_size
        io.display_framebuffer_scale = compute_fb_scale(window_size, fb_size)
        io.delta_time = 1.0/60

        if glfw.get_window_attrib(self.window, glfw.FOCUSED):
            io.mouse_pos = glfw.get_cursor_pos(self.window)
        else:
            io.mouse_pos = -1, -1

        io.mouse_down[0] = glfw.get_mouse_button(self.window, 0)
        io.mouse_down[1] = glfw.get_mouse_button(self.window, 1)
        io.mouse_down[2] = glfw.get_mouse_button(self.window, 2)

        current_time = glfw.get_time()

        if self._gui_time:
            self.io.delta_time = current_time - self._gui_time
        else:
            self.io.delta_time = 1. / 60.

        self._gui_time = current_time
