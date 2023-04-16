def uncomment_text(text: str):
    """
    Uncomments all lines as long as the comment is proceeded by spaces only
    """
    output = []
    for line in text.split("\n"):
        if line.lstrip().startswith("# "):
            line = line.replace("# ", "", 1)
        
        output.append(line)
    return "\n".join(output)


def comment_text(text: str):
    """
    Adds a python comment to each line of the string. It tries to insert the
    comment as far to the right as possible in a line, such that no content is
    missed.
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
        output.append(line[:min_spaces] + "# " + line[min_spaces:])
    return "\n".join(output)


def indent_by(text: str, by: int):
    """
    Indents each line of text by 'by' spaces.
    """
    return "\n".join([by * " " + line for line in text.split("\n")])


def pythonise_string(string: str, make_upper=False) -> str:
    """
    Converts a string to be snake_case or UPPER_CASE depending on the value
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


def wrap_text(text, to_size=60) -> str:
    """
    Adds newlines to text such that at least 'to_size' characters are present on
    each line. When a 'to_size' characters are found, the next space will be
    replaced by a newline.
    """
    output = ""
    i = 0
    for char in text:
        if i < to_size:
            output += char
        elif char == " ":
            output += "\n"
            i = 0
        else:
            output += char

        i += 1
    return output

