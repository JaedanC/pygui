from typing import Optional

from ..comments import Comments, parse_comment
from . import safe_python_name
from .interfaces import IArgument, IType
from .db_type import DearBindingsTypeNew
import re


class DearBindingsArgumentNew(IArgument):
    def from_json(argument_json: dict) -> IArgument:
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
            "default_value": "NULL",
            "is_instance_pointer": false
        }
        """
        name = safe_python_name(argument_json["name"])
        assert not argument_json.get("is_varargs"), "Python does not support is_varargs: {}".format(name)
        _type: IType = DearBindingsTypeNew.from_json(argument_json["type"])
        comments: Comments = parse_comment(argument_json)

        default_lookup = {
            "NULL": "None",
            "true": "True",
            "false": "False",
        }

        default_value = argument_json.get("default_value")
        if default_value is not None:
            if default_value in default_lookup:
                default_value = default_lookup[default_value]
            
            if "ImVec2" in default_value:
                default_value = default_value.replace("ImVec2", "")
                default_value = default_value.replace("f", "")
            elif "ImVec4" in default_value:
                default_value = default_value.replace("ImVec4", "")
                default_value = default_value.replace("f", "")
            
            found = re.match("sizeof\((.*)\)", default_value)
            if found:
                default_value = "4"
            
            if _type.with_no_const_or_sign() == "float":
                default_value = default_value.replace("f", "")
        
        return DearBindingsArgumentNew(name, _type, comments, default_value)

    def __init__(self, name: str, _type: IType, comments: Comments = None, default_value=None):
        self.name = name
        self._type = _type
        self.comments = comments
        if self.comments is None:
            self.comments = Comments([], None)
        self.default_value = default_value

    def __repr__(self) -> str:
        return "{}: {}{}".format(
            self.name,
            self._type.to_pxd(),
            f"={self.default_value}" if self.default_value is not None else ""
        )

    def to_pxd(self) -> str:
        if self._type.is_function_pointer():
            return self._type.to_pxd()
        
        return "{} {}".format(
            self._type.to_pxd(),
            self.name,
        )

        # Default values are not required in the pxd
        # return "{} {}{}".format(
        #     self._type.to_pxd(),
        #     self.name,
        #     f"={self.default_value}" if self.default_value is not None else ""
        # )

    def get_type(self) -> IType:
        return self._type

    def get_name(self) -> str:
        return self.name

    def get_default_value(self) -> Optional[str]:
        return self.default_value
