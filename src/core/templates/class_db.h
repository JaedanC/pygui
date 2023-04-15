# ?use_template(False)
cdef class {class_name}:
    cdef {pxd_library_name}.{class_name}* _ptr
    
    @staticmethod
    cdef {class_name} from_ptr({pxd_library_name}.{class_name}* _ptr):
        cdef {class_name} wrapper = {class_name}.__new__({class_name})
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
