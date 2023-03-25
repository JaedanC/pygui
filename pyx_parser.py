from __future__ import annotations
from typing import List
from io import StringIO
import re


class PyxFunction:
    def __init__(self, name: str, parameters: str, lines: List[str],
                 use_template=False, custom_return_type=None):
        self.name: str = name
        self.parameters: str = parameters
        self.impl: List[str] = lines
        self.use_template: bool = use_template
        self.custom_return_type: str = custom_return_type
    
    def __repr__(self):
        return "Function({}, parameters({}), template={}, return_type={})".format(
            self.name,
            self.parameters,
            self.use_template,
            self.custom_return_type
        )
    
    def as_pyi_format(self):
        return "def {}({}) -> {}: ...".format(
            self.name,
            self.parameters,
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
    
    def as_pyi_format(self):
        return "{}: {}".format(
            self.name,
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
    
    def as_pyi_format(self):
        body = StringIO()
        body.write("\n")
        for field in self.fields:
            body.write("    {}\n".format(field.as_pyi_format()))
        
        for method in self.methods:
            body.write("    {}\n".format(method.as_pyi_format()))

        has_body = (len(self.methods) + len(self.fields)) > 0
        return "class {}:{}".format(
            self.name,
            " ..." if not has_body else body.getvalue()
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
        found_return_type = re.match(".*@pyi.returns\((.*?)\).*", line)
        if found_return_type is not None and "inferred_type" not in options:
            options["inferred_type"] = found_return_type.group(1) if found_return_type.group(1) != "" else None
        
        found_name = re.match("def (.*?)\((.*?)\):", line)
        if found_name is not None and "name" not in options:
            options["name"] = found_name.group(1)
            options["inferred_parameters"] = found_name.group(2)
        
        if line.startswith("#? "):
            line = line.replace("#? ", "", 1)
            assert len(line.split(" = ")) == 2, "Option must be length 2"
            option, value = line.split(" = ")
            options[option] = value
    return options


def main():
    with open("pygui/core_v2.pyx") as f:
        pyx = f.read()
    
    functions: List[PyxFunction] = []
    function_section = get_sections(pyx, "Functions")[0]
    for function in get_sections(function_section, "Function"):
        options = parse_function_options(function.split("\n"))

        if options["custom_return_type"] == "[Auto]":
            return_type = options["inferred_type"]
        else:
            return_type = options["custom_return_type"]

        functions.append(PyxFunction(
            options["name"],
            options["inferred_parameters"],
            function.split("\n"),
            options["use_template"],
            return_type,
        ))
    
    classes: List[PyxClass] = []
    for class_section in get_sections(pyx, "Class"):
        lines = class_section.split("\n")
        name = re.findall("cdef class (.*):", lines[0])[0]

        methods = []
        for method_section in get_sections(class_section, "Method"):
            options = parse_function_options(method_section.split("\n"))

            if options["custom_return_type"] == "[Auto]":
                return_type = options["inferred_type"]
            else:
                return_type = options["custom_return_type"]

            methods.append(PyxFunction(
                options["name"],
                options["inferred_parameters"],
                method_section.split("\n"),
                options["use_template"],
                return_type,
            ))
        
        fields = []
        for field_section in get_sections(class_section, "Field"):
            options = parse_function_options(field_section.split("\n"))

            if options["custom_type"] == "[Auto]":
                return_type = options["inferred_type"]
            else:
                return_type = options["custom_type"]

            fields.append(PyxField(
                options["name"],
                field_section.split("\n"),
                options["use_template"],
                return_type,
            ))
        
        classes.append(PyxClass(
            name,
            methods,
            fields
        ))
    

    output = StringIO()
    output.write("from typing import Any, Callable, Tuple, List\n\n")

    output.write("VERTEX_BUFFER_POS_OFFSET: int\n")
    output.write("VERTEX_BUFFER_UV_OFFSET: int\n")
    output.write("VERTEX_BUFFER_COL_OFFSET: int\n")
    output.write("VERTEX_SIZE: int\n")
    output.write("INDEX_SIZE: int\n\n")

    enum_section = get_sections(pyx, "Enums")[0]
    enum_lines = enum_section.split("\n")
    for line in enum_lines:
        if line == "":
            continue
    
        enum_string = line.split(" = ")[0]
        output.write(f"{enum_string}: int\n")

    output.write("\n")
    for function in functions:
        output.write(function.as_pyi_format() + "\n")
    output.write("\n")

    for class_ in classes:
        output.write(class_.as_pyi_format() + "\n")
    
    pyi_content = output.getvalue()
    with open("pygui/__init__.pyi", "w") as f:
        f.write(pyi_content)
    
    with open("pygui/__init__.py", "w") as f:
        f.write("from .core import *\n\n")
        f.write("VERTEX_BUFFER_POS_OFFSET = core._py_vertex_buffer_vertex_pos_offset()\n")
        f.write("VERTEX_BUFFER_UV_OFFSET = core._py_vertex_buffer_vertex_uv_offset()\n")
        f.write("VERTEX_BUFFER_COL_OFFSET = core._py_vertex_buffer_vertex_col_offset()\n")
        f.write("VERTEX_SIZE = core._py_vertex_buffer_vertex_size()\n")
        f.write("INDEX_SIZE = core._py_index_buffer_index_size()\n")

if __name__ == "__main__":
    main()
