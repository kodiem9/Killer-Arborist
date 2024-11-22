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
    new_x += dir_x * 5;
    new_y += dir_y * 5;
}

void Player::Collide(Rectangle const &data)
{
    if (CheckCollisionRecs((Rectangle){ new_x, new_y, PLAYER_SIZE, PLAYER_SIZE }, data)) {
        // Calculate the penetration (how much the player is overlapping the object)
        float penetration_x = (dir_x == 1) ? (data.x - (new_x + PLAYER_SIZE)) : ((new_x - data.width) - data.x);
        float penetration_y = (dir_y == 1) ? (data.y - (new_y + PLAYER_SIZE)) : ((new_y - data.height) - data.y);

        // Which penetration axis the player is "overlapping" more
        if (fabs(penetration_x) < fabs(penetration_y)) {
            if (dir_x == 1) new_x = data.x - PLAYER_SIZE;
            else if (dir_x == -1) new_x = data.x + data.width;
        } else {
            if (dir_y == 1) new_y = data.y - PLAYER_SIZE;
            else if (dir_y == -1) new_y = data.y + data.height;
        }
    }

    x = new_x;
    y = new_y;
}

/* PRIVATE */
Vector2 Player::GetPlayerPosition()
{
    return (Vector2){ x, y };
}