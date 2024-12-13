from __future__ import annotations
import re
import textwrap
import json
from io import StringIO
from typing import List, Tuple, Any

from diff_match_patch import diff_match_patch
from .model.template import Template


def comment_out_text(text: str):
    """
    Adds a python comment to each line of the string. It tries to insert the
    comment as far to the right as possible in a line, such that no content is
    missed. Blank lines are not commented.
    """
    min_spaces = len(text)
    for line in text.split("\n"):
        spaces = 0
        for char in line:
            if char == " ":
                spaces += 1
            else:
                break
        min_spaces = min(spaces, min_spaces)

    output = []
    for line in text.split("\n"):
        if line.strip() == "":
            output.append("")
        else:
            output.append(line[:min_spaces] + "# " + line[min_spaces:])
    return "\n".join(output)


def comparable_options_to_pyx_string(comparable: Any):
    return "\n".join([f"# ?{k}({v})" for k, v in comparable.options.items()])


class PyxHeader:
    def __init__(self, functions: List[PyxFunction], classes: List[PyxClass]):
        self.functions: List[PyxFunction] = functions
        self.classes: List[PyxClass] = classes
        self.sort()
        self._rebuild_comparable()

    def _rebuild_comparable(self):
        self.comparable_lookup = {}
        for function in self.functions:
            self.comparable_lookup[function.name] = function
        for class_ in self.classes:
            self.comparable_lookup[class_.name] = class_
            for field in class_.fields:
                self.comparable_lookup[class_.name + "." + field.name] = field
            for method in class_.methods:
                self.comparable_lookup[class_.name + "." + method.name] = method

    def get_all_comparable_lookups(self) -> List[str]:
        return list(self.comparable_lookup.keys())

    def get_comparable(self, lookup_text):
        if lookup_text in self.comparable_lookup:
            return self.comparable_lookup[lookup_text]

    def copy(self):
        return PyxHeader(
            [f.copy() for f in self.functions],
            [c.copy() for c in self.classes],
        )

    def sort(self):
        self.functions.sort(key=lambda x: x.name)
        self.classes.sort(key=lambda x: x.name)
        for class_ in self.classes:
            class_.fields.sort(key=lambda x: x.name)
            class_.methods.sort(key=lambda x: x.name)

    def add_new_comparable(self, comparable, expected_comparable_string: str):
        if isinstance(comparable, PyxFunction):
            self.functions.append(comparable)
        elif isinstance(comparable, PyxClass):
            self.classes.append(comparable)
        elif isinstance(comparable, PyxClass.Field) or isinstance(comparable, PyxClass.Method):
            # Need to add the comparable to the correct class so we're first
            # going to find the class to add the new field to.
            search_for_class = expected_comparable_string.split(".")[0]
            found_class: PyxClass = self.get_comparable(search_for_class)
            assert found_class is not None, "Can't just add a field/method to a non-existing class"
            if isinstance(comparable, PyxClass.Field):
                found_class.fields.append(comparable)
            elif isinstance(comparable, PyxClass.Method):
                found_class.methods.append(comparable)

        self._rebuild_comparable()
        self.sort()

    def as_pyx(self, ignore_active_flag=False) -> str:
        output = StringIO()

        for function in self.functions:
            output.write("# [Function]\n")
            impl = Template(function.impl) \
                .set_condition("has_comment", function.comment is not None) \
                .compile().replace("__REPLACE_WITH_COMMENT__", textwrap.indent(f'"""\n{function.comment}\n"""', "    "))

            output.write("{}\n{}\n".format(
                comparable_options_to_pyx_string(function),
                impl if comparable_is_active(function) or ignore_active_flag else comment_out_text(impl)
            ))
            output.write("# [End Function]\n\n")

        for class_ in self.classes:
            output.write("# [Class]\n")
            output.write("# [Class Constants]\n")
            impl = Template(class_.impl) \
                .set_condition("has_comment", class_.comment is not None) \
                .compile().replace("__REPLACE_WITH_COMMENT__", textwrap.indent(f'"""\n{class_.comment}\n"""', "    "))

            output.write("{}\n{}\n".format(
                comparable_options_to_pyx_string(class_),
                impl if comparable_is_active(class_) or ignore_active_flag else comment_out_text(impl)
            ))
            output.write("    # [End Class Constants]\n")

            for field in class_.fields:
                output.write("\n    # [Field]\n")
                impl = Template(field.impl) \
                    .set_condition("has_comment", field.comment is not None) \
                    .compile().replace("__REPLACE_WITH_COMMENT__", textwrap.indent(f'"""\n{field.comment}\n"""', "        "))

                output.write("{}\n{}\n".format(
                    textwrap.indent(comparable_options_to_pyx_string(field), "    "),
                    impl if comparable_is_active(field) or ignore_active_flag else comment_out_text(impl)
                ))
                output.write("    # [End Field]\n")

            for method in class_.methods:
                output.write("\n    # [Method]\n")
                impl = Template(method.impl) \
                    .set_condition("has_comment", method.comment is not None) \
                    .compile().replace("__REPLACE_WITH_COMMENT__", textwrap.indent(f'"""\n{method.comment}\n"""', "        "))

                output.write("{}\n{}\n".format(
                    textwrap.indent(comparable_options_to_pyx_string(method), "    "),
                    impl if comparable_is_active(method) or ignore_active_flag else comment_out_text(impl)
                ))
                output.write("    # [End Method]\n")

            output.write("# [End Class]\n\n")
        return output.getvalue()

    def to_pyi(
            self,
            function_template_base: str,
            class_template_base: str,
            field_template_base: str,
            show_comments: bool,
        ) -> str:
        pyi = StringIO()

        for function in self.functions:
            if comparable_is_invisible(function):
                continue

            function_template = Template(function_template_base)
            function_template.set_condition("has_comment", function.comment is not None and show_comments)
            function_template.format(
                function_name=function.name,
                function_parameters=function.parameters,
                function_returns=function.options["returns"],
                function_comment=textwrap.indent(f'"""\n{function.comment}\n"""', "    ")
            )

            if comparable_is_active(function):
                pyi.write(function_template.compile())
            else:
                pyi.write(comment_out_text(function_template.compile()))

        pyi.write("\n")

        for class_ in self.classes:
            if comparable_is_invisible(class_):
                continue

            class_template = Template(class_template_base)
            class_template.set_condition("has_content", class_.has_one_active_member() or class_.comment is not None)
            class_template.set_condition("has_one_member", class_.has_one_active_member())
            class_template.set_condition("has_comment", class_.comment is not None and show_comments)

            class_template.format(
                class_name=class_.name,
                class_comment=textwrap.indent(f'"""\n{class_.comment}\n"""', "    "),
            )
            pyi.write(class_template.compile())

            for field in class_.fields:
                if comparable_is_invisible(field):
                    continue

                field_template = Template(field_template_base)
                field_template.set_condition("has_comment", field.comment is not None and show_comments)
                field_template.format(
                    field_name=field.name,
                    field_type=field.options["returns"],
                    field_comment=f'"""\n{field.comment}\n"""'
                )
                if comparable_is_active(field):
                    pyi.write(textwrap.indent(field_template.compile(), "    "))
                else:
                    pyi.write(textwrap.indent(comment_out_text(field_template.compile()), "    "))

            for method in class_.methods:
                if comparable_is_invisible(method):
                    continue

                method_template = Template(function_template_base)
                method_template.set_condition("has_comment", method.comment is not None and show_comments)
                method_template.format(
                    function_name=method.name,
                    function_parameters=method.parameters,
                    function_returns=method.options["returns"],
                    function_comment=textwrap.indent(f'"""\n{method.comment}\n"""', "    ")
                )

                if comparable_is_active(method):
                    pyi.write(textwrap.indent(method_template.compile(), "    "))
                else:
                    pyi.write(textwrap.indent(comment_out_text(method_template.compile()), "    "))
            pyi.write("\n")

        return pyi.getvalue()


class PyxFunction:
    def __init__(self, name: str, parameters: str, options: dict, impl: str, comment: str):
        self.name: str = name
        self.parameters: str = parameters
        self.options: dict = options
        self.impl: str = impl
        self.comment: str | None = comment

    def copy(self):
        return PyxFunction(
            self.name,
            self.parameters,
            self.options.copy(),
            self.impl,
            self.comment,
        )


class PyxClass:
    class Field:
        def __init__(self, name, options: dict, impl: str, comment: str):
            self.name: str = name
            self.options: dict = options
            self.impl: str = impl
            self.comment: str | None = comment

        def copy(self):
            return PyxClass.Field(
                self.name,
                self.options.copy(),
                self.impl,
                self.comment,
            )

    class Method:
        def __init__(self, name, parameters: str, options: dict, impl: str, comment: str):
            self.name: str = name
            self.parameters: str = parameters
            self.options: dict = options
            self.impl: str = impl
            self.comment: str | None = comment

        def copy(self):
            return PyxClass.Method(
                self.name,
                self.parameters,
                self.options.copy(),
                self.impl,
                self.comment,
            )

    def __init__(self, name, options: dict, impl: str,
                 fields: List[Field], methods: List[Method], comment: str):
        self.name: str = name
        self.options: dict = options
        self.impl: str = impl
        self.fields: List[PyxClass.Field] = fields
        self.methods: List[PyxClass.Method] = methods
        self.comment: str | None = comment

    def has_one_active_member(self):
        for comparable in self.fields + self.methods:
            if comparable_is_active(comparable):
                return True
        return False

    def copy(self):
        return PyxClass(
            self.name,
            self.options.copy(),
            self.impl,
            [f.copy() for f in self.fields],
            [m.copy() for m in self.methods],
            self.comment,
        )


class HeaderComparison:
    def __init__(self, old: PyxHeader, new: PyxHeader):
        self.in_old_missing_in_new = []
        self.in_new_missing_in_old = []
        self.in_both = []
        self.patches_for_old_to_new = {}
        self.old = old
        self.new = new
        self.dmp = diff_match_patch()

        for old_c in self.old.get_all_comparable_lookups():
            new_c = new.get_comparable(old_c)
            if new_c is None:
                print(f"- Could not find {old_c} in the new. Perhaps the API removed a function")
                self.in_old_missing_in_new.append(old_c)
            else:
                self.in_both.append(old_c)

        for new_c in self.new.get_all_comparable_lookups():
            old_c = old.get_comparable(new_c)
            if old_c is None:
                print(f"+ Could not find {new_c} in the old. Perhaps the API added a function")
                self.in_new_missing_in_old.append(new_c)

        for both_c in self.in_both:
            old_obj = old.get_comparable(both_c)
            new_obj = new.get_comparable(both_c)
            assert old_obj is not None
            assert new_obj is not None
            self.create_patch_for(old_obj, new_obj, both_c)

    def create_patch_for(self, old_comparable, new_comparable, comparable_lookup):
        option_patches = self.dmp.patch_make(
            json.dumps(old_comparable.options),
            json.dumps(new_comparable.options)
        )
        impl_patches = self.dmp.patch_make(
            old_comparable.impl,
            new_comparable.impl
        )
        comment_patches = self.dmp.patch_make(
            old_comparable.comment if old_comparable.comment is not None else "",
            new_comparable.comment if new_comparable.comment is not None else ""
        )

        self.patches_for_old_to_new[comparable_lookup] = (option_patches, impl_patches, comment_patches)

    def apply_options_patch_to(self, comparable_lookup: str, write_to_comparable):
        old_obj = self.old.get_comparable(comparable_lookup)
        new_obj = self.new.get_comparable(comparable_lookup)
        option_patches, _, _ = self.patches_for_old_to_new[comparable_lookup]

        if len(option_patches) > 0:
            # print(f"Merging: Patching options for {comparable_lookup}")
            pass

        applied_template_options, results = self.dmp.patch_apply(
            option_patches, json.dumps(write_to_comparable.options))
        # print("Before")
        # print(json.dumps(write_to_comparable.options))
        # print(applied_template_options)
        # print("----------------------")

        success = True
        if not all(results):
            print(f"Failed to apply patch to options in {comparable_lookup}:")
            print("Old options ---------------------------")
            print(old_obj.options)
            print("New implementation ---------------------------")
            print(new_obj.options)
            print("Template implementation ----------------------")
            print(write_to_comparable.options)
            print("We got to ------------------------------------")
            print(applied_template_options)
            success = False
        else:
            # print("----------------------")
            # print(applied_template_options, comparable_lookup)
            # print(option_patches)
            # print(write_to_comparable.options)
            # print(old_obj.options)
            # print(new_obj.options)
            # It should still create valid json but we will see
            write_to_comparable.options = json.loads(applied_template_options)

        return success

    def apply_patch_to(self, comparable_lookup: str, write_to_comparable):
        assert comparable_lookup in self.patches_for_old_to_new
        _, impl_patches, comment_patches = self.patches_for_old_to_new[comparable_lookup]
        old_obj = self.old.get_comparable(comparable_lookup)
        new_obj = self.new.get_comparable(comparable_lookup)

        if len(impl_patches) > 0:
            print(f"Merging: Patching {comparable_lookup}")
        if comment_patches is not None and len(comment_patches) > 0:
            print(f"Merging: Patching comment for {comparable_lookup}")

        success = True
        applied_template_impl, results = self.dmp.patch_apply(impl_patches, write_to_comparable.impl)
        if not all(results):
            print("Failed to apply patch to body:")
            print("Old implementation ---------------------------")
            print(old_obj.impl)
            print("New implementation ---------------------------")
            print(new_obj.impl)
            print("Template implementation ----------------------")
            print(write_to_comparable.impl)
            print("We got to ------------------------------------")
            print(applied_template_impl)
            success = False
        else:
            write_to_comparable.impl = applied_template_impl

        if len(comment_patches) > 0:
            applied_template_comments, results = self.dmp.patch_apply(
                comment_patches,
                write_to_comparable.comment if write_to_comparable.comment is not None else ""
            )

            if not all(results):
                print(f"Failed to apply patch to comments in {comparable_lookup}:")
                print("Old comments ---------------------------------")
                print(old_obj.comment)
                print("New comments ---------------------------------")
                print(new_obj.comment)
                print("Template comments ----------------------------")
                print(write_to_comparable.comment)
                print("We got to ------------------------------------")
                print(applied_template_comments)
                success = False
            else:
                write_to_comparable.comment = applied_template_comments

        return success

    def n_patches(self):
        return len(list(filter(lambda x: len(x) > 0, self.patches_for_old_to_new.values())))

    def create_new_header_based_on_comparison(self, template: PyxHeader):
        merged_template = template.copy()

        success = True
        for new_c in self.new.get_all_comparable_lookups():
            new_obj = self.new.get_comparable(new_c)
            assert new_obj is not None

            tem_obj = template.get_comparable(new_c)
            if tem_obj is None:
                print(f"Merging: New comparable '{new_c}' not found in template. Adding it to the template")
                # Add the new_obj directly to the template here.
                merged_template.add_new_comparable(new_obj, new_c)
                # Sanity check to make sure the new comparable has been added
                assert merged_template.get_comparable(new_c) is not None
                continue

            # This is a copy of the template that we will write to to preserve
            # the original contents in case something goes wrong during patching.
            # If we get to here there should also be a matching merge_obj
            # otherwise something has gone wrong with the copy process.
            merged_obj = merged_template.get_comparable(new_c)
            assert merged_obj is not None

            # We still need to apply the patches to the options so that any
            # changes in the original source file also reflect the options.
            # Currently, we are only patching the options if using_template is
            # true, which doesn't make sense. If old_obj is None then no patches
            # were made so we can keep the template's comment got now.
            old_obj = self.old.get_comparable(new_c)
            if old_obj is not None:
                if not self.apply_options_patch_to(new_c, merged_obj):
                    success = False

            # If the comparable is not using a custom_comment or use_template
            # then we'll reset the comment.
            if not comparable_is_using_template(tem_obj) and \
                not comparable_is_using_custom_comment(tem_obj):
                merged_obj.comment = new_obj.comment

            # If the comparable is not using the template, then reset it back to
            # the implementation in the new. Since we're not changing the options
            # as well then it is possible to activate a function without using
            # the template.
            if not comparable_is_using_template(tem_obj):
                merged_obj.impl = new_obj.impl
                continue

            old_obj = self.old.get_comparable(new_c)
            if old_obj is None:
                # This means that we should just use the template implementation
                # because no patches were created. In this case we can just do
                # nothing.
                print(f"Merging: No impl patches found for '{new_c}'. Keeping template.")
                continue

            assert old_obj is not None

            # Here we have an old implementation, a new implementation and a
            # template with use_template == True. This is where we use the
            # patches generated between the old and the new and apply it to the
            # template.
            # print("Attempting to apply patch to '{}'".format(new_c))
            # old_new_patch = self.patches_for_old_to_new[new_c]

            # Applies the patch to merged_obj. Returns true on success.
            if not self.apply_patch_to(new_c, merged_obj):
                success = False

        for temp_c in merged_template.get_all_comparable_lookups():
            if self.new.get_comparable(temp_c) is None:
                print(f"Merging: Noting standalone comparable in template: '{temp_c}'")

        if success:
            return merged_template
        else:
            return None


def comparable_is_active(comparable: Any):
    options: dict = comparable.options
    if "active" in options:
        return options["active"] == "True"
    return True


def comparable_is_using_template(comparable: Any):
    options: dict = comparable.options
    if "use_template" in options:
        return options["use_template"] == "True"
    return True


def comparable_is_invisible(comparable: Any):
    options: dict = comparable.options
    if "invisible" in options:
        return options["invisible"] == "True"
    return False


def comparable_is_using_custom_comment(comparable: Any):
    options: dict = comparable.options
    if "custom_comment_only" in options:
        return options["custom_comment_only"] == "True"
    return False


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


def create_pyx_model(pyx_src: str) -> PyxHeader:
    def parse_options(src_containing_options: str) -> dict:
        options = {}
        for line in src_containing_options.split("\n"):
            if not line.strip().startswith("# ?"):
                return options

            options_found = re.match(r".*?# \?(.*?)\((.*)\)", line)
            if options_found is None:
                return options

            options[options_found.group(1)] = options_found.group(2)
        return options

    def parse_other_than_options_and_comment(src: str) -> str:
        i = 0
        for i, line in enumerate(src.split("\n")):
            if not line.strip().startswith("# ?"):
                break

        impl = "\n".join(src.split("\n")[i:])

        # Remove the comment and replace it the template syntax
        replace_with = "\n" + \
            "#if has_comment\n" + \
            "__REPLACE_WITH_COMMENT__\n" + \
            "#endif"
        no_comment_impl = re.sub(r'\s*""".*?"""', replace_with, impl, 1, re.DOTALL)
        return no_comment_impl

    def parse_function(src_containing_name: str) -> Tuple[str, str]:
        for line in src_containing_name.split("\n"):
            found_name = re.match(r".*def (.*?)\((.*?)\):", line.strip())

            if found_name is not None:
                # Name, Inferred Parameters
                return found_name.group(1), found_name.group(2)
        assert False

    def parse_class(src_containing_class: str) -> str:
        for line in src_containing_class.split("\n"):
            class_name_found = re.match(r"cdef class (.*?):", line)

            if class_name_found is not None:
                return class_name_found.group(1)
        assert False

    def parse_multiline_comment(src_containing_comment: str) -> str:
        try:
            start_index = src_containing_comment.index('"""')
            end_index = src_containing_comment.index('"""', start_index + 1)
        except ValueError:
            return None

        multiline_comments = textwrap.dedent(src_containing_comment[start_index + 3:end_index])
        multiline_comments = multiline_comments.strip("\n")
        return multiline_comments


    parsed_functions: List[PyxFunction] = []
    for function_src in get_sections(pyx_src, "Function"):
        function_options = parse_options(function_src)
        function_body = parse_other_than_options_and_comment(function_src)
        function_name, function_parameters = parse_function(function_src)
        function_comment = parse_multiline_comment(function_src)
        parsed_functions.append(PyxFunction(
            function_name,
            function_parameters,
            function_options,
            function_body,
            function_comment,
        ))

    parsed_classes: List[PyxClass] = []
    for class_src in get_sections(pyx_src, "Class"):
        class_constants_section = get_sections(class_src, "Class Constants")[0]
        class_constants_options = parse_options(class_constants_section)
        class_constants_body = parse_other_than_options_and_comment(class_constants_section)
        class_name = parse_class(class_constants_section)
        class_comment = parse_multiline_comment(class_src)

        parsed_fields = []
        for class_field in get_sections(class_src, "Field"):
            field_options = parse_options(class_field)
            field_name, _ = parse_function(class_field)
            field_body = parse_other_than_options_and_comment(class_field)
            field_comment = parse_multiline_comment(class_field)
            parsed_fields.append(PyxClass.Field(
                field_name,
                field_options,
                field_body,
                field_comment,
            ))

        parsed_methods = []
        for class_method in get_sections(class_src, "Method"):
            method_options = parse_options(class_method)
            method_name, method_parameters = parse_function(class_method)
            method_body = parse_other_than_options_and_comment(class_method)
            method_comment = parse_multiline_comment(class_method)
            parsed_methods.append(PyxClass.Method(
                method_name,
                method_parameters,
                method_options,
                method_body,
                method_comment,
            ))

        parsed_classes.append(PyxClass(
            class_name,
            class_constants_options,
            class_constants_body,
            parsed_fields,
            parsed_methods,
            class_comment,
        ))

    return PyxHeader(parsed_functions, parsed_classes)


def main():
    with open("core/core_generated_dear_bindings.pyx") as f:
        old_pyx = f.read()

    with open("core/core_generated_dear_bindings_new.pyx") as f:
        new_pyx = f.read()

    with open("core/core_generated_dear_bindings_template.pyx") as f:
        template_pyx = f.read()

    old_model = create_pyx_model(old_pyx)
    new_model = create_pyx_model(new_pyx)
    comparison = HeaderComparison(old_model, new_model)

    template_model = create_pyx_model(template_pyx)
    merged = comparison.create_new_header_based_on_comparison(template_model)

    if merged is None:
        print("Merge failed")


if __name__ == "__main__":
    main()
