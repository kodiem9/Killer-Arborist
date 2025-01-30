package game
import rl "vendor:raylib"
import "core:fmt"

@(private="file")
SIZE : f32 : 64

@(private="file")
NORMAL_SPEED : f32 : 300

@(private="file")
FAST_SPEED : f32 : 600

Player :: struct {
    position: rl.Vector2,
    new_position: rl.Vector2,
    speed: f32,
    direction: i8_vec2
}

player_init :: proc(player: ^Player) {
    player.position = { f32(rl.GetScreenWidth() / 2 - 32), f32(rl.GetScreenHeight() / 2 - 32) }
    player.speed = NORMAL_SPEED
}

player_draw :: proc(player: ^Player) {
    rl.DrawRectangleV(player.position, { SIZE, SIZE }, rl.RED)
}

player_update :: proc(dt: f32, player: ^Player) {
    player.direction.x = i8(rl.IsKeyDown(.D)) - i8(rl.IsKeyDown(.A))
    player.direction.y = i8(rl.IsKeyDown(.S)) - i8(rl.IsKeyDown(.W))
    
    player.new_position.x += f32(player.direction.x) * player.speed * dt
    player.new_position.y += f32(player.direction.y) * player.speed * dt

    if rl.IsKeyDown(.LEFT_SHIFT) { player.speed = FAST_SPEED }
    else { player.speed = NORMAL_SPEED }
}

player_collision :: proc(player: ^Player, tile: ^Tile) {
    penetration: rl.Vector2

    if player_check_collisions_with_tile(player^, tile^) {
        // Checks the penetration to see which side is being "pushed"
        if (player.direction.x == 1) {
            penetration.x = tile.position.x - (player.new_position.x + SIZE)
        } else {
            penetration.x = (player.new_position.x - tile.size.x) - tile.position.x
        }
    
        if (player.direction.y == 1) {
            penetration.y = tile.position.y - (player.new_position.y + SIZE)
        } else {
            penetration.y = (player.new_position.y - tile.size.y) - tile.position.y
        }
    
        // If left, right side is being pushed more, then we update the x position, if not then we update the y position
        if (abs(penetration.x) < abs(penetration.y)) {
            if (player.direction.x == 1) {
                player.new_position.x = tile.position.x - SIZE
            } else {
                player.new_position.x = tile.position.x + tile.size.x
            }
        }
        else {
            if (player.direction.y == 1) {
                player.new_position.y = tile.position.y - SIZE
            } else {
                player.new_position.y = tile.position.y + tile.size.y
            }
        }    
    }

    player.position = player.new_position
}

player_check_collisions_with_tile :: proc(player: Player, tile: Tile) -> bool {
    player_rect: rl.Rectangle = { player.new_position.x, player.new_position.y, SIZE, SIZE }
    tile_rect: rl.Rectangle = { tile.position.x, tile.position.y, tile.size.x, tile.size.y }

    return rl.CheckCollisionRecs(player_rect, tile_rect)
}