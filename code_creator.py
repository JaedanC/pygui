import json
import re
import keyword 
from typing import Tuple, List


class Parameter:
    def __init__(self):
        self.data_type = None
        self.variable_name = None
    
    def set_data_type(self, data_type: str):
        data_type = data_type.replace("struct", "")
        self.data_type = data_type.strip()
        return self
    
    def set_variable_name(self, name: str):
        if name in keyword.kwlist or name in dir(__builtins__):
            name = name + "_"
        
        
        name = name.replace(",", ", ")
        self.variable_name = name
        return self
    
    def __repr__(self):
        return "Parameter({}, {})".format(
            self.data_type,
            self.variable_name
        )
    
    def as_cython(self):
        # "const " if self.is_const else "",
        return "{}{}".format(
            self.data_type + " " if self.data_type is not None else "",
            self.variable_name
        )

    def as_python(self):
        return "{}{}".format(
            self.variable_name,
            ": " + self.data_type if self.data_type is not None else "",
        )


class Typedef:
    def __init__(self, base, definition):
        self.base = base
        self.definition = definition

    def as_cython(self):
        return "ctypedef {} {}".format(
            self.base,
            self.definition
        )


class Struct:
    def __init__(self):
        self.parameters: List[Parameter] = []
        self.name = None
        self.typedef = None
    
    def add_name(self, name):
        self.name = name
    
    def add_typedef(self, typedef):
        self.typedef = typedef
    
    def add_parameter(self, parameter):
        self.parameters.append(parameter)

    def __repr__(self):
        return "{}{}{}".format(
            ("(typedef " + self.typedef + ") ") if self.typedef is not None else "",
            self.name,
            ":\n\t" + "\n\t".join(list(map(str, self.parameters))) if len(self.parameters) > 0 else ""
        )

    def as_cython(self, indent=4):
        output = ""
        if len(self.parameters) == 0:
            output = indent * " " + "pass\n"
        else:
            for parameter in self.parameters:
                output += "{}{}\n".format(
                    " " * indent,
                    parameter.as_cython()
                )
        return "ctypedef struct {}:\n{}".format(
            self.name,
            output
        )

    def as_cython_forward_declration(self):
        return f"ctypedef struct {self.name}"


class Enum:
    def __init__(self):
        self.values = []
        self.name: str = None

    def add_name(self, name):
        self.name = name

    def add_value(self, value):
        self.values.append(value)

    def as_cython(self, indent=4):
        output = ""
        if len(self.values) == 0:
            output = "pass"
        else:
            for value in self.values:
                output += "{}{}\n".format(
                    " " * indent,
                    value
                )
        return "ctypedef enum {}:\n{}".format(
            self.name,
            output
        )


class Function:
    def __init__(self):
        self.parameters = []
        self.name = None
        self.return_type = None
    
    def add_parameter(self, parameter):
        self.parameters.append(parameter)

    def add_name(self, name):
        self.name = name
    
    def add_return_type(self, _type):
        self.return_type = _type

    def __repr__(self):
        return "{} {}{}".format(
            self.return_type,
            self.name,
            ":\n\t" + "\n\t".join(list(map(str, self.parameters))) if len(self.parameters) > 0 else ""
        )
    
    def as_cython(self):
        return "{} {}({})".format(
            self.return_type,
            self.name,
            ", ".join(map(lambda p: p.as_cython(), self.parameters))
        )
    
    def pythonised_name(self):
        function_name = self.name
        function_name = function_name.replace("ImGui", "Imgui")
        python_style_name = pythonise_string(function_name)
        python_style_name = re.sub("^ig_", "", python_style_name)
        return python_style_name


def reduce_cimgui_h(src) -> str:
    lines: list = src.split("\n")
    if "#ifdef CIMGUI_DEFINE_ENUMS_AND_STRUCTS" not in lines:
        assert False
    
    lines = lines[lines.index("#ifdef CIMGUI_DEFINE_ENUMS_AND_STRUCTS") + 1:]

    def filter_ifdef(lines, define):
        new_lines = []
        seen_rogue_define = False
        for line in lines:
            if seen_rogue_define and line.startswith("#endif"):
                seen_rogue_define = False
                continue
            if line.endswith(define):
                seen_rogue_define = True
                continue

            if seen_rogue_define:
                continue
            
            new_lines.append(line)
        return new_lines

    lines = filter_ifdef(lines, "CIMGUI_DEFINE_ENUMS_AND_STRUCTS")

    lines = list(filter(lambda l: not l.startswith("//"), lines))
    lines = list(filter(lambda l: not l.startswith("#"), lines))
    lines = list(filter(lambda l: not l.startswith("typedef union"), lines))
    lines = list(filter(lambda l: l != "", lines))
    src = "\n".join(lines)

    src = src.replace("va_list", "char*")
    src = src.replace("CONST", "const")
    src = src.replace("FILE", "void*")
    src = re.sub("\s*}\s*", "}", src)
    src = re.sub("\s*{\s*", "{", src)
    src = re.sub("\s*,\s*", ",", src)
    src = re.sub("\s*:.*?;", ";", src) # Remove bitfields
    src = src.replace("CIMGUI_API ", "")
    src = re.sub(" +", " ", src)
    src = src.replace(",...", "") # Remove ellipsis
    
    # Ensures that each statement is on one line
    current_group = ""
    inside_curly_brackets = 0
    groups = []
    for char in src:
        if char == "\n":
            continue
        
        current_group += char
        if char == "{":
            inside_curly_brackets += 1
        elif char == "}":
            inside_curly_brackets -= 1
        
        if char == ";" and inside_curly_brackets == 0:
            groups.append(current_group)
            current_group = ""
            continue
    
    # Sort to make the order correct for a header file
    def custom_sort(row):
        priority_words = [
            "typedef",
            "struct",
        ]

        for i, priority in enumerate(priority_words):
            if row.startswith(priority):
                return (i, row)
        return (len(priority_words), row)
    groups.sort(key=custom_sort)

    src = "\n".join(groups)

    # Expand unions
    union_regex = re.compile("union{(.*?)};")
    for found in union_regex.finditer(src):
        src = src.replace(found.group(0), found.group(1))
    
    # Remove any definitions for enums. I only want the names
    enum_regex = re.compile("(?<=[{,])(.*?)\s*=\s*.*?(?=[,}])")
    for found in enum_regex.finditer(src):
        src = src.replace(found.group(0), found.group(1))

    # Remove any square bracket stuff
    src = re.sub("(\[.*?\])", "", src)

    return src


def parse_reduced_cimgui(src: str) -> \
        Tuple[List[Enum], List[Struct], List[Typedef], List[Function]]:
    def parse_parameter_list(parameter_list: List[str]) -> List[Parameter]:
        field_regex = re.compile("^(.*) (.*?)$")
        function_pointer_regex = re.compile("^([_* a-zA-Z]*)(\(\*.*?\)\(.*\))$")

        parameters = []
        for field in parameter_list:
            field = field.strip()

            # Hardcoded because the spec is different for this one field!! >:[
            if field == "ImFontAtlas*Fonts":
                field = "ImFontAtlas* Fonts"
            
            if field == "void" or field == "" or field == "...":
                continue
        
            # Can't play nice? No const for you
            if field.count("const") > 1:
                field = field.replace("const", "")
            
            # Accounts for function pointers that have const* in them
            # which Cython does not like. It just removes the const in that
            # case.
            func_pointer_found = function_pointer_regex.match(field)
            if func_pointer_found is not None:
                _type = func_pointer_found.group(1)
                name = func_pointer_found.group(2)
                name = name.replace(" const", "")
                name = name.replace(";", "")
            else:
                found = field_regex.match(field)
                if found is None:
                    assert False, "Parameter does not match spec"
                _type = found.group(1)
                name = found.group(2)
            
            parameter = Parameter()
            parameter.set_data_type(_type)
            parameter.set_variable_name(name)
            parameters.append(parameter)
        return parameters
    
    def parameter_split(parameters: str, split_char: str) -> List[str]:
        in_brackets = 0
        groups = []
        current = ""
        for char in parameters:
            if char == "(":
                in_brackets += 1
            if char == ")":
                in_brackets -= 1
            
            if char == split_char and in_brackets == 0:
                groups.append(current)
                current = ""
                continue
            
            current += char
        groups.append(current)
        return groups

    def parse_typedef_lines(typedef_lines: List[str]) -> \
            Tuple[List[Enum], List[Struct], List[Typedef]]:
        enums = []
        enum_regex = re.compile("typedef enum{(.*)}(.*);")

        structs = []
        typedef_struct_regex = re.compile("typedef struct (.*?)(?:{(.*?)}| ).*?;")

        typedefs = []
        typedef_regex = re.compile("typedef ([ _*a-zA-Z0-9]+) (.+?);")
        for line in typedef_lines:
            enum_found = enum_regex.match(line)
            if enum_found is not None:
                values = enum_found.group(1)
                name = enum_found.group(2)

                enum = Enum()
                enum.add_name(name)
                for value in values.split(","):
                    if value == "":
                        continue

                    enum.add_value(value)
                enums.append(enum)
                continue
            
            struct_found = typedef_struct_regex.match(line)
            if struct_found is not None:
                name = struct_found.group(1)
                fields = struct_found.group(2)

                struct = Struct()
                struct.add_name(name)
                if fields is not None:
                    for field in parse_parameter_list(parameter_split(fields, ";")):
                        struct.add_parameter(field)
                structs.append(struct)
                continue
            
            typedef_found = typedef_regex.match(line)
            if typedef_found is not None:
                base = typedef_found.group(1)
                definition = typedef_found.group(2)
                typedefs.append(Typedef(base, definition))
                continue
        
            print(line)
            assert False, "Line did not match spec"
        
        
        def custom_typedef_sort(typedef):
            priority = [
                "int",
                "unsigned",
                "signed",
            ]

            for i, _type in enumerate(priority):
                if typedef.base.startswith(_type):
                    return (i, typedef.base)
            return (len(priority), typedef.base)
        typedefs.sort(key=custom_typedef_sort)
        return enums, structs, typedefs

    def parse_struct_lines(struct_lines: List[str]) -> List[Struct]:
        structs = []
        struct_regex = re.compile("struct (.*?)(?:{(.*)})?;")
        for line in struct_lines:
            found = struct_regex.match(line)
            if found is None:
                print(line)
                assert False, "Line did not match spec"
            
            name = found.group(1)
            fields = found.group(2)
            if fields is None:
                continue

            struct = Struct()
            struct.add_name(name)
            for field in parse_parameter_list(parameter_split(fields, ";")):
                struct.add_parameter(field)
            structs.append(struct)
        return structs

    def parse_function_lines(function_lines: List[str]) -> List[Function]:
        functions = []
        function_regex = re.compile("^(.+) ([^,\n]+?)\((.*?)\);$")
        for line in function_lines:
            found = function_regex.match(line)
            if found is None:
                print(line)
                assert False, "Line did not match spec"
            
            _type = found.group(1)
            name = found.group(2)
            parameter_list = found.group(3)

            function = Function()
            function.add_return_type(_type)
            function.add_name(name)
            for field in parse_parameter_list(parameter_split(parameter_list, ",")):
                function.add_parameter(field)
            functions.append(function)
        return functions
    
    typedef_lines = []
    struct_lines = []
    function_lines = []

    for line in src.split("\n"):
        if line.startswith("typedef"):
            typedef_lines.append(line)
            continue

        if line.startswith("struct"):
            struct_lines.append(line)
            continue
        
        # This is a weird one. I don't think we
        # want any externals coming through...
        if line.startswith("extern"):
            continue
        
        function_lines.append(line)
    
    enums, structs, typedefs = parse_typedef_lines(typedef_lines)
    structs += parse_struct_lines(struct_lines)
    functions = parse_function_lines(function_lines)

    return enums, structs, typedefs, functions


def keep_unique_structs(structs: List[Struct]):
    struct_dict = {}
    for struct in structs:
        if struct.name not in struct_dict:
            struct_dict[struct.name] = struct
            continue
        
        if len(struct.parameters) > len(struct_dict[struct.name].parameters):
            struct_dict[struct.name] = struct
            continue
    return list(struct_dict.values())


def dependency_aware_sort(structs: List[Struct]) -> List[Struct]:
    # First, initialise the dictionary to contain the names of the structs
    # as keys
    dependency_graph = { s.name: [] for s in structs }

    # Then, add the parameters to each struct that is known to be a struct
    # itself. Pointers to structs are okay because we know their size on
    # compilation.
    for struct in structs:
        for parameter in struct.parameters:
            # We know the size of pointers so they
            # can be ignored
            if "*" in parameter.data_type:
                continue

            if parameter.data_type in dependency_graph:
                dependency_graph[struct.name].append(parameter)

    # To improve time complexity, create a lookup between the name of the struct
    # to the struct itself.
    struct_lookup = {}
    for struct in structs:
        struct_lookup[struct.name] = struct

    # Continue to pop structs that have no more dependencies.
    safe_struct_order = []
    while len(dependency_graph) > 0:
        to_remove = []
        for struct_name, parameters in dependency_graph.items():
            if len(parameters) != 0:
                continue

            safe_struct_order.append(struct_lookup[struct_name])
            to_remove.append(struct_name)
        
        for old_struct_name in to_remove:
            dependency_graph.pop(old_struct_name)
        
        # When we find the structs with no dependencies, go and remove themself
        # from the other structs who might be waiting on this one.
        for parameters in dependency_graph.values():
            parameter_to_remove = []
            for parameter in parameters:
                if parameter.data_type in to_remove:
                    parameter_to_remove.append(parameter)
            
            for parameter in parameter_to_remove:
                parameters.remove(parameter)
    return safe_struct_order


def pxd_typedefs(typedefs: List[Typedef]) -> str:
    output = ""
    for typedef in typedefs:
        output += "    {}\n".format(
            typedef.as_cython()
        )
    return output


def pxd_structs_forward_declaration(structs: List[Struct]) -> str:
    output = ""
    for struct in structs:
        output += "    {}\n".format(
            struct.as_cython_forward_declration()
        )
    return output


def pxd_structs(structs: List[Struct]) -> str:
    output = ""
    for struct in structs:
        output += "    {}\n".format(
            struct.as_cython(indent=8)
        )
    return output


def pxd_enums(enums: List[Function]) -> str:
    output = ""
    for enum in enums:
        output += "    {}\n".format(
            enum.as_cython(indent=8)
        )
    return output


def pxd_functions(functions: List[Function]) -> str:
    output = ""
    for function in functions:
        output += "    {}\n".format(function.as_cython())
    return output


def pythonise_string(string: str, make_upper=False) -> str:
    pythonised_string = ""
    for i, char in enumerate(string):
        skip_underscore = True
        if i > 0 and i < len(string) - 1:
            back = string[i - 1]
            forw = string[i + 1]
            skip_underscore = (back.isupper() or back.isnumeric()) \
                          and (forw.isupper() or forw.isnumeric() or forw == "_") or back == "_"
        
        if char == "_":
            skip_underscore = True

        if make_upper:
            if (char.isupper() or char.isnumeric()) and i != 0 and not skip_underscore:
                pythonised_string += "_" + char.upper()
                continue
            pythonised_string += char.upper()
        else:
            if (char.isupper() or char.isnumeric()) and i != 0 and not skip_underscore:
                pythonised_string += "_" + char.lower()
                continue
            pythonised_string += char.lower()
    return pythonised_string


def pyx_enums(enums: List[Enum], extension_name) -> str:
    output = ""
    for enum in enums:
        for value_name in enum.values:
            value_name = value_name.replace("ImGui", "Imgui")
            python_constant_name = pythonise_string(value_name, make_upper=True)
            output += "{} = {}.{}\n".format(
                python_constant_name,
                extension_name,
                value_name
            )
        output += "\n"
    return output


def pyx_functions(functions: List[Function]) -> Tuple[str, None]:
    functions.sort(key=lambda f: f.pythonised_name())
    output = ""

    # Knockout the easy ones first
    for function in functions:
        function: Function
        if function.return_type not in dir(__builtins__) and \
            function.return_type != "void":
            continue
        
        skip = False
        for parameter in function.parameters:
            parameter: Parameter
            if parameter.data_type not in dir(__builtins__) and \
                parameter.data_type != "void":
                skip = True
                break
        
        if skip:
            continue
        
        # Get the easy ones out first
        template = \
        "def {}({}):\n" \
        "    return ccimgui.{}({})\n\n"
        
        output += template.format(
            function.pythonised_name(),
            ", ".join(map(lambda f: f.as_python(), function.parameters)),
            function.name,
            ", ".join(map(lambda f: f.variable_name, function.parameters))
        )
    
    print(output)



def main():
    with open("cimgui/cimgui.h") as f:
        src = f.read()
    
    src = reduce_cimgui_h(src)

    with open("pygui/cimgui_test.h", "w") as f:
        f.write(src)

    enums, structs, typedefs, functions = parse_reduced_cimgui(src)
    structs = keep_unique_structs(structs)
    structs = dependency_aware_sort(structs)


    # with open("pygui/ccimgui.pxd", "w") as f:
    #     f.write("# -*- coding: utf-8 -*-\n")
    #     f.write("# distutils: language = c++\n\n")
    #     f.write("from libcpp cimport bool\n\n")
    #     f.write('cdef extern from "cimgui.h":\n')
    #     f.write(pxd_structs_forward_declaration(structs))
    #     f.write("\n")
    #     f.write(pxd_typedefs(typedefs))
    #     f.write(pxd_enums(enums))
    #     f.write("\n\n")
    #     f.write(pxd_structs(structs))
    #     f.write(pxd_functions(functions))

    with open("pygui/core_test.pyx", "w") as f:
        f.write("import cython\n")
        f.write("from cython.operator import dereference\n\n")
        f.write("from collections import namedtuple\n\n")
        f.write("from . cimport ccimgui\n")
        f.write("from libcpp cimport bool\n")
        f.write("from libc.stdint cimport uintptr_t\n")
        f.write("from cython.view cimport array as cvarray\n")
        f.write("from cpython.version cimport PY_MAJOR_VERSION\n\n")
        f.write(pyx_enums(enums, "ccimgui"))

    pyx_functions(functions)

    # print(pxd_structs_forward_declaration(structs))
    # print(pxd_typedefs(typedefs))
    # print(pxd_enums(enums))
    # print(pxd_structs(structs))


if __name__ == "__main__":
    main()
    # print(dir(__builtins__))
