import pygui
import glfw
import OpenGL.GL as gl
from python_demo_window import pygui_demo_window


vsync_enabled = pygui.Bool(True)
show_imgui_demo = pygui.Bool(True)
show_python_demo = pygui.Bool(True)


utf8_test = """
UTF-8 encoded sample plain-text file
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

Markus Kuhn [ˈmaʳkʊs kuːn] <mkuhn@acm.org> — 1999-08-20


The ASCII compatible UTF-8 encoding of ISO 10646 and Unicode
plain-text files is defined in RFC 2279 and in ISO 10646-1 Annex R.


Using Unicode/UTF-8, you can write in emails and source code things such as

Mathematics and Sciences:

    ∮ E⋅da = Q,  n → ∞, ∑ f(i) = ∏ g(i), ∀x∈ℝ: ⌈x⌉ = −⌊−x⌋, α ∧ ¬β = ¬(¬α ∨ β),

    ℕ ⊆ ℕ₀ ⊂ ℤ ⊂ ℚ ⊂ ℝ ⊂ ℂ, ⊥ < a ≠ b ≡ c ≤ d ≪ ⊤ ⇒ (A ⇔ B),

    2H₂ + O₂ ⇌ 2H₂O, R = 4.7 kΩ, ⌀ 200 mm

Linguistics and dictionaries:

    ði ıntəˈnæʃənəl fəˈnɛtık əsoʊsiˈeıʃn
    Y [ˈʏpsilɔn], Yen [jɛn], Yoga [ˈjoːgɑ]

APL:

    ((V⍳V)=⍳⍴V)/V←,V    ⌷←⍳→⍴∆∇⊃‾⍎⍕⌈

Nicer typography in plain text files:

    ╔══════════════════════════════════════════╗
    ║                                          ║
    ║   • ‘single’ and “double” quotes         ║
    ║                                          ║
    ║   • Curly apostrophes: “We’ve been here” ║
    ║                                          ║
    ║   • Latin-1 apostrophe and accents: '´`  ║
    ║                                          ║
    ║   • ‚deutsche‘ „Anführungszeichen“       ║
    ║                                          ║
    ║   • †, ‡, ‰, •, 3–4, —, −5/+5, ™, …      ║
    ║                                          ║
    ║   • ASCII safety test: 1lI|, 0OD, 8B     ║
    ║                      ╭─────────╮         ║
    ║   • the euro symbol: │ 14.95 € │         ║
    ║                      ╰─────────╯         ║
    ╚══════════════════════════════════════════╝

Greek (in Polytonic):

    The Greek anthem:

    Σὲ γνωρίζω ἀπὸ τὴν κόψη
    τοῦ σπαθιοῦ τὴν τρομερή,
    σὲ γνωρίζω ἀπὸ τὴν ὄψη
    ποὺ μὲ βία μετράει τὴ γῆ.

    ᾿Απ᾿ τὰ κόκκαλα βγαλμένη
    τῶν ῾Ελλήνων τὰ ἱερά
    καὶ σὰν πρῶτα ἀνδρειωμένη
    χαῖρε, ὦ χαῖρε, ᾿Ελευθεριά!

    From a speech of Demosthenes in the 4th century BC:

    Οὐχὶ ταὐτὰ παρίσταταί μοι γιγνώσκειν, ὦ ἄνδρες ᾿Αθηναῖοι,
    ὅταν τ᾿ εἰς τὰ πράγματα ἀποβλέψω καὶ ὅταν πρὸς τοὺς
    λόγους οὓς ἀκούω· τοὺς μὲν γὰρ λόγους περὶ τοῦ
    τιμωρήσασθαι Φίλιππον ὁρῶ γιγνομένους, τὰ δὲ πράγματ᾿ 
    εἰς τοῦτο προήκοντα,  ὥσθ᾿ ὅπως μὴ πεισόμεθ᾿ αὐτοὶ
    πρότερον κακῶς σκέψασθαι δέον. οὐδέν οὖν ἄλλο μοι δοκοῦσιν
    οἱ τὰ τοιαῦτα λέγοντες ἢ τὴν ὑπόθεσιν, περὶ ἧς βουλεύεσθαι,
    οὐχὶ τὴν οὖσαν παριστάντες ὑμῖν ἁμαρτάνειν. ἐγὼ δέ, ὅτι μέν
    ποτ᾿ ἐξῆν τῇ πόλει καὶ τὰ αὑτῆς ἔχειν ἀσφαλῶς καὶ Φίλιππον
    τιμωρήσασθαι, καὶ μάλ᾿ ἀκριβῶς οἶδα· ἐπ᾿ ἐμοῦ γάρ, οὐ πάλαι
    γέγονεν ταῦτ᾿ ἀμφότερα· νῦν μέντοι πέπεισμαι τοῦθ᾿ ἱκανὸν
    προλαβεῖν ἡμῖν εἶναι τὴν πρώτην, ὅπως τοὺς συμμάχους
    σώσομεν. ἐὰν γὰρ τοῦτο βεβαίως ὑπάρξῃ, τότε καὶ περὶ τοῦ
    τίνα τιμωρήσεταί τις καὶ ὃν τρόπον ἐξέσται σκοπεῖν· πρὶν δὲ
    τὴν ἀρχὴν ὀρθῶς ὑποθέσθαι, μάταιον ἡγοῦμαι περὶ τῆς
    τελευτῆς ὁντινοῦν ποιεῖσθαι λόγον.

    Δημοσθένους, Γ´ ᾿Ολυνθιακὸς

Georgian:

    From a Unicode conference invitation:

    გთხოვთ ახლავე გაიაროთ რეგისტრაცია Unicode-ის მეათე საერთაშორისო
    კონფერენციაზე დასასწრებად, რომელიც გაიმართება 10-12 მარტს,
    ქ. მაინცში, გერმანიაში. კონფერენცია შეჰკრებს ერთად მსოფლიოს
    ექსპერტებს ისეთ დარგებში როგორიცაა ინტერნეტი და Unicode-ი,
    ინტერნაციონალიზაცია და ლოკალიზაცია, Unicode-ის გამოყენება
    ოპერაციულ სისტემებსა, და გამოყენებით პროგრამებში, შრიფტებში,
    ტექსტების დამუშავებასა და მრავალენოვან კომპიუტერულ სისტემებში.

Russian:

    From a Unicode conference invitation:

    Зарегистрируйтесь сейчас на Десятую Международную Конференцию по
    Unicode, которая состоится 10-12 марта 1997 года в Майнце в Германии.
    Конференция соберет широкий круг экспертов по  вопросам глобального
    Интернета и Unicode, локализации и интернационализации, воплощению и
    применению Unicode в различных операционных системах и программных
    приложениях, шрифтах, верстке и многоязычных компьютерных системах.

Thai (UCS Level 2):

    Excerpt from a poetry on The Romance of The Three Kingdoms (a Chinese
    classic 'San Gua'):

    [----------------------------|------------------------]
    ๏ แผ่นดินฮั่นเสื่อมโทรมแสนสังเวช  พระปกเกศกองบู๊กู้ขึ้นใหม่
    สิบสองกษัตริย์ก่อนหน้าแลถัดไป       สององค์ไซร้โง่เขลาเบาปัญญา
    ทรงนับถือขันทีเป็นที่พึ่ง           บ้านเมืองจึงวิปริตเป็นนักหนา
    โฮจิ๋นเรียกทัพทั่วหัวเมืองมา         หมายจะฆ่ามดชั่วตัวสำคัญ
    เหมือนขับไสไล่เสือจากเคหา      รับหมาป่าเข้ามาเลยอาสัญ
    ฝ่ายอ้องอุ้นยุแยกให้แตกกัน          ใช้สาวนั้นเป็นชนวนชื่นชวนใจ
    พลันลิฉุยกุยกีกลับก่อเหตุ          ช่างอาเพศจริงหนาฟ้าร้องไห้
    ต้องรบราฆ่าฟันจนบรรลัย           ฤๅหาใครค้ำชูกู้บรรลังก์ ฯ

    (The above is a two-column text. If combining characters are handled
    correctly, the lines of the second column should be aligned with the
    | character above.)

Ethiopian:

    Proverbs in the Amharic language:

    ሰማይ አይታረስ ንጉሥ አይከሰስ።
    ብላ ካለኝ እንደአባቴ በቆመጠኝ።
    ጌጥ ያለቤቱ ቁምጥና ነው።
    ደሀ በሕልሙ ቅቤ ባይጠጣ ንጣት በገደለው።
    የአፍ ወለምታ በቅቤ አይታሽም።
    አይጥ በበላ ዳዋ ተመታ።
    ሲተረጉሙ ይደረግሙ።
    ቀስ በቀስ፥ ዕንቁላል በእግሩ ይሄዳል።
    ድር ቢያብር አንበሳ ያስር።
    ሰው እንደቤቱ እንጅ እንደ ጉረቤቱ አይተዳደርም።
    እግዜር የከፈተውን ጉሮሮ ሳይዘጋው አይድርም።
    የጎረቤት ሌባ፥ ቢያዩት ይስቅ ባያዩት ያጠልቅ።
    ሥራ ከመፍታት ልጄን ላፋታት።
    ዓባይ ማደሪያ የለው፥ ግንድ ይዞ ይዞራል።
    የእስላም አገሩ መካ የአሞራ አገሩ ዋርካ።
    ተንጋሎ ቢተፉ ተመልሶ ባፉ።
    ወዳጅህ ማር ቢሆን ጨርስህ አትላሰው።
    እግርህን በፍራሽህ ልክ ዘርጋ።

Runes:

    ᚻᛖ ᚳᚹᚫᚦ ᚦᚫᛏ ᚻᛖ ᛒᚢᛞᛖ ᚩᚾ ᚦᚫᛗ ᛚᚪᚾᛞᛖ ᚾᚩᚱᚦᚹᛖᚪᚱᛞᚢᛗ ᚹᛁᚦ ᚦᚪ ᚹᛖᛥᚫ

    (Old English, which transcribed into Latin reads 'He cwaeth that he
    bude thaem lande northweardum with tha Westsae.' and means 'He said
    that he lived in the northern land near the Western Sea.')

Braille:

    ⡌⠁⠧⠑ ⠼⠁⠒  ⡍⠜⠇⠑⠹⠰⠎ ⡣⠕⠌

    ⡍⠜⠇⠑⠹ ⠺⠁⠎ ⠙⠑⠁⠙⠒ ⠞⠕ ⠃⠑⠛⠔ ⠺⠊⠹⠲ ⡹⠻⠑ ⠊⠎ ⠝⠕ ⠙⠳⠃⠞
    ⠱⠁⠞⠑⠧⠻ ⠁⠃⠳⠞ ⠹⠁⠞⠲ ⡹⠑ ⠗⠑⠛⠊⠌⠻ ⠕⠋ ⠙⠊⠎ ⠃⠥⠗⠊⠁⠇ ⠺⠁⠎
    ⠎⠊⠛⠝⠫ ⠃⠹ ⠹⠑ ⠊⠇⠻⠛⠹⠍⠁⠝⠂ ⠹⠑ ⠊⠇⠻⠅⠂ ⠹⠑ ⠥⠝⠙⠻⠞⠁⠅⠻⠂
    ⠁⠝⠙ ⠹⠑ ⠡⠊⠑⠋ ⠍⠳⠗⠝⠻⠲ ⡎⠊⠗⠕⠕⠛⠑ ⠎⠊⠛⠝⠫ ⠊⠞⠲ ⡁⠝⠙
    ⡎⠊⠗⠕⠕⠛⠑⠰⠎ ⠝⠁⠍⠑ ⠺⠁⠎ ⠛⠕⠕⠙ ⠥⠏⠕⠝ ⠰⡡⠁⠝⠛⠑⠂ ⠋⠕⠗ ⠁⠝⠹⠹⠔⠛ ⠙⠑ 
    ⠡⠕⠎⠑ ⠞⠕ ⠏⠥⠞ ⠙⠊⠎ ⠙⠁⠝⠙ ⠞⠕⠲

    ⡕⠇⠙ ⡍⠜⠇⠑⠹ ⠺⠁⠎ ⠁⠎ ⠙⠑⠁⠙ ⠁⠎ ⠁ ⠙⠕⠕⠗⠤⠝⠁⠊⠇⠲

    ⡍⠔⠙⠖ ⡊ ⠙⠕⠝⠰⠞ ⠍⠑⠁⠝ ⠞⠕ ⠎⠁⠹ ⠹⠁⠞ ⡊ ⠅⠝⠪⠂ ⠕⠋ ⠍⠹
    ⠪⠝ ⠅⠝⠪⠇⠫⠛⠑⠂ ⠱⠁⠞ ⠹⠻⠑ ⠊⠎ ⠏⠜⠞⠊⠊⠥⠇⠜⠇⠹ ⠙⠑⠁⠙ ⠁⠃⠳⠞
    ⠁ ⠙⠕⠕⠗⠤⠝⠁⠊⠇⠲ ⡊ ⠍⠊⠣⠞ ⠙⠁⠧⠑ ⠃⠑⠲ ⠔⠊⠇⠔⠫⠂ ⠍⠹⠎⠑⠇⠋⠂ ⠞⠕
    ⠗⠑⠛⠜⠙ ⠁ ⠊⠕⠋⠋⠔⠤⠝⠁⠊⠇ ⠁⠎ ⠹⠑ ⠙⠑⠁⠙⠑⠌ ⠏⠊⠑⠊⠑ ⠕⠋ ⠊⠗⠕⠝⠍⠕⠝⠛⠻⠹ 
    ⠔ ⠹⠑ ⠞⠗⠁⠙⠑⠲ ⡃⠥⠞ ⠹⠑ ⠺⠊⠎⠙⠕⠍ ⠕⠋ ⠳⠗ ⠁⠝⠊⠑⠌⠕⠗⠎ 
    ⠊⠎ ⠔ ⠹⠑ ⠎⠊⠍⠊⠇⠑⠆ ⠁⠝⠙ ⠍⠹ ⠥⠝⠙⠁⠇⠇⠪⠫ ⠙⠁⠝⠙⠎
    ⠩⠁⠇⠇ ⠝⠕⠞ ⠙⠊⠌⠥⠗⠃ ⠊⠞⠂ ⠕⠗ ⠹⠑ ⡊⠳⠝⠞⠗⠹⠰⠎ ⠙⠕⠝⠑ ⠋⠕⠗⠲ ⡹⠳
    ⠺⠊⠇⠇ ⠹⠻⠑⠋⠕⠗⠑ ⠏⠻⠍⠊⠞ ⠍⠑ ⠞⠕ ⠗⠑⠏⠑⠁⠞⠂ ⠑⠍⠏⠙⠁⠞⠊⠊⠁⠇⠇⠹⠂ ⠹⠁⠞
    ⡍⠜⠇⠑⠹ ⠺⠁⠎ ⠁⠎ ⠙⠑⠁⠙ ⠁⠎ ⠁ ⠙⠕⠕⠗⠤⠝⠁⠊⠇⠲

    (The first couple of paragraphs of "A Christmas Carol" by Dickens)

Compact font selection example text:

    ABCDEFGHIJKLMNOPQRSTUVWXYZ /0123456789
    abcdefghijklmnopqrstuvwxyz £©µÀÆÖÞßéöÿ
    –—‘“”„†•…‰™œŠŸž€ ΑΒΓΔΩαβγδω АБВГДабвгд
    ∀∂∈ℝ∧∪≡∞ ↑↗↨↻⇣ ┐┼╔╘░►☺♀ ﬁ�⑀₂ἠḂӥẄɐː⍎אԱა

Greetings in various languages:

    Hello world, Καλημέρα κόσμε, コンニチハ

Box drawing alignment tests:                                            █
                                                                        ▉
    ╔══╦══╗  ┌──┬──┐  ╭──┬──╮  ╭──┬──╮  ┏━━┳━━┓  ┎┒┏┑   ╷  ╻ ┏┯┓ ┌┰┐    ▊ ╱╲╱╲╳╳╳
    ║┌─╨─┐║  │╔═╧═╗│  │╒═╪═╕│  │╓─╁─╖│  ┃┌─╂─┐┃  ┗╃╄┙  ╶┼╴╺╋╸┠┼┨ ┝╋┥    ▋ ╲╱╲╱╳╳╳
    ║│╲ ╱│║  │║   ║│  ││ │ ││  │║ ┃ ║│  ┃│ ╿ │┃  ┍╅╆┓   ╵  ╹ ┗┷┛ └┸┘    ▌ ╱╲╱╲╳╳╳
    ╠╡ ╳ ╞╣  ├╢   ╟┤  ├┼─┼─┼┤  ├╫─╂─╫┤  ┣┿╾┼╼┿┫  ┕┛┖┚     ┌┄┄┐ ╎ ┏┅┅┓ ┋ ▍ ╲╱╲╱╳╳╳
    ║│╱ ╲│║  │║   ║│  ││ │ ││  │║ ┃ ║│  ┃│ ╽ │┃  ░░▒▒▓▓██ ┊  ┆ ╎ ╏  ┇ ┋ ▎
    ║└─╥─┘║  │╚═╤═╝│  │╘═╪═╛│  │╙─╀─╜│  ┃└─╂─┘┃  ░░▒▒▓▓██ ┊  ┆ ╎ ╏  ┇ ┋ ▏
    ╚══╩══╝  └──┴──┘  ╰──┴──╯  ╰──┴──╯  ┗━━┻━━┛           └╌╌┘ ╎ ┗╍╍┛ ┋  ▁▂▃▄▅▆▇█

"""


def render():
    pygui.begin("Hello from pygui!")
    pygui.text("FPS: {}".format(round(pygui.get_io().framerate)))
    if pygui.checkbox("Enable vsync", vsync_enabled):
        glfw.swap_interval(int(vsync_enabled.value))
    pygui.checkbox("Show pygui Demo", show_python_demo)
    pygui.same_line()
    pygui.checkbox("Show ImGui Demo", show_imgui_demo)
    pygui.end()

    if show_imgui_demo:
        pygui.show_demo_window()

    if show_python_demo:
        pygui_demo_window()


def main():
    if not glfw.init():
        return

    glfw.window_hint(glfw.OPENGL_FORWARD_COMPAT, glfw.TRUE)
    glfw.window_hint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
    glfw.window_hint(glfw.CONTEXT_VERSION_MAJOR, 3)
    glfw.window_hint(glfw.CONTEXT_VERSION_MINOR, 2)
    glfw.window_hint(glfw.RESIZABLE, glfw.TRUE)

    window = glfw.create_window(1024, 768, "Hello World!", None, None)
    if window is None:
       print("Failed to create window! Terminating")
       glfw.terminate()
       return
    
    glfw.make_context_current(window)

    # Vsync:
    # 1: On
    # 0: Off
    glfw.swap_interval(int(vsync_enabled.value))

    # Setup imgui
    pygui.create_context()

    # Setup config flags
    io = pygui.get_io()
    io.config_flags |= pygui.CONFIG_FLAGS_NAV_ENABLE_KEYBOARD
    io.config_flags |= pygui.CONFIG_FLAGS_NAV_ENABLE_GAMEPAD
    io.config_flags |= pygui.CONFIG_FLAGS_DOCKING_ENABLE
    io.config_flags |= pygui.CONFIG_FLAGS_VIEWPORTS_ENABLE

    pygui.impl_glfw_init_for_open_gl(window, True)
    pygui.impl_open_gl3_init()

    # Check opengl version
    print("Opengl version: {}".format(gl.glGetString(gl.GL_VERSION).decode()))
    print("glfw version: {}.{}.{}".format(glfw.VERSION_MAJOR, glfw.VERSION_MINOR, glfw.VERSION_REVISION))
    print("ImGui version: {}".format(pygui.get_version()))

    # Try out different styles
    pygui.style_colors_dark()
    # pygui.style_colors_light()
    # pygui.style_colors_classic()
    clear_color = (0.45, 0.55, 0.6, 1.0)

    pygui.IM_ASSERT(True, "You should never see this")
    try:
        pygui.IM_ASSERT(False, "Checking pygui's IM_ASSERT. Raises ")
    except pygui.ImGuiError as e:
        print(e, end="")
        if isinstance(e, AssertionError):
            print("AssertionError")
        else:
            print("pygui.ImGuiError")

    # --------------------------------------------------------------------------
    # // Load a first font
    # ImFont* font = io.Fonts->AddFontDefault();
    # 
    # // Add character ranges and merge into the previous font
    # // The ranges array is not copied by the AddFont* functions and is used lazily
    # // so ensure it is available at the time of building or calling GetTexDataAsRGBA32().
    # static const ImWchar icons_ranges[] = { 0xf000, 0xf3ff, 0 }; // Will not be copied by AddFont* so keep in scope.
    # ImFontConfig config;
    # config.MergeMode = true;
    # io.Fonts->AddFontFromFileTTF("DroidSans.ttf", 18.0f, &config, io.Fonts->GetGlyphRangesJapanese()); // Merge into first font
    # io.Fonts->AddFontFromFileTTF("fontawesome-webfont.ttf", 18.0f, &config, icons_ranges);             // Merge into first font
    # io.Fonts->Build();

    io = pygui.get_io()

    io.fonts.add_font_default()

    # utf-8 ranges from above
    builder = pygui.ImFontGlyphRangesBuilder.create()
    builder.add_text(utf8_test)
    ranges = builder.build_ranges()
    builder.destroy()

    # NotoSansMath font
    config = pygui.ImFontConfig.create()
    config.glyph_min_advance_x = 7.5
    config.glyph_max_advance_x = 7.5
    config.name = "NotoSansMath-Regular without range"
    io.fonts.add_font_from_file_ttf("pygui/fonts/NotoSansMath-Regular.ttf", 16, config)
    config.name = "NotoSansMath-Regular with range"
    io.fonts.add_font_from_file_ttf("pygui/fonts/NotoSansMath-Regular.ttf", 16, config, ranges)
    config.destroy()

    # Consolas font
    config = pygui.ImFontConfig.create()
    config.name = "Consola without range"
    io.fonts.add_font_from_file_ttf("pygui/fonts/consola.ttf", 13, config)
    config.name = "Consola with range"
    io.fonts.add_font_from_file_ttf("pygui/fonts/consola.ttf", 13, config, ranges)
    config.destroy()

    # Merging multiple fonts together
    config = pygui.ImFontConfig.create()
    config.name = "Consola + NotoSansMath + CascadiaMono"
    config.glyph_min_advance_x = 7.15
    config.glyph_max_advance_x = 7.15
    io.fonts.add_font_from_file_ttf("pygui/fonts/consola.ttf", 13, config, ranges)
    config.merge_mode = True
    io.fonts.add_font_from_file_ttf("pygui/fonts/NotoSansMath-Regular.ttf", 20, config, ranges)
    io.fonts.add_font_from_file_ttf("pygui/fonts/CascadiaMono.ttf", 14, config, ranges)
    config.destroy()

    builder = pygui.ImFontGlyphRangesBuilder.create()
    builder.add_text("Should not be visible")
    builder.clear()
    omega = ord("Ω")
    builder.add_text("asciiASCII")
    assert not builder.get_bit(omega)
    builder.set_bit(omega)
    assert builder.get_bit(omega)
    builder.add_char(ord("b"))
    custom_range = builder.build_ranges()
    builder.destroy()

    config = pygui.ImFontConfig.create()
    config.name = "Proggy + Droid Minimal"
    io.fonts.add_font_from_file_ttf("pygui/fonts/ProggyClean.ttf", 20, config, custom_range)
    config.merge_mode = True
    io.fonts.add_font_from_file_ttf("pygui/fonts/DroidSans.ttf", 11, config, ranges)
    config.destroy()

    # More fonts
    io.fonts.add_font_from_file_ttf("pygui/fonts/Font Awesome 6 Free-Regular-400.otf", 13, None, ranges)
    io.fonts.add_font_from_file_ttf("pygui/fonts/CascadiaMono.ttf", 14, None, ranges)
    io.fonts.add_font_from_file_ttf("pygui/fonts/unifont-15.0.01.otf", 13, None, ranges)
    # io.fonts.add_font_from_file_ttf("pygui/fonts/consola.ttf", 13, config, ranges)
    # io.fonts.add_font_from_file_ttf("pygui/fonts/Roboto-Medium.ttf", 14, config, ranges)
    # io.fonts.add_font_from_file_ttf("pygui/fonts/Everson Mono.ttf", 13, config, ranges)
    # io.fonts.add_font_from_file_ttf("pygui/fonts/consola.ttf", 18, config, io.fonts.get_glyph_ranges_japanese())

    # Any fonts that need to be added should call build()
    io.fonts.build()

    # Since we need the ranges to be valid for the call to build, Python's gc
    # mightclean up the ImGlyphRange before the call to build, resulting in
    # accessing freed memory. This is why you can defer the destruction
    # explicitly to ensure the memory is freed exactly at that point. The gc can
    # safetly clean up the python ImFontConfig object whenever it likes after
    # this call.
    custom_range.destroy()
    ranges.destroy()

    use_index = pygui.Int(5)
    use_font = pygui.Bool(True)
    # --------------------------------------------------------------------------
    
    try:
        while not glfw.window_should_close(window):
            glfw.poll_events()
            pygui.impl_open_gl3_new_frame()
            pygui.impl_glfw_new_frame()
            pygui.new_frame()

            render()

            # ------------------- FONTS --------------------------
            if pygui.begin("Custom fonts"):
                fonts = pygui.get_io().fonts.fonts
                selected_font = fonts[0]
                if pygui.begin("Style Editor"):
                    pygui.checkbox("Push Font", use_font)
                    pygui.list_box("Use font", use_index, [f.get_debug_name() for f in fonts], len(fonts))
                    selected_font = fonts[use_index.value % len(fonts)]
                    if pygui.collapsing_header("Style Editor"):
                        pygui.show_style_editor()
                pygui.end()

                pygui.push_font(selected_font if use_font else fonts[0])
                pygui.text("After push こんにちは！テスト")
                pygui.text("©땔땕땗😀☠️⭐")
                pygui.text_unformatted(utf8_test)
                pygui.show_about_window()
                pygui.pop_font()
            pygui.end()
            # ------------------- FONTS --------------------------
            
            pygui.render()
            glfw.make_context_current(window)
            
            gl.glViewport(0, 0, int(io.display_size[0]), int(io.display_size[1]))
            gl.glClearColor(*clear_color)
            gl.glClear(gl.GL_COLOR_BUFFER_BIT)

            draw_data = pygui.get_draw_data()
            pygui.impl_open_gl3_render_draw_data(draw_data)

            if io.config_flags & pygui.CONFIG_FLAGS_VIEWPORTS_ENABLE:
                backup_current_window = glfw.get_current_context()
                pygui.update_platform_windows()
                pygui.render_platform_windows_default()
                glfw.make_context_current(backup_current_window)
            
            glfw.swap_buffers(window)
    except KeyboardInterrupt:
        print("Closing")
    
    pygui.impl_open_gl3_shutdown()
    pygui.impl_glfw_shutdown()
    pygui.destroy_context()
    glfw.destroy_window(window)
    glfw.terminate()


if __name__ == "__main__":
    main()
