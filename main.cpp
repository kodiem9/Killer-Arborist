#include <Engine.hpp>

int main()
{
    InitWindow(1280, 720, "Killer Arborist");
    SetTargetFPS(60);
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