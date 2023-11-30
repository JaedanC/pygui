from __future__ import annotations


class Template:
    """Represents a function in a pyx file. Has a specific format to ease with
    creating the function.
    """
    def __init__(self, base_template: str):
        self.base: str = base_template
    
    def set_condition(self, condition: str, value: bool) -> Template:
        """Any conditions in the file will be included or excluded based on
        value. Example:
        
        --------------------
        #if show_this
            print("hello")
        #else
            print("world)
        #endif
        --------------------

        template.set_condition("show_this", True)

        ----- Results ------
            print("hello")
        --------------------
        """
        in_correct_block = False
        in_correct_if_block = False
        in_correct_else_block = False
        if_block_stack = 0
        filtered_lines = []
        for line in self.base.split("\n"):
            line_stripped = line.strip()
            include_this_line = True

            # Custom comments
            if line.startswith("##"):
                include_this_line = False

            if line_stripped.startswith(f"#if {condition}"):
                in_correct_block = True
                in_correct_if_block = True
                include_this_line = False
            
            if in_correct_block and line_stripped.startswith("#if"):
                if_block_stack += 1 
            elif in_correct_block and line_stripped.startswith("#endif"):
                if_block_stack -= 1
            
            if line_stripped.startswith("#else") and in_correct_block and if_block_stack == 1:
                in_correct_else_block = True
                in_correct_if_block = False
                include_this_line = False
            if line_stripped.startswith("#endif") and in_correct_block and if_block_stack == 0:
                in_correct_block = False
                in_correct_else_block = False
                in_correct_if_block = False
                include_this_line = False

            # If we are in the corresponding block
            show_line = (in_correct_if_block and value) or (in_correct_else_block and not value) or not in_correct_block
            if show_line and include_this_line:
                filtered_lines.append(line)
        
        self.base = "\n".join(filtered_lines)
        return self

    def format(self, **kwargs) -> Template:
        """Works like a normal string .format except this does not error if a
        {placeholder} is missing a corresponding =kwargs, or a =kwarg does not match a
        {placeholder}. It's like a "safe" .format.
        """
        # From https://www.programiz.com/python-programming/methods/string/format_map
        class IgnoreMissing(dict):
            def __missing__(self, key):
                return "{" + key + "}"
        try:
            self.base = self.base.format_map(IgnoreMissing(**kwargs))
        except ValueError:
            print(self.base)
            print(kwargs)
            raise ValueError
        return self

    def compile(self) -> str:
        """Compiles the resulting function based on the information provided
        in the constructor and the conditions.

        Returns:
            str: A non-indented template string. May still contain missing
                 {placeholders}
        """
        return self.base

