from io import StringIO
from typing import List, Optional
from ...parsed import pythonise_string
from ...comments import Comments, parse_comment
from ..interfaces import Enum


class DearBindingsEnumNew(Enum):
    class Element:
        def __init__(self, element_json: dict):
            self.name: str = element_json["name"]
            self.value_expression: Optional[str] = element_json.get("value_expression")
            self.value: int = element_json["value"]
            self.is_count: bool = element_json["is_count"]
            self.comments: Comments = parse_comment(element_json)
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
    
    def __repr__(self) -> str:
        return "Enum({} -> {} elements)".format(self.name, len(self.elements))
    
    def to_pxd(self) -> str:
        contents = StringIO("")
        contents.write(f"ctypedef enum {self.name}:\n")

        longest_enum = 0
        for enum_element in self.elements:
            longest_enum = max(len(enum_element.name), longest_enum)

        for enum_element in self.elements:
            comment_text = enum_element.comments.hash_attached_only()
            padding_required = (5 + longest_enum - len(enum_element.name)) * " "
            contents.write("    {}{}\n".format(
                enum_element.name,
                padding_required + comment_text if comment_text is not None else ""
            ))
        return contents.getvalue()
    
    def to_pyx(self, pxd_library_name) -> str:
        contents = StringIO("")

        for enum_element in self.elements:
            contents.write("{} = {}.{}\n".format(
                pythonise_string(enum_element.name_omitted_imgui_prefix()).upper(),
                pxd_library_name,
                enum_element.name
            ))
        return contents.getvalue()
    

    def get_comment(self) -> Comments:
        return self.comments

    def has_element(self, to_find: str) -> bool:
        for element in self.elements:
            if element.name == to_find:
                return True
        return False
