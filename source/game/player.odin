package game
import rl "vendor:raylib"
import "core:fmt"

@(private="file")
TEXTURE_SIZE : f32 : 16

@(private="file")
MULTIPLY_SIZE : f32 : 4

@(private="file")
SIZE : f32 : TEXTURE_SIZE * MULTIPLY_SIZE

@(private="file")
NORMAL_SPEED : f32 : 300

@(private="file")
FAST_SPEED : f32 : 600

@(private="file")
WALKING_ZOOM : f32 : 1

@(private="file")
RUNNING_ZOOM : f32 : 0.85

Player :: struct {
    texture: Full_Texture,
    position: rl.Vector2,
    new_position: rl.Vector2,
    speed: f32,
    direction: i8_vec2
}

player_init :: proc(player: ^Player) {
    player.position = { (global.screen_size.x / 2) - SIZE / 2, (global.screen_size.y / 2) - SIZE / 2 }
    player.speed = NORMAL_SPEED

    player.texture.source = { 0, 0, TEXTURE_SIZE, TEXTURE_SIZE }
    player.texture.dest = { player.position.x, player.position.y, player.texture.source.width * MULTIPLY_SIZE, player.texture.source.height * MULTIPLY_SIZE }
    player.texture.origin = { 0, 0 }
}

player_draw :: proc(player: ^Player) {
    rl.DrawTexturePro(global.entity_texture, player.texture.source, player.texture.dest, player.texture.origin, 0, rl.WHITE)
}

player_update :: proc(dt: f32, player: ^Player) {
    player.direction.x = i8(rl.IsKeyDown(.D)) - i8(rl.IsKeyDown(.A))
    player.direction.y = i8(rl.IsKeyDown(.S)) - i8(rl.IsKeyDown(.W))
    
    player.new_position.x += f32(player.direction.x) * player.speed * dt
    player.new_position.y += f32(player.direction.y) * player.speed * dt

    if rl.IsKeyDown(.LEFT_SHIFT) {
        player.speed = FAST_SPEED
        global.camera.zoom += (RUNNING_ZOOM - global.camera.zoom) / 5;
    }
    else {
        player.speed = NORMAL_SPEED
        global.camera.zoom += (WALKING_ZOOM - global.camera.zoom) / 5;
    }

    player.texture.dest = { player.position.x, player.position.y, player.texture.source.width * MULTIPLY_SIZE, player.texture.source.height * MULTIPLY_SIZE }

    global.camera.target.x += (player.position.x - global.camera.target.x) / 5;
    global.camera.target.y += (player.position.y - global.camera.target.y) / 5;
}

// IMPORTANT: the player WON'T move if this procedure isn't called at least once!
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