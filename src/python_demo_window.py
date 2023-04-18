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
    show_demo_widgets()
    show_demo_tables()


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
    text_utf8_buf = pygui.StrPtr("\xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e", 32)
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
    multi_vec4f = pygui.Vec4Ptr(0.10, 0.2, 0.3, 0.44)
    multi_vec4i = pygui.Vec4Ptr(1, 5, 100, 255)


def show_demo_widgets():
    if not pygui.collapsing_header("Widgets"):
        return
    
    if pygui.tree_node_ex("Basic"):
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
    
    if pygui.tree_node_ex("Trees"):
        if pygui.tree_node_ex("Basic trees"):
            for i in range(5):
                if i == 0:
                    pygui.set_next_item_open(True, pygui.COND_ONCE)
                
                if pygui.tree_node_ex("Child {}".format(i)):
                    pygui.text("blah blah")
                    pygui.same_line()
                    if pygui.small_button("button"):
                        pass
                    pygui.tree_pop()
            pygui.tree_pop()

        if pygui.tree_node_ex("Advanced, with Selectable nodes"):
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
                    node_open = pygui.tree_node_ex(f"Selectable Node {i}", node_flags)
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
                    pygui.tree_node_ex(f"Selectable Leaf {i}", node_flags)
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
    
    if pygui.tree_node_ex("Collapsing Headers"):
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
    
    if pygui.tree_node_ex("Bullets"):
        pygui.bullet_text("Bullet point 1");
        pygui.bullet_text("Bullet point 2\nOn multiple lines");
        if pygui.tree_node_ex("Tree node"):
            pygui.bullet_text("Another bullet point")
            pygui.tree_pop()
        
        pygui.bullet()
        pygui.text("Bullet point 3 (two calls)")
        pygui.bullet()
        pygui.small_button("Button")
        pygui.tree_pop()

    if pygui.tree_node_ex("Text"):
        if pygui.tree_node_ex("Colorful text"):
            pygui.text_colored((1, 0, 1, 1), "Pink")
            pygui.text_colored((1, 1, 0, 1), "Yellow")
            pygui.text_disabled("Disabled")
            pygui.same_line()
            help_marker("The TextDisabled color is stored in ImGuiStyle.")
            pygui.tree_pop()
        
        if pygui.tree_node_ex("Word Wrapping"):
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

        if pygui.tree_node_ex("UTF-8 Text"):
            pygui.text_wrapped(
                "CJK text will only appear if the font was loaded with the appropriate CJK character ranges. "
                "Call io.Fonts->AddFontFromFileTTF() manually to load extra character ranges. "
                "Read docs/FONTS.md for details.")
            # Normally we would use u8"blah blah" with the proper characters directly in the string.
            pygui.text("Hiragana: \xe3\x81\x8b\xe3\x81\x8d\xe3\x81\x8f\xe3\x81\x91\xe3\x81\x93 (kakikukeko)")
            pygui.text("Kanjis: \xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e (nihongo)")
            # static char buf[32] = u8"NIHONGO"; // <- this is how you would write it with C++11, using real kanjis
            # TODO: This crashes. Not sure why.
            pygui.text("The call below crashes so it has been omitted in this demo.")
            pygui.text('pygui.input_text("UTF-8 input", static.widgets_text_utf8_buf)')
            # pygui.input_text("UTF-8 input", widget.text_utf8_buf)
            pygui.tree_pop()

        pygui.tree_pop()

    if pygui.tree_node_ex("Images"):
        if pygui.tree_node_ex("Custom Pygui Image"):
            pygui.image(
                widget.instance().widgets_image_texture,
                (widget.instance().widgets_image.width / 2,
                widget.instance().widgets_image.height / 2))
            pygui.tree_pop()
        
        if pygui.tree_node_ex("ImGui Demo"):
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
    
    if pygui.tree_node_ex("Combo"):
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
        # This one is yet to be added, but still I question if this is required
        # in python. We're already inside a very high-level language. I'm yet to
        # see a benefit of using a callback function.
        # struct Funcs { static bool ItemGetter(void* data, int n, const char** out_str) { *out_str = ((const char**)data)[n]; return true; } };
        # static int item_current_4 = 0;
        # ImGui::Combo("combo 4 (function)", &item_current_4, &Funcs::ItemGetter, items, IM_ARRAYSIZE(items));
        pygui.tree_pop()

    if pygui.tree_node_ex("List boxes"):
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
    
    if pygui.tree_node_ex("Selectables"):
        if pygui.tree_node_ex("Basic"):
            pygui.selectable_bool_ptr("1. I am selectable", widget.select_selection[0])
            pygui.selectable_bool_ptr("2. I am selectable", widget.select_selection[1])
            pygui.text("(I am not selectable)")
            pygui.selectable_bool_ptr("4. I am selectable", widget.select_selection[3])
            if pygui.selectable("5. I am double clickable", widget.select_selection[4], pygui.SELECTABLE_FLAGS_ALLOW_DOUBLE_CLICK):
                if pygui.is_mouse_double_clicked(pygui.MOUSE_BUTTON_LEFT):
                    widget.select_selection[4].value = not widget.select_selection[4].value
            pygui.tree_pop()
        
        if pygui.tree_node_ex("Selection State: Single Selection"):
            for n in range(5):
                if pygui.selectable(f"Object {n}", widget.select_single_state_selected == n):
                    widget.select_single_state_selected = n
            pygui.tree_pop()

        if pygui.tree_node_ex("Selection State: Multiple Selection"):
            help_marker("Hold CTRL and click to select multiple items.")
            for n in range(5):
                if pygui.selectable(f"Object {n}", widget.select_multi_state_selection[n]):
                    if not pygui.get_io().key_ctrl:
                        widget.select_multi_state_selection = [pygui.BoolPtr(False) for _ in range(len(widget.select_multi_state_selection))]
                    widget.select_multi_state_selection[n].value = not widget.select_multi_state_selection[n].value
            pygui.tree_pop()
        
        if pygui.tree_node_ex("Rendering more text into the same line"):
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
        
        if pygui.tree_node_ex("In columns"):
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
        
        if pygui.tree_node_ex("Grid"):
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

        if pygui.tree_node_ex("Alignment"):
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

    if pygui.tree_node_ex("Plotting"):
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

    if pygui.tree_node_ex("Color/Picker Widgets"):
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

    if pygui.tree_node_ex("Multi-component Widgets"):
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
    if pygui.tree_node_ex("Basic"):
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
    if pygui.tree_node_ex("Borders, background"):
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
    if pygui.tree_node_ex("Resizable, stretch"):
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
    if pygui.tree_node_ex("Resizable, fixed"):
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
    if pygui.tree_node_ex("Resizable, mixed"):
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
    if pygui.tree_node_ex("Reorderable, hideable, with headers"):
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
    if pygui.tree_node_ex("Padding"):
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
    if pygui.tree_node_ex("Sorting"):
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
