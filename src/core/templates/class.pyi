#if has_content
class {class_name}:
#else
class {class_name}: ...
#endif
#if has_comment
{class_comment}
#endif
#if has_content
#if has_one_member
#else
    pass
#endif
#endif
