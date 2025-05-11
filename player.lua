local Player = {}
Player.__index = Player

-- Construtor
function Player:new(x, y)
    R = 30
    local obj = {
        r = R,
        x = x - R,
        y = y - R,
        color = {0, 0, 1}
    }
    setmetatable(obj, self)
    return obj
end

function Player:update(dt)
    
end

function Player:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.r)
end

return Player