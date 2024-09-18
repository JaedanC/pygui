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



static void glfw_error_callback(int error, const char* description)
{
	fprintf(stderr, "GLFW Error %d: %s\n", error, description);
}


void show_imfontconfig(ImFontConfig* config)
{
    char rasterizer_multiply_text[64];
    sprintf(rasterizer_multiply_text, "config.rasterizer_multiply: %f", config->RasterizerMultiply);
    ImGui_MenuItem(rasterizer_multiply_text);
}


void show_imfont_atlas(ImFontAtlas* atlas)
{
    if (ImGui_BeginMenu("atlas.config_data"))
    {
        char config_data_size[32];
        sprintf(config_data_size, "atlas->ConfigData.size(): %d", atlas->ConfigData.Size);
        ImGui_MenuItem(config_data_size);
        for (int i = 0; i < atlas->ConfigData.Size; i++)
        {
            char config_text[32];
            sprintf(config_text, "Config %d", i);
            if (ImGui_BeginMenu(config_text))
            {
                show_imfontconfig(&atlas->ConfigData.Data[i]);
                ImGui_EndMenu();
            }
        }
        ImGui_EndMenu();
    }
}


void example_function()
{
	{
		ImFont* font = ImGui_GetFont();
		show_imfont_atlas(font->ContainerAtlas);
	}
}


int main(int argc, char* argv[])
{
	glfwSetErrorCallback(glfw_error_callback);
	if (!glfwInit())
		return 1;

	// Decide GL+GLSL versions
	// GL 3.0 + GLSL 130
	const char* glsl_version = "#version 130";
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0);
	//glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);  // 3.2+ only
	//glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);            // 3.0+ only

	// Create window with graphics context
	GLFWwindow* window = glfwCreateWindow(1024, 768, "Hello World!", NULL, NULL);
	if (!window)
		return 1;
	glfwMakeContextCurrent(window);
	glfwSwapInterval(1); // Enable vsync

	// Check opengl version
	printf("opengl version: %s\n", (char*)glGetString(GL_VERSION));

	// Setup Dear ImGui context
	ImGui_CreateContext(NULL);
	ImGuiIO* io = ImGui_GetIO();
	io->ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;   // Enable Keyboard Controls
	io->ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;    // Enable Gamepad Controls
	io->ConfigFlags |= ImGuiConfigFlags_DockingEnable;       // Enable Docking
	io->ConfigFlags |= ImGuiConfigFlags_ViewportsEnable;     // Enable Multi-Viewport / Platform Windows

	// Setup Dear ImGui style
	ImGui_StyleColorsDark(NULL);

	ImGuiStyle* style = ImGui_GetStyle();
	if (io->ConfigFlags & ImGuiConfigFlags_ViewportsEnable)
	{
		style->WindowRounding = 0.0f;
		style->Colors[ImGuiCol_WindowBg].w = 1.0f;
	}

	// Setup Platform/Renderer backends
	ImGui_ImplGlfw_InitForOpenGL(window, true);
	ImGui_ImplOpenGL3_Init(glsl_version);

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


	//ImFontAtlas* atlas = ImGui_GetIO()->Fonts;
	//ImFontAtlas_AddFontDefault(atlas, NULL);
	//ImFontAtlas_AddFontFromFileTTF(atlas, "fonts/DroidSans*/.ttf", 14.0f, NULL, NULL);

	// ImFontConfig constructor
	//ImFontConfig cfg;
	//memset(&cfg, 0, sizeof(ImFontConfig));
    //cfg.FontDataOwnedByAtlas = true;
    //cfg.OversampleH = 3;
    //cfg.OversampleV = 1;
    //cfg.RasterizerMultiply = 1.0f;

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
		// {
		// 	static float f = 0.0f;
		// 	static int counter = 0;
		// 
		// 	ImGui_Begin("Hello, world!", NULL, 0);
		// 	ImGui_Text("This is some useful text");
		// 	ImGui_Checkbox("Demo window", &showDemoWindow);
		// 	ImGui_Checkbox("Another window", &showAnotherWindow);
		// 	ImGui_Text("New Char: ∮");
		// 
		// 	example_function();
		// 
		// 	ImGui_SliderFloatEx("Float", &f, 0.0f, 1.0f, "%.3f", 0);
		// 	ImGui_ColorEdit3("clear color", (float*)&clearColor, 0);
		// 
		// 	static int current_item = 0;
		// 	const char* items[] = { "Apple", "Banana", "Cherry", "Kiwi", "Mango", "Orange" };
		// 	ImGui_ListBox("List box", &current_item, items, 6, 4);
		// 
		// 	ImVec2 buttonSize;
		// 	buttonSize.x = 0;
		// 	buttonSize.y = 0;
		// 	if (ImGui_ButtonEx("Button", buttonSize))
		// 		counter++;
		// 	ImGui_SameLineEx(0.0f, -1.0f);
		// 	ImGui_Text("counter = %d", counter);
		// 
		// 	ImGui_Text("Application average %.3f ms/frame (%.1f FPS)",
		// 		1000.0f / ImGui_GetIO()->Framerate, ImGui_GetIO()->Framerate);
		// 	if (ImGui_Button("Click to crash ImGui"))
		// 		IM_ASSERT(false && "If you're reading this, cimgui is crashing visibly!");
		// 
		// 	ImGui_End();
		// }

		// if (showAnotherWindow)
		// {
		// 	ImGui_Begin("imgui Another Window", &showAnotherWindow, 0);
		// 	ImGui_Text("Hello from imgui");
		// 	ImVec2 buttonSize;
		// 	buttonSize.x = 0;
		// 	buttonSize.y = 0;
		// 	if (ImGui_ButtonEx("Close me", buttonSize)) {
		// 		showAnotherWindow = false;
		// 	}
		// 	ImGui_End();
		// }

		// render
		ImGui_Render();
		int display_w;
		int display_h;
		glfwGetFramebufferSize(window, &display_w, &display_h);
		glViewport(0, 0, display_w, display_h);
		glClearColor(clearColor.x, clearColor.y, clearColor.z, clearColor.w);
		glClear(GL_COLOR_BUFFER_BIT);
		ImGui_ImplOpenGL3_RenderDrawData(ImGui_GetDrawData());

		// Update and Render additional Platform Windows
		// (Platform functions may change the current OpenGL context, so we save/restore it to make it easier to paste this code elsewhere.
		//  For this specific demo app we could also call glfwMakeContextCurrent(window) directly)
		if (io->ConfigFlags & ImGuiConfigFlags_ViewportsEnable)
		{
			GLFWwindow* backup_current_context = glfwGetCurrentContext();
			ImGui_UpdatePlatformWindows();
			ImGui_RenderPlatformWindowsDefault();
			glfwMakeContextCurrent(backup_current_context);
		}

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
