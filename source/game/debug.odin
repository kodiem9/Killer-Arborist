package game
import rl "vendor:raylib"

@(private="file")
ALPHA : rl.Color : { 0, 0, 0, 100 }

debug_window_enabled: bool = false

debug_info_draw :: proc() {
    rl.DrawRectangle(0, 0, rl.GetScreenWidth(), rl.GetScreenHeight(), ALPHA)
}

debug_draw :: proc() {
    if debug_window_enabled {
        debug_info_draw()
    }
    else {
        if global.scene == .GAME {
            rl.DrawText("Game", 8, rl.GetScreenHeight() - 74, 28, rl.BLUE)
        } else {
            rl.DrawText("Map editor", 8, rl.GetScreenHeight() - 74, 28, rl.BLUE)
        }
        rl.DrawText("Debug", 8, rl.GetScreenHeight() - 108, 28, rl.RED)
        rl.DrawText("(Press M for memory window)", 8, rl.GetScreenHeight() - 40, 14, rl.GRAY)
        rl.DrawText("(Press N to change scenes)", 8, rl.GetScreenHeight() - 20, 14, rl.GRAY)
    }
}

debug_update :: proc() {
    if rl.IsKeyPressed(.M) {
        debug_window_enabled = !debug_window_enabled
    }

    if rl.IsKeyPressed(.N) {
        if global.scene == .GAME {
            global.scene = .MAP_EDITOR
        } else {
            global.scene = .GAME
        }
    }

    if rl.IsKeyPressed(.ONE) do global.selected_tile = 0
    if rl.IsKeyPressed(.TWO) do global.selected_tile = 1
    if rl.IsKeyPressed(.THREE) do global.selected_tile = 2
}