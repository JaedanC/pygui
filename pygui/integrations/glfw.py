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
            glfw.set_cursor_pos_callback(self.window, self.mouse_movement_callback)
            glfw.set_mouse_button_callback(self.window, self.mouse_click_callback)
            glfw.set_scroll_callback(self.window, self.scroll_callback)
            glfw.set_window_size_callback(self.window, self.resize_callback)

        self.io.display_size = glfw.get_framebuffer_size(self.window)
        self.io.get_clipboard_text_fn = self._get_clipboard_text
        self.io.set_clipboard_text_fn = self._set_clipboard_text

        self._map_keyboard_and_mouse()
        self._gui_time = None

    def _get_clipboard_text(self):
        return glfw.get_clipboard_string(self.window)

    def _set_clipboard_text(self, text):
        glfw.set_clipboard_string(self.window, text)

    def _map_keyboard_and_mouse(self):
        self.key_map = {
            glfw.KEY_SPACE:         pygui.IMGUI_KEY_SPACE,
            glfw.KEY_APOSTROPHE:    pygui.IMGUI_KEY_APOSTROPHE,
            glfw.KEY_COMMA:         pygui.IMGUI_KEY_COMMA,
            glfw.KEY_MINUS:         pygui.IMGUI_KEY_MINUS,
            glfw.KEY_PERIOD:        pygui.IMGUI_KEY_PERIOD,
            glfw.KEY_SLASH:         pygui.IMGUI_KEY_SLASH,
            glfw.KEY_0:             pygui.IMGUI_KEY_0,
            glfw.KEY_1:             pygui.IMGUI_KEY_1,
            glfw.KEY_2:             pygui.IMGUI_KEY_2,
            glfw.KEY_3:             pygui.IMGUI_KEY_3,
            glfw.KEY_4:             pygui.IMGUI_KEY_4,
            glfw.KEY_5:             pygui.IMGUI_KEY_5,
            glfw.KEY_6:             pygui.IMGUI_KEY_6,
            glfw.KEY_7:             pygui.IMGUI_KEY_7,
            glfw.KEY_8:             pygui.IMGUI_KEY_8,
            glfw.KEY_9:             pygui.IMGUI_KEY_9,
            glfw.KEY_SEMICOLON:     pygui.IMGUI_KEY_SEMICOLON,
            glfw.KEY_EQUAL:         pygui.IMGUI_KEY_EQUAL,
            glfw.KEY_A:             pygui.IMGUI_KEY_A,
            glfw.KEY_B:             pygui.IMGUI_KEY_B,
            glfw.KEY_C:             pygui.IMGUI_KEY_C,
            glfw.KEY_D:             pygui.IMGUI_KEY_D,
            glfw.KEY_E:             pygui.IMGUI_KEY_E,
            glfw.KEY_F:             pygui.IMGUI_KEY_F,
            glfw.KEY_G:             pygui.IMGUI_KEY_G,
            glfw.KEY_H:             pygui.IMGUI_KEY_H,
            glfw.KEY_I:             pygui.IMGUI_KEY_I,
            glfw.KEY_J:             pygui.IMGUI_KEY_J,
            glfw.KEY_K:             pygui.IMGUI_KEY_K,
            glfw.KEY_L:             pygui.IMGUI_KEY_L,
            glfw.KEY_M:             pygui.IMGUI_KEY_M,
            glfw.KEY_N:             pygui.IMGUI_KEY_N,
            glfw.KEY_O:             pygui.IMGUI_KEY_O,
            glfw.KEY_P:             pygui.IMGUI_KEY_P,
            glfw.KEY_Q:             pygui.IMGUI_KEY_Q,
            glfw.KEY_R:             pygui.IMGUI_KEY_R,
            glfw.KEY_S:             pygui.IMGUI_KEY_S,
            glfw.KEY_T:             pygui.IMGUI_KEY_T,
            glfw.KEY_U:             pygui.IMGUI_KEY_U,
            glfw.KEY_V:             pygui.IMGUI_KEY_V,
            glfw.KEY_W:             pygui.IMGUI_KEY_W,
            glfw.KEY_X:             pygui.IMGUI_KEY_X,
            glfw.KEY_Y:             pygui.IMGUI_KEY_Y,
            glfw.KEY_Z:             pygui.IMGUI_KEY_Z,
            glfw.KEY_LEFT_BRACKET:  pygui.IMGUI_KEY_LEFT_BRACKET,
            glfw.KEY_BACKSLASH:     pygui.IMGUI_KEY_BACKSLASH,
            glfw.KEY_RIGHT_BRACKET: pygui.IMGUI_KEY_RIGHT_BRACKET,
            glfw.KEY_GRAVE_ACCENT:  pygui.IMGUI_KEY_GRAVE_ACCENT,
            glfw.KEY_ESCAPE:        pygui.IMGUI_KEY_ESCAPE,
            glfw.KEY_ENTER:         pygui.IMGUI_KEY_ENTER,
            glfw.KEY_TAB:           pygui.IMGUI_KEY_TAB,
            glfw.KEY_BACKSPACE:     pygui.IMGUI_KEY_BACKSPACE,
            glfw.KEY_INSERT:        pygui.IMGUI_KEY_INSERT,
            glfw.KEY_DELETE:        pygui.IMGUI_KEY_DELETE,
            glfw.KEY_RIGHT:         pygui.IMGUI_KEY_RIGHT_ARROW,
            glfw.KEY_LEFT:          pygui.IMGUI_KEY_LEFT_ARROW,
            glfw.KEY_DOWN:          pygui.IMGUI_KEY_DOWN_ARROW,
            glfw.KEY_UP:            pygui.IMGUI_KEY_UP_ARROW,
            glfw.KEY_PAGE_UP:       pygui.IMGUI_KEY_PAGE_UP,
            glfw.KEY_PAGE_DOWN:     pygui.IMGUI_KEY_PAGE_DOWN,
            glfw.KEY_HOME:          pygui.IMGUI_KEY_HOME,
            glfw.KEY_END:           pygui.IMGUI_KEY_END,
            glfw.KEY_CAPS_LOCK:     pygui.IMGUI_KEY_CAPS_LOCK,
            glfw.KEY_SCROLL_LOCK:   pygui.IMGUI_KEY_SCROLL_LOCK,
            glfw.KEY_NUM_LOCK:      pygui.IMGUI_KEY_NUM_LOCK,
            glfw.KEY_PRINT_SCREEN:  pygui.IMGUI_KEY_PRINT_SCREEN,
            glfw.KEY_PAUSE:         pygui.IMGUI_KEY_PAUSE,
            glfw.KEY_F1:            pygui.IMGUI_KEY_F1,
            glfw.KEY_F2:            pygui.IMGUI_KEY_F2,
            glfw.KEY_F3:            pygui.IMGUI_KEY_F3,
            glfw.KEY_F4:            pygui.IMGUI_KEY_F4,
            glfw.KEY_F5:            pygui.IMGUI_KEY_F5,
            glfw.KEY_F6:            pygui.IMGUI_KEY_F6,
            glfw.KEY_F7:            pygui.IMGUI_KEY_F7,
            glfw.KEY_F8:            pygui.IMGUI_KEY_F8,
            glfw.KEY_F9:            pygui.IMGUI_KEY_F9,
            glfw.KEY_F10:           pygui.IMGUI_KEY_F10,
            glfw.KEY_F11:           pygui.IMGUI_KEY_F11,
            glfw.KEY_F12:           pygui.IMGUI_KEY_F12,
            glfw.KEY_KP_0:          pygui.IMGUI_KEY_KEYPAD0,
            glfw.KEY_KP_1:          pygui.IMGUI_KEY_KEYPAD1,
            glfw.KEY_KP_2:          pygui.IMGUI_KEY_KEYPAD2,
            glfw.KEY_KP_3:          pygui.IMGUI_KEY_KEYPAD3,
            glfw.KEY_KP_4:          pygui.IMGUI_KEY_KEYPAD4,
            glfw.KEY_KP_5:          pygui.IMGUI_KEY_KEYPAD5,
            glfw.KEY_KP_6:          pygui.IMGUI_KEY_KEYPAD6,
            glfw.KEY_KP_7:          pygui.IMGUI_KEY_KEYPAD7,
            glfw.KEY_KP_8:          pygui.IMGUI_KEY_KEYPAD8,
            glfw.KEY_KP_9:          pygui.IMGUI_KEY_KEYPAD9,
            glfw.KEY_KP_DECIMAL:    pygui.IMGUI_KEY_KEYPAD_DECIMAL,
            glfw.KEY_KP_DIVIDE:     pygui.IMGUI_KEY_KEYPAD_DIVIDE,
            glfw.KEY_KP_MULTIPLY:   pygui.IMGUI_KEY_KEYPAD_MULTIPLY,
            glfw.KEY_KP_SUBTRACT:   pygui.IMGUI_KEY_KEYPAD_SUBTRACT,
            glfw.KEY_KP_ADD:        pygui.IMGUI_KEY_KEYPAD_ADD,
            glfw.KEY_KP_ENTER:      pygui.IMGUI_KEY_KEYPAD_ENTER,
            glfw.KEY_KP_EQUAL:      pygui.IMGUI_KEY_KEYPAD_EQUAL,
            glfw.KEY_LEFT_SHIFT:    pygui.IMGUI_KEY_LEFT_SHIFT,
            glfw.KEY_LEFT_CONTROL:  pygui.IMGUI_KEY_LEFT_CTRL,
            glfw.KEY_LEFT_ALT:      pygui.IMGUI_KEY_LEFT_ALT,
            glfw.KEY_LEFT_SUPER:    pygui.IMGUI_KEY_LEFT_SUPER,
            glfw.KEY_RIGHT_SHIFT:   pygui.IMGUI_KEY_RIGHT_SHIFT,
            glfw.KEY_RIGHT_CONTROL: pygui.IMGUI_KEY_RIGHT_CTRL,
            glfw.KEY_RIGHT_ALT:     pygui.IMGUI_KEY_RIGHT_ALT,
            glfw.KEY_RIGHT_SUPER:   pygui.IMGUI_KEY_RIGHT_SUPER,
            glfw.KEY_MENU:          pygui.IMGUI_KEY_MENU,
        }
        self.mouse_map = {
            glfw.MOUSE_BUTTON_LEFT: pygui.IMGUI_MOUSE_BUTTON_LEFT, 
            glfw.MOUSE_BUTTON_RIGHT: pygui.IMGUI_MOUSE_BUTTON_RIGHT, 
            glfw.MOUSE_BUTTON_MIDDLE: pygui.IMGUI_MOUSE_BUTTON_MIDDLE, 
        }

    def keyboard_callback(self, window, key, scancode, action, mods):
        if key in self.key_map:
            self.io.add_key_event(self.key_map[key], action == glfw.PRESS)

    def mouse_movement_callback(self, window, x: float, y: float):
        self.io.add_mouse_pos_event(x, y)

    def mouse_click_callback(self, window, mouse_button: int, action: int, mods: int):
        if mouse_button in self.mouse_map:
            self.io.add_mouse_button_event(self.mouse_map[mouse_button], action == glfw.PRESS)

    def scroll_callback(self, window, x_offset, y_offset):
        self.io.add_mouse_wheel_event(x_offset, y_offset)

    def resize_callback(self, window, width, height):
        self.io.display_size = width, height

    def process_inputs(self):
        self.io.display_size = glfw.get_window_size(self.window)
        self.io.delta_time = 1.0 / 60  # For the first frame

        current_time = glfw.get_time()
        if self._gui_time:
            self.io.delta_time = current_time - self._gui_time
        else:
            self.io.delta_time = 1. / 60.
        self._gui_time = current_time
