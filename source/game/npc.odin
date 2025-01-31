package game
import rl "vendor:raylib"

@(private="file")
SIZE : f32 : 64

NPC :: struct {
    position: rl.Vector2,
    size: rl.Vector2
}

npc_init :: proc(position: rl.Vector2) -> NPC {
    npc: NPC
    
    npc.position = position
    npc.size = { SIZE, SIZE }

    return npc
}

npc_draw :: proc(npc: ^NPC) {
    rl.DrawRectangleV(npc.position, npc.size, rl.BLUE)
}

npc_update :: proc() {

}