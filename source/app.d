import std.stdio;
import std.string;
import std.traits;

import derelict.sdl2.sdl;
import derelict.sdl2.image;
import derelict.sdl2.ttf;
import derelict.util.exception;

bool quit;

SDL_Window   *window;
SDL_Renderer *renderer;

void main()
{
    initBindings();
    initSDL();

    SDL_Event event;
    while (!quit)
        while (SDL_PollEvent(&event))
        {
            // Exit event
            if (event.type == SDL_QUIT)
                quit = true;

            // Debug event logging
            logSDLEvent(event);

            // Draw
            SDL_RenderClear(renderer);
            SDL_RenderPresent(renderer);
        }
}

void initBindings()
{
    // Load Derelict modules
    try
    {
        writeln("Binding sdl2...");
        DerelictSDL2.load();

        writeln("Binding sdl2_image...");
        DerelictSDL2Image.load();

        writeln("Binding sdl2_ttf...");
        DerelictSDL2ttf.load();

        writeln("Done binding!");
    }
    catch (DerelictException e)
    {
        writeln(e);
        readln();

        return;
    }
}

void initSDL()
{
    // Init SDL
    if (SDL_Init(SDL_INIT_EVERYTHING) != 0)
        writeError("Error initializing SDL");

    // Create Window
    window = SDL_CreateWindow(toStringz("HackTech"), 100, 100, 640, 480, SDL_WINDOW_SHOWN);
    if (window == null)
        writeError("Error Creating SDL Window");

    // Create Renderer
    renderer = SDL_CreateRenderer(window, -1,
               SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (renderer == null)
        writeError("Error Creating SDL Renderer");
}

void writeError(string msg)
{
    const char* error = toStringz(msg);

    printf("ERROR: %s - %s", error, SDL_GetError());
    readln();
    SDL_Quit();
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
