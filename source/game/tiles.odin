package game
import rl "vendor:raylib"

@(private="file")
TEXTURE_SIZE : f32 : 16

@(private="file")
MULTIPLY_SIZE : f32 : 4

@(private="file")
SIZE : f32 : TEXTURE_SIZE * MULTIPLY_SIZE

Tile :: struct {
    texture: Full_Texture,
    position: rl.Vector2,
    size: rl.Vector2
}

tile_init :: proc(position: rl.Vector2) -> Tile {
    tile: Tile
    
    tile.position = position
    tile.size = { SIZE, SIZE }
    tile.texture.source = { TEXTURE_SIZE * f32(global.selected_tile), TEXTURE_SIZE * f32(global.selected_tile), TEXTURE_SIZE, TEXTURE_SIZE }
    tile.texture.dest = { tile.position.x, tile.position.y, tile.texture.source.width * MULTIPLY_SIZE, tile.texture.source.height * MULTIPLY_SIZE }
    tile.texture.origin = { 0, 0 }

    return tile
}

tile_draw :: proc(tile: ^Tile) {
    rl.DrawTexturePro(global.tile_texture, tile.texture.source, tile.texture.dest, tile.texture.origin, 0, rl.WHITE)
}