package game
import rl "vendor:raylib"

Global :: struct {
    camera: rl.Camera2D,
    world_mouse: rl.Vector2,
    screen_size: rl.Vector2
}
global: Global

i8_vec2 :: struct {
    x, y: i8
}

global_init :: proc() {
    global.screen_size.x = f32(rl.GetScreenWidth())
    global.screen_size.y = f32(rl.GetScreenHeight())
}

is_mouse_hovered_vec :: proc(pos, size: rl.Vector2) -> bool {
    global.world_mouse.x = (f32(rl.GetMouseX()) - global.screen_size.x / 2) + global.camera.target.x
    global.world_mouse.y = (f32(rl.GetMouseY()) - global.screen_size.y / 2) + global.camera.target.y

    check_x: bool = (global.world_mouse.x > pos.x - size.x / 2 && global.world_mouse.x < pos.x + size.x / 2)
    check_y: bool = (global.world_mouse.y > pos.y - size.y / 2 && global.world_mouse.y < pos.y + size.y / 2)

    return check_x && check_y
}