from __future__ import annotations
import pygui
import math
import time
from PIL import Image
from enum import Enum, auto


# From: https://stackoverflow.com/questions/4092528/how-can-i-clamp-clip-restrict-a-number-to-some-range#comment53230306_4092550
def clamp(n, smallest, largest):
    return max(smallest, min(n, largest))


def help_marker(desc: str):
    pygui.text_disabled("(?)")
    if pygui.is_item_hovered(pygui.HOVERED_FLAGS_DELAY_SHORT) and pygui.begin_tooltip():
        pygui.push_text_wrap_pos(pygui.get_font_size() * 35)
        pygui.text_unformatted(desc)
        pygui.pop_text_wrap_pos()
        pygui.end_tooltip()


def push_style_compact():
    style = pygui.get_style()
    pygui.push_style_var_im_vec2(pygui.STYLE_VAR_FRAME_PADDING, (style.frame_padding[0], style.frame_padding[1] * 0.6))
    pygui.push_style_var_im_vec2(pygui.STYLE_VAR_ITEM_SPACING, (style.item_spacing[0], style.item_spacing[1] * 0.6))


def pop_style_compact():
    pygui.pop_style_var(2)


def pygui_demo_window():
    if demo.show_app_console:
        show_app_console(demo.show_app_console)
    if demo.show_custom_rendering:
        show_app_custom_rendering(demo.show_custom_rendering)
    if demo.show_about_window:
        pygui.show_about_window(demo.show_about_window)
    if demo.show_random_extras:
        show_random_extras(demo.show_random_extras)

    show_menu_bar()
    show_demo_widgets()
    show_demo_window_layout()
    show_demo_tables()
    crash_imgui()


class widget:
    _singleton_instance = None

    @staticmethod
    def instance() -> widget:
        if widget._singleton_instance is None:
            widget._singleton_instance = widget()
        return widget._singleton_instance
    
    def __init__(self):
        self.widgets_image = Image.open("pygui/img/code.png")
        self.widgets_image_texture = pygui.load_image(self.widgets_image)

    general_clicked = 0
    general_check = pygui.BoolPtr(True)
    general_e = pygui.IntPtr(0)
    general_counter = 0
    inputs_str0 = pygui.StrPtr("Hello, World!", 128)
    inputs_str1 = pygui.StrPtr("", 128)
    inputs_i0 = pygui.IntPtr(123)
    inputs_f0 = pygui.FloatPtr(0.001)
    inputs_d0 = pygui.DoublePtr(999999.00000001)
    inputs_f1 = pygui.FloatPtr(1.e10)
    inputs_vec4a = [
        pygui.FloatPtr(0.1),
        pygui.FloatPtr(0.2),
        pygui.FloatPtr(0.3),
        pygui.FloatPtr(0.44),
    ]
    drag_i1 = pygui.IntPtr(50)
    drag_i2 = pygui.IntPtr(42)
    drag_f1 = pygui.FloatPtr(1)
    drag_f2 = pygui.FloatPtr(0.0067)
    sliders_i1 = pygui.IntPtr(0)
    sliders_f1 = pygui.FloatPtr(0.123)
    sliders_f2 = pygui.FloatPtr(0)
    sliders_angle = pygui.FloatPtr(0)
    sliders_elem = pygui.IntPtr(0)
    picker_col1 = pygui.Vec4Ptr(1, 0, 0.2, 1)
    picker_col2 = pygui.Vec4Ptr(0.4, 0.7, 0, 0.5)
    combo_item_current = pygui.IntPtr(0)
    list_item_current = pygui.IntPtr(0)
    tree_base_flags = pygui.IntPtr(
        pygui.TREE_NODE_FLAGS_OPEN_ON_ARROW | \
        pygui.TREE_NODE_FLAGS_OPEN_ON_DOUBLE_CLICK | \
        pygui.TREE_NODE_FLAGS_SPAN_AVAIL_WIDTH)
    tree_align_label_with_current_x_position = pygui.BoolPtr(False)
    tree_test_drag_and_drop = pygui.BoolPtr(False)
    tree_selection_mask = pygui.IntPtr(1 << 2)
    header_closable_group = pygui.BoolPtr(True)
    text_wrap_width = pygui.FloatPtr(200)
    text_utf8_buf = pygui.StrPtr("日本語", 64)
    combo_flags = pygui.IntPtr(0)
    combo_item_current_idx = pygui.IntPtr(0)
    combo_item_current_2 = pygui.IntPtr(0)
    combo_item_current_3 = pygui.IntPtr(0)
    combo_item_current_4 = pygui.IntPtr(0)
    image_use_text_color_for_tint = pygui.BoolPtr(False)
    image_pressed_count = 0
    list_box_item_current_idx = 0
    select_selection = [
        pygui.BoolPtr(False),
        pygui.BoolPtr(True),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
    ]
    select_selected = -1
    select_single_state_selected = -1
    select_multi_state_selection = [
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
    ]
    select_render_selected = [
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
    ]
    select_column_selected = [pygui.BoolPtr(False) for _ in range(10)]
    select_grid_selected = [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
    ]
    select_allign_selected = [
        pygui.BoolPtr(True),
        pygui.BoolPtr(False),
        pygui.BoolPtr(True),
        pygui.BoolPtr(False),
        pygui.BoolPtr(True),
        pygui.BoolPtr(False),
        pygui.BoolPtr(True),
        pygui.BoolPtr(False),
        pygui.BoolPtr(True),
    ]
    plotting_animate = pygui.BoolPtr(True)
    plotting_arr = [
        0.6, 0.1, 1.0, 0.5, 0.92, 0.1, 0.2
    ]
    plotting_values = [0] * 90
    plotting_values_offset = 0
    plotting_refresh_time = 0
    plotting_phase = 0
    plotting_func_type = pygui.IntPtr(0)
    plotting_display_count = pygui.IntPtr(70)
    plotting_progress = 0
    plotting_progress_dir = 1
    colour_color = pygui.Vec4Ptr(114 / 255, 144 / 255, 154 / 255, 200 / 255)
    colour_flags = pygui.IntPtr(0)
    colour_alpha_preview = pygui.BoolPtr(True)
    colour_alpha_half_preview = pygui.BoolPtr(False)
    colour_drag_and_drop = pygui.BoolPtr(True)
    colour_options_menu = pygui.BoolPtr(True)
    colour_hdr = pygui.BoolPtr(False)
    colour_saved_palette_init = pygui.BoolPtr(True)
    colour_saved_palette = [pygui.Vec4Ptr(0, 0, 0, 0) for _ in range(32)]
    colour_backup_color = pygui.Vec4Ptr(0, 0, 0, 0)
    colour_no_border = pygui.BoolPtr(False)
    colour_alpha = pygui.BoolPtr(True)
    colour_alpha_bar = pygui.BoolPtr(True)
    colour_side_preview = pygui.BoolPtr(True)
    colour_ref_color = pygui.BoolPtr(False)
    colour_ref_color_v = pygui.Vec4Ptr(1, 0, 1, 0.5)
    colour_display_mode = pygui.IntPtr(False)
    colour_picker_mode = pygui.IntPtr(False)
    colour_color_hsv = pygui.Vec4Ptr(0.23, 1, 1, 1)
    data_drag_clamp = pygui.BoolPtr(False)
    data_s8_v = pygui.IntPtr(127)
    data_u8_v = pygui.IntPtr(255)
    data_s16_v = pygui.IntPtr(32767)
    data_u16_v = pygui.IntPtr(65535)
    data_s32_v = pygui.LongPtr(-1)
    data_u32_v = pygui.LongPtr(-1)
    data_s64_v = pygui.LongPtr(-1)
    data_u64_v = pygui.LongPtr(-1)
    data_f32_v = pygui.FloatPtr(0.123)
    data_f64_v = pygui.DoublePtr(90000.01234567890123456789)
    data_inputs_step = pygui.BoolPtr(True)
    data_long_n = [
        pygui.LongPtr(10000000),
        pygui.LongPtr(20000000),
    ]
    data_float_n = [
        pygui.FloatPtr(0.1),
        pygui.FloatPtr(0.2),
        pygui.FloatPtr(0.3),
        pygui.FloatPtr(0.4),
    ]
    data_double_n = [
        pygui.DoublePtr(0.00001),
        pygui.DoublePtr(0.00002),
        pygui.DoublePtr(0.00003),
        pygui.DoublePtr(0.00004),
    ]
    multi_vec4f = pygui.Vec4Ptr(0.10, 0.2, 0.3, 0.44)
    multi_vec4i = pygui.Vec4Ptr(1, 5, 100, 255)
    tab_tab_bar_flags = pygui.IntPtr(pygui.TAB_BAR_FLAGS_REORDERABLE)
    tab_opened = [pygui.BoolPtr(True) for _ in range(4)]


def show_demo_widgets():
    if not pygui.collapsing_header("Widgets"):
        return
    
    if pygui.tree_node("Basic"):
        pygui.separator_text("General")

        if pygui.button("Button"):
            widget.general_clicked += 1
        
        if widget.general_clicked & 1:
            pygui.same_line()
            pygui.text("Thanks for clicking me!")
        
        pygui.checkbox("checkbox", widget.general_check)

        pygui.radio_button_int_ptr("radio a", widget.general_e, 0)
        pygui.same_line()
        pygui.radio_button_int_ptr("radio b", widget.general_e, 1)
        pygui.same_line()
        pygui.radio_button_int_ptr("radio c", widget.general_e, 2)
        
        # Color buttons, demonstrate using PushID() to add unique identifier in the ID stack, and changing style.
        for i in range(6):
            if i > 0:
                pygui.same_line()
            
            pygui.push_id_int(i)
            pygui.push_style_color_im_vec4(pygui.COL_BUTTON,         pygui.color_convert_hsv_to_rgb(i / 7, 0.6, 0.6))
            pygui.push_style_color_im_vec4(pygui.COL_BUTTON_HOVERED, pygui.color_convert_hsv_to_rgb(i / 7, 0.7, 0.7))
            pygui.push_style_color_im_vec4(pygui.COL_BUTTON_ACTIVE,  pygui.color_convert_hsv_to_rgb(i / 7, 0.8, 0.8))
            pygui.button("Click")
            pygui.pop_style_color(3)
            pygui.pop_id()
        
        # Use AlignTextToFramePadding() to align text baseline to the baseline of framed widgets elements
        # (otherwise a Text+SameLine+Button sequence will have the text a little too high by default!)
        # See 'Demo->Layout->Text Baseline Alignment' for details.
        pygui.align_text_to_frame_padding()
        pygui.text("Hold to repeat:")
        pygui.same_line()

        spacing: float = pygui.get_style().item_inner_spacing[0]
        pygui.push_button_repeat(True)
        if pygui.arrow_button("##left", pygui.DIR_LEFT):
            widget.general_counter -= 1
        pygui.same_line(0, spacing)
        if pygui.arrow_button("##right", pygui.DIR_RIGHT):
            widget.general_counter += 1
        pygui.pop_button_repeat()
        pygui.same_line()
        pygui.text(str(widget.general_counter))

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
        if pygui.is_item_hovered(pygui.HOVERED_FLAGS_DELAY_NORMAL):
            pygui.set_tooltip("I am a tooltip with a delay")
        
        pygui.same_line()
        help_marker("Tooltip are created by using the IsItemHovered() function over any kind of item.")

        pygui.label_text("label", "Value")

        pygui.separator_text("Inputs")

        pygui.input_text("input text", widget.inputs_str0)
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

        pygui.input_text_with_hint("input text (w/ hint)", "enter text here", widget.inputs_str1)
        pygui.input_int("input int", widget.inputs_i0)
        pygui.input_float("input float", widget.inputs_f0, 0.01, 1.0, "%.3f")
        pygui.input_double("input double", widget.inputs_d0, 0.01, 1.0, "%.8f")
        pygui.input_float("input scientific", widget.inputs_f1, 0, 0, "%e")
        pygui.input_float2("input float2", widget.inputs_vec4a)
        pygui.input_float3("input float3", widget.inputs_vec4a)
        pygui.input_float4("input float4", widget.inputs_vec4a)

        pygui.separator_text("Drags")

        pygui.drag_int("drag int", widget.drag_i1, 1)
        pygui.same_line()
        help_marker(
            "Click and drag to edit value.\n"
            "Hold SHIFT/ALT for faster/slower edit.\n"
            "Double-click or CTRL+click to input value."
        )
        pygui.drag_int("drag int 0..100", widget.drag_i2, 1, 0, 100, "%d%%", pygui.SLIDER_FLAGS_ALWAYS_CLAMP)
        pygui.drag_float("drag float", widget.drag_f1, 0.005)
        pygui.drag_float("drag small float", widget.drag_f2, 0.0001, 0, 0, "%.06f ns")

        pygui.separator_text("Sliders")

        pygui.slider_int("slider int", widget.sliders_i1, -1, 3)
        pygui.same_line()
        help_marker("CTRL+click to input value.")
        pygui.slider_float("slider float", widget.sliders_f1, 0, 1, "ratio = %.3f")
        pygui.slider_float("slider float (log)", widget.sliders_f2, -10, 10, "%.4f", pygui.SLIDER_FLAGS_LOGARITHMIC)
        pygui.slider_angle("slider angle", widget.sliders_angle)

        # Using the format string to display a name instead of an integer.
        # Here we completely omit '%d' from the format string, so it'll only display a name.
        # This technique can also be used with DragInt().
        elements = ["Fire", "Earth", "Air", "Water"]
        elem_name = elements[widget.sliders_elem.value] if 0 <= widget.sliders_elem.value < len(elements) else "Unknown"
        pygui.slider_int("slider enum", widget.sliders_elem, 0, len(elements) - 1, elem_name)
        pygui.same_line()
        help_marker("Using the format string parameter to display a name instead of the underlying integer.")
        
        pygui.separator_text("Selectors/Pickers")

        pygui.color_edit3("color 1", widget.picker_col1)
        pygui.same_line()
        help_marker(
            "Click on the color square to open a color picker.\n"
            "Click and hold to use drag and drop.\n"
            "Right-click on the color square to show options.\n"
            "CTRL+click on individual component to input value.\n"
        )
        pygui.color_edit4("color 2", widget.picker_col2)

        # Using the _simplified_ one-liner Combo() api here
        # See "Combo" section for examples of how to use the more flexible BeginCombo()/EndCombo() api.
        # I dunno man, it's pretty clean here in python...
        items = ["AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFF", "GGGG", "HHHH", "IIIIIII", "JJJJ", "KKKKKKK"]
        pygui.combo("combo", widget.combo_item_current, items)
        pygui.same_line()
        help_marker("Using the simplified one-liner Combo API here.\nRefer to the \"Combo\" section below for an explanation of how to use the more flexible and general BeginCombo/EndCombo API.")
        
        items_list = ["Apple", "Banana", "Cherry", "Kiwi", "Mango", "Orange", "Pineapple", "Strawberry", "Watermelon"]
        pygui.list_box("listbox", widget.list_item_current, items_list, 4)
        pygui.same_line()
        help_marker(
            "Using the simplified one-liner ListBox API here.\nRefer to the \"List boxes\" section below for an explanation of how to use the more flexible and general BeginListBox/EndListBox API."
        )

        pygui.tree_pop()
    
    if pygui.tree_node("Trees"):
        if pygui.tree_node("Basic trees"):
            for i in range(5):
                if i == 0:
                    pygui.set_next_item_open(True, pygui.COND_ONCE)
                
                if pygui.tree_node("Child {}".format(i)):
                    pygui.text("blah blah")
                    pygui.same_line()
                    if pygui.small_button("button"):
                        pass
                    pygui.tree_pop()
            pygui.tree_pop()

        if pygui.tree_node("Advanced, with Selectable nodes"):
            help_marker(
                "This is a more typical looking tree with selectable nodes.\n"
                "Click to select, CTRL+Click to toggle, click on arrows or double-click to open."
            )
            pygui.checkbox_flags("ImGuiTreeNodeFlags_OpenOnArrow",       widget.tree_base_flags, pygui.TREE_NODE_FLAGS_OPEN_ON_ARROW)
            pygui.checkbox_flags("ImGuiTreeNodeFlags_OpenOnDoubleClick", widget.tree_base_flags, pygui.TREE_NODE_FLAGS_OPEN_ON_DOUBLE_CLICK)
            pygui.checkbox_flags("ImGuiTreeNodeFlags_SpanAvailWidth",    widget.tree_base_flags, pygui.TREE_NODE_FLAGS_SPAN_AVAIL_WIDTH)
            pygui.same_line()
            help_marker("Extend hit area to all available width instead of allowing more items to be laid out after the node.")
            pygui.checkbox_flags("ImGuiTreeNodeFlags_SpanFullWidth",     widget.tree_base_flags, pygui.TREE_NODE_FLAGS_SPAN_FULL_WIDTH)
            pygui.checkbox("Align label with current X position", widget.tree_align_label_with_current_x_position)
            pygui.checkbox("Test tree node as drag source", widget.tree_test_drag_and_drop)
            pygui.text("Hello!")
            if widget.tree_align_label_with_current_x_position:
                pygui.unindent(pygui.get_tree_node_to_label_spacing())
            
            # 'selection_mask' is dumb representation of what may be user-side selection state.
            #  You may retain selection state inside or outside your objects in whatever format you see fit.
            # 'node_clicked' is temporary storage of what node we have clicked to process selection at the end
            #  of the loop. May be a pointer to your own node type, etc.
            node_clicked = -1
            for i in range(6):
                node_flags = widget.tree_base_flags.value
                is_selected = (widget.tree_selection_mask.value & (1 << i)) != 0
                if is_selected:
                    node_flags |= pygui.TREE_NODE_FLAGS_SELECTED
                if i < 3:
                    # Items 0..2 are Tree Node
                    node_open = pygui.tree_node(f"Selectable Node {i}", node_flags)
                    if pygui.is_item_clicked() and not pygui.is_item_toggled_open():
                        node_clicked = i
                    if widget.tree_test_drag_and_drop and pygui.begin_drag_drop_source():
                        pygui.set_drag_drop_payload("_TREENODE", None, 0)
                        pygui.text("This is a drag and drop source")
                        pygui.end_drag_drop_source()
                    if node_open:
                        pygui.bullet_text("Blah blah\nBlah Blah")
                        pygui.tree_pop()
                else:
                    # Items 3..5 are Tree Leaves
                    # The only reason we use TreeNode at all is to allow selection of the leaf. Otherwise we can
                    # use BulletText() or advance the cursor by GetTreeNodeToLabelSpacing() and call Text().
                    node_flags |= pygui.TREE_NODE_FLAGS_LEAF | pygui.TREE_NODE_FLAGS_NO_TREE_PUSH_ON_OPEN # ImGuiTreeNodeFlags_Bullet
                    pygui.tree_node(f"Selectable Leaf {i}", node_flags)
                    if pygui.is_item_clicked() and not pygui.is_item_toggled_open():
                        node_clicked = i
                    if widget.tree_test_drag_and_drop and pygui.begin_drag_drop_source():
                        pygui.set_drag_drop_payload("_TREENODE", None, 0)
                        pygui.text("This is a drag and drop source")
                        pygui.end_drag_drop_source()
            
            if node_clicked != -1:
                # Update selection state
                # (process outside of tree loop to avoid visual inconsistencies during the clicking frame)
                if pygui.get_io().key_ctrl:
                    widget.tree_selection_mask.value ^= (1 << node_clicked)              # CTRL+click to toggle
                else: #elif not (static.widgets_tree_selection_mask & (1 << node_clicked)) # Depending on selection behavior you want, may want to preserve selection when clicking on item that is part of the selection
                    widget.tree_selection_mask.value = (1 << node_clicked)               # Click to single-select

            if widget.tree_align_label_with_current_x_position:
                pygui.indent(pygui.get_tree_node_to_label_spacing())
            pygui.tree_pop()
        pygui.tree_pop()
    
    if pygui.tree_node("Collapsing Headers"):
        pygui.checkbox("Show 2nd header", widget.header_closable_group)
        if pygui.collapsing_header("Header", pygui.TREE_NODE_FLAGS_NONE):
            pygui.text("IsItemHovered: {}".format(pygui.is_item_hovered()))
            for i in range(5):
                pygui.text(f"Some content {i}")
        
        if pygui.collapsing_header_bool_ptr("Header with a close button", widget.header_closable_group):
            pygui.text("IsItemHovered: {}".format(pygui.is_item_hovered()))
            for i in range(5):
                pygui.text(f"more content {i}")
        pygui.tree_pop()
    
    if pygui.tree_node("Bullets"):
        pygui.bullet_text("Bullet point 1");
        pygui.bullet_text("Bullet point 2\nOn multiple lines");
        if pygui.tree_node("Tree node"):
            pygui.bullet_text("Another bullet point")
            pygui.tree_pop()
        
        pygui.bullet()
        pygui.text("Bullet point 3 (two calls)")
        pygui.bullet()
        pygui.small_button("Button")
        pygui.tree_pop()

    if pygui.tree_node("Text"):
        if pygui.tree_node("Colorful text"):
            pygui.text_colored((1, 0, 1, 1), "Pink")
            pygui.text_colored((1, 1, 0, 1), "Yellow")
            pygui.text_disabled("Disabled")
            pygui.same_line()
            help_marker("The TextDisabled color is stored in ImGuiStyle.")
            pygui.tree_pop()
        
        if pygui.tree_node("Word Wrapping"):
            pygui.text_wrapped(
                "This text should automatically wrap on the edge of the window. The current implementation "
                "for text wrapping follows simple rules suitable for English and possibly other languages.")
            pygui.spacing()

            pygui.slider_float("Wrap width", widget.text_wrap_width, -20, 600, "%.0f")

            draw_list = pygui.get_window_draw_list()
            for n in range(2):
                pygui.text(f"Test paragraph {n}")
                pos = pygui.get_cursor_screen_pos()
                marker_min = (pos[0] + widget.text_wrap_width.value, pos[1])
                marker_max = (pos[0] + widget.text_wrap_width.value + 10, pos[1] + pygui.get_text_line_height())
                pygui.push_text_wrap_pos(pygui.get_cursor_pos()[0] + widget.text_wrap_width.value)
                if n == 0:
                    pygui.text("The lazy dog is a good dog. This paragraph should fit within {} pixels. Testing a 1 character word. The quick brown fox jumps over the lazy dog.".format(
                        widget.text_wrap_width.value
                    ))
                else:
                    pygui.text("aaaaaaaa bbbbbbbb, c cccccccc,dddddddd. d eeeeeeee   ffffffff. gggggggg!hhhhhhhh")
                
                draw_list.add_rect(pygui.get_item_rect_min(), pygui.get_item_rect_max(), pygui.IM_COL32(255, 255, 0, 255))
                draw_list.add_rect_filled(marker_min, marker_max, pygui.IM_COL32(255, 0, 255, 255))
                pygui.pop_text_wrap_pos()
            pygui.tree_pop()

        if pygui.tree_node("UTF-8 Text"):
            # UTF-8 test with Japanese characters
            # (Needs a suitable font? Try "Google Noto" or "Arial Unicode". See docs/FONTS.md for details.)
            # - From C++11 you can use the u8"my text" syntax to encode literal strings as UTF-8
            # - For earlier compiler, you may be able to encode your sources as UTF-8 (e.g. in Visual Studio, you
            #   can save your source files as 'UTF-8 without signature').
            # - FOR THIS DEMO FILE ONLY, BECAUSE WE WANT TO SUPPORT OLD COMPILERS, WE ARE *NOT* INCLUDING RAW UTF-8
            #   CHARACTERS IN THIS SOURCE FILE. Instead we are encoding a few strings with hexadecimal constants.
            #   Don't do this in your application! Please use u8"text in any language" in your application!
            # Note that characters values are preserved even by InputText() if the font cannot be displayed,
            # so you can safely copy & paste garbled characters into another application.
            pygui.text_wrapped(
                "CJK text will only appear if the font was loaded with the appropriate CJK character ranges. "
                "Call io.Fonts->AddFontFromFileTTF() manually to load extra character ranges. "
                "Read docs/FONTS.md for details.")
            # Normally we would use u8"blah blah" with the proper characters directly in the string.
            pygui.text("Hiragana: かきくけこ (kakikukeko)")
            pygui.text("Kanjis: 日本語 (nihongo)")
            pygui.input_text("UTF-8 input", widget.text_utf8_buf)
            pygui.tree_pop()
        pygui.tree_pop()

    if pygui.tree_node("Images"):
        if pygui.tree_node("Custom Pygui Image"):
            pygui.image(
                widget.instance().widgets_image_texture,
                (widget.instance().widgets_image.width / 2,
                widget.instance().widgets_image.height / 2))
            pygui.tree_pop()
        
        if pygui.tree_node("ImGui Demo"):
            io = pygui.get_io()
            pygui.text_wrapped(
                "Below we are displaying the font texture (which is the only texture we have access to in this demo). "
                "Use the 'ImTextureID' type as storage to pass pointers or identifier to your own texture data. "
                "Hover the texture for a zoomed view!")
            
            my_tex_id: int = io.fonts.tex_id
            my_tex_w = io.fonts.tex_width
            my_tex_h = io.fonts.tex_height

            pygui.checkbox("Use Text Color for Tint", widget.image_use_text_color_for_tint)
            pygui.text("{}x{}".format(my_tex_w, my_tex_h))
            pos = pygui.get_cursor_screen_pos()
            uv_min = (0, 0) # Top-left
            uv_max = (1, 1) # Lower-right
            if widget.image_use_text_color_for_tint:
                tint_col = pygui.get_style_color_vec4(pygui.COL_TEXT)
            else:
                tint_col = (1, 1, 1, 1)
            border_col = pygui.get_style_color_vec4(pygui.COL_BORDER)
            pygui.image(my_tex_id, (my_tex_w, my_tex_h), uv_min, uv_max, tint_col, border_col)

            if pygui.is_item_hovered() and pygui.begin_tooltip():
                region_sz = 32
                region_x = io.mouse_pos[0] - pos[0] - region_sz * 0.5
                region_y = io.mouse_pos[1] - pos[1] - region_sz * 0.5
                zoom = 4
                if region_x < 0:
                    region_x = 0
                elif region_x > my_tex_w - region_sz:
                    region_x = my_tex_w - region_sz
                
                if region_y < 0:
                    region_y = 0
                elif region_y > my_tex_h - region_sz:
                    region_y = my_tex_h - region_sz
                
                pygui.text("Min: ({:.2f}, {:.2f})".format(region_x, region_y))
                pygui.text("Max: ({:.2f}, {:.2f})".format(region_x + region_sz, region_y + region_sz))
                uv0 = (region_x) / my_tex_w, (region_y) / my_tex_h
                uv1 = (region_x + region_sz) / my_tex_w, (region_y + region_sz) / my_tex_h
                pygui.image(my_tex_id, (region_sz * zoom, region_sz * zoom), uv0, uv1, tint_col, border_col)
                pygui.end_tooltip()
            
            pygui.text_wrapped("And now some textured buttons..")
            for i in range(8):
                # UV coordinates are often (0.0f, 0.0f) and (1.0f, 1.0f) to display an entire textures.
                # Here are trying to display only a 32x32 pixels area of the texture, hence the UV computation.
                # Read about UV coordinates here: https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples
                pygui.push_id_int(i)
                if i > 0:
                    pygui.push_style_var_im_vec2(pygui.STYLE_VAR_FRAME_PADDING, (i - 1, i - 1))
                size = (32, 32)
                uv0 = (0, 0)
                uv1 = (32 / my_tex_w, 32 / my_tex_h)
                bg_col = (0, 0, 0, 1)
                tint_col = (1, 1, 1, 1)
                if pygui.image_button("", my_tex_id, size, uv0, uv1, bg_col, tint_col):
                    widget.image_pressed_count += 1
                if i > 0:
                    pygui.pop_style_var()
                pygui.pop_id()
                pygui.same_line()
            
            pygui.new_line()
            pygui.text("Pressed {} times.".format(widget.image_pressed_count))
            pygui.tree_pop()

        pygui.tree_pop()
    
    if pygui.tree_node("Combo"):
        # Combo Boxes are also called "Dropdown" in other systems
        # Expose flags as checkbox for the demo
        pygui.checkbox_flags("ImGuiComboFlags_PopupAlignLeft", widget.combo_flags, pygui.COMBO_FLAGS_POPUP_ALIGN_LEFT)
        pygui.same_line()
        help_marker("Only makes a difference if the popup is larger than the combo")
        if pygui.checkbox_flags("ImGuiComboFlags_NoArrowButton", widget.combo_flags, pygui.COMBO_FLAGS_NO_ARROW_BUTTON):
            widget.combo_flags.value &= ~pygui.COMBO_FLAGS_NO_PREVIEW
        if pygui.checkbox_flags("ImGuiComboFlags_NoPreview", widget.combo_flags, pygui.COMBO_FLAGS_NO_PREVIEW):
            widget.combo_flags.value &= ~pygui.COMBO_FLAGS_NO_ARROW_BUTTON
        
        # Using the generic BeginCombo() API, you have full control over how to display the combo contents.
        # (your selection data could be an index, a pointer to the object, an id for the object, a flag intrusively
        # stored in the object itself, etc.)
        items = ["AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFF", "GGGG", "HHHH", "IIII", "JJJJ", "KKKK", "LLLLLLL", "MMMM", "OOOOOOO"]
        combo_preview_value = items[widget.combo_item_current_idx.value]
        if pygui.begin_combo("combo 1", combo_preview_value, widget.combo_flags.value):
            for n in range(len(items)):
                is_selected = widget.combo_item_current_idx.value == n
                if pygui.selectable(items[n], is_selected):
                    widget.combo_item_current_idx.value = n
                
                # Set the initial focus when opening the combo (scrolling + keyboard navigation focus)
                if is_selected:
                    pygui.set_item_default_focus()
            
            pygui.end_combo()
        
        # Simplified one-liner Combo() API, using values packed in a single constant string
        # This is a convenience for when the selection set is small and known at compile-time.
        # Pygui note: Obviously this doesn't really make sense in pygui. Just use a list.
        pygui.combo("combo 2 (one-liner)", widget.combo_item_current_2, ["aaaa", "bbbb", "cccc", "dddd", "eeee"])

        # Simplified one-liner Combo() using an array of const char*
        # This is not very useful (may obsolete): prefer using BeginCombo()/EndCombo() for full control.
        # If the selection isn't within 0..count, Combo won't display a preview
        pygui.combo("combo 3 (array)", widget.combo_item_current_3, items)

        # Simplified one-liner Combo() using an accessor function
        def item_getter(data, n: int, out_str: pygui.StrPtr) -> bool:
            out_str.value = data[n]
            return True
        pygui.combo_callback("combo 4 (function)", widget.combo_item_current_4, item_getter, items, len(items))
        pygui.tree_pop()

    if pygui.tree_node("List boxes"):
        # Using the generic BeginListBox() API, you have full control over how to display the combo contents.
        # (your selection data could be an index, a pointer to the object, an id for the object, a flag intrusively
        # stored in the object itself, etc.)
        items = ["AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFF", "GGGG", "HHHH", "IIII", "JJJJ", "KKKK", "LLLLLLL", "MMMM", "OOOOOOO"]
        if pygui.begin_list_box("listbox 1"):
            for n in range(len(items)):
                is_selected = widget.list_box_item_current_idx == n
                if pygui.selectable(items[n], is_selected):
                    widget.list_box_item_current_idx = n
                
                # Set the initial focus when opening the combo (scrolling + keyboard navigation focus)
                if is_selected:
                    pygui.set_item_default_focus()
                
            pygui.end_list_box()

        pygui.text("Full-width:")
        if pygui.begin_list_box("##listbox 2", (-pygui.FLT_MIN, 5 * pygui.get_text_line_height_with_spacing())):
            for n in range(len(items)):
                is_selected = widget.list_box_item_current_idx == n
                if pygui.selectable(items[n], is_selected):
                    widget.list_box_item_current_idx = n
                
                # Set the initial focus when opening the combo (scrolling + keyboard navigation focus)
                if is_selected:
                    pygui.set_item_default_focus()
            pygui.end_list_box()
        
        pygui.tree_pop()
    
    if pygui.tree_node("Selectables"):
        if pygui.tree_node("Basic"):
            pygui.selectable_bool_ptr("1. I am selectable", widget.select_selection[0])
            pygui.selectable_bool_ptr("2. I am selectable", widget.select_selection[1])
            pygui.text("(I am not selectable)")
            pygui.selectable_bool_ptr("4. I am selectable", widget.select_selection[3])
            if pygui.selectable("5. I am double clickable", widget.select_selection[4], pygui.SELECTABLE_FLAGS_ALLOW_DOUBLE_CLICK):
                if pygui.is_mouse_double_clicked(pygui.MOUSE_BUTTON_LEFT):
                    widget.select_selection[4].value = not widget.select_selection[4].value
            pygui.tree_pop()
        
        if pygui.tree_node("Selection State: Single Selection"):
            for n in range(5):
                if pygui.selectable(f"Object {n}", widget.select_single_state_selected == n):
                    widget.select_single_state_selected = n
            pygui.tree_pop()

        if pygui.tree_node("Selection State: Multiple Selection"):
            help_marker("Hold CTRL and click to select multiple items.")
            for n in range(5):
                if pygui.selectable(f"Object {n}", widget.select_multi_state_selection[n]):
                    if not pygui.get_io().key_ctrl:
                        widget.select_multi_state_selection = [pygui.BoolPtr(False) for _ in range(len(widget.select_multi_state_selection))]
                    widget.select_multi_state_selection[n].value = not widget.select_multi_state_selection[n].value
            pygui.tree_pop()
        
        if pygui.tree_node("Rendering more text into the same line"):
            pygui.selectable_bool_ptr("main.c", widget.select_render_selected[0])
            pygui.same_line(300)
            pygui.text(" 2,345 bytes")

            pygui.selectable_bool_ptr("Hello.cpp", widget.select_render_selected[1])
            pygui.same_line(300)
            pygui.text("12,245 bytes")
            
            pygui.selectable_bool_ptr("Hello.h", widget.select_render_selected[2])
            pygui.same_line(300)
            pygui.text(" 2,345 bytes")
            pygui.tree_pop()
        
        if pygui.tree_node("In columns"):
            if pygui.begin_table("split1", 3, pygui.TABLE_FLAGS_RESIZABLE | pygui.TABLE_FLAGS_NO_SAVED_SETTINGS | pygui.TABLE_FLAGS_BORDERS):
                for i in range(10):
                    pygui.table_next_column()
                    pygui.selectable_bool_ptr(f"Item {i}", widget.select_column_selected[i])
                pygui.end_table()
            pygui.spacing()
            if pygui.begin_table("split2", 3, pygui.TABLE_FLAGS_RESIZABLE | pygui.TABLE_FLAGS_NO_SAVED_SETTINGS | pygui.TABLE_FLAGS_BORDERS):
                for i in range(10):
                    pygui.table_next_row()
                    pygui.table_next_column()
                    pygui.selectable_bool_ptr(f"Item {i}", widget.select_column_selected[i], pygui.SELECTABLE_FLAGS_SPAN_ALL_COLUMNS)
                    pygui.table_next_column()
                    pygui.text("Some other contents")
                    pygui.table_next_column()
                    pygui.text("123456")
                pygui.end_table()
            pygui.tree_pop()
        
        if pygui.tree_node("Grid"):
            # Add in a bit of silly fun...
            current_time = pygui.get_time()
            winning_state = not any(0 in inner for inner in widget.select_grid_selected)
            if winning_state:
                pygui.push_style_var_im_vec2(
                    pygui.STYLE_VAR_SELECTABLE_TEXT_ALIGN,
                    (0.5 + 0.5 * math.cos(current_time * 2), 0.5 + 0.5 * math.sin(current_time * 3))
                )
            for y in range(4):
                for x in range(4):
                    if x > 0:
                        pygui.same_line()
                    pygui.push_id_int(y * 4 + x)
                    if pygui.selectable("Sailor", bool(widget.select_grid_selected[y][x]), 0, (50, 50)):
                        widget.select_grid_selected[y][x] ^= 1
                        if x > 0:
                            widget.select_grid_selected[y][x - 1] ^= 1
                        if x < 3:
                            widget.select_grid_selected[y][x + 1] ^= 1
                        if y > 0:
                            widget.select_grid_selected[y - 1][x] ^= 1
                        if y < 3:
                            widget.select_grid_selected[y + 1][x] ^= 1
                    pygui.pop_id()
                
            if winning_state:
                pygui.pop_style_var()
            pygui.tree_pop()

        if pygui.tree_node("Alignment"):
            help_marker(
                "By default, Selectables uses style.SelectableTextAlign but it can be overridden on a per-item "
                "basis using PushStyleVar(). You'll probably want to always keep your default situation to "
                "left-align otherwise it becomes difficult to layout multiple items on a same line")
            for y in range(3):
                for x in range(3):
                    alignment = (x / 2, y / 2)
                    if x > 0:
                        pygui.same_line()
                    pygui.push_style_var_im_vec2(pygui.STYLE_VAR_SELECTABLE_TEXT_ALIGN, alignment)
                    pygui.selectable_bool_ptr(
                        "({:.1f}, {:.1f})".format(alignment[0], alignment[1]),
                        widget.select_allign_selected[3 * y + x],
                        pygui.SELECTABLE_FLAGS_NONE,
                        (80, 80)
                    )
                    pygui.pop_style_var()
            pygui.tree_pop()
        pygui.tree_pop()

    if pygui.tree_node("Tabs"):
        if pygui.tree_node("Basic"):
            tab_bar_flags = pygui.TAB_BAR_FLAGS_NONE
            if pygui.begin_tab_bar("MyTabBar", tab_bar_flags):
                if pygui.begin_tab_item("Avocado"):
                    pygui.text("This is the Avocado tab!\nblah blah blah blah blah")
                    pygui.end_tab_item()
                if pygui.begin_tab_item("Broccoli"):
                    pygui.text("This is the Broccoli tab!\nblah blah blah blah blah")
                    pygui.end_tab_item()
                if pygui.begin_tab_item("Cucumber"):
                    pygui.text("This is the Cucumber tab!\nblah blah blah blah blah")
                    pygui.end_tab_item()
                pygui.end_tab_bar()
            pygui.separator()
            pygui.tree_pop()
        
        if pygui.tree_node("Advanced & Close Button"):
            pygui.checkbox_flags("ImGuiTabBarFlags_Reorderable", widget.tab_tab_bar_flags, pygui.TAB_BAR_FLAGS_REORDERABLE)
            pygui.checkbox_flags("ImGuiTabBarFlags_AutoSelectNewTabs", widget.tab_tab_bar_flags, pygui.TAB_BAR_FLAGS_AUTO_SELECT_NEW_TABS)
            pygui.checkbox_flags("ImGuiTabBarFlags_TabListPopupButton", widget.tab_tab_bar_flags, pygui.TAB_BAR_FLAGS_TAB_LIST_POPUP_BUTTON)
            pygui.checkbox_flags("ImGuiTabBarFlags_NoCloseWithMiddleMouseButton", widget.tab_tab_bar_flags, pygui.TAB_BAR_FLAGS_NO_CLOSE_WITH_MIDDLE_MOUSE_BUTTON)
            if widget.tab_tab_bar_flags.value & pygui.TAB_BAR_FLAGS_FITTING_POLICY_MASK == 0:
                widget.tab_tab_bar_flags.value |= pygui.TAB_BAR_FLAGS_FITTING_POLICY_DEFAULT
            if pygui.checkbox_flags("ImGuiTabBarFlags_FittingPolicyResizeDown", widget.tab_tab_bar_flags, pygui.TAB_BAR_FLAGS_FITTING_POLICY_RESIZE_DOWN):
                widget.tab_tab_bar_flags.value &= ~(pygui.TAB_BAR_FLAGS_FITTING_POLICY_MASK ^ pygui.TAB_BAR_FLAGS_FITTING_POLICY_RESIZE_DOWN)
            if pygui.checkbox_flags("ImGuiTabBarFlags_FittingPolicyScroll", widget.tab_tab_bar_flags, pygui.TAB_BAR_FLAGS_FITTING_POLICY_SCROLL):
                widget.tab_tab_bar_flags.value &= ~(pygui.TAB_BAR_FLAGS_FITTING_POLICY_MASK ^ pygui.TAB_BAR_FLAGS_FITTING_POLICY_SCROLL)

            # Tab Bar
            names = ["Artichoke", "Beetroot", "Celery", "Daikon"]
            for n in range(len(widget.tab_opened)):
                if n > 0:
                    pygui.same_line()
                pygui.checkbox(names[n], widget.tab_opened[n])

            # Passing a bool* to BeginTabItem() is similar to passing one to Begin():
            # the underlying bool will be set to false when the tab is closed.
            if pygui.begin_tab_bar("MyTabBar", widget.tab_tab_bar_flags.value):
                for n in range(len(widget.tab_opened)):
                    if widget.tab_opened[n] and pygui.begin_tab_item(names[n], widget.tab_opened[n], pygui.TAB_BAR_FLAGS_NONE):
                        pygui.text("This is the {} tab!".format(names[n]))
                        if n & 1:
                            pygui.text("I am an odd tab.")
                        pygui.end_tab_item()
                pygui.end_tab_bar()
            pygui.separator()
            pygui.tree_pop()

        pygui.tree_pop()

    if pygui.tree_node("Plotting"):
        pygui.checkbox("Animate", widget.plotting_animate)

        # Plot as lines and plot as histogram
        pygui.plot_lines("Frame Times", widget.plotting_arr)
        pygui.plot_histogram("Histogram", widget.plotting_arr, 0, None, 0, 1, (0, 80))

        # Fill an array of contiguous float values to plot
        # Tip: If your float aren't contiguous but part of a structure, you can pass a pointer to your first float
        # and the sizeof() of your structure in the "stride" parameter.
        if not widget.plotting_animate or widget.plotting_refresh_time == 0:
            widget.plotting_refresh_time = time.time()
        
        while widget.plotting_refresh_time < time.time():
            widget.plotting_values[widget.plotting_values_offset] = math.cos(
                widget.plotting_phase
            )
            widget.plotting_values_offset = (widget.plotting_values_offset + 1) % len(widget.plotting_values)
            widget.plotting_phase += 0.1 * widget.plotting_values_offset
            widget.plotting_refresh_time += 1 / 60

        average = 0
        for n in range(len(widget.plotting_values)):
            average += widget.plotting_values[n]
        average /= len(widget.plotting_values)
        pygui.plot_lines(
            "Lines",
            widget.plotting_values,
            widget.plotting_values_offset,
            "avg {:.6f}".format(average),
            -1,
            1,
            (0, 80)
        )

        # This section has been modified to use pythonic functions and methods
        # rather than the values_getter moethod in the demo.
        pygui.separator_text("Functions")
        pygui.set_next_item_width(pygui.get_font_size() * 8)
        pygui.combo("func", widget.plotting_func_type, ["Sin", "Saw"])
        pygui.same_line()
        pygui.slider_int("Sample count", widget.plotting_display_count, 1, 400)

        def saw(value: int):
            return 1 if value & 1 == 0 else -1

        if widget.plotting_func_type.value == 0:
            values = [math.sin(i / 10) for i in range(widget.plotting_display_count.value)]
        else:
            values = [saw(i) for i in range(widget.plotting_display_count.value)]
        
        pygui.plot_lines("Lines", values, 0, None, -1, 1, (0, 80))
        pygui.plot_histogram("Histogram", values, 0, None, -1, 1, (0, 80))
        pygui.separator()

        if widget.plotting_animate:
            widget.plotting_progress += widget.plotting_progress_dir * 0.4 * pygui.get_io().delta_time
            if widget.plotting_progress >= 1.1:
                widget.plotting_progress = 1.1
                widget.plotting_progress_dir *= -1
            if widget.plotting_progress <= -0.1:
                widget.plotting_progress = -0.1
                widget.plotting_progress_dir *= -1

        # Typically we would use ImVec2(-1.0f,0.0f) or ImVec2(-FLT_MIN,0.0f) to use all available width,
        # or ImVec2(width,0.0f) for a specified width. ImVec2(0.0f,0.0f) uses ItemWidth.
        pygui.progress_bar(widget.plotting_progress, (0, 0))
        pygui.same_line(0, pygui.get_style().item_inner_spacing[0])
        pygui.text("Progress Bar")
        
        progress_saturated = clamp(widget.plotting_progress, 0, 1)
        pygui.progress_bar(widget.plotting_progress, (0, 0), "{}/{}".format(
            int(progress_saturated * 1753), 1753
        ))
        pygui.tree_pop()

    if pygui.tree_node("Color/Picker Widgets"):
        pygui.separator_text("Options")
        pygui.checkbox_flags("With Alpha Preview", widget.colour_flags, pygui.COLOR_EDIT_FLAGS_ALPHA_PREVIEW)
        pygui.checkbox_flags("With Half Alpha Preview", widget.colour_flags, pygui.COLOR_EDIT_FLAGS_ALPHA_PREVIEW_HALF)
        pygui.checkbox_flags("No Drag and Drop", widget.colour_flags, pygui.COLOR_EDIT_FLAGS_NO_DRAG_DROP)
        pygui.checkbox_flags("No Options Menu", widget.colour_flags, pygui.COLOR_EDIT_FLAGS_NO_OPTIONS)
        pygui.same_line()
        help_marker("Right-click on the individual color widget to show options.")
        pygui.checkbox_flags("With HDR", widget.colour_flags, pygui.COLOR_EDIT_FLAGS_HDR)
        pygui.same_line()
        help_marker("Currently all this does is to lift the 0..1 limits on dragging widgets.")
        misc_flags = widget.colour_flags.value
        
        pygui.separator_text("Inline color editor")
        pygui.text("Color widget:")
        pygui.same_line()
        help_marker(
            "Click on the color square to open a color picker.\n"
            "CTRL+click on individual component to input value.\n")
        pygui.color_edit3("MyColor##1", widget.colour_color, misc_flags)

        pygui.text("Color widget HSV with Alpha:")
        pygui.color_edit4("MyColor##2", widget.colour_color, pygui.COLOR_EDIT_FLAGS_DISPLAY_HSV | misc_flags)

        pygui.text("Color widget with Float Display:")
        pygui.color_edit4("MyColor##2f", widget.colour_color, pygui.COLOR_EDIT_FLAGS_FLOAT | misc_flags)
        
        pygui.text("Color button with Picker:")
        pygui.same_line()
        help_marker(
            "With the ImGuiColorEditFlags_NoInputs flag you can hide all the slider/text inputs.\n"
            "With the ImGuiColorEditFlags_NoLabel flag you can pass a non-empty label which will only "
            "be used for the tooltip and picker popup.")
        pygui.color_edit4("MyColor##3", widget.colour_color, pygui.COLOR_EDIT_FLAGS_NO_INPUTS | pygui.COLOR_EDIT_FLAGS_NO_LABEL | misc_flags)

        pygui.text("Color button with Custom Picker Popup:")

        # Generate a default palette. The palette will persist and can be edited.
        if widget.colour_saved_palette_init:
            for n in range(len(widget.colour_saved_palette)):
                widget.colour_saved_palette[n] = pygui.Vec4Ptr(*pygui.color_convert_hsv_to_rgb(
                    n / 31,
                    0.8,
                    0.8
                ))
                widget.colour_saved_palette[n].w = 1 # Alpha
            widget.colour_saved_palette_init.value = False
        
        open_popup = pygui.color_button("MyColor##3b", widget.colour_color.vec(), misc_flags)
        pygui.same_line(0, pygui.get_style().item_inner_spacing[0])
        open_popup = open_popup or pygui.button("Palette")
        if open_popup:
            pygui.open_popup("mypicker")
            widget.colour_backup_color = widget.colour_color.copy()
        if pygui.begin_popup("mypicker"):
            pygui.text("MY CUSTOM COLOR PICKER WITH AN AMAZING PALETTE!")
            pygui.separator()
            pygui.color_picker4("##picker", widget.colour_color, misc_flags | pygui.COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW | pygui.COLOR_EDIT_FLAGS_NO_SMALL_PREVIEW)
            pygui.same_line()

            pygui.begin_group()
            pygui.text("Current")
            pygui.color_button("##current", widget.colour_color.vec(), pygui.COLOR_EDIT_FLAGS_NO_PICKER | pygui.COLOR_EDIT_FLAGS_ALPHA_PREVIEW_HALF, (60, 40))
            pygui.text("Previous")
            if pygui.color_button("##previous", widget.colour_backup_color.vec(), pygui.COLOR_EDIT_FLAGS_NO_PICKER | pygui.COLOR_EDIT_FLAGS_ALPHA_PREVIEW_HALF, (60, 40)):
                widget.colour_color = widget.colour_backup_color.copy()
            pygui.separator()
            pygui.text("Palette")
            for n in range(len(widget.colour_saved_palette)):
                pygui.push_id_int(n)
                if n % 8 != 0:
                    pygui.same_line(0, pygui.get_style().item_spacing[0])
                
                palette_button_flags = \
                    pygui.COLOR_EDIT_FLAGS_NO_ALPHA | \
                    pygui.COLOR_EDIT_FLAGS_NO_PICKER | \
                    pygui.COLOR_EDIT_FLAGS_NO_TOOLTIP
                if pygui.color_button("##palette", widget.colour_saved_palette[n].vec(), palette_button_flags, (20, 20)):
                    preserved_alpha = widget.colour_color.w
                    widget.colour_color = widget.colour_saved_palette[n].copy()
                    widget.colour_color.w = preserved_alpha

                # Allow user to drop colors into each palette entry. Note that ColorButton() is already a
                # drag source by default, unless specifying the ImGuiColorEditFlags_NoDragDrop flag.
                # Pygui note. In the pyx file the accept drap drop payload for
                # the color 3f and 4f types will return Vec4Ptr containing the
                # color that is being dragged.
                if pygui.begin_drag_drop_target():
                    payload = pygui.accept_drag_drop_payload(pygui.PAYLOAD_TYPE_COLOR_3F)
                    payload: pygui.Vec4Ptr
                    if payload is not None:
                        preserved_alpha = widget.colour_saved_palette[n].w
                        widget.colour_saved_palette[n] = payload.copy()
                        widget.colour_saved_palette[n].w = preserved_alpha
                    
                    payload = pygui.accept_drag_drop_payload(pygui.PAYLOAD_TYPE_COLOR_4F)
                    payload: pygui.Vec4Ptr
                    if payload is not None:
                        preserved_alpha = widget.colour_saved_palette[n].w
                        widget.colour_saved_palette[n] = payload.copy()
                        widget.colour_saved_palette[n].w = preserved_alpha
                    pygui.end_drag_drop_target()
                
                pygui.pop_id()
            pygui.end_group()
            pygui.end_popup()

        pygui.text("Color button only:")
        pygui.checkbox("ImGuiColorEditFlags_NoBorder", widget.colour_no_border)
        pygui.color_button(
            "MyColor##3c",
            widget.colour_color.vec(),
            misc_flags | (pygui.COLOR_EDIT_FLAGS_NO_BORDER if widget.colour_no_border else 0),
            (80, 80))
        
        pygui.separator_text("Color picker")
        pygui.checkbox("With Alpha", widget.colour_alpha)
        pygui.checkbox("With Alpha Bar", widget.colour_alpha_bar)
        pygui.checkbox("With Side Preview Bar", widget.colour_side_preview)
        if widget.colour_side_preview:
            pygui.same_line()
            pygui.checkbox("With Ref Color", widget.colour_ref_color)
            if widget.colour_ref_color:
                pygui.same_line()
                pygui.color_edit4("##RefColor", widget.colour_ref_color_v, pygui.COLOR_EDIT_FLAGS_NO_INPUTS | misc_flags)
        pygui.combo("Display Mode", widget.colour_display_mode, ["Auto/Current", "None", "RGB Only", "HSV Only", "Hex Only"])
        pygui.same_line()
        help_marker(
            "ColorEdit defaults to displaying RGB inputs if you don't specify a display mode, "
            "but the user can change it with a right-click on those inputs.\n\nColorPicker defaults to displaying RGB+HSV+Hex "
            "if you don't specify a display mode.\n\nYou can change the defaults using SetColorEditOptions().")
        pygui.same_line()
        help_marker("When not specified explicitly (Auto/Current mode), user can right-click the picker to change mode.")
        flags = misc_flags
        if not widget.colour_alpha: # This is by default if you call ColorPicker3() instead of ColorPicker4()
            flags |= pygui.COLOR_EDIT_FLAGS_NO_ALPHA
        if widget.colour_alpha_bar:
            flags |= pygui.COLOR_EDIT_FLAGS_ALPHA_BAR
        if not widget.colour_side_preview:
            flags |= pygui.COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW
        if widget.colour_picker_mode.value == 1:
            flags |= pygui.COLOR_EDIT_FLAGS_PICKER_HUE_BAR
        if widget.colour_picker_mode.value == 2:
            flags |= pygui.COLOR_EDIT_FLAGS_PICKER_HUE_WHEEL
        if widget.colour_display_mode.value == 1:
            flags |= pygui.COLOR_EDIT_FLAGS_NO_INPUTS # Disable all RGB/HSV/Hex displays
        if widget.colour_display_mode.value == 2:
            flags |= pygui.COLOR_EDIT_FLAGS_DISPLAY_RGB # Override display mode
        if widget.colour_display_mode.value == 3:
            flags |= pygui.COLOR_EDIT_FLAGS_DISPLAY_HSV
        if widget.colour_display_mode.value == 4:
            flags |= pygui.COLOR_EDIT_FLAGS_DISPLAY_HEX

        pygui.color_picker4("MyColor##4", widget.colour_color, flags, widget.colour_ref_color_v if widget.colour_ref_color else None)

        pygui.text("Set defaults in code:")
        pygui.same_line()
        help_marker("SetColorEditOptions() is designed to allow you to set boot-time default.\n"
            "We don't have Push/Pop functions because you can force options on a per-widget basis if needed,"
            "and the user can change non-forced ones with the options menu.\nWe don't have a getter to avoid"
            "encouraging you to persistently save values that aren't forward-compatible.")
        if pygui.button("Default: Uint8 + HSV + Hue Bar"):
            pygui.set_color_edit_options(pygui.COLOR_EDIT_FLAGS_UINT8 | pygui.COLOR_EDIT_FLAGS_DISPLAY_HSV | pygui.COLOR_EDIT_FLAGS_PICKER_HUE_BAR)
        if pygui.button("Default: Float + HDR + Hue Wheel"):
            pygui.set_color_edit_options(pygui.COLOR_EDIT_FLAGS_FLOAT | pygui.COLOR_EDIT_FLAGS_HDR | pygui.COLOR_EDIT_FLAGS_PICKER_HUE_WHEEL)

        # Always both a small version of both types of pickers (to make it more visible in the demo to people who are skimming quickly through it)
        pygui.text("Both types:")
        w = (pygui.get_content_region_avail()[0] - pygui.get_style().item_spacing[1]) * 0.4
        pygui.set_next_item_width(w)
        pygui.color_picker3("##MyColor##5", widget.colour_color, pygui.COLOR_EDIT_FLAGS_PICKER_HUE_BAR | pygui.COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW | pygui.COLOR_EDIT_FLAGS_NO_INPUTS | pygui.COLOR_EDIT_FLAGS_NO_ALPHA)
        pygui.same_line()
        pygui.set_next_item_width(w)
        pygui.color_picker3("##MyColor##6", widget.colour_color, pygui.COLOR_EDIT_FLAGS_PICKER_HUE_WHEEL | pygui.COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW | pygui.COLOR_EDIT_FLAGS_NO_INPUTS | pygui.COLOR_EDIT_FLAGS_NO_ALPHA)

        # HSV encoded support (to avoid RGB<>HSV round trips and singularities when S==0 or V==0)
        pygui.spacing()
        pygui.text("HSV encoded colors")
        pygui.same_line()
        help_marker(
            "By default, colors are given to ColorEdit and ColorPicker in RGB, but ImGuiColorEditFlags_InputHSV"
            "allows you to store colors as HSV and pass them to ColorEdit and ColorPicker as HSV. This comes with the"
            "added benefit that you can manipulate hue values with the picker even when saturation or value are zero.")
        pygui.text("Color widget with InputHSV:")
        pygui.color_edit4("HSV shown as RGB##1", widget.colour_color_hsv, pygui.COLOR_EDIT_FLAGS_DISPLAY_RGB | pygui.COLOR_EDIT_FLAGS_INPUT_HSV | pygui.COLOR_EDIT_FLAGS_FLOAT)
        pygui.color_edit4("HSV shown as HSV##1", widget.colour_color_hsv, pygui.COLOR_EDIT_FLAGS_DISPLAY_HSV | pygui.COLOR_EDIT_FLAGS_INPUT_HSV | pygui.COLOR_EDIT_FLAGS_FLOAT)
        drag_floats = [pygui.FloatPtr(v) for v in widget.colour_color_hsv.vec()]
        pygui.drag_float4("Raw HSV values", drag_floats, 0.01, 0, 1)
        widget.colour_color_hsv = pygui.Vec4Ptr(*(f.value for f in drag_floats))

        pygui.tree_pop()

    if pygui.tree_node("Data Types"):
        INT_MIN = (-2147483647 - 1)
        INT_MAX = 2147483647
        UINT_MAX = 0xffffffff
        LLONG_MIN = (-9223372036854775807 - 1)
        LLONG_MAX = 9223372036854775807
        ULLONG_MAX = 0xffffffffffffffff
        IM_PRId64 = "I64d"
        IM_PRIu64 = "I64u"
        s8_zero  = 0;  s8_one  = 1;  s8_fifty  = 50;  s8_min  = -128;         s8_max = 127
        u8_zero  = 0;  u8_one  = 1;  u8_fifty  = 50;  u8_min  = 0;            u8_max = 255
        s16_zero = 0;  s16_one = 1;  s16_fifty = 50;  s16_min = -32768;       s16_max = 32767
        u16_zero = 0;  u16_one = 1;  u16_fifty = 50;  u16_min = 0;            u16_max = 65535
        s32_zero = 0;  s32_one = 1;  s32_fifty = 50;  s32_min = INT_MIN//2;   s32_max = INT_MAX//2;    s32_hi_a = INT_MAX//2 - 100;    s32_hi_b = INT_MAX//2
        u32_zero = 0;  u32_one = 1;  u32_fifty = 50;  u32_min = 0;            u32_max = UINT_MAX//2;   u32_hi_a = UINT_MAX//2 - 100;   u32_hi_b = UINT_MAX//2
        s64_zero = 0;  s64_one = 1;  s64_fifty = 50;  s64_min = LLONG_MIN//2; s64_max = LLONG_MAX//2;  s64_hi_a = LLONG_MAX//2 - 100;  s64_hi_b = LLONG_MAX//2
        u64_zero = 0;  u64_one = 1;  u64_fifty = 50;  u64_min = 0;            u64_max = ULLONG_MAX//2; u64_hi_a = ULLONG_MAX//2 - 100; u64_hi_b = ULLONG_MAX//2
        f32_zero = 0;  f32_one = 1;  f32_lo_a = -10000000000;      f32_hi_a = +10000000000
        f64_zero = 0;  f64_one = 1;  f64_lo_a = -1000000000000000; f64_hi_a = +1000000000000000

        pygui.separator_text("Drags")
        pygui.checkbox("Clamp integers to 0..50", widget.data_drag_clamp)
        drag_clamp = widget.data_drag_clamp.value

        pygui.drag_scalar("drag s8",         pygui.DATA_TYPE_S8,     widget.data_s8_v,  1,       s8_zero  if drag_clamp else None, s8_fifty  if drag_clamp else None)
        pygui.drag_scalar("drag u8",         pygui.DATA_TYPE_U8,     widget.data_u8_v,  1,       u8_zero  if drag_clamp else None, u8_fifty  if drag_clamp else None, "%u ms")
        pygui.drag_scalar("drag s16",        pygui.DATA_TYPE_S16,    widget.data_s16_v, 1 << 8,  s16_zero if drag_clamp else None, s16_fifty if drag_clamp else None)
        pygui.drag_scalar("drag u16",        pygui.DATA_TYPE_U16,    widget.data_u16_v, 1 << 8,  u16_zero if drag_clamp else None, u16_fifty if drag_clamp else None, "%u ms")
        pygui.drag_scalar("drag s32",        pygui.DATA_TYPE_S32,    widget.data_s32_v, 1 << 24, s32_zero if drag_clamp else None, s32_fifty if drag_clamp else None)
        pygui.drag_scalar("drag s32 hex",    pygui.DATA_TYPE_S32,    widget.data_s32_v, 1 << 24, s32_zero if drag_clamp else None, s32_fifty if drag_clamp else None, "0x%08X")
        pygui.drag_scalar("drag u32",        pygui.DATA_TYPE_U32,    widget.data_u32_v, 1 << 24, u32_zero if drag_clamp else None, u32_fifty if drag_clamp else None, "%u ms")
        pygui.drag_scalar("drag s64",        pygui.DATA_TYPE_S64,    widget.data_s64_v, 1 << 56, s64_zero if drag_clamp else None, s64_fifty if drag_clamp else None)
        pygui.drag_scalar("drag u64",        pygui.DATA_TYPE_U64,    widget.data_u64_v, 1 << 56, u64_zero if drag_clamp else None, u64_fifty if drag_clamp else None)
        pygui.drag_scalar("drag float",      pygui.DATA_TYPE_FLOAT,  widget.data_f32_v, 0.005,   f32_zero, f32_one, "%f")
        pygui.drag_scalar("drag float log",  pygui.DATA_TYPE_FLOAT,  widget.data_f32_v, 0.005,   f32_zero, f32_one, "%f", pygui.SLIDER_FLAGS_LOGARITHMIC)
        pygui.drag_scalar("drag double",     pygui.DATA_TYPE_DOUBLE, widget.data_f64_v, 0.0005,  f64_zero, None,    "%.10f grams")
        pygui.drag_scalar("drag double log", pygui.DATA_TYPE_DOUBLE, widget.data_f64_v, 0.0005,  f64_zero, f64_one, "0 < %.10f < 1", pygui.SLIDER_FLAGS_LOGARITHMIC)


        pygui.separator_text("Sliders")
        pygui.slider_scalar("slider s8 full",       pygui.DATA_TYPE_S8,     widget.data_s8_v,  s8_min,   s8_max,   "%d")
        pygui.slider_scalar("slider u8 full",       pygui.DATA_TYPE_U8,     widget.data_u8_v,  u8_min,   u8_max,   "%u")
        pygui.slider_scalar("slider s16 full",      pygui.DATA_TYPE_S16,    widget.data_s16_v, s16_min,  s16_max,  "%d")
        pygui.slider_scalar("slider u16 full",      pygui.DATA_TYPE_U16,    widget.data_u16_v, u16_min,  u16_max,  "%u")
        pygui.slider_scalar("slider s32 low",       pygui.DATA_TYPE_S32,    widget.data_s32_v, s32_zero, s32_fifty,"%d")
        pygui.slider_scalar("slider s32 high",      pygui.DATA_TYPE_S32,    widget.data_s32_v, s32_hi_a, s32_hi_b, "%d")
        pygui.slider_scalar("slider s32 full",      pygui.DATA_TYPE_S32,    widget.data_s32_v, s32_min,  s32_max,  "%d")
        pygui.slider_scalar("slider s32 hex",       pygui.DATA_TYPE_S32,    widget.data_s32_v, s32_zero, s32_fifty, "0x%04X")
        pygui.slider_scalar("slider u32 low",       pygui.DATA_TYPE_U32,    widget.data_u32_v, u32_zero, u32_fifty,"%u")
        pygui.slider_scalar("slider u32 high",      pygui.DATA_TYPE_U32,    widget.data_u32_v, u32_hi_a, u32_hi_b, "%u")
        pygui.slider_scalar("slider u32 full",      pygui.DATA_TYPE_U32,    widget.data_u32_v, u32_min,  u32_max,  "%u")
        pygui.slider_scalar("slider s64 low",       pygui.DATA_TYPE_S64,    widget.data_s64_v, s64_zero, s64_fifty,"%" + IM_PRId64)
        pygui.slider_scalar("slider s64 high",      pygui.DATA_TYPE_S64,    widget.data_s64_v, s64_hi_a, s64_hi_b, "%" + IM_PRId64)
        pygui.slider_scalar("slider s64 full",      pygui.DATA_TYPE_S64,    widget.data_s64_v, s64_min,  s64_max,  "%" + IM_PRId64)
        pygui.slider_scalar("slider u64 low",       pygui.DATA_TYPE_U64,    widget.data_u64_v, u64_zero, u64_fifty,"%" + IM_PRIu64 + " ms")
        pygui.slider_scalar("slider u64 high",      pygui.DATA_TYPE_U64,    widget.data_u64_v, u64_hi_a, u64_hi_b, "%" + IM_PRIu64 + " ms")
        pygui.slider_scalar("slider u64 full",      pygui.DATA_TYPE_U64,    widget.data_u64_v, u64_min,  u64_max,  "%" + IM_PRIu64 + " ms")
        pygui.slider_scalar("slider float low",     pygui.DATA_TYPE_FLOAT,  widget.data_f32_v, f32_zero, f32_one)
        pygui.slider_scalar("slider float low log", pygui.DATA_TYPE_FLOAT,  widget.data_f32_v, f32_zero, f32_one,  "%.10f", pygui.SLIDER_FLAGS_LOGARITHMIC)
        pygui.slider_scalar("slider float high",    pygui.DATA_TYPE_FLOAT,  widget.data_f32_v, f32_lo_a, f32_hi_a, "%e")
        pygui.slider_scalar("slider double low",    pygui.DATA_TYPE_DOUBLE, widget.data_f64_v, f64_zero, f64_one,  "%.10f grams")
        pygui.slider_scalar("slider double low log",pygui.DATA_TYPE_DOUBLE, widget.data_f64_v, f64_zero, f64_one,  "%.10f", pygui.SLIDER_FLAGS_LOGARITHMIC)
        pygui.slider_scalar("slider double high",   pygui.DATA_TYPE_DOUBLE, widget.data_f64_v, f64_lo_a, f64_hi_a, "%e grams")

        pygui.separator_text("Sliders (reverse)")
        pygui.slider_scalar("slider s8 reverse",    pygui.DATA_TYPE_S8,   widget.data_s8_v,  s8_max,    s8_min,   "%d")
        pygui.slider_scalar("slider u8 reverse",    pygui.DATA_TYPE_U8,   widget.data_u8_v,  u8_max,    u8_min,   "%u")
        pygui.slider_scalar("slider s32 reverse",   pygui.DATA_TYPE_S32,  widget.data_s32_v, s32_fifty, s32_zero, "%d")
        pygui.slider_scalar("slider u32 reverse",   pygui.DATA_TYPE_U32,  widget.data_u32_v, u32_fifty, u32_zero, "%u")
        pygui.slider_scalar("slider s64 reverse",   pygui.DATA_TYPE_S64,  widget.data_s64_v, s64_fifty, s64_zero, "%" + IM_PRId64)
        pygui.slider_scalar("slider u64 reverse",   pygui.DATA_TYPE_U64,  widget.data_u64_v, u64_fifty, u64_zero, "%" + IM_PRIu64 + " ms")

        pygui.separator_text("Inputs")
        pygui.checkbox("Show step buttons", widget.data_inputs_step)
        pygui.input_scalar("input s8",      pygui.DATA_TYPE_S8,     widget.data_s8_v,  s8_one  if widget.data_inputs_step else None, None, "%d")
        pygui.input_scalar("input u8",      pygui.DATA_TYPE_U8,     widget.data_u8_v,  u8_one  if widget.data_inputs_step else None, None, "%u")
        pygui.input_scalar("input s16",     pygui.DATA_TYPE_S16,    widget.data_s16_v, s16_one if widget.data_inputs_step else None, None, "%d")
        pygui.input_scalar("input u16",     pygui.DATA_TYPE_U16,    widget.data_u16_v, u16_one if widget.data_inputs_step else None, None, "%u")
        pygui.input_scalar("input s32",     pygui.DATA_TYPE_S32,    widget.data_s32_v, s32_one if widget.data_inputs_step else None, None, "%d")
        pygui.input_scalar("input s32 hex", pygui.DATA_TYPE_S32,    widget.data_s32_v, s32_one if widget.data_inputs_step else None, None, "%04X")
        pygui.input_scalar("input u32",     pygui.DATA_TYPE_U32,    widget.data_u32_v, u32_one if widget.data_inputs_step else None, None, "%u")
        pygui.input_scalar("input u32 hex", pygui.DATA_TYPE_U32,    widget.data_u32_v, u32_one if widget.data_inputs_step else None, None, "%08X")
        pygui.input_scalar("input s64",     pygui.DATA_TYPE_S64,    widget.data_s64_v, s64_one if widget.data_inputs_step else None)
        pygui.input_scalar("input u64",     pygui.DATA_TYPE_U64,    widget.data_u64_v, u64_one if widget.data_inputs_step else None)
        pygui.input_scalar("input float",   pygui.DATA_TYPE_FLOAT,  widget.data_f32_v, f32_one if widget.data_inputs_step else None)
        pygui.input_scalar("input double",  pygui.DATA_TYPE_DOUBLE, widget.data_f64_v, f64_one if widget.data_inputs_step else None)

        # The _n versions. These are annoying.
        pygui.separator_text("Drag Scalar N")
        help_marker(
            "This example demonstrates the importance of selecting the correct data type.\n"
            " 4 * 1 byte (s8/u8)   chars  == 1 * 4 byte int.\n"
            " 2 * 2 byte (s16/u16) shorts == 1 * 4 byte int.\n"
            " 2 * 4 byte (s16/u16) ints   == 1 * 8 byte long.\n"
            " So if you want to edit an integer then you should select S32 as the type. Otherwise, this actually makes"
            " a neat way to edit the bits of an integer"
            )
        pygui.drag_scalar_n("drag_n s8",      pygui.DATA_TYPE_S8,     widget.data_long_n, 16)
        pygui.drag_scalar_n("drag_n u8",      pygui.DATA_TYPE_U8,     widget.data_long_n, 16)
        pygui.drag_scalar_n("drag_n s16",     pygui.DATA_TYPE_S16,    widget.data_long_n, 8)
        pygui.drag_scalar_n("drag_n u16",     pygui.DATA_TYPE_U16,    widget.data_long_n, 8)
        pygui.drag_scalar_n("drag_n s32",     pygui.DATA_TYPE_S32,    widget.data_long_n, 4)
        pygui.drag_scalar_n("drag_n s32 hex", pygui.DATA_TYPE_S32,    widget.data_long_n, 4)
        pygui.drag_scalar_n("drag_n u32",     pygui.DATA_TYPE_U32,    widget.data_long_n, 4, 1 << 22)
        pygui.drag_scalar_n("drag_n u32 hex", pygui.DATA_TYPE_U32,    widget.data_long_n, 4, 1 << 22)
        pygui.drag_scalar_n("drag_n s64",     pygui.DATA_TYPE_S64,    widget.data_long_n, 2, 1 << 54)
        pygui.drag_scalar_n("drag_n u64",     pygui.DATA_TYPE_U64,    widget.data_long_n, 2, 1 << 54)
        pygui.drag_scalar_n("drag_n float",   pygui.DATA_TYPE_FLOAT,  widget.data_float_n, 4)
        pygui.drag_scalar_n("drag_n double",  pygui.DATA_TYPE_DOUBLE, widget.data_double_n, 4)

        pygui.separator_text("Slider Scalar N")
        pygui.slider_scalar_n("slider_n s8",      pygui.DATA_TYPE_S8,     widget.data_long_n, 16,  s8_min,  s8_max)
        pygui.slider_scalar_n("slider_n u8",      pygui.DATA_TYPE_U8,     widget.data_long_n, 16,  u8_min,  u8_max)
        pygui.slider_scalar_n("slider_n s16",     pygui.DATA_TYPE_S16,    widget.data_long_n, 8,   s16_min, s16_max)
        pygui.slider_scalar_n("slider_n u16",     pygui.DATA_TYPE_U16,    widget.data_long_n, 8,   u16_min, u16_max)
        pygui.slider_scalar_n("slider_n s32",     pygui.DATA_TYPE_S32,    widget.data_long_n, 4,   s32_min, s32_max)
        pygui.slider_scalar_n("slider_n s32 hex", pygui.DATA_TYPE_S32,    widget.data_long_n, 4,   s32_min, s32_max)
        pygui.slider_scalar_n("slider_n u32",     pygui.DATA_TYPE_U32,    widget.data_long_n, 4,   u32_min, u32_max)
        pygui.slider_scalar_n("slider_n u32 hex", pygui.DATA_TYPE_U32,    widget.data_long_n, 4,   u32_min, u32_max)
        pygui.slider_scalar_n("slider_n s64",     pygui.DATA_TYPE_S64,    widget.data_long_n, 2,   s64_min, s64_max)
        pygui.slider_scalar_n("slider_n u64",     pygui.DATA_TYPE_U64,    widget.data_long_n, 2,   u64_min, u64_max)
        pygui.slider_scalar_n("slider_n float",   pygui.DATA_TYPE_FLOAT,  widget.data_float_n, 4,  f32_lo_a, f32_hi_a)
        pygui.slider_scalar_n("slider_n double",  pygui.DATA_TYPE_DOUBLE, widget.data_double_n, 4, f64_lo_a, f64_hi_a)

        pygui.separator_text("Input Scalar N")
        pygui.input_scalar_n("input_n s8",      pygui.DATA_TYPE_S8,     widget.data_long_n, 8,   1,    10) # It works with 16 but looks terrible
        pygui.input_scalar_n("input_n u8",      pygui.DATA_TYPE_U8,     widget.data_long_n, 8,   2,    20)
        pygui.input_scalar_n("input_n s16",     pygui.DATA_TYPE_S16,    widget.data_long_n, 8,   3,    30)
        pygui.input_scalar_n("input_n u16",     pygui.DATA_TYPE_U16,    widget.data_long_n, 8,   4,    40)
        pygui.input_scalar_n("input_n s32",     pygui.DATA_TYPE_S32,    widget.data_long_n, 4,   5,    50)
        pygui.input_scalar_n("input_n s32 hex", pygui.DATA_TYPE_S32,    widget.data_long_n, 4,   6,    60)
        pygui.input_scalar_n("input_n u32",     pygui.DATA_TYPE_U32,    widget.data_long_n, 4,   7,    70)
        pygui.input_scalar_n("input_n u32 hex", pygui.DATA_TYPE_U32,    widget.data_long_n, 4,   8,    80)
        pygui.input_scalar_n("input_n s64",     pygui.DATA_TYPE_S64,    widget.data_long_n, 2,   9,    90)
        pygui.input_scalar_n("input_n u64",     pygui.DATA_TYPE_U64,    widget.data_long_n, 2,   10,   100)
        pygui.input_scalar_n("input_n float",   pygui.DATA_TYPE_FLOAT,  widget.data_float_n, 4,  0.1,  1)
        pygui.input_scalar_n("input_n double",  pygui.DATA_TYPE_DOUBLE, widget.data_double_n, 4, 0.01, 0.1)
        pygui.tree_pop()

    if pygui.tree_node("Multi-component Widgets"):
        pygui.separator_text("2-wide")
        pygui.input_float2("input float2", widget.multi_vec4f.as_floatptrs())
        pygui.drag_float2("drag float2", widget.multi_vec4f.as_floatptrs(), 0.01, 0, 1)
        pygui.slider_float2("slider float2", widget.multi_vec4f.as_floatptrs(), 0, 1)
        pygui.input_int2("input int2", widget.multi_vec4i.as_floatptrs())
        pygui.drag_int2("drag int2", widget.multi_vec4i.as_floatptrs(), 1, 0, 255)
        pygui.slider_int2("slider int2", widget.multi_vec4i.as_floatptrs(), 0, 255)

        pygui.separator_text("3-wide")
        pygui.input_float3("input float3", widget.multi_vec4f.as_floatptrs())
        pygui.drag_float3("drag float3", widget.multi_vec4f.as_floatptrs(), 0.01, 0, 1)
        pygui.slider_float3("slider float3", widget.multi_vec4f.as_floatptrs(), 0, 1)
        pygui.input_int3("input int3", widget.multi_vec4i.as_floatptrs())
        pygui.drag_int3("drag int3", widget.multi_vec4i.as_floatptrs(), 1, 0, 255)
        pygui.slider_int3("slider int3", widget.multi_vec4i.as_floatptrs(), 0, 255)

        pygui.separator_text("4-wide")
        pygui.input_float4("input float4", widget.multi_vec4f.as_floatptrs())
        pygui.drag_float4("drag float4", widget.multi_vec4f.as_floatptrs(), 0.01, 0, 1)
        pygui.slider_float4("slider float4", widget.multi_vec4f.as_floatptrs(), 0, 1)
        pygui.input_int4("input int4", widget.multi_vec4i.as_floatptrs())
        pygui.drag_int4("drag int4", widget.multi_vec4i.as_floatptrs(), 1, 0, 255)
        pygui.slider_int4("slider int4", widget.multi_vec4i.as_floatptrs(), 0, 255)

        pygui.tree_pop()


class layout:
    scroll_track_item = pygui.IntPtr(50)
    scroll_enable_track = pygui.BoolPtr(True)
    scroll_enable_extra_decorations = pygui.BoolPtr(False)
    scroll_scroll_to_off_px = pygui.FloatPtr(0)
    scroll_scroll_to_pos_px = pygui.FloatPtr(200)
    scroll_lines = pygui.IntPtr(7)


def show_demo_window_layout():
    if not pygui.collapsing_header("Layout & Scrolling"):
        return
    
    if pygui.tree_node("Scrolling"):
        help_marker("Use SetScrollHereY() or SetScrollFromPosY() to scroll to a given vertical position.")
        pygui.checkbox("Decoration", layout.scroll_enable_extra_decorations)
        pygui.checkbox("Track", layout.scroll_enable_track)
        pygui.push_item_width(100)
        pygui.same_line(140)
        layout.scroll_enable_track.value |= pygui.drag_int("##item", layout.scroll_track_item, 0.25, 0, 99, "Item = %d")

        scroll_to_off = pygui.button("Scroll Offset")
        pygui.same_line(140)
        scroll_to_off |= pygui.drag_float("##off", layout.scroll_scroll_to_off_px, 1, 0, pygui.FLT_MAX, "+%.0f px")

        scroll_to_pos = pygui.button("Scroll To Pos")
        pygui.same_line(140)
        scroll_to_pos |= pygui.drag_float("##pos", layout.scroll_scroll_to_pos_px, 1, -10, pygui.FLT_MAX, "X/Y = %.0f px")
        pygui.pop_item_width()

        if scroll_to_off or scroll_to_pos:
            layout.scroll_enable_track.value = False
        
        style = pygui.get_style()
        child_w = (pygui.get_content_region_avail()[0] - 4 * style.item_spacing[0]) / 5
        if child_w < 1:
            child_w = 1
        pygui.push_id("##VerticalScrolling")
        for i in range(5):
            if i > 0:
                pygui.same_line()
            pygui.begin_group()
            names = ["Top", "25%", "Center", "75%", "Bottom"]
            pygui.text_unformatted(names[i])

            child_flags = pygui.WINDOW_FLAGS_MENU_BAR if layout.scroll_enable_extra_decorations else 0
            child_id = pygui.get_id(str(i))
            child_is_visible = pygui.begin_child(str(child_id), (child_w, 200), True, child_flags)
            if pygui.begin_menu_bar():
                pygui.text_unformatted("abc")
                pygui.end_menu_bar()
            if scroll_to_off:
                pygui.set_scroll_y(layout.scroll_scroll_to_off_px.value)
            if scroll_to_pos:
                pygui.set_scroll_from_pos_y(pygui.get_cursor_start_pos()[1] + layout.scroll_scroll_to_pos_px.value, i * 0.25)
            if child_is_visible: # Avoid calling SetScrollHereY when running with culled items
                for item in range(100):
                    if layout.scroll_enable_track and item == layout.scroll_track_item.value:
                        pygui.text_colored((1, 1, 0, 1), "Item {}".format(item))
                        pygui.set_scroll_here_y(i * 0.25) # 0.0f:top, 0.5f:center, 1.0f:bottom
                    else:
                        pygui.text("Item {}".format(item))
            scroll_y = pygui.get_scroll_y()
            scroll_max_y = pygui.get_scroll_max_y()
            pygui.end_child()
            pygui.text("{:.0f}/{:.0f}".format(scroll_y, scroll_max_y))
            pygui.end_group()
        pygui.pop_id()

        # Horizontal scroll functions
        pygui.spacing()
        help_marker(
            "Use SetScrollHereX() or SetScrollFromPosX() to scroll to a given horizontal position.\n\n"
            "Because the clipping rectangle of most window hides half worth of WindowPadding on the "
            "left/right, using SetScrollFromPosX(+1) will usually result in clipped text whereas the "
            "equivalent SetScrollFromPosY(+1) wouldn't.")
        pygui.push_id("##HorizontalScrolling")
        for i in range(5):
            child_height = pygui.get_text_line_height() + style.scrollbar_size + style.window_padding[1] * 2
            child_flags = pygui.WINDOW_FLAGS_HORIZONTAL_SCROLLBAR | (pygui.WINDOW_FLAGS_ALWAYS_VERTICAL_SCROLLBAR if layout.scroll_enable_extra_decorations else 0)
            child_id = pygui.get_id(str(i))
            child_is_visible = pygui.begin_child(str(child_id), (-100, child_height), True, child_flags)
            if scroll_to_off:
                pygui.set_scroll_x(layout.scroll_scroll_to_off_px.value)
            if scroll_to_pos:
                pygui.set_scroll_from_pos_x(pygui.get_cursor_start_pos()[0] + layout.scroll_scroll_to_pos_px.value, i * 0.25)
            if child_is_visible: # Avoid calling SetScrollHereY when running with culled items
                for item in range(100):
                    if item > 0:
                        pygui.same_line();
                    if (layout.scroll_enable_track and item == layout.scroll_track_item.value):
                        pygui.text_colored((1, 1, 0, 1), "Item {}".format(item))
                        pygui.set_scroll_here_x(i * 0.25); # 0.0f:left, 0.5f:center, 1.0f:right
                    else:
                        pygui.text("Item {}".format(item))
            scroll_x = pygui.get_scroll_x()
            scroll_max_x = pygui.get_scroll_max_x()
            pygui.end_child()
            pygui.same_line()
            names = ["Left", "25%", "Center", "75%", "Right"]
            pygui.text("{}\n{:.0f}/{:.0f}".format(names[i], scroll_x, scroll_max_x))
            pygui.spacing()
        pygui.pop_id()

        # Miscellaneous Horizontal Scrolling Demo
        help_marker(
            "Horizontal scrolling for a window is enabled via the ImGuiWindowFlags_HorizontalScrollbar flag.\n\n"
            "You may want to also explicitly specify content width by using SetNextWindowContentWidth() before Begin().")
        pygui.slider_int("Lines", layout.scroll_lines, 1, 15)
        pygui.push_style_var(pygui.STYLE_VAR_FRAME_ROUNDING, 3)
        pygui.push_style_var_im_vec2(pygui.STYLE_VAR_FRAME_PADDING, (2, 1))
        scrolling_child_size = (0, pygui.get_frame_height_with_spacing() * 7 + 30)
        pygui.begin_child("scrolling", scrolling_child_size, True, pygui.WINDOW_FLAGS_HORIZONTAL_SCROLLBAR)
        for line in range(layout.scroll_lines.value):
            # Display random stuff. For the sake of this trivial demo we are using basic Button() + SameLine()
            # If you want to create your own time line for a real application you may be better off manipulating
            # the cursor position yourself, aka using SetCursorPos/SetCursorScreenPos to position the widgets
            # yourself. You may also want to use the lower-level ImDrawList API.
            num_buttons = 10 + (line * 9 if line & 1 else line * 3)
            
            for n in range(num_buttons):
                if n > 0:
                    pygui.same_line()
                pygui.push_id(str(n + line * 1000))
                if n % 15 == 0:
                    label = "FizzBuzz"
                elif n % 3 == 0:
                    label = "Fizz"
                elif n % 5 == 0:
                    label = "Buzz"
                else:
                    label = str(n)
                hue = n * 0.05
                pygui.push_style_color_im_vec4(pygui.COL_BUTTON, pygui.color_convert_hsv_to_rgb(hue, 0.6, 0.6))
                pygui.push_style_color_im_vec4(pygui.COL_BUTTON_HOVERED, pygui.color_convert_hsv_to_rgb(hue, 0.7, 0.7))
                pygui.push_style_color_im_vec4(pygui.COL_BUTTON_ACTIVE, pygui.color_convert_hsv_to_rgb(hue, 0.8, 0.8))
                pygui.button(label, (40 + math.sin(line + n) * 20, 0))
                pygui.pop_style_color(3)
                pygui.pop_id()
        scroll_x = pygui.get_scroll_x()
        scroll_max_x = pygui.get_scroll_max_x()
        pygui.end_child()
        pygui.pop_style_var(2)
        scroll_x_delta = 0
        pygui.small_button("<<")
        if pygui.is_item_active():
            scroll_x_delta = -pygui.get_io().delta_time * 1000
        pygui.same_line()
        pygui.text("Scroll from code")
        pygui.same_line()
        pygui.small_button(">>")
        if pygui.is_item_active():
            scroll_x_delta = +pygui.get_io().delta_time * 1000
        pygui.same_line()
        pygui.text("{:.0f}/{:.0f}".format(scroll_x, scroll_max_x))
        if scroll_x_delta != 0:
            # Demonstrate a trick: you can use Begin to set yourself in the context of another window
            # (here we are already out of your child window)
            pygui.begin_child("scrolling")
            pygui.set_scroll_x(pygui.get_scroll_x() + scroll_x_delta)
            pygui.end_child()
        pygui.spacing()

        pygui.tree_pop()


class table:
    disable_indent = pygui.BoolPtr(False)
    border_flags = pygui.IntPtr(pygui.TABLE_FLAGS_BORDERS | pygui.TABLE_FLAGS_ROW_BG)
    class ContentsType(Enum):
        CT_TEXT = auto()
        CT_FILL_BUTTON = auto()
    border_display_headers = pygui.BoolPtr(False)
    border_contents_type = pygui.IntPtr(ContentsType.CT_TEXT.value)
    resize_flags = pygui.IntPtr( \
        pygui.TABLE_FLAGS_SIZING_STRETCH_SAME | \
        pygui.TABLE_FLAGS_RESIZABLE | \
        pygui.TABLE_FLAGS_BORDERS_OUTER | \
        pygui.TABLE_FLAGS_BORDERS_V | \
        pygui.TABLE_FLAGS_CONTEXT_MENU_IN_BODY)
    fixed_flags = pygui.IntPtr( \
        pygui.TABLE_FLAGS_SIZING_FIXED_FIT | \
        pygui.TABLE_FLAGS_RESIZABLE | \
        pygui.TABLE_FLAGS_BORDERS_OUTER | \
        pygui.TABLE_FLAGS_BORDERS_V | \
        pygui.TABLE_FLAGS_CONTEXT_MENU_IN_BODY)
    mixed_flags = pygui.IntPtr( \
        pygui.TABLE_FLAGS_SIZING_FIXED_FIT | \
        pygui.TABLE_FLAGS_ROW_BG | \
        pygui.TABLE_FLAGS_BORDERS | \
        pygui.TABLE_FLAGS_RESIZABLE | \
        pygui.TABLE_FLAGS_REORDERABLE | \
        pygui.TABLE_FLAGS_HIDEABLE)
    hidable_flags = pygui.IntPtr( \
        pygui.TABLE_FLAGS_RESIZABLE | \
        pygui.TABLE_FLAGS_REORDERABLE | \
        pygui.TABLE_FLAGS_HIDEABLE | \
        pygui.TABLE_FLAGS_BORDERS_OUTER | \
        pygui.TABLE_FLAGS_BORDERS_V)
    padding_flags = pygui.IntPtr( \
        pygui.TABLE_FLAGS_BORDERS_V)
    padding_show_headers = pygui.BoolPtr(False)
    padding_flags2 = pygui.IntPtr( \
        pygui.TABLE_FLAGS_BORDERS | \
        pygui.TABLE_FLAGS_ROW_BG)
    padding_cell_padding = pygui.Vec2Ptr(0, 0)
    padding_show_widget_frame_bg = pygui.BoolPtr(True)
    padding_text_bufs = [pygui.StrPtr("edit me", 16) for _ in range(3 * 15)]
    sort_items = []
    sort_flags = pygui.IntPtr( \
       pygui.TABLE_FLAGS_RESIZABLE | \
       pygui.TABLE_FLAGS_REORDERABLE | \
       pygui.TABLE_FLAGS_HIDEABLE | \
       pygui.TABLE_FLAGS_SORTABLE | \
       pygui.TABLE_FLAGS_SORT_MULTI | \
       pygui.TABLE_FLAGS_ROW_BG | \
       pygui.TABLE_FLAGS_BORDERS_OUTER | \
       pygui.TABLE_FLAGS_BORDERS_V | \
       pygui.TABLE_FLAGS_NO_BORDERS_IN_BODY | \
       pygui.TABLE_FLAGS_SCROLL_Y)
    
    # We are passing our own identifier to TableSetupColumn() to facilitate identifying columns in the sorting code.
    # This identifier will be passed down into ImGuiTableSortSpec::ColumnUserID.
    # But it is possible to omit the user id parameter of TableSetupColumn() and just use the column index instead! (ImGuiTableSortSpec::ColumnIndex)
    # If you don't use sorting, you will generally never care about giving column an ID!
    class MyItemColumnID(Enum):
        ID = auto()
        Name = auto()
        Action = auto()
        Quantity = auto()
        Description = auto()
    
    class MyItem:
        def __init__(self, _id: int, name: str, quantity: int):
            self._id = _id
            self.name = name
            self.quantity = quantity
        
        def get_column_field(self, column: int):
            """
            If you want to use this approach for sorting, then you need to make
            sure this matches the column order that is to be used in the table.
            """
            return [
                self._id,
                self.name,
                None,
                self.quantity
            ][column]
    
    # From: https://stackoverflow.com/a/75123782
    class negated: # name changed; otherwise the same
        def __init__(self, obj):
            self.obj = obj

        def __eq__(self, other):
            return other.obj == self.obj

        def __lt__(self, other):
            return other.obj < self.obj


def show_demo_tables():
    if not pygui.collapsing_header("Tables & Columns"):
        return
    
    TEXT_BASE_WIDTH = pygui.calc_text_size("A")[0]
    TEXT_BASE_HEIGHT = pygui.get_text_line_height_with_spacing()

    pygui.push_id("Tables")

    open_action = -1
    if pygui.button("Open all"):
        open_action = 1
    pygui.same_line()
    if pygui.button("Close all"):
        open_action = 0
    pygui.same_line()

    # Options
    pygui.checkbox("Disable tree indentation", table.disable_indent)
    pygui.same_line()
    help_marker("Disable the indenting of tree nodes so demo tables can use the full window width.")
    pygui.separator()
    if table.disable_indent:
        pygui.push_style_var(pygui.STYLE_VAR_INDENT_SPACING, 0)
    
    # About Styling of tables
    # Most settings are configured on a per-table basis via the flags passed to BeginTable() and TableSetupColumns APIs.
    # There are however a few settings that a shared and part of the ImGuiStyle structure:
    #   style.CellPadding                          // Padding within each cell
    #   style.Colors[ImGuiCol_TableHeaderBg]       // Table header background
    #   style.Colors[ImGuiCol_TableBorderStrong]   // Table outer and header borders
    #   style.Colors[ImGuiCol_TableBorderLight]    // Table inner borders
    #   style.Colors[ImGuiCol_TableRowBg]          // Table row background when ImGuiTableFlags_RowBg is enabled (even rows)
    #   style.Colors[ImGuiCol_TableRowBgAlt]       // Table row background when ImGuiTableFlags_RowBg is enabled (odds rows)
    
    if open_action != -1:
        pygui.set_next_item_open(open_action != 0)
    if pygui.tree_node("Basic"):
        # Here we will showcase three different ways to output a table.
        # They are very simple variations of a same thing!

        # [Method 1] Using TableNextRow() to create a new row, and TableSetColumnIndex() to select the column.
        # In many situations, this is the most flexible and easy to use pattern.
        help_marker("Using TableNextRow() + calling TableSetColumnIndex() _before_ each cell, in a loop.")
        if pygui.begin_table("table1", 3):
            for row in range(4):
                pygui.table_next_row()
                for column in range(3):
                    pygui.table_set_column_index(column)
                    pygui.text("Row {} Column {}".format(row, column))
            pygui.end_table()
        
        # [Method 2] Using TableNextColumn() called multiple times, instead of using a for loop + TableSetColumnIndex().
        # This is generally more convenient when you have code manually submitting the contents of each column.
        help_marker("Using TableNextRow() + calling TableNextColumn() _before_ each cell, manually.")
        if pygui.begin_table("table2", 3, 0):
            for row in range(4):
                pygui.table_next_row()
                pygui.table_next_column()
                pygui.text("Row {}".format(row))
                pygui.table_next_column()
                pygui.text("Some contents")
                pygui.table_next_column()
                pygui.text("123.456")
            pygui.end_table()
        
        # [Method 3] We call TableNextColumn() _before_ each cell. We never call TableNextRow(),
        # as TableNextColumn() will automatically wrap around and create new rows as needed.
        # This is generally more convenient when your cells all contains the same type of data.
        help_marker(
            "Only using TableNextColumn(), which tends to be convenient for tables where every cell contains the same type of contents.\n"
            "This is also more similar to the old NextColumn() function of the Columns API, and provided to facilitate the Columns->Tables API transition.")
        if pygui.begin_table("table3", 3):
            for item in range(14):
                pygui.table_next_column()
                pygui.text("Item {}".format(item))
            pygui.end_table()
        pygui.tree_pop()
    
    if open_action != -1:
        pygui.set_next_item_open(open_action != 0)
    if pygui.tree_node("Borders, background"):
        push_style_compact()
        pygui.checkbox_flags("ImGuiTableFlags_RowBg", table.border_flags, pygui.TABLE_FLAGS_ROW_BG)
        pygui.checkbox_flags("ImGuiTableFlags_Borders", table.border_flags, pygui.TABLE_FLAGS_BORDERS)
        pygui.same_line()
        help_marker(
            "ImGuiTableFlags_Borders\n = ImGuiTableFlags_BordersInnerV\n | ImGuiTableFlags_BordersOuterV\n | ImGuiTableFlags_BordersInnerV\n | ImGuiTableFlags_BordersOuterH")
        pygui.indent()

        pygui.checkbox_flags("ImGuiTableFlags_BordersH", table.border_flags, pygui.TABLE_FLAGS_BORDERS_H)
        pygui.indent()
        pygui.checkbox_flags("ImGuiTableFlags_BordersOuterH", table.border_flags, pygui.TABLE_FLAGS_BORDERS_OUTER_H)
        pygui.checkbox_flags("ImGuiTableFlags_BordersInnerH", table.border_flags, pygui.TABLE_FLAGS_BORDERS_INNER_H)
        pygui.unindent()

        pygui.checkbox_flags("ImGuiTableFlags_BordersV", table.border_flags, pygui.TABLE_FLAGS_BORDERS_V)
        pygui.indent()
        pygui.checkbox_flags("ImGuiTableFlags_BordersOuterV", table.border_flags, pygui.TABLE_FLAGS_BORDERS_OUTER_V)
        pygui.checkbox_flags("ImGuiTableFlags_BordersInnerV", table.border_flags, pygui.TABLE_FLAGS_BORDERS_INNER_V)
        pygui.unindent()

        pygui.checkbox_flags("ImGuiTableFlags_BordersOuter", table.border_flags, pygui.TABLE_FLAGS_BORDERS_OUTER)
        pygui.checkbox_flags("ImGuiTableFlags_BordersInner", table.border_flags, pygui.TABLE_FLAGS_BORDERS_INNER)
        pygui.unindent()

        pygui.align_text_to_frame_padding()
        pygui.text("Cell contents:")
        pygui.same_line()
        pygui.radio_button_int_ptr("Text", table.border_contents_type, table.ContentsType.CT_TEXT.value)
        pygui.same_line()
        pygui.radio_button_int_ptr("FillButton", table.border_contents_type, table.ContentsType.CT_FILL_BUTTON.value)
        pygui.checkbox("Display headers", table.border_display_headers)
        pygui.checkbox_flags("ImGuiTableFlags_NoBordersInBody", table.border_flags, pygui.TABLE_FLAGS_NO_BORDERS_IN_BODY)
        pygui.same_line()
        help_marker("Disable vertical borders in columns Body (borders will always appear in Headers")
        pop_style_compact()

        if pygui.begin_table("table1", 3, table.border_flags.value):
            # Display headers so we can inspect their interaction with borders.
            # (Headers are not the main purpose of this section of the demo, so we are not elaborating on them too much. See other sections for details)
            if table.border_display_headers:
                pygui.table_setup_column("One")
                pygui.table_setup_column("Two")
                pygui.table_setup_column("Three")
                pygui.table_headers_row()
            
            for row in range(5):
                pygui.table_next_row()
                for column in range(3):
                    pygui.table_set_column_index(column)
                    buf_text = "Hello {},{}".format(column, row)
                    if table.border_contents_type.value == table.ContentsType.CT_TEXT.value:
                        pygui.text_unformatted(buf_text)
                    elif table.border_contents_type.value == table.ContentsType.CT_FILL_BUTTON.value:
                        pygui.button(buf_text, (-pygui.FLT_MIN, 0))
            pygui.end_table()


        pygui.tree_pop()

    if open_action != -1:
        pygui.set_next_item_open(open_action != 0)
    if pygui.tree_node("Resizable, stretch"):
        # By default, if we don't enable ScrollX the sizing policy for each column is "Stretch"
        # All columns maintain a sizing weight, and they will occupy all available width.
        
        push_style_compact()
        pygui.checkbox_flags("ImGuiTableFlags_Resizable", table.resize_flags, pygui.TABLE_FLAGS_RESIZABLE)
        pygui.checkbox_flags("ImGuiTableFlags_BordersV", table.resize_flags, pygui.TABLE_FLAGS_BORDERS_V)
        pygui.same_line()
        help_marker("Using the _Resizable flag automatically enables the _BordersInnerV flag as well, this is why the resize borders are still showing when unchecking this.")
        pop_style_compact()

        if pygui.begin_table("table1", 3, table.resize_flags.value):
            for row in range(5):
                pygui.table_next_row()
                for column in range(3):
                    pygui.table_set_column_index(column)
                    pygui.text("Hello {},{}".format(column, row))
            pygui.end_table()
        pygui.tree_pop()

    if open_action != -1:
        pygui.set_next_item_open(open_action != 0)
    if pygui.tree_node("Resizable, fixed"):
        help_marker(
            "Using _Resizable + _SizingFixedFit flags.\n"
            "Fixed-width columns generally makes more sense if you want to use horizontal scrolling.\n\n"
            "Double-click a column border to auto-fit the column to its contents.")

        push_style_compact()
        pygui.checkbox_flags("ImGuiTableFlags_NoHostExtendX", table.resize_flags, pygui.TABLE_FLAGS_NO_HOST_EXTEND_X)
        pop_style_compact()

        if pygui.begin_table("table1", 3, table.resize_flags.value):
            for row in range(5):
                pygui.table_next_row()
                for column in range(3):
                    pygui.table_set_column_index(column)
                    pygui.text("Hello {},{}".format(column, row))
            pygui.end_table()
        pygui.tree_pop()

    if open_action != -1:
        pygui.set_next_item_open(open_action != 0)
    if pygui.tree_node("Resizable, mixed"):
        help_marker(
            "Using TableSetupColumn() to alter resizing policy on a per-column basis.\n\n"
            "When combining Fixed and Stretch columns, generally you only want one, maybe two trailing columns to use _WidthStretch.")

        if pygui.begin_table("table1", 3, table.mixed_flags.value):
            pygui.table_setup_column("AAA", pygui.TABLE_COLUMN_FLAGS_WIDTH_FIXED)
            pygui.table_setup_column("BBB", pygui.TABLE_COLUMN_FLAGS_WIDTH_FIXED)
            pygui.table_setup_column("CCC", pygui.TABLE_COLUMN_FLAGS_WIDTH_STRETCH)
            pygui.table_headers_row()
            for row in range(5):
                pygui.table_next_row()
                for column in range(3):
                    pygui.table_set_column_index(column)
                    pygui.text("{} {},{}".format('Stretch' if column == 2 else 'Fixed', column , row))
            pygui.end_table()

        if pygui.begin_table("table2", 6, table.mixed_flags.value):
            pygui.table_setup_column("AAA", pygui.TABLE_COLUMN_FLAGS_WIDTH_FIXED)
            pygui.table_setup_column("BBB", pygui.TABLE_COLUMN_FLAGS_WIDTH_FIXED)
            pygui.table_setup_column("CCC", pygui.TABLE_COLUMN_FLAGS_WIDTH_FIXED | pygui.TABLE_COLUMN_FLAGS_DEFAULT_HIDE)
            pygui.table_setup_column("DDD", pygui.TABLE_COLUMN_FLAGS_WIDTH_STRETCH)
            pygui.table_setup_column("EEE", pygui.TABLE_COLUMN_FLAGS_WIDTH_STRETCH)
            pygui.table_setup_column("FFF", pygui.TABLE_COLUMN_FLAGS_WIDTH_STRETCH | pygui.TABLE_COLUMN_FLAGS_DEFAULT_HIDE)
            pygui.table_headers_row()
            for row in range(5):
                pygui.table_next_row()
                for column in range(6):
                    pygui.table_set_column_index(column)
                    pygui.text("{} {},{}".format('Stretch' if column == 2 else 'Fixed', column , row))
            pygui.end_table()
        pygui.tree_pop()

    if open_action != -1:
        pygui.set_next_item_open(open_action != 0)
    if pygui.tree_node("Reorderable, hideable, with headers"):
        push_style_compact()
        pygui.checkbox_flags("ImGuiTableFlags_Resizable", table.hidable_flags, pygui.TABLE_FLAGS_RESIZABLE)
        pygui.checkbox_flags("ImGuiTableFlags_Reorderable", table.hidable_flags, pygui.TABLE_FLAGS_REORDERABLE)
        pygui.checkbox_flags("ImGuiTableFlags_Hideable", table.hidable_flags, pygui.TABLE_FLAGS_HIDEABLE)
        pygui.checkbox_flags("ImGuiTableFlags_NoBordersInBody", table.hidable_flags, pygui.TABLE_FLAGS_NO_BORDERS_IN_BODY)
        pygui.checkbox_flags("ImGuiTableFlags_NoBordersInBodyUntilResize", table.hidable_flags, pygui.TABLE_FLAGS_NO_BORDERS_IN_BODY_UNTIL_RESIZE)
        pygui.same_line()
        help_marker("Disable vertical borders in columns Body until hovered for resize (borders will always appear in Headers)")
        pop_style_compact()

        if pygui.begin_table("table1", 3, table.hidable_flags.value):
            # Submit column names with table_setup_column() and call table_headers_row() to create a row with a header in each column.
            # (Later we will show how table_setup_column() has other uses, optional flags, sizing weight etc.)
            pygui.table_setup_column("One")
            pygui.table_setup_column("Two")
            pygui.table_setup_column("Three")
            pygui.table_headers_row()
            for row in range(6):
                pygui.table_next_row()
                for column in range(3):
                    pygui.table_set_column_index(column)
                    pygui.text("Hello {},{}".format(column, row))
            pygui.end_table()

        # Use outer_size.x == 0.0f instead of default to make the table as tight as possible (only valid when no scrolling and no stretch column)
        if pygui.begin_table("table2", 3, table.hidable_flags.value | pygui.TABLE_FLAGS_SIZING_FIXED_FIT, (0.0, 0.0)):
            pygui.table_setup_column("One")
            pygui.table_setup_column("Two")
            pygui.table_setup_column("Three")
            pygui.table_headers_row()
            for row in range(6):
                pygui.table_next_row()
                for column in range(3):
                    pygui.table_set_column_index(column)
                    pygui.text("Fixed {},{}".format(column, row))
            pygui.end_table()
        pygui.tree_pop()

    if open_action != -1:
        pygui.set_next_item_open(open_action != 0)
    if pygui.tree_node("Padding"):
        # First example: showcase use of padding flags and effect of BorderOuterV/BorderInnerV on X padding.
        # We don't expose BorderOuterH/BorderInnerH here because they have no effect on X padding.
        help_marker(
            "We often want outer padding activated when any using features which makes the edges of a column visible:\n"
            "e.g.:\n"
            "- BorderOuterV\n"
            "- any form of row selection\n"
            "Because of this, activating BorderOuterV sets the default to PadOuterX. Using PadOuterX or NoPadOuterX you can override the default.\n\n"
            "Actual padding values are using style.CellPadding.\n\n"
            "In this demo we don't show horizontal borders to emphasize how they don't affect default horizontal padding."
        )

        push_style_compact()
        pygui.checkbox_flags("ImGuiTableFlags_PadOuterX", table.padding_flags, pygui.TABLE_FLAGS_PAD_OUTER_X)
        pygui.same_line()
        help_marker("Enable outer-most padding (default if ImGuiTableFlags_BordersOuterV is set)")
        pygui.checkbox_flags("ImGuiTableFlags_NoPadOuterX", table.padding_flags, pygui.TABLE_FLAGS_NO_PAD_OUTER_X)
        pygui.same_line()
        help_marker("Disable outer-most padding (default if ImGuiTableFlags_BordersOuterV is not set)")
        pygui.checkbox_flags("ImGuiTableFlags_NoPadInnerX", table.padding_flags, pygui.TABLE_FLAGS_NO_PAD_INNER_X)
        pygui.same_line()
        help_marker("Disable inner padding between columns (double inner padding if BordersOuterV is on, single inner padding if BordersOuterV is off)")
        pygui.checkbox_flags("ImGuiTableFlags_BordersOuterV", table.padding_flags, pygui.TABLE_FLAGS_BORDERS_OUTER_V)
        pygui.checkbox_flags("ImGuiTableFlags_BordersInnerV", table.padding_flags, pygui.TABLE_FLAGS_BORDERS_INNER_V)
        pygui.checkbox("show_headers", table.padding_show_headers)
        pop_style_compact()

        if pygui.begin_table("table_padding", 3, table.padding_flags.value):
            if table.padding_show_headers:
                pygui.table_setup_column("One")
                pygui.table_setup_column("Two")
                pygui.table_setup_column("Three")
                pygui.table_headers_row()

            for row in range(5):
                pygui.table_next_row()
                for column in range(3):
                    pygui.table_next_column()
                    if row == 0:
                        pygui.text("Avail {:.2f}".format(pygui.get_content_region_avail()[0]))
                    else:
                        pygui.button("Hello {}.{}".format(column, row), (-pygui.FLT_MIN, 0))
            pygui.end_table()

        # Second example: set style.CellPadding to (0.0) or a custom value.
        # FIXME-TABLE: Vertical border effectively not displayed the same way as horizontal one...
        help_marker("Setting style.CellPadding to (0,0) or a custom value.")

        push_style_compact()
        pygui.checkbox_flags("ImGuiTableFlags_Borders", table.padding_flags2, pygui.TABLE_FLAGS_BORDERS)
        pygui.checkbox_flags("ImGuiTableFlags_BordersH", table.padding_flags2, pygui.TABLE_FLAGS_BORDERS_H)
        pygui.checkbox_flags("ImGuiTableFlags_BordersV", table.padding_flags2, pygui.TABLE_FLAGS_BORDERS_V)
        pygui.checkbox_flags("ImGuiTableFlags_BordersInner", table.padding_flags2, pygui.TABLE_FLAGS_BORDERS_INNER)
        pygui.checkbox_flags("ImGuiTableFlags_BordersOuter", table.padding_flags2, pygui.TABLE_FLAGS_BORDERS_OUTER)
        pygui.checkbox_flags("ImGuiTableFlags_RowBg", table.padding_flags2, pygui.TABLE_FLAGS_ROW_BG)
        pygui.checkbox_flags("ImGuiTableFlags_Resizable", table.padding_flags2, pygui.TABLE_FLAGS_RESIZABLE)
        pygui.checkbox("show_widget_frame_bg", table.padding_show_widget_frame_bg)
        pygui.slider_float2("CellPadding", table.padding_cell_padding.as_floatptrs(), 0, 10, "%.0f")
        pop_style_compact()

        pygui.push_style_var_im_vec2(pygui.STYLE_VAR_CELL_PADDING, table.padding_cell_padding.vec());
        if pygui.begin_table("table_padding_2", 3, table.padding_flags2.value):
            if not table.padding_show_widget_frame_bg:
                pygui.push_style_color(pygui.COL_FRAME_BG, 0)
            
            for cell in range(3 * 5):
                pygui.table_next_column()
                pygui.set_next_item_width(-pygui.FLT_MIN)

                pygui.push_id_int(cell)
                pygui.input_text("##cell", table.padding_text_bufs[cell])
                pygui.pop_id()

            if not table.padding_show_widget_frame_bg:
                pygui.pop_style_color()
            pygui.end_table()
        
        pygui.pop_style_var()
        pygui.tree_pop()

    if open_action != -1:
        pygui.set_next_item_open(open_action != 0)
    if pygui.tree_node("Sorting"):
        template_item_names = [
            "Banana", "Apple", "Cherry", "Watermelon", "Grapefruit", "Strawberry", "Mango",
            "Kiwi", "Orange", "Pineapple", "Blueberry", "Plum", "Coconut", "Pear", "Apricot"
        ]
        if len(table.sort_items) == 0:
            for n in range(50):
                table.sort_items.append(table.MyItem(
                    n,
                    template_item_names[n % len(template_item_names)],
                    (n * n - n) % 20
                ))
        
        push_style_compact()
        pygui.checkbox_flags("ImGuiTableFlags_SortMulti", table.sort_flags, pygui.TABLE_FLAGS_SORT_MULTI)
        pygui.same_line()
        help_marker("When sorting is enabled: hold shift when clicking headers to sort on multiple column. TableGetSortSpecs() may return specs where (SpecsCount > 1).")
        pygui.checkbox_flags("ImGuiTableFlags_SortTristate", table.sort_flags, pygui.TABLE_FLAGS_SORT_TRISTATE)
        pygui.same_line()
        help_marker("When sorting is enabled: allow no sorting, disable default sorting. TableGetSortSpecs() may return specs where (SpecsCount == 0).")
        pop_style_compact()

        if pygui.begin_table("table_sorting", 4, table.sort_flags.value, (0, TEXT_BASE_HEIGHT * 15), 0):
            # Declare columns
            # We use the "user_id" parameter of TableSetupColumn() to specify a user id that will be stored in the sort specifications.
            # This is so our sort function can identify a column given our own identifier. We could also identify them based on their index!
            # Demonstrate using a mixture of flags among available sort-related flags:
            # - ImGuiTableColumnFlags_DefaultSort
            # - ImGuiTableColumnFlags_NoSort / ImGuiTableColumnFlags_NoSortAscending / ImGuiTableColumnFlags_NoSortDescending
            # - ImGuiTableColumnFlags_PreferSortAscending / ImGuiTableColumnFlags_PreferSortDescending
            pygui.table_setup_column("ID", pygui.TABLE_COLUMN_FLAGS_DEFAULT_SORT | pygui.TABLE_COLUMN_FLAGS_WIDTH_FIXED,                   0, table.MyItemColumnID.ID.value)
            pygui.table_setup_column("Name", pygui.TABLE_COLUMN_FLAGS_WIDTH_FIXED,                                                               0, table.MyItemColumnID.Name.value)
            pygui.table_setup_column("Action", pygui.TABLE_COLUMN_FLAGS_NO_SORT | pygui.TABLE_COLUMN_FLAGS_WIDTH_FIXED,                    0, table.MyItemColumnID.Action.value)
            pygui.table_setup_column("Quantity", pygui.TABLE_COLUMN_FLAGS_PREFER_SORT_DESCENDING | pygui.TABLE_COLUMN_FLAGS_WIDTH_STRETCH, 0, table.MyItemColumnID.Quantity.value)
            pygui.table_setup_scroll_freeze(0, 1) # Make row always visible
            pygui.table_headers_row()

            def custom_key(element: table.MyItem):
                sort_specs = pygui.table_get_sort_specs()
                sort_with = []
                for sort_spec in sort_specs.specs:
                    compare_obj = None
                    compare_obj = element.get_column_field(sort_spec.column_index)
                    # Or instead of using column_index you could directly check the value of
                    # column_user_id, (passed into pygui.table_setup_column()) to then add
                    # the corresponding field to the tuple. That setup is commented out below.

                    # if sort_spec.column_user_id == table.MyItemColumnID.ID.value:
                    #     compare_obj = element._id
                    # elif sort_spec.column_user_id == table.MyItemColumnID.Name.value:
                    #     compare_obj = element.name
                    # elif sort_spec.column_user_id == table.MyItemColumnID.Quantity.value:
                    #     compare_obj = element.quantity
                    # elif sort_spec.column_user_id == table.MyItemColumnID.Description.value:
                    #     compare_obj = element.name
                    
                    if sort_spec.sort_direction == pygui.SORT_DIRECTION_DESCENDING:
                        compare_obj = table.negated(compare_obj)
                    sort_with.append(compare_obj)
                # Add a default sorting method
                sort_with.append(element._id)
                return tuple(sort_with)

            # Sort our data if sort specs have been changed!
            """
            Python note: This sorting process is much easier as we can use the sort function
            to sort our list. But we still need to pass a suitable key function to ensure
            that it is sorted based on the information provided to us from ImGui. This is
            where ImGuiTableSortSpecs comes in. This class provides information about the
            sort itself. Here we use it to determine if we need to resort the list. This is
            to prevent us from needing to sort the list every frame.

            Secondly, the custom_key function above uses the information inside
            ImGuiTableSortSpecs.specs to retreive a List of ImGuiTableColumnSortSpecs. These
            contain information about the columns we are to sort on:
             - Which column?
             - Descending (def) of Ascending?
            The custom_key function returns a tuple containing the elements that will be
            used inside the sort function to compare each element.
            """
            if (sort_specs := pygui.table_get_sort_specs()):
                if sort_specs.specs_dirty:
                    table.sort_items.sort(key=custom_key)
                sort_specs.specs_dirty = False
            
            # Demonstrate using clipper for large vertical lists
            clipper = pygui.ImGuiListClipper.create()

            # This is our first example of not being able to share heap objects
            # across the dll. I need to get a pointer to a valid type that it
            # creates, not me. This may require modifying cimgui to create a
            # constructor function.
            clipper.begin(len(table.sort_items))
            while clipper.step():
                for row_n in range(clipper.display_start, clipper.display_end):
                    # Display a data item
                    item: table.MyItem = table.sort_items[row_n]
                    pygui.push_id_int(item._id)
                    pygui.table_next_row()
                    pygui.table_next_column()
                    pygui.text("{:.4f}".format(item._id))
                    pygui.table_next_column()
                    pygui.text_unformatted(item.name)
                    pygui.table_next_column()
                    pygui.small_button("None")
                    pygui.table_next_column()
                    pygui.text("{}".format(item.quantity))
                    pygui.pop_id()
            clipper.destroy()

            pygui.end_table()
        pygui.tree_pop()

    pygui.pop_id()

    if table.disable_indent:
        pygui.pop_style_var()


class menu:
    b = pygui.BoolPtr(True)


def show_menu_bar():
    if pygui.begin_menu_bar():
        if pygui.begin_menu("File"):
            show_menu_file()
            pygui.end_menu()
        if pygui.begin_menu("Edit"):
            if pygui.menu_item("Undo", "CTRL+Z"): pass
            if pygui.menu_item("Redo", "CTRL+Y", False, False): pass
            pygui.separator()
            if pygui.menu_item("Cut", "CTRL+X"): pass
            if pygui.menu_item("Copy", "CTRL+C"): pass
            if pygui.menu_item("Paste", "CTRL+V"): pass
            pygui.end_menu()
        if pygui.begin_menu("Examples"):
            pygui.menu_item_bool_ptr("Console", None, demo.show_app_console)
            pygui.menu_item_bool_ptr("Custom rendering", None, demo.show_custom_rendering)
            pygui.menu_item_bool_ptr("Pygui extras", None, demo.show_random_extras)
            pygui.end_menu()
        if pygui.begin_menu("Tools"):
            pygui.menu_item_bool_ptr("About Dear ImGui", None, demo.show_about_window)
            pygui.end_menu()
        pygui.end_menu_bar()


def show_menu_file():
    pygui.menu_item("(demo menu)", None, False, False)
    if pygui.menu_item("New"): pass
    if pygui.menu_item("Open", "Ctrl+O"): pass
    if pygui.begin_menu("Open Recent"):
        pygui.menu_item("fish_hat.c")
        pygui.menu_item("fish_hat.inl")
        pygui.menu_item("fish_hat.h")
        if pygui.begin_menu("More.."):
            pygui.menu_item("Hello")
            pygui.menu_item("Sailor")
            if pygui.begin_menu("Recurse.."):
                show_menu_file()
                pygui.end_menu()
            pygui.end_menu()
        pygui.end_menu()
    if pygui.menu_item("Save", "Ctrl+S"): pass
    if pygui.menu_item("Save As.."): pass

    if pygui.begin_menu("Colors"):
        sz = pygui.get_text_line_height()
        for i in range(pygui.COL_COUNT):
            name = pygui.get_style_color_name(i)
            p = pygui.get_cursor_screen_pos()
            pygui.get_window_draw_list().add_rect_filled(
                p, (p[0] + sz, p[1] + sz),
                pygui.get_color_u32(i)
            )
            pygui.dummy((sz, sz))
            pygui.same_line()
            pygui.menu_item(name)
        pygui.end_menu()
    
    # Here we demonstrate appending again to the "Options" menu (which we already created above)
    # Of course in this demo it is a little bit silly that this function calls BeginMenu("Options") twice.
    # In a real code-base using it would make senses to use this feature from very different code locations.
    if pygui.begin_menu("Options"):
        pygui.checkbox("SomeOption", menu.b)
        pygui.end_menu()

    if pygui.begin_menu("Disabled", False):
        assert False # Should not be reached
    
    if pygui.menu_item("Checked", None, True): pass
    pygui.separator()
    if pygui.menu_item("Quit", "Alt+F4"): pass


class ExampleAppConsole:
    def __init__(self):
        self.input_buf = pygui.StrPtr("", 256)
        self.items = []
        self.commands = [
            "HELP",
            "HISTORY",
            "CLEAR",
            "CLASSIFY",
        ]
        self.history = []
        # -1: new line, 0..History.Size-1 browsing history.
        self.history_pos = -1
        # Not adding filter at the moment
        self.auto_scroll = pygui.BoolPtr(True)
        self.scroll_to_bottom = pygui.BoolPtr(False)
    
    def clear_log(self):
        self.items.clear()
    
    def add_log(self, string: str, *args):
        self.items.append(" ".join([string] + list(args)))
    
    def draw(self, title: str, p_open: pygui.BoolPtr):
        pygui.set_next_window_size((520, 600), pygui.COND_FIRST_USE_EVER)
        if not pygui.begin(title, p_open):
            pygui.end()
            return
        
        # As a specific feature guaranteed by the library, after calling Begin() the last Item represent the title bar.
        # So e.g. IsItemHovered() will return true when hovering the title bar.
        # Here we create a context menu only available from the title bar.
        if pygui.begin_popup_context_item():
            if pygui.menu_item("Close Console"):
                p_open.value = False
            pygui.end_popup()
        
        pygui.text_wrapped(
            "This example implements a console with basic coloring, completion (TAB key) and history (Up/Down keys). A more elaborate "
            "implementation may want to store entries along with extra data such as timestamp, emitter, etc.")
        pygui.text_wrapped("Enter 'HELP' for help.")

        if pygui.small_button("Add Debug Text"):
            self.add_log("{} some text".format(len(self.items)))
            self.add_log("some more text")
            self.add_log("display very important message here!")
        
        pygui.same_line()
        if pygui.small_button("Add Debug Error"):
            self.add_log("[error] something went wrong")
        pygui.same_line()
        if pygui.small_button("Clear"):
            self.clear_log()
        pygui.same_line()
        copy_to_clipboard = pygui.small_button("Copy")

        pygui.separator()

        # Options menu
        if pygui.begin_popup("Options"):
            pygui.checkbox("Auto-scroll", self.auto_scroll)
            pygui.end_popup()

        # Options, Filter
        if pygui.button("Options"):
            pygui.open_popup("Options")
        # pygui.same_line()
        # Filter.Draw("Filter (\"incl,-excl\") (\"error\")", 180);
        pygui.separator()

        # Reserve enough left-over height for 1 separator + 1 input text
        footer_height_to_reserve = pygui.get_style().item_spacing[1] + pygui.get_frame_height_with_spacing()
        if pygui.begin_child("ScrollingRegion", (0, -footer_height_to_reserve), False, pygui.WINDOW_FLAGS_HORIZONTAL_SCROLLBAR):
            if pygui.begin_popup_context_window():
                if pygui.selectable("Clear"):
                    self.clear_log()
                pygui.end_popup()
            
            # Display every line as a separate entry so we can change their color or add custom widgets.
            # If you only want raw text you can use ImGui::TextUnformatted(log.begin(), log.end());
            # NB- if you have thousands of entries this approach may be too inefficient and may require user-side clipping
            # to only process visible items. The clipper will automatically measure the height of your first item and then
            # "seek" to display only items in the visible area.
            # To use the clipper we can replace your standard loop:
            #      for (int i = 0; i < Items.Size; i++)
            #   With:
            #      ImGuiListClipper clipper;
            #      clipper.Begin(Items.Size);
            #      while (clipper.Step())
            #         for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
            # - That your items are evenly spaced (same height)
            # - That you have cheap random access to your elements (you can access them given their index,
            #   without processing all the ones before)
            # You cannot this code as-is if a filter is active because it breaks the 'cheap random-access' property.
            # We would need random-access on the post-filtered list.
            # A typical application wanting coarse clipping and filtering may want to pre-compute an array of indices
            # or offsets of items that passed the filtering test, recomputing this array when user changes the filter,
            # and appending newly elements as they are inserted. This is left as a task to the user until we can manage
            # to improve this example code!
            # If your items are of variable height:
            # - Split them into same height items would be simpler and facilitate random-seeking into your list.
            # - Consider using manual call to IsRectVisible() and skipping extraneous decoration from your items.
            pygui.push_style_var_im_vec2(pygui.STYLE_VAR_ITEM_SPACING, (4, 1)) # Tighten spacing
            if copy_to_clipboard:
                pygui.log_to_clipboard()
            
            for item in self.items:
                # TODO: Filter

                # Normally you would store more information in your item than just a string.
                # (e.g. make Items[] an array of structure, store color/type etc.)
                
                color = (0, 0, 0, 0)
                has_color = False
                if "[error]" in item:
                    color = (1, 0.4, 0.4, 1)
                    has_color = True
                elif "#" in item:
                    color = (1, 0.8, 0.6, 1)
                    has_color = True
                if has_color:
                    pygui.push_style_color_im_vec4(pygui.COL_TEXT, color)
                pygui.text_unformatted(item)
                if has_color:
                    pygui.pop_style_color()
            
            if copy_to_clipboard:
                pygui.log_finish()
            
           # Keep up at the bottom of the scroll region if we were already at the bottom at the beginning of the frame.
           # Using a scrollbar or mouse-wheel will take away from the bottom edge.
            if self.scroll_to_bottom or (self.auto_scroll and pygui.get_scroll_y() >= pygui.get_scroll_max_y()):
                pygui.set_scroll_here_y(1)
            self.scroll_to_bottom.value = False

            pygui.pop_style_var()
        pygui.end_child()
        pygui.separator()

        # Command-line
        reclaim_focus = False
        input_text_flags = \
            pygui.INPUT_TEXT_FLAGS_ENTER_RETURNS_TRUE | \
            pygui.INPUT_TEXT_FLAGS_ESCAPE_CLEARS_ALL | \
            pygui.INPUT_TEXT_FLAGS_CALLBACK_COMPLETION | \
            pygui.INPUT_TEXT_FLAGS_CALLBACK_HISTORY
        
        if pygui.input_text("Input", self.input_buf, input_text_flags, self.text_edit_callback):
            if len(self.input_buf.value.strip()) > 0:
                self.exec_command(self.input_buf.value)
            self.input_buf.value = ""
            reclaim_focus = True

        # Auto-focus on window apparition
        pygui.set_item_default_focus()
        if reclaim_focus:
            pygui.set_keyboard_focus_here(-1) # Auto focus previous widget

        pygui.end()

    def exec_command(self, command_line: str):
        self.add_log("# {}\n".format(command_line))

        # Insert into history. First find match and delete it so it can be pushed to the back.
        # This isn't trying to be smart or optimal.
        self.history_pos = -1
        for i in reversed(range(len(self.history))):
            if self.history[i] == command_line:
                self.history.pop(i)
                break
        self.history.append(command_line)
        
        if command_line.startswith("CLEAR"):
            self.clear_log()
        elif command_line.startswith("HELP"):
            self.add_log("Commands:")
            for command in self.commands:
                self.add_log(f"- {command}")
        elif command_line.startswith("HISTORY"):
            first = len(self.history) - 10
            for i in range(max(first, 0), len(self.history)):
                self.add_log("{} {}\n".format(i, self.history[i]))
        else:
            self.add_log("Unknown command: {}".format(command_line))
        
        self.scroll_to_bottom.value = True
    
    def text_edit_callback(self, data: pygui.ImGuiInputTextCallbackData, user_data) -> int:
        if data.event_flag == pygui.INPUT_TEXT_FLAGS_CALLBACK_COMPLETION:
            # Example of TEXT COMPLETION
            # Locate beginning of current word
            word_end = data.cursor_pos
            word_start = data.cursor_pos

            while (word_start > 0):
                c = data.buf[word_start - 1]
                if c == ' ' or c == '\t' or c == ',' or c == ';':
                    break
                word_start -= 1
            word = data.buf[word_start:word_end]
        
            candidates = [command for command in self.commands if command.startswith(word.upper())]
            if len(candidates) == 0:
                self.add_log('No match for "{}"!\n'.format(word))
            elif len(candidates) == 1:
                data.delete_chars(word_start, word_end - word_start)
                data.insert_chars(data.cursor_pos, candidates[0] + " ")
            
            else:
                # Multiple matches. Complete as much as we can..
                # So inputing "C"+Tab will complete to "CL" then display "CLEAR" and "CLASSIFY" as matches.
                match_len = word_end - word_start
                while True:
                    all_candidates_matches = True
                    for i, candidate in enumerate(candidates):
                        if i == 0:
                            c = candidate[match_len].upper()
                            continue
                        
                        if c != candidate[match_len].upper():
                            all_candidates_matches = False
                            break

                    if not all_candidates_matches:
                        break
                    match_len += 1

                if match_len > 0:
                    data.delete_chars(word_start, word_end - word_start)
                    data.insert_chars(data.cursor_pos, candidates[0][:match_len])

                # List matches
                self.add_log("Possible matches:\n")
                for candidate in candidates:
                    self.add_log("- {}\n".format(candidate))
            
        elif data.event_flag == pygui.INPUT_TEXT_FLAGS_CALLBACK_HISTORY:
            # Example of HISTORY
            prev_history_pos = self.history_pos
            if data.event_key == pygui.KEY_UP_ARROW:
                if self.history_pos == -1:
                    self.history_pos = len(self.history) - 1
                elif self.history_pos > 0:
                    self.history_pos -= 1
            elif data.event_key == pygui.KEY_DOWN_ARROW:
                if self.history_pos != -1:
                    self.history_pos += 1
                    if self.history_pos >= len(self.history):
                       self.history_pos = -1

            # A better implementation would preserve the data on the current input line along with cursor position.
            if prev_history_pos != self.history_pos:
                history_str = self.history[self.history_pos] if self.history_pos >= 0 else ""
                data.delete_chars(0, data.buf_text_len)
                data.insert_chars(0, history_str)
        return 0


class demo:
    example_app_console = ExampleAppConsole()
    show_app_console = pygui.BoolPtr(False)
    show_custom_rendering = pygui.BoolPtr(False)
    show_about_window = pygui.BoolPtr(False)
    show_random_extras = pygui.BoolPtr(False)

    render_sz = pygui.FloatPtr(36)
    render_thickness = pygui.FloatPtr(3)
    render_ngon_sides = pygui.IntPtr(6)
    render_circle_segments_override = pygui.BoolPtr(False)
    render_circle_segments_override_v = pygui.IntPtr(12)
    render_curve_segments_override = pygui.BoolPtr(False)
    render_curve_segments_override_v = pygui.IntPtr(8)
    render_colf = pygui.Vec4Ptr(1, 1, 0.4, 1)
    render_points = []
    render_scrolling = [0, 0]
    render_opt_enable_grid = pygui.BoolPtr(True)
    render_opt_enable_context_menu = pygui.BoolPtr(True)
    render_adding_line = False
    render_draw_bg = pygui.BoolPtr(True)
    render_draw_fg = pygui.BoolPtr(True)

    random_begin_disabled = pygui.BoolPtr(True)
    random_first_checkbox = pygui.BoolPtr(False)
    random_second_checkbox = pygui.BoolPtr(False)
    random_third_checkbox = pygui.BoolPtr(False)
    random_modal_checkbox = pygui.BoolPtr(False)
    random_colour = pygui.Vec4Ptr(1, 1, 0, 1)
    random_current_item = pygui.IntPtr(0)
    random_error_text = [(1, 0, 0, 1), ""]
    random_drag_min = pygui.IntPtr(1)
    random_drag_max = pygui.IntPtr(100)
    random_drag = pygui.IntPtr(50)
    random_drag_float_min = pygui.FloatPtr(0.001)
    random_drag_float_max = pygui.FloatPtr(0.100)
    random_drag_float = pygui.FloatPtr(0.05)
    random_multiline_buffer = pygui.StrPtr("", 64)


def show_app_console(p_open: pygui.BoolPtr):
    demo.example_app_console.draw("Example: Pygui Console", p_open)


def show_app_custom_rendering(p_open: pygui.BoolPtr):
    if not pygui.begin("Example: Pygui Custom rendering", p_open):
        pygui.end()
        return
    
    # Tip: If you do a lot of custom rendering, you probably want to use your own geometrical types and benefit of
    # overloaded operators, etc. Define IM_VEC2_CLASS_EXTRA in imconfig.h to create implicit conversions between your
    # types and ImVec2/ImVec4. Dear ImGui defines overloaded operators but they are internal to imgui.cpp and not
    # exposed outside (to avoid messing with your types) In this example we are not using the maths operators!
    if pygui.begin_tab_bar("##TabBar"):
        if pygui.begin_tab_item("Primitives"):
            pygui.push_item_width(-pygui.get_font_size() * 15)
            draw_list = pygui.get_window_draw_list()

            # Draw gradients
            # (note that those are currently exacerbating our sRGB/Linear issues)
            # Calling ImGui::GetColorU32() multiplies the given colors by the current Style Alpha, but you may pass the IM_COL32() directly as well..
            pygui.text("Gradients")
            gradient_size = (pygui.calc_item_width(), pygui.get_frame_height())
            p0 = pygui.get_cursor_screen_pos()
            p1 = (p0[0] + gradient_size[0], p0[1] + gradient_size[1])
            col_a = pygui.get_color_u32_im_u32(pygui.IM_COL32(0, 0, 0, 255))
            col_b = pygui.get_color_u32_im_u32(pygui.IM_COL32(255, 255, 255, 255))
            draw_list.add_rect_filled_multi_color(p0, p1, col_a, col_b, col_b, col_a)
            pygui.invisible_button("##gradient1", gradient_size)

            p0 = pygui.get_cursor_screen_pos()
            p1 = (p0[0] + gradient_size[0], p0[1] + gradient_size[1])
            col_a = pygui.get_color_u32_im_u32(pygui.IM_COL32(0, 255, 0, 255))
            col_b = pygui.get_color_u32_im_u32(pygui.IM_COL32(255, 0, 0, 255))
            draw_list.add_rect_filled_multi_color(p0, p1, col_a, col_b, col_b, col_a)
            pygui.invisible_button("##gradient2", gradient_size)

            # Draw a bunch of primitives
            pygui.text("All primitives")
            pygui.drag_float("Size", demo.render_sz, 0.2, 2, 100, "%.0f")
            pygui.drag_float("Thickness", demo.render_thickness, 0.05, 1, 8, "%.02f")
            pygui.slider_int("N-gon sides", demo.render_ngon_sides, 3, 12)
            pygui.checkbox("##circlesegmentoverride", demo.render_circle_segments_override)
            pygui.same_line(0, pygui.get_style().item_inner_spacing[0])
            demo.render_circle_segments_override.value |= pygui.slider_int("Circle segments override", demo.render_circle_segments_override_v, 3, 40)
            pygui.checkbox("##curvessegmentoverride", demo.render_curve_segments_override)
            pygui.same_line(0, pygui.get_style().item_inner_spacing[0])
            demo.render_curve_segments_override.value |= pygui.slider_int("Curves segments override", demo.render_curve_segments_override_v, 3, 40)
            pygui.color_edit4("Color", demo.render_colf)

            p = pygui.get_cursor_screen_pos()
            col = demo.render_colf.to_u32()
            sz = demo.render_sz.value
            spacing = 10.0
            corners_tl_br = pygui.IM_DRAW_FLAGS_ROUND_CORNERS_TOP_LEFT | pygui.IM_DRAW_FLAGS_ROUND_CORNERS_BOTTOM_RIGHT
            rounding = demo.render_sz.value / 5.0
            circle_segments = demo.render_circle_segments_override_v.value if demo.render_circle_segments_override else 0
            curve_segments = demo.render_curve_segments_override_v.value if demo.render_curve_segments_override else 0
            x = p[0] + 4.0
            y = p[1] + 4.0
            for n in range(2):
                # First line uses a thickness of 1.0f, second line uses the configurable thickness
                th = 1 if (n == 0) else demo.render_thickness.value
                draw_list.add_ngon((x + sz*0.5, y + sz*0.5), sz*0.5, col, demo.render_ngon_sides.value, th)
                x += sz + spacing;  # N-gon
                draw_list.add_circle((x + sz*0.5, y + sz*0.5), sz*0.5, col, circle_segments, th)
                x += sz + spacing  # Circle
                draw_list.add_rect((x, y), (x + sz, y + sz), col, 0.0, pygui.IM_DRAW_FLAGS_NONE, th)
                x += sz + spacing  # Square
                draw_list.add_rect((x, y), (x + sz, y + sz), col, rounding, pygui.IM_DRAW_FLAGS_NONE, th)
                x += sz + spacing  # Square with all rounded corners
                draw_list.add_rect((x, y), (x + sz, y + sz), col, rounding, corners_tl_br, th)
                x += sz + spacing  # Square with two rounded corners
                draw_list.add_triangle((x+sz*0.5,y), (x+sz, y+sz-0.5), (x, y+sz-0.5), col, th)
                x += sz + spacing  # Triangle
                # draw_list->AddTriangle(ImVec2(x+sz*0.2f,y), ImVec2(x, y+sz-0.5f), ImVec2(x+sz*0.4f, y+sz-0.5f), col, th)
                # x+= sz*0.4f + spacing # Thin triangle
                draw_list.add_line((x, y), (x + sz, y), col, th)
                x += sz + spacing  # Horizontal line (note: drawing a filled rectangle will be faster!)
                draw_list.add_line((x, y), (x, y + sz), col, th)
                x += spacing       # Vertical line (note: drawing a filled rectangle will be faster!)
                draw_list.add_line((x, y), (x + sz, y + sz), col, th)
                x += sz + spacing  # Diagonal line

                # Quadratic Bezier Curve (3 control points)
                cp3 = [
                    (x, y + sz * 0.6),
                    (x + sz * 0.5, y - sz * 0.4),
                    (x + sz, y + sz),
                ]
                draw_list.add_bezier_quadratic(cp3[0], cp3[1], cp3[2], col, th, curve_segments)
                x += sz + spacing

                # # Cubic Bezier Curve (4 control points)
                cp4 = [
                    (x, y),
                    (x + sz * 1.3, y + sz * 0.3),
                    (x + sz - sz * 1.3, y + sz - sz * 0.3),
                    (x + sz, y + sz),
                ]
                draw_list.add_bezier_cubic(cp4[0], cp4[1], cp4[2], cp4[3], col, th, curve_segments)

                x = p[0] + 4
                y += sz + spacing
            
            draw_list.add_ngon_filled((x + sz * 0.5, y + sz * 0.5), sz*0.5, col, demo.render_ngon_sides.value)
            x += sz + spacing;  # N-gon
            draw_list.add_circle_filled((x + sz*0.5, y + sz*0.5), sz*0.5, col, circle_segments)
            x += sz + spacing;  # Circle
            draw_list.add_rect_filled((x, y), (x + sz, y + sz), col)
            x += sz + spacing;  # Square
            draw_list.add_rect_filled((x, y), (x + sz, y + sz), col, 10.0)
            x += sz + spacing;  # Square with all rounded corners
            draw_list.add_rect_filled((x, y), (x + sz, y + sz), col, 10.0, corners_tl_br)
            x += sz + spacing;  # Square with two rounded corners
            draw_list.add_triangle_filled((x+sz*0.5,y), (x+sz, y+sz-0.5), (x, y+sz-0.5), col)
            x += sz + spacing;  # Triangle
            # draw_list.AddTriangleFilled(ImVec2(x+sz*0.2f,y), ImVec2(x, y+sz-0.5f), ImVec2(x+sz*0.4f, y+sz-0.5f), col); x += sz*0.4f + spacing; # Thin triangle
            draw_list.add_rect_filled((x, y), (x + sz, y + demo.render_thickness.value), col)
            x += sz + spacing;  # Horizontal line (faster than AddLine, but only handle integer thickness)
            draw_list.add_rect_filled((x, y), (x + demo.render_thickness.value, y + sz), col)
            x += spacing * 2.0;# Vertical line (faster than AddLine, but only handle integer thickness)
            draw_list.add_rect_filled((x, y), (x + 1, y + 1), col)
            x += sz;            # Pixel (faster than AddLine)
            draw_list.add_rect_filled_multi_color((x, y), (x + sz, y + sz), pygui.IM_COL32(0, 0, 0, 255), pygui.IM_COL32(255, 0, 0, 255), pygui.IM_COL32(255, 255, 0, 255), pygui.IM_COL32(0, 255, 0, 255));

            pygui.dummy(((sz + spacing) * 10.2, (sz + spacing) * 3.0))
            pygui.pop_item_width()
            pygui.end_tab_item()
        
        if pygui.begin_tab_item("Canvas"):
            pygui.checkbox("Enable grid", demo.render_opt_enable_grid)
            pygui.checkbox("Enable context menu", demo.render_opt_enable_context_menu)
            pygui.text("Mouse Left: drag to add lines,\nMouse Right: drag to scroll, click for context menu.")

            # Typically you would use a BeginChild()/EndChild() pair to benefit from a clipping region + own scrolling.
            # Here we demonstrate that this can be replaced by simple offsetting + custom drawing + PushClipRect/PopClipRect() calls.
            # To use a child window instead we could use, e.g:
            #      ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(0, 0));      // Disable padding
            #      ImGui::PushStyleColor(ImGuiCol_ChildBg, IM_COL32(50, 50, 50, 255));  // Set a background color
            #      ImGui::BeginChild("canvas", ImVec2(0.0f, 0.0f), true, ImGuiWindowFlags_NoMove);
            #      ImGui::PopStyleColor();
            #      ImGui::PopStyleVar();
            #      [...]
            #      ImGui::EndChild();

            # Using InvisibleButton() as a convenience 1) it will advance the layout cursor and 2) allows us to use IsItemHovered()/IsItemActive()
            canvas_p0 = pygui.get_cursor_screen_pos()      # ImDrawList API uses screen coordinates!
            canvas_sz = pygui.get_content_region_avail()   # Resize canvas to what's available
            if canvas_sz[0] < 50.0:
                canvas_sz[0] = 50.0
            if canvas_sz[1] < 50.0:
                canvas_sz[1] = 50.0
            canvas_p1 = (canvas_p0[0] + canvas_sz[0], canvas_p0[1] + canvas_sz[1])

            # Draw border and background color
            io = pygui.get_io()
            draw_list = pygui.get_window_draw_list()
            draw_list.add_rect_filled(canvas_p0, canvas_p1, pygui.IM_COL32(50, 50, 50, 255))
            draw_list.add_rect(canvas_p0, canvas_p1, pygui.IM_COL32(255, 255, 255, 255))

            # This will catch our interactions
            pygui.invisible_button("canvas", canvas_sz, pygui.BUTTON_FLAGS_MOUSE_BUTTON_LEFT | pygui.BUTTON_FLAGS_MOUSE_BUTTON_RIGHT)
            is_hovered = pygui.is_item_hovered()  # Hovered
            is_active = pygui.is_item_active()    # Held
            origin = (canvas_p0[0] + demo.render_scrolling[0], canvas_p0[1] + demo.render_scrolling[1]) # Lock scrolled origin
            mouse_pos_in_canvas = (io.mouse_pos[0] - origin[0], io.mouse_pos[1] - origin[1])

            # Add first and second point
            if is_hovered and not demo.render_adding_line and pygui.is_mouse_clicked(pygui.MOUSE_BUTTON_LEFT):
                demo.render_points.append(mouse_pos_in_canvas)
                demo.render_points.append(mouse_pos_in_canvas)
                demo.render_adding_line = True
            if demo.render_adding_line:
                demo.render_points[len(demo.render_points) - 1] = mouse_pos_in_canvas
                if not pygui.is_mouse_down(pygui.MOUSE_BUTTON_LEFT):
                    demo.render_adding_line = False
            
            # Pan (we use a zero mouse threshold when there's no context menu)
            # You may decide to make that threshold dynamic based on whether the mouse is hovering something etc.
            mouse_threshold_for_pan = -1 if demo.render_opt_enable_context_menu else 0
            if is_active and pygui.is_mouse_dragging(pygui.MOUSE_BUTTON_RIGHT, mouse_threshold_for_pan):
                demo.render_scrolling[0] += io.mouse_delta[0]
                demo.render_scrolling[1] += io.mouse_delta[1]

            # Context menu (under default mouse threshold)
            drag_delta = pygui.get_mouse_drag_delta(pygui.MOUSE_BUTTON_RIGHT)
            if demo.render_opt_enable_context_menu and drag_delta[0] == 0 and drag_delta[1] == 0:
                pygui.open_popup_on_item_click("context", pygui.POPUP_FLAGS_MOUSE_BUTTON_RIGHT)
            if pygui.begin_popup("context"):
                if demo.render_adding_line:
                    demo.render_points = demo.render_points[:len(demo.render_points) - 2]
                
                demo.render_adding_line = False
                if pygui.menu_item("Remove one", None, False, len(demo.render_points) > 0):
                    demo.render_points.pop()
                    demo.render_points.pop()
                if pygui.menu_item("Remove all", None, False, len(demo.render_points) > 0):
                    demo.render_points.clear()
                pygui.end_popup()

            # Draw grid + all lines in the canvas
            draw_list.push_clip_rect(canvas_p0, canvas_p1, True);
            if demo.render_opt_enable_grid:
                GRID_STEP = 64

                x = demo.render_scrolling[0] % GRID_STEP
                while x < canvas_sz[0]:
                    draw_list.add_line((canvas_p0[0] + x, canvas_p0[1]), (canvas_p0[0] + x, canvas_p1[1]), pygui.IM_COL32(200, 200, 200, 40))
                    x += GRID_STEP
                y = demo.render_scrolling[1] % GRID_STEP
                while y < canvas_sz[1]:
                    draw_list.add_line((canvas_p0[0], canvas_p0[1] + y), (canvas_p1[0], canvas_p0[1] + y), pygui.IM_COL32(200, 200, 200, 40))
                    y += GRID_STEP
            for n in range(0, len(demo.render_points), 2):
                first = demo.render_points[n]
                second = demo.render_points[n + 1]
                draw_list.add_line((origin[0] + first[0], origin[1] + first[1]), (origin[0] + second[0], origin[1] + second[1]), pygui.IM_COL32(255, 255, 0, 255), 2)
            draw_list.pop_clip_rect()

            pygui.end_tab_item()

        if pygui.begin_tab_item("BG/FG draw lists"):
            pygui.checkbox("Draw in Background draw list", demo.render_draw_bg)
            pygui.same_line()
            help_marker("The Background draw list will be rendered below every Dear ImGui windows.")
            pygui.checkbox("Draw in Foreground draw list", demo.render_draw_fg)
            pygui.same_line()
            help_marker("The Foreground draw list will be rendered over every Dear ImGui windows.")
            window_pos = pygui.get_window_pos()
            window_size = pygui.get_window_size()
            window_center = (window_pos[0] + window_size[0] * 0.5, window_pos[1] + window_size[1] * 0.5)
            if demo.render_draw_bg:
                pygui.get_background_draw_list().add_circle(window_center, window_size[0] * 0.6, pygui.IM_COL32(255, 0, 0, 200), 0, 10 + 4)
            if demo.render_draw_fg:
                pygui.get_foreground_draw_list().add_circle(window_center, window_size[1] * 0.6, pygui.IM_COL32(0, 255, 0, 200), 0, 10)
            pygui.end_tab_item()
        pygui.end_tab_bar()
    
    pygui.end()


def show_random_extras(p_open: pygui.BoolPtr):
    if not pygui.begin("Example: Random Extras", p_open):
        pygui.end()
        return
    
    if pygui.tree_node("pygui.begin_child_frame()"):
        new_id = pygui.get_id("begin_child_frame()")
        item_height = pygui.get_text_line_height_with_spacing()
        if pygui.begin_child_frame(new_id, (-pygui.FLT_MIN, item_height * 5 + 5)):
            for n in range(5):
                pygui.text("My Item {}".format(n))
            pygui.end_child_frame()
        pygui.tree_pop()

    if pygui.tree_node("pygui.begin_child_id()"):
        new_id = pygui.get_id("begin_child_id()")
        pygui.begin_child_id(new_id, (0, 260), True)
        if pygui.begin_table("split", 2, pygui.TABLE_FLAGS_RESIZABLE | pygui.TABLE_FLAGS_NO_SAVED_SETTINGS):
            for i in range(30):
                pygui.table_next_column()
                pygui.button("{:3f}".format(i), (-pygui.FLT_MIN, 0))
            pygui.end_table()
        pygui.end_child()
        pygui.tree_pop()

    if pygui.tree_node("pygui.begin_disabled()"):
        pygui.checkbox("Begin Disabled", demo.random_begin_disabled)
        pygui.begin_disabled(demo.random_begin_disabled.value)
        pygui.checkbox("First checkbox", demo.random_first_checkbox)
        pygui.checkbox("Second checkbox", demo.random_second_checkbox)
        pygui.end_disabled()
        pygui.checkbox("Ignore disabled checkbox", demo.random_third_checkbox)
        pygui.tree_pop()
    
    if pygui.tree_node("pygui.begin_main_menu_bar()"):
        if pygui.begin_main_menu_bar():
            if pygui.begin_menu("File"):
                pygui.menu_item("Hello world")
                pygui.end_menu()
            
            if pygui.begin_menu("Test"):
                pygui.menu_item("Content1")
                pygui.menu_item("Content2")
                pygui.menu_item("Content3")
                pygui.end_menu()
            
            if pygui.begin_menu("About"):
                pygui.menu_item("About me etc...")
                pygui.end_menu()
            pygui.end_main_menu_bar()
        pygui.tree_pop()
    
    if pygui.tree_node("pygui.begin_popup_context_void()"):
        pygui.text_wrapped(
            "Popup only appears when you right click on the main window."
            " This will make the usual ImGui menu appear."
        )
        if pygui.begin_popup_context_void(None, pygui.POPUP_FLAGS_MOUSE_BUTTON_RIGHT):
            show_menu_file()
            pygui.end_popup()
        pygui.tree_pop()

    if pygui.tree_node("pygui.begin_popup_modal()"):
        pygui.text_wrapped("Modal windows are like popups but the user cannot close them by clicking outside.")
        if pygui.button("Open Modal"):
            pygui.open_popup("Modal?")

        # Always center this window when appearing
        center = pygui.get_main_viewport().get_center()
        pygui.set_next_window_pos(center, pygui.COND_APPEARING, (0.5, 0.5))

        if pygui.begin_popup_modal("Modal?", None, pygui.WINDOW_FLAGS_ALWAYS_AUTO_RESIZE):
            pygui.text("This opens a modal popup")
            pygui.separator()

            pygui.push_style_var_im_vec2(pygui.STYLE_VAR_FRAME_PADDING, (0, 0))
            pygui.checkbox("This is a checkbox", demo.random_modal_checkbox)
            pygui.pop_style_var()

            if pygui.button("OK", (120, 0)):
                pygui.close_current_popup()
            pygui.set_item_default_focus()
            pygui.same_line()
            if pygui.button("Cancel", (120, 0)):
                pygui.close_current_popup()
            pygui.end_popup()
        pygui.tree_pop()

    if pygui.tree_node("pygui.color_convert_float4_to_u32()"):
        draw_list = pygui.get_window_draw_list()

        pygui.color_edit4("Edit rgb", demo.random_colour)
        pygui.color_edit4("Edit hsv", demo.random_colour, pygui.COLOR_EDIT_FLAGS_DISPLAY_HSV)
        float_to_u32 = pygui.color_convert_float4_to_u32(demo.random_colour.vec())
        float_to_u32_macro = pygui.IM_COL32(*[c * 255 for c in demo.random_colour.vec()])
        pygui.text("color_convert_float4_to_u32: {}".format(float_to_u32))
        pygui.text("IM_COL32:                    {}".format(float_to_u32_macro))

        gradient_size = (pygui.calc_item_width(), pygui.get_frame_height())

        pygui.separator()
        pygui.text("color_convert_u32_to_float4()")
        u32_to_float4 = pygui.color_convert_u32_to_float4(float_to_u32)
        pygui.text(str(u32_to_float4))
        p0 = pygui.get_cursor_screen_pos()
        p1 = (p0[0] + gradient_size[0], p0[1] + gradient_size[1])
        draw_list.add_rect_filled(p0, p1, pygui.color_convert_float4_to_u32(u32_to_float4))
        pygui.invisible_button("##gradient1", gradient_size)

        pygui.separator()
        pygui.text("color_convert_rgb_to_hsv()")
        rgb_to_hsv = pygui.color_convert_rgb_to_hsv(*u32_to_float4)
        pygui.text(str(rgb_to_hsv))
        p0 = pygui.get_cursor_screen_pos()
        p1 = (p0[0] + gradient_size[0], p0[1] + gradient_size[1])
        draw_list.add_rect_filled(p0, p1, pygui.color_convert_float4_to_u32(pygui.color_convert_hsv_to_rgb(*rgb_to_hsv)))
        pygui.invisible_button("##gradient2", gradient_size)
        
        pygui.tree_pop()

    if pygui.tree_node("pygui.combo_callback()"):
        def combo_callback_function(data, index: int, out: pygui.StrPtr) -> bool:
            out.value = data[index]
            return True
        data = ["Apples", "Oranges", "Mango", "Passionfruit", "Strawberry"]
        
        pygui.combo_callback("My Combo", demo.random_current_item,
                             combo_callback_function, data, len(data))
        pygui.tree_pop()

    if pygui.tree_node("pygui.debug_check_version_and_data_layout()"):
        pygui.text_wrapped(
            "If pressing this alerts ImGui then the sizes of the structs in"
            " cython is different to ImGui. This *might* not be an issue.")
        try:
            if pygui.button("Call pygui.debug_check_version_and_data_layout()"):
                pygui.debug_check_version_and_data_layout()
                demo.random_error_text = [(0, 1, 0, 1), "Passed"]
        except pygui.ImGuiError as e:
            demo.random_error_text = [(1, 0, 0, 1), str(e)]
        
        if demo.random_error_text[1] != "":
            pygui.push_style_color_im_vec4(pygui.COL_TEXT, demo.random_error_text[0])
            pygui.text_wrapped(demo.random_error_text[1])
            pygui.pop_style_color()

        if demo.random_error_text[1] != "":
            if pygui.button("Clear"):
                demo.random_error_text[1] = ""

        pygui.tree_pop()
    
    if pygui.tree_node("pygui.debug_text_encoding()"):
        pygui.debug_text_encoding("Demo String")
        pygui.tree_pop()
    
    if pygui.tree_node("pygui.drag_int_range2()"):
        pygui.drag_int_range2("My drag_int2", demo.random_drag_min, demo.random_drag_max, 1, -500, 500)
        pygui.drag_int("drag_int", demo.random_drag, 1, demo.random_drag_min.value, demo.random_drag_max.value)
        pygui.drag_float_range2("My drag_float2", demo.random_drag_float_min, demo.random_drag_float_max, 0.001, -1, 1)
        pygui.drag_float("drag_float", demo.random_drag_float, 0.001, demo.random_drag_float_min.value, demo.random_drag_float_max.value)
        pygui.tree_pop()
    
    if pygui.tree_node("pygui.input_text_multiline()"):
        def callback_function(callback_data, user_data) -> int:
            print("Hello", user_data)
            return 0
        pygui.input_text_multiline("My text", demo.random_multiline_buffer, (-pygui.FLT_MIN, 100),
                                   pygui.INPUT_TEXT_FLAGS_CALLBACK_EDIT, callback_function, "My data")
        pygui.tree_pop()
    
    pygui.end()


class crash_test:
    error_text = pygui.StrPtr("", 256)
    catch_message = ""


def crash_imgui():
    if not pygui.collapsing_header("Crash ImGui"):
        return
    
    pygui.text("Test various crashes")
    pygui.same_line()
    help_marker(
        "1. This will call a function in ImGui that is known to crash. This crash"
        " originates from ImGui itself. If USE_CUSTOM_PYTHON_ERROR is defined then"
        " this will exception will be caught.\n"
        "2. This will call IM_ASSERT. If USE_CUSTOM_PYTHON_ERROR is defined then"
        " this function call will raise a pygui.ImGuiError, otherwise it will"
        " raise an AssertionError. In either cause, this should not crash because"
        " pygui.ImGuiError is AssertionError when USE_CUSTOM_PYTHON_ERROR is"
        " undefined.\n"
        "3. This uses python's assert keyword. If USE_CUSTOM_PYTHON_ERROR is"
        " defined this should crash your program because pygui.ImGuiError and"
        " AssertionError are different.\n"
        "4. This will call IM_ASSERT but will except by force using the ImGui's"
        " exposed dll exception. If USE_CUSTOM_PYTHON_ERROR is not defined, this"
        " will be caught, otherwise this will crash simply because you can't catch"
        " and exception with 'None'.\n"
    )

    if pygui.button("Clear"):
        crash_test.catch_message = ""
        crash_test.error_text.value = ""

    
    if pygui.button("Crash 1: pop_style_color() -> except pygui.Error"):
        try:
            pygui.pop_style_color(1)
        except pygui.ImGuiError as e:
            crash_test.catch_message = "Caught! You have custom exceptions on."
            crash_test.error_text.value = str(e)
    
    if pygui.button("Crash 2: pygui.IM_ASSERT(False) -> except pygui.Error"):
        try:
            pygui.IM_ASSERT(False, "I am an error message")
        except pygui.ImGuiError as e:
            crash_test.catch_message = "Caught! This should never crash."
            crash_test.error_text.value = str(e)
    
    if pygui.button("Crash 3: assert False -> except pygui.Error"):
        try:
            assert False, "I am another error message"
        except pygui.ImGuiError as e:
            crash_test.catch_message = "Caught! You have custom exceptions off."
            crash_test.error_text.value = str(e)
    
    if pygui.button("Crash 4: pygui.IM_ASSERT(False) -> except pygui.core.Error"):
        try:
            assert pygui.IM_ASSERT(False, "We are an error message")
        except pygui.get_imgui_error() as e:
            # Prefer to use pygui.ImGuiError as it is safer. This value could
            # be None if cimgui is not using a custom python exception. For this
            # example this is exavtly what we want.
            crash_test.catch_message = "Caught! You have custom exceptions on."
            crash_test.error_text.value = str(e)
    
    if len(crash_test.catch_message) > 0:
        pygui.text(crash_test.catch_message)
        pygui.text_wrapped(crash_test.error_text.value)
    
