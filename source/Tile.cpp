#include <Tile.hpp>

Tile::Tile(float x, float y) : x(x), y(y) {}

Tile::~Tile()
{

}

/* PUBLIC */
void Tile::Draw()
{
    DrawRectangle(x, y, TILE_SIZE, TILE_SIZE, BLACK);
}

void Tile::Update()
{

}

/* PRIVATE */
Rectangle Tile::TileAttributes()
{
    return (Rectangle){ x, y, TILE_SIZE, TILE_SIZE };
}