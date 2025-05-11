local Player = require("Player")
local Enemy = require("enemies.enemy")
local Level = require("level")

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

    level = Level:new(1, player)
end

function love.textinput(key)
    level:textinput(key)
end

function love.update(dt)
    level:update(dt)
end

function love.draw()
    level:draw()
end