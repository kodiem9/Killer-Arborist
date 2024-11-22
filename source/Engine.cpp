#include <Engine.hpp>

Engine::Engine()
{
    player = new Player(Global::window_width/2.0f, Global::window_height/2.0f);

    camera.target = player->GetPlayerPosition();
    camera.offset = (Vector2){ Global::window_width/2.0f, Global::window_height/2.0f };
    camera.rotation = 0.0f;
    camera.zoom = 1.0f;

    for(int i = 0; i < 20; i++)
    {
        tiles.emplace_back(GetRandomValue(0, Global::window_width), GetRandomValue(0, Global::window_height));
    }
}

Engine::~Engine()
{
    player = nullptr;
    delete player;
}

void Engine::Draw()
{
    BeginMode2D(camera);

        for(Tile tile: tiles) {
            tile.Draw();
        }
        player->Draw();
    
    EndMode2D();

    DrawText(TextFormat("Camera: (%.0f, %.0f)", player->GetPlayerPosition().x, player->GetPlayerPosition().y), 10, 10, 20, GRAY);
}

void Engine::Update()
{
    player->Update();
    for(Tile &tile: tiles) {
        player->Collide(tile.TileAttributes());
    }
    camera.target.x += (player->GetPlayerPosition().x - camera.target.x) / 5;
    camera.target.y += (player->GetPlayerPosition().y - camera.target.y) / 5;
}
