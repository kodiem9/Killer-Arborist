#include <Engine.hpp>

int main()
{
    InitWindow(Global::window_width, Global::window_height, Global::game_title);
    SetTargetFPS(Global::game_fps);
    Engine engine;

    while(!WindowShouldClose())
    {
        BeginDrawing();
        engine.Update();
        ClearBackground(LIGHTGRAY);
        engine.Draw();
        EndDrawing();
    }

    CloseWindow();
    return 0;
}