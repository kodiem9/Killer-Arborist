package game
import rl "vendor:raylib"
import "core:math"

@(private="file")
TEXTURE_SIZE : f32 : 16

@(private="file")
MULTIPLY_SIZE : f32 : 4

@(private="file")
SIZE : f32 : TEXTURE_SIZE * MULTIPLY_SIZE

@(private="file")
ALPHA : rl.Color : { 255, 255, 255, 125 }

Place_Tile :: struct {
    texture: Full_Texture,
    position: rl.Vector2,
    add_tile: bool,
    erase_tile: bool,
}

place_tile_init :: proc(tile: ^Place_Tile) {
    tile.texture.source = { 0, 0, TEXTURE_SIZE, TEXTURE_SIZE }
    tile.texture.dest = { tile.position.x, tile.position.y, tile.texture.source.width * MULTIPLY_SIZE, tile.texture.source.height * MULTIPLY_SIZE }
    tile.texture.origin = { 0, 0 }
}

place_tile_draw :: proc(tile: ^Place_Tile) {
    rl.DrawTexturePro(global.tile_texture, tile.texture.source, tile.texture.dest, tile.texture.origin, 0, ALPHA)
}

place_tile_update :: proc(tile: ^Place_Tile) {
    tile.position.x = math.round_f32((global.world_mouse.x / SIZE)) * SIZE
    tile.position.y = math.round_f32((global.world_mouse.y / SIZE)) * SIZE

    tile.texture.source = { TEXTURE_SIZE * f32(global.selected_tile), TEXTURE_SIZE * f32(global.selected_tile), TEXTURE_SIZE, TEXTURE_SIZE }
    tile.texture.dest = { tile.position.x, tile.position.y, tile.texture.source.width * MULTIPLY_SIZE, tile.texture.source.height * MULTIPLY_SIZE }

    tile.add_tile = rl.IsMouseButtonDown(.LEFT)
    tile.erase_tile = rl.IsMouseButtonDown(.RIGHT)
}

/*
uint16_t world_mouse_x = (GetMouseX() / camera.zoom) + (camera.target.x - (GetScreenWidth() / 2 / camera.zoom));
uint16_t world_mouse_y = (GetMouseY() / camera.zoom) + (camera.target.y - (GetScreenHeight() / 2 / camera.zoom));
data.x = (world_mouse_x / 60) * 60;
data.y = (world_mouse_y / 60) * 60;
*/