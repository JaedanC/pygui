import textwrap
from io import StringIO
from .db_type import DearBindingsTypeNew
from ..interfaces import ITypedef, HasComment, IType
from ...comments import Comments, parse_comment


class DearBindingsTypedefNew(ITypedef, HasComment):
    def from_json(typedef_json: dict) -> ITypedef:
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
            }
        },
        """
        base: IType = DearBindingsTypeNew.from_json(typedef_json["type"])
        definition: str = typedef_json["name"]
        comments: Comments = parse_comment(typedef_json)
        return DearBindingsTypedefNew(base, definition, comments)

    def __init__(self, base: IType, definition: str, comments: Comments):
        self.base = base
        self.definition = definition
        self.comments = comments

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

    def get_base(self) -> IType:
        return self.base

    def get_definition(self) -> str:
        return self.definition
