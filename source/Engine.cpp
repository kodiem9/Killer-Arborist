#include <Engine.hpp>

Engine::Engine()
{
    player = new Player(Global::window_width/2.0f, Global::window_height/2.0f);

    camera.target = player->GetPlayerPosition();
    camera.offset = (Vector2){ Global::window_width/2.0f, Global::window_height/2.0f };
    camera.rotation = 0.0f;
    camera.zoom = 1.0f;
}

Engine::~Engine()
{
    player = nullptr;
    delete player;
}

void Engine::Draw()
{
    BeginMode2D(camera);

        player->Draw();
    
    EndMode2D();

    DrawText(TextFormat("Camera: (%.0f, %.0f)", player->GetPlayerPosition().x, player->GetPlayerPosition().y), 10, 10, 20, GRAY);
}

void Engine::Update()
{
    player->Update();
    camera.target = player->GetPlayerPosition();
}
