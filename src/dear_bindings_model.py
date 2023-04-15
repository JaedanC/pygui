from __future__ import annotations
from typing import List, Any
from io import StringIO
import builtins
import json
import keyword
import textwrap


class DearBinding:
    def __init__(self, enums, typedefs, structs, functions):
        self.enums: List[DearEnum] = enums
        self.typedefs: List[DearTypedef] = typedefs
        self.structs: List[DearStruct] = structs
        self.functions: List[DearFunction] = functions
    
    def __repr__(self):
        return \
            "Enums:\n{}\n\n".format("\n".join([str(e) for e in self.enums])) + \
            "Typedefs:\n{}\n\n".format("\n".join([str(e) for e in self.typedefs])) + \
            "Structs:\n{}\n\n".format("\n".join([str(e) for e in self.structs])) + \
            "Functions:\n{}\n".format("\n".join([str(e) for e in self.functions]))


class Comments:
    def __init__(self, comment_preceeding: List[str], comment_attached: str):
        self.comment_proceeding: List[str] = comment_preceeding
        self.comment_attached: str         = comment_attached
    
    def to_python_comment(self):
        if len(self.comment_proceeding) == 0 and self.comment_attached is None:
            return None
        
        comment_attached_no_none = self.comment_attached
        if self.comment_attached is None:
            comment_attached_no_none = ""
        
        no_c_comment_proceeding = [line.lstrip("// ") for line in self.comment_proceeding]
        no_c_comment_attached = comment_attached_no_none.lstrip("// ")

        comment = textwrap.dedent(
        '''
        """
        {}
        """
        ''')

        if len(self.comment_proceeding) == 0 or comment_attached_no_none == "":
            comment = comment.format(
                "\n".join(no_c_comment_proceeding) + no_c_comment_attached)
        else:
            comment = comment.format(
                "\n".join(no_c_comment_proceeding) + "\n" + no_c_comment_attached)
        return comment

    def attached_only(self):
        if self.comment_attached is None:
            return None
        return "# " + self.comment_attached.lstrip("// ")

class DearEnum:
    class Value:
        def __init__(self, name: str, value: int, comments: Comments):
            self.name: str          = name
            self.value: int         = value
            self.comments: Comments = comments
        

    def __init__(self, name: str, elements: List[Value], comments: Comments):
        self.name: str                      = name
        self.elements: List[DearEnum.Value] = elements
        self.comments: Comments             = comments
    
    def __repr__(self):
        return "Enum({} -> {} elements)".format(self.name, len(self.elements))


class DearType:
    def __init__(self, raw_type: str):
        self.raw_type = raw_type
    
    def __repr__(self):
        return "Type({})".format(self.raw_type)
    
    def is_function_type(self) -> bool:
        return "(*" in self.raw_type


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
    
    def __repr__(self):
        return "Struct({}({}))".format(self.name, ", ".join((str(f) for f in self.fields)))


class DearFunction:
    class Argument:
        def __init__(self, name: str, _type: DearType, is_array: bool,
                     default_value: Any, comments: Comments):
            self.name: str          = name
            self.type: DearType     = _type
            self.is_array: bool     = is_array
            self.default_value: Any = default_value
            self.comments: Comments = comments
        
        def __repr__(self):
            return "Arg({}: {})".format(self.name, self.type)
    
    def __init__(self, name: str, imgui_name: str, return_type: DearType,
                 arguments: List[Argument], is_default_argument_helper: bool,
                 is_manual_helper: bool, is_imstr_helper: bool, 
                 has_imstr_helper: bool, comments: Comments):
        self.name: str                        = name
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


def safe_python_name(name: str, edit_format="{}_") -> str:
    """Modifies a string to not be a keyword or built-in function. Not using
    this causes Cython to freak out. This adds an underscore if a conflict is
    found. A new string is returned.
    """
    if name in keyword.kwlist or name in dir(builtins) or name == "format":
        name = edit_format.format(name)
    return name


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

            function_argument_is_varargs = function_argument_obj["is_varargs"]
            # Ignore any vargs stuff since Cython cannot handle this.
            if function_argument_is_varargs:
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

            function_argument_is_array = function_argument_obj["is_array"]
            if "default_value" in function_argument_obj:
                function_argument_default_value = function_argument_obj["default_value"]
            else:
                function_argument_default_value = None
            function_argument_comments = parse_comment(function_argument_obj)
            function_arguments.append(DearFunction.Argument(
                function_argument_name,
                DearType(function_argument_type),
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


def to_pxd(header: DearBinding) -> str:
    pxd_base = """
    # -*- coding: utf-8 -*-
    # distutils: language = c++

    from libcpp cimport bool

    {}
    """

    dynamic_content = StringIO("")
    dynamic_content.write('cdef extern from "cimgui.h":\n')
    
    for struct in header.structs:
        # You might think you could use this value but some typedefs require all
        # the structs to be forward declared. So we can just be safe and do them
        # all.
        # if not struct.forward_declaration:
        #     continue

        struct_forward_declaration_pxd = "    ctypedef struct {}\n".format(struct.name)
        dynamic_content.write(struct_forward_declaration_pxd)
    dynamic_content.write("\n")

    for typedef in header.typedefs:
        comment_text = typedef.comments.to_python_comment()
        if comment_text is not None:
            dynamic_content.write(textwrap.indent(comment_text, "    "))
        
        typedef_pxd = "    ctypedef {} {}\n".format(
            typedef.base.raw_type,
            typedef.definition.raw_type
        )
        dynamic_content.write(typedef_pxd)
    dynamic_content.write("\n")

    for enum in header.enums:
        longest_enum = 0
        for enum_element in enum.elements:
            longest_enum = max(len(enum_element.name), longest_enum)

        comment_text = enum.comments.to_python_comment()
        if comment_text is not None:
            dynamic_content.write(textwrap.indent(comment_text, "    "))
        
        enum_pxd = "    ctypedef enum {}:\n".format(enum.name)
        dynamic_content.write(enum_pxd)
        for enum_element in enum.elements:
            comment_text = enum_element.comments.attached_only()
            padding_required = (5 + longest_enum - len(enum_element.name)) * " "

            enum_element_pxd = "        {}{}\n".format(
                enum_element.name,
                padding_required + comment_text if comment_text is not None else ""
            )
            dynamic_content.write(enum_element_pxd)
        dynamic_content.write("\n")
    dynamic_content.write("\n")
    
    for struct in header.structs:
        longest_field = 0
        for field in struct.fields:
            longest_field = max(len(field.name) + len(field.type.raw_type), longest_field)
        
        comment_text = struct.comments.to_python_comment()
        if comment_text is not None:
            dynamic_content.write(textwrap.indent(comment_text, "    "))
        
        struct_pxd = "    ctypedef struct {}:\n".format(struct.name)
        dynamic_content.write(struct_pxd)
        if len(struct.fields) == 0:
            dynamic_content.write("        pass\n")

        for struct_field in struct.fields:
            comment_text = struct_field.comments.attached_only()
            padding_required = (5 + longest_field - len(struct_field.name) - len(struct_field.type.raw_type)) * " "
            
            struct_field_pxd = "        {}{}{}\n".format(
                struct_field.type.raw_type,
                " " + struct_field.name if not struct_field.type.is_function_type() else "",
                padding_required + comment_text if comment_text is not None else ""
            )
            dynamic_content.write(struct_field_pxd)
        dynamic_content.write("\n")
    dynamic_content.write("\n")
    
    for function in header.functions:
        comment_text = function.comments.to_python_comment()
        if comment_text is not None:
            dynamic_content.write(textwrap.indent(comment_text, "    "))

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
    return textwrap.dedent(pxd_base).format(dynamic_content.getvalue())
        

def main():
    cimgui_json_path = "external/dear_bindings/cimgui.json"
    with open(cimgui_json_path) as f:
        cimgui_json = json.load(f)
    
    defines = [
        ("IMGUI_DISABLE_OBSOLETE_KEYIO", True),
        ("IMGUI_DISABLE_OBSOLETE_FUNCTIONS", True),
        ("IMGUI_HAS_IMSTR", False),
    ]
    header = parse_binding_json(cimgui_json, defines)
    # print(header)

    pxd = to_pxd(header)
    with open("core/ccimgui_dear_bindings.pxd", "w") as f:
        f.write(pxd)


if __name__ == "__main__":
    main()