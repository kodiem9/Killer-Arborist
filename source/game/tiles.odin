package game
import rl "vendor:raylib"

@(private="file")
SIZE : f32 : 64

Tile :: struct {
    position: rl.Vector2
}

tile_draw :: proc(tile: ^Tile) {
    rl.DrawRectangleV(tile.position, { SIZE, SIZE }, rl.DARKGRAY)
}