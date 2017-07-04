import std.stdio;
import std.string;
import std.traits;

import derelict.sdl2.sdl;
import derelict.opengl;

private SDL_Window*   window;
private SDL_GLContext context;

/// Thrown on successfully exiting the application.
class SuccessfulExit : Exception
{
    this()
    {
        super("");
    }
}

int main()
{
    initBindings();
    initSDL();
    initGL();

    try
    {
        for (;;)
        {
            for (SDL_Event event; SDL_PollEvent(&event);)
            {
                if (event.type == SDL_QUIT)
                    throw new SuccessfulExit();

                event.logSDLEvent();
            }

            glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
            SDL_GL_SwapWindow(window);
        }
    }
    catch (SuccessfulExit)
    {
        return 0;
    }
}

void logln(string func = __FUNCTION__, T...)(T args)
{
    writeln(func, ": ", args);
}

void initBindings()
{
    logln("Loading sdl2...");
    DerelictSDL2.load();

    /*
    logln("Loading sdl2_image...");
    DerelictSDL2Image.load();

    logln("Loading sdl2_ttf...");
    DerelictSDL2ttf.load();
    */

    logln("Loading gl3...");
    DerelictGL3.load();
}

void initGL()
{
    logln("Loading OpenGL function pointers...");
    DerelictGL3.reload();

    glEnable(GL_TEXTURE_2D);
    glEnable(GL_BLEND);
    glEnable(GL_CULL_FACE);

    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    glClearColor(1, 0, 1, 1);

    glMatrixMode(GL_PROJECTION);
    glOrtho(0, 640, 480, 0, -1, 1);
}

void initSDL()
{
    if (SDL_Init(SDL_INIT_EVERYTHING) != 0)
        throw new Exception("Error initializing SDL");

    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 1);

    logln("Initializing window...");
    window = SDL_CreateWindow("HackTech", 100, 100, 640, 480, SDL_WINDOW_OPENGL | SDL_WINDOW_SHOWN);
    if (!window)
        throw new Exception("Error creating SDL window");

    logln("Creating OpenGL context...");
    context = SDL_GL_CreateContext(window);

    if (SDL_GL_SetSwapInterval(-1) < 0)
        SDL_GL_SetSwapInterval(1);

    SDL_version ver;
    SDL_GetVersion(&ver);

    logln("Initialized SDL ", ver.major, ".", ver.minor, ".", ver.patch);
}

void logSDLEvent(SDL_Event event)
{
    switch (event.type)
    {
    case SDL_KEYDOWN, SDL_KEYUP:
        logln("SDL Keyboard Event: ", event.key);
        break;
    case SDL_MOUSEMOTION:
        logln("SDL Mouse Event: ", event.motion);
        break;
    default:
        break;
    }
}

// EOF
