local Player = require("Player")
local Enemy = require("enemies.enemy")

local player
local enemies = {}
local font

SCREEN_WIDTH = 1100
SCREEN_HEIGHT = 650

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)

    font = love.graphics.newFont("assets/fonts/Roboto-Bold.ttf", 20)
    love.graphics.setFont(font)

    player = Player:new(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    enemy1 = Enemy:new(SCREEN_WIDTH/2 - 150, SCREEN_HEIGHT/2, 50, {0, 0, 1}, "amor")
    enemy2 = Enemy:new(SCREEN_WIDTH/2 - 250, SCREEN_HEIGHT/2, 50, {0, 0, 1}, "baixinho")
    enemy3 = Enemy:new(SCREEN_WIDTH/2 + 150, SCREEN_HEIGHT/2, 50, {0, 0, 1}, "coração")

    table.insert(enemies, enemy1)
    table.insert(enemies, enemy2)
    table.insert(enemies, enemy3)
end

function love.textinput(key)
    for i = #enemies, 1, -1 do
        local enemy = enemies[i]
        enemy:textinput(key)
        if enemy:is_dead() then
            table.remove(enemies, i)
        end
    end
end

function love.update(dt)
    
end

function love.draw()
    player:draw()
    for i, enemy in ipairs(enemies) do
        enemy:draw()
    end
end