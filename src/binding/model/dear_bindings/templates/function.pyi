#if is_static_method
@staticmethod
#endif
#if has_comment
def {function_name}({function_parameters}) -> {function_returns}:
{function_comment}
    pass

#else
def {function_name}({function_parameters}) -> {function_returns}: ...
#endif
