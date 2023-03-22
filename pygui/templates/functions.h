#if is_constructor
# Constructor
@staticmethod
def {function_name}({parameters}):
    #if has_body_lines
{body_lines}
    #endif
    cdef {return_type} _ptr = {library_name}.{function_pxd_name}({arguments})
    if _ptr is NULL:
        raise MemoryError
    return _{struct_name}.from_ptr(_ptr)
##
#else
def {function_name}({parameters}):
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
