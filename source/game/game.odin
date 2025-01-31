package game
import rl "vendor:raylib"
import "core:fmt"

Game_Memory :: struct {
    player: Player,
    tiles: [dynamic]Tile
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

    for i in 0..<9 {
        tile_pos: rl.Vector2
        tile_pos.x = f32(rl.GetRandomValue(0, rl.GetScreenWidth()))
        tile_pos.y = f32(rl.GetRandomValue(0, rl.GetScreenHeight()))

        append(&game_memory.tiles, tile_init(tile_pos))
    }
}

game_destroy :: proc() {
    delete(game_memory.tiles)

    rl.CloseWindow()
}

game_loop :: proc() {
    rl.BeginDrawing()

        player_update(rl.GetFrameTime(), &game_memory.player)
        for &tile in game_memory.tiles do player_collision(&game_memory.player, &tile)
        game_update_camera()
        when ODIN_DEBUG do debug_mode_update()

    rl.ClearBackground(rl.LIGHTGRAY)

        rl.BeginMode2D(camera)

            for &tile in game_memory.tiles do tile_draw(&tile)
            player_draw(&game_memory.player)

        rl.EndMode2D()

        when ODIN_DEBUG do debug_mode_draw()
        rl.DrawFPS(8, 8)

    rl.EndDrawing()
}

game_update_camera :: proc() {
    camera.target.x += (game_memory.player.position.x - camera.target.x) / 5;
    camera.target.y += (game_memory.player.position.y - camera.target.y) / 5;
}

game_is_running :: proc() -> bool {
    return !rl.WindowShouldClose()
}