#pragma once
#include <Global.hpp>

class Player
{
    public:
        Player(float x, float y);
        ~Player();
        void Draw();
        void Update();

        Vector2 GetPlayerPosition();

    private:
        float x, y;
};