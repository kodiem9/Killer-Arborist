package game
import rl "vendor:raylib"

@(private="file")
SIZE : f32 : 64
SPEED : f32 : 0.01

Player :: struct {
    position: rl.Vector2
}

player_draw :: proc(player: ^Player) {
    rl.DrawRectangleV(player.position, { SIZE, SIZE }, rl.RED)
}

player_update :: proc(player: ^Player) {
    if rl.IsKeyDown(.W) do player.position.y -= SPEED
    if rl.IsKeyDown(.S) do player.position.y += SPEED
    if rl.IsKeyDown(.A) do player.position.x -= SPEED
    if rl.IsKeyDown(.D) do player.position.x += SPEED
}