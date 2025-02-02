package game
import rl "vendor:raylib"
import "core:fmt"
import "core:math"

@(private="file")
TEXTURE_SIZE : f32 : 16

@(private="file")
MULTIPLY_SIZE : f32 : 4

@(private="file")
SIZE : f32 : TEXTURE_SIZE * MULTIPLY_SIZE

@(private="file")
SPEED : f32 : 100

@(private="file")
STOP_BORDER : f32 : 16

@(private="file")
DELAY_BEFORE_MOVING : f32 : 5

NPC_State :: enum {
    Standing,
    Preparing,
    Moving,
    Controlling,
}

NPC :: struct {
    texture: Full_Texture,
    position: rl.Vector2,
    size: rl.Vector2,
    destination: rl.Vector2,
    direction_speed: rl.Vector2,
    delay_before_moving: f32,
    state: NPC_State
}

npc_init :: proc(position: rl.Vector2) -> NPC {
    npc: NPC
    
    npc.position = position
    npc.size = { SIZE, SIZE }
    npc.state = .Standing

    npc.texture.source = { 16, 0, TEXTURE_SIZE, TEXTURE_SIZE }
    npc.texture.dest = { npc.position.x, npc.position.y, npc.texture.source.width * MULTIPLY_SIZE, npc.texture.source.height * MULTIPLY_SIZE }
    npc.texture.origin = { 0, 0 }

    return npc
}

npc_draw :: proc(npc: ^NPC) {
    when ODIN_DEBUG {
        rl.DrawLineEx(npc.position + { SIZE / 2, SIZE / 2 }, npc.destination + { STOP_BORDER / 2, STOP_BORDER / 2 }, 4, rl.BLACK)
        rl.DrawRectangleV(npc.destination, { STOP_BORDER, STOP_BORDER }, rl.BLACK)
        rl.DrawTexturePro(global.entity_texture, npc.texture.source, npc.texture.dest, npc.texture.origin, 0, rl.WHITE)
        if npc.state == .Controlling do rl.DrawRectangleLinesEx(npc.texture.dest, 4, rl.GREEN)
    }
    else {
        rl.DrawTexturePro(global.entity_texture, npc.texture.source, npc.texture.dest, npc.texture.origin, 0, rl.WHITE)
    }
}

npc_update :: proc(dt: f32, npc: ^NPC) {
    #partial switch npc.state {
        case .Preparing: {
            dest: rl.Vector2
            dest.x = f32(rl.GetRandomValue(0, rl.GetScreenWidth()))
            dest.y = f32(rl.GetRandomValue(0, rl.GetScreenHeight()))

            npc_set_destination(npc, dest)
        }

        case .Moving: {
            npc.position += npc.direction_speed * (SPEED * dt)
            npc_rect: rl.Rectangle = { npc.position.x, npc.position.y, npc.size.x, npc.size.y }
            dest_rect: rl.Rectangle = { npc.destination.x - STOP_BORDER / 2, npc.destination.y - STOP_BORDER / 2, STOP_BORDER, STOP_BORDER }

            if rl.CheckCollisionRecs(npc_rect, dest_rect) {
                npc.state = .Standing
            }
        }

        case .Standing: {
            npc.delay_before_moving -= dt

            if npc.delay_before_moving < 0 {
                npc.destination = { 0, 0 }
                npc.direction_speed = { 0, 0 }

                npc.state = .Preparing
            }
        }
    }

    when ODIN_DEBUG {
        if rl.IsMouseButtonPressed(.LEFT) {
            if is_mouse_hovered_vec(npc.position, { SIZE, SIZE }) {
                npc.state = .Controlling
            } else {
                if npc.state == .Controlling do npc_set_destination(npc, global.world_mouse)
            }
        }
    }

    npc.texture.dest = { npc.position.x, npc.position.y, npc.texture.source.width * MULTIPLY_SIZE, npc.texture.source.height * MULTIPLY_SIZE }
}

npc_set_destination :: proc(npc: ^NPC, destination: rl.Vector2) {
    dest: rl.Vector2 = destination
    distance: rl.Vector2

    npc.destination = dest

    distance.x = npc.destination.x - npc.position.x
    distance.y = npc.destination.y - npc.position.y

    if abs(distance.x) > abs(distance.y) {
        npc.direction_speed.x = 1
        npc.direction_speed.y = abs(distance.y / distance.x)
    }
    else {
        npc.direction_speed.x = abs(distance.x / distance.y)
        npc.direction_speed.y = 1
    }

    if distance.x < 0 do npc.direction_speed.x *= -1
    if distance.y < 0 do npc.direction_speed.y *= -1

    when ODIN_DEBUG {
        fmt.println("npc.position:", npc.position)
        fmt.println("npc.destination:", npc.destination)
        fmt.println("npc.direction_speed:", npc.direction_speed)
        fmt.println()
    }

    npc.state = .Moving
    npc.delay_before_moving = DELAY_BEFORE_MOVING
}