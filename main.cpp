#include <PCH.hpp>

int main()
{
    InitWindow(1280, 720, "Killer Arborist");
    SetTargetFPS(60);

    while(!WindowShouldClose())
    {
        BeginDrawing();

        ClearBackground(LIGHTGRAY);

        EndDrawing();
    }

    CloseWindow();
    return 0;
}