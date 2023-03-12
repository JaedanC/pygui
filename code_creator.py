import json
import re


class Parameter:
    def __init__(self):
        self.data_type = None
        self.variable_name = None
    
    def set_data_type(self, data_type: str):
        self.data_type = data_type
        return self
    
    def set_variable_name(self, name: str):
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
        self.parameters = []
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
        self.name = None

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


def reduce_cimgui_h(src):
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


def parse_reduced_cimgui(src):
    def parse_parameter_list(parameter_list):
        field_regex = re.compile("^(.*) (.*?)$")

        parameters = []
        for field in parameter_list:
            field = field.strip()

            # Hardcoded because the spec is different for this one field!! >:[
            if field == "ImFontAtlas*Fonts":
                field = "ImFontAtlas* Fonts"
            
            if field == "void" or field == "" or field == "...":
                continue

            found = field_regex.match(field)
            if found is None:
                assert False, "Parameter does not match spec"
            
            parameter = Parameter()
            parameter.set_data_type(found.group(1))
            parameter.set_variable_name(found.group(2))
            parameters.append(parameter)

        return parameters
    
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
                for field in parse_parameter_list(fields.split(";")):
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
        for field in parse_parameter_list(fields.split(";")):
            struct.add_parameter(field)
        structs.append(struct)
    
    functions = []
    function_regex = re.compile("^(.+?) (.+?)\((.*?)\);$")
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
        for field in parse_parameter_list(parameter_list.split(",")):
            function.add_parameter(field)
        functions.append(function)
    

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

    return enums, structs, typedefs, functions


def get_structs(base):
    with open(base + "structs_and_enums.json") as f:
        structs_and_enums = json.load(f)
    
    structs = []
    structs_obj = structs_and_enums["structs"]
    for name, fields_obj in structs_obj.items():
        struct = Struct()
        struct.add_name(name)
        for field_obj in fields_obj:
            parameter = Parameter()

            name = field_obj["name"]
            _type = field_obj["type"]

            # TODO: Could find a way to get each component later
            if "union" in _type:
                continue

            if "(*)" in _type:
                new_type = _type[:_type.find("(*)")]
                _type = _type[_type.find("(*)"):]
                _type = _type.replace("(*)", f"(*{name})")
                name = _type
                _type = new_type
            
            parameter.set_variable_name(name)
            parameter.set_data_type(_type)
            parameter.set_const(parameter.data_type.startswith("const"))
            struct.add_parameter(parameter)
        structs.append(struct)
    
    # Manual additions
    def add_data_struct(structs, name, data_type):
        extra_struct = Struct()
        extra_struct.add_name(name)
        extra_struct.add_parameter(Parameter().set_variable_name("Size").set_data_type("int"))
        extra_struct.add_parameter(Parameter().set_variable_name("Capacity").set_data_type("int"))
        extra_struct.add_parameter(Parameter().set_variable_name("Data").set_data_type(data_type))
        structs.append(extra_struct)

    add_data_struct(structs, "ImVector_ImU32", "ImU32*")
    add_data_struct(structs, "ImVector_ImDrawCmd", "ImDrawCmd*")
    add_data_struct(structs, "ImVector_ImDrawIdx", "ImDrawIdx*")
    add_data_struct(structs, "ImVector_ImU32", "ImU32*")
    add_data_struct(structs, "ImVector_ImDrawListPtr", "ImDrawList**")
    add_data_struct(structs, "ImVector_ImDrawVert", "ImDrawVert*")
    add_data_struct(structs, "ImVector_ImVec2", "ImVec2*")
    add_data_struct(structs, "ImVector_ImVec4", "ImVec4*")
    add_data_struct(structs, "ImVector_ImTextureID", "ImTextureID*")
    add_data_struct(structs, "ImVector_ImDrawChannel", "ImDrawChannel*")
    add_data_struct(structs, "ImVector_float", "float*")
    add_data_struct(structs, "ImVector_ImGuiSettingsHandler", "ImGuiSettingsHandler*")
    add_data_struct(structs, "ImVector_char", "char*")
    add_data_struct(structs, "ImVector_ImGuiDockRequest", "ImGuiDockRequest*")
    add_data_struct(structs, "ImVector_ImGuiDockNodeSettings", "ImGuiDockNodeSettings*")
    add_data_struct(structs, "ImVector_ImGuiWindowPtr", "ImGuiWindow**")
    add_data_struct(structs, "ImVector_unsigned_char", "unsigned char*")
    add_data_struct(structs, "ImVector_ImGuiListClipperData", "ImGuiListClipperData*")
    add_data_struct(structs, "ImVector_ImGuiTableTempData", "ImGuiTableTempData*")
    add_data_struct(structs, "ImVector_ImGuiTable", "ImGuiTable*")
    add_data_struct(structs, "ImPool_ImGuiTable", "ImPoolIdx")
    add_data_struct(structs, "ImVector_ImGuiTabBar", "ImGuiTabBar*")
    add_data_struct(structs, "ImPool_ImGuiTabBar", "ImPoolIdx")
    add_data_struct(structs, "ImVector_ImGuiPtrOrIndex", "ImGuiPtrOrIndex*")
    add_data_struct(structs, "ImVector_ImGuiShrinkWidthItem", "ImGuiShrinkWidthItem*")
    add_data_struct(structs, "ImVector_ImGuiSettingsHandler", "ImGuiSettingsHandler*")
    add_data_struct(structs, "ImChunkStream_ImGuiWindowSettings", "ImVector_char")
    add_data_struct(structs, "ImChunkStream_ImGuiTableSettings", "ImVector_char")
    add_data_struct(structs, "ImVector_ImGuiContextHook", "ImGuiContextHook*")
    add_data_struct(structs, "ImVector_ImGuiInputEvent", "ImGuiInputEvent*")
    add_data_struct(structs, "ImVector_ImWchar", "ImWchar*")
    add_data_struct(structs, "ImVector_ImFontGlyph", "ImFontGlyph*")
    add_data_struct(structs, "ImVector_ImFontPtr", "ImFont**")
    add_data_struct(structs, "ImVector_ImFontAtlasCustomRect", "ImFontAtlasCustomRect*")
    add_data_struct(structs, "ImVector_ImFontConfig", "ImFontConfig*")
    add_data_struct(structs, "ImVector_ImGuiWindowStackData", "ImGuiWindowStackData*")
    add_data_struct(structs, "ImVector_ImGuiColorMod", "ImGuiColorMod*")
    add_data_struct(structs, "ImVector_ImGuiStyleMod", "ImGuiStyleMod*")
    add_data_struct(structs, "ImVector_ImGuiID", "ImGuiID*")
    add_data_struct(structs, "ImVector_ImGuiItemFlags", "ImGuiItemFlags*")
    add_data_struct(structs, "ImVector_ImGuiGroupData", "ImGuiGroupData*")
    add_data_struct(structs, "ImVector_ImGuiPopupData", "ImGuiPopupData*")
    add_data_struct(structs, "ImVector_ImGuiViewportPPtr", "ImGuiViewportP**")
    add_data_struct(structs, "ImVector_ImGuiKeyRoutingData", "ImGuiKeyRoutingData*")
    add_data_struct(structs, "ImVector_ImGuiListClipperRange", "ImGuiListClipperRange*")
    add_data_struct(structs, "ImVector_ImGuiOldColumnData", "ImGuiOldColumnData*")
    add_data_struct(structs, "ImVector_ImGuiPlatformMonitor", "ImGuiPlatformMonitor*")
    add_data_struct(structs, "ImVector_ImGuiViewportPtr", "ImGuiViewport**")
    add_data_struct(structs, "ImVector_ImGuiStackLevelInfo", "ImGuiStackLevelInfo*")
    add_data_struct(structs, "ImVector_ImGuiStoragePair", "ImGuiStoragePair*")
    add_data_struct(structs, "ImVector_ImGuiTabItem", "ImGuiTabItem*")
    add_data_struct(structs, "ImSpan_ImGuiTableColumn", "ImGuiTableColumn*")
    add_data_struct(structs, "ImSpan_ImGuiTableColumnIdx", "ImGuiTableColumnIdx*")
    add_data_struct(structs, "ImSpan_ImGuiTableCellData", "ImGuiTableCellData*")
    add_data_struct(structs, "ImVector_ImGuiTableInstanceData", "ImGuiTableInstanceData*")
    add_data_struct(structs, "ImVector_ImGuiTableColumnSortSpecs", "ImGuiTableColumnSortSpecs*")
    add_data_struct(structs, "ImVector_ImGuiTextRange", "ImGuiTextRange*")
    add_data_struct(structs, "ImVector_int", "int*")
    add_data_struct(structs, "ImVector_ImGuiOldColumns", "ImGuiOldColumns*")
    add_data_struct(structs, "ImVector_ImGuiDockRequest", "ImGuiDockRequest*")
    add_data_struct(structs, "ImVector_ImGuiDockNodeSettings", "ImGuiDockNodeSettings*")

    structs.sort(key=lambda s: s.name)
    return structs


def get_enums(base):
    with open(base + "structs_and_enums.json") as f:
        structs_and_enums = json.load(f)
    
    enums = []
    enums_obj = structs_and_enums["enums"]
    for name, values_obj in enums_obj.items():
        enum = Enum()
        enum.add_name(name)
        for field_obj in values_obj:
            parameter = Parameter()
            parameter.set_variable_name(field_obj["name"])
            enum.add_value(parameter)
        enums.append(enum)
    
    enums.sort(key=lambda s: s.name)
    return enums


def get_functions(base):
    with open(base + "definitions.json") as f:
        definitions = json.load(f)
    
    functions = []
    for name, functions_obj in definitions.items():
        for function_obj in functions_obj:
            if "location" not in function_obj or \
                function_obj["location"].startswith("imgui_internal"):
                continue

            function = Function()
            function.add_name(name)
            for field_obj in function_obj["argsT"]:
                parameter = Parameter()
                parameter.set_variable_name(field_obj["name"])
                parameter.set_data_type(field_obj["type"])
                function.add_parameter(parameter)
            functions.append(function)

    functions.sort(key=lambda f: f.name)
    return functions


def get_typedefs(base):
    with open(base + "typedefs_dict.json") as f:
        typedefs_dict = json.load(f)
    
    typedefs = []
    for definition, base in typedefs_dict.items():
        # We get these from get_structs
        if base.startswith("struct"):
            definition = ""

        # Function pointer
        if "(*)" in base:
            callback_name = definition
            callback_type = base[:base.find("(*)")]
            base = base[base.find("(*)"):]
            base = base.strip(";")
            base = base.replace("(*)", f"(*{callback_name})")
            definition = base
            base = callback_type
        
        # Remove ... in function pointers
        definition = definition.replace(",...", "")

        typedefs.append(Typedef(base, definition))

    # Remove some exceptions

    exception_definitions = [
        "const_iterator",
        "ImBitArrayForNamedKeys",
        "ImFileHandle",
        "iterator",
    ]

    exception_bases = [
        "T"
    ]

    typedefs = list(filter(
        lambda t: t.definition not in exception_definitions, typedefs
    ))
    typedefs = list(filter(
        lambda t: t.base not in exception_bases, typedefs
    ))

    # Add Manual
    typedefs.append(Typedef("void*", "ImFileHandle"))

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
    return typedefs


def pxd_typedefs(typedefs):
    output = ""
    for typedef in typedefs:
        output += "    {}\n".format(
            typedef.as_cython()
        )
    return output


def pxd_structs_forward_declaration(structs):
    output = ""
    for struct in structs:
        output += "    {}\n".format(
            struct.as_cython_forward_declration()
        )
    return output


def pxd_structs(structs):
    struct_dict = {}

    for struct in structs:
        if struct.name not in struct_dict:
            struct_dict[struct.name] = struct
            continue
        
        if len(struct.parameters) > len(struct_dict[struct.name].parameters):
            struct_dict[struct.name] = struct
            continue
    
    structs = list(struct_dict.values())
    structs.sort(key=lambda s: s.name)

    output = ""
    for struct in structs:
        output += "    {}\n".format(
            struct.as_cython(indent=8)
        )
    return output


def pxd_enums(enums):
    output = ""
    for enum in enums:
        output += "    {}\n".format(
            enum.as_cython(indent=8)
        )
    return output


def pxd_functions(functions):
    output = ""
    for function in functions:
        output += "    {}\n".format(function.as_cython())
    return output


def main():
    # base = "cimgui/generator/output/"

    # structs = get_structs(base)
    # enums = get_enums(base)
    # functions = get_functions(base)
    # typedefs = get_typedefs(base)

    with open("cimgui/cimgui.h") as f:
        src = f.read()
    
    src = reduce_cimgui_h(src)

    with open("pygui/cimgui_test.h", "w") as f:
        f.write(src)

    enums, structs, typedefs, functions = parse_reduced_cimgui(src)

    # for function in functions:
    #     print(function)
    
    
    # for typedef in typedefs:
    #     print(typedef.as_cython())

    with open("pygui/ccimgui.pxd", "w") as f:
        f.write("# -*- coding: utf-8 -*-\n")
        f.write("# distutils: language = c++\n\n")
        f.write("from libcpp cimport bool\n\n")
        f.write('cdef extern from "cimgui.h":\n')
        f.write(pxd_structs_forward_declaration(structs))
        f.write("\n")
        f.write(pxd_typedefs(typedefs))
        f.write(pxd_enums(enums))
        f.write("\n\n")
        f.write(pxd_structs(structs))
        f.write(pxd_functions(functions))

    # print(pxd_structs_forward_declaration(structs))
    # print(pxd_typedefs(typedefs))
    # print(pxd_enums(enums))
    # print(pxd_structs(structs))


if __name__ == "__main__":
    main()
