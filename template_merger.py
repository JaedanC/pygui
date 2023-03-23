from __future__ import annotations
from diff_match_patch import diff_match_patch
from model_creator import header_model
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

    with open("pygui/ccimgui.pxd", "w") as f:
        f.write(header.in_pxd_format())
    
    if "--pxd" in sys.argv:
        print("Skipping diff")
        return
    
    if "--merge" in sys.argv or "--try" in sys.argv:
        dmp = diff_match_patch()
        dmp.Match_Distance = 5000
        # dmp.Diff_EditCost = 10
        # dmp.Match_MaxBits = 0
        dmp.Match_Threshold = 0.8
        # dmp.Diff_Timeout = 0

        # Compute the new contents
        changes = header.in_pyx_format()
        patch_sync(
            dmp,
            "pygui/core_v2.pyx",
            "pygui/core_v2_template.pyx",
            "pygui/core.pyx",
            changes,
            "pygui/core_v2_trial.pyx",
            "pygui/core_v2_attempt.pyx"
        )



if __name__ == "__main__":
    main()
