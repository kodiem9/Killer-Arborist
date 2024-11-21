#include <Player.hpp>

Player::Player(float x, float y) : x(x), y(y) {}

Player::~Player()
{

}

/* PUBLIC */
void Player::Draw()
{
    DrawRectangle(x, y, PLAYER_SIZE, PLAYER_SIZE, RED);
}

void Player::Update()
{
    dir_x = IsKeyDown(KEY_D) - IsKeyDown(KEY_A);
    dir_y = IsKeyDown(KEY_S) - IsKeyDown(KEY_W);
    x += dir_x * 5;
    y += dir_y * 5;
}

void Player::Collide(Rectangle data)
{
    if (CheckCollisionRecs((Rectangle){ x, y, PLAYER_SIZE, PLAYER_SIZE }, data)) {
        printf("Collision!\n");
    }
}

/* PRIVATE */
Vector2 Player::GetPlayerPosition()
{
    return (Vector2){ x, y };
}