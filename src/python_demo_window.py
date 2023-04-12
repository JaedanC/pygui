from __future__ import annotations
import pygui
import math
import time
from PIL import Image


class static:
    _singleton_instance = None

    @staticmethod
    def instance() -> static:
        if static._singleton_instance is None:
            static._singleton_instance = static()
        return static._singleton_instance
    
    def __init__(self):
        self.widgets_image = Image.open("pygui/img/code.png")
        self.widgets_image_texture = pygui.load_image(self.widgets_image)

    widgets_general_clicked = 0
    widgets_general_check = pygui.BoolPtr(True)
    widgets_general_e = pygui.IntPtr(0)
    widgets_general_counter = 0
    widgets_inputs_str0 = pygui.StrPtr("Hello, World!", 128)
    widgets_inputs_str1 = pygui.StrPtr("", 128)
    widgets_inputs_i0 = pygui.IntPtr(123)
    widgets_inputs_f0 = pygui.FloatPtr(0.001)
    widgets_inputs_d0 = pygui.DoublePtr(999999.00000001)
    widgets_inputs_f1 = pygui.FloatPtr(1.e10)
    widgets_inputs_vec4a = [
        pygui.FloatPtr(0.1),
        pygui.FloatPtr(0.2),
        pygui.FloatPtr(0.3),
        pygui.FloatPtr(0.44),
    ]
    widgets_drag_i1 = pygui.IntPtr(50)
    widgets_drag_i2 = pygui.IntPtr(42)
    widgets_drag_f1 = pygui.FloatPtr(1)
    widgets_drag_f2 = pygui.FloatPtr(0.0067)
    widgets_sliders_i1 = pygui.IntPtr(0)
    widgets_sliders_f1 = pygui.FloatPtr(0.123)
    widgets_sliders_f2 = pygui.FloatPtr(0)
    widgets_sliders_angle = pygui.FloatPtr(0)
    widgets_sliders_elem = pygui.IntPtr(0)
    widgets_picker_col1 = pygui.Vec4Ptr(1, 0, 0.2, 1)
    widgets_picker_col2 = pygui.Vec4Ptr(0.4, 0.7, 0, 0.5)
    widgets_combo_item_current = pygui.IntPtr(0)
    widgets_list_item_current = pygui.IntPtr(0)
    widgets_tree_base_flags = pygui.IntPtr(
        pygui.IMGUI_TREE_NODE_FLAGS_OPEN_ON_ARROW | \
        pygui.IMGUI_TREE_NODE_FLAGS_OPEN_ON_DOUBLE_CLICK | \
        pygui.IMGUI_TREE_NODE_FLAGS_SPAN_AVAIL_WIDTH)
    widgets_tree_align_label_with_current_x_position = pygui.BoolPtr(False)
    widgets_tree_test_drag_and_drop = pygui.BoolPtr(False)
    widgets_tree_selection_mask = pygui.IntPtr(1 << 2)
    widgets_header_closable_group = pygui.BoolPtr(True)
    widgets_text_wrap_width = pygui.FloatPtr(200)
    widgets_text_utf8_buf = pygui.StrPtr("\xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e", 32)
    widgets_combo_flags = pygui.IntPtr(0)
    widgets_combo_item_current_idx = pygui.IntPtr(0)
    widgets_combo_item_current_2 = pygui.IntPtr(0)
    widgets_combo_item_current_3 = pygui.IntPtr(0)
    widgets_combo_item_current_4 = pygui.IntPtr(0)
    widgets_image_use_text_color_for_tint = pygui.BoolPtr(False)
    widgets_image_pressed_count = 0
    widgets_list_box_item_current_idx = 0
    widgets_select_selection = [
        pygui.BoolPtr(False),
        pygui.BoolPtr(True),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
    ]
    widgets_select_selected = -1
    widgets_select_single_state_selected = -1
    widgets_select_multi_state_selection = [
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
    ]
    widgets_select_render_selected = [
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
        pygui.BoolPtr(False),
    ]
    widgets_select_column_selected = [pygui.BoolPtr(False) for _ in range(10)]
    widgets_select_grid_selected = [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
    ]
    widgets_select_allign_selected = [
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
    widgets_plotting_animate = pygui.BoolPtr(True)
    widgets_plotting_arr = [
        0.6, 0.1, 1.0, 0.5, 0.92, 0.1, 0.2
    ]
    widgets_plotting_values = [0] * 90
    widgets_plotting_values_offset = 0
    widgets_plotting_refresh_time = 0
    widgets_plotting_phase = 0
    widgets_plotting_func_type = pygui.IntPtr(0)
    widgets_plotting_display_count = pygui.IntPtr(70)
    widgets_plotting_progress = 0
    widgets_plotting_progress_dir = 1
    widgets_colour_color = pygui.Vec4Ptr(114 / 255, 144 / 255, 154 / 255, 200 / 255)
    widgets_colour_flags = pygui.IntPtr(0)
    widgets_colour_alpha_preview = pygui.BoolPtr(True)
    widgets_colour_alpha_half_preview = pygui.BoolPtr(False)
    widgets_colour_drag_and_drop = pygui.BoolPtr(True)
    widgets_colour_options_menu = pygui.BoolPtr(True)
    widgets_colour_hdr = pygui.BoolPtr(False)
    widgets_colour_saved_palette_init = pygui.BoolPtr(True)
    widgets_colour_saved_palette = [pygui.Vec4Ptr(0, 0, 0, 0) for _ in range(32)]
    widgets_colour_backup_color = pygui.Vec4Ptr(0, 0, 0, 0)
    widgets_colour_no_border = pygui.BoolPtr(False)
    widgets_colour_alpha = pygui.BoolPtr(True)
    widgets_colour_alpha_bar = pygui.BoolPtr(True)
    widgets_colour_side_preview = pygui.BoolPtr(True)
    widgets_colour_ref_color = pygui.BoolPtr(False)
    widgets_colour_ref_color_v = pygui.Vec4Ptr(1, 0, 1, 0.5)
    widgets_colour_display_mode = pygui.IntPtr(False)
    widgets_colour_picker_mode = pygui.IntPtr(False)
    widgets_colour_color_hsv = pygui.Vec4Ptr(0.23, 1, 1, 1)
    widgets_multi_vec4f = pygui.Vec4Ptr(0.10, 0.2, 0.3, 0.44)
    widgets_multi_vec4i = pygui.Vec4Ptr(1, 5, 100, 255)



# From: https://stackoverflow.com/questions/4092528/how-can-i-clamp-clip-restrict-a-number-to-some-range#comment53230306_4092550
def clamp(n, smallest, largest):
    return max(smallest, min(n, largest))


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
            static.widgets_general_clicked += 1
        
        if static.widgets_general_clicked & 1:
            pygui.same_line()
            pygui.text("Thanks for clicking me!")
        
        pygui.checkbox("checkbox", static.widgets_general_check)

        pygui.radio_button("radio a", static.widgets_general_e, 0)
        pygui.same_line()
        pygui.radio_button("radio b", static.widgets_general_e, 1)
        pygui.same_line()
        pygui.radio_button("radio c", static.widgets_general_e, 2)
        
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

        spacing: float = pygui.get_style().item_inner_spacing[0]
        pygui.push_button_repeat(True)
        if pygui.arrow_button("##left", pygui.IMGUI_DIR_LEFT):
            static.widgets_general_counter -= 1
        pygui.same_line(0, spacing)
        if pygui.arrow_button("##right", pygui.IMGUI_DIR_RIGHT):
            static.widgets_general_counter += 1
        pygui.pop_button_repeat()
        pygui.same_line()
        pygui.text(str(static.widgets_general_counter))

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

        pygui.input_text("input text", static.widgets_inputs_str0)
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

        pygui.input_text_with_hint("input text (w/ hint)", "enter text here", static.widgets_inputs_str1)
        pygui.input_int("input int", static.widgets_inputs_i0)
        pygui.input_float("input float", static.widgets_inputs_f0, 0.01, 1.0, "%.3f")
        pygui.input_double("input double", static.widgets_inputs_d0, 0.01, 1.0, "%.8f")
        pygui.input_float("input scientific", static.widgets_inputs_f1, 0, 0, "%e")
        pygui.input_float2("input float2", static.widgets_inputs_vec4a)
        pygui.input_float3("input float3", static.widgets_inputs_vec4a)
        pygui.input_float4("input float4", static.widgets_inputs_vec4a)

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

        pygui.separator_text("Sliders")

        pygui.slider_int("slider int", static.widgets_sliders_i1, -1, 3)
        pygui.same_line()
        help_marker("CTRL+click to input value.")
        pygui.slider_float("slider float", static.widgets_sliders_f1, 0, 1, "ratio = %.3f")
        pygui.slider_float("slider float (log)", static.widgets_sliders_f2, -10, 10, "%.4f", pygui.IMGUI_SLIDER_FLAGS_LOGARITHMIC)
        pygui.slider_angle("slider angle", static.widgets_sliders_angle)

        # Using the format string to display a name instead of an integer.
        # Here we completely omit '%d' from the format string, so it'll only display a name.
        # This technique can also be used with DragInt().
        elements = ["Fire", "Earth", "Air", "Water"]
        elem_name = elements[static.widgets_sliders_elem.value] if 0 <= static.widgets_sliders_elem.value < len(elements) else "Unknown"
        pygui.slider_int("slider enum", static.widgets_sliders_elem, 0, len(elements) - 1, elem_name)
        pygui.same_line()
        help_marker("Using the format string parameter to display a name instead of the underlying integer.")
        
        pygui.separator_text("Selectors/Pickers")

        pygui.color_edit3("color 1", static.widgets_picker_col1)
        pygui.same_line()
        help_marker(
            "Click on the color square to open a color picker.\n"
            "Click and hold to use drag and drop.\n"
            "Right-click on the color square to show options.\n"
            "CTRL+click on individual component to input value.\n"
        )
        pygui.color_edit4("color 2", static.widgets_picker_col2)

        # Using the _simplified_ one-liner Combo() api here
        # See "Combo" section for examples of how to use the more flexible BeginCombo()/EndCombo() api.
        # I dunno man, it's pretty clean here in python...
        items = ["AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFF", "GGGG", "HHHH", "IIIIIII", "JJJJ", "KKKKKKK"]
        pygui.combo("combo", static.widgets_combo_item_current, items)
        pygui.same_line()
        help_marker("Using the simplified one-liner Combo API here.\nRefer to the \"Combo\" section below for an explanation of how to use the more flexible and general BeginCombo/EndCombo API.")
        
        items_list = ["Apple", "Banana", "Cherry", "Kiwi", "Mango", "Orange", "Pineapple", "Strawberry", "Watermelon"]
        pygui.list_box("listbox", static.widgets_list_item_current, items_list, 4)
        pygui.same_line()
        help_marker(
            "Using the simplified one-liner ListBox API here.\nRefer to the \"List boxes\" section below for an explanation of how to use the more flexible and general BeginListBox/EndListBox API."
        )

        pygui.tree_pop()
    
    if pygui.tree_node("Trees"):
        if pygui.tree_node("Basic trees"):
            for i in range(5):
                if i == 0:
                    pygui.set_next_item_open(True, pygui.IMGUI_COND_ONCE)
                
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
            pygui.checkbox_flags("ImGuiTreeNodeFlags_OpenOnArrow",       static.widgets_tree_base_flags, pygui.IMGUI_TREE_NODE_FLAGS_OPEN_ON_ARROW)
            pygui.checkbox_flags("ImGuiTreeNodeFlags_OpenOnDoubleClick", static.widgets_tree_base_flags, pygui.IMGUI_TREE_NODE_FLAGS_OPEN_ON_DOUBLE_CLICK)
            pygui.checkbox_flags("ImGuiTreeNodeFlags_SpanAvailWidth",    static.widgets_tree_base_flags, pygui.IMGUI_TREE_NODE_FLAGS_SPAN_AVAIL_WIDTH)
            pygui.same_line()
            help_marker("Extend hit area to all available width instead of allowing more items to be laid out after the node.")
            pygui.checkbox_flags("ImGuiTreeNodeFlags_SpanFullWidth",     static.widgets_tree_base_flags, pygui.IMGUI_TREE_NODE_FLAGS_SPAN_FULL_WIDTH)
            pygui.checkbox("Align label with current X position", static.widgets_tree_align_label_with_current_x_position)
            pygui.checkbox("Test tree node as drag source", static.widgets_tree_test_drag_and_drop)
            pygui.text("Hello!")
            if static.widgets_tree_align_label_with_current_x_position:
                pygui.unindent(pygui.get_tree_node_to_label_spacing())
            
            # 'selection_mask' is dumb representation of what may be user-side selection state.
            #  You may retain selection state inside or outside your objects in whatever format you see fit.
            # 'node_clicked' is temporary storage of what node we have clicked to process selection at the end
            #  of the loop. May be a pointer to your own node type, etc.
            node_clicked = -1
            for i in range(6):
                node_flags = static.widgets_tree_base_flags.value
                is_selected = (static.widgets_tree_selection_mask.value & (1 << i)) != 0
                if is_selected:
                    node_flags |= pygui.IMGUI_TREE_NODE_FLAGS_SELECTED
                if i < 3:
                    # Items 0..2 are Tree Node
                    node_open = pygui.tree_node(f"Selectable Node {i}", node_flags)
                    if pygui.is_item_clicked() and not pygui.is_item_toggled_open():
                        node_clicked = i
                    if static.widgets_tree_test_drag_and_drop and pygui.begin_drag_drop_source():
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
                    node_flags |= pygui.IMGUI_TREE_NODE_FLAGS_LEAF | pygui.IMGUI_TREE_NODE_FLAGS_NO_TREE_PUSH_ON_OPEN # ImGuiTreeNodeFlags_Bullet
                    pygui.tree_node(f"Selectable Leaf {i}", node_flags)
                    if pygui.is_item_clicked() and not pygui.is_item_toggled_open():
                        node_clicked = i
                    if static.widgets_tree_test_drag_and_drop and pygui.begin_drag_drop_source():
                        pygui.set_drag_drop_payload("_TREENODE", None, 0)
                        pygui.text("This is a drag and drop source")
                        pygui.end_drag_drop_source()
            
            if node_clicked != -1:
                # Update selection state
                # (process outside of tree loop to avoid visual inconsistencies during the clicking frame)
                if pygui.get_io().key_ctrl:
                    static.widgets_tree_selection_mask.value ^= (1 << node_clicked)              # CTRL+click to toggle
                else: #elif not (static.widgets_tree_selection_mask & (1 << node_clicked)) # Depending on selection behavior you want, may want to preserve selection when clicking on item that is part of the selection
                    static.widgets_tree_selection_mask.value = (1 << node_clicked)               # Click to single-select

            if static.widgets_tree_align_label_with_current_x_position:
                pygui.indent(pygui.get_tree_node_to_label_spacing())
            pygui.tree_pop()
        pygui.tree_pop()
    
    if pygui.tree_node("Collapsing Headers"):
        pygui.checkbox("Show 2nd header", static.widgets_header_closable_group)
        if pygui.collapsing_header("Header", None, pygui.IMGUI_TREE_NODE_FLAGS_NONE):
            pygui.text("IsItemHovered: {}".format(pygui.is_item_hovered()))
            for i in range(5):
                pygui.text(f"Some content {i}")
        
        if pygui.collapsing_header("Header with a close button", static.widgets_header_closable_group):
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

            pygui.slider_float("Wrap width", static.widgets_text_wrap_width, -20, 600, "%.0f")

            draw_list = pygui.get_window_draw_list()
            for n in range(2):
                pygui.text(f"Test paragraph {n}")
                pos = pygui.get_cursor_screen_pos()
                marker_min = (pos[0] + static.widgets_text_wrap_width.value, pos[1])
                marker_max = (pos[0] + static.widgets_text_wrap_width.value + 10, pos[1] + pygui.get_text_line_height())
                pygui.push_text_wrap_pos(pygui.get_cursor_pos()[0] + static.widgets_text_wrap_width.value)
                if n == 0:
                    pygui.text("The lazy dog is a good dog. This paragraph should fit within {} pixels. Testing a 1 character word. The quick brown fox jumps over the lazy dog.".format(
                        static.widgets_text_wrap_width.value
                    ))
                else:
                    pygui.text("aaaaaaaa bbbbbbbb, c cccccccc,dddddddd. d eeeeeeee   ffffffff. gggggggg!hhhhhhhh")
                
                draw_list.add_rect(pygui.get_item_rect_min(), pygui.get_item_rect_max(), pygui.IM_COL32(255, 255, 0, 255))
                draw_list.add_rect_filled(marker_min, marker_max, pygui.IM_COL32(255, 0, 255, 255))
                pygui.pop_text_wrap_pos()
            pygui.tree_pop()

        if pygui.tree_node("UTF-8 Text"):
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
            pygui.tree_pop()

        pygui.tree_pop()

    if pygui.tree_node("Images"):
        if pygui.tree_node("Custom Pygui Image"):
            pygui.image(
                static.instance().widgets_image_texture,
                (static.instance().widgets_image.width / 2,
                static.instance().widgets_image.height / 2))
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

            pygui.checkbox("Use Text Color for Tint", static.widgets_image_use_text_color_for_tint)
            pygui.text("{}x{}".format(my_tex_w, my_tex_h))
            pos = pygui.get_cursor_screen_pos()
            uv_min = (0, 0) # Top-left
            uv_max = (1, 1) # Lower-right
            if static.widgets_image_use_text_color_for_tint:
                tint_col = pygui.get_style_color_vec4(pygui.IMGUI_COL_TEXT)
            else:
                tint_col = (1, 1, 1, 1)
            border_col = pygui.get_style_color_vec4(pygui.IMGUI_COL_BORDER)
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
                    pygui.push_style_var_vec2(pygui.IMGUI_STYLE_VAR_FRAME_PADDING, (i - 1, i - 1))
                size = (32, 32)
                uv0 = (0, 0)
                uv1 = (32 / my_tex_w, 32 / my_tex_h)
                bg_col = (0, 0, 0, 1)
                tint_col = (1, 1, 1, 1)
                if pygui.image_button("", my_tex_id, size, uv0, uv1, bg_col, tint_col):
                    static.widgets_image_pressed_count += 1
                if i > 0:
                    pygui.pop_style_var()
                pygui.pop_id()
                pygui.same_line()
            
            pygui.new_line()
            pygui.text("Pressed {} times.".format(static.widgets_image_pressed_count))
            pygui.tree_pop()

        pygui.tree_pop()
    
    if pygui.tree_node("Combo"):
        # Combo Boxes are also called "Dropdown" in other systems
        # Expose flags as checkbox for the demo
        pygui.checkbox_flags("ImGuiComboFlags_PopupAlignLeft", static.widgets_combo_flags, pygui.IMGUI_COMBO_FLAGS_POPUP_ALIGN_LEFT)
        pygui.same_line()
        help_marker("Only makes a difference if the popup is larger than the combo")
        if pygui.checkbox_flags("ImGuiComboFlags_NoArrowButton", static.widgets_combo_flags, pygui.IMGUI_COMBO_FLAGS_NO_ARROW_BUTTON):
            static.widgets_combo_flags.value &= ~pygui.IMGUI_COMBO_FLAGS_NO_PREVIEW
        if pygui.checkbox_flags("ImGuiComboFlags_NoPreview", static.widgets_combo_flags, pygui.IMGUI_COMBO_FLAGS_NO_PREVIEW):
            static.widgets_combo_flags.value &= ~pygui.IMGUI_COMBO_FLAGS_NO_ARROW_BUTTON
        
        # Using the generic BeginCombo() API, you have full control over how to display the combo contents.
        # (your selection data could be an index, a pointer to the object, an id for the object, a flag intrusively
        # stored in the object itself, etc.)
        items = ["AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFF", "GGGG", "HHHH", "IIII", "JJJJ", "KKKK", "LLLLLLL", "MMMM", "OOOOOOO"]
        combo_preview_value = items[static.widgets_combo_item_current_idx.value]
        if pygui.begin_combo("combo 1", combo_preview_value, static.widgets_combo_flags.value):
            for n in range(len(items)):
                is_selected = static.widgets_combo_item_current_idx.value == n
                if pygui.selectable(items[n], is_selected):
                    static.widgets_combo_item_current_idx.value = n
                
                # Set the initial focus when opening the combo (scrolling + keyboard navigation focus)
                if is_selected:
                    pygui.set_item_default_focus()
            
            pygui.end_combo()
        
        # Simplified one-liner Combo() API, using values packed in a single constant string
        # This is a convenience for when the selection set is small and known at compile-time.
        # Pygui note: Obviously this doesn't really make sense in pygui. Just use a list.
        pygui.combo("combo 2 (one-liner)", static.widgets_combo_item_current_2, ["aaaa", "bbbb", "cccc", "dddd", "eeee"])

        # Simplified one-liner Combo() using an array of const char*
        # This is not very useful (may obsolete): prefer using BeginCombo()/EndCombo() for full control.
        # If the selection isn't within 0..count, Combo won't display a preview
        pygui.combo("combo 3 (array)", static.widgets_combo_item_current_3, items)

        # Simplified one-liner Combo() using an accessor function
        # This one is yet to be added, but still I question if this is required
        # in python. We're already inside a very high-level language. I'm yet to
        # see a benefit of using a callback function.
        # struct Funcs { static bool ItemGetter(void* data, int n, const char** out_str) { *out_str = ((const char**)data)[n]; return true; } };
        # static int item_current_4 = 0;
        # ImGui::Combo("combo 4 (function)", &item_current_4, &Funcs::ItemGetter, items, IM_ARRAYSIZE(items));
        pygui.tree_pop()

    if pygui.tree_node("List boxes"):
        # Using the generic BeginListBox() API, you have full control over how to display the combo contents.
        # (your selection data could be an index, a pointer to the object, an id for the object, a flag intrusively
        # stored in the object itself, etc.)
        items = ["AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFF", "GGGG", "HHHH", "IIII", "JJJJ", "KKKK", "LLLLLLL", "MMMM", "OOOOOOO"]
        if pygui.begin_list_box("listbox 1"):
            for n in range(len(items)):
                is_selected = static.widgets_list_box_item_current_idx == n
                if pygui.selectable(items[n], is_selected):
                    static.widgets_list_box_item_current_idx = n
                
                # Set the initial focus when opening the combo (scrolling + keyboard navigation focus)
                if is_selected:
                    pygui.set_item_default_focus()
                
            pygui.end_list_box()

        pygui.text("Full-width:")
        if pygui.begin_list_box("##listbox 2", (-pygui.FLT_MIN, 5 * pygui.get_text_line_height_with_spacing())):
            for n in range(len(items)):
                is_selected = static.widgets_list_box_item_current_idx == n
                if pygui.selectable(items[n], is_selected):
                    static.widgets_list_box_item_current_idx = n
                
                # Set the initial focus when opening the combo (scrolling + keyboard navigation focus)
                if is_selected:
                    pygui.set_item_default_focus()
            pygui.end_list_box()
        
        pygui.tree_pop()
    
    if pygui.tree_node("Selectables"):
        if pygui.tree_node("Basic"):
            pygui.selectable_bool_ptr("1. I am selectable", static.widgets_select_selection[0])
            pygui.selectable_bool_ptr("2. I am selectable", static.widgets_select_selection[1])
            pygui.text("(I am not selectable)")
            pygui.selectable_bool_ptr("4. I am selectable", static.widgets_select_selection[3])
            if pygui.selectable("5. I am double clickable", static.widgets_select_selection[4], pygui.IMGUI_SELECTABLE_FLAGS_ALLOW_DOUBLE_CLICK):
                if pygui.is_mouse_double_clicked(pygui.IMGUI_MOUSE_BUTTON_LEFT):
                    static.widgets_select_selection[4].ptr = not static.widgets_select_selection[4].ptr
            pygui.tree_pop()
        
        if pygui.tree_node("Selection State: Single Selection"):
            for n in range(5):
                if pygui.selectable(f"Object {n}", static.widgets_select_single_state_selected == n):
                    static.widgets_select_single_state_selected = n
            pygui.tree_pop()

        if pygui.tree_node("Selection State: Multiple Selection"):
            help_marker("Hold CTRL and click to select multiple items.")
            for n in range(5):
                if pygui.selectable(f"Object {n}", static.widgets_select_multi_state_selection[n]):
                    if not pygui.get_io().key_ctrl:
                        static.widgets_select_multi_state_selection = [pygui.BoolPtr(False) for _ in range(len(static.widgets_select_multi_state_selection))]
                    static.widgets_select_multi_state_selection[n].ptr = not static.widgets_select_multi_state_selection[n].ptr
            pygui.tree_pop()
        
        if pygui.tree_node("Rendering more text into the same line"):
            pygui.selectable_bool_ptr("main.c", static.widgets_select_render_selected[0])
            pygui.same_line(300)
            pygui.text(" 2,345 bytes")

            pygui.selectable_bool_ptr("Hello.cpp", static.widgets_select_render_selected[1])
            pygui.same_line(300)
            pygui.text("12,245 bytes")
            
            pygui.selectable_bool_ptr("Hello.h", static.widgets_select_render_selected[2])
            pygui.same_line(300)
            pygui.text(" 2,345 bytes")
            pygui.tree_pop()
        
        if pygui.tree_node("In columns"):
            if pygui.begin_table("split1", 3, pygui.IMGUI_TABLE_FLAGS_RESIZABLE | pygui.IMGUI_TABLE_FLAGS_NO_SAVED_SETTINGS | pygui.IMGUI_TABLE_FLAGS_BORDERS):
                for i in range(10):
                    pygui.table_next_column()
                    pygui.selectable_bool_ptr(f"Item {i}", static.widgets_select_column_selected[i])
                pygui.end_table()
            pygui.spacing()
            if pygui.begin_table("split2", 3, pygui.IMGUI_TABLE_FLAGS_RESIZABLE | pygui.IMGUI_TABLE_FLAGS_NO_SAVED_SETTINGS | pygui.IMGUI_TABLE_FLAGS_BORDERS):
                for i in range(10):
                    pygui.table_next_row()
                    pygui.table_next_column()
                    pygui.selectable_bool_ptr(f"Item {i}", static.widgets_select_column_selected[i], pygui.IMGUI_SELECTABLE_FLAGS_SPAN_ALL_COLUMNS)
                    pygui.table_next_column()
                    pygui.text("Some other contents")
                    pygui.table_next_column()
                    pygui.text("123456")
                pygui.end_table()
            pygui.tree_pop()
        
        if pygui.tree_node("Grid"):
            # Add in a bit of silly fun...
            current_time = pygui.get_time()
            winning_state = not any(0 in inner for inner in static.widgets_select_grid_selected)
            if winning_state:
                pygui.push_style_var_vec2(
                    pygui.IMGUI_STYLE_VAR_SELECTABLE_TEXT_ALIGN,
                    (0.5 + 0.5 * math.cos(current_time * 2), 0.5 + 0.5 * math.sin(current_time * 3))
                )
            for y in range(4):
                for x in range(4):
                    if x > 0:
                        pygui.same_line()
                    pygui.push_id_int(y * 4 + x)
                    if pygui.selectable("Sailor", bool(static.widgets_select_grid_selected[y][x]), 0, (50, 50)):
                        static.widgets_select_grid_selected[y][x] ^= 1
                        if x > 0:
                            static.widgets_select_grid_selected[y][x - 1] ^= 1
                        if x < 3:
                            static.widgets_select_grid_selected[y][x + 1] ^= 1
                        if y > 0:
                            static.widgets_select_grid_selected[y - 1][x] ^= 1
                        if y < 3:
                            static.widgets_select_grid_selected[y + 1][x] ^= 1
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
                    pygui.push_style_var_vec2(pygui.IMGUI_STYLE_VAR_SELECTABLE_TEXT_ALIGN, alignment)
                    pygui.selectable_bool_ptr(
                        "({:.1f}, {:.1f})".format(alignment[0], alignment[1]),
                        static.widgets_select_allign_selected[3 * y + x],
                        pygui.IMGUI_SELECTABLE_FLAGS_NONE,
                        (80, 80)
                    )
                    pygui.pop_style_var()
            pygui.tree_pop()
        pygui.tree_pop()

    if pygui.tree_node("Plotting"):
        pygui.checkbox("Animate", static.widgets_plotting_animate)

        # Plot as lines and plot as histogram
        pygui.plot_lines("Frame Times", static.widgets_plotting_arr)
        pygui.plot_histogram("Histogram", static.widgets_plotting_arr, 0, None, 0, 1, (0, 80))

        # Fill an array of contiguous float values to plot
        # Tip: If your float aren't contiguous but part of a structure, you can pass a pointer to your first float
        # and the sizeof() of your structure in the "stride" parameter.
        if not static.widgets_plotting_animate or static.widgets_plotting_refresh_time == 0:
            static.widgets_plotting_refresh_time = time.time()
        
        while static.widgets_plotting_refresh_time < time.time():
            static.widgets_plotting_values[static.widgets_plotting_values_offset] = math.cos(
                static.widgets_plotting_phase
            )
            static.widgets_plotting_values_offset = (static.widgets_plotting_values_offset + 1) % len(static.widgets_plotting_values)
            static.widgets_plotting_phase += 0.1 * static.widgets_plotting_values_offset
            static.widgets_plotting_refresh_time += 1 / 60

        average = 0
        for n in range(len(static.widgets_plotting_values)):
            average += static.widgets_plotting_values[n]
        average /= len(static.widgets_plotting_values)
        pygui.plot_lines(
            "Lines",
            static.widgets_plotting_values,
            static.widgets_plotting_values_offset,
            "avg {:.6f}".format(average),
            -1,
            1,
            (0, 80)
        )

        # This section has been modified to use pythonic functions and methods
        # rather than the values_getter moethod in the demo.
        pygui.separator_text("Functions")
        pygui.set_next_item_width(pygui.get_font_size() * 8)
        pygui.combo("func", static.widgets_plotting_func_type, ["Sin", "Saw"])
        pygui.same_line()
        pygui.slider_int("Sample count", static.widgets_plotting_display_count, 1, 400)

        def saw(value: int):
            return 1 if value & 1 == 0 else -1

        if static.widgets_plotting_func_type.value == 0:
            values = [math.sin(i / 10) for i in range(static.widgets_plotting_display_count.value)]
        else:
            values = [saw(i) for i in range(static.widgets_plotting_display_count.value)]
        
        pygui.plot_lines("Lines", values, 0, None, -1, 1, (0, 80))
        pygui.plot_histogram("Histogram", values, 0, None, -1, 1, (0, 80))
        pygui.separator()

        if static.widgets_plotting_animate:
            static.widgets_plotting_progress += static.widgets_plotting_progress_dir * 0.4 * pygui.get_io().delta_time
            if static.widgets_plotting_progress >= 1.1:
                static.widgets_plotting_progress = 1.1
                static.widgets_plotting_progress_dir *= -1
            if static.widgets_plotting_progress <= -0.1:
                static.widgets_plotting_progress = -0.1
                static.widgets_plotting_progress_dir *= -1

        # Typically we would use ImVec2(-1.0f,0.0f) or ImVec2(-FLT_MIN,0.0f) to use all available width,
        # or ImVec2(width,0.0f) for a specified width. ImVec2(0.0f,0.0f) uses ItemWidth.
        pygui.progress_bar(static.widgets_plotting_progress, (0, 0))
        pygui.same_line(0, pygui.get_style().item_inner_spacing[0])
        pygui.text("Progress Bar")
        
        progress_saturated = clamp(static.widgets_plotting_progress, 0, 1)
        pygui.progress_bar(static.widgets_plotting_progress, (0, 0), "{}/{}".format(
            int(progress_saturated * 1753), 1753
        ))
        pygui.tree_pop()

    if pygui.tree_node("Color/Picker Widgets"):
        pygui.separator_text("Options")
        pygui.checkbox_flags("With Alpha Preview", static.widgets_colour_flags, pygui.IMGUI_COLOR_EDIT_FLAGS_ALPHA_PREVIEW)
        pygui.checkbox_flags("With Half Alpha Preview", static.widgets_colour_flags, pygui.IMGUI_COLOR_EDIT_FLAGS_ALPHA_PREVIEW_HALF)
        pygui.checkbox_flags("No Drag and Drop", static.widgets_colour_flags, pygui.IMGUI_COLOR_EDIT_FLAGS_NO_DRAG_DROP)
        pygui.checkbox_flags("No Options Menu", static.widgets_colour_flags, pygui.IMGUI_COLOR_EDIT_FLAGS_NO_OPTIONS)
        pygui.same_line()
        help_marker("Right-click on the individual color widget to show options.")
        pygui.checkbox_flags("With HDR", static.widgets_colour_flags, pygui.IMGUI_COLOR_EDIT_FLAGS_HDR)
        pygui.same_line()
        help_marker("Currently all this does is to lift the 0..1 limits on dragging widgets.")
        misc_flags = static.widgets_colour_flags.value
        
        pygui.separator_text("Inline color editor")
        pygui.text("Color widget:")
        pygui.same_line()
        help_marker(
            "Click on the color square to open a color picker.\n"
            "CTRL+click on individual component to input value.\n")
        pygui.color_edit3("MyColor##1", static.widgets_colour_color, misc_flags)

        pygui.text("Color widget HSV with Alpha:")
        pygui.color_edit4("MyColor##2", static.widgets_colour_color, pygui.IMGUI_COLOR_EDIT_FLAGS_DISPLAY_HSV | misc_flags)

        pygui.text("Color widget with Float Display:")
        pygui.color_edit4("MyColor##2f", static.widgets_colour_color, pygui.IMGUI_COLOR_EDIT_FLAGS_FLOAT | misc_flags)
        
        pygui.text("Color button with Picker:")
        pygui.same_line()
        help_marker(
            "With the ImGuiColorEditFlags_NoInputs flag you can hide all the slider/text inputs.\n"
            "With the ImGuiColorEditFlags_NoLabel flag you can pass a non-empty label which will only "
            "be used for the tooltip and picker popup.")
        pygui.color_edit4("MyColor##3", static.widgets_colour_color, pygui.IMGUI_COLOR_EDIT_FLAGS_NO_INPUTS | pygui.IMGUI_COLOR_EDIT_FLAGS_NO_LABEL | misc_flags)

        pygui.text("Color button with Custom Picker Popup:")

        # Generate a default palette. The palette will persist and can be edited.
        if static.widgets_colour_saved_palette_init:
            for n in range(len(static.widgets_colour_saved_palette)):
                pygui.color_convert_hsv_to_rgb(
                    n / 31,
                    0.8,
                    0.8,
                    static.widgets_colour_saved_palette[n],
                )
                static.widgets_colour_saved_palette[n].w = 1 # Alpha
            static.widgets_colour_saved_palette_init.ptr = False
        
        open_popup = pygui.color_button("MyColor##3b", static.widgets_colour_color.vec(), misc_flags)
        pygui.same_line(0, pygui.get_style().item_inner_spacing[0])
        open_popup |= pygui.button("Palette")
        if open_popup:
            pygui.open_popup("mypicker")
            static.widgets_colour_backup_color = static.widgets_colour_color.copy()
        if pygui.begin_popup("mypicker"):
            pygui.text("MY CUSTOM COLOR PICKER WITH AN AMAZING PALETTE!")
            pygui.separator()
            pygui.color_picker4("##picker", static.widgets_colour_color, misc_flags | pygui.IMGUI_COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW | pygui.IMGUI_COLOR_EDIT_FLAGS_NO_SMALL_PREVIEW)
            pygui.same_line()

            pygui.begin_group()
            pygui.text("Current")
            pygui.color_button("##current", static.widgets_colour_color.vec(), pygui.IMGUI_COLOR_EDIT_FLAGS_NO_PICKER | pygui.IMGUI_COLOR_EDIT_FLAGS_ALPHA_PREVIEW_HALF, (60, 40))
            pygui.text("Previous")
            if pygui.color_button("##previous", static.widgets_colour_backup_color.vec(), pygui.IMGUI_COLOR_EDIT_FLAGS_NO_PICKER | pygui.IMGUI_COLOR_EDIT_FLAGS_ALPHA_PREVIEW_HALF, (60, 40)):
                static.widgets_colour_color = static.widgets_colour_backup_color.copy()
            pygui.separator()
            pygui.text("Palette")
            for n in range(len(static.widgets_colour_saved_palette)):
                pygui.push_id_int(n)
                if n % 8 != 0:
                    pygui.same_line(0, pygui.get_style().item_spacing[0])
                
                palette_button_flags = \
                    pygui.IMGUI_COLOR_EDIT_FLAGS_NO_ALPHA | \
                    pygui.IMGUI_COLOR_EDIT_FLAGS_NO_PICKER | \
                    pygui.IMGUI_COLOR_EDIT_FLAGS_NO_TOOLTIP
                if pygui.color_button("##palette", static.widgets_colour_saved_palette[n].vec(), palette_button_flags, (20, 20)):
                    preserved_alpha = static.widgets_colour_color.w
                    static.widgets_colour_color = static.widgets_colour_saved_palette[n].copy()
                    static.widgets_colour_color.w = preserved_alpha

                # Allow user to drop colors into each palette entry. Note that ColorButton() is already a
                # drag source by default, unless specifying the ImGuiColorEditFlags_NoDragDrop flag.
                # Pygui note. In the pyx file the accept drap drop payload for
                # the color 3f and 4f types will return Vec4Ptr containing the
                # color that is being dragged.
                if pygui.begin_drag_drop_target():
                    payload = pygui.accept_drag_drop_payload(pygui.IMGUI_PAYLOAD_TYPE_COLOR_3F)
                    payload: pygui.Vec4Ptr
                    if payload is not None:
                        preserved_alpha = static.widgets_colour_saved_palette[n].w
                        static.widgets_colour_saved_palette[n] = payload.copy()
                        static.widgets_colour_saved_palette[n].w = preserved_alpha
                    
                    payload = pygui.accept_drag_drop_payload(pygui.IMGUI_PAYLOAD_TYPE_COLOR_4F)
                    payload: pygui.Vec4Ptr
                    if payload is not None:
                        preserved_alpha = static.widgets_colour_saved_palette[n].w
                        static.widgets_colour_saved_palette[n] = payload.copy()
                        static.widgets_colour_saved_palette[n].w = preserved_alpha
                    pygui.end_drag_drop_target()
                
                pygui.pop_id()
            pygui.end_group()
            pygui.end_popup()

        pygui.text("Color button only:")
        pygui.checkbox("ImGuiColorEditFlags_NoBorder", static.widgets_colour_no_border)
        pygui.color_button(
            "MyColor##3c",
            static.widgets_colour_color.vec(),
            misc_flags | (pygui.IMGUI_COLOR_EDIT_FLAGS_NO_BORDER if static.widgets_colour_no_border else 0),
            (80, 80))
        
        pygui.separator_text("Color picker")
        pygui.checkbox("With Alpha", static.widgets_colour_alpha)
        pygui.checkbox("With Alpha Bar", static.widgets_colour_alpha_bar)
        pygui.checkbox("With Side Preview Bar", static.widgets_colour_side_preview)
        if static.widgets_colour_side_preview:
            pygui.same_line()
            pygui.checkbox("With Ref Color", static.widgets_colour_ref_color)
            if static.widgets_colour_ref_color:
                pygui.same_line()
                pygui.color_edit4("##RefColor", static.widgets_colour_ref_color_v, pygui.IMGUI_COLOR_EDIT_FLAGS_NO_INPUTS | misc_flags)
        pygui.combo("Display Mode", static.widgets_colour_display_mode, ["Auto/Current", "None", "RGB Only", "HSV Only", "Hex Only"])
        pygui.same_line()
        help_marker(
            "ColorEdit defaults to displaying RGB inputs if you don't specify a display mode, "
            "but the user can change it with a right-click on those inputs.\n\nColorPicker defaults to displaying RGB+HSV+Hex "
            "if you don't specify a display mode.\n\nYou can change the defaults using SetColorEditOptions().")
        pygui.same_line()
        help_marker("When not specified explicitly (Auto/Current mode), user can right-click the picker to change mode.")
        flags = misc_flags
        if not static.widgets_colour_alpha: # This is by default if you call ColorPicker3() instead of ColorPicker4()
            flags |= pygui.IMGUI_COLOR_EDIT_FLAGS_NO_ALPHA
        if static.widgets_colour_alpha_bar:
            flags |= pygui.IMGUI_COLOR_EDIT_FLAGS_ALPHA_BAR
        if not static.widgets_colour_side_preview:
            flags |= pygui.IMGUI_COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW
        if static.widgets_colour_picker_mode.value == 1:
            flags |= pygui.IMGUI_COLOR_EDIT_FLAGS_PICKER_HUE_BAR
        if static.widgets_colour_picker_mode.value == 2:
            flags |= pygui.IMGUI_COLOR_EDIT_FLAGS_PICKER_HUE_WHEEL
        if static.widgets_colour_display_mode.value == 1:
            flags |= pygui.IMGUI_COLOR_EDIT_FLAGS_NO_INPUTS # Disable all RGB/HSV/Hex displays
        if static.widgets_colour_display_mode.value == 2:
            flags |= pygui.IMGUI_COLOR_EDIT_FLAGS_DISPLAY_RGB # Override display mode
        if static.widgets_colour_display_mode.value == 3:
            flags |= pygui.IMGUI_COLOR_EDIT_FLAGS_DISPLAY_HSV
        if static.widgets_colour_display_mode.value == 4:
            flags |= pygui.IMGUI_COLOR_EDIT_FLAGS_DISPLAY_HEX

        pygui.color_picker4("MyColor##4", static.widgets_colour_color, flags, static.widgets_colour_ref_color_v if static.widgets_colour_ref_color else None)

        pygui.text("Set defaults in code:")
        pygui.same_line()
        help_marker("SetColorEditOptions() is designed to allow you to set boot-time default.\n"
            "We don't have Push/Pop functions because you can force options on a per-widget basis if needed,"
            "and the user can change non-forced ones with the options menu.\nWe don't have a getter to avoid"
            "encouraging you to persistently save values that aren't forward-compatible.")
        if pygui.button("Default: Uint8 + HSV + Hue Bar"):
            pygui.set_color_edit_options(pygui.IMGUI_COLOR_EDIT_FLAGS_UINT8 | pygui.IMGUI_COLOR_EDIT_FLAGS_DISPLAY_HSV | pygui.IMGUI_COLOR_EDIT_FLAGS_PICKER_HUE_BAR)
        if pygui.button("Default: Float + HDR + Hue Wheel"):
            pygui.set_color_edit_options(pygui.IMGUI_COLOR_EDIT_FLAGS_FLOAT | pygui.IMGUI_COLOR_EDIT_FLAGS_HDR | pygui.IMGUI_COLOR_EDIT_FLAGS_PICKER_HUE_WHEEL)

        # Always both a small version of both types of pickers (to make it more visible in the demo to people who are skimming quickly through it)
        pygui.text("Both types:")
        w = (pygui.get_content_region_avail()[0] - pygui.get_style().item_spacing[1]) * 0.4
        pygui.set_next_item_width(w)
        pygui.color_picker3("##MyColor##5", static.widgets_colour_color, pygui.IMGUI_COLOR_EDIT_FLAGS_PICKER_HUE_BAR | pygui.IMGUI_COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW | pygui.IMGUI_COLOR_EDIT_FLAGS_NO_INPUTS | pygui.IMGUI_COLOR_EDIT_FLAGS_NO_ALPHA)
        pygui.same_line()
        pygui.set_next_item_width(w)
        pygui.color_picker3("##MyColor##6", static.widgets_colour_color, pygui.IMGUI_COLOR_EDIT_FLAGS_PICKER_HUE_WHEEL | pygui.IMGUI_COLOR_EDIT_FLAGS_NO_SIDE_PREVIEW | pygui.IMGUI_COLOR_EDIT_FLAGS_NO_INPUTS | pygui.IMGUI_COLOR_EDIT_FLAGS_NO_ALPHA)

        # HSV encoded support (to avoid RGB<>HSV round trips and singularities when S==0 or V==0)
        pygui.spacing()
        pygui.text("HSV encoded colors")
        pygui.same_line()
        help_marker(
            "By default, colors are given to ColorEdit and ColorPicker in RGB, but ImGuiColorEditFlags_InputHSV"
            "allows you to store colors as HSV and pass them to ColorEdit and ColorPicker as HSV. This comes with the"
            "added benefit that you can manipulate hue values with the picker even when saturation or value are zero.")
        pygui.text("Color widget with InputHSV:")
        pygui.color_edit4("HSV shown as RGB##1", static.widgets_colour_color_hsv, pygui.IMGUI_COLOR_EDIT_FLAGS_DISPLAY_RGB | pygui.IMGUI_COLOR_EDIT_FLAGS_INPUT_HSV | pygui.IMGUI_COLOR_EDIT_FLAGS_FLOAT)
        pygui.color_edit4("HSV shown as HSV##1", static.widgets_colour_color_hsv, pygui.IMGUI_COLOR_EDIT_FLAGS_DISPLAY_HSV | pygui.IMGUI_COLOR_EDIT_FLAGS_INPUT_HSV | pygui.IMGUI_COLOR_EDIT_FLAGS_FLOAT)
        drag_floats = [pygui.FloatPtr(v) for v in static.widgets_colour_color_hsv.vec()]
        pygui.drag_float4("Raw HSV values", drag_floats, 0.01, 0, 1)
        static.widgets_colour_color_hsv = pygui.Vec4Ptr(*(f.value for f in drag_floats))

        pygui.tree_pop()

    if pygui.tree_node("Multi-component Widgets"):
        pygui.separator_text("2-wide")
        pygui.input_float2("input float2", static.widgets_multi_vec4f.as_floatptrs())
        pygui.drag_float2("drag float2", static.widgets_multi_vec4f.as_floatptrs(), 0.01, 0, 1)
        pygui.slider_float2("slider float2", static.widgets_multi_vec4f.as_floatptrs(), 0, 1)
        pygui.input_int2("input int2", static.widgets_multi_vec4i.as_floatptrs())
        pygui.drag_int2("drag int2", static.widgets_multi_vec4i.as_floatptrs(), 1, 0, 255)
        pygui.slider_int2("slider int2", static.widgets_multi_vec4i.as_floatptrs(), 0, 255)

        pygui.separator_text("3-wide")
        pygui.input_float3("input float3", static.widgets_multi_vec4f.as_floatptrs())
        pygui.drag_float3("drag float3", static.widgets_multi_vec4f.as_floatptrs(), 0.01, 0, 1)
        pygui.slider_float3("slider float3", static.widgets_multi_vec4f.as_floatptrs(), 0, 1)
        pygui.input_int3("input int3", static.widgets_multi_vec4i.as_floatptrs())
        pygui.drag_int3("drag int3", static.widgets_multi_vec4i.as_floatptrs(), 1, 0, 255)
        pygui.slider_int3("slider int3", static.widgets_multi_vec4i.as_floatptrs(), 0, 255)

        pygui.separator_text("4-wide")
        pygui.input_float4("input float4", static.widgets_multi_vec4f.as_floatptrs())
        pygui.drag_float4("drag float4", static.widgets_multi_vec4f.as_floatptrs(), 0.01, 0, 1)
        pygui.slider_float4("slider float4", static.widgets_multi_vec4f.as_floatptrs(), 0, 1)
        pygui.input_int4("input int4", static.widgets_multi_vec4i.as_floatptrs())
        pygui.drag_int4("drag int4", static.widgets_multi_vec4i.as_floatptrs(), 1, 0, 255)
        pygui.slider_int4("slider int4", static.widgets_multi_vec4i.as_floatptrs(), 0, 255)

        pygui.tree_pop()
