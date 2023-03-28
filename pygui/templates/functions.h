#if is_constructor
# ?returns({struct_name})
@staticmethod
def {function_name}({parameters}):
    #if has_comment
{comment}
    #endif
    #if has_body_lines
{body_lines}
    #endif
    cdef {return_type} _ptr = {library_name}.{function_pxd_name}({arguments})
    if _ptr is NULL:
        raise MemoryError
    return {struct_name}.from_ptr(_ptr)
##
#else
# ?returns({python_return_type})
def {function_name}({parameters}):
    #if has_comment
{comment}
    #endif
    #if has_body_lines
{body_lines}
    #endif
    #if has_return_type
    cdef {return_type} res = {library_name}.{function_pxd_name}({arguments})
##
        #if has_return_tuple
    return {res}, {return_tuple}
        #else
    return {res}
        #endif // has_return_tuple
##
    #else
    {library_name}.{function_pxd_name}({arguments})
    #endif // has_return_type
#endif // is_method