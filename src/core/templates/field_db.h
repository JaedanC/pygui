# ?use_template(False)
# ?active(False)
# ?returns({python_type})
@property
def {field_name}(self):
    cdef {field_type} res = dereference(self._ptr).{cimgui_field_name}
    return {res}
@{field_name}.setter
def {field_name}(self, value: {python_type}):
    dereference(self._ptr).{cimgui_field_name} = {value}
