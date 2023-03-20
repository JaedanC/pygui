from __future__ import annotations
import json
import keyword
import re
from io import StringIO
from typing import List, Tuple


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


class Parameter:
    """Represents a CType, name pair. A parameter may also have a default value
    and a size. Size means that that Parameter is an array.
    """

    def __init__(self, name: str, _type: CType, default_value=None, size=1):
        self.name: str = name
        self.type: CType = _type
        self.default_value = default_value
        self.size = size

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


class Function:
    """Represents a non-method function. Functions have a name, return type and
    list of parameters. Struct specific functions (methods) should not use this
    class.
    """

    def __init__(self, name: str, return_type: CType, parameters: List[Parameter]):
        self.name: str = name
        self.parameters: List[Parameter] = parameters
        self.return_type: CType = return_type

    def __repr__(self):
        return "Function({}) -> {}:\n\t{}".format(
            self.name,
            self.return_type.internal_str,
            "\n\t".join([p.__repr__() for p in self.parameters])
        )

    def in_pxd_format(self):
        """Return the Function in *.pxd format
        """
        return "    {} {}({}) except +".format(
            self.return_type.internal_str,
            self.name,
            ", ".join([p.in_pxd_format() for p in self.parameters])
        )


class Method:
    """Represents a struct specific function. Methods can be overloaded.
    Overloaded methods share the same imgui_name. Methods can also be
    constructors or destructors.
    """

    def __init__(self, imgui_name: str, cimgui_name: str, struct_name: str,
                 return_type: CType, parameters: List[Parameter],
                 is_constructor: bool, is_destructor: bool):
        self.imgui_name: str = imgui_name
        self.cimgui_name: str = cimgui_name
        self.struct_name: str = struct_name
        self.return_type: CType = return_type
        self.parameters: List[Parameter] = parameters
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
            ", ".join([p.__repr__() for p in self.parameters])
        )

    def in_pxd_format(self):
        """Return the Method in *.pxd format
        """
        return "    {} {}({}) except +".format(
            self.return_type.internal_str if self.return_type is not None else "void",
            self.cimgui_name,
            ", ".join([p.in_pxd_format() for p in self.parameters])
        )


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

    def __init__(self, structs, enums, typedefs, functions):
        self.structs: List[Struct] = structs
        self.enums: List[Enum] = enums
        self.typedefs: List[Typedef] = typedefs
        self.functions: List[Function] = functions

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
        # TODO:
        pass

    def in_pyi_format(self):
        # TODO:
        pass


def safe_python_name(name: str) -> str:
    """Modifies a string to not be a keyword or built-in function. Not using
    this causes Cython to freak out. This adds an underscore if a conflict is
    found. A new string is returned.
    """
    if name in keyword.kwlist or name in dir(__builtins__):
        name = name + "_"
    return name


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


def header_model(base):
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
                    parameter_name = safe_python_name(parameter_json["name"])
                    if parameter_name == "...":
                        continue

                    default_value = None
                    if parameter_name in function_json["defaults"]:
                        default_value = function_json["defaults"][parameter_name]

                    parameters.append(Parameter(
                        parameter_name,
                        CType(parameter_json["type"]),
                        default_value=default_value
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

                    methods.append(Method(
                        imgui_function_name,
                        cimgui_name,
                        struct_name,
                        return_type,
                        parameters,
                        is_constructor,
                        is_destructor
                    ))
                else:
                    # Function
                    functions.append(Function(
                        cimgui_name,
                        CType(function_json["ret"]),
                        parameters
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
                for parameter in method.parameters:
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
            for parameter in function.parameters:
                if bad_function_pointer in parameter.type.internal_str:
                    failed = True
                    break
            if failed:
                continue
            keep_functions.append(function)
        functions = keep_functions

    return HeaderSpec(structs, enums, typedefs, functions)


def main():
    header = header_model("cimgui/generator/output")

    with open("pygui/ccimgui.pxd", "w") as f:
        f.write(header.in_pxd_format())

    with open("pygui/ccimgui_v2.pxd", "w") as f:
        f.write(header.in_pxd_format())

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
