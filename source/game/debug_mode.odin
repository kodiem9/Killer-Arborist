package game
import rl "vendor:raylib"

debug_window_enabled: bool = false

debug_mode_window_draw :: proc() {
    rl.DrawRectangle(0, 0, rl.GetScreenWidth(), rl.GetScreenHeight(), { 0, 0, 0, 100 })
}

debug_mode_draw :: proc() {
    when ODIN_DEBUG {
        if debug_window_enabled {
            debug_mode_window_draw()
        }
        else {
            rl.DrawText("Debug", 8, rl.GetScreenHeight() - 50, 28, rl.RED)
            rl.DrawText("(Press M for memory window)", 8, rl.GetScreenHeight() - 20, 14, rl.GRAY)
        }
    }
}

debug_mode_update :: proc() {
    if rl.IsKeyPressed(.M) {
        debug_window_enabled = !debug_window_enabled
    }
}