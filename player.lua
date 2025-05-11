local Player = {}
Player.__index = Player

-- Construtor
function Player:new(x, y)
    R = 30
    local obj = {
        r = R,
        x = x - R,
        y = y - R,
        color = {1, 0, 0},
        max_health = 100,
        health = 100
    }
    setmetatable(obj, self)
    return obj
end

function Player:damage(damage)
    self.health = self.health - damage
end

function Player:update(dt)
    
end

function Player:draw()
    love.graphics.setColor(self.color)
    love.graphics.setLineWidth(1)
    love.graphics.circle("line", self.x, self.y, self.r)
    love.graphics.circle("fill", self.x, self.y, (self.health / self.max_health) * self.r)
end

return Player