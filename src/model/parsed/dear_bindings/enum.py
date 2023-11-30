from io import StringIO
from typing import List, Optional
from ...parsed import pythonise_string
from ...comments import Comments, parse_comment
from ..interfaces import IEnum, HasComment


class DearBindingsEnumNew(IEnum):
    class Element(HasComment):
        def from_json(element_json: dict):
            name = element_json["name"]
            comments = parse_comment(element_json)
            return DearBindingsEnumNew.Element(name, comments)

        def __init__(self, name: str, comments: Comments):
            self.name = name
            self.comments = comments
        
        def get_name(self) -> str:
            return self.name

        def get_comment(self) -> Comments:
            return self.comments

        def name_omitted_imgui_prefix(self):
            return self.name.replace("ImGui", "", 1)

    def from_json(enum_json: dict) -> IEnum:
        name = enum_json["name"]
        elements = [DearBindingsEnumNew.Element.from_json(e) for e in enum_json["elements"]]
        comments = parse_comment(enum_json)
        return DearBindingsEnumNew(name, elements, comments)

    def __init__(self, name: str, elements: List[Element], comments: Comments):
        self.name = name
        self.elements = elements
        self.comments = comments

    def __repr__(self) -> str:
        return "Enum({} -> {} elements)".format(self.name, len(self.elements))
    
    def to_pxd(self) -> str:
        contents = StringIO("")
        contents.write(f"ctypedef enum {self.name}:\n")

        longest_enum = 0
        for enum_element in self.elements:
            longest_enum = max(len(enum_element.get_name()), longest_enum)

        for enum_element in self.elements:
            comment_text = enum_element.get_comment().hash_attached_only()
            padding_required = (5 + longest_enum - len(enum_element.get_name())) * " "
            contents.write("    {}{}\n".format(
                enum_element.get_name(),
                padding_required + comment_text if comment_text is not None else ""
            ))
        return contents.getvalue()

    def to_pyx(self, pxd_library_name) -> str:
        contents = StringIO("")

        for enum_element in self.elements:
            contents.write("{} = {}.{}\n".format(
                pythonise_string(enum_element.name_omitted_imgui_prefix()).upper(),
                pxd_library_name,
                enum_element.get_name()
            ))
        return contents.getvalue()
    
    def get_comment(self) -> Comments:
        return self.comments

    def has_element(self, to_find: str) -> bool:
        for element in self.elements:
            if element.get_name() == to_find:
                return True
        return False

    def get_name(self) -> str:
        return self.name
