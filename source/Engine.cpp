#include <Engine.hpp>

Engine::Engine()
{
    player = new Player(Global::window_width/2, Global::window_height/2);
}

Engine::~Engine()
{

}

void Engine::Draw()
{
    player->Draw();
}

void Engine::Update()
{
    player->Update();
}
