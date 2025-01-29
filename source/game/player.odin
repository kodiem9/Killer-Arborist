package game
import rl "vendor:raylib"

@(private="file")
SIZE : f32 : 64
NORMAL_SPEED : f32 : 300
FAST_SPEED : f32 : 600

Player :: struct {
    position: rl.Vector2,
    speed: f32
}

player_init :: proc(player: ^Player) {
    player.position = { f32(rl.GetScreenWidth() / 2 - 32), f32(rl.GetScreenHeight() / 2 - 32) }
    player.speed = NORMAL_SPEED
}

player_draw :: proc(player: ^Player) {
    rl.DrawRectangleV(player.position, { SIZE, SIZE }, rl.RED)
}

player_update :: proc(dt: f32, player: ^Player) {
    if rl.IsKeyDown(.W) do player.position.y -= player.speed * dt
    if rl.IsKeyDown(.S) do player.position.y += player.speed * dt
    if rl.IsKeyDown(.A) do player.position.x -= player.speed * dt
    if rl.IsKeyDown(.D) do player.position.x += player.speed * dt

    if rl.IsKeyDown(.LEFT_SHIFT) { player.speed = FAST_SPEED }
    else { player.speed = NORMAL_SPEED }
}