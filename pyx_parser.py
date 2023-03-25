from __future__ import annotations
from typing import List, Tuple
from io import StringIO
import re


class PyxEnum:
    def __init__(self, enum_string: str):
        self.enum_string = enum_string
    
    def __repr__(self):
        return "Enum({})".format(
            self.enum_string
        )
    
    def as_pyi_format(self):
        return "{}: int".format(
            self.enum_string
        )


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
    
    def as_pyx_format(self):
        return "\n".join(self.impl)
    

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
        self.fields.sort(key=lambda f: f.name)
        self.methods.sort(key=lambda m: m.name)

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
    

class PyxCollection:
    def __init__(self, enums: List[PyxEnum], functions: List[PyxFunction], classes: List[PyxClass]):
        self.enums = enums
        self.functions = functions
        self.classes = classes

    def as_pyi_format(self) -> Tuple[str, str]:
        pyi_content = StringIO()
        pyi_content.write("from typing import Any, Callable, Tuple, List\n\n")
        pyi_content.write("VERTEX_BUFFER_POS_OFFSET: int\n")
        pyi_content.write("VERTEX_BUFFER_UV_OFFSET: int\n")
        pyi_content.write("VERTEX_BUFFER_COL_OFFSET: int\n")
        pyi_content.write("VERTEX_SIZE: int\n")
        pyi_content.write("INDEX_SIZE: int\n\n")

        self.functions.sort(key=lambda f: f.name)
        self.classes.sort(key=lambda c: c.name)

        for function in self.functions:
            pyi_content.write(function.as_pyi_format() + "\n")
        pyi_content.write("\n")

        for class_ in self.classes:
            pyi_content.write(class_.as_pyi_format() + "\n")
        
        py_content = StringIO()
        py_content.write("from .core import *\n\n")
        py_content.write("VERTEX_BUFFER_POS_OFFSET = core._py_vertex_buffer_vertex_pos_offset()\n")
        py_content.write("VERTEX_BUFFER_UV_OFFSET = core._py_vertex_buffer_vertex_uv_offset()\n")
        py_content.write("VERTEX_BUFFER_COL_OFFSET = core._py_vertex_buffer_vertex_col_offset()\n")
        py_content.write("VERTEX_SIZE = core._py_vertex_buffer_vertex_size()\n")
        py_content.write("INDEX_SIZE = core._py_index_buffer_index_size()\n")
        
        return pyi_content.getvalue(), py_content.getvalue()

    def get_function_by_name(self, name) -> PyxFunction:
        for function in self.functions:
            if name == function.name:
                return function
        return None


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


def create_pyx_collection(pyx):
    enum_section = get_sections(pyx, "Enums")[0]
    enum_lines = enum_section.split("\n")
    enums = []
    for line in enum_lines:
        if line == "":
            continue
        
        enum_string = line.split(" = ")[0]
        enums.append(PyxEnum(enum_string))
    
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
    
    return PyxCollection(enums, functions, classes)


def main():
    with open("pygui/core_v2.pyx") as f:
        pyx = f.read()
    
    collection = create_pyx_collection(pyx)
    pyi, py = collection.as_pyi_format()

    with open("pygui/__init__.pyi", "w") as f:
        f.write(pyi)
    
    with open("pygui/__init__.py", "w") as f:
        f.write(py)

if __name__ == "__main__":
    main()
