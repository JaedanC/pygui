cdef class {struct_name}:
    cdef {library_name}.{struct_name}* _ptr
    
    @staticmethod
    cdef {struct_name} from_ptr({library_name}.{struct_name}* _ptr):
        cdef {struct_name} wrapper = {struct_name}.__new__({struct_name})
        wrapper._ptr = _ptr
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")
