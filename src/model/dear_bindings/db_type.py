from __future__ import annotations
from typing import Optional
from .interfaces import IType
from enum import Enum, auto


class Kinds(Enum):
    Array = auto()
    Type = auto()
    Pointer = auto()
    Builtin = auto()
    User = auto()
    Other = auto()

    def lookup(string: str):
        return {
            "Array": Kinds.Array,
            "Type": Kinds.Type,
            "Pointer": Kinds.Pointer,
            "Builtin": Kinds.Builtin,
        }.get(string, Kinds.Other)


class Kind:
    def from_json(kind_json: dict, is_function_pointer: bool=False):
        """Kind
        {
            "kind": "Builtin",
            "builtin_type": "char",
            "storage_classes": [
                "const"
            ]
        }
        """
        """Function Pointer Parameter
        {
            "kind": "Type",
            "name": "vp",
            "inner_type": {
                "kind": "Pointer",
                "inner_type": {
                    "kind": "User",
                    "name": "ImGuiViewport"
                }
            }
        }
        """
        """
        {
            "name": "user_data",
            "type": {
                "declaration": "void*",
                "description": {
                    "kind": "Pointer",
                    "inner_type": {
                        "kind": "Builtin",
                        "builtin_type": "void"
                    }
                }
            },
            "is_array": false,
            "is_varargs": false,
            "is_instance_pointer": false
        }
        """
        kind = Kinds.lookup(kind_json["kind"])
        name = kind_json.get("name") or kind_json.get("builtin_type", "").replace("_", " ")
        is_const: bool = "const" in kind_json.get("storage_classes", [])
        
        _type = None
        if is_function_pointer:
            _type = FunctionPointer(kind_json["inner_type"], name)
        elif "inner_type" in kind_json:
            _type = Kind.from_json(kind_json["inner_type"])
        else:
            _type = name
        
        return Kind(kind, _type, name, is_const)

    def __init__(
            self,
            kinds: Kinds,
            _type: Optional[Kind | FunctionPointer | str] = None,
            name: str = None,
            is_const: bool = False,
        ):
        self.name = name
        self.kind = kinds
        self._type = _type or name
        self.name = name
        self.is_const = is_const

    def to_pxd(self, include_const=True):
        const = ""
        if include_const:
            const = "const " if self.is_const else ""
        
        if self.kind == Kinds.Array:
            return "{}{}*".format(
                const,
                self._type.to_pxd(include_const=False),
                # If we could evaluate the bounds then this would be the
                # place to do that. Change the last * to [{}] and add the
                # bounds inbetween. TODO
            )
        elif self.kind == Kinds.Type:
            return "{}{}".format(
                const,
                self._type.to_pxd()
            )
        elif self.kind == Kinds.Pointer:
            return "{}{}*".format(
                const,
                self._type.to_pxd()
            )
        else:
            return "{}{}".format(
                const,
                self._type
            )
    
    def is_array(self):
        return self.kind == Kinds.Array

    def is_function_pointer(self) -> bool:
        return isinstance(self._type, FunctionPointer)
    
    def get_name(self) -> str:
        return self.name


class FunctionPointer:
    def __init__(self, function_ptr_json: dict, function_ptr_name: str):
        function_ptr_json = function_ptr_json["inner_type"]
        self.function_ptr_name = function_ptr_name
        self.return_type = Kind.from_json(function_ptr_json["return_type"])
        self.parameters = [Kind.from_json(a) for a in function_ptr_json["parameters"]]
    
    def to_pxd(self):
        return "{} (*{})({})".format(
            self.return_type.to_pxd(),
            self.function_ptr_name,
            ", ".join((map(lambda x: f"{x.to_pxd()} {x.get_name()}", self.parameters))),
        )


class DearBindingsTypeNew(IType):
    def from_json(type_json: dict):
        """Pointer
        {
            "declaration": "const char*",
            "description": {
                "kind": "Pointer",
                "inner_type": {
                    "kind": "Builtin",
                    "builtin_type": "char",
                    "storage_classes": [
                        "const"
                    ]
                }
            }
        }
        """
        """User
        {
            "declaration": "ImVec2",
            "description": {
                "kind": "User",
                "name": "ImVec2"
            }
        }
        """
        """Builtin
        {
            "declaration": "int",
            "description": {
                "kind": "Builtin",
                "builtin_type": "int"
            }
        }
        """
        """Inner User w/const
        {
            "declaration": "const ImDrawList*",
            "description": {
                "kind": "Pointer",
                "inner_type": {
                    "kind": "User",
                    "name": "ImDrawList",
                    "storage_classes": [
                        "const"
                    ]
                }
            }
        }
        """
        """Array
        {
            "declaration": "float[2]",
            "description": {
                "kind": "Array",
                "bounds": "2",
                "inner_type": {
                    "kind": "Builtin",
                    "builtin_type": "float"
                }
            }
        }
        """
        """Function Pointer
        {
            "declaration": "const char* (*GetClipboardTextFn)(void* user_data)",
            "type_details": {
                "flavour": "function_pointer",
                "return_type": {
                    "declaration": "const char*",
                    "description": {
                        "kind": "Pointer",
                        "inner_type": {
                            "kind": "Builtin",
                            "builtin_type": "char",
                            "storage_classes": [
                                "const"
                            ]
                        }
                    }
                },
                "arguments": [
                    {
                        "name": "user_data",
                        "type": {
                            "declaration": "void*",
                            "description": {
                                "kind": "Pointer",
                                "inner_type": {
                                    "kind": "Builtin",
                                    "builtin_type": "void"
                                }
                            }
                        },
                        "is_array": false,
                        "is_varargs": false,
                        "is_instance_pointer": false
                    }
                ]
            },
            "description": {
                "kind": "Type",
                "name": "GetClipboardTextFn",
                "inner_type": {
                    "kind": "Pointer",
                    "inner_type": {
                        "kind": "Function",
                        "return_type": {
                            "kind": "Pointer",
                            "inner_type": {
                                "kind": "Builtin",
                                "builtin_type": "char",
                                "storage_classes": [
                                    "const"
                                ]
                            }
                        },
                        "parameters": [
                            {
                                "kind": "Type",
                                "name": "user_data",
                                "inner_type": {
                                    "kind": "Pointer",
                                    "inner_type": {
                                        "kind": "Builtin",
                                        "builtin_type": "void"
                                    }
                                }
                            }
                        ]
                    }
                }
            }
        }
        """
        declaration: str = type_json["declaration"]
        is_function_pointer = "type_details" in type_json
        kind: Kind = Kind.from_json(type_json["description"], is_function_pointer)
        return DearBindingsTypeNew(declaration, kind)

    def __init__(self, declaration: str, kind: Kind):
        self.declaration = declaration
        self.kind = kind

    def to_pxd(self) -> str:
        return self.kind.to_pxd()

    def is_function_pointer(self) -> bool:
        return self.kind.is_function_pointer()

    def is_array(self) -> bool:
        return self.kind.is_array()
