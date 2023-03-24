from __future__ import annotations
from typing import List, Tuple


class PyxFunction:
    def __init__(self, name: str, lines: List[str], use_template=False,
                 custom_return_type=None):
        self.name: str = name
        self.impl: List[str] = lines
        self.use_template: bool = use_template
        self.custom_return_type: str = custom_return_type
    


class PxyField:
    def __init__(self, name: str, lines: List[str], use_template=False,
                 custom_type=None):
        self.name: str = name
        self.impl: List[str] = lines
        self.use_template: bool = use_template
        self.custom_type: str = custom_type


class PyxClass:
    def __init__(self, name: str, methods: List[PyxFunction],
                 fields: List[PxyField]):
        self.name = name
        self.methods = methods
        self.fields = fields


def get_sections(src: str, section_name: str) -> List[str]:
    all_sections = []
    found_section = []
    inside_section = False
    for line in src.split("\n"):
        if line.strip().startswith(f"# [End {section_name}]"):
            all_sections.append("\n".join(found_section))
            found_section = []
            inside_section = False
            
        if inside_section:
            found_section.append(line)

        if line.strip().startswith(f"# [{section_name}]"):
            inside_section = True
        
    return all_sections


def main():
    with open("pygui/core_v2.pyx") as f:
        pyx = f.read()
    
    function_section = get_sections(pyx, "Functions")[0]
    for function in get_sections(function_section, "Function"):
        print("-----------------------------------------------")
        # print(function)
        # print("-----------------------------------------------")
        lines = function.split("\n")
        use_template_line, custom_return_type_line, *lines = lines
        use_template = use_template_line.split("=")
        print(use_template_line)
        print(custom_return_type_line)



if __name__ == "__main__":
    main()
