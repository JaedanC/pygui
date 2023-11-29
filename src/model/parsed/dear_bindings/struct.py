import textwrap
from io import StringIO
from typing import List
from ...comments import Comments, parse_comment
from ...parsed import safe_python_name
from ..interfaces import Struct, _Type, Field, Function
from .db_type import DearBindingsTypeNew



class DearBindingsStructField(Field):
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
        self.name: str = safe_python_name(field_json["name"])
        self.is_array: bool = field_json["is_array"]
        self.is_anonymous: bool = field_json["is_anonymous"]
        self._type: _Type = DearBindingsTypeNew(field_json["type"])
        self.is_internal: bool = field_json["is_internal"]
        self.source_location: dict = field_json.get("source_location")
        self.comments: Comments = parse_comment(field_json)
    
    def to_pxd(self):
        return "{}{}".format(
            self._type.to_pxd(),
            "" if self._type.is_function_pointer() else " " + self.name
        )
    
    def get_name(self) -> str:
        return self.name
    
    def get_comment(self) -> Comments:
        return self.comments
    
    def get_type(self) -> _Type:
        return self._type


class DearBindingsStructNew(Struct):
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
    def __init__(self, struct_json: dict):
        self.name: str = struct_json["name"]
        self.fields: List[Field] = [DearBindingsStructField(f) for f in struct_json["fields"]]
        self.comments: Comments = parse_comment(struct_json)
        self.methods: List[Function] = []
    
    def get_name(self) -> str:
        return self.name

    def to_pxd(self):
        contents = StringIO("")

        comment_text = self.comments.hash_all_comments()
        if comment_text is not None:
            contents.write(comment_text)
            contents.write("\n")

        contents.write("ctypedef struct {}:".format(self.name))

        if len(self.fields) == 0:
            contents.write("\n    pass\n")
            return contents.getvalue()
        
        longest_field = 0
        for field in self.fields:
            longest_field = max(longest_field, len(field.to_pxd()))

        for field in self.fields:
            contents.write("\n    " + field.to_pxd())
            comment_text = field.get_comment().hash_attached_only()
            if comment_text is not None:
                contents.write(" " * (longest_field - len(field.to_pxd()) + 5))
                contents.write(comment_text)
        contents.write("\n")
        contents.write("\n")

        for method in self.methods:
            # Struct comments
            comment_text = method.get_comment().hash_all_comments()
            if comment_text is not None:
                contents.write("\n")
                contents.write(comment_text)
                contents.write("\n")
            
            argument_strings = []
            for argument in method.get_arguments():
                argument_strings.append("{}{}".format(
                    argument.get_type().to_pxd(),
                    " " + argument.get_name() if not argument.get_type().is_function_pointer() else "",
                ))
            method_pxd = "{} {}({}) except +\n".format(
                method.get_return_type().to_pxd(),
                method.get_name(),
                ", ".join(argument_strings)
            )
            contents.write(method_pxd)

        contents.write("\n")

        return contents.getvalue()

    def to_pxd_foward_declaration(self) -> str:
        return "ctypedef struct {}".format(self.name)

    def get_comment(self) -> Comments:
        return self.comments

    def get_fields(self) -> List[Field]:
        return self.fields

    def add_method(self, method: Function):
        self.methods.append(method)

    def get_methods(self) -> List[Function]:
        return self.methods
