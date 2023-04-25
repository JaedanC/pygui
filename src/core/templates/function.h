# ?use_template(False)
# ?active(False)
# ?invisible(False)
# ?returns({python_return_type})
def {python_function_name}({python_function_arguments}):
    #if has_comment
{comment}
    #endif
    #if has_additional_lines
{additional_lines}

    #endif
    #if has_return_type
    cdef {return_type} res = {pxd_library_name}.{function_name}({function_arguments})
    return {res}
    #else
    {pxd_library_name}.{function_name}({function_arguments})
    #endif // has_return_type
