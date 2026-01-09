#pragma once

//---- Define attributes of all API symbols declarations, e.g. for DLL under Windows
// Using Dear ImGui via a shared library is not recommended, because of function call overhead and because we don't guarantee backward nor forward ABI compatibility.
// - Windows DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
//   for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for more details.
//#define IMGUI_API __declspec(dllexport)                   // MSVC Windows: DLL export
//#define IMGUI_API __declspec(dllimport)                   // MSVC Windows: DLL import
//#define IMGUI_API __attribute__((visibility("default")))  // GCC/Clang: override visibility when set is hidden

// The Cython binding will interface with the CIMGUI_API functions. 
#define CIMGUI_API       __declspec(dllimport)
#define CIMGUI_IMPL_API  __declspec(dllimport)

#include "imgui_config.h"
