from __future__ import annotations
from diff_match_patch import diff_match_patch, patch_obj
from model_creator import header_model
import sys


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
    dmp.Match_MaxBits = 64
    dmp.Diff_Timeout = 0
    dmp.Match_Threshold = 0.5
    patches = dmp.patch_make(existing_content, changes)
    new_third_document, successes = dmp.patch_apply(patches, third_document)
    
    # Make no changes unless the patching was all succesful
    assert len(successes) == len(patches), "Success: {}, Patches: {}".format(
        len(successes), len(patches))
    
    if False in successes:
        print("Patch failed. Aborting {} patches".format(len(patches)))
        # print(patches, successes)
        with open("pygui/core_v2_attempt.pyx", "w") as f:
            f.write(changes)
        
        for patch, success in zip(patches, successes):
            if success:
                continue

            print(patch)
            print()
        return
    
    if "--try" in sys.argv:
        print("Patch worked. Skipping write")
        return
    
    with open("pygui/core_v2_template.pyx", "w") as f:
        f.write(new_third_document)
    
    with open("pygui/core_v2.pyx", "w") as f:
        f.write(changes)
    
    with open("pygui/core.pyx", "w") as f:
        f.write(new_third_document)

    print("Patched")


if __name__ == "__main__":
    main()
