import std.stdio;
import std.string;
import std.traits;

import derelict.sdl2.sdl;
import derelict.sdl2.image;
import derelict.sdl2.ttf;
import derelict.util.exception;

static SDL_Window   *window;
static SDL_Renderer *renderer;

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

    SDL_Event event;

    try
    {
        for (;;)
        {
            while (SDL_PollEvent(&event))
            {
                // Exit event
                if (event.type == SDL_QUIT)
                    throw new SuccessfulExit();

                // Debug event logging
                logSDLEvent(event);
            }

            // Draw
            SDL_RenderClear(renderer);
            SDL_RenderPresent(renderer);
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
    // Load Derelict modules
    logln("Loading sdl2...");
    DerelictSDL2.load();

    /*
    logln("Loading sdl2_image...");
    DerelictSDL2Image.load();

    logln("Loading sdl2_ttf...");
    DerelictSDL2ttf.load();
    */

    writeln("Done");
}

void initSDL()
{
    // Init SDL
    if (SDL_Init(SDL_INIT_EVERYTHING) != 0)
        throw new Exception("Error initializing SDL");

    // Create Window
    window = SDL_CreateWindow(toStringz("HackTech"), 100, 100, 640, 480, SDL_WINDOW_SHOWN);
    if (!window)
        throw new Exception("Error creating SDL window");

    // Create Renderer
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (!renderer)
        throw new Exception("Error creating SDL renderer");
}

void logSDLEvent(SDL_Event event)
{
    switch (event.type)
    {
    case SDL_KEYDOWN, SDL_KEYUP:
        writeln("SDL Keyboard Event: ", event.key);
        break;
    case SDL_MOUSEMOTION:
        writeln("SDL Mouse Event: ", event.motion);
        break;
    default:
        break;
    }
}
