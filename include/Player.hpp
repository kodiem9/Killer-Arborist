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
        void Collide(Rectangle const &data);

        Vector2 GetPlayerPosition();
        bool IsSprinting();

    private:
        enum Speed
        {
            NORMAL = 5,
            SPRINT = 8
        };

        float new_x, new_y, x, y;
        int8_t dir_x, dir_y, speed;
        bool b_sprint;
};