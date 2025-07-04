local utf8 = require("utf8")
require("words_handler")

math.randomseed(os.time())

local TypeEnemy = require("enemies.enemy")

local Level = {}
Level.__index = Level

local words = {}

words = loadWords("assets/texts/wordsList.txt")

-- Construtor
function Level:new(level, player)
    local obj = {
        player = player,
        enemies = {}
    }

    local current_words = words[math.min(math.floor((level - 1)/3) + 1, #words)]
    local num_enemies = 10 + ((level - 1) % 3) * 5

    local centerX = SCREEN_WIDTH / 2
    local centerY = SCREEN_HEIGHT / 2

    for i = 1, num_enemies, 1 do
        local angle = math.random() * 2 * math.pi
        local radius = math.random(600, 2000)
        local x = centerX + radius * math.cos(angle)
        local y = centerY + radius * math.sin(angle)
        local text_index = math.random(1, #current_words)
        local new_enemy = TypeEnemy:new(x, y, {0, 0, 1}, current_words[text_index], 1.5, 10)
        table.insert(obj.enemies, new_enemy)
    end

    setmetatable(obj, self)
    return obj
end

function Level:textinput(key)
    for i = #self.enemies, 1, -1 do
        local enemy = self.enemies[i]
        enemy:textinput(key)
    end
end

function Level:is_complete()
    return #self.enemies == 0
end

function Level:gameover()
    return self.player.health <= 0
end

function Level:update(dt)
    for i = #self.enemies, 1, -1 do
        local enemy = self.enemies[i]
        enemy:update(self.player, dt)
        if enemy:is_dead() then
            table.remove(self.enemies, i)
        end
    end
end

function Level:draw()
    self.player:draw()
    for i, enemy in ipairs(self.enemies) do
        enemy:draw()
    end
end

return Level