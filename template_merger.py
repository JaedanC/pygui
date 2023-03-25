from __future__ import annotations
from diff_match_patch import diff_match_patch
from model_creator import header_model
from pyx_parser import PyxCollection, PyxFunction, create_pyx_collection
from typing import List
import sys



def uncomment_except(text: str, except_lines: int):
    output = []
    for i, line in enumerate(text.split("\n")):
        if i < except_lines:
            output.append(line)
            continue

        if line.lstrip().startswith("# "):
            line = line.replace("# ", "", 1)
        output.append(line)
    return "\n".join(output)


def patch_failed(message, changes, p, s):
    print(message + " failed. Aborting {} patches".format(len(p)))
    for patch, success in zip(p, s):
        if success:
            continue

        print(patch)
        print()


def patch_sync(
    dmp: diff_match_patch,
    staging_filename: str,
    template_filename: str,
    final_filename: str,
    changed_content: str,
    trial_filename: str,
    attempted_filename: str,
):
    # Open a backup
    with open(staging_filename) as f:
        existing_content = f.read()
    
    # Read the template. There should be one, but if there isn't just create a
    # new one.
    try:
        with open(template_filename) as f:
            template_content = f.read()
    except FileNotFoundError:
        with open(template_filename, "w") as f:
            f.write(changed_content)
            return

    with open(attempted_filename, "w") as f:
        f.write(changed_content)

    # Uncomment the template content to make the patching below more consistent.
    comment_commits = dmp.patch_make(
        uncomment_except(template_content, 3),
        template_content
    )
    # diffs = line_diff(dmp, existing_content, changes)
    # with open("diff.html", "w") as f:
    #     f.write(dmp.diff_prettyHtml(diffs))

    # patches = dmp.patch_make(diffs)

    # Create the patches between the old content and the new.
    commits = dmp.patch_make(existing_content, changed_content)

    # Apply those changes to the templated content.
    template_and_changes_merged, successes = dmp.patch_apply(
        commits, uncomment_except(template_content, 3))
    
    with open("pygui/core_v2_uncommented.pyx", "w") as f:
        f.write(uncomment_except(template_content, 3))

    if False in successes:
        patch_failed(
            "Standard patches",
            changed_content,
            commits,
            successes
        )
        return
    
    template_and_changes_merged, successes = dmp.patch_apply(
        comment_commits,
        template_and_changes_merged
    )
    
    # assert len(successes) == len(comment_patches), "Success: {}, Comment Patches: {}".format(
    #     len(successes), len(comment_patches))
    
    if False in successes:
        patch_failed(
            "Comment patches",
            changed_content,
            comment_commits,
            successes
        )
        return

    if "--try" in sys.argv:
        print("Patch worked. Skipping writes:")
        print(f" - New content -> '{staging_filename}'")
        print(f" - Merged content -> '{template_filename}'")
        print(f" - Merged content -> '{final_filename}'")
        with open(trial_filename, "w") as f:
            f.write(template_and_changes_merged)
        return
    
    with open(staging_filename, "w") as f:
        f.write(changed_content)

    with open(template_filename, "w") as f:
        f.write(template_and_changes_merged)
    
    with open(final_filename, "w") as f:
        f.write(template_and_changes_merged)

    print("Patched:")
    print(f" - New content -> '{staging_filename}'")
    print(f" - Merged content -> '{template_filename}'")
    print(f" - Merged content -> '{final_filename}'")


def line_diff(dmp, text1, text2):
    chars1, chars2, lineArray = dmp.diff_linesToChars(text1, text2);
    diffs = dmp.diff_main(chars1, chars2, False)
    dmp.diff_charsToLines(diffs, lineArray)
    return diffs


def main():
    if len(sys.argv) < 2:
        print("Usage: python template_merger.py <OPTION>")
        print("  --pxd     Will create the pxd file only")
        print("  --try     Will run a trial patch and save the output to a trial file")
        print("  --merge   Patch the core file using the changes")
        return
    
    header = header_model("cimgui/generator/output", "ccimgui")
    
    """
    Steps:
    - Read core_generated.pyx -> existing_generated_content
    - Compute new pyx         -> new_generated_content
    - Read core_template.pyx  -> template_content
    - Convert each content type to a PyxCollection so that they can be compared.
    - Find the fields/functions in the template that do not wish to be used:
        - Thus, override their contents using the new generated content. This
          will delete the templated content. This is by design.
    - Then, for the fields/functions that do want to be used:
        - Compute the patches between the old and new generated content.
        - Apply the patch to the templated version.
        - If the new generated content does not have the function or field then
          add it to the template
    - If any errors occured above, print them out here and return. Do not
      override any files on error.
    - Write the completed template file to core.pyx
    - Write the completed template file to core_template.pyx
    - Write the new_generated_content file to core_generated.pyx
    - Compute the pyi file using the completed template PyxCollection.
    """

    # - Read core_generated.pyx -> existing_generated_content
    # - Compute new pyx         -> new_generated_content
    # - Read core_template.pyx  -> template_content    
    with open("pygui/core_v2.pyx") as f:
        existing_generated_content = f.read()

    new_generated_content = header.in_pyx_format()
    
    try:
        with open("pygui/core_v2_template.pyx") as f:
            template_content = f.read()
    except FileNotFoundError:
        with open("pygui/core_v2_template.pyx", "w") as f:
            f.write(new_generated_content)
            template_content = existing_generated_content
    
    dmp = diff_match_patch()
    # dmp.Match_Distance = 5000
    # dmp.Diff_EditCost = 10
    # dmp.Match_MaxBits = 0
    # dmp.Match_Threshold = 0.8
    # dmp.Diff_Timeout = 0

    # Convert each content type to a PyxCollection so that they can be compared.
    old_collection = create_pyx_collection(existing_generated_content)
    new_collection = create_pyx_collection(new_generated_content)
    template_collection = create_pyx_collection(template_content)

    # Find the fields/functions in the template that do not wish to be used:
    #    Thus, override their contents using the new generated content. This
    #    will delete the templated content. This is by design.
    template_functions_to_be_overridden: List[PyxFunction] = []
    for new_function in new_collection.functions:
        template_function = template_collection.get_function_by_name(f.name)
        if template_function is None or not template_function.use_template:
            template_functions_to_be_overridden.append(new_function)
    
    for template_function in template_collection.functions:
        old_function = old_collection.get_function_by_name(template_function.name)
        new_function = new_collection.get_function_by_name(template_function.name)
        # The function must have been deleted in the output. Let's not delete the
        # function in the template. Maybe the API changed? Let's just keep the
        # template function for now and print a message to the user that this
        # function could not be found in the new content.
        if new_function is None:
            print(f"Function {template_function.name} in template could not be found in the new content")
            template_functions_to_be_overridden.append(template_function)
            continue

        # A completely new function that we have a template for but no existing
        # content for. Let's just tell the user we found it and move on. The
        # function should still be picked up above if the user has correctly
        # set the use_template template on the function.
        if old_function is None:
            print(f"Function {template_function.name} in template has no history. Keeping the template version")
            continue
    
        # This should have already been picked up above. In that case we want
        # this function to be overridden.
        if not template_function.use_template:
            print(f"Skipping {template_function.name}")
            continue
        
        # These are the functions in the template that we need to compute
        # patches for. Compute patches between the old and the new and apply it
        # to the template. Append the computed template to the override list.
        # Let's compute the patches between the old content and the new.
        patches = dmp.patch_make(
            "\n".join(old_function.impl),
            "\n".join(new_function.impl),
        )
        new_template_content = "\n".join(template_function.impl)
        new_template_content, successes = dmp.patch_apply(patches, new_template_content)

        if False in successes:
            print("---------------------------------------------------")
            print("1. Could not apply patch between old:")
            print("\n".join(old_function.impl))
            print("---------------------------------------------------")
            print("2. And the new:")
            print("\n".join(new_function.impl))
            print("---------------------------------------------------")
            print("3. To template:")
            print("\n".join(template_function.impl))
            print("---------------------------------------------------")
            print("4. We got to:")
            print(new_template_content)
            print("---------------------------------------------------")
            continue
        
        template_functions_to_be_overridden.append(PyxFunction(
            template_function.name,
            template_function.parameters,
            new_template_content.split("\n"),
            True, template_function.custom_return_type,
        ))
    
    # for template_function in template_functions_to_be_overridden:
    #     print(template_function)
    
    with open("pygui/core_v2_trial.pyx", "w") as f:
        f.write("from typing import List, Tuple, Any\n\n")
        for template_function in template_functions_to_be_overridden:
            f.write(template_function.as_pyx_format() + "\n\n")


    # The source of truth here is the new_collection as that will have the most
    # recent API changes.

    # with open("pygui/ccimgui.pxd", "w") as f:
    #     f.write(header.in_pxd_format())
    
    # if "--pxd" in sys.argv:
    #     print("Skipping diff")
    #     return
    
    # if "--merge" in sys.argv or "--try" in sys.argv:
    #     dmp = diff_match_patch()
    #     dmp.Match_Distance = 5000
    #     # dmp.Diff_EditCost = 10
    #     # dmp.Match_MaxBits = 0
    #     dmp.Match_Threshold = 0.8
    #     # dmp.Diff_Timeout = 0

    #     # Compute the new contents
    #     changes = header.in_pyx_format()
    #     patch_sync(
    #         dmp,
    #         "pygui/core_v2.pyx",
    #         "pygui/core_v2_template.pyx",
    #         "pygui/core.pyx",
    #         changes,
    #         "pygui/core_v2_trial.pyx",
    #         "pygui/core_v2_attempt.pyx"
    #     )



if __name__ == "__main__":
    main()
