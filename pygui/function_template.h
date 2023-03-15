
def <function_name>(<parameters>):
#if has_return_type
    cdef <return_type> res == <library_name>.<function_pxd_name>(<function_parameter_names>)
    return res
#else
    <library_name>.<function_pxd_name>(<function_parameter_names>)
#endif