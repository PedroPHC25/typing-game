local Player = require("Player")
local Enemy = require("enemies.enemy")
local Level = require("level")

local player
local enemies = {}
local font
local level_number = 1
local level
local screen

SCREEN_WIDTH = 1100
SCREEN_HEIGHT = 650

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)

    font = love.graphics.newFont("assets/fonts/Roboto-Bold.ttf", 20)
    love.graphics.setFont(font)

    player = Player:new(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)

    screen = "start"
end

function love.textinput(key)
    if level and screen == "game" then
        level:textinput(key)
    end
end

function love.keypressed(key)
    if screen == "start" and key == "return" then
        screen = "game"
        level = Level:new(level_number, player)
    end
end

function love.update(dt)
    if level and screen == "game" then
        level:update(dt)
        if level:is_complete() then
            level_number = level_number + 1
            screen = "start"
        end
        if level:gameover() then
            level_number = 1
            player.health = player.max_health
            screen = "start"
        end
    end
end

function love.draw()
    if screen == "start" then
        local text = "Aperte Enter para começar o nível " .. tostring(level_number)
        local textWidth = font:getWidth(text)
        local textHeight = font:getHeight()
        local x = (SCREEN_WIDTH - textWidth) / 2
        local y = (SCREEN_HEIGHT - textHeight) / 2
        love.graphics.setColor({1, 1, 1})
        love.graphics.rectangle("fill", 0.95*x, 0.95*y, textWidth + 0.1*x, textHeight + 0.1*y)
        love.graphics.setColor({0, 0, 0})
        love.graphics.print(text, x, y)
    end
    if level and screen == "game" then
        level:draw()
    end
end