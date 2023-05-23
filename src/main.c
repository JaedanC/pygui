#include "cimgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include <GLFW/glfw3.h>
#include <stdio.h>
#ifdef _MSC_VER
#include <windows.h>
#endif
#include <GL/gl.h>


#ifdef IMGUI_HAS_IMSTR
#define ImGui_Begin igBegin_Str
#define ImGui_SliderFloat igSliderFloat_Str
#define ImGui_Checkbox igCheckbox_Str
#define ImGui_ColorEdit3 igColorEdit3_Str
#define ImGui_Button igButton_Str
#endif


GLFWwindow* window;

int main(int argc, char* argv[])
{
	if (!glfwInit())
		return -1;

	// Decide GL+GLSL versions
	glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GLFW_TRUE);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);

#if __APPLE__
	// GL 3.2 Core + GLSL 150
	const char* glsl_version = "#version 150";
#else
	// GL 3.2 + GLSL 130
	const char* glsl_version = "#version 130";
#endif

	// just an extra window hint for resize
	glfwWindowHint(GLFW_RESIZABLE, GLFW_TRUE);

	window = glfwCreateWindow(1024, 768, "Hello World!", NULL, NULL);
	if (!window)
	{
		printf("Failed to create window! Terminating!\n");
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);

	// enable vsync
	glfwSwapInterval(0);

	// check opengl version sdl uses
	printf("opengl version: %s\n", (char*)glGetString(GL_VERSION));

	// setup imgui
	ImGui_CreateContext(NULL);

	// set docking
	ImGuiIO* ioptr = ImGui_GetIO();
	ioptr->ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;   // Enable Keyboard Controls
	//ioptr->ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;  // Enable Gamepad Controls
#ifdef IMGUI_HAS_DOCK
	ioptr->ConfigFlags |= ImGuiConfigFlags_DockingEnable;       // Enable Docking
	ioptr->ConfigFlags |= ImGuiConfigFlags_ViewportsEnable;     // Enable Multi-Viewport / Platform Windows
#endif

	int monitors_count = 0;
	GLFWmonitor** glfw_monitors = glfwGetMonitors(&monitors_count);

	ImGui_ImplGlfw_InitForOpenGL(window, true);
	ImGui_ImplOpenGL3_Init(glsl_version);

	ImGui_StyleColorsDark(NULL);
	// ImFontAtlas_AddFontDefault(io.Fonts, NULL);

	bool showDemoWindow = true;
	bool showAnotherWindow = false;
	ImVec4 clearColor;
	clearColor.x = 0.45f;
	clearColor.y = 0.55f;
	clearColor.z = 0.60f;
	clearColor.w = 1.00f;

	// ImFontGlyphRangesBuilder constructor
	//ImFontGlyphRangesBuilder builder;
	//memset(&builder, 0, sizeof(ImFontGlyphRangesBuilder));
	//ImFontGlyphRangesBuilder_Clear(&builder);
	//ImFontGlyphRangesBuilder_AddText(&builder, "a∮", NULL); // 8750

	//ImVector_ImWchar c_range;
	//ImVector_Construct(&c_range);
	//ImFontGlyphRangesBuilder_BuildRanges(&builder, &c_range);


	//ImFontAtlas* atlas = ImGui_GetIO()->Fonts;
	//ImFontAtlas_AddFontDefault(atlas, NULL);
	//ImFontAtlas_AddFontFromFileTTF(atlas, "fonts/DroidSans*/.ttf", 14.0f, NULL, NULL);

	// ImFontConfig constructor
	//ImFontConfig cfg;
	//memset(&cfg, 0, sizeof(ImFontConfig));
    //cfg.FontDataOwnedByAtlas = true;
    //cfg.OversampleH = 3;
    //cfg.OversampleV = 1;
    //cfg.GlyphMaxAdvanceX = 3.402823466e+38F; // = FLT_MAX
    //cfg.RasterizerMultiply = 1.0f;
    //cfg.EllipsisChar = (ImWchar)-1;

	//ImFontAtlas_AddFontFromFileTTF(atlas, "fonts/ProggyClean.ttf", 14.0f, &cfg, ImFontAtlas_GetGlyphRangesDefault(atlas));
	//ImFontAtlas_AddFontFromFileTTF(atlas, "fonts/ProggyClean.ttf", 14.0f, &cfg, c_range.Data);
	//cfg.MergeMode = true;
	//ImFontAtlas_AddFontFromFileTTF(atlas, "fonts/NotoSansMath-Regular.ttf", 20.0f, &cfg, c_range.Data);
	//ImFontAtlas_Build(atlas);

	// main event loop
	bool quit = false;
	while (!glfwWindowShouldClose(window))
	{

		glfwPollEvents();

		// start imgui frame
		ImGui_ImplOpenGL3_NewFrame();
		ImGui_ImplGlfw_NewFrame();

		ImGui_NewFrame();

		if (showDemoWindow)
			ImGui_ShowDemoWindow(&showDemoWindow);

		// show a simple window that we created ourselves.
		{
			static float f = 0.0f;
			static int counter = 0;

			ImGui_Begin("Hello, world!", NULL, 0);
			ImGui_Text("This is some useful text");
			ImGui_Checkbox("Demo window", &showDemoWindow);
			ImGui_Checkbox("Another window", &showAnotherWindow);
			ImGui_Text("New Char: ∮");

			ImGui_SliderFloatEx("Float", &f, 0.0f, 1.0f, "%.3f", 0);
			ImGui_ColorEdit3("clear color", (float*)&clearColor, 0);

			static int current_item = 0;
			const char* items[] = { "Apple", "Banana", "Cherry", "Kiwi", "Mango", "Orange" };
			ImGui_ListBox("List box", &current_item, items, 6, 4);

			ImVec2 buttonSize;
			buttonSize.x = 0;
			buttonSize.y = 0;
			if (ImGui_ButtonEx("Button", buttonSize))
				counter++;
			ImGui_SameLineEx(0.0f, -1.0f);
			ImGui_Text("counter = %d", counter);

			ImGui_Text("Application average %.3f ms/frame (%.1f FPS)",
				1000.0f / ImGui_GetIO()->Framerate, ImGui_GetIO()->Framerate);
			if (ImGui_Button("Click to crash ImGui"))
				IM_ASSERT(false && "If you're reading this, cimgui is crashing visibly!");

			ImGui_End();
		}

		if (showAnotherWindow)
		{
			ImGui_Begin("imgui Another Window", &showAnotherWindow, 0);
			ImGui_Text("Hello from imgui");
			ImVec2 buttonSize;
			buttonSize.x = 0;
			buttonSize.y = 0;
			if (ImGui_ButtonEx("Close me", buttonSize)) {
				showAnotherWindow = false;
			}
			ImGui_End();
		}

		// render
		ImGui_Render();
		glfwMakeContextCurrent(window);
		glViewport(0, 0, (int)ioptr->DisplaySize.x, (int)ioptr->DisplaySize.y);
		glClearColor(clearColor.x, clearColor.y, clearColor.z, clearColor.w);
		glClear(GL_COLOR_BUFFER_BIT);
		ImGui_ImplOpenGL3_RenderDrawData(ImGui_GetDrawData());
#ifdef IMGUI_HAS_DOCK
		if (ioptr->ConfigFlags & ImGuiConfigFlags_ViewportsEnable)
		{
			GLFWwindow* backup_current_window = glfwGetCurrentContext();
			ImGui_UpdatePlatformWindows();
			ImGui_RenderPlatformWindowsDefault();
			glfwMakeContextCurrent(backup_current_window);
		}
#endif
		glfwSwapBuffers(window);
	}

	//ImVector_Destruct(&c_range);

	// clean up
	ImGui_ImplOpenGL3_Shutdown();
	ImGui_ImplGlfw_Shutdown();
	ImGui_DestroyContext(NULL);

	glfwDestroyWindow(window);
	glfwTerminate();

	return 0;
}
