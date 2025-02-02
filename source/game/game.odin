package game
import rl "vendor:raylib"
import "dbg"
import "core:fmt"

Game_Memory :: struct {
    player: Player,
    tiles: [dynamic]Tile,
    npcs: [dynamic]NPC
}
game_memory: Game_Memory

game_init :: proc() {
    rl.InitWindow(800, 600, "Killer Arborist - dev")
    rl.SetTargetFPS(120)

    global_init()
    player_init(&game_memory.player)

    global.camera.target = game_memory.player.position
    global.camera.offset = { (global.screen_size.x / 2) - 32, (global.screen_size.y / 2) - 32 }
    global.camera.rotation = 0
    global.camera.zoom = 1

    for i in 0..<9 {
        tile_pos: rl.Vector2
        tile_pos.x = f32(rl.GetRandomValue(0, rl.GetScreenWidth()))
        tile_pos.y = f32(rl.GetRandomValue(0, rl.GetScreenHeight()))

        append(&game_memory.tiles, tile_init(tile_pos))
    }

    for i in 0..<3 {
        npc_pos: rl.Vector2
        npc_pos.x = f32(rl.GetRandomValue(0, rl.GetScreenWidth()))
        npc_pos.y = f32(rl.GetRandomValue(0, rl.GetScreenHeight()))

        append(&game_memory.npcs, npc_init(npc_pos))
    }
}

game_destroy :: proc() {
    delete(game_memory.tiles)
    delete(game_memory.npcs)

    rl.CloseWindow()
}

game_loop :: proc() {
    dt: f32 = rl.GetFrameTime()

    rl.BeginDrawing()

        player_update(dt, &game_memory.player)
        for &tile in game_memory.tiles do player_collision(&game_memory.player, &tile)
        for &npc in game_memory.npcs do npc_update(dt, &npc)
        game_update_camera()
        when ODIN_DEBUG do dbg.update()

    rl.ClearBackground(rl.LIGHTGRAY)

        rl.BeginMode2D(global.camera)

            for &tile in game_memory.tiles do tile_draw(&tile)
            for &npc in game_memory.npcs do npc_draw(&npc)
            player_draw(&game_memory.player)

        rl.EndMode2D()

        when ODIN_DEBUG do dbg.draw()
        rl.DrawFPS(8, 8)

    rl.EndDrawing()
}

game_update_camera :: proc() {
    global.camera.target.x += (game_memory.player.position.x - global.camera.target.x) / 5;
    global.camera.target.y += (game_memory.player.position.y - global.camera.target.y) / 5;
}

game_is_running :: proc() -> bool {
    return !rl.WindowShouldClose()
}