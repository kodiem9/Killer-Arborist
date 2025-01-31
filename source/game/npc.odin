package game
import rl "vendor:raylib"
import "core:fmt"
import "core:math"

@(private="file")
SIZE : f32 : 64

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
}

NPC :: struct {
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

    return npc
}

npc_draw :: proc(npc: ^NPC) {
    rl.DrawRectangleV(npc.position, npc.size, rl.BLUE)
    // MAYBE: in debug mode add entity ids and see where the destination leads?
}

npc_update :: proc(dt: f32, npc: ^NPC) {
    switch npc.state {
        case .Preparing: {
            dest: rl.Vector2
            distance: rl.Vector2

            dest.x = f32(rl.GetRandomValue(0, rl.GetScreenWidth()))
            dest.y = f32(rl.GetRandomValue(0, rl.GetScreenHeight()))
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
}