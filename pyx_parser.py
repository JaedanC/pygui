from __future__ import annotations
from typing import List, Tuple, Any
from io import StringIO
import helpers
import re


class PyxEnum:
    def __init__(self, enum_string: str):
        self.enum_string = enum_string
        self.python_enum_name = enum_string.split(" = ")[0]
    
    def __repr__(self):
        return "Enum({})".format(
            self.enum_string
        )
    
    def as_pyi_format(self):
        return "{}: int".format(
            self.python_enum_name
        )


class PyxFunction:
    def __init__(self, name: str, parameters: str, lines: List[str],
                 use_template=False, return_type=None, active=False):
        self.name: str = name
        self.parameters: str = parameters
        self.impl: List[str] = lines
        self.use_template: bool = use_template
        self.return_type: str = return_type
        self.active: bool = active
    
    def __repr__(self):
        return "Function({}, parameters({}), template={}, return_type={}, active={})".format(
            self.name,
            self.parameters,
            self.use_template,
            self.return_type,
            self.active,
        )
    
    def as_pyi_format(self):
        output = "def {}({}) -> {}: ...".format(
                self.name,
                self.parameters,
                self.return_type
            )
        if self.active:
            return output
        return "# " + output
    
    def as_pyx_format(self):
        return "\n".join(self.impl)

    def merge(self, other: PyxFunction):
        self.parameters = other.parameters
        self.impl = other.impl
        self.use_template = other.use_template
        self.return_type = other.return_type
        self.active = other.active


class PyxField:
    def __init__(self, name: str, lines: List[str], use_template=False,
                 custom_type=None, active=False):
        self.name: str = name
        self.impl: List[str] = lines
        self.use_template: bool = use_template
        self.custom_type: str = custom_type
        self.active: bool = active
    
    def __repr__(self):
        return "Field({}, template={}, type={}, active={})".format(
            self.name,
            self.use_template,
            self.custom_type,
            self.active,
        )
    
    def as_pyi_format(self):
        output = "{}: {}".format(
            self.name,
            self.custom_type
        )
        if self.active:
            return output
        return "# " + output

    def merge(self, other: PyxField):
        self.impl = other.impl
        self.use_template = other.use_template
        self.custom_type = other.custom_type
        self.active = other.active


class PyxClass:
    def __init__(self,name: str, constant_lines: PyxGeneric,
                 methods: List[PyxFunction], fields: List[PyxField]):
        self.name: str = name
        self.constant_lines: PyxGeneric = constant_lines
        self.methods: List[PyxFunction] = methods
        self.fields: List[PyxField] = fields
    
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
        has_active = len([a for a in self.fields + self.methods if a.active]) > 0
        return "class {}:{}".format(
            self.name,
            body.getvalue() if has_body and has_active else " ..."
        )

    
class PyxGeneric:
    def __init__(self, name: str, impl: List[str], use_template=False):
        self.name: str = name
        self.impl: List[str] = impl
        self.use_template: bool = use_template
    
    def merge(self, other: PyxGeneric):
        self.impl = other.impl
        self.use_template = other.use_template
    

class PyxCollection:
    def __init__(self, enums: List[PyxEnum], functions: List[PyxFunction],
                 classes: List[PyxClass], extras: List[PyxGeneric]):
        self.enums: List[PyxEnum] = enums
        self.functions: List[PyxFunction] = functions
        self.classes: List[PyxClass] = classes
        self.extras: List[PyxGeneric] = extras

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

        pyi_content.write("class BoolPtr:\n")
        pyi_content.write("    def __init__(self, initial_value: bool): ...\n\n")

        for enum in self.enums:
            pyi_content.write(enum.as_pyi_format() + "\n")
        pyi_content.write("\n")

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

    def get_mergeable_by_name(self, type_: str, name: str) -> Tuple[str, str, Any]:
        if type_ == "Function":
            for function in self.functions:
                if function.name == name:
                    return ("Function", function.name, function)
        
        if type_ == "Field":
            for class_ in self.classes:
                for field in class_.fields:
                    if class_.name.strip("_") + "." + field.name == name:
                        return ("Field", class_.name + "." + field.name, field)
        
        if type_ == "Method":
            for class_ in self.classes:
                for method in class_.methods:
                    if class_.name.strip("_") + "." + method.name == name:
                        return ("Method", class_.name + "." + method.name, method)
        
        if type_ == "Class Constants":
            for class_ in self.classes:
                if class_.name.strip("_") + "." + class_.constant_lines.name == name:
                    return (
                        "Class Constants",
                        class_.name + "." + class_.constant_lines.name,
                        class_.constant_lines
                    )
        return None

    def apply_merge(self, from_: Tuple[str, str, Any]):
        n_type, n_name, n_mergeable = from_
        _, _, s_mergeable = self.get_mergeable_by_name(n_type, n_name)
        s_mergeable.merge(n_mergeable)

    def as_pyx_format(self, ignore_active_flag_show_regardless=True):
        output = StringIO()
        output.write("# distutils: language = c++\n")
        output.write("# cython: language_level = 3\n")
        output.write("# cython: embedsignature=True\n\n")
        
        imports, constant_functions = self.extras
        output.write("# [Imports]\n")
        output.write("\n".join(imports.impl) + "\n")
        output.write("# [End Imports]\n\n")

        output.write("# [Enums]\n")
        for enum in self.enums:
            output.write(enum.enum_string + "\n")
        output.write("# [End Enums]\n\n")

        output.write("# [Constant Functions]\n")
        output.write("\n".join(constant_functions.impl) + "\n")
        output.write("# [End Constant Functions]\n\n")

        for function in self.functions:
            output.write("# [Function]\n")
            if function.active or ignore_active_flag_show_regardless:
                output.write("\n".join(function.impl) + "\n")
            else:
                output.write(helpers.comment_text("\n".join(function.impl)) + "\n")
            output.write("# [End Function]\n\n")
    
        for class_ in self.classes:
            output.write("# [Class]\n")
            output.write("# [Class Constants]\n")
            output.write("\n".join(class_.constant_lines.impl) + "\n")
            output.write("    # [End Class Constants]\n")

            for field in class_.fields:
                output.write("\n    # [Field]\n")
                if field.active or ignore_active_flag_show_regardless:
                    output.write("\n".join(field.impl) + "\n")
                else:
                    output.write(helpers.comment_text("\n".join(field.impl)) + "\n")
                output.write("    # [End Field]\n")

            for method in class_.methods:
                output.write("\n    # [Method]\n")
                if method.active or ignore_active_flag_show_regardless:
                    output.write("\n".join(method.impl) + "\n")
                else:
                    output.write(helpers.comment_text("\n".join(method.impl)) + "\n")
                output.write("    # [End Method]\n")
            
            output.write("# [End Class]\n\n")
        
        return output.getvalue()

    def get_all_mergable(self) -> List[Tuple[str, str, Any]]:
        mergable = []
        for function in self.functions:
            mergable.append(("Function", function.name, function))
        for class_ in self.classes:
            mergable.append((
                "Class Constants",
                class_.name + "." + class_.constant_lines.name,
                class_.constant_lines
            ))
            for field in class_.fields:
                mergable.append(("Field", class_.name + "." + field.name, field))

            for method in class_.methods:
                mergable.append(("Method", class_.name + "." + method.name, method))
        return mergable


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
    
    if len(found_section) > 0:
        all_sections.append("\n".join(found_section))
    
    return all_sections


def parse_function_options(lines):
    options = {}
    for line in lines:
        line = line.strip()
        found_return_type = re.match(".*\?returns\((.*?)\).*", line)
        if found_return_type is not None and "inferred_type" not in options:
            options["inferred_type"] = found_return_type.group(1) if found_return_type.group(1) != "" else None
        
        found_name = re.match(".*def (.*?)\((.*?)\):", line)
        if found_name is not None and "name" not in options:
            options["name"] = found_name.group(1)
            options["inferred_parameters"] = found_name.group(2)
        
        if "# ?" in line:
            options_found = re.match(".*?# \?(.*?)\((.*)\)", line)
            if options_found is None:
                assert False, "Could not parse option {}".format(line)
            options[options_found.group(1)] = options_found.group(2)
    return options


def create_pyx_collection(pyx):
    enum_section = get_sections(pyx, "Enums")[0]
    enum_lines = enum_section.split("\n")
    enums = []
    for line in enum_lines:
        if line == "":
            continue
        
        enums.append(PyxEnum(line))
    
    functions: List[PyxFunction] = []
    for function in get_sections(pyx, "Function"):
        options = parse_function_options(function.split("\n"))
        return_type = options["inferred_type"]
        assert options["use_template"] in ["True", "False"]
        assert options["active"] in ["True", "False"]

        functions.append(PyxFunction(
            options["name"],
            options["inferred_parameters"],
            function.split("\n"),
            options["use_template"] == "True",
            return_type,
            options["active"] == "True",
        ))
    
    classes: List[PyxClass] = []
    for class_section in get_sections(pyx, "Class"):
        name = None
        for line in class_section.split("\n"):
            name_found = re.match("cdef class (.*?):", line)
            if name_found is not None:
                name = name_found.group(1)
                break
        assert name is not None, "Could not find name for class"

        class_constants_section = get_sections(class_section, "Class Constants")[0]
        class_constants_options = parse_function_options(class_constants_section.split("\n"))
        class_constants = PyxGeneric(
            "Class Constants",
            class_constants_section.split("\n"),
            use_template=class_constants_options["use_template"]
        )

        methods = []
        for method_section in get_sections(class_section, "Method"):
            options = parse_function_options(method_section.split("\n"))
            return_type = options["inferred_type"]
            assert options["use_template"] in ["True", "False"]
            assert options["active"] in ["True", "False"]

            methods.append(PyxFunction(
                options["name"],
                options["inferred_parameters"],
                method_section.split("\n"),
                options["use_template"] == "True",
                return_type,
                options["active"] == "True",
            ))
        
        fields = []
        for field_section in get_sections(class_section, "Field"):
            options = parse_function_options(field_section.split("\n"))
            return_type = options["inferred_type"]
            assert options["use_template"] in ["True", "False"]
            assert options["active"] in ["True", "False"]

            fields.append(PyxField(
                options["name"],
                field_section.split("\n"),
                options["use_template"] == "True",
                return_type,
                options["active"] == "True",
            ))
        
        classes.append(PyxClass(
            name,
            class_constants,
            methods,
            fields
        ))
    
    import_section = get_sections(pyx, "Imports")[0]
    constant_functions_section = get_sections(pyx, "Constant Functions")[0]
    generics = [
        PyxGeneric("Imports", import_section.split("\n")),
        PyxGeneric("Constants", constant_functions_section.split("\n")),
    ]
    
    return PyxCollection(enums, functions, classes, generics)


def main():
    with open("pygui/core_v2.pyx") as f:
        pyx = f.read()
    
    collection = create_pyx_collection(pyx)
    pyi, py = collection.as_pyi_format()

    with open("pygui/__init__.pyi", "w") as f:
        f.write(pyi)
    
    with open("pygui/__init__.py", "w") as f:
        f.write(py)
    
    with open("pygui/core_v2_trial.pyx", "w") as f:
        f.write(collection.as_pyx_format())


if __name__ == "__main__":
    main()
