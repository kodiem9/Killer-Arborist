package main

import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(800, 600, "Killer Arborist - dev");
    defer rl.CloseWindow()

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.LIGHTGRAY)
        rl.EndDrawing()
    }
}