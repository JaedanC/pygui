from __future__ import annotations
from typing import List, Any, Dict
from io import StringIO
from pyx_parser import *
import builtins
import json
import keyword
import sys
import textwrap


PYX_TEMPLATE_MARKER = "# ---- Start Generated Content ----\n\n"


class MergeFailed(Exception):
    pass


class MergeResult:
    def __init__(self, old_pyx: str, new_pyx: str, template_pyx: str):
        self.old_pyx: str      = old_pyx
        self.new_pyx: str      = new_pyx
        self.template_pyx: str = template_pyx

        self.old_model: PyxHeader = create_pyx_model(old_pyx)
        self.new_model: PyxHeader = create_pyx_model(new_pyx)
        self.template_model: PyxHeader = create_pyx_model(template_pyx)

        comparison = HeaderComparison(self.old_model, self.new_model)
        self.merged_model: PyxHeader = comparison.create_new_header_based_on_comparison(self.template_model)
        if self.merged_model is None:
            raise MergeFailed
        
        self.merged_pyx: str = replace_after(
            new_pyx,
            PYX_TEMPLATE_MARKER,
            self.merged_model.as_pyx()
        )
        self.merged_pyx_all_active: str = replace_after(
            new_pyx,
            PYX_TEMPLATE_MARKER,
            self.merged_model.as_pyx(ignore_active_flag=True)
        )


class DearBinding:
    def __init__(self, enums, typedefs, structs, functions):
        self.enums: List[DearEnum] = enums
        self.typedefs: List[DearTypedef] = typedefs
        self.structs: List[DearStruct] = structs
        self.functions: List[DearFunction] = []
        
        methods: List[DearFunction] = []
        for function in functions:
            function: DearFunction
            if len(function.arguments) > 0 and function.arguments[0].name == "self":
                methods.append(function)
                continue
            self.functions.append(function)
        
        struct_lookup = {s.name: s for s in self.structs}
        for method in methods:
            method: DearFunction
            class_name = method.arguments[0].type.with_no_const_or_asterisk()
            # Modify the name of the function so that it looks more like a 
            # method.
            method.python_name = method.python_name.replace(class_name + "_", "", 1)
            struct_lookup[class_name].add_method(method)
    
    def __repr__(self):
        return \
            "Enums:\n{}\n\n".format("\n".join([str(e) for e in self.enums])) + \
            "Typedefs:\n{}\n\n".format("\n".join([str(e) for e in self.typedefs])) + \
            "Structs:\n{}\n\n".format("\n".join([str(e) for e in self.structs])) + \
            "Functions:\n{}\n".format("\n".join([str(e) for e in self.functions]))

    def sort(self):
        self.functions.sort(key=lambda x: x.name_omitted_imgui_prefix())
        self.structs.sort(key=lambda x: x.name)
        for struct in self.structs:
            struct.fields.sort(key=lambda x: x.name)
            struct.methods.sort(key=lambda x: x.name)

    def is_cimgui_type(self, _type: DearType):
        for enum in self.enums:
            if _type.with_no_const_or_asterisk() == enum:
                return True
            for enum_element in enum.elements:
                if _type.with_no_const_or_asterisk() == enum_element.name:
                    return True
        
        for typedef in self.typedefs:
            if typedef.definition.raw_type == _type.with_no_const_or_asterisk():
                return True
        
        for struct in self.structs:
            if _type.with_no_const_or_asterisk() == struct.name:
                return True
        
        return False

    def follow_type(self, _type: DearType) -> DearType:
        if not self.is_cimgui_type(_type):
            return _type
        
        for enum in self.enums:
            if enum.name == _type.with_no_const_or_asterisk():
                return DearType("int")

        for typedef in self.typedefs:
            if _type.with_no_const_or_asterisk() == typedef.definition.raw_type:
                return self.follow_type(typedef.base)
        
        return _type

    def as_name_type_default_parameter(self, argument: DearFunction.Argument):
        parameter_format = "{}: {}{}".format(
            argument.name,
            self.as_python_type(self.follow_type(argument.type)),
            "={}".format(argument.default_value) if argument.default_value is not None else ""
        )
        return parameter_format

    def as_python_type(self, _type: DearType):
        python_type_lookup = {
            "bool": "bool",
            "bool*": "BoolPtr",
            "char": "int",
            "int": "int",
            "int*": "IntPtr",
            "short": "int",
            "short*": "IntPtr",
            "long": "int",
            "long*": "IntPtr",
            "float": "float",
            "float*": "FloatPtr",
            "double": "float",
            "double*": "DoublePtr",
            "ImVec2": "tuple",
            "ImVec4": "tuple",
            "void": "None",
            "char*": "str",
        }
        _type = self.follow_type(_type)
        
        if _type.is_array() and _type.ptr_version() is not None:
            return "Sequence[" + _type.ptr_version() + "]"
        
        if _type.with_no_const_or_sign() in python_type_lookup:
            return python_type_lookup[_type.with_no_const_or_sign()]
        
        for struct in self.structs:
            if struct.name == _type.with_no_const_or_asterisk():
                return struct.name
        
        if _type.is_function_type():
            return "Callable"
        

        return "Any"

    def marshall_c_to_python(self, _type: DearType):
        _type = self.follow_type(_type)
        
        if _type.is_string():
            return "_from_bytes({})"
        
        if _type.is_vec2():
            return "_cast_ImVec2_tuple({})"
        
        if _type.is_vec4():
            return "_cast_ImVec4_tuple({})"

        if _type.ptr_version() is not None:
            return _type.ptr_version() + "(dereference({}))"

        if self.is_cimgui_type(_type):
            return _type.with_no_const_or_asterisk() + ".from_ptr({})"
        
        return "{}"

    def marshall_python_to_c(self, _type: DearType, default_value=None):
        _type = self.follow_type(_type)

        if _type.is_vec2():
            return "_cast_tuple_ImVec2({})"

        if _type.is_vec4():
            return "_cast_tuple_ImVec4({})"
        
        if _type.is_string():
            return "_bytes({})"
        
        if _type.ptr_version() and default_value == "None":
            return _type.ptr_version() + ".ptr({})"
        
        if _type.ptr_version() is not None:
            return "&{}.value"

        if self.is_cimgui_type(_type):
            return "{}._ptr"
        
        return "{}"


class Template:
    """Represents a function in a pyx file. Has a specific format to ease with
    creating the function.
    """
    def __init__(self, base_template: str):
        self.base: str = base_template
    
    def set_condition(self, condition: str, value: bool) -> Template:
        """Any conditions in the file will be included or excluded based on
        value. Example:
        
        --------------------
        #if show_this
            print("hello")
        #else
            print("world)
        #endif
        --------------------

        template.set_condition("show_this", True)

        ----- Results ------
            print("hello")
        --------------------
        """
        in_correct_block = False
        in_correct_if_block = False
        in_correct_else_block = False
        if_block_stack = 0
        filtered_lines = []
        for line in self.base.split("\n"):
            line_stripped = line.strip()
            include_this_line = True

            # Custom comments
            if line.startswith("##"):
                include_this_line = False

            if line_stripped.startswith(f"#if {condition}"):
                in_correct_block = True
                in_correct_if_block = True
                include_this_line = False
            
            if in_correct_block and line_stripped.startswith("#if"):
                if_block_stack += 1 
            elif in_correct_block and line_stripped.startswith("#endif"):
                if_block_stack -= 1
            
            if line_stripped.startswith("#else") and in_correct_block and if_block_stack == 1:
                in_correct_else_block = True
                in_correct_if_block = False
                include_this_line = False
            if line_stripped.startswith("#endif") and in_correct_block and if_block_stack == 0:
                in_correct_block = False
                in_correct_else_block = False
                in_correct_if_block = False
                include_this_line = False

            # If we are in the corresponding block
            show_line = (in_correct_if_block and value) or (in_correct_else_block and not value) or not in_correct_block
            if show_line and include_this_line:
                filtered_lines.append(line)
        
        self.base = "\n".join(filtered_lines)
        return self

    def format(self, **kwargs) -> Template:
        """Works like a normal string .format except this does not error if a
        {placeholder} is missing a corresponding =kwargs, or a =kwarg does not match a
        {placeholder}. It's like a "safe" .format.
        """
        # From https://www.programiz.com/python-programming/methods/string/format_map
        class IgnoreMissing(dict):
            def __missing__(self, key):
                return "{" + key + "}"
        try:
            self.base = self.base.format_map(IgnoreMissing(**kwargs))
        except ValueError:
            print(self.base)
            print(kwargs)
            raise ValueError
        return self

    def compile(self, **kwargs) -> str:
        """Compiles the resulting function based on the information provided
        in the constructor and the conditions.

        Returns:
            str: A non-indented template string. May still contain missing
                 {placeholders}
        """
        for kwarg, value in kwargs.items():
            self.set_condition(kwarg, value)
        
        self.format(**kwargs)
        return self.base


class Comments:
    def __init__(self, comment_preceeding: List[str], comment_attached: str):
        self.comment_proceeding: List[str] = comment_preceeding
        self.comment_attached: str         = comment_attached

        if self.comment_attached is not None:
            self.comment_attached = self.comment_attached.replace('"', "'")
            self.comment_attached = self.comment_attached.lstrip("// ").capitalize()
        
        self.comment_proceeding = [line.lstrip("// ") for line in self.comment_proceeding]
        
    def three_quote_all_comments(self):
        if len(self.comment_proceeding) == 0 and self.comment_attached is None:
            return None
        
        comment_attached_no_none = self.comment_attached if self.comment_attached is not None else ""
        
        comment = textwrap.dedent(
        '''
        """
        {}
        """
        ''')

        if len(self.comment_proceeding) == 0 or self.comment_attached is None:
            comment = comment.format(
                "\n".join(self.comment_proceeding) + comment_attached_no_none.capitalize())
        else:
            comment = comment.format(
                "\n".join(self.comment_proceeding) + "\n" + comment_attached_no_none.capitalize())
        return comment.strip()

    def three_quote_proceeding_only(self):
        if len(self.comment_proceeding) == 0:
            return None
        
        return textwrap.dedent(
        '''
        """
        {}
        """
        '''.format("\n".join(self.comment_proceeding)))
        return comment

    def hash_all_comments(self):
        if len(self.comment_proceeding) == 0 and self.comment_attached is None:
            return None
        
        if len(self.comment_proceeding) > 0 and self.comment_attached is not None:
            return textwrap.dedent(
                """
                {}
                # {}
                """).format(
                    "\n".join(["# " + line for line in self.comment_proceeding]),
                    self.comment_attached
                ).strip("\n")
        
        if len(self.comment_proceeding) > 0:
            return "\n".join(["# " + line for line in self.comment_proceeding])
        return "# " + self.comment_attached

    def hash_proceeding_only(self):
        if len(self.comment_proceeding) == 0:
            return None

        return "\n".join(["# " + line for line in self.comment_proceeding])

    def hash_attached_only(self):
        if self.comment_attached is None:
            return None
        return "# " + self.comment_attached


class DearEnum:
    class Value:
        def __init__(self, name: str, value: int, comments: Comments):
            self.name: str          = name
            self.value: int         = value
            self.comments: Comments = comments
        
        def name_omitted_imgui_prefix(self):
            return self.name.replace("ImGui", "", 1)
        

    def __init__(self, name: str, elements: List[Value], comments: Comments):
        self.name: str                      = name
        self.elements: List[DearEnum.Value] = elements
        self.comments: Comments             = comments
    
    def __repr__(self):
        return "Enum({} -> {} elements)".format(self.name, len(self.elements))


class DearType:
    def __init__(self, raw_type: str, is_array_size=None):
        self.raw_type: str = raw_type
        self.array_size: int = is_array_size
        if is_array_size is not None:
            self.raw_type += "*"
    
    def __repr__(self):
        return "Type({})".format(self.raw_type)
    
    def is_function_type(self) -> bool:
        return "(*" in self.raw_type
    
    def is_array(self):
        return self.array_size is not None

    def with_no_const(self):
        return self.raw_type \
            .replace("const ", "")

    def with_no_const_or_sign(self):
        return self.with_no_const() \
            .replace("unsigned ", "") \
            .replace("signed ", "")

    def with_no_const_or_asterisk(self):
        return self.with_no_const() \
            .replace("*", "")
    
    def is_void_type(self):
        return self.raw_type == "void"
    
    def is_string(self):
        return self.with_no_const() == "char*"
    
    def is_vec2(self):
        return self.with_no_const() == "ImVec2"
    
    def is_vec4(self):
        return self.with_no_const() == "ImVec4"

    def ptr_version(self):
        ptr_version_mappings = {
            "bool*": "BoolPtr",
            "int*": "IntPtr",
            "float*": "FloatPtr",
            "double*": "DoublePtr",
        }
        if self.is_array() and self.with_no_const() in ptr_version_mappings:
                return ptr_version_mappings[self.with_no_const()]

        if self.with_no_const() in ptr_version_mappings:
            return ptr_version_mappings[self.with_no_const()]
        return None


class DearTypedef:
    def __init__(self, base: DearType, definition: DearType, comments: Comments):
        self.base: DearType       = base
        self.definition: DearType = definition
        self.comments: Comments   = comments
    
    def __repr__(self):
        return "Typedef({} <- {})".format(self.base, self.definition)


class DearStruct:
    class Field:
        def __init__(self, name: str, _type: DearType, comments: Comments):
            self.name: str          = name
            self.type: DearType     = _type
            self.comments: Comments = comments
        
        def __repr__(self):
            return "Field({}: {})".format(self.name, self.type)
    
    def __init__(self, name: str, imgui_name: str, forward_declaration: bool,
                 fields: List[Field], comments: Comments):
        self.name: str                 = name
        self.imgui_name: str           = imgui_name
        self.forward_declaration: bool = forward_declaration
        self.fields: List[DearStruct.Field] = fields
        self.comments: Comments        = comments

        self.methods: List[DearFunction] = []
    
    def __repr__(self):
        return "Struct({}({}))".format(self.name, ", ".join((str(f) for f in self.fields)))

    def add_method(self, method: DearFunction):
        self.methods.append(method)


class DearFunction:
    class Argument:
        def __init__(self, name: str, _type: DearType, is_array: bool,
                     default_value: Any, comments: Comments):
            self.name: str          = name
            self.type: DearType     = _type
            self.is_array: bool     = is_array
            self.comments: Comments = comments

            default_lookup = {
                "NULL": "None",
                "true": "True",
                "false": "False",
            }

            if default_value is not None:
                if default_value in default_lookup:
                    default_value = default_lookup[default_value]
                
                if "ImVec2" in default_value:
                    default_value = default_value.replace("ImVec2", "")
                    default_value = default_value.replace("f", "")
                elif "ImVec4" in default_value:
                    default_value = default_value.replace("ImVec4", "")
                    default_value = default_value.replace("f", "")
                
                if _type.raw_type == "float":
                    default_value = default_value.replace("f", "")
            
            self.default_value: Any = default_value
        
        def __repr__(self):
            return "Arg({}: {})".format(self.name, self.type)
    
    def __init__(self, name: str, imgui_name: str, return_type: DearType,
                 arguments: List[Argument], is_default_argument_helper: bool,
                 is_manual_helper: bool, is_imstr_helper: bool, 
                 has_imstr_helper: bool, comments: Comments):
        self.name: str                        = name
        self.python_name: str                 = name
        self.imgui_name: str                  = imgui_name
        self.return_type: DearType            = return_type
        self.arguments: List[DearFunction.Argument] = arguments
        self.is_default_argument_helper: bool = is_default_argument_helper
        self.is_manual_helper: bool           = is_manual_helper
        self.is_imstr_helper: bool            = is_imstr_helper
        self.has_imstr_helper: bool           = has_imstr_helper
        self.comments: Comments               = comments
    
    def __repr__(self):
        return "Function({}({}) -> {})".format(
            self.name,
            ", ".join((str(a) for a in self.arguments)),
            self.return_type
        )
    
    def name_omitted_imgui_prefix(self):
        return self.python_name.replace("ImGui_", "", 1)


def pythonise_string(string: str, make_upper=False) -> str:
    """
    Converts a string to be snake_case or UPPER_CASE depending on the value
    of make_upper. Returns a new string.
    """

    new_string = ""
    isupper_count = 0
    for i, char in enumerate(string.replace("_", "")):
        if char.isupper():
            if isupper_count == 0 and i > 0:
                new_string += "_"
            isupper_count += 1
        elif isupper_count > 1 and i > 2: # i condition because of vslider_float
            isupper_count = 0
            new_string += "_"
        else:
            isupper_count = 0
        
        new_string += char
    
    if make_upper:
        return new_string.upper()
    
    return new_string.lower()


def safe_python_name(name: str, edit_format="{}_") -> str:
    """Modifies a string to not be a keyword or built-in function. Not using
    this causes Cython to freak out. This adds an underscore if a conflict is
    found. A new string is returned.
    """
    if name in keyword.kwlist or name in dir(builtins) or name == "format":
        name = edit_format.format(name)
    return name


def replace_after(src: str, marker_substring: str, new_impl: str) -> str:
    ms_len = len(marker_substring)
    src = src[:src.index(marker_substring) + ms_len] + new_impl
    return src


def wrap_text(text, to_size=60) -> str:
    """
    Adds newlines to text such that at least 'to_size' characters are present on
    each line. When a 'to_size' characters are found, the next space will be
    replaced by a newline.
    """
    output = ""
    i = 0
    for char in text:
        if i < to_size:
            output += char
        elif char == " ":
            output += "\n"
            i = 0
        else:
            output += char

        i += 1
    return output


def parse_binding_json(cimgui_json, definitions) -> DearBinding:
    def parse_comment(json_containing_comment) -> Comments:
        proceeding = []
        attached = None
        if "comments" not in json_containing_comment:
            return Comments(proceeding, attached)
        
        if "attached" in json_containing_comment["comments"]:
            attached = json_containing_comment["comments"]["attached"]
        
        if "preceding" in json_containing_comment["comments"]:
            proceeding = json_containing_comment["comments"]["preceding"]
        return Comments(proceeding, attached)

    def passes_conditional(obj_containing_conditional, definitions, verbose=False):
        def is_defined(expression, definitions):
            for define, _ in definitions:
                if expression == define:
                    return True
            return False
        
        def is_true(expression, definitions):
            for define, value in definitions:
                if expression == define:
                    return value
            return False

        if "conditionals" not in obj_containing_conditional:
            return True

        conditional_list = obj_containing_conditional["conditionals"]
        
        if verbose:
            print(conditional_list, end=" ")

        for conditional_obj in conditional_list:
            condition, expression = conditional_obj.values()
            if condition == "ifndef" and not is_defined(expression, definitions):
                continue

            if condition == "ifdef" and is_defined(expression, definitions):
                continue
            
            if condition == "if":
                if "defined" in expression or is_true(expression, definitions):
                    continue
            
            if verbose:
                print("Failed")
            return False
        if verbose:
            print("Failed")
        return True


    # Enums
    parsed_enums: List[DearEnum] = []
    for enum_obj in cimgui_json["enums"]:
        if not passes_conditional(enum_obj, definitions):
            continue

        enum_name = enum_obj["name"]

        parsed_enums_values = []
        for enum_element_obj in enum_obj["elements"]:
            if not passes_conditional(enum_element_obj, definitions):
                continue

            enum_element_name = enum_element_obj["name"]
            if "value" in enum_element_obj:
                enum_element_value = enum_element_obj["value"]
            else:
                enum_element_value = None
            enum_element_comment = parse_comment(enum_element_obj)
            parsed_enums_values.append(DearEnum.Value(
                enum_element_name,
                enum_element_value,
                enum_element_comment,
            ))
        enum_comments = parse_comment(enum_obj)
        parsed_enums.append(DearEnum(enum_name, parsed_enums_values, enum_comments))
    
    # Typedefs
    parsed_typedefs: List[DearTypedef] = []
    for typedef_obj in cimgui_json["typedefs"]:
        if not passes_conditional(typedef_obj, definitions):
            continue

        typedef_name = typedef_obj["name"]
        typedef_type = typedef_obj["type"]["declaration"]
        typedef_comments = parse_comment(typedef_obj)
        parsed_typedefs.append(DearTypedef(
            DearType(typedef_type),
            DearType(typedef_name),
            typedef_comments,
        ))
    
    # Structs
    parsed_structs: List[DearStruct] = []
    for struct_obj in cimgui_json["structs"]:
        if not passes_conditional(struct_obj, definitions):
            continue

        # Ignore any anonymous structs
        if struct_obj["is_anonymous"]:
            continue

        struct_name = struct_obj["name"]
        struct_original_fully_qualified_name = struct_obj["original_fully_qualified_name"]
        struct_forward_declaration = struct_obj["forward_declaration"]
        struct_fields = []
        for struct_field_obj in struct_obj["fields"]:
            if not passes_conditional(struct_field_obj, definitions):
                continue

            # Ignore any anonymous fields
            if struct_field_obj["is_anonymous"]:
                continue

            struct_field_type: str = struct_field_obj["type"]["declaration"]

            # Weird edge case where instances of:
            #       const int array[2]
            # ...gets converted to
            #       const int* const array
            # Which Cython cannot handle. Here we remove the second const
            if struct_field_type.count("const") >= 2:
                struct_field_type = struct_field_type.replace("const", "__keeping__first__", 1)
                struct_field_type = struct_field_type.replace("const", "")
                struct_field_type = struct_field_type.replace("__keeping__first__", "const")

            struct_field_comments = parse_comment(struct_field_obj)
            for struct_field_name_obj in struct_field_obj["names"]:
                struct_field_name = safe_python_name(struct_field_name_obj["name"])
                struct_fields.append(DearStruct.Field(
                    struct_field_name,
                    DearType(struct_field_type),
                    struct_field_comments,
                ))
        
        struct_comments = parse_comment(struct_obj)
        parsed_structs.append(DearStruct(
            struct_name,
            struct_original_fully_qualified_name,
            struct_forward_declaration,
            struct_fields,
            struct_comments,
        ))

    # Functions
    parsed_functions: List[DearFunction] = []
    for function_obj in cimgui_json["functions"]:
        if not passes_conditional(function_obj, definitions):
            continue

        function_name = function_obj["name"]
        function_original_fully_qualified_name = function_obj["original_fully_qualified_name"]
        function_return_type = function_obj["return_type"]["declaration"]
        function_arguments = []
        for function_argument_obj in function_obj["arguments"]:
            if not passes_conditional(function_argument_obj, definitions):
                continue

            # Ignore any vargs stuff since Cython cannot handle this.
            if function_argument_obj["is_varargs"]:
                continue

            function_argument_name = safe_python_name(function_argument_obj["name"])
            function_argument_type = function_argument_obj["type"]["declaration"]
            # Weird edge case where instances of:
            #       const int array[2]
            # ...gets converted to
            #       const int* const array
            # Which Cython cannot handle. Here we remove the second const
            if function_argument_type.count("const") >= 2:
                function_argument_type = function_argument_type.replace("const", "__keeping__first__", 1)
                function_argument_type = function_argument_type.replace("const", "")
                function_argument_type = function_argument_type.replace("__keeping__first__", "const")
            
            # I'm also not interested in keeping va_list since Cython cannot
            # handle this.
            if function_argument_type == "va_list":
                continue

            function_argument_array_bounds = None
            function_argument_is_array = function_argument_obj["is_array"]
            if function_argument_is_array:
                function_argument_array_bounds = function_argument_obj["array_bounds"]

            if "default_value" in function_argument_obj:
                function_argument_default_value = function_argument_obj["default_value"]
            else:
                function_argument_default_value = None
            function_argument_comments = parse_comment(function_argument_obj)
            function_arguments.append(DearFunction.Argument(
                function_argument_name,
                DearType(function_argument_type, is_array_size=function_argument_array_bounds),
                function_argument_is_array,
                function_argument_default_value,
                function_argument_comments,
            ))
        function_is_default_argument_helper = function_obj["is_default_argument_helper"]
        function_is_manual_helper = function_obj["is_manual_helper"]
        function_is_imstr_helper = function_obj["is_imstr_helper"]
        function_has_imstr_helper = function_obj["has_imstr_helper"]
        function_comments = parse_comment(function_obj)
        parsed_functions.append(DearFunction(
            function_name,
            function_original_fully_qualified_name,
            DearType(function_return_type),
            function_arguments,
            function_is_default_argument_helper,
            function_is_manual_helper,
            function_is_imstr_helper,
            function_has_imstr_helper,
            function_comments,
        ))
    
    parsed_functions.sort(key=lambda x: x.name)
    
    return DearBinding(
        parsed_enums,
        parsed_typedefs,
        parsed_structs,
        parsed_functions,
    )


def to_pxd(header: DearBinding, header_file_name: str, include_base=True) -> str:
    base = """
    # -*- coding: utf-8 -*-
    # distutils: language = c++

    from libcpp cimport bool


    """

    dynamic_content = StringIO("")

    if include_base:
        dynamic_content.write(textwrap.dedent(base.lstrip("\n")))

    dynamic_content.write('cdef extern from "{}":\n'.format(header_file_name))
    
    # Struct forward declaration
    for struct in header.structs:
        # You might think you could use this value but some typedefs require all
        # the structs to be forward declared. So we can just be safe and do them
        # all.
        # if not struct.forward_declaration:
        #     continue

        struct_forward_declaration_pxd = "    ctypedef struct {}\n".format(struct.name)
        dynamic_content.write(struct_forward_declaration_pxd)
    dynamic_content.write("\n")

    # Typedefs
    typedef_format_test = "    ctypedef {}"

    # Used for pretty printing the comments for each typdef
    longest_typedef = 0
    longest_function_ptr_typedef = 0
    for typedef in header.typedefs:
        if typedef.base.is_function_type():
            typedef_pxd = typedef_format_test.format(
                typedef.base.raw_type
            )
        else:
            typedef_pxd = typedef_format_test.format(
                typedef.base.raw_type + " " + typedef.definition.raw_type
            )
        if typedef.base.is_function_type():
            longest_function_ptr_typedef = max(len(typedef_pxd), longest_function_ptr_typedef)
        else:
            longest_typedef = max(len(typedef_pxd), longest_typedef)


    for typedef in header.typedefs:
        # Typedef comments
        comment_text = typedef.comments.hash_proceeding_only()
        if comment_text is not None:
            dynamic_content.write("\n" + textwrap.indent(comment_text, "    ") + "\n")
        
        if typedef.base.is_function_type():
            typedef_pxd = typedef_format_test.format(
                typedef.base.raw_type
            )
        else:
            typedef_pxd = typedef_format_test.format(
                typedef.base.raw_type + " " + typedef.definition.raw_type
            )
        if typedef.base.is_function_type():
            padding_required = (5 + longest_function_ptr_typedef - len(typedef_pxd)) * " "
        else:
            padding_required = (5 + longest_typedef - len(typedef_pxd)) * " "


        comment_text = typedef.comments.hash_attached_only()
        dynamic_content.write("{}{}\n".format(
            typedef_pxd,
            padding_required + comment_text if comment_text is not None else ""
        ))
    dynamic_content.write("\n")

    # Enums
    for enum in header.enums:
        # Used for pretty printing the comments for each value
        longest_enum = 0
        for enum_element in enum.elements:
            longest_enum = max(len(enum_element.name), longest_enum)

        # Enum comments
        comment_text = enum.comments.hash_all_comments()
        if comment_text is not None:
            dynamic_content.write(textwrap.indent(comment_text, "    ") + "\n")
        
        enum_pxd = "    ctypedef enum {}:\n".format(enum.name)
        dynamic_content.write(enum_pxd)
        for enum_element in enum.elements:
            # Show attached comments only.
            comment_text = enum_element.comments.hash_attached_only()
            padding_required = (5 + longest_enum - len(enum_element.name)) * " "

            enum_element_pxd = "        {}{}\n".format(
                enum_element.name,
                padding_required + comment_text if comment_text is not None else ""
            )
            dynamic_content.write(enum_element_pxd)
        dynamic_content.write("\n")
    dynamic_content.write("\n")
    
    # Structs
    for struct in header.structs:
        # Used for pretty printing the comments for each field
        longest_field = 0
        for field in struct.fields:
            longest_field = max(len(field.name) + len(field.type.raw_type), longest_field)
        
        # Struct comments
        comment_text = struct.comments.hash_all_comments()
        if comment_text is not None:
            dynamic_content.write(textwrap.indent(comment_text, "    ") + "\n")
        
        struct_pxd = "    ctypedef struct {}:\n".format(struct.name)
        dynamic_content.write(struct_pxd)
        if len(struct.fields) == 0:
            dynamic_content.write("        pass\n")

        for struct_field in struct.fields:
            # Show attached comments only.
            comment_text = struct_field.comments.hash_attached_only()
            padding_required = (5 + longest_field - len(struct_field.name) - len(struct_field.type.raw_type)) * " "
            
            struct_field_pxd = "        {}{}{}\n".format(
                struct_field.type.raw_type,
                " " + struct_field.name if not struct_field.type.is_function_type() else "",
                padding_required + comment_text if comment_text is not None else ""
            )
            dynamic_content.write(struct_field_pxd)
        dynamic_content.write("\n")
        
        for struct_method in struct.methods:
            # Struct comments
            comment_text = struct_method.comments.hash_all_comments()
            if comment_text is not None:
                dynamic_content.write("\n" + textwrap.indent(comment_text, "    ") + "\n")
            
            method_argument_strings = []
            for method_argument in struct_method.arguments:
                method_argument_strings.append("{}{}".format(
                    method_argument.type.raw_type,
                    " " + method_argument.name if not method_argument.type.is_function_type() else "",
                ))
            method_pxd = "    {} {}({}) except +\n".format(
                struct_method.return_type.raw_type,
                struct_method.name,
                ", ".join(method_argument_strings)
            )
            dynamic_content.write(method_pxd)

        dynamic_content.write("\n")
    dynamic_content.write("\n")
    
    # Functions
    for function in header.functions:
        # Functions comments
        comment_text = function.comments.hash_all_comments()
        if comment_text is not None:
            dynamic_content.write("\n" + textwrap.indent(comment_text, "    ") + "\n")

        function_argument_strings = []
        for function_argument in function.arguments:
            function_argument_strings.append("{}{}".format(
                function_argument.type.raw_type,
                " " + function_argument.name if not function_argument.type.is_function_type() else "",
            ))
        function_pxd = "    {} {}({}) except +\n".format(
            function.return_type.raw_type,
            function.name,
            ", ".join(function_argument_strings)
        )
        dynamic_content.write(function_pxd)
    dynamic_content.write("\n")

    return dynamic_content.getvalue()


def to_pyx(header: DearBinding, pxd_library_name: str, imports: str, include_base: bool) -> str:
    header.sort()
    base = """
    # distutils: language = c++
    # cython: language_level = 3
    # cython: embedsignature=True

    {imports}

    cdef bytes _bytes(str text):
        return text.encode()

    cdef str _from_bytes(bytes text):
        return <str>(text.decode('utf-8', errors='ignore'))

    cdef _cast_ImVec2_tuple({pxd_library_name}.ImVec2 vec):
        return (vec.x, vec.y)

    cdef {pxd_library_name}.ImVec2 _cast_tuple_ImVec2(pair) except +:
        cdef {pxd_library_name}.ImVec2 vec
        if len(pair) != 2:
            raise ValueError('pair param must be length of 2')
        vec.x, vec.y = pair
        return vec

    cdef _cast_ImVec4_tuple({pxd_library_name}.ImVec4 vec):
        return (vec.x, vec.y, vec.z, vec.w)

    cdef {pxd_library_name}.ImVec4 _cast_tuple_ImVec4(quadruple):
        cdef {pxd_library_name}.ImVec4 vec
        if len(quadruple) != 4:
            raise ValueError('quadruple param must be length of 4')

        vec.x, vec.y, vec.z, vec.w = quadruple
        return vec


    def _py_vertex_buffer_vertex_pos_offset():
        return <uintptr_t><size_t>&(<{pxd_library_name}.ImDrawVert*>NULL).pos

    def _py_vertex_buffer_vertex_uv_offset():
        return <uintptr_t><size_t>&(<{pxd_library_name}.ImDrawVert*>NULL).uv

    def _py_vertex_buffer_vertex_col_offset():
        return <uintptr_t><size_t>&(<{pxd_library_name}.ImDrawVert*>NULL).col

    def _py_vertex_buffer_vertex_size():
        return sizeof({pxd_library_name}.ImDrawVert)

    def _py_index_buffer_index_size():
        return sizeof({pxd_library_name}.ImDrawIdx)


    cdef class BoolPtr:
        @staticmethod
        cdef bool* ptr(ptr: BoolPtr):
            return <bool*>(NULL if ptr is None else <void*>(&ptr.value))
        
        cdef public bool value

        def __init__(self, initial_value: bool):
            self.value: bool = initial_value

        def __bool__(self):
            return self.value


    cdef class IntPtr:
        @staticmethod
        cdef int* ptr(ptr: IntPtr):
            return <int*>(NULL if ptr is None else <void*>(&ptr.value))
        
        cdef public int value

        def __init__(self, initial_value: int):
            self.value: int = initial_value


    cdef class FloatPtr:
        @staticmethod
        cdef float* ptr(ptr: FloatPtr):
            return <float*>(NULL if ptr is None else <void*>(&ptr.value))
        
        cdef public float value

        def __init__(self, initial_value: float):
            self.value = initial_value


    cdef class DoublePtr:
        @staticmethod
        cdef double* ptr(ptr: DoublePtr):
            return <double*>(NULL if ptr is None else <void*>(&ptr.value))
        
        cdef public double value

        def __init__(self, initial_value: float):
            self.value = initial_value


    cdef class StrPtr:
        cdef char* buffer
        cdef public int buffer_size

        def __init__(self, initial_value: str, buffer_size=256):
            self.buffer = <char*>{pxd_library_name}.ImGui_MemAlloc(buffer_size)
            self.buffer_size: int = buffer_size
            self.value = initial_value
        
        def __dealloc__(self):
            {pxd_library_name}.ImGui_MemFree(self.buffer)

        @property
        def value(self):
            return _from_bytes(self.buffer)
        @value.setter
        def value(self, value: str):
            strncpy(self.buffer, _bytes(value), self.buffer_size - 1)
            self.buffer[min((self.buffer_size - 1), len(value))] = 0


    cdef class Vec2Ptr:
        cdef public FloatPtr _x
        cdef public FloatPtr _y

        def __init__(self, x: float, y: float):
            self._x = FloatPtr(x)
            self._y = FloatPtr(y)

        @property
        def x(self):
            return self._x.value
        @x.setter
        def x(self, x):
            self._x.value = x
        @property
        def y(self):
            return self._y.value
        @y.setter
        def y(self, y):
            self._y.value = y

        def from_floatptrs(self, float_ptrs: Sequence[FloatPtr]):
            assert len(float_ptrs) >= 2
            self._x = float_ptrs[0]
            self._y = float_ptrs[1]

        def as_floatptrs(self) -> Sequence[FloatPtr]:
            return [
                self._x,
                self._y,
            ]

        def vec(self) -> Sequence[float]:
            return (
                self.x,
                self.y,
            )

        def copy(self) -> Vec2Ptr:
            return Vec2Ptr(*self.vec())

        cdef void from_array(self, float* array):
            self._x.value = array[0]
            self._y.value = array[1]

        cdef void to_array(self, float* array):
            array[0] = self.x
            array[1] = self.y


    cdef class Vec4Ptr:
        cdef public FloatPtr _x
        cdef public FloatPtr _y
        cdef public FloatPtr _z
        cdef public FloatPtr _w

        def __init__(self, x: float, y: float, z: float, w: float):
            self._x = FloatPtr(x)
            self._y = FloatPtr(y)
            self._z = FloatPtr(z)
            self._w = FloatPtr(w)

        @property
        def x(self):
            return self._x.value
        @x.setter
        def x(self, x):
            self._x.value = x
        @property
        def y(self):
            return self._y.value
        @y.setter
        def y(self, y):
            self._y.value = y
        @property
        def z(self):
            return self._z.value
        @z.setter
        def z(self, z):
            self._z.value = z
        @property
        def w(self):
            return self._w.value
        @w.setter
        def w(self, w):
            self._w.value = w

        def from_floatptrs(self, float_ptrs: Sequence[FloatPtr]):
            assert len(float_ptrs) >= 4
            self._x = float_ptrs[0]
            self._y = float_ptrs[1]
            self._z = float_ptrs[2]
            self._w = float_ptrs[3]

        def as_floatptrs(self) -> Sequence[FloatPtr]:
            return [
                self._x,
                self._y,
                self._z,
                self._w,
            ]

        def vec(self) -> Sequence[float]:
            return (
                self.x,
                self.y,
                self.z,
                self.w,
            )

        def copy(self) -> Vec4Ptr:
            return Vec4Ptr(*self.vec())

        cdef void from_array(self, float* array):
            self._x.value = array[0]
            self._y.value = array[1]
            self._z.value = array[2]
            self._w.value = array[3]

        cdef void to_array(self, float* array):
            array[0] = self.x
            array[1] = self.y
            array[2] = self.z
            array[3] = self.w


    def IM_COL32(int r, int g, int b, int a) -> int:
        cdef unsigned int output = 0
        output |= a << 24
        output |= b << 16
        output |= g << 8
        output |= r << 0
        return output

    FLT_MIN = LIBC_FLT_MIN
    FLT_MAX = LIBC_FLT_MAX
    IMGUI_PAYLOAD_TYPE_COLOR_3F = "_COL3F"
    IMGUI_PAYLOAD_TYPE_COLOR_4F = "_COL4F"
    IM_COL32_WHITE        = IM_COL32(255, 255, 255, 255)   # Opaque white = 0xFFFFFFFF
    IM_COL32_BLACK        = IM_COL32(0, 0, 0, 255)         # Opaque black
    IM_COL32_BLACK_TRANS  = IM_COL32(0, 0, 0, 0)


    """

    pyx = StringIO()

    if include_base:
        pyx.write(textwrap.dedent(base.lstrip("\n")).format(
            pxd_library_name=pxd_library_name,
            imports=imports,
        ))

    # Add enums
    for enum in header.enums:
        for enum_element in enum.elements:
            pyx.write("{} = {}.{}\n".format(
                pythonise_string(enum_element.name_omitted_imgui_prefix(), make_upper=True),
                pxd_library_name,
                enum_element.name
            ))

    def function_to_pyx(header: DearBinding, function_template: Template, function: DearFunction) -> str:
        # Python return type
        python_return_type = header.as_python_type(function.return_type)

        # Python function name
        python_function_name = pythonise_string(function.name_omitted_imgui_prefix())

        # Python function arguments
        python_function_arguments = ", ".join([header.as_name_type_default_parameter(a) for a in function.arguments])

        # Comments
        function_comments = function.comments.three_quote_all_comments()
        function_template.set_condition("has_comment", function_comments is not None)
        if function_comments is not None:
            function_template.format(comment=textwrap.indent(function_comments, "    "))

        # Return type
        function_template.set_condition("has_return_type", not function.return_type.is_void_type())
        if function.return_type.is_function_type():
            return_type = "Callable"
        elif header.is_cimgui_type(function.return_type):
            return_type = "{}.{}".format(pxd_library_name, function.return_type.with_no_const())
        else:
            return_type = function.return_type.raw_type

        # Function arguments
        if len(function.arguments) > 0:
            function_argument_list = []
            for argument in function.arguments:
                marshalled_type = header.marshall_python_to_c(argument.type, argument.default_value).format(argument.name)
                if argument.name == "self":
                    marshalled_type = "self._ptr"
                function_argument_list.append(marshalled_type)

            function_arguments = "\n" + ",\n".join(function_argument_list) + "\n    "
            function_arguments = textwrap.indent(function_arguments, "        ")
        else:
            function_arguments = ""

        # res
        followed_return_type = header.follow_type(function.return_type)
        res = header.marshall_c_to_python(followed_return_type).format("res")

        return function_template.format(
            python_return_type=python_return_type,
            python_function_name=python_function_name,
            python_function_arguments=python_function_arguments,
            return_type=return_type,
            pxd_library_name=pxd_library_name,
            function_name=function.name,
            function_arguments=function_arguments,
            res=res,
        ).compile()

    # Add Functions
    with open("core/templates/function.h") as f:
        function_base = f.read()
    
    pyx.write("\n\n")
    pyx.write(PYX_TEMPLATE_MARKER)
    for function in header.functions:
        function_template = Template(function_base)
        pyx.write("# [Function]\n")
        function_pyx = function_to_pyx(header, function_template, function)
        pyx.write(function_pyx)
        pyx.write("# [End Function]\n\n")


    # Add Classes/Methods
    with open("core/templates/class.h") as f:
        class_base = f.read()
    with open("core/templates/field.h") as f:
        field_base = f.read()
    
    for struct in header.structs:
        class_template = Template(class_base)

        struct_comments = struct.comments.three_quote_all_comments()
        class_template.set_condition("has_comment", struct_comments is not None)
        if struct_comments is not None:
            class_template.format(comment=textwrap.indent(struct_comments, "    "))

        class_template.format(
            class_name=struct.name,
            pxd_library_name=pxd_library_name,
        )
        pyx.write("# [Class]\n")
        pyx.write("# [Class Constants]\n")
        pyx.write(class_template.compile())
        pyx.write("    # [End Class Constants]\n\n")
        
        for field in struct.fields:
            field_template = Template(field_base)
            
             # Comments
            field_comments = field.comments.three_quote_all_comments()
            field_template.set_condition("has_comment", field_comments is not None)
            if field_comments is not None:
                field_template.format(comment=textwrap.indent(field_comments, "    "))

            # Python type
            python_type = header.as_python_type(field.type)

            # Field type
            if field.type.is_function_type():
                field_type = "Callable"
            elif header.is_cimgui_type(field.type):
                field_type = "{}.{}".format(pxd_library_name, field.type.with_no_const())
            else:
                field_type = field.type.raw_type

            # Res
            res = header.marshall_c_to_python(field.type).format("res")

            # Field name
            field_name = pythonise_string(field.name)

            # Cimgui field name
            cimgui_field_name = field.name

            # Value
            value = header.marshall_python_to_c(field.type).format("value")

            pyx.write("    # [Field]\n")
            pyx.write(textwrap.indent(field_template.format(
                python_type=python_type,
                field_name=field_name,
                field_type=field_type,
                cimgui_field_name=cimgui_field_name,
                res=res,
                value=value,
            ).compile(), "    "))
            pyx.write("    # [End Field]\n\n")


        for method in struct.methods:
            method_template = Template(function_base)
            method_pyx = function_to_pyx(header, method_template, method)
            pyx.write("    # [Method]\n")
            pyx.write(textwrap.indent(method_pyx, "    "))
            pyx.write("    # [End Method]\n\n")
        pyx.write("# [End Class]\n\n")

    return pyx.getvalue()


def generate_new_pyx(from_header: DearBinding, pxd_library_name: str, include_base=True):
    imports = textwrap.dedent("""
        import ctypes
        import cython
        import array
        from cython.operator import dereference
        from typing import Callable, Any, Sequence

        cimport {}
        
        from cython.view cimport array as cvarray
        from libcpp cimport bool
        from libc.float cimport FLT_MIN as LIBC_FLT_MIN
        from libc.float cimport FLT_MAX as LIBC_FLT_MAX
        from libc.stdint cimport uintptr_t
        from libc.string cimport strncpy
        """
    ).format(pxd_library_name)
    return to_pyx(from_header, pxd_library_name, imports.strip(), include_base)


def to_pyi(headers: List[DearBinding], model: PyxHeader, extension_name: str):
    base = textwrap.dedent("""
    # This file is auto-generated. If you need to edit this file then edit the
    # template that this is created from instead.
    from typing import Any, Callable, Tuple, List, Sequence
    from PIL import Image


    VERTEX_BUFFER_POS_OFFSET: int
    VERTEX_BUFFER_UV_OFFSET: int
    VERTEX_BUFFER_COL_OFFSET: int
    VERTEX_SIZE: int
    INDEX_SIZE: int
    FLT_MIN: float
    FLT_MAX: float

    IMGUI_PAYLOAD_TYPE_COLOR_3F: int
    IMGUI_PAYLOAD_TYPE_COLOR_4F: int

    class BoolPtr:
        value: bool
        def __init__(self, initial_value: bool): ...
        def __bool__(self) -> bool: ...

    class IntPtr:
        value: int
        def __init__(self, initial_value: int): ...

    class FloatPtr:
        value: float
        def __float__(self) -> float: ...

    class DoublePtr:
        value: float
        def __init__(self, initial_value: float): ...

    class StrPtr:
        value: str
        def __init__(self, initial_value: str, buffer_size=256): ...

    class Vec4Ptr:
        x: float
        y: float
        z: float
        w: float
        def __init__(self, x: float, y: float, z: float, w: float): ...
        def vec(self) -> Tuple[float, float, float, float]: ...
        def as_floatptrs(self) -> Sequence[FloatPtr]: ...
        def from_floatptrs(self, float_ptrs: Sequence[FloatPtr]): ...
        def to_floatptrs(self) -> Sequence[FloatPtr]: ...
        def copy(self) -> Vec4Ptr: ...

    class Vec2Ptr:
        x: float
        y: float
        def __init__(self, x: float, y: float): ...
        def vec(self) -> Tuple[float, float]: ...
        def as_floatptrs(self) -> Sequence[FloatPtr]: ...
        def from_floatptrs(self, float_ptrs: Sequence[FloatPtr]): ...
        def to_floatptrs(self) -> Sequence[FloatPtr]: ...
        def copy(self) -> Vec2Ptr: ...

    def IM_COL32(r: int, g: int, b: int, a: int) -> int: ...

    def load_image(image: Image) -> int: ...

    """.lstrip("\n"))

    # __init__.pyi ------------------------------------

    pyi_output = StringIO()
    pyi_output.write(base)
    
    with open("core/templates/function.pyi") as f:
        function_template_src = f.read()
    
    with open("core/templates/class.pyi") as f:
        class_template_src = f.read()
    
    with open("core/templates/field.pyi") as f:
        field_template_src = f.read()

    for header in headers:
        for enum in header.enums:
            for enum_value in enum.elements:
                pyi_output.write("{}: int\n".format(pythonise_string(enum_value.name_omitted_imgui_prefix(), make_upper=True)))
        pyi_output.write("\n")

    for function in model.functions:
        function_template = Template(function_template_src)

        function_template.set_condition("has_comment", function.comment is not None)
        function_template.format(
            function_name=function.name,
            function_parameters=function.parameters,
            function_returns=function.options["returns"],
            function_comment=textwrap.indent(f'"""\n{function.comment}\n"""', "    ")
        )

        if comparable_is_active(function):
            pyi_output.write(function_template.compile())
        else:
            pyi_output.write(comment_text(function_template.compile()))
    
    pyi_output.write("\n")

    for class_ in model.classes:
        class_template = Template(class_template_src)
        class_template.set_condition("has_content", class_.has_one_active_member() or class_.comment is not None)
        class_template.set_condition("has_one_member", class_.has_one_active_member())
        class_template.set_condition("has_comment", class_.comment is not None)

        class_template.format(
            class_name=class_.name,
            class_comment=textwrap.indent(f'"""\n{class_.comment}\n"""', "    "),
        )
        pyi_output.write(class_template.compile())

        for field in class_.fields:
            field_template = Template(field_template_src)
            field_template.set_condition("has_comment", field.comment is not None)
            field_template.format(
                field_name=field.name,
                field_type=field.options["returns"],
                field_comment=f'"""\n{field.comment}\n"""'
            )
            if comparable_is_active(field):
                pyi_output.write(textwrap.indent(field_template.compile(), "    "))
            else:
                pyi_output.write(textwrap.indent(comment_text(field_template.compile()), "    "))

        for method in class_.methods:
            method_template = Template(function_template_src)
            method_template.set_condition("has_comment", method.comment is not None)
            method_template.format(
                function_name=method.name,
                function_parameters=method.parameters,
                function_returns=method.options["returns"],
                function_comment=textwrap.indent(f'"""\n{method.comment}\n"""', "    ")
            )

            if comparable_is_active(method):
                pyi_output.write(textwrap.indent(method_template.compile(), "    "))
            else:
                pyi_output.write(textwrap.indent(comment_text(method_template.compile()), "    "))
        pyi_output.write("\n")
    

    # __init__.py ------------------------------------
    py = textwrap.dedent("""
    from .{extension_name} import *

    VERTEX_BUFFER_POS_OFFSET = {extension_name}._py_vertex_buffer_vertex_pos_offset()
    VERTEX_BUFFER_UV_OFFSET = {extension_name}._py_vertex_buffer_vertex_uv_offset()
    VERTEX_BUFFER_COL_OFFSET = {extension_name}._py_vertex_buffer_vertex_col_offset()
    VERTEX_SIZE = {extension_name}._py_vertex_buffer_vertex_size()
    INDEX_SIZE = {extension_name}._py_index_buffer_index_size()



    import OpenGL.GL as gl
    from PIL import Image

    # From https://stackoverflow.com/questions/72325672/opengl-doesnt-draw-anything-if-i-use-pil-or-pypng-to-load-textures
    def load_image(image: Image) -> int:
        convert = image.convert("RGBA")
        image_data = convert.tobytes()
        # image_data = convert.transpose(Image.Transpose.FLIP_TOP_BOTTOM).tobytes()
        w = image.width
        h = image.height

        # create the texture in VRAM
        texture: int = gl.glGenTextures(1)
        gl.glBindTexture(gl.GL_TEXTURE_2D, texture)

        # configure some texture settings
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_REPEAT) # when you try to reference points beyond the edge of the texture, how should it behave?
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, gl.GL_REPEAT) # in this case, repeat the texture data
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LINEAR) # when you zoom in, how should the new pixels be calculated?
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LINEAR_MIPMAP_LINEAR) # when you zoom out, how should the existing pixels be combined?
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_BASE_LEVEL, 0)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAX_LEVEL, 0)

        # load texture onto the GPU
        gl.glTexImage2D(
            gl.GL_TEXTURE_2D,    # where to load texture data
            0,                   # mipmap level
            gl.GL_RGBA8,         # format to store data in
            w,                   # image dimensions
            h,                   #
            0,                   # border thickness
            gl.GL_RGBA,          # format data is provided in
            gl.GL_UNSIGNED_BYTE, # type to read data as
            image_data
        )          # data to load as texture
        # gl.debug.check_gl_error()

        # generate smaller versions of the texture to save time when its zoomed out
        gl.glGenerateMipmap(gl.GL_TEXTURE_2D)

        # clean up afterwards
        gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
        return texture
    """.format(extension_name=extension_name).lstrip("\n"))

    return pyi_output.getvalue(), py


def main():
    with open("config.json") as f:
        config = json.load(f)
    
    EXTENSION_NAME =          config["EXTENSION_NAME"]
    CIMGUI_PXD_PATH =         config["CIMGUI_PXD_PATH"]
    CIMGUI_LIBRARY_NAME =     config["CIMGUI_LIBRARY_NAME"]
    GENERATED_PYX_PATH =      config["GENERATED_PYX_PATH"]
    PYX_PATH =                config["PYX_PATH"]
    PYX_TRIAL_PATH =          config["PYX_TRIAL_PATH"]
    TEMPLATE_PYX_PATH =       config["TEMPLATE_PYX_PATH"]
    TEMPLATE_PYX_TRIAL_PATH = config["TEMPLATE_PYX_TRIAL_PATH"]
    INIT_PYI_PATH =           config["INIT_PYI_PATH"]
    INIT_PY_PATH =            config["INIT_PY_PATH"]
    
    defines = [
        ("IMGUI_DISABLE_OBSOLETE_KEYIO", True),
        ("IMGUI_DISABLE_OBSOLETE_FUNCTIONS", True),
        ("IMGUI_HAS_IMSTR", False),
    ]

    headers: List[DearBinding] = []
    header_files: List[str] = []
    for module in config["modules"]:
        header_files.append(module["header"])
        with open(module["binding_json"]) as f:
            headers.append(parse_binding_json(json.load(f), defines))

    def _help():
        print(textwrap.dedent("""
        Usage: python model_creator.py <Option>
        Note: This script expects a file called config.json to exist in the calling directory.
        The config file should contain the constants and backends used by the script.

          --help       Prints this
          --trial      Attempts to merge the old/new/template content but writes the result to
                         core_trial.pyx only.
          --all        Typical usage. Builds the pxd/pyx/pyi file. The merged file is written
                         to core.pyx.
          --pxd        Builds the pxd file only.
          --pyx        Builds the pyx file only.
          --pyi        Builds the pyi file only.
          --reset      Creates a new template to manually modify pxy files with. This will not
                         complete if a template stil exists. You must delete core_template.pyx
                         yourself.
        """.lstrip("\n")))
        return

    def trial_pyx(headers: DearBinding, pxd_libary_name: str):
        new_pyx = ""
        for i, header in enumerate(headers):
            new_pyx += generate_new_pyx(header, pxd_libary_name, i == 0)

        try:
            with open(GENERATED_PYX_PATH) as f:
                old_pyx = f.read()
        except FileNotFoundError:
            print(f"Trial: '{GENERATED_PYX_PATH}' not found. Using new generated content as the old.")
            old_pyx = new_pyx

        try:
            with open(TEMPLATE_PYX_PATH) as f:
                template_pyx = f.read()
        except FileNotFoundError:
            print(f"Trial: '{TEMPLATE_PYX_PATH}' not found. Aborting. Use --reset first ")
            return
        
        try:
            merge_result = MergeResult(old_pyx, new_pyx, template_pyx)
        except MergeFailed:
            print("Trial: Merge failed. Aborting.")
            return

        with open(PYX_TRIAL_PATH, "w") as f:
            f.write(merge_result.merged_pyx)
        with open(TEMPLATE_PYX_TRIAL_PATH, "w") as f:
            f.write(merge_result.merged_pyx_all_active)
        print(f"Created {PYX_TRIAL_PATH}")
        print(f"Created {TEMPLATE_PYX_TRIAL_PATH}")

    def reset(headers: List[DearBinding], pxd_libary_name: str):
        new_pyx = ""
        for i, header in enumerate(headers):
            new_pyx += generate_new_pyx(header, pxd_libary_name, i == 0)
        
        new_model = create_pyx_model(new_pyx)
        try:
            with open(TEMPLATE_PYX_PATH) as f:
                print(f"Error: Template '{TEMPLATE_PYX_PATH}' still exists.")
                print("Please delete the file manually if you are sure.")
                return
        except FileNotFoundError:
            with open(PYX_PATH, "w") as f:
                f.write(replace_after(
                    new_pyx,
                    PYX_TEMPLATE_MARKER,
                    new_model.as_pyx()
                ))
            with open(TEMPLATE_PYX_PATH, "w") as f:
                f.write(replace_after(
                    new_pyx,
                    PYX_TEMPLATE_MARKER,
                    new_model.as_pyx(ignore_active_flag=True)
                ))
            print(f"Created {PYX_PATH}")
            print(f"Created {TEMPLATE_PYX_PATH}")

    def write_pxd(headers: List[DearBinding], header_files: List[str]):
        pxd = ""
        for i, (header, header_file) in enumerate(zip(headers, header_files)):
            pxd += to_pxd(header, header_file, i == 0) # TODO: Pass in the header's .h reference file
        
        with open(CIMGUI_PXD_PATH, "w") as f:
            f.write(pxd)
        print(f"Created {CIMGUI_PXD_PATH}")
    
    def write_pyx(headers: List[DearBinding], pxd_libary_name: str):
        new_pyx = ""
        for i, header in enumerate(headers):
            new_pyx += generate_new_pyx(header, pxd_libary_name, i == 0)

        try:
            with open(GENERATED_PYX_PATH) as f:
                old_pyx = f.read()
        except FileNotFoundError:
            print(f"'{GENERATED_PYX_PATH}' not found. Using new generated content as the old.")
            old_pyx = new_pyx

        try:
            with open(TEMPLATE_PYX_PATH) as f:
                template_pyx = f.read()
        except FileNotFoundError:
            print(f"'{TEMPLATE_PYX_PATH}' not found. Aborting. Use --reset first ")
            return
        
        try:
            merge_result = MergeResult(old_pyx, new_pyx, template_pyx)
        except MergeFailed:
            print("Merge failed. Aborting.")
            return

        with open(GENERATED_PYX_PATH, "w") as f:
            f.write(merge_result.new_pyx)
        with open(PYX_PATH, "w") as f:
            f.write(merge_result.merged_pyx)
        with open(TEMPLATE_PYX_PATH, "w") as f:
            f.write(merge_result.merged_pyx_all_active)
        print(f"Created {GENERATED_PYX_PATH}")
        print(f"Created {PYX_PATH}")
        print(f"Created {TEMPLATE_PYX_PATH}")
    
    def write_pyi(headers: List[DearBinding], extension_name: str):
        try:
            with open(TEMPLATE_PYX_PATH) as f:
                model = create_pyx_model(f.read())
        except FileNotFoundError:
            print(f"'{TEMPLATE_PYX_PATH}' not found. This is required to create the pyi file")
            return
        
        pyi, py = to_pyi(headers, model, extension_name)

        with open(INIT_PYI_PATH, "w") as f:
            f.write(pyi)
        with open(INIT_PY_PATH, "w") as f:
            f.write(py)
        print(f"Created {INIT_PYI_PATH}")
        print(f"Created {INIT_PY_PATH}")
        pass


    if len(sys.argv) < 2:
        _help()
        return

    if "--help" in sys.argv:
        _help()
        return
    
    if "--trial" in sys.argv:
        trial_pyx(headers, CIMGUI_LIBRARY_NAME)
        return
    
    if "--reset" in sys.argv:
        reset(headers, CIMGUI_LIBRARY_NAME)
        return

    if "--pxd" in sys.argv:
        write_pxd(headers, header_files)
        return
    
    if "--pyx" in sys.argv:
        write_pyx(headers, CIMGUI_LIBRARY_NAME)
        return

    if "--pyi" in sys.argv:
        write_pyi(headers, EXTENSION_NAME)
        return
    
    if "--all" in sys.argv:
        write_pxd(headers, header_files)
        write_pyx(headers, CIMGUI_LIBRARY_NAME)
        write_pyi(headers, EXTENSION_NAME)
        return


if __name__ == "__main__":
    main()