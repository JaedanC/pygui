from typing import Optional

from ...comments import Comments, parse_comment
from ...parsed import safe_python_name
from ..interfaces import Argument, _Type
from .db_type import DearBindingsTypeNew


class DearBindingsArgumentNew(Argument):
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
        self.name: str = safe_python_name(argument_json["name"])
        self.is_array: bool = argument_json["is_array"]
        self.is_varargs: bool = argument_json["is_varargs"]
        assert not self.is_varargs, "Python does not support is_varargs: {}".format(self.name)
        self.is_instance_pointer: bool = argument_json["is_instance_pointer"]
        self._type: _Type = DearBindingsTypeNew(argument_json["type"])
        self.comments: Comments = parse_comment(argument_json)

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
            
            if self._type.with_no_const_or_sign() == "float":
                default_value = default_value.replace("f", "")
        
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

    def get_type(self) -> _Type:
        return self._type

    def get_name(self) -> str:
        return self.name

    def get_default_value(self) -> Optional[str]:
        return self.default_value
