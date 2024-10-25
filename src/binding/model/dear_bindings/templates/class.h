# ?use_template(False)
# ?active(True)
# ?invisible(False)
# ?custom_comment_only(False)
cdef class {class_name}:
    #if has_comment
{comment}
    #endif
    cdef {pxd_library_name}.{class_name}* _ptr
    cdef bool dynamically_allocated
    
    @staticmethod
    cdef {class_name} from_ptr({pxd_library_name}.{class_name}* _ptr):
        if _ptr == NULL:
            return None
        cdef {class_name} wrapper = {class_name}.__new__({class_name})
        wrapper._ptr = _ptr
        wrapper.dynamically_allocated = False
        return wrapper
    
    @staticmethod
    cdef {class_name} from_heap_ptr({pxd_library_name}.{class_name}* _ptr):
        wrapper = {class_name}.from_ptr(_ptr)
        if wrapper is None:
            return None
        wrapper.dynamically_allocated = True
        return wrapper
    
    def __init__(self):
        raise TypeError("This class cannot be instantiated directly.")

    def __hash__(self) -> int:
        if self._ptr == NULL:
            raise RuntimeError("Won't hash a NULL pointer")
        cdef unsigned int ptr_int = <uintptr_t>self._ptr
        return hash(ptr_int)
