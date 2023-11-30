import builtins
import keyword
from io import StringIO


def pythonise_string(string: str, make_upper=False) -> str:
    """
    Converts a string to be snake_case or UPPER_CASE depending on the value
    of make_upper. Returns a new string.
    """

    # Some groupings of uppercase characters are allowed. Each group is only
    # allowed to have one member match.
    exceptions_to_the_rule = [
        ["ID"],
        ["RGBA", "RGB"],
        ["HSV"],
        ["TTY"],
        ["UTF"],
        ["OSX"],
        ["ImGui"],
    ]

    for exception_group in exceptions_to_the_rule:
        for exception in exception_group:
            if exception in string:
                string = string.replace(exception, "_" + exception.lower() + "_")
                break
    
    # Replace last occurance of Ex with _Ex_
    if string.endswith("Ex"):
        string = string[::-1].replace("xE", "_xE_", 1)[::-1]
    
    new_string = StringIO()
    is_upper_streak = 0
    for i, char in enumerate(string):
        if char.isupper():
            is_upper_streak += 1
        else:
            is_upper_streak = 0
        
        if is_upper_streak == 1 and i > 0:
            new_string.write("_")
        
        new_string.write(char)
    underscored_string = new_string.getvalue().strip("_").replace("__", "_")
    if make_upper:
        return underscored_string.upper()
    else:
        return underscored_string.lower()
    


def safe_python_name(name: str, edit_format="{}_") -> str:
    """Modifies a string to not be a keyword or built-in function. Not using
    this causes Cython to freak out. This adds an underscore if a conflict is
    found. A new string is returned.
    """
    conflicting = \
        name in keyword.kwlist \
        or name in dir(builtins) \
        or name in ["format", "in"]
    
    if conflicting:
        name = edit_format.format(name)
    return name
