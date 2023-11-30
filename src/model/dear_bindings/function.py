from io import StringIO
from typing import List
from ..comments import Comments, parse_comment
from .interfaces import IFunction, IType, IArgument
from .db_type import _Type
from .argument import Argument


class Function(IFunction):
    def from_json(function_json: dict) -> IFunction:
        """Function
        {
            "name": "ImGui_DestroyContext",
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
        name: str = function_json["name"]
        return_type: IType = _Type.from_json(function_json["return_type"])
        # Ignore any Cython unsupported arguments
        arguments: List[IArgument] = []
        for argument in function_json["arguments"]:
            if argument["is_varargs"] or argument.get("type", {}).get("declaration") == "va_list":
                continue
            arguments.append(Argument.from_json(argument))
        comments: Comments = parse_comment(function_json)
        return Function(name, return_type, arguments, comments)

    def __init__(self, name: str, return_type: IType, arguments: List[IArgument], comments: Comments = None):
        self.name = name
        self.python_name = self.name
        self.return_type = return_type
        self.arguments = arguments
        self.comments = comments
        if self.comments is None:
            self.comments = Comments([], None)
    
    def __repr__(self):
        return "{}() -> {}{}{}".format(
            self.name,
            self.return_type.to_pxd(),
            "\n    " if len(self.arguments) > 0 else "",
            "\n    ".join((a.to_pxd() for a in self.arguments)),
        )

    def to_pxd(self):
        content = StringIO("")

        comment_text = self.comments.hash_all_comments()
        if comment_text is not None:
            content.write("\n")
            content.write(comment_text)
            content.write("\n")
        
        content.write("{} {}({}) except +".format(
            self.return_type.to_pxd(),
            self.name,
            ", ".join((a.to_pxd() for a in self.arguments)),
        ))

        return content.getvalue()

    def get_return_type(self) -> IType:
        return self.return_type

    def get_name(self) -> str:
        return self.name

    def set_python_name(self, python_name: str):
        self.python_name = python_name
    
    def get_python_name(self) -> str:
        return self.python_name

    def get_function_name_no_imgui_prefix(self) -> str:
        return self.python_name.replace("ImGui_", "", 1)

    def get_arguments(self) -> List[IArgument]:
        return self.arguments

    def get_comment(self) -> Comments:
        return self.comments
