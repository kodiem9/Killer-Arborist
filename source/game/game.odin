package game
import rl "vendor:raylib"

game_init :: proc() {
    rl.InitWindow(800, 600, "Killer Arborist - dev")
}

game_destroy :: proc() {
    rl.CloseWindow()
}

game_loop :: proc() {
    rl.BeginDrawing()
    rl.ClearBackground(rl.LIGHTGRAY)
    rl.EndDrawing()
}

game_is_running :: proc() -> bool {
    return !rl.WindowShouldClose()
}