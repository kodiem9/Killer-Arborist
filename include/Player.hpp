#pragma once
#include <Global.hpp>

constexpr uint16_t PLAYER_SIZE = 64;

class Player
{
    public:
        Player(float x, float y);
        ~Player();
        void Draw();
        void Update();
        void Collide(Rectangle data);

        Vector2 GetPlayerPosition();

    private:
        float x, y;
        int8_t dir_x, dir_y;
};