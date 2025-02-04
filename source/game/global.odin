package game
import rl "vendor:raylib"

// I am not sure if I should keep the scenes in global.odin or game.odin. I'll have to think about it
Game_Scene :: enum {
    GAME = 0,
    MAP_EDITOR,
}

Global :: struct {
    entity_texture: rl.Texture2D,
    tile_texture: rl.Texture2D,

    camera: rl.Camera2D,
    world_mouse: rl.Vector2,
    screen_size: rl.Vector2,
    scene: Game_Scene,
}
global: Global

i8_vec2 :: struct {
    x, y: i8
}

Full_Texture :: struct {
    source: rl.Rectangle,
    dest: rl.Rectangle,
    origin: rl.Vector2,
}

global_init :: proc() {
    global.screen_size.x = f32(rl.GetScreenWidth())
    global.screen_size.y = f32(rl.GetScreenHeight())

    global.entity_texture = rl.LoadTexture("../assets/entities.png")
    global.tile_texture = rl.LoadTexture("../assets/tiles.png")
}

global_update :: proc() {
    global.world_mouse.x = (f32(rl.GetMouseX()) - global.screen_size.x / 2) + global.camera.target.x
    global.world_mouse.y = (f32(rl.GetMouseY()) - global.screen_size.y / 2) + global.camera.target.y
}

is_mouse_hovered_vec :: proc(pos, size: rl.Vector2) -> bool {
    check_x: bool = (global.world_mouse.x > pos.x - size.x / 2 && global.world_mouse.x < pos.x + size.x / 2)
    check_y: bool = (global.world_mouse.y > pos.y - size.y / 2 && global.world_mouse.y < pos.y + size.y / 2)

    return check_x && check_y
}