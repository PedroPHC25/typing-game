require("../utils")
local utf8 = require("utf8")

local TypeEnemy = {}
TypeEnemy.__index = TypeEnemy

-- Construtor
function TypeEnemy:new(x, y, color, text, speed, damage)
    local obj = {
        x = x,
        y = y,
        r = 0,
        color = color,
        text = text,
        speed = speed,
        letters = {},
        current_letter_index = 1,
        dead = false,
        damage = damage
    }

    for pos, code in utf8.codes(obj.text) do
        local char = utf8.char(code)
        table.insert(obj.letters, { char = char, color = {1, 1, 1} })
    end

    setmetatable(obj, self)
    return obj
end

function TypeEnemy:check_letter(key)
    local current_letter = self.letters[self.current_letter_index]
    if current_letter.char == key then
        current_letter.color = {1, 0, 1}
        if self.current_letter_index == #self.letters then
            self.dead = true
        else
            self.current_letter_index = self.current_letter_index + 1
        end
    end
end

function TypeEnemy:textinput(text)
    if self.x > 0 and self.x < SCREEN_WIDTH and self.y > 0 and self.y < SCREEN_HEIGHT then
        self:check_letter(text)
    end
end

function TypeEnemy:kill()
    self.dead = true
end

function TypeEnemy:is_dead()
    return self.dead
end

function TypeEnemy:move(playerX, playerY, dt)
    local diffX = playerX - self.x
    local diffY = playerY - self.y
    
    local speedX = diffX/(math.abs(diffX) + math.abs(diffY)) * self.speed
    local speedY = diffY/(math.abs(diffX) + math.abs(diffY)) * self.speed

    self.x = self.x + speedX
    self.y = self.y + speedY
end

function TypeEnemy:update(player, dt)
    self:move(player.x, player.y, dt)
    if euclidian_distance(self.x, self.y, player.x, player.y) < player.r + self.r then
        player:damage(self.damage)
        self:kill()
    end
end

function TypeEnemy:draw()
    local font = love.graphics.getFont()
    local totalWidth = 0
    local widths = {}

    for i, letter in ipairs(self.letters) do
        local w = font:getWidth(letter.char)
        table.insert(widths, w)
        totalWidth = totalWidth + w
    end

    self.r = totalWidth / 1.8

    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.r)

    local startX = self.x - totalWidth/2
    local y = self.y - font:getHeight()/2

    local x = startX

    for i, letter in ipairs(self.letters) do
        love.graphics.setColor(letter.color)
        love.graphics.print(letter.char, x, y)
        x = x + widths[i]
    end
end

return TypeEnemy