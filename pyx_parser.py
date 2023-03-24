from __future__ import annotations
from typing import List, Tuple
import re


class PyxFunction:
    def __init__(self, name: str, lines: List[str], use_template=False,
                 custom_return_type=None):
        self.name: str = name
        self.impl: List[str] = lines
        self.use_template: bool = use_template
        self.custom_return_type: str = custom_return_type
    
    def __repr__(self):
        return "Function({}, template={}, return_type={})".format(
            self.name,
            self.use_template,
            self.custom_return_type
        )
    

class PyxField:
    def __init__(self, name: str, lines: List[str], use_template=False,
                 custom_type=None):
        self.name: str = name
        self.impl: List[str] = lines
        self.use_template: bool = use_template
        self.custom_type: str = custom_type
    
    def __repr__(self):
        return "Field({}, template={}, type={})".format(
            self.name,
            self.use_template,
            self.custom_type
        )


class PyxClass:
    def __init__(self, name: str, methods: List[PyxFunction],
                 fields: List[PyxField]):
        self.name = name
        self.methods = methods
        self.fields = fields
    
    def __repr__(self):
        return "Class({}):\n    {}\n    {}".format(
            self.name,
            "\n    ".join([str(f) for f in self.fields]),
            "\n    ".join([str(m) for m in self.methods]),
        )


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


def parse_function_options(lines):
    options = {}
    for line in lines:
        line = line.strip()
        if not line.startswith("# "):
            try:
                options["name"] = re.findall("def (.*?)\(", line)[0]
            except IndexError:
                continue
            break
        
        line = line.replace("# ", "", 1)
        assert " = " in line, "Must be in {} = {} format"
        assert len(line.split(" = ")) == 2, "Must be length 2"
        option, value = line.split(" = ")
        options[option] = value
    return options


def main():
    with open("pygui/core_v2.pyx") as f:
        pyx = f.read()
    
    functions = []
    function_section = get_sections(pyx, "Functions")[0]
    for function in get_sections(function_section, "Function"):
        options = parse_function_options(function.split("\n"))

        functions.append(PyxFunction(
            options["name"],
            function.split("\n"),
            options["use_template"],
            options["custom_return_type"],
        ))
    
    classes = []
    for class_section in get_sections(pyx, "Class"):
        lines = class_section.split("\n")
        name = re.findall("cdef class (.*):", lines[0])[0]
        print(name)

        methods = []
        for method_section in get_sections(class_section, "Method"):
            options = parse_function_options(method_section.split("\n"))
            methods.append(PyxFunction(
                options["name"],
                method_section.split("\n"),
                options["use_template"],
                options["custom_return_type"],
            ))
        
        fields = []
        for field_section in get_sections(class_section, "Field"):
            options = parse_function_options(field_section.split("\n"))
            print(options)
            fields.append(PyxField(
                options["name"],
                field_section.split("\n"),
                options["use_template"],
                options["custom_type"],
            ))
        
        classes.append(PyxClass(
            name,
            methods,
            fields
        ))
    

    for function in functions:
        print(function)
    
    for class_ in classes:
        print(class_)


if __name__ == "__main__":
    main()
