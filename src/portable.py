import os
import shutil


def main():
    PORTABLE_SAVE_LOCATION = "../portable"

    # Create the portible pygui installation
    if os.path.exists(PORTABLE_SAVE_LOCATION):
        shutil.rmtree(PORTABLE_SAVE_LOCATION)

    def verbose_copy(start, dest):
        print(f"Creating {dest}")
        return shutil.copy2(start, dest)

    shutil.copytree("deploy/pygui_cython", PORTABLE_SAVE_LOCATION + "/pygui_cython",
        copy_function=verbose_copy,
        ignore=shutil.ignore_patterns(
            "__pycache__",
            "libs",
            "*.ini",
            "*.exe",
    ))
    shutil.copytree("deploy/assets", PORTABLE_SAVE_LOCATION + "/assets",
        copy_function=verbose_copy,
    )

    verbose_copy("deploy/requirements.txt", PORTABLE_SAVE_LOCATION + "/requirements.txt")
    verbose_copy("deploy/app.py",           PORTABLE_SAVE_LOCATION + "/app.py")


if __name__ == "__main__":
    main()
