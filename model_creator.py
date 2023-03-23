from __future__ import annotations
import json
import keyword
import re
from io import StringIO
from typing import List, Tuple



def snake_caseify(string: str, make_upper=False) -> str:
    """Converts a string to be snake_case or UPPER_CASE depending on the value
    of make_upper. Returns a new string.
    """
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


def indent_by(string: str, by: int):
    return "\n".join([by * " " + line for line in string.split("\n")])


def function_body_template(
    header: HeaderSpec,
    parameter_list: ParameterList,
    return_type: CType,
    function_name: str,
    cimgui_function_name: str,
    **kwargs
):
    parameter_tokens = []
    argument_tokens = []
    implementation_lines = []
    to_return_tokens = []

    # Expand array parameters:
    # float value[2] == float value0, float value1
    for parameter in parameter_list:
        parameter_tokens += parameter.in_pyx_type_name_default_format(header)
        argument_tokens += parameter.in_pyx_name_format(header)
        implementation_lines += parameter.implementation_lines
        to_return_tokens += parameter.additional_returns
    
    # This is the string that makes up the return value of the cimgui
    # function call
    has_return_type = return_type is not None and not return_type.is_void()
    res_name = "res"
    return_type_string = ""
    if has_return_type:
        if header.is_type_class(return_type):
            res_name = "_{}.from_ptr(res)".format(return_type.with_no_const_or_asterisk())
        
        if header.is_type_external(return_type):
            return_type_string = header.library_name + "." + return_type.with_no_const()
        else:
            return_type_string = return_type.internal_str

    if len(parameter_tokens) > 5:
        parameter_text = "\n" + indent_by(",\n".join(parameter_tokens), 4) + "\n"
    else:
        parameter_text = ", ".join(parameter_tokens)
    
    if len(argument_tokens) > 5:
        argument_text = "\n" + indent_by(",\n".join(argument_tokens), 8) + "\n    "
    else:
        argument_text = ", ".join(argument_tokens)

    with open("pygui/templates/functions.h") as f:
        template = Template(f.read())

    template.set_condition("has_return_type", has_return_type)
    template.set_condition("has_return_tuple", False)
    template.set_condition("has_body_lines", len(implementation_lines) > 0)

    template.format(
        function_name=function_name,
        parameters=parameter_text,
        body_lines=indent_by("\n".join(implementation_lines), 4),
        return_type=return_type_string,
        library_name=header.library_name,
        function_pxd_name=cimgui_function_name,
        arguments=argument_text,
        res=res_name,
        **kwargs
    )
        
    return template.compile(**kwargs)


class Template:
    """Represents a function in a pyx file. Has a specific format to ease with
    creating the function.
    """
    def __init__(self, base_template: str):
        self.base: str = base_template
    
    def set_condition(self, condition: str, value: bool) -> Template:
        """Any conditions in the file will be included or excluded based on
        value. Example:
        
        --------------------
        #if show_this
            print("hello")
        #else
            print("world)
        #endif
        --------------------

        template.set_condition("show_this", True)

        ----- Results ------
            print("hello")
        --------------------
        """
        in_correct_block = False
        in_correct_if_block = False
        in_correct_else_block = False
        if_block_stack = 0
        filtered_lines = []
        # print()
        # print(condition + " == " + str(value))
        for line in self.base.split("\n"):
            line_stripped = line.strip()
            include_this_line = True

            # Custom comments
            if line.startswith("##"):
                include_this_line = False

            if line_stripped.startswith(f"#if {condition}"):
                in_correct_block = True
                in_correct_if_block = True
                include_this_line = False
            
            if in_correct_block and line_stripped.startswith("#if"):
                if_block_stack += 1 
            elif in_correct_block and line_stripped.startswith("#endif"):
                if_block_stack -= 1
            
            if line_stripped.startswith("#else") and in_correct_block and if_block_stack == 1:
                in_correct_else_block = True
                in_correct_if_block = False
                include_this_line = False
            if line_stripped.startswith("#endif") and in_correct_block and if_block_stack == 0:
                in_correct_block = False
                in_correct_else_block = False
                in_correct_if_block = False
                include_this_line = False

            # If we are in the corresponding block
            show_line = (in_correct_if_block and value) or (in_correct_else_block and not value) or not in_correct_block
            # print(show_line, include_this_line, "\t", line)
            if show_line and include_this_line:
                filtered_lines.append(line)
        
        self.base = "\n".join(filtered_lines)
        return self

    def format(self, **kwargs) -> Template:
        """Works like a normal string .format except this does not error if a
        {placeholder} is missing a corresponding =kwargs, or a =kwarg does not match a
        {placeholder}. It's like a "safe" .format.
        """
        # From https://www.programiz.com/python-programming/methods/string/format_map
        class IgnoreMissing(dict):
            def __missing__(self, key):
                return "{" + key + "}"
            
        self.base = self.base.format_map(IgnoreMissing(**kwargs))
        return self

    def compile(self, **kwargs) -> str:
        """Compiles the resulting function based on the information provided
        in the constructor and the conditions.

        Returns:
            str: A non-indented template string. May still contain missing
                 {placeholders}
        """
        for kwarg, value in kwargs.items():
            self.set_condition(kwarg, value)
        
        self.format(**kwargs)
        return self.base


class CType:
    """
    Represents a type without a name. Can also be a function pointer. Requires
    a Parameter wrapper to be a function pointer.
    """

    def __init__(self, _type: str):
        _type = _type.replace("char* const[]", "char**")
        _type = _type.replace("va_list", "char*")
        self.internal_str: str = _type

    def __repr__(self):
        return "CType({}{})".format(
            "FunctionPointer -> " if self.is_function_pointer() else "",
            self.internal_str
        )

    def is_function_pointer(self):
        """Returns true if the CType is a function pointer.
        """
        return "(*)" in self.internal_str

    def is_pointer(self):
        """Returns true if the CType is a pointer.
        """
        return "*" in self.internal_str
    
    def as_cython_type(self, header: HeaderSpec):
        if self.is_function_pointer():
            return "Callable"
        
        lookup = {
            "void": "None",
            "char*": "str",
            "const char*": "str",
            "float*": "float",
            "float": "float",
            "int": "int",
            "int*": "int",
            "ImVec2": "tuple",
            "const ImVec2": "tuple",
            "ImVec4": "tuple",
            "const ImVec4": "tuple",
        }
        if self.internal_str in lookup:
            return lookup[self.internal_str]
        
        for typedef in header.typedefs:
            if typedef.definition.internal_str == self.internal_str:
                return header.library_name + "." + typedef.definition.internal_str

        return "Any"

    def with_no_const(self):
        return self.internal_str \
            .replace("const ", "")

    def with_no_const_or_asterisk(self):
        return self.with_no_const() \
            .replace("*", "")

    def is_void(self):
        return self.internal_str == "void"


class Parameter:
    """Represents a CType, name pair. A parameter may also have a default value
    and a size. Size means that that Parameter is an array.
    """

    def __init__(self, name: str, _type: CType, default_value=None, size=1):
        if name == "v":
            name = "value"
        self.name: str = name
        self.type: CType = _type
        
        default_lookup = {
            "NULL": "None",
            "true": "True",
            "false": "False",
        }

        if default_value in default_lookup:
            default_value = default_lookup[default_value]
        elif default_value is not None:
            for i in range(10):
                default_value = re.sub(str(i) + "f", str(i), default_value)
            default_value = re.sub("\.f", "", default_value)
            default_value = default_value.replace("ImVec2", "")
            default_value = default_value.replace("ImVec4", "")
            default_value = default_value.replace(",", ", ")

        self.default_value = default_value
        self.size = size

        self.expanded_parameters: List[Parameter] = [ self ]
        self.expanded_arguments: List[str] = [ self.name ]

        self.implementation_lines: List[str] = []
        self.additional_returns: List[str] = []

        if self.size > 1:
            self._expand_parameter()

    def _expand_parameter(self):
        self.expanded_parameters = self.expand_self()
        self.implementation_lines.append("cdef {type}[{size}] io_{type}_{name} = [{expanded_names}]" \
            .format(
                type=self.type.with_no_const_or_asterisk(),
                size=len(self.expanded_parameters),
                name=self.name,
                expanded_names=", ".join([p.name for p in self.expanded_parameters])
            ))

        self.expanded_arguments = ["<{type}*>&io_{type}_{name}".format(
            type=self.type.with_no_const_or_asterisk(),
            name=self.name
        )]

        return_extra = "[{}]"
        argument_return_list = []
        for i in range(len(self.expanded_parameters)):
            argument_return_list.append(
                f"io_{self.type.with_no_const_or_asterisk()}_{self.name}[{i}]"
            )

        self.additional_returns.append(return_extra.format(", ".join(argument_return_list)))

    def __repr__(self):
        return "Param({}, {}){} {}".format(
            self.type.__repr__(),
            self.name,
            f" = {self.default_value}" if self.default_value is not None else "",
            f"size: {self.size}" if self.size > 1 else ""
        )

    def in_pxd_format(self) -> str:
        """Return the Parameter in *.pxd format
        """
        if self.type.is_function_pointer():
            return self.type.internal_str.replace("(*)", f"(*{self.name})")
        return "{} {}{}".format(
            self.type.internal_str,
            self.name,
            f"[{self.size}]" if self.size > 1 else ""
        )
    
    def expand_self(self) -> List[Parameter]:
        """This returns a list of strings because some types have a length. I
        want to unpack these. For example:
        
        float value[3] == "float value0", "float value1", "float value2"
        """
        parameters = []
        for i in range(self.size):
            parameters.append(Parameter(
                self.name + (str(i) if self.size > 1 else ""),
                self.type,
                self.default_value,
                size=1
        ))
        return parameters

    def in_pyx_type_name_default_format(self, header: HeaderSpec) -> List[str]:
        output = []
        for local_parameter in self.expanded_parameters:
            assert not local_parameter.is_array()
            type_string = self.type.as_cython_type(header)

            if header.is_type_class(self.type) and type_string == "Any":
                type_string = "_" + self.type.with_no_const_or_asterisk()
            
            # if type_string == "_ImVec2":
            #     type_string = "bruh"
            
            output.append("{} {}{}".format(
                type_string,
                local_parameter.name,
                "=" + self.default_value if self.default_value is not None else ""
            ))
        return output
    
    def in_pyx_name_format(self, header: HeaderSpec) -> List[str]:
        if self.type.with_no_const() == "ImVec2":
            return [f"_cast_tuple_ImVec2({a})" for a in self.expanded_arguments]
        
        if self.type.with_no_const() == "ImVec4":
            return [f"_cast_tuple_ImVec4({a})" for a in self.expanded_arguments]
        
        if header.is_type_class(self.type):
            return [a + "._ptr" for a in self.expanded_arguments]

        if self.type.as_cython_type(header) == "str":
            return [f"_bytes({a})" for a in self.expanded_arguments]

        return self.expanded_arguments

    def is_array(self) -> bool:
        return self.size > 1
    
    def has_pyx_implementation_lines(self) -> bool:
        return self.implementation_lines > 0

    def has_pyx_additional_returns(self) -> bool:
        return self.additional_returns > 0

    def in_field_pyx_format(self, header: HeaderSpec):
        with open("pygui/templates/fields.h") as f:
            text = f.read()
            getter = Template(text)
            setter = Template(text)

        type_string = self.type.as_cython_type(header)
        res = "res"
        if header.is_type_class(self.type) and type_string == "Any":
            type_string = header.library_name + "." + self.type.with_no_const_or_asterisk()
            res = "_" + self.type.with_no_const_or_asterisk() + ".from_ptr(res)"

        getter.format(
            field_name = snake_caseify(self.name),
            cimgui_field_name = self.name,
            field_type = type_string,
            res = res,
        )

        value = "value"
        if self.type.with_no_const() == "ImVec2":
            value = "_cast_tuple_ImVec2(value)"
        elif self.type.with_no_const() == "ImVec4":
            value = "_cast_tuple_ImVec4(value)"
        elif header.is_type_class(self.type):
            value = "value._ptr"
        elif self.type.as_cython_type(header) == "str":
            return "_bytes(value)"

        python_type = self.type.as_cython_type(header)
        if python_type == "Any":
            python_type = ""

        setter.format(
            field_name = snake_caseify(self.name),
            cimgui_field_name = self.name,
            field_type = type_string,
            res = res,
            value = value,
            python_type = self.type.as_cython_type(header),
        )

        get_func = getter.compile(
            is_getter=True
        )

        set_func = setter.compile(
            is_getter=False
        )

        return indent_by(get_func + "\n" + set_func + "\n", 4)


class ParameterList:
    def __init__(self, parameters: List[Parameter]):
        self.internal_parameters = parameters
    
    def __iter__(self):
        self.i = 0
        return self
    
    def __next__(self):
        if self.i < len(self.internal_parameters):
            to_return = self.internal_parameters[self.i]
            self.i += 1
            return to_return
        raise StopIteration

    def __len__(self):
        return len(self.internal_parameters)

    def in_pxd_format(self):
        return [p.in_pxd_format() for p in self.internal_parameters]


class Typedef:
    """Represents a base -> definition Typedef. Base and defintion are both
    CTypes.
    """

    def __init__(self, base: CType, definition: CType):
        self.base: CType = base
        self.definition: CType = definition

    def __repr__(self):
        return "Typedef(base: {}, {})".format(
            self.base.__repr__(),
            self.definition.__repr__(),
        )

    def in_pxd_format(self) -> str:
        """Return the Typedef in *.pxd format
        """
        return "    ctypedef {} {}".format(
            self.base.internal_str,
            self.definition.internal_str
        )


class Enum:
    """Represents a Enum. This is just a list of strings. Enums will have their
    fixed size included in their name. 

    TODO: Consider changing the list of strings to a list of Parameters.
    """

    def __init__(self, name: str, values: List[str]):
        self.name: str = name
        self.values: List[str] = values

    def __repr__(self):
        return "Enum({}):\n\t{}".format(
            self.name,
            "\n\t".join(self.values)
        )

    def in_pxd_format(self):
        """Return the Enum in *.pxd format
        """
        value_output = StringIO()
        if len(self.values) == 0:
            value_output.write("pass")
        else:
            value_output.write("\n        ".join([v for v in self.values]))
        return "    ctypedef enum {}:\n        {}".format(
            self.name,
            value_output.getvalue()
        )
    
    def in_pyx_format(self, library_name):
        value_output = StringIO()
        for value in self.values:
            snake_value = snake_caseify(value, make_upper=True) \
                .replace("IM_GUI", "IMGUI")
            value_output.write("{} = {}.{}\n".format(
                snake_value,
                library_name,
                value
            ))
        return value_output.getvalue()


class Function:
    """Represents a non-method function. Functions have a name, return type and
    list of parameters. Struct specific functions (methods) should not use this
    class.
    """

    def __init__(self, name: str, return_type: CType, parameters: ParameterList):
        self.name: str = name
        self.parameters: ParameterList = parameters
        self.return_type: CType = return_type

    def __repr__(self):
        return "Function({}) -> {}:\n\t{}".format(
            self.name,
            self.return_type.internal_str,
            "\n\t".join([p.__repr__() for p in self.parameters.internal_parameters])
        )

    def in_pxd_format(self):
        """Return the Function in *.pxd format
        """
        return "    {} {}({}) except +".format(
            self.return_type.internal_str,
            self.name,
            ", ".join(self.parameters.in_pxd_format())
        )
    
    def in_pyx_format(self, header: HeaderSpec):
        return function_body_template(
            header,
            self.parameters,
            self.return_type,
            re.sub("^ig_", "", snake_caseify(self.name)), 
            self.name,
            is_constructor=False
        )


class Method:
    """Represents a struct specific function. Methods can be overloaded.
    Overloaded methods share the same imgui_name. Methods can also be
    constructors or destructors.
    """

    def __init__(self, imgui_name: str, cimgui_name: str, struct_name: str,
                 return_type: CType, parameters: ParameterList,
                 is_constructor: bool, is_destructor: bool):
        self.imgui_name: str = imgui_name
        self.cimgui_name: str = cimgui_name
        self.struct_name: str = struct_name
        self.return_type: CType = return_type
        self.parameters: ParameterList = parameters
        self.is_constructor: bool = is_constructor
        self.is_destructor: bool = is_destructor

    def __repr__(self):
        if self.is_constructor:
            prefix = "@"
        elif self.is_destructor:
            prefix = "~"
        else:
            prefix = self.return_type.internal_str + " "

        return "{}{}({})".format(
            prefix,
            self.cimgui_name,
            ", ".join([p.__repr__() for p in self.parameters.internal_parameters])
        )

    def in_pxd_format(self):
        """Return the Method in *.pxd format
        """
        return "    {} {}({}) except +".format(
            self.return_type.internal_str if self.return_type is not None else "void",
            self.cimgui_name,
            ", ".join(self.parameters.in_pxd_format())
        )
    
    def in_pyx_format(self, header: HeaderSpec):
        function_name = snake_caseify(self.cimgui_name.replace(self.struct_name + "_", ""))
        function_name = safe_python_name(function_name)
        function_name = re.sub("^im_", "", function_name)

        output = function_body_template(
            header,
            self.parameters,
            self.return_type,
            function_name,
            self.cimgui_name,
            is_constructor=self.is_constructor,
            struct_name=self.struct_name
        )
        return indent_by(output, 4)


class Struct:
    """Represents a struct. Structs have a name and a list of parameters.
    Parameters may have a size > 1, which means they are an array.
    """

    def __init__(self, name: str, fields: List[Parameter]):
        self.name: str = name
        self.fields: List[Parameter] = fields
        self.methods: List[Method] = []

    def __repr__(self):
        return "Struct({}):\n\t{}\n\t{}".format(
            self.name,
            "\n\t".join([f.__repr__() for f in self.fields]),
            "\n\t".join([m.__repr__() for m in self.methods])
        )

    def add_method(self, method: Method):
        """Can be used later to assign a Method to this struct.
        """
        self.methods.append(method)

    def sort_methods(self):
        """Sorts the methods so that the constructors and destructor are first.
        """
        to_sort_list = []

        for method in self.methods:
            if method.is_constructor:
                to_sort_list.append((0, method.cimgui_name, method))
                continue

            if method.is_destructor:
                to_sort_list.append((1, method.cimgui_name, method))
                continue

            to_sort_list.append((2, method.cimgui_name, method))

        to_sort_list.sort()
        self.methods = [m[2] for m in to_sort_list]

    def in_pxd_forward_declaration_format(self) -> str:
        """Return the Struct in *.pxd format when you want to do a forward
        declaration of the struct.
        """
        return f"    ctypedef struct {self.name}"

    def in_pxd_format(self) -> str:
        """Return the Struct in *.pxd format
        """
        field_output = StringIO()
        if len(self.fields) == 0:
            field_output.write("        pass\n")
        else:
            for parameter in self.fields:
                field_output.write("        {}\n".format(
                    parameter.in_pxd_format()
                ))
        return "    ctypedef struct {}:\n{}".format(
            self.name,
            field_output.getvalue()
        )


class HeaderSpec:
    """Represents a complete parsed header file. This contains functions to
    output the header file in various formats. Structs, Enums, Typedefs,
    Functions (and Methods) sometimes require each other to perform some
    operations. Thus, this class acts as a wrapper of sorts.
    """

    def __init__(self, structs, enums, typedefs, functions, library_name):
        self.structs: List[Struct] = structs
        self.enums: List[Enum] = enums
        self.typedefs: List[Typedef] = typedefs
        self.functions: List[Function] = functions
        self.library_name: str = library_name

    def in_pxd_format(self):
        """Returns the Header in fully complete *.pxd format for Cython
        """
        output = StringIO()
        output.write("# -*- coding: utf-8 -*-\n")
        output.write("# distutils: language = c++\n\n")
        output.write("from libcpp cimport bool\n\n")
        output.write('cdef extern from "cimgui.h":\n')
        for struct in self.structs:
            output.write(f"{struct.in_pxd_forward_declaration_format()}\n")
        output.write("\n\n")

        for typedef in self.typedefs:
            output.write(f"{typedef.in_pxd_format()}\n")
        output.write("\n\n")

        for enum in self.enums:
            output.write(f"{enum.in_pxd_format()}\n\n")
        output.write("\n\n")

        for struct in self.structs:
            output.write(f"{struct.in_pxd_format()}\n")

        for function in self.functions:
            output.write(f"{function.in_pxd_format()}\n")

        output.write("\n")
        for struct in self.structs:
            for method in struct.methods:
                output.write(f"{method.in_pxd_format()}\n")

        return output.getvalue()

    def in_pyx_format(self):
        output = StringIO()
        output.write("# distutils: language = c++\n")
        output.write("# cython: language_level = 3\n")
        output.write("# cython: embedsignature=True\n\n")

        output.write("")
        output.write("import cython\n")
        output.write("from cython.operator import dereference\n\n")
        output.write("from collections import namedtuple\n")
        output.write("from typing import Callable, Any\n\n")
        output.write("from . cimport ccimgui\n")
        output.write("from libcpp cimport bool\n")
        output.write("from libc.stdint cimport uintptr_t\n")
        output.write("from libc.float cimport FLT_MAX, FLT_MIN\n")
        output.write("from cython.view cimport array as cvarray\n")
        output.write("from cpython.version cimport PY_MAJOR_VERSION\n\n\n")

        for enum in self.enums:
            output.write(enum.in_pyx_format(self.library_name) + "\n")
        output.write("\n")

        output.write("Vec2 = namedtuple('Vec2', ['x', 'y'])\n")
        output.write("Vec4 = namedtuple('Vec4', ['x', 'y', 'z', 'w'])\n\n")

        output.write("cdef bytes _bytes(str text):\n")
        output.write("    return <bytes>(text if PY_MAJOR_VERSION < 3 else text.encode('utf-8'))\n\n")

        output.write("cdef str _from_bytes(bytes text):\n")
        output.write("    return <str>(text if PY_MAJOR_VERSION < 3 else text.decode('utf-8', errors='ignore'))\n\n\n")
        
        output.write(f"cdef _cast_ImVec2_tuple({self.library_name}.ImVec2 vec):\n")
        output.write("    return Vec2(vec.x, vec.y)\n\n")

        output.write(f"cdef {self.library_name}.ImVec2 _cast_tuple_ImVec2(pair) except +:\n")
        output.write(f"    cdef {self.library_name}.ImVec2 vec\n")
        output.write("    if len(pair) != 2:\n")
        output.write("        raise ValueError('pair param must be length of 2')\n")
        output.write("    vec.x, vec.y = pair\n")
        output.write("    return vec\n\n")

        output.write(f"cdef _cast_ImVec4_tuple({self.library_name}.ImVec4 vec):\n")
        output.write("    return Vec4(vec.x, vec.y, vec.z, vec.w)\n\n")

        output.write(f"cdef {self.library_name}.ImVec4 _cast_tuple_ImVec4(quadruple):\n")
        output.write(f"    cdef {self.library_name}.ImVec4 vec\n")
        output.write("    if len(quadruple) != 4:\n")
        output.write("        raise ValueError('quadruple param must be length of 4')\n\n")
        output.write("    vec.x, vec.y, vec.z, vec.w = quadruple\n")
        output.write("    return vec\n\n\n")

        output.write("def _py_vertex_buffer_vertex_pos_offset():\n")
        output.write("    return <uintptr_t><size_t>&(<ccimgui.ImDrawVert*>NULL).pos\n\n")

        output.write("def _py_vertex_buffer_vertex_uv_offset():\n")
        output.write("    return <uintptr_t><size_t>&(<ccimgui.ImDrawVert*>NULL).uv\n\n")

        output.write("def _py_vertex_buffer_vertex_col_offset():\n")
        output.write("    return <uintptr_t><size_t>&(<ccimgui.ImDrawVert*>NULL).col\n\n")

        output.write("def _py_vertex_buffer_vertex_size():\n")
        output.write("    return sizeof(ccimgui.ImDrawVert)\n\n")

        output.write("def _py_index_buffer_index_size():\n")
        output.write("    return sizeof(ccimgui.ImDrawIdx)\n\n\n")

        for function in self.functions:
            output.write(function.in_pyx_format(self) + "\n")
        output.write("\n")
        
        for struct in self.structs:
            with open("pygui/templates/classes.h") as f:
                template = f.read()
            
            output.write(template.format(
                struct_name=struct.name,
                library_name=self.library_name,
            ))

            for method in struct.methods:
                output.write(method.in_pyx_format(self) + "\n")

            for field in struct.fields:
                output.write(field.in_field_pyx_format(self) + "\n")
            output.write("\n")

        return output.getvalue()

    def in_pyi_format(self):
        # TODO:
        pass
    
    def is_type_external(self, _type: CType):
        assert _type is not None
        type_string = _type.with_no_const_or_asterisk()

        if self.is_type_class(_type):
            return True
        
        if type_string in [e.name for e in self.enums]:
            return True
        
        if type_string in [t.definition.internal_str for t in self.typedefs]:
            return True
        
        if type_string == "bool":
            return True
        
        return False

    def is_type_class(self, _type: CType):
        assert _type is not None
        type_string = _type.with_no_const_or_asterisk()

        if type_string in [s.name for s in self.structs]:
            return True


def safe_python_name(name: str, suffix="_") -> str:
    """Modifies a string to not be a keyword or built-in function. Not using
    this causes Cython to freak out. This adds an underscore if a conflict is
    found. A new string is returned.
    """
    if name in keyword.kwlist or name in dir(__builtins__) or name == "format":
        name = name + suffix
    return name


def header_model(base, library_name):
    def parse_structs_and_enums(filename) -> Tuple[List[Struct], List[Enum]]:
        with open(filename) as f:
            model = json.load(f)

        structs_json = model["structs"]
        structs: List[Struct] = []
        for name, fields_list in structs_json.items():
            fields = []
            for field_json in fields_list:
                _type = field_json["type"]
                if _type == "union { int val_i; float val_f; void* val_p;}":
                    fields.append(Parameter("val_i", CType("int")))
                    fields.append(Parameter("val_f", CType("float")))
                    fields.append(Parameter("val_p", CType("void*")))
                    continue

                field_name = safe_python_name(field_json["name"])
                if field_name == "...":
                    continue

                # This means that we need to add an additional data struct to
                # represent this type. This struct does not appear in the .json
                # file.
                if "template_type" in field_json and _type not in [s.name for s in structs]:
                    template_type = field_json["template_type"]
                    template_fields = [
                        Parameter("Size", CType("int")),
                        Parameter("Capacity", CType("int")),
                        Parameter("Data", CType(template_type + "*")),
                    ]
                    structs.append(Struct(_type, template_fields))

                size = 1
                if "size" in field_json:
                    field_name = re.sub("\[.*\]", "", field_name)
                    size = field_json["size"]

                fields.append(Parameter(
                    field_name,
                    CType(_type),
                    size=size
                ))
            structs.append(Struct(name, fields))

        def dependency_aware_struct_sort(structs: List[Struct]):
            # First, initialise the dictionary to contain the names of the structs
            # as keys
            dependency_graph = {s.name: [] for s in structs}

            # Then, add the parameters to each struct that is known to be a struct
            # itself. Pointers to structs are okay because we know their size on
            # compilation.
            for struct in structs:
                for parameter in struct.fields:
                    parameter: Parameter
                    _type: CType = parameter.type

                    # We know the size of pointers so they can be ignored
                    if _type.is_pointer():
                        continue

                    if _type.internal_str in dependency_graph:
                        dependency_graph[struct.name].append(parameter)

            # To improve time complexity, create a lookup between the name of the struct
            # to the struct itself.
            struct_lookup = {s.name: s for s in structs}

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
                        parameter: Parameter
                        if parameter.type.internal_str in to_remove:
                            parameter_to_remove.append(parameter)

                    for parameter in parameter_to_remove:
                        parameters.remove(parameter)
            return safe_struct_order

        structs = dependency_aware_struct_sort(structs)

        enums_json = model["enums"]
        enums = []
        for name, value_list in enums_json.items():
            values = []
            for value_json in value_list:
                value_name = value_json["name"]
                if "size" in value_json:
                    value_name = re.sub("\[.*\]", "", value_name)
                    value_name += "[{}]".format(value_json["size"])

                values.append(value_name)
            enums.append(Enum(name, values))

        enums.sort(key=lambda e: e.name)
        return structs, enums

    def parse_typedefs(structs: List[Struct], filename) -> List[Typedef]:
        with open(filename) as f:
            model = json.load(f)

        typedefs = []
        for definition, base in model.items():
            if base.startswith("struct "):
                potential_struct_name = base.replace("struct ", "")
                if potential_struct_name not in [s.name for s in structs]:
                    structs.append(Struct(potential_struct_name, []))
                continue

            # Ignore these
            # ctypedef T value_type
            # ctypedef const value_type* const_iterator
            # ctypedef value_type* iterator
            ignore_definitions = ["value_type", "const_iterator", "iterator"]
            if definition in ignore_definitions:
                continue

            typedefs.append(Typedef(
                CType(base),
                CType(definition)
            ))

        def custom_typedef_sort(typedef: Typedef):
            priority = [
                "int",
                "unsigned",
                "signed",
            ]

            for i, _type in enumerate(priority):
                if typedef.base.internal_str.startswith(_type):
                    return (i, typedef.base.internal_str)
            return (len(priority), typedef.base.internal_str)

        typedefs.sort(key=custom_typedef_sort)
        return typedefs

    def parse_functions_and_methods(filename) -> Tuple[List[Function], List[Method]]:
        with open(filename) as f:
            model = json.load(f)

        functions = []
        methods = []
        for imgui_function_name, overloads in model.items():
            for function_json in overloads:
                # Parse the parameters of the method/function
                parameters = []
                for parameter_json in function_json["argsT"]:
                    parameter_name = parameter_json["name"]

                    # Extract the default value if there is one
                    default_value = None
                    if parameter_name in function_json["defaults"]:
                        default_value = function_json["defaults"][parameter_name]
                    
                    parameter_name = safe_python_name(parameter_name)
                    if parameter_name == "...":
                        continue


                    # Extracts the float[3] into float and size
                    parameter_type = parameter_json["type"]
                    size = 1
                    found = re.match("^(.*)\[(.*)\].*$", parameter_type)
                    if found is not None and len(found.group(2)) > 0:
                        parameter_type = found.group(1)
                        size = int(found.group(2))

                    parameters.append(Parameter(
                        parameter_name,
                        CType(parameter_type),
                        default_value=default_value,
                        size=size
                    ))

                # ov_cimguiname : the overloaded cimgui name (if absent it would be taken from cimguiname)
                # cimguiname : the name without overloading (this should be used if there is not ov_cimguiname)
                cimgui_name = function_json["cimguiname"]
                if "ov_cimguiname" in function_json:
                    cimgui_name = function_json["ov_cimguiname"]

                if function_json["stname"] != "":
                    # Method
                    is_constructor = "constructor" in function_json
                    is_destructor = "destructor" in function_json
                    struct_name = function_json["stname"]

                    return_type = None
                    if "ret" in function_json:
                        return_type = CType(function_json["ret"])
                    elif is_constructor:
                        return_type = CType(struct_name + "*")

                    methods.append(Method(
                        imgui_function_name,
                        cimgui_name,
                        struct_name,
                        return_type,
                        ParameterList(parameters),
                        is_constructor,
                        is_destructor
                    ))
                else:
                    # Function
                    functions.append(Function(
                        cimgui_name,
                        CType(function_json["ret"]),
                        ParameterList(parameters)
                    ))

        functions.sort(key=lambda f: f.name)
        return functions, methods

    structs, enums = parse_structs_and_enums(base + "/structs_and_enums.json")
    typedefs = parse_typedefs(structs, base + "/typedefs_dict.json")
    functions, methods = parse_functions_and_methods(
        base + "/definitions.json")

    # Pairs the methods to a struct.
    struct_lookup = {s.name: s for s in structs}
    for method in methods:
        try:
            struct_lookup[method.struct_name].add_method(method)
        except KeyError:
            pass

    for struct in structs:
        struct.sort_methods()

    # I want to remove any mention to these
    # // Callback and functions types
    # typedef int     (*ImGuiInputTextCallback)(ImGuiInputTextCallbackData* data);    // Callback function for ImGui::InputText()
    # typedef void    (*ImGuiSizeCallback)(ImGuiSizeCallbackData* data);              // Callback function for ImGui::SetNextWindowSizeConstraints()
    # typedef void*   (*ImGuiMemAllocFunc)(size_t sz, void* user_data);               // Function signature for ImGui::SetAllocatorFunctions()
    # typedef void    (*ImGuiMemFreeFunc)(void* ptr, void* user_data);                // Function signature for ImGui::SetAllocatorFunctions()
    to_remove = [
        "ImDrawCallback",
        "ImGuiInputTextCallback",
        "ImGuiSizeCallback",
        "ImGuiMemAllocFunc",
        "ImGuiMemFreeFunc",
    ]

    for bad_function_pointer in to_remove:
        # Remove any typedefs that mention it
        typedefs = [
            t for t in typedefs if bad_function_pointer not in t.definition.internal_str]

        # Remove any structs that have this as a field.
        for struct in structs:
            struct.fields = [
                p for p in struct.fields if bad_function_pointer not in p.type.internal_str]

            # Remove any methods that reference it.
            keep_methods = []
            for method in struct.methods:
                failed = False
                for parameter in method.parameters.internal_parameters:
                    if bad_function_pointer in parameter.type.internal_str:
                        failed = True
                        break
                if failed:
                    continue
                keep_methods.append(method)
            struct.methods = keep_methods

        # Remove any structs that reference that data that the function pointer would
        # normally return -> Some Data struct.
        structs = [s for s in structs if bad_function_pointer +
                   "Data" not in s.name]

        # Remove any functions that have a callback as a parameter.
        keep_functions = []
        for function in functions:
            failed = False
            for parameter in function.parameters.internal_parameters:
                if bad_function_pointer in parameter.type.internal_str:
                    failed = True
                    break
            if failed:
                continue
            keep_functions.append(function)
        functions = keep_functions

    return HeaderSpec(structs, enums, typedefs, functions, library_name)


def main():
    header = header_model("cimgui/generator/output", "ccimgui")

    with open("pygui/ccimgui.pxd", "w") as f:
        f.write(header.in_pxd_format())

    # with open("pygui/core_v2.pyx", "w") as f:
    #     pyx = header.in_pyx_format()
    #     f.write(pyx)

    # for function in header.functions:
    #     print(function)

    # for struct in header.structs:
    #     print(struct)

    # for enum in enums:
    #     print(enum)

    # for typedef in header.typedefs:
    #     print(typedef)


if __name__ == "__main__":
    main()
