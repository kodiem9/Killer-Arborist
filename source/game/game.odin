package game
import rl "vendor:raylib"
import "core:fmt"

Game_Memory :: struct {
    player: Player,
    place_tile: Place_Tile,
    tiles: [dynamic]Tile,
    npcs: [dynamic]NPC,
}
game_memory: Game_Memory

game_init :: proc() {
    rl.InitWindow(800, 600, "Killer Arborist - dev")
    rl.SetTargetFPS(120)

    global.scene = .GAME

    global_init()
    player_init(&game_memory.player)
    place_tile_init(&game_memory.place_tile)

    global.camera.target = game_memory.player.position
    global.camera.offset = { (global.screen_size.x / 2) - 32, (global.screen_size.y / 2) - 32 }
    global.camera.rotation = 0
    global.camera.zoom = 1

    append(&game_memory.tiles, tile_clone({ 0, 0 }))

    for i in 0..<3 {
        npc_pos: rl.Vector2
        npc_pos.x = f32(rl.GetRandomValue(0, rl.GetScreenWidth()))
        npc_pos.y = f32(rl.GetRandomValue(0, rl.GetScreenHeight()))

        append(&game_memory.npcs, npc_clone(npc_pos))
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

        global_update()
        switch global.scene {
            case .GAME: {
                player_update(dt, &game_memory.player)
                for &tile in game_memory.tiles do player_collision(&game_memory.player, &tile)
                for &npc in game_memory.npcs do npc_update(dt, &npc)
                public_map_editor_update()
            }

            case .MAP_EDITOR: {
                public_map_editor_update()
                private_map_editor_update(dt)
            }
        }

        when ODIN_DEBUG do debug_update()

    rl.ClearBackground(rl.LIGHTGRAY)

        switch global.scene {
            case .GAME: {
                rl.BeginMode2D(global.camera)

                    for &tile in game_memory.tiles do tile_draw(&tile)
                    for &npc in game_memory.npcs do npc_draw(&npc)
                    player_draw(&game_memory.player)

                rl.EndMode2D()
            }

            case .MAP_EDITOR: {
                rl.BeginMode2D(global.camera)

                    for &tile in game_memory.tiles do tile_draw(&tile)
                    for &npc in game_memory.npcs do npc_draw(&npc)
                    player_draw(&game_memory.player)
                    map_editor_draw()

                rl.EndMode2D()
            }
        }

        when ODIN_DEBUG do debug_draw()
        rl.DrawFPS(8, 8)

    rl.EndDrawing()
}

game_is_running :: proc() -> bool {
    return !rl.WindowShouldClose()
}
