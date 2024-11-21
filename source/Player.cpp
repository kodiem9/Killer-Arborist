#include <Player.hpp>

Player::Player(float x, float y) : x(x), y(y) {}

Player::~Player()
{

}

/* PUBLIC */
void Player::Draw()
{
    DrawRectangle(x, y, 64, 64, RED);
}

void Player::Update()
{
    x += (IsKeyDown(KEY_D)-IsKeyDown(KEY_A)) * 5;
    y += (IsKeyDown(KEY_S)-IsKeyDown(KEY_W)) * 5;
}

/* PRIVATE */
Vector2 Player::GetPlayerPosition()
{
    return (Vector2){ x, y };
}