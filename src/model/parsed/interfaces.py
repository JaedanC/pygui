from abc import ABC, abstractmethod
from typing import List, Optional
from ..comments import Comments
from ..template import Template


class HasComment:
    def get_comment(self) -> Comments:
        pass


class _Type(ABC):
    @abstractmethod
    def to_pxd(self) -> str:
        pass

    @abstractmethod
    def is_function_pointer(self) -> bool:
        pass
    
    @abstractmethod
    def is_array(self) -> bool:
        pass
    
    def with_no_const(self) -> str:
        return self.to_pxd() \
            .replace("const ", "")

    def with_no_const_or_sign(self) -> str:
        return self.with_no_const() \
            .replace("unsigned ", "") \
            .replace("signed ", "")

    def with_no_const_or_asterisk(self) -> str:
        return self.with_no_const() \
            .replace("*", "")

    def is_void_type(self) -> bool:
        return self.to_pxd() == "void"

    def is_string(self) -> bool:
        return self.with_no_const() == "char*"
    
    def is_vec2(self) -> bool:
        return self.with_no_const() == "ImVec2"
    
    def is_vec4(self) -> bool:
        return self.with_no_const() == "ImVec4"

    def ptr_version(self) -> Optional[str]:
        return {
            "bool*": "Bool",
            "int*": "Int",
            "float*": "Float",
            "double*": "Double",
        }.get(self.with_no_const_or_sign())


class Argument(ABC):
    @abstractmethod
    def to_pxd(self) -> str:
        pass

    @abstractmethod
    def get_type(self) -> _Type:
        pass

    @abstractmethod
    def get_name(self) -> str:
        pass

    @abstractmethod
    def get_default_value(self) -> Optional[str]:
        pass


class Function(ABC, HasComment):
    @abstractmethod
    def to_pxd(self) -> str:
        pass

    @abstractmethod
    def get_name(self) -> str:
        pass

    @abstractmethod
    def set_python_name(self, name: str):
        pass

    @abstractmethod
    def get_python_name(self):
        pass


    @abstractmethod
    def get_return_type(self) -> _Type:
        pass

    @abstractmethod
    def get_function_name_no_imgui_prefix(self) -> str:
        pass

    @abstractmethod
    def get_arguments(self) -> List[Argument]:
        pass


class Enum(ABC, HasComment):
    @abstractmethod
    def to_pxd(self) -> str:
        pass

    @abstractmethod
    def to_pyx(self) -> str:
        pass

    @abstractmethod
    def has_element(self, element: str) -> bool:
        pass


class Field(ABC, HasComment):
    @abstractmethod
    def to_pxd(self) -> str:
        pass

    @abstractmethod
    def get_name(self) -> str:
        pass

    @abstractmethod
    def get_type(self) -> _Type:
        pass


class Struct(ABC, HasComment):
    @abstractmethod
    def get_name(self) -> str:
        pass

    @abstractmethod
    def to_pxd(self) -> str:
        pass

    @abstractmethod
    def to_pxd_foward_declaration(self) -> str:
        pass

    @abstractmethod
    def get_fields(self) -> List[Field]:
        pass

    @abstractmethod
    def add_method(self, method: Function):
        pass

    @abstractmethod
    def get_methods(self) -> List[Function]:
        pass


class Typedef(ABC, HasComment):
    @abstractmethod
    def to_pxd(self) -> str:
        pass

    @abstractmethod
    def is_function_pointer(self) -> bool:
        pass

    @abstractmethod
    def get_base(self) -> _Type:
        pass

    @abstractmethod
    def get_definition(self) -> str:
        pass


class Binding(ABC):
    @abstractmethod
    def to_pxd(self) -> str:
        pass

    @abstractmethod
    def to_pyx(self, pxd_library_name: str, include_base: bool) -> str:
        pass

    @abstractmethod
    def function_to_pyx(self, template: Template, function: Function) -> str:
        pass

    @abstractmethod
    def follow_type(self, _type: _Type) -> _Type:
        pass

    @abstractmethod
    def as_python_type(self, _type: _Type) -> str:
        pass

    @abstractmethod
    def as_name_type_default_parameter(self, argument: Argument) -> str:
        pass

    @abstractmethod
    def is_cimgui_type(self, _type: _Type) -> bool:
        pass

    @abstractmethod
    def marshall_c_to_python(self, _type: _Type):
        pass

    @abstractmethod
    def marshall_python_to_c(
            self,
            _type: _Type,
            argument_name: str,
            pxd_library_name: str,
            default_value: Optional[str] = None
        ):
        pass
