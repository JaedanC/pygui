#if is_getter
##
@property
def {field_name}(self):
    cdef {field_type} res = dereference(self._ptr).{cimgui_field_name}
    return {res}
##
#else
##
@{field_name}.setter
def {field_name}(self, {python_type} value):
    dereference(self._ptr).{cimgui_field_name} = {value}
##
#endif