package main

import "game"

main :: proc() {
    game.game_init()
    
    for game.game_is_running() {
        game.game_loop()
    }

    game.game_destroy()
}