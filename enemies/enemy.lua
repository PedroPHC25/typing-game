local utf8 = require("utf8")

local Enemy = {}
Enemy.__index = Enemy

-- Construtor
function Enemy:new(x, y, r, color, text)
    local obj = {
        r = r,
        x = x - r,
        y = y - r,
        color = color,
        text = text,
        letters = {},
        current_letter_index = 1,
        dead = false
    }

    for pos, code in utf8.codes(obj.text) do
        local char = utf8.char(code)
        table.insert(obj.letters, { char = char, color = {1, 1, 1} })
    end

    setmetatable(obj, self)
    return obj
end

function Enemy:check_letter(key)
    local current_letter = self.letters[self.current_letter_index]
    if current_letter.char == key then
        current_letter.color = {1, 0, 0}
        if self.current_letter_index == #self.letters then
            self.dead = true
        else
            self.current_letter_index = self.current_letter_index + 1
        end
    end
end

function Enemy:textinput(text)
    self:check_letter(text)
end

function Enemy:is_dead()
    return self.dead
end

function Enemy:update(dt)
    
end

function Enemy:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.r)

    local font = love.graphics.getFont()
    local totalWidth = 0
    local widths = {}

    for i, letter in ipairs(self.letters) do
        local w = font:getWidth(letter.char)
        table.insert(widths, w)
        totalWidth = totalWidth + w
    end

    self.r = totalWidth / 1.9

    local startX = self.x - totalWidth/2
    local y = self.y - font:getHeight()/2

    local x = startX

    for i, letter in ipairs(self.letters) do
        love.graphics.setColor(letter.color)
        love.graphics.print(letter.char, x, y)
        x = x + widths[i]
    end
end

return Enemy