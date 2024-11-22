#pragma once
#include <Global.hpp>

constexpr uint16_t TILE_SIZE = 64;

class Tile
{
    public:
        Tile(float x, float y);
        ~Tile();
        void Draw();
        void Update();

        Rectangle TileAttributes();

    private:
        float x, y;
};