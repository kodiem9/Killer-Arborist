package debug
import rl "vendor:raylib"

debug_window_enabled: bool = false

debug_window_draw :: proc() {
    rl.DrawRectangle(0, 0, rl.GetScreenWidth(), rl.GetScreenHeight(), { 0, 0, 0, 100 })
}

draw :: proc() {
    when ODIN_DEBUG {
        if debug_window_enabled {
            debug_window_draw()
        }
        else {
            rl.DrawText("Debug", 8, rl.GetScreenHeight() - 50, 28, rl.RED)
            rl.DrawText("(Press M for memory window)", 8, rl.GetScreenHeight() - 20, 14, rl.GRAY)
        }
    }
}

update :: proc() {
    if rl.IsKeyPressed(.M) {
        debug_window_enabled = !debug_window_enabled
    }
}