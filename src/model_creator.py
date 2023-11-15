from __future__ import annotations
from typing import List, Any, Dict, Optional
from io import StringIO
from pyx_parser import *
from helpers import Template
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
            "bool*": "Bool",
            "char": "int",
            "size_t": "int",
            "int": "int",
            "int*": "Int",
            "short": "int",
            "short*": "Int",
            "long": "int",
            "long*": "Int",
            "float": "float",
            "float*": "Float",
            "double": "float",
            "double*": "Double",
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

    def marshall_python_to_c(self, _type: DearType, argument_name: str,
                             pxd_library_name: str, default_value=None):
        _type = self.follow_type(_type)

        additional_lines = []

        output = "{name}"
        if _type.is_vec2():
            output = "_cast_tuple_ImVec2({name})"

        elif _type.is_vec4():
            output = "_cast_tuple_ImVec4({name})"
        
        elif _type.is_string() and default_value == "None":
            additional_lines.append(
                "bytes_{name} = _bytes({name}) if {name} is not None else None".format(name=argument_name)
            )
            output = "((<char*>bytes_{name} if {name} is not None else NULL))"

        elif _type.is_string():
            output = "_bytes({name})"
        
        elif _type.ptr_version() and default_value == "None":
            output = _type.ptr_version() + ".ptr({name})"

        elif self.is_cimgui_type(_type) and default_value == "None":
            output = "<{pxd_library_name}.{type_name}>(NULL if {{name}} is None else {{name}}._ptr)".format(
                pxd_library_name=pxd_library_name,
                type_name=_type.with_no_const()
            )
        
        elif _type.ptr_version() is not None:
            output = "&{name}.value"

        elif self.is_cimgui_type(_type):
            output = "{name}._ptr"
        
        return output.format(name=argument_name), additional_lines


class Comments:
    def __init__(self, comment_preceeding: List[str], comment_attached: str):
        self.comment_proceeding: List[str] = comment_preceeding
        self.comment_attached: str         = comment_attached

        if self.comment_attached is not None:
            self.comment_attached = self.comment_attached.replace('"', "'")
            self.comment_attached = self.comment_attached.replace('{', "(")
            self.comment_attached = self.comment_attached.replace('}', ")")
            self.comment_attached = self.comment_attached.lstrip("// ").capitalize()
        
        self.comment_proceeding = [line.lstrip("// ") for line in self.comment_proceeding]
        self.comment_proceeding = [line.replace("{", "(") for line in self.comment_proceeding]
        self.comment_proceeding = [line.replace("}", ")") for line in self.comment_proceeding]
        
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


class DearBindingNew:
    def __init__(self, enums, typedefs, structs, functions):
        self.enums: List[DearBindingsEnumNew] = enums
        self.typedefs: List[DearBindingsTypedefNew] = typedefs
        self.structs: List[DearBindingsStructNew] = structs
        self.functions: List[DearBindingsFunctionNew] = functions

        # methods: List[DearBindingsFunctionNew] = []
        # for function in functions:
        #     function: DearBindingsFunctionNew
        #     if len(function.arguments) > 0 and function.arguments[0].name == "self":
        #         methods.append(function)
        #         continue
        #     self.functions.append(function)
        
        # struct_lookup = {s.name: s for s in self.structs}
        # for method in methods:
        #     method: DearBindingsFunctionNew
            # class_name = method.arguments[0].type.with_no_const_or_asterisk()
            # Modify the name of the function so that it looks more like a 
            # method.
            # method.python_name = method.python_name.replace(class_name + "_", "", 1)
            # struct_lookup[class_name].add_method(method)
    
    def __repr__(self):
        return \
            "Enums:\n{}\n\n".format("\n".join([str(e) for e in self.enums])) + \
            "Typedefs:\n{}\n\n".format("\n".join([str(e) for e in self.typedefs])) + \
            "Structs:\n{}\n\n".format("\n".join([str(e) for e in self.structs])) + \
            "Functions:\n{}\n".format("\n".join([str(e) for e in self.functions]))


class DearBindingsTypedefNew:
    def __init__(self, typedef_json: dict):
        """Typedef
        {
            "name": "ImGuiMouseSource",
            "type": {
                "declaration": "int",
                "description": {
                    "kind": "Builtin",
                    "builtin_type": "int"
                }
            },
            "comments": {
                "attached": "// -> enum ImGuiMouseSource      // Enum; A mouse input source identifier (Mouse, TouchScreen, Pen)"
            },
            "is_internal": false,
            "source_location": {
                "filename": "imgui.h"
            }
        },
        """
        self.name: str = typedef_json["name"]
        self._type: DearBindingsTypeNew = DearBindingsTypeNew(typedef_json["type"])
        self.comments: Comments = parse_comment(typedef_json)
        self.is_internal: bool = typedef_json["is_internal"]
        self.source_location: dict = typedef_json["source_location"]

        self.base = self._type
        self.definition = self.name
    
    def __repr__(self):
        return "Typedef({} <- {})".format(self.base, self.definition)


class DearBindingsEnumNew:
    class Element:
        def __init__(self, element_json: dict):
            self.name: str = element_json["name"]
            self.value_expression: Optional[str] = element_json.get("value_expression")
            self.value: int = element_json["value"]
            self.is_count: bool = element_json["is_count"]
            self.is_internal: bool = element_json["is_internal"]
            self.source_location: dict = element_json["source_location"]
        
        def name_omitted_imgui_prefix(self):
            return self.name.replace("ImGui", "", 1)
        
    def __init__(self, enum_json: dict):
        self.name: str = enum_json["name"]
        self.original_fully_qualified_name: str = enum_json["original_fully_qualified_name"]
        self.is_flags_enum: bool = enum_json["is_flags_enum"]
        self.elements: List[DearBindingsEnumNew.Element] = [DearBindingsEnumNew.Element(e) for e in enum_json["elements"]]
        self.comments: Comments = parse_comment(enum_json)
        self.is_internal: bool = enum_json["is_internal"]
        self.source_location: dict = enum_json["source_location"]
    
    def __repr__(self):
        verbose = False
        if verbose:
            return "{}:{}{}".format(
                self.name,
                "\n    " if len(self.elements) > 0 else "",
                "\n    ".join((a.name for a in self.elements)),
            )
        return "Enum({} -> {} elements)".format(self.name, len(self.elements))


class DearBindingsArgumentNew:
    def __init__(self, argument_json: dict):
        """Argument
        {
            "name": "ctx",
            "type": {
                "declaration": "ImGuiContext*",
                "description": {
                    "kind": "Pointer",
                    "inner_type": {
                        "kind": "User",
                        "name": "ImGuiContext"
                    }
                }
            },
            "is_array": false,
            "is_varargs": false,
            "default_value": "NULL",
            "is_instance_pointer": false
        }
        """
        self.name: str = argument_json["name"]
        self.is_array: bool = argument_json["is_array"]
        self.is_varargs: bool = argument_json["is_varargs"]
        assert not self.is_varargs, "Python does not support is_varargs: {}".format(self.name)
        self.is_instance_pointer: bool = argument_json["is_instance_pointer"]
        self.default_value: Optional[str] = argument_json.get("default_value")
        self._type: DearBindingsTypeNew = DearBindingsTypeNew(argument_json["type"])
        self.comments: Comments = parse_comment(argument_json)
    
    def __repr__(self):
        return "{}: {}{}".format(
            self.name,
            self._type,
            f"={self.default_value}" if self.default_value is not None else "")


class DearBindingsFunctionNew:
    def __init__(self, function_json: dict):
        """Function
        {
            "name": "ImGui_DestroyContext",
            "original_fully_qualified_name": "ImGui::DestroyContext",
            "return_type": {
                "declaration": "void",
                "description": {
                    "kind": "Builtin",
                    "builtin_type": "void"
                }
            },
            "arguments": [
                {
                    "name": "ctx",
                    "type": {
                        "declaration": "ImGuiContext*",
                        "description": {
                            "kind": "Pointer",
                            "inner_type": {
                                "kind": "User",
                                "name": "ImGuiContext"
                            }
                        }
                    },
                    "is_array": false,
                    "is_varargs": false,
                    "default_value": "NULL",
                    "is_instance_pointer": false
                }
            ],
            "is_default_argument_helper": false,
            "is_manual_helper": false,
            "is_imstr_helper": false,
            "has_imstr_helper": false,
            "is_unformatted_helper": false,
            "comments": {
                "attached": "// NULL = destroy current context"
            },
            "is_internal": false,
            "source_location": {
                "filename": "imgui.h",
                "line": 300
            }
        },
        """
        self.name: str = function_json["name"]
        self.original_fully_qualified_name: str = function_json["original_fully_qualified_name"]
        self.return_type: DearBindingsTypeNew = DearBindingsTypeNew(function_json["return_type"])
        # Ignore any Cython unsupported arguments
        self.arguments: List[DearBindingsArgumentNew] = []
        for argument in function_json["arguments"]:
            if argument["is_varargs"] or argument.get("type", {}).get("declaration") == "va_list":
                continue
            self.arguments.append(DearBindingsArgumentNew(argument))
        self.comments: Comments = parse_comment(function_json)
    
    def __repr__(self):
        return "{}() -> {}{}{}".format(
            self.name,
            self.return_type,
            "\n    " if len(self.arguments) > 0 else "",
            "\n    ".join((str(a) for a in self.arguments)),
        )


class DearBindingsTypeNew:
    class Kind:
        def __init__(self, kind_json: dict, is_function_pointer: bool=False):
            """Kind
            {
                "kind": "Builtin",
                "builtin_type": "char",
                "storage_classes": [
                    "const"
                ]
            }
            """
            self.kind: str = kind_json["kind"]
            self.is_nullable: Optional[bool] = kind_json.get("is_nullable")
            self.is_const: bool = "const" in kind_json.get("storage_classes", [])
            self.bounds: int = kind_json.get("bounds")
            self.name = kind_json.get("name") or kind_json.get("builtin_type")
            
            self._type = None
            if is_function_pointer:
                self._type = DearBindingsTypeNew.FunctionPointer(kind_json["inner_type"], self.name)
            elif "inner_type" in kind_json:
                self._type = DearBindingsTypeNew.Kind(kind_json["inner_type"])
            else:
                self._type = self.name

        def __repr__(self):
            const = "const " if self.is_const else ""
            if self.kind == "Array":
                return "{}{}[{}]".format(
                    const,
                    self._type,
                    self.bounds
                )
            elif self.kind == "Pointer":
                return "{}{}*".format(
                    const,
                    self._type
                )
            else:
                return "{}{}".format(
                    const,
                    self._type
                )

    class FunctionPointer:
        def __init__(self, function_ptr_json: dict, function_ptr_name: str):
            function_ptr_json = function_ptr_json["inner_type"]
            self.function_ptr_name = function_ptr_name
            self.return_type = DearBindingsTypeNew.Kind(function_ptr_json["return_type"])
            self.parameters = [DearBindingsTypeNew.Kind(a) for a in function_ptr_json["parameters"]]
        
        def __repr__(self):
            return "{} (*{})({})".format(
                self.return_type,
                self.function_ptr_name,
                ", ".join((map(lambda x: f"{x} {x.name}", self.parameters))),
            )

    def __init__(self, type_json: dict):
        """Pointer
        {
            "declaration": "const char*",
            "description": {
                "kind": "Pointer",
                "is_nullable": false,
                "inner_type": {
                    "kind": "Builtin",
                    "builtin_type": "char",
                    "storage_classes": [
                        "const"
                    ]
                }
            }
        }
        """
        """User
        {
            "declaration": "ImVec2",
            "description": {
                "kind": "User",
                "name": "ImVec2"
            }
        }
        """
        """Builtin
        {
            "declaration": "int",
            "description": {
                "kind": "Builtin",
                "builtin_type": "int"
            }
        }
        """
        """Inner User w/const
        {
            "declaration": "const ImDrawList*",
            "description": {
                "kind": "Pointer",
                "inner_type": {
                    "kind": "User",
                    "name": "ImDrawList",
                    "storage_classes": [
                        "const"
                    ]
                }
            }
        }
        """
        """Array
        {
            "declaration": "float[2]",
            "description": {
                "kind": "Array",
                "bounds": "2",
                "inner_type": {
                    "kind": "Builtin",
                    "builtin_type": "float"
                }
            }
        }
        """
        """Function Pointer
        {
            "declaration": "const char* (*GetClipboardTextFn)(void* user_data)",
            "type_details": {
                "flavour": "function_pointer",
                "return_type": {
                    "declaration": "const char*",
                    "description": {
                        "kind": "Pointer",
                        "inner_type": {
                            "kind": "Builtin",
                            "builtin_type": "char",
                            "storage_classes": [
                                "const"
                            ]
                        }
                    }
                },
                "arguments": [
                    {
                        "name": "user_data",
                        "type": {
                            "declaration": "void*",
                            "description": {
                                "kind": "Pointer",
                                "inner_type": {
                                    "kind": "Builtin",
                                    "builtin_type": "void"
                                }
                            }
                        },
                        "is_array": false,
                        "is_varargs": false,
                        "is_instance_pointer": false
                    }
                ]
            },
            "description": {
                "kind": "Type",
                "name": "GetClipboardTextFn",
                "inner_type": {
                    "kind": "Pointer",
                    "inner_type": {
                        "kind": "Function",
                        "return_type": {
                            "kind": "Pointer",
                            "inner_type": {
                                "kind": "Builtin",
                                "builtin_type": "char",
                                "storage_classes": [
                                    "const"
                                ]
                            }
                        },
                        "parameters": [
                            {
                                "kind": "Type",
                                "name": "user_data",
                                "inner_type": {
                                    "kind": "Pointer",
                                    "inner_type": {
                                        "kind": "Builtin",
                                        "builtin_type": "void"
                                    }
                                }
                            }
                        ]
                    }
                }
            }
        }
        """
        self.type_json = type_json
        self.declaration: str = type_json["declaration"]
        self.kind: DearBindingsTypeNew.Kind = DearBindingsTypeNew.Kind(type_json["description"], self.is_function_ptr())
    
    def __repr__(self):
        return str(self.kind)

    def is_function_ptr(self) -> bool:
        return "type_details" in self.type_json


class DearBindingsStructNew:
    """Struct
    {
        "name": "ImGuiStyle",
        "original_fully_qualified_name": "ImGuiStyle",
        "kind": "struct",
        "by_value": false,
        "forward_declaration": false,
        "is_anonymous": false,
        "fields": [],
        "is_internal": false,
        "source_location": {
            "filename": "imgui.h",
            "line": 2015
        }
    """
    class Field:
        """Field
        {
            "name": "BackendLanguageUserData",
            "is_array": false,
            "is_anonymous": false,
            "type": {
                "declaration": "void*",
                "description": {
                    "kind": "Pointer",
                    "inner_type": {
                        "kind": "Builtin",
                        "builtin_type": "void"
                    }
                }
            },
            "comments": {
                "attached": "// = NULL           // User data for non C++ programming language backend"
            },
            "is_internal": false,
            "source_location": {
                "filename": "imgui.h",
                "line": 2175
            }
        }
        """
        """Function Pointer
        {
            "name": "GetClipboardTextFn",
            "is_array": false,
            "is_anonymous": false,
            "type": {
                "declaration": "const char* (*GetClipboardTextFn)(void* user_data)",
                "type_details": {
                    "flavour": "function_pointer",
                    "return_type": {
                        "declaration": "const char*",
                        "description": {
                            "kind": "Pointer",
                            "inner_type": {
                                "kind": "Builtin",
                                "builtin_type": "char",
                                "storage_classes": [
                                    "const"
                                ]
                            }
                        }
                    },
                    "arguments": [
                        {
                            "name": "user_data",
                            "type": {
                                "declaration": "void*",
                                "description": {
                                    "kind": "Pointer",
                                    "inner_type": {
                                        "kind": "Builtin",
                                        "builtin_type": "void"
                                    }
                                }
                            },
                            "is_array": false,
                            "is_varargs": false,
                            "is_instance_pointer": false
                        }
                    ]
                },
                "description": {
                    "kind": "Type",
                    "name": "GetClipboardTextFn",
                    "inner_type": {
                        "kind": "Pointer",
                        "inner_type": {
                            "kind": "Function",
                            "return_type": {
                                "kind": "Pointer",
                                "inner_type": {
                                    "kind": "Builtin",
                                    "builtin_type": "char",
                                    "storage_classes": [
                                        "const"
                                    ]
                                }
                            },
                            "parameters": [
                                {
                                    "kind": "Type",
                                    "name": "user_data",
                                    "inner_type": {
                                        "kind": "Pointer",
                                        "inner_type": {
                                            "kind": "Builtin",
                                            "builtin_type": "void"
                                        }
                                    }
                                }
                            ]
                        }
                    }
                }
            },
            "comments": {
                "preceding": [
                    "// Optional: Access OS clipboard",
                    "// (default to use native Win32 clipboard on Windows, otherwise uses a private clipboard. Override to access OS clipboard on other architectures)"
                ]
            },
            "is_internal": false,
            "source_location": {
                "filename": "imgui.h"
            }
        """
        def __init__(self, field_json: dict):
            self.name: str = field_json["name"]
            self.is_array: bool = field_json["is_array"]
            self.is_anonymous: bool = field_json["is_anonymous"]
            self._type: DearBindingsTypeNew = DearBindingsTypeNew(field_json["type"])
            self.is_internal: bool = field_json["is_internal"]
            self.source_location: dict = field_json.get("source_location")
            self.comments: Comments = parse_comment(field_json)
        
        def __repr__(self):
            return "{}{}".format(
                self._type,
                "" if self._type.is_function_ptr() else " " + self.name
            )

    def __init__(self, struct_json: dict):
        self.name: str = struct_json["name"]
        self.original_fully_qualified_name: str = struct_json["original_fully_qualified_name"]
        self.kind: str = struct_json["kind"]
        self.by_value: bool = struct_json["by_value"]
        self.forward_declaration: bool = struct_json["forward_declaration"]
        self.is_anonymous: bool = struct_json["is_anonymous"]
        self.fields: List[DearBindingsStructNew.Field] = [DearBindingsStructNew.Field(f) for f in struct_json["fields"]]
        self.is_internal: bool = struct_json["is_internal"]
        self.source_location: dict = struct_json["source_location"]
        self.comments: Comments = parse_comment(struct_json)

    def __repr__(self):
        # return "Struct({}({}))".format(self.name, ", ".join((str(f) for f in self.fields)))
    
        return "struct {}:{}{}".format(
            self.name,
            "\n    " if len(self.fields) > 0 else "",
            "\n    ".join((str(a) for a in self.fields)),
        )


class DearEnum:
    class Element:
        def __init__(self, name: str, value: int, comments: Comments):
            self.name: str          = name
            self.value: int         = value
            self.comments: Comments = comments
        
        def name_omitted_imgui_prefix(self):
            return self.name.replace("ImGui", "", 1)
        

    def __init__(self, name: str, elements: List[Element], comments: Comments):
        self.name: str                      = name
        self.elements: List[DearEnum.Element] = elements
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
            "bool*": "Bool",
            "int*": "Int",
            "float*": "Float",
            "double*": "Double",
        }
        if self.with_no_const_or_sign() in ptr_version_mappings:
            return ptr_version_mappings[self.with_no_const_or_sign()]
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

    # Some groupings of uppercase characters are allowed. Each group is only
    # allowed to have one member match.
    exceptions_to_the_rule = [
        ["ID"],
        ["RGBA", "RGB"],
        ["HSV"],
        ["TTY"],
        ["UTF"],
        ["OSX"],
        ["ImGui"],
    ]

    for exception_group in exceptions_to_the_rule:
        for exception in exception_group:
            if exception in string:
                string = string.replace(exception, "_" + exception.lower() + "_")
                break
    
    # Replace last occurance of Ex with _Ex_
    if string.endswith("Ex"):
        string = string[::-1].replace("xE", "_xE_", 1)[::-1]
    
    new_string = StringIO()
    is_upper_streak = 0
    for i, char in enumerate(string):
        if char.isupper():
            is_upper_streak += 1
        else:
            is_upper_streak = 0
        
        if is_upper_streak == 1 and i > 0:
            new_string.write("_")
        
        new_string.write(char)
    underscored_string = new_string.getvalue().strip("_").replace("__", "_")
    if make_upper:
        return underscored_string.upper()
    else:
        return underscored_string.lower()


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


def parse_binding_new_json(cimgui_json, definitions) -> DearBindingNew:
    parsed_enums = [DearBindingsEnumNew(e) for e in cimgui_json["enums"]]
    parsed_typedefs = [DearBindingsTypedefNew(e) for e in cimgui_json["typedefs"]]
    parsed_structs = [DearBindingsStructNew(e) for e in cimgui_json["structs"]]
    parsed_functions = [DearBindingsFunctionNew(e) for e in cimgui_json["functions"]]

    parsed_functions.sort(key=lambda x: x.name)

    db = DearBindingNew(
        parsed_enums,
        parsed_typedefs,
        parsed_structs,
        parsed_functions
    )
    print(db)


def parse_binding_json(cimgui_json, definitions) -> DearBinding:
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

        DearBindingsEnumNew(enum_obj)

        enum_name = enum_obj["name"]

        parsed_enums_values = []
        for enum_element_obj in enum_obj["elements"]:
            if not passes_conditional(enum_element_obj, definitions):
                continue

            enum_element_name = enum_element_obj["name"]
            enum_element_value = enum_element_obj["value"]
            # if "value" in enum_element_obj:
            # else:
            #     enum_element_value = None
            enum_element_comment = parse_comment(enum_element_obj)
            parsed_enums_values.append(DearEnum.Element(
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

        DearBindingsTypedefNew(typedef_obj)

        typedef_name = typedef_obj["name"]
        typedef_type = typedef_obj["type"]["declaration"]
        typedef_comments = parse_comment(typedef_obj)
        # TODO: Use typedef_obj["type"]["declaration"]["description"]
        # and do a lookup to the builtins table from:
        # https://github.com/dearimgui/dear_bindings/blob/04e531be9a2115ebe2c746cb2bfb9aa139f1d400/docs/MetadataFormat.md?plain=1#L136

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
        
        DearBindingsStructNew(struct_obj)

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

            struct_field_name = safe_python_name(struct_field_obj["name"])
            # struct_field_name_is_array = struct_field_obj["is_array"]
            
            
            # TODO Review this
            DearBindingsTypeNew(struct_field_obj["type"])
            struct_field_type: str = struct_field_obj["type"]["declaration"]
            # Weird edge case where instances of:
            #       const int array[2]
            # ...gets converted to
            #       const int* const array
            # Which Cython cannot handle. Here we remove the second const
            # if struct_field_type.count("const") >= 2:
            #     struct_field_type = struct_field_type.replace("const", "__keeping__first__", 1)
            #     struct_field_type = struct_field_type.replace("const", "")
            #     struct_field_type = struct_field_type.replace("__keeping__first__", "const")

            struct_field_comments = parse_comment(struct_field_obj)
            # for struct_field_name_obj in struct_field_obj["name"]:

            # struct_field_name_is_array = False
            # if "is_array" in struct_field_obj:

            # local_struct_field_type = struct_field_type + ("*" if struct_field_name_is_array else "")
            # struct_fields.append(DearStruct.Field(
            #     struct_field_name,
            #     DearType(local_struct_field_type),
            #     struct_field_comments,
            # ))
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
        
        # TODO Review
        DearBindingsTypeNew(function_obj["return_type"])

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
            # if function_argument_type.count("const") >= 2:
            #     function_argument_type = function_argument_type.replace("const", "__keeping__first__", 1)
            #     function_argument_type = function_argument_type.replace("const", "")
            #     function_argument_type = function_argument_type.replace("__keeping__first__", "const")
            
            # I'm also not interested in keeping va_list since Cython cannot
            # handle this.

            DearBindingsArgumentNew(function_argument_obj)

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
    
    cdef extern from "Python.h":
        ctypedef struct PyObject

    cdef extern from "pygui_config.h":
        PyObject* get_imgui_error()

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


def to_pyx(header: DearBinding, pxd_library_name: str, include_base: bool) -> str:
    header.sort()
    base = '''
    # distutils: language = c++
    # cython: language_level = 3
    # cython: embedsignature=True

    import ctypes
    import cython
    import array
    from collections import namedtuple
    from cython.operator import dereference
    from typing import Callable, Any, Sequence, Tuple, NamedTuple

    cimport ccimgui
    from libcpp cimport bool
    from libc.stdint cimport uintptr_t
    from libc.stdlib cimport malloc, free
    from libc.string cimport strncpy, memset
    from libc.float cimport FLT_MIN as LIBC_FLT_MIN
    from libc.float cimport FLT_MAX as LIBC_FLT_MAX
    from libc.limits cimport INT_MIN as LIBC_INT_MIN
    from libc.limits cimport INT_MAX as LIBC_INT_MAX
    from libc.limits cimport UINT_MAX as LIBC_UINT_MAX
    from libc.limits cimport LLONG_MIN as LIBC_LLONG_MIN
    from libc.limits cimport LLONG_MAX as LIBC_LLONG_MAX
    from libc.limits cimport ULLONG_MAX as LIBC_ULLONG_MAX

    FLT_MIN = LIBC_FLT_MIN
    FLT_MAX = LIBC_FLT_MAX
    INT_MIN = LIBC_INT_MIN
    INT_MAX = LIBC_INT_MAX
    UINT_MAX = LIBC_UINT_MAX
    LLONG_MIN = LIBC_LLONG_MIN
    LLONG_MAX = LIBC_LLONG_MAX
    ULLONG_MAX = LIBC_ULLONG_MAX

    # Used purely to allow for .x and .y notation on any of the tuples returned
    # by the _cast_ImVec2_tuple style functions. The included pygui examples does
    # not use this behaviour. It instead assumes that it is just a tuple. This
    # features mainly exists to prevent any accidents when translating ImGui code
    # to pygui.
    # Vec2Tuple = namedtuple("Vec2", "x y")
    # Vec4Tuple = namedtuple("Vec4", "x y z w")

    cdef void* _pygui_malloc(size_t sz, void* user_data):
        return malloc(sz)
    
    cdef void _pygui_free(void* ptr, void* user_data):
        free(ptr)

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


    cdef class Bool:
        @staticmethod
        cdef bool* ptr(ptr: Bool):
            return <bool*>(NULL if ptr is None else <void*>(&ptr.value))
        
        cdef public bool value

        def __init__(self, initial_value: bool):
            self.value: bool = initial_value

        def __bool__(self):
            return self.value


    cdef class Int:
        @staticmethod
        cdef int* ptr(ptr: Int):
            return <int*>(NULL if ptr is None else <void*>(&ptr.value))
        
        cdef public int value

        def __init__(self, initial_value: int=0):
            self.value: int = initial_value
    
    cdef class Long:
        @staticmethod
        cdef long long* ptr(ptr: Long):
            return <long long*>(NULL if ptr is None else <void*>(&ptr.value))
        
        cdef public long long value

        def __init__(self, initial_value: int=0):
            self.value: int = initial_value


    cdef class Float:
        @staticmethod
        cdef float* ptr(ptr: Float):
            return <float*>(NULL if ptr is None else <void*>(&ptr.value))
        
        cdef public float value

        def __init__(self, initial_value: float=0.0):
            self.value = initial_value


    cdef class Double:
        @staticmethod
        cdef double* ptr(ptr: Double):
            return <double*>(NULL if ptr is None else <void*>(&ptr.value))
        
        cdef public double value

        def __init__(self, initial_value: float=0.0):
            self.value = initial_value


    cdef class String:
        cdef char* buffer
        cdef unsigned int _buffer_size

        def __cinit__(self, initial_value: str="", buffer_size=256):
            IM_ASSERT(buffer_size > 0)
            self.buffer = <char*>{pxd_library_name}.ImGui_MemAlloc(buffer_size)
            if self.buffer == NULL:
                raise MemoryError()
            self._buffer_size: int = buffer_size
            self.value = initial_value
        
        def __dealloc__(self):
            {pxd_library_name}.ImGui_MemFree(self.buffer)

        @property
        def buffer_size(self) -> int:
            return self._buffer_size
        @buffer_size.setter
        def buffer_size(self, value: int):
            raise NotImplementedError

        @property
        def value(self):
            return _from_bytes(self.buffer)
        @value.setter
        def value(self, value: str):
            # Remember: len(bytes(str)) != len(str)
            # So to mark the end of the string, you should use the len(bytes).
            c_bytes = _bytes(value)
            n_bytes = len(c_bytes)
            strncpy(self.buffer, c_bytes, self._buffer_size)
            self.buffer[min(n_bytes, self._buffer_size - 1)] = 0


    cdef class Vec2:
        cdef public Float x_ptr
        cdef public Float y_ptr
        cdef int _n

        def __init__(self, x: float, y: float):
            self.x_ptr = Float(x)
            self.y_ptr = Float(y)
        
        def __add__(self, other: Vec2):
            return Vec2(
                self.x + other.x,
                self.y + other.y,
            )
        
        def __sub__(self, other: Vec2):
            return Vec2(
                self.x - other.x,
                self.y - other.y,
            )
        
        def __eq__(self, other: Vec2):
            return self.x == other.x \\
                and self.y == other.y
        
        def __len__(self):
            return 2

        def __getitem__(self, index: int):
            return self.tuple()[index]
        
        def __iter__(self):
            self._n = -1
            return self
        
        def __next__(self):
            self._n += 1
            if self._n == 0:
                return self.x
            elif self._n == 1:
                return self.y
            raise StopIteration
        
        def __repr__(self):
            return f"Vec2({{self.x}}, {{self.y}})"
        
        @staticmethod
        def zero():
            return Vec2(0, 0)

        @property
        def x(self):
            return self.x_ptr.value
        @x.setter
        def x(self, x):
            self.x_ptr.value = x
        @property
        def y(self):
            return self.y_ptr.value
        @y.setter
        def y(self, y):
            self.y_ptr.value = y

        def from_floatptrs(self, float_ptrs: Sequence[Float, Float]) -> Vec2:
            IM_ASSERT(len(float_ptrs) >= 2, "Must be a sequence of length 2")
            self.x_ptr = float_ptrs[0]
            self.y_ptr = float_ptrs[1]
            return self

        def as_floatptrs(self) -> Sequence[Float, Float]:
            return (
                self.x_ptr,
                self.y_ptr,
            )
        
        def tuple(self) -> Sequence[float, float]:
            return (
                self.x,
                self.y,
            )

        def from_tuple(self, vec: Sequence[float, float]) -> Vec2:
            if len(vec) < 2:
                raise IndexError
            
            self.x = vec[0]
            self.y = vec[1]
            return self

        def copy(self) -> Vec2:
            return Vec2(*self.tuple())
        

        cdef void from_array(self, float* array):
            self.x_ptr.value = array[0]
            self.y_ptr.value = array[1]

        cdef void to_array(self, float* array):
            array[0] = self.x_ptr.value
            array[1] = self.y_ptr.value


    cdef class Vec4:
        cdef public Float x_ptr
        cdef public Float y_ptr
        cdef public Float z_ptr
        cdef public Float w_ptr

        def __init__(self, x: float, y: float, z: float, w: float):
            self.x_ptr = Float(x)
            self.y_ptr = Float(y)
            self.z_ptr = Float(z)
            self.w_ptr = Float(w)
        
        def __add__(self, other: Vec4):
            return Vec4(
                self.x + other.x,
                self.y + other.y,
                self.z + other.z,
                self.w + other.w,
            )
        
        def __sub__(self, other: Vec4):
            return Vec2(
                self.x - other.x,
                self.y - other.y,
                self.z - other.z,
                self.w - other.w,
            )
        
        def __eq__(self, other: Vec2):
            return self.x == other.x \\
                and self.y == other.y \\
                and self.z == other.z \\
                and self.w == other.w \\
        
        def __len__(self):
            return 4

        def __getitem__(self, index: int):
            return self.tuple()[index]
        
        def __iter__(self):
            self._n = -1
            return self
        
        def __next__(self):
            self._n += 1
            if self._n == 0:
                return self.x
            elif self._n == 1:
                return self.y
            elif self._n == 2:
                return self.z
            elif self._n == 3:
                return self.w
            raise StopIteration
        
        def __repr__(self):
            return f"Vec4({{self.x}}, {{self.y}}, {{self.z}}, {{self.w}})"
        
        @staticmethod
        def zero():
            return Vec4(0, 0, 0, 0)

        @property
        def x(self):
            return self.x_ptr.value
        @x.setter
        def x(self, x):
            self.x_ptr.value = x
        @property
        def y(self):
            return self.y_ptr.value
        @y.setter
        def y(self, y):
            self.y_ptr.value = y
        @property
        def z(self):
            return self.z_ptr.value
        @z.setter
        def z(self, z):
            self.z_ptr.value = z
        @property
        def w(self):
            return self.w_ptr.value
        @w.setter
        def w(self, w):
            self.w_ptr.value = w
        
        def from_floatptrs(self, float_ptrs: Sequence[Float, Float, Float, Float]) -> Vec4:
            IM_ASSERT(len(float_ptrs) >= 4, "Must be a sequence of length 4")
            self.x_ptr = float_ptrs[0]
            self.y_ptr = float_ptrs[1]
            self.z_ptr = float_ptrs[2]
            self.w_ptr = float_ptrs[3]
            return self

        def as_floatptrs(self) -> Sequence[Float, Float, Float, Float]:
            return (
                self.x_ptr,
                self.y_ptr,
                self.z_ptr,
                self.w_ptr,
            )

        def tuple(self) -> Sequence[float, float, float, float]:
            return (
                self.x,
                self.y,
                self.z,
                self.w,
            )
        
        def from_tuple(self, vec: Sequence[float, float, float, float]) -> Vec4:
            if len(vec) < 4:
                raise IndexError
            
            self.x = vec[0]
            self.y = vec[1]
            self.z = vec[2]
            self.w = vec[3]
            return self
        
        def to_u32(self) -> int:
            return IM_COL32(
                int(self.x * 255),
                int(self.y * 255),
                int(self.z * 255),
                int(self.w * 255),
            )

        def copy(self) -> Vec4:
            return Vec4(*self.tuple())

        cdef void from_array(self, float* array):
            self.x_ptr.value = array[0]
            self.y_ptr.value = array[1]
            self.z_ptr.value = array[2]
            self.w_ptr.value = array[3]

        cdef void to_array(self, float* array):
            array[0] = self.x_ptr.value
            array[1] = self.y_ptr.value
            array[2] = self.z_ptr.value
            array[3] = self.w_ptr.value
    
            
    cdef class ImGlyphRange:
        cdef unsigned short* c_ranges
        cdef object p_ranges
        
        def __cinit__(self, glyph_ranges: Sequence[tuple]):
            # All elements passed need to be of length 2, and add 1 to any
            # tuples that contain zero, because these are considered terminators
            # of the array in imgui. Assert that only positive numbers were
            # passed in.
            safe_ranges = []
            for glyph in glyph_ranges:
                IM_ASSERT(len(glyph) == 2)
                start, end = glyph
                IM_ASSERT(start >= 0 and end >= 0)
                start = start + 1 if start == 0 else start
                IM_ASSERT(start <= end)
                safe_ranges.append((start, end))
                    
            self.p_ranges = safe_ranges
            self.c_ranges = <unsigned short*>{pxd_library_name}.ImGui_MemAlloc((len(safe_ranges) * 2 + 1) * sizeof(short))
            if self.c_ranges == NULL:
                raise MemoryError()
            for i, g_range in enumerate(safe_ranges):
                self.c_ranges[i * 2] = g_range[0]
                self.c_ranges[i * 2 + 1] = g_range[1]
            self.c_ranges[len(safe_ranges) * 2] = 0
        
        @property
        def ranges(self):
            return self.p_ranges
        @ranges.setter
        def ranges(self, value):
            raise NotImplementedError
        
        def destroy(self: ImGuiTextFilter):
            """
            Explicitly frees this instance.
            """
            if self.c_ranges != NULL:
                {pxd_library_name}.ImGui_MemFree(self.c_ranges)
                self.c_ranges = NULL
        def __dealloc__(self):
            """
            Just in case the user forgets to free the memory.
            """
            self.destroy()
        
        @staticmethod
        cdef from_short_array(const {pxd_library_name}.ImWchar* c_glyph_ranges):
            cdef {pxd_library_name}.ImWchar x
            cdef {pxd_library_name}.ImWchar y
            cdef int i = 0
            ranges = []
            while True:
                x = c_glyph_ranges[i * 2]
                if x == 0:
                    break
                y = c_glyph_ranges[i * 2 + 1]
                ranges.append((x, y))
                i += 1
            # Owns the ranges and keeps a copy.
            return ImGlyphRange(ranges)


    PAYLOAD_TYPE_COLOR_3F = "_COL3F"
    PAYLOAD_TYPE_COLOR_4F = "_COL4F"

    # IM_COL32_R_SHIFT = 0
    # IM_COL32_G_SHIFT = 8
    # IM_COL32_B_SHIFT = 16
    # IM_COL32_A_SHIFT = 24
    def IM_COL32(int r, int g, int b, int a) -> int:
        cdef unsigned long output = 0
        output |= a << 24
        output |= b << 16
        output |= g << 8
        output |= r << 0
        return output

    IM_COL32_WHITE        = IM_COL32(255, 255, 255, 255)   # Opaque white = 0xFFFFFFFF
    IM_COL32_BLACK        = IM_COL32(0, 0, 0, 255)         # Opaque black
    IM_COL32_BLACK_TRANS  = IM_COL32(0, 0, 0, 0)

    def get_imgui_error():
        cdef {pxd_library_name}.PyObject* imgui_exception
        imgui_exception = {pxd_library_name}.get_imgui_error()
        if imgui_exception == NULL:
            return None

        cdef object python_exception = <object>imgui_exception
        return python_exception

    def IM_ASSERT(condition: bool, error_message: str=""):
        """
        If cimgui exposes us a custom exception, we will use that. Otherwise,
        we will use Python's AssertionError.
        """
        if condition:
            return
        
        # The variable name of ImGuiError means nothing. It just makes python's
        # traceback look nicer. The actual name of the exception is defined
        # in the config.cpp
        ImGuiError = get_imgui_error()
        if ImGuiError is None:
            raise AssertionError(error_message)
        else:
            raise ImGuiError(error_message)
    
    def IM_CLAMP(n, smallest, largest):
        return max(smallest, min(n, largest))

    '''

    pyx = StringIO()

    if include_base:
        pyx.write(textwrap.dedent(base.lstrip("\n")).format(
            pxd_library_name=pxd_library_name
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
        lines_required_for_marshalling = []
        if len(function.arguments) > 0:
            function_argument_list = []
            for argument in function.arguments:
                marshalled_type, additional_lines = header.marshall_python_to_c(argument.type, argument.name, pxd_library_name, argument.default_value)
                lines_required_for_marshalling += additional_lines
                if argument.name == "self":
                    marshalled_type = "self._ptr"
                function_argument_list.append(marshalled_type)

            function_arguments = "\n" + ",\n".join(function_argument_list) + "\n    "
            function_arguments = textwrap.indent(function_arguments, "        ")
        else:
            function_arguments = ""
        
        # Checking for lines required to marshalling between python and c
        function_template.set_condition("has_additional_lines", len(lines_required_for_marshalling) > 0)
        function_template.format(
            additional_lines=textwrap.indent("\n".join(lines_required_for_marshalling), "    ")
        )
        
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

        # Depending on if custom_comment_only is set, we'll generate the comment
        # twice. This will make the pyx parser only edit the first comment
        # keeping the old comment in the implementation. This is mainly to let
        # diff_match_patch find the old comment to apply changes to if the
        # comment changes in cimgui.
        # struct_comments = None
        # if struct.comments.three_quote_all_comments() is not None:
        #     struct_comments = struct.comments.three_quote_all_comments() + "\n" + \
        #         comment_text(struct.comments.three_quote_all_comments())
        
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
            value, _ = header.marshall_python_to_c(field.type, "value", pxd_library_name)

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


def to_pyi(headers: List[DearBinding], model: PyxHeader, extension_name: str,
           show_comments: bool):
    base = textwrap.dedent('''
    # This file is auto-generated. If you need to edit this file then edit the
    # template that this is created from instead.
    from typing import Any, Callable, Tuple, List, Sequence
    from PIL import Image

    FLT_MIN: float
    """
    Occasionally used by ImGui to mark boundaries for things. Usually used as
    `-pygui.FLT_MIN`
    """
    FLT_MAX: float
    """
    Occasionally used by ImGui to mark boundaries for things.
    """
    INT_MIN: int
    INT_MAX: int
    UINT_MAX: int
    LLONG_MIN: int
    LLONG_MAX: int
    ULLONG_MAX: int

    PAYLOAD_TYPE_COLOR_3F: int
    """
    Used by `pygui.accept_drag_drop_payload()` to retrieve colors that are
    dragged inside ImGui. No Alpha channel.
    """
    PAYLOAD_TYPE_COLOR_4F: int
    """
    Used by `pygui.accept_drag_drop_payload()` to retrieve colors that are
    dragged inside ImGui. Includes Alpha channel.
    """

    class ImGuiError(Exception):
        """
        Raised by ImGui if an `IM_ASSERT()` fails *and* custom exceptions have
        been turned on. Otherwise, this exception will be equal to
        `AssertionError` and ImGui exceptions will be left to crash your app.
        """
        pass

    class Bool:
        """
        A wrapper class for a c++ boolean. `Use Bool.value` to access the
        underlying value. This as a replacement for `bool*` in c++.
        """
        value: bool
        def __init__(self, initial_value: bool) -> Bool: ...
        def __bool__(self) -> bool:
            """
            Allows this instance to be directly used a boolean in an `if` statement
            without needing to extract the value.
                
                ```python
                my_boolean = pygui.Bool(True)
                if my_boolean:
                    print("This is true")
                ```
            """

    class Int:
        """
        A wrapper class for a c++ int. Use `Int.value` to access the underlying
        value. This as a replacement for `int*` in c++. The underlying `int` size
        will be platform specific. If more bytes are required then use a
        `pygui.Long`.
        """
        value: int
        def __init__(self, initial_value: int=0) -> Int: ...

    class Long:
        """
        A wrapper class for a c++ long long. Use `Long.value` to access the
        underlying value. This as a replacement for `long long*` in c++. The
        underlying `long long` size will be platform specific.
        """
        value: int
        def __init__(self, initial_value: int=0) -> Long: ...

    class Float:
        """
        A wrapper class for a c++ float. Use `Float.value` to access the
        underlying value. This as a replacement for `float*` in c++. The
        underlying `float` precision will be platform specific. If more precision
        is required then use a `pygui.Double`.
        """
        value: float
        def __init__(self, initial_value: float=0.0) -> Float: ...

    class Double:
        """
        A wrapper class for a c++ double. Use `Double.value` to access the
        underlying value. This as a replacement for `double*` in c++. The
        underlying `double` precision will be platform specific.
        """
        value: float
        def __init__(self, initial_value: float=0.0) -> Double: ...

    class String:
        """
        A wrapper class for a c++ heap allocated `char*` string. Use
        `String.value` to read the buffer as if it were a python string. The
        `buffer_size` indicates how large the buffer backing this string should
        be. Depending on the characters in the string, the `buffer_size`
        *may not* be the same `len()` as the string.
        
        The number of writable bytes is equal to `buffer_size - 1`, to make room
        for the NULL byte which is automatically handled by this class.

        Modifying the underling `String.value` is also supported. This will
        automically convert the string passed into bytes and populate the buffer
        using `strncpy` (no buffer overflow for you). Modifying the
        `buffer_size` is *not* supported and will raise a NotImplementedError if
        changed. `buffer_size` must be >= 0 on creation.
        
        This as a replacement for `char*` in c++.
        """
        value: str
        buffer_size: int
        """
        Read only size of the heap allocated buffer backing this string.
        """
        def __init__(self, initial_value: str="", buffer_size=256) -> String: ...

    class Vec2:
        """
        A wrapper class for a c++ ImVec2. Use `Vec2.x` and `Vec2.y` to access
        individual components of the Vector. Or use `Vec2.tuple()` to access the
        the underlying `ImVec2` as a read-only python `tuple`. Each component of
        this `Vec2` is a `pygui.Float`. See the methods on this class for more
        information.
        """
        x: float
        """
        Access/Modify the `x` component of the `Vec2` 
        """
        y: float
        """
        Access/Modify the `y` component of the `Vec2` 
        """
        x_ptr: Float
        """
        Access/Modify the `x` component of the `Vec2` as a `pygui.Float`
        """
        y_ptr: Float
        """
        Access/Modify the `y` component of the `Vec2` as a `pygui.Float`
        """
        def __init__(self, x: float, y: float) -> Vec2: ...
        @staticmethod
        def zero() -> Vec2:
            """
            Same as `Vec2(0, 0)`
            """
            pass
        
        def tuple(self) -> Sequence[float, float]:
            """
            Access a read-only tuple containing the `x`, `y` components of the
            `Vec2`
            """
            pass
        
        def from_tuple(self, vec: Sequence[float, float]) -> Vec2:
            """
            Modify the components of the `Vec2` using a (minimum) length 2
            Sequence. eg. tuple/list

                ```python
                vec2 = pygui.Vec2(0, 0)
                vec2.from_tuple((50, 100))
                ```
            
            Returns the same Vec2 so that this method can be chained.
            """
            pass
        
        def as_floatptrs(self) -> Sequence[Float, Float]:
            """
            Returns the internal components of the `Vec2` as a length 2 tuple of
            `pygui.Floats`. Each `pygui.Float` can be used to modify the
            internal state of the `Vec2` from elsewhere.
            """
            pass
        
        def from_floatptrs(self, float_ptrs: Sequence[Float, Float]) -> Vec2:
            """
            Modify the components of the `Vec2` using a (minimum) length 2
            Sequence of `pygui.Float`. eg. tuple/list. Returns the same Vec2 so
            that this method can be chained.
            """
            pass
        
        def copy(self) -> Vec2:
            """
            Returns a new deepcopied `Vec2`. The underlying `pygui.Float` are
            also new.
            """
            pass

    class Vec4:
        """
        A wrapper class for a c++ ImVec4. Use `Vec4.x`, `Vec4.y`, `Vec4.z` and
        `Vec4.w` to access individual components of the Vector. Or use
        `Vec4.tuple()` to access the the underlying `ImVec4` as a read-only
        python `tuple`. Each component of this `Vec4` is a `pygui.Float`. See
        the methods on this class for more information.
        """
        x: float
        """
        Access/Modify the `x` component of the `Vec4` 
        """
        y: float
        """
        Access/Modify the `y` component of the `Vec4` 
        """
        z: float
        """
        Access/Modify the `z` component of the `Vec4` 
        """
        w: float
        """
        Access/Modify the `w` component of the `Vec4` 
        """
        x_ptr: Float
        """
        Access/Modify the `x` component of the `Vec4` as a `pygui.Float`
        """
        y_ptr: Float
        """
        Access/Modify the `y` component of the `Vec4` as a `pygui.Float`
        """
        z_ptr: Float
        """
        Access/Modify the `z` component of the `Vec4` as a `pygui.Float`
        """
        w_ptr: Float
        """
        Access/Modify the `w` component of the `Vec4` as a `pygui.Float`
        """
        def __init__(self, x: float, y: float, z: float, w: float) -> Vec4: ...
        @staticmethod
        def zero() -> Vec4:
            """
            Same as `Vec4(0, 0)`
            """
            pass
        
        def tuple(self) -> Sequence[float, float, float, float]:
            """
            Access a read-only tuple containing the components of the `Vec4`
            """
            pass
        
        def from_tuple(self, vec: Sequence[float, float, float, float]) -> Vec4:
            """
            Modify the components of the `Vec4` using a (minimum)
            length 4 Sequence. eg. tuple/list

                ```python
                vec4 = pygui.Vec4(0, 0, 0, 0)
                vec4.from_tuple((50, 100, 150, 200))
                ```

            Returns the same Vec4 so that this method can be chained.
            """
            pass
        
        def as_floatptrs(self) -> Sequence[Float, Float, Float, Float]:
            """
            Returns the internal components of the `Vec2` as a length 4 tuple of
            `pygui.Floats`. Each `pygui.Float` can be used to modify the
            internal state of the `Vec4` from elsewhere.
            """
            pass
        
        def from_floatptrs(self, float_ptrs: Sequence[Float, Float, Float, Float]) -> Vec4:
            """
            Modify the components of the `Vec4` using a (minimum) length 4
            Sequence of `pygui.Float`. eg. tuple/list. Returns the same Vec4 so
            that this method can be chained.
            """
            pass
        
        def to_u32(self) -> int:
            """
            Converts this `Vec4` into a u32 integer. u32 integers are used in
            ImGui for coloring.
            """
            pass
        
        def copy(self) -> Vec4:
            """
            Returns a new deepcopied `Vec4`. The underlying `pygui.Float` are
            also new.
            """
            pass
    
    class ImGlyphRange:
        """
        A custom wrapper around an `unsigned short*` array. This is used to back
        the glyph range used by many of the font functions in pygui. Pass a list
        of 2 element tuples to create a valid range.
        
        For example:

            ```python
            range = pygui.ImGlyphRange([
                (0x01,   0xFF),   # Extended ASCII Range,
                (0x1F00, 0x1FFF), # Greek Extended Range
            ])
            ```

        Unlike ImGui, you do not need to pass a 0 element to mark the end of
        the array. This class will handle that. If any of the ranges start with
        a 0, that range will be changed to 1.

            ```python
            range = pygui.ImGlyphRange([
                (0x00, 0xFF) # Internally adds 1
            ]) 
            # Is the the same as
            range = pygui.ImGlyphRange([
                (0x01, 0xFF)
            ])
            ```
        """
        ranges: Sequence[tuple]
        """
        The (read-only) list of ranges backing this object. Modifying this value
        will raise a NotImplementedError.
        """
        def __init__(self, glyph_ranges: Sequence[tuple]): ...
        def destroy(self):
            """
            Internally, the memory backing the ImGlyphRange will be freed when
            the python object is cleaned up by the garbage collector, but this
            may actually free the memory backing this range before you call
            `ImFontAtlas.build()` which requires the buffer to be valid. Hence,
            this function exists.
            
            Call `ImGlyphRange.destroy()` explicitly after calling
            `ImFontAtlas.build()` to ensure Python does not garbage-collect this
            object.
            """
            pass


    def IM_COL32(r: int, g: int, b: int, a: int) -> int:
        """
        Mimics a macro in ImGui. Each components is between 0-255. The result is
        a u32 integer used commonly in ImGui for coloring.
        """
    
    IM_COL32_WHITE : int
    IM_COL32_BLACK : int
    IM_COL32_BLACK_TRANS : int

    class ImGuiError(Exception): ...

    def IM_ASSERT(condition: bool, msg: str=""):
        """
        Use like `assert`. If the condition is false an `ImGuiError` is raised.
        """
        pass
    
    def IM_CLAMP(n, smallest, largest):
        """
        Returns n clamped to [smallest, largest]
        """
        pass
        
    def load_image(image: Image) -> int:
        """
        Loads a PIL image into ImGui. Returns a texture handle that can be used
        in any `pygui.image` function.
        """
        pass

    '''.lstrip("\n"))

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
        if comparable_is_invisible(function):
            continue

        function_template = Template(function_template_src)

        function_template.set_condition("has_comment", function.comment is not None and show_comments)
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
        if comparable_is_invisible(class_):
            continue

        class_template = Template(class_template_src)
        class_template.set_condition("has_content", class_.has_one_active_member() or class_.comment is not None)
        class_template.set_condition("has_one_member", class_.has_one_active_member())
        class_template.set_condition("has_comment", class_.comment is not None and show_comments)

        class_template.format(
            class_name=class_.name,
            class_comment=textwrap.indent(f'"""\n{class_.comment}\n"""', "    "),
        )
        pyi_output.write(class_template.compile())

        for field in class_.fields:
            if comparable_is_invisible(field):
                continue

            field_template = Template(field_template_src)
            field_template.set_condition("has_comment", field.comment is not None and show_comments)
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
            if comparable_is_invisible(method):
                continue

            method_template = Template(function_template_src)
            method_template.set_condition("has_comment", method.comment is not None and show_comments)
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

    ImGuiError = {extension_name}.get_imgui_error()
    if ImGuiError is None:
        ImGuiError = AssertionError


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
    
    EXTENSION_NAME =           config["EXTENSION_NAME"]
    CIMGUI_PXD_PATH =          config["CIMGUI_PXD_PATH"]
    CIMGUI_LIBRARY_NAME =      config["CIMGUI_LIBRARY_NAME"]
    GENERATED_PYX_PATH =       config["GENERATED_PYX_PATH"]
    GENERATED_PYX_TRIAL_PATH = config["GENERATED_PYX_TRIAL_PATH"]
    PYX_PATH =                 config["PYX_PATH"]
    PYX_TRIAL_PATH =           config["PYX_TRIAL_PATH"]
    TEMPLATE_PYX_PATH =        config["TEMPLATE_PYX_PATH"]
    TEMPLATE_PYX_TRIAL_PATH =  config["TEMPLATE_PYX_TRIAL_PATH"]
    INIT_PYI_PATH =            config["INIT_PYI_PATH"]
    INIT_PY_PATH =             config["INIT_PY_PATH"]
    
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
            json_content = json.load(f)
            headers.append(parse_binding_json(json_content, defines))
            parse_binding_new_json(json_content, defines)

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
            new_pyx += to_pyx(header, pxd_libary_name, i == 0)

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
        
        with open(GENERATED_PYX_TRIAL_PATH, "w") as f:
            f.write(merge_result.new_pyx)
        with open(PYX_TRIAL_PATH, "w") as f:
            f.write(merge_result.merged_pyx)
        with open(TEMPLATE_PYX_TRIAL_PATH, "w") as f:
            f.write(merge_result.merged_pyx_all_active)
        print(f"Created {PYX_TRIAL_PATH}")
        print(f"Created {TEMPLATE_PYX_TRIAL_PATH}")

    def reset(headers: List[DearBinding], pxd_libary_name: str):
        new_pyx = ""
        for i, header in enumerate(headers):
            new_pyx += to_pyx(header, pxd_libary_name, i == 0)
        
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
            pxd += to_pxd(header, header_file, i == 0)
        
        with open(CIMGUI_PXD_PATH, "w") as f:
            f.write(pxd)
        print(f"Created {CIMGUI_PXD_PATH}")
    
    def write_pyx(headers: List[DearBinding], pxd_libary_name: str):
        new_pyx = ""
        for i, header in enumerate(headers):
            new_pyx += to_pyx(header, pxd_libary_name, i == 0)

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
    
    def write_pyi(headers: List[DearBinding], extension_name: str, show_comments: bool):
        try:
            with open(TEMPLATE_PYX_PATH) as f:
                model = create_pyx_model(f.read())
        except FileNotFoundError:
            print(f"'{TEMPLATE_PYX_PATH}' not found. This is required to create the pyi file")
            return
        
        pyi, py = to_pyi(headers, model, extension_name, show_comments)

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
    
    show_comments = "--nocomments" not in sys.argv

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
        write_pyi(headers, EXTENSION_NAME, show_comments)
        return
    
    if "--all" in sys.argv:
        write_pxd(headers, header_files)
        write_pyx(headers, CIMGUI_LIBRARY_NAME)
        write_pyi(headers, EXTENSION_NAME, show_comments)
        return


if __name__ == "__main__":
    main()