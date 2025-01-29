package game
import rl "vendor:raylib"

Game_Memory :: struct {
    player: Player,
    tiles: [10]Tile
}
game_memory: Game_Memory

game_init :: proc() {
    rl.InitWindow(800, 600, "Killer Arborist - dev")
    rl.SetTargetFPS(120)

    player_init(&game_memory.player)

    camera.target = game_memory.player.position
    camera.offset = { f32(rl.GetScreenWidth() / 2 - 32), f32(rl.GetScreenHeight() / 2 - 32) }
    camera.rotation = 0
    camera.zoom = 1

    for &value in game_memory.tiles {
        value.position.x = f32(rl.GetRandomValue(0, rl.GetScreenWidth()))
        value.position.y = f32(rl.GetRandomValue(0, rl.GetScreenHeight()))
    }
}

game_destroy :: proc() {
    rl.CloseWindow()
}

game_loop :: proc() {
    rl.BeginDrawing()
    player_update(rl.GetFrameTime(), &game_memory.player)
    game_update_camera()
    rl.ClearBackground(rl.LIGHTGRAY)
    rl.BeginMode2D(camera)
    for &tile in game_memory.tiles do tile_draw(&tile)
    player_draw(&game_memory.player)
    rl.EndMode2D()
    rl.DrawFPS(8, 8)
    rl.EndDrawing()
}

game_update_camera :: proc() {
    camera.target = game_memory.player.position
}

game_is_running :: proc() -> bool {
    return !rl.WindowShouldClose()
}