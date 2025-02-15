package game
import rl "vendor:raylib"
import "core:fmt"

@(private="file")
SPEED : f32 : 500

@(private="file")
Map_Editor :: struct {
    position: rl.Vector2,
    direction: i8_vec2,
}

@(private="file")
map_editor: Map_Editor

map_editor_draw :: proc() {
    place_tile_draw(&game_memory.place_tile)
}

public_map_editor_update :: proc() {
    if rl.IsKeyPressed(.N) {
        if global.scene == .GAME {
            global.scene = .MAP_EDITOR
            map_editor.position = global.camera.target
        } else {
            global.scene = .GAME
        }
    }

    if rl.IsKeyPressed(.ONE) do global.selected_tile = 0
    if rl.IsKeyPressed(.TWO) do global.selected_tile = 1
    if rl.IsKeyPressed(.THREE) do global.selected_tile = 2
}

private_map_editor_update :: proc(dt: f32) {
    place_tile_update(&game_memory.place_tile)
    map_editor_manage_tiles()

    map_editor.direction.x = i8(rl.IsKeyDown(.D)) - i8(rl.IsKeyDown(.A))
    map_editor.direction.y = i8(rl.IsKeyDown(.S)) - i8(rl.IsKeyDown(.W))

    map_editor.position.x += f32(map_editor.direction.x) * SPEED * dt
    map_editor.position.y += f32(map_editor.direction.y) * SPEED * dt

    global.camera.target = map_editor.position
}

map_editor_manage_tiles :: proc() {
    if game_memory.place_tile.add_tile {
        tile_pos: rl.Vector2 = game_memory.place_tile.position

        for tile in game_memory.tiles {
            if tile.position == tile_pos do return
        }

        append(&game_memory.tiles, tile_clone(tile_pos))
        fmt.println("Added tile:", tile_pos)
    }

    if game_memory.place_tile.erase_tile {
        tile_pos: rl.Vector2 = game_memory.place_tile.position

        for tile, index in game_memory.tiles {
            if tile.position == tile_pos {
                ordered_remove(&game_memory.tiles, index)
                fmt.println("Removed tile:", tile_pos)
                return
            }
        }
    }
}
