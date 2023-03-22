from __future__ import annotations
from diff_match_patch import diff_match_patch
from model_creator import header_model


def main():
    header = header_model("cimgui/generator/output", "ccimgui")

    # Open a backup
    with open("pygui/core_v2.pyx") as f:
        existing_content = f.read()
    
    # Compute the new contents
    changes = header.in_pyx_format()
    
    # Read the template. There should be one, but if there isn't just create a
    # new one.
    try:
        with open("pygui/core_v2_template.pyx") as f:
            third_document = f.read()
    except FileNotFoundError:
        with open("pygui/core_v2_template.pyx", "w") as f:
            f.write(changes)
            return

    # Compute the difference between the two
    dmp = diff_match_patch()
    patches = dmp.patch_make(existing_content, changes)
    new_third_document, successes = dmp.patch_apply(patches, third_document)
    
    # Make no changes unless the patching was all succesful
    if False in successes:
        print("Patch failed. Aborting")
        return
    
    with open("pygui/core_v2_template.pyx", "w") as f:
        f.write(new_third_document)
    
    with open("pygui/core_v2.pyx", "w") as f:
        f.write(changes)

    print("Patched")


if __name__ == "__main__":
    main()
