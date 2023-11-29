import textwrap
from io import StringIO
from .db_type import DearBindingsTypeNew
from ..interfaces import Typedef, HasComment, _Type
from ...comments import Comments, parse_comment


class DearBindingsTypedefNew(Typedef, HasComment):
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
        self._type: _Type = DearBindingsTypeNew(typedef_json["type"])
        self.comments: Comments = parse_comment(typedef_json)
        self.is_internal: bool = typedef_json["is_internal"]
        self.source_location: dict = typedef_json["source_location"]

        self.base: _Type = self._type
        self.definition: str = self.name
    

    def to_pxd(self) -> str:
        contents = StringIO("")

        if self.base.is_function_pointer():
            contents.write("ctypedef {}".format(self.base.to_pxd()))
        else:
            contents.write("ctypedef {} {}".format(
                self.base.to_pxd(),
                self.definition
            ))
        
        return contents.getvalue()


    def is_function_pointer(self) -> bool:
        return self.base.is_function_pointer()


    def get_comment(self):
        return self.comments

    def get_base(self) -> _Type:
        return self.base

    def get_definition(self) -> str:
        return self.definition