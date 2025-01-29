package game
import rl "vendor:raylib"

Game_Memory :: struct {
    player: Player
}
game_memory: Game_Memory

game_init :: proc() {
    rl.InitWindow(800, 600, "Killer Arborist - dev")

    game_memory.player = { position={ f32(rl.GetScreenWidth() / 2 - 32), f32(rl.GetScreenHeight() / 2 - 32) } }
}

game_destroy :: proc() {
    rl.CloseWindow()
}

game_loop :: proc() {
    rl.BeginDrawing()
    player_draw(&game_memory.player)
    rl.ClearBackground(rl.LIGHTGRAY)
    player_update(&game_memory.player)
    rl.EndDrawing()
}

game_is_running :: proc() -> bool {
    return !rl.WindowShouldClose()
}