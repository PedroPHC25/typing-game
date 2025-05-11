math.randomseed(os.time())

local Enemy = require("enemies.enemy")

local Level = {}
Level.__index = Level

local words = {
    "lua", "estrela", "vento", "sombra", "folha",
    "rio", "caminho", "nuvem", "relâmpago", "noite",
    "fogo", "cristal", "eco", "montanha", "chave",
    "vidro", "fenda", "areia", "vento", "luz",
    "espelho", "portão", "chama", "rocha", "céu",
    "mar", "ilha", "bússola", "alvorecer", "pântano",
    "gelo", "tempo", "abismo", "vento", "som",
    "barco", "caverna", "tronco", "raiz", "flecha",
    "neblina", "galho", "brisa", "onda", "poço",
    "orvalho", "lenha", "pedra", "sopro", "estrela"
}

-- Construtor
function Level:new(level, player)
    local obj = {
        player = player,
        enemies = {}
    }

    for i = 1, 10 + (level - 1) * 5, 1 do
        local x = random_disjoint((-1) * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH * 2)
        local y = random_disjoint((-1) * SCREEN_HEIGHT, 0, SCREEN_HEIGHT, SCREEN_HEIGHT * 2)
        local text_index = math.random(1, #words)
        local new_enemy = Enemy:new(x, y, {0, 0, 1}, words[text_index], 1.5, 10)
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