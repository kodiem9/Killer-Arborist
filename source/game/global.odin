package game
import rl "vendor:raylib"

camera: rl.Camera2D
world_mouse: rl.Vector2
screen_size: rl.Vector2

i8_vec2 :: struct {
    x, y: i8
}

global_init :: proc() {
    screen_size.x = f32(rl.GetScreenWidth())
    screen_size.y = f32(rl.GetScreenWidth())
}

is_mouse_hovered_vec :: proc(pos, size: rl.Vector2) -> bool {
    world_mouse.x = (f32(rl.GetMouseX()) - screen_size.x / 2) + camera.target.x
    world_mouse.y = (f32(rl.GetMouseY()) - screen_size.y / 2) + camera.target.y

    check_x: bool = (world_mouse.x > pos.x - size.x / 2 && world_mouse.x < pos.x + size.x / 2)
    check_y: bool = (world_mouse.y > pos.y - size.y / 2 && world_mouse.y < pos.y + size.y / 2)

    return check_x && check_y
}