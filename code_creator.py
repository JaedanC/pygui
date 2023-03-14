from __future__ import annotations
import re
import keyword 
from typing import Tuple, List
from abc import ABC, abstractmethod
from dataclasses import dataclass 


class HeaderSpec:
    def __init__(self, src):
        self.enums: List[Enum] = []
        self.structs: List[Struct] = []
        self.typedefs: List[Typedef] = []
        self.functions: List[Function] = []

        self.reduced_src = HeaderSpec.__reduce_cimgui_h(src)
        self.__parse_reduced_cimgui()

        self.keep_unique_structs()
        self.structs = self.dependency_aware_struct_sort()

    @staticmethod
    def __reduce_cimgui_h(src) -> str:
        lines: List[str] = src.split("\n")
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

        lines = [l for l in lines if not l.startswith("//")]
        lines = [l for l in lines if not l.startswith("#")]
        lines = [l for l in lines if not l.startswith("typedef union")]
        lines = [l for l in lines if not l != ""]
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

    def __parse_reduced_cimgui(self):
        def parse_parameter_list(parameter_list: List[str]) -> List[NormalParameter]:
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
                
                parameters.append(NormalParameter(_type, name))
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
                    enum_values = [v for v in values.split(",") if v != ""]
                    enums.append(Enum(name, enum_values))
                    continue
                
                struct_found = typedef_struct_regex.match(line)
                if struct_found is not None:
                    name = struct_found.group(1)
                    fields = struct_found.group(2)

                    if fields is not None:
                        parameters = parse_parameter_list(parameter_split(fields, ";"))
                        structs.append(Struct(name, parameters))
                    else:
                        structs.append(Struct(name, []))
                    continue
                
                typedef_found = typedef_regex.match(line)
                if typedef_found is not None:
                    base = typedef_found.group(1)
                    definition = typedef_found.group(2)
                    typedefs.append(Typedef(base, definition))
                    continue
            
                print(line)
                assert False, "Line did not match spec"
            
            
            def custom_typedef_sort(typedef: Typedef):
                priority = [
                    "int",
                    "unsigned",
                    "signed",
                ]

                for i, _type in enumerate(priority):
                    if typedef.get_base().startswith(_type):
                        return (i, typedef.get_base())
                return (len(priority), typedef.get_base())
            
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
                
                parameters = parse_parameter_list(parameter_split(fields, ";"))
                structs.append(Struct(name, parameters))
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

                parameters = parse_parameter_list(parameter_split(parameter_list, ","))
                functions.append(Function(_type, name, parameters))
            return functions
        
        typedef_lines = []
        struct_lines = []
        function_lines = []

        for line in self.reduced_src.split("\n"):
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
        
        self.enums, self.structs, self.typedefs = parse_typedef_lines(typedef_lines)
        self.structs += parse_struct_lines(struct_lines)
        self.functions = parse_function_lines(function_lines)

    def keep_unique_structs(self):
        struct_dict = {}
        for struct in self.structs:
            if struct.get_name() not in struct_dict:
                struct_dict[struct.get_name()] = struct
                continue
            
            if len(struct) > len(struct_dict[struct.get_name()]):
                struct_dict[struct.get_name()] = struct
                continue
        
        return list(struct_dict.values())

    def dependency_aware_struct_sort(self):
        # First, initialise the dictionary to contain the names of the structs
        # as keys
        dependency_graph = { s.get_name(): [] for s in self.structs }

        # Then, add the parameters to each struct that is known to be a struct
        # itself. Pointers to structs are okay because we know their size on
        # compilation.
        for struct in self.structs:
            for parameter in struct:
                # We know the size of pointers so they
                # can be ignored
                if "*" in parameter.get_ctype():
                    continue

                if parameter.get_ctype() in dependency_graph:
                    dependency_graph[struct.get_name()].append(parameter)

        # To improve time complexity, create a lookup between the name of the struct
        # to the struct itself.
        struct_lookup = {}
        for struct in self.structs:
            struct_lookup[struct.get_name()] = struct

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
                    parameter: NormalParameter
                    if parameter.get_ctype() in to_remove:
                        parameter_to_remove.append(parameter)
                
                for parameter in parameter_to_remove:
                    parameters.remove(parameter)
        return safe_struct_order


class Parameter(ABC):
    @abstractmethod
    def in_pxd_format(self) -> str:
        pass
    
    @abstractmethod
    def get_name(self) -> str:
        pass

    @abstractmethod
    def in_pyx_python_format(self, enums: List[Enum], typedefs: List[Typedef],
                             library_name: str) -> str:
        pass
    
    @abstractmethod
    def in_pyx_cython_format(self) -> str:
        pass


class CType:
    def __init__(self, _type: str):
        assert _type is not None
        assert _type != ""

        self.internal_str: str = _type.strip().replace("struct", "")

    def __eq__(self, other: CType) -> bool:
        assert isinstance(other, CType)
        return self.internal_str == other.internal_str

    def __repr__(self):
        return f"CType({self.internal_str})"

    def get_ctype(self) -> str:
        return self.internal_str

    def get_standardised_ctype(self, typedefs: List[Typedef]) -> str:
        assert typedefs is not None

        _type = self.internal_str
        _type = re.sub("^const ", "", _type)
        _type = re.sub("^unsigned ", "", _type)
        _type = re.sub("^signed ", "", _type)

        for typedef in typedefs:
            if _type == typedef.get_definition():
                base: CType = typedef.get_base()
                return base.get_standardised_ctype(typedefs)

        return _type

    def in_pxd_format(self):
        return self.get_ctype()

    def in_pyx_cython_format(self, enums: List[Enum], typedefs: List[Typedef], library_name: str) -> str:
        _type = self.get_ctype()
        for enum in enums:
            if _type == enum.get_name():
                assert False, "The enum should be typedef'd instead!"
                return "{}.{}".format(
                    library_name,
                    enum.get_name()
                )
        
        _type = re.sub("^const ", "", _type)
        _type = re.sub("^unsigned ", "", _type)
        _type = re.sub("^signed ", "", _type)
        
        # Is recursive so that we continue to follow any typedefs.
        for typedef in typedefs:
            if _type == typedef.get_definition():
                return typedef.get_base().convert_type_to_pyx_type(enums, typedefs, library_name)
        
        mapping = {
            ("bool"): "bool",
            ("char*"): "str",
            ("double"): "double",
            ("float", "float*"): "float",
            # ("ImVec2"): "",
            ("int", "int*"): "int",
            ("void"): "",
        }

        for types, mapped_to in mapping.items():
            if _type in types:
                return mapped_to

        return None


class FunctionPointerParameter(Parameter):
    def __init__(self, return_type: CType, name: str, fields: List[Parameter | CType]):
        assert return_type is not None
        assert name is not None
        assert fields is not None
        
        self._return_type: CType = return_type
        self._name: str = name
        self._fields: List[Parameter | CType] = fields

    def __repr__(self):
        return "FunctionPointerParameter({}, {}):\n    " + \
            "    \n".join(map(str, self._fields))

    def get_name(self) -> str:
        return self._name

    def in_pxd_format(self):
        raise NotImplementedError()

    def in_pyx_python_format(self, enums: List[Enum], typedefs: List[Typedef],
                             library_name: str):
        raise NotImplementedError()

    def in_pyx_cython_format(self) -> str:
        raise NotImplementedError()


class NormalParameter(Parameter):
    def __init__(self, ctype: CType, name: str):
        assert self._ctype is not None
        assert name is not None
        assert name != ""

        self._ctype: CType = ctype
        self._name: str = name.strip()
        self._name = self._name.replace(",", ", ")

        # Make sure the name does not use a keyword
        if self._name in keyword.kwlist or self._name in dir(__builtins__):
            self._name = self._name + "_"
        
        # Standardise how pointers are shown
        if self._name.startswith("*"):
            self._ctype.internal_str += "*" * self._name.count("*")
            self._name = self._name.replace("*", "")
    
    def __repr__(self):
        return f"NormalParameter({self._ctype}, {self._name})"
    
    def get_name(self) -> str:
        return self._name

    # def get_function_pointer_safe_name(self):
    #     if not self._is_function_pointer():
    #         return self._name
    #     return self._name_if_function_pointer()

    def get_ctype(self) -> CType:
        return self._ctype

    def in_pxd_format(self) -> str:
        return "{} {}".format(self._ctype.in_pxd_format(), self._name)
        # if not self._is_function_pointer():
        
        # function_pointer_regex = re.compile("^\(\*(.*?)\)")
        # found = function_pointer_regex.match(self._name)
        # assert found is not None

        # return found.group(1)

    def in_pyx_python_format(self, enums: List[Enum], typedefs: List[Typedef],
                             library_name: str) -> str:
        assert enums is not None
        assert typedefs is not None
        assert library_name is not None
        assert library_name != ""
        
        # if not self._is_function_pointer():
        pyx_type = self._ctype.in_pyx_cython_format(enums, typedefs, library_name)
        return "{}{}".format(
            self._name,
            ": " + pyx_type if pyx_type is not None else "",
        )
    
        # function_pointer_regex = re.compile("^\(\*(.*?)\)")
        # found = function_pointer_regex.match(self._name)
        # assert found is not None

        # return found.group(1)
    
    def in_pyx_cython_format(self):
        return self.in_pxd_format()
    
    # def _name_if_function_pointer(self):
    #     assert self._is_function_pointer()
    #     function_pointer_regex = re.compile("^\(\*(.*?)\)")
    #     found = function_pointer_regex.match(self._name)
    #     return found.group(1)
    
    # def _is_function_pointer(self):
    #     return self._name.startswith("(*")


class Typedef:
    def __init__(self, base: CType, definition: CType):
        self._base: CType = base
        self._definition: CType = definition

    def get_base(self) -> CType:
        return self._base

    def get_definition(self) -> CType:
        return self._definition

    def in_pxd_format(self) -> str:
        return "ctypedef {} {}".format(
            self._base.in_pxd_format(),
            self._definition.in_pxd_format()
        )


class Struct:
    def __init__(self, name: str, parameters: List[Parameter]):
        self._name: str = name
        self._parameters: List[Parameter] = parameters
    
    def __iter__(self):
        self.i = 0
        return self

    def __next__(self):
        if self.i < len(self._parameters):
            to_return = self._parameters[self.i]
            self.i += 1
            return to_return
        raise StopIteration

    def __repr__(self):
        return "Struct({}):\n\t{}".format(
            self._name,
            "\n\t".join(list(map(str, self._parameters)))
        )

    def __len__(self):
        return len(self._parameters)

    def get_name(self) -> str:
        return self._name

    def get_parameters(self) -> List[Parameter]:
        return self._parameters

    def in_pxd_format(self, indent=4) -> str:
        output = ""
        if len(self._parameters) == 0:
            output = indent * " " + "pass\n"
        else:
            for parameter in self._parameters:
                output += "{}{}\n".format(
                    " " * indent,
                    parameter.in_pxd_format()
                )
        return "ctypedef struct {}:\n{}".format(
            self._name,
            output
        )

    def in_pxd_forward_declaration_format(self) -> str:
        return f"ctypedef struct {self._name}"


class Enum:
    def __init__(self, name: str, values: List[str]):
        self._name: str = name
        self._values: List[str] = values

    def __iter__(self):
        self.i = 0
        return self

    def __next__(self):
        if self.i < len(self._values):
            to_return = self._values[self.i]
            self.i += 1
            return to_return
        raise StopIteration

    def get_name(self) -> str:
        return self._name

    def get_values(self) -> List[str]:
        return self._values

    def in_pxd_format(self, indent=4):
        output = ""
        if len(self._values) == 0:
            output = "pass"
        else:
            for value in self._values:
                output += "{}{}\n".format(
                    " " * indent,
                    value
                )
        return "ctypedef enum {}:\n{}".format(
            self._name,
            output
        )


class Function:
    def __init__(self, return_type: CType, name: str, parameters: List[Parameter]):
        self._return_type: CType = return_type
        self._name: str = name
        self._parameters: List[Parameter] = parameters
    
    def __repr__(self):
        return "Function({}, {}):\n\t{}".format(
            self._return_type,
            self._name,
            "\n\t".join(list(map(str, self._parameters)))
        )
    
    def __iter__(self):
        self.i = 0
        return self
    
    def __next__(self):
        if self.i < len(self._parameters):
            to_return = self._parameters[self.i]
            self.i += 1
            return to_return
        raise StopIteration

    def in_pxd_format(self):
        return "{} {}({})".format(
            self._return_type,
            self._name,
            ", ".join(map(lambda p: p.in_pxd_format(), self._parameters))
        )
    
    def pythonised_name(self):
        function_name = self._name
        function_name = function_name.replace("ImGui", "Imgui")
        python_style_name = pythonise_string(function_name)
        python_style_name = re.sub("^ig_", "", python_style_name)
        return python_style_name

    def in_pyx_format(self, enums, typedefs, library_name):
        template = \
        "def {}({}):\n" \
        "    cdef {} return_value = {}({})\n" \
        "    return return_value\n\n"

        comma_delimited_parameters = ", ".join(map(
            lambda p: p.in_pyx_python_format(enums, typedefs, library_name), self._parameters))

        comma_delimited_parameter_names = ", ".join(map(lambda p: p.get_name(), self._parameters))

        return template.format(
            self.pythonised_name(),
            comma_delimited_parameters,
            self._return_type.get_ctype(),
            library_name + "." + self._name,
            comma_delimited_parameter_names,
        )


def pxd_typedefs(typedefs: List[Typedef]) -> str:
    output = ""
    for typedef in typedefs:
        output += "    {}\n".format(
            typedef.in_pxd_format()
        )
    return output


def pxd_structs_forward_declaration(structs: List[Struct]) -> str:
    output = ""
    for struct in structs:
        output += "    {}\n".format(
            struct.in_pxd_forward_declaration_format()
        )
    return output


def pxd_structs(structs: List[Struct]) -> str:
    output = ""
    for struct in structs:
        output += "    {}\n".format(
            struct.in_pxd_format(indent=8)
        )
    return output


def pxd_enums(enums: List[Enum]) -> str:
    output = ""
    for enum in enums:
        output += "    {}\n".format(enum.in_pxd_format(indent=8))
    return output


def pxd_functions(functions: List[Function]) -> str:
    output = ""
    for function in functions:
        output += "    {}\n".format(function.in_pxd_format())
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
        for value in enum:
            value = value.replace("ImGui", "Imgui")
            python_constant_name = pythonise_string(value, make_upper=True)
            output += "{} = {}.{}\n".format(
                python_constant_name,
                extension_name,
                value
            )
        output += "\n"
    return output


def pyx_classes(): ...


def pyx_functions(
        functions: List[Function],
        enums: List[Enum],
        typedefs: List[Typedef],
        library_name: str) -> Tuple[str, None]:
    functions.sort(key=lambda f: f.pythonised_name())

    output = ""
    for function in functions:
        output += function.in_pyx_format(enums, typedefs, library_name)
    
    return output
            

def main():
    with open("cimgui/cimgui.h") as f:
        src = f.read()
    
    with open("pygui/cimgui.h", "w") as f:
        f.write(src)
    
    header = HeaderSpec(src)

    with open("pygui/cimgui_flat.h", "w") as f:
        f.write(header.reduced_src)

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

    enum_text = pyx_enums(enums, "ccimgui")
    function_text = pyx_functions(functions, enums, typedefs, "ccimgui")

    with open("pygui/core_test.pyx", "w") as f:
        f.write("import cython\n")
        f.write("from cython.operator import dereference\n\n")
        f.write("from collections import namedtuple\n\n")
        f.write("from . cimport ccimgui\n")
        f.write("from libcpp cimport bool\n")
        f.write("from libc.stdint cimport uintptr_t\n")
        f.write("from cython.view cimport array as cvarray\n")
        f.write("from cpython.version cimport PY_MAJOR_VERSION\n\n")
        f.write(enum_text)
        f.write(function_text)

    # print(pxd_structs_forward_declaration(structs))
    # print(pxd_typedefs(typedefs))
    # print(pxd_enums(enums))
    # print(pxd_structs(structs))


if __name__ == "__main__":
    main()
    # print(dir(__builtins__))
