package game
import rl "vendor:raylib"

@(private="file")
SIZE : f32 : 64

Tile :: struct {
    position: rl.Vector2,
    size: rl.Vector2
}

tile_init :: proc(position: rl.Vector2) -> Tile {
    tile: Tile
    
    tile.position = position
    tile.size = { SIZE, SIZE }

    return tile
}

tile_draw :: proc(tile: ^Tile) {
    rl.DrawRectangleV(tile.position, { SIZE, SIZE }, rl.DARKGRAY)
}