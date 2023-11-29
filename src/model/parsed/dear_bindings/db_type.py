from typing import Optional
from ..interfaces import _Type


class DearBindingsTypeNew(_Type):
    class Kind:
        def __init__(self, kind_json: dict, is_function_pointer: bool=False):
            """Kind
            {
                "kind": "Builtin",
                "builtin_type": "char",
                "storage_classes": [
                    "const"
                ]
            }
            """
            self.kind: str = kind_json["kind"]
            self.is_nullable: Optional[bool] = kind_json.get("is_nullable")
            self.is_const: bool = "const" in kind_json.get("storage_classes", [])
            self.bounds: int = kind_json.get("bounds")
            self.name = kind_json.get("name") or kind_json.get("builtin_type", "").replace("_", " ")
            
            self._type = None
            if is_function_pointer:
                self._type = DearBindingsTypeNew.FunctionPointer(kind_json["inner_type"], self.name)
            elif "inner_type" in kind_json:
                self._type = DearBindingsTypeNew.Kind(kind_json["inner_type"])
            else:
                self._type = self.name

        def to_pxd(self, include_const=True):
            const = ""
            if include_const:
                const = "const " if self.is_const else ""
            
            if self.kind == "Array":
                return "{}{}*".format(
                    const,
                    self._type.to_pxd(include_const=False),
                    # If we could evaluate the bounds then this would be the
                    # place to do that. Change the last * to [{}] and add the
                    # bounds inbetween. TODO
                )
            elif self.kind == "Type":
                return "{}{}".format(
                    const,
                    self._type.to_pxd()
                )
            elif self.kind == "Pointer":
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
            return self.kind == "Array"


    class FunctionPointer:
        def __init__(self, function_ptr_json: dict, function_ptr_name: str):
            function_ptr_json = function_ptr_json["inner_type"]
            self.function_ptr_name = function_ptr_name
            self.return_type = DearBindingsTypeNew.Kind(function_ptr_json["return_type"])
            self.parameters = [DearBindingsTypeNew.Kind(a) for a in function_ptr_json["parameters"]]
        
        def to_pxd(self):
            return "{} (*{})({})".format(
                self.return_type.to_pxd(),
                self.function_ptr_name,
                ", ".join((map(lambda x: f"{x.to_pxd()} {x.name}", self.parameters))),
            )


    def __init__(self, type_json: dict):
        """Pointer
        {
            "declaration": "const char*",
            "description": {
                "kind": "Pointer",
                "is_nullable": false,
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
        self.type_json = type_json
        self.declaration: str = type_json["declaration"]
        self.kind: DearBindingsTypeNew.Kind = DearBindingsTypeNew.Kind(type_json["description"], self.is_function_pointer())
    

    def to_pxd(self) -> str:
        return self.kind.to_pxd()

    def is_function_pointer(self) -> bool:
        return "type_details" in self.type_json

    def is_array(self) -> bool:
        return self.kind.is_array()
