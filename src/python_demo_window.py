import pygui
import math
import time


class static:
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
    widgets_picker_col1 = [
        pygui.FloatPtr(1),
        pygui.FloatPtr(0),
        pygui.FloatPtr(0.2),
    ]
    widgets_picker_col2 = [
        pygui.FloatPtr(0.4),
        pygui.FloatPtr(0.7),
        pygui.FloatPtr(0),
        pygui.FloatPtr(0.5),
    ]
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

        spacing: float = pygui.get_style().item_inner_spacing.x
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
        pygui.text("# TODO: Looking to incorporate pillow or another raw format")
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
        # TODO: This one is yet to be added.
        # struct Funcs { static bool ItemGetter(void* data, int n, const char** out_str) { *out_str = ((const char**)data)[n]; return true; } };
        # static int item_current_4 = 0;
        # ImGui::Combo("combo 4 (function)", &item_current_4, &Funcs::ItemGetter, items, IM_ARRAYSIZE(items));
        pygui.tree_pop()