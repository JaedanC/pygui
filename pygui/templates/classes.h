cdef class _{struct_name}:
    cdef {library_name}.{struct_name}* _ptr
    
    @staticmethod
    cdef _{struct_name} from_ptr({library_name}.{struct_name}* _ptr):
        cdef _{struct_name} wrapper = _{struct_name}.__new__(_{struct_name})
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError('This class cannot be instantiated directly.')

