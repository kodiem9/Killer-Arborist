#pragma once
#include <Player.hpp>

class Engine
{
    public:
        Engine();
        ~Engine();
        void Draw();
        void Update();
    
    private:
        Player *player;
};